Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012038.outbound.protection.outlook.com [52.101.53.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E041DDF0;
	Mon, 24 Aug 2026 14:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580733; cv=fail; b=EwR40PH69rljqkCn9p4b68u417HM+/DBsyGcaEqMzXb+31sGmIrKy7nKXTYzvO75E2MoTqC7dwYHMYTd5T9tb8VVmVPA70UaGBfoBrEnEGWOWT6izVhRxQc4E7keByvbNBug0U9hnt8PexcI9iAWmKUFvzvaWErdHGeAiZtmb3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580733; c=relaxed/simple;
	bh=SMVuzGvBHpravNfostXCv5x4PW0r+Q9fAlvOm9YMlGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YJV1T1nZt7KsIl21DeqLPa6A64gQqRsMP3xmvSq6Ut83PMj7uCdBqcoH+56TaCGk9IRc4h94P3gwe07L3KhlYs1rFWimTj7f8blNpTyPyiprzN1t6DLS+xMV6B88YHpAZRgbpkjctgZ1PK8tzkNx+s/j4cXKaDb83Afa06CVKn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AxjZkSoH; arc=fail smtp.client-ip=52.101.53.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AxjZkSoH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tgMMtr5zL1zri44jdtZTe/Bs12VCS3vSHGCl+yTskJhw6gi39Put8ZnesMg2CUnvEW2IA47QrccaAiuvpgyxLgrBvFCMzBq6kt/PhwR4ttBe0caCSkin3KLGdxledcaSuhc4y2mU/KVZ/0Zm0WNdmmF91G/X3mEJjnW+53OcWm1U8t9u1WL3rOalTodrqPz7GYjizex9mLj9goYY3+JVAGzeN+i6TQ4h3sML219CStmwHFmRoXHy17jrCFpebNlFK6rO1gBwnhg5uy+D9UdFXZ4s2Mg9ZtmAtxPKJo1UOwFt9/aRhnsxXyVaS9DhK4T1Vnb22GmslBy6/vsesJWrpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+tmGtowXpUi0h9uC/zshG9rzdXVg/YIKOUIy+U3jfI=;
 b=CcaZWiVb+ElzBeAapN1RIq9n01wF3sqesxEklQ4BqOlh4MFS/7E3KM4v9ojYq0igQ3YpqdmkHDpIoJ9wRduUQygKyl0tCOt6afRf4CTQqFj+Bg7IKJbD2bHacTkMl4BYtETFKLfg/tuhEzhWEIJVWf5hHlHUGZX4Z4l99B1pIRAzEOyWrKG7PCLJxP7cVpJn0S8L0hRMs4iUMGuDWiahxVhOKQtXcgyI37JFlyxdtyEM3vsW4geB5pLASGDkfKd5lQBH+bwc+tc4hN4TtN8PGtZMhwzyUIw2Ds1OkMs6V1MZtDLPTZD+LY7tWj+p15kAb9c2rlhB7vOvOHoWpgyxRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+tmGtowXpUi0h9uC/zshG9rzdXVg/YIKOUIy+U3jfI=;
 b=AxjZkSoH2VCMKbsPbiHYixI3XJ0OomHBr4syGZfBcO96ClviUQ0y1DTshZ7bI8HK03/p6IvDRI3GnnsfwJBfnsf3T2lbfGb7PlE1Dyyhh2GdLbcT38DVJNOSIy264uJg677G8yFMCDPCKLzy20Eb3xIpRYjZCibosP5YQFnfYU75uiu70UpBg8Wu/o5suQnrFraNKUucVOI+abCmQej0plr39KyolRZckA3lRRzGtp3h1nfOLcRC5TRIB76A3HE+I/++dH7e0xs/kRidBmX8FJX4O7L32i0dUish9S5DoxDQD4/6Td7JolKSP7MBY+c/fB7tpG9K+HzW6lNVlT3i7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 14:11:52 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 14:11:51 +0000
Date: Mon, 24 Aug 2026 16:11:43 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	suzhidao@xiaomi.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH] sched_ext: pass the initial cpu.idle state in
 scx_cgroup_init_args
