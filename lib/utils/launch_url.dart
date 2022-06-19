import 'package:flutter/material.dart';

import 'package:new_verde/models/scan.dart';
import 'package:url_launcher/url_launcher.dart';

void launchWebView(BuildContext context, ScanModel scan) async {
  final url = scan.value;

  if (!await launchUrl(url as Uri)) throw 'Could not launch $url';
}