Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012017.outbound.protection.outlook.com [40.107.209.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3BD36BCD7;
	Wed, 24 Jun 2026 11:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782302340; cv=fail; b=ijs8gIiYlEHBuVYAzaqF6J72HONWFMnIzYbuMmNJiHIV//pmDQI4b1UphVxmFiP6KONe3qRbGhHvctrGtkMoB+K4WRMF7ZvFlkGIy7jXokGtZv7GY7dTyKS7mhDBYqmUteCMla9aK5WGcnRG5+WIDaQtSpvmUJDkfsUYgMTddT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782302340; c=relaxed/simple;
	bh=pI7Dbqnue/jQAE/hiV5l8KPyM1PrQsHm2ZhJxeXB+c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ble+ppKOmR/xl5gsX3GN7ZOMk6L3hxDz/nh3fWG3Dd7l04PDcQvhSJTpmERwMGwymu0X0HBWyV/5AljSdvSz0AQdapILhwXYMfS3n/p2TyFaq7PF/SO6Qm9v3bTDsRwv/R06tuy8yEF5XPhYdu7FrFQ5XTolOuF7+k9ZUeJKAeM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TObv9R8d; arc=fail smtp.client-ip=40.107.209.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TObv9R8d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WamhJg1IXXLBQVn0NiDbSl0f35z8tdH9X/jFXmRdetxlMQKj5Tu8RYtd9gjBiK2v7r0Bm4+RyQaCEi6Mr3Z6Wjdg8b0DdOjj8b1Cx0IL0DU6n5fp1h/ZLX0XWJ6jy4VF5BAJwAbNkOyLlEk/O6keNYTBHCfIAbiFfRXVXbzYa6fY/NWYvmqf9kd+BtShC5n9wbsPclnhlan3/2G8XbjvLGnzOnGnBPWq48JulCHDdkTzm3USLhBDGCGxfU8PnAwHoIkSw6R08lLjMIiNp4if1l99qLqtNb01JkzIZzopc2PN92hRyM6g4HZQExEPvyBFsg8gLHguiBAl6tcmaykX0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0L8oMlALeG359sacxK7BI4G4Ij0DT11cyfDjNnASI8=;
 b=u8L+5eXXnF2BotnKT1ZBlurv9rtqdoVc1pJsuWEpFcc01ndEvpClBQTJJK0qEt5acOL8yimCWbbP7UxY1NczGwx+cGHf24R4SB36f3BsX5gGHxlKDLrEXTXuj43ba3v97/Cf+JJqDXkDoj9shmDWjqjNwoJVePaZ4cgurDN6vc6pqi8uN44xbghmn/HtlNnlztNYhnEvel7LW4B/uXE0baEbRsjA1KFgrHImiL+gkXyEDihsZmQb9I743FYROnZODECZQiWji9kKYGBReSlbkAJ+5aCtKq/uLp9XJ/d7Gb6NIl8LVpIKyvvm/R360w9+Td5Gl96l1Cd33hwsBuw45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0L8oMlALeG359sacxK7BI4G4Ij0DT11cyfDjNnASI8=;
 b=TObv9R8dxTPueJGdqC/EoLCAV+P6m2XD+N5Q7r9V45KKw/W0LvqW+XuFxikiKmUJy7mpLqHvXk+64xwlbPFhtbok8B4XDCIemT9Lo7C0Ct0uCAEHKGSKKT0q5uHYvgtfMTPYX2+TPRI/KBmIekjXp9OM0f3yFBiKAn3TgkNqPLo7NaipJxBQi5CHwlEjP/VIuMvDiaSENKrEZe/3GaTbat7l6ezvHFVFn1kVYl3TnQfJPm/FO4IJe7+Djfv/IFIap/O05eG77Kb516WUqEIHVvhzGhqEAgfBZ/KkQPDFxzBTXxZJv4iNatyw43ETMcMVGxK/7vG4uW9HKC5xuyoCPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 11:58:56 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 11:58:56 +0000
Date: Wed, 24 Jun 2026 13:58:49 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Breno Leitao <leitao@debian.org>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2] sched_ext: Avoid flooding the log with deprecation
 warnings
