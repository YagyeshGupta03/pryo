import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pryo_app/Constants/colors.dart';
import 'package:pryo_app/Controllers/global_controllers.dart';

String fontFamily = "nunito";

ThemeData whiteTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  iconTheme: const IconThemeData(color: Colors.black),
  fontFamily: fontFamily,
  primaryColor: const Color(0XFFFE6D0B),
  hintColor: Colors.white,
  indicatorColor: circleClr,
  hoverColor: Colors.transparent,
  primaryColorDark: const Color(0XFFFE6D0B),
  textTheme: TextTheme(
    displayLarge: TextStyle(
        color: txtColor,
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w700),

    displayMedium: TextStyle(
        color: txtColor,
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600),

    //custom textField
    displaySmall: TextStyle(
      fontWeight: FontWeight.w400,
      color: txtColor,
      fontSize: 15,
      fontFamily: fontFamily,
    ),

    bodySmall: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: txtColor,
      fontFamily: fontFamily,
    ),

    bodyMedium: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: txtColor,
      fontFamily: fontFamily,
    ),

    bodyLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: txtColor,
      fontFamily: fontFamily,
    ),

    //User name on dashboard screen
    titleSmall: TextStyle(
        color: txtColor,
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400),

    titleMedium: TextStyle(
        color: txtColor,
        fontFamily: fontFamily,
        fontSize: 17,
        fontWeight: FontWeight.w600),

    titleLarge: TextStyle(
        fontSize: 30,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w900,
        color: txtColor),

    labelSmall: TextStyle(
        fontSize: 11,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        color: txtColor),

    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: txtColor,
      fontFamily: fontFamily,
    ),

    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: txtColor,
      fontFamily: fontFamily,
    ),

    headlineSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: txtColor,
      fontFamily: fontFamily,
    ),

    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: txtColor,
      fontFamily: fontFamily,
    ),

    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: Colors.black,
      fontFamily: fontFamily,
    ),
  ),
  cardTheme: const CardTheme(color: Colors.white),
  inputDecorationTheme: InputDecorationTheme(
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: primaryColor,
        width: 2,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 1,
      ),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    toolbarHeight: 60,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  focusColor: Colors.black,
  cardColor: circleClr,
  canvasColor: circleClr,
  dialogBackgroundColor: Colors.black,
  highlightColor: circleClr,
  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    buttonColor: const Color(0XFFFE6D0B).withOpacity(0.25),
  ),
);

ThemeData blackTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  useMaterial3: true,
  fontFamily: fontFamily,
  iconTheme: const IconThemeData(color: Colors.white),
  primaryColor: const Color(0XFFFE6D0B),
  hintColor: const Color(0XFF384046),
  indicatorColor: Colors.black,
  primaryColorDark: Colors.black,
  hoverColor: Colors.white,

  textTheme: TextTheme(
    displayLarge: TextStyle(
        color: Colors.white,
        fontFamily: fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w700),

    displayMedium: TextStyle(
        color: Colors.white,
        fontFamily: fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600),

    //custom textField
    displaySmall: TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.white,
      fontSize: 15,
      fontFamily: fontFamily,
    ),

    bodySmall: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontFamily: fontFamily,
    ),

    bodyMedium: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontFamily: fontFamily,
    ),

    bodyLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontFamily: fontFamily,
    ),

    //User name on dashboard screen
    titleSmall: TextStyle(
        color: Colors.white,
        fontFamily: fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400),

    titleMedium: TextStyle(
        color: Colors.white,
        fontFamily: fontFamily,
        fontSize: 17,
        fontWeight: FontWeight.w600),

    titleLarge: TextStyle(
        fontSize: 30,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w900,
        color: Colors.white),

    labelSmall: TextStyle(
        fontSize: 11,
        fontFamily: fontFamily,
        fontWeight: FontWeight.w400,
        color: Colors.white),

    labelMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.white,
      fontFamily: fontFamily,
    ),

    labelLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontFamily: fontFamily,
    ),

    headlineSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontFamily: fontFamily,
    ),

    headlineMedium: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontFamily: fontFamily,
    ),

    headlineLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: Colors.black,
      fontFamily: fontFamily,
    ),
  ),

  cardTheme: const CardTheme(color: Color(0XFF384046)),

  inputDecorationTheme: InputDecorationTheme(
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.transparent,
        width: 5,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: primaryColor,
        width: 2,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.white,
        width: 1,
      ),
    ),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    toolbarHeight: 60,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    // titleTextStyle:
    //     TextStyle(fontSize: 14, fontFamily: fontFamily, color: Colors.black)
  ),

  //circle clr to grey color
  cardColor: const Color(0XFF384046),

  dialogBackgroundColor: const Color(0XFF03132C),
  highlightColor: Colors.black,
  canvasColor: Colors.black,
  focusColor: Colors.white,

  buttonTheme: ButtonThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    buttonColor: Color(0XFFFE6D0B).withOpacity(0.25),
  ),
);

