Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0534C3DEFFB;
	Tue, 25 Aug 2026 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646434; cv=fail; b=bmYXcd2kyJl16gW0XOahNAbkBbzVpHiNbNLB1f48xDVoDZIDh2hpxqonXIQAt6f9XW9+uj7elLqamMWPFCScybiUk5tnC1nzZY0z7IHuvZZ6GH8jDUH+vdrjlEEd8LoIIMLTRWOSSnmCGaKhRwMBkJiGshUCtDlnZO+egoTHVtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646434; c=relaxed/simple;
	bh=vVe2utE5wSsNs1aNFcIswYtmA5AhdckmjlszekQWwDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WIcX+Ap0eQt9K7hlhFFrAlsaheIUWfZIkGS0oHVDTvYHicIjFyPO+oOg07SuQakawczd5Gn0k8oGsp1EeMqCSldk/EqIfKMK9OMjAesxPUWrvsqmNntnmeFL8WruMOM4ZWocSVyjn9tFGtAVz5hr9Qje9USXt6SratMwDtF43JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ph28Kcle; arc=fail smtp.client-ip=52.101.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ph28Kcle"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSkErfBljkR6BPyaLUqeYa17Bup/V5l7+CmbtPE4Hh81x11ne7RmAGFv4DE753ybwpROabcqKtp0oQTARQfCndzhfdecxSPlbQ6k79TR7p+tzhIF3EYurcxsewdj6OyYyYZx7A170rYAPMhe3u+oUP0viIWFkUWw+B2gQzEJy8Oyoab01SbqfPrTo9EzrUUTJvuBfWey5rwe8wyz5h+fgKjGKix3bpUWDyfK0UXOqcolGZJ+4Yqo+HSqmFQ5eLOvZMax/gOwT+cTloy/WSb9+lNve5vlVgA39l9/PZDAY7Uo6NfkM8zXOOAaJS+L6XaW8IjrQL12E1x8ayG3y2Jiiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GyjtDcrfNIKrwzjluJxIanIP8scQD6gmUTgIBlIsU/M=;
 b=JrtMOUD/wGMTCHZJdzS1yYDpC7XcwGcFkk/YigXImV5RTi4GUVIKTUH8lsX7szNlGoM5mFTvyG8xt4PKrQwbB4ihc8rJMO3nO5C/95gkOAYFZXgZBKroFtcuS0d6VMzPSH/60o4xN9hGFv1sWVlUMOy9IvlxvqkGssyR5gBl6P+UaYTiux1brdwHJJdGKsHwKC/lsyzhFJ83IKDkrWl5fC+sRcyE6w7+nqT1Gv9jIW1uHN6D6BG5JLRVjVbN2JObxRbvx2HSdzhTY5k2QOqQaEjSlKPtvOV64wXohtLBktA+vFedBkr8vcNfmGVp9xaw3ocQb05+nwKanbog23IVFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GyjtDcrfNIKrwzjluJxIanIP8scQD6gmUTgIBlIsU/M=;
 b=ph28Kcle2glRHHIGN7p/eSHo35EZy9ftDX9oGFfcl6gwkRXhJhyosttKyFGuQC2JHWGpj5v2pB1TQ7PZGYJxz2WdhHhfQIxBf3c0o8uY1OK+0TSq/M98fWPTwPfhiCwQL96HWptv000Qj2MAOkTaodIwDScf8gR+E5gRCxX5FSa3B05LGqWJXMAX8LZDdF0oes5MFeImSeE3jbBgeVeZwX4h5v1DbRKyYzu1Rh5LPphMDVqL6HUFvwka2DTUDn7TSCwCCeP7uC75ZtauTirhlpqYy/Ni2Di5mniWutM+DXyTr+TehXI45wGaHFfPWVOSK/BePdScbMiiFyLBpjH79w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 08:27:09 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 08:27:08 +0000
Date: Tue, 25 Aug 2026 10:27:03 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	michalblk@google.com, suzhidao@xiaomi.com,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH] sched_ext: Allow ops.cgroup_set_weight/idle() to be
 sleepable
