Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011053.outbound.protection.outlook.com [52.101.57.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42A43C555C;
	Wed, 17 Jun 2026 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683223; cv=fail; b=JjNOITrIHuBqHgAbpxfchxDmQKtmp8acJaiE4EaF0COOPGTZyjsngFealu6is0EztTGeCOQW3fWXIz3xIWUH5SE71Y5yEJIFlV9JDof2BggNvhzD7XmtkGw+rDWsnlfeJsVV9HT0N/KWpHoEXpzeMqIoYHIP3fWh1bmFYWsy1yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683223; c=relaxed/simple;
	bh=Xuq++zQE39ZuYIJBb16N0yzKx6mxI3v+kID61GLZPkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GZWLUYFP6tCOFAhae6/gUjLrfqMcbuHAdBrW3NVvOkitf4Ly/lo5fOVLx0X4zgEpnwAu2OEK1E3kPOQ0P8XHjhr7VEffZahPYmuDk406ZmJI8GWbe1b7rWFu5HWpptv6lVX+sdDIgKWreWhZ/oJ5VcTE7XBysS8Kjt5lqXhScjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WLaL0JUD; arc=fail smtp.client-ip=52.101.57.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WLaL0JUD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUzymZ9WkyR/n0SfHnIGKa1NvsdoQxh3uBcgvwVEPNBj8JYtk1RmVsbuBPzYSMVUIsxKHQ3u4ykAsP3xxp2mdtmTkGC/AnHt+Ca9ZL283LCv+tYNS0OQRkk9/yw2/w5UCFb1GPbYstJyiNbzF1YkAovDmGsAR+HvinhC42eKEDlsXiLN/+nR1KZzuPWq9FD2RTC1ZAes48PScoOhi2Hf5SbpP8sQTQZ1sjxxCqb6ppu4Ms3DYHyfaisV4u+zBVmB3HTrXLBj3TZ7KuppbBRfo1D81G0rJ/+IGjtLpJyPufWPwArGbxtJjtiHdxy1DYw9rIuEeq3bAH22YNU8K+wGSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wt9e4NYMGg34G158QMrsXAwjw13oqcUT7srXqrVaM7o=;
 b=HLw//iDCeCwJ8CL1/srBCqK866UOZJH27Q3fAFKGTgFeJ2OZ7/wfbKrk7svjbbCfby8y6/K+Nv1bpG+7Dz/9UVUA0QCwWixyxo0zy0Sl0rRbCZR87XW5dfvM/6T35J5JC5SA/JxRUX8TWXaIfIGrqTmIx4qffJHIioJpsJ/t+8NT5sCcZn7TckKnLJLX+Qpd5AHI+AEfqtU+NH9JdjQylTmVcQN+ju+jeseUgAwMW/bsK+t2JXDW+Y/hM6MILNgzXM63ToUVEWdLkLcKmYfcWcbi38OO0cvaUWUuImCFlGvqHt6x7SGQL4WjGLy8rEvVVa8sK+zTUq8X5epN6FZBSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wt9e4NYMGg34G158QMrsXAwjw13oqcUT7srXqrVaM7o=;
 b=WLaL0JUDNYuDkrUY1SGUjqsqL+MtU3RfgoWf2KXKseQ7iEntl1CKmaMxVpHhkFDlQ/CYKaY3qNfKrYKHqpSB552az4ZuNMvXCZvEyjwu9JD2l1lC3o8ROTnPId8xUNxo+ThESp88OM5yGsL3PmWisbGMHd/HGjxPvIcjRwfSJfNpG4j3YIitjnpqLwX4UcC1StTA9RAibruZOtPtJWao1Dmx+5s0QQwN8cSZTG+J0x7XOrRV8OBl1Yg+K4bakS6za0gpKZ8+Cz7QIlNQxfptUrA1iEO7kR0rzgsXpxz6u0OHoErH6TQ5jCWyFjanrK2CkzGSIrMGKXqoqabfaua9vA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 08:00:13 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0113.015; Wed, 17 Jun 2026
 08:00:12 +0000
Date: Wed, 17 Jun 2026 09:59:58 +0200
From: Andrea Righi <arighi@nvidia.com>
To: luoliang@kylinos.cn
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] tools/sched_ext: scx_flatcg: Fix inverted vtime delta
 accounting
