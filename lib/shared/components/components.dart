import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/cubit/cubit.dart';

Widget defaultButton({
  required double width, // = double.infinity,
  required Color backgroud,
  required Function function,
  required String text, //= Colors.blue
}) =>
    Container(
      width: width,
      color: backgroud,
      child: MaterialButton(
        onPressed: (){
          function();
        },
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

//////////////////////////////

////////////////

    

/////////////
// Widget buildArticleItem(article, context) => InkWell(
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             Container(
//               width: 120,
//               height: 120,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   image: DecorationImage(
//                       image: NetworkImage('${article['urlToImage']}'),
//                       fit: BoxFit.cover)),
//             ),
//             SizedBox(
//               width: 20,
//             ),
//             Expanded(
//               child: Container(
//                 height: 120,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: Text(
//                         '${article['title']}',
//                         style: Theme.of(context).textTheme.bodyText1,
//                         maxLines: 3,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                     Text(
//                       '${article['publishedAt']}',
//                       style: TextStyle(color: Colors.grey),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       onTap: () {
//         navigateTo(context, WebViewScreen(article['url']));
//       },
//     );

///////////
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey[300],
      ),
    );
////////////////////

// Widget articleBuilder(list, context, {isSearch = false}) => ConditionalBuilder(
//       condition: list.length > 0,
//       builder: (context) => ListView.separated(
//         physics: BouncingScrollPhysics(),
//         itemBuilder: (context, index) => buildArticleItem(list[index], context),
//         separatorBuilder: (context, index) => myDivider(),
//         itemCount: 10,
//       ),
//       fallback: (context) => isSearch
//           ? Container()
//           : Center(
//               child: CircularProgressIndicator(),
//             ),
//     );

////////////////////

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

////////////////////

void navigateAndReplacement(context, widget) =>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => widget),
        // (Route<dynamic> route) => false,
        (route){
          return false;
        }
    );
