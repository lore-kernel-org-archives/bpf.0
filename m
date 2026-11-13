Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794580657;
	b=V4Std6m6e/41JLFjjsTBp/2BYBh9vyfCN1nqTPVd/E77Ui5EmpTWTl7W3nkHFZdkkfjF
	 58iw3lE3wNomZ/ma8iqb2QYmCPr5Ky2EO1ib1Ya9yXGirv74F8Hek4su733D/cYk8Vf58
	 DjqgoxDSzNVwEYtTpP0tPedBbwXIeYwi2LW/ACyzQxScMt6O/opLANgWUTBaCL/re+T5k
	 UVV/PgYiAQAknomeU856ws6kRyK2bsRZ2UjLHA9NFqfyShGLuD4Ly4xaBIPOMoDhcB3fA
	 HREsYJeEaMNyyA2moBHbdPhRG8eAOGk146UYZx+mrbPF9mnZYVDNMZj0TvyNsLWBpEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794580657;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=/RYVCqV7k7xTPgRrR2CDb38P/NJSsTKrT2U6zO68EaA=;
	b=AgWym4w7UtOWAjsKwjcgBkUjlH/gUhM3uVfYSj3zNQkBQ08CA58if4h8k2WU5F2vML4y
	 VucyI7iHcjHBes6/T5kXdh8aKJu9vQOriYUUesI2Mq07A3P7JUd5jFJ061m7gwQQD2EV+
	 H+ZvXzJHlxBPCBX5MmtrXnR6R7CVSzT0RjW0FUe/Ke5IHtSui8Q0PZzVJbzobEAU6LuTy
	 lISvDGUiHuiHfa7sfzirhJy5NiaTsHAz0LFGWGaH3/6ifpahsWv6oXM7VmFkdPz5FR3ui
	 E2AKB2VKxK3PUBadDmVxN2nfZPvthJVSKMFSSTwGof0zlP+6N3cGkAOyalTPF/zpHLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=m0jnPKVs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.191.73
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020073.outbound.protection.outlook.com [52.101.191.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3667C606A327;
	Fri, 13 Nov 2026 14:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3667C606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=m0jnPKVs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPZyWASnZIjDfIJsLMruSVyzhbTk6oCADYFCaXukApBU7wow6peVFjn28IyVtlaM9M3l19a6GO1UvjrskB4LF9e39L0GXAbI+uL5RuohIDU1NPfqgqngvErajGBfFtjBH73aDH6QY95aZSADXyohrIZIuoF+avbaWshtkDwgdgA5HVgLZBTgDcaKO99BLsQIx3pdqHnFjoHz99MZJVDaeQIIfPqd6s+HKbK323pw3S5kHTvOljxCmqpVBbgVJ98k8wzeavKhbCuRLLQigQ9Ky100fWGi5uJ+WkBwdo7o7dLgasqpRE4Jqh+be4gueOfcKElsiOpq1caQiBSeD683cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RYVCqV7k7xTPgRrR2CDb38P/NJSsTKrT2U6zO68EaA=;
 b=Lgp6jI6MLZW1a1oTJRYjupvWcSd/vqTaMXkBIzxP0R1fl0tA29L/boL+qXrid9qjJKXENgpT7CB85HVfSjeptYcU6ycFOvlmOSPMQh/Uggz9nBjoOC3V89IFoeorfkdWB9cFno2lORrAiXvz7pw2EiBYHziatSOvmW/reKC/W3JueyQ6cb93kLtNwieNkWgJSXWXfsFrB5O+kwpAzkFCUlc1I+F9KDFI1NrHLqQci0hhY5bZx0NqMXLD1DA5HM9P/AphNdCFHnzFMkkLGcfl9uORcOvSr7vQ7S39cmpUML0tRYRlm/mlD+Xp40UAcs3LXwkODF52K2DC42lW0n+stQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RYVCqV7k7xTPgRrR2CDb38P/NJSsTKrT2U6zO68EaA=;
 b=m0jnPKVs7PNgGxMNqabU3Z6JW3Bz16zQy7IiiaJPehoIvUXV0g2Ge7hrwOAVeDubeD7L3dHsB6/jIDQFe3D+7BqqjH1y+VTnrYKsr2kOJAEC0TISJN16FSSqDeyVpC0KxiTV74/n1az1cBWTZopa0+OsGUadsKNkDuArgDq1xnv44bZi9vEb6LDXUQf7rRURLCMGdAE9Tnwmlu01WZeVqg6OQYbVbTNS1jPOO8rlIk9MQe3aEzghKTiZEV8aVelvY30A0rHNkgxUy/rI2gK4pIU/jhZWDDC+1GagS7VSaO1VHVXghLeLEMgUGQ6qhtiBeKB9QheDiJShZnK6l5k3TQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT6PR01MB940077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1ba::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 14:37:33 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0615.008; Fri, 13 Nov 2026
 14:37:33 +0000
Message-ID: <9b274b15-7b4d-4611-b894-d1651b99c490@efficios.com>
Date: Fri, 13 Nov 2026 09:37:32 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 15/16] selftests/membarrier: Check the memory barriers
 of each thread
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20261113131903.157186-1-mathieu.desnoyers@efficios.com>
 <20261113131903.157186-16-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-212919@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-212919@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0003.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::7) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT6PR01MB940077:EE_
