class PatientModel {
  final String name;
  final String age;
  final String height;
  final String weight;
  final String gender;
  final String email;
  final String phone;
  final String profileImageUrl;
  final List recordCids;

  PatientModel(this.name, this.age, this.height, this.weight, this.gender,
      this.email, this.phone, this.profileImageUrl, this.recordCids);
}
