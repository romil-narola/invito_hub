import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:invito_hub/l10n/app_localizations.dart';
import '../repository/contacts_repository.dart';
import '../models/guest_group.dart';
import '../repository/mock_guest_group_repository.dart';

class ContactsPickerScreen extends StatefulWidget {
  final List<Contact>? initiallySelected;

  const ContactsPickerScreen({super.key, this.initiallySelected});

  @override
  State<ContactsPickerScreen> createState() => _ContactsPickerScreenState();
}

class _ContactsPickerScreenState extends State<ContactsPickerScreen> {
  final ContactsRepository _repository = ContactsRepository();
  final MockGuestGroupRepository _groupsRepository = MockGuestGroupRepository();

  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  List<GuestGroup> _groups = [];
  late List<Contact> _selectedContacts;
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _selectedContacts = widget.initiallySelected != null
        ? List.from(widget.initiallySelected!)
        : [];
    _loadContacts();
  }

  Future<void> _loadContacts() async {
    List<Contact> contacts = [];
    try {
      contacts = await _repository.getContacts();
    } catch (e) {
      if (widget.initiallySelected == null ||
          widget.initiallySelected!.isEmpty) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
        return;
      }
    }

    try {
      final groups = await _groupsRepository.getGroups();

      if (widget.initiallySelected != null) {
        for (final initContact in widget.initiallySelected!.reversed) {
          bool exists = contacts.any((c) {
            if (c.phones.isNotEmpty && initContact.phones.isNotEmpty) {
              return c.phones.first.number.replaceAll(RegExp(r'\D'), '') ==
                  initContact.phones.first.number.replaceAll(RegExp(r'\D'), '');
            }
            return c.id == initContact.id && c.id.isNotEmpty;
          });
          if (!exists) {
            contacts.insert(0, initContact);
          }
        }
      }

      setState(() {
        _contacts = contacts;
        _filteredContacts = contacts;
        _groups = groups;
        _isLoading = false;
        _error = '';
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _filterContacts(String query) {
    if (query.isEmpty) {
      setState(() => _filteredContacts = _contacts);
      return;
    }
    final lowercaseQuery = query.toLowerCase();
    setState(() {
      _filteredContacts = _contacts.where((contact) {
        return contact.displayName.toLowerCase().contains(lowercaseQuery);
      }).toList();
    });
  }

  bool _isContactSelected(Contact contact) {
    return _selectedContacts.any((c) {
      if (c.id == contact.id && c.id.isNotEmpty) return true;
      if (c.phones.isNotEmpty && contact.phones.isNotEmpty) {
        // Strip non-digits for safer comparison if needed, or exact match
        final p1 = c.phones.first.number.replaceAll(RegExp(r'\D'), '');
        final p2 = contact.phones.first.number.replaceAll(RegExp(r'\D'), '');
        return p1 == p2;
      }
      return false;
    });
  }

  void _toggleSelection(Contact contact) {
    setState(() {
      if (_isContactSelected(contact)) {
        _selectedContacts.removeWhere((c) {
          if (c.id == contact.id && c.id.isNotEmpty) return true;
          if (c.phones.isNotEmpty && contact.phones.isNotEmpty) {
            final p1 = c.phones.first.number.replaceAll(RegExp(r'\D'), '');
            final p2 = contact.phones.first.number.replaceAll(
              RegExp(r'\D'),
              '',
            );
            return p1 == p2;
          }
          return false;
        });
      } else {
        _selectedContacts.add(contact);
      }
    });
  }

  void _toggleGroupSelection(GuestGroup group) {
    // If all members are selected, deselect them. Otherwise, select all.
    bool allSelected = group.contactPhones.every((phone) {
      return _selectedContacts.any(
        (c) =>
            c.phones.isNotEmpty &&
            c.phones.first.number.replaceAll(RegExp(r'\D'), '') ==
                phone.replaceAll(RegExp(r'\D'), ''),
      );
    });

    setState(() {
      for (final phone in group.contactPhones) {
        final mockContact = Contact(
          id: '',
          displayName: 'Guest ($phone)',
          phones: [Phone(phone)],
        );

        if (allSelected) {
          // Remove
          _selectedContacts.removeWhere((c) {
            if (c.phones.isNotEmpty) {
              return c.phones.first.number.replaceAll(RegExp(r'\D'), '') ==
                  phone.replaceAll(RegExp(r'\D'), '');
            }
            return false;
          });
        } else {
          // Add if not exists
          if (!_isContactSelected(mockContact)) {
            _selectedContacts.add(mockContact);
          }
        }
      }
    });
  }

  bool get _isAllFilteredSelected {
    if (_filteredContacts.isEmpty) return false;
    return _filteredContacts.every((c) => _isContactSelected(c));
  }

  void _toggleAllFiltered() {
    setState(() {
      if (_isAllFilteredSelected) {
        for (var c in _filteredContacts) {
          _selectedContacts.removeWhere((selected) {
            if (selected.id == c.id && c.id.isNotEmpty) return true;
            if (selected.phones.isNotEmpty && c.phones.isNotEmpty) {
              return selected.phones.first.number.replaceAll(
                    RegExp(r'\D'),
                    '',
                  ) ==
                  c.phones.first.number.replaceAll(RegExp(r'\D'), '');
            }
            return false;
          });
        }
      } else {
        for (var c in _filteredContacts) {
          if (!_isContactSelected(c)) {
            _selectedContacts.add(c);
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.contactsPickerTitle),
          actions: [
            TextButton(
              onPressed: _toggleAllFiltered,
              child: Text(
                _isAllFilteredSelected ? 'Deselect All' : 'Select All',
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Contacts'),
              Tab(text: 'Groups'),
            ],
          ),
        ),
        body: TabBarView(children: [_buildBody(), _buildGroupsBody()]),
        floatingActionButton: _selectedContacts.isNotEmpty
            ? FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pop(context, _selectedContacts);
                },
                icon: const Icon(Icons.check),
                label: Text(
                  AppLocalizations.of(
                    context,
                  )!.contactsPickerDone(_selectedContacts.length),
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildBody() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error.isNotEmpty) {
      final isPermissionError = _error.toLowerCase().contains('permission');
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              isPermissionError
                  ? AppLocalizations.of(context)!.contactsPermissionError
                  : AppLocalizations.of(context)!.contactsGenericError(_error),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            if (isPermissionError)
              ElevatedButton.icon(
                onPressed: () {
                  openAppSettings();
                },
                icon: const Icon(Icons.settings),
                label: Text(AppLocalizations.of(context)!.contactsOpenSettings),
              ),
            if (!isPermissionError)
              ElevatedButton(
                onPressed: _loadContacts,
                child: Text(AppLocalizations.of(context)!.contactsRetry),
              ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: _filterContacts,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.contactsSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: isDark
                        ? Colors.grey.shade800
                        : Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF6C63FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(Icons.person_add, color: Colors.white),
                  onPressed: _showCreateContactDialog,
                  tooltip: 'Create New Contact',
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _filteredContacts.length,
            itemBuilder: (context, index) {
              final contact = _filteredContacts[index];
              final isSelected = _isContactSelected(contact);
              final phone = contact.phones.isNotEmpty
                  ? contact.phones.first.number
                  : AppLocalizations.of(context)!.contactsNoPhoneNumber;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: isSelected
                      ? const Color(0xFF6C63FF)
                      : (isDark ? Colors.grey.shade700 : Colors.grey.shade200),
                  child: Text(
                    contact.displayName.isNotEmpty
                        ? contact.displayName.substring(0, 1).toUpperCase()
                        : '?',
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : (isDark ? Colors.white70 : Colors.black87),
                    ),
                  ),
                ),
                title: Text(contact.displayName),
                subtitle: Text(phone),
                trailing: isSelected
                    ? const Icon(Icons.check_circle, color: Color(0xFF6C63FF))
                    : const Icon(Icons.circle_outlined, color: Colors.grey),
                onTap: () => _toggleSelection(contact),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGroupsBody() {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    return ListView.builder(
      itemCount: _groups.length,
      itemBuilder: (context, index) {
        final group = _groups[index];
        final isSelected = group.contactPhones.every((phone) {
          return _selectedContacts.any(
            (c) =>
                c.phones.isNotEmpty &&
                c.phones.first.number.replaceAll(RegExp(r'\D'), '') ==
                    phone.replaceAll(RegExp(r'\D'), ''),
          );
        });

        return ListTile(
          leading: CircleAvatar(
            backgroundColor: isSelected
                ? const Color(0xFF6C63FF)
                : Colors.grey.shade300,
            child: Icon(
              Icons.group,
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
          ),
          title: Text(group.name),
          subtitle: Text('${group.contactPhones.length} contacts'),
          trailing: isSelected
              ? const Icon(Icons.check_circle, color: Color(0xFF6C63FF))
              : const Icon(Icons.circle_outlined, color: Colors.grey),
          onTap: () => _toggleGroupSelection(group),
        );
      },
    );
  }

  void _showCreateContactDialog() {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create New Contact'),
          insetPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final phone = phoneController.text.trim();
                if (name.isNotEmpty && phone.isNotEmpty) {
                  var newContact = Contact(
                    name: Name(first: name),
                    phones: [Phone(phone)],
                  );

                  bool savedToSystem = false;
                  try {
                    // Request write permissions if needed
                    if (await FlutterContacts.requestPermission(
                      readonly: false,
                    )) {
                      await newContact.insert();
                      savedToSystem = true;
                    } else {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Permission denied to save to system contacts.',
                            ),
                          ),
                        );
                      }
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to save to system: $e')),
                      );
                    }
                  }

                  if (newContact.id.isEmpty) {
                    newContact.id = DateTime.now().millisecondsSinceEpoch
                        .toString();
                  }

                  // fallback to display name for the local UI if needed
                  if (newContact.displayName.isEmpty) {
                    newContact.displayName = name;
                  }

                  if (!context.mounted) return;

                  setState(() {
                    _contacts.insert(0, newContact);
                    _filterContacts(''); // Reset filter to show new contact
                  });
                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        savedToSystem
                            ? '$name saved to device contacts!'
                            : '$name added to app only!',
                      ),
                    ),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
