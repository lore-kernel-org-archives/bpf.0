Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012052.outbound.protection.outlook.com [40.107.75.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9340437E5ED
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458893; cv=fail; b=s1Z7L5bWdSWBWe4Y4v+H/KC9MIWbEAWom12LsAfRrzS1RJgE9eBGvrzcT0XlDU/Mifi8x3+hLM+eLe6FYcSNgy17AbY9HoeEgL8n7Dv4mZAK070YNqvg3qkBh8RGSBTy1LHTwP1/MkFqr5imEyMiHjoRY1A4U7CIRR2sXfXDJUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458893; c=relaxed/simple;
	bh=463Y9POBpVBuzlofI9FYqh/h/uTUioIelaVl4UFxFuA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iGuZHjbbz+mcDCgXKH0vHLIsStv7QkHdcjqsfVdZInxbhnSVMieapxXwElVnZduVElBOYvwAzJQQDbIoQ7OwQKQIj01Aj7ZtlZaN4MWu1kaywDsJ1Nw50CFE6NXB/TWp4u0Jc/ojPDCDc+GW+vKPoi825Pq1J04ZDxyneoJnc6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Rv5EiZd+; arc=fail smtp.client-ip=40.107.75.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Rv5EiZd+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cp2czcCPWT1+RJLXDTtLdKXea20Msm2DeS9tKAruBbfAfbYmXvH0NKbvCFxznaFu6Z3saUPYHRLtI+foGxoNdLSSVQUS+ze53/IXPmr0eY/3yZjJ1W2d27YQvNMrEPt5u7x33NtuwudfFTdgvTuAtUCM+llY+x4SVtWeAy2xjqfuTrQHriQD1nIIWUUJuivfQQ3WXOHrXi13jm6CovjAfdIRwyl907IBdtS/swoimrjRKIYKGqCH9jYiVVqotJzkwFIrHXk9qa7bVNWCTs9MnUJPpSIPdw+dzBGvY30xdG/pH6OK7SkO9xa1f/YFN6qIjlngCTrMe1+3Fl+9izhPWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETtym0dEzhu97dovxOJS7xkOF0wEBLWTKL9ymJKHXbM=;
 b=gWKtUX4WdsNuNOMDoUOP7TONDZrccppoa3r6MKu02dVP9c5Jg1gdheO50TlRILPzwwJLOsCDZ223nkGM+byS8nlsLZ9LDOVT4LkkvBhW29IycQFhQKoHDXd7cXU2DC7Au82lSjTXMmC5KOL5EBtNOH7zK18toeXwWFMm62KtteCyC8qF0s3qWkJQJJ4DozW7oA06q3oJATV3pycVMHNAvLQ3fbW0r7G/wcBDP4WxkR8K5YKGrApBGKmkaiwNEdFDBT8Z4KFARSpMnjMQNCkAGOl2sIFCu16w6JaY1d47cjS/yIqRmoE9gksRl4a2PP3ENqRvZr/x965w0gppmUOovw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETtym0dEzhu97dovxOJS7xkOF0wEBLWTKL9ymJKHXbM=;
 b=Rv5EiZd+cm8ItEtg5y4g55hfimF4vC6nXbqxgadmeKsQeo+QjssE8iA59g8FBYTvGj6uEvCKoWxB/i5HzYz4jhjc//RK4pnWkhkIJXReO8b02e+GttszDCEptpKkF4jD5HuJ5BFCXolOFP9uzrWydU4lKDoNCr9iWYqpj3yRv+VUmvdCM8XXKt6JKHMfWMjtfl4Sxzbi1VI1wLx9An1VXtgODz8ZQB/l7tSfx+l/2lEHYbSBw1x2y7jN62PrVk93LukLyPJueDWtUe3/njU4pzY1ikSsSRQTFr5yMeREkL6ssgi5G7zSRJbbVOkeSfd/r9MSD61+EnEgNKjfzrc0Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SI2PR06MB4996.apcprd06.prod.outlook.com (2603:1096:4:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:54:48 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 07:54:48 +0000
Message-ID: <9c41ef89-bce8-406e-a68d-33d7f2662b6e@vivo.com>
Date: Tue, 15 Sep 2026 15:54:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 2/2] selftests/bpf: add tests for selective
 module BTF loading
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: eddyz87@gmail.com, andrii.nakryiko@gmail.com, alan.maguire@oracle.com,
 olsajiri@gmail.com, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
References: <20260911120820.46900-3-zhaofuyu@vivo.com>
 <e0769af3635afed4f52885bbfddbad5c6cb882ee276c3e9e6269591deac6ac12@mail.kernel.org>