Message-ID: <aoxRHw-Q5FCUX6zo@gpd4>
References: <20260824133954.561956-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824133954.561956-1-cui.tao@linux.dev>
X-ClientProxiedBy: MI3PEPF0000753C.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4d8) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 34f3086e-f40e-4da7-cdde-08df01e9a4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iEkV/aJPJUFP3VZDteQUwT4mPRqGpIiVf2godLTw+oYI1wksyOZC0ocCUrxnIpRz3k6e+0Ay8/J3tfjQmyipT+2XJANl/jTSvpbZNrliaJZK+RQwEGVEPjiZW8H7dihqJS/iXDcqXc+Dey0UssHc4q/MyauWbk/I/QxxrSeouj6vSpLlsoIsdWewbaFnpteCKXv5r0oablh9mZup1qzbVHpMVC0Xj3b7+CgtdGVT76BJocWWAXXY3k8LJtu+4VkIlfg6oyLANZUdCGaU8PTTM6bG4MX6lsGDH6AV4B1U3DKNEuPutz/gf3B/r5ck9E4XZPC9KpfSgtOATU0rIaO9kMWoGu483/ZeKdFjOzi1IYxcQawnqpPsQkhHvSWEwsD9Zkyn221BiG4hQIICPZuf1+dgGp1S2FAEcfE1ZiPaECgoJ/KApRQWdALzGmaRMO63f6r8ZNcyGVetI6LWdPQgUdEeEmtjK8EFn5frt5mcm6B16Bf8XFBF4obqdBsoz7xNX61VhZhj8pt9lQLici5/AhqvCGa6ZjpPT4+0GYpL9GZoyslAzz7TiIfm8qB750i9Ht4Ai3jNm7i8q5qCqZG5kUIMpLmAZfK8OGoIdyuQjBw5tqXhNuJLogDqHOve6ZXOzlL/ECt2CChpiLtSCmxxAuTgnEG2s6p5KEqjlt4+k8k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QsFduAkPaVvq0pS1A5Dgt0vvE/NHIWik9J6ks8xmcz3YxRIZWudR16kYNqDf?=
 =?us-ascii?Q?xFnzQZB9Umd2NIfeJmRKLbkJBKvOPKn+zTWfAWRWwbtw9i585xMrZYr55S4v?=
 =?us-ascii?Q?pmjmIzArjQO8HJHAgzzSmlsMoneuUY4nzE14BUyla+hFMmgH8OSMyZpy7riy?=
 =?us-ascii?Q?tASixobj4od+OCKv6wnXfEDUaZTEJCoIN7oz1pMHnIlEzHGOM8nE9iNXm0eM?=
 =?us-ascii?Q?dR9El0sZF5Z7Oa+3hPQWOZhXXlQ2ojwBkq7cLbkEG1DqO5k4k/tmhqbHPz+6?=
 =?us-ascii?Q?Mj9+jFwSkrv/gKsMafcO9xu6s7Km84mIfJFLrqwbQk+U8kJpNEIs9X8q9onI?=
 =?us-ascii?Q?BqW5+RFWi6bwVrX3+Nte3t1esqMnB05FhxEztwGNLwEBxvtLp+8IWntiaP+j?=
 =?us-ascii?Q?KMuHjet7kcCEhPf592mLtZHiWMg7pTywHf0ryvxTXZdNIoDtl2geJQ0WtLzW?=
 =?us-ascii?Q?TDKuKZTSPOoWu7SuzGPscnJ8LZwrfRCRncILKlFLg4JZeUAheTG23uE8wEiR?=
 =?us-ascii?Q?05xQOU2igjbcp0Pmng/N3vs54hNocgv3OCODvcJmVhEvw0F7UOdOmR8pBEYZ?=
 =?us-ascii?Q?3O1O5YxJkxJ9dT0hQo9CltGh2qQ9D+tjsK32mh5nUQ/TQEtW3cGXppk6dYwz?=
 =?us-ascii?Q?YAolweXfa/JfXS786rTtBXYNiIrkjDPMKYOmJzXBkbG6ohe9uIvvYnu8Ez0p?=
 =?us-ascii?Q?FfxuFxU2xBh8WEuX4BvenN4EBCIztUPXcgop9zLD62wt+KXhgkvH5ivMoyUV?=
 =?us-ascii?Q?E7+xo0pa+Gca+nqJ1R0EjACVIyBPoPE2SWO2A0tUc2pb+CDNAOTSOP7h1obg?=
 =?us-ascii?Q?eGTUgrEWMbB28bsVBZY2d1BeKQaABejGXcdZ+GyeQsbG7+kJbnofLtk41DM8?=
 =?us-ascii?Q?b+uNm2x/ZvG4T5UugmAImddYivtdmCI5eOG3STcUOZfE9xb2G5iYzLUmoMAa?=
 =?us-ascii?Q?1Hlh5jUFKb0vuxxkwLw7DUWTTTDtVSYx/Jg9tftqpDLm6EfJIjIGcN9Pd9jP?=
 =?us-ascii?Q?Tx0qHLqqkHt5TFu3lRNdYC4T8LLufBs2DbPpVTEY9j1DP3E3XpwIDcC8soEb?=
 =?us-ascii?Q?qGdu5ZruC7qIr7wlXIEgOSAWCMmR3kxB2iJReajcZFRvKjLWRn8pwFAgb4tK?=
 =?us-ascii?Q?67K2TOYb8z1oPiBEmaV+k7AIlhq0DkK4S00QJFlCVDPMVf7CEYb4sKc9xWLf?=
 =?us-ascii?Q?RYpmqxU+OKB4sIllWUpfVHpG1+JjdM23gbF79olRtJX5MsTi7uRd/5mH950r?=
 =?us-ascii?Q?lThGKka30XmYqvdQf395myxRBLs6RWL3JfRcpWyji5oPiQPntGj2ww0or+yG?=
 =?us-ascii?Q?qAJmYPF92HSI+B3+5oWUs9UxApfRXQq3jafd4M8u3aHQvAWEBkHDIqAbRvnC?=
 =?us-ascii?Q?p9y+7ninqVGi5jBXLiNu5ZUAWjPFiotETupVLvMPSVJFyC92tqSkn8oLAKKK?=
 =?us-ascii?Q?Y0CicKziyjXQJstNrGpiQUDpEKgq30vw+NMcCyE7ld9KxobeYefmkR5apFKD?=
 =?us-ascii?Q?cjh3+937QuHwymFrwAI9oO5GcjuXSksd4AYroVCi9Wuois+alCEcZKikNLMQ?=
 =?us-ascii?Q?qBvCoKohreaN4OpOR8B7Y2UiGPY1+mrpu/wvQJH+Z0VaGv3rAxFj8/Z2zIKS?=
 =?us-ascii?Q?OdUM/58bGVvLoENtsomdvAaMpeDoZTjpYzvA7nqdfOb9l8cYr/GSyXLetjth?=
 =?us-ascii?Q?54k8XO8uSAB4d9QPu1TO0WXwpmb04vgmSC91RDgDOypcVyFOLhVVGu5M1VKT?=
 =?us-ascii?Q?8HRSgZtDPQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34f3086e-f40e-4da7-cdde-08df01e9a4b3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 14:11:51.3436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhLUu3wp8XY1zlcLL4uR9Jc63Bo80B+H4AKmlfu2bElScXw5uv7nic97iuPw8KBoun45MMNTR7RFAEacf+JsiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354

