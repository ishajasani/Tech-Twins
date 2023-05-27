import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:techie_twins/config/walletservice.dart';
import 'package:web3dart/web3dart.dart';

import '../../../config/contract_linking/doctor_contract_linking.dart';
import '../../../config/contract_linking/patient_contract_linking.dart';
import '../../../widgets/custom_textfields.dart';

class DateTimePickerPage extends StatefulWidget {
  final EthereumAddress docAddress;
  const DateTimePickerPage({super.key, required this.docAddress});

  @override
  State<DateTimePickerPage> createState() => _DateTimePickerPageState();
}

class _DateTimePickerPageState extends State<DateTimePickerPage> {
  String dateTime = '';
  getCustomFormattedDateTime(String givenDateTime) {
    final DateTime docDateTime = DateTime.parse(givenDateTime);
    return docDateTime.millisecondsSinceEpoch;
  }

  @override
  void initState() {
    getPatientAddress();
    super.initState();
  }

  PatientContractLinking patientContractLinking = PatientContractLinking();
  DoctorContractLinking contractLinking = DoctorContractLinking();
  EthereumAddress? patientAddress;
  WalletService walletService = WalletService();
  getPatientAddress() async {
    String privateKey = await walletService.getPrivateKey();
    setState(() {
      patientAddress = EthPrivateKey.fromHex(privateKey).address;
    });
    if (kDebugMode) {
      print(patientAddress);
    }
  }

  TextEditingController controller = TextEditingController();
  void setAppointment() {
    int dateTimeInMilliSeconds = 0;
    setState(() {
      dateTimeInMilliSeconds = getCustomFormattedDateTime(dateTime);
    });
    contractLinking
        .bookAppointmentFunction(BigInt.from(dateTimeInMilliSeconds),
            widget.docAddress, patientAddress!, controller.text)
        .then((value) {
      patientContractLinking.addMyAppointment(
          BigInt.from(dateTimeInMilliSeconds),
          widget.docAddress,
          patientAddress!,
          controller.text);
      // ignore: avoid_print
    }).then((value) => print(value));

    Navigator.pop(context);
    Fluttertoast.showToast(msg: "Appointment Booked");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Text(
                "schedule a meeting",
                style: TextStyle(
                    height: 1,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 10),
              )),
          const SizedBox(
            height: 20,
          ),
          DateTimePicker(
            type: DateTimePickerType.dateTime,
            initialTime: TimeOfDay.now(),
            dateMask: 'd MMMM, yyyy - hh:mm a',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
            icon: const Icon(Icons.event),
            dateLabelText: 'Date Time',
            timeLabelText: "Hour",
            onChanged: (val) {
              setState(() {
                dateTime = val;
              });
            },
            onSaved: (val) {
              setState(() {
                dateTime = val!;
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          GenderField(
              controller: controller,
              hintText: "https://meet.google.com/wer-wer-wer",
              labelText: "Metting Link"),
          const Spacer(),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Cancel",
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width / 20),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (controller.text.isEmpty) {
                Fluttertoast.showToast(msg: "Enter the meeting link");
              } else {
                setAppointment();
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xff1D3092).withOpacity(.49),
                  borderRadius: BorderRadius.circular(30)),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
                child: Text(
                  "Confirm",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width / 20),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
