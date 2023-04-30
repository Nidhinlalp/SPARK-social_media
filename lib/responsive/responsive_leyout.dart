import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spark/providers/user_provider.dart';
import 'package:spark/utils/dimensions.dart';

class ResponsiveLeyout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;
  const ResponsiveLeyout(
      {super.key,
      required this.webScreenLayout,
      required this.mobileScreenLayout});

  @override
  State<ResponsiveLeyout> createState() => _ResponsiveLeyoutState();
}

class _ResponsiveLeyoutState extends State<ResponsiveLeyout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraits) {
        if (constraits.maxWidth > webScreenSize) {
          return widget.webScreenLayout;
        }
        return widget.mobileScreenLayout;
      },
    );
  }
}
