import 'package:dennis_lechon_crm/screens/homebuttons/customer_screen.dart';
import 'package:flutter/material.dart';

class CustomerDash extends StatelessWidget {
  const CustomerDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            CustomerCard(
                age: '21 years old',
                name: 'Maria Leonora Teresa Mamasita',
                address: 'Mandaue',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomerScreen()),
                  );
                }),
            CustomerCard(
                age: '21 years old',
                name: 'Dianne',
                address: 'Minglanilla',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomerScreen()),
                  );
                }),
            CustomerCard(
                age: '21 years old',
                name: 'Melzar',
                address: 'Lapu-lapu',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomerScreen()),
                  );
                }),
            CustomerCard(
                age: '21 years old',
                name: 'Vorr',
                address: 'Banilad',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomerScreen()),
                  );
                }),
            CustomerCard(
                age: '21 years old',
                name: 'Emma',
                address: 'Talamban',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CustomerScreen()),
                  );
                }),
          ],
        ));
  }
}

class CustomerCard extends StatelessWidget {
  const CustomerCard({
    Key? key,
    required this.age,
    required this.name,
    required this.address,
    required this.press,
  }) : super(key: key);

  final String age, name, address;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.only(
          left: 20,
          top: 10,
          bottom: 0,
        ),
        width: size.width * 0.25,
        height: size.width * 0.25,
        //height: 100,
        //size.width * 0.4,
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: press,
              child: Container(
                padding: const EdgeInsets.only(left: 25, right: 25),
                decoration: const BoxDecoration(
                    color: Color(0xFFF1A22C),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20))),
                height: 32,
                width: size.width * 0.25,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(name,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: const TextStyle(
                              fontFamily: 'Baloo_2',
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ]),
              ),
            ),
            GestureDetector(
              onTap: press,
              child: Container(
                //color: Colors.red,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 20,
                      color: Color.fromARGB(101, 158, 158, 158),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      address,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1F2426),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      age,
                      style: const TextStyle(
                        color: Color(0xFF1F2426),
                      ),
                    ),
                    SizedBox(width: size.width * 0.25),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
