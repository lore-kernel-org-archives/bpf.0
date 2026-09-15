Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012007.outbound.protection.outlook.com [40.107.75.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CE0380FD5
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789457104; cv=fail; b=CItWpqmmQ1/4FEGVP8a/d1unaaOb1Z1LDoiG2p+EVRZZKRP5LQfpYbAhN0wVtnzs+8c1t3uYyimmUWPuogKs3pGPqKGxTOBZmwQ3CmjCoBL+bWmGluLh0mrXJAfWdW/5mks64HxPCT2UgKoHyGBxy9uM/UdC0LvHgLbdQoyfnR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789457104; c=relaxed/simple;
	bh=xKEFVKPTwMVdbh5NINKXBVBQUX0pO22s9Ru763Wt5Qo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pwkHh20Tft1PqQt0nh+LJ+qJrnlPV0/rnQS8V5xu9HRmDJqEKZdTBuabqHiqAwQLqkfMlX5jCsp0o5x4tSXI2Z5CUgfhT0KBBF7erPOjiZXP9uxCFSn/q8tyOW/acP3bg+m+bzOO1U0iKuVf4/ihb1NEBpX/KcFzvdTyuavX3Rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=JKZ4aVjK; arc=fail smtp.client-ip=40.107.75.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="JKZ4aVjK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txvYYPqbeweTGKDl8c4QvrKFL46CI8J5icuEmzdrwO3qJEiYkZkX8PtTaulCDfPbL3ARyh/fYJy7joKjlx90zVgUSP/2Jxwp1X5al08RNaxulLKEjWIICD9GYb89JGuffDuHCK/SBYKtJovVEO/Uyp9uXR+nhAH9xYVXEa7RGNV+nbbsEIGQuwvuhKHQd38lsCKZJtK7l0rlfKTQf82iRTtAtpUvaOfHgy7CG1wIX6qn0CF3edrKsCBmKcekH1/pKHhvFHAQofGjcmejU19bBY3FWZcLTafsGfIyQx2xq2F1exfpMsm9ZivaYxcS/0+ULI1YcfeMwAfOHzSj2zUKTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RySJHVmcEHH30p20pkexUiJ+oLXb7210L1WORPpTCFw=;
 b=iolrm7Fj7TCVWQKQtAsmwKmhgndhLB/lu9e/WQ4zdulaZkhys8QhmUR37xWA3CNQaFjkjyoJMAlAuBJL7YUOM51+CB1cAG3CIA5hvnxVJJa6IDiDVWXmPlMkUSQFyu4j5jjjqzK9+Jzr+6r+ixneGGk+4ED3m2MukCBI3WsCTrOrBPaRvIAmsgl5kbrnYmr/csrmsHbm6JxFdNoD0PySHp0uBXUnEWhz29QKNMXNugUidL86XxEMI9tf7gLUS5mhqQ6KNZej5vVS2MMDSQHAg+dcTOBtVuv74Lcs3q1YNnomwl3aQAJx45edDH9YgCARwi85l+vCuP7FC7a3MGGxtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RySJHVmcEHH30p20pkexUiJ+oLXb7210L1WORPpTCFw=;
 b=JKZ4aVjKOcrKIOCleQcaqgUunwD8JMXvII+WtzDIfdxUMf2wb+fKZdpB5ltdVEOh97rSc74fy3l1b/TjqQnCDIxAv1NPZT9CRxev3eE9mN2fCUcEQ5ZZO+JmxfM42MT8ZTMdNTlPHT6exgsxi0oH1MNB58FNW9+wUgk+GVWqp95+VjOT0nORBxsnxvZ/zwb9hfUnY9zSeU/caIfoovTkOzLewU5DIrtPxpNXuPBbemT2hUlCecwNtQQqvx4Vz6nYUvuXc8DeASxbblKnNBeTXYbwt8aJpZJOPs6mpaQPYrPH0hxDLf5n8i/EJ+cohFx+Wdla+xvxtz8eYrMdtDg+bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by SEZPR06MB5522.apcprd06.prod.outlook.com (2603:1096:101:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Tue, 15 Sep
 2026 07:24:56 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%3]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 07:24:56 +0000
Message-ID: <2255129b-8d3e-4d9a-bc0a-a911f0fbed53@vivo.com>
Date: Tue, 15 Sep 2026 15:24:50 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 1/2] libbpf: support selective kernel module
 BTF loading via bpf_object_open_opts
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, eddyz87@gmail.com, alan.maguire@oracle.com,
 olsajiri@gmail.com, Andrii Nakryiko <andrii@kernel.org>
