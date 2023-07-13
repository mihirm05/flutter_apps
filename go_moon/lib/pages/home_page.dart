import 'package:flutter/material.dart';
import 'package:go_moon/widgets/custom_dropdown_button.dart';

class HomePage extends StatelessWidget {
  late double _deviceHeight, _deviceWidth;

  // constructor
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Container(
              height: _deviceHeight,
              width: _deviceWidth,
              padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
              child: Stack(
                children: [Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _pageTitle(),  
                  _bookARideWidget(),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _astroImageWidget())
              ]
              )
              )
              ),
    );
  }

  Widget _pageTitle() {
    return const Text(
      "#GoMoon",
      style: TextStyle(
          color: Colors.white, 
          fontSize: 70, 
          fontWeight: FontWeight.w800),
    );
  }

  Widget _astroImageWidget() {
    return Container(
      width: _deviceWidth*0.65,
      height: _deviceHeight*0.5,
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/astro_moon.png"),
        ),
      ),
    );
  }

  Widget _bookARideWidget() {
    return Container(
        height: _deviceHeight * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _destinationDropDownWidget(),
            _travellersInformationWidget(),
            _rideButton()
          ],
        ));
  }

  Widget _destinationDropDownWidget() {
    return CustomDropDownButtonClass(values: const [
      'James Webb Telescope',
      'International Space Station',
    ], width: _deviceWidth); // create a list of DropDownMenuItem of type String
  }

  Widget _travellersInformationWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // shortcut to get the highlighted text wrapped in a widget: Ctrl + .
        CustomDropDownButtonClass(
            values: const ['1', '2', '3', '4'], width: _deviceWidth * 0.45),
        CustomDropDownButtonClass(
            values: const ['Economy', 'Business', 'First Class'],
            width: _deviceWidth * 0.4),
      ],
    ); // create a list of DropDownMenuItem of type String
  }

  Widget _rideButton() {
    return Container(
        margin: EdgeInsets.only(
          bottom: _deviceHeight * 0.01),
        width: _deviceWidth,
        decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(10)),
        child: MaterialButton(
          onPressed: () {},
          child:
              const Text(
                "Book a ride", 
                style: TextStyle(
                  color: Colors.black)
                  ),
        )
        );
  }
}
