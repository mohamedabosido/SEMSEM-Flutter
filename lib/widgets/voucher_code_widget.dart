import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tokoto/api/controller/cart_api_controller.dart';
import 'package:tokoto/api/controller/voucher_code_api_controller.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/helpers/helpers.dart';
import 'package:tokoto/widgets/app_button.dart';
import 'package:tokoto/widgets/app_text_field.dart';

class VoucherCodeWidget extends ConsumerStatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const VoucherCodeWidget({
    required this.text,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _VoucherCodeWidgetState();
}

class _VoucherCodeWidgetState extends ConsumerState<VoucherCodeWidget>
    with Helpers {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).backgroundColor.withOpacity(0.15),
            offset: const Offset(0, -20),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(kDefaultPadding / 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).backgroundColor,
                ),
                child: SvgPicture.asset(
                  'images/receipt.svg',
                  width: 25,
                  height: 25,
                ),
              ),
              TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    context: context,
                    builder: (context) => const VoucherCodeValidation(),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      'Add voucher code',
                      style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            ?.color
                            ?.withOpacity(0.6),
                        fontSize: 18,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.6),
                      size: 18,
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Total:',
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.6),
                      fontSize: 18,
                    ),
                  ),
                  ref.watch(cartTotalProvider).when(
                      data: (data) => Text(
                            '\$ $data',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color,
                              fontSize: 24,
                            ),
                          ),
                      error: (error, stackTrace) => Text(
                            '\$ ${ref.watch(cartsProvider.notifier).getTotal()}',
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color,
                              fontSize: 24,
                            ),
                          ),
                      loading: () => const CupertinoActivityIndicator(
                            radius: 15,
                            animating: true,
                          )),
                ],
              ),
              AppButton(
                  text: widget.text, onPressed: widget.onPressed, width: 190),
            ],
          ),
        ],
      ),
    );
  }
}

class VoucherCodeValidation extends ConsumerStatefulWidget {
  const VoucherCodeValidation({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _VoucherCodeValidationState();
}

class _VoucherCodeValidationState extends ConsumerState<VoucherCodeValidation> {
  late TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final voucherCodeState = ref.watch(voucherCodeProvider);
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        children: [
          AppTextField(
            labelText: 'Voucher Code',
            hintText: 'Enter Voucher Code',
            suffixIcon: Icons.discount_outlined,
            textInputType: TextInputType.text,
            controller: controller,
            autofocus: true,
            textInputAction: TextInputAction.search,
          ),
          const SizedBox(height: kDefaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButton(
                text: 'ADD',
                onPressed: () {
                  if (controller.text.length > 2) {
                    ref.read(codeProvider.notifier).state = controller.text;
                  }
                },
                width: 200,
              ),
              voucherCodeState.when(data: (data) {
                return Row(
                  children: [
                    const Text(
                      'Total is: ',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      '\$ ${ref.watch(cartTotalProvider).value}',
                      style: const TextStyle(
                          color: kPrimaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                );
              }, error: (error, stack) {
                return const Text(
                  'No Voucher Code!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }, loading: () {
                return const CupertinoActivityIndicator(
                  radius: 25,
                  animating: true,
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
