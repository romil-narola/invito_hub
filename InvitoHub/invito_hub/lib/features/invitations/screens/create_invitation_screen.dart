import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/routing/app_router.dart';
import '../../contacts/screens/contacts_picker_screen.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:file_picker/file_picker.dart';
import 'package:invito_hub/l10n/app_localizations.dart';
import '../models/invitation.dart';
import '../models/invitation_type.dart';
import '../repository/mock_invitation_repository.dart';

class CreateInvitationScreen extends StatefulWidget {
  final Invitation? invitationToEdit;

  const CreateInvitationScreen({super.key, this.invitationToEdit});

  @override
  State<CreateInvitationScreen> createState() => _CreateInvitationScreenState();
}

class _CreateInvitationScreenState extends State<CreateInvitationScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _hostController;
  late TextEditingController _locationController;
  late TextEditingController _messageController;
  late TextEditingController _coHostsController;
  late TextEditingController _budgetController;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  List<Contact> _selectedContacts = [];
  InvitationType _selectedType = InvitationType.values.first;
  List<String> _attachedDocuments = [];
  String? _selectedTemplate;
  bool _isInit = false;

  final List<String> _templates = [
    'Classic',
    'Modern',
    'Party',
    'Elegant',
    'Minimal',
  ];

  @override
  void initState() {
    super.initState();

    final inv = widget.invitationToEdit;

    _titleController = TextEditingController(text: inv?.eventTitle ?? '');
    _hostController = TextEditingController(text: inv?.hostName ?? '');
    _locationController = TextEditingController(text: inv?.location ?? '');
    _messageController = TextEditingController(
      text: inv?.customMessage ?? 'You are cordially invited!',
    );
    _coHostsController = TextEditingController(
      text: inv?.coHosts.join(', ') ?? '',
    );
    _budgetController = TextEditingController(
      text: inv?.estimatedBudget?.toString() ?? '',
    );

    if (inv != null) {
      _selectedDate = inv.dateTime;
      _selectedTime = TimeOfDay.fromDateTime(inv.dateTime);
      _selectedType = inv.type;
      _selectedTemplate = inv.templateName;

      // Dummy contacts will be initialized in didChangeDependencies
      _attachedDocuments = List.from(inv.attachedDocuments);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit && widget.invitationToEdit != null) {
      _isInit = true;
      final inv = widget.invitationToEdit!;
      _selectedContacts = inv.invitedContacts.map((phone) {
        return Contact(
          id: '',
          displayName: AppLocalizations.of(context)!.guestNameWithPhone(phone),
          phones: [Phone(phone)],
        );
      }).toList();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _hostController.dispose();
    _locationController.dispose();
    _messageController.dispose();
    _coHostsController.dispose();
    _budgetController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().subtract(
        const Duration(days: 365),
      ), // allow past dates for editing
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  void _pickTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? const TimeOfDay(hour: 18, minute: 0),
    );
    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  void _pickContacts() async {
    final contacts = await Navigator.push<List<Contact>>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ContactsPickerScreen(initiallySelected: _selectedContacts),
      ),
    );
    if (contacts != null) {
      setState(() {
        // For simplicity, we just replace them here
        _selectedContacts = contacts;
      });
    }
  }

  Future<void> _pickDocument() async {
    final result = await FilePicker.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );
    if (result != null && result.files.isNotEmpty) {
      setState(() {
        _attachedDocuments.addAll(
          result.files
              .map((e) => e.path!)
              .where((path) => !_attachedDocuments.contains(path)),
        );
      });
    }
  }

  Future<void> _openCoHostContactsPicker() async {
    final result = await Navigator.pushNamed(context, AppRouter.contactsRoute);
    if (result != null && result is List<Contact>) {
      setState(() {
        final newCoHosts = result
            .map((c) {
              if (c.phones.isNotEmpty) {
                return '${c.displayName} (${c.phones.first.number})';
              }
              return c.displayName;
            })
            .join(', ');

        if (_coHostsController.text.isNotEmpty) {
          _coHostsController.text += ', $newCoHosts';
        } else {
          _coHostsController.text = newCoHosts;
        }
      });
    }
  }

  void _previewInvitation() {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.errorSelectDateTime),
          ),
        );
        return;
      }
      if (_selectedContacts.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.errorSelectContacts),
          ),
        );
        return;
      }

      final dateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      final invitation = Invitation(
        id:
            widget.invitationToEdit?.id ??
            MockInvitationRepository().generateId(),
        type: _selectedType,
        eventTitle: _titleController.text,
        hostName: _hostController.text,
        dateTime: dateTime,
        location: _locationController.text,
        customMessage: _messageController.text,
        invitedContacts: _selectedContacts
            .map((e) => e.phones.isNotEmpty ? e.phones.first.number : '')
            .toList(),
        createdAt: widget.invitationToEdit?.createdAt ?? DateTime.now(),
        attachedDocuments: _attachedDocuments,
        templateName: _selectedTemplate,
        coHosts: _coHostsController.text
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList(),
        estimatedBudget: double.tryParse(_budgetController.text),
        currentExpenses: 0.0, // newly created invitations start at 0 expenses
        rsvps: {}, // Ensure mutable map
      );

      Navigator.pushNamed(
        context,
        AppRouter.previewInvitationRoute,
        arguments: {'invitation': invitation, 'contacts': _selectedContacts},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.invitationToEdit != null;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final tileColor = isDark ? Colors.grey.shade800 : Colors.grey.shade100;
    final itemTileColor = isDark ? Colors.grey.shade900 : Colors.grey.shade50;
    final borderColor = isDark ? Colors.grey.shade700 : Colors.grey.shade200;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing
              ? AppLocalizations.of(context)!.createScreenEditTitle
              : AppLocalizations.of(context)!.createScreenCreateTitle,
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24.0),
          children: [
            Text(
              AppLocalizations.of(context)!.createScreenEventDetails,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<InvitationType>(
              initialValue: _selectedType,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(
                  context,
                )!.createScreenInvitationType,
                prefixIcon: const Icon(Icons.category),
              ),
              items: InvitationType.values.map((type) {
                return DropdownMenuItem(
                  value: type,
                  child: Row(
                    children: [
                      Icon(type.icon, size: 20),
                      const SizedBox(width: 12),
                      Text(type.displayName),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedType = value;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Select Template (Mock)',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _templates.length,
                itemBuilder: (context, index) {
                  final template = _templates[index];
                  final isSelected = _selectedTemplate == template;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTemplate = isSelected ? null : template;
                      });
                    },
                    child: Container(
                      width: 80,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF6C63FF) : tileColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF6C63FF)
                              : borderColor,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          template,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : (isDark ? Colors.white70 : Colors.black87),
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(
                  context,
                )!.createScreenEventTitleLabel,
                prefixIcon: const Icon(Icons.event),
              ),
              validator: (v) => v!.isEmpty
                  ? AppLocalizations.of(context)!.errorRequiredField
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _hostController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(
                  context,
                )!.createScreenHostedByLabel,
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (v) => v!.isEmpty
                  ? AppLocalizations.of(context)!.errorRequiredField
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _coHostsController,
              decoration: InputDecoration(
                labelText: 'Co-Hosts (Phone/Email or Select)',
                prefixIcon: const Icon(Icons.group),
                hintText: 'e.g. +1234567890',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.contacts),
                  onPressed: _openCoHostContactsPicker,
                  tooltip: 'Select from Contacts',
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _budgetController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                labelText: 'Estimated Budget',
                prefixIcon: Icon(Icons.attach_money),
                hintText: 'e.g. 500.00',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickDate,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(
                          context,
                        )!.createScreenDateLabel,
                        prefixIcon: const Icon(Icons.calendar_today),
                      ),
                      child: Text(
                        _selectedDate == null
                            ? AppLocalizations.of(
                                context,
                              )!.createScreenSelectDate
                            : DateFormat.yMMMd().format(_selectedDate!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: _pickTime,
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(
                          context,
                        )!.createScreenTimeLabel,
                        prefixIcon: const Icon(Icons.access_time),
                      ),
                      child: Text(
                        _selectedTime == null
                            ? AppLocalizations.of(
                                context,
                              )!.createScreenSelectTime
                            : _selectedTime!.format(context),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(
                  context,
                )!.createScreenLocationLabel,
                prefixIcon: const Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.createScreenMessageTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _messageController,
              maxLines: 4,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(
                  context,
                )!.createScreenCustomMessageLabel,
                alignLabelWithHint: true,
              ),
              validator: (v) => v!.isEmpty
                  ? AppLocalizations.of(context)!.errorRequiredField
                  : null,
            ),
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.createScreenAttachmentsTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ListTile(
              onTap: _pickDocument,
              tileColor: tileColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              leading: const Icon(Icons.attach_file, color: Color(0xFF6C63FF)),
              title: Text(
                AppLocalizations.of(context)!.createScreenAttachDocuments,
              ),
              trailing: const Icon(Icons.add, size: 16),
            ),
            if (_attachedDocuments.isNotEmpty) ...[
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 64.0 * 5),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: _attachedDocuments.length,
                  itemBuilder: (context, index) {
                    final docPath = _attachedDocuments[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ListTile(
                        tileColor: itemTileColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: borderColor),
                        ),
                        leading: const Icon(
                          Icons.description,
                          color: Color(0xFF6C63FF),
                          size: 20,
                        ),
                        title: Text(
                          docPath.split('/').last.split('\\').last,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 14),
                        ),
                        trailing: InkWell(
                          onTap: () {
                            setState(() {
                              _attachedDocuments.remove(docPath);
                            });
                          },
                          child: const Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
            const SizedBox(height: 20),
            Text(
              AppLocalizations.of(context)!.createScreenGuestsTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ListTile(
              onTap: _pickContacts,
              tileColor: tileColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              leading: const Icon(Icons.group_add, color: Color(0xFF6C63FF)),
              title: Text(
                _selectedContacts.isEmpty
                    ? AppLocalizations.of(context)!.createScreenSelectContacts
                    : AppLocalizations.of(
                        context,
                      )!.createScreenContactsSelected(_selectedContacts.length),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _previewInvitation,
                child: Text(
                  isEditing
                      ? AppLocalizations.of(context)!.createScreenPreviewChanges
                      : AppLocalizations.of(
                          context,
                        )!.createScreenPreviewInvitation,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
