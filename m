Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013027.outbound.protection.outlook.com [40.107.44.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E663545D95
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 14:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962947; cv=fail; b=gs57DAva7jJRbmszLK7HMyCONlhvp+1uqKfH9gXjk9Cm5fhG3F4S8QCLElD262lHvy5/VNn5LoW+q8TFOsUiTkTp8dPSuYxStCJ+neQiAuEyXr0x5GnR9ZhD24uLVrEFkQszapXyeMJa8z2hcGFWG/BfWlH5V7LODzUwwUNnZpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962947; c=relaxed/simple;
	bh=xOGjEbcMMBDLahoUg73O6JYJx0ix16ey+Jqm2KfSoKE=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EzzuAfYG4p9j3xmX6Y1QOa7GJbo5GhA8iU1/YhQFp6X/kvZaeSMFT5IYY2zF33l0Qz8hVFhY1BVkpD5XdvLZhr6XbGGtSuwQA4KkipqM7vjxzqVQH0EFHnOS/ZnaX55TrQ9aZsbhZJce8dIAUILKYgpN3YbwKnixB/2FO4VxLxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=PDDntfI7; arc=fail smtp.client-ip=40.107.44.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="PDDntfI7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlDHUzcaS/WLCd9bQJEucG25xZ59AHyv1yEqnkmOl5RzezzfjIyUBqsOQfZe3Rdgm4LzzwVE8372ZppRlYMwUEVNtFoEizCibkj0gr28VaC4z3so6UxEfpemc2QAsr1VKkCYalyom61ONhSt+5+k3SJr4hAdhZ/79kTn4KnKZwTF4dZsiXPH2pRakD63RhJDlmq2L/x+rwoke29AW87jHPRcA25SO4tYjo7BDzbT7m04FuBND2CKDWklPT13YltHFAjbVy4mhELU7e3nDmckY8CDDrWZ4segI5bMTYDV9TwzD55J0D9CxIdAdrCF7LL/LGYy4i7bV2vCRqOU54wdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfyynafAKjNJTgfnAuJs6LYoQFFl+ksEvtNZNXL54u8=;
 b=mFd06BxxIdsDQA4nZ3Djt8jpry/y67Pwr3ut9oxZUet9anNlRi113cjx7atoIMOaqkUKVfGnvpU7fmF0z8OutA999j3tte0mYbtpkJNzItR8jKuhPbI33se5wkPXYrhJUAlAeRO3QWaLn3MMW9Tv62VQf7vaydTl0MFYVrN7j5Plpu6vPW/xZBokvMpLC3vlW4SUSPrqQXZGzTCw37qPaFSl//cKhuq2KDI5FGEbRLBVCXAYZWYkgdAS6NyNRrnq3GvX8UaoLPhANXmwLyqvBz0hnqtnAZ8/vi5oJacrN1k3ytyP4EwQkhCBhry6+0k6mQYSV+zb8GpCFvlS2JCVEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfyynafAKjNJTgfnAuJs6LYoQFFl+ksEvtNZNXL54u8=;
 b=PDDntfI7KNYBKNjbs/+rFgSRem0+soTUGPAH8VlToZ1YqPuXaYzmqDn5XsYOBzcUIfGKFj4GOZUkR3KPjXJbJAPhm6UPtWGuWm5sJsYgNW6OjMnmI6yDkBhIWhc7XFnyfCRgqBrSJGgHuQCk0ibrF4pvN2M6W8BfNJiz6g62kFdj78DkrsjHbPf+NHvnwLQYTeRTWTRUAnHVBS+szH0GLzqbhyUSPwG0rDrPcNwX7tcx48LKvKTDHkQtvB8AQCbWsg47B7k0SJrt9iXpOZrQ/17wY3ANDi/RNdp70uBtSjc32YHz7pqCYjAinwydCOxZsrg3HIdwCp9N0o64m9q8IA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEZPR06MB7312.apcprd06.prod.outlook.com (2603:1096:101:250::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 9 Sep 2026
 14:09:02 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 14:09:02 +0000
Message-ID: <2093adfa-196e-4f18-a087-6435c5396bd2@vivo.com>
Date: Wed, 9 Sep 2026 22:08:59 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v7 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, andrii.nakryiko@gmail.com,
 alan.maguire@oracle.com, Andrii Nakryiko <andrii@kernel.org>
References: <20260907053847.1115-1-zhaofuyu@vivo.com>
 <20260907053847.1115-2-zhaofuyu@vivo.com> <ap522nLwOCK-BFJo@krava>
In-Reply-To: <ap522nLwOCK-BFJo@krava>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEZPR06MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 16f9ab44-4e4b-4409-4106-08df0e7be65e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	KxjrOfsCnngEAXiNFbLE7gTBNNC7L31CVOsVwZhpX0KzmfOWFU+m9CV1WmGESbiJKQ88lN3Ci/HcxBQ/IOvPEtJD5E7b4LZo/+WZf5yol0OUZMWzQl/D2XXGVplJzVKptnv6WOHoZCGXmu/TfyCDXP3S5OE0htUtTk8irdtmgi/VidaSxkD0nrCumRlmLG9SHyFfNjJjh0iWuoPuk9/nAse9uRfac7gpkC65Md4CVo5z0RpoGuZQgFkVG8aJdyTo0Dz6gLuvBwAu5cRdeDMsIj6KWMThxcRBwaFxS7bX6jHceWkgCBjnZNIj0RYKshbxKtv05iJU7IzKeQzaGvNdCXK0Hgf9ty8NVJK9Qw2jaH3TK4QHMYXyzJEddVTm8Rep1u6ycwv3jIduEeS6x2/z9IBTk6Y9KGAprd2+0nmEiIDT+ZNrl00ylvinzWeLUC7lNg2BWgubRqhi+X9VIXr3WorvkF2jd9YjdaMlX9YRsv3R0R/pBeM1C7JaSYvdPQ/K3X6isr51bHWWV0xI0jv4pOoww9gb/74DD9u53lYYkV67/NQ29/6wtNYakm3r21Wnprbt7zEH6rHFNQj1YqEP+F5XsFT0l0q651PGqJDmXN7ST5vdJv+RYnQ+7x/+FL0izZ5VtwrfeaB/dyBvOZZ1q3VVXYH2BivwPo6av57Dxvs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzJ0U3ptM2FhakhyWjgyYjJBSE5FSUljOWdaT2c2Zm95ZkVVb01WbHIzekxZ?=
 =?utf-8?B?N0ZMcHZBTzN4Y0RlVGRSbDZmR0lscmJXOWczUDRka0JRZmhpTFREcUR0bmxx?=
 =?utf-8?B?Sm53eWZzcDJQUkZQRjUvclNSTHJZWG52cnZOYXJWaUw4N0ExWDV5a0gwSUU1?=
 =?utf-8?B?KytuMkNDa3lDZ3JEZm5BdVRINVFSQXJuekNERmhBbkd6RjcwNmpyeFc2WkJa?=
 =?utf-8?B?S05jRXpGQ3p6VytjM3pvY1dNSFNDQm1zY1JJTlVPTEN5dzJ6cisvTHF2VW9v?=
 =?utf-8?B?UlBxME1kRkl6cHFCWVlKdG9ZeCtYUVdDT09paVlhbG1WMUErclNZSFhINHJX?=
 =?utf-8?B?UkZvSmx0V1J2TVl6M1l0bjM1cU04SEJTMDlQY1FvRUNGd3gvVUsrK1pVelpV?=
 =?utf-8?B?QlVQOWVxZE1XQUVwc3FqSk5LR1dsZnlVZUhOMG5IbGlnUUdDQ1FTQWlNSjh0?=
 =?utf-8?B?bEtma3c2N2xMbXJaVVhBMDA4dTdsc1pRcUtIb2tQNTV5VzdEQ0s4MDcybHJR?=
 =?utf-8?B?VHJEQXFETGhLVm9wTERvQnRhYWlmVmlqZWY5elgySlU0a2ZRNElXMXdGL1A5?=
 =?utf-8?B?Zi9aZzJKdS91UkphMndWbmtvcUQ1b1ArQkNtQjZJNVNiMnA2WkhsVklqL0ts?=
 =?utf-8?B?am9hUFlSaFdzeHZJTlZwcHJqb1BrY2phMlZrUitOUVU3d2pETDNJUVp5YkNC?=
 =?utf-8?B?TjcxdXdUOHVTY1FWeTB4czh4Ymoxa1VJbUxWaDljYUxaS0toR2xxU3ZZWWRj?=
 =?utf-8?B?S2V0bGM5RExGbGpFRDFPQ2p3WldvRGNDaVlPSGkrdWtlalZsaFNsTHU1dmRQ?=
 =?utf-8?B?Z3k4VFVwTXB1YStacjB5U3lnMnJhZHpRMTc5bEcvVmcrMjBDYXJ0cG9DNmRw?=
 =?utf-8?B?bTRoTk82UGpHRGZCRlRXc1V3eXZBckNYd1ZVcmY5RERySXJ2bVpQSDlhVDIw?=
 =?utf-8?B?a3NJUmF6WTZ6dlV3VFBvTU9ncEhjdE5jVTloNjBCRlRXdWdrRmh0cXNxVHVI?=
 =?utf-8?B?V01ZS3hPU09qUlQvaXkzSnlqWm0rRmYzRjkyZFhTazNreFRsWFQ0cDFYMVFw?=
 =?utf-8?B?Z1owdUg4V1ZuZEdSVjBkNGFnRUVSTVFSNkNjS2xURmZ2Y2lUbnI0NWVtUmdk?=
 =?utf-8?B?NGJONkJLbzZLMjQ4NmRXVFJZN1ZiSHcrVnZPNXVYUjNFOXlwUXUvVHU5cy85?=
 =?utf-8?B?S3JjaldFOVM4ZC9hckIyMUpsQ3hZcm51Z2tBOVhCUEZVTWc3TWRaSjhxRUtP?=
 =?utf-8?B?NHk0RmpVblBNd1J5NE5tSVlLblZ6cndJVWpiaWlRMmtPRXJqS0plclo5bTBT?=
 =?utf-8?B?SFR3cklnN2dkMzNrVzAra1padXZnUFkwTHpOdFY3ZFowZzNXY2J2YW83ZHVX?=
 =?utf-8?B?MWVoLzBBSmhYMFRnQjQyNnFrSGxoTm04Rkk2TzJVeVFlUWpRbjVnNG82US8y?=
 =?utf-8?B?WVlIMUt2d2M0R0VzK0tqYmJvb1Y0YVFYWWdNeWNsa3BkSXdNbGJRcjYzM2xX?=
 =?utf-8?B?eWNpYTA3ak9ERi9tZUd4QXJGcyt5RXlmRnIrM1gxeEdxYjBXR0JCMkZveGd2?=
 =?utf-8?B?bUM1RjcxWm1TbFBVKzhyMnZNMEpyU2p1TTJhRXNwd0VDcVhUMjNxTFVTNmd3?=
 =?utf-8?B?QUxDeWRvdlRPS0o4aXMvN2YwWlllYndRZTI0K0Y0WldqNGxmTTBZUFh3a01v?=
 =?utf-8?B?NUNuOUR5UlcwSnFuZTRVazJtc29ENlJIdU1KWEVUSEhPUnRlek9rVGRMSlFG?=
 =?utf-8?B?ZTBjWDR5cjV2SHpmbkRjdU1ub2xURzBMN1NWSHdQQTdzb2MyVlRLdFQ2akJT?=
 =?utf-8?B?c28xMkhPa0l4Wm5ZZkFDZS9sOTNDTktURWNuQitSNk9UZS9WTnB1K0tlWHcv?=
 =?utf-8?B?aGxoOHZpUkpleHQrc1doZVp6UGt2dDJIY0ZoRmZJRHBFYS9EZlJGSmlTK0xY?=
 =?utf-8?B?cFRsN1lHaU1DOWVTOG1IbGh0VDhGUml3Szg3aHZETXpwVVBUN2JHUkhXNkE4?=
 =?utf-8?B?UnpFNUZ0bmE3TjZuWDdEWmVCeW1GVGJhNzdKMTlkN2Z2ZHZDdm9IdHJ6T2F5?=
 =?utf-8?B?Z21lY1V5QjFyNDI1ZXBOTmFNRE80MkU4U08veGxQUHZwVCtxS2tlT29Ndmcw?=
 =?utf-8?B?Z1RiRzBMQnJ3Q0FzclFMT3JWZFpZdkNKMHNKVG81elBkVGZsRGxvR3NZVXZ0?=
 =?utf-8?B?WXhQMmxaeUxiUHVYNDkrMklNM01Zb0xiQ0JvZ0NpV0x6enB1ay9rQnpWV3pB?=
 =?utf-8?B?YTJBVjVrb1lTSzVMUFhZcWhRT0Eva2JjWDZwU09kVnMzMk15cjFoRjlaeEo1?=
 =?utf-8?B?SUVxQ2hsMnV5UHlkUWlmVE9CZVhKL3BmKzRvaElwaUlLM1g3K093QT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16f9ab44-4e4b-4409-4106-08df0e7be65e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 14:09:02.0061
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JdsHIMQMPOUxV2VRadbeWg4q30i975z7JgSRlrxtchryfMNz6ZScpRYKm2V/XQ7rqj2LjB5fCMLMf7+Av2I73A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7312



On 9/7/2026 4:33 PM, Jiri Olsa wrote:
> On Mon, Sep 07, 2026 at 01:38:46PM +0800, Fuyu Zhao wrote:
> 
> SNIP
> 
>>  static int load_module_btfs(struct bpf_object *obj)
>>  {
>>  	struct bpf_btf_info info;
>> @@ -5825,6 +5842,9 @@ static int load_module_btfs(struct bpf_object *obj)
>>  	if (!kernel_supports(obj, FEAT_MODULE_BTF))
>>  		return 0;
>>  
>> +	if (obj->btf_module_allowlist_cnt == 0)
>> +		return 0;
>> +
>>  	while (true) {
>>  		err = bpf_btf_get_next_id(id, &id);
>>  		if (err && errno == ENOENT)
>> @@ -5867,6 +5887,11 @@ static int load_module_btfs(struct bpf_object *obj)
>>  			continue;
>>  		}
>>  
>> +		if (!is_btf_mod_allowed(obj, name)) {
>> +			close(fd);
>> +			continue;
>> +		}
>> +
>>  		btf = btf_get_from_fd(fd, obj->btf_vmlinux);
>>  		err = libbpf_get_error(btf);
>>  		if (err) {
>> @@ -5891,6 +5916,10 @@ static int load_module_btfs(struct bpf_object *obj)
>>  			break;
>>  		}
>>  		obj->btf_module_cnt++;
>> +
>> +		if (obj->btf_module_allowlist &&
> 
> IIUC you don't need to check obj->btf_module_allowlist,
> because obj->btf_module_allowlist_cnt is -1 by default?
> 

Yes, that's correct. I'll remove the
obj->btf_module_allowlist check to keep the code simpler.

>> +		    obj->btf_module_allowlist_cnt == obj->btf_module_cnt)
>> +			break;
>>  	}
>>  
>>  	if (err) {
>> @@ -8426,8 +8455,10 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
>>  					  const struct bpf_object_open_opts *opts)
>>  {
>>  	const char *kconfig, *btf_tmp_path, *token_path;
>> +	const char **mod_allow;
>> +	int mod_allow_cnt;
>>  	struct bpf_object *obj;
>> -	int err;
>> +	int err, i, j;
>>  	char *log_buf;
>>  	size_t log_size;
>>  	__u32 log_level;
>> @@ -8470,6 +8501,22 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
>>  	if (token_path && strlen(token_path) >= PATH_MAX)
>>  		return ERR_PTR(-ENAMETOOLONG);
>>  
>> +	mod_allow = OPTS_GET(opts, btf_module_allowlist, NULL);
>> +	mod_allow_cnt = OPTS_GET(opts, btf_module_allowlist_cnt, 0);
>> +
>> +	if ((!mod_allow && mod_allow_cnt > 0) || mod_allow_cnt < 0)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	for (i = 0; i < mod_allow_cnt; i++) {
>> +		if (!mod_allow[i] || !mod_allow[i][0])
>> +			return ERR_PTR(-EINVAL);
>> +
>> +		for (j = 0; j < i; j++) {
>> +			if (strcmp(mod_allow[i], mod_allow[j]) == 0)
>> +				return ERR_PTR(-EINVAL);
>> +		}
> 
> do we care if user supplied same name multiple times?
> 

Yes, we care about duplicate names. We reject them so that each entry
in the allowlist represents a unique module. This allows the
load_module_btfs() loop to exit early once all requested module BTFs
have been loaded.

> thanks,
> jirka
> 
>> +	}
>> +
>>  	obj = bpf_object__new(path, obj_buf, obj_buf_sz, obj_name);
>>  	if (IS_ERR(obj))
>>  		return obj;

