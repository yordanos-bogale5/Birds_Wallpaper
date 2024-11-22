import 'package:chatremedy/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/svg.dart';

class PrivacyPolicies extends StatelessWidget {
  const PrivacyPolicies({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          SizedBox(height: 50,),
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            shape: BoxShape.circle),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        margin: const EdgeInsets.only(right: 20),
                        child: SvgPicture.asset(AppSvg.arrowBack)),
                  ),
                  const Text(
                    "Privacy Policy",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              )),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 0),
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  child: RichText(
                    text: const TextSpan(
                      text: '''Privacy Policy
Effective Date: 1st February 2023
    
ChatRemedy ARC Ltd (“ChatRemedy” or “We”) is committed to protecting the privacy and security of our users. This privacy policy (the “Policy”) explains how we collect, use, and share your personal information when you use our IOS mobile application called ChatRemedy (the “App”) and visit our website www.ChatRemedy.com (the “Site”). This Policy is intended to comply with the General Data Protection Regulation (GDPR) and other applicable data protection laws. By using the App and the Site, you consent to the collection, use, and sharing of your personal information as described in this Policy \n.
''',
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Information We May Collect\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                '''When you create a profile on our App, we may collect your nickname and email address. We do not collect any other personal information.
Any personal information provided by the user during a counseling session will be accessed and stored by the third-party therapist responsible for the user’s personal data. We do not store any personal information of our users, including names, addresses, phone numbers, or email addresses. We do not have access to or strip any identifiable data, such as email, from user-provided personal information.
We do not store, on our database, any personal information that could identify our users, including but not limited to names, addresses, phone numbers, or email addresses.
We do not have access to a user’s private messages or calls. However, a counsellor who freelances on our App may decide to pass information to authorities.
We do not use social media login information, and we do not track geolocation. We do not start contracts with our users.
How We Use Your Information
    
We use your nickname and email address to provide you with access to the App and the services we offer. We do not sell your personal information or share it with third parties, except as necessary to provide the services you request, or as required by law.
How We Share Your Information
Under exceptional circumstances if you have provided us any personal information voluntarily, we do not share that information with third parties, except as necessary to provide the services you request, or as required by law.\n \n'''),
                        TextSpan(
                          text: 'Your Rights\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                'You have the right to access and erase your personal information, as well as the right to data portability. You may also object to the processing of your personal information or withdraw your consent at any time. To exercise these rights, you can simply delete your profile and uninstall the app.\n\n'),
                        TextSpan(
                          text: 'Security\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                'We take reasonable and appropriate measures to protect your information from unauthorized access, disclosure, alteration, and destruction. However, no method of transmission over the Internet or method of electronic storage is 100% secure. Therefore, we cannot guarantee its absolute security.\n\n'),
                        TextSpan(
                          text: 'Privacy\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                'At our company, we take privacy very seriously, and we are committed to protecting the confidentiality and security of our users’ personal information. As part of this commitment, we require that users of our app do not engage in any activity that violates the privacy rights of others. Specifically, users are not permitted to screen record or take screenshots of any content within the app, and are not allowed to share any such content via social media, video sessions, private messages, or therapist profiles. Any such activity will be considered a breach of our privacy policy and may result in immediate termination of the user’s account. We reserve the right to take legal action if necessary to protect the privacy rights of our users.\n\n'),
                        TextSpan(
                          text: 'Changes to This Policy\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                'We may update this Policy from time to time. If we make any material changes, we will notify you by posting the updated Policy on the Site or by sending you an email. Your continued use of the App and the Site after the effective date of the updated Policy constitutes your acceptance of the updated Policy.\n \n'),
                        TextSpan(
                          text: 'Contact Us\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                'If you have any questions or concerns about this Policy, please contact us at info@chatremedy.com.\n \n'),
                        TextSpan(text: '''Home
Work with us
Contact Us
Terms and Conditions
Privacy Policy
    
© 2023 – All Rights Reserved – Chatremedy'''),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