References: <20260911120820.46900-1-zhaofuyu@vivo.com>
 <20260911120820.46900-2-zhaofuyu@vivo.com>
 <CAEf4BzYkY3ehPGei5Ra2xUJZHu-JcKLfPOuKeo3Ckks8w=OrEQ@mail.gmail.com>
 <0eb56403-6782-4126-b660-c5504ec35232@vivo.com>
 <CAEf4BzY=nuvYTytWXCBXZAR+nDdzynhDdj4cmRO+v+0jazLWmw@mail.gmail.com>
From: Fuyu Zhao <zhaofuyu@vivo.com>
In-Reply-To: <CAEf4BzY=nuvYTytWXCBXZAR+nDdzynhDdj4cmRO+v+0jazLWmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TP0P295CA0011.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::17) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|SEZPR06MB5522:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d704557-9725-4917-d003-08df12fa70a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|4143699003|3023799007|4133799003|10067099003|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LMdQ5JajxBroA3okU4gf7zaQFVHB9sl1BMUNYKoF8dpgsshNvQize1n40sddcdbmJUzJULKoJFSptl5hk2NnR2axNbu1FO/SZA2t45S58yd7vn+lFbrVwtQYi0PZfYAJ60BHX02FkvRhuxfYO1hiyEUghiHQ+uWv5rvD+1c47SurhEIMoK2f2Z6MEi61i2TjGVlXhr1zNYctakeX719OfchtxcdYP06WrkX/GCSxqYtCqV35BRoGPnDXUgMTqqM258uAl05N37zoiodlvy0MZzuv7XqOElKkBMJY9L9PDIQnSWT3Jv3Bw9gitdbe8cC4u+0V8MLKtU2xo9Yn1iWTMmdZ0fYO9xPFGdkJ+xpJ9rZWC2HQWTNJAYjO+NObYpVLGgPsloY75f351+qQyLLXpfnh6fzVXUR9udvpkI49MKzB698Sg3xCKa8R7OFX+6VCDOLzGevGCwZazMTkIsU8Qh/matnWSbMokG9GBrka+KzJFaTWvDPJ1c+6qy1YyzVL60758W3LSE64YvdazWRjoPTyL+GSeSetjx6tHkTE2Nk8S4JxEC5ZVlLeG+Jm7zN29TI9FB3AppEeOTmKiXyK9/18utlmkYame7Nv8bFKC26QJ/mdRQ8/aQEkVQ1HMlBx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(4143699003)(3023799007)(4133799003)(10067099003)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEFHdWYyUjF5QTc3RmJDMjZjT1JHeXM0SjVlZ0RIK1hOb3V4ZjZVWmRSNExJ?=
 =?utf-8?B?SE90TGZkSUhQVXkreU5EZTBzZVFsQldTaTE0ektoVDBpcnJKMnBKUHcwWFYr?=
 =?utf-8?B?UmdvSjBQc1k2Nkl5UWJhUEVRTE1FZzZTT0dpRVBYb2hINmFwT0p5ZGsrckR1?=
 =?utf-8?B?S0tZbzlFbnhreXRha0NpNFh6QVBNSDRBWU84L3ZBTmM3bFE3TWJvenNNWUV6?=
 =?utf-8?B?b0FPTnBFSWR5ODMvTXoycUFFU2ozZXU4UzRPQ2h6Zm5janJPeFNQY2pCRGx2?=
 =?utf-8?B?ZnVPMEFQYVQ3V2xKSmRYNXpGdkRzZU82SFdUS2IyMUQ1S25hWkt1cnlsYUkz?=
 =?utf-8?B?Uk1BSTJIMXV6Y3FCSmJsbHp0ZUFRMTMrZG16RHF2eHRSUVFGTStWQmZjSkxk?=
 =?utf-8?B?Q3FEc3p0SURuVzZXNEdWOEF6QjRrL2NvNG90OXNNdkpvMHNTc3paM2tudC9x?=
 =?utf-8?B?a2x5N3JUTHlhemJSa0w5VnVUMUpMK1I2RU80NDI3Y3lJS3g4V2UrUGxNeXBt?=
 =?utf-8?B?WnNsT2x2M0M1ZHd0V0c3UUdOT0tXZkNBSzZtUFpCWU50aEhGREQ0S2FWWk5v?=
 =?utf-8?B?ckRSTWtNbzBWVDgvQ3M0cFgwQnAxNHVNZHViWGRXSzdUSkdVY0JUbzQwM0s1?=
 =?utf-8?B?b1BCK1h0bUJhOXRyZks4YTZBV0dHaVkzNXkvUS9OY2hlWTRRSW9wc1RkNVJt?=
 =?utf-8?B?cFY4MnowYTFJKzBGWmVrV0FmZWZ4K2QxdzNWQ3JoZUx5RGN3ck1IekxYcVMr?=
 =?utf-8?B?MmJXMnFvUFlPRi9pMjVZdjh2a3Y0ZnRPS0c5OFJSVlkxUjk5Yk9LSXJpNWpP?=
 =?utf-8?B?bEhqeEwxQ24vZ2ZMR2Fla1lIQjdQb1VuQXFKNFE1dWtxc2tyNExhNDIwMVFt?=
 =?utf-8?B?Tm5LdjN5bTA5NEJScDhycXNCU3NVdHN6QjdxSFRlMmxmVWI5NU9HZnQ2aFR5?=
 =?utf-8?B?czNWT3FicjZvNlREQWZ3UGcycHpUd0hjVUExeCtqYkhRTi9Bb3NXcDk4ZzFt?=
 =?utf-8?B?ekRncFZTYTJ1aFBzWEtVVWg3QVJFb2dlLzU0L0tpaHBWNUxrVDRuaWhROHlo?=
 =?utf-8?B?OGF3RWZtSVFHL0FHTUlGWkxmRzlqVTNrVjRON0RqM0Z4aDBnMDVtTkxaeVV4?=
 =?utf-8?B?VWlXZ3RxM2VoM3IzZDNXZGorWnZ1eFd6RUZzbW90RE5JK2RKZjN5djNQMXdz?=
 =?utf-8?B?UElUQzhFTmUvbVJEaVAxNkhYNXFZaWhmVS92V0NVQ1JVNXFWUUdiNUx6MGsr?=
 =?utf-8?B?cURreVlBUzFZdHpCRlFCYWZSMXppNDlkNzZKZ2FHMXA1aXBWcmdZN1hIcVhh?=
 =?utf-8?B?M2ZqTWFxa1B0TmdhWDA4OTdYU3hCdFdHanlId1dQYS9uNGF0ZjYrYUlYbW1w?=
 =?utf-8?B?S1FYLzVubXVKNmd0RHZuTVlKZHVVMWpSZ2p1OU9MK2I4aytaMWRrSmpMcW5k?=
 =?utf-8?B?SWVvRUdzYnJMVGpVNDJxTFJPeXVudFkyOFdUTWJwNTh0cGdkSEFmRDAxV2dt?=
 =?utf-8?B?TFdJMlh0ZjRIQVJ5Z0xmSkUxSTYrS3ZLaTBpQlYyWjdEU1Nva01JVWQydmFq?=
 =?utf-8?B?VUJhbEZIV0FYUWxURy9VTE5HQUlnWXdpTVlGaC9nMTdZbUtmckErMXRoRUZa?=
 =?utf-8?B?aDJWNTRoWlBmVndKd2R6N3BGMUxIc2ppYXZpQ1lSa1RrdzRCaTdTSk5Dald4?=
 =?utf-8?B?UHhiT2ljWHhMT051U2poN2tJOWIxaTZZRjNzdDZ3aklsdWlhREhFUVkyc1px?=
 =?utf-8?B?a29EcVBsa1lCTklXU0IzcHNLNFN4eGF0Vy9FVGZac0QrandqREpmZ0Z6bG40?=
 =?utf-8?B?d3BCQUFiQ0dEN2l5clBLMU01NjNtNFBqRHgvWWpZdmVjc3dqamlMVlp0TkRX?=
 =?utf-8?B?M2pyMHpaYUR1LzBONFN3Zm8zK0k2RXFOejBodzhDdkV1bGFvMWVxam5ic1pr?=
 =?utf-8?B?RTlUNVlQZGY1a1JiWGRtNGVsZFdoL2diRW9CQkpEMFVacDNIUEJFUDlNNFpo?=
 =?utf-8?B?Q2J2cnA4dG1pKzBaSEhzcmZlV3hLdHVLdy9Pc2dLeGw3YXZsazJPMUJZSVhL?=
 =?utf-8?B?SGx1b2lnTy9DZ2NpZWM2Rk4vOWN4VEU3NkNtUXJUUG8yTjlZOEVJd2RqdDZW?=
 =?utf-8?B?L1dIMWdSN3AvdmY2QUdhODMyZEo1d3JodmdvNVgyNTJOT0RmNjNBekNGMlZo?=
 =?utf-8?B?ZjFycmNBVW5mQkx4djFRWlg2Yk5HYnFDRCtVY2xQTFJpQnNIZjBldk5NM3BT?=
 =?utf-8?B?dmlseXlLN1BYa0xpQ0V0eGRzekFGamJIWXpCcmlwaG8vWTE1cmlBQnQwcWha?=
 =?utf-8?B?ZDQvTTFKZHZXdnRJUGNGdkl6bWIxNlVKNW1GZnFLTW5WUm9oaWVodz09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d704557-9725-4917-d003-08df12fa70a5
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:24:56.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvjQLCRySA/vR5DNx//ip7DqjRa7/0j0r6SVBptqpaLAqp5CWzF2Pmu8+88yTVEYnC3ZvES+KsgY7J7vftC5Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5522