Hi Tao,

On Mon, Aug 24, 2026 at 09:39:54PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> scx_cgroup_init_args carries the initial weight and bandwidth control
> parameters of a cgroup to ops.cgroup_init(), but not its cpu.idle
> state. A cgroup that was already configured idle before the scheduler
> was loaded (or before it was onlined under it) is presented as
> non-idle, and the BPF scheduler only learns about it if cpu.idle is
> written again later.
> 
> Add the idle state to scx_cgroup_init_args and fill it in both places
> that build the args -- scx_tg_online() for cgroups created under the
> scheduler and scx_cgroup_init() for cgroups that already exist when
> the scheduler is loaded.
> 
> Verified in a VM with a probe scheduler printing the init args: a
> cgroup configured cpu.idle=1 before loading shows idle=1 in
> ops.cgroup_init(), the default shows 0, and later cpu.idle writes
> still come through ops.cgroup_set_idle().
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  kernel/sched/ext/ext.c      | 4 +++-
>  kernel/sched/ext/internal.h | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)
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

It looks like there are two more places in kernel/sched/ext/sub.c,
scx_cgroup_claim_subtree() and scx_cgroup_return_subtree(), they should also
initialize idle. Otherwise the field defaults to false and an idle cgroup would
be presented as non-idle when it's handed to a sub-scheduler.

Thanks,
-Andrea
