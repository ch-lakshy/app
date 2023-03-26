import 'package:arp_scanner/device.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset("assets/images/logo.svg"),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.devices}) : super(key: key);

  final List<Device> devices;

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
