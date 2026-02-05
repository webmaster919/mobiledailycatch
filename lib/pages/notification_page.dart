import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/constants.dart';

class NotificationPage extends StatelessWidget {
  // Liste fictive de notifications
  final List<Map<String, String>> notifications = [
    {
      "title": "Commande confirmée ✅",
      "subtitle": "Votre commande #12345 a été confirmée.",
      "time": "Il y a 2 min",
    },
    {
      "title": "Commande en livraison 🚚",
      "subtitle": "Votre commande #12345 est en route.",
      "time": "Il y a 30 min",
    },
    {
      "title": "Offre spéciale 🎉",
      "subtitle": "Profitez de -20% sur votre prochaine commande !",
      "time": "Aujourd'hui",
    },
    {
      "title": "Rappel de paiement 💳",
      "subtitle": "Votre abonnement expire demain.",
      "time": "Hier",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
     appBar: null,
      body:
          notifications.isEmpty
              ? Center(
                child: Text(
                  "Aucune notification pour le moment 📭",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
              : ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(
                        Icons.notifications,
                        color: AppColors.blueBic,
                      ),
                      title: Text(
                        notifications[index]["title"]!,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        notifications[index]["subtitle"]!,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey[700],
                        ),
                      ),
                      trailing: Text(
                        notifications[index]["time"]!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
