class HotelListData {
  HotelListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.subTxt = "",
    this.dist = "10:30",
    this.reviews = 80,
    this.rating = 4.5,
    this.perNight = "Vacant",
  });

  String imagePath;
  String titleTxt;
  String subTxt;
  String dist;
  double rating;
  int reviews;
  String perNight;

  static List<HotelListData> hotelList = <HotelListData>[
    HotelListData(
      imagePath: 'assets/hotel/hotel_1.png',
      titleTxt: 'F43',
      subTxt: 'Free',
      dist: "10:30",
      reviews: 80,
      rating: 4.4,
      perNight: "Vacant",
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_1.png',
      titleTxt: 'F44',
      subTxt: 'CSCI311',
      dist: "10:30",
      reviews: 80,
      rating: 4.4,
      perNight: "Occupied",
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_1.png',
      titleTxt: 'F46',
      subTxt: 'Free',
      dist: "10:30",
      reviews: 80,
      rating: 4.4,
      perNight: "Vacant",
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_1.png',
      titleTxt: 'F51',
      subTxt: 'CSCI301',
      dist: "10:30",
      reviews: 80,
      rating: 4.4,
      perNight: "Occupied",
    ),
    HotelListData(
      imagePath: 'assets/hotel/hotel_1.png',
      titleTxt: 'F52',
      subTxt: 'CSCI313',
      dist: "10:30",
      reviews: 80,
      rating: 4.4,
      perNight: "Occupied",
    ),
  ];
}
