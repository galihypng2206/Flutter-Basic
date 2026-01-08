import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "https://event-middleware-alpha.kai.id"; // ganti untuk emulator
  final String token = "Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxNzYwMDY3MzQ5fC18ZmVZb1Zuel9ReTI0UDBHR0xIR3d2UDpBUEE5MWJHT21ScmUzRUpyaExWX2FyRGlOeFlFdFN2M3ZvbUtBaG5wZVdVRVVBazFUMmFHMVJIemRpdnZuRHdxUVc2c3g5RjVuUlFjbFd1Tlk1ZjYxTWFQajZnZmdtUC00NEpZOWxtUjVhNERqejN0RkNTVWlENHwyMTIwNzg1IiwiZXhwIjoxNzY4NzA3MzQ5LCJpc3MiOiJodHRwczovL2thaS5pZC8ifQ.EEd2hweTPddVjmOm6qOApX_p8z3FPB_zvsnaA1cqx_DWo8IvsgRiQ1u1Hk3UClp8nU6UpsdtRbV9F0bTbIu6jQ"; // nanti bisa diganti dinamis

   Future<List<dynamic>> fetchEvents(int page, int size) async {
    final response = await http.get(
      Uri.parse("$baseUrl/event?page=0&size=10"),
      headers: {
        "Authorization": token,
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      // cek struktur JSON
      if (data["payload"] != null && data["payload"]["eventList"] != null) {
        return data["payload"]["eventList"];
      } else {
        return []; // kalau kosong
      }
    } else {
      throw Exception("Failed to load events: ${response.statusCode}");
    }
  }
}
