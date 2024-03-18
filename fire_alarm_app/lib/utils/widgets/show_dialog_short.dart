import 'package:fire_alarm_app/utils/image_data.dart';
import 'package:flutter/material.dart';

showLoaderDialogShort(BuildContext context) {
  showGeneralDialog(
    context: context,
    // routeSettings: const RouteSettings(name: RouteData.dialogLoading),
    pageBuilder: (context, animation, secondaryAnimation) => const Scaffold(
      backgroundColor: Colors.black54,
      body: Center(child: LoadingDialogWidget()),
    ),
  );
}

class LoadingDialogWidget extends StatefulWidget {
  const LoadingDialogWidget({super.key});

  @override
  State<LoadingDialogWidget> createState() => _LoadingDialogWidgetState();
}

class _LoadingDialogWidgetState extends State<LoadingDialogWidget> {
  // DialogService dialogService = DialogService();
  // late Timer _timer;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 25.0,
        width: 25.0,
        child: Image.asset(
          ImageData.loading,
        ),
      ),
    );
  }
}
