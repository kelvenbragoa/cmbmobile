class OutputResponse {

  final String code;

  const OutputResponse({

    required this.code,
  });

  factory OutputResponse.fromJson(Map<String, dynamic> json) {
    return OutputResponse(
      code: json['output_ResponseCode'],
    );
  }
}