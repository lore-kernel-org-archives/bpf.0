Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FC337C109;
	Fri,  8 May 2026 07:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778227029; cv=fail; b=N2sI06OwoXOvytB4tWxoHHMKAKHTVDIWlOpigKLStv6pt24/xOx2HFQ/SNs1CmbIshxcykDd7RCfevvo5K9P3yPhjuIftjuDyVsGZNNN7tsVEdfPnjaxqGCbPmikgH6LqPTbkQzI3MEgSKlHdV8scp+Q8Z1q/emVv5E/O+ctCks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778227029; c=relaxed/simple;
	bh=LcaUKcl28Vq8ygIGNoikZp73JSIqZXnO8pYdOsYu95M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=akhEC3I0iqwHqNaEPUNiFImN4A67cNs6XPG14EjUDPiU61eVRy8810GhZLqS2ICuBhlb3WeHm3PlWJ9OA2du3yPH/iAxGf8Xgj1AuZw1yxrff47YkzwBKWrEGhhvaLnPRt+ElEBNrqjATbhPp04ziVjO2Zz2g63kaKdei3uPOhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RUnANsFT; arc=fail smtp.client-ip=40.107.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RUnANsFT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vKapibJp8ILkX00lrjK106QGz1zA9+XuY1QjV5ENByileDw/pmwlNU7rC/J5WD3BYvFXa3+mStTYwKqHqrNGWXZB2G4cY/lnWbg1il40Bq0Z2oB3T3Pjz1siBJttcUtm8lk6IUydQ4XEO7N7GSPI3YhdLLfAqK3HoOk172xRzVXHhFdlC65jcVPBvD2xHRZlL4H/TZRiop2j/ItqPw9L0bv1cTT+s2UOgDNQsgDUJ53tj6hloTnL+/QzDHM7Uocb8/CEDWXhr8REJcFzQqFdzFWfP0wpYrx83PreumI1lfZSWznVC24SEz7dNQWzNfkNmlB6NeyfKBkQ6tcAH3QKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxKz2dxL8yrvN4kA4K5AFVKiNaQQlXUS529n8S5B2cE=;
 b=hsKGJTn5Xbb0dYORANfoF83EPPTq5nTZaBZABsIVs4MQk/dED9MqIQ8PgVc6eqzemiDGG/zo4fMO0Bo9jtx4vzWkKqC92RSVgKt/zVRNDI1cxGdaBjXLmUhWSRaQZ+uHBc0EaL7B/6WD3w/YFRy9+C4B2GAwjTVYj9H4m1c7ZyEtkdHAKo0v7y8UbGHIySbff9tO4ileLnl3oRNyUHELRqRC0zAqwT+hSpr+IwJUO4jsbTUtbWT0ZSPnyfyb4Gek2mG5vmgC/cTNlzCpVJFDYvVwaKvzgJoN9XJnHJAOvxE9hZTJ35FPYDrbSQLlstvLdX0ET3m6p9PhU/JOMdpL1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxKz2dxL8yrvN4kA4K5AFVKiNaQQlXUS529n8S5B2cE=;
 b=RUnANsFTNA5ZTJVvMXamdErbC324Zz/hxTlLAMWdO+yTfDPyEYzNjhZ23A6DklYy6+Nzg1VOqf/uyEwbZW7bp1YfQ8lWX55al/6dXUeW++GTGjFBREwTpRY2LBR2z537pxVwoy/cgvlNAbIv2RnwfsBvnpp7debUQSMqjk3hkwOrx+GHUP9vU7sFLZazqfDx51WvaGWbHPyOa0ygRCcP0K2Yb6BXUFgVtfuppqWyl/thFmcr6FPluP2Lj0GKCTHVqklTZvgZLE58Mnv7NAb1YA6oQ9OUBEMxluNFIChAk8G8rrTa3gmMpKTlX7S377JO3Kk9kFDW4kSvc1FyOGXsYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH3PR12MB8212.namprd12.prod.outlook.com (2603:10b6:610:120::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 07:57:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 07:57:02 +0000
Date: Fri, 8 May 2026 09:56:54 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Add scx_ai_numa scheduler example for AI
 workloads
Message-ID: <af2XRpaX_rFh_GI9@gpd4>
References: <20260508-feat-scx_ai_example-v1-1-2b498af3514d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508-feat-scx_ai_example-v1-1-2b498af3514d@gmail.com>
X-ClientProxiedBy: ZR1PEPF000077BE.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::46b) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH3PR12MB8212:EE_
X-MS-Office365-Filtering-Correlation-Id: 54c2e11d-5c9e-40bf-8fdc-08deacd763b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	J+49GmXO7mgMol6NapGsGHC8ZOZIBpYNwOTVMW3zTkwUi2UP3hZxPjNIzV7gzVGs+jaxEZijOEISxE2kh8hG2N46veXuBqUbHtoH3mdG9TBYQ9GBI2B7GnvPlTJYmhLWZzYlYMba3TPR/s2Ph5HeakCw8X/1OrQD/dUYbYQaP55XJqsUizJNXVw24f3YZT5t/VhxzBC/bcIgfqCNVIfXAmuKoY1f4dX+PRYRm3AGgVKe//cFDIDFiXQ14H8HfMOr5XG6nRy8xgE6DzywUlINv1/3AFFCfZrc1EWbaAv+IvsyfP2NfKfsl+EqiV67jSqxRXGUqHpTmBsrnNfJ7N6sPgszmMds50dv6N82GcowiZe+PwO8wotxoxkyBJLdYEs8hKykn1Ipr1S4/2anFYlYazxMXKRszagM+aR0sgX3XBzoTxJSkcmovtkr6tmh+vybIHyI+ZylT5W8B8jwPDSt7z+Ho+0mwwvxj/eBS53ZHR0r7MrZyIxXDCTw6xmzJtuY7ZS5oqyT/AJFUBwktCNiz3STnaml5wELIEZY597jv4VOkk9a/XTGPX3BNpFMmU4V9P/hok7Z6dgjHiUzFBZGSdBR4yRvSO3PnP/mOZPkNa2VK4TCJkfGVEWwON3LkyZBeMgUcquugUpj5mwtcN+d9/W4IsveQnpnChkhTzBONF42q6e42bQb3oIB0ras2OrQ/vhetgAu3+a07jlBMHIZRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3NSM1JnNmVLeFE1Q3NvZTYxbnIxOWEva2FsMjJYcExmbjJGOHplT0luT1Bw?=
 =?utf-8?B?allFMzdPZnN4c2ZLbmd6Z2I0UkM0b1FXTEY3TkE0RElhQ1RlWjBRYlNpRWds?=
 =?utf-8?B?Y3RRYjUybHp4YmVmQ2ZKQ1FIZGJHK0lmdXN6S255MGxLOUdsbEY5VGRadjZR?=
 =?utf-8?B?SXcvV1NaZ04vMEdvQlhGSUFKSHNnd2I5c0p3V0xPY0Jzc1Z4MElSd1BrRU1l?=
 =?utf-8?B?Q0xEK3NMRzEzTHl3aGZselBLR2JBK3FENHFhZ1lqcnBGQnNjMHc1ckI4LzV4?=
 =?utf-8?B?TnVDUzNMbE93YlE3cXpNM2VEb1V1TG1BTGZISkhHM0F2U0h3Y2x0bHh1b3NX?=
 =?utf-8?B?Q205aitvVFczTHp0V3lZRTRBSzh6bUhVZVRCT1BhRkhyVUdYZ3IyMm1YL0Ft?=
 =?utf-8?B?a0owTjFvQ2dZMi9pb0VKSThYbkpaMjV3QWpucXFpTjY5OW1nRjhMRzU5OWxv?=
 =?utf-8?B?aW1RM3BQK1JnQStBUVJyVHVtMUVVeWx2N1V1VS93clBXL1NHYlNKellpeFhW?=
 =?utf-8?B?SVV0RHhTazdCRUVmUklTbGNpeTB3SU1vK05ycnVIRlRweE5yM1lGa1hGaExo?=
 =?utf-8?B?RC9oaUZaRkN3MVpCZU92STNHV2drRW1pNExQei9kdEUyRjRaRnJDaE1zY1Vm?=
 =?utf-8?B?Y0VvUWx5ODhRb2JUNFFCTzBnRjVianF5WFRVT0xoWjJiMFFBV2J2RGpYT1ky?=
 =?utf-8?B?Z2YrNURzS0pnRkcxT0FraC9ocExVdkFQL0tORGRZc2RIMk5hRWhTRnVqZ1RO?=
 =?utf-8?B?bGxnOTFzY1M0anJIY25Odmp0eklROHFQSXFnMFIwVk9iS0hhcFdUMFdLdS9U?=
 =?utf-8?B?Nnc0bmxra2JJUWJoSW5PZ25XREJzQ2hIcHlKUGc4bDQyTHB3cVZ3UHRkVU1C?=
 =?utf-8?B?WXNVNm93RnNTN2lDRGNPR1FybzdLTG9wSjBpVDQzUlR2QTJ5eGQvZ3RJT0ZG?=
 =?utf-8?B?cHFvRk9hWkNuTE91VFdwTW9pajVNdThOT2VLV3Z2TmlzY0ZxOTJFQjBobXZT?=
 =?utf-8?B?TUFDYkNmZEVuUlZqZUYxQVBhZFljdWdYWlFsZ0p2LzdvSUFuc1dVL1RNZjdj?=
 =?utf-8?B?OFJKdmhqZ2JVeisvSnVIN0N2Zm1ncTFUV2NSeUZzNGhPblRGcFllc1NMdmxx?=
 =?utf-8?B?NHdaYXVnb3J5SEc1TUlnZ0JLSXljQVJkaHczTHUzRC92enJMUlRKSnhUSFNv?=
 =?utf-8?B?NFJkL2JOTTVyYW13RDltMm5zcHRIODhXM2EwakZicDJqeTQzTWVtSHhreGEw?=
 =?utf-8?B?OGQ2YlhiS2VOc3dvVmw5cjBuakF6NWZxTU1LcGhrVGdDY0hvMVJxckJyL0dH?=
 =?utf-8?B?QWdIQ1RYRVdVbUo1ZVJENElLNFpSU09VbG1SUEVreUVWTFB4TEtSdHUrb1lD?=
 =?utf-8?B?a1NybTdDa3BrUDRNOG5ZNWY5OXhKdlBmWDM5VXNFL3FETjg4V0dBdDVpVkF2?=
 =?utf-8?B?NWpEci82NVU0UzZqOHZpOG9ZMld0d0NueHNNUS9uanlobVkxREpPZ3pNczRv?=
 =?utf-8?B?eHdzeXhzTmx0YTk2cGdaMm8zNGhoYnNTVGo0aHBjNStsWDFMcTlzenp0d005?=
 =?utf-8?B?UFpVMzROQ01EQkg3Q1RwdWNveTlaSmtxeEl6eWFrRDNIdWRucW8vRmVrR1Jv?=
 =?utf-8?B?M0hTbGYxZjJ4RHJGTVBla1U0d2VNbzRpWXQ4ZWNhSW5TY2xFbmltbFFGWk1G?=
 =?utf-8?B?UWlsK0xxSHloMnNTTk9pek9zelFnK3J6czlDaTJrTExlTzZyM0pmZE9JQ0Z4?=
 =?utf-8?B?WnIvK0cveS8rOGNOMnFaWXphdW5Cb2hVTXN2YTRvYUJBRTAvNXhHYmdsaDJs?=
 =?utf-8?B?UlJxTDdZdGt5S3d0UGhpOGUvdjVhdEFqVGFtdEt6ZHIzWGJ0NFNOQTBnaWZQ?=
 =?utf-8?B?TUdEeEx1U1BPNXdSTnhkU1pJWEpQbFMzeWNuTllxVFhZT01ydzU0alZNRVBI?=
 =?utf-8?B?VldxNjZjTlZwdzdML0F3LzRNaDRVQ2FKak1uQmttU2pOcVByeTJzTFN2Y2cz?=
 =?utf-8?B?Wk9tc2JFK0o5WkJKTXlzR24wRXlGWHQ0T1dydnJhcmY0K285MTVYWmphZTQy?=
 =?utf-8?B?cHV2UGdsZTBnM3N4ZXpjanVJdXF4ZEpvRE5FajdVdTloazI0MXpXWUVlczBO?=
 =?utf-8?B?SVZ0RTd1VHl2L2lQNjYvSDFoZ2NycjExcW1vdEc5MnU0aSs3QU9SNlNxVFNr?=
 =?utf-8?B?OCtaN3JQZk82LzJXNGZuZ2l1QVNkZzBDWVhNd0J0TTRDVVllSHJkTnd4K1dT?=
 =?utf-8?B?amh0NXZEU2hPZjhHTFQwYTY3STVLRGU2K2ROa0Y5TGRBZWFlRGdsVFgvc0o3?=
 =?utf-8?B?MVZIRjBtNjFyUHBpb1N3dDA2c2JXU2VvMnlzTm1tLzc3ZVBGVTV4Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54c2e11d-5c9e-40bf-8fdc-08deacd763b3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:57:02.6759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmiWsTJrK5PYg3ZnGnseWEj/HN6qH2n58zaMMyjEK6xuGd12bqhJ5ZMdi65rLchkIUY5SZ/vCaak9cKMhWjtbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8212

