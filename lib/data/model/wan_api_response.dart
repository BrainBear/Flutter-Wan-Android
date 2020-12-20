class WanApiResponse {
  final int errorCode;
  final String errorMsg;
  final dynamic data;

  bool get success => errorCode == 0;

  WanApiResponse.fromJson(Map<String, dynamic> json)
      : errorCode = json['errorCode'],
        errorMsg = json['errorMsg'],
        data = json['data'];
}


class WanApiException implements Exception {
  final int errorCode;
  final String errorMsg;

  WanApiException(this.errorCode, this.errorMsg);

  WanApiException.fromResponse(WanApiResponse wanApiResponse)
      : this.errorCode = wanApiResponse.errorCode,
        this.errorMsg = wanApiResponse.errorMsg;
}