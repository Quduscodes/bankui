import 'package:bankui/constants/color_constant.dart';
import 'package:bankui/models/card_model.dart';
import 'package:bankui/models/operation_model.dart';
import 'package:bankui/models/transaction_model.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String customerName = 'Amanda Alex';

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 8.0),
          child: ListView(
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          print('drawer tapped');
                        },
                        child: SvgPicture.asset('assets/svg/drawer_icon.svg')),
                    Container(
                      height: 60.0,
                      width: 60.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              image: AssetImage('assets/images/user_image.png'))),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25.0),
              Padding(
                padding: EdgeInsets.only(left: 16.0, bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(greeting(),
                        style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: kWhiteColor)),
                    Text(customerName,
                        style: GoogleFonts.inter(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: kWhiteColor))
                  ],
                ),
              ),
              Container(
                height: 199,
                child: ListView.builder(
                    padding: EdgeInsets.only(left: 16.0, right: 6.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(right: 10),
                        height: 199,
                        width: 344,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          color: Color(cards[index].cardBackground),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                                child: SvgPicture.asset(
                                    cards[index].cardElementTop)),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: SvgPicture.asset(
                                    cards[index].cardElementBottom)),
                            Positioned(
                                left: 29,
                                top: 48,
                                child: Text('CARD NUMBER',
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: kWhiteColor))),
                            Positioned(
                                left: 29,
                                top: 65,
                                child: Text(cards[index].cardNumber,
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: kWhiteColor))),
                            Positioned(
                                right: 21,
                                top: 35,
                                child: Image.asset(
                                  cards[index].cardType,
                                  width: 28,
                                  height: 28,
                                )),
                            Positioned(
                                left: 29,
                                bottom: 45,
                                child: Text('Card Holder Name',
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: kWhiteColor))),
                            Positioned(
                                left: 29,
                                bottom: 21,
                                child: Text(cards[index].user,
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: kWhiteColor))),
                            Positioned(
                                left: 202,
                                bottom: 45,
                                child: Text('Expiry Date',
                                    style: GoogleFonts.inter(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: kWhiteColor))),
                            Positioned(
                                left: 202,
                                bottom: 21,
                                child: Text(cards[index].cardExpired,
                                    style: GoogleFonts.inter(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: kWhiteColor))),
                          ],
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16.0, bottom: 13.0, top: 29.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Operations',
                      style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: kWhiteColor),
                    ),
                    DotsIndicator(
                      dotsCount: datas.length,
                      position: _current.toDouble(),
                      decorator: DotsDecorator(
                          size: Size.square(9.0),
                          activeSize: Size(18.0, 9.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                          activeColor: kBlueColor,
                          color: kTwentyBlueColor),
                    )
                  ],
                ),
              ),
              Container(
                height: 123.0,
                child: ListView.builder(
                    padding: EdgeInsets.only(left: 16.0),
                    itemCount: datas.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _current = index;
                          });
                        },
                        child: OperationCard(
                          operation: datas[index].name,
                          selectedIcon: datas[index].selectedIcon,
                          unSelectedIcon: datas[index].unselectedIcon,
                          isSelected: _current == index,
                          context: this,
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16.0, bottom: 13.0, top: 29.0, right: 10.0),
                child: Text(
                  'Transaction Histories',
                  style: GoogleFonts.inter(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: kWhiteColor),
                ),
              ),
              ListView.builder(
                  itemCount: transactions.length,
                  padding: EdgeInsets.only(left: 16,right: 16),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 76.0,
                      margin: EdgeInsets.only(bottom: 13),
                      padding: EdgeInsets.only(left: 24.0, top: 12.0,bottom: 12.0,right: 22.0),
                    decoration: BoxDecoration(
                      color: kTenBlackColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [BoxShadow(
                        color: kTenBlackColor,
                        blurRadius: 10,
                        spreadRadius: 5,
                        offset: Offset(8.0,8.0)
                      )]
                    ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 57,
                                width: 57,
                                decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                                image: AssetImage(transactions[index].photo))),
                              ),
                              SizedBox(width: 13.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(transactions[index].name,  style: GoogleFonts.inter(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: kWhiteColor)),
                                  Text(transactions[index].date, style: GoogleFonts.inter(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: kWhiteColor)),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(transactions[index].amount, style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: kBlueColor)),
                            ],
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class OperationCard extends StatefulWidget {
  final String operation;
  final String selectedIcon;
  final String unSelectedIcon;
  final bool isSelected;
  final _HomeScreenState context;

  OperationCard(
      {this.context,
      this.isSelected,
      this.operation,
      this.selectedIcon,
      this.unSelectedIcon});

  @override
  _OperationCardState createState() => _OperationCardState();
}

class _OperationCardState extends State<OperationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.0),
      width: 140.0,
      height: 123.0,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: kTenBlackColor,
                blurRadius: 10.0,
                spreadRadius: 5.0,
                offset: Offset(8.0, 8.0))
          ],
          borderRadius: BorderRadius.circular(15),
          color: widget.isSelected ? kBlueColor : kTenBlackColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
              widget.isSelected ? widget.selectedIcon : widget.unSelectedIcon),
          SizedBox(height: 9.0),
          Text(
            widget.operation,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: widget.isSelected ? FontWeight.w700 : FontWeight.w400,
                color: widget.isSelected ? kWhiteColor : kWhiteColor),
          )
        ],
      ),
    );
  }
}
