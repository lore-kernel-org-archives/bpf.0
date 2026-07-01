Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012058.outbound.protection.outlook.com [40.107.209.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC67B3630A5;
	Wed,  1 Jul 2026 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924474; cv=fail; b=UUHPd+OCzfzKLADMVrHNK1NV1DE5Hp8/7bDyHiGxwPWmj989PjainpjGYlNxn5Zuq9mJrBlnm/j6kHy3/J4RyG7/XejUsgL6+mhfJuEAsY9Vhk0JZGvXb1BeJ5PL96V576T9dMMJcQh7HOdXeavuUK+iNaJAZR/MGuNGfmaWK2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924474; c=relaxed/simple;
	bh=dk/5Y3Wa9hmoXQtJhbf5EiYJAOgEfVb8NG2SDE3XsVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qJm5/a43ddLjiH763m55S0izDctq9/Gla17dhvs1Gh5ExIm/jD6pQZvOBALwyOqEWzRKTxZ+mHW1FwlUQmbYtDPlR2S/9wTaxkqrpZVA42WTBy5h41dvjHcoNZlBNDCM8fmRUyb7leXZVkDVDKtnvphJwSEIAGmTO2bN6kJFp78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gx0TnG/g; arc=fail smtp.client-ip=40.107.209.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gx0TnG/g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NJI8G11z+DEAx0aVunoBJpVKL2HlFOa5k6wNsaYjx/ViTXxIrSh1aHtaJ6wR1C0BOhaLBpF7B9ggMraMXMVQAr/0BvPuI2hfPrFc7JM3ozLne9qXdVtuaIjglRLUDHuRNjJ4l+y8E/1MGVLf+Z6M07rM3cjJUSfdby/jKBo2dASaDuwAoKfYN/QlHkErdoktkD7XxOvJy/NI6Cd8ynpKRHEv5ZHGPUpG+9HHqZWW3pV6H/ssRxT+qKpzBK3LYtqtkrZpADoFdjGkfme+T+17yedCb/iAc6oinmynfX4Hn6NRHjyT0Jd2Sg2oM1xXrZNLFlkKvdygopujy5WmH4wZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6uWRRJ4um76A2Te3BnK/Ix2i4HjFv24t1oWVoSHWw4=;
 b=JgI2a1wemSLprz5/B9ez2Lo1i4aehldLx5EhcM/68mssE0Mhw8AfXhrNcmIEgWClnj+ReD0HjPz+GSrSq2XQpQe8TMnJw57ZBND+cOItWBIhYrCI1Ix+O3jsY1uGt/b8KmcYjR0t+7Qez2mTsaUaAMiUffYXmwLRIrIrj5FmjAiZdaudNSHDP0KrCwr1brRoUSKQg10ZFuLXbrQhVYtoQnt1U5qQFRZYiO2OQuDccyQjBZVAl9HxDgAAMvvM+PKxdhawN8/u8Q9+JsEnmySUVrncVi87CocN1Rm+2tviqLfwaLb7Hc6iRK00u7WV99aWqpKFe6QpBZSYgS3sl22Vcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6uWRRJ4um76A2Te3BnK/Ix2i4HjFv24t1oWVoSHWw4=;
 b=Gx0TnG/gJgL5lzTwNV+/vj8EDI+N5fgAHiWwmxF7FD6VpGprHlVmRUqDOdaRVvglZAbp4T6KZz0yYvgTMc7jbPSdcJs/r7WR67gyZyzTKLEIQ1Phnj2Wm+sUk+GaH4by4a7ahH9Quw+9+d9LVSGghvSgTFxHSjk+RzHekNi8cS6Etz87huq1HC5QkOaaV1N1aaWeE/dCml4p4C2G4DFr8SS4gVCfXYI/5pPEs9xZaYRP+8iV5/LDYWjrtU1V1FOp6uPmwm0Ko2cHa/te7CPVPGfh7hWAZ+CJBRmIXOtI1QL8xHnHthamRj4w/zEyFI6IUIA2DYKuJpC2HN2hafmrMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CY8PR12MB7097.namprd12.prod.outlook.com (2603:10b6:930:51::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 16:47:43 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 16:47:41 +0000
Date: Wed, 1 Jul 2026 18:47:32 +0200
From: Andrea Righi <arighi@nvidia.com>
To: "zhidao su (Xiaomi)" <soolaugust@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Shuah Khan <shuah@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	zhidao su <suzhidao@xiaomi.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>,
	Zhao Mengmeng <zhaomengmeng@kylinos.cn>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Reject task setter kfuncs outside SCX contexts
Message-ID: <akVEpEArgmcEJVqA@gpd4>
References: <20260701091954.384565-1-soolaugust@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701091954.384565-1-soolaugust@gmail.com>
X-ClientProxiedBy: MI3PEPF0000753A.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4cc) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CY8PR12MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 871e7c95-b497-4202-8b2c-08ded790779e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|18002099003|22082099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	D2rxU+ES5YYXSMLJE7KMe1QJQePRVJIateyF4o1byYPEkH6rV/qfUoe5tRwyz6euk0A61HYJ/vrJegNoDHc7d3DgOR4g5N+tPzcQMOcvoS4MsOWniUzWyMgUwK6Vmc2BUtJ6q0nUqljoydCQHis6RuqeB/ciEnBZbNlyRJPL/MXvMTGxjyXV7n8XMmBJlB7hflD/nQjJYPYH2BBdDCGpA6aYubPSFj9DRhFm2kdp1pTgQyyt9Ol3REpMxUPN+t5v5n5zpsFtzecqAMN+RA+QkDRVhPkrW5IkojkZpTwqcE/yWDjKqkdw3ypPtKZiEe2EyFDieV+YJewSx3EOSmKrQsJz1Q17g/uyuDuV5LhmKo2LApfBzbOD9KedCuJiyHSAJKTVGM2ybVehTd7qWnvqQ0tTuekia74kWFFNzNsEGHIMlCa9C1KQjoHVZhas4HN/6PVpRW7yGj3RkEpPj+yyhzvUij5RBVXgfgsh8sswsG2Ib7UbrqdAYS8Vn+Zd3oXPW1VyKDBxCu+McWiBGsO6s73C1NvNHVQ6Gi+JGZgrW13FPqp/0ruBYHuyYiwhN8gcIrQBMzsCwQPb4dmr+9AoI3w1bnpLvR24gN5hXOpmvFaAAdttFRDEcL361EYHrwEDPfGwwgOlL15D0YIhhMvFaTyjUIMLVe2NkFX44eHoMUM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K++k79szBtotiPmMCxf6fUAufGtxLsmHf5tKh2ASlQTiG236YKSPo5OzZvvF?=
 =?us-ascii?Q?Ya4PN+hxtqN4dZh2PZ7EB9hOEjoItfVmX9Wk/ygATTGJ3wTrkolVcsrvSKy/?=
 =?us-ascii?Q?LLas6rsPPBGRcFnxG0iPq7ZcgED083oui/jORLus1XAnEiQGcNXCyfrEXhmI?=
 =?us-ascii?Q?xXud14VIQDHfxTRl7yZA/3wV5wlQusQXrd61un2Lx6CsoTA52P4hI4B8g+ik?=
 =?us-ascii?Q?OWRYVh+PT7adLHboBLmE4A7M6wBp+ycjI0BXrlZkV7CWnP7d4XXycxawfzlS?=
 =?us-ascii?Q?HUAPZMw4bAxauFF1GO9oftncjjCxICWNloCubVl4wTj7Zl29qY1Pz7QmJ0RZ?=
 =?us-ascii?Q?3pchUUaRqBV1HdfLXtm/n88O3gxF1rdK2vUCF+m9p6GLem5St9YduVb/PVlL?=
 =?us-ascii?Q?6/VhQpTcadRq0ADIzYnDOuZhILTOO3Doe32x8MacnVB9D4oRlKc+Nttgz7Vl?=
 =?us-ascii?Q?MadiZLmNzJHP/XR8jtWIoc91CMFOByXHWKqsyj82kbMe/mY4TtTdNipdwezD?=
 =?us-ascii?Q?tmQfT7ATopbAWyIksYlSOS4UhFp0zFbxF+9s0KdvAj0A+HohxnndaivKnv2b?=
 =?us-ascii?Q?fQkdFe87tMlFHe6Hoe/uOGd+xpr/lDYoM5BPad+4KQNKkikRadMZM4XVcKZ8?=
 =?us-ascii?Q?8yf6aB094NJF4w4/Bdee1uUanymQ0XQKlrOYNhubrzqzknv0POTU+BhjU/Z9?=
 =?us-ascii?Q?QwiNUYYMWrqPUdPNmzdTRJDWjN4XH+VIvRNKbgWpRGpO2XAYALIN1QSstrIl?=
 =?us-ascii?Q?WzMw5vwdVi5IGvWMeQ+hrO/HYARBIZ3qOD2YUYQyD0UbxXDx7fmjWRmjn1tz?=
 =?us-ascii?Q?4DAqnjolosuxQYRKx4MEJh0w6E2RYQ+Azw3+HQ0wHIaWwirvVUCG/mk5N+jT?=
 =?us-ascii?Q?P4E9jzCq0xzgNU+UWJFRtNKoJDZM5lziDl5mrqRJk53pZjKGNfNh6G0CjB88?=
 =?us-ascii?Q?Y08IiS5pWITeljJ8jqhc67gGwVIpO//a9lNd4fgWxDfUHTQecbhih6LhAp4l?=
 =?us-ascii?Q?It+olgDvcIE/TLhghp/p75fZt2jAHy7/AuDVSPDQ/CWgGiicpLQmWM8lZ4cY?=
 =?us-ascii?Q?gaHpKxHq5PRUfXDpYKPf6gJnvdym1RMiOin9NGjJqrBsgZLRMsA9X3RYpMAf?=
 =?us-ascii?Q?9GyLJ0Z+RRIJKtfhWibZC6eB/oKWSt4ZD2xeo4QaRrzLpp3znnkFkudm2f/U?=
 =?us-ascii?Q?IVUUMRx9EoWeIrEhNuWRUhOFHDl6mKrnls1Psty9EwN/qwpsCW7Mt520w+t3?=
 =?us-ascii?Q?TiIrEeFndmcMCz+AKeWYQ3CJeNYZBe+pTPq3Y/RSXKKl/gKby/4W94q093V2?=
 =?us-ascii?Q?l4AN6xwt/xv/l8ccYi6xDlR4RppsBXVqG7KJ9eLQ7xG4cECKQ3QPwf1+pGtw?=
 =?us-ascii?Q?uqS2I1A9JtOYTm267Uy9pUiIraNGrDdgQNJ9bHx0xPfBlhtgu71MWIisSTI5?=
 =?us-ascii?Q?Cqu7GebzXA+uqYHjbFMgqw8ff2Xd9//0tMdFjxzTiogKTP3or70EDEAJS+Sp?=
 =?us-ascii?Q?KG2AC2FOv0AzxpLtghpUAEUmcFWb4aI95l9FQPN6N4vHVRa1VMJiEaKyn6IZ?=
 =?us-ascii?Q?3VGmg4US0i5NBJ3vW6hax8ymtjahR6y68EUlH6UUDP8OtxHE3jyQ/Rj8WNHi?=
 =?us-ascii?Q?6c7mFPSwNFlhI+fHSL79NkVhbtM23xpHY3U9U4l9wgBWnGNSx6mWV8CRG6UX?=
 =?us-ascii?Q?aZaekvgTEGj4IfSZHTmvYcyfq6QOGxZe+3c1YNWkZgUUE/Zq3d7Mec6czGV+?=
 =?us-ascii?Q?tENMBjtzWg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871e7c95-b497-4202-8b2c-08ded790779e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 16:47:41.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4T8IXSDYntu88E06vHWdLXxJ9Ila3k9yuA8ELJlxIIPISjM6TxVQ6wQ22fnxneTb8ZZMY6N7rbpKS6tNJva1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7097

Hi zhidao,

On Wed, Jul 01, 2026 at 05:19:54PM +0800, zhidao su (Xiaomi) wrote:
> scx_bpf_task_set_slice() and scx_bpf_task_set_dsq_vtime() mutate
> sched_ext task state and rely on scx_prog_sched() and
> scx_task_on_sched() to validate the calling scheduler's authority over
> the target task.
> 
> However, the kfuncs were part of scx_kfunc_ids_any. That set is also
> registered for tracing and syscall programs and the verifier-time
> context filter allows any-set kfuncs from non-STRUCT_OPS program types.
> As a result, a non-SCX tracing program can load after calling the task
> setter wrappers, reaching the mutator kfuncs outside an SCX scheduler
> context.
> 
> Split the task setter kfuncs into their own filtered kfunc set. Register
> that set for STRUCT_OPS, TRACING, and SYSCALL so the verifier can find
> the kfuncs, but let scx_kfunc_context_filter() reject them outside SCX
> struct_ops contexts. SCX schedulers can still call the setters, and the
> existing runtime task authority checks remain in place.
> 
> Add a negative sched_ext selftest which tries to call both task setter
> kfuncs from a tracing program. The test fails before this change because
> the program loads successfully, and passes after this change because the
> verifier rejects the task setter call.
> 
> Signed-off-by: zhidao su (Xiaomi) <soolaugust@gmail.com>

This patch doesn't apply cleanly, it looks like it's based on old for-7.2
branch. Can you rebase it to a more recent kernel (we've moved some code
around)?

In general, the restriction makes sense to me. It may be worth clarifying in the
description that this change isn't expected to introduce any runtime overhead,
as everything is handled by the verifier.

Few comments below.

> 
> ---
> Validation:
> - Before fix: task_setter_kfunc_deny failed because non-SCX BPF loaded after calling task setter kfuncs
> - After fix: runner -t task_setter_kfunc_deny passed (PASSED=1 FAILED=0)
> - checkpatch --strict: 0 errors, 1 warning (MAINTAINERS new-file prompt), 0 checks
> 
>  kernel/sched/ext.c                                      | 24 ++++++++++++++++++------
>  tools/testing/selftests/sched_ext/Makefile              |  1 +
>  tools/testing/selftests/sched_ext/task_setter_kfunc_deny.bpf.c | 17 +++++++++++++++++
>  tools/testing/selftests/sched_ext/task_setter_kfunc_deny.c     | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 113 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index b8dd3358959d..257ffaca45f6 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -10254,9 +10254,12 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p,
>  
>  __bpf_kfunc_end_defs();
>  
> -BTF_KFUNCS_START(scx_kfunc_ids_any)
> +BTF_KFUNCS_START(scx_kfunc_ids_task_setter)
>  BTF_ID_FLAGS(func, scx_bpf_task_set_slice, KF_IMPLICIT_ARGS | KF_RCU);
>  BTF_ID_FLAGS(func, scx_bpf_task_set_dsq_vtime, KF_IMPLICIT_ARGS | KF_RCU);
> +BTF_KFUNCS_END(scx_kfunc_ids_task_setter)
> +
> +BTF_KFUNCS_START(scx_kfunc_ids_any)
>  BTF_ID_FLAGS(func, scx_bpf_kick_cpu, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_kick_cid, KF_IMPLICIT_ARGS)
>  BTF_ID_FLAGS(func, scx_bpf_dsq_nr_queued, KF_IMPLICIT_ARGS)
> @@ -10299,6 +10302,12 @@ BTF_ID_FLAGS(func, scx_bpf_task_cgroup, KF_IMPLICIT_ARGS | KF_RCU | KF_ACQUIRE)
>  #endif
>  BTF_KFUNCS_END(scx_kfunc_ids_any)
>  
> +static const struct btf_kfunc_id_set scx_kfunc_set_task_setter = {
> +	.owner			= THIS_MODULE,
> +	.set			= &scx_kfunc_ids_task_setter,
> +	.filter			= scx_kfunc_context_filter,
> +};
> +
>  static const struct btf_kfunc_id_set scx_kfunc_set_any = {
>  	.owner			= THIS_MODULE,
>  	.set			= &scx_kfunc_ids_any,
> @@ -10408,13 +10417,14 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
>  	bool in_dispatch = btf_id_set8_contains(&scx_kfunc_ids_dispatch, kfunc_id);
>  	bool in_cpu_release = btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id);
>  	bool in_idle = btf_id_set8_contains(&scx_kfunc_ids_idle, kfunc_id);
> +	bool in_task_setter = btf_id_set8_contains(&scx_kfunc_ids_task_setter, kfunc_id);
>  	bool in_any = btf_id_set8_contains(&scx_kfunc_ids_any, kfunc_id);
>  	bool in_cpu_only = btf_id_set8_contains(&scx_kfunc_ids_cpu_only, kfunc_id);
>  	u32 moff, flags;
>  
>  	/* Not an SCX kfunc - allow. */
>  	if (!(in_unlocked || in_init || in_select_cpu || in_enqueue || in_dispatch ||
> -	      in_cpu_release || in_idle || in_any))
> +	      in_cpu_release || in_idle || in_task_setter || in_any))
>  		return 0;
>  
>  	/* SYSCALL progs (e.g. BPF test_run()) may call unlocked and select_cpu kfuncs. */
> @@ -10457,7 +10467,7 @@ int scx_kfunc_context_filter(const struct bpf_prog *prog, u32 kfunc_id)
>  		return -EACCES;
>  
>  	/* SCX struct_ops: check the per-op allow list. */
> -	if (in_any || in_idle)
> +	if (in_any || in_idle || in_task_setter)
>  		return 0;
>  
>  	moff = prog->aux->attach_st_ops_member_off;
> @@ -10572,6 +10582,12 @@ static int __init scx_init(void)
>  					     &scx_kfunc_set_unlocked)) ||
>  	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
>  					     &scx_kfunc_set_unlocked)) ||
> +	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
> +					     &scx_kfunc_set_task_setter)) ||
> +	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> +					     &scx_kfunc_set_task_setter)) ||
> +	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL,
> +					     &scx_kfunc_set_task_setter)) ||
>  	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
>  					     &scx_kfunc_set_any)) ||
>  	    (ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> diff --git a/tools/testing/selftests/sched_ext/Makefile b/tools/testing/selftests/sched_ext/Makefile
> index 5d2dffca0e91..000000000000 100644
> --- a/tools/testing/selftests/sched_ext/Makefile
> +++ b/tools/testing/selftests/sched_ext/Makefile
> @@ -176,6 +176,7 @@ auto-test-targets :=			\
>  	maybe_null			\
>  	minimal				\
>  	non_scx_kfunc_deny		\
> +	task_setter_kfunc_deny		\
>  	numa				\
>  	allowed_cpus			\
>  	peek_dsq			\
> diff --git a/tools/testing/selftests/sched_ext/task_setter_kfunc_deny.bpf.c b/tools/testing/selftests/sched_ext/task_setter_kfunc_deny.bpf.c
> new file mode 100644
> index 000000000000..79b619a3445f
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/task_setter_kfunc_deny.bpf.c
> @@ -0,0 +1,17 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Verify that non-SCX programs cannot call task-mutating SCX kfuncs.
> + */
> +
> +#include <scx/common.bpf.h>
> +
> +SEC("tp_btf/sched_switch")
> +int BPF_PROG(non_scx_task_setter, bool preempt, struct task_struct *prev,
> +	     struct task_struct *next, unsigned int prev_state)
> +{
> +	scx_bpf_task_set_slice(next, 1000000);
> +	scx_bpf_task_set_dsq_vtime(next, 1);

This only verifies that at least one of the two calls is rejected. Once the
verifier rejects the first call, the test does not independently demonstrate
that scx_bpf_task_set_dsq_vtime() is filtered too.

Can we use two BPF progs to test each kfunc?

> +	return 0;
> +}
> +
> +char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/sched_ext/task_setter_kfunc_deny.c b/tools/testing/selftests/sched_ext/task_setter_kfunc_deny.c
> new file mode 100644
> index 000000000000..1450a7133a5c
> --- /dev/null
> +++ b/tools/testing/selftests/sched_ext/task_setter_kfunc_deny.c
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Verify that task-mutating SCX kfuncs are rejected outside SCX contexts.
> + */
> +
> +#include <bpf/libbpf.h>
> +#include <stdarg.h>
> +#include <scx/common.h>
> +#include <stdio.h>
> +#include <string.h>
> +#include "scx_test.h"
> +#include "task_setter_kfunc_deny.bpf.skel.h"
> +
> +static char verifier_log[8192];
> +static size_t verifier_log_pos;
> +
> +static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
> +{
> +	if (level == LIBBPF_DEBUG && verifier_log_pos < sizeof(verifier_log)) {

I think libbpf emits a failed program's verifier log at LIBBPF_WARN, not
LIBBPF_DEBUG. I think you should capture LIBBPF_WARN, or preferably provide a
verifier buffer directly with bpf_program__set_log_buf().

> +		int ret = vsnprintf(verifier_log + verifier_log_pos,
> +				  sizeof(verifier_log) - verifier_log_pos, format, args);

vsnprintf() returns the required length when truncated, so
verifier_log_pos += ret may advance beyond the buffer size.

> +
> +		if (ret > 0)
> +			verifier_log_pos += ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool expected_rejection_seen(void)
> +{
> +	return strstr(verifier_log, "scx_bpf_task_set_slice") ||
> +	       strstr(verifier_log, "scx_bpf_task_set_dsq_vtime");
> +}

With separate progs, each load should check for its corresponding kfunc name
rather than accepting either name. That would also ensure both paths are
covered.

Thanks,
-Andrea