On 9/14/2026 11:54 PM, Andrii Nakryiko wrote:
> On Sun, Sep 13, 2026 at 9:22 PM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
>>
>>
>>
>> On 9/12/2026 3:18 AM, Andrii Nakryiko wrote:
>>> On Fri, Sep 11, 2026 at 5:08 AM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
>>>>
>>>> Add btf_module_allowlist and btf_module_allowlist_cnt fields to
>>>> bpf_object_open_opts to limit which kernel module BTFs libbpf is
>>>> allowed to load.
>>>>
>>>> When the option is not specified, the existing behavior remains
>>>> unchanged. An explicitly specified empty allowlist prevents libbpf from
>>>> consulting any kernel module BTFs.
>>>>
>>>> The allowlist limits which kernel module BTFs libbpf will consult
>>>> wherever module BTF might be needed.
>>>>
>>>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>>>> Signed-off-by: Fuyu Zhao <zhaofuyu@vivo.com>
>>>> ---
>>>>  tools/lib/bpf/libbpf.c | 72 +++++++++++++++++++++++++++++++++++++++++-
>>>>  tools/lib/bpf/libbpf.h | 16 +++++++++-
>>>>  2 files changed, 86 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index c036e8a91ed8..4ab7ddc3b4cc 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -751,6 +751,8 @@ struct bpf_object {
>>>>         bool btf_modules_loaded;
>>>>         size_t btf_module_cnt;
>>>>         size_t btf_module_cap;
>>>> +       char **btf_module_allowlist;
>>>> +       int btf_module_allowlist_cnt;
>>>
>>> please use size_T for this count, just like other counts (both
>>> internally in bpf_object and in public UAPI opts struct)
>>>
>>>
>>> other than that, looks good, I was about to apply before that `int j`
>>> in bpf_object__close() caught my attention
>>>
>>> pw-bot: cr
>>>
>>
>> Hi Andrii,
>>
>> I also felt that using `int` for `btf_module_allowlist_cnt` looked a bit
>> out of place. But it does allow us to cleanly represent the three
>> states -1, 0, and >0 for no list, an empty list, and a specified list,
>> respectively, as we discussed previously [1]. An additional benefit is
>> that all subsequent checks can rely only on `btf_module_allowlist_cnt`,
>> which keeps the code more consistent.
>>
>> With `size_t`, maybe we could use `SIZE_MAX` to represent the no-list
>> case. But I'm not sure if that's preferable, as the count would then
>> carry both the list size and the state of whether the option was
>> specified. Or is there a better way?
> 
> use size_t in UAPI (in opts struct), check that the value is no larger
> than SIZE_MAX (-EINVAL otherwise), then just use ssize_t internally
> and preserve -1 as marker of "no list"?
> 

That makes more sense. I assume the check should be
`mod_allow_cnt > SSIZE_MAX`, since the maximum value of `mod_allow_cnt`
is already `SIZE_MAX`, and it will later be stored in
`obj->btf_module_allowlist_cnt`, which is a `ssize_t`. I'll update this.

Thanks,
Fuyu

>>
>> [1] https://lore.kernel.org/bpf/CAEf4BzaHTTEob-vmhmcRt1pmED+eBBLWnehEDUk=t7O7GUyyFg@mail.gmail.com/
>>
>> Thanks,
>> Fuyu
>>
>>>>
>>>>         /* optional log settings passed to BPF_BTF_LOAD and BPF_PROG_LOAD commands */
>>>>         char *log_buf;
>>>
>>> [...]
>>>
>>>>         err = bpf_object__elf_init(obj);
>>>>         err = err ? : bpf_object__elf_collect(obj);
>>>>         err = err ? : bpf_object__collect_externs(obj);
>>>> @@ -9626,6 +9691,7 @@ static void bpf_map__destroy(struct bpf_map *map)
>>>>  void bpf_object__close(struct bpf_object *obj)
>>>>  {
>>>>         size_t i;
>>>> +       int j;
>>>
>>> you don't need j with count defined as size_t
>>>
>>>>
>>>>         if (IS_ERR_OR_NULL(obj))
>>>>                 return;
>>>
>>> [...]
>>

