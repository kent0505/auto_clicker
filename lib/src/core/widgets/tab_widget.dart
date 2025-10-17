import 'package:flutter/material.dart';

import '../constants.dart';

class TabWidget extends StatefulWidget {
  const TabWidget({
    super.key,
    required this.titles,
    required this.pages,
  });

  final List<String> titles;
  final List<Widget> pages;

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.titles.length,
      animationDuration: Duration.zero,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        _selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<MyColors>()!;

    return Column(
      children: [
        Container(
          height: 52,
          margin: const EdgeInsets.symmetric(
            horizontal: Constants.padding,
          ).copyWith(bottom: Constants.padding / 2),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: colors.tile,
            borderRadius: BorderRadius.circular(Constants.radius),
          ),
          child: TabBar(
            controller: _tabController,
            indicatorColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(Constants.radius),
              color: _tabController.index == _selectedIndex ? colors.bg : null,
            ),
            labelStyle: TextStyle(
              color: colors.text,
              fontSize: 16,
              fontFamily: AppFonts.w500,
            ),
            unselectedLabelStyle: TextStyle(
              color: colors.text2,
              fontSize: 16,
              fontFamily: AppFonts.w500,
            ),
            tabs: List.generate(
              widget.titles.length,
              (index) {
                return Tab(text: widget.titles[index]);
              },
            ),
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: widget.pages,
          ),
        ),
      ],
    );
  }
}
