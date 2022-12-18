import '../ui/views/history/history_viewcomponent.dart';
import '../ui/views/home/home_viewmodel.dart';

abstract class IAuthentication {
  Future<bool> pairEndpoint(String scanData);
  Future<Map<String, String>> generateReqestSignature(String url);
  Future<bool> approveRequest(
      String email, String plain, String signed, String url);
  void bindHistoryModel(HistoryViewModel model);
  void bindHomeModels(HomeViewModel model);
}
