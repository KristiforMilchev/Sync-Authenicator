# Sync Authenticator

A web3 blockchain based Authenticator application built with Flutter for IOS and Android

# Integration Instructions
TBD 

 ## What is the sync authentication protocol?

![image](https://user-images.githubusercontent.com/49519924/208472736-22bf0485-49d1-4444-86ed-c396245a4732.png)


The sync authentication protocol is based on EVM compatible wallet signatures, unlike the traditional 2FA where we have a code that has to be confirmed, we base our authentication protocol on the foundations of the Ethereum protocol. The application contains a stripped down EVM compatible address that doesn't operate on the blockchain, but we use the existing cryptography to generate sign and confrim messages. Since in Ethreum every message that is signed by a generated private key always derives the public key of the original signer we can improve the existing 2FA security by elimitinating the guessing factor. With the current infrastructure when a 2FA based application generates a reqest with a code it cannot physically determine if the sender is the owner of that code, but only that the code matches the expected code. With the sync authenication protocol that issue is now solved, since each private key used to sign a message derives the public key of the wallet that signed it we can now safely accept and validate messages.

## Integrating

the Sync Authenticator with an existing asp.net core/.net application.

In order to integrate an existing application with the sync authenication protocol first we need to get some prerequisites or implement the ECDSASignature, following the integration scheme we will use a third party library under .net that already implements the signatures. [Nethereum](https://www.nuget.org/packages/Nethereum.Web3)

Once we have installed the nuget package to our existing solution we need to create a new endpoint or a controller to handle the integraton of the Sync 2FA protocol.

<pre>                    `
                        public class TwoFactorAuthenticationController : Controller
                        {
                            private readonly ILogger <homecontroller>_logger;
                            private  IAuthentication Authentication { get; set; }

                            public TwoFactorAuthenticationController(ILogger <homecontroller>logger, IAuthentication authentication)
                            {
                                _logger = logger;
                                Authentication = authentication;
                            }
                        }</homecontroller></homecontroller>`
                </pre>

After we have created our controller we need to setup a few endpoints that handle the communication between the sync authenicator app and the website.  
The first method that we will create is the message generator, even though one message signed by two people it's still good practice to generate unique messages each time there is a request.

<pre>                    `[HttpGet]
                        public string GetSignatureMessage()
                        {
                            // Generates a message to be signed by web3 account.
                            return Guid.NewGuid().ToString().Replace("-","");
                        }` 
                </pre>

Next we will create another public method that will generate the pair payload which can be consumed by QR code generator. It should return the domain ane, a message and the unique identifier of the user.(Can be email, ID, or hash, whatever is used to identify the user in your database.)

<pre>                    `[HttpGet]
                        public string EnableTwoFa()
                        {
                            var exist = Authentication.IsAuthenticated(User);
                            if (string.IsNullOrEmpty(exist))
                                return string.Empty;
                            var dbContext = new DatabaseContext();
                            var user = dbContext.Single(exist);

                            Utilities.RequestedTwoFactorPairs.Add(user);
                            var location = new Uri($"{Request.Scheme}://{Request.Host}{Request.Path}{Request.QueryString}");

                            var url =  location.Authority;
                            return JsonConvert.SerializeObject(new TwoFaRegisterCode
                            {
                                url =$"https://{url}",
                                email = exist,
                                message = Authentication.GenerateSignatureRequest()
                            });
                        }` 
                </pre>

Next we need to create the pair method, this method can be consumed at any time, thus it's important that we keep track of users that requested a pair in an external collection and deny requests for users that haven't requested a pair with 2FA app. Here is the first important bit of the protocol, when we pair a user with the we take the message that was sent, we use instantiate a new instance of the EthereumMessageSigner from the Nethereum library and we recover the public key of the signed message. Then using the public key generated by the recovery process we update the existing user database entry and from now on we use that as our reference point weather a request should be approved or denied. Do note that dbContext.single is an abstraction of IRepository that is specefic to the website used for the example and not nessecery. You should query your own use and update it.

<pre>                    `
                        [HttpPost]
                        public async Task <bool>Pair([FromBody] TwoFactorRequest dto)
                        {
                            var account = Utilities.RequestedTwoFactorPairs.FirstOrDefault(x => x.Email == dto.Email);
                            if (account == null)
                                return false;

                            var signer = new EthereumMessageSigner();

                            var verify = signer.EncodeUTF8AndEcRecover(message, signature);
                            var dbContext = new DatabaseContext();
                            var getUser = dbContext.Single(email);
                            if (getUser == null)
                                return false;

                            getUser.IsTwoFactorEnabled = true;
                            getUser.TwoFactorKey = verify;
                            dbContext.Update(getUser);

                            return result;
                        }</bool> `
                </pre>

The last method that we need to integrate is the SignTwoFactor, it's the method used to approve a expected signature. If an account is paired with existing app your web service should wait for this method to be called before allowing the user to proceed with the sign in process. Here we follow the same process as in the pair method however we have few changes in the business logic, first we check for accounts that expect a signature, e.g account that has already filled in their username and password and now awaits a 2FA confirmation. Once the user clicks confirm on the IOS or Android application SignTwoFactor will be called, we follow the same model, derive a public key from the received message and signature and then check if those two match with our users public key in case they match the user is authenticated.

<pre>                    `
                         [HttpPost]
                            public async Task <bool>SignTwoFactor([FromBody] TwoFactorRequest dto)
                            {
                                var account = Utilities.ExpectingTwoFactorSignature.FirstOrDefault(x => x.Account.Email == dto.Email);
                                if (account == null)
                                    return false;

                                var existingUser = Utilities.ExpectingTwoFactorSignature.FirstOrDefault(x => x.Account.Email == request.Email);
                                if (existingUser == null)
                                    return false;

                                 var signer = new EthereumMessageSigner();

                                 var verify = signer.EncodeUTF8AndEcRecover(request.Message, request.Signed);
                                 //var verify = signer.EncodeUTF8AndEcRecover(request.Message, request.Signed);

                                // //Verify that the requester owns the account.
                                 if (verify != existingUser.Account.TwoFactorKey)
                                     return false;

                                Utilities.ExpectingTwoFactorSignature.FirstOrDefault(x => x.Account.Email == request.Email).Confirmed = true;
                                return true;
                            }</bool> `
                </pre>

## Example source code

The following example repository doesn't represent a production ready login/register system, it's meant to show how you can add the authenicator to an already existing login/register system, always use salt when storing creating and consuming passwords. Some of the bits of the documentation have been encapsulated in abstractions inside the IAuthentication service, for readability purposes.  
[Example consumer app using claims identity and simple login](https://github.com/KristiforMilchev/sync-authenticator-dotnet-7-consumer)
