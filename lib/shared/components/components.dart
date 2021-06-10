import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

//button
Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0.0,
  @required String text,
  @required Function function,
}) => Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: MaterialButton(
        onPressed: function,
        child: Text(isUpperCase ? text.toUpperCase() : text),
      ),
    );

//form field

Widget defaultFormfield({
  @required TextEditingController controller,
  @required TextInputType type,
  Function submit,
  Function change,
  IconData suffix,
  bool isPassword = false,
  Function onTapped,
  bool clickable = true,
  Function suffixpress,
  TextStyle stylelabel,
  @required Function validate,
  @required String textlabel,
  @required IconData prefix,
}) => TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: submit,
      onChanged: change,
      enabled: clickable,
      onTap: onTapped,
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelStyle: stylelabel,
        labelText: textlabel,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: IconButton(
          onPressed: suffixpress,
          icon: Icon(
            suffix,
          ),
        ),
        border: OutlineInputBorder(),
      ),
    );
//text button
Widget defaultTextButton({@required Function function, @required String text}) => TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

//Navigation's

void navigateTo(context, widget) => Navigator.push(context, MaterialPageRoute(builder: (context) => widget));


void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
        (route) => false,
  );





Widget newsBuilder(article, context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      Container(
        height: 120.0,
        width: 120.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          "${article['urlToImage']}",
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Container(
          height: 120,
          width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  "${article['title']}",
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // SizedBox(height: 20.0,),

              Text(
                "${article['publishedAt']}",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      )
    ],
  ),
);

Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
      condition: list.length > 0,
      builder: (context) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) => newsBuilder(list[index], context),
          separatorBuilder: (context, index) => Container(
            height: 1,
            color: Colors.grey,
            margin: EdgeInsetsDirectional.only(start: 20.0),
          ),
        );
      },
      fallback: (context) => isSearch
          ? Container()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );


Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

