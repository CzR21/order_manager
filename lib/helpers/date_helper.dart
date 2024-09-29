class DateHelper {

  static String getAgeGroup(String dateOfBirth){
    DateTime birthDate = DateTime.parse(dateOfBirth);
    DateTime today = DateTime.now();

    int age = today.year - birthDate.year;

    if (today.month < birthDate.month || (today.month == birthDate.month && today.day < birthDate.day)) age--;

    List<int> ageRanges = [20, 30, 40, 50, 60, 70, 80, 90, 100];

    for (int i = 0; i < ageRanges.length; i++) {
      if (age < ageRanges[i]) {
        return i == 0 ? "Até ${ageRanges[i]} anos" : "${ageRanges[i - 1]}-${ageRanges[i]} anos";
      }
    }

    return "Mais de 100 anos";
  }
}