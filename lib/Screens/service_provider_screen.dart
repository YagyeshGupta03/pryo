import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/all_urls.dart';
import 'package:pryo_app/Controllers/user_dashboard_controller.dart';
import 'package:pryo_app/Screens/worker_profile_screen.dart';
import '../Constants/colors.dart';
import '../Constants/theme_data.dart';
import '../Controllers/global_controllers.dart';
import '../Widgets/dashboard_widgets.dart';
import 'UserMemberScreens/HomeScreens/dashboard_screen.dart';
import 'UserMemberScreens/HomeScreens/homeScreen.dart';

class ServiceProviderScreen extends StatefulWidget {
  const ServiceProviderScreen(
      {Key? key, required this.heading, required this.child})
      : super(key: key);

  final String heading;
  final Widget child;

  @override
  State<ServiceProviderScreen> createState() => _ServiceProviderScreenState();
}

class _ServiceProviderScreenState extends State<ServiceProviderScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .iconTheme
                  .color,
            )),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            widget.heading,
            style: Provider.of<ThemeProvider>(context)
                .currentTheme
                .textTheme
                .bodyMedium,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: widget.child,
      ),
    );
  }
}





class ServiceProviders extends StatefulWidget {
  const ServiceProviders({
    super.key,
    required this.image,
    required this.title,
    required this.phone,
    required this.ratings,
    required this.id,
    required this.profession, required this.email, required this.countryCode,
  });

  final String image;
  final String title;
  final String phone;
  final String countryCode;
  final String ratings;
  final String id;
  final String profession;
  final String email;

  @override
  State<ServiceProviders> createState() => _ServiceProvidersState();
}

class _ServiceProvidersState extends State<ServiceProviders> {

  bool isFav = false;

  @override
  void initState() {
    super.initState();
    _userDashboardController.checkFavorite(widget.id).then((value){
      isFav = value;
    });
  }

  final UserDashboardController _userDashboardController =
  Get.put(UserDashboardController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Get.to(()=> WorkerProfileScreen(userID: widget.id));
      },
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Provider.of<ThemeProvider>(context).currentTheme.cardColor,
        ),
        child: Column(
          children: [
            widget.image == ''
                ? Container(
                    height: 120,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                      image: const DecorationImage(
                          image: AssetImage('assets/images/profile.jpg'),
                          fit: BoxFit.fill),
                    ),
                  )
                : Container(
                    height: 120,
                    width: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                      image: DecorationImage(
                          image: NetworkImage('$profileUrl${widget.image}'),
                          fit: BoxFit.fill),
                    ),
                  ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Text(
                widget.title,
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .bodyMedium,maxLines: 1, overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              child: Text(
                widget.profession,
                style: Provider.of<ThemeProvider>(context)
                    .currentTheme
                    .textTheme
                    .titleSmall,maxLines: 1, overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 5),
            IgnorePointer(
              ignoring: true,
              child: RatingBar(
                initialRating: widget.ratings.isEmpty ? 1 : double.parse(widget.ratings),
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 20,
                ratingWidget: RatingWidget(
                  full: const Icon(
                    Icons.star,
                    color: Color(0XFFFEAD1D),
                  ),
                  half: const Icon(Icons.star_half, color: Color(0XFFFEAD1D)),
                  empty:
                  const Icon(Icons.star_border, color: Color(0XFFFEAD1D)),
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TapButton(
                  onTap: () {
                    makePhoneCall('${widget.countryCode}${widget.phone}');
                  },
                  image: const Icon(
                    Icons.call,
                    color: Colors.green,
                  ),
                ),
                TapButton(
                  onTap: () {
                    firebase.createChatRoom(
                        context,
                        widget.id,
                        widget.title,
                       widget.email,
                        widget.phone);
                  },
                  image: Image.asset(
                    'assets/images/chat.png',
                    fit: BoxFit.contain,
                  ),
                ),
                if(isFav)
                  IconButton(
                      onPressed: () async {
                        bool done = await _userDashboardController
                            .favUpdate(widget.id);
                        print(done);
                        if (done) {
                          isFav  = done;
                          setState(() {

                          });
                        } else {
                          isFav  = done;
                          setState(() {});
                        }
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ))
                else
                  IconButton(
                      onPressed: () async {
                        bool done = await _userDashboardController
                            .favUpdate(widget.id);
                        print(done);
                        if (done) {
                          isFav  = done;
                          setState(() {

                          });
                        } else {
                          isFav  = done;
                          setState(() {});
                        }
                      },
                      icon: const Icon(Icons.favorite_border))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
