// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:pryo_app/Constants/sizes.dart';
// import 'package:pryo_app/Constants/theme_data.dart';
// import 'package:pryo_app/Screens/Sp_screens/sp_settings.dart';
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   List today = [
//     NotificationTile(
//       icon: 'assets/images/Notifications/serviceAdd.png',
//       text: 'New Service Added',
//       subText: "AC Repair new added",
//       time: "5 mins ago",
//       onTap: () {},
//     ),
//     NotificationTile(
//       icon: 'assets/images/Notifications/moneyTransfer.png',
//       text: 'Andrews Sent You A Msg!',
//       subText: "May I help you?",
//       time: "20 mins ago",
//       onTap: () {},
//     )
//   ];
//   List week = [
//     NotificationTile(
//       icon: 'assets/images/Notifications/ratingNotify.png',
//       text: 'Rating Notification',
//       subText: "How's the experience of our service provider?",
//       time: "Mar 20",
//       onTap: () {},
//     ),
//     NotificationTile(
//       icon: 'assets/images/Notifications/discount.png',
//       text: '10% Off on All Services',
//       subText: "Book now and get 10% off on all services",
//       time: "Mar 19",
//       onTap: () {},
//     ),
//     NotificationTile(
//       icon: 'assets/images/Notifications/update.png',
//       text: 'Anything Updated',
//       subText: "Successfully updated",
//       time: "Mar 13",
//       onTap: () {},
//     ),
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Get.to(() => const SpSettings());
//           },
//           icon: Icon(
//             Icons.arrow_back_outlined,
//             color: Provider.of<ThemeProvider>(context)
//                 .currentTheme
//                 .iconTheme
//                 .color,
//           ),
//         ),
//         title: Text(
//           'Notifications',
//           style: Provider.of<ThemeProvider>(context)
//               .currentTheme
//               .textTheme
//               .bodyMedium,
//         ),
//         centerTitle: true,
//       ),
//       body: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Today',
//               style: Provider.of<ThemeProvider>(context)
//                   .currentTheme
//                   .textTheme
//                   .labelLarge,
//             ),
//             SizedBox(
//               child: ListView.builder(
//                 itemCount: today.length,
//                 shrinkWrap: true,
//                 itemBuilder: (BuildContext context, int index) {
//                   return today[index];
//                 },
//               ),
//             ),
//             const SizedBox(height: 20),
//             Text(
//               'This Week',
//               style: Provider.of<ThemeProvider>(context)
//                   .currentTheme
//                   .textTheme
//                   .labelLarge,
//             ),
//             SizedBox(
//               child: ListView.builder(
//                 itemCount: week.length,
//                 shrinkWrap: true,
//                 itemBuilder: (BuildContext context, int index) {
//                   return week[index];
//                 },
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class NotificationTile extends StatelessWidget {
//   const NotificationTile(
//       {Key? key,
//       required this.icon,
//       required this.text,
//       required this.subText,
//       required this.time,
//       required this.onTap})
//       : super(key: key);
//
//   final String icon;
//   final String text;
//   final String subText;
//   final String time;
//   final Function onTap;
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {
//         onTap();
//       },
//       child: Card(
//         elevation: 1,
//         color: Provider.of<ThemeProvider>(context).currentTheme.canvasColor,
//         shadowColor:
//             Provider.of<ThemeProvider>(context).currentTheme.canvasColor,
//         child: SizedBox(
//           height: 65,
//           width: screenWidth(context),
//           child: Center(
//             child: ListTile(
//               leading: Container(
//                 height: 45,
//                 width: 45,
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: Provider.of<ThemeProvider>(context)
//                       .currentTheme
//                       .cardTheme.color,
//                 ),
//                 child: Image.asset(icon),
//               ),
//               title: Text(
//                 text,
//                 style:  Provider.of<ThemeProvider>(context)
//                     .currentTheme.textTheme.bodyLarge,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               subtitle: Text(
//                 subText,
//                 style:  Provider.of<ThemeProvider>(context)
//                     .currentTheme.textTheme.titleSmall,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//               ),
//               trailing: Text(
//                 time,
//                 style:  Provider.of<ThemeProvider>(context)
//                     .currentTheme.textTheme.headlineSmall,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
