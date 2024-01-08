import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Screens/UserMemberScreens/USettingScreens/uSetting_screen.dart';
import 'package:pryo_app/Screens/worker_profile_screen.dart';
import 'package:pryo_app/Widgets/dashboard_widgets.dart';
import '../../../Constants/all_urls.dart';
import '../../../Constants/theme_data.dart';
import '../../../Controllers/global_controllers.dart';
import '../../../Controllers/user_dashboard_controller.dart';
import '../../../generated/l10n.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  final UserDashboardController _userDashboardController =
      Get.put(UserDashboardController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Get.to(() => const USettingScreen());
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Provider.of<ThemeProvider>(context)
                .currentTheme
                .iconTheme
                .color,
          ),
        ),
        title: Center(
          child: Text(
            S.of(context).yourFavorites,
            style: Provider.of<ThemeProvider>(context)
                .currentTheme
                .textTheme
                .bodyMedium,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(bottom: 40),
        padding: const EdgeInsets.all(20),
        child: Obx(
          () => _userDashboardController.serviceByFavList.isEmpty
              ? Center(
                  child: TextButton(
                      onPressed: () {},
                      child: Text(S.of(context).noFavoritesAdded)),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(S.of(context).serviceProvider,
                        style: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .textTheme
                            .bodyMedium),
                    SingleChildScrollView(
                      child: SizedBox(
                        height: 275,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              _userDashboardController.serviceByFavList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return FavCard(
                                id: _userDashboardController
                                    .serviceByFavList[index].id,
                                image: _userDashboardController
                                            .serviceByFavList[index]
                                            .profileImage ==
                                        ''
                                    ? Container(
                                        height: 120,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.blue,
                                          image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/profile.jpg'),
                                              fit: BoxFit.fill),
                                        ),
                                      )
                                    : Container(
                                        height: 120,
                                        width: 160,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.blue,
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    '$profileUrl${_userDashboardController.serviceByFavList[index].profileImage}'),
                                                fit: BoxFit.fill)),
                                      ),
                                name: _userDashboardController
                                    .serviceByFavList[index].title,
                                chat: () {
                                  firebase.createChatRoom(
                                      context,
                                      _userDashboardController
                                          .serviceByFavList[index].id,
                                      _userDashboardController
                                          .serviceByFavList[index].title,
                                      _userDashboardController
                                          .serviceByFavList[index].email,
                                      _userDashboardController
                                          .serviceByFavList[index].phone);
                                },
                                ratings: _userDashboardController
                                    .serviceByFavList[index].ratings,
                                profession: _userDashboardController
                                    .serviceByFavList[index].categoryName,
                                onTap: () {
                                  Get.to(
                                    () => WorkerProfileScreen(
                                        userID: _userDashboardController
                                            .serviceByFavList[index]
                                            .categoryId),
                                  );
                                },
                                call: () {
                                  makePhoneCall(_userDashboardController
                                      .serviceByFavList[index].phone);
                                },
                                favorite: () {
                                  favoriteController
                                      .favUpdate(_userDashboardController
                                          .serviceByFavList[index].id)
                                      .whenComplete(() =>
                                          _userDashboardController
                                              .getUsersFavorite());
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