From: Fuyu Zhao <zhaofuyu@vivo.com>
In-Reply-To: <e0769af3635afed4f52885bbfddbad5c6cb882ee276c3e9e6269591deac6ac12@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0013.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::18) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SI2PR06MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fd9bf09-846b-495d-35a3-08df12fe9d7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	WJUNxNxXKB4x/N96CqWDFaFvoooaR+qPlfsZZKxBHwXZWxxtupteObKSVUiYgpLTyEXDazdKjp92AL+sREYzG3LY0riUcIsHNOUpoa1vmOXRfubvDojMGj3Nu/cf6+Ta0MFC7bYCRhBd7WPZbOLZ3G+X5jwYj7xXJIHnSWmvjhuzKyhRD8ar81BNZv8q6tLXc9+s+JyjhBk8+4L9kW7Dxsfq6s2kjKVECYUkBZABZE3UJcfsjze8jF8CzcWQTpcW+osqdUVY417FVo/BIKB0/S/EFop6JHW8Y6ti3yvmVQpxGHlXmqxZjePmNxRWZC0mLkqw3QaIvRiuQKJMoAf15nzb77sOP/cKj0aURU9sf4VRbYBFFCtRQxRFHIPEBlhpCXo43UJ2hxULTIktic/PTcfWyT1+rO7pYyUurms5OdEr+F+GEhYLO81XHs18rUxmovjNYweDmlW1T9s9pWmXZIBI/I0I3wwzMLbOWX0cf4yVLKImSqmG31OqeEq7Atz0y0COqFjqwTkLm2IsJsSsr6C7MjvBGhwxF62xwMf7p3nwhl7829yXcvx+0sm1FCnbPqOB0TaVcrcosRAJTuXo4v15jLXNDkQjHRgXMh/Z41v5V62VqPHJTcct4BxKOxC0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmloM1crRGJYeStqK2FBcUF5STZkL25EdFNzaUZaTHhrOGFtWWVwbG42bWtq?=
 =?utf-8?B?bm42QVYyOGxmcHVkR1NidHJraHpZVGlxekc2ZHhTT21oeFJEclpPUUJSbmUw?=
 =?utf-8?B?S3dSTTZNWUMvbjI4Tk15K3ZWU1lTTEZxMEV2aHRyNVU2ZTVpMjIxSDkwUkFu?=
 =?utf-8?B?RHl2d0FIVWJ6RFhqYVRkRmo4OTNxRFJLajNZUDc2YXlZRmoyMTFSampOU2M3?=
 =?utf-8?B?c2FsTDY2MXdTVFFER1VoZ05jSzA5NGRMbno3UkM1TXZmYmhYWFQ5VnBOdmpX?=
 =?utf-8?B?UFZVd1pBZHJrbHcrdER3cER6emVBTEFNV0c2VnVCeE84UUMzWmszU1MyL1Jw?=
 =?utf-8?B?bGRRZTRoODNucEdoZm9OTHIvTXBxVXVZREdkbzgraE9nTUcwV21jUDZyKzh2?=
 =?utf-8?B?MVcvWkNZRWJSU1pmeG1KbVJyUzFVTnlvdVZ6OG5CVFlBM0JqU3pzK2llSjF2?=
 =?utf-8?B?NjZkYjRqT1FsUUVLOHdPTldWZFhKcTZmcG82a0ROTlVUU1dqZ05HYkdoZzAw?=
 =?utf-8?B?N0tGQjIvaVV4ZzE3bG9Tdi9QdXNRUUhaWWM4TGNaUENsdFdNZlcrWXNmQ1pE?=
 =?utf-8?B?VXZpM24zV3lsejN3RDB2aFpPZmFldnBZM2REdEsyaXNuMFlxanpMRHdPSmpw?=
 =?utf-8?B?eVN2aHZjUFE2L0Z1N3Z5bDlmUy9xbUxnbkhVVndMS1Q0VVJzbmZ2OGtQbm9Z?=
 =?utf-8?B?dFlJY3picGJtS282SER2Vmk2dEdUYlZNZ1cvV2RTb3VKejhBcmFQTUIyL2xZ?=
 =?utf-8?B?dDZIRnNqOUIrZVhQT0lRQkdWck1ZYlVVSDNmVzYzcXp5R2tRTGJTMFI2RS9y?=
 =?utf-8?B?TTg5TjdYRlRTZ3JIZU9RamVwbFBuTDlVTEF6bEtsUFlSOFdlb1BHSHlBdi85?=
 =?utf-8?B?VkhaU2RaRE0xcFppclR3UWROOFA2T3hCdDVhcWlrMTdVakpoREx3eUJBVFFh?=
 =?utf-8?B?amN0OElzKzNIeEdXMk1pVEJ0WDFzbmZqRlpNNjFYWVF2c1lJd1dDaTIzOEl5?=
 =?utf-8?B?TitJK1JlZTZ1MHpnN3RuTXArUHhHSVFPRFJRUkpucVFvSXpsYk11YmJwK3lq?=
 =?utf-8?B?ZWpoYWtOZWl5RDZsUXRoSE15UmVTMExIamhFQnVYSlNkbXpTbU5ENTdNRTla?=
 =?utf-8?B?NENnNzV3Ni82MVdwVzZ5ckx5RFlFMDZieHBHSVpuRlNhdEZaNkllaU5NalR3?=
 =?utf-8?B?cE5HY3llUFlYcTcrNzYxdVdNdi9NTmVGajhTNXcwU1A0N3I0cjBXZnJwUXZF?=
 =?utf-8?B?SkZoTkIyRXQ4OTBpUWpITzNHMzlWVjJreFFUbWdka25uTjBqc2dSQnRpOXRp?=
 =?utf-8?B?WGhmQnFEM3EwZlVVdTYrVmF2S1loZDdudmFod0FTQlJGN0tHNE1hOGJwSHJi?=
 =?utf-8?B?R2xYSTNZZFFZVXoyNWhtdnpMTGF5UTNBQmE1QVdNbER1ZlA0b3N6TEZVQUhC?=
 =?utf-8?B?RlpYZW94SEk0K2dyUFJEcFhGeTcxZmdVZ2wrOUh5Q25vMG53V2VlQ2lwUEQ3?=
 =?utf-8?B?bUhuSWZjT09sQWJ2SzlBR3oyMkhJUElocE1vZklWbWNOZEkyYnZUYnRLNEVi?=
 =?utf-8?B?aUk1TTRXeStEb255cWFRZGNabWNuMC9maHhaYmtVZHBldTkzZ1FzalZUU1Y1?=
 =?utf-8?B?Qm9yUVZ4UDcyeGtwdXA3b0xRbEJ1RGtSRk5PT3NPTWM0ZDRneUx1Ui9rLzR3?=
 =?utf-8?B?b0dXQ3ZqWTNBQTJzL3RNZlZkZVlUd3ZRTzl0b0dzL0RWODF4RE1Od2xjL2tT?=
 =?utf-8?B?ekNNZC9hODI0djFsY05tdmdvakczb3hvTGNBRXhtN29nc2dtaFBiQkltaThT?=
 =?utf-8?B?RDJQRE53QlJBSFFtaWlGZ1J6RzQ2aHp2dGh5dTVaT0lxN1pteXFKMkRDanFT?=
 =?utf-8?B?d0JCeHdwY2wrazhxRTYwRHJ6NWFhUnVaclZmS3JhdjFwZjdrRktiN2M3Z2h4?=
 =?utf-8?B?enRJL3pTcjVJcVBQTlZ5UVZHZDJzRDN0dE84NlpFcTExaUlkd3NnbVZJakFj?=
 =?utf-8?B?WDNXcUNZVThxVGJOV1lCY0RxcFNQK3lCQkVDdWIveWJNa2ZBT1ZqVUNTTUkr?=
 =?utf-8?B?Z1NTVllTRHdtSXdRRDJ0Yk5lbWN0eG1qWnhqVTluMm55NEM1eEdHdlYzc1dT?=
 =?utf-8?B?amorUmY5Z2NyL2ZFdmY3eFNDRXRqeGIxV1V3aWNIK0lTaVJKeGxVNGprU3Jn?=
 =?utf-8?B?Zk5uTUdBdmc0WUFQR2hETWNjOG1HMkF2VGpoZHB6VytmZTRFTWk5dWZJMnlY?=
 =?utf-8?B?OHU0bjRnallLZlh3SmZzZ1RPSnovcjZ4bGIyNjkzV0J1MmdUTU1uVTFMRUtG?=
 =?utf-8?Q?zNrUO0WkzvlPiJugic?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd9bf09-846b-495d-35a3-08df12fe9d7f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:54:48.4883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gcZOR4CBBoPZtkeKSsat1S8JKACcaM5oZOfeGiLxRaaFqFqEJl1AIJkol8V5gX7aJOxSIN4Iwg1WcOBlVh62w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4996



