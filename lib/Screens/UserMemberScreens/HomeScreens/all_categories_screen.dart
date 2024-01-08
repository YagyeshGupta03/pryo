import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:pryo_app/Constants/all_urls.dart';
import 'package:pryo_app/Constants/sizes.dart';
import 'package:pryo_app/Constants/theme_data.dart';
import 'package:pryo_app/Controllers/category_controller.dart';
import 'package:pryo_app/Screens/sub_category_options.dart';
import '../../../generated/l10n.dart';
import 'homeScreen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    _categoryController.serviceCategory();
  }
  final CategoryController _categoryController = Get.put(CategoryController());
  final List<Color> colors = [
    const Color(0XFFF8B0ED).withOpacity(0.25),
    const Color(0XFFCABDFF).withOpacity(0.25),
    const Color(0XFFB5EBCD).withOpacity(0.25),
    const Color(0XFFFFD88D).withOpacity(0.25),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
             Get.to(()=> const HomeScreen());
            },
            icon: Icon(
              Icons.arrow_back_outlined,
              color: Provider.of<ThemeProvider>(context)
                  .currentTheme
                  .iconTheme
                  .color,
            )),
        title: Text(
          S.of(context).allCategories,
          style: Provider.of<ThemeProvider>(context)
              .currentTheme
              .textTheme
              .bodyMedium,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 40),
          padding: const EdgeInsets.all(20),
          child: Obx(
            () =>  SizedBox(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: screenWidth(context) < 370 ? 2 : 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 140),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _categoryController.categoryList.length,
                itemBuilder: (context, index) {
                  final colorIndex = index % colors.length;
                  final color = colors[colorIndex];
                  return CategoryCircle(
                      onTap: () {
                        _categoryController.getSubCategoryForm(context,
                            _categoryController.categoryList[index].id);
                        Get.to(
                          () => SubCategoryOptions(
                              categoryName: _categoryController
                                  .categoryList[index].title),
                        );
                      },
                      colors: color,
                      image: _categoryController.categoryList[index].image,
                      title: _categoryController.categoryList[index].title);
                },
              ),
            ),
          ),
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
class CategoryCircle extends StatelessWidget {
  const CategoryCircle(
      {Key? key,
      required this.onTap,
      required this.image,
      required this.title,
      required this.colors})
      : super(key: key);

  final Function onTap;
  final String image;
  final String title;
  final Color colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: CircleAvatar(
            radius: 32,
            backgroundColor:
                Provider.of<ThemeProvider>(context).currentTheme == whiteTheme
                    ? Colors.transparent
                    : Colors.white,
            child: CircleAvatar(
              radius: 32,
              backgroundColor: colors,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.network(
                  '$imageUrl$image',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: Provider.of<ThemeProvider>(context)
              .currentTheme
              .textTheme
              .displayMedium,
        ),
      ],
    );
  }
}
