import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsRepository {
  Future<bool> requestPermission() async {
    final status = await Permission.contacts.request();
    return status.isGranted;
  }

  Future<List<Contact>> getContacts() async {
    final hasPermission = await requestPermission();
    if (!hasPermission) {
      throw Exception('Contacts permission denied');
    }

    // flutter_contacts requires its own init call for some platforms, but usually requestPermission handles it.
    // However, it's safe to use FlutterContacts.requestPermission() as well.
    if (await FlutterContacts.requestPermission(readonly: true)) {
      final contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: false,
      );
      return contacts
          .where((c) => c.displayName.isNotEmpty && c.phones.isNotEmpty)
          .toList();
    } else {
      throw Exception('Contacts permission denied by FlutterContacts');
    }
  }
}
