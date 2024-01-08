
//Base apis
const String baseUrl = 'https://pryo.nu/Api/';
const String imageUrl = 'https://pryo.nu/uploads/category/';
const String galleryUrl = 'https://pryo.nu/uploads/gallery_images/';
const String profileUrl = 'https://pryo.nu/uploads/profile_pic/';
const String subCategoryUrl = 'https://pryo.nu/uploads/subcategory/';
const String advertisementUrl = 'https://pryo.nu/uploads/ads/';
const String onboardingImage = 'https://pryo.nu/uploads/splash/';

//Intro apis
const String onboardingUrl = '${baseUrl}get_all_splash';
const String emailLoginUrl = '${baseUrl}user_login_with_email';
const String phoneLoginUrl = '${baseUrl}user_login_with_phone';
const String signupUrl = '${baseUrl}service_user_signup';
const String userInfo = '${baseUrl}getUserById';
const String forgotPasswordApi = '${baseUrl}forgotPassword';
// const String termsApi = '${baseUrl}get_terms_and_conditions';
const String termsWebApi = 'https://pryo.nu/terms-and-conditions';
const String privacyWebApi = 'https://pryo.nu/privacy-policy';
// const String privacy = '${baseUrl}get_privacy_policy';
const String adminSupportApi = '${baseUrl}add_inquiry';
const String sendOTP = '${baseUrl}send_otp'; //forgot password Api
const String verifyOTP = '${baseUrl}varified_otp'; //forgot password Api
const String signUpOTP = '${baseUrl}signup_email_varified'; // sign up verification api
const String signUpOTPVerify = '${baseUrl}signup_varified'; // sign up verification api


//Profile Update apis
const String spProfileUpdate = '${baseUrl}userServiceProfileUpdate';
const String userProfileUpdate = '${baseUrl}userProfileUpdate';
const String profileImage = '${baseUrl}update_profile_img';
const String galleryImages = '${baseUrl}update_gallery_images';
const String addReviewApi = '${baseUrl}add_review_rating';
const String updateWorkExp = '${baseUrl}update_work_experience';
const String updateLocationApi = '${baseUrl}user_lat_long_update_byId';
const String changePasswordApi = '${baseUrl}changePassword';
const String checkReview = '${baseUrl}get_last_user_review';


//Form dropdown apis
const String getSubCategoryByCategoryId = '${baseUrl}getSubcategoryById';


//User Dashboard apis
const String getAllCategory = '${baseUrl}get_all_category';
const String serviceProviderByLatLng = '${baseUrl}getUserBylatLong';
const String serviceProviderByCity = '${baseUrl}serviceProviderSearchBycategoryAndCity';
const String getAllSubCategories = '${baseUrl}getAllSubCategory';
const String addFavorite = '${baseUrl}add_wishlist';
const String getFavorite = '${baseUrl}getAllUserWishlist';
const String getAds = '${baseUrl}getAllAds';
const String getReviewList = '${baseUrl}get_userListReviewRatingByProductId';
const String getAdminReview = '${baseUrl}getDashboardReview';
const String getServiceProviderBySubCatId = '${baseUrl}getServiceProviderBySubcatId';
const String searchBarApi = '${baseUrl}get_searchByCategorySubcategoryFullname';
const String serviceProviderByRatings = '${baseUrl}getServiceProviderByCityAccordingToRating';
const String checkFav = '${baseUrl}checkWishlistUser';
const String reviewAndWork = '${baseUrl}get_reviewRatingByPercent';


