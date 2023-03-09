import 'package:flutter/material.dart';
import 'package:techie_twins/constants.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function onPress;
  const DefaultButton({
    super.key,
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class DefaultButtonWhite extends StatelessWidget {
  final String text;
  final Function onPress;
  const DefaultButtonWhite({
    super.key,
    required this.text,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(fontSize: 25, color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class WalletAddressTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  const WalletAddressTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
      obscureText: true,
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
