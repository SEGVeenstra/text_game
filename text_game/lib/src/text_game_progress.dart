class TextGameProgress {
  TextGameProgress({
    String? currentLocationId,
  }) : _currentLocationId = currentLocationId;

  String? _currentLocationId;

  String? get currentLocationId => _currentLocationId;

  void updateLocation(String locationId) {
    _currentLocationId = locationId;
  }
}
