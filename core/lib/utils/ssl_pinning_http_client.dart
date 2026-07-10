import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

class SSLPinningHttpClient {
  static IOClient? _client;

  static Future<IOClient> getClient() async {
    if (_client != null) return _client!;

    final sslCert = await rootBundle.load(
      "assets/certificates/themoviedb-org.pem",
    );

    final context = SecurityContext(withTrustedRoots: false);

    context.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());

    final httpClient = HttpClient(context: context);

    httpClient.badCertificateCallback = (cert, host, port) => false;

    _client = IOClient(httpClient);

    return _client!;
  }
}
