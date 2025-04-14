class HttpResponse {
  final int status;
  final String message;
  final dynamic data; // Thêm thuộc tính data

  HttpResponse({
    required this.status,
    required this.message,
    this.data, // Có thể null nếu API không trả về data
  });
}