Message-ID: <ao1R11aGRZH9hE5f@gpd4>
References: <20260825052336.46746-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825052336.46746-1-cui.tao@linux.dev>
X-ClientProxiedBy: MI3PEPF00004E9F.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::451) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e5bef82-d601-49ca-5672-08df0282a714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|10067099003|6133799003|11063799006|22082099003|18002099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	r6UKmiq5Zwkvp1EJSZZdtcprNauPLGcbB6ePuXifzDpkniXtTOSu2AJrIKhMm2QVe83qnodOqDfEi5NHc1UDBPi3gpGUfRWHGru6gJqzpYP99tGEkWLzc5tdsfdtT7MpwK9F6CAuR42axZ/2RKxhOptPauXHQLIcFEW0SG/ZJ3Hkkhi8QrrRZjLsXX9iZTCNcfxVHAzT529P5ALaGHiPwDlbHGfPt2QLn9Qqbw2DX86sDIRSrCM5oacjlr+kAbV6GITrQFSUgY4a3oz0roGUDhftXU68tx3DXcF5M0C8+kX5Qhrg7ROEXfUQ9g/NfRgWxA44eavKa/YMg5nGB3pkAnVeqLWwCbgGw2uYHga73/9zuDWgka8mqxa4kwJNAO8IO0O4ckJ5x1cc1BR0mbqFYBcJgWYLjKCkYIQA2iJ//PbY7CvA8JWqUK8DFqM/97ky5ZzbLUQptHS0V+MhjLPf8PEno57NhYZHgzy49tgwtgl226Hnn4t/O/i/tKlHgoWSWLp0HRpCOptN3+dvfkbwYPT+x0n8PkHgrVL6xnHO/hPS77woRuFUrY8Mhwd1K39HKbyKwX7gDrQB+k4KawfdY90o04bWAtM8U3QHGpcxgdkW0UrEvLH8or4/SqO9IOI+2brZSIkQ5QgscNY7F43p524efxKn7IpoFR7dbSzjPcg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(10067099003)(6133799003)(11063799006)(22082099003)(18002099003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?otTQgjt7W0R62EtfQu5OqcbEbvL7TiSeyWxDgQXRLsRP+bxm5PkYhgigZDYM?=
 =?us-ascii?Q?P5AbTJVN9ErRqJdG+fNljADD5O6JVHttAX0XaOrOMqhEMUEZEejdFYXec6bM?=
 =?us-ascii?Q?/sAsN0gu5i9Ql4rAar+dEjq9TXUO9V9dfkSiQJjdtpfOyQqKLjxRmkbFoEvQ?=
 =?us-ascii?Q?PuK/Vvrku8zsdFITwNTO/NkRpxlxHdek642SxQQ6OFBPwGh6frQbokvy3wG0?=
 =?us-ascii?Q?ZOZY1AllK8bpjHbKfmUbuhD5WC+3F+xdzVoW8u3P1CzMFc40Xfv7g62hSCQ3?=
 =?us-ascii?Q?viR3zuLJEBF/3JUa+bkbbiSnlCLWNWckgOClCcbxA0QVHRC7LEe2cq5SYxEV?=
 =?us-ascii?Q?xC8dJwGDstzmcgZoG20CYZvODQTTl3iC5lgk/faJgLW4OiFXdaTq9Xn6HIWJ?=
 =?us-ascii?Q?JdNssp2+GX6iLF9AMNClIi5zY8LA0yRkkmr7fabg+plaKVL2/BwdY5UVECK2?=
 =?us-ascii?Q?4jrEVex1fvb+J2WI80+Cqyn+hgzEE6pyIDoOYFDkhW0zzVYdPqnEDARVABfx?=
 =?us-ascii?Q?UXN1zH4nTFHSIcd1mTgYh3J2//wO1BMa4jcfnt26cPBEbuZQ2x0mNM5ZeTyO?=
 =?us-ascii?Q?g4kgY1/3apdOlfFCwtzVkH86ljAkDgmpVDrHkGvFjVLi3XLl8l8RH3E70oPp?=
 =?us-ascii?Q?jMaUF0VakfF6hSWwigK95eDGi6867tGT370NVx/CC+PeSDX+ujt/netCtOEz?=
 =?us-ascii?Q?nvgiyAn+bXlGLxO77cVmeyKJ82EaDVtvGIPAuxej505Kqg3ReHJj1fkfEaF+?=
 =?us-ascii?Q?/F2kOcgWCsanpUJfBdWl2STr9rQMZpJfFLth5AzVZekDfNVsna+HzW/fo6uJ?=
 =?us-ascii?Q?rqLoBoBWd4DGg363ImJhuMneLsJkLerbY9zX8dlNmVG+wie1veficNrWNyeF?=
 =?us-ascii?Q?HbLEKiIUBiLki09pUIPXTUay7ifFZ8uhsE4CT3p4H5IzukpGUI0FVj7kWHKb?=
 =?us-ascii?Q?rXEYX4b+jGVo536E40UvoWTptZTxumkBLBTiixGdoUAcwJSjWlHBxWyCe3/q?=
 =?us-ascii?Q?xoqJGDjyhYcDTEU4eOhKAqUtd7LmRFbzhpGh1hoDl+Gfz19jHjjDRGmplxxc?=
 =?us-ascii?Q?JhAkWsV9lR4XAXJUxLcDDOscggINiDJtQE1FuSInObpwpGSPxYYCIHrFKF7/?=
 =?us-ascii?Q?IvZV5p87HvLtQ1kt3wMpCWRKhsktz9qfMN3xevcg81HVQ7rqMNvUntNS94N2?=
 =?us-ascii?Q?mRdLseT7KlyH8fBcuM/x9SgQDd0q/VbbQL14+DngfOMkRWBLlzKuCjL/gahJ?=
 =?us-ascii?Q?tMbKS37SmmTu1xlxouYAAY7icD5UGiLZH4O0IXH8RvwEmnajHRMNLP0oFBt/?=
 =?us-ascii?Q?AEzAjUdSFpMxTFu5yCw8mCHRMT9JYrPYy3JimFGfMY8lT1tab+1tYEyxNv6b?=
 =?us-ascii?Q?sQYBKbmx3pCzuZ5xo3YiW/LtIxw2uROJff9e9Wnjm3lm8Ply1F9uaC33Sp8o?=
 =?us-ascii?Q?v8n/B+/FaQy/Ob/mMTymgmrRxBV+yr7jS1xvgVdJezs/oJIgqJ2orUNzubN7?=
 =?us-ascii?Q?5Wck9s9aG2cP/HZwr/HGU9HKFAQigEujxBTUXka5+l7QJmlH2r1Z4wVqXV+c?=
 =?us-ascii?Q?ZGmcaSW45CEsVvAQW2VjGSWeKLGiiSq09LIVqXflYk7skfFi9247unpt2x3v?=
 =?us-ascii?Q?ZTnvYbNel7kJjpwqteZwgB1BABGIC/y+7kDJ7+fl0wis8KmI7le2fCJrIwXK?=
 =?us-ascii?Q?wJMKLrKZchnZuJvOjUBYdSmF+lPpepNgRZu6yj03Knbbo4IZEoUQAj02McvC?=
 =?us-ascii?Q?qICCC5fbRg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5bef82-d601-49ca-5672-08df0282a714
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:27:08.4818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZFIESVA3HUZ5Y4RpI/Gf89dxoDJVNOqrzWGVour6+ZpndNwXxY9FWYOza/goF3dmSB4NzHtZ8I7EVos4vHxQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118

