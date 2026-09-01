Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012070.outbound.protection.outlook.com [52.101.126.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32F941A542
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 03:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788232534; cv=fail; b=E7UdHxFK9fGtKLF4qLrZtHpP/Xvu6iTOkVf0YZph6u7W195QGaHCgd0EmROxcTgTaCub79UQo9Y8SVYAVurNbBaUu2EwHHZ5fEv3FvKYhJASAJKwodOhq9JJH2sHNce5+G0fjpF/KJO8h1cZ98WZ0tEJFvhDVYMpIC1l6/KCrss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788232534; c=relaxed/simple;
	bh=DNSq5tZDWERc0PMdFGOAygCWFTdErfF4rSn5wBVCp6s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mPwATpcohXUeYCQ+AkQluUteLujcEgtSy64vpqCo0rCFvJpKndPR1zsPVu5Ov+vh0NUkA1owIGOlbp3Ma+3gp3s/3Wusc2+7bYlOAUceOylTiI9bVdGFkk3Wqi2s57n5lHrDguEm6HeznGVErSjSxl56b9IAlsa+DC/BVsLCebA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=RuFsAYOa; arc=fail smtp.client-ip=52.101.126.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="RuFsAYOa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1+4olHQsAZZprdH7YygptQUns1Ob2GqS+ldFnfqh4iPvLhRVruq10Mb1LMUQi32PVU/LSifLwJg3txFAMiJBk+DOY3oWFMlUgC/jMeFZt5ZTFXYRA3WlmaY3trkixCXpd13z09vQUiA0JQSmIiytAmixylPt40xDavQ/+XkaUHBVGwyE/jhZnNxEdlS0fi+84j70CyZmhUdZKtLSrcQIHu8rf+3i2duWJVt8X3QRniJgeEZ56FGPQsxGPvjFYl4BkpZgX73TP8Q2F1U1qvuQxnMTsMnDS8DXNGYf/2j9jPSsjUetZJ8mqZUSOHjlQ0owW+jYOyTTyLdTkyBxk371g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfftXaoutI1Cmko3xtKET1DB88Fsk307TwqnMKQ56pQ=;
 b=hRQh22sxwAQjBQDtPOjav6MIt8u9wi5r/GOBUKR+YG9quNqI2lsdOatZ8J2H1/Jy10YRVuOGuMfg5+7svsVJZ3oJWBsTv7h9694vGNyVkb30rAUd0yhZaV8BlxNazm/yOMbBl4JgEfGqX5G5cSqCOXG3hniav92g9ZVuR0PAGd6g+xYModVcb5SuvUQN8o8MGT1K8jzP+j5ArhRjj5CK0lR5B5z77eKCEn1t1jHoo3pgYmbpsPU4csCz1/dVDXygP5RdV6F8VYbVLSCpuu7xfJwt79FncRF1mnK1i1PjdlQnqLfohqCPc4vybZUJCUqFkX2UGxcE2B2XqAdrPX2dEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfftXaoutI1Cmko3xtKET1DB88Fsk307TwqnMKQ56pQ=;
 b=RuFsAYOawLxF1nB5i0qLnwSjz20Rs8Jxq+ieDL5a491PvcWgQ0QC/p0h7IFIa1XUN5iiJCMhkWGwUKMAhpxjalK28U8plPaJcz5GyzJFAiKKP/lqeox9WaN8qkD/CLwbCkOhkVjFtCti97eAZAuPi+Y8gdEBJvKp+YBI16WZki3G3ahQTU0Dlti50SaoLGeTQXHulDnEOYnTjpjLm/PM0o3IYUrSDFt0dS4cnoRTdF+51cVFDywjjD+mXtAF/7snI7lh+oCUbisLFBI82O0XgtjycxifnCU0LrpHM80JWPRW8dDyT57iYPgMIl9EyJp+Tf8pk2J7pfjqfjb+/zXTDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SI6PR06MB7269.apcprd06.prod.outlook.com (2603:1096:4:245::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 03:15:23 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 03:15:23 +0000
Message-ID: <dd0005b7-a8e9-4cb1-9ba4-6f80b950c401@vivo.com>
Date: Tue, 1 Sep 2026 11:15:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org
Cc: eddyz87@gmail.com, andrii.nakryiko@gmail.com
References: <20260831133809.1161-1-zhaofuyu@vivo.com>
 <20260831133809.1161-2-zhaofuyu@vivo.com>
 <ccb5d732-90ef-4acb-b11d-75da7f1d21ce@oracle.com>
From: Fuyu Zhao <zhaofuyu@vivo.com>
In-Reply-To: <ccb5d732-90ef-4acb-b11d-75da7f1d21ce@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0195.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::17) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SI6PR06MB7269:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a8058c3-0ed5-432f-8cd4-08df07d74274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|22082099003|18002099003|56012099006|6133799003|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	WeuM9IF2/RuiPAWW/3XO23qpxaEFeCAl3GEjEwci7sXIscAkx3MGjTbCO0L0EzN/f66Kl5QMO7SwfR/4aKgqbHnQjQcI9wAHMcOZSkgkOFaUqJe8CGcDYmsEdebafvWgYPP57Je5dIKCrE/aXgtJb+dOODRqE6ul1116yCswGhehlz6uXDcnkO+kd+SS2nd65Gmi9PGPryejbn7l4Z0pxQawKUaVNpVtlUUsShQyE77NJXos8YcnvlWlUTMY5tHfS7xxch8ga49iEA4C1l3otPkzVPVrCtH3J1l1z8jNfRLqAxF54kCUABZkmR38YDeg+55V0N2WZUtPUqNMsHuPtsOxVgqPNYWi+TtjNFsnqDaxStSf8MitNsJ+STMgVDm2mOReJcVWOWpiyxp0pzO+W3UinWFVIkyO0sweICr/5Z+62xbwT5VuT12ROWdky6sHj+MpgJnQDCHAT6xyloYtn5MAdx57sYST0nyYwg+FzaFFSebWIwfvDpuUqZ7JSFA6IVtTpK2RE1v0tleaZrj4YUJ3xoJoWf6/kJBRllxSh5EYuIIPYL5uwnpB3rnuw1yhzz/gcz5rGk7g4G4N3n/n9j7fxReykIjh8WIhN6sQ+2ELjYx61J5IuTRPJSVwYp2mHWi314jCXZnGmLfwdmSgYyL2XEzUUH+N+hiSbar0PzU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUpWWUJBZE0xYU9MRWw5cnRzQUNmdXVMVkY2WENyc0J3YytyMlhtOUtXZHNF?=
 =?utf-8?B?azNmNjdIdGtNRDF4MWttZCtIYU9RaVROak01bURFa0djcTdXYXpVaENLWWZl?=
 =?utf-8?B?ZE91TS9nbEtMM3pua0VJQjN1QUExcnkyZmQwY3dtSWZlbUxMZHZHME1HVkNj?=
 =?utf-8?B?OFVFMUdXcUx1ZEYvd0xuakRCYUJ3RjdEWTk0Q1B4cmkxQnZwN0FJRnJMSTk3?=
 =?utf-8?B?V3BSem5lUHBxWGhWM2RGRk0wbyt6S3FhclZsRzlEbTczYjZLUkYzQllDejRL?=
 =?utf-8?B?TWhEYzVrRnZkWXZzNEU1ZXFoS0xNd2tobTJ6NEVrS2xVb3VCSHlRakdESk1o?=
 =?utf-8?B?K3lOdW11eWlGNjJrdlltM09BNHhBTDYyMFBJZk9Fb0dEajdIRWY4WGJiajl1?=
 =?utf-8?B?NnhSUmZMb1RsdFRlOTZiakJNbCtKdzc1cjZFRC92bVJVODAxb21JVXI2MjhY?=
 =?utf-8?B?aEVZTXAxVzlvU1p0eE8wWGRxbWtsekJnVFA0clFPMjJySEVlK016cmVlL2pX?=
 =?utf-8?B?cFNFWVdaYWtCQUNTTWF4YUVwbnlmZGxVSnU3c0xjN091aWo4SnN5QUpLVDd1?=
 =?utf-8?B?NllIVUJVMjRoaC9FL2JlYXVoUGs2YnRJRGdyckd3MGtIeXJ5cWlKQmVDaDIr?=
 =?utf-8?B?bVhRWlNrS2dFbVVuV3ZMM1QwaXMvaG9SRTl3UE5UT2N5Tlo1elBXTWV6V08r?=
 =?utf-8?B?Y1gwNnJSSkMzM3FrNkZRZlpId250LzMrZmM1anRLL2FVQkNsejAxY3l2d0dT?=
 =?utf-8?B?R3ZKbUZZdG1rUStOZ1dHRFRvTEV5ZzJBc01ISDFyUXd1UVJ3dHp3dFVlbkMz?=
 =?utf-8?B?VDBFbE9YZHhXNTJTZ0plb0JNanRYOXZ5Yk9ISmNDQTQzRExra1JWUEZmV3g3?=
 =?utf-8?B?aVMvYlpqemJjaW9ZKzZmZmpmUnIrN0YwcUJ1SUw5bS9yelBHTHNrb05uMkY2?=
 =?utf-8?B?a2VUYjByUmtObi9yd1FvVFdqd3dZcDVlNW5vMmZ5K1ZuUGFWT2RFRGhSNmhR?=
 =?utf-8?B?TmVVdmdKbjd3Z0t2ejBkRURiOTdsUGhOMkE4elNXUFQvWDJoc3ZCSmVrR1VF?=
 =?utf-8?B?NHU0NUtQTVp2VjJhcGNRREJsaU1uYlZHUDZ4eVk3Z2VjakZGeVpEaUdibHV3?=
 =?utf-8?B?YXBoT25ReExnUlRQK3pHd2RaM2RjQWFlYUh0N0ZHYVZhY012VjJSL0t1alpW?=
 =?utf-8?B?dTcyM09qMFh6alFSUHMzTCtnSTU5WHBzWFZnZ09RQk1RWWF5a3FhRUFGOHpn?=
 =?utf-8?B?OFpnbEZKb2s3TVJoTTRxY1o4Z245QkU1eE9EZ0sxOXU4SjNtZDNkUUk3b2E0?=
 =?utf-8?B?enZWd1ZuM1JEWmFRTDBjVDRSMDFCSUNoMUNqUE1vWTVITlczUUt6VllydmF2?=
 =?utf-8?B?TVVqeXdKTmt5cG9yM2twd3crR1FiUHlGLzlqSEpvc3NhQnNCWC9DcGhkbzNM?=
 =?utf-8?B?RVREeG9OUFhJeHhJZlNVWXU1Y3hHU1F0ZlZMWm1YUk5uM2hOWWxhWHRpb2NT?=
 =?utf-8?B?N3dvS083YTdWZlVXbHJCaTVBMUV4Z3VjRkNkckZBVmVIS0VncmFQVlVsYW5N?=
 =?utf-8?B?ZHE2YXFVZC9DL3dMY0pVZ3VnN1hOM1JoV0JwMnJNSGQwUExqN0ZDelVSaU16?=
 =?utf-8?B?bmhWUXdVS1lBNDRRc2pWTXk1dFZla2tiVi9xUFlUbC9qUGlJYTZ2MWhpZXdi?=
 =?utf-8?B?ckNwRlhrTm5HTXdtbk9PSmtMZFBTb2NqZDc0MEhyTWdBVlpRTnNuTG1PVklT?=
 =?utf-8?B?YzZqbjBONjkrSzZjSm1QQ1pzd2JaWDc3QWNOUVpndldBc3ovTGtSTndiaW9K?=
 =?utf-8?B?cmxOMWMzK3ZYRHdzV0paOFdmZWdpQ3JhMjYwdkxvNHdKK2dYSlU5cjFwdHRs?=
 =?utf-8?B?eXh6ZURFV2ZqbUtnZ0xkRHdOUW9yTEU5dmRLYkU0UWxteHdTR3g5N0VYWkFw?=
 =?utf-8?B?MnFoOGN6VEY3aHg4SWplWmZxR0N3WGxEU0hVK2lVVWdYZ0ZwNEJKNlc3T1Rw?=
 =?utf-8?B?bnJOTFZJUGUzbHlyV2RHVVZ1a0hHS2hHK0FIV1p0OW85NHZJVVVIUjVQZVdZ?=
 =?utf-8?B?QjdLa2MrdXZuc3J0eEkvQ3EzQmF2RHQxdHJiTFNyRlQycHhYYXM0cjVubHo5?=
 =?utf-8?B?bWJaL1V2VEtlcVNvVkNZNTdEQVRtMjkvVldMOVR5amF4WEZKbDJMUEpFWlFo?=
 =?utf-8?B?dlVlMFYxSnFMcUpFdHY3eWR4S05uc0FpZWhLdGRzV1hCbEw0Q2VGSkZPSEll?=
 =?utf-8?B?MTMvN3Rwb2lYWUlVS1RqQlQ2Qk1VMFNUaE1ISXBKVXhQc1E1RzRBRkVNRGg3?=
 =?utf-8?B?MmpRZXpiTDROZHo0YXRJWUdTbThDek1nc0M0RE5LNjJYRTJGUmdsQT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a8058c3-0ed5-432f-8cd4-08df07d74274
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 03:15:22.9311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Z5Yn3XDDFVjo68WYgg67FZhmH+7UtLEwWPMWolyl4iexRQ/AuHQGWMCEEg9PrFVOlPixBuOcjkWyRz8FF3m1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI6PR06MB7269



在 2026/8/31 22:46, Alan Maguire 写道:
> 
> 
> On 31/08/2026 14:38, Fuyu Zhao wrote:
>>
>> Add btf_module_names and nr_btf_module_names fields to
>> bpf_object_open_opts to support selective kernel module BTF loading.
>>
>> With btf_module_names:
>> - when provided, only the specified kernel module BTFs are loaded;
>> - when an empty list is provided, no module BTFs are loaded;
>> - when NULL, all module BTFs are loaded as before.
>>
>> This avoids unnecessary module BTF loading and reduces BPF object
>> loading time when only a subset of kernel module BTFs is needed.
>>
>> Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
>> Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
>> ---
>>  tools/lib/bpf/libbpf.c | 117 +++++++++++++++++++++++++++++++++++++++++
>>  tools/lib/bpf/libbpf.h |  24 ++++++++-
>>  2 files changed, 140 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 514e4e9daa82..e19d0afd2592 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -779,6 +779,9 @@ struct bpf_object {
>>  	char *token_path;
>>  	int token_fd;
>>  
>> +	char **btf_module_names;
>> +	size_t nr_btf_module_names;
>> +
>>  	char path[];
>>  };
>>  
>> @@ -5803,6 +5806,103 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>>  	return 0;
>>  }
>>  
>> +static void bpf_object_free_btf_module_names(struct bpf_object *obj)
>> +{
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
>> +		/*
>> +		 * The list is expected to be small, so a simple nested scan is
>> +		 * sufficient for duplicate detection.
>> +		 */
>> +		for (j = 0; j < i; j++) {
>> +			if (strcmp(obj->btf_module_names[j], names[i]) == 0) {
>> +				pr_warn("duplicate kernel module BTF name '%s'\n",
>> +					names[i]);
>> +				err = -EINVAL;
>> +				goto err_out;
>> +			}
>> +		}
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
>> +
>> +static bool is_module_btf_needed(const struct bpf_object *obj, const char *name)
>> +{
>> +	size_t i;
>> +
>> +	if (!obj->btf_module_names)
>> +		return true;
>> +
>> +	for (i = 0; i < obj->nr_btf_module_names; i++) {
>> +		if (strcmp(obj->btf_module_names[i], name) == 0)
>> +			return true;
>> +	}
>> +
>> +	pr_debug("skipping module BTF '%s', not in btf_module_names\n", name);
>> +	return false;
>> +}
>> +
>> +static bool no_module_btfs_needed(const struct bpf_object *obj)
>> +{
>> +	return obj->btf_module_names && !obj->nr_btf_module_names;
>> +}
>> +
>> +static bool all_needed_module_btfs_loaded(const struct bpf_object *obj)
>> +{
>> +	return obj->btf_module_names &&
>> +	       obj->nr_btf_module_names == obj->btf_module_cnt;
>> +}
>> +
>>  static int load_module_btfs(struct bpf_object *obj)
>>  {
>>  	struct bpf_btf_info info;
>> @@ -5825,6 +5925,9 @@ static int load_module_btfs(struct bpf_object *obj)
>>  	if (!kernel_supports(obj, FEAT_MODULE_BTF))
>>  		return 0;
>>  
>> +	if (no_module_btfs_needed(obj))
>> +		return 0;
>> +
>>  	while (true) {
>>  		err = bpf_btf_get_next_id(id, &id);
>>  		if (err && errno == ENOENT)
>> @@ -5867,6 +5970,11 @@ static int load_module_btfs(struct bpf_object *obj)
>>  			continue;
>>  		}
>>  
>> +		if (!is_module_btf_needed(obj, name)) {
>> +			close(fd);
>> +			continue;
>> +		}
>> +
>>  		btf = btf_get_from_fd(fd, obj->btf_vmlinux);
>>  		err = libbpf_get_error(btf);
>>  		if (err) {
>> @@ -5891,6 +5999,9 @@ static int load_module_btfs(struct bpf_object *obj)
>>  			break;
>>  		}
>>  		obj->btf_module_cnt++;
>> +
>> +		if (all_needed_module_btfs_loaded(obj))
>> +			break;
>>  	}
>>  
> 
> I was looking at the selftest in patch 2 and was a bit confused as to why
> specifying just "nonexistent_module" in the module list was a way to test 
> the scenario where we fail to specify a module that is needed ("bpf_testmod"
> in that case). I think I see the answer here - we don't look at the module
> count and check it against the number we asked for after the loop completes.
> In the case of "nonexistent_module" our obj->btf_module_cnt is 0. Since 
> all_needed_module_btfs_loaded() will evaluate to false in that case,
> we keep iterating over BTF ids.
> 
> On loop exit shouldn't we check obj->btf_module_cnt in the case we asked
> for specific modules, and make sure it matches the requested number?
>   

Sorry for causing some confusion here. My original design was to
treat `btf_module_names` as a filter rather than a list of required
modules. Even if the number of requested and loaded module BTFs does
not match after the loop, BPF program loading will still fail after
`load_module_btfs()` if a required module BTF is missing.

However, your question made me realize that this behavior could be
made more explicit. It seems better to detect the mismatch and fail
here, rather than defer the failure to subsequent processing in
libbpf. I'll add this check and update the corresponding selftests in
the next version.

Thanks,
Fuyu

>>  	if (err) {
>> @@ -8508,6 +8619,10 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
>>  		}
>>  	}
>>  
>> +	err = bpf_object_init_btf_module_names(obj, opts);
>> +	if (err)
>> +		goto out;
>> +
>>  	err = bpf_object__elf_init(obj);
>>  	err = err ? : bpf_object__elf_collect(obj);
>>  	err = err ? : bpf_object__collect_externs(obj);
>> @@ -9629,6 +9744,8 @@ void bpf_object__close(struct bpf_object *obj)
>>  		close(obj->jumptable_maps[i].fd);
>>  	zfree(&obj->jumptable_maps);
>>  
>> +	bpf_object_free_btf_module_names(obj);
>> +
>>  	free(obj);
>>  }
>>  
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index b965ad571540..1cabf7e46554 100644
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
>> +	 * The list must contain valid, non-empty module names and must not
>> +	 * contain duplicate entries; otherwise -EINVAL is returned.
>> +	 *
>> +	 * This affects:
>> +	 * - BPF CO-RE relocations against types defined in modules;
>> +	 * - BTF-based resolution of attach targets;
>> +	 * - module-qualified tracing multi-attach targets;
>> +	 * - struct_ops kernel type resolution;
>> +	 * - extern (ksym) resolution for kernel symbols defined in modules.
>> +	 */
>> +	const char **btf_module_names;
>> +	size_t nr_btf_module_names;
>>  
>>  	size_t :0;
>>  };
>> -#define bpf_object_open_opts__last_field bpf_token_path
>> +#define bpf_object_open_opts__last_field nr_btf_module_names
>>  
>>  /**
>>   * @brief **bpf_object__open()** creates a bpf_object by opening
>> -- 
>> 2.34.1
>>
> 

