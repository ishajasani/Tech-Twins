import 'package:flutter/material.dart';

class PrivateKeyField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  const PrivateKeyField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.white.withOpacity(.5)),
        hintText: hintText,
        prefixIcon: Icon(
          Icons.wallet,
          color: Colors.white.withOpacity(.5),
        ),
        hintStyle: TextStyle(color: Colors.white.withOpacity(.5)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class WalletPinTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  const WalletPinTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.white.withOpacity(.5)),
        hintText: hintText,
        prefixIcon: Icon(
          Icons.password_outlined,
          color: Colors.white.withOpacity(.5),
        ),
        hintStyle: TextStyle(color: Colors.white.withOpacity(.5)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class NameField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  const NameField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        hintText: hintText,
        prefixIcon: Icon(
          Icons.person_2_outlined,
          color: Colors.black.withOpacity(.5),
        ),
        hintStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class WeightField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  const WeightField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        hintText: hintText,
        prefixIcon: Icon(
          Icons.line_weight_rounded,
          color: Colors.black.withOpacity(.5),
        ),
        hintStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class HeightField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  const HeightField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        hintText: hintText,
        prefixIcon: Icon(
          Icons.height_outlined,
          color: Colors.black.withOpacity(.5),
        ),
        hintStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class BloodField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  const BloodField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        hintText: hintText,
        prefixIcon: Icon(
          Icons.bloodtype_outlined,
          color: Colors.black.withOpacity(.5),
        ),
        hintStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class AgeField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  const AgeField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        hintText: hintText,
        prefixIcon: Icon(
          Icons.numbers,
          color: Colors.black.withOpacity(.5),
        ),
        hintStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class GenderField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  const GenderField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        hintText: hintText,
        prefixIcon: Icon(
          Icons.person_3,
          color: Colors.black.withOpacity(.5),
        ),
        hintStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  const EmailField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        hintText: hintText,
        prefixIcon: Icon(
          Icons.email_outlined,
          color: Colors.black.withOpacity(.5),
        ),
        hintStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}


class PhoneField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  const PhoneField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        label: Text(labelText),
        labelStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        hintText: hintText,
        prefixIcon: Icon(
          Icons.phone,
          color: Colors.black.withOpacity(.5),
        ),
        hintStyle: TextStyle(color: Colors.black.withOpacity(.5)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

