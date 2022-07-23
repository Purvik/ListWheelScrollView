import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'List Wheel Scroll View'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "Normal List View",
            ),
            Tab(
              text: "Wheel Scroll View",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Center(
            child: _normalList(),
          ),
          Center(
            // child: _wheelScrollViewType1(),
            child: _wheelScrollViewType2(),
          ),
        ],
      ),
    );
  }

  Widget _wheelScrollViewType1() => ListWheelScrollView(
        itemExtent: 40,
        physics: const FixedExtentScrollPhysics(),
        overAndUnderCenterOpacity: 0.5,
        children: _listItems(),
      );

  Widget _wheelScrollViewType2() => ListWheelScrollView.useDelegate(
        itemExtent: 50,
        physics: const FixedExtentScrollPhysics(),
        overAndUnderCenterOpacity: 0.5,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: 20,
          builder: (BuildContext context, int index) => _containerItem(index),
        ),
      );

  Widget _normalList() => ListView(
        children: _listItems(),
      );

  List<Widget> _listItems() => List.generate(
        25,
        (index) => _containerItem(index),
      );

  Widget _listWheelScrollView() => ListWheelScrollView(
        itemExtent: 80,
        physics: const FixedExtentScrollPhysics(),
        overAndUnderCenterOpacity: 0.5,
        children: List.generate(
          30,
          (index) => Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              border: Border.all(
                width: 2.0,
                color: Colors.black45,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              '${index + 1}',
              style: Theme.of(context).textTheme.subtitle2,
            ),
          ),
        ),
      );

  Widget _containerItem(int index) {
    return Container(
      height: 60,
      width: 60,
      margin: const EdgeInsets.symmetric(
        horizontal: 12.0,
        vertical: 4.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
        border: Border.all(
          width: 2.0,
          color: Colors.black45,
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        '${index + 1}',
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }
}
