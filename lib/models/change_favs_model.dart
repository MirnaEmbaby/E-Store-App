class ChangeFavsModel {
  bool? status;
  String? message;

  ChangeFavsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}