Message-ID: <ajJT_hn9uGtlQnL0@gpd4>
References: <20260617064805.3901965-1-luoliang@kylinos.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617064805.3901965-1-luoliang@kylinos.cn>
X-ClientProxiedBy: MI1PEPF000008D2.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::432) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 558a98eb-c178-48cd-5ef1-08decc4675a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Vs2GRmPVPydfnhLjTrpP2KcIEc++2CLbkoaxuWD8voamLD28N4YX63IdbtmIe+Op+xTngvhEZ8228JX/No/8l113OK+C4FrHoNIvsDm00Yc+Vj2ZATNcBNTzE5p3FDwQkzVW/MK2JCLq8E+KZe2YIt0wcKNGLpb1aSapscdGVhlkBGMbxB6+gU+tgTQOWpfvzOIlgkj5wwQ5HMLM4nzgSLLUkwx3oBz5aIZ3nV+9T+dMyXtwhFx4nosHePRUgt+n3sR52VcODZz5BEgpq3orF63Qu3msuozqR09hWiSHnmaroD48TQUF/fGml73qrEm2jzJkU+s3v/Gk4b3nslnTC1U2W5lXNNt1UlYlTaAttI06WxazGfd7hG5UmvM9k4MKGWgvfW2g07E5YMZxR4vKASdxZXDrFi/jel3cLfi6cXTb3tIAtNxNt7qMLzwr+j9QqoQtHkdslwGGTSFfxMp6yuCc/5acz7g+okIOow7vHhw7tHLqqqkpICnspkscsdm//86Cb+muTsJb1riFwihRwrncdVg4i3o63p55L42hdyKejnq1QLzrWZtF6lB1VBk9R4BrR+D04y4UbF42p3cG/mCxGTSHNAQDxQN1OhLcbsED4AFm+ird/VxLAQ6Yx7jhD6Z4LAnmaOxTHU5P8jM7MYWwFgiopSzOBuMz7/4qv8FsF5o+tP7dXzLK8177h3bS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7uI72kEOGNqDRclCPVVTN+48W+MEfhhCR+tqajVcpNP8+WACO64VcuP1sHmo?=
 =?us-ascii?Q?1qyZt7p/IJ/VmJ64LTddC+ayE13E+zSK6OSqyPx0HoEjUhfUCejmrlRbysG1?=
 =?us-ascii?Q?vprlm/N7/4CKL78qEhEinOQF4Oajlvd+DH6XbxU4XD4KLa+aIuGF5Dxl9AFx?=
 =?us-ascii?Q?0GVSWIikzkuD05Zff9G97+Zi+dEpqMDiY8EQWaE2cPISyux+xQX7A+ke0oRH?=
 =?us-ascii?Q?XlFxAgOshmDyfDl9z6Ipdbu+MSjKuw17YCCoqa+WjupvOFwCMOgQvSCjtMs+?=
 =?us-ascii?Q?EAsQbEIwYOwpe2jwAVTgShc3HR5/FNNoj9xwgT0d3+d67+JoI43uq2CNICsr?=
 =?us-ascii?Q?YcseGfQxNA8u55+vVsWP7zPklYh4EEA58dUE6JoO1nkONpq+IzM18CIOu1QC?=
 =?us-ascii?Q?o/8vi2cJf7befRJ1tjlrIRrgVK+VIxuJJtifYTKxVwabR3cWj8M8OL0c6Dt0?=
 =?us-ascii?Q?Z9xYiBuKx9cjDbWTfsHrlPq3RTnxjICbVJJKm6/+MqlNaYKHnWrWAPCm2g7V?=
 =?us-ascii?Q?Wrbtb9A+1KOsU/jJIPPnojAzU46hDeNe7c7Wr0xC6oYE11sj0UKEee0AhRbe?=
 =?us-ascii?Q?MTIN5kwYjR94O2xp4paOzwlXBArb1ifwu/yLclCcQpSEJzThnsQ8BG09/6N7?=
 =?us-ascii?Q?OUn0EF5fp7uQ8BVgZ99/te3w//OhJxsUMOEXqSWEBms9UdhYOnH7IFjumi4g?=
 =?us-ascii?Q?udWXX/3rfE3iX6Ozz94aKzW7PTgaBcMFIgdRhZRtjcvnEVI9pXivFfzbXPR6?=
 =?us-ascii?Q?yINWfoMa5stGPHmBXbeh/821uOVfLhEENRv4BOcZBX6uRCkz3k4GVYR+ie1g?=
 =?us-ascii?Q?RTB06ofeyKfg4IPezIVUwfSYcs8eA7arp/MPrxp27b5ivPqrl//dbORzI6ZN?=
 =?us-ascii?Q?lMgGnjeb1WJobWzZPcQwJm+djNQsNcT0ndx0FcFM8WFROtzlJhx7gOlN4Hxn?=
 =?us-ascii?Q?9OmTlApgtbGxImEI3m35kyQ3jqAdVC81H0UmfTypWYqkfmcJsz/5jkbYkRrW?=
 =?us-ascii?Q?wErTEmLGeKTMALmS6SriiAou+/r83mBin0mkU6ToHz+N93uO/+g98YOJOvad?=
 =?us-ascii?Q?wpmwZW9XnDU2MGKKtrhzGPj8Y5WbEboGfY5kK30DI3pJ7i6r9cylJxI3N4Z7?=
 =?us-ascii?Q?p0SF4klGHNXeNfbxgxcmQKqY9V0sgOiMkn3FGnjRXbNObqz0ZuyxEujudMex?=
 =?us-ascii?Q?QxeacNJKqxuuWJpht+I+k54i8vvuU5/iOu0lO4ipTjNPYrf/8vLf8Xi3KW3A?=
 =?us-ascii?Q?rjuxc7WieV5lpdwwyEfDC4gT0VaGGZOIztv6H2aV8Dnk/H37eHXgyivlhgBV?=
 =?us-ascii?Q?DysCnZm6k1It1s6sAGEtIa7ILmQry/+UqM7V9wQMxdBPv7b2SBBEfxQ7ASgG?=
 =?us-ascii?Q?ycaSiiDujfWngVUOga8DBjfA9eJ0UQ4Gms11dhBNA+dMwsM79vgrZ4Os9XeO?=
 =?us-ascii?Q?p2PTOBd+5JJzUfSOkZo5mIRgWlU/ZoG/9uFRLiPDIG8IVUPDi98lvHzeqFi6?=
 =?us-ascii?Q?Yr2giqULd9erDQdWcwmDAp927Uom9KkROpZIBRxEQuBu3ZiXGTU3ZbyPChsj?=
 =?us-ascii?Q?u0dZag2QDh7xT14zNAgdrd1guDdia5RVcWnAVMxlyFaDzppoGMZ5tr7iZaCk?=
 =?us-ascii?Q?KqjG75OJk/3EpI/bEPEOtnQ4Es3fbdJyMi4MlLIl+2AbcE8zyHU/KWrtUNcl?=
 =?us-ascii?Q?MNw5FXZ5ICh9od8ZASgd/zCXY5VWPLQs5dIvlZnQXLDutTNN4RTGMFA34jjB?=
 =?us-ascii?Q?oOc5A51ZiA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558a98eb-c178-48cd-5ef1-08decc4675a5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 08:00:12.8809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fjyxIq7+Bz7f89nq67GzxlKaV+VD2C2Kg0j3YXYWU2Yqz6QVMU7zArquvka+LfOFpUjP5xSieXF/08g1hgFjAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798

