import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Screens/Sp_screens/sp_settings.dart';
import 'package:pryo_app/Screens/worker_profile_screen.dart';
import '../Constants/all_urls.dart';
import '../Constants/sizes.dart';
import '../Constants/theme_data.dart';
import '../Controllers/global_controllers.dart';
import '../Controllers/profile_controller.dart';
import '../generated/l10n.dart';



class SpProfileView extends StatefulWidget {
  const SpProfileView({Key? key}) : super(key: key);

  @override
  State<SpProfileView> createState() => _SpProfileViewState();
}

class _SpProfileViewState extends State<SpProfileView> {
  @override
  void initState() {
    super.initState();
    userInfoController.getWorkerInfo(credentialController.id);
    userInfoController.getReviewAndExperience(credentialController.id);
    userInfoController.getReviews(credentialController.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Get.to(() => const SpSettings());
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 605,
                  child: Column(
                    children: [
                      Container(
                        width: screenWidth(context),
                        height: 255,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/background.png'),
                              fit: BoxFit.fill),
                        ),
                      ),
                      SizedBox(
                        height: 350,
                        width: screenWidth(context),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: screenWidth(context),
                    margin:
                    const EdgeInsets.only(right: 20, left: 20, top: 170),
                    padding:
                    const EdgeInsets.only(left: 15, right: 15, top: 60),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .cardColor),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(
                              () => Text(
                            userInfoController.fullName.value,
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .bodyMedium, textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Obx(
                              () => Text(
                            '${userInfoController.categoryName.value} ${S.of(context).expert}',
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .bodyLarge,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // IgnorePointer(
                        //   ignoring: true,
                        //   child: RatingBar(
                        //     initialRating: userInfoController
                        //         .averageRatings.value.isEmpty
                        //         ? 1
                        //         : double.parse(
                        //         userInfoController.averageRatings.value),
                        //     direction: Axis.horizontal,
                        //     itemCount: 5,
                        //     itemSize: 20,
                        //     ratingWidget: RatingWidget(
                        //       full: const Icon(
                        //         Icons.star,
                        //         color: Color(0XFFFEAD1D),
                        //       ),
                        //       half: const Icon(Icons.star_half,
                        //           color: Color(0XFFFEAD1D)),
                        //       empty: const Icon(Icons.star_border,
                        //           color: Color(0XFFFEAD1D)),
                        //     ),
                        //     onRatingUpdate: (rating) {
                        //       print(rating);
                        //     },
                        //   ),
                        // ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.green,
                            ),
                            Obx(
                                  () => SizedBox(
                                height: 45,
                                child: Center(
                                  child: Text(
                                    userInfoController.city.value,
                                    style: Provider.of<ThemeProvider>(context)
                                        .currentTheme
                                        .textTheme
                                        .bodyLarge,
                                    maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ContactButton(
                              color: primaryColor,
                              icon: Icons.call,
                              text: S.of(context).call,
                              onTap: () {},
                              txtClr: whiteColor,
                            ),
                            ContactButton(
                              color: const Color(0XFFFE6D0B).withOpacity(0.25),
                              icon: Icons.message,
                              text: S.of(context).chats,
                              onTap: () {},
                              txtClr: primaryColor,
                            )
                          ],
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).about,
                              style: Provider.of<ThemeProvider>(context)
                                  .currentTheme
                                  .textTheme
                                  .bodyMedium,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Obx(
                              () => Text(
                            userInfoController.about.value == ''? S.of(context).iAmAServiceProvider : userInfoController.about.value,
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .labelMedium,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const SpRatingsBox(),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              S.of(context).expertise,
                              style: Provider.of<ThemeProvider>(context)
                                  .currentTheme
                                  .textTheme
                                  .bodyMedium,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        ExpertPoints(
                            text: userInfoController.subCategoryName.value),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                ProfileImage(
                  image: userInfoController.profileImage.value,
                ),
              ],
            ),
            const SpGallery(),
            SpReview(
              workerId: credentialController.id.toString(),
              profileImage: userInfoController.profileImage.value,
            ),
          ],
        ),
      ),
    );
  }
}
//
//
//
//
//
class SpGallery extends StatelessWidget {
  const SpGallery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).gallery,
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .bodyMedium,
              ),
              // userInfoController.galleryImages.isEmpty
              //     ? TextButton(
              //         onPressed: () {
              //           // Navigator.pushReplacement(
              //           //   context,
              //           //   MaterialPageRoute(
              //           //     builder: (context) => const ServiceProviderScreen(
              //           //       title: 'AC Repair',
              //           //       image: 'assets/images/acSpecialist.jpg'
              //           //           '',
              //           //     ),
              //           //   ),
              //           // );
              //         },
              //         child: Text(
              //           'View All',
              //           style: Provider.of<ThemeProvider>(context)
              //               .currentTheme
              //               .textTheme
              //               .bodySmall,
              //         ),
              //       )
              //     : const SizedBox(),
            ],
          ),
          const SizedBox(height: 5),
          Obx(
                () => userInfoController.galleryImages.length.isEqual(1)
                ? Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                S.of(context).noImagesAvailable,
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .bodySmall,
              ),
            )
                : SizedBox(
              height: 165,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: userInfoController.galleryImages.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 190,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.transparent,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                        image: DecorationImage(
                            image: NetworkImage(
                                '$galleryUrl${userInfoController.galleryImages[index]}'),
                            fit: BoxFit.fill),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//
//
//
//
class SpRatingsBox extends StatelessWidget {
  const SpRatingsBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Provider.of<ThemeProvider>(context)
              .currentTheme
              .scaffoldBackgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Obx(
                    () => Text(
                  '${userInfoController.uPositiveRatings.value.toString().toString()}%',
                  style: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .headlineMedium,
                ),
              ),
              Text(
                'Positive\n Ratings',
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .headlineSmall,
                textAlign: TextAlign.center,
              )
            ],
          ),
          Column(
            children: [
              Obx(
                    () => userInfoController.uTotalFiveRating.value.toString() == ''
                    ? Text(
                  '0',
                  style: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .headlineMedium,
                )
                    : Text(
                  userInfoController.uTotalFiveRating.value.toString(),
                  style: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .headlineMedium,
                ),
              ),
              Text('5 Star\n Ratings',
                  style: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .headlineSmall,
                  textAlign: TextAlign.center)
            ],
          ),
          Column(
            children: [
              Obx(
                    () => userInfoController.workExperience.value.toString() == ''
                    ? Text(
                  '0',
                  style: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .headlineMedium,
                )
                    : Text(
                  userInfoController.workExperience.value.toString(),
                  style: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .headlineMedium,
                ),
              ),
              Text('Years\n Experience',
                  style: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .headlineSmall,
                  textAlign: TextAlign.center)
            ],
          )
        ],
      ),
    );
  }
}

//
//
//
//
//
class SpReview extends StatelessWidget {
  const SpReview({Key? key, required this.profileImage, required this.workerId})
      : super(key: key);

  final String profileImage;
  final String workerId;

  @override
  Widget build(BuildContext context) {
    final ProfileController _profileController = Get.put(ProfileController());
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                S.of(context).reviews,
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .bodyMedium,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  S.of(context).addReview,
                  style: const TextStyle(fontSize: 14, color: primaryColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Obx(
                () => userInfoController.reviewList.length.isEqual(0)
                ? Text(
              S.of(context).noReview,
              style: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .textTheme
                  .bodySmall,
            )
                : SizedBox(
              child: ListView.builder(
                itemCount: userInfoController.reviewList.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return ReviewTile(
                    images: userInfoController.reviewList[index].image,
                    name: userInfoController.reviewList[index].name,
                    review: userInfoController.reviewList[index].review,
                    rating: userInfoController.reviewList[index].rating,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}






