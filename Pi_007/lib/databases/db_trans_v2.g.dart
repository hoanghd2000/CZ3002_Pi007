// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_trans_v2.dart';

// **************************************************************************
// DriftDatabaseGenerator
// **************************************************************************

// ignore_for_file: type=lint
class Txn extends DataClass implements Insertable<Txn> {
  final int id;
  final bool spending;
  final String category;
  final String name;
  final double amount;
  final String note;
  final DateTime timestamp;
  const Txn(
      {required this.id,
      required this.spending,
      required this.category,
      required this.name,
      required this.amount,
      required this.note,
      required this.timestamp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['spending'] = Variable<bool>(spending);
    map['category'] = Variable<String>(category);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<double>(amount);
    map['note'] = Variable<String>(note);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  TxnCompanion toCompanion(bool nullToAbsent) {
    return TxnCompanion(
      id: Value(id),
      spending: Value(spending),
      category: Value(category),
      name: Value(name),
      amount: Value(amount),
      note: Value(note),
      timestamp: Value(timestamp),
    );
  }

  factory Txn.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Txn(
      id: serializer.fromJson<int>(json['id']),
      spending: serializer.fromJson<bool>(json['spending']),
      category: serializer.fromJson<String>(json['category']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<double>(json['amount']),
      note: serializer.fromJson<String>(json['note']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'spending': serializer.toJson<bool>(spending),
      'category': serializer.toJson<String>(category),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<double>(amount),
      'note': serializer.toJson<String>(note),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  Txn copyWith(
          {int? id,
          bool? spending,
          String? category,
          String? name,
          double? amount,
          String? note,
          DateTime? timestamp}) =>
      Txn(
        id: id ?? this.id,
        spending: spending ?? this.spending,
        category: category ?? this.category,
        name: name ?? this.name,
        amount: amount ?? this.amount,
        note: note ?? this.note,
        timestamp: timestamp ?? this.timestamp,
      );
  @override
  String toString() {
    return (StringBuffer('Txn(')
          ..write('id: $id, ')
          ..write('spending: $spending, ')
          ..write('category: $category, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, spending, category, name, amount, note, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Txn &&
          other.id == this.id &&
          other.spending == this.spending &&
          other.category == this.category &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.note == this.note &&
          other.timestamp == this.timestamp);
}

class TxnCompanion extends UpdateCompanion<Txn> {
  final Value<int> id;
  final Value<bool> spending;
  final Value<String> category;
  final Value<String> name;
  final Value<double> amount;
  final Value<String> note;
  final Value<DateTime> timestamp;
  const TxnCompanion({
    this.id = const Value.absent(),
    this.spending = const Value.absent(),
    this.category = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.note = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  TxnCompanion.insert({
    required int id,
    required bool spending,
    required String category,
    required String name,
    required double amount,
    required String note,
    this.timestamp = const Value.absent(),
  })  : id = Value(id),
        spending = Value(spending),
        category = Value(category),
        name = Value(name),
        amount = Value(amount),
        note = Value(note);
  static Insertable<Txn> custom({
    Expression<int>? id,
    Expression<bool>? spending,
    Expression<String>? category,
    Expression<String>? name,
    Expression<double>? amount,
    Expression<String>? note,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (spending != null) 'spending': spending,
      if (category != null) 'category': category,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (note != null) 'note': note,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  TxnCompanion copyWith(
      {Value<int>? id,
      Value<bool>? spending,
      Value<String>? category,
      Value<String>? name,
      Value<double>? amount,
      Value<String>? note,
      Value<DateTime>? timestamp}) {
    return TxnCompanion(
      id: id ?? this.id,
      spending: spending ?? this.spending,
      category: category ?? this.category,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (spending.present) {
      map['spending'] = Variable<bool>(spending.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TxnCompanion(')
          ..write('id: $id, ')
          ..write('spending: $spending, ')
          ..write('category: $category, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('note: $note, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $TxnTable extends Txn with TableInfo<$TxnTable, Txn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TxnTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  final VerificationMeta _spendingMeta = const VerificationMeta('spending');
  @override
  late final GeneratedColumn<bool> spending = GeneratedColumn<bool>(
      'spending', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: 'CHECK (spending IN (0, 1))');
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  final VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  final VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  final VerificationMeta _timestampMeta = const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, spending, category, name, amount, note, timestamp];
  @override
  String get aliasedName => _alias ?? 'txn';
  @override
  String get actualTableName => 'txn';
  @override
  VerificationContext validateIntegrity(Insertable<Txn> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('spending')) {
      context.handle(_spendingMeta,
          spending.isAcceptableOrUnknown(data['spending']!, _spendingMeta));
    } else if (isInserting) {
      context.missing(_spendingMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Txn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Txn(
      id: attachedDatabase.options.types
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      spending: attachedDatabase.options.types
          .read(DriftSqlType.bool, data['${effectivePrefix}spending'])!,
      category: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      name: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      amount: attachedDatabase.options.types
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      note: attachedDatabase.options.types
          .read(DriftSqlType.string, data['${effectivePrefix}note'])!,
      timestamp: attachedDatabase.options.types
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
    );
  }

  @override
  $TxnTable createAlias(String alias) {
    return $TxnTable(attachedDatabase, alias);
  }
}

abstract class _$TxnDb extends GeneratedDatabase {
  _$TxnDb(QueryExecutor e) : super(e);
  late final $TxnTable txn = $TxnTable(this);
  @override
  Iterable<TableInfo<Table, dynamic>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [txn];
}
