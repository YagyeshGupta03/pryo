// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Welcome Back, We have missed you`
  String get welcomeBackYouHaveBeenNMissedForLongTime {
    return Intl.message(
      'Welcome Back, We have missed you',
      name: 'welcomeBackYouHaveBeenNMissedForLongTime',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get emailAddress {
    return Intl.message(
      'Email Address',
      name: 'emailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Hello PRYO!`
  String get helloUser {
    return Intl.message(
      'Hello PRYO!',
      name: 'helloUser',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot Password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Enter all the credentials`
  String get enterAllTheCredentials {
    return Intl.message(
      'Enter all the credentials',
      name: 'enterAllTheCredentials',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get dontHaveAnAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'dontHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Click here to read our`
  String get clickHereToReadOur {
    return Intl.message(
      'Click here to read our',
      name: 'clickHereToReadOur',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Service`
  String get termsOfService {
    return Intl.message(
      'Terms of Service',
      name: 'termsOfService',
      desc: '',
      args: [],
    );
  }

  /// `and`
  String get and {
    return Intl.message(
      'and',
      name: 'and',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policies`
  String get privacyPolicies {
    return Intl.message(
      'Privacy Policies',
      name: 'privacyPolicies',
      desc: '',
      args: [],
    );
  }

  /// `Enter your registered e-mail`
  String get enterYourRegisteredEmail {
    return Intl.message(
      'Enter your registered e-mail',
      name: 'enterYourRegisteredEmail',
      desc: '',
      args: [],
    );
  }

  /// `E-mail`
  String get email {
    return Intl.message(
      'E-mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your mail`
  String get enterYourMail {
    return Intl.message(
      'Enter your mail',
      name: 'enterYourMail',
      desc: '',
      args: [],
    );
  }

  /// `Send OTP`
  String get sendOtp {
    return Intl.message(
      'Send OTP',
      name: 'sendOtp',
      desc: '',
      args: [],
    );
  }

  /// `An OTP has been sent to your mail`
  String get anOtpIsSendToYourMail {
    return Intl.message(
      'An OTP has been sent to your mail',
      name: 'anOtpIsSendToYourMail',
      desc: '',
      args: [],
    );
  }

  /// `Enter OTP that was sent to your mail`
  String get enterOtpSendToYourMail {
    return Intl.message(
      'Enter OTP that was sent to your mail',
      name: 'enterOtpSendToYourMail',
      desc: '',
      args: [],
    );
  }

  /// `Enter OTP`
  String get enterOtp {
    return Intl.message(
      'Enter OTP',
      name: 'enterOtp',
      desc: '',
      args: [],
    );
  }

  /// `Field is empty`
  String get fieldIsEmpty {
    return Intl.message(
      'Field is empty',
      name: 'fieldIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Enter new password`
  String get enterNewPassword {
    return Intl.message(
      'Enter new password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Select user type`
  String get selectUserType {
    return Intl.message(
      'Select user type',
      name: 'selectUserType',
      desc: '',
      args: [],
    );
  }

  /// `Searcher`
  String get userMember {
    return Intl.message(
      'Searcher',
      name: 'userMember',
      desc: '',
      args: [],
    );
  }

  /// `PRYO`
  String get serviceProvider {
    return Intl.message(
      'PRYO',
      name: 'serviceProvider',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message(
      'User Name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get phoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `SIGNUP`
  String get signup {
    return Intl.message(
      'SIGNUP',
      name: 'signup',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Enter valid details`
  String get enterValidDetails {
    return Intl.message(
      'Enter valid details',
      name: 'enterValidDetails',
      desc: '',
      args: [],
    );
  }

  /// `Kindly fill all the mandatory fields`
  String get kindlyFillAllTheMandatoryFields {
    return Intl.message(
      'Kindly fill all the mandatory fields',
      name: 'kindlyFillAllTheMandatoryFields',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already have an account?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Log In`
  String get logIn {
    return Intl.message(
      'Log In',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Verification`
  String get verification {
    return Intl.message(
      'Verification',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `Select ID`
  String get selectId {
    return Intl.message(
      'Select ID',
      name: 'selectId',
      desc: '',
      args: [],
    );
  }

  /// `OTP`
  String get otp {
    return Intl.message(
      'OTP',
      name: 'otp',
      desc: '',
      args: [],
    );
  }

  /// `[Enter OTP that was sent to your mail to register successfully]`
  String get enterOtpSendToYourMailToRegisterSuccessfully {
    return Intl.message(
      '[Enter OTP that was sent to your mail to register successfully]',
      name: 'enterOtpSendToYourMailToRegisterSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Invalid OTP`
  String get invalidOtp {
    return Intl.message(
      'Invalid OTP',
      name: 'invalidOtp',
      desc: '',
      args: [],
    );
  }

  /// `OTP expired`
  String get otpExpired {
    return Intl.message(
      'OTP expired',
      name: 'otpExpired',
      desc: '',
      args: [],
    );
  }

  /// `Verify OTP`
  String get verifyOtp {
    return Intl.message(
      'Verify OTP',
      name: 'verifyOtp',
      desc: '',
      args: [],
    );
  }

  /// `What do you need help with?`
  String get whatWouldYouLikeToService {
    return Intl.message(
      'What do you need help with?',
      name: 'whatWouldYouLikeToService',
      desc: '',
      args: [],
    );
  }

  /// `Search PRYO´s, Categories`
  String get searchServiceCategories {
    return Intl.message(
      'Search PRYO´s, Categories',
      name: 'searchServiceCategories',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `View All`
  String get viewAll {
    return Intl.message(
      'View All',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `PRYO´s Nearby`
  String get serviceProviderNearby {
    return Intl.message(
      'PRYO´s Nearby',
      name: 'serviceProviderNearby',
      desc: '',
      args: [],
    );
  }

  /// `PRYO´s Nearby`
  String get serviceProvidersNearby {
    return Intl.message(
      'PRYO´s Nearby',
      name: 'serviceProvidersNearby',
      desc: '',
      args: [],
    );
  }

  /// `Location permission is denied. Kindly provide permission for nearby PRYO´s.`
  String get locationPermissionIsDeniedKindlyProvidePermissionForNearbyService {
    return Intl.message(
      'Location permission is denied. Kindly provide permission for nearby PRYO´s.',
      name: 'locationPermissionIsDeniedKindlyProvidePermissionForNearbyService',
      desc: '',
      args: [],
    );
  }

  /// `No PRYO nearby you`
  String get noServiceProviderNearbyYou {
    return Intl.message(
      'No PRYO nearby you',
      name: 'noServiceProviderNearbyYou',
      desc: '',
      args: [],
    );
  }

  /// `Kindly allow location permission.`
  String get kindlyAllowLocationPermission {
    return Intl.message(
      'Kindly allow location permission.',
      name: 'kindlyAllowLocationPermission',
      desc: '',
      args: [],
    );
  }

  /// `Click here`
  String get clickHere {
    return Intl.message(
      'Click here',
      name: 'clickHere',
      desc: '',
      args: [],
    );
  }

  /// `Leave feedback`
  String get leaveFeedback {
    return Intl.message(
      'Leave feedback',
      name: 'leaveFeedback',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Please rate your PRYO`
  String get pleaseRateYourServiceProvider {
    return Intl.message(
      'Please rate your PRYO',
      name: 'pleaseRateYourServiceProvider',
      desc: '',
      args: [],
    );
  }

  /// `Please rate us!`
  String get pleaseRateUs {
    return Intl.message(
      'Please rate us!',
      name: 'pleaseRateUs',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get review {
    return Intl.message(
      'Review',
      name: 'review',
      desc: '',
      args: [],
    );
  }

  /// `No review`
  String get noReview {
    return Intl.message(
      'No review',
      name: 'noReview',
      desc: '',
      args: [],
    );
  }

  /// `+ Add Review`
  String get addReview {
    return Intl.message(
      '+ Add Review',
      name: 'addReview',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `No images available`
  String get noImagesAvailable {
    return Intl.message(
      'No images available',
      name: 'noImagesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get gallery {
    return Intl.message(
      'Gallery',
      name: 'gallery',
      desc: '',
      args: [],
    );
  }

  /// `Expertise`
  String get expertise {
    return Intl.message(
      'Expertise',
      name: 'expertise',
      desc: '',
      args: [],
    );
  }

  /// `I am a PRYO`
  String get iAmAServiceProvider {
    return Intl.message(
      'I am a PRYO',
      name: 'iAmAServiceProvider',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Call`
  String get call {
    return Intl.message(
      'Call',
      name: 'call',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chats {
    return Intl.message(
      'Chats',
      name: 'chats',
      desc: '',
      args: [],
    );
  }

  /// `Old password`
  String get oldPassword {
    return Intl.message(
      'Old password',
      name: 'oldPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your existing password`
  String get enterYourExistingPassword {
    return Intl.message(
      'Enter your existing password',
      name: 'enterYourExistingPassword',
      desc: '',
      args: [],
    );
  }

  /// `New password`
  String get newPassword {
    return Intl.message(
      'New password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get confirmPassword {
    return Intl.message(
      'Confirm password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm your password`
  String get confirmYourPassword {
    return Intl.message(
      'Confirm your password',
      name: 'confirmYourPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password confirmation does not match`
  String get passwordConfirmationDoesNotMatch {
    return Intl.message(
      'Password confirmation does not match',
      name: 'passwordConfirmationDoesNotMatch',
      desc: '',
      args: [],
    );
  }

  /// `Fill all the fields`
  String get fillAllTheFields {
    return Intl.message(
      'Fill all the fields',
      name: 'fillAllTheFields',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Admin Support`
  String get adminSupport {
    return Intl.message(
      'Admin Support',
      name: 'adminSupport',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `No Computer PRYO´s in your city`
  String get noComputerServiceProviderInYourCity {
    return Intl.message(
      'No Computer PRYO´s in your city',
      name: 'noComputerServiceProviderInYourCity',
      desc: '',
      args: [],
    );
  }

  /// `Contractor PRYO`
  String get contractorService {
    return Intl.message(
      'Contractor PRYO',
      name: 'contractorService',
      desc: '',
      args: [],
    );
  }

  /// `No contractor in your city`
  String get noContractorInYourCity {
    return Intl.message(
      'No contractor in your city',
      name: 'noContractorInYourCity',
      desc: '',
      args: [],
    );
  }

  /// `PRYO Category`
  String get serviceCategory {
    return Intl.message(
      'PRYO Category',
      name: 'serviceCategory',
      desc: '',
      args: [],
    );
  }

  /// `Top PRYO`
  String get topServiceProvider {
    return Intl.message(
      'Top PRYO',
      name: 'topServiceProvider',
      desc: '',
      args: [],
    );
  }

  /// `Top PRYO´s`
  String get topServiceProviders {
    return Intl.message(
      'Top PRYO´s',
      name: 'topServiceProviders',
      desc: '',
      args: [],
    );
  }

  /// `No PRYO provider in your city`
  String get noServiceProviderInYourCity {
    return Intl.message(
      'No PRYO provider in your city',
      name: 'noServiceProviderInYourCity',
      desc: '',
      args: [],
    );
  }

  /// `What Our Customer Says`
  String get whatOurCustomerSays {
    return Intl.message(
      'What Our Customer Says',
      name: 'whatOurCustomerSays',
      desc: '',
      args: [],
    );
  }

  /// `Verified User`
  String get verifiedUser {
    return Intl.message(
      'Verified User',
      name: 'verifiedUser',
      desc: '',
      args: [],
    );
  }

  /// `Your Favorites`
  String get yourFavorites {
    return Intl.message(
      'Your Favorites',
      name: 'yourFavorites',
      desc: '',
      args: [],
    );
  }

  /// `No Conversation`
  String get noConversation {
    return Intl.message(
      'No Conversation',
      name: 'noConversation',
      desc: '',
      args: [],
    );
  }

  /// `All Categories`
  String get allCategories {
    return Intl.message(
      'All Categories',
      name: 'allCategories',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get editProfile {
    return Intl.message(
      'Edit Profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Street (Include house number)`
  String get streetIncludeHouseNumber {
    return Intl.message(
      'Street (Include house number)',
      name: 'streetIncludeHouseNumber',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Select Work Profile`
  String get selectWorkProfile {
    return Intl.message(
      'Select Work Profile',
      name: 'selectWorkProfile',
      desc: '',
      args: [],
    );
  }

  /// `Work Profile`
  String get workProfile {
    return Intl.message(
      'Work Profile',
      name: 'workProfile',
      desc: '',
      args: [],
    );
  }

  /// `Remove selected work profile`
  String get removeSelectedWorkProfile {
    return Intl.message(
      'Remove selected work profile',
      name: 'removeSelectedWorkProfile',
      desc: '',
      args: [],
    );
  }

  /// `Select PRYO Category`
  String get selectServiceCategory {
    return Intl.message(
      'Select PRYO Category',
      name: 'selectServiceCategory',
      desc: '',
      args: [],
    );
  }

  /// `About yourself`
  String get aboutYourself {
    return Intl.message(
      'About yourself',
      name: 'aboutYourself',
      desc: '',
      args: [],
    );
  }

  /// `Bio`
  String get bio {
    return Intl.message(
      'Bio',
      name: 'bio',
      desc: '',
      args: [],
    );
  }

  /// `Add your PRYO images`
  String get addYourServiceImages {
    return Intl.message(
      'Add your PRYO images',
      name: 'addYourServiceImages',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Work Experience`
  String get workExperience {
    return Intl.message(
      'Work Experience',
      name: 'workExperience',
      desc: '',
      args: [],
    );
  }

  /// `Enter number of years`
  String get enterNumberOfYears {
    return Intl.message(
      'Enter number of years',
      name: 'enterNumberOfYears',
      desc: '',
      args: [],
    );
  }

  /// `Select experience certificate`
  String get selectExperienceCertificate {
    return Intl.message(
      'Select experience certificate',
      name: 'selectExperienceCertificate',
      desc: '',
      args: [],
    );
  }

  /// `Enter all the fields`
  String get enterAllTheFields {
    return Intl.message(
      'Enter all the fields',
      name: 'enterAllTheFields',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Enquiry submitted successfully`
  String get enquirySubmittedSuccessfully {
    return Intl.message(
      'Enquiry submitted successfully',
      name: 'enquirySubmittedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get noInternetConnection {
    return Intl.message(
      'No Internet Connection',
      name: 'noInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Please Wait`
  String get pleaseWait {
    return Intl.message(
      'Please Wait',
      name: 'pleaseWait',
      desc: '',
      args: [],
    );
  }

  /// `Not Available For Chat`
  String get notAvailableForChat {
    return Intl.message(
      'Not Available For Chat',
      name: 'notAvailableForChat',
      desc: '',
      args: [],
    );
  }

  /// `Image uploaded successfully`
  String get imageUploadedSuccessfully {
    return Intl.message(
      'Image uploaded successfully',
      name: 'imageUploadedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection.`
  String get checkYourInternetConnection {
    return Intl.message(
      'Check your internet connection.',
      name: 'checkYourInternetConnection',
      desc: '',
      args: [],
    );
  }

  /// `Refresh`
  String get refresh {
    return Intl.message(
      'Refresh',
      name: 'refresh',
      desc: '',
      args: [],
    );
  }

  /// `Gallery Images`
  String get galleryImages {
    return Intl.message(
      'Gallery Images',
      name: 'galleryImages',
      desc: '',
      args: [],
    );
  }

  /// `Choose image`
  String get chooseImage {
    return Intl.message(
      'Choose image',
      name: 'chooseImage',
      desc: '',
      args: [],
    );
  }

  /// `No image in the gallery`
  String get noImageInTheGallery {
    return Intl.message(
      'No image in the gallery',
      name: 'noImageInTheGallery',
      desc: '',
      args: [],
    );
  }

  /// `Save image`
  String get saveImage {
    return Intl.message(
      'Save image',
      name: 'saveImage',
      desc: '',
      args: [],
    );
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message(
      'Dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `Total Experience`
  String get totalExperience {
    return Intl.message(
      'Total Experience',
      name: 'totalExperience',
      desc: '',
      args: [],
    );
  }

  /// `Positive Ratings`
  String get positiveRatings {
    return Intl.message(
      'Positive Ratings',
      name: 'positiveRatings',
      desc: '',
      args: [],
    );
  }

  /// `Profile Details`
  String get profileDetails {
    return Intl.message(
      'Profile Details',
      name: 'profileDetails',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contactUs {
    return Intl.message(
      'Contact us',
      name: 'contactUs',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Light theme`
  String get lightTheme {
    return Intl.message(
      'Light theme',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get darkTheme {
    return Intl.message(
      'Dark theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Photo`
  String get photo {
    return Intl.message(
      'Photo',
      name: 'photo',
      desc: '',
      args: [],
    );
  }

  /// `File`
  String get file {
    return Intl.message(
      'File',
      name: 'file',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `PRYO´s`
  String get serviceProviders {
    return Intl.message(
      'PRYO´s',
      name: 'serviceProviders',
      desc: '',
      args: [],
    );
  }

  /// `Go Back`
  String get goBack {
    return Intl.message(
      'Go Back',
      name: 'goBack',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `Profiles`
  String get profiles {
    return Intl.message(
      'Profiles',
      name: 'profiles',
      desc: '',
      args: [],
    );
  }

  /// `No favorites added`
  String get noFavoritesAdded {
    return Intl.message(
      'No favorites added',
      name: 'noFavoritesAdded',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Our PRYO`
  String get ourServiceProvider {
    return Intl.message(
      'Our PRYO',
      name: 'ourServiceProvider',
      desc: '',
      args: [],
    );
  }

  /// `No PRYO for this category in your area`
  String get noServiceProviderForThisCategoryInYourArea {
    return Intl.message(
      'No PRYO for this category in your area',
      name: 'noServiceProviderForThisCategoryInYourArea',
      desc: '',
      args: [],
    );
  }

  /// `Expert`
  String get expert {
    return Intl.message(
      'Expert',
      name: 'expert',
      desc: '',
      args: [],
    );
  }

  /// `Computer in`
  String get computerIn {
    return Intl.message(
      'Computer in',
      name: 'computerIn',
      desc: '',
      args: [],
    );
  }

  /// `Computers service`
  String get computersService {
    return Intl.message(
      'Computers service',
      name: 'computersService',
      desc: '',
      args: [],
    );
  }

  /// `Contractor in`
  String get contractorIn {
    return Intl.message(
      'Contractor in',
      name: 'contractorIn',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `No search data available`
  String get noSearchDataAvailable {
    return Intl.message(
      'No search data available',
      name: 'noSearchDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `I have read`
  String get iHaveRead {
    return Intl.message(
      'I have read',
      name: 'iHaveRead',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'sv'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
