import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hotel_manager/models/support_ticket.dart';
import 'package:intl/intl.dart';

import '../constants/colour_constants.dart';
import '../constants/svg_constants.dart';
import '../constants/text_constants.dart';
import 'input_field.dart';

class MessageTile extends StatelessWidget {
  MessageTile({required this.ticket, this.onSendTap, required this.onChanged});

  SupportTicket ticket;
  FutureOr<void> Function()? onSendTap;
  void Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin:
      EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
        color: ColourConstants.orchidAccent,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(
                0, 3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.string(
                SvgConstants.customerReviewAvatarImage,
                height: 60,
                // height: 60,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      ticket.name,
                      overflow: TextOverflow.visible,
                      style: TextConstants.subTextStyle(
                          fontSize: 24),
                    ),
                    Text(
                      DateFormat('yyyy-MM-dd')
                          .format(ticket.createdAt),
                      style: TextConstants.subTextStyle(
                          fontSize: 19),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  'Message : ',
                  style: TextConstants.subTextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    ticket.description,
                    overflow: TextOverflow.visible,
                    style: TextConstants.subTextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              Expanded(
                child: InputField(
                  labelText: 'Type Message Here',
                  onChanged: onChanged,
                ),
              ),
              GestureDetector(
                onTap: onSendTap,
                child: Container(
                  margin:
                  EdgeInsets.only(left: 20, right: 5),
                  child: Icon(
                    Icons.send,
                    color: ColourConstants.richBlack,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
