import 'package:chatremedy/src/features/authorization/provider/user_provider.dart';
import 'package:chatremedy/src/features/authorization/widgets/text_form_field.dart';
import 'package:chatremedy/src/features/profile/provider/send_email.dart';
import 'package:chatremedy/src/utils/colors.dart';
import 'package:chatremedy/src/utils/show_loader_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SupportSheet extends ConsumerStatefulWidget {
  const SupportSheet({super.key});

  @override
  ConsumerState<SupportSheet> createState() => _SupportSheetState();
}

class _SupportSheetState extends ConsumerState<SupportSheet> {
  String selectedType = "General Feedback";

  final username = TextEditingController();
  final message = TextEditingController();

  final List<String> types = [
    "General Feedback",
    "Report a Bug",
    "Report a Counsellor"
  ];

  @override
  void initState() {
    Future(setUserName);
    super.initState();
  }

  setUserName() {
    final user = ref.watch(userProvider);
    username.text = user.user?.username ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 4,
            width: 100,
            decoration: BoxDecoration(
                color: AppColors.hintColor.withOpacity(0.5),
                borderRadius: BorderRadius.circular(30)),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Support',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                  backgroundColor: AppColors.hintColor.withOpacity(0.1),
                  hintText: "Username",
                  controller: username),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.hintColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: DropdownButton(
                    underline: const SizedBox(),
                    isExpanded: true,
                    value: selectedType,
                    items: [
                      ...types.map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedType = value ?? "General Feedback";
                      });
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Message',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                backgroundColor: AppColors.hintColor.withOpacity(0.1),
                hintText: "Message..",
                controller: message,
                maxLine: 5,
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  showLoaderDialog(context);
                  FocusScope.of(context).unfocus();
                  final result = await sendEmail({
                    'user_name': username.text,
                    'user_email': user.user!.email!,
                    'user_subject': selectedType,
                    'user_message': message.text
                  });
                  if (result) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: "Email Sent Successfully");
                  } else {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Fluttertoast.showToast(
                        msg: "Error occurred while sending email");
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Send",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          )
        ],
      ),
    );
  }

  // sendEmail() async {
  //   final Email email = Email(
  //     body: "${message.text} \n\nThank You.\nRegard ${username.text}",
  //     subject: selectedType,
  //     recipients: ['report@chatremedy.com'],
  //     isHTML: false,
  //   );
  //
  //   await FlutterEmailSender.send(email).then((val) {
  //     Navigator.pop(context);
  //   });
  // }
}
