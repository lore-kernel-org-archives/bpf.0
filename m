Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012039.outbound.protection.outlook.com [40.107.75.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A341513D51E
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 03:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786419720; cv=fail; b=TQkUwSn0xN2hdH/YJ0M/Ezs75cOSN5M2nKoYweXJ0gtj/HtXNKhrCW38fXyq7BdR/2uS8YiUjziU7nqUpDxBm1boFmnpk49ReTcuuXTCg+iV3QELaawM7Y57a8bNblWZsync6EYUXkrxzt4L8VH9b7lwrvYh9JpGS5pFMbKPGFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786419720; c=relaxed/simple;
	bh=YMxRf1yn1hkVyMTCikYSp9L5AnCObG8rPJJG/Zd0M5s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Crv2W6VwTdt8fCqbD9uVDcF45Z3lAc/iPJsXleeUWoaZmVat2fbNUl6tUyaWvjHPaZU/1dkvfPu25TsVLnKdcACzRMB9562D47VAIo9Y4mQDtTVoGrickLDLjSgPZTXcAp/czcr9UPbM8Vw4QlpbNuc6VXU9+n1Vv3v+8/+2PiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=iU1YKocI; arc=fail smtp.client-ip=40.107.75.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="iU1YKocI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v+RPp0fzbpoikWmxicYMj4t0YUvsX0QquwWp0SucMWaNTBKRhLBq34CQQSun2lKepLS/GU5uXiKmcIQbSpig3LuWiDLmfDP9yGx7Bu1v1qAUl5AKmlq3sgVdLSYr1gN9YtH4movAgu7WIBoOty0pH9tT1vLGXOi+j5UnUUvwT7vkQLDPfjwfFxyJ84+yVVN96s2uN9kcsetAAKw8wSID2LGT+MimsHvN2pHr93ftkzW2Y/aFNw888dhnP0lGpbiem5DAKxyjchmIS1vL90qhKdosFah8a/E6o8pMdRuDhTyDRm12QM4u5oDCnwKOsqoWujPuAti4Phvi3pcSUQJK/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eWDCKuVTu2EpnLLGBkaBzE+51Q8G9Pexer/UwPCu5dM=;
 b=dc5TWXioRvfbuD8sGciNsxw0l2VXHQ3OiuN/iyjf48D9Czh+ftBiMvjZZY8+ZMnI/5guyCy1edAGo5AWdWRW93in+jgEpUwGB/8BxhnUBlUSw97br+M4gX0jFeuqtSR3SFC6r7YHwluQcmmM3XMRXWvsiZVR3DfYLiJ8LTEObTBBy0qBheIZomesNqtVKGG5KZMXf99pzqmX4oKOPSLJxM5XEAkLrNvE1lKvvqodyIwDaZh01fOebd+MgvIhZlKn3464vO1TioJKaxPD8q8bzgi2ER/BN9MPEz0tu2bK88CCEG5b1F4Fussz/hbahok5n4XER0u34HUcBEGKuihfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eWDCKuVTu2EpnLLGBkaBzE+51Q8G9Pexer/UwPCu5dM=;
 b=iU1YKocIQ52w3qW4hBmxYak29H1eMPPptcKMC1/hn871HWK6PSlRTaMnShhcIxH9/2j6rNNBQV2eZvS+awGw84ge8zQicioYTgrrGoK1B7vBQEhBxazM3D5YE4GZ8uM7KMD2x2PmPdDGr8Kob3VBj4KAGpNjmQiLO/sG9eu+KkuaVNvQ7AL0tXZVrVm4JP3oEtb2DSaq9dNJRn9bYMDzETwLT1A5PY5W/GfvKqqCoKxmbCM6inRtyS0G6ysauZwT/LMf16qE0Q4bisXQjR8pRjGqn0tcT61WpHi96mixOPldFFdhrvmtdj8uYLhMAWQ8lOPi/BGUzVrGunpzW82Meg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com (2603:1096:301:b5::13)
 by OSNPR06MB9100.apcprd06.prod.outlook.com (2603:1096:604:47f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 03:41:53 +0000
Received: from PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571]) by PUZPR06MB4742.apcprd06.prod.outlook.com
 ([fe80::206c:c661:9838:5571%6]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 03:41:53 +0000
Message-ID: <9ad53975-c513-45f9-aca4-1c9a722b8685@vivo.com>
Date: Tue, 11 Aug 2026 11:41:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH bpf-next 0/2] libbpf: Improve BPF load performance by
 selectively loading kmod BTFs
