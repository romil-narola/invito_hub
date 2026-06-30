import 'package:equatable/equatable.dart';

class GuestGroup extends Equatable {
  final String id;
  final String name;
  final List<String> contactPhones;

  const GuestGroup({
    required this.id,
    required this.name,
    required this.contactPhones,
  });

  @override
  List<Object?> get props => [id, name, contactPhones];
}
