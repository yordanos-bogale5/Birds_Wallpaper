import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatremedy/src/features/authorization/provider/user_provider.dart';
import 'package:chatremedy/src/features/favourities/views/favourities_screen.dart';
import 'package:chatremedy/src/features/profile/widget/profile_tile.dart';
import 'package:chatremedy/src/features/profile/widget/support_sheet.dart';
import 'package:chatremedy/src/features/security/views/security_screen.dart';
import 'package:chatremedy/src/features/terms_and_conditions/privacy_policy.dart';
import 'package:chatremedy/src/features/terms_and_conditions/terms_and_conditions.dart';
import 'package:chatremedy/src/features/wallet/views/wallet_screen.dart';
import 'package:chatremedy/src/utils/colors.dart';
import 'package:chatremedy/src/utils/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/hex_to_color.dart';
import '../../../utils/text_avatar.dart';
import '../provider/logout.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider).user!;
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                children: [
                  Text(
                    "Account",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              )),
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20))),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  user.avatar == null || user.avatar == ""
                      ? TextAvatar(
                          shape: BoxShape.circle,
                          size: 100,
                          text: '${user.username?.toUpperCase()}',
                          fontSize: 35,
                          color: hexToColor(user.avatarColor ?? "#452e28"),
                        )
                      : CachedNetworkImage(
                          imageUrl: "${user.avatar}",
                          imageBuilder: (context, imageProvider) => Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${user.username}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${user.email}",
                    style: const TextStyle(
                        color: AppColors.hintColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: AppColors.formFieldColor,
                        borderRadius: BorderRadius.circular(20)),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        ProfileTile(
                          svg: AppSvg.heartOutlined,
                          title: "Favourities",
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const FavouritesScreen(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                              // MaterialPageRoute(
                              //     builder: (context) =>
                              //         const FavouritesScreen())
                            );
                          },
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        ProfileTile(
                          svg: AppSvg.wallet,
                          title: "Wallet",
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        WalletScreen(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                              // MaterialPageRoute(
                              //     builder: (context) => WalletScreen())
                            );
                          },
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        ProfileTile(
                          svg: AppSvg.security,
                          title: "Security",
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const SecurityScreen(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                              // MaterialPageRoute(
                              //     builder: (context) =>
                              //         const SecurityScreen())
                            );
                          },
                        ),
                        const SizedBox(
                          height: 26,
                        ),
                        ProfileTile(
                          svg: AppSvg.support,
                          title: "Support",
                          onTap: () {
                            _showSupportBottomSheet(context);
                          },
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const TermsAndConditions(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                              // MaterialPageRoute(
                              //     builder: (context) =>
                              //         const TermsAndConditions())
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2))),
                            alignment: Alignment.center,
                            child: const Text(
                              "Terms of services",
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation1, animation2) =>
                                        const PrivacyPolicies(),
                                transitionDuration: Duration.zero,
                                reverseTransitionDuration: Duration.zero,
                              ),
                              // MaterialPageRoute(
                              //     builder: (context) =>
                              //         const PrivacyPolicies())
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.2))),
                            alignment: Alignment.center,
                            child: const Text(
                              "Privacy Policy",
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      logOut(context, ref);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.2))),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AppSvg.logout),
                          const Text(
                            " Log Out",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }

  void _showSupportBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const SupportSheet(),
        );
      },
    );
  }
}
