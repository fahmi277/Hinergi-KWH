import "package:hinergi_kwh/service/apiKey.dart";

class GetPrice {
  String getPriceKwh(double dataKwh , double kwhPrice) {
    // double kwhPrice = dataVariable().kwhPrice;

    double abonemenkwh = kwhPrice * dataKwh;

    return "Rp. " + abonemenkwh.toStringAsFixed(0);
  }

  double getKwhPerBudget(double budget, double kwhPrice) {
    return budget/kwhPrice;
  }
}
