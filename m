Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012006.outbound.protection.outlook.com [52.101.126.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F8C56E07C
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963238; cv=fail; b=oc5lVNA3hGyfx280RU0GBTK0M/L31O+rVvLVuDTFPXQEhKoNGsGLnJQ8hB4wxxgLtvg+hJTbN9p22JYL9Y/HiTnzzXBIg3wlUppJcVtYCNOvTkjunzQUUp2GUXR+0acpWPVOPlLuwhI1uOayYH2CSAxl6yjl1vqshu1HQciVjp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963238; c=relaxed/simple;
	bh=IQem79petb4VzdwWKMlwJ9s4ThtZFtWK1m4qHxI7uq0=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bplaRk7gRP8l4rqTQV2Itlgr4BMHrExnPQQTcKojvnUVBCTHUP3zCiqKDst5FP/zVwfutYR5NQF5Ib+GVV7yJddTUMtXJw7WLhkDGFnJEQsjAxtv8rIl4Erw1XRHIb+cEiIbL7G/EohexYb2Sz7UHjz5OV8vlUNOLcd8lE+FrXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ecBJSrqj; arc=fail smtp.client-ip=52.101.126.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ecBJSrqj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHx8YVYCS/ezoxHcsMQuGK0BXh5650DP+WIhtBJGrFWheExqn+3gjczvxamqB+fHYpgSv7d0qW/WU+2yjKjYbvPLcJ+M8I1z+tQJo8RMWr/tMwjZW9+yeTJmJqvjLEh8qBl5SCF8nt77LBfS+VnomRZJKE4jU24xPDUzbYQodVPtiYgF3iY2FHp8NX+17TCY8xHPscCDHsmdTZrU2I/t64n9qJO7wyl/DX8n7DQpKnkmL+O4hr6lUGO0Ey9x/K1ezDn26kW+vhJiZQ9uaqMz3vh353ZqZ+4ZrRUTw+5o+zOT7pnTJQARlVSq2iuvirYL0G7Ea7RStVjjxo6WIK9+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKG2UDgytkSKMcdTlZpKODTTYYkq5gGmOe5BSEemctY=;
 b=gdU/iKVAe7++qm1j/Kzn09QZWztAkrcyuv4tlVEyUGOt8c6IN/ERpiRRh8zWHh86Nlg2au9yHmexMuRPnLG1Pj4pk86+fk/mZHqXrnMsz8Vp7VoJiDunfvDvb4tTmehHqdi81Sgb/HzQCocqtdJyMjgZG8aqp9x0qvfIXBfj3UAIRa8d9x9H4z4h6rTpKZZTjKiP+ftZyHmh+AYzsFkbRuQO0a76PMSuVn3D0l4gPHhmPB4W1JpQ39YX31xiEZ1/aVzyp2iza4TkmvExhnUzBEQwUNtixkSzTdswPF8+zkOGwfK1gy48QyFiIOFq/daqpZi+FPdCK7CtuBFD1i39VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKG2UDgytkSKMcdTlZpKODTTYYkq5gGmOe5BSEemctY=;
 b=ecBJSrqjQYbJpXTIlgxXFFztCrazeSMQm9hA/V1YnSu2zUkABJfT5599DX6vn7idyku7lJcP+lFqp78451Nt46nxbRw3XctAtj9hSHTKgKq7mLhJrdyMhHlkcewxrYF+Pgtk2LSd4xkGrqlV5uYpbFStvDhG84MAebo0n/w6550/14Cuy0efO0M8v0sngk5pMO2oB3IxhE9CGvLh4uQXFNBm1TXjsC1poDTqpga5u178/AwFusStjZUJ/9rTqZDQ9coA4mp3qvw6C4qfbsT2r6vrTvAqr+PaPkVuShEsRpEmUxR+BnV5Zivy2u+v+K5x4TQq/QegdjIEpSPdaT0Phg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEZPR06MB7312.apcprd06.prod.outlook.com (2603:1096:101:250::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 9 Sep 2026
 14:13:53 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 14:13:53 +0000
Message-ID: <93965708-fad8-4273-9b82-092f1368b050@vivo.com>
Date: Wed, 9 Sep 2026 22:13:48 +0800
User-Agent: Mozilla Thunderbird
From: Fuyu Zhao <zhaofuyu@vivo.com>
Subject: Re: [PATCH bpf-next v7 2/2] selftests/bpf: add tests for selective
 module BTF loading
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: eddyz87@gmail.com, andrii.nakryiko@gmail.com, alan.maguire@oracle.com,
 ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, yonghong.song@linux.dev, mason@kernel.org,
 ihor.solodrai@linux.dev
References: <20260907053847.1115-3-zhaofuyu@vivo.com>
 <3b909016a8dcb99df0125202bbc3a564bb48c60067ea1476a22db43088c695e7@mail.kernel.org>
In-Reply-To: <3b909016a8dcb99df0125202bbc3a564bb48c60067ea1476a22db43088c695e7@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEZPR06MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 751c6aba-0178-4b75-9271-08df0e7c93e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|6133799003|18002099003|22082099003|4143699003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	1CT3SGYftAqQGwFWOAEXonYvOSPqrTG+6iWucIzwtL5ny9RZZ23ZTcUmOULDhZ/iwvZO4okkJekWpeMW6eIkoZZYZeJ6ARY2QPgU3MK0mjRSynwO64egHAtpx4HacEocR+LA2TZ96HIPpUZjsuGUQNz2PkBSH8g3qbSloInjuHbdnHTkZHSzXruAqUfL4lcXRsDuCM8RCRNCn7JqgBD0M7Aq3sZn0+jWA0s5JnQkCttohBQGOrrfvews8gdEDyMzI+IDIAT7yS55nV4owjesS0wONRZ2Jm5yBwh6MTvKYtjqMrIv9n3EGX1oO8nvWsb73mn5+q4UPAEghH80JFaay2R49FHJG0QYSZKvYa3jUdFQ1ebbvw3rR0B8tKo32gk+pyppGw/VGe6VRTDtUCqCehBWOs1mUWZ3f+EiD3GPqHdJUmaamCPKpYRKU9o6i3OWkRoyPy+3LklhMuVFmJSgfKiGayiYtETKcke850E0Tb9WaQVE0xTz0jBsOQbLLZhzZh0qVy+6udJ329VeGoQ0TSNpIihkmZlMflu7yYbC5LGj/cIczrDs8TdjBb8KhwBH3ztNEpdx7/GuRV98JpkSDtEHoqDzur7OvwyRzXUg6QsvkWm6fKXqqn7OSzKdK8PZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(6133799003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUZCUzFYbVA4NU5pTmtmRmtpNTBXR0YzUjJGK3duTGgvUjI5SDVnMGhrYnRx?=
 =?utf-8?B?S3cwQThvS0dXWHVKSHlINEd2SEpVdkw3SHpPbElXTlRTc255anRJTmFUSmJo?=
 =?utf-8?B?Ry8xN1ZHNk5CdzNaWG5HVGtleGFqWEVTZ2ozc1E5NVBaVElQOUIwK1ZVYmxq?=
 =?utf-8?B?a3MwYTFjcmc2T0NCaUM5TWFDN0hvYnNBQ2g2UmlQQzBBcGoxSnBCcGVmV1c0?=
 =?utf-8?B?WllUcjdPdFNOWVk0WWxPVmNNS0ZCMmdsQ0dVK3dXVU1zbHF5a2pudlpKdmYx?=
 =?utf-8?B?RTlHY2lmaUhiM05lRDR3T3ltNUJzSjdjOGNNWHRlOUl1MUp4MmQxbnhaNisr?=
 =?utf-8?B?UUNtZ2pOUENGQWpUd0tUL1UyaHo0WGNFbm9aZ3NWb2t3NFJ4d2xlRkVIVUU4?=
 =?utf-8?B?UUk5UlJYaG42L3p3emJPckxNVHNJeC9zUW5ncDZ6MDU4UE1pRm9ESXVjZ3Nq?=
 =?utf-8?B?SjNNbjlVaFUyL2ZIbm0wQnc3L2R6WmR6blMyZjIreGJuZldaV2IzdXBFNVpk?=
 =?utf-8?B?NmJkbVpzclNKR3REd2VOMEVBN0Q5YXNhc1N0YWovZTNNUkJ1Q0VmQ0JaSEUz?=
 =?utf-8?B?STkzM0lraVgyOVBHV1U3YjV3OWcyV2diQUhiQTJISWxDY1Z0VFh4Y1lNTnU4?=
 =?utf-8?B?WVpIU1N0NmVWeEYxcEk0azFtQW5xMXFxenljeU10anNNYm9SOTRFK1I1V1hu?=
 =?utf-8?B?a3dUaHZBSmRtWkhzei9lU1E2TWlmWFA5SHIyUStoQnNwcThjblZvL29ra2ZW?=
 =?utf-8?B?QVl4WTBWMURkU3QrV0RwTTBKTmhoa25kZ1lBS3hhVjFqc1l4SGw0a29lbGFm?=
 =?utf-8?B?d0xYMWcwV0JRckppOUVORUYrOU9kZm5vdkpOOXlRMlRHUmxPNzFqeTU2S2VB?=
 =?utf-8?B?MHdQS2VwWGl5R3pFbDU2elFXNGRGcmYrR2JxZUZ5NmNSeVRaTTVEcUxiaDJX?=
 =?utf-8?B?VzA0Y2tldnd1bE5qVGVVcEpVVzRudTRQWHNmUG50UzNQcDI2a3lxK3d6RzJI?=
 =?utf-8?B?U1pHMjRMaFZmNENsbkg3dEVjWGN4UzVUM1JJa25haWptRnl4Qk4vODdjc2pk?=
 =?utf-8?B?M1l4VVdrcXhoVTRTcVozT1lYV05IaEQxcFpXbDZhSElYQ2xiM0pPNTZMV0Vw?=
 =?utf-8?B?QnlIQmRlN2NQTDVNQmEzSG8vRUNkWHROKzdPTzJ1dFljd0U3bENzWFVNNUR5?=
 =?utf-8?B?NmV0Y0IvWXhnclhWUlV3dTJwZ1ZJZzRGbUVua2FTUE4rN3BWTTlrWFlNbytW?=
 =?utf-8?B?U0c5U3d3MWtZbGQvSG8zdTlIbnI3MDhsUnlndXFOZ25nU3RsMW1DUmh1SlJY?=
 =?utf-8?B?NWxXNG90TGhYZXJxYy82aWJVMFZCQ25hdk9SQjY4dUxWT1dTQXUzVUI4OTQ0?=
 =?utf-8?B?RnFjMWJXUHpVejR3UjFKMXlyMlQrRVB5NGZhd2VlTGRZQndKTnZBS2JrODFT?=
 =?utf-8?B?WW1qbGU3ZHNsejZZVTVxcTJodkNUbmFxeEo2ZTE1QXNRc0ErWDQ3S2FvNmJP?=
 =?utf-8?B?MEpKK1oyY3FrYitPQUI3cUFlQms1bXBSUTM3Nk1UbFIrcEZRdmoxWFUraEpt?=
 =?utf-8?B?Vll0NEZGNVh5dGFSTzRTUDZKYklHVXpITFFGcktyM0l0VCtoMVNrVVM0dVc2?=
 =?utf-8?B?L2VJekZxS1RFblRHUlVkUkg1cytPTzhaRTBDR2ZDSlBxeW9aN3paam1lV3hl?=
 =?utf-8?B?Nmc5VlpGMGlJTy9BUndBZ0pndjNYRStSOGdSOWpEamhqUlJReGJud09HL05u?=
 =?utf-8?B?ZmRFa1NZckZpcmpEWTRSVUgxeXNRVjBJWGk0RmU4UDNvS0RzeWFtMU1XV0hX?=
 =?utf-8?B?MXFkSDhSSDJQa0RWNlVJa3h1a0lrajFqNzErYnZubWJyMjdHZnlyNVU5RmxY?=
 =?utf-8?B?Rzg2Q2FvaEExaDVtb1cwbmlZTlpTQlZGelVVa3F1VXdSTE8vbS9wdUFNVEha?=
 =?utf-8?B?dkN4TVIwT3lLWktLdCt3UGd4a0ZWMU80S0VqZEIreW4xRytaVXB1SlB6aEl3?=
 =?utf-8?B?K2NxMmphTWJLdE1sNjZEbHhQa21tbVFsRytiN3gwZ3RqejU4dzAxOWYyQ3k3?=
 =?utf-8?B?ZWZQcmtMTzdjZjdGZk5hUEZmY2pQYURTZHhNMVYyWnI1c01keWNWSEtUVTNZ?=
 =?utf-8?B?R3AwYWhsTzQ2a2lJMHFlM25ENUlwbWhQWGovWlZBUzdqbVV2cUcwQno3WjMr?=
 =?utf-8?B?ZzNPN0krdGpFK1NzR2dUM3gyWnlBd3pnTjJqdWMxb1l4KzVQTDRoQXJNYTVn?=
 =?utf-8?B?OHUwa1BLT3FSVjBLY3JYZnlBdGhkWWlwV3BVU2lvdHdGNEYyYTlGL2ZKVGFh?=
 =?utf-8?B?cTQ5Z0ozVXNMb1FmOU5PdHJ6dFJRVlR0Vk1pWXZKQVFoMG5oajRGdz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 751c6aba-0178-4b75-9271-08df0e7c93e9
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 14:13:53.1607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t01r+gINqVNYNtlqM7BEBLCQ97yR/XbccZmDm7qJVD43HhBXgX8Sb9e9qHXEjPxuuRRiDlXbT7Um24TaH6q1Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7312



On 9/9/2026 12:03 AM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
>> new file mode 100644
>> index 000000000000..fb1b9ffb6c7a
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf_module_allowlist.c
>> @@ -0,0 +1,155 @@
> 
> [ ... ]
> 
>> +static void btf_module_allowlist_default(void)
>> +{
>> +	struct btf_module_allowlist *skel;
>> +	int ret;
>> +	LIBBPF_OPTS(bpf_object_open_opts, opts);
>> +
>> +	skel = btf_module_allowlist__open();
>> +	if (!ASSERT_OK_PTR(skel, "btf_module_allowlist__open"))
>> +		return;
>> +
>> +	ret = btf_module_allowlist__load(skel);
>> +	ASSERT_OK(ret, "btf_module_allowlist__load");
>> +
>> +	btf_module_allowlist__destroy(skel);
>> +	skel = NULL;
>> +
>> +	skel = btf_module_allowlist__open_opts(&opts);
>> +	if (!ASSERT_OK_PTR(skel, "btf_module_allowlist__open_opts"))
>> +		return;
>> +
>> +	ret = btf_module_allowlist__load(skel);
>> +	ASSERT_OK(ret, "btf_module_allowlist__load opts");
>> +
>> +	btf_module_allowlist__destroy(skel);
>> +}
> 
> Jiri Olsa noted in v7 that the second btf_module_allowlist__open_opts(&opts)
> call appears redundant. This test section duplicates the same test logic
> already covered in the first part of the function. Could this second test
> be removed to simplify the test?
> 

Agreed, the second case is redundant, so I'll remove it.

> [ ... ]
> 
>> +void test_btf_module_allowlist(void)
>> +{
>> +	struct btf *vmlinux_btf = NULL;
>> +	struct btf *module_btf = NULL;
>> +
>> +	if (!env.has_testmod) {
>> +		printf("%s:SKIP: bpf_testmod is not available\n", __func__);
>> +		test__skip();
>> +		return;
>> +	}
>> +
>> +	vmlinux_btf = btf__load_vmlinux_btf();
>> +	if (libbpf_get_error(vmlinux_btf)) {
>> +		printf("%s:SKIP: vmlinux_btf is not available\n", __func__);
>> +		test__skip();
>> +		return;
>> +	}
>> +
>> +	/* Ensure bpf_testmod BTF is available. */
>> +	module_btf = btf__load_module_btf("bpf_testmod", vmlinux_btf);
>> +	if (libbpf_get_error(module_btf)) {
>> +		printf("%s:SKIP: bpf_testmod's BTF is not available\n", __func__);
>> +		btf__free(vmlinux_btf);
>> +		test__skip();
>> +		return;
>> +	}
> 
> Andrii Nakryiko requested in v6 not to use libbpf_get_error() as it is
> legacy and discouraged. He suggested checking for NULL and then looking at
> errno instead. The code still uses libbpf_get_error() here and again below
> for the module_btf check. Could these be updated to follow the recommended
> pattern?
> 

Sorry, this was my oversight. I updated some of the libbpf_get_error()
checks but overlooked these remaining ones. I'll fix them as suggested.

>> +
>> +	btf__free(module_btf);
>> +	btf__free(vmlinux_btf);
>> +
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
> Jiri Olsa also suggested in v7 adding a test that verifies the module's BTF
> did not get loaded because of the allowlist setup. He recommended using
> something like bpf_program__set_attach_target(prog, 0,
> "bpf_testmod:bpf_fentry_test1") which would fail, or some other way that
> uses obj->btf_modules. This would improve test coverage by directly verifying
> that module BTF filtering works at the BTF loading level, not just at the
> program loading level. Would it be worth adding such a test?
> 

Sure, I'll add a test for this.

Thanks,
Fuyu

>> diff --git a/tools/testing/selftests/bpf/progs/btf_module_allowlist.c b/tools/testing/selftests/bpf/progs/btf_module_allowlist.c
>> new file mode 100644
>> index 000000000000..bb3c38bee77d
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/btf_module_allowlist.c
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34245661129

