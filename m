Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012063.outbound.protection.outlook.com [40.93.195.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F636B904;
	Mon, 24 Aug 2026 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584036; cv=fail; b=IUcdNhf3QQ5Y5s2c1zZdMxfeP8Zs8nVagRICCPx893W6EhDHqlup55AxzR173HRaBFY2tUsyPty2b5qHiM1GgNHs5pskoGxiIQVMagSBeNICv1Md2C76zUcD6tNgCtDAUnKy5YHRKiWb/UOg7tUk52hcbJKc6ZhtVnLsZY5kyGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584036; c=relaxed/simple;
	bh=kGkneR/XoMwsN3o32MdFoa8lN8816CciC/loYsnA8Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QRB9OvZ5QZRzX6CgSiZQC01qJ1mLCRSquK2QVo9kFYhDt6vOVZ68brrQjrrQonDB8NjTBQ0SitJx5KAmzDl4y6mVgQ/DUTHxjjWl8K0AlCNn0s5MjzqaldbCEq/bpsBHFPCKsMnCxlRqKg+gEibQpoK51bKiiWUrlLGmGfyKW/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BdfP6ZLJ; arc=fail smtp.client-ip=40.93.195.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BdfP6ZLJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jpRN7eoMRKWJ8GSrOs2S25YWalhimPwlIJLm+2z0CvhueXAgcCmJEo76a+dCw5r+fEniSNtC08a24047oGvUIbtaVqUcZwcmFAJU3K8qJcM8ToTKO5lo24j8Z3b4hl0gfrGIz7SP6gzegUOHfVM6X0XqdPSXVvgoMwPHF76DuN/YE6DBI35HI/kyjOYjnJ+SNurzygdqfLmn+WXqv6uoEy2oGGjcx0hNINdG2WbkXqSphklxy+Qsxi6gXpsOBEeU3xOfvyz3GM9K/aQ9fWwxI/eCV7pxAr07vZbi3bplH+Znx9xT6pposqV9V0zZnw1kR9f885xm5EqFmZyhT6+rsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7UBoruRny/0pQK2FaOxSFjPQRlOiAJSgBClxcni0ts=;
 b=Fre+v4sparYJ4nuQh60csJ2nT0d2RnLdl7artISgX5pFQBEp0DjSvFZUyoTu8WytShEye5CfLWIssgfzKXQA7e1o093jKjqSIzJZWGvScUEulkAAZXLWIhl47QAAPs2IPlXV9wrwqbh4bmNeuxLP3LUrsnf/zhTj81VHPinLiG4BdtBWd5xgaheCZUc+aceVHC0k+wB8tnR3d0Vlg6QYLAlXF7yAf5zJ0bAFuw7TEivKqLFKpN/I/avwyBHSTjNy3mpQC0BqReDNfx0fUgJUGoORLbq1ZqfbxqcbMLvKbefnwmWEwRMcbLZjdjTdvNAwgEP3MLV8cJw44XjeFqb5Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7UBoruRny/0pQK2FaOxSFjPQRlOiAJSgBClxcni0ts=;
 b=BdfP6ZLJBeh2035xKKr0doI1JWnJ6V8HdHsSDSFLRBWCBRTO9ltSNUDIGCI9IgaumQ5IscvgJ+1PCSvlSDsCoS8m3pp/J404foL9GB94KU814ed1hzUQNHC8Pfwsrs3lNf7+Bb7Jr+7OpTgOa7YOjIdOh0IcEewiDt062XQ7S9VIgerpNHoB8L+fkAW3t3qHL4SCt5Fjg3/sqwtSa9fsxNH8+sr7lVGSSTg72Th9uxn52AX0gMmy2jhPwUZE7+AN1N4i1fL0SSff9oGPHTaXwGt3HelcU5yfCUapwMAQ38EufrTLaoNSkndg7LLI5a3k16wchemd9qlxvqeeihdyuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA0PPFD4454CAA9.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 15:07:09 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 15:07:08 +0000
Date: Mon, 24 Aug 2026 17:07:04 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	suzhidao@xiaomi.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v2] sched_ext: pass the initial cpu.idle state in
 scx_cgroup_init_args