class ThemeProvider extends ChangeNotifier {
  ThemeData _currentTheme = whiteTheme;

  ThemeData get currentTheme =>
      credentialController!.theme ? _currentTheme : blackTheme;

  void setTheme(ThemeData theme) {
    _currentTheme = theme;
    notifyListeners();
    // credentialController.addTheme(true);
  }
}

//
//
//
//
// class WordProvider extends ChangeNotifier {
//   final eng = const Locale("en", "US");
//   final sv = const Locale("sv", "SWE");
//
//   Locale _currentLanguage = credentialController.word.toString() == 'eng'
//       ? const Locale("en", "US")
//       : const Locale("sv", "SWE");
//
//   Locale get currentLanguage =>
//       credentialController.word != null ? _currentLanguage : eng;
//
//   void setWord(String lang) {
//     notifyListeners();
//     if(lang == 'eng'){
//       _currentLanguage = const Locale("en", "US");
//       notifyListeners();
//     }
//     else {
//       _currentLanguage = const Locale("sv", "SWE");
//       notifyListeners();
//     }
//     notifyListeners();
//     // credentialController.addTheme(true);
//   }
// }


class LanguageController extends GetxController {
  final availableLanguages = ['en', 'sv']; // Add more languages as needed

  late Object _currentLanguage = credentialController.word ?? 'sv'.obs;

  Object get currentLanguage => _currentLanguage;

   void changeLanguage(String newLanguage) {
    if (availableLanguages.contains(newLanguage)) {
      _currentLanguage = newLanguage;
      Get.updateLocale(Locale(newLanguage));
    }
  }
}

