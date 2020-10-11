import "package:hinergi_kwh/service/apiKey.dart";

class GetPrice {
  String getPriceKwh(double dataKwh) {
    double kwhPrice = dataVariable().kwhPrice;

    double abonemenkwh = kwhPrice * dataKwh;

    return "Rp. " + abonemenkwh.toStringAsFixed(0);
  }
}
