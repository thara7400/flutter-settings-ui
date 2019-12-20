import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings_ui/src/cupertino_settings_section.dart';
import 'package:settings_ui/src/settings_tile.dart';

// ignore: must_be_immutable
class SettingsSection extends StatelessWidget {
  final String title;
  final String addition;
  final List<SettingsTile> tiles;
  bool showBottomDivider = false;

  SettingsSection({
    Key key,
    this.tiles,
    this.title,
    this.addition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return iosSection();
    else if (Platform.isAndroid)
      return androidSection(context);
    else
      return androidSection(context);
  }

  Widget iosSection() {
    return CupertinoSettingsSection(
      tiles,
      header: title == null ? null : Text(title),
      footer: addition == null ? null : Text(addition),
    );
  }

  Widget androidSection(BuildContext context) {
    if (addition != null) showBottomDivider = true;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      title == null
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
      ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: tiles.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(height: 1),
        itemBuilder: (BuildContext context, int index) {
          return tiles[index];
        },
      ),
      if (showBottomDivider) Divider(height: 1),
      addition == null
          ? Container()
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Text(addition),
      ),
    ]);
  }
}
