import 'package:flutter/material.dart';
import 'package:setting_app/ui_widget/appbar.dart';
import '../Utility/colors.dart';
import '../ui_widget/robotoTextWidget.dart';
import '../utility/string.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var isLoading = false;
  String inputValue = "Work hard";
  List<String> _textFields = List.generate(20, (index) => 'hello') ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textFields[0]="Well Done";
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          AppBarWidget(
            pagetitle: appName,
          ),
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.07),

            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return cardWidget(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  cardWidget(int index) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [getterWidget(), editWidget(index), setterWidget()],
        ),
      ),
    );
  }

  getterWidget() {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(6),
        width: 70,
        height: 35,
        decoration: const BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Center(
          child: robotoTextWidget(
              textval: get,
              colorval: AppColors.white,
              sizeval: 20,
              fontWeight: FontWeight.w400),
        ),
      ),
      onTap: () {},
    );
  }

  setterWidget() {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(6),
        width: 70,
        height: 35,
        decoration: const BoxDecoration(
          color: AppColors.blue,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Center(
          child: robotoTextWidget(
              textval: set,
              colorval: AppColors.white,
              sizeval: 20,
              fontWeight: FontWeight.w400),
        ),
      ),
      onTap: () {},
    );
  }

  editWidget(int key) {
    return Container(
      margin: const EdgeInsets.all(6),
      width: 150,
      height: 50,
      child: TextFormField(
        initialValue:  _textFields[key],
        decoration: InputDecoration(
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey), //<-- SEE HERE
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field can not be empty';
          }
          return null;
        },
        onChanged: (value) {
          // Handle input changes
          onUpdate(key,value);
        },
        onSaved: (newValue) {
          // Handle the saved input value

        },
      ),
    );
  }

  void onUpdate(int key, String value) {

    print( _textFields[key] = value);

  }
}
