import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tokoto/Models/product.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/widgets/app_app_bar.dart';
import 'package:tokoto/widgets/app_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentIndexProvider = StateProvider<int>((ref) {
  return 0;
});

class FeedbackProductScreen extends ConsumerStatefulWidget {
  final ProductModel product;

  const FeedbackProductScreen({required this.product, Key? key})
      : super(key: key);

  @override
  ConsumerState<FeedbackProductScreen> createState() =>
      _FeedbackProductScreenState();
}

class _FeedbackProductScreenState extends ConsumerState<FeedbackProductScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const AppAppBar(text: 'Feedback', automaticallyImplyLeading: true),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Stack(
                  children: [
                     Center(
                      child: CircleAvatar(
                        radius: 90,
                        backgroundColor: Theme.of(context).backgroundColor,
                      ),
                    ),
                    Center(
                      child: Image.network(
                        widget.product.images!.entries.first.value.first,
                        width: 300,
                        height: 200,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              SizedBox(
                height: 60,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        ref.read(currentIndexProvider.state).state = index;
                      },
                      child: Container(
                        margin: const EdgeInsetsDirectional.only(
                            end: kDefaultPadding / 3),
                        padding: const EdgeInsets.all(kDefaultPadding / 2),
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SvgPicture.asset(
                          ref.watch(currentIndexProvider) > index-1
                              ? 'images/Star Icon.svg'
                              : 'images/Star Icon 5.svg',
                          width: 25,
                          height: 25,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              SizedBox(
                width: double.infinity,
                height: 200,
                child: TextField(
                  expands: true,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: controller,
                  style:  TextStyle(
                    color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.6),
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    hintText: 'Add your Comment',
                    hintStyle:  TextStyle(
                      color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.6),
                      fontSize: 18,
                    ),
                    label:  Text(
                      'Comment',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.6),
                        fontSize: 20,
                      ),
                    ),
                    alignLabelWithHint: true,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: kDefaultPadding,
                        vertical: kDefaultPadding / 2),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide:  BorderSide(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide:  BorderSide(
                        color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.7),
                      ),
                    ),

                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              AppButton(text: 'Submit', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
