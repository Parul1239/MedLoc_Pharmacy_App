import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_medloc/components/cart_products.dart';
import 'package:flutter_medloc/details.dart';
import 'package:provider/provider.dart';
import 'package:flutter_medloc/components/pdt_item.dart';

import 'cart_products.dart';

class Medicine with ChangeNotifier {
  final String id;
  final String medi_image;
  final String medi_name;
  final double medi_price;
  final String old_price;
  final String ratings;
  final String reviews;
  final String brand;
  final String medi_image1;
  final String desc;
  final String marketer;

  Medicine({
    this.id,
    this.medi_image,
    this.medi_name,
    this.medi_image1,
    this.medi_price,
    this.old_price,
    this.marketer,
    this.desc,
    this.reviews,
    this.ratings,
    this.brand
  });
}


class ExtraMed with ChangeNotifier {
  List <Medicine> med_list = [
    Medicine(
      id: '17',
      medi_image: 'images/m1.jpg',
      medi_name: ' Baby Care Cerelac',
      medi_image1: 'images/t13.jpg',
      medi_price: 257,
      old_price: '320',
      ratings: " 4.6 ",
      reviews: "285 Ratings & 103 Reviews",
      brand: "    Nestle India Ltd",
        marketer: "Nestle India Ltd, "
            "Nestle House, Jacaranda Marg M Block, Phase II, National Highway 8, Gurgaon 122 002, India",
        desc: "Nestle Cerelac Baby Cereal is a complementary food that provides adequate nutrients to the babies of"
            "12 months and above. It is an important source of 17 important nutrients including  vitamins and minerals."
            "It is free from added colors, flavors and preservatives.",

    ),
    Medicine(
      id: '18',
      medi_image: 'images/t10.jpg',
      medi_name: ' Bournvita Drink',
      medi_image1: 'images/t14.jpg',
      medi_price: 390,
      old_price: '410',
      ratings: " 4.5 ",
      reviews: "213 Ratings & 67 Reviews",
      brand: "    Mondelez India Foods Ltd",
      marketer: "Mondelez House, Unit No. 2001, 20th Floor, Tower-3, Indiabulls Finance Centre, Mumbai-400013, India.",
      desc: "Cadbury Bournvita Health Drink is a malted drink mix which contains a unique blend of Vitamin(D, B2, B9, B12) Iron,"
          "and Calcium. It helps in providing essential nutrients and minerals which promote physical and mental development."
          "It makes a nutritious drink with milk and can be consumed as both hot and cold drink."
    ),
    Medicine(
      id: '19',
      medi_image: 'images/t11.webp',
      medi_name: 'Blood Glucose Monitor',
      medi_image1: 'images/t9.jpg',
      medi_price: 650,
      old_price: '706',
      ratings: " 4.0 ",
      reviews: "110 Ratings & 53 Reviews",
      brand: "    Accuchek Ortho Support",
      marketer: "Accuchek Private Ltd, 409, Antrikash Bhawan, 22 Kasturba Gandhi Marg, New Delhi-110 001.",
      desc: "Accu Chek Blood Glucose Monitor measures the concentration of blood glucose by self testing for"
          "both professional and home use. It consists of strips that require only a tiny drop of blood."
          "Testing glucose frequently will allow you to keep your diabetes in control."
    ),
    Medicine(
      id: '20',
      medi_image: 'images/t12.jpg',
      medi_name: ' Dettol Antiseptic',
      medi_image1: 'images/t15.jpg',
      medi_price: 105,
      old_price: '125',
      ratings: " 4.1 ",
      reviews: "4420 Ratings & 1711 Reviews",
      brand: "    Reckitt Benckiser",
      marketer: "Reckitt Benckiser, Plot No. 48, Institutional Area, Sector 32, Gurugram, Haryana 122001",
      desc: "Dettol Antiseptic Disinfectant Liquid for First Aid, Surface Cleaning and Personal Hygiene is used as an "
          "antiseptic agent that prevents the growth of bacteria, fungi and viruses as well. It protects against infection, "
          "prevents bacterial growth and can be used as a normal disinfectant."

    ),
  ];

  List<Medicine> get items {
    return [...med_list];
  }

  Medicine findById(String id) {
    return med_list.firstWhere((pdt) => pdt.id == id);
  }
}

