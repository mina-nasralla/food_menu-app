// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'قائمة الطعام';

  @override
  String get home => 'الرئيسية';

  @override
  String get cart => 'السلة';

  @override
  String get language => 'اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get quantity => 'الكمية';

  @override
  String get spiceLevel => 'مستوى التوابل';

  @override
  String get addOns => 'الإضافات';

  @override
  String get recommendedAddons => 'إضافات مقترحة';

  @override
  String get specialInstructions => 'تعليمات خاصة';

  @override
  String get specialInstructionsHint =>
      'أضف ملاحظات للمطبخ (بدون مخلل، الصوص على الجانب، إلخ.)';

  @override
  String get applyTo => 'تطبيق على:';

  @override
  String get ofPreposition => 'من';

  @override
  String get total => 'الإجمالي';

  @override
  String get item => 'عنصر';

  @override
  String get items => 'عناصر';

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String addedToCart(int count, String itemText) {
    return 'تمت إضافة $count $itemText إلى السلة!';
  }

  @override
  String get preparationTime => 'دقيقة';

  @override
  String get searchHint => 'بحث';

  @override
  String get searchPlaceholder => 'بحث...';

  @override
  String get noAddonsFound => 'لم يتم العثور على إضافات';

  @override
  String get homeNav => 'الرئيسية';

  @override
  String get bestSellers => 'الأكثر مبيعاً';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get categories => 'التصنيفات';

  @override
  String get browseAll => 'تصفح الكل';

  @override
  String get categoryItems => 'عناصر التصنيف';

  @override
  String get switchToList => 'التبديل إلى القائمة';

  @override
  String get switchToGrid => 'التبديل إلى الشبكة';

  @override
  String get todaysOffers => 'عروض اليوم';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get limitedTime => 'لفترة محدودة';

  @override
  String get order => 'اطلب';

  @override
  String get burgers => 'برجر';

  @override
  String get pizza => 'بيتزا';

  @override
  String get drinks => 'مشروبات';

  @override
  String get desserts => 'حلويات';

  @override
  String get offerTitle => 'خصم يصل إلى 40% على\nالبرجر';

  @override
  String get offerSubtitle =>
      'اطلب 2 واحصل على بطاطس مجانية مع\nمجموعات مختارة.';

  @override
  String get burger1Name => 'برجر مزدوج كلاسيكي';

  @override
  String get burger1Desc => 'شريحة لحم بقري، شيدر، خس، طماطم وصوص خاص.';

  @override
  String get burger2Name => 'برجر دجاج حار';

  @override
  String get burger2Desc =>
      'دجاج مقرمش، هلابينو، جبنة بيبر جاك ومايونيز شيبوتلي.';

  @override
  String get burger3Name => 'فيجي ديلايت';

  @override
  String get burger3Desc => 'شريحة نباتية، خس، طماطم، مخلل وصوص خاص.';

  @override
  String get addonCheese => 'شيدر إضافي';

  @override
  String get addonCheeseDesc => 'أضف شريحة إضافية من الجبن';

  @override
  String get addonBacon => 'بيكون';

  @override
  String get addonBaconDesc => 'شرائح بيكون مقرمشة مدخنة';

  @override
  String get addonCombo => 'ترقية إلى كومبو';

  @override
  String get addonComboDesc => 'بطاطس + مشروب غازي';

  @override
  String get addonAvocado => 'أفوكادو';

  @override
  String get addonAvocadoDesc => 'شرائح أفوكادو طازجة';

  @override
  String get addonMushrooms => 'فطر مشوي';

  @override
  String get addonMushroomsDesc => 'فطر بورتوبيلو سوتيه';

  @override
  String get checkoutComingSoon => 'وظيفة الدفع قريباً!';

  @override
  String get cartEmpty => 'سلتك فارغة';

  @override
  String get addItemsToStart => 'أضف عناصر للبدء';

  @override
  String get continueShopping => 'متابعة التسوق';

  @override
  String get each => 'للقطعة';

  @override
  String get summary => 'الملخص';

  @override
  String get subtotal => 'المجموع الفرعي';

  @override
  String get deliveryFee => 'رسوم التوصيل';

  @override
  String get serviceFee => 'رسوم الخدمة';

  @override
  String get checkout => 'الدفع';

  @override
  String get editOrder => 'تعديل الطلب';

  @override
  String get quantityLabel => 'الكمية';

  @override
  String get selectAddonsHint =>
      'حدد عدد العناصر التي يجب أن تحتوي على كل إضافة';

  @override
  String get checkoutTitle => 'إتمام الطلب';

  @override
  String get deliveryInfo => 'معلومات التوصيل';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get fullNameHint => 'أدخل اسمك الكامل';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get phoneNumberHint => 'أدخل رقم هاتفك';

  @override
  String get address => 'عنوان التوصيل';

  @override
  String get addressHint => 'أدخل عنوان التوصيل';

  @override
  String get deliveryNotes => 'ملاحظات التوصيل (اختياري)';

  @override
  String get deliveryNotesHint => 'أضف أي تعليمات خاصة بالتوصيل';

  @override
  String get confirmOrder => 'تأكيد الطلب';

  @override
  String get orderSummary => 'ملخص الطلب';

  @override
  String get orderConfirmation => 'تأكيد الطلب';

  @override
  String get confirmAndPay => 'تأكيد وإرسال الطلب';

  @override
  String get orderSuccess => 'تم تقديم الطلب بنجاح!';

  @override
  String get orderSuccessMessage => 'تم تقديم طلبك وسيتم توصيله قريباً.';

  @override
  String get orderNumber => 'رقم الطلب';

  @override
  String get backToHome => 'العودة للرئيسية';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get invalidPhone => 'الرجاء إدخال رقم هاتف صحيح';

  @override
  String get reviewOrder => 'مراجعة طلبك';

  @override
  String get customerInfo => 'معلومات العميل';

  @override
  String get cancel => 'إلغاء';

  @override
  String itemsCount(int count) {
    return '$count عناصر';
  }

  @override
  String get ordersNav => 'الطلبات';

  @override
  String get menuNav => 'القائمة';

  @override
  String get statsNav => 'الإحصائيات';

  @override
  String get profileNav => 'الملف الشخصي';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get accepted => 'مقبول';

  @override
  String get preparing => 'قيد التحضير';

  @override
  String get ready => 'جاهز';

  @override
  String get completed => 'مكتمل';

  @override
  String get acceptOrder => 'قبول الطلب';

  @override
  String get reject => 'رفض';

  @override
  String get markAsReady => 'تحديد كجاهز';

  @override
  String get complete => 'إكمال';

  @override
  String get noOrders => 'لا توجد طلبات بعد';

  @override
  String get itemsTab => 'العناصر';

  @override
  String get addonsTab => 'الإضافات';

  @override
  String get offersTab => 'العروض';

  @override
  String get createBanner => 'إنشاء بانر';

  @override
  String get editOffer => 'تعديل العرض';

  @override
  String get headline => 'العنوان الرئيسي';

  @override
  String get subtitleDescription => 'العنوان الفرعي/الوصف';

  @override
  String get priceIfApplicable => 'السعر (إن وجد)';

  @override
  String get imageUrl => 'رابط الصورة';

  @override
  String get selectedItems => 'العناصر المحددة';

  @override
  String get selectedAddons => 'الإضافات المحددة';

  @override
  String get estimatedValue => 'القيمة المقدرة';

  @override
  String get useEstimated => 'استخدام المقدر';

  @override
  String get finalPrice => 'السعر النهائي';

  @override
  String get pricing => 'التسعير';

  @override
  String get header => 'الرأسية';

  @override
  String get visuals => 'المرئيات';

  @override
  String get includedItems => 'العناصر المضمنة';

  @override
  String get active => 'نشط';

  @override
  String get inactive => 'غير نشط';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get save => 'حفظ';

  @override
  String get create => 'إنشاء';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get addItem => 'إضافة عنصر';

  @override
  String get itemName => 'اسم العنصر';

  @override
  String get description => 'الوصف';

  @override
  String get price => 'السعر';

  @override
  String get category => 'التصنيف';

  @override
  String get availableAddons => 'الإضافات المتاحة';

  @override
  String get addAddon => 'إضافة إضافة';

  @override
  String get addonName => 'اسم الإضافة';

  @override
  String get totalOrders => 'إجمالي الطلبات';

  @override
  String get revenue => 'الإيرادات';

  @override
  String get activeOffers => 'العروض النشطة';

  @override
  String get menuItems => 'عناصر القائمة';

  @override
  String get myRestaurant => 'مطعمي';

  @override
  String get location => 'الموقع';

  @override
  String get phone => 'الهاتف';

  @override
  String get website => 'الموقع الإلكتروني';

  @override
  String get facebook => 'فيسبوك';

  @override
  String get whatsapp => 'واتساب';

  @override
  String get totalVisitors => 'إجمالي الزوار';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get chiefLogin => 'تسجيل دخول الشيف';

  @override
  String get welcomeBack => 'مرحباً بعودتك!';

  @override
  String get loginToManage => 'سجل الدخول لإدارة مطعمك';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get register => 'تسجيل';

  @override
  String get pleaseEnterEmail => 'الرجاء إدخال بريدك الإلكتروني';

  @override
  String get pleaseEnterValidEmail => 'الرجاء إدخال بريد إلكتروني صحيح';

  @override
  String get pleaseEnterPassword => 'الرجاء إدخال كلمة المرور';

  @override
  String get useEst => 'استخدام المقدر';

  @override
  String get acceptingOrders => 'يتم استقبال الطلبات';

  @override
  String get notAcceptingOrders => 'لا يتم استقبال طلبات';

  @override
  String get ordersOn => 'استقبال مفعل';

  @override
  String get ordersOff => 'استقبال متوقف';

  @override
  String get workingHours => 'ساعات العمل';

  @override
  String get day => 'اليوم';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get operationalStatus => 'الحالة التشغيلية';

  @override
  String get open => 'مفتوح';

  @override
  String get closed => 'مغلق';

  @override
  String get theme => 'المظهر';

  @override
  String get dark => 'داكن';

  @override
  String get light => 'فاتح';

  @override
  String get statistics => 'الإحصائيات';

  @override
  String get totalSales => 'إجمالي المبيعات';

  @override
  String get visitors => 'الزوار';

  @override
  String get avgOrder => 'متوسط الطلب';

  @override
  String get yourSubscription => 'اشتراكك';

  @override
  String get basicPlan => 'الخطة الأساسية';

  @override
  String get activeStatus => 'نشط';

  @override
  String expiresOn(Object date) {
    return 'تنتهي في $date';
  }

  @override
  String get availablePlans => 'الخطط المتاحة';

  @override
  String get proPlan => 'الخطة الاحترافية';

  @override
  String get enterprisePlan => 'خطة المؤسسات';

  @override
  String get unlimitedItems => 'عناصر غير محدودة، دعم أولوية';

  @override
  String get customPlanDesc => 'مدير مخصص، توسع';

  @override
  String get newOrder => 'جديد';

  @override
  String get inProgress => 'قيد التنفيذ';

  @override
  String get doneStatus => 'تم الحجز';

  @override
  String get details => 'التفاصيل';

  @override
  String orderDetails(Object id) {
    return 'تفاصيل الطلب #$id';
  }

  @override
  String get itemsLabel => 'العناصر:';

  @override
  String get orderAccepted => 'تم قبول الطلب';

  @override
  String get viewDetails => 'عرض التفاصيل';

  @override
  String get noOrdersFound => 'لم يتم العثور على طلبات';

  @override
  String get editItem => 'تعديل العنصر';

  @override
  String get addNewItem => 'إضافة عنصر جديد';

  @override
  String get selectAddons => 'اختر الإضافات:';

  @override
  String get editAddon => 'تعديل الإضافة';

  @override
  String get addNewAddon => 'إضافة إضافة جديدة';

  @override
  String get menuManagement => 'إدارة القائمة';

  @override
  String get acceptingOrdersDesc => 'يتم استقبال وخدمة الطلبات حالياً.';

  @override
  String get notAcceptingOrdersDesc => 'المتجر مغلق حالياً أمام الجمهور.';

  @override
  String get updateProfile => 'تعديل الملف الشخصي';

  @override
  String get cuisineType => 'نوع المطبخ';

  @override
  String get facebookUrl => 'رابط فيسبوك';

  @override
  String get whatsappNumber => 'رقم واتساب';

  @override
  String get update => 'تحديث';

  @override
  String get monday => 'الإثنين';

  @override
  String get tuesday => 'الثلاثاء';

  @override
  String get wednesday => 'الأربعاء';

  @override
  String get thursday => 'الخميس';

  @override
  String get friday => 'الجمعة';

  @override
  String get saturday => 'السبت';

  @override
  String get sunday => 'الأحد';

  @override
  String get updateLogo => 'تحديث الشعار';

  @override
  String get updateBanner => 'تحديث الغلاف';

  @override
  String get editWorkingHours => 'تعديل ساعات العمل';

  @override
  String get openingTime => 'وقت الفتح';

  @override
  String get closingTime => 'وقت الإغلاق';

  @override
  String get isClosed => 'مغلق';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get directions => 'الاتجاهات';

  @override
  String get call => 'اتصال';

  @override
  String get deliveryTimeValue => '20-30 دقيقة';

  @override
  String get deliveryLabel => 'التوصيل';

  @override
  String get addressLabel => 'العنوان';

  @override
  String get error => 'خطأ';

  @override
  String get selectOnMap => 'حدد على الخريطة';

  @override
  String get chooseLocationVisually => 'اختر الموقع بصريًا';

  @override
  String get typeAddress => 'أدخل العنوان';

  @override
  String get enterAddressManually => 'أدخل العنوان يدوياً';

  @override
  String get confirm => 'تأكيد';

  @override
  String get name => 'الاسم';

  @override
  String get nameHint => 'أدخل اسمك';
}
