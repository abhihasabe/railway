import 'package:rapid_response/bloc_cubits/theme_cubit/theme_cubit.dart';
import 'package:rapid_response/localization/app_localization.dart';
import 'package:rapid_response/models/lang_status_model.dart';
import 'package:rapid_response/widgets/card_view_widget.dart';
import 'package:rapid_response/routes/app_routes_names.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapid_response/theme/app_dimension.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:rapid_response/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LangCard extends StatelessWidget {
  final LangsStatus _item;

  const LangCard(this._item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQueryData.fromWindow(WidgetsBinding.instance!.window).platformBrightness;
    return CardViewWidget(
      backgroundColor: _item.isSelected
          ? (brightness == Brightness.dark)
              ? cardDarkColor
              : const Color(0xffece2e4)
          : cardColor,
      width: MediaQuery.of(context).size.width,
      height: DIMENSION_80,
      elevation: DIMENSION_1,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: ListTile(
                leading: Container(
                  height: 50.0,
                  width: 50.0,
                  child: Center(
                    child: Text(_item.buttonText,
                        style: TextStyle(
                            color:
                                _item.isSelected ? Colors.white : Colors.black,
                            //fontWeight: FontWeight.bold,
                            fontSize: 18.0)),
                  ),
                  decoration: BoxDecoration(
                    color: _item.isSelected ? primaryColor : Colors.transparent,
                    border: Border.all(
                        width: 1.0,
                        color: _item.isSelected ? primaryColor : Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                  ),
                ),
                title: Text(_item.title,
                    style: TextStyle(
                        color: _item.isSelected ? textColor : Colors.black,
                        //fontWeight: FontWeight.bold,
                        fontSize: 18.0)),
                subtitle: Text(_item.subtitle,
                    style: TextStyle(
                        color: _item.isSelected ? textColor : Colors.black,
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0)),
                onTap: () {
                  if (AppLocalization.of(context)!.isEnLocale) {
                    context.read<ThemeCubit>().changeLang(context, 'es');
                    goDashboard(context);
                  } else {
                    context.read<ThemeCubit>().changeLang(context, 'en');
                    goDashboard(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void goDashboard(BuildContext context) {
    VxNavigator.of(context).push(Uri.parse(adminHomeScreen));
  }
}
