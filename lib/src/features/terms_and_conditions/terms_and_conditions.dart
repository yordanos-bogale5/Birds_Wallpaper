import 'package:chatremedy/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/svg.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                    "Terms & Conditions",
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: RichText(
                    text: const TextSpan(
                      text: '''Terms and Conditions
APPTERMS AND CONDITIONS
    
This agreement, binding both individually and on behalf of an entity, is between you and Chatremedy (referred to as "us," "we," ‘’company’ orour"). The agreement pertains to your access to and use of the our mobile application (the "App" or "Application").
    
By downloading and using the App, you acknowledge that you have read, understood, and agreed to be bound by these Terms and Conditions. Failure to agree to these terms will prohibit your use of the App, and you must immediately discontinue use. 
    
Any additional terms, conditions, or documents posted on our app and website from time to time are considered part of this agreement.
We reserve the right to make changes or modifications to these Terms and Conditions at any time and for any reason. Changes will be indicated by updating the "Last updated" date at the bottom of these Terms and Conditions, and you waive the right toreceive separate notice of each change.
It is your responsibility to regularly review these Terms and Conditions to ensure that you are aware of any changes. Continued use of the App after any updates to these Terms and Conditions will signify your acceptance and acknowledgement of such changes. 
    
The Chatremedy App offers convenient and accessible counseling services to individuals seeking anonymity in their support seeking journey.
By simply downloading and utilizing the App, users are confirming their agreement to abide by the guidelines and regulations outlined within this comprehensive Terms and Conditions document.
Through the utilization of one-way video call ordirect message, the App provides a safe and secure platform for individuals toreceive the support they need, whenever they need it. It is imperative that users fully understand and agree to the terms outlined in this document prior to accessing and utilizing the services provided by our App. 
    
''',
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'User Registration\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                '''The registration procedure for our App requires users to establish a distinct andpersonal username and password combination, ensuring the confidentiality and privacy of each user's account information.
In specific circumstances, our trusted payment processing partners, Stripe, may require additional payment information, such as the full name displayed on the credit card utilized for payment purposes.
This additional information is necessary to maintain the security and efficiency of our payment processes and to protect the financial well-being of our users.
It is important for users to fully understand the requirements of the registration process and to provide accurate information to ensure a seamless and secure experience. 
    .\n \n'''),
                        TextSpan(
                          text: 'Payment Processors\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                '''The management of all monetary transactions associated with the counseling services offered through our App is expertly handled by the services of Stripe.
These reputable payment processing organizations ensure the security, efficiency, andaccuracy of all financial transactions and are integral to the smooth functioning of our App.
By utilizing their services, our users can be confidentthat their payments are being processed in a trustworthy and reliable manner,guaranteeing a seamless experience in obtaining the support they need. The integration of Stripe into our platform is a testament to our commitment toproviding our users with the highest quality of services and the safest andmost secure payment processes available. \n\n'''),
                        TextSpan(
                          text: 'Information Collection\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                '''The only information that will be stored by the app in relation to users is their username and date of registration.
Our counsellors must provide full name and professional background information, which will be verified through an employee background check and stored in our database for the purpose of ensuring the legitimacy and legality of our counsellors for the protection of our users.\n\n'''),
                        TextSpan(
                          text: 'Information Protection\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                '''User and counsellor information will never be sold or shared with third-party entities.
The app administrator will not have access to personal direct messages or counselor consultations.
The only information that will be stored is related to transaction details, including time and cost, between users and counsellors. \n\n'''),
                        TextSpan(
                          text: 'Termination of Account\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                '''As a user of the App, you have the ability to choose to end your experience with us atany moment by opting to cancel your registered account. However, it isimportant to note that due to the nature of our platform and the payment structure in place, we are unable to provide any sort of financial compensation or reimbursement to users who choose to terminate their accounts.
Our payment model operates on a per minute basis, where users are charged for the exact amount of time they spend in counseling sessions with our freelance counsellors. Once a user has made a payment for these services, the funds are promptly disbursed to the corresponding counsellor, with a small portion being deducted as the service fee, which is a fee that the platform charges to cover operational costs. 
It is important to note that the service fee,which is charged as a non-refundable amount, is not subject to any form of reimbursement, regardless of the reason for termination of the account.
As such, it is crucial for users to carefully consider their decision to use the platform and make payments for the counseling services, as they will not beeligible for any form of refund or reimbursement once the payment has been processed. \n \n'''),
                        TextSpan(
                          text: 'Liability\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                '''The company acknowledges and understands that the nature of counseling services is highly sensitive and personal, and as such, it has a responsibility to ensure thesafety and security of all users who utilize its platform. Despite the company's best efforts to maintain a secure and stable platform, it is unable to guarantee the outcome of any counseling session between users and counsellors. The company's role is limited to the provision and maintenance ofthe platform, the deployment of state-of-the-art video conferencing software,and the secure processing of payments through the use of reliable third-party payment processing services.The company recognizes that while it has implemented robust security measures to protectuser data and transactions, it cannot guarantee the absolute security of information stored on its servers, or any user's computer or device. The company is not responsible for any unauthorized access to or use of user information, or for any claims arising from professional negligence or poor advice provided by counsellors during counseling sessions. By accessing and utilizing the platform, users acknowledge the limitations and assumptions of liability set forth in these terms and conditions, and agree to use the platform at their own risk.
    
ProfessionalIndemnity and Sensitive Data
The responsibility for any claims of professional negligence or poor advice givenby our counsellors during a counseling session lies solely with the counsellor and not with the company. The company also cannot be held accountable for anybreach of security that may result in the unauthorized access or misuse ofsensitive client data stored on a user's device, including any incidents of hacking. By using the services provided by this app, you agree to be bound by these terms and conditions, which are subject to change at any time without prior notification.It is your responsibility to periodically review these terms to ensure that you are aware of any modifications or updates. Your continued use of the app after any changes have been made signifies your agreement to be bound by the revised terms and conditions. \n \n'''),
                        TextSpan(
                          text: 'Intellectual property\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                '''Unless other wise specified, the App is our proprietary property, and all source code,databases, functionality, software, website designs, audio, video, text,photographs, and graphics contained therein (collectively, the"Content"), as well as the trademarks, service marks, and logos contained therein (collectively, the "Marks"), are owned or controlled by us or licensed to us and are secured by copyright and trademark laws, as well as various other intellectual property and unfair competition laws. The App provides the Content and Marks "AS IS" for your information and personal use.
Except as expressly provided in these Terms of Use, no portion of the App, nor any Content or Marks, may be copied, reproduced, aggregated,republished, uploaded, posted, publicly displayed, encoded, translated,transmitted, distributed, sold, licensed, or otherwise exploited for any commercial purpose.You are granted a limited license to access and use the App, as well as to download orprint a copy of any portion of the Content to which you have obtained proper access, only for your personal, non-commercial use. We retain all rights in andto the App, Content, and Marks that are not expressly granted to you. \n \n'''),
                        TextSpan(
                          text: 'Disclaimer\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                '''Byaccessing and utilizing the services of the Application, you make the following representations and warranties:The information you have provided during registration is accurate, current, and complete.
You are committed to keeping the information updated.You have the legal capacity to agree to these Terms of Use.You are not a minor in the jurisdiction where you reside or have received permission from a parent or guardian if you are a minor.You will not access the App using automated means or methods, such as through the use ofa bot, script, or other automated processes.
You will not use the App for any illegal or unauthorized purposes and will abide by all applicable laws and regulations.Please note that we reserve the right to revoke your access to the App and all current or future use of the App if we discover that the information you have provided is untruthful, outdated, or incomplete.  \n \n'''),
                        TextSpan(
                          text: 'Contact Us\n',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(
                            text:
                                '''In order to resolve a complaint regarding the App or to receive further information regarding use of the App, please contact us at: info@chatremedy.com  
    
CHATREMEDY ARC Ltd
2nd Floor College House,
17 King Edwards Road,
RUISLIP,
London,
HA4 7AE
UnitedKingdom
    
Home
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