class OtherMed extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final med=Provider.of<ExtraMed>(context);
    final medts = med.items;
    return Padding(padding: const EdgeInsets.only(right: 10.0),
        child: Container(
        height: 206.0,
        width: 240.0,
        child: ListView.builder(
          itemCount: medts.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) => ChangeNotifierProvider.value(
              value: medts[index],
            child: MedItem(
              medi_image: medts[index].medi_image,
              medi_name: medts[index].medi_name,
              medi_price: medts[index].medi_price,
              old_price: medts[index].old_price,
              ratings: medts[index].ratings,
              reviews: medts[index].reviews,
              brand: medts[index].brand,
              medi_image1 : medts[index].medi_image1,
              desc: medts[index].desc,
              marketer: medts[index].marketer,
            )
          ),
        ),
    ));

  }
}

class Product with ChangeNotifier{
  final String id;
  final String med_image;
  final String med_name;
  final double med_price;
  final String old_price;
  final String ratings;
  final String reviews;
  final String brand;
  final String med_image1;
  final String desc;
  final String marketer;

  Product({
    this.id,
    this.med_image,
    this.med_name,
    this.med_price,
    this.old_price,
    this.ratings,
    this.reviews,
    this.brand,
    this.med_image1,
    this.desc,
    this.marketer
  });
}