Hi Tao,

On Tue, Aug 25, 2026 at 01:23:36PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> ops.cgroup_set_weight() and ops.cgroup_set_idle() are delivered from
> scx_group_set_weight() and scx_group_set_idle(), which run from the
> cpu.weight (and v1 cpu.shares) and cpu.idle cgroup interface write paths
> in process context. Both hold percpu_down_read(&scx_cgroup_ops_rwsem),
> whose read side may sleep. The call sites are therefore sleepable, like
> ops.cgroup_set_bandwidth(), which was recently added to the sleepable
> allow-list.

The change itself makes sense, but I think the serialization issue pointed out
by sashiko is valid. Concurrent cgroup knob updates can complete their sched_ext
notifications out of order, potentially leaving the core scheduler and BPF
scheduler with inconsistent state.

We should probably address the race first. I may have a fix and will post it
shortly (testing right now). Then we can apply this sleepable callback change on
top.

> 
> bpf_scx_check_member() rejects a sleepable program on any member not on
> its allow-list, so a BPF scheduler cannot allocate -- which is sleepable
> -- when a cgroup's weight or idle state changes at runtime. Add
> cgroup_set_weight() and cgroup_set_idle() to the allow-list so these
> callbacks can allocate on demand, and document that they may block.
> 
> Also add the matching compatibility markers, so userspace can detect
> this support via BTF, mirroring
> scx_compat_marker_cgroup_set_bandwidth_may_sleep().
> 
> To size the alternative, a scheduler that gives each cgroup a
> dedicated idle DSQ must create it in ops.cgroup_init() for every
> cgroup up front. In a VM with 2000 cgroups that is 2000+ standing
> DSQs, each a struct scx_dispatch_q plus a per-CPU area. With the
> allow-list entries the same scheduler can create the DSQ lazily on
> the first cpu.idle=1 write of a cgroup: 4 allocations for the 4
> cgroups marked idle at runtime, and repeated cpu.idle writes do not re-allocate. Verified with a probe scheduler on an
> unpatched kernel (load rejected with -EINVAL) and on a patched one.

