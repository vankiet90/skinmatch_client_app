import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerModel {
  final String? name;
  final String? avatar;
  final String? badge;
  final double? totalSpent;
  final String? scanCount;
  final DateTime? lastVisited;
  final String? servedBy;
  final Color? badgeColor;
  final Color? badgeTextColor;
  final String? phoneNumber;
  final String? email;
  final String? gender;
  final String? dob;

  CustomerModel({
    this.name,
    this.avatar,
    this.badge,
    this.totalSpent,
    this.scanCount,
    this.lastVisited,
    this.servedBy,
    this.badgeColor,
    this.badgeTextColor,
    this.phoneNumber,
    this.email,
    this.gender,
    this.dob,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    String? totalSpentStr = json["totalSpent"];
    double? totalSpentDouble;
    if (totalSpentStr != null) {
      totalSpentStr = totalSpentStr.replaceAll(RegExp(r'[\$,]'), '');
      totalSpentDouble = double.tryParse(totalSpentStr);
    }

    DateTime? lastVisitedDate;
    if (json["lastVisited"] != null) {
      try {
        lastVisitedDate = DateFormat('dd/MM/yyyy').parse(json["lastVisited"]);
      } catch (_) {}
    }

    return CustomerModel(
      name: json["name"],
      avatar: json["avatar"],
      badge: json["badge"],
      totalSpent: totalSpentDouble,
      scanCount: json["scanCount"],
      lastVisited: lastVisitedDate,
      servedBy: json["servedBy"],
      badgeColor: json["badgeColor"],
      badgeTextColor: json["badgeTextColor"],
      phoneNumber: json["phone_number"],
      email: json["email"],
      gender: json["gender"],
      dob: json["dob"],
    );
  }
}
