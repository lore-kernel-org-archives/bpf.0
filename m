Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013056.outbound.protection.outlook.com [40.107.44.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896FC37475C
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789458881; cv=fail; b=LrGt7jYZVHlp/pC5x+V2Zr/rY8LfA9lM1noIeEUqHa/GSoQO2Gf3dREysorEQvfA1qwdo0DkwJhXbCh/dJzSdGWo3KBvif8+7tfFHnYDs3k0k7XzV1AEZb6togMYHgXQRG7HDXkpJRhb66+XEA0xr1tpGwFq1e37NtHQUPX0N6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789458881; c=relaxed/simple;
	bh=VsUOPAp59I/NDENBM6KqxL82Nu7mnGbGY6HwAJC6rRk=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VoW7l3pQ9oFUh6e9kq1CUVtyi4gpyQ5D6OiSPU2aR2chyzL30MplPSEYG1cAU3bTlT4tKoLwfG3CCIEBiYJeeid8NCVYtYf0YJgQaDc0K2sGxK7SUIxV/+C+vCy0MtWzT/Guce2iesTRUe3QU4E5aGzC960A3i7xZDgmj+N6/2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=fiQ6wgeA; arc=fail smtp.client-ip=40.107.44.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="fiQ6wgeA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SkM/XY5x3FGAfdyJMow1yS655df05+CnuPqwMJKWxWfwWAaMQTGLZoxV32eREvLUBbv4LwOB6ygIDkG3NHWmJbiRqh5oaULGOiTi1ZyFTFWJxn6btOiJv40mGqu30JEfIooJ0oBSnZRcqodqI3luoTZYtIaFfdC4lfbMhwyULQ7L7zNe7vx59qo/Kal7kyLH84kcC3pjw97njR4Ds1/6YECY9e7OQjm4diL45VtuKNi6gJXjmb7p7Oskma7cwLTUI3OjHtI3MMjOf9gAHo1FsspeE9gj7DPh3F4MtRLqFwDmIl3iJMHTkp8uJqV1ceT7FJy/DkzOPY5w0sH+X4aPRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIk7Mt4juBxSaUE2c26k3XAtkUUn9KY1sIv0oBboKeQ=;
 b=bA4iB4RBGa6wa14n+TJ093QrZKdtDExGYzrg1+LWWDlG3lOu0wm0romm8i+VFCXEqDkXvmcCLh68pgGi0fdwaqlItG4XARhqaqx962X7CQTK3VKzgmigWDaytaLV0f/5uhaPZuft5svgbyHjJaM345vnAxluyof6lSn3c4PYPEw6Qc2Y0hmCrvmcel/y92HDxtTVPeVnCA++Zc/NNIiwCojdyqILePbUXxkwsJ8+N6E9K6gxUDvsA3kM9r8aaIJXgHVemYWyrRfq92pSgxSP0SiLjIf5vv1mN0+kYxNHT359yT+psSvpX7IYXPffLWjDfmT0CveFZVvSWCeHOWI0AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIk7Mt4juBxSaUE2c26k3XAtkUUn9KY1sIv0oBboKeQ=;
 b=fiQ6wgeAUxg2CUVeAR00oaMXH7FjO8IiSoIvDqee8hGsmphf/MWYeXrmzYe7r2U3PslCda+sCv4Sw96zI3Mh31e4MRNXgwfX/2Hcyit+pJGSjAs6HrigIWPnIO8uereMZDdXafhoPoT83kPPF1549qg4tw7l1qmH2EcaNE+z8We6Jsnx0+oxivZqkcumSKK+qUvwDU/gJZxuMwyn2BvhBLPHwaSxj1+yl1l+uRRBFBEH95v+9/O8MBy/WsGCie4xy4JJMElSsmxtAKanK0uaw/Mr4hu1PER4WCyAAivOL+LNBuzvUHPtzBOTp1RAU8vJ0dIWPG/ik5QQLEloGC2ubQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SI2PR06MB4996.apcprd06.prod.outlook.com (2603:1096:4:1a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:54:34 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 07:54:34 +0000
Message-ID: <d58dc76e-c275-43b8-b924-2943292bcf9d@vivo.com>
Date: Tue, 15 Sep 2026 15:54:29 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v8 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: eddyz87@gmail.com, andrii.nakryiko@gmail.com, alan.maguire@oracle.com,
 olsajiri@gmail.com, andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
References: <20260911120820.46900-2-zhaofuyu@vivo.com>
 <e9e749ceac4e34adc78f6fd53cf22e40709db06a07f1cc99c66858ff3b67d5c6@mail.kernel.org>
In-Reply-To: <e9e749ceac4e34adc78f6fd53cf22e40709db06a07f1cc99c66858ff3b67d5c6@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TP0P295CA0007.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::7)
 To PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SI2PR06MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: 920c2def-31fc-45a7-83e8-08df12fe950b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	URvY0U9P17smrAQa3ZuJ6a8UcV77rcFUKHkJifzc3pHgfpowAuOvAbWVZNZaDo1Ih85UtqKm/7jZOTa7CHORjmttU79zUFQF6mNbh0izIjG12SAk8qZRTBs6mPttlajRc2H34S7p7US9fBqCKxyvH/E4wKpW/WFYS2YHjHXNYMjbeaQmUPVJvE7ghyt26lHfW8ylHSf2Pgc9fgrkj3IU2vZmpo2tSIO/MRTLUguOQUSbLlDdlCEOtZd/puSQvVKrejxGyTkjvXHhBkKNGUH4BrRtzqjs6jcIf1ab6h/uxxcvgF7CTDlb0W16Vd8l7fPngi3g3nv+9DIhg673dyGGpE0tLLwwIOGgVmeex1AdILDgmmzTv/8GOurF9jam0DXok7GuYukMXiETd8t8IepUA97++2eyGmKz1PJflQ3cGRtU9zH9C15Ce97xyMp7B80cl19Q9xMSsvcqk/gvjLb92yF72I+CXS3mUf9FGho9d27Md4mi7aritkny7xyVnvoa+SqNs9BLjmORCCQz3kI+VEpe6ZZroBPR2g+lomxrQVV72p9mEHyvhnOBp8sL9KbUafPmRp67oWr8XmBqrC9zJkpyCuNjAQzxsGGmkd2gSaX72vFiKN0dH8JyVpMlIiRd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yml1dCtpeURWekJ0MXlIMnMranNxWlZ4RUljanVRMzIzaXlISkkrQUV5cVha?=
 =?utf-8?B?d204eUxIZERRYzJINk9IZG9xT0w0eU5SMm1KMm9DYUNDVVoyeENEMUpXU0lN?=
 =?utf-8?B?ZHVTS0szbzQrRlBqQUEyTW9reFQxVnNnTTlUTloxaVcyVEhZaVNJQ1YwS3BD?=
 =?utf-8?B?UVhhS2xOYzlsZzArdldORjIydUNYcGJyc1l4RnJrTXVhMG9NRUZGS1pWMlBO?=
 =?utf-8?B?emR2Nk81U2pnN01EM01LYWJEOVhpeG9zNTZUYW9qdWpRZTA3a2dheTR4cUdT?=
 =?utf-8?B?eGN6UmRmY1FqV25mZDZaYkZ3TDlBNUsvQTJ3RDBtR0l0OWQzYllNWFp1K3lO?=
 =?utf-8?B?YzJjTU1oaWJZNytpUDlYWmFDTkJScHBOVDRUdCtlUW1LZmFrQWhwUXNmZisr?=
 =?utf-8?B?V0QxemxSb0RlelZiZWFRNkRDNThSNEZsMnp2S1FsNXppUW14NXVIamwwMzdL?=
 =?utf-8?B?NzZaeWgwMGlXQmkwazArNzZMSzJSZThFaFFNcXE2V1RHRmJnU1A2cndZT1BZ?=
 =?utf-8?B?TEsxNDRrdkFWZW44Sm9adkM2N2R4RGc3Njg4aDFmdFNvNUQwRUZCTW1KYVdK?=
 =?utf-8?B?ZW04SlV3QnQzR2dENE1DYXBwUnNmMjNjRytIOGRLU1pRS2lqbkpIa2w4MHAv?=
 =?utf-8?B?VnhFL3ZjOWpibXExd2t2VFFmNFdVbXVEV2R1N09TNm43dVZEbnhGN001Vk1a?=
 =?utf-8?B?b1dHbzRaVEpDRVNSZ1k1YkxYTWk4djlteHR0NmF1LzBnTG95QmZDM0tHUDRR?=
 =?utf-8?B?MmtkNldVMDNpRXZMUWx3K1pWV1RlU2lsYk9oWkt0MGRQSjdlbUxkTGphR1RQ?=
 =?utf-8?B?MHJYVTBEWjVFYlFzcmNuZEVlbGlmd1o1aTJEZ0dnMVpxaWlWdTBhcHlUcjVK?=
 =?utf-8?B?emtEdDcrZkxHTEw0UkQ3ZDR4dnVJNlNnNzVEY0xtME5mY1VBdzB2c1NDbDQ3?=
 =?utf-8?B?QS9JSjlnak1Da2U5NDViTTJ3eXRLV0pRQklvWEEyMnYyTldKdzhxcU1IYUtv?=
 =?utf-8?B?aFVMRjk0Y0RzcjNWQ0V5MFhteFZTQ212cjhTQldzaEt6QlRLclZ5RkQ0aGda?=
 =?utf-8?B?ekhLRzBRWnB4Ynp0dFB4Q2loTStDMUp6ZFlMM2xQT0YzMFRIbUlZMEYyUXFz?=
 =?utf-8?B?UlhtcEZ0YWxmVWlJNlVFSzZwNWtZeHRZSFlhTnlBbkUxNTVXaFdURFJhL3V3?=
 =?utf-8?B?aklBa09WcitCY09jTlBFSW1QSFhGb0xreTQwaFpEOW8wcW9tL0dsc3Z6SW5M?=
 =?utf-8?B?SmpxczRFQmFJMEtTNmNRR3RBdUZUbUVWdTNPby9wVVpVMlo1enRtRlFramd4?=
 =?utf-8?B?aEdOOW96ZXh1Q2JSVnZFTkpjcTdlejFxQ2IvaUZEVStLNlZ6VHFFK2ZNZlox?=
 =?utf-8?B?cEtQM3NCQm5hZW1NUnZmUjNJQjlabFFDU05QM1RmVEYxN2ZXWWp1cGMxc2ht?=
 =?utf-8?B?MnBON3ZVR0tZYWszR3k4aG5Xei9CR3Rhc3UwakY1UXVJZyswWTI5cC9xV3FU?=
 =?utf-8?B?S2tFaG4wVkxiU1BUVDI2MTB0RGlQSzhvWU5jV1p1UDVPUXVXMnBqaFJMc0ZP?=
 =?utf-8?B?aHd0emJHbW9leVk5eFZiWjQvZW1zWFBnQy83TW1Zcm01c2Z1VXpyTGVJaTkv?=
 =?utf-8?B?OTlXY0lIY2UyY05oam1GQ0p5YWhwbUZVZlRhSE1raWlnczg5eDVMSmRMYndt?=
 =?utf-8?B?VUdXWmhidU4xM3NncE9hRE1ZVDhZQityMXRQUHlJZ25GK3YwRWVLT1ZNeGdS?=
 =?utf-8?B?Z2ZrSmJJdUZTMFRDbkFlb3Vna1NMenRoMmYxUlhEclo3VkgrSFp6aEtrWEl3?=
 =?utf-8?B?VkRjWC82Tnp6K0M1a21pWkVVVnRUcWgwTVUxOUhPekNyamFFOG44U1ZCYTl1?=
 =?utf-8?B?d1dWTVFtWFZoU0gwMW1ITEx2Z2lUNkNrajJNY3l6dXU5SnR1RmFYcHJiQ1R1?=
 =?utf-8?B?Zk5iYmRPTUt3OUJWcndlbk1hS2d5YnhaTU0yd2UyU3FVSXBKWnBwcUtLd0pN?=
 =?utf-8?B?Q01mV2hLeU8zcmVnTjhwK0ZWdXZvRHp5cVZLMVdMQjNERU4zQjNwRm93WGVC?=
 =?utf-8?B?TGtvTHhSTVhDNURBS25hS1RwQVlXUkg0VFJDN3U3N1o5T25qNFNPRTRjakZQ?=
 =?utf-8?B?Z1V3Z2JINGNJaFJWdjN0eGZGSnVCR2MvVjRIVnRqQzJKVmVkUmlXYmFWRjVn?=
 =?utf-8?B?UVRGMWF6TVQzWHVOZzhPUUh3eExtSXI1Tm1WZ0tyc1FJS2JBbTkyNkJ0RHkr?=
 =?utf-8?B?OEZkZnlvTVlieENzeGlTVGFZWWlXWFhEWm9PaDFDVnEyclRtTGdob09ENlU0?=
 =?utf-8?B?UC9GWkVVQ1g1bFluT3JkWkRHUG13R3pOdTkyTFduNjVPNEk3ZTRuUT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 920c2def-31fc-45a7-83e8-08df12fe950b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:54:34.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TFVsJ6uSDNfC+lnmQkovQPEdQ45WE3q1TwGdWGQsdaVuVSzq8c84G2dQVrzxP0Lqoue7r0X4b9096BFIs3PUog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4996



On 9/11/2026 8:52 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
>> index b965ad571540..b1602c769f3d 100644
>> --- a/tools/lib/bpf/libbpf.h
>> +++ b/tools/lib/bpf/libbpf.h
>> @@ -224,10 +224,24 @@ struct bpf_object_open_opts {
>>  	 * point (/sys/fs/bpf), in case this default behavior is undesirable.
>>  	 */
>>  	const char *bpf_token_path;
>> +	/*
>> +	 * Optional allowlist of kernel module names whose BTFs libbpf is
>> +	 * allowed to load. The allowlist limits which kernel module BTFs libbpf
>> +	 * will consult wherever module BTF might be needed.
>> +	 *
>> +	 * When the option is not specified, the existing behavior remains
>> +	 * unchanged. An explicitly specified empty list prevents libbpf from
>> +	 * consulting any kernel module BTFs.
>                       ^^^
> How can a user specify an empty allowlist? The comment describes the behavior
> but not how to achieve it. Looking at the implementation in libbpf.c:8612:
> 
>     obj->btf_module_allowlist_cnt = mod_allow ? mod_allow_cnt : -1;
> 
> the code uses the pointer to distinguish states, not the count:
>   - btf_module_allowlist == NULL (regardless of _cnt) -> -1, allow all
>   - btf_module_allowlist != NULL, _cnt == 0 -> allow none
> 
> So a caller who writes
> 
>     LIBBPF_OPTS(bpf_object_open_opts, opts, .btf_module_allowlist_cnt = 0);
> 
> gets unrestricted module BTF loading (the legacy behavior), not the documented
> "consult no module BTFs". To actually reach the empty-list mode, the caller
> must pass a non-NULL pointer that is never dereferenced. The selftest
> (999379bdbd8f) does exactly that:
> 
>     static void btf_module_allowlist_empty(void)
>     {
>             const char *mod_list[] = { NULL };
> 
>             test_load_with_list(mod_list, 0, -ESRCH);
>     }
> 
> with a dummy array whose only element is never read, purely so the pointer is
> non-NULL.
> 
> Should the comment document this pointer-vs-count distinction and spell out
> the required "pass a non-NULL dummy pointer" idiom? Or would it be clearer to
> use an unambiguous encoding, like a separate flag for "restrict module BTFs"
> or documenting that _cnt == 0 with any pointer value means empty?
> 

The comment is intended to describe the semantics rather than the specific
way to construct an empty list. The selftest shows how to explicitly specify
an empty list, so I think the current documentation is sufficient.

>> +	 *
>> +	 * The list must contain valid, non-empty module names and must not
>> +	 * contain duplicate entries; otherwise -EINVAL is returned.
>> +	 */
>> +	const char **btf_module_allowlist;
>> +	int btf_module_allowlist_cnt;
>              ^^^
> Why use a signed int for the count field instead of size_t? Both existing
> precedents in this header for "const char ** array + count" use size_t:
> 
>     /* libbpf.h:617 */
>     struct bpf_kprobe_multi_opts {
>             size_t sz;
>             const char **syms;
>             size_t cnt;             /* number of elements in syms */
> 
>     /* libbpf.h:644 */
>     struct bpf_uprobe_multi_opts {
>             size_t sz;
>             const char **syms;
>             size_t cnt;
> 
> With int, the code has to validate a state that cannot exist with size_t:
> 
>     if ((!mod_allow && mod_allow_cnt > 0) || mod_allow_cnt < 0)
>             return ERR_PTR(-EINVAL);
> 
> and it overloads the count with a -1 sentinel, then compares it against the
> size_t sibling field btf_module_cnt:
> 
>     /* libbpf.c:5971 */
>     if (obj->btf_module_allowlist_cnt == obj->btf_module_cnt)
>             break;
> 
> That comparison is safe today (the -1 converts to SIZE_MAX which
> btf_module_cnt cannot reach), but it does mix signed and unsigned, and
> bpf_object__close() has to introduce a second signed loop variable int j
> alongside the existing size_t i purely to iterate this field.
> 
> Would size_t matching the neighbouring opts structs be clearer, or is the
> signed encoding serving a specific need here?
> 

Same as Andrii mentioned. I'll change the public API count to size_t and
use ssize_t internally, with -1 as the "not specified" marker.

>>
>>  	size_t :0;
>>  };
>> -#define bpf_object_open_opts__last_field bpf_token_path
>> +#define bpf_object_open_opts__last_field btf_module_allowlist_cnt
> 
> [ ... ]
> 
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index c036e8a91ed8..4ab7ddc3b4cc 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
>> @@ -5851,6 +5853,21 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>>  	return 0;
>>  }
>>
>> +static bool is_btf_mod_allowed(const struct bpf_object *obj, const char *name)
>> +{
>> +	int i;
>> +
>> +	if (obj->btf_module_allowlist_cnt < 0)
>> +		return true;
>> +
>> +	for (i = 0; i < obj->btf_module_allowlist_cnt; i++) {
>> +		if (strcmp(obj->btf_module_allowlist[i], name) == 0)
>> +			return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>>  static int load_module_btfs(struct bpf_object *obj)
>>  {
>>  	struct bpf_btf_info info;
>> @@ -5873,6 +5890,9 @@ static int load_module_btfs(struct bpf_object *obj)
>>  	if (!kernel_supports(obj, FEAT_MODULE_BTF))
>>  		return 0;
>>
>> +	if (obj->btf_module_allowlist_cnt == 0)
>> +		return 0;
>> +
>>  	while (true) {
>>  		err = bpf_btf_get_next_id(id, &id);
>>  		if (err && errno == ENOENT)
>> @@ -5915,6 +5935,11 @@ static int load_module_btfs(struct bpf_object *obj)
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
>> @@ -5939,6 +5964,9 @@ static int load_module_btfs(struct bpf_object *obj)
>>  			break;
>>  		}
>>  		obj->btf_module_cnt++;
>> +
>> +		if (obj->btf_module_allowlist_cnt == obj->btf_module_cnt)
>> +			break;
>                        ^^^
> Alan Maguire pointed out in v6 that after the loop exits, there is no check
> to verify all requested modules were actually found. If a user requests
> modules that don't exist on the system, the function silently succeeds even
> though obj->btf_module_cnt < obj->btf_module_allowlist_cnt.
> 
> Should the code verify that obj->btf_module_cnt matches the requested number
> when an allowlist is specified? That would help users detect when they've
> specified non-existent or misspelled module names.
> 

This is the intended semantics of an allowlist. A module in the list is
allowed to be loaded, but the list does not require all listed modules to
exist or be loaded.

>>  	}
>>
>>  	if (err) {
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34598086716