//
// class AppTranslation {
//   static Map<String, Map<String, String>> translations = {
//     'en': {
//       "welcomeBackYouHaveBeenNMissedForLongTime": "Welcome Back, You Have Been \n Missed For Long Time",
//       "emailAddress": "Email Address",
//       "password": "Password",
//       "helloUser": "Hello user!",
//       "forgotPassword": "Forgot Password?",
//       "login": "Login",
//       "enterAllTheCredentials": "Enter all the credentials",
//       "dontHaveAnAccount": "Don't have an account?",
//       "signUp": "Sign Up",
//       "clickHereToReadOur": "Click here to read our",
//       "termsOfService": "Terms of Service",
//       "and": "and",
//       "privacyPolicies": "Privacy Policies",
//       "enterYourRegisteredEmail": "Enter your registered e-mail",
//       "email": "E-mail",
//       "enterYourMail": "Enter your mail",
//       "sendOtp": "Send OTP",
//       "anOtpIsSendToYourMail": "An OTP is send to your mail",
//       "enterOtpSendToYourMail": "Enter otp send to your mail",
//       "enterOtp": "Enter OTP",
//       "fieldIsEmpty": "Field is empty",
//       "enterNewPassword": "Enter new password",
//       "selectUserType": "Select user type",
//       "userMember": "User Member",
//       "serviceProvider": "Service Provider",
//       "fullName": "Full Name",
//       "userName": "User Name",
//       "city": "City",
//       "address": "Address",
//       "phoneNumber": "Phone Number",
//       "signup": "SIGNUP",
//       "next": "Next",
//       "enterValidDetails": "Enter valid details",
//       "kindlyFillAllTheMandatoryFields": "Kindly fill all the mandatory fields",
//       "alreadyHaveAnAccount": "Already have an account?",
//       "logIn": "Log In",
//       "verification": "Verification",
//       "selectId": "Select ID",
//       "otp": "OTP",
//       "enterOtpSendToYourMailToRegisterSuccessfully": "[Enter OTP send to your mail to register successfully]",
//       "invalidOtp": "Invalid OTP",
//       "otpExpired": "OTP expired",
//       "verifyOtp": "Verify OTP",
//       "whatWouldYouLikeToService": "What would you like to service?",
//       "searchServiceCategories": "Search Service, Categories",
//       "categories": "Categories",
//       "viewAll": "View All",
//       "serviceProviderNearby": "Service Provider Nearby",
//       "serviceProvidersNearby": "Service providers nearby",
//       "locationPermissionIsDeniedKindlyProvidePermissionForNearbyService": "Location permission is denied. Kindly provide permission for nearby service provider.",
//       "noServiceProviderNearbyYou": "No service provider nearby you",
//       "kindlyAllowLocationPermission": "Kindly allow location permission.",
//       "clickHere": "Click here",
//       "leaveFeedback": "Leave feedback",
//       "submit": "Submit",
//       "pleaseRateYourServiceProvider": "Please rate your service provider",
//       "pleaseRateUs": "Please rate us!",
//       "review": "Review",
//       "noReview": "No review",
//       "addReview": "+ Add Review",
//       "reviews": "Reviews",
//       "noImagesAvailable": "No images available",
//       "gallery": "Gallery",
//       "expertise": "Expertise",
//       "iAmAServiceProvider": "I am a service provider",
//       "about": "About",
//       "call": "Call",
//       "chats": "Chats",
//       "oldPassword": "Old password",
//       "enterYourExistingPassword": "Enter your existing password",
//       "newPassword": "New password",
//       "confirmPassword": "Confirm password",
//       "confirmYourPassword": "Confirm your password",
//       "passwordConfirmationDoesNotMatch": "Password confirmation does not match",
//       "fillAllTheFields": "Fill all the fields",
//       "save": "Save",
//       "adminSupport": "Admin Support",
//       "title": "Title",
//       "description": "Description",
//       "noComputerServiceProviderInYourCity": "No Computer service provider in your city",
//       "contractorService": "Contractor service",
//       "noContractorInYourCity": "No contractor in your city",
//       "serviceCategory": "Service Category",
//       "topServiceProvider": "Top Service Provider",
//       "topServiceProviders": "Top Service Providers",
//       "noServiceProviderInYourCity": "No service provider in your city",
//       "whatOurCustomerSays": "What Our Customer Says",
//       "verifiedUser": "Verified User",
//       "yourFavorites": "Your Favorites",
//       "noConversation": "No Conversation",
//       "allCategories": "All Categories",
//       "editProfile": "Edit Profile",
//       "streetIncludeHouseNumber": "Street (Include house number)",
//       "update": "Update",
//       "selectWorkProfile": "Select Work Profile",
//       "workProfile": "Work Profile",
//       "removeSelectedWorkProfile": "Remove selected work profile",
//       "selectServiceCategory": "Select Service Category",
//       "aboutYourself": "About yourself",
//       "bio": "Bio",
//       "addYourServiceImages": "Add your service images",
//       "edit": "Edit",
//       "workExperience": "Work Experience",
//       "enterNumberOfYears": "Enter number of years",
//       "selectExperienceCertificate": "Select experience certificate",
//       "enterAllTheFields": "Enter all the fields",
//       "skip": "Skip",
//       "enquirySubmittedSuccessfully": "Enquiry submitted successfully",
//       "noInternetConnection": "No Internet Connection",
//       "pleaseWait": "Please Wait",
//       "notAvailableForChat": "Not Available For Chat",
//       "imageUploadedSuccessfully": "Image uploaded successfully",
//       "checkYourInternetConnection": "Check your internet connection.",
//       "refresh": "Refresh",
//       "galleryImages": "Gallery Images",
//       "chooseImage": "Choose image",
//       "noImageInTheGallery": "No image in the gallery",
//       "saveImage": "Save image",
//       "dashboard": "Dashboard",
//       "totalExperience": "Total Experience",
//       "positiveRatings": "Positive Ratings",
//       "profileDetails": "Profile Details",
//       "settings": "Settings",
//       "changePassword": "Change password",
//       "contactUs": "Contact us",
//       "logout": "Logout",
//       "lightTheme": "Light theme",
//       "darkTheme": "Dark theme",
//       "photo": "Photo",
//       "file": "File",
//       "cancel": "Cancel",
//       "chat": "Chat",
//       "serviceProviders": "Service Providers",
//       "goBack": "Go Back",
//       "home": "Home",
//       "category": "Category",
//       "profiles": "Profiles",
//       "noFavoritesAdded": "No favorites added",
//       "notifications": "Notifications",
//       "ourServiceProvider": "Our Service Provider",
//       "noServiceProviderForThisCategoryInYourArea": "No service provider for this category in your area",
//       "expert": "Expert",
//       "computerIn": "Computer in",
//       "computersService": "Computers service",
//       "contractorIn": "Contractor in",
//       "theme": "Theme",
//       "language": "Language",
//       "noSearchDataAvailable": "No search data available"
//     },
//     'sv': {
//       "welcomeBackYouHaveBeenNMissedForLongTime": "Välkommen tillbaka, du har saknats under lång tid.",
//       "emailAddress": "Emailadress",
//       "password": "Lösenord",
//       "helloUser": "Hej användare!",
//       "forgotPassword": "Glömt lösenordet?",
//       "login": "Logga in",
//       "enterAllTheCredentials": "Ange alla uppgifter",
//       "dontHaveAnAccount": "Har du inte ett konto?",
//       "signUp": "Registrera dig",
//       "clickHereToReadOur": "Klicka här för att läsa våra",
//       "termsOfService": "Användarvillkor",
//       "and": "och",
//       "privacyPolicies": "Integritetspolicys",
//       "enterYourRegisteredEmail": "Ange din registrerade e-post",
//       "email": "E-post",
//       "enterYourMail": "Ange din e-post",
//       "sendOtp": "Skicka OTP",
//       "anOtpIsSendToYourMail": "En OTP har skickats till din e-post",
//       "enterOtpSendToYourMail": "Ange OTP skickat till din e-post",
//       "enterOtp": "Ange OTP",
//       "fieldIsEmpty": "Fältet är tomt",
//       "enterNewPassword": "Ange nytt lösenord",
//       "selectUserType": "Välj användartyp",
//       "userMember": "Användarmedlem",
//       "serviceProvider": "Tjänsteleverantör",
//       "fullName": "Fullständigt namn",
//       "userName": "Användarnamn",
//       "city": "Stad",
//       "address": "Adress",
//       "phoneNumber": "Telefonnummer",
//       "signup": "Registrera dig",
//       "next": "Nästa",
//       "enterValidDetails": "Ange giltiga uppgifter",
//       "kindlyFillAllTheMandatoryFields": "Vänligen fyll i alla obligatoriska fält",
//       "alreadyHaveAnAccount": "Har du redan ett konto?",
//       "logIn": "Logga in",
//       "verification": "Verifikation",
//       "selectId": "Välj ID",
//       "otp": "OTP",
//       "enterOtpSendToYourMailToRegisterSuccessfully": "[Ange OTP skickat till din e-post för att registreringen ska lyckas]",
//       "invalidOtp": "Ogiltig OTP",
//       "otpExpired": "OTP har gått ut",
//       "verifyOtp": "Bekräfta OTP",
//       "whatWouldYouLikeToService": "Vad vill du ha för tjänst?",
//       "searchServiceCategories": "Sök tjänst, Kategorier",
//       "categories": "Kategorier",
//       "viewAll": "Visa alla",
//       "serviceProviderNearby": "Tjänsteleverantörer i närheten",
//       "serviceProvidersNearby": "Tjänsteleverantörer i närheten",
//       "locationPermissionIsDeniedKindlyProvidePermissionForNearbyService": "Platsbehörighet nekas. Vänligen ge tillstånd för att hitta närliggande tjänsteleverantörer.",
//       "noServiceProviderNearbyYou": "Inga tjänsteleverantörer i närheten av dig",
//       "kindlyAllowLocationPermission": "Vänligen tillåt platstillstånd.",
//       "clickHere": "Klicka här",
//       "leaveFeedback": "Lämna feedback",
//       "submit": "Skicka in",
//       "pleaseRateYourServiceProvider": "Vänligen betygsätt din tjänsteleverantör",
//       "pleaseRateUs": "Vänligen betygsätt oss!",
//       "review": "Recension",
//       "noReview": "Ingen recension",
//       "addReview": "+ Lägg till recension",
//       "reviews": "Recensioner",
//       "noImagesAvailable": "Inga bilder tillgängliga",
//       "gallery": "Galleri",
//       "expertise": "Expertis",
//       "iAmAServiceProvider": "Jag är en tjänsteleverantör",
//       "about": "Om",
//       "call": "Ring",
//       "chats": "Chattar",
//       "oldPassword": "Gammalt lösenord",
//       "enterYourExistingPassword": "Ange ditt befintliga lösenord",
//       "newPassword": "Nytt lösenord",
//       "confirmPassword": "Bekräfta lösenord",
//       "confirmYourPassword": "Bekräfta ditt lösenord",
//       "passwordConfirmationDoesNotMatch": "Lösenordsbekräftelse matchar inte",
//       "fillAllTheFields": "Fyll i alla fält",
//       "save": "Spara",
//       "adminSupport": "Administrativt stöd",
//       "title": "Titel",
//       "description": "Beskrivning",
//       "noComputerServiceProviderInYourCity": "Ingen datorservicetjänst i din stad",
//       "contractorService": "Entreprenadtjänst",
//       "noContractorInYourCity": "Ingen entreprenör i din stad",
//       "serviceCategory": "Tjänstekategori",
//       "topServiceProvider": "Topp tjänsteleverantör",
//       "topServiceProviders": "Topp tjänsteleverantörer",
//       "noServiceProviderInYourCity": "Ingen tjänsteleverantör i din stad",
//       "whatOurCustomerSays": "Vad våra kunder säger",
//       "verifiedUser": "Verifierad användare",
//       "yourFavorites": "Dina favoriter",
//       "noConversation": "Ingen konversation",
//       "allCategories": "Alla kategorier",
//       "editProfile": "Redigera profil",
//       "streetIncludeHouseNumber": "Gata (inkludera husnummer)",
//       "update": "Uppdatera",
//       "selectWorkProfile": "Välj arbetsprofil",
//       "workProfile": "Arbetsprofil",
//       "removeSelectedWorkProfile": "Ta bort vald arbetsprofil",
//       "selectServiceCategory": "Välj tjänstekategori",
//       "aboutYourself": "Om dig själv",
//       "bio": "Biografi",
//       "addYourServiceImages": "Lägg till dina tjänstebilder",
//       "edit": "Redigera",
//       "workExperience": "Arbetslivserfarenhet",
//       "enterNumberOfYears": "Ange antal år",
//       "selectExperienceCertificate": "Välj erfarenhetsintyg",
//       "enterAllTheFields": "Fyll i alla fält",
//       "skip": "Hoppa över",
//       "enquirySubmittedSuccessfully": "Förfrågan skickades framgångsrikt",
//       "noInternetConnection": "Ingen internetanslutning",
//       "pleaseWait": "Var god vänta",
//       "notAvailableForChat": "Ej tillgänglig för chatt",
//       "imageUploadedSuccessfully": "Bild uppladdad framgångsrikt",
//       "checkYourInternetConnection": "Kontrollera din internetanslutning",
//       "refresh": "Uppdatera",
//       "galleryImages": "Bildgalleri",
//       "chooseImage": "Välj bild",
//       "noImageInTheGallery": "Ingen bild i galleriet",
//       "saveImage": "Spara bild",
//       "dashboard": "Instrumentpanel",
//       "totalExperience": "Total erfarenhet",
//       "positiveRatings": "Positiva betyg",
//       "profileDetails": "Profildetaljer",
//       "settings": "Inställningar",
//       "changePassword": "Ändra lösenord",
//       "contactUs": "Kontakta oss",
//       "logout": "Logga ut",
//       "lightTheme": "Ljust tema",
//       "darkTheme": "Mörkt tema",
//       "photo": "Foto",
//       "file": "Fil",
//       "cancel": "Avbryt",
//       "chat": "Chatt",
//       "serviceProviders": "Tjänsteleverantörer",
//       "goBack": "Gå tillbaka",
//       "home": "Hem",
//       "category": "Kategori",
//       "profiles": "Profiler",
//       "noFavoritesAdded": "Inga favoriter tillagda",
//       "notifications": "Meddelanden",
//       "ourServiceProvider": "Våra tjänsteleverantörer",
//       "noServiceProviderForThisCategoryInYourArea": "Ingen tjänsteleverantör för denna kategori i ditt område",
//       "expert": "Expert",
//       "computerIn": "Dator i",
//       "computersService": "Datorservice",
//       "contractorIn": "Entreprenör i",
//       "theme": "Theme",
//       "language": "Language",
//       "noSearchDataAvailable": "Ingen sökdata tillgänglig."
//     },
//     // Add more translations
//   };
// }