To: Alan Maguire <alan.maguire@oracle.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org
References: <20260806042042.3239428-1-zhaofuyu@vivo.com>
 <CAEf4BzZbsH2kyq9wb=eCNEOioWJnO2jSwsvbL3uWeyL51OnzVw@mail.gmail.com>
 <40e6c11b-5868-4463-9067-374c96775553@vivo.com>
 <6f1d8104-c79c-431a-b04a-5b93b9628c40@oracle.com>
From: Fuyu Zhao <zhaofuyu@vivo.com>
In-Reply-To: <6f1d8104-c79c-431a-b04a-5b93b9628c40@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::14) To PUZPR06MB4742.apcprd06.prod.outlook.com
 (2603:1096:301:b5::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB4742:EE_|OSNPR06MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 9340a90c-d277-41e7-e034-08def75a7b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|6133799003|4143699003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	p0BhAFGYZz9+uQU601IB71TgxN5ndYpz9KpXJH9XkCqI337l2Eeahat4HuMRxQgekm37vpRTeHltxmB3cZF74ntCxsRVpzgxJGV0+Bd3OFL5JL8ZRPfY86qSfRl3QT0I8Dghmf0qsCxZTTyw2WjJNEyoZkPMhkyHBbeeWDk/Z/EYnP6EoZKu5s6Akph3LYyUXhmKMnS/uazA2BOeIGtTYRFMwzqcgj8XxgzEhtNqWI2Xy7UwfFyT76XB5kkMuEd7CGAkKRuHoTmu4AODbbYS2RIxz9HAuneCyIHwVyQjBnSQm6WQ3bgBumUvESjD9q0v97N83eFaJRqaMMVwDs5w6JubwvJH7GzLl6gTJOIK7Z/r69QF8TVwgYV56wRQR9Sk88Uns5/rINDqXyoDw2kZogWCfY0s4huBLaIgsM2vObBufUnpNzALedNpWCATtui3qUXp+rJzfi6cEwX2CAzowq/oKWXiLGQdceOXdF5Yp8l88bzjFxrdLgFB07d58mITw3eoQt9Aa9s5XhGcJknNP4OZPd5p2SBzkiSods7YK9gn2UOh351uNz4zjHILOZhzu3oArsN+VDVc3jt59MG+mKQD1v/BRutL5MRjgOOTdOV4TImJfQIlyZNK5l11M7XNNECOnuvAJBDPEQObUf2aOUozIuq6k3PlMbjH6HC/pAk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB4742.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(4143699003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0JnS1VhTk1vbHJYQ0d1eG05UmZaa084dVlsbG9UaWNKUm8yOUxtZDBkVW5o?=
 =?utf-8?B?Nm1GOWg3aDFxVHc3cThZRDNqb0VhZXFaU28zV2lIcktueWQ1WndmZ3BISGpN?=
 =?utf-8?B?OHhtYVJGL0tod28xM2dMSndXS0tRSlJ5V0FNbmlwSi9ISFdPSWlMRzZCMGtj?=
 =?utf-8?B?d240WEcveXN3cVQySllhNXRvL3RwOExlcjU4b1VHN0poamxJZU8zM1RqVHBr?=
 =?utf-8?B?R3ozQjh1M1dOQ2JpTzhiU1dKb0kwbEZzdUpScEJSc2YrMlFkTk9FbjRjRTdz?=
 =?utf-8?B?a0RDR2xuazNHdHNaZWlNRkd4bDZoQUhMc05Tb3ZoZ0JzQUVSUzVTK2JXazg4?=
 =?utf-8?B?SFRDd1dRbjl5Zzg3UUpiRFMxSGt2YnFNd1Bka2RrRkp6RkZyd1BNRGlkOHpo?=
 =?utf-8?B?OUFVTFZ4ejY1Mm9OdlF1b0FDcGduZjZZZ0ovVmJVYUU0SE5NMkw2ZHBpSWhI?=
 =?utf-8?B?RVZQYmxvZ0ZmbFJ0Q2dPV1cycW8yUTBNWElkUStCNmFRVkd2dlFubFlNdnpw?=
 =?utf-8?B?Tlk5NTJnNE5rK0ZSbW95bVJNTWRIM1E2SVhKOHA5UlExL2ZEaGh4TkZVZG5o?=
 =?utf-8?B?aVNONENRbGVSMG1kd2JLeVZzMS9BMTJKa1RPZHNEZFNQU3ZiV0ZkelBtbDRj?=
 =?utf-8?B?NkdUZWtnbnFSK1RNckJjSnpscHJPNERZM3pIQ2crblJqdGdtNDhtVHZMYWZi?=
 =?utf-8?B?dHNOdzFlMUJxL1dBUktpTVlOKytzazVyYVQxUUk2WUpKRGk1SXljVDJsUHJE?=
 =?utf-8?B?bTVOd3FneUwwUWRVRW91S2tkRmc1VXJIalhTaFpLa0R2bkQ4TmxvVU9xQ2pM?=
 =?utf-8?B?SmxMRUcyZmh5SzAwTldZZGlVVWVmNUc4NS9TVHJvUzlEYXZTNE5pQm45MTZI?=
 =?utf-8?B?N3BrZE1lYXU1M3BlSmhiT3gwNTdmdGJpTXNneTFnU25kRHd4WGVTMmJ3S1E1?=
 =?utf-8?B?WkRwUC9xdjhnUXlEc0twZ1EwaGhJekNoMjJYSS9JMzVwdVc2a0g0WjhoTExM?=
 =?utf-8?B?Tlh5Ukp4R3VZL1Q0ZmpPZ3V6TGIvUzdEMWpRd1NxUFBBRXZja3JNQzRnemw3?=
 =?utf-8?B?NE02eDFqeDIvVDhsYVZlM0JJSzhBY08vYmFHUzZPaVdMUHZHekZMUm1uK05t?=
 =?utf-8?B?cElyNnAwc0JzQTFMTU9NYkVEdW0zaEVna3pWWVllL1M2M2NzWTIzQWxwV0xw?=
 =?utf-8?B?a05GWUJNakNtbHM1bzdub2x4SnNZd0cvZ2xrVHhUb1JENmVraWt4b0R3ZmZZ?=
 =?utf-8?B?eXJ2RFQ4ZlhHMEZmcE5JRnYxSXJ2c3ZxbWkvY0IyZGVGSXd0cmJnaUpnbVd3?=
 =?utf-8?B?Y05LdWw3d2kyQ2N3aGQwTTdVRlJrUmhLS0JKaTRlMkJrbFB6NkY3bE1OQzN0?=
 =?utf-8?B?K3dwR2VQZ1RLN0JnYW5kc0pOZVpQcEJvcnF5OE10Qkc5dmRWcVN4SHQxN090?=
 =?utf-8?B?L2dtZE4rSTJ6YU9VbFBNOWhGNkt3WUJtVHQ2aW9YYWtTVERqOGVJUGxOcG1o?=
 =?utf-8?B?ek11Y3VvVFAwTFpONGhvMnBpV1BQVTVqYlduWEE1MUkwa3NCdHNjYWJ3NjAx?=
 =?utf-8?B?OWRzQXMxSkJkcjN6em1hSm1sRFlaSDUvZmtEbk1uemZqbUpEQzJKV2YxMy9m?=
 =?utf-8?B?bkVWY2tGY0xKVmJObGVxeEl1WVNNYzNQdmtIUDNidlBLUTdVS2IyM3VDeklD?=
 =?utf-8?B?ZEdJZUpDeG9FQmJsZHU2Y0NSRHFObk1aNzVXUjQwMXpJWElTMnhVSlZOZjZK?=
 =?utf-8?B?L0JkT3kwWEtGa1U4dS9wL2dkT1VyL21pYXB3VEJhc1Z4M1gxcklyczVlRUk2?=
 =?utf-8?B?VVgwWlFublZSbjMvNGhYZU5heTJUVHZseWttdXVHTUczQTNoVU1lU0szNXJP?=
 =?utf-8?B?L1lqOTg4ejZ2Rnp4UEhWcUxja0hKK3ZOZzhyNTBNSitRMUJWekhub3NMRXhI?=
 =?utf-8?B?d0FOT1lFNmEzbno3bU9QOVBwY09mUnlNQlZZQTBUVzBDaDRnUlRBY2N1dnFT?=
 =?utf-8?B?eDBRWkpGMmZleUFLa0g0QnJkV1BXRS8wVHRRa2YvSW1qcUg1SEZnb1JXSmdP?=
 =?utf-8?B?ZVJhMStFQmgxbloxZ1dYRnY5ZTcvOXBZNkYzNVVxTTBWNFNaKzZxajRQbUVK?=
 =?utf-8?B?YUNXYXI3Zm9EZXNQMFFTMVZHUVlRdktlUkd0MWY0Z3ROMHBNREJFdWZONDly?=
 =?utf-8?B?UGhJNVhteWkyZ2hIV09yTFJGQlhxSVQrMzFVTy9BcUhNV0lXS0YyZVBJbFVm?=
 =?utf-8?B?ZmVHYWVRcWhTdGcwckpDbGdZTklONVRLVnhoMjlMemZQNlhvTVdSU2YyU0k2?=
 =?utf-8?B?R1RxVVl5cjNHQ2FKcjBiVldjR0VHdXdiQ2c4cTlvdEEvY1ArMWJWQT09?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9340a90c-d277-41e7-e034-08def75a7b76
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB4742.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 03:41:52.8649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0b6aG89IMFrCLOMh+1raLemXxEbKQAtmhHoHbuKE0Cm35UzciVE+Bk9hY3+wTl1BlnKHLn7uA0BulvJvCKAG4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNPR06MB9100



On 8/10/2026 8:27 PM, Alan Maguire wrote:
> On 10/08/2026 07:20, Fuyu Zhao wrote:
>>
>>
>> On 8/8/2026 6:18 AM, Andrii Nakryiko wrote:
>>> On Wed, Aug 5, 2026 at 9:21 PM Fuyu Zhao <zhaofuyu@vivo.com> wrote:
>>>>
>>>> Currently, during BPF object loading, load_module_btfs() unconditionally
>>>> iterates over all loaded kernel modules and loads their BTFs. This
>>>> introduces unnecessary overhead when a BPF program only needs a specific,
>>>> small subset of modules. In environments with hundreds of modules,
>>>> loading all module measurably increases the loading time.
>>>>
>>>> This series introduces a ".kmod_btfs" ELF section, allowing BPF programs
>>>> to declare the modules that need BTF loading. libbpf parses this
>>>> section, collects the module names, and skips loading BTFs for any
>>>> module not in the list, thereby reducing overhead. It also stops the
>>>> iteration early once all declared modules are found.
>>>>
>>>> Usage example:
>>>>
>>>>   DEFINE_KMOD_BTFS(_needed_kmods) = { "bpf_testmod" };
>>>>
>>>> Performance impact (<skel>__open_and_load() time):
>>>>
>>>>   Modules loaded | Without .kmod_btfs | With .kmod_btfs | Speedup
>>>>   ---------------|--------------------|-----------------|--------
>>>>   1              | 35.0 ms            | 35.0 ms         | Baseline
>>>>   10             | 36.5 ms            | 35.1 ms         | +3.8%
>>>>   100            | 46.2 ms            | 35.9 ms         | +22.3%
>>>>   300            | 65.2 ms            | 38.0 ms         | +41.7%
>>>
>>> First, is 30ms start up overhead really such a big deal when it comes
>>> to one-time thing that sets up a bunch of BPF programs? Can you
>>> elaborate on the use case you have that actually is harmed by this
>>> libbpf behavior?
>>>
>>
>> Hi Andrii,
>>
>> Thanks for the feedback, and sorry for the delayed response.
>>
>> To clarify the use case, we use `sched_ext` on Android mobile platforms
>> and dynamically switch schedulers for performance-sensitive scenarios,
>> such as gaming workloads. The BPF programs are loaded on demand when a
>> scheduler switch is required, rather than being initialized once during
>> system startup. Since the scheduler switch happens on the critical path
>> of user interaction, the setup latency directly affects the perceived
>> responsiveness of the system.
>>
>> On Android devices, the impact of `load_module_btfs()` is even more
>> pronounced in our use case. In our testing, loading BTFs for all modules
>> takes more than 300 ms (with 93 module BTFs), which accounts for around
>> 69% of the total BPF loading time. Such a delay during the scheduler
>> transition can cause visible frame drops in latency-sensitive workloads.
>>
>> We also tried preloading the BPF programs. However, this does not fit
>> well with our use case. Mobile devices have tighter memory constraints,
>> and we avoid keeping unused BPF programs resident when they are not
>> needed. Since different workloads may require different schedulers,
>> preloading all possible BPF programs would introduce unnecessary memory
>> overhead.
>>
>> By allowing a BPF program to explicitly declare the required kernel
>> modules through `.kmod_btfs`, libbpf can avoid loading unrelated module
>> BTFs and significantly reduce the loading latency without increasing the
>> memory footprint of inactive features.
>>
> 
> the approach of having an extra section .kmod_btfs feels a bit unwieldy;
> we already support kernel/module qualification in autoload section names
> via
> 
> SEC("fentry/mymod:foo")
> SEC("fexit/vmlinux:bar")
> 
> Couldn't you use that instead to inform selective lookup in find_kernel_btf_id()?
> 
>  

Hi Alan,

Thanks for the feedback.

The existing module qualification in autoload section names allows
`find_kernel_btf_id()` to search for BTF IDs in a specific module BTF
after `load_module_btfs()` has completed. However, it does not reduce
the number of module BTFs that `load_module_btfs()` needs to load.

Also, using SEC() module qualification is only applicable to BPF program
types where the module name can be specified in SEC(). It does not apply
to program types such as `struct_ops`, where the module name cannot be
represented by SEC().

The purpose of `.kmod_btfs` is to let BPF programs explicitly declare
which module BTFs `load_module_btfs()` should load, so unrelated modules
can be skipped. Since `.kmod_btfs` is an optional ELF section, it does
not affect existing BPF programs unless they explicitly provide this
information.

Thanks,
Fuyu

>> Hope this clarifies the motivation behind this change. Thanks again for
>> the feedback.
>>
>> Best regards,
>> Fuyu
>>
>>>>
>>>> Fuyu Zhao (2):
>>>>   libbpf: support selective kernel module BTF loading via .kmod_btfs
>>>>     section
>>>>   selftests/bpf: add tests for selective kmod BTF loading
>>>>
>>>>  tools/lib/bpf/bpf_helpers.h                   |  14 +++
>>>>  tools/lib/bpf/libbpf.c                        | 112 ++++++++++++++++++
>>>>  .../selftests/bpf/prog_tests/kmod_btfs.c      |  47 ++++++++
>>>>  tools/testing/selftests/bpf/progs/kmod_btfs.c |  14 +++
>>>>  .../selftests/bpf/progs/kmod_btfs_mix.c       |  15 +++
>>>>  .../selftests/bpf/progs/kmod_btfs_nonexist.c  |  17 +++
>>>>  6 files changed, 219 insertions(+)
>>>>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
>>>>  create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs.c
>>>>  create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_mix.c
>>>>  create mode 100644 tools/testing/selftests/bpf/progs/kmod_btfs_nonexist.c
>>>>
>>>> --
>>>> 2.34.1
>>>>
>>>>
>>
>>
> 

