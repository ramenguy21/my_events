class EventModel {
  final String id;
  final String title;
  final String description;
  final int scheduledAt; // Unix timestamp
  final String location;
  final double? lat;
  final double? lng;
  final List<String> images;
  final String organizerName;
  final String organizerEmail;
  final String organizerPhone;
  final int attendeeLimit;
  final int attendeeCount;
  final String userId;
  final String createdAt;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    required this.scheduledAt,
    required this.location,
    this.lat,
    this.lng,
    required this.images,
    required this.organizerName,
    required this.organizerEmail,
    required this.organizerPhone,
    required this.attendeeLimit,
    required this.attendeeCount,
    required this.userId,
    required this.createdAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      scheduledAt: _parseInt(json['scheduledAt']),
      location: json['location']?.toString() ?? '',
      lat: _parseDouble(json['lat']),
      lng: _parseDouble(json['lng']),
      images:
          (json['images'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      organizerName: json['organizerName']?.toString() ?? '',
      organizerEmail: json['organizerEmail']?.toString() ?? '',
      organizerPhone: json['organizerPhone']?.toString() ?? '',
      attendeeLimit: _parseInt(json['attendeeLimit']),
      attendeeCount: _parseInt(json['attendeeCount']),
      userId: json['userId']?.toString() ?? '',
      createdAt: json['createdAt']?.toString() ?? '',
    );
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'scheduledAt': scheduledAt,
      'location': location,
      'lat': lat,
      'lng': lng,
      'images': images,
      'organizerName': organizerName,
      'organizerEmail': organizerEmail,
      'organizerPhone': organizerPhone,
      'attendeeLimit': attendeeLimit,
      'attendeeCount': attendeeCount,
      'userId': userId,
      'createdAt': createdAt,
    };
  }

  // Helper to get formatted date/time
  String getFormattedDate() {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(scheduledAt * 1000);
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  String getFormattedTime() {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(scheduledAt * 1000);
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    int? scheduledAt,
    String? location,
    double? lat,
    double? lng,
    List<String>? images,
    String? organizerName,
    String? organizerEmail,
    String? organizerPhone,
    int? attendeeLimit,
    int? attendeeCount,
    String? userId,
    String? createdAt,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      location: location ?? this.location,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      images: images ?? this.images,
      organizerName: organizerName ?? this.organizerName,
      organizerEmail: organizerEmail ?? this.organizerEmail,
      organizerPhone: organizerPhone ?? this.organizerPhone,
      attendeeLimit: attendeeLimit ?? this.attendeeLimit,
      attendeeCount: attendeeCount ?? this.attendeeCount,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
