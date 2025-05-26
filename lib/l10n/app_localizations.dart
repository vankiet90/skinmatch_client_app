import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi')
  ];

  /// No description provided for @menuHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get menuHome;

  /// No description provided for @menuCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get menuCustomer;

  /// No description provided for @menuInventory.
  ///
  /// In en, this message translates to:
  /// **'Inventory'**
  String get menuInventory;

  /// No description provided for @menuMarketing.
  ///
  /// In en, this message translates to:
  /// **'Marketing'**
  String get menuMarketing;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon..!'**
  String get comingSoon;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @profileScreen.
  ///
  /// In en, this message translates to:
  /// **'Profile Screen'**
  String get profileScreen;

  /// No description provided for @signInSecurity.
  ///
  /// In en, this message translates to:
  /// **'Sign In & Security'**
  String get signInSecurity;

  /// No description provided for @signInSecurityScreen.
  ///
  /// In en, this message translates to:
  /// **'Sign In & Security Screen'**
  String get signInSecurityScreen;

  /// No description provided for @languageScreen.
  ///
  /// In en, this message translates to:
  /// **'Language Screen'**
  String get languageScreen;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @privacyScreen.
  ///
  /// In en, this message translates to:
  /// **'Privacy Screen'**
  String get privacyScreen;

  /// No description provided for @staffManagement.
  ///
  /// In en, this message translates to:
  /// **'Staff Management'**
  String get staffManagement;

  /// No description provided for @staffManagementScreen.
  ///
  /// In en, this message translates to:
  /// **'Staff Management Screen'**
  String get staffManagementScreen;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @feedbackScreen.
  ///
  /// In en, this message translates to:
  /// **'Feedback Screen'**
  String get feedbackScreen;

  /// No description provided for @takeAPhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get takeAPhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get chooseFromGallery;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @customerDetailEdit.
  ///
  /// In en, this message translates to:
  /// **'Customer detail edit'**
  String get customerDetailEdit;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @pleaseEnterFullname.
  ///
  /// In en, this message translates to:
  /// **'Please enter fullname'**
  String get pleaseEnterFullname;

  /// No description provided for @fullname.
  ///
  /// In en, this message translates to:
  /// **'Fullname'**
  String get fullname;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @pleaseEnterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get pleaseEnterPhoneNumber;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter email'**
  String get pleaseEnterEmail;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get invalidEmail;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get dateOfBirth;

  /// No description provided for @pleaseSelectDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Please select date of birth'**
  String get pleaseSelectDateOfBirth;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @deleteCustomer.
  ///
  /// In en, this message translates to:
  /// **'Delete customer'**
  String get deleteCustomer;

  /// No description provided for @customerDetail.
  ///
  /// In en, this message translates to:
  /// **'Customer detail'**
  String get customerDetail;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @lastVisited.
  ///
  /// In en, this message translates to:
  /// **'Last visited'**
  String get lastVisited;

  /// No description provided for @scanHistory.
  ///
  /// In en, this message translates to:
  /// **'Scan history'**
  String get scanHistory;

  /// No description provided for @purchaseHistory.
  ///
  /// In en, this message translates to:
  /// **'Purchase history'**
  String get purchaseHistory;

  /// No description provided for @deleteStoreInformation.
  ///
  /// In en, this message translates to:
  /// **'Delete store information'**
  String get deleteStoreInformation;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @scanHistoryTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan History'**
  String get scanHistoryTitle;

  /// No description provided for @standard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get standard;

  /// No description provided for @lastScan.
  ///
  /// In en, this message translates to:
  /// **'Last scan'**
  String get lastScan;

  /// No description provided for @oilSkin.
  ///
  /// In en, this message translates to:
  /// **'Oil skin'**
  String get oilSkin;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @dateTime.
  ///
  /// In en, this message translates to:
  /// **'Date time'**
  String get dateTime;

  /// No description provided for @skinType.
  ///
  /// In en, this message translates to:
  /// **'Skin type'**
  String get skinType;

  /// No description provided for @oil.
  ///
  /// In en, this message translates to:
  /// **'Oil'**
  String get oil;

  /// No description provided for @skinHeath.
  ///
  /// In en, this message translates to:
  /// **'Skin health'**
  String get skinHeath;

  /// No description provided for @analysis.
  ///
  /// In en, this message translates to:
  /// **'Analysis'**
  String get analysis;

  /// No description provided for @drynessOrTightnessOilinessOrCloggedPores.
  ///
  /// In en, this message translates to:
  /// **'Dryness or tightness\\nOiliness or clogged pores'**
  String get drynessOrTightnessOilinessOrCloggedPores;

  /// No description provided for @noName.
  ///
  /// In en, this message translates to:
  /// **'No name'**
  String get noName;

  /// No description provided for @noBadge.
  ///
  /// In en, this message translates to:
  /// **'No badge'**
  String get noBadge;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get customer;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get goodMorning;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @scanDetail.
  ///
  /// In en, this message translates to:
  /// **'Scan Detail'**
  String get scanDetail;

  /// No description provided for @darkSpotsOnTheSkinCausedByInadequateSunProtection.
  ///
  /// In en, this message translates to:
  /// **'Dark spots on the skin caused by inadequate sun protection'**
  String get darkSpotsOnTheSkinCausedByInadequateSunProtection;

  /// No description provided for @products.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get products;

  /// No description provided for @viewOrder.
  ///
  /// In en, this message translates to:
  /// **'View order'**
  String get viewOrder;

  /// No description provided for @insights.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insights;

  /// No description provided for @drynessOrTightnessOilinessOrCloggedPores2.
  ///
  /// In en, this message translates to:
  /// **'Dryness or tightness\\nOiliness or clogged pores'**
  String get drynessOrTightnessOilinessOrCloggedPores2;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @weValueYourPrivacy.
  ///
  /// In en, this message translates to:
  /// **'We value your privacy. Here\'s how we collect, use, and protect your personal information to deliver a better skincare experience with our AI-powered app.'**
  String get weValueYourPrivacy;

  /// No description provided for @weCollectYourData.
  ///
  /// In en, this message translates to:
  /// **'We collect your name, age, address, photos, and skin condition data through AI skin scanning to personalize your skincare journey.'**
  String get weCollectYourData;

  /// No description provided for @yourDataHelpsUs.
  ///
  /// In en, this message translates to:
  /// **'Your data helps us:'**
  String get yourDataHelpsUs;

  /// No description provided for @howWeUseIt.
  ///
  /// In en, this message translates to:
  /// **'2. How We Use It'**
  String get howWeUseIt;

  /// No description provided for @enhanceYourShoppingExperience.
  ///
  /// In en, this message translates to:
  /// **'- Enhance your shopping experience.'**
  String get enhanceYourShoppingExperience;

  /// No description provided for @provideCustomerSupport.
  ///
  /// In en, this message translates to:
  /// **'- Provide customer support.'**
  String get provideCustomerSupport;

  /// No description provided for @offerPersonalizedSkincareAdvice.
  ///
  /// In en, this message translates to:
  /// **'- Offer personalized skincare advice based on AI analysis.'**
  String get offerPersonalizedSkincareAdvice;

  /// No description provided for @howLongWeStoreIt.
  ///
  /// In en, this message translates to:
  /// **'3. How Long We Store It'**
  String get howLongWeStoreIt;

  /// No description provided for @weStoreYourData.
  ///
  /// In en, this message translates to:
  /// **'We store your data for up to 3 years, depending on your choice (1, 2, or 3 years). You can opt for no storage or request deletion anytime by contacting us.'**
  String get weStoreYourData;

  /// No description provided for @howWeProtectIt.
  ///
  /// In en, this message translates to:
  /// **'4. How We Protect It'**
  String get howWeProtectIt;

  /// No description provided for @weUseSecureEncryption.
  ///
  /// In en, this message translates to:
  /// **'We use secure encryption and store your data in Vietnam, following local laws to keep it safe from unauthorized access.'**
  String get weUseSecureEncryption;

  /// No description provided for @yourRights.
  ///
  /// In en, this message translates to:
  /// **'5. Your Rights'**
  String get yourRights;

  /// No description provided for @youHaveTheRightTo.
  ///
  /// In en, this message translates to:
  /// **'You have the right to:'**
  String get youHaveTheRightTo;

  /// No description provided for @reviewOrUpdateData.
  ///
  /// In en, this message translates to:
  /// **'- Review or update your data.'**
  String get reviewOrUpdateData;

  /// No description provided for @requestDeletion.
  ///
  /// In en, this message translates to:
  /// **'- Request its deletion at any time.'**
  String get requestDeletion;

  /// No description provided for @contactUsForSupport.
  ///
  /// In en, this message translates to:
  /// **'- Contact us for support via email, phone, or Zalo.'**
  String get contactUsForSupport;

  /// No description provided for @purchaseDetail.
  ///
  /// In en, this message translates to:
  /// **'Purchase detail'**
  String get purchaseDetail;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @servedBy.
  ///
  /// In en, this message translates to:
  /// **'Served by'**
  String get servedBy;

  /// No description provided for @lumiereCleanser.
  ///
  /// In en, this message translates to:
  /// **'Lumiere Cleanser'**
  String get lumiereCleanser;

  /// No description provided for @serum.
  ///
  /// In en, this message translates to:
  /// **'Serum'**
  String get serum;

  /// No description provided for @discountApplied.
  ///
  /// In en, this message translates to:
  /// **'Discount Applied'**
  String get discountApplied;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @viewScan.
  ///
  /// In en, this message translates to:
  /// **'View scan'**
  String get viewScan;

  /// No description provided for @purchaseHistoryTitle2.
  ///
  /// In en, this message translates to:
  /// **'Purchase history'**
  String get purchaseHistoryTitle2;

  /// No description provided for @totalPurchase.
  ///
  /// In en, this message translates to:
  /// **'Total purchase'**
  String get totalPurchase;

  /// No description provided for @totalValue.
  ///
  /// In en, this message translates to:
  /// **'Total value'**
  String get totalValue;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get order;

  /// No description provided for @scanAgain.
  ///
  /// In en, this message translates to:
  /// **'Scan again'**
  String get scanAgain;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @facialAnalysis.
  ///
  /// In en, this message translates to:
  /// **'Facial analysis'**
  String get facialAnalysis;

  /// No description provided for @skincarePlan.
  ///
  /// In en, this message translates to:
  /// **'Skincare plan'**
  String get skincarePlan;

  /// No description provided for @basedOnYourSkinAnalysisOn.
  ///
  /// In en, this message translates to:
  /// **'Based on your skin analysis on'**
  String get basedOnYourSkinAnalysisOn;

  /// No description provided for @treatmentPlan.
  ///
  /// In en, this message translates to:
  /// **'Treatment plan'**
  String get treatmentPlan;

  /// No description provided for @cleanse.
  ///
  /// In en, this message translates to:
  /// **'Cleanse'**
  String get cleanse;

  /// No description provided for @toner.
  ///
  /// In en, this message translates to:
  /// **'Toner'**
  String get toner;

  /// No description provided for @moisturizer.
  ///
  /// In en, this message translates to:
  /// **'Moisturizer'**
  String get moisturizer;

  /// No description provided for @sunscreen.
  ///
  /// In en, this message translates to:
  /// **'Sunscreen'**
  String get sunscreen;

  /// No description provided for @additionalInsights.
  ///
  /// In en, this message translates to:
  /// **'Additional insights'**
  String get additionalInsights;

  /// No description provided for @doYouHaveAnyAllergies.
  ///
  /// In en, this message translates to:
  /// **'Do you have any allergies?'**
  String get doYouHaveAnyAllergies;

  /// No description provided for @analyzingFacialSkinCondition.
  ///
  /// In en, this message translates to:
  /// **'analyzing facial skin condition...'**
  String get analyzingFacialSkinCondition;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'Recent'**
  String get recent;

  /// No description provided for @accessToMyLibrary.
  ///
  /// In en, this message translates to:
  /// **'Access to My Library'**
  String get accessToMyLibrary;

  /// No description provided for @currentHealthStatus.
  ///
  /// In en, this message translates to:
  /// **'Current health status'**
  String get currentHealthStatus;

  /// No description provided for @policyAgreement.
  ///
  /// In en, this message translates to:
  /// **'Policy Agreement'**
  String get policyAgreement;

  /// No description provided for @personalDataCollected.
  ///
  /// In en, this message translates to:
  /// **'Personal data (facial skin images, skin condition) is collected to improve analysis results during the skin scanning process. Your information will be deleted upon request.'**
  String get personalDataCollected;

  /// No description provided for @iAgreeToStoreMyPersonalInformation.
  ///
  /// In en, this message translates to:
  /// **'I agree to store my personal information in accordance with '**
  String get iAgreeToStoreMyPersonalInformation;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get confirmDelete;

  /// No description provided for @dataDeletionRequestSent.
  ///
  /// In en, this message translates to:
  /// **'Data Deletion Request Sent!'**
  String get dataDeletionRequestSent;

  /// No description provided for @customerDataDeletedShopLevel.
  ///
  /// In en, this message translates to:
  /// **'The customer\'s data has been successfully deleted at the shop  owner level. A request has been created and sent to Admin SM for  final approval. You will be notified once it\'s processed.'**
  String get customerDataDeletedShopLevel;

  /// No description provided for @personalDataDeletionRequested.
  ///
  /// In en, this message translates to:
  /// **'Personal data (facial skin images, skin condition) will be  requested for deletion, and a confirmation email will be  sent upon completion'**
  String get personalDataDeletionRequested;

  /// No description provided for @deleteCustomerTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Customer?'**
  String get deleteCustomerTitle;

  /// No description provided for @deleteCustomerConfirmation.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. Are you sure you want to delete this customer?'**
  String get deleteCustomerConfirmation;

  /// No description provided for @limitedAccessToPhotos.
  ///
  /// In en, this message translates to:
  /// **'You have limited SkinMatch from accessing your photos.'**
  String get limitedAccessToPhotos;

  /// No description provided for @manage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manage;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, '**
  String get welcomeBack;

  /// No description provided for @haveYouEverUsedOurServiceBefore.
  ///
  /// In en, this message translates to:
  /// **'Have you ever used our service before?'**
  String get haveYouEverUsedOurServiceBefore;

  /// No description provided for @alreadyScanBefore.
  ///
  /// In en, this message translates to:
  /// **'Already scan before'**
  String get alreadyScanBefore;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @keyIngredients.
  ///
  /// In en, this message translates to:
  /// **'Key Ingredients'**
  String get keyIngredients;

  /// No description provided for @howToUse.
  ///
  /// In en, this message translates to:
  /// **'How to use'**
  String get howToUse;

  /// No description provided for @wetYourFace.
  ///
  /// In en, this message translates to:
  /// **'1.Wet your face with lukewarm water.\\n'**
  String get wetYourFace;

  /// No description provided for @applyCleanser.
  ///
  /// In en, this message translates to:
  /// **'2. Apply a small amount of cleanser to your hands.\\n'**
  String get applyCleanser;

  /// No description provided for @massageFace.
  ///
  /// In en, this message translates to:
  /// **'3. Massage gently onto your face in circular motions.\\n'**
  String get massageFace;

  /// No description provided for @rinseFace.
  ///
  /// In en, this message translates to:
  /// **'4. Rinse off with lukewarm water.\\n'**
  String get rinseFace;

  /// No description provided for @patDry.
  ///
  /// In en, this message translates to:
  /// **'5. Pat your face dry with a clean towel'**
  String get patDry;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @skinHealthTitle.
  ///
  /// In en, this message translates to:
  /// **'Skin health'**
  String get skinHealthTitle;

  /// No description provided for @average.
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get average;

  /// No description provided for @darkSpotsInadequateSunProtection.
  ///
  /// In en, this message translates to:
  /// **'Dark spots on the skin caused by inadequate sun protection.'**
  String get darkSpotsInadequateSunProtection;

  /// No description provided for @howDoYouShopForSkincare.
  ///
  /// In en, this message translates to:
  /// **'How do you usually shop for skincare? (Pick the option that best describes you)'**
  String get howDoYouShopForSkincare;

  /// No description provided for @skinTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'Skin type'**
  String get skinTypeTitle;

  /// No description provided for @pleaseSpecificYourAllergies.
  ///
  /// In en, this message translates to:
  /// **'Please specific your allergies'**
  String get pleaseSpecificYourAllergies;

  /// No description provided for @storeForSixMonths.
  ///
  /// In en, this message translates to:
  /// **'Store for 6 months'**
  String get storeForSixMonths;

  /// No description provided for @storeForOneMonths.
  ///
  /// In en, this message translates to:
  /// **'Store for 1 year'**
  String get storeForOneMonths;

  /// No description provided for @storeForTwoMonths.
  ///
  /// In en, this message translates to:
  /// **'Store for 2 years'**
  String get storeForTwoMonths;

  /// No description provided for @doNotStoreMyInformation.
  ///
  /// In en, this message translates to:
  /// **'Do not store my information'**
  String get doNotStoreMyInformation;

  /// No description provided for @customerName.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get customerName;

  /// No description provided for @glycerinHyaluronic.
  ///
  /// In en, this message translates to:
  /// **'Glycerin, Hyaluronic Acid, Chamomile Extract, Green Tea Extract.'**
  String get glycerinHyaluronic;

  /// No description provided for @wrinkles.
  ///
  /// In en, this message translates to:
  /// **'Wrinkles'**
  String get wrinkles;

  /// No description provided for @redness.
  ///
  /// In en, this message translates to:
  /// **'Redness'**
  String get redness;

  /// No description provided for @nodules.
  ///
  /// In en, this message translates to:
  /// **'Nodules'**
  String get nodules;

  /// No description provided for @pustules.
  ///
  /// In en, this message translates to:
  /// **'Pustules'**
  String get pustules;

  /// No description provided for @eyeBags.
  ///
  /// In en, this message translates to:
  /// **'Eye bags'**
  String get eyeBags;

  /// No description provided for @acne.
  ///
  /// In en, this message translates to:
  /// **'Acne'**
  String get acne;

  /// No description provided for @oiliness.
  ///
  /// In en, this message translates to:
  /// **'Oiliness'**
  String get oiliness;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @whatWeCollect.
  ///
  /// In en, this message translates to:
  /// **'1. What We Collect'**
  String get whatWeCollect;

  /// No description provided for @allergy.
  ///
  /// In en, this message translates to:
  /// **'Allergy'**
  String get allergy;

  /// No description provided for @healthStatus.
  ///
  /// In en, this message translates to:
  /// **'Health Status'**
  String get healthStatus;

  /// No description provided for @skinConditions.
  ///
  /// In en, this message translates to:
  /// **'Skin conditions'**
  String get skinConditions;

  /// No description provided for @fromAtoZ.
  ///
  /// In en, this message translates to:
  /// **'From A to Z'**
  String get fromAtoZ;

  /// No description provided for @fromZtoA.
  ///
  /// In en, this message translates to:
  /// **'From Z to A'**
  String get fromZtoA;

  /// No description provided for @totalSpent.
  ///
  /// In en, this message translates to:
  /// **'Total spent'**
  String get totalSpent;

  /// No description provided for @highToLow.
  ///
  /// In en, this message translates to:
  /// **'High to Low'**
  String get highToLow;

  /// No description provided for @lowToHigh.
  ///
  /// In en, this message translates to:
  /// **'Low to High'**
  String get lowToHigh;

  /// No description provided for @lastVisitedDate.
  ///
  /// In en, this message translates to:
  /// **'Last visited date'**
  String get lastVisitedDate;

  /// No description provided for @earliest.
  ///
  /// In en, this message translates to:
  /// **'Earliest'**
  String get earliest;

  /// No description provided for @latest.
  ///
  /// In en, this message translates to:
  /// **'Latest'**
  String get latest;

  /// No description provided for @skinScan.
  ///
  /// In en, this message translates to:
  /// **'Skin scan'**
  String get skinScan;

  /// No description provided for @searchByNameOrdeNumber.
  ///
  /// In en, this message translates to:
  /// **'Search by name, order number,…'**
  String get searchByNameOrdeNumber;

  /// No description provided for @customerList.
  ///
  /// In en, this message translates to:
  /// **'Customer list'**
  String get customerList;

  /// No description provided for @repeatPurchase.
  ///
  /// In en, this message translates to:
  /// **'Repeat Purchase'**
  String get repeatPurchase;

  /// No description provided for @skinProfile.
  ///
  /// In en, this message translates to:
  /// **'Skin Profile'**
  String get skinProfile;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'vi': return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
