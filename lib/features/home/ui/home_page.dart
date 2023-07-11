import 'package:flutter/material.dart';
import 'package:flutter_social_media_app/features/home/ui/post_list_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Flexible(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return PostTileWidget();
              },
            ),
          ),
        ],
      ),
    );
  }
}