Message-ID: <ajvGeVwE-kNhrRHu@gpd4>
References: <20260624-scx_warning-v2-1-07d0d48b0d01@debian.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-scx_warning-v2-1-07d0d48b0d01@debian.org>
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
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: fcdfb4fd-6672-4620-ef3f-08ded1e7f832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|56012099006|11063799006|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	Z+9WTKYi65vaWViJjYyCQf8iKh017MgOAXSBvQ/jVEwBK0IvAo6hRW0PL3w4OomJDRWMijdY1Lboucv9hjW8MWOP+i4UzTcGqwdFbKMs4CMnNAEQq0vY+wKvp61k95CSil83IcMlPOeSZDLPFHGl1iI1JqACg/UWibgZcfjpkPjAM9C1f1OuKar/vcZXDz5JBhY/rZt8FFW5BGFyR9fmIorvhCwMTzdoW7ckS5yYWZ0dux0R+ooTzNVcwwFSn2XC9jzQQnprBMtZCwPd4Q3hwOpjn8w0JB9z3GVgG1yfZU+coiKAjW3mLJcxcqRyki4j/+AL0VSGMqBhmfel2nkUbwUMzH6XMkvfseNMK6ReauBS79HAjx8eIhVDs8zF7loo2LVh7I8t7NoEWOqfx7FXMh7TgQftPkfThr/d0usZZL9LQ0chAC2xXcCVfpuP8m4O0C+BlsvvhpOYdNRpic6rR+0zzqFKimG7Fgbf9Y2rsObrqiy/okXZwZl5C0lG0zY7JQs85/N7dCqFjoW6YeX7h8cjBrxIFEUOtW2ds8W8noARWPses/NRv4JovhUvHEnyL/f5adAWu83RBKDvfgROB9E4cRWSyj0M118eNQTpG0yxWJxNKIOLMStVcNXlEkmG06EbdezC4lvsGURMM+1E9t9ia6KMIN3R7xm38a2jE3w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(56012099006)(11063799006)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Aa0wQrzIb1m8sET+JLbZVtdlmCagGokdKle0hKdYCpwN5HAxtKfdiKJ+5n/V?=
 =?us-ascii?Q?+ELrc0ERc8Srl7NVMcWte0iD4+f5pmBCLAhFFJmms0K7eg9fM3iGB25kNmbz?=
 =?us-ascii?Q?2jnhBMC77NcH+NrP/V/E+10MjFfAUueyjW4/NWax+CG4f3AQ0lL0BkD8f5si?=
 =?us-ascii?Q?D2KG5X4iOQ+98G2P7kmX7l3c12J2Kk8T0iTTrWkItBNRe1pQMwPsceCORtBR?=
 =?us-ascii?Q?QbyxIpMVbPsbogAS8m4f/szti60bKv3uZr728zDS23o1FFf6gZFbpG86nvAc?=
 =?us-ascii?Q?xAZzNmNE2mAPXfL9x4QJ3XLBuiyGqXMtJAkrFh6lCv5PJRVHzeBdDWNtlTR4?=
 =?us-ascii?Q?MeDWrga0lzNV8lu/jgArCq8n2LUDiGHxlC3o+QIPS528ENAxKPvOjf/Ia/Es?=
 =?us-ascii?Q?GgHF7XJMYSzQLDN6n0FVpUaBQGqYqCsVvtZ8Eg2MaU9T/HWGX/fUYKmHCfeX?=
 =?us-ascii?Q?vP+kfRIsorX/CFPYLONnOrZ7d1sLfdlU9InOgE6H50u84xM+7SQkjGLcSOXS?=
 =?us-ascii?Q?8DyJlbTJeyDykP1gfYyqIkwZxEO0KVXiWhNpwhnUqxFjDsMLAT1rK5Xq4ILZ?=
 =?us-ascii?Q?ZqV1PCmdLp5H8zC5TPZlkhypU2lZW+XwFWcE4+Q5hjscPr/RzzYOStqusto5?=
 =?us-ascii?Q?3xbLGz3FfygF9cqE+HjG7Mn4zOaJj0c4pasbbnqWz/U8qSFlr8vEpdMZGq6/?=
 =?us-ascii?Q?XLLUgNeHaF+3NXR+bsS01GMNQO/QEBG7hCk7h5yyJMgYqPQkq0xbVMxtvL1G?=
 =?us-ascii?Q?MB6P0+lvB9kMT9MB/FxcFS/inV4KiTxni6gYL0+c+U5dpU3fhOu/tligIo/o?=
 =?us-ascii?Q?NXVTJ40CBW/KQQ4WHZMmllcAJCQWLi2C+uLN7v9NFf8UefrT8oJL6A5TnQBA?=
 =?us-ascii?Q?64XLmcGHru1GaPFcmsr6MJtJ9A0wmdyMaanueAFtwO7N23YVjGTqAL/hrDoj?=
 =?us-ascii?Q?LVr91hN936S5fUYC3iNWT2VJYogMG3tE1m5uCT2T09Gyi5rli2/1urcDuV/z?=
 =?us-ascii?Q?OcUfqm9IM2/keuOAXyIcrZye6iCQn1BgPmtUYjr5PpqLQO80T6q9i+lEzptq?=
 =?us-ascii?Q?ZBAW0Uv5wgekcFtraPTGvFIW5WazVKSJNMYyUeKgfPZE5B8atPgs3aimlp5F?=
 =?us-ascii?Q?xz/QDTTp0MWGzPQF9LNUPuB1BD4YoJs6F/iVl3gTNvfjfAWa4xhCNYmrOjcN?=
 =?us-ascii?Q?oxsHMYfc1HgBx7k1OQslNQZMsq7Ng4LR7xjIWXrOdMCQm24SkB88wOblfwFe?=
 =?us-ascii?Q?EVP0D8qcZG2ju9q/V8OAzicuBYcu9BbwAi/iTYH0HKpgjGiOvOET/ovDnj2M?=
 =?us-ascii?Q?R2AJlmFpqUBsLgONFGFSKBHHSnG+VKBEYd8zvhon8E1IfprOM3sImxBTFjHD?=
 =?us-ascii?Q?AaPTVcVHoZc9qrVeeNsy0kfBIiEuRAghNYnAjOKwN7Nb/E8hCTVE6HtiWpav?=
 =?us-ascii?Q?/KbMHnSbBPfeFNXRGVrcYvmbNj5Sb2r/cI7PJiifqq/geujF77b3vDcM/54K?=
 =?us-ascii?Q?aa0Ep/oHEZiR/rwczh8HH7fXgYjNvSn7+9Ucoth/1/cPxOMqi86A0pKaERKz?=
 =?us-ascii?Q?4AsDeXHhhiur5bcGjDAWX/tPK5/2lfK3w6YXsgdTTcv7m9aUUmw4mIbS4Isl?=
 =?us-ascii?Q?cnTeksNm4FnBtu9C9bVT8dnuKADRE6pWzHoWyNpWmLDX2Pp5TnepnwSaoOWq?=
 =?us-ascii?Q?TBjnOekTHy0btDyDR/97hp2CTDFjvSFdEk1BDjbXdGfk7QVl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcdfb4fd-6672-4620-ef3f-08ded1e7f832
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 11:58:56.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5oaoHF93Xn0noY+6w+bg3oMf8CC1syoKg2vNWksmsSebW1pszUl8b9HpuhYMHeH/CD7d4jZIHg2BapP56QLRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698

