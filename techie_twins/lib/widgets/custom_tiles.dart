import 'package:flutter/material.dart';
import 'package:techie_twins/constants.dart';

class DoctorTileBlue extends StatelessWidget {
  const DoctorTileBlue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width / 2.2,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Feeling lucky",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "I'm proud of how far I've come in my health journey",
              style:
                  TextStyle(color: Colors.white.withOpacity(.5), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorTileRed extends StatelessWidget {
  const DoctorTileRed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height / 6,
        width: MediaQuery.of(context).size.width / 2.2,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Need a opinion",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "We will help you find the best care",
              style:
                  TextStyle(color: Colors.white.withOpacity(.5), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class ConsultantTile extends StatelessWidget {
  final String name, designation, exp, stars, imageUrl;
  final VoidCallback onTap;
  const ConsultantTile({
    super.key,
    required this.name,
    required this.designation,
    required this.exp,
    required this.stars,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 5.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              color: consultantTileColor),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(imageUrl),
                    onBackgroundImageError: (exception, stackTrace) {},
                  ),
                  title: Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(designation),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(Icons.access_time),
                    const SizedBox(
                      width: 5,
                    ),
                    Text("$exp Years"),
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(Icons.star_rate_rounded),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(stars)
                  ],
                )
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.only(top: 15, right: 15),
              height: MediaQuery.of(context).size.height / 7,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  color: consultantTileButtonColor),
              child: const RotatedBox(
                quarterTurns: -1,
                child: Center(
                  child: Text(
                    "Consult",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PatientTreatedInfoTile extends StatelessWidget {
  final String patients;
  const PatientTreatedInfoTile({
    super.key,
    required this.patients,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Patients",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            Text(
              "$patients +",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white),
            ),
            const Text(
              "treated",
              style: TextStyle(fontSize: 22, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class ExpInfoTile extends StatelessWidget {
  final String years;
  const ExpInfoTile({
    super.key,
    required this.years,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Exp",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            Text(
              "$years +",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white),
            ),
            const Text(
              "years",
              style: TextStyle(fontSize: 22, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class RatingInfoTile extends StatelessWidget {
  final String stars;
  const RatingInfoTile({
    super.key,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Rating",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            Text(
              stars,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white),
            ),
            const Text(
              "stars",
              style: TextStyle(fontSize: 22, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

class LabReportGeneratedInfoTile extends StatelessWidget {
  final String reports;
  const LabReportGeneratedInfoTile({
    super.key,
    required this.reports,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(22)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Reports",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
            Text(
              "$reports +",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white),
            ),
            const Text(
              "generated",
              style: TextStyle(fontSize: 22, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
