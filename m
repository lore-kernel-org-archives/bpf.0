Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013052.outbound.protection.outlook.com [40.93.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7B44756B5;
	Tue, 22 Sep 2026 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790084942; cv=fail; b=iCkpDAYEY2lfjHsBDPA/umJFdiTOZ/+0T/lNcJYpCBgxV3oRsB0ZucuRKxyLTxg64U/JxvWxpZn0w6PLkqiRxhEFgFiuKkUDyW+UusEEiONViQk0i/vW3LuLUe8hNpuCA4yNQo4b1GcRnJf2ATzNLtG20ssDzQE7jN/EDf6aAFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790084942; c=relaxed/simple;
	bh=oXOSf5sEdSi4NB+sXLz9k158WpztD2eNkcsMxKke8Lk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TTZEHRc/51ibX9V7alRPXvfVcGp7AEE+a56LLVWpSbHYxmXAi/AVfXzih7kZiXVk8y5lRe5whnqx34C4vX949ZU8PEUzuksrjjH7gqR+bol038V6Jhfs/sdVD1E9IeoM++9HEHPBVXLkPwu/Uj2zK2eJTRINSHE2+JBCKNPb4rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bY5le9nd; arc=fail smtp.client-ip=40.93.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bY5le9nd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s385Ttm1roxG3cr83he9ANf2K4q2aHtl1VN3H7VSNODAks4qr8tOtJcKcjYGDSrTRcAtSVc6ogQSbw0TIBUA77nb/fzG60z3ASWvoiYJCegkO/74962z63a1rX02yvuDC3BBUv8us/7HDSQ7c73UMAZnrKTJGDZzdBWo87nVhNN+7Y6JhpzvVQPH+hwLGHzy+d1UZNld0lTn8CXCn2FrlgsNpfhO+w+g9bhfXAKOdzQKs82RSFsc5hSNedd90ay1JRQ6Ar12ISVAInz/rZ2b5wqwtuiLHSbYhwXsrs7w3yHY3AEsglCuV7l7YJK345/N5iKQxPqPzjQ0On3wZvy4wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwSlbEgEz9AFntWOePV0tKXfdEjf72dLg2o/hbgYQZ0=;
 b=s6ajIrjpoKSnqFmulyuxDyCLsVfhNuV+xBJH/hCIKTzj8eb7EuFyHgEdVoW+nyoTzkr/X3tNEbFkKsGutkvrlqBpVy3xHtQ7to4P9mCn7hqqu6f55SMjf/IGilVWWo58v8qys5JxTuu/n0sS85VeBbvZpHDprwe6ElhUgn8q+wPr21wcU9xxHOkLu46r66lRPh3gVu3JMRDeQ++uPV7h6Vi5UdcMBPczGgehvo2sLj25h5v3hCAhT7MBz4ZTst8MY42X6MmWx5wJHnPiSfK1dY/TVOCYMjzlACv2re3HimdkprkgUPJZLItRKsm1d28gdtEe+rH6Mz7KINT5h0Rbzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwSlbEgEz9AFntWOePV0tKXfdEjf72dLg2o/hbgYQZ0=;
 b=bY5le9ndlZICbZhLolROFwE0SH1U5BaQjCMK5ZcO51APclF4vVSpFdy2n7KvFns2FCTGh8b5hFTdJLtTCpVJLZkknXvpYdQV4fj2NDyd8klkfFYZ38iM9lgm3KtC992CUHboKMpIUVxl06Aqy4bMNO2NymjBOg/hcZpLxXcRdaJnPniTSr5YsmMnsell8C1mM6ocrz2CA3SYjaBN7N/75LkYQTEA2Jnaiq7C/LE+oD3/SGSQXiH+8zS70ipeI48CritsMd6XM1kIzGR3YXTqjzokK+uA4uBzMloesLRiqh7fTbEgspfbBfk6pR8OcYeskbf/Znt5Q3GywJoRx42qSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA1PR12MB7734.namprd12.prod.outlook.com (2603:10b6:208:422::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 13:48:56 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0428.015; Tue, 22 Sep 2026
 13:48:55 +0000
Date: Tue, 22 Sep 2026 15:48:48 +0200
From: Andrea Righi <arighi@nvidia.com>
To: rahadbhuiya <rahadbhuiya2021@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/sched_ext: Add scx_priority dual-queue priority
 CPU scheduler
Message-ID: <arKHQEyAnvgIF4ij@gpd4>
References: <20260922084557.532-1-rahadbhuiya2021@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922084557.532-1-rahadbhuiya2021@gmail.com>
X-ClientProxiedBy: MI2PEPF00000B89.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::407) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA1PR12MB7734:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db250dd-84ac-4a96-cad2-08df18b03eaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|56012099006|6133799003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	QJX7Z+d5a4qHAjVwO4hX3FN5eEEKQ78xJ3RRdsxOaNa2FffJTpF6nHpieorHFE+sWFIDktMfpB/BI+vAF+sREPx5556s/lKnYyxGTODK5UtdjLHkjJMnOnS4Ob4mzfD5sAPkUJkPU1foFk7jKErP668fJEyM7tHMFdah7E8LcISG2n9FD0jY7ODPekTs0ALPlOGdqRNS4QJV8g1XWlLDbHDbpdgNKfl56s52KDclhSzqeeecZEK2gl27+bz44x5m8gLTo+wVQZqRj9KVFIdri5pqOnwQdgQHABA2Q0CQXauqWF0E0hkbBepGJxRz0lmaVuRLt8+L4uFeR1DYHD2XjqBI58pecAveQCYs3LrV+A+TDFB+5E2xSIn8wUcrAofD464BhUtgkvEp5HvFN/S/rx0hppvI5fPeuvyn9G7JXB2yM4eREGI2jDJqow+1JMyztHC+9CFlGfodlfvH7OOxl3A/b8iZtcbpD8W12L8Yc9/lCxps861gOrXgSVc2vHDqJCjxxEoRfgs/bxLCtwvyAu4K852vCEUlqO2t9Ft+ZEA8ydQn0E7r3TgFGT56CzNY3XwjY22MZKNCVajD3SEf131CpM/rRP5XQIxhGHVVP7XHO1jN/M65lX5j1Qs6PB3/S8r5ZRz0Fk6RHISR2cX0oB37fIDA6ePd3oWCXF/xymg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LF5/lnvmrjY0AogvA/TOIv/SRb0MZZoC3YCCfhphIA+Gsb0Wz8CnvVt7t37N?=
 =?us-ascii?Q?q4TgXTr4RlwSQathV9NoePWX9mLzSa1Ogkhv2SlRcuBtHe4SSsPm65APC0Fq?=
 =?us-ascii?Q?jA4S1NI/K3hCh7IqToQ0px3tcBf3p5hk0zSwE66eTLiAJtnG67Bdanrhnbeb?=
 =?us-ascii?Q?feHyk6zO8/sWWMFOMWIINuW5hHfHZI7kwircBiYd7TFPkr7Dc8YUh3W8cWR8?=
 =?us-ascii?Q?N0FGtp3lQCBwicnmJSGxCL/PQ+FaMTja+F1WneTGY9SnzmMUr6SmaX9eXcmY?=
 =?us-ascii?Q?fMDmMPj+Ltvqv8SXCIdEt87Ko6VYO5ngTykTk8YGtjYkCn8iB5JqIRLZEWe2?=
 =?us-ascii?Q?P79z+Ib5r0txtfF4doeUEVyUCCyr0ELfue7JYU2mGBQMb+TM/HvmjQF9UJd2?=
 =?us-ascii?Q?oztPfCa9Ttdn0864oq/RJB2wFp788LOQ84hj+3uawZCQBebLDXL/EB4HLMj5?=
 =?us-ascii?Q?xOhp+Iv1Np5amfqtHVxwmdRPTzhDPjj4IbJ9Kn+9v1DilAtqPgWKpO9mSYJ9?=
 =?us-ascii?Q?JSgwZYzAdTsOXjy8AqMNSlRVo6yIy5oIeFrGcnoQ/Dd226chWNp5BGqPH1GR?=
 =?us-ascii?Q?wDVFiwy2N/UCF7bOEE8wS0fDuVwS6vgTa6fy9P3h/ySjj+Cspg9fw5LlE3lj?=
 =?us-ascii?Q?tfM6PW0QH5bi/0ph8Pi8Y+e6o/AXe79OIGfhWPIEa35ETAmHl6fBWFypaOX2?=
 =?us-ascii?Q?cupYel6tBinp4Z4u4vINoKlb1e/Y57LszF5p9rL7E/CHzg1xHqSygtmTH8fQ?=
 =?us-ascii?Q?26o923k6pyuz1iAYU090JC5IR4iEtTZVXHUJG4Ilq1jxL34huLLeovQ+mVUS?=
 =?us-ascii?Q?BNdFtFHo3qbxM8g32iOxgG8ijlun6lIYky3YmRu/Cr34xvw0paCMYNOk0Rxr?=
 =?us-ascii?Q?0pcxvMVfI/JGzvbUbY4dR7xxMOkVc4Btkl/L171AFK8bi3OM92snqLzj6ege?=
 =?us-ascii?Q?YUK4/ckslc2NCJ/9dLEm/7MsTq//2yIi6IIqaqViLBtlORVOD9wgKhGVM19f?=
 =?us-ascii?Q?WO+FVJpD/267kMvtHUSUb2H60iakqUILwJ93sffX8QP1U2r7rcoXFggXUtxG?=
 =?us-ascii?Q?s/AvsmDRp5JJEkhH8JeS4vGPrwPXv87eaVcN4zQL6IdvVBr8Pug49K8ufd1S?=
 =?us-ascii?Q?KGf/HvkS9MAM6bSrV1lPvMJYOSKeTYlwotsfgTcr1zWu+WMrVRRWloywFV3l?=
 =?us-ascii?Q?dxnaY4ZLxvivPTubuI/R0tPdNq4IVlYo5Pd9OK6hh45xEWyNrrC0qBwDUqnF?=
 =?us-ascii?Q?HjQ7x6rqn9K0HR+b+2XkGOv07eWQLrJtMrl40XLBjhBFbsiHTYoMGuQTcz2N?=
 =?us-ascii?Q?854AIas3+E7fsK46qtYzX1pQQNJ6sd8NDezTAKF6YpfuLyJ2FB2MxRn51mLW?=
 =?us-ascii?Q?fB9MLn2jAx0WRcdevYqIbYLWJaWRNC8ue9dgjK0eivte7SHuta1QndFqUQuk?=
 =?us-ascii?Q?GDn09bILV7+qd0seeGAJDG+4SjuDw3mbNrOD+o+CVWCbOl1u1ZBn8jUK9E0t?=
 =?us-ascii?Q?T/TLLEaOUK57F621iLBnOqJSVU12IqeDpAvpZC4dYW5uPYbkHXM8Ae6y4m0B?=
 =?us-ascii?Q?5eSnKF12YWic+MU/2BIb2+idkwhZBJjOFJKQsD5Pbqag01hK3dFp9fms2Q1u?=
 =?us-ascii?Q?ZrSchtKpXkTJ963qVJhONQxplO1RjOI9X0Paqsv184aZpMqdw9+K4dsZwyUg?=
 =?us-ascii?Q?R9HteBK88g5B1LbGESv88rDLzj9nGB/viGnFT+z5VvV8y/SR4lLeFqIO120Q?=
 =?us-ascii?Q?UA1FZ6HaCw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db250dd-84ac-4a96-cad2-08df18b03eaa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 13:48:55.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4y8cZmpTEmYSeNsoa1jf33SJoVH9/FpAW7zb6/8cVuCtP+N9gVGwv2AxNAsMVbxcAgrIP2AABJMbnobJvlCWGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7734

On Tue, Sep 22, 2026 at 02:45:57PM +0600, rahadbhuiya wrote:
> Add scx_priority, a dual-queue priority CPU scheduler using sched_ext.
> It differentiates between latency-sensitive/interactive tasks (nice < 0)
> and normal/batch tasks, dispatching high-priority tasks with boosted
> slices and draining the high-priority queue first upon core availability.
> 
> - Add scx_priority.bpf.c with two DSQs (high priority and normal).
> - Add scx_priority.c userspace monitor tracking live throughput.
> - Update Makefile and README.md.
> 
> Signed-off-by: rahadbhuiya <rahadbhuiya2021@gmail.com>

Personally, I don't see a strong motivation to include this in the kernel,
schedulers under tools/sched_ext are primarily intended as examples to
demonstrate how to use the sched_ext API, and the functionality covered here is
already well represented by the existing examples.

If your goal is to offer a scheduler for people to actually use it, I'd
recommend submitting a PR to the community scheduler repository:
https://github.com/sched-ext/scx instead.

-Andrea

> ---
>  tools/sched_ext/Makefile           |   2 +-
>  tools/sched_ext/README.md          |   7 ++
>  tools/sched_ext/scx_priority.bpf.c | 117 ++++++++++++++++++++++++++
>  tools/sched_ext/scx_priority.c     | 128 +++++++++++++++++++++++++++++
>  4 files changed, 253 insertions(+), 1 deletion(-)
>  create mode 100644 tools/sched_ext/scx_priority.bpf.c
>  create mode 100644 tools/sched_ext/scx_priority.c
> 
> diff --git a/tools/sched_ext/Makefile b/tools/sched_ext/Makefile
> index 21554f089692..41b80e164cda 100644
> --- a/tools/sched_ext/Makefile
> +++ b/tools/sched_ext/Makefile
> @@ -191,7 +191,7 @@ $(INCLUDE_DIR)/%.bpf.skel.h: $(SCXOBJ_DIR)/%.bpf.o $(INCLUDE_DIR)/vmlinux.h $(BP
>  
>  SCX_COMMON_DEPS := include/scx/common.h include/scx/user_exit_info.h | $(BINDIR)
>  
> -c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_flatcg scx_userland scx_pair scx_sdt
> +c-sched-targets = scx_simple scx_cpu0 scx_qmap scx_central scx_flatcg scx_userland scx_pair scx_sdt scx_priority
>  
>  $(addprefix $(BINDIR)/,$(c-sched-targets)): \
>  	$(BINDIR)/%: \
> diff --git a/tools/sched_ext/README.md b/tools/sched_ext/README.md
> index 0ee5a3d997e5..18b80eacc28a 100644
> --- a/tools/sched_ext/README.md
> +++ b/tools/sched_ext/README.md
> @@ -164,6 +164,13 @@ scx_simple can be run in either global weighted vtime mode, or FIFO mode.
>  Though very simple, in limited scenarios, this scheduler can perform reasonably
>  well on single-socket systems with a unified L3 cache.
>  
> +## scx_priority
> +
> +A dual-queue priority scheduler that separates latency-sensitive and interactive
> +tasks from normal/batch tasks. Tasks with higher priority (nice < 0) are queued
> +to a dedicated high-priority DSQ with boosted time slices and drained first upon
> +dispatch.
> +
>  ## scx_qmap
>  
>  Another simple, yet slightly more complex scheduler that provides an example of
> diff --git a/tools/sched_ext/scx_priority.bpf.c b/tools/sched_ext/scx_priority.bpf.c
> new file mode 100644
> index 000000000000..816b197c4019
> --- /dev/null
> +++ b/tools/sched_ext/scx_priority.bpf.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * A dual-queue priority scheduler based on sched_ext.
> + *
> + * Dispatches latency-sensitive / interactive tasks (nice < 0) to a high-priority
> + * DSQ, and batch / normal tasks to a standard DSQ. When a CPU core becomes
> + * available, the high-priority queue is drained first before serving normal tasks.
> + *
> + * Copyright (c) 2026 Rahad Bhuiya <rahadbhuiya2021@gmail.com>
> + */
> +#include <scx/common.bpf.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +#define PRIO_DSQ_HIGH	0
> +#define PRIO_DSQ_LOW	1
> +
> +/*
> + * Stats tracking:
> + * [0] - High priority / interactive tasks queued
> + * [1] - Standard / batch tasks queued
> + */
> +struct {
> +	__uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +	__uint(key_size, sizeof(u32));
> +	__uint(value_size, sizeof(u64));
> +	__uint(max_entries, 2);
> +} stats SEC(".maps");
> +
> +static void stat_inc(u32 idx)
> +{
> +	u64 *cnt_p = bpf_map_lookup_elem(&stats, &idx);
> +
> +	if (cnt_p)
> +		(*cnt_p)++;
> +}
> +
> +static bool is_high_prio(const struct task_struct *p)
> +{
> +	/*
> +	 * In the Linux kernel, static_prio maps nice -20..19 to 100..139.
> +	 * Default nice 0 corresponds to static_prio 120. Tasks with nice < 0
> +	 * (static_prio < 120) or real-time policies are prioritized.
> +	 */
> +	return p->static_prio < 120;
> +}
> +
> +s32 BPF_STRUCT_OPS(prio_select_cpu, struct task_struct *p, s32 prev_cpu, u64 wake_flags)
> +{
> +	bool is_idle = false;
> +	s32 cpu;
> +
> +	cpu = scx_bpf_select_cpu_dfl(p, prev_cpu, wake_flags, &is_idle);
> +	if (is_idle) {
> +		u64 slice = is_high_prio(p) ? (2 * SCX_SLICE_DFL) : SCX_SLICE_DFL;
> +
> +		stat_inc(is_high_prio(p) ? 0 : 1);
> +		scx_bpf_dsq_insert(p, SCX_DSQ_LOCAL, slice, 0);
> +	}
> +
> +	return cpu;
> +}
> +
> +void BPF_STRUCT_OPS(prio_enqueue, struct task_struct *p, u64 enq_flags)
> +{
> +	if (is_high_prio(p)) {
> +		stat_inc(0);
> +		scx_bpf_dsq_insert(p, PRIO_DSQ_HIGH, 2 * SCX_SLICE_DFL, enq_flags);
> +	} else {
> +		stat_inc(1);
> +		scx_bpf_dsq_insert(p, PRIO_DSQ_LOW, SCX_SLICE_DFL, enq_flags);
> +	}
> +}
> +
> +void BPF_STRUCT_OPS(prio_dispatch, s32 cpu, struct task_struct *prev)
> +{
> +	/* First drain high-priority tasks if any are waiting */
> +	if (scx_bpf_dsq_move_to_local(PRIO_DSQ_HIGH, 0))
> +		return;
> +
> +	/* Otherwise drain standard priority tasks */
> +	scx_bpf_dsq_move_to_local(PRIO_DSQ_LOW, 0);
> +}
> +
> +s32 BPF_STRUCT_OPS_SLEEPABLE(prio_init)
> +{
> +	int ret;
> +
> +	ret = scx_bpf_create_dsq(PRIO_DSQ_HIGH, -1);
> +	if (ret) {
> +		scx_bpf_error("failed to create high priority DSQ (%d)", ret);
> +		return ret;
> +	}
> +
> +	ret = scx_bpf_create_dsq(PRIO_DSQ_LOW, -1);
> +	if (ret) {
> +		scx_bpf_error("failed to create low priority DSQ (%d)", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +UEI_DEFINE(uei);
> +
> +void BPF_STRUCT_OPS(prio_exit, struct scx_exit_info *ei)
> +{
> +	UEI_RECORD(uei, ei);
> +}
> +
> +SCX_OPS_DEFINE(priority_ops,
> +	       .select_cpu	= (void *)prio_select_cpu,
> +	       .enqueue		= (void *)prio_enqueue,
> +	       .dispatch	= (void *)prio_dispatch,
> +	       .init		= (void *)prio_init,
> +	       .exit		= (void *)prio_exit,
> +	       .name		= "priority");
> diff --git a/tools/sched_ext/scx_priority.c b/tools/sched_ext/scx_priority.c
> new file mode 100644
> index 000000000000..3cf975be3a1e
> --- /dev/null
> +++ b/tools/sched_ext/scx_priority.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Userspace controller and monitor for scx_priority scheduler.
> + *
> + * Copyright (c) 2026 Rahad Bhuiya <rahadbhuiya2021@gmail.com>
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <assert.h>
> +#include <libgen.h>
> +#include <bpf/bpf.h>
> +#include <scx/common.h>
> +#include "scx_priority.bpf.skel.h"
> +
> +const char help_fmt[] =
> +"A dual-queue priority sched_ext scheduler.\n"
> +"\n"
> +"Usage: %s [-i INTERVAL] [-v] [-h]\n"
> +"\n"
> +"  -i INTERVAL   Stats monitoring interval in seconds (default: 1)\n"
> +"  -v            Print libbpf debug messages\n"
> +"  -h            Display this help and exit\n";
> +
> +static bool verbose;
> +static sig_atomic_t exit_req;
> +
> +static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
> +{
> +	if (level == LIBBPF_DEBUG && !verbose)
> +		return 0;
> +	return vfprintf(stderr, format, args);
> +}
> +
> +static void sigint_handler(int sig)
> +{
> +	exit_req = 1;
> +}
> +
> +static void read_stats(struct scx_priority *skel, __u64 *stats)
> +{
> +	int nr_cpus = libbpf_num_possible_cpus();
> +	__u64 *cnts[2];
> +	__u32 idx;
> +
> +	assert(nr_cpus > 0);
> +	cnts[0] = calloc(nr_cpus, sizeof(__u64));
> +	cnts[1] = calloc(nr_cpus, sizeof(__u64));
> +	if (!cnts[0] || !cnts[1]) {
> +		free(cnts[0]);
> +		free(cnts[1]);
> +		return;
> +	}
> +
> +	memset(stats, 0, sizeof(stats[0]) * 2);
> +
> +	for (idx = 0; idx < 2; idx++) {
> +		int ret, cpu;
> +
> +		ret = bpf_map_lookup_elem(bpf_map__fd(skel->maps.stats),
> +					  &idx, cnts[idx]);
> +		if (ret < 0)
> +			continue;
> +		for (cpu = 0; cpu < nr_cpus; cpu++)
> +			stats[idx] += cnts[idx][cpu];
> +	}
> +
> +	free(cnts[0]);
> +	free(cnts[1]);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct scx_priority *skel;
> +	struct bpf_link *link;
> +	__s32 opt;
> +	__u64 ecode;
> +	int interval = 1;
> +
> +	libbpf_set_print(libbpf_print_fn);
> +	signal(SIGINT, sigint_handler);
> +	signal(SIGTERM, sigint_handler);
> +
> +restart:
> +	optind = 1;
> +	skel = SCX_OPS_OPEN(priority_ops, scx_priority);
> +
> +	while ((opt = getopt(argc, argv, "i:vh")) != -1) {
> +		switch (opt) {
> +		case 'i':
> +			interval = atoi(optarg);
> +			if (interval <= 0)
> +				interval = 1;
> +			break;
> +		case 'v':
> +			verbose = true;
> +			break;
> +		default:
> +			fprintf(stderr, help_fmt, basename(argv[0]));
> +			return opt != 'h';
> +		}
> +	}
> +
> +	SCX_OPS_LOAD(skel, priority_ops, scx_priority, uei);
> +	link = SCX_OPS_ATTACH(skel, priority_ops, scx_priority);
> +
> +	printf("scx_priority started (interval: %ds). Press Ctrl-C to stop.\n", interval);
> +	printf("%-15s %-15s %-15s\n", "HIGH_PRIO(UI)", "LOW_PRIO(BATCH)", "TOTAL_DISPATCH");
> +
> +	while (!exit_req && !UEI_EXITED(skel, uei)) {
> +		__u64 stats[2];
> +
> +		read_stats(skel, stats);
> +		printf("%-15llu %-15llu %-15llu\n",
> +		       stats[0], stats[1], stats[0] + stats[1]);
> +		fflush(stdout);
> +		sleep(interval);
> +	}
> +
> +	bpf_link__destroy(link);
> +	ecode = UEI_REPORT(skel, uei);
> +	scx_priority__destroy(skel);
> +
> +	if (!exit_req && UEI_ECODE_RESTART(ecode))
> +		goto restart;
> +	return 0;
> +}
> -- 
> 2.54.0.windows.1
> 
