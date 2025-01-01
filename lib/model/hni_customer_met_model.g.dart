// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hni_customer_met_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HniCustomerMetResponce _$HniCustomerMetResponceFromJson(
        Map<String, dynamic> json,) =>
    HniCustomerMetResponce(
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$HniCustomerMetResponceToJson(
        HniCustomerMetResponce instance,) =>
    <String, dynamic>{
      'data': instance.data,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      typename: json['__typename'] as String?,
      getUserForm: json['getUserForm'] == null
          ? null
          : GetUserForm.fromJson(json['getUserForm'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      '__typename': instance.typename,
      'getUserForm': instance.getUserForm,
    };

GetUserForm _$GetUserFormFromJson(Map<String, dynamic> json) => GetUserForm(
      typename: json['__typename'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      formUuid: json['formUuid'] as String?,
      isEditable: json['isEditable'] as bool?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetUserFormToJson(GetUserForm instance) =>
    <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'name': instance.name,
      'formUuid': instance.formUuid,
      'isEditable': instance.isEditable,
      'questions': instance.questions,
    };

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      typename: json['__typename'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      formUuid: json['formUuid'] as String?,
      isEditable: json['isEditable'] as bool?,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      option: json['option'] as String?,
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'name': instance.name,
      'formUuid': instance.formUuid,
      'isEditable': instance.isEditable,
      'questions': instance.questions,
      'option': instance.option,
    };

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      typename: json['__typename'] as String?,
      id: (json['id'] as num?)?.toInt(),
      question: json['question'] as String?,
      questionType: json['questionType'] as String?,
      answerType: json['answerType'] as String?,
      maxLines: (json['maxLines'] as num?)?.toInt(),
      hintText: json['hintText'] as String?,
      isEnabled: json['isEnabled'] as bool?,
      reValidation: json['reValidation'] as String?,
      reValidationText: json['reValidationText'],
      isMandatoryField: json['isMandatoryField'] as bool?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      userResponse: json['userResponse'],
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      '__typename': instance.typename,
      'id': instance.id,
      'question': instance.question,
      'questionType': instance.questionType,
      'answerType': instance.answerType,
      'maxLines': instance.maxLines,
      'hintText': instance.hintText,
      'isEnabled': instance.isEnabled,
      'reValidation': instance.reValidation,
      'reValidationText': instance.reValidationText,
      'isMandatoryField': instance.isMandatoryField,
      'options': instance.options,
      'userResponse': instance.userResponse,
    };