On 9/11/2026 8:52 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
>> new file mode 100644
>> index 000000000000..04a2acc508f7
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
>> @@ -0,0 +1,159 @@
> 
> [ ... ]
> 
>> +/*
>> + * An empty allowlist skips all module BTFs, so loading should fail.
>> + */
>> +static void btf_module_allowlist_empty(void)
>> +{
>> +	const char *mod_list[] = { NULL };
>> +
>> +	test_load_with_list(mod_list, 0, -ESRCH);
>> +}
> 
> This isn't a bug, but rather than restating the function name, could this
> comment note why a non-NULL one-element array is passed with count 0 --
> i.e. that a non-NULL pointer is what marks the allowlist as explicitly
> empty rather than unspecified?
> 

I agree. A non-NULL pointer with a count of 0 indicates an explicitly empty
allowlist. I'll update the comment accordingly.

>> +
>> +void test_btf_module_allowlist(void)
>> +{
> 
> [ ... ]
> 
>> +	if (test__start_subtest("default"))
>> +		btf_module_allowlist_default();
>> +
>> +	if (test__start_subtest("allowlist"))
>> +		btf_module_allowlist_allow();
>> +
>> +	if (test__start_subtest("skip_unlisted"))
>> +		btf_module_allowlist_skip();
>> +
>> +	if (test__start_subtest("emptylist"))
>> +		btf_module_allowlist_empty();
>> +
>> +	if (test__start_subtest("invalid_input"))
>> +		btf_module_allowlist_invalid();
>> +}
> 
> This isn't a bug, but would it read better to make the subtest names
> match the function names (and list the functions in the order they run)
> so a failing subtest maps directly to its function?
> 

That makes sense. I'll make the subtest names match the corresponding
function names.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34598086716