Message-ID: <aoxeGI-RsNj3nDKU@gpd4>
References: <20260824142817.568085-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824142817.568085-1-cui.tao@linux.dev>
X-ClientProxiedBy: MI3PEPF00007533.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4c5) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA0PPFD4454CAA9:EE_
X-MS-Office365-Filtering-Correlation-Id: 2814ea95-c76d-42c1-a263-08df01f15e07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	mc/Dj24rrcXHW3TPiziG6QYoVKgitH2zbMHhtZ5E+7D71hq4h+CuQW24Xhrn28Or0cH8qTCIpTBs5XGm7PTM/siCYBRNx2gfTcVkXZqd4G5bd0dSm1ybsDCKwa6nJFJvPs9WnVCWJUoCvBtT8XFuVmSce5xOKAMp2eph3lQRU1L0kC6QAxU5kHFW/HMuDnD4wf32YwXETDUd3OYsIIN/GSJYUG8poeE9jRz2L9C4na3SZk6/OD+Z6jTY6Er2WceGOifTRH4ooMV5/IidyRtderkrHZl64jOY+LOpTWjug7DKytEuJDkVpfJuZ31ixmSbs7nBp6tXW2B3pKm39f9AuLR8de2ZMVPKOqD0MaOUUnFVz8VgI9YqVv1gHnpSBF/OAFgn7H2Vg/eLe5kpvHtouWJB+87LRqlR7DU+G2jqhe7jWKqDsNOiBkp4SSnpANHk+5FGSCxGV6x9DlJH7pdqurg/9xvwuUk+Gd5jGBFNd+Oi9+yo6Wi59fm3GMbcv+9I3/5z0rELwEug8IktVK6juw/POAwaaE11Q8MRFb2hrO04bs1xbG6lxHs0FCVfXeUQeEyLDYgKeOVHSOvckUwT6B0tF+YhSP/dmS7V2piWG5iCxxAtHcIr2hkNlpXmdRlGGvxI1Druy4ihgEyC7HmU8+N69qTj7tD0kO/t2L53zLE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KUQftL7uIpHfkXSDJbqsS3AfK5ZGqu7j8GG9tYZaUnebY+hT6tl/Y/t/bR7g?=
 =?us-ascii?Q?dINdego9RV0/nNM0ugHj10ObCLi83KyQQ3f9d6FwRyzg5T03n3WHbaGVYNlJ?=
 =?us-ascii?Q?D4ObhgbLVb1Vt3xm8tqzIgYlWIlV7UgOAt/aKC+/OvqA6GJghjZ4lKrg3ams?=
 =?us-ascii?Q?QliAPvX8xHJrog93vSrWtiemF7085P+EuErbVgEcGEtowpUbMBq9qbXUuZdl?=
 =?us-ascii?Q?mQbf/WJZ6ZQOnG1szzXO3pJEMHWPOgSmj7dYdoaycOpOJ+rOaoYiHuBHLjkD?=
 =?us-ascii?Q?kZJXQA5B7xa5GKaG8tMsw5DMBoc948s5oV4OZd4zh+F1olQazLANjkVuf39e?=
 =?us-ascii?Q?TFsGZHLurBofkQgXffOGDBJKo6jZEhACyRxAao6/cH/BkRDzWn0615vWQEoQ?=
 =?us-ascii?Q?QtaMWBapoc4W3mgeFCyFwYCA0BZV1/S/8lcBMIyFpeRNZmtexv6YH21LW0Ji?=
 =?us-ascii?Q?iIFBFUdzBRD3qqE+9ZKM7pAuGcbD9aUiYQi3nk4tMoWNQbgE5LR8/bMh8kbF?=
 =?us-ascii?Q?wv6Y0JIAW9KW/ywk/qhVZzKZMrzjr8K+8grEBxyR+4iXYcJXHIfTX+5S/OF5?=
 =?us-ascii?Q?oEE0ujx8TKV8OWfoFpDckJAjXQl4pvixRYFnzdQvdea+Yceh+TcnWW1O/GBM?=
 =?us-ascii?Q?Uo9V1HXN+l9NZXBLfy+ffEW/91z8ZekvUvHVvoOF7f6wKsT1ovywJqldEHAS?=
 =?us-ascii?Q?DpwsewKKvCzeOPAPepU7XsMSYzBPOto2l0Lf7WFvsY+5YbNvCRKZ6MevPQ+2?=
 =?us-ascii?Q?YbIvmor8k5hK0AiAjsjlhQAJvN+XQbZdh7bIlw+jz+UrB7tPTQ7NDy6GDhfP?=
 =?us-ascii?Q?SKIjcaSaj6vzF+Re71tStownnir7dJiMFH9BMSx/rQHrAXnQgeGM1evQCAtN?=
 =?us-ascii?Q?pxfU5V/RFhRqwiBd3E3mbsKgPOvZjXbpSxhSrr1PrSQYC/tjCRgCD3dC1y3D?=
 =?us-ascii?Q?SPO8XxSS/Fqsdi7SmDBWn7XR9/ZYAaKAUyRrUDG/jRtjXmtxCxZ/UssCRj3L?=
 =?us-ascii?Q?r8T4UotK2SMpyQ2rI5RBD9970p5BAue12fafm+J7U+p0hFTl21pAs4SoO1Gb?=
 =?us-ascii?Q?dsJkzPX3zMjaF9DT15jLlqFODIhKw8ujA03hv+d0UwJtnJwcWzEezWZhk9fC?=
 =?us-ascii?Q?Lvmh3Uvr3q1q5yA1dcvO1zm2G0PTTppHTxSwGTt2jWGufYcO3hTnfO2A1UPv?=
 =?us-ascii?Q?uIwbHXsIYWgDb6VN9u5Lr5qSZpXoV85uGrIQB9EJLnhmv0DIPOeRtODDytZj?=
 =?us-ascii?Q?3i3XsZbHYpGQxfIotyo+EpR8NZctePopDINRy3DzrPCFAIJ97YnKXcBFMmlV?=
 =?us-ascii?Q?FjOCuj8HgmdQlVp8PNc0CfychNLHusfqQAqT8BDVdDB+Yq3jQ/lelKaQnGEq?=
 =?us-ascii?Q?VFmyTjO6M7IIEuH/OERIpz0ZFYSAykQrTs2ze+7BQZhUCNoYLF5kNIkk6iZc?=
 =?us-ascii?Q?uEkR8+JXjy4H81x1qmKPS0pM3PEx807V2QA4ITIY/pX2cJPf7OS4iF655PTx?=
 =?us-ascii?Q?3g6Ql5DQivDrcFh6IlIzjVi0nYFeNKxiHIR8QYRE+4ew5Gia2q3syo/QxKiI?=
 =?us-ascii?Q?7LYrUkipKEjXFheJ1gVu6VUCdqSmFdPxCPMDB17N2K6o7a07883XCVa64GFo?=
 =?us-ascii?Q?mx2dfQpiAsM5JKQ2bvL1C5ng5ilalljIsKjRcfvIdaujzOKnETSPJ2duMmKf?=
 =?us-ascii?Q?001vb9DRXXo9ouaZF1tTDC0lTkrFHegO9ItOkvJ4GvyloPwyC1Ry1Hr0Depj?=
 =?us-ascii?Q?gvF1TuUFRg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2814ea95-c76d-42c1-a263-08df01f15e07
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 15:07:08.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vEvgmL0O7/4CZraNs/6WB5Lu7HlQlfTSaDIWh2++itwej5typVfGvB4qB0s+noaHK7ocjVnlTJig/jfe7G0aKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD4454CAA9