class Products with ChangeNotifier {
  List <Product> product_list = [
    Product(
        id: "1",
        med_image: 'images/med1.jpg',
        med_image1: 'images/med9.jpeg',
        med_name: ' Paracetamol',
        med_price: 100,
        old_price: '126',
        ratings: " 3.6 ",
        reviews: "562 Ratings & 231 Reviews",
        brand: "    Panadol",
        marketer: "Apple Formulation Private Limited, "
            "Plot No.208, Dehradun Road, NH 73, "
            "Roorkee - 247667, Uttarakhand",
        desc: "Paracetamol (acetaminophen) is a pain reliever and a fever reducer. "
            "Paracetamol is used to treat many conditions such as headache, muscle aches, arthritis, backache, toothaches, colds, and fevers. "
            "It relieves pain in mild arthritis but has no effect on the underlying inflammation and swelling of the joint."
    ),
    Product(
        id: "2",
        med_image: 'images/med2.jpg',
        med_image1: 'images/med10.jpg',
        med_name: ' Bencodryl Syrup',
        med_price: 142,
        old_price: '193',
        ratings: " 4.1 ",
        reviews: "356 Ratings & 120 Reviews",
        brand: "    Benadryl",
        marketer: "Spine Healthcare Pvt. Ltd., "
            "S. C. F. 601, 1st Floor, Motor Market Manimajra, U. T., "
            "Sector 5, Chandigarh - 160101",
        desc: "Benadryl Syrup is used in the treatment of cough. "
            "It relieves allergy symptoms such as runny nose, stuffy nose, sneezing, watery eyes "
            "and congestion or stuffiness. It also thins mucus in the nose, windpipe and lungs, making it easier to cough out."
            "It is not used to relieve cough caused by smoking and asthma."
    ),
    Product(
        id: "3",
        med_image: 'images/med3.jpg',
        med_image1: 'images/med11.jpg',
        med_name: ' Tylenol Pain Relief',
        med_price: 104,
        old_price: '130',
        ratings: " 3.9 ",
        reviews: "259 Ratings & 85 Reviews",
        brand: "    Tylenol Ext",
        marketer: "Seven Star Health Care Private Limited, "
            "Shrushti Avenue Road, Opp Awaz Radio,"
            "Mumbai - 401101, Maharashtra",
        desc: "Tylenol Extra Strength caplets with 500mg of acetaminophen help reduce fever "
            "and provide temporary relief of minor aches and pains. Both a fever reducer and pain reliever, "
            "it relieves minor aches and pains due to headache, backache, toothache, minor pain of arthritis, "
            "the common cold, and premenstrual and menstrual cramps. "
    ),
    Product(
        id: "4",
        med_image: 'images/med4.jpg',
        med_image1: 'images/med12.jpg',
        med_name: ' Moov Pain Relief \n Spray',
        med_price: 110,
        old_price: '135',
        ratings: " 4.3 ",
        reviews: "348 Ratings & 95 Reviews",
        brand: "    Reckitt Benckiser",
        marketer: "Amrit Pharma, Govindpuri, Delhi 663/8, Sector 5, National Highway 8, Delhi - 110019",
        desc: "MOOV Pain Relief Cream is one of India's most popular ointments for fast pain relief "
            "amongst the homemakers. It is an analgesic (or pain relieving) ointment made using 100% ayurvedic "
            "ingredients. Also available in a Spray format that allows easy application. "
    ),
    Product(
        id: "5",
        med_image: 'images/med5.jpeg',
        med_image1: 'images/med13.jpg',
        med_name: ' Johnson Baby \n Products',
        med_price: 385,
        old_price: '400',
        ratings: " 4.0 ",
        reviews: "402 Ratings & 222 Reviews",
        brand: "    Johnson & Johnson",
        marketer: "Jayant Medical And General Stores, Shitala Mata Mandir, Khamla Main Road, Nagpur - 440025, Maharashtra",
        desc: "Johnson’s baby care products are pure, gentle and mild, and hence, "
            "the perfect choice for something as soft and supple as the baby’s skin. "
            "Their entire range of products is created through a nature-friendly process which provides the best results for your little baby."
    ),
    Product(
        id: "6",
        med_image: 'images/med6.jpg',
        med_image1: 'images/med14.jpg',
        med_name: ' Pampers Diaper',
        med_price: 150,
        old_price: '185',
        ratings: " 4.4 ",
        reviews: "423 Ratings & 263 Reviews",
        brand: "    Procter & Gamble",
        marketer: "Deepali Enterprises, School Block, Khamla Main Road, NH 58, Shakarpur, Delhi - 110092",
        desc: "Pampers Baby-Dry pants style diapers are the only pants in India with Ultra Absorb Core, "
            "Double Leak Guards and Lotion with Aloe Vera. Ultra Absorb Core provides your baby a new type "
            "of dryness overnight - breathable dryness. Magic gel locks wetness away to provide up to 12 hours of dryness."
    ),
    Product(
        id: '7',
        med_image: 'images/med7.jpg',
        med_image1: 'images/med15.jpg',
        med_name: ' MamyPoko Pants \n Diaper',
        med_price: 100,
        old_price: '125',
        ratings: " 4.6 ",
        reviews: "310 Ratings & 103 Reviews",
        brand: "    Unicharm",
        marketer: "R K Enterprises, Molarband Village, School Block, Badarpur, New Delhi - 110044, Delhi",
        desc: "MamyPoko pants extra absorb comes with crisscross absorbent sheet which absorbs 7 glasses of urine "
            "and spreads it equally, so there's no fear of heaviness. Its stretchable thigh support prevents gaps "
            "between diaper and baby's thigh, hence prevents leakage."
    ),
    Product(
        id: "8",
        med_image: 'images/med8.jpg',
        med_image1: 'images/med16.jpg',
        med_name: ' Himalaya Baby Care',
        med_price: 450,
        old_price: '500',
        ratings: " 4.1 ",
        reviews: "255 Ratings & 166 Reviews",
        brand: "    Himalaya Wellness",
        marketer: "Nohar Cosmetics, Ganesh Krupa, Sarweshwar Society, Opp. Woodland Showroom, Nashik - 422005, Maharashtra",
        desc: "Himalaya's baby care products are Ayurvedic formulations, "
            "contain 100% pure herbal actives, and conform to the standards of the pharmaceutical industry, "
            "thus making each product effective, mild and soothing to suit and nourish your baby's delicate skin."
    ),

  ];

  List<Product> get items {
    List <Product> filteredProduct = product_list;
    return [...product_list];
  }

  Product findById(String id) {
    return product_list.firstWhere((pdt) => pdt.id == id);
  }
}

class AllProducts extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final productData=Provider.of<Products>(context);
    final pdts = productData.items;
    return GridView.builder(
        itemCount: pdts.length,
        scrollDirection: Axis.vertical,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) => ChangeNotifierProvider.value(
          value: pdts[index],
          child: PdtItem(
            med_image: pdts[index].med_image,
            med_name: pdts[index].med_name,
            med_price: pdts[index].med_price,
            old_price: pdts[index].old_price,
            ratings: pdts[index].ratings,
            reviews: pdts[index].reviews,
            brand: pdts[index].brand,
            med_image1 : pdts[index].med_image1,
            desc: pdts[index].desc,
            marketer: pdts[index].marketer,
          ),
        )
    );
  }
}

