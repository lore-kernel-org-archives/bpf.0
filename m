Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.104
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795807646;
	b=tC8YrZkibnyppEltqPH2JsHbjfn3Y91dNj7N3aQZ+sMfhDxUFWKVowHkQGhhZPwrftHk
	 9604nKH4O9ehOkIEwpGB+MZzlCLa2TUS2AlXScLRQVZvMMJnsT4dj3XirGCPYZvZm4iRB
	 kzL6geptpW9asa48i4SJc8QcdVSjwGkkU3tNpSSVFfQewW7kJQqViuHJXGtNX1GjfVUyX
	 OTcnH/uwDKAYuxDZ38CWRDTlPDdkY+AertNM3IaNrEyORSihcH8/VeiI0W89+DWV5Ibgu
	 AGBB6gBunF8uMoFnASopvdY/YuYbMGHs524I0S/0Kkuy67uVaQ9EKDrGd07K8e73ppQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807646;
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
	bh=uUJ872aGb9W/Gr73OddDdFkGiYcOSklaX+SEQXaAUIA=;
	b=W4pXgLn1Msho93jY55cIbcGkqgbNaH5bwRAXfxFJ4zP059RSphsdqY6NCEcjIKUzK4jH
	 kVVUdeFYcTliEWNWyEBPpqbQMxwhUj0uDAKoLwMy3g2Q7tTN58/ZfZHPu0SbdGhyNEKjd
	 fZ0NISFTCD6UR8B6JIkVFHc3rP7mDr+3BUIqrrkZ37lkKpLyb3VnoIRevlX1VgEny/Quu
	 RraKUT4AVoYuCsBx+ZpNlz8/BKibZipsCChlHG4y4f/7NKeCUhR+QtqKWyNDKoGljZLgk
	 cdnZZdlu+xtu7OdaE2HtxQ88AbN1IBbbVNTQBB5j2u3Xn1LG2QxT8D/CIxlkeMxbIzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=qwuXiVOj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.193.104
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022104.outbound.protection.outlook.com [40.107.193.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEAB606A331;
	Fri, 27 Nov 2026 19:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AEAB606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=selector1 header.b=qwuXiVOj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ME+3iYcX1TJtO7O2PLqqMbXSuyzjRSPksKxjeoheS6ZraeEL6fTc8+lJypYmtyZzQA/dt00Fp2IB2eHecNmkzsVKeBSU5PYc84aVWCaMrDRwS1gM9skER6Pm+vCAP6cLcOua2mGhbcXyaM4esUA3buMEmnbTcPXwh6v7hTtXfQQL2bYa8UWjfkX11AKHMvwhJQLtjmLnGI0Aa71b7ZZlPwq0tQRnse+9i3Unuhp2qDgY0f4UBCnKVQ3l1DEr/3mCC8xOJVIbg/wEsmetibMw3pvRdzHL0i2j/PX8fvY+xCLvAZmyZ3ZPZVAO4T5rkbagsNlMw+KOdQ2bNFcYAsSp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUJ872aGb9W/Gr73OddDdFkGiYcOSklaX+SEQXaAUIA=;
 b=Ghsg3s9dZCD0GxU8yLs6I64EGAk/542BQQlA2PLNRnPAOQQtFEc1aSa9zKbkwK5iZMSq5fpNP5c6AZLMoE40Ap9zeB5XSQrh1Bwd6Yutsysxk+CC1RM96HATENQBkkdJTu67j6x0tsDiDLuk6OCHT0JUhxuhUAVX+/HnNMcOUYAVKw2xpvdVmKjE5ZDJ2fAXZsFLgvQQ9M1NMG5DkwuHm9x4j0944yu8OhuuG2ONz0qLB2syRGwZH4YemziAUzb3ebonv/+a4xp8OK8v015x6SVBj/cO/zSjaedTAcqqznp3hhxXwMBCtvHDQVWVLdxKDxXq47UI/1YBqk39oRHj9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUJ872aGb9W/Gr73OddDdFkGiYcOSklaX+SEQXaAUIA=;
 b=qwuXiVOjp5hhrhhnZJP6IKQBH+p/CU6ORcFXYtwKm7DdwU9SdEDqiUqEeRS5yFdgzqfN6xETBk8wexLiLb5q5ekFoSDnp55YM0A3Reo9ckUNXM0yhF9jOjqf8QnqaAe40CGR+VUv+oArLgyI+f+748YVaJZHV9Yn4MKONEyTEXgEE7UeWk9/lqG8Dn0yiAAz5Mu4VVP+30ls4kCehnX09l+Xppj7sm9ODxsNGNTCAaalKcwmQweCI7OE7mb4u9wIJp9rXPbDrqh2isgaBUvQdVFrz88NG8tgQfcmX/359uZ8hIAK6lG3CKBYWg/15ZnZVX54cFmTwYs6vBf5omiSzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:1d0::10) by YT4PR01MB9767.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e7::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 19:27:18 +0000