Hi Tao,

On Mon, Aug 24, 2026 at 10:28:16PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> scx_cgroup_init_args carries the initial weight and bandwidth control
> parameters of a cgroup to ops.cgroup_init(), but not its cpu.idle
> state. A cgroup that was already configured idle before the scheduler
> was loaded (or before it was onlined under it) is presented as
> non-idle, and the BPF scheduler only learns about it if cpu.idle is
> written again later.
> 
> Add the idle state to scx_cgroup_init_args and fill it in all four
> places that build the args: scx_tg_online() for cgroups onlined under
> the scheduler, scx_cgroup_init() for cgroups that already exist when
> the scheduler is loaded, and the sub-scheduler handover paths
> scx_cgroup_claim_subtree() and scx_cgroup_return_subtree().
> 
> Verified in a VM with a probe scheduler printing the init args: a
> cgroup configured cpu.idle=1 before loading shows idle=1 in
> ops.cgroup_init(), the default shows 0, and later cpu.idle writes
> still come through ops.cgroup_set_idle(). The sub-scheduler paths
> are compile-tested only.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

We should probably add:

Fixes: 347ed2d566da ("sched/ext: Implement cgroup_set_idle() callback"

With that:

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
> v1 -> v2: Also fill .idle in the sub-scheduler handover paths in
> sub.c, scx_cgroup_claim_subtree() and scx_cgroup_return_subtree(),
> missed in v1 and pointed out by Andrea Righi and the sashiko AI
> review bot.
> 
> v1: https://lore.kernel.org/r/20260824133954.561956-1-cui.tao@linux.dev
> 
>  kernel/sched/ext/ext.c      | 4 +++-
>  kernel/sched/ext/internal.h | 3 +++
>  kernel/sched/ext/sub.c      | 2 ++
>  3 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index b646711a45fe..a7218314dcfb 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -4764,7 +4764,8 @@ int scx_tg_online(struct task_group *tg)
>  				{ .weight = tg->scx.weight,
>  				  .bw_period_us = tg->scx.bw_period_us,
>  				  .bw_quota_us = tg->scx.bw_quota_us,
> -				  .bw_burst_us = tg->scx.bw_burst_us };
> +				  .bw_burst_us = tg->scx.bw_burst_us,
> +				  .idle = tg->scx.idle };
>  
>  			ret = SCX_CALL_OP_RET(sch, cgroup_init,
>  					      NULL, tg->css.cgroup, &args);
> @@ -5185,6 +5186,7 @@ static int scx_cgroup_init(struct scx_sched *sch)
>  				.bw_period_us = tg->scx.bw_period_us,
>  				.bw_quota_us = tg->scx.bw_quota_us,
>  				.bw_burst_us = tg->scx.bw_burst_us,
> +				.idle = tg->scx.idle,
>  			};
>  
>  			ret = SCX_CALL_OP_RET(sch, cgroup_init, NULL, css->cgroup, &args);
> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index 53e136a47924..aa149a9c29f7 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -259,6 +259,9 @@ struct scx_cgroup_init_args {
>  	u64			bw_period_us;
>  	u64			bw_quota_us;
>  	u64			bw_burst_us;
> +
> +	/* whether the cgroup is configured idle via cpu.idle */
> +	bool			idle;
>  };
>  
>  enum scx_cpu_preempt_reason {
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index 0554448835bd..9701bd1d8ea0 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -1361,6 +1361,7 @@ static s32 scx_cgroup_claim_subtree(struct scx_sched *sch)
>  			.bw_period_us = tg->scx.bw_period_us,
>  			.bw_quota_us = tg->scx.bw_quota_us,
>  			.bw_burst_us = tg->scx.bw_burst_us,
> +			.idle = tg->scx.idle,
>  		};
>  
>  		if (tg->scx.sched != parent ||
> @@ -1464,6 +1465,7 @@ static void scx_cgroup_return_subtree(struct scx_sched *sch)
>  			.bw_period_us = tg->scx.bw_period_us,
>  			.bw_quota_us = tg->scx.bw_quota_us,
>  			.bw_burst_us = tg->scx.bw_burst_us,
> +			.idle = tg->scx.idle,
>  		};
>  
>  		/* the first pass must have transferred everything */
> -- 
> 2.43.0
> 