class Gadget with ChangeNotifier{
  final String id;
  final String gadget_image;
  final String gadget_name;
  final double gadget_price;
  final String old_price;
  final String ratings;
  final String reviews;
  final String brand;
  final String gadget_image1;
  final String desc;
  final String marketer;

  Gadget({
    this.id,
    this.gadget_image,
    this.gadget_name,
    this.gadget_price,
    this.old_price,
    this.ratings,
    this.reviews,
    this.brand,
    this.gadget_image1,
    this.desc,
    this.marketer
  });
}

class Gadgets with ChangeNotifier {
  List <Gadget> gadget_list = [
    Gadget(
        id: "9",
        gadget_image: 'images/m17.png',
        gadget_image1: 'images/t1.jpg',
        gadget_name: ' Thermometer',
        gadget_price: 1010,
        old_price: '1265',
        ratings: " 4.7 ",
        reviews: "632 Ratings & 281 Reviews",
        brand: "    Sahyog Wellness",
        marketer: "Sahyog Wellness Private Limited, "
            "Plot No.329, Pitampura Road, NH 73, "
            "Roorkee - 247667, Delhi",
        desc: "Sahyog Wellness Non Contact Body & Object Infrared Thermometer is a non-contact thermometer and takes body"
            "temperature and object temperature. It is accurate and reliable. It is used in measuring the fever to keep the "
            "thermometer either in the mouth or in the armpit."
    ),
    Gadget(
        id: "10",
        gadget_image: 'images/m18.jpeg',
        gadget_image1: 'images/t8.jpg',
        gadget_name: ' Body Massager',
        gadget_price: 1150,
        old_price: '1385',
        ratings: " 3.7 ",
        reviews: "440 Ratings & 290 Reviews",
        brand: "    Nureca Inc USA",
        marketer: "Nureca Inc USA Pvt. Ltd., "
            "S. C. F. 601, 1st Floor, Motor Market Manimajra, U. T., "
            "Sector 5, Chandigarh - 160101",
        desc: "Dr Physio Electric Full Body Massager has three massaging heads for deep massages. It can be used"
            "for the neck, back and other body parts. It comes with wave massage,"
            "scraping as well as rolling heads with protective cover. It utilizes shiatsu massage technique to create a sense"
            "of relaxation."
    ),
    Gadget(
        id: "11",
        gadget_image: 'images/m19.jpg',
        gadget_image1: 'images/t7.png',
        gadget_name: ' BP Monitors',
        gadget_price: 1570,
        old_price: '1742',
        ratings: " 4.6 ",
        reviews: "229 Ratings & 115 Reviews",
        brand: "    Morepen Laboratories Ltd",
        marketer: "Morepen Laboratories Private Limited, "
            "Shrushti Avenue Road, Opp Awaz Radio,"
            "Pune - 401101, Maharashtra",
        desc: "Dr Morepen Blood Pressure Monitor is a medical device that incorporates new capabilities,"
            "enabling users to improve the ease and accuracy of blood pressure monitoring and management for "
            "self-care purposes by patients. It measures the blood pressure level of the user."
    ),
    Gadget(
        id: "12",
        gadget_image: 'images/m20.jpg',
        gadget_image1: 'images/t6.webp',
        gadget_name: ' Pulse Oximeter',
        gadget_price: 785,
        old_price: '856',
        ratings: " 4.3 ",
        reviews: "220 Ratings & 85 Reviews",
        brand: "    Prozo Distribution Private Ltd",
        marketer: "Prozo Distribution Private Ltd, Govindpuri, Delhi 663/8, Sector 5, National Highway 8, Delhi - 110019",
        desc: "Prozo Plus Fingertip Pulse Oximeter with OLED Digital Display is used for measuring the pulse oxygen saturation and pulse"
            "rate through finger. The product is suitable for use in family, hospital, oxygen bar, community healthcare,"
            "and physical care in sports. Measures blood oxygen saturation levels and pulse rate in adults. "
    ),
    Gadget(
        id: "13",
        gadget_image: 'images/m21.jpg',
        gadget_image1: 'images/t5.jpg',
        gadget_name: ' Vital Signs Monitor',
        gadget_price: 2685,
        old_price: '2845',
        ratings: " 4.4 ",
        reviews: "501 Ratings & 356 Reviews",
        brand: "    AliveCor",
        marketer: "AliveCor Private Limited, Shitala Mata Mandir, Khamla Main Road, Nagpur - 440025, Maharashtra",
        desc: "AliveCor Vital signs monitor give medical personnel an indication about the patient's condition and enable "
            "them to evaluate treatment options. The measurements usually consist of pulse oximetry, ECG, noninvasive blood "
            "pressure and temperature. Record your ECG in seconds."
    ),
    Gadget(
        id: "14",
        gadget_image: 'images/m22.webp',
        gadget_image1: 'images/t4.webp',
        gadget_name: ' Weighing Scales',
        gadget_price: 1750,
        old_price: '1820',
        ratings: " 3.9 ",
        reviews: "445 Ratings & 256 Reviews",
        brand: "    Omron Healthcare India Pvt Ltd",
        marketer: "Omron HealthCare India Pvt Ltd, School Block, Khamla Main Road, NH 58, Shakarpur, Delhi - 110092",
        desc: "Omron Digital Weighing Scale provides an easy to use and accurate way to measure and record your body weight."
            "This device calculates and records how your body is changing, ensuring your don't lose body muscle when you're trying"
            "to lose body fat. Automatic ON/OFF Function. 4 sensor technology."
    ),
    Gadget(
        id: '15',
        gadget_image: 'images/m23.webp',
        gadget_image1: 'images/t3.jpg',
        gadget_name: ' Flamingo Knee Cap',
        gadget_price: 490,
        old_price: '580',
        ratings: " 3.6 ",
        reviews: "290 Ratings & 163 Reviews",
        brand: "    Ascent Meditech Limited",
        marketer: "Ascent Meditech Limited, Molarband Village, School Block, Badarpur, New Delhi - 110044, Delhi",
        desc: "Flamingo Knee Cap is a splendid product to provide excellent support and warmth to the knee. To support for weak knee"
            "arthritic conditions and supports injury. It provides therapeutic warmth and adequate compression. Better sweat absorption"
            "with no rashes and allergy. "
    ),
    Gadget(
        id: "16",
        gadget_image: 'images/m24.jpg',
        gadget_image1: 'images/t2.jpg',
        gadget_name: ' Stethoscope',
        gadget_price: 360,
        old_price: '425',
        ratings: " 4.6 ",
        reviews: "465 Ratings & 256 Reviews",
        brand: "    Morepen Laboratories Ltd",
        marketer: "Morepen Laboratories Ltd, Ganesh Krupa, Opp. Woodland Showroom, Mumbai - 422005, Maharashtra",
        desc: "Dr Morepen Stethoscope is an acoustic medical device for auscultation or listening to the internal sounds or heart beats"
            "of human body. It is used to listen the heart beats and monitor the pulse of the body. It is compact with dual frequency and has"
            "seamless PVC tubing. It has soft ear knobs with best sound quality."
    ),

  ];

