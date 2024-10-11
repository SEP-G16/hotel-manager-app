import 'package:hotel_manager/exception/gender_not_found_exception.dart';

enum Gender{
  Male, Female;

  static Gender getGenderFromName(String name) {
    switch (name) {
      case 'Male':
        return Gender.Male;
      case 'Female':
        return Gender.Female;
      default:
        throw GenderNotFoundException('Unable to identify gender : $name');
    }
  }
}

extension GenderExtension on Gender{
  String getGenderAsString() {
    return this.toString().split('.').last;
  }
}