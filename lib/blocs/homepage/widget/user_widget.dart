// import 'package:flutter/material.dart';
// import 'package:hni_customers_app/model/hni_customer_met_model.dart';

// class ViewSavedDataScreen extends StatelessWidget {
//   const ViewSavedDataScreen({required this.savedData, super.key});

//   final HniCustomerMetResponce savedData;

//   @override
//   Widget build(BuildContext context) {
//     final questions = savedData.data?.getUserForm?.questions;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           savedData.data?.getUserForm?.name ?? 'Saved Responses',
//           style: const TextStyle(color: Colors.white),
//         ),
//       ),
//       body: questions == null || questions.isEmpty
//           ? const Center(
//               child: Text(
//                 'No responses found.',
//                 style: TextStyle(fontSize: 16),
//               ),
//             )
//           : ListView.builder(
//               padding: const EdgeInsets.all(16),
//               itemCount: questions.length,
//               itemBuilder: (context, index) {
//                 final question = questions[index];
//                 return _buildQuestionCard(question);
//               },
//             ),
//     );
//   }

//   Widget _buildQuestionCard(Question question) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               question.question ?? 'No Question Text',
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             if (question.userResponse != null) ...[
//               Text(
//                 '${question.userResponse}',
//                 style: const TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//             ],
//             if (question.questionType == 'FORM' &&
//                 question.options != null) ...[
//               const SizedBox(height: 8),
//               Column(
//                 children: question.options!.map(_buildNestedQuestions).toList(),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNestedQuestions(Option option) {
//     if (option.questions == null || option.questions!.isEmpty) {
//       return Container();
//     }

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: option.questions!.map((nestedQuestion) {
//         return Padding(
//           padding: const EdgeInsets.only(left: 12, bottom: 8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 nestedQuestion.question ?? 'No Question Text',
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 '${nestedQuestion.userResponse ?? 'No Response'}',
//                 style: const TextStyle(fontSize: 14, color: Colors.grey),
//               ),
//               if (nestedQuestion.questionType == 'FORM' &&
//                   nestedQuestion.options != null)
//                 Column(
//                   children: nestedQuestion.options!
//                       .map(_buildNestedQuestions)
//                       .toList(),
//                 ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hni_customers_app/model/hni_customer_met_model.dart';

class ViewSavedDataScreen extends StatelessWidget {
  const ViewSavedDataScreen({required this.savedData, super.key});

  final HniCustomerMetResponce savedData;

  @override
  Widget build(BuildContext context) {
    final questions = savedData.data?.getUserForm?.questions;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          savedData.data?.getUserForm?.name ?? 'Saved Responses',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: questions == null || questions.isEmpty
          ? const Center(
              child: Text(
                'No responses found.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                return _buildQuestionCard(question);
              },
            ),
    );
  }

  Widget _buildQuestionCard(Question question) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question.question ?? 'No Question Text',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (question.userResponse != null) ...[
              Text(
                _formatUserResponse(question),
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
            if (question.questionType == 'FORM' &&
                question.options != null) ...[
              const SizedBox(height: 8),
              Column(
                children: question.options!.map(_buildNestedQuestions).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildNestedQuestions(Option option) {
    if (option.questions == null || option.questions!.isEmpty) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: option.questions!.map((nestedQuestion) {
        return Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nestedQuestion.question ?? 'No Question Text',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatUserResponse(nestedQuestion),
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              if (nestedQuestion.questionType == 'FORM' &&
                  nestedQuestion.options != null)
                Column(
                  children: nestedQuestion.options!
                      .map(_buildNestedQuestions)
                      .toList(),
                ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _formatUserResponse(Question question) {
    if (kIsWeb) {
      // Web-specific formatting
      return 'Web Response: ${question.userResponse ?? 'No Response'}';
    } else if (Platform.isAndroid || Platform.isIOS) {
      // Mobile-specific formatting
      return 'Mobile Response: ${question.userResponse ?? 'No Response'}';
    } else {
      // Fallback for other platforms
      return 'Response: ${question.userResponse ?? 'No Response'}';
    }
  }
}