Hi Breno,

On Wed, Jun 24, 2026 at 02:27:43AM -0700, Breno Leitao wrote:
> The deprecation notices for direct p->scx.slice/dsq_vtime writes and for
> ops->cpu_acquire/release() use plain pr_warn(), so they repeat on every
> scheduler (re)load and can flood the kernel log.
> 
> The slice/dsq_vtime notice is the worst offender: it is emitted from the
> BPF verifier's btf_struct_access callback, which is re-evaluated as the
> verifier explores program paths, so a single scheduler load can print it
> many times -- hundreds of lines on some hosts, dozens within the same
> second.
> 
> Switch both notices to pr_warn_ratelimited() so each deprecation is still
> reported but bursts no longer spam the log, and add the missing newline
> to the slice/dsq_vtime message.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
> Changes in v2:
> - Switch both deprecation notices from pr_warn_once() to
>   pr_warn_ratelimited() (Christian, Andrea)
> - Link to v1: https://lore.kernel.org/r/20260623-scx_warning-v1-1-14bf218f4bd9@debian.org
> ---
>  kernel/sched/ext/ext.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 691d53fe0f648..d62b93f48a854 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -6988,7 +6988,7 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
>  	 * run past the BPF allocation. Skip for cid-form.
>  	 */
>  	if (!sch->is_cid_type && (ops->cpu_acquire || ops->cpu_release))
> -		pr_warn("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
> +		pr_warn_ratelimited("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
>  
>  	/*
>  	 * Sub-scheduler support is tied to the cid-form struct_ops. A sub-sched
> @@ -7806,7 +7806,7 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
>  		     off + size <= offsetofend(struct task_struct, scx.slice)) ||
>  		    (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
>  		     off + size <= offsetofend(struct task_struct, scx.dsq_vtime))) {
> -			pr_warn("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()");
> +			pr_warn_ratelimited("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()\n");
>  			return SCALAR_VALUE;
>  		}
>  
> 
> ---
> base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
> change-id: 20260623-scx_warning-0df49c442afb
> 
> Best regards,
> -- 
> Breno Leitao <leitao@debian.org>
> 
