import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Screens/UserMemberScreens/HomeScreens/homeScreen.dart';
import 'package:pryo_app/Screens/review_screen.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Constants/all_urls.dart';
import '../Constants/sizes.dart';
import '../Constants/theme_data.dart';
import '../Controllers/global_controllers.dart';
import '../Controllers/profile_controller.dart';
import '../generated/l10n.dart';

class WorkerProfileScreen extends StatefulWidget {
  const WorkerProfileScreen({Key? key, required this.userID}) : super(key: key);

  final String userID;

  @override
  State<WorkerProfileScreen> createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> {
  @override
  void initState() {
    super.initState();
    userInfoController.getWorkerInfo(widget.userID);
    userInfoController.getReviewAndExperience(widget.userID);
    userInfoController.getReviews(widget.userID);
  }

  void _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    print(phoneNumber);
    if (await canLaunch(phoneUri.toString())) {
      await launch(phoneUri.toString());
    } else {
      throw 'Could not launch phone call';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
            Get.to(() => const HomeScreen());
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
                            userInfoController.wFullName.value,
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .bodyMedium, textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Obx(
                          () => Text(
                            '${userInfoController.wCategoryName.value} ${S.of(context).expert}',
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .bodyLarge,
                          ),
                        ),
                        const SizedBox(height: 10),
                        IgnorePointer(
                          ignoring: true,
                          child: RatingBar(
                            initialRating: userInfoController
                                    .wAverageRatings.value.isEmpty
                                ? 1
                                : double.parse(
                                    userInfoController.wAverageRatings.value),
                            direction: Axis.horizontal,
                            itemCount: 5,
                            itemSize: 20,
                            ratingWidget: RatingWidget(
                              full: const Icon(
                                Icons.star,
                                color: Color(0XFFFEAD1D),
                              ),
                              half: const Icon(Icons.star_half,
                                  color: Color(0XFFFEAD1D)),
                              empty: const Icon(Icons.star_border,
                                  color: Color(0XFFFEAD1D)),
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                        ),
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
                                width: screenWidth(context)/1.5,
                                height: 45,
                                child: Center(
                                  child: Text(
                                    userInfoController.wCity.value,
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
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ContactButton(
                              color: primaryColor,
                              icon: Icons.call,
                              text: S.of(context).call,
                              onTap: () {
                                print(userInfoController.wCountryCode.value);
                                print(userInfoController.wPhone.value);
                                _makePhoneCall(
                                    '${userInfoController.wCountryCode.value}${userInfoController.wPhone.value}');
                              },
                              txtClr: whiteColor,
                            ),
                            ContactButton(
                              color: const Color(0XFFFE6D0B).withOpacity(0.25),
                              icon: Icons.message,
                              text: S.of(context).chats,
                              onTap: () {
                                firebase.createChatRoom(
                                    context,
                                    userInfoController.wId.value.toString(),
                                    userInfoController.wFullName.value
                                        .toString(),
                                    userInfoController.wEmail.value.toString(),
                                    userInfoController.wPhone.value.toString());
                              },
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
                            userInfoController.wAbout.value == ''? S.of(context).iAmAServiceProvider : userInfoController.wAbout.value,
                            style: Provider.of<ThemeProvider>(context)
                                .currentTheme
                                .textTheme
                                .labelMedium,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const RatingsBox(),
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
                            text: userInfoController.wSubCategoryName.value),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                ProfileImage(
                  image: userInfoController.wProfileImage.value,
                ),
              ],
            ),
            const Gallery(),
            Review(
              workerId: widget.userID,
              profileImage: userInfoController.wProfileImage.value,
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
class RatingsBox extends StatelessWidget {
  const RatingsBox({
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
                  '${userInfoController.positiveRatings.value.toString().toString()}%',
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
                () => userInfoController.totalFiveRating.value.toString() == ''
                    ? Text(
                        '0',
                        style: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .textTheme
                            .headlineMedium,
                      )
                    : Text(
                        userInfoController.totalFiveRating.value.toString(),
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
                () => userInfoController.wWorkExperience.value.toString() == ''
                    ? Text(
                        '0',
                        style: Provider.of<ThemeProvider>(context)
                            .currentTheme
                            .textTheme
                            .headlineMedium,
                      )
                    : Text(
                        userInfoController.wWorkExperience.value.toString(),
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
class Gallery extends StatelessWidget {
  const Gallery({Key? key}) : super(key: key);

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
            () => userInfoController.wGalleryImages.length.isEqual(1)
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
                      itemCount: userInfoController.wGalleryImages.length,
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
                                      '$galleryUrl${userInfoController.wGalleryImages[index]}'),
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
//
class Review extends StatelessWidget {
  const Review({Key? key, required this.profileImage, required this.workerId})
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
                onPressed: () {
                  _profileController.checkLastReview(context, workerId).then((value) {
                    Get.to(() => ReviewScreen(image: profileImage, spId: workerId),
                    );
                  });
                },
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

//
//
//
//
//
class ReviewTile extends StatelessWidget {
  const ReviewTile({
    super.key,
    required this.images,
    required this.name,
    required this.review,
    required this.rating,
  });

  final String images;
  final String name;
  final String review;
  final String rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth(context),
      height: 100,
      padding: const EdgeInsets.all(2),
      color: Colors.transparent,
      margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          images == ''
              ? Container(
                  height: 60,
                  width: 60,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2000),
                    color: Colors.blue,
                    image: const DecorationImage(
                        image: AssetImage('assets/images/profile.jpg'),
                        fit: BoxFit.fill),
                  ),
                )
              : Container(
                  height: 60,
                  width: 60,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2000),
                      color: Colors.blue,
                      image: DecorationImage(
                          image: NetworkImage('$profileUrl$images'),
                          fit: BoxFit.fill)),
                ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .bodyLarge,
                ),
                const SizedBox(height: 5),
                IgnorePointer(
                  ignoring: true,
                  child: RatingBar(
                    initialRating: rating.isEmpty ? 1 : double.parse(rating),
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: 15,
                    ratingWidget: RatingWidget(
                      full: const Icon(
                        Icons.star,
                        color: Color(0XFFFEAD1D),
                      ),
                      half:
                          const Icon(Icons.star_half, color: Color(0XFFFEAD1D)),
                      empty: const Icon(Icons.star_border,
                          color: Color(0XFFFEAD1D)),
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  child: Text(
                    review,
                    style: Provider.of<ThemeProvider>(context)
                        .currentTheme
                        .textTheme
                        .titleSmall,
                  ),
                )
              ],
            ),
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
class ExpertPoints extends StatelessWidget {
  const ExpertPoints({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.check_circle,
          color: blackColor,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: Provider.of<ThemeProvider>(context)
              .currentTheme
              .textTheme
              .labelMedium,
          overflow: TextOverflow.ellipsis,
          maxLines: 5,
        ),
      ],
    );
  }
}

//
//
//
//
//
class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: image.isNotEmpty
          ? Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.only(top: 120),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 5),
                color: Colors.white,
                image: DecorationImage(
                    image: NetworkImage('$profileUrl$image'), fit: BoxFit.fill),
              ),
            )
          : Container(
              height: 100,
              width: 100,
              margin: const EdgeInsets.only(top: 120),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 5),
                color: Colors.white,
                image: const DecorationImage(
                    image: AssetImage('assets/images/profile.jpg'),
                    fit: BoxFit.fill),
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
class ContactButton extends StatelessWidget {
  const ContactButton({
    super.key,
    required this.icon,
    required this.onTap,
    required this.color,
    required this.text,
    required this.txtClr,
  });

  final IconData icon;
  final Function onTap;
  final Color color;
  final String text;
  final Color txtClr;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: color,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: txtClr,
            ),
            const SizedBox(width: 5),
            Text(
              text,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: txtClr,
                fontFamily: fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
