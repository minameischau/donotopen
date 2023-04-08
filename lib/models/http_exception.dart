class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  HttpException.firebase(String code)
      : message = _translateFirebaseErrorCode(code);

  static String _translateFirebaseErrorCode(code) {
    switch (code) {
      case 'Email đã tồn tại':
        return 'Địa chỉ email này đã được sử dụng.';
      case 'Email không hợp lệ':
        return 'Địa chỉ email này không hợp lệ.';
      case 'Mật khẩu yếu':
        return 'Mật khẩu này quá yếu';
      case 'Email không tồn tại':
        return 'Không thể tìm người dùng có email này';
      case 'Mật khẩu không hợp lệ':
        return 'Mật khẩu không hợp lệ.';
      default:
        return code;
    }
  }

  @override
  String toString() {
    return message;
  }
}
