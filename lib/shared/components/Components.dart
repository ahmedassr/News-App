import 'package:first_app/modules/web_view/WebView.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(list, context) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MyWebView(url: list['url'])));
      },
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage('${list['urlToImage']}')),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text('${list['title']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),
                  Text(
                    '${list['publishedAt']}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, color: Colors.grey),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget customListBuilder(list, context, {isSearch = false}) {
  return list.isNotEmpty
      ? ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return buildArticleItem(list[index], context);
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: 10)
      : isSearch
          ? const Center()
          : const Center(
              child: CircularProgressIndicator(),
            );
}

Widget customSearchBar({
  required hint,
  required TextEditingController controller,
  required Function(String) onChange,
  required String? Function(String?)? validate,
}) {
  return Container(
    height: 40,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: TextFormField(
          controller: controller,
          onChanged: onChange,
          validator: validate,
          enabled: true,
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              label: Text(hint),
              border: InputBorder.none),
        )),
  );
}
