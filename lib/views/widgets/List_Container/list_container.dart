import 'package:flutter/material.dart';

class ListContainer extends StatelessWidget {
  ListContainer(
      {super.key,
      required this.title,
      required this.desc,
      required this.date,
      this.onDelete,
      this.onEdit,
      this.onShare, required this.col});
  final Color col;
  final String title;
  final String desc;
  final String date;
  final void Function()? onDelete;
  final void Function()? onEdit;
  final void Function()? onShare;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: 600,
        minHeight: 200,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        // height: MediaQuery.of(context).size.height / 5,
        height: 200,
        decoration:
            BoxDecoration(color: col, borderRadius: BorderRadius.circular(18)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        desc,
                        maxLines: 3,
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white60,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: onEdit,
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                        )),
                    IconButton(
                        onPressed: onDelete,
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        )),
                  ],
                )
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
