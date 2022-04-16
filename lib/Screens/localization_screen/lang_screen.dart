import 'package:railway_alert/screens/localization_screen/lang_card_widget.dart';
import 'package:railway_alert/localization/app_localization.dart';
import 'package:railway_alert/models/lang_status_model.dart';
import 'package:railway_alert/widgets/toolbar_widget.dart';
import 'package:railway_alert/theme/app_dimension.dart';
import 'package:railway_alert/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LangScreen extends StatefulWidget {
  const LangScreen({Key? key}) : super(key: key);

  @override
  createState() {
    return _LangScreen();
  }
}

class _LangScreen extends State<LangScreen> {
  List<LangsStatus> langData = <LangsStatus>[];
  bool? enStatus, spStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) => getData());
  }

  getData() {
    enStatus = AppLocalization.of(context)!.isEnLocale;
    spStatus = AppLocalization.of(context)!.isSpLocale;
    langData.add(LangsStatus(enStatus!, 'E', 'English', 'English'));
    langData.add(LangsStatus(spStatus!, 'S', 'Española', 'Spanish'));
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ToolbarWidget(
        leading: const Icon(Icons.arrow_back_outlined),
        onClick: () {
          Navigator.of(context).pop();
        },
        title: AppLocalization.of(context)?.translate('clang'),
        actions: const [
          Icon(
            Icons.notifications,
            size: DIMENSION_28,
          ),
          SizedBox(
            width: DIMENSION_12,
          )
        ],
      ),
      body: ListView.builder(
        itemCount: langData.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            //highlightColor: Colors.red,
            splashColor: primaryColor,
            onTap: () {
              setState(() {
                for (var element in langData) {
                  element.isSelected = false;
                }
                langData[index].isSelected = true;
              });
            },
            child: LangCard(langData[index]),
          );
        },
      ),
    );
  }
}
