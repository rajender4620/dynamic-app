// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hni_customers_app/blocs/homepage/cubit/homepage_cubit.dart';
// import 'package:hni_customers_app/blocs/homepage/widget/hintcustomerform_page.dart';
// import 'package:hni_customers_app/blocs/homepage/widget/user_widget.dart';
// import 'package:hni_customers_app/core/app_theme.dart';
// import 'package:hni_customers_app/model/hni_customer_met_model.dart';
// import 'package:hni_customers_app/utils/shared_preference.dart';

// class HomePage extends StatelessWidget {
//   const HomePage({required this.toggleTheme, super.key});
//   final VoidCallback toggleTheme;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) {
//         final cubit = HomepageCubit()..init();
//         return cubit;
//       },
//       child: Builder(
//         builder: (context) {
//           final theme = MyAppTheme.getTheme(Theme.of(context).brightness);

//           return Scaffold(
//             backgroundColor: theme.scaffoldBackgroundColor,
//             appBar: AppBar(
//               title: const Text(
//                 'Dynamic Form App',
//                 style: TextStyle(
//                   color: Colors.white,
//                 ),
//               ),
//               actions: [
//                 IconButton(
//                   icon: const Icon(Icons.brightness_6),
//                   onPressed: toggleTheme,
//                 ),
//               ],
//             ),
//             body: BlocBuilder<HomepageCubit, HomepageState>(
//               builder: (context, state) {
//                 if (state is HomepageInitial) {
//                   return const Center(child: Text('Initializing...'));
//                 } else if (state is HomepageFailed) {
//                   return Center(
//                     child: Text(state.errorMessage),
//                   );
//                 } else if (state is HomepageLoaded) {
//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       const SizedBox(height: 5),
//                       ElevatedButton(
//                         onPressed: () {
//                           Navigator.push<void>(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => DynamicForm(
//                                 hniCustomerMetResponce:
//                                     state.hniCustomerMetResponce,
//                                 allForms: state.formData,
//                               ),
//                             ),
//                           );
//                         },
//                         child: const Text('HNI Customer Met'),
//                       ),
//                       const SizedBox(height: 10),
//                       const Divider(),
//                       const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 8),
//                         child: Center(
//                           child: Text(
//                             'Saved User Data',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                       ),
//                       FutureBuilder<HniCustomerMetResponce?>(
//                         future: SharedPreferencesHelper.loadLatestUserData(),
//                         builder: (context, snapshot) {
//                           if (snapshot.connectionState ==
//                               ConnectionState.waiting) {
//                             return const Center(
//                               child: CircularProgressIndicator(),
//                             );
//                           } else if (!snapshot.hasData ||
//                               snapshot.data == null) {
//                             return const Center(
//                               child: Text('No saved user data found.'),
//                             );
//                           }

//                           final savedData = snapshot.data!;
//                           return Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16),
//                             child: Card(
//                               child: ListTile(
//                                 title: Text(
//                                   savedData.data?.getUserForm?.name ??
//                                       'Unnamed Form',
//                                 ),
//                                 subtitle: const Text(
//                                   'Tap to view saved responses.',
//                                 ),
//                                 onTap: () {
//                                   Navigator.push<void>(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => ViewSavedDataScreen(
//                                         savedData: savedData,
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//                   );
//                 }
//                 return Container();
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hni_customers_app/blocs/homepage/cubit/homepage_cubit.dart';
import 'package:hni_customers_app/blocs/homepage/widget/hintcustomerform_page.dart';
import 'package:hni_customers_app/blocs/homepage/widget/user_widget.dart';
import 'package:hni_customers_app/core/app_theme.dart';
import 'package:hni_customers_app/model/hni_customer_met_model.dart';
import 'package:hni_customers_app/utils/shared_preference.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.toggleTheme, super.key});
  final VoidCallback toggleTheme;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = HomepageCubit()..init();
        return cubit;
      },
      child: Builder(
        builder: (context) {
          final theme = MyAppTheme.getTheme(Theme.of(context).brightness);

          return Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              title: const Text(
                'Dynamic Form App',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.brightness_6),
                  onPressed: toggleTheme,
                ),
              ],
            ),
            body: BlocBuilder<HomepageCubit, HomepageState>(
              builder: (context, state) {
                if (state is HomepageInitial) {
                  return const Center(child: Text('Initializing...'));
                } else if (state is HomepageFailed) {
                  return Center(
                    child: Text(state.errorMessage),
                  );
                } else if (state is HomepageLoaded) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push<void>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DynamicForm(
                                    hniCustomerMetResponce:
                                        state.hniCustomerMetResponce,
                                    allForms: state.formData,
                                  ),
                                ),
                              );
                            },
                            child: const Text('HNI Customer Met'),
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(
                                'Saved User Data',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          FutureBuilder<HniCustomerMetResponce?>(
                            future:
                                SharedPreferencesHelper.loadLatestUserData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (!snapshot.hasData ||
                                  snapshot.data == null) {
                                return const Center(
                                  child: Text('No saved user data found.'),
                                );
                              }

                              final savedData = snapshot.data!;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Card(
                                  child: ListTile(
                                    title: Text(
                                      savedData.data?.getUserForm?.name ??
                                          'Unnamed Form',
                                    ),
                                    subtitle: const Text(
                                      'Tap to view saved responses.',
                                    ),
                                    onTap: () {
                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ViewSavedDataScreen(
                                            savedData: savedData,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
                return Container();
              },
            ),
          );
        },
      ),
    );
  }
}