nit: this paragraph needs a rewrapping (line too long).

Besides rewrapping, could we simplify this part and rephrase it in terms of DSQs
rather than allocations? For example (something along these lines):

  Without this support, a scheduler that uses a dedicated idle DSQ for each
  cgroup must create it eagerly from ops.cgroup_init(). With a sleepable
  ops.cgroup_set_idle() callback, it can instead create the DSQ
  lazily when the cgroup is first marked idle, avoiding unnecessary DSQs
  for cgroups that never use cpu.idle.

Thanks,
-Andrea

> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  kernel/sched/ext/ext.c      | 18 ++++++++++++++++++
>  kernel/sched/ext/internal.h |  9 +++++----
>  2 files changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index b646711a45fe..53b888f5a6c5 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -8079,7 +8079,9 @@ static int bpf_scx_check_member(const struct btf_type *t,
>  	case offsetof(struct sched_ext_ops, cgroup_init):
>  	case offsetof(struct sched_ext_ops, cgroup_exit):
>  	case offsetof(struct sched_ext_ops, cgroup_prep_move):
> +	case offsetof(struct sched_ext_ops, cgroup_set_weight):
>  	case offsetof(struct sched_ext_ops, cgroup_set_bandwidth):
> +	case offsetof(struct sched_ext_ops, cgroup_set_idle):
>  #endif
>  	case offsetof(struct sched_ext_ops, cpu_online):
>  	case offsetof(struct sched_ext_ops, cpu_offline):
> @@ -11055,3 +11057,19 @@ __initcall(scx_init);
>  #ifdef CONFIG_EXT_GROUP_SCHED
>  DEFINE_SCX_COMPAT_MARKER(cgroup_set_bandwidth_may_sleep);
>  #endif	/* CONFIG_EXT_GROUP_SCHED */
> +
> +/*
> + * scx_compat_marker_cgroup_set_weight_may_sleep: advertises that
> + * ops.cgroup_set_weight() may be implemented as a sleepable callback.
> + */
> +#ifdef CONFIG_EXT_GROUP_SCHED
> +DEFINE_SCX_COMPAT_MARKER(cgroup_set_weight_may_sleep);
> +#endif	/* CONFIG_EXT_GROUP_SCHED */
> +
> +/*
> + * scx_compat_marker_cgroup_set_idle_may_sleep: advertises that
> + * ops.cgroup_set_idle() may be implemented as a sleepable callback.
> + */
> +#ifdef CONFIG_EXT_GROUP_SCHED
> +DEFINE_SCX_COMPAT_MARKER(cgroup_set_idle_may_sleep);
> +#endif	/* CONFIG_EXT_GROUP_SCHED */
> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index 53e136a47924..f81d03de2d3c 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -736,7 +736,7 @@ struct sched_ext_ops {
>  	 * @cgrp: cgroup whose weight is being updated
>  	 * @weight: new weight [1..10000]
>  	 *
> -	 * Update @cgrp's weight to @weight.
> +	 * Update @cgrp's weight to @weight. This operation may block.
>  	 *
>  	 * Knobs of a cgroup belong to the parent, so the set_* ops are
>  	 * delivered to @cgrp's parent's sched. That sched may never have seen
> @@ -773,9 +773,10 @@ struct sched_ext_ops {
>  	 * @cgrp: cgroup whose idle state is being updated
>  	 * @idle: whether the cgroup is entering or exiting idle state
>  	 *
> -	 * Update @cgrp's idle state to @idle. This callback is invoked when
> -	 * a cgroup transitions between idle and non-idle states, allowing the
> -	 * BPF scheduler to adjust its behavior accordingly.
> +	 * Update @cgrp's idle state to @idle. This operation may block. This
> +	 * callback is invoked when a cgroup transitions between idle and
> +	 * non-idle states, allowing the BPF scheduler to adjust its behavior
> +	 * accordingly.
>  	 *
>  	 * Delivery follows the same rule as cgroup_set_weight().
>  	 */
> -- 
> 2.43.0
> 
