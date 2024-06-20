class Reference {

  final String reference;

  const Reference({

    required this.reference,
  });

  factory Reference.fromJson(Map<String, dynamic> json) {
    return Reference(
      reference: json['reference'],
     
    );
  }
}