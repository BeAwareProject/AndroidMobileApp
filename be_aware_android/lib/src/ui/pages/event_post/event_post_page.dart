import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/generated_code/dependency_injection/injectable.dart';
import 'package:be_aware_android/src/exceptions/server_exception.dart';
import 'package:be_aware_android/src/services/events_service.dart';
import 'package:be_aware_android/src/ui/common/dialogs/loading_dialog.dart';
import 'package:be_aware_android/src/ui/pages/event_post/widget/event_selectable_tag.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toastification/toastification.dart';

class EventPostPage extends StatefulWidget {
  EventPostPage({super.key});
  final EventsService eventsService = getIt();

  @override
  State<EventPostPage> createState() => _EventPostPageState();
}

class _EventPostPageState extends State<EventPostPage> {
  final List<bool> _isSelectedCasualties = [true, false, false];
  final List<bool> _isSelectedDeadly = [true, false];
  PageTagDto? _tags;
  final Set<int> _selectedTagsIds = {};
  bool _serverException = false;

  @override
  void initState() {
    super.initState();
    _loadTags();
  }

  Future<void> _report() async {
    if (_selectedTagsIds.isEmpty) {
      _showToast(
        "You must choose at least one tag",
        ToastificationType.warning,
      );
    } else {
      _showLoadingDialog();
      Location? currentLocation = await _getCurrentLocation();
      if (currentLocation != null) {
        EventForm eventForm = EventForm(
          location: currentLocation,
          description: "Bomba w śmietniku",
          deadly: _isSelectedDeadly[1],
          casualties:
              _isSelectedCasualties[2] ? null : _isSelectedCasualties[1],
          tagIds: _selectedTagsIds.toList(),
        );
        try {
          await widget.eventsService.postEvent(eventForm);
          _popLoadingDialog();
          _showToast(
            "Event added!!!",
            ToastificationType.success,
          );
        } on ServerException catch (_) {
          _popLoadingDialog();
          _showToast(
            "An error occured",
            ToastificationType.error,
          );
        }
      } else {
        _popLoadingDialog();
      }
    }
  }

  Future<Location?> _getCurrentLocation() async {
    if (await Permission.location.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium,
        );
        return Location(
          latitude: position.latitude,
          longitude: position.longitude,
        );
      } catch (e) {
        _showToast("Location cannot be determined", ToastificationType.error);
      }
    } else {
      _showToast(
          "Localization permission not granted", ToastificationType.error);
    }
    return null;
  }

  void _showLoadingDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return const LoadingDialog(message: "Publishing...");
        });
  }

  void _popLoadingDialog() {
    Navigator.pop(context);
  }

  Future<void> _loadTags() async {
    try {
      PageTagDto tags = await widget.eventsService.getAllTags();
      setState(() {
        _tags = tags;
      });
    } on ServerException catch (_) {
      setState(() {
        _serverException = true;
      });
    }
  }

  void _switchCasualties(int newIndex) {
    setState(() {
      for (int index = 0; index < _isSelectedCasualties.length; index++) {
        if (index == newIndex) {
          _isSelectedCasualties[index] = !_isSelectedCasualties[index];
        } else {
          _isSelectedCasualties[index] = false;
        }
      }
    });
  }

  void _switchDeadly(int newIndex) {
    setState(() {
      for (int index = 0; index < _isSelectedDeadly.length; index++) {
        if (index == newIndex) {
          _isSelectedDeadly[index] = !_isSelectedDeadly[index];
        } else {
          _isSelectedDeadly[index] = false;
        }
      }
    });
  }

  void _onTapTag(int tagId) {
    if (_selectedTagsIds.contains(tagId)) {
      setState(() {
        _selectedTagsIds.remove(tagId);
      });
    } else {
      if (_selectedTagsIds.length < 3) {
        setState(() {
          _selectedTagsIds.add(tagId);
        });
      } else {
        _showToast(
          "You can choose max 3 tags",
          ToastificationType.warning,
        );
      }
    }
  }

  void _showToast(String title, ToastificationType type) {
    toastification.show(
      context: context,
      title: title,
      showProgressBar: false,
      type: type,
      style: ToastificationStyle.fillColored,
      alignment: Alignment.topRight,
      margin: const EdgeInsets.only(top: 0, left: 10, right: 20),
      autoCloseDuration: const Duration(seconds: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Event"),
      ),
      body: _serverException
          ? const Center(child: Text("Error occured"))
          : _tags == null
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                context.push("/event/takephoto/123");
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.play_circle_outlined,
                                    size: 35,
                                  ),
                                  SizedBox(width: 7),
                                  Text("GO LIVE"),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          Text(
                            "Are there any casualties?",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 10),
                          ToggleButtons(
                            isSelected: _isSelectedCasualties,
                            onPressed: _switchCasualties,
                            children: const [
                              SizedBox(
                                width: 90,
                                child: Center(
                                    child: Text('NO',
                                        style: TextStyle(fontSize: 16))),
                              ),
                              SizedBox(
                                width: 90,
                                child: Center(
                                    child: Text('YES',
                                        style: TextStyle(fontSize: 16))),
                              ),
                              SizedBox(
                                width: 130,
                                child: Center(
                                    child: Text("DON'T KNOW",
                                        style: TextStyle(fontSize: 16))),
                              ),
                            ],
                          ),
                          const SizedBox(height: 35),
                          Text(
                            "Is thread deadly?",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 10),
                          ToggleButtons(
                            isSelected: _isSelectedDeadly,
                            onPressed: _switchDeadly,
                            children: const [
                              SizedBox(
                                width: 155,
                                child: Center(
                                    child: Text('NO',
                                        style: TextStyle(fontSize: 16))),
                              ),
                              SizedBox(
                                width: 155,
                                child: Center(
                                    child: Text('YES',
                                        style: TextStyle(fontSize: 16))),
                              ),
                            ],
                          ),
                          const SizedBox(height: 35),
                          Text(
                            "Event type",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 12.0,
                              children: _tags!.content
                                      ?.map((tag) => EventSelectableTag(
                                            tag: tag,
                                            selected: _selectedTagsIds
                                                .contains(tag.id),
                                            onTap: _onTapTag,
                                          ))
                                      .toList() ??
                                  [],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: _report,
                          child: const Text(
                            "Report",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
