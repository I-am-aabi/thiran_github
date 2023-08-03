import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thiran/controllers/gitrepo_data_controller.dart';

class GitAppBar extends StatelessWidget {
  const GitAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    bool tap = true;
    return Consumer<Gitcontrolller>(
      builder: (context, gitrepo, child) => SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 3,
          color: Colors.blue.shade100,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '  Git Star',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Row(
                children: [
                  const Text('30',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Switch(
                      value: tap,
                      inactiveThumbColor: Colors.white,
                      activeColor: Colors.white,
                      activeTrackColor: Colors.blueAccent,
                      inactiveTrackColor: Colors.blueAccent,
                      onChanged: (value) {
                        gitrepo.change30days();
                        tap = !tap;
                      }),
                  const Text(
                    '60  ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
