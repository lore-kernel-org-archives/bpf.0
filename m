Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013060.outbound.protection.outlook.com [40.107.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406C845D1A8;
	Tue,  1 Sep 2026 07:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247581; cv=fail; b=tMRLILeqyHh+uMau7hlohts86e4cx6iBdqV+X/pEyb+LXN1pfp0YHYTCHG4WRvpkCsC4D40KGOXd25ffieO0sEWi1HaSD4lkiAFalPoWtsZTjxJA+JNrwUrzKlbCJ7lfCwvRZki+1s+dP7dAp3J2SBqqe1+ETRbufUYxdrY5xqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247581; c=relaxed/simple;
	bh=NOnK3M+Iy1e4zyql5BkHhV7ho+98Ux4ToPeogJVxbC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=usUnCyIqPVlp7pBpWLG7e3pT8kk9p1owlOw4d/HLJ70o3dT2gzKPxv/v/NOpHOFfIakYZmFpqDyIPZK54lLgRtbh3YxO5/bRgGGBKcJw3jymySsu9RpUsl1wGweJcVD1nSVcdZ29pfGbKx0zXK9pcie/purodFBTsJcTZUXF+dU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nTwmVr7p; arc=fail smtp.client-ip=40.107.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nTwmVr7p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pO2RPrPIy7ILdweHPu9uJtlhj0g+5ubs7a19G5n/fRPzRCsAe0id8SGmrCap/rxixtes+8mgh+MWzi5s1k5HVbQ219ewXw5p2z70fQwl753vf0dIU1dVeceT0eLBh49/SHVW4uySyTCLvgW7mkFuYwg0EFRIaU6iLTuD95Lld7HOMSvTxQajYRqs3SIyZB9OP9yHaWRBNx+HDRneDE06MwAB77RfFNWb7w+Q4uQLPR6SmyM6XDeA7S8+pl0GA7jAwvol16cxYKYO66OgLd+lWBAmup1wB5Ir3V7UffvZyOiktOwb/rn8YIITNR+RwTRyT4jJHitVLNIcPaf2jNlRxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jd/9LaxDKAn5uxug7kqxMcr9cItQ1AI1hhuWqoy2icw=;
 b=h1OY1z6SgRovrTP39GxlVttF1m9zOk//NOeYleiNbHQKrYEvPs2MhrS4zRzFTDXF/uxl1VkGSVXysS7hkONoQALsZqv+VjnUaFjqUg8C33uiPQ42EPPirQqn9VtSbH4upOOStraUxGbl2N5UuoD7xqG8S0s7A71A4OW0xS6geRXlqaw5sZdIl/cFzwU/0WH/p5UPhoGORRBSsbR4uSzjyQZYFFVRuPaqsqru8bxRR5vBVhnxqAq3PNcxz5OCoVC39q6lgYmmneYxH0K1q4AUx7WrEm1niCj3ZomfMNfSkiYRj3RoLeCAh4A6yaz9k3HKIkwAZ+VLMED2UnSjARFUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jd/9LaxDKAn5uxug7kqxMcr9cItQ1AI1hhuWqoy2icw=;
 b=nTwmVr7pfN9jKzJK8aSyQVzy1oDgkh3V1MXT+ZZpXXT9tSIX8knKhK9U6RrysWhuJY1VCMdztOTx4ceZGGNaeY4pRXbm9f4rgy/ylcOKmCsAPAQzsFnQ0AXrdcnnYTlyjslObO8900oMnO/eClK/8rXOxqL1Ixt+JoMhzzRi2XlD/fa8evAKcFlnteRpsV4rxuipsr49uoofsz7CD7VmDG2oNBlwm8ye2gPGLg7tDY3r/qxKhnCbhFBTH5OEesqXMwZC2+cDcdUHOvAH+WoLEd4RNyn0lB1WPsL8XYnotVauXYpIedh6xsS5+mWj26D6DVIUfNIFUFN6KoE2PMxY4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Tue, 1 Sep 2026
 07:26:12 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 07:26:11 +0000
Date: Tue, 1 Sep 2026 09:25:59 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	michalblk@google.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH] sched_ext: don't deliver duplicate ops.cgroup_set_idle()
 for same value