  List<Gadget> get items {
    return [...gadget_list];
  }

  Gadget findById(String id) {
    return gadget_list.firstWhere((gdt) => gdt.id == id);
  }
}
class AllGadgets extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final productData=Provider.of<Gadgets>(context);
    final pdts = productData.items;
    return GridView.builder(
        itemCount: pdts.length,
        scrollDirection: Axis.vertical,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (BuildContext context, int index) => ChangeNotifierProvider.value(
          value: pdts[index],
          child: GadgetItem(
            gadget_image: pdts[index].gadget_image,
            gadget_name: pdts[index].gadget_name,
            gadget_price: pdts[index].gadget_price,
            old_price: pdts[index].old_price,
            ratings: pdts[index].ratings,
            reviews: pdts[index].reviews,
            brand: pdts[index].brand,
            gadget_image1 : pdts[index].gadget_image1,
            desc: pdts[index].desc,
            marketer: pdts[index].marketer,
          ),
        )
    );
  }
}

class MyColors {
  static const grey = Color(0xfff3f3f3),
      orange = Color(0xffffb755),
      red = Color(0xffed5568),
      lightGreen = Color(0xffdbf3e8),
      darkGreen = Color(0xff4ac18e),
      blue = Color(0xff40beee);
}


Future navigateToDetailsScreen(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage()));
}

Future navigateToCartScreen(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Pay()));
}