X-MS-Office365-Filtering-Correlation-Id: 61686479-b856-4d12-7c27-08df4193a795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|261009223027099003|56012099006|4143699003|261028144727099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	30VbqRvNKbnH4K8pqeTeEqUgrgxYiB8p3W5MWSZaVUoRQfwl+rZy0zqVcwEBRYEUO8NhrHoMGH0Numxnc1hY2IvQQA6hGpl+j3FwhPYghF1cachW2CeLN7G6gQIoV/sx5ZXaQwduAEmu0hxemrMoF5XFZDPkXTWDJo5S1OFlwP8aqfBJadgQUYtnf3VwHlFrEIJAL9cU6leyW5Dq1DT14luW5ZMCIgCelw36j0whMh+xVA4xmHNE0Hisdl0Bd1/tsj6YAU0LBya3jbCcy1/eAY7ixZOhXL/U0m3saOIl5Pqq9S8MCz8v1LjNeBOT+MbZ+WNxd9BllqMF7ZCIXzDZmR/cEpsPubrKdpyikFBSVnC9AKJZh8Nx5sKg9Ft/g6F09LpOO6polmTZItRWocyZ5D61JQ4kS1aDJzrVxRbxVq7p3CYY/2MFOyg3biEXPzoga803U/yoKqezV+Qh8151o5W/HbTanhmayOyEpk6RKfjcDnZZIPM/pHZYQJvutGi9vFGB2X6ro0SbKpVZCd4dLfE31nM3knawM+gqCsVlff3m+XcYDE8aQ0n0Qd8vjVFTh/u7eJv6OuRnsAVBiZsr8jskPPtcnkuQRv9cr5B9jKc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(261009223027099003)(56012099006)(4143699003)(261028144727099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHIzeERKMjZwWW9rOURkaVAxR0l0aHE3VWF5YytBbmJaSlRobHV2RGJsQkpt?=
 =?utf-8?B?VFdIUjh1TGUxSkxCdUQ2cXNGUndJaEVIVStSYkNydEdHaDAzMUxFZU1hVTlr?=
 =?utf-8?B?QzNTblBKK0NqM3ZlQmpUaWhSYk1rY0hPcGtIWXc1d1ZySG9BTmZ4emZnQzNO?=
 =?utf-8?B?UXR2dHRCSk96c3BQMnZRL290TkxvZHhQNTBja2FkRERDSHFCdzVST1g0Rnlj?=
 =?utf-8?B?Mm9UVVdFenNkcHJZLzVJeFVIWlkzUm9seFgwcml2bnlBVWtHc3BiTDVwbmI3?=
 =?utf-8?B?SndheFZrZVhXT0ZXaitDYjNQdTJtSlVQT0dUVHdETytweEpOWFdXQStGUm1y?=
 =?utf-8?B?dDQ2OFB6ajJjeE51V0l0cXl2R3BNTTVIUzlpN0h4ZkJlTFNuOEV1Uk5nVExk?=
 =?utf-8?B?K3ZaclhlNGtRYzFIVWRjdFc0ZEZQYWc5SXZzdVZ4V0NmYzlLVzZYTHd6VXIw?=
 =?utf-8?B?UTZLU1BEN3NCZy9qb2ZlODJ6bkxad2IyeGpLbTlyZUJqZjJQWVJkRERrQWZm?=
 =?utf-8?B?aXlORElxbkJBT3k5clM4QmppZnM5WnlYbzVVRHdWU1BDNEc3bkhxaFBVZEov?=
 =?utf-8?B?bzhPZDVERklXVE9FcVIxd3FzQjg1SlgrMFc0RnJaSWo4Q3hKa0xPaTdhOE05?=
 =?utf-8?B?TVhMRVF6aHB4M2d4UkJvMjlZR2EzR2QxZ0xLdUJSZ3E3cTNFN0dZRHd6MmdS?=
 =?utf-8?B?U05udTAxblJoOUFEN1VTNjFKUG91RHM5N0R4VEJDc0wwUC9tMnB5dFZLelUz?=
 =?utf-8?B?NG5ZbnhVTUpZMTR5WGdYOFB5M0VJd1liU1dXbzhFMStBVXNaNndaRFhRSlpZ?=
 =?utf-8?B?UHFSTkpnUHRkOEFrdS93MVJQNCtJaGtMMDcwUHBtY0hObGs2cWppT09LdTBB?=
 =?utf-8?B?U0ZWNStzQUNJTW0vR3Y5WTM1WVpsWjdyZ01qMXpQVGdRajRrYzFpZnlVbUdz?=
 =?utf-8?B?UER5TTc0ZTAxU1V0MkwvTDNLbDNWQmVEZEtNR2Z4R01tOURTOFpUV3NzeDNW?=
 =?utf-8?B?ZzBvaFo2UkRCb2lKRkZZMThpemcrQzIzRGVHN0JPa2RNK0N6c1A0Nlhyelcv?=
 =?utf-8?B?bUpMMlR3Wmk5blh0elV2cUY0VVI3R3ZDRGFIS01QMENPT0NmcTVqMTQ3M2xQ?=
 =?utf-8?B?Ukp4SEI2TE13c2IwNk9SZ2pmY2VKdjR1L2FTQkExNGhEZWh1Sy9Zb0EyT1lU?=
 =?utf-8?B?aEtYWC9FbGo4d0hPRVhVNjdxNU1HMjUwVFZSa0pjdGlxZWUzQXdXanI5N1RL?=
 =?utf-8?B?OHY1b2x0NXB3OE4wVFh4VjlZYStxNW1IREJxN3hVbXpHV2tjbGg0VFg4MlBp?=
 =?utf-8?B?bDRHelBwNjJPMzVraFhhcDAzYnNuRjRONElETlFQUE1tRm43NS9Semg3R2JD?=
 =?utf-8?B?dkplbUM3ZHNLNGY5S3ZaYWdqL0FZQWdUUDNUcUNwUHNkUW1IaGFpVkoweVly?=
 =?utf-8?B?ZVVaZG1sazRIQ1pqRGZxT2p5K29WMUFjalhjU1BVZUVIVk1FRkpUV1QyK3Rp?=
 =?utf-8?B?SDVXaXI3SnpQVEF5ZC9nOENXcUkxSDc0bXhNdjk4cVBDT3VlTkNxTUJSNlZ2?=
 =?utf-8?B?YVd1cWM1UHl2enZPNWp3dWJValNNNUVVajBqR2p1OTUxQkE0NTZ2ZzhRZ3M2?=
 =?utf-8?B?TWljNjhISDFwZGMxK2dseTFmNG5XUFRMRFYvZVZwS0kwME5TWml2ekdyUDBK?=
 =?utf-8?B?bmZ0eGp1T1pyeTNrcm5DVTB5d2hjZkdOd3d0KzR5VGFyMithdmEyTUx2d2lm?=
 =?utf-8?B?aHUrZUM3NGliLzRJWlBzdk8ySHNnbmZQYWpLT2Vvc3JGN3o3Ym03VTJKWmJ3?=
 =?utf-8?B?UW9RNU5MU1hGRmdFZlhzd3k5ZkVVZnR4Wmk1UFdodHFYa0dvZzdOa0pTSkdo?=
 =?utf-8?B?K0NsemFhczFxREZXOWo5cmtoREVEdkVMQ01yL0Y2RysyNkZpZXRLTkVhTXNu?=
 =?utf-8?B?U29wbnE2TEdBeUFyTmhhOFlRUGs0eHA1L2RDRHZJQmdnMDk1bndNMWZudjM2?=
 =?utf-8?B?MHZoelZ0THV0UzUwUkZIZm1FRjQvdXFrRExreTJtaWpaZmlnWkFYWGR1eHZO?=
 =?utf-8?B?QnJHVjQ2cVZmMlcyVGFTWE5xZXo5cW8wT3dCZGxHVjhJWnRJeWsxU2xLYUtL?=
 =?utf-8?B?eTR2LzRBU21hTThYeU43ajhuWW5UdGdBdWd6ZkxJUGtUTTFkdzljZ1p0TWJ4?=
 =?utf-8?B?clN5L2JYVnVldElRMXpmbXhxZmFMYjlGV1ZGWDNQajdNb05pMXRyNENrNzhs?=
 =?utf-8?B?SjRoRENTVWZjY2ZxMUZWT2ZaOE55SVc0M080TldrKzNGMFJucjcvcEJNT3BE?=
 =?utf-8?B?bS91aFBUV1hNNjlpWW51QUQxVmZrK0wzbkpkaEpNaEphQnVoV2ZYSEtEeEM3?=
 =?utf-8?Q?7irTrs05e1HlscrfZ7GrpCVvp2xeDqF9nG1H0?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61686479-b856-4d12-7c27-08df4193a795
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 14:37:33.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+tA+82iCRUX6YM2vww1KoglqnmkfB2hV+Zg8YgVsInUpvWKa2rxPShHowpnDyzo7O0GtY1pJvKRMr8piPTVeS+3F4Q+B5ZcVQmyq8/YXk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT6PR01MB940077

> [Severity: Medium]
> Does setting setup_broken = true before bpf_object__load() and
> bpf_program__attach() cause main() to fail instead of skipping when the
> kernel lacks required BPF features?
>
> A kernel with CONFIG_DEBUG_INFO_BTF=y and CONFIG_PROC_KCORE=y can still
> lack CONFIG_BPF_EVENTS=y (needed to load kprobe/tracing programs and
> BPF_MAP_TYPE_TASK_STORAGE) or have BPF JIT disabled (needed to attach
> tp_btf/sched_switch).

Yes for CONFIG_BPF_EVENTS. The same holds for CONFIG_KPROBE_EVENTS,
which the kprobes of the test need. The test should skip in both cases.

The BPF JIT is not needed. The sched_switch program is attached as a raw
tracepoint, which does not use a BPF trampoline. I built a kernel
without CONFIG_BPF_JIT: the test attaches and all 13 test cases pass.

Planned fix for the next round: bpf_setup() checks both options before
it treats an error as a failure. It probes the kprobe program type with
libbpf_probe_bpf_prog_type(), and it looks for the kprobe PMU in sysfs.
I tested this on a kernel without each option: the test is skipped.

> [Severity: Medium]
> Does calling pin_to_cpu(target->cpu) before map_counters() miss the
> lazy-TLB context switch in global_expedited_lazy_tlb?

[...]

> As a result, sched_switch never sets OWES_BARRIER or increments
> MBT_SCHED_IN for that lazy-TLB switch.  Calling map_counters() before
> pin_to_cpu(target->cpu) registers the thread in task_slot before it
> migrates back to cpus[1].

Yes. The target moves back to its CPU before it has a counter slot. The
BPF program does not see that switch, so the barrier which the scheduler
owes the target there is not checked.

The checks of each call start after the registration, so they are not
affected. Without the fix of patch 1, the test case still fails.

Planned fix for the next round: run_target() calls map_counters() before
pin_to_cpu().

> [Severity: Low]
> Can zeroing shared->next_slot in reset_shared() let an exiting task from a
> finished test case clobber the BPF counters of a new thread in the next
> test case?

[...]

> Preserving shared->next_slot across reset_shared() avoids reusing counter
> slots across test cases.

Yes, this window exists. I did not reproduce it.

Planned fix for the next round: reset_shared() keeps next_slot. The 13
test cases use about 270 of the 512 slots at most.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