Message-ID: <apZ-B__OiVcZW46Z@gpd4>
References: <20260901031101.731943-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901031101.731943-1-cui.tao@linux.dev>
X-ClientProxiedBy: MI3PEPF00004E9C.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::458) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ2PR12MB8739:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c5308c-bdf7-4dda-9aa7-08df07fa4c61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|10067099003|11063799006|5023799004|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	y3OpbovqfUEx4EolwsMsulPiEtQNE525Yfkh5mK58NGBoOAjMMoKD7vfFeHssLzWLgiOG850AB4YyFj7zXtjjlqW04RjrBbEQm+0Lzq8Y7efMeRfOp2q8eueY7l5KW43b++3WGEfuTUUKidr6tFMur4ocyuaKQI64HMZr5N9Xk9Sx/yqV8fjK3fbE1WWnQ7XUo7p1CZ93isONwXJYiTlr55+RJeRX70EFbcsHlWjqS62ldn0PqRWl943ftEM/E8suheFgYmEAcRjawYfMj6DMXZ5pT9Hu5mE7qbOtNU42wFXBQ8nBZyExI/uxbm4WNg4+6EyLnX5icwH9iyzB8sBtLRR9gbscE9x4RcS58KkXavBsfXABHBVOxPMW4NfusuwTbMJcjBntdv19CR72s6lLbsj7wohB7LGUkRuBf/HfbUwwhT80ABgWp7iuGjsFyaHEsTU5wYr4F7v5EdvxYXBielLmF/RjKcljMWAwCzQTx3A2z+CllGh83SlU5FuBy0DhfNyUWHqfZgJvI/NVV8Uz5JxYWIC3LZBu2jJwlnRjL7Cp1U8SxTVUJi2/6JdhtoVvPOSqvpgHjIY87noZt4x6ige1If9KfF19Hz66cBCXRmkaxFMr8UJE6G3PiipOj+a4K3807RrMqkEYWdEJlFUydaXu+NPi9eHzGkYGJya9Kk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(5023799004)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?obeUsOTYfOqAt5CVTNDszIqTiGPklYIAifG9Zo+5U0jMMKBabkNtd/3ejbt6?=
 =?us-ascii?Q?Hhso2MR9rZK+DHIL82QcB/ImS83RLy91F6ahaWrBV8jixmcQAmiGcsTzkmjO?=
 =?us-ascii?Q?nh8lCx1KhARcMGOSkyvGb8pkkXd5lvx4+8Fc95JZfxXBT7+bMmGcCUME9MCo?=
 =?us-ascii?Q?kpO7w/rkmzC3qU9+37qw+NvmPFIG4UH4SnC2aMgFeGCM03V+NHTgGs7+uti7?=
 =?us-ascii?Q?lwf//b8lImCGwU89McR5aokD/C2p5phLWPiOJhzuTp7ueg9cl8WJk2+bD9vo?=
 =?us-ascii?Q?YpfK988ltuQRhiaET8UiDonpqyIxI46n8ptGAihcQUc8gbq/7RcRSJAkqpmZ?=
 =?us-ascii?Q?4xADcyJNekm2EczORBCqx6AiIW4khkUy2BWo94onp4S/Zm0+wk8qgYK/Tipf?=
 =?us-ascii?Q?CA+mbWMEEtIhp4KjIUCS7ivygTJYnB4CC4idX2sSV0K6aJt+5AivMcpWPBDq?=
 =?us-ascii?Q?bE6Fnwlvq/ZDcIdiYufH497Rclf+kqRQkpod71RZuunQoxpOOfDcdN+2p/Hn?=
 =?us-ascii?Q?6RH5DEBLvL5EpjgnJIiTQp9Xdi5PJ0uUx9irS33H77StetNfCjI25L9BYXVD?=
 =?us-ascii?Q?WeWED7FwiKTPPH1BkFNgCDqn09jaiV5OfNOOkci5NK27kN/WEcdSmoHXuvrr?=
 =?us-ascii?Q?icNIJdooAFAorm100xP194wD3VtGj8eDyM9Qu5GqoagjAxFwo586FpVvNnQm?=
 =?us-ascii?Q?8dnuaaEcUcMTUprM4DYy45GpjrIGk75OGlGacunibOlx2vsg1tnafc++bNoq?=
 =?us-ascii?Q?lC/ZUVUjfeNr8JFHm4G83eT9x0P+cjPV2GadLGj5ESzGtzqJFf8br40/VpAC?=
 =?us-ascii?Q?r19ArYI8h9U/Fwnkl95PecVGjg9WIuRO5BpLOUEGp5m/ZnPcqqiCu1RlxrgG?=
 =?us-ascii?Q?YClIFrERp1owSDOrsJ8Qa1Fk065V3G5RfNm7ewiQEPipYjK1NSwcMk+7q43X?=
 =?us-ascii?Q?1iF0n8clWR+EQJzoDTDZgz6nbNt4MAdKX3DSo+0tRAW++fw+Yhs/oyJ9GAqH?=
 =?us-ascii?Q?ij6tbZzfNAi/1XWeJhFU5sO9Ye9PtpXwhDDz5am2EAjmU5B3EToUXt8LfNVV?=
 =?us-ascii?Q?0TTtOzgp/GyL/Jghptx2eOfgIXhAVSaJvAK5264dFj3/n05BlBQT1KXHI7bu?=
 =?us-ascii?Q?ywXNLCJthY3gwVR7dOo1f572XSmGRaQxzxRBXY/eYwxo635TjWh/W4Uuh79I?=
 =?us-ascii?Q?0b/u04rz0eDLdfuC346GVbFKntkbylng1fZ//scx/3s3kt51a89LptUR5IlX?=
 =?us-ascii?Q?h49M7LVitO+RjkFpWEcJbFd39zzo6rYBhCJkQoRvqkpZQ+Q7SEyLuyO8/GCg?=
 =?us-ascii?Q?So5E7sjG9lhvy0HC6+pkGaQjiMS6t9TLs6Bdq0U+690vM6U0KE0CBzhkhsj3?=
 =?us-ascii?Q?oNvNtedOhoMqY93iX1wTBM1iTiyVLybIHCQFmd3IZ9ThBSikX1f4rj291r95?=
 =?us-ascii?Q?oamO38h3cYcN/IfkU+IiHTm/mAUqp6ZsaiJljyosSm03d0r+wzdx9FocY5D5?=
 =?us-ascii?Q?QXi18FsAAA/X1KEZjxtiBUG8wWgiDVnvRXdpdJYv3TbTrfBD8368QmuUJhlG?=
 =?us-ascii?Q?7QnPXQJ0J85L97z0iwiSFiY1c9/9la7BKkBFyXDkwdfj9CsOdKZu03bXpvJ3?=
 =?us-ascii?Q?lt7GCZdkbzQwSbKHw84NKJ43Y6PRfddonUT9YmOLLoCfmW2DPRFM9KCESIV/?=
 =?us-ascii?Q?BjSbzQQlqFJ4MDrNRekU5g2SRxqY3FC6qg3n2Vi+bmZ3sVujHSbdjrjIFd+Q?=
 =?us-ascii?Q?n2+qimP+OQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c5308c-bdf7-4dda-9aa7-08df07fa4c61
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 07:26:11.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SQHxPrtIU/W8lQqKfyBt7kL2frHzwSDN512qCwtPSOtcmjMHW5k9nuRN9RjgChFxFHZUiLtYz+HIt1un7eZcug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8739

