Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013028.outbound.protection.outlook.com [52.101.127.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56A34A78E;
	Fri, 21 Aug 2026 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787284287; cv=fail; b=UUPMssDIR537NomkcwMpK9sQ0tbbVSb0goBYJOuyYX1iHPF77Gb5nvI82yCCAz9UxeylgtcgFn3JFpLQluW3Ks8hVv5fM1TgmpqPdO0LwA2BJo9F0M/t97rkAN4CClFqeTTN2iWe3qgVCRoI4ND+oyQCzRu9D3jDbkc/uZwhhxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787284287; c=relaxed/simple;
	bh=GRxcd1MWCSovuLJercvpl3tl2BfDnGiFH71SnhfvbhQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EJY4ta6HW/Fm4SgahPDPsmDXizWWCD9Zky0+uPQONl+bf4YfbxYTqSaV4B/5XNdqV2IzfteLAxGuq583riZ/CkUEGPXh5bV+6buDhO1yfy7B+XkxQPWZhH3hOzkGlT2F4YtNNO4wqgwU3O+7i7/sEuxA0U4sy4kGaY5IPDI8w8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=VU4NCD8I; arc=fail smtp.client-ip=52.101.127.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="VU4NCD8I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpk9AoNS7FahPItEtgjmkK3dtfK4P3wJm1e/D2R/KIn/qUlYRTqQ8DKQ3XrL5H2f6zoMP04+ni6+J08k8n+lDDCO5vC05zaSFnYbSrOxI/QyqPB5eGYnfmyeuFCzXztOuIbEWhstGw+dmvjDMRp1HdiID038CundUM0cvVQmgk4wrOwVwGjVD2bx83wMNl1X0HNQsEHKGsj609oHkpGxFQslybBrksdTwG/tBFEqNGqa1kDvxz7UUH7R66RaFmEkRzVIbedynD+GmcMucaGM0CpRmA2NY9WRhSGsFOWOBGpBADN+4ohKKnzVwqFoYjUvRmnbl2erDEhw7SK1J53bUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vevPvo7ae+PTeKms0XJotVYLU5JAUeJd4AyeV57R8gU=;
 b=hILKoNdBZLR3hdbeMBnyIFHYJgt8hmH1Dmf+3tK9j/ITtok+mr+FNIULtV5xrvWrslsm34YTevPpJjpsUbyxCr1cmKwRUqdwsGbhKw5uLMQ3Vwu25XVwevn8kgzYUNBxmqeljQumAVnpNwnHWqtMZHKlRuc7vnfMFOsU8TAMEBm2o6yyDa6Qgwb5dsU+nnAPqVD4VHeiJWm5IW0NQaIkYTR8hG/sDCPnTLEW8gu/BoUyzOI3tHKM7Pt8Sb18lMbIg6qQgERyV//ecoIkUPwTFPBQd8ew1S4jEZeCZb8kym3rY1vEYlgq7a7hCdloY+vpZu93SxxPJ9VxLj3o45cZgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vevPvo7ae+PTeKms0XJotVYLU5JAUeJd4AyeV57R8gU=;
 b=VU4NCD8IgzVI/PzdDraGwLdwft/SZPhaO/yZZoLw+piy24yGm7eH81vWOpJKVM2CBDroZE1k8YzInyDwIMyvreluEUN1KAGRu8Y/b9+FrZcM3xxKBAuqMix8DV7OzzvK3j3E1KUIjZZNdcrcCDcllITONOCYQ6pwzVbpt2w4uvgxsQdHVlpBiwqWLXzgl3++O92fAAffgC1hhATDpZ2kGEr1vFkKmSdqYK7wWTkEkfU4XhzA4qC3D4RuxF6W5ryCDIcrjTXSsYV6LsHWbwZHUZp1/JJF5zNYXJ9IekcZ7mmxtQaL7xZlkMfs3Lp9ihz52boOiywxAR5nKNYdIuvDNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SE1PPF3B12CE932.apcprd06.prod.outlook.com (2603:1096:108:1::410) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 03:51:18 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0339.008; Fri, 21 Aug 2026
 03:51:17 +0000
Message-ID: <7fcd1b5f-dc15-486d-a56f-4961a25b133a@vivo.com>
Date: Fri, 21 Aug 2026 11:51:10 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [RFC PATCH bpf-next v3 1/2] libbpf: support selective kernel
 module BTF loading via bpf_object_open_opts
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, yatsenko@meta.com,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20260819090426.267-1-zhaofuyu@vivo.com>
 <20260819090426.267-2-zhaofuyu@vivo.com>
 <5efea1c6d5feb9bfc4ffe3eedde9ab98c2613776.camel@gmail.com>
In-Reply-To: <5efea1c6d5feb9bfc4ffe3eedde9ab98c2613776.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0004.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::14) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SE1PPF3B12CE932:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bcba98c-0baf-4cb6-a9b9-08deff37742e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|11063799006|10067099003|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6qWIkdVosQ4jeVwKgnxtA+IoZc6t69/gNbU6mYj3emOqW6mJOxmiHh0M85aXcHE8z0qBpm6ktyw4NNPtZ8lh6veLwl7FkQEuykb9Sy1G7/uk986YJ0WWb+3OP/kJWbO6jYr0w7M3o3kRgdrD7bXjHhS6lEufbi0kihKg5eVl09v7P9mzdT93fQ25tpJkLyYh7IH7grl1VHtdTemu1BDyYCnUm9m5XMbGISQdUKrPVlC0ESMX18eDpsVq/C9gk3Vkm5WYb66Ul377JpZwiB8JsQXw7zT1+993CmF2NcQNJ9FBZKgSXrPdJc2vrzw+k69OGCBuBC3Lrba4UY9QtpTSUHd9HW99bF/w+djTny+xcNKAbtlMMyUuDyrKCgfFN6h6Q1aoxD/mIYB7GwrgDSUtKP0ch8vVjqLlkRSNuSpat8PHW3llJjO5dC9hZRy6CT5pQMPmUhi5DIBdXgchdN51X6kQO7hati10RjjM2CixE6rtIfzg9HRtxq1nznIyNWswMJj2XC80VBmsx5xlS3cRpr9ctvMMrQ/3ADvpdDjFKqi42XjX0UNImr8YweK/QHjvl9o9kWVzQbFvaDMbLvwPXhzkEMs7l7ZqVFBNBSuPPh4ewmn6FtSvo+HlSEmSfOHpUpUlQ7+/d48M4tOSsY3KIGK1Mp2FSx9ARtkFZulW2qA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(11063799006)(10067099003)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVJPYXR2M0NuOUliVjFWOVhyUFQrb1JIZzhYS1loSjVnVE1oN3FlSkhmRDlT?=
 =?utf-8?B?OWFOeHhTSlMrVHhwUUhwM2xsRjYxTG1mN083cDhla21vb3Rsa3NqSGZqS1Rj?=
 =?utf-8?B?aDR6bFhnWm83MUVFRXluc09FWDhLMG8rUklXODJWMnA4Vlg4K3VYQnB0VVpH?=
 =?utf-8?B?VEtadUJoZU1iRDlwSCs5aTFuZ1BZaHRlSmI4Zm5WTFlscFVmZ1l5dWNrc0h3?=
 =?utf-8?B?TllQWDlrSmdVQ1Z6c2dxbXF5dzdtMmp0eTh1bzA1emNNeXdEZmw0SXVieU5Y?=
 =?utf-8?B?VEtoSGZvaWdCOTdRSXhwS0lOMVRBYzZvbnErZjdNQWJJUk1YQW95SnFxdElm?=
 =?utf-8?B?b0VoYjB6WEdoc2d6Y1ZsSnI4Z0I3MkdBbW9JV3MrWDZ4TmJGS3NlQldqbjE5?=
 =?utf-8?B?aGoyb0F0dkM4eTVqaVFyTlNnT0tCWlMxMzZkR0JWd2NGbTc3cWFWSHVHdU1I?=
 =?utf-8?B?MFpRUzQ4QmEyb2ZScWxHZmdCa0I4dExxY2hWQnl4dlJodzVaNmlUcitzWDIy?=
 =?utf-8?B?eVdqbTFQcDRpVFdLZ1FIRWxncHlXc04waENBS0U1VXZmNWZGVHU3K1RNcEcz?=
 =?utf-8?B?cHVWd3hMZUF1MTFYVUdtVGYrUE9RU2w5UjF0bEU4R2hUaHZGN2EwMnVLenc0?=
 =?utf-8?B?YXJmdCtzSCt4NDA4OVRyNHVxbnc0bTZ5M0RYUFp0WjUzZXhub3EvT3kzVXJP?=
 =?utf-8?B?Yk5zNUhjN2JwQWRoaFFLdkFaMURGeTNwRFFkclJQYyswcTNrQlhXeDRHc2RX?=
 =?utf-8?B?YnRWVGJKODJKSkg2V0hvNElwdE1YejNUWThiK3FsZmlWcVRLSnQ1ZWpYVkNW?=
 =?utf-8?B?UFl2Kzhud28xSHdHZE5hMHVTOUpvck0yTXBwWGxzT3FNMWRsMzE2QSsrZito?=
 =?utf-8?B?T0piSUphTWdGdzA2ZVZ6Ty8zNmNyYmd1ZFRNNGJ4NXB3Zm9LeUFoMmZWeis5?=
 =?utf-8?B?N2tPRDBQc25MNVI4aS9jSjhiTVlaeU9UNG5kNnFLeG9pdlRtUU9rdldBRnZx?=
 =?utf-8?B?NVNHQzhGZDJjMWJZT2pHRVM5a3F1MzlPY21pWlFCTlc3alRkRlJ4Y05ieWpr?=
 =?utf-8?B?QVZXM2NLaFBDajArazI2Y2JvSW1pT3ZTdVJaZEdESXVHaklUMUFCR3R6Lytq?=
 =?utf-8?B?bE5CWS9XU0NtcFZXOFVaZnhlWW43MG14MUhlSHJLZXdsZWdSUzhHOTFlSUxN?=
 =?utf-8?B?T0hMTlJMd0QycjcrS0RLbWxnVXpOOVhvRXF5eGdVTDNtTW9tMDNJQXRiWm82?=
 =?utf-8?B?dFBJdHFFM3dEd2Yvb0RrdXFWSnhrTG94Z256TC93ZjBrWTQvS1ViQTFBYkti?=
 =?utf-8?B?aSs3b3k0RHV6V3M4clFSaHZqQWtMVmI4MFZkdlphbEFhTEFTaTkrMnk4RXVk?=
 =?utf-8?B?dUErNG94NFhmRklodm05NjVYamY0eXVPRlkzSWZKRHZGUHBITzdxV2Vtc0p1?=
 =?utf-8?B?MzhsYXh6ZU5LUHVoZVJaYjE5cUt5eE5oOU5oc0Q2d1Rjb2xORWZld1VDSFZD?=
 =?utf-8?B?KzI4TlY3SjdQZWwva3JrcitQNi9ZZ3gwQjlxZ0xZbXYzNmRmWC9jZmdyRStH?=
 =?utf-8?B?Ny94Q1owZGVGZWxDeXdLZmhMYVkxZHJ5WUNGWmc0SjZLUFBKSkVnb3dic3dr?=
 =?utf-8?B?ZjUwd2FkMjh1WTNUeGUwbi9xaEJqSG0rTml0b2x3MXcyZklMRVc1c28wU0ph?=
 =?utf-8?B?dTFnZEV5c1lacUd3RDdMMjZaZ1ZZbHNPMUNTaWNKWUc4UytRK090aGx2SW91?=
 =?utf-8?B?aERGRkQ2TDVoRUhtaHRUYTNxcmFRSlpVOGgyZnByMkhYTFFVd1VkVWJxVGY2?=
 =?utf-8?B?QXBlNWhsbnFhWDBoVjJXYnBIbmxTWkthS2ZpazVPa1h3MzFqNW5XV3Fzb1lp?=
 =?utf-8?B?VDJqZ050NTRrOGlkdnQ4MkxLaVgwVERCbTRTM1dhcUFHTzRtb1BnOGFkZ2ht?=
 =?utf-8?B?YkFvcjY5SmhSdWdVOUlPcy9lMm5IYmFPQ3dRc2k2ODlCREkzeE9xTVNQdjFv?=
 =?utf-8?B?UkY1bmNPSDlVWVN3RU9GRTdhcHR2eE1lTitLYzdxeGpzY09adkR3TTdMNlo3?=
 =?utf-8?B?MVFHNDJCQ2JOMGhRVUNPOHZ4anpHc3RMWUVpMjFQQTJCSDBOK0ltU0JvZDMx?=
 =?utf-8?B?Ky9DcHNqR3U0bEpnY2xhd3NyM2lFREJNNnlJT3FHWWRQUUtEbVROV09aOTNp?=
 =?utf-8?B?Q1JBZk45S0JTUi9Dd1oxdWJEUTVPbVEzbTYzRVVGcGpqYW1hLzhLYUhMSDgy?=
 =?utf-8?B?QUZHdEw2a1FQaG4xZUxKQ05QUi9nckJxVUFIVDU2SWoyVHl5QXNVTEg3WWJU?=
 =?utf-8?B?bGN3b3ZGV3JINUtwVGJleCs1WU8ydlJQRFVWM2RwS2FWaWRIZmZ6dz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bcba98c-0baf-4cb6-a9b9-08deff37742e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 03:51:17.5265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LEk08olNpZoXUV1iOUeX2Wk0h0HfeuITkx1IM9PMwmTM3EVzGnH9m1565/05pa4L11wz3Ed/V2bUDMyCWTknFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF3B12CE932

