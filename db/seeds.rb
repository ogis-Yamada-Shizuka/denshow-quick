# db/seeds.rb は、稼働用の仕込みデータを作成できます。
# データの作成は、ふつうに ActiveRecord の機能で行えます。
# アプリの初回セットアップ時に rake db:seed でデータを仕込みますが、念のため何
# 度も実行できるよう、データ作成前に既存データを削除しています。
# データの削除を delete_all で書いているので、取扱いにはご注意ください。。

Progress.delete_all
if Rails.env.development?
  Progress.connection.execute("update sqlite_sequence set seq=1 where name='progresses'")
else
  Progress.connection.execute("SELECT SETVAL('progresses_id_seq', 1, false)")
end


Flow.delete_all
if Rails.env.development?
  Flow.connection.execute("update sqlite_sequence set seq=1 where name='flows'")
else
  Flow.connection.execute("SELECT SETVAL('flows_id_seq', 1, false)")
end

RequestApplication.delete_all
if Rails.env.development?
  RequestApplication.connection.execute("update sqlite_sequence set seq=1 where name='request_applications'")
else
  RequestApplication.connection.execute("SELECT SETVAL('request_applications_id_seq', 1, false)")
end

FlowOrder.delete_all
Dept.delete_all

# 部署のマスターデータ
# Ransackで、自前のscope利用時に、値に1を渡すとエラーとなるため、idに1を利用しないように変更。
Dept.create([
              { name: "資材部", project: false, id: 2 },
              { name: "技術情報課", project: false, id: 3 },
              { name: "プロジェクトA",      project: true,   id: 4 },
              { name: "プロジェクトB",      project: true,   id: 5 },
              { name: "プロジェクトC",      project: true,   id: 6 }
            ])

if Rails.env.development?
  Dept.connection.execute("update sqlite_sequence set seq=6 where name='depts'")
else
  Dept.connection.execute("SELECT SETVAL('depts_id_seq', 6)")
end




# フロー順のマスターデータ
FlowOrder.create([
                   { order: 1,  project_flg: false,  dept_id: 2,  reject_permission: false, first_to_revert_permission: false, id: 1 },
                   { order: 2,  project_flg: true,  dept_id: nil, reject_permission: true,  first_to_revert_permission: false, id: 2 },
                   { order: 3,  project_flg: false,   dept_id: 3, reject_permission: true ,  first_to_revert_permission: true, id: 3 },
                   { order: 4,  project_flg: false,  dept_id: 2,  reject_permission: false , first_to_revert_permission: false, id: 4 }
                 ])

if Rails.env.development?
  FlowOrder.connection.execute("update sqlite_sequence set seq=4 where name='flow_orders'")
else
  FlowOrder.connection.execute("SELECT SETVAL('flow_orders_id_seq', 4)")
end


# 担当課のマスターデータ
Section.delete_all
Section.create([
              { name: "国産部品",  id: 1 },
              { name: "外注", id: 2 },
              { name: "材料",   id: 3 },
              { name: "輸入備品",   id: 4 },
              { name: "調計１",   id: 5 },
              { name: "調計２",   id: 6 },
              { name: "調計３",   id: 7 }
            ])
if Rails.env.development?
  Section.connection.execute("update sqlite_sequence set seq=7 where name='sections'")
else
  Section.connection.execute("SELECT SETVAL('sections_id_seq', 7)")
end

# 機種のマスターデータ
Model.delete_all
Model.create([
              { code: "A01", name: "機種その１",  id: 1 },
              { code: "B01", name: "機種その２", id: 2 },
              { code: "C01", name: "機種その３",  id: 3 }
            ])
if Rails.env.development?
  Model.connection.execute("update sqlite_sequence set seq=3 where name='models'")
else
  Model.connection.execute("SELECT SETVAL('models_id_seq', 3)")
end

# ベンダーコードのマスターデータ
Vendor.delete_all
Vendor.create([
              { code: "A0001", name: "ベンダーその１",  id: 1 },
              { code: "B0001", name: "ベンダーその２", id: 2 },
              { code: "C0001", name: "ベンダーその３",  id: 3 }
            ])
if Rails.env.development?
  Vendor.connection.execute("update sqlite_sequence set seq=3 where name='vendors'")
else
  Vendor.connection.execute("SELECT SETVAL('vendors_id_seq', 3)")
end

