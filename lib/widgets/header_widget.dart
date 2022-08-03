import 'package:rapid_response/bloc_cubits/login_cubit/login_cubit.dart';
import 'package:rapid_response/controllers/MenuController.dart';
import 'package:rapid_response/routes/app_routes_names.dart';
import 'package:rapid_response/theme/app_dimension.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rapid_response/theme/app_colors.dart';
import 'package:rapid_response/PlatformService.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Header extends StatelessWidget {
  const Header(
      {Key? key, this.iconColor, this.title, this.bgColor, this.textColor})
      : super(key: key);

  final Color? iconColor, bgColor, textColor;
  final title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      child: SafeArea(
        child: PlatFormServices.isMobile(context)
            ? Container(
                color: bgColor,
                child: appBar(context, title, textColor!),
              )
            : appBar(context, title, textColor!),
      ),
    );
  }
}

Widget appBar(BuildContext context, title, Color textColor) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      if (!PlatFormServices.isDesktop(context))
        IconButton(
          icon: const Icon(Icons.menu, color: iconColor),
          onPressed: context.read<MenuController>().controlMenu,
        ),
      Padding(
        padding: !PlatFormServices.isMobile(context)
            ? const EdgeInsets.only(left: 48.0)
            : const EdgeInsets.only(left: 8.0),
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
        ),
      ),
      if (!PlatFormServices.isMobile(context))
        Spacer(flex: PlatFormServices.isDesktop(context) ? 2 : 1),
      if (!PlatFormServices.isMobile(context))
        const Expanded(child: SearchField()),
      /*if (!PlatFormServices.isMobile(context))*/
      const Align(
        child: ProfileCard(),
        alignment: Alignment.centerRight,
      )
    ],
  );
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: InkWell(
        onTap: (){
          context.read<LoginCubit>().logout();
          VxNavigator.of(context).push(Uri.parse(loginScreen));
        },
        child: Card(
          elevation: 2,
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.40),
            margin: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 10, vertical: defaultPadding / 10),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Image.asset("assets/images/profile.png"),
          ),
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        height: 42,
        child: TextField(
          decoration: InputDecoration(
            isDense: true,
            hintText: "Search",
            fillColor: onPrimaryVariantColor,
            filled: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            suffixIcon: InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(defaultPadding * 0.65),
                margin: const EdgeInsets.symmetric(
                    horizontal: defaultPadding / 6,
                    vertical: defaultPadding / 6),
                decoration: const BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset("assets/icons/Search.svg"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
