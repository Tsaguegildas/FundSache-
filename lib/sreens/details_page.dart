import 'package:flutter/material.dart';
import 'package:fundvgsache/models/lostItem.dart';
import 'package:fundvgsache/sreens/messagePage.dart';

class DetailsPage extends StatelessWidget {
  final LostItems lostItem;

  const DetailsPage({super.key, required this.lostItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lostItem.itemName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lostItem.itemBild != null
                  ? Image.asset(
                      lostItem.itemBild!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 16),
              Text(
                lostItem.itemName,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                lostItem.itemMarque ?? '',
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Text(
                'Beschreibung:',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                lostItem.itemBeschreibung ?? 'Keine Beschreibung verfügbar',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),

              // Text(
              // 'Finder ID:',
              // style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              //       ),
              Row(
                children: [
                  Container(

                    child: Column(
                      children: [
                        const Text(
                          'Fundort:',
                          style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          lostItem.itemLocationFund,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Gefunden am:',
                          style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          lostItem.itemDateFund,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        const  Text(
                          'Status:',
                          style:
                          const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),

                        const SizedBox(height: 16),
                        Text(
                          lostItem.itemStatus,
                          style: TextStyle(
                            fontSize: 16,
                            color: lostItem.itemStatus == 'gefunden'
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ///////////////////////////////


                      ],
                    ),

                  ),
                  Expanded(child: IconButton(
                    iconSize: 72,
                    icon: const Icon(Icons.message , color: Colors.black38),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Messagepage(),
                        ),
                      );
                    },
                  ),),
                ],
              ),
              const SizedBox(height: 8),
              //       Text(
              // lostItem.finderId != null ? lostItem.finderId.toString() : 'Nicht angegeben',
              // style: const TextStyle(fontSize: 16),
              //
              //       ),
            ],
          ),
        ),
      ),
    );
  }
}
