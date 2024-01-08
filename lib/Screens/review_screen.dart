import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Controllers/profile_controller.dart';
import 'package:pryo_app/Widgets/common_widgets.dart';
import '../Constants/all_urls.dart';
import '../Constants/theme_data.dart';
import '../generated/l10n.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key, required this.image, required this.spId})
      : super(key: key);

  final String image;
  final String spId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final ProfileController _profileController = Get.put(ProfileController());
  String ratings = '1';

  @override
  Widget build(BuildContext context) {
    final _feedback = TextEditingController(text: _profileController.cReview);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () {
          Get.back();
          },
          icon: Icon(
            Icons.arrow_back_outlined,
            color: Provider.of<ThemeProvider>(context)
                .currentTheme
                .iconTheme
                .color,
          ),
        ),
        title: Text(
          S.of(context).review,
          style: Provider.of<ThemeProvider>(context)
              .currentTheme
              .textTheme
              .bodyMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.image == ''?
              CircleAvatar(
                radius: 60,
                backgroundColor: primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: Image.asset(
                      'assets/images/profile.jpg',
                      fit: BoxFit.fill,
                      height: 110,
                      width: 110,
                    ),
                  ),
                ),
              )
              : CircleAvatar(
                radius: 60,
                backgroundColor: primaryColor,
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: Image.network(
                      '$profileUrl${widget.image}',
                      fit: BoxFit.fill,
                      height: 110,
                      width: 110,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(S.of(context).pleaseRateUs,
                  style: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .displayLarge,
                  textAlign: TextAlign.center),
              const SizedBox(height: 10),
              Text(S.of(context).pleaseRateYourServiceProvider,
                  style: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .titleMedium,
                  textAlign: TextAlign.center),
              const SizedBox(height: 15),
              Center(
                child: RatingBar(
                  initialRating: _profileController.cRating == ''? 1 : double.parse(_profileController.cRating),
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                    full: const Icon(
                      Icons.star,
                      color: Color(0XFFFEAD1D),
                    ),
                    half: const Icon(Icons.star_half, color: Color(0XFFFEAD1D)),
                    empty:
                        const Icon(Icons.star_border, color: Color(0XFFFEAD1D)),
                  ),
                  itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                  onRatingUpdate: (rating) {
                    print(rating);
                    setState(() {
                      ratings = '${rating.toInt()}';
                    });
                    print(ratings);
                  },
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .displayMedium,
                cursorColor: primaryColor,
                controller: _feedback,
                maxLines: 3,
                maxLength: 100,
                decoration: InputDecoration(
                  hintText: S.of(context).leaveFeedback,
                  hintStyle: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .textTheme
                      .displaySmall,
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                  border: Provider.of<ThemeProvider>(context)
                      .currentTheme
                      .inputDecorationTheme
                      .border,
                ),
              ),
              const SizedBox(height: 25),
              LoginButton(
                  onTap: () {
                    if (_feedback.text.isNotEmpty) {
                      _profileController.addReview(
                          context, widget.spId, ratings, _feedback.text);
                    }
                  },
                  title: S.of(context).submit,
                  txtColor: whiteColor,
                  btnColor: primaryColor)
            ],
          ),
        ),
      ),
    );
  }
}