Hi Qiliang,

On Fri, May 08, 2026 at 03:51:35PM +0800, Qiliang Yuan wrote:
> Implement an AI-focused NUMA-aware scheduler that optimizes task dispatch for
> GPU-accelerated AI training. The scheduler maintains per-NUMA-node dispatch
> queues to preserve L3 cache warmth and minimize remote DRAM accesses that
> would stall GPU kernel launches waiting on CPU preprocessing.
> 
> Key features:
> - Per-NUMA-node DSQs (dispatch queues) to maintain cache locality
> - Idle fast path that bypasses DSQ for minimum latency
> - Per-task NUMA affinity tracking to remember task placement
> - Work stealing across nodes to prevent starvation during load imbalance
> 
> The BPF component (scx_ai_numa.bpf.c) implements the core scheduler
> callbacks, while the userspace loader (scx_ai_numa.c) detects NUMA
> topology, installs the BPF program, and reports per-node dispatch
> statistics every second.
> 
> This scheduler is suitable for AI training workloads where GPU command
> launches depend on rapid CPU preprocessing with minimal scheduling latency.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>

I think this would be more appropriate for inclusion in
https://github.com/sched-ext/scx.

Thanks,
-Andrea

> ---
>  tools/sched_ext/Makefile          |   2 +-
>  tools/sched_ext/scx_ai_numa.bpf.c | 200 ++++++++++++++++++++++++++++++++++++++
>  tools/sched_ext/scx_ai_numa.c     | 126 ++++++++++++++++++++++++
>  3 files changed, 327 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
> index 21554f0896923..a639b5bf4f542 100644
> --- a/tools/sched_ext/Makefile
> +++ b/tools/sched_ext/Makefile
> @@ -191,7 +191,7 @@ $(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BP
>  
>  SCX_COMMON_DEPS := include/scx/common.h include/scx/user_exit_info.h | $(BINDIR)
>  
> -c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_flatcg scx_userland scx_pair scx_sdt
> +c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_flatcg scx_userland scx_pair scx_sdt scx_ai_numa
>  
>  $(addprefix $(BINDIR)/,$(c-sched-targets)): \
>  	$(BINDIR)/%: \
> diff --git a/tools/sched_ext/scx_ai_numa.bpf.c b/tools/sched_ext/scx_ai_numa.bpf.c
> new file mode 100644
> index 0000000000000..89d3b7dd3d474
> --- /dev/null
> +++ b/tools/sched_ext/scx_ai_numa.bpf.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * scx_ai_numa - AI NUMA-aware scheduler (BPF side)
> + *
> + * Scheduling policy optimized for AI training workloads:
> + *
> + * 1. Per-NUMA-node DSQs: each NUMA node owns a dedicated dispatch queue.
> + *    Tasks are steered to the DSQ of the NUMA node they last ran on,
> + *    preserving L3 cache warmth and reducing remote DRAM accesses that
> + *    stall GPU kernel launches waiting on CPU preprocessing.
> + *
> + * 2. Idle fast path: when an idle CPU is found, bypass the per-node DSQ
> + *    and insert directly into SCX_DSQ_LOCAL for minimum latency.
> + *
> + * 3. Task NUMA affinity: per-task storage tracks the preferred NUMA node
> + *    (updated every time select_cpu() sees the task's prev_cpu).
> + *
> + * 4. Work stealing: if a node's DSQ is empty, try remote nodes in order
> + *    to prevent CPU starvation during load imbalance (e.g., bursty GPU
> + *    command submissions landing on a single NUMA node).
> + */
> +#include <scx/common.bpf.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +UEI_DEFINE(uei);
> +
> +#define MAX_NUMA_NODES 16
> +
> +/* One DSQ per NUMA node, IDs 0 .. MAX_NUMA_NODES-1 */
> +#define NUMA_DSQ(node) ((u64)(node))
> +
> +/* Per-task context: remember which NUMA node this task prefers */
> +struct task_ctx {
> +	u32 preferred_node;
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +	__uint(map_flags, BPF_F_NO_PREALLOC);
> +	__type(key, int);
> +	__type(value, struct task_ctx);
> +} task_ctx_stor SEC(".maps");
> +
> +/* Per-node counters (per-CPU to avoid false sharing) */
> +struct node_stat {
> +	__u64 local_dsq;	/* fast-path: direct SCX_DSQ_LOCAL insert */
> +	__u64 numa_dsq;		/* enqueued to per-node DSQ */
> +	__u64 steal;		/* dispatched from a remote node's DSQ */
> +};
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(key_size, sizeof(u32));
> +	__uint(value_size, sizeof(struct node_stat));
> +	__uint(max_entries, MAX_NUMA_NODES);
> +} node_stats SEC(".maps");
> +
> +/* Set by userspace after detecting the number of NUMA nodes */
> +const volatile u32 nr_nodes = 1;
> +
> +static __always_inline u32 cpu_to_node(s32 cpu)
> +{
> +	return __COMPAT_scx_bpf_cpu_node(cpu);
> +}
> +
> +static __always_inline void stat_inc_local(u32 node)
> +{
> +	struct node_stat *s = bpf_map_lookup_elem(&node_stats, &node);
> +
> +	if (s)
> +		s->local_dsq++;
> +}
> +
> +static __always_inline void stat_inc_numa(u32 node)
> +{
> +	struct node_stat *s = bpf_map_lookup_elem(&node_stats, &node);
> +
> +	if (s)
> +		s->numa_dsq++;
> +}
> +
> +static __always_inline void stat_inc_steal(u32 node)
> +{
> +	struct node_stat *s = bpf_map_lookup_elem(&node_stats, &node);
> +
> +	if (s)
> +		s->steal++;
> +}
> +
> +s32 BPF_STRUCT_OPS(ai_numa_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
> +{
> +	struct task_ctx *tctx;
> +	bool is_idle = false;
> +	u32 node;
> +	s32 cpu;
> +
> +	/* Update task's preferred NUMA node from prev_cpu */
> +	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0,
> +				     BPF_LOCAL_STORAGE_GET_F_CREATE);
> +	if (tctx) {
> +		node = cpu_to_node(prev_cpu);
> +		tctx->preferred_node = node < nr_nodes ? node : 0;
> +	}
> +
> +	/*
> +	 * Default selection tries prev_cpu first (same LLC), which preserves
> +	 * L1/L2/L3 cache across AI loop iterations without extra policy code.
> +	 */
> +	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &is_idle);
> +	if (is_idle) {
> +		/* Idle CPU found: bypass DSQ for minimum latency */
> +		node = cpu_to_node(cpu);
> +		stat_inc_local(node);
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, SCX_SLICE_DFL, 0);
> +	}
> +
> +	return cpu;
> +}
> +
> +void BPF_STRUCT_OPS(ai_numa_enqueue, struct task_struct *p, u64 enq_flags)
> +{
> +	struct task_ctx *tctx;
> +	u32 node = 0;
> +
> +	/*
> +	 * Route to the task's preferred NUMA node DSQ.
> +	 * Keeping AI tasks on the same NUMA node as their GPU's host memory
> +	 * reduces cross-node DRAM traffic and PCIe DMA stalls.
> +	 */
> +	tctx = bpf_task_storage_get(&task_ctx_stor, p, 0, 0);
> +	if (tctx) {
> +		node = tctx->preferred_node;
> +		if (node >= nr_nodes)
> +			node = 0;
> +	}
> +
> +	stat_inc_numa(node);
> +	scx_bpf_dsq_insert(p, NUMA_DSQ(node), SCX_SLICE_DFL, enq_flags);
> +}
> +
> +void BPF_STRUCT_OPS(ai_numa_dispatch, s32 cpu, struct task_struct *prev)
> +{
> +	u32 my_node = cpu_to_node(cpu);
> +	u32 i;
> +
> +	/* First: consume from our own NUMA node — zero cross-node traffic */
> +	if (scx_bpf_dsq_move_to_local(NUMA_DSQ(my_node), 0))
> +		return;
> +
> +	/*
> +	 * Work steal from other nodes in order.
> +	 * Prevents CPU starvation when one GPU's launch bursts all tasks
> +	 * onto a single NUMA node while other nodes sit idle.
> +	 */
> +	for (i = 0; i < MAX_NUMA_NODES; i++) {
> +		u32 node = i;
> +
> +		if (node >= nr_nodes)
> +			break;
> +		if (node == my_node)
> +			continue;
> +		if (scx_bpf_dsq_move_to_local(NUMA_DSQ(node), 0)) {
> +			stat_inc_steal(my_node);
> +			return;
> +		}
> +	}
> +}
> +
> +s32 BPF_STRUCT_OPS_SLEEPABLE(ai_numa_init)
> +{
> +	u32 i;
> +	int ret;
> +
> +	for (i = 0; i < MAX_NUMA_NODES; i++) {
> +		if (i >= nr_nodes)
> +			break;
> +		ret = scx_bpf_create_dsq(NUMA_DSQ(i), -1);
> +		if (ret) {
> +			scx_bpf_error("failed to create DSQ for node %u: %d",
> +				      i, ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +void BPF_STRUCT_OPS(ai_numa_exit, struct scx_exit_info *ei)
> +{
> +	UEI_RECORD(uei, ei);
> +}
> +
> +SCX_OPS_DEFINE(ai_numa_ops,
> +	       .select_cpu	= (void *)ai_numa_select_cpu,
> +	       .enqueue		= (void *)ai_numa_enqueue,
> +	       .dispatch	= (void *)ai_numa_dispatch,
> +	       .init		= (void *)ai_numa_init,
> +	       .exit		= (void *)ai_numa_exit,
> +	       .name		= "ai_numa");
> diff --git a/tools/sched_ext/scx_ai_numa.c b/tools/sched_ext/scx_ai_numa.c
> new file mode 100644
> index 0000000000000..58c7bb1bd6bb6
> --- /dev/null
> +++ b/tools/sched_ext/scx_ai_numa.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * scx_ai_numa - AI NUMA-aware scheduler (userspace loader)
> + *
> + * Detects NUMA topology, configures the BPF scheduler, and prints
> + * per-node dispatch statistics every second.
> + */
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <assert.h>
> +#include <libgen.h>
> +#include <sys/stat.h>
> +#include <bpf/bpf.h>
> +#include <scx/common.h>
> +#include "scx_ai_numa.bpf.skel.h"
> +
> +/* Must match BPF side */
> +struct node_stat {
> +	__u64 local_dsq;
> +	__u64 numa_dsq;
> +	__u64 steal;
> +};
> +
> +#define MAX_NUMA_NODES 16
> +
> +static volatile int exit_req;
> +
> +static void sigint_handler(int sig)
> +{
> +	exit_req = 1;
> +}
> +
> +/* Detect NUMA node count by scanning sysfs */
> +static __u32 detect_nr_nodes(void)
> +{
> +	struct stat st;
> +	char path[64];
> +	__u32 i, count = 0;
> +
> +	for (i = 0; i < MAX_NUMA_NODES; i++) {
> +		snprintf(path, sizeof(path),
> +			 "/sys/devices/system/node/node%u", i);
> +		if (stat(path, &st) == 0 && S_ISDIR(st.st_mode))
> +			count = i + 1;
> +		else
> +			break;
> +	}
> +	return count ? count : 1;
> +}
> +
> +static void print_stats(struct scx_ai_numa *skel, __u32 nr_nodes)
> +{
> +	int nr_cpus = libbpf_num_possible_cpus();
> +	int map_fd  = bpf_map__fd(skel->maps.node_stats);
> +
> +	printf("\n%-6s %14s %14s %14s\n",
> +	       "Node", "Local-DSQ", "NUMA-DSQ", "Steals");
> +	printf("------+--------------+--------------+--------------\n");
> +
> +	for (__u32 node = 0; node < nr_nodes; node++) {
> +		struct node_stat per_cpu[nr_cpus];
> +		struct node_stat total = {};
> +		__u32 key = node;
> +		int i;
> +
> +		if (bpf_map_lookup_elem(map_fd, &key, per_cpu) < 0)
> +			continue;
> +
> +		for (i = 0; i < nr_cpus; i++) {
> +			total.local_dsq += per_cpu[i].local_dsq;
> +			total.numa_dsq  += per_cpu[i].numa_dsq;
> +			total.steal     += per_cpu[i].steal;
> +		}
> +
> +		printf("%-6u %14llu %14llu %14llu\n", node,
> +		       total.local_dsq, total.numa_dsq, total.steal);
> +	}
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct scx_ai_numa *skel;
> +	struct bpf_link *link;
> +	__u64 ecode;
> +	__u32 nr_nodes;
> +
> +	signal(SIGINT, sigint_handler);
> +	signal(SIGTERM, sigint_handler);
> +
> +	nr_nodes = detect_nr_nodes();
> +	printf("scx_ai_numa: detected %u NUMA node(s)\n", nr_nodes);
> +
> +restart:
> +	/*
> +	 * Avoid SCX_OPS_OPEN() which accesses sub_attach/sub_detach/
> +	 * sub_cgroup_id at compile time. These fields may not be available
> +	 * in all supported kernel versions.
> +	 */
> +	skel = scx_ai_numa__open();
> +	SCX_BUG_ON(!skel, "Could not open scx_ai_numa");
> +	skel->struct_ops.ai_numa_ops->hotplug_seq = scx_hotplug_seq();
> +	SCX_ENUM_INIT(skel);
> +
> +	/* Pass NUMA topology to the BPF program via rodata */
> +	skel->rodata->nr_nodes = nr_nodes;
> +
> +	SCX_OPS_LOAD(skel, ai_numa_ops, scx_ai_numa, uei);
> +	link = SCX_OPS_ATTACH(skel, ai_numa_ops, scx_ai_numa);
> +
> +	printf("scx_ai_numa: running (Ctrl-C to stop)\n");
> +
> +	while (!exit_req && !UEI_EXITED(skel, uei)) {
> +		print_stats(skel, nr_nodes);
> +		fflush(stdout);
> +		sleep(1);
> +	}
> +
> +	bpf_link__destroy(link);
> +	ecode = UEI_REPORT(skel, uei);
> +	scx_ai_numa__destroy(skel);
> +
> +	if (UEI_ECODE_RESTART(ecode))
> +		goto restart;
> +	return 0;
> +}
> 
> ---
> base-commit: 8ab992f815d6736b5c7a6f5fd7bfe7bc106bb3dc
> change-id: 20260508-feat-scx_ai_example-8e1384942646
> 
> Best regards,
> -- 
> Qiliang Yuan <realwujing@gmail.com>
> 
