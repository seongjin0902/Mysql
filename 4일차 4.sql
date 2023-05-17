use shopdb;

select json_object('name','홍길동','height',182) as 'json type';

set @var=10; 

select @var;

set @json_data = json_object('name','홍길동','height',182);
select @json_data;

set @json_data2 = '{"name":"홍길동","height":182}';
select @json_data2;

set @json_data3='{
	"userinfo" :
    [
		{"name":"홍길동","age":55,"addr":"대구"},
		{"name":"남길동","age":22,"addr":"울산"},
		{"name":"동길동","age":33,"addr":"인천"}
    ]
}';
select @json_data3;
select json_search(@json_data3,'one','남길동');












