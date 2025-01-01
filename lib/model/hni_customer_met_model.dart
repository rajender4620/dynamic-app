import 'package:json_annotation/json_annotation.dart';
part 'hni_customer_met_model.g.dart';

@JsonSerializable()
class HniCustomerMetResponce {
  HniCustomerMetResponce({
    this.data,
  });

  factory HniCustomerMetResponce.fromJson(Map<String, dynamic> json) =>
      _$HniCustomerMetResponceFromJson(json);
  @JsonKey(name: 'data')
  Data? data;

  Map<String, dynamic> toJson() => _$HniCustomerMetResponceToJson(this);
}

@JsonSerializable()
class Data {
  Data({
    this.typename,
    this.getUserForm,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  @JsonKey(name: '__typename')
  String? typename;
  @JsonKey(name: 'getUserForm')
  GetUserForm? getUserForm;

  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class GetUserForm {
  GetUserForm({
    this.typename,
    this.id,
    this.name,
    this.formUuid,
    this.isEditable,
    this.questions,
  });

  factory GetUserForm.fromJson(Map<String, dynamic> json) =>
      _$GetUserFormFromJson(json);
  @JsonKey(name: '__typename')
  String? typename;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'formUuid')
  String? formUuid;
  @JsonKey(name: 'isEditable')
  bool? isEditable;
  @JsonKey(name: 'questions')
  List<Question>? questions;

  Map<String, dynamic> toJson() => _$GetUserFormToJson(this);
}

@JsonSerializable()
class Option {
  Option({
    this.typename,
    this.id,
    this.name,
    this.formUuid,
    this.isEditable,
    this.questions,
    this.option,
  });

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);
  @JsonKey(name: '__typename')
  String? typename;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'formUuid')
  String? formUuid;
  @JsonKey(name: 'isEditable')
  bool? isEditable;
  @JsonKey(name: 'questions')
  List<Question>? questions;
  @JsonKey(name: 'option')
  String? option;

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}

@JsonSerializable()
class Question {
  Question({
    this.typename,
    this.id,
    this.question,
    this.questionType,
    this.answerType,
    this.maxLines,
    this.hintText,
    this.isEnabled,
    this.reValidation,
    this.reValidationText,
    this.isMandatoryField,
    this.options,
    this.userResponse,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);
  @JsonKey(name: '__typename')
  String? typename;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'question')
  String? question;
  @JsonKey(name: 'questionType')
  String? questionType;
  @JsonKey(name: 'answerType')
  String? answerType;
  @JsonKey(name: 'maxLines')
  int? maxLines;
  @JsonKey(name: 'hintText')
  String? hintText;
  @JsonKey(name: 'isEnabled')
  bool? isEnabled;
  @JsonKey(name: 'reValidation')
  String? reValidation;
  @JsonKey(name: 'reValidationText')
  dynamic reValidationText;
  @JsonKey(name: 'isMandatoryField')
  bool? isMandatoryField;
  @JsonKey(name: 'options')
  List<Option>? options;
  @JsonKey(name: 'userResponse')
  dynamic userResponse;

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