Hi Tao,

On Tue, Sep 01, 2026 at 11:11:01AM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> ops.cgroup_set_idle() is documented to be invoked when a cgroup
> transitions between idle and non-idle states, and scx_group_set_weight()
> already skips value-preserving writes. scx_group_set_idle() delivers
> every write unconditionally, so rewriting an already-correct cpu.idle
> value feeds the BPF scheduler a transition callback each time, which
> toggle- or accounting-based schedulers miscount. Mirror the weight
> guard and only deliver on an actual change.
> 
> Verified with a probe scheduler printing each callback: rewriting
> cpu.idle=1 twice on an already-idle cgroup delivered two callbacks
> before and none after.
> 
> Fixes: 347ed2d566da ("sched/ext: Implement cgroup_set_idle() callback")
> Link: https://lore.kernel.org/r/b53c61a1-4d7d-4232-941f-d48b0563d4ed

This link seems broken, I think the right one is:

Link: https://lore.kernel.org/r/b53c61a1-4d7d-4232-941f-d48b0563d4ed@linux.dev

> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

Other than that looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/ext/ext.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 8041c87a3562..8b3625107b72 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -4933,7 +4933,8 @@ void scx_group_set_idle(struct task_group *tg, bool idle)
>  	percpu_down_read(&scx_cgroup_ops_rwsem);
>  	sch = scx_tg_knob_sched(tg);
>  
> -	if (scx_cgroup_enabled && sch && SCX_HAS_OP(sch, cgroup_set_idle))
> +	if (scx_cgroup_enabled && sch && SCX_HAS_OP(sch, cgroup_set_idle) &&
> +	    tg->scx.sched_idle != idle)
>  		SCX_CALL_OP(sch, cgroup_set_idle, NULL, tg_cgrp(tg), idle);
>  
>  	/* Update the task group's idle state */
> -- 
> 2.43.0
> 