Hi Eduard,

Thanks for the suggestions. Please see my responses inline below.

On 8/21/2026 7:58 AM, Eduard Zingerman wrote:
> On Wed, 2026-08-19 at 17:04 +0800, Fuyu Zhao wrote:
> 
> Overall the logic seem to be fine for me, please find a few comments below.
> 
> ...
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 514e4e9daa82..37934ca49dd7 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -779,6 +779,13 @@ struct bpf_object {
>>  	char *token_path;
>>  	int token_fd;
>>  
>> +	/* kernel module BTFs to load, as specified via bpf_object_open_opts */
>> +	struct {
>> +		char **names;
>> +		size_t nr_names;
>> +		struct hashmap *names_map;
> 
> We already have a strset type, please use it instead of a direct
> hashmap reference. This would remove the need for `names` field
> and simplify the bpf_object__init_kmod_btfs() function.
> 
> Also, do you expect `nr_names` to be high?
> If not, wouldn't plain array search be simpler/faster here?
> 

I initially used a hashmap to avoid repeatedly walking the requested
module name list. But I don't expect nr_names to be high in practice, so
a plain array search should be sufficient and simpler. I'll change this
in the next version.

>> +	} *kmod_btfs;
> 
> Why indirection?
> 

I followed the existing pattern in bpf_object and used an anonymous
structure with indirection here. I don't have a strong reason to keep
the indirection, though. I'll simplify it.

> Also, I agree with the bot here, prior fields use "module" in the name,
> so something like "btf_module_names" or similar is a better fit.
> Same for publicly visible 'opts' name.
> 

I think `btf_module_names` is a much better name than my original choice.
I'll change that in `opts`, too.

> ...
> 
>> +static int bpf_object__init_kmod_btfs(struct bpf_object *obj,
>> +				      const struct bpf_object_open_opts *opts)
>> +{
>> +	const char **kmod_btf_names;
>> +	size_t i, kmod_btf_names_cnt;
>> +	int err;
>> +
>> +	kmod_btf_names = OPTS_GET(opts, kmod_btf_names, NULL);
>> +	if (!kmod_btf_names)
>> +		return 0;
>> +
>> +	kmod_btf_names_cnt = OPTS_GET(opts, kmod_btf_names_cnt, 0);
>> +	if (!kmod_btf_names_cnt) {
>> +		pr_warn("kmod_btf_names_cnt must be set when kmod_btf_names is provided\n");
>> +		return -EINVAL;
> 
> I kinda agree with the bot here, why disallow an empty filter here?
> 

I understand the point now. I hadn't considered the use case of
explicitly skipping all module BTFs. A non-NULL `kmod_btf_names` with a
zero count is a way to represent this case, so I'll support it in the
next version.

>> +	}
>> +
>> +	obj->kmod_btfs = calloc(1, sizeof(*obj->kmod_btfs));
>> +	if (!obj->kmod_btfs)
>> +		return -ENOMEM;
>> +
>> +	obj->kmod_btfs->names = calloc(kmod_btf_names_cnt, sizeof(char *));
>> +	if (!obj->kmod_btfs->names) {
>> +		err = -ENOMEM;
>> +		goto err_out;
>> +	}
>> +
>> +	obj->kmod_btfs->names_map = hashmap__new(mod_name_hash_fn,
>> +						 mod_name_equal_fn, NULL);
>> +	if (IS_ERR(obj->kmod_btfs->names_map)) {
>> +		err = PTR_ERR(obj->kmod_btfs->names_map);
>> +		obj->kmod_btfs->names_map = NULL;
>> +		goto err_out;
>> +	}
>> +
>> +	for (i = 0; i < kmod_btf_names_cnt; i++) {
>> +		size_t idx = obj->kmod_btfs->nr_names;
>> +
>> +		if (!kmod_btf_names[i] || !kmod_btf_names[i][0]) {
>> +			pr_warn("invalid kernel module BTF name at index %zu\n", i);
>> +			err = -EINVAL;
>> +			goto err_out;
>> +		}
>> +
>> +		obj->kmod_btfs->names[idx] = strdup(kmod_btf_names[i]);
>> +		if (!obj->kmod_btfs->names[idx]) {
>> +			err = -ENOMEM;
>> +			goto err_out;
>> +		}
>> +
>> +		err = hashmap__add(obj->kmod_btfs->names_map,
>> +				   obj->kmod_btfs->names[idx], 0);
>> +		if (err) {
>> +			zfree(&obj->kmod_btfs->names[idx]);
>> +			if (err == -EEXIST) {
>> +				pr_warn("duplicate kmod BTF name '%s' ignored\n",
>> +					kmod_btf_names[i]);
> 
> Nit: I'd downgrade this to debug level, if at all.
> 

Agreed. I'll downgrade this to debug level in the next version.

>> +				continue;
>> +			}
>> +			goto err_out;
>> +		}
>> +		obj->kmod_btfs->nr_names++;
>> +	}
>> +	return 0;
>> +
>> +err_out:
>> +	bpf_object__free_kmod_btfs(obj);
>> +	return err;
>> +}
> 
> ...
> 
>> @@ -8515,6 +8645,7 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
>>  	err = err ? : bpf_object__init_maps(obj, opts);
>>  	err = err ? : bpf_object_init_progs(obj, opts);
>>  	err = err ? : bpf_object__collect_relos(obj);
>> +	err = err ? : bpf_object__init_kmod_btfs(obj, opts);
> 
> Nit: all other options are collected before bpf_object__elf_init()
>      call just above.
> 

Agreed. I'll change it in the next version.

>>  	if (err)
>>  		goto out;
>>  
> 
> ...
> 
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index b965ad571540..2f8ff6d2d3df 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -224,10 +224,24 @@ struct bpf_object_open_opts {
>>  	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
>>  	 */
>>  	const char *bpf_token_path;
>> +	/*
>> +	 * Optional list of kernel module names whose BTFs should be loaded.
>> +	 * kmod_btf_names_cnt specifies the number of entries in
>> +	 * kmod_btf_names.
>> +	 *
>> +	 * If kmod_btf_names is NULL, all module BTFs are loaded, preserving
>> +	 * the default behavior. Otherwise, only the specified module BTFs
>> +	 * are loaded.
>> +	 *
>> +	 * kmod_btf_names_cnt must be non-zero when kmod_btf_names is
>> +	 * non-NULL; otherwise -EINVAL is returned.
> 
> Nit: please add a complete list of behaviors this affects, e.g. CO-RE,
>      fentry/fexit resolution, etc.
> 

I'll expand the comment to cover the affected behaviors in the next version.

>> +	 */
>> +	const char **kmod_btf_names;
>> +	size_t kmod_btf_names_cnt;
>>  
>>  	size_t :0;
>>  };
>> -#define bpf_object_open_opts__last_field bpf_token_path
>> +#define bpf_object_open_opts__last_field kmod_btf_names_cnt
>>  
>>  /**
>>   * @brief **bpf_object__open()** creates a bpf_object by opening