Received: from YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc]) by YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6b9e:a901:67c5:7ddc%6]) with mapi id 15.21.0662.007; Fri, 27 Nov 2026
 19:27:18 +0000
Message-ID: <51c3bb03-c712-4982-9d02-e21206c7ece9@efficios.com>
Date: Fri, 27 Nov 2026 14:27:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/16] selftests/membarrier: Check the memory barriers
 of each thread
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20261127185822.158216-1-mathieu.desnoyers@efficios.com>
 <20261127185822.158216-16-mathieu.desnoyers@efficios.com>
 <sashiko-outbox-238151@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-238151@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0170.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::10) To YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
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
X-MS-TrafficTypeDiagnostic: YT6PR01MB491026:EE_|YT4PR01MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: 37742cdc-b54a-44b1-e865-08df4cbc735d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|6133799003|261009223027099003|10067099003|261026140227099003|261026121527099003|261021121427099003|261102123227099003|261028144727099003|261022105027099003|261022075727099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	QBu6VlewcrsxVkS7uoRdisetqPhXAFaWS1mWG3eS1NCJizHKh9y+8yZ2jb4c0M+1SL5jeYuyfh4q0+uRG7jFHmhn4vD9cQK4pMlMpHHg/vzs6FuRGs3NW/qkj5qf3HpRTCuhG15J0ha8ErIGJ9G0w47uRDrvdwheeXrgKtpCNuLm6ZWVReOqV/x0KtKAYsdcwntwrzHDrGzbpjZtlkuP3Li3NumHOkViWjQdkTOxNJbECCSf0NuAt85U50S3hcdvN6h2BEoZwI0duCm+yErZzH8iW6aHH916E1XTZgpm/1JDN64UmiMsRykQQeVLACVGWeMrS5uD8uOtG3zx1gL9EWTXzVnUgqn2hlM7eHypJcbrFCsdVbwBJjcNUyry4pJRnX2186W6az0afLjUZJo5D2iO6/magFpZLVWlLlOJ9xKGLBPwhIKEX99U5HeNFLHHtnOPSBDhFpiCcfYkpELZF2fDle76iaF5m+TmzqUi20ZCkNZ/nCM3K+CfOriJ1TEw/a4sstMMxBvLNW4ZZyka+u+r7EEzSXxIO1CI3p26ViuqEf0UFMSqYUAVis4DKraJ3oj325eoCqdm7bcF6sO/u8UcXNuzeQW4Dfox15SJ4cs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(6133799003)(261009223027099003)(10067099003)(261026140227099003)(261026121527099003)(261021121427099003)(261102123227099003)(261028144727099003)(261022105027099003)(261022075727099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjFxYnliakpUTmQrWEt6dDVucjIwZEM1WTJtbWZvbFNTWXdJS2xQb2pJaDlR?=
 =?utf-8?B?OWJjMno5dVJjMzlGdmRteTlUK3hKL3BQVjZITklVUk9wcnZTUVM1T3dlWXR0?=
 =?utf-8?B?Z3NqblYwYnM4aVNSbDFHUERhZUFuclN5VEdqQnB5S2k0N2l3R3lYQkpjRm5t?=
 =?utf-8?B?Yk9IRG5VbWdSWEZwdDN1ditlUkdMTkFOL0JjTXFxYjNEVFhZcUxTcnN5YVk5?=
 =?utf-8?B?c1lVVnk1bEpaUE9hSE5Fb1RqdERreUUxY2tSQUIvNmxzWll0dXp4VUlmRHAr?=
 =?utf-8?B?OXo5VUtwRnYyMnFnZ05EQi9VUHZFalVJTkpUaGYvMWZvOFJlb0x0eGJwOU8w?=
 =?utf-8?B?VE9mbXZEMjZtbnpuL3MvWCtVbmxTWmRQNWFDTHJOK3J1QStkTmtWUjloYlNJ?=
 =?utf-8?B?R3hvZ3JrM2JqOG9tL3dtYnd0Z2FHdFVrZGVKdWI4akQ0Tk1hNjZ5Wm85OEd0?=
 =?utf-8?B?T1k1a0NhYlplTkNmc1VwOU5kTC96TDZQSWx3RkJrS2Q1d1FZeTVyQ3BxN0dy?=
 =?utf-8?B?QW83dFkrYzh6VUR2djNhYWp4Y0tPSTYyTEtiaXpKeG9iREVqTFJrYVlKMWF1?=
 =?utf-8?B?VWJoeEQyekhRbWs1ODBpSUduT0xHU1BvUEI5RHl3dE5jNnlheVJaTjhldGJy?=
 =?utf-8?B?SWlkd2gwQUtjNU0vSDhjVVJpa21MOXBGUk1nNjFFaDJPajlrMW5mcWNhdU1M?=
 =?utf-8?B?aHhVcFJtM20vYmpGNUhJUFZmV1ExdGtSWXpoOXNDMjJJTnY4cEwxcFNsL1VN?=
 =?utf-8?B?T1E0TFczbGtxYmp0TVBweHUrcUplSEgxSGdrVi9ZTExILytxZyt0V1dtei9S?=
 =?utf-8?B?ei91cFNkT05vV1lvaHR6SnVOaHpJWllDNTltZGVsWityMVp3YjNCMksrb2xH?=
 =?utf-8?B?c0ZLMTFkcWxkSmRsRGR6cjJiM0xTKytJNlQySy9NQ2ZwdzZZZjFsdGY3Yzll?=
 =?utf-8?B?endHdCsvbEt6THhsTmR6QnhsYUxiMTN2bENMbCswbUFZOXhYTDcrZG92VE9R?=
 =?utf-8?B?WjBseS9BQ3hJVVRnVitKZWNIUHNxK29GQzZxY01HVDY4bng4R3BxMGxBSUl2?=
 =?utf-8?B?cVhPQWhFZlRVVEQzcmFCc2p6c3pLYU5GOFF3dTc5UFd4REJSRFVwRmpkOCtZ?=
 =?utf-8?B?M3NPOE5MR0ZEV1hEaE1HdFh0NG9IUTlBeTFDc3k3aE1XcEhmcTFFZlJheVlp?=
 =?utf-8?B?ZkRNTEJaeGZBUU1YYXlJN3lJRGt1TGYrMjA0SndJR25JVEg0SUtvTnBrajdp?=
 =?utf-8?B?alJwaTVRSFVUVWMxOHYvSVNmNzJta014MkFYMXI4dTZwaDZvYkp3VW14cDdy?=
 =?utf-8?B?SXMzNUc1c3NKREsyM09aZ2lmQm1SdFNHQ2VHL3NpK2J1enZKaWYra1pmQ0sz?=
 =?utf-8?B?dzFuYzg1cTJSaG1CRVo0U1lrK1puTjROc0tEL2FhZ3FYdDdCYXBIZkN3VmhQ?=
 =?utf-8?B?M05aOUxmYU8ya2UrK3FLR0lzVzRIaXFrTXEwelo5SWRZVGVqOVk2c0tpazhM?=
 =?utf-8?B?NFYvMjlaVzgzd0drY0hJY2FobFMwR1BweWhMUVpFclgvOHppTVUySHBCY0pq?=
 =?utf-8?B?cElPWTN5TUxXTXZma0pkZVMvd3B3cllzTDNiakdGMGRqSkdDRFZSYkJnYlpB?=
 =?utf-8?B?ajU0L1NRTytodDIycDJJNUViZmxxV3JmRHhHYWVvUTk4Wm9aZ2VMK1BzU1Zo?=
 =?utf-8?B?bzRNd1F2NkNMY0ZnaUNPbDk1d3RKMjlESkN4WDh2Y3ZDOHhKT2ZVK09ac1FR?=
 =?utf-8?B?Zi9qNEZ1OFFTaXFUNzhZaE9ESGhNanFhZWFEeUNobXBlT2FuYzJNY3MrN3hQ?=
 =?utf-8?B?VmN0N0kySnJYTm1xU0VkOS9ldmVmaVdGTVJnU2F1R1RBWUtoSXlIQ3Q4dzZU?=
 =?utf-8?B?b3g4Zmc0RWo0VHZiQUlCb3c3MmRvOWNwS3JHWjl3R21GQ1B1Z0VYR0laQ0Rq?=
 =?utf-8?B?VGpENmVpck5jbndsaUlacnVBMTJIZWw2T2ZnV0FVNFpnK2tVWDlQSkZ3ZlNP?=
 =?utf-8?B?WmloVEttWEZoS2FuUWJMK2FkUUJHWFBTQlU5REUwWUk0RkNzQVFZbUR0WGxs?=
 =?utf-8?B?a0xuMzRUWGlycEJOSTU5THl0ZGUwR3JLd3NJSmNuMEVqb05zeTlsOFpNWXpO?=
 =?utf-8?B?a0VjMTlaWk5wNjM3OTFqQjlTV0dpbHpUQWxNMEhaRlR2c01wRVRyR3JEeVVZ?=
 =?utf-8?B?d3gyS0VWNHhGNVNYb25GdlllQlRNazM3ZnhoVlpnNVV6aFZGQmhlOUFtVWh3?=
 =?utf-8?B?UzMwQ2VjV3FLL0tLVU10QmtqQ0p1L0ZSZ0xjaEtXZUNoTmh4SHVYSzlTOWNY?=
 =?utf-8?B?VnRwOUtZc3JBMFNuSnpXbHpNb0xyemRvMmhMbXlsWmZtaXQ0VGFqeTVlTmw4?=
 =?utf-8?Q?9ftLBtopxufQB3xcXTrThy1tYToyXL0mM66UY?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37742cdc-b54a-44b1-e865-08df4cbc735d
X-MS-Exchange-CrossTenant-AuthSource: YT6PR01MB491026.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 19:27:18.3838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bP64CbyxdxPCeLzSYOdBKAEkeI7sb8qtHqTfRAcW/YvMvHiqyAK76kbHhHEdHZ8vz+tplSOZ2Dt+wBs43dOmXPf7mgIER2tkE2Hr7WjNuRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT4PR01MB9767

> [Severity: Medium]
> Can run_target() read MBT_SCHED_IN_MISSED before the target thread has
> scheduled out to flush state->owed?

[...]

> If the child is not preempted during that round, the schedule-out on
> cpus[1] only happens at _exit(0) after run_target() has already recorded
> stats->sched_in_missed, so a missing scheduler barrier on that switch-in
> will go undetected.

Yes. The BPF program counts a missed barrier only when the CPU leaves
the thread. So the last switch-in of a target is never checked. This
holds for every test case, not only for the lazy TLB one.

I checked it with a variant of the test which does not probe the
barriers of a switch-in. Each switch-in then counts as a missed
barrier. global_expedited_lazy_tlb ran about 47 rounds. Before the fix,
it counted 48 missed barriers. After the fix, it counted 95, so one more
per round.

Planned fix for the next round: run_target() waits until the CPU leaves
the target before it reads MBT_SCHED_IN_MISSED. It sleeps until the BPF
program has counted a schedule-out.

> Also, sampling first_sched_in after pin_to_cpu(target->cpu) subtracts out
> the MBT_SCHED_IN increment from that initial migration onto target->cpu
> when computing stats->sched_in.  Should first_sched_in be read before
> pin_to_cpu(), and should run_target() force a schedule-out (e.g. via
> sched_yield() or migrating off target->cpu) before reading
> MBT_SCHED_IN_MISSED?

No change planned for first_sched_in. Only EXPECT_NO_IPI uses
stats->sched_in. It allows one IPI for each switch-in, and run_target()
starts counting both at the same point. The switch-in onto target->cpu
happens before the caller starts, so no IPI can follow it.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com
