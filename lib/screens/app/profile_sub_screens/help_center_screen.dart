import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tokoto/constant/constant.dart';
import 'package:tokoto/widgets/app_app_bar.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppAppBar(text: 'Help Center'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FAQ',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: kDefaultPadding / 2),
              ExpansionTile(
                childrenPadding: const EdgeInsets.all(kDefaultPadding / 3),
                title: const Text(
                  'How does warranty work on tokoto?',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                children: [
                  Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy',
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 18,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.6),
                    ),
                  )
                ],
              ),
              const Divider(),
              ExpansionTile(
                childrenPadding: const EdgeInsets.all(kDefaultPadding / 3),
                title: const Text(
                  'How long is my order delivery time?',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                children: [
                  Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy',
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 18,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.6),
                    ),
                  )
                ],
              ),
              const Divider(),
              ExpansionTile(
                childrenPadding: const EdgeInsets.all(kDefaultPadding / 3),
                title: const Text(
                  'How to become a tokoto seller?',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                children: [
                  Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy',
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 18,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.6),
                    ),
                  )
                ],
              ),
              const Divider(),
              ExpansionTile(
                childrenPadding: const EdgeInsets.all(kDefaultPadding / 3),
                title: const Text(
                  'How does warranty work on tokoto?',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                children: [
                  Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy',
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 18,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.6),
                    ),
                  )
                ],
              ),
              const Divider(),
              ExpansionTile(
                childrenPadding: const EdgeInsets.all(kDefaultPadding / 3),
                title: const Text(
                  'Why I don\'t accept otp on my phone?',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                children: [
                  Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy',
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 18,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.6),
                    ),
                  )
                ],
              ),
              const Divider(),
              ExpansionTile(
                childrenPadding: const EdgeInsets.all(kDefaultPadding / 3),
                title: const Text(
                  'How to rate my order products?',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                children: [
                  Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy',
                    style: TextStyle(
                      height: 1.5,
                      fontSize: 18,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.6),
                    ),
                  )
                ],
              ),
              const Divider(),
              const SizedBox(height: kDefaultPadding),
              const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Theme.of(context).backgroundColor,
                  child: SvgPicture.asset('images/Conversation.svg'),
                ),
                title: const Text(
                  'Chat Tokoto now',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  'You can chat with us here',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(0.6),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Theme.of(context).backgroundColor,
                  child: SvgPicture.asset('images/Mail.svg'),
                ),
                title: const Text(
                  'Send Email',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  'Send your question or problem',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(0.6),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundColor: Theme.of(context).backgroundColor,
                  child: SvgPicture.asset('images/Call.svg'),
                ),
                title: const Text(
                  'Costumer Service',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  '1800806',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(0.6),
                  ),
                ),
              ),
              const SizedBox(height: kDefaultPadding),
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(
                  '© Copyright 2022 - Mohamed Abosido',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(0.6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
