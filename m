Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012015.outbound.protection.outlook.com [40.107.75.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137CD222599
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 03:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787801170; cv=fail; b=lhReJXo8dUcg3DuN9qUug7qyR6vuGUziImnTbR+Jwv2M6JZNQo2RoGSeiXu9Cdqx5ruFPm75Z1TIpx8MOpScqBIYimab/wImUzFvQc035pjvrn+Z82aDMgFM8W8MjC0lP48AiilCVPaYcpbUaLHnmyumM+UOce83ctJNELpfbys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787801170; c=relaxed/simple;
	bh=plpkCYPycCZ3pSet/bh8zXrfPGLYIdOBFySAxG5iBYk=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gHrRkTbfPeQFO7AcrbHD06qQJzJRp255/GCH+AzGar9ENnOQ1L24sSK/dViqT7grvLnNz5Fjo69kYoi95514OLrrQOjWCbqoD8V1ORpejBexTfeRCMQl9+d5jZUOGQxMLRnr7pVD1BXLa24bFZy6FKKegO2jEt8LtnZxsgty2Sw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RbQULQfs; arc=fail smtp.client-ip=40.107.75.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RbQULQfs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sjeYbc+X965blCoUXawZd/QLThw1f9Xsxt9K8xvofdxyXnDvuBIcgHCAanNAMgGZyYpdVwNEQxIXw/6DDPHETdrPV2yrarVEpxxS84tHZYA7ibdbldI4z00xS3+fNLAuovdrVWPGGBTBqWwmapUe+9uI+Zz6QoA/0WVOWBWTxJRzPaBbyNzMLBOgq+yCakriSkbVe0PISMZcQsLcyU6OullQiNUUO18Hlkkw5FWUy289COkNZrepHTh9PqUAYKxh4qFrDPXxLRHp/HfJ0x1wxJ8Losncx7MFODj3B+UtF2LZ3JMVHo/JZNSPJhtN8VSR7XrYyHBPBFvX/KWRuKifdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whWsEaPH/Abk8/fb02L9lQkwrrpV8tpmSQE3meT7MEU=;
 b=AoNPXt6BWkmyBgbtxITDrjfWvgeHdcHHlJrpQ+by1Zv2PdmLh+WZCnefI7V7AIdzy9QeBIND+ujO2Yrinlhup9PQQnEo6FgdYeXvLMDPo7M9L+HBCItqDhobn7+afAJ5MUgc8HlYKBqE8Zd7CkRiwzoYdgix7Hj/6nUrYZmvdMYpRjk2w+HmfpJcthRy8QPzw+C/Po76eb0JDCviE3KS0avFdZUtVoCi0Q2jGLDUAoRomjFV1GWrVeLoFN47haL7W9uZYK1CDDe9SAXMGFUue7fsOeJ77y565TpQ3sIDHHTJxVmjwuy9qon6iSANCLg/Q0f+pnAP1W1WArRL6SBnMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whWsEaPH/Abk8/fb02L9lQkwrrpV8tpmSQE3meT7MEU=;
 b=RbQULQfs1Km3c77uctiQEqNYnW9zX+XHPKdKqTIPKqNrEy+rhuXG2Rr9St6NffwymmVqPeeXpLv/8MUdtTKYJn/b4kq2/t+b3X10hmyH/McR6VWQEB+4nksbxcK0r6THPnoMxsN9cwkkhzp3mlGw6S6foYaEcHFx6fVaLtzVhd3BbTfpixK1v1mXbWDZQzfQhmR3ccr93PqrfrlYcN76JaTnwPZIc7sW9uIZLlsLYUtGql2zUSFdMvNcg8hJSu8d+poDlkbDjVyvsder0tbY/RhPk3U/oDgNMsGjVKvndSwKuN7ylCoFf4wY3kxCWlKb4ZSGh8q7hO7Wpyk03fHtsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by OSQPR06MB7184.apcprd06.prod.outlook.com (2603:1096:604:293::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 03:26:05 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 03:26:04 +0000
Message-ID: <fd301b2f-4333-4868-8a77-c2c06362cb75@vivo.com>
Date: Thu, 27 Aug 2026 11:26:01 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v5 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: bot+bpf-ci@kernel.org, eddyz87@gmail.com, andrii.nakryiko@gmail.com,
 alan.maguire@oracle.com
Cc: bpf@vger.kernel.org
References: <20260826131428.302-2-zhaofuyu@vivo.com>
 <70202a9e53b06c7d44cd83b2824fc43fab79a2ac24d0e0c71bb95759eca5508c@mail.kernel.org>
In-Reply-To: <70202a9e53b06c7d44cd83b2824fc43fab79a2ac24d0e0c71bb95759eca5508c@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR04CA0208.apcprd04.prod.outlook.com
 (2603:1096:4:187::10) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|OSQPR06MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: fa04725c-3d13-4dab-7448-08df03eaecea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|13003099007|6133799003|4133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GSjq6ZG/8bMcb+u4GgxcjSt8qdtPPzsylONWD5yX1QCie237PgSb/HNCy5Ny/3uf1oLiJ77nIaWnfiyNXjtw/2dTtVzXS0Hkbme3HdS+BdsKtxLPd7PWzbmBankgdH8bT+yn6xLj/cVAMElvB4vTMHIloM0uihKSWmCWxGvxY/fZrrC1d4rCbTuhK+uo7QTw0hT4RoW9kyO/8OFHJHyW+RnskhMBTZS/PuR4g0N/Q3rDHpUBVzCOUT03v1UkTtZZJxOB8fD1DhkT98+hfDwMEMEyUzk5JV5B73bslfWYPC6pDd7OK0lawin4Gt1uqZkhy9L6kDpjiNUUAz0mzjU483UUT8xAdZPKErzW7Gv0xlLNB9YkZh41nXoQ6x7+diGea4kl7m/T6sDlGadjDrG41Yn201EfDv8J7DboGM/KoFjRt8h7DpnJ7S2L5YbrvnmQgP5VyaSlttrNTGnB6uXpq/CBSdrCwQdPgtMXxx6KqmKFABK+t4zOdlwxJMS+Dx3D3H8CplSUU2VmyM7bEskPfrHQPquw/OEnKkPWsYljbfiI3S7g2ZkDWuUHcigZxk0c/7d3FfOpNAcOg25yvCU7CXgSoNd2EwR/hRgtNZ4ZMh6aVJoypmcdLvFCq1EBrME8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(13003099007)(6133799003)(4133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzM4RWhETnhFNExrbzJzck8xYS9Db2pVNXVKY05ucTIvc3hoQ0hjM1VEbytU?=
 =?utf-8?B?Z29Dd1MzUFg5VDE0ZEE5WjZWU2h6Y3V3cWxmU2tjWUZSZ3c3VDZlbUNYNktu?=
 =?utf-8?B?a1Jla0FWRkVZMm1PNjM3MlhFNnRFMXptUnQrRlk0dHhPMERoSUdhcUVZckpD?=
 =?utf-8?B?TkNZMWtQMTZ1Z040cE1oMGloVlBpS0lxeEdlM291L3ZacnliQTJ1Q1p3QXVn?=
 =?utf-8?B?dnd0ckNERGVDeDlVNGtEMDhQRHdDRDNQWVVoYTJpdkRoNjVkdm9VU1U3WkUz?=
 =?utf-8?B?bFNjUDZnV01hZWtlMEJ5S1BqNGJ4cjNBR2M4UG1neEE4UnlqZXNQSGwrR1Fz?=
 =?utf-8?B?WVZaMW11WFZHMm02WkRZcklUeUI0WVdEUWVhQTlicDUxcm5tdVdIdEZ6bnZ4?=
 =?utf-8?B?V2JNbk9CSmNsWVJ1b3lMVS9mN2NRbi9SWDFZeW9RZVpIazNScDRDRjNnRjla?=
 =?utf-8?B?ZE4wUm5yMVA0eU1rNDYrNW1pb01EQ0VwNEhTa1lEN2tHaEJMTisrbmVuM0Y2?=
 =?utf-8?B?Vmt4ZThseGpFVDRVakhFM243QmRvWGMxRjV6QlZmSzc0MzluWXBBMXFCZUFa?=
 =?utf-8?B?WGo4N1pabHBLYm5RRnhKVndxNTJtM1Z4UGVlbU4yMDRLSEVCYVdJUEIvUUVN?=
 =?utf-8?B?TjUzRlg1OGVwb016MndncWd5Nk04dUZFTkZPc0pMekQ5SExQT09hUWorSFRO?=
 =?utf-8?B?ZWsvTlpyRkZ0bmdlaE1xU2ZWQThiQUI0dmV4eHFualdOWE9sbmdMaFljeFla?=
 =?utf-8?B?SVMvckx5cUY2cHJlYkMzdC9WWFZzWXlMZmtWTnlqRnR0K0x4Um9JanE4K2E2?=
 =?utf-8?B?YStiWHNvd2xJNGxpdnR3bVJ5L3Z0Y1lkRllXQ0pHMnBwT2FreVdGTThWWHFR?=
 =?utf-8?B?SVJNN3pHc1FkNE5GeHZvMFZ1NmZ3d2RQWU5yOVl5UTdDSEs4RzloMitSSVBQ?=
 =?utf-8?B?bjhieHF4NU8yQ0RDc1VHTUVUTGEwdVBUM0xKcGowNzgvRURtaDhZdVNhTlhu?=
 =?utf-8?B?Yjh6b0dtWXMzd3R1clJ4dEFwZFkzeUttVWgvZytiSzFnclF4TWk5SmxSZFUz?=
 =?utf-8?B?SU1VNE16ZXU2Q3pLQU1NRmdCTXJHaFJmTmthVnRIV0ljVkFoTCs1MVphdTkz?=
 =?utf-8?B?dStCVjZnWVhINktOWmFqWXVJOCtOZXBOVC9KbmZ5bWhCZENSOGs3S281SW9a?=
 =?utf-8?B?QmFCUFVnbDFFUnUxUzdQK1dDNDdRaElhQUxnT2JhV3pVUGhyNE5vY1l0ZmRU?=
 =?utf-8?B?OWZLNmpqRklxeGpVeWw5S3NicGpaRTRITUZsVExmVFVNYm5LaTFpVGFiL0FS?=
 =?utf-8?B?MVorejFLT0ViYTJ6NzkzZ3FrN2V6VEh3dmcyYmRKWmZBdXl1VCt3SXlxcFFP?=
 =?utf-8?B?KytsRVNoRHBwTUNLdWhuZjc3ejZnNTd5d1A3VlpOVDZPemJlaklXc01OS3gv?=
 =?utf-8?B?WVpXbDhQQkcyWTdENE9OMWFqOTJwd3I2Rm1hUkU5RkdGSUJWaktVeXM0TXNr?=
 =?utf-8?B?eUdxalZETDFyR2dsM0tCbHEzcWJXcnRGOUJFZzU1dTdUdlhZajdHTWhGYldx?=
 =?utf-8?B?MmF3OXVIaThVbFRZOUlUTFF6UmUwWm5HV2VCVGhidnRuSERuMjZmWlQzMEcx?=
 =?utf-8?B?VDJReVFhSzIybjRYeEw0MUVtSnhTeWVCc2ozRk82YzhsVzdTcmJ1a05XWVNT?=
 =?utf-8?B?MzRoQ1VHRHhrcmtaMVluYnk4b1liOFQxVWFLYkJETDVPa21PaG1zZkp0SHh5?=
 =?utf-8?B?dmZSTDBjanpqVSsrdkVHOE9BRFF6RlhPcnRiSUZ5YVZHNnZqeEdNSXhKcmwr?=
 =?utf-8?B?Q0Y4MkY0UkoyT2JiNVhlaGUxUnJHNUNLUmszTmtDZUhlcU9YQ3lEU3ZzL0RO?=
 =?utf-8?B?bjViN284K1VFbjZoZUZpS3p6VjZsdW5xOUZhQXp2ajFkLytMbUErN1pvanJW?=
 =?utf-8?B?dlJwazZISGRKM2RPNTFaSkljdUpvUUM0SjArUFNVcUZXY2hDamRmT2srTHZz?=
 =?utf-8?B?Wk1kRGRDMlpHZHArWExIMHVhT2o4alNuYnI2RGhnSnZTQkhDTGt3UWRIT29Y?=
 =?utf-8?B?NlpRUjBjUXRZNFo0cy9xSzRMTTlncTdLNThpbFBKSDFpY2YycktWTkxLeG1Q?=
 =?utf-8?B?WElra1pxYzFydmdTbkxYdkFXUWxtMTduaVVIVXpNMzRUUTA5TEltbXdFY1gx?=
 =?utf-8?B?NzN3TEpGcklPSlZWRTNLWWFOZDFTenZzaXlvb0lnUUYwY2JiTmg2VG9UbDFm?=
 =?utf-8?B?UlNwT2FQZTQ4NUxKQ1VkUzk1WEE0cWpETXNDZ09FMm5jeW01b2V2Qmd5dGdn?=
 =?utf-8?B?bnpXblJvZ1JiRjRyNG1pd3Q3aDBuL0FSbkw2QU9wSGYwTTQxVjFFQT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa04725c-3d13-4dab-7448-08df03eaecea
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 03:26:04.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MFXdGFnz9wsr82BGVumIUqXBGY9A2uQerxdYGWVx0YLr0ORTvTd5WvS25/Vdy9VIQFA81NXPien5/nwyrl8++g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7184



On 8/26/2026 10:13 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index b749c01742ee0..a466aabf35e1c 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
>> @@ -5851,6 +5854,99 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>>  	return 0;
>>  }
>>
>> +static void bpf_object_free_btf_module_names(struct bpf_object *obj)
>> +{
> 
> Andrii Nakryiko raised a concern in v3 about the naming convention used
> here. Internal helper functions should not use double underscore naming, as
> that convention is reserved for extern method-like APIs. Would
> bpf_object_free_module_names and bpf_object_init_module_names be more
> appropriate, following the single underscore pattern for internal helpers?
> 
> Reference: https://lore.kernel.org/bpf/CAEf4BzbbdjeSW88EEk2xRvAxq-HWUJ7qTw4BYnL3kLH0f0uhwg@mail.gmail.com/
> 

Am I missing something here, or did the bot miss something?
The helper functions are already using the single-underscore
naming convention in the current version. I also think
`btf_module_names` is more appropriate than `module_names`, as it
makes it explicit that these module names are specifically used
for BTF-related handling.

>> +	size_t i;
>> +
>> +	if (!obj->btf_module_names)
>> +		return;
>> +
>> +	for (i = 0; i < obj->nr_btf_module_names; i++)
>> +		zfree(&obj->btf_module_names[i]);
>> +	zfree(&obj->btf_module_names);
>> +	obj->nr_btf_module_names = 0;
>> +}
>> +
>> +static int bpf_object_init_btf_module_names(struct bpf_object *obj,
>> +					    const struct bpf_object_open_opts *opts)
>> +{
>> +	const char **names;
>> +	size_t i, j, cnt;
>> +	int err;
>> +
>> +	names = OPTS_GET(opts, btf_module_names, NULL);
>> +	if (!names)
>> +		return 0;
>> +
>> +	cnt = OPTS_GET(opts, nr_btf_module_names, 0);
>> +
>> +	/*
>> +	 * Allocate one entry for an empty list to distinguish it from the
>> +	 * default behavior.
>> +	 */
>> +	obj->btf_module_names = calloc(cnt ?: 1,
>> +				       sizeof(*obj->btf_module_names));
>> +	if (!obj->btf_module_names)
>> +		return -ENOMEM;
>> +
>> +	for (i = 0; i < cnt; i++) {
>> +		if (!names[i] || !names[i][0]) {
>> +			pr_warn("invalid kernel module BTF name at index %zu\n", i);
>> +			err = -EINVAL;
>> +			goto err_out;
>> +		}
>> +
>> +		for (j = 0; j < i; j++) {
>> +			if (strcmp(obj->btf_module_names[j], names[i]) == 0) {
>> +				pr_warn("duplicate kernel module BTF name '%s'\n",
>> +					names[i]);
>> +				err = -EINVAL;
>> +				goto err_out;
>> +			}
>> +		}
> 
> Andrii Nakryiko suggested in v3 that the module name list should be sorted
> and duplicates detected in a single pass rather than using the O(n^2)
> nested loop approach. The suggestion was to error out with -EINVAL if
> duplicates are found after sorting. Would this optimization be worth
> implementing?
> 
> Reference: https://lore.kernel.org/bpf/CAEf4BzbbdjeSW88EEk2xRvAxq-HWUJ7qTw4BYnL3kLH0f0uhwg@mail.gmail.com/
> 

I think the O(n²) duplicate check should be fine here, as
`nr_btf_module_names` is expected to be very small in practice.
Sorting the list just for duplicate detection would add complexity
without providing a meaningful benefit for the expected use case.

Hi Andrii, hi Eduard,

what do you think? Is it OK to keep the nested loop here?

>> +
>> +		obj->btf_module_names[i] = strdup(names[i]);
>> +		if (!obj->btf_module_names[i]) {
>> +			err = -ENOMEM;
>> +			goto err_out;
>> +		}
>> +
>> +		obj->nr_btf_module_names++;
>> +	}
>> +	return 0;
>> +
>> +err_out:
>> +	bpf_object_free_btf_module_names(obj);
>> +	return err;
>> +}
> 
> [ ... ]
> 
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index b965ad5715403..b8c1d98d69d85 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -224,10 +224,32 @@ struct bpf_object_open_opts {
>>  	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
>>  	 */
>>  	const char *bpf_token_path;
>> +	/*
>> +	 * Optional list of kernel module names whose BTFs should be loaded.
>> +	 * nr_btf_module_names specifies the number of entries in
>> +	 * btf_module_names.
>> +	 *
>> +	 * With btf_module_names:
>> +	 * - when provided, only the BTFs of the specified modules are loaded;
>> +	 * - when an empty list is provided, no module BTFs are loaded;
>> +	 * - when NULL, all module BTFs are loaded as before.
>> +	 *
>> +	 * The list must not contain duplicate entries; otherwise -EINVAL is
>> +	 * returned.
>> +	 *
>> +	 * This affects:
>> +	 * - BPF CO-RE relocations against types defined in modules;
>> +	 * - BTF-based resolution of function attach targets for
>> +	 *   fentry/fexit/fmod_ret/freplace/LSM programs;
>> +	 * - struct_ops kernel type resolution;
>> +	 * - extern (ksym) resolution for kernel symbols defined in modules.
>> +	 */
> 
> Looking at the 'This affects:' list and the -EINVAL contract, are there two
> things missing?
> 
> First, load_module_btfs() has four callers in libbpf.c, but the list above
> covers only three: bpf_core_find_cands (CO-RE relocations), find_kernel_btf_id
> (fentry/fexit/etc), and find_ksym_btf_id (extern resolution). The fourth
> caller is find_attach_module(), which is reached from tracing_multi_mod_fd()
> and collect_func_ids_by_glob() for 'module:glob' attach patterns:
> 
>     mod = find_attach_module(obj, pattern);
>     if (!mod) {
>         err = -EINVAL;
>         goto cleanup;
>     }
> 
> So a user who sets btf_module_names and then attaches a tracing-multi
> program with 'mymod:foo*' gets -EINVAL if mymod is not in the list, but the
> documented behavior above doesn't hint that this option affects multi-attach
> module resolution.
> 

I think the `fentry`/`fexit` entry in the documentation already
covers the multi-attach case mentioned here. However, `fsession`
could be added as well.

> Second, the -EINVAL contract mentions only duplicates, but
> bpf_object_init_btf_module_names() also rejects NULL and empty-string
> entries:
> 
>     if (!names[i] || !names[i][0]) {
>         pr_warn("invalid kernel module BTF name at index %zu\n", i);
>         err = -EINVAL;
> 
> Would it be worth clarifying both of these in the documentation?
> 

I don't think this needs to be documented, as this check is just
input validation when `cnt > 0`. It prevents NULL or empty strings
from being included in the provided list, rather than being part
of the API semantics.

Thanks,
Fuyu

>> +	const char **btf_module_names;
>> +	size_t nr_btf_module_names;
>>
>>  	size_t :0;
>>  };
>> -#define bpf_object_open_opts__last_field bpf_token_path
>> +#define bpf_object_open_opts__last_field nr_btf_module_names
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32974547426