Hi Liang,

On Wed, Jun 17, 2026 at 02:48:05PM +0800, luoliang@kylinos.cn wrote:
> From: Liang Luo <luoliang@kylinos.cn>
> 
> In try_pick_next_cgroup(), a cgroup is charged its full slice upfront.
> fcg_dispatch() is then supposed to refund the unused time by adding
> (expected_end - now) * FCG_HWEIGHT_ONE / hweight to cvtime_delta:
> 
>     __sync_fetch_and_add(&cgc->cvtime_delta,
>                          (cpuc->cur_at + cgrp_slice_ns - now) *
>                          FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));
> 
> However, if a cgroup yields early (expected_end > now), this adds a
> positive value to cvtime_delta, which ultimately increases cvtime,
> heavily penalizing the cgroup instead of refunding it.
> 
> Conversely, if a cgroup overuses its slice (now > expected_end), the
> unsigned subtraction underflows to a massive u64. When multiplied by
> FCG_HWEIGHT_ONE and divided by hweight via unsigned division, it
> yields an enormous positive number. Adding this huge value to
> cvtime_delta pushes the cgroup's virtual time roughly 3.25 days into
> the future, permanently starving it.
> 
> cgrp_cap_budget() later applies cvtime_delta to cvtime reading it as
> u64. Once dispatch can produce negative (refund) deltas, reading them
> as u64 turns every refund into a huge positive value with the same
> starving effect, so read and apply the delta as s64 and clamp the
> result at zero.
> 
> Order the time delta as (now - expected_end) so overruns are positive
> and early yields negative, and split the magnitude scaling by sign
> since BPF has no signed division.
> 
> Observed on a nested cgroup hierarchy under mixed CPU load: cvtime
> grew roughly 300x faster than wall-clock time, cvtime_delta reached
> 2^47..2^49, and tasks in cgroups stalled. After the change cvtime
> advances at the expected weight-scaled rate and no anomalous deltas
> appear.
> 
> Fixes: a4103eacc2ab ("sched_ext: Add a cgroup scheduler which uses flattened hierarchy")
> Signed-off-by: Liang Luo <luoliang@kylinos.cn>
> ---
>  tools/sched_ext/scx_flatcg.bpf.c | 37 ++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_flatcg.bpf.c b/tools/sched_ext/scx_flatcg.bpf.c
> index fec359581826..a37f5b876da8 100644
> --- a/tools/sched_ext/scx_flatcg.bpf.c
> +++ b/tools/sched_ext/scx_flatcg.bpf.c
> @@ -249,15 +249,26 @@ static void cgrp_refresh_hweight(struct cgroup *cgrp, struct fcg_cgrp_ctx *cgc)
>  
>  static void cgrp_cap_budget(struct cgv_node *cgv_node, struct fcg_cgrp_ctx *cgc)
>  {
> -	u64 delta, cvtime, max_budget;
> +	s64 delta;
> +	u64 cvtime, max_budget;
>  
>  	/*
>  	 * A node which is on the rbtree can't be pointed to from elsewhere yet
>  	 * and thus can't be updated and repositioned. Instead, we collect the
>  	 * vtime deltas separately and apply it asynchronously here.
>  	 */
> -	delta = __sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_delta);
> -	cvtime = cgv_node->cvtime + delta;
> +	delta = (s64)__sync_fetch_and_sub(&cgc->cvtime_delta, cgc->cvtime_delta);
> +	/*
> +	 * cvtime_delta may be negative (early-yield refund from fcg_dispatch()).
> +	 * Apply it in the signed domain and clamp the resulting cvtime at zero
> +	 * so that a refund larger than the accumulated cvtime doesn't roll the
> +	 * field negative.
> +	 */
> +	s64 vtime = (s64)cgv_node->cvtime + delta;
> +
> +	if (vtime < 0)
> +		vtime = 0;
> +	cvtime = (u64)vtime;
>  
>  	/*
>  	 * Allow a cgroup to carry the maximum budget proportional to its
> @@ -767,11 +778,25 @@ void BPF_STRUCT_OPS(fcg_dispatch, s32 cpu, struct task_struct *prev)
>  		 * We want to update the vtime delta and then look for the next
>  		 * cgroup to execute but the latter needs to be done in a loop
>  		 * and we can't keep the lock held. Oh well...
> +		 *
> +		 * Charge the overrun or refund the unused time. The original
> +		 * (cur_at + slice - now) was inverted: early yields were
> +		 * penalized and overruns underflowed. Use (now - (cur_at +
> +		 * slice)) so overruns are positive and early yields negative;
> +		 * split the magnitude scaling by sign since BPF has no signed
> +		 * division.
>  		 */
>  		bpf_spin_lock(&cgv_tree_lock);
> -		__sync_fetch_and_add(&cgc->cvtime_delta,
> -				     (cpuc->cur_at + cgrp_slice_ns - now) *
> -				     FCG_HWEIGHT_ONE / (cgc->hweight ?: 1));
> +		s64 excess = (s64)now - (s64)(cpuc->cur_at + cgrp_slice_ns);

Maybe we can do:

  u64 expected_end = cpuc->cur_at + cgrp_slice_ns;
  s64 excess = (s64)(now - expected_end);

using the typical kernel time-comparison idiom.

Other than that, looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> +		s64 delta;
> +
> +		if (excess > 0)
> +			delta = (s64)((u64)excess * FCG_HWEIGHT_ONE /
> +				      (cgc->hweight ?: 1));
> +		else
> +			delta = -(s64)((u64)-excess * FCG_HWEIGHT_ONE /
> +				       (cgc->hweight ?: 1));
> +		__sync_fetch_and_add(&cgc->cvtime_delta, delta);
>  		bpf_spin_unlock(&cgv_tree_lock);
>  	} else {
>  		stat_inc(FCG_STAT_CNS_GONE);
> -- 
> 2.43.0
> 
