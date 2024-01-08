import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/sizes.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';
import '../../Constants/theme_data.dart';
import '../../generated/l10n.dart';

class NoConnectionScreen extends StatelessWidget {
  const NoConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Center(
              child: Text(
                'No Internet',
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 5),
             Center(
              child: Text(
                S.of(context).checkYourInternetConnection,
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: (){
              credentialController.getData();
              userInfoController.getUserInfo();
              connectivityController.refreshConnection(context);
            }, child: Text(S.of(context).refresh)),

          ],
        ),
      ),
    );
  }
}
