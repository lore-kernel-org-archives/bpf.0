Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011039.outbound.protection.outlook.com [52.101.62.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AC92D7393;
	Tue, 23 Jun 2026 15:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230027; cv=fail; b=VnUk5Z/7Bn3+O076RBg1+hRtynaq89yi+viaMpWCw0szp6wTv1kUS1/YD6wKvb2QBP2U25l/c+xLWOfzWwdreBYZY6IV41IFdEZu/w7xcmOJ0Nb7Yg24feqHTnctpM6w0A+7B2cK8QFzB0P37vCip3sMxv3rqyMZXgHOwo6/7oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230027; c=relaxed/simple;
	bh=uId/olEd+1Qe6DXL+oDg0BmkDsicCJ/RGU1HFKwjxBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oWgd86XXquHrnJg7haiEc+xpOcRpypA7Q0uY7cIGN+Sr7atYZybWNYYt/VV32BrgpoR1PMFRLdq7qvKH5Av2xABKRt6Bew95aMfs2ZtFHiFbDGDn1WMVS/leZLJrbzBOiIvoU0MFsg8r/MnfNwxXruSmPbOkyqez3VlgZA784gU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DR7vrwnq; arc=fail smtp.client-ip=52.101.62.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DR7vrwnq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U5oAGEVI71rMMljI1zwTi6d0fKb+x75SOapIDHRPDwa4Hx7KyxWjkUcS0JXAJPBydj53Od5WKFQOx6Tw3Iuz3EzImzxTT/Y2znLMVkks4qWi9b7Yq2llb37MYOEhDNHyzwZwpr625ZuqttoUUMqnWZO800H81fNzRrg9Lz09j9ZHvcM3dsepqcIpB+mV4OpqbPsso/ahfXJYjLlE9uikNfGXMW2jBKzWZ/0LkPrJ0mLnHEvOaY6AtyfnrUiPOy7fS9zF3kicizxr8Q+dssW/gqK6azDufhxkFFHM6WecM7bu84qjXf065FewuwbD1jOAEwFYAXClPUQFVFCS1TSmww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N06+I1DoZeUS2OghGu6QapbntxvtKqQPZ3PW0r2FQws=;
 b=hPxtT3bLFYPZ4Cy7ojpMeC8JsBDmlu8LsijXZYAQTW8P9EFHgkVL+EgnqC4/GX9ubt7vn3lnVznkah57vDGoOtOTNfQgm8OSraHqfmAVqySbTe3wdngV7By+FKELnuWQGinH+ai0w06OVOaK/oFBURCPoy+8lfxx3LvnoQVUgf0ZHmw7qiJ6OSF1NP3nQ9yC7y2CUtRcsJbGwYq0IhZZHtzWdD5GppVRo3JEUz0t1xiXN9+PyxP3phrdBDvXlfx12WA1o5be0e8cqR8GpeIgXJcKdHGVR1ydRA7TnbuvP3869Gwgaa48lXTuzh4jJljuOWwiAQm/8Jj6tlp/MMDULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N06+I1DoZeUS2OghGu6QapbntxvtKqQPZ3PW0r2FQws=;
 b=DR7vrwnqa3xJuyyqZ32fhf1jUqYSiP6uBoJFb9x5cIRcDelgd8XvhScTlM3DuY8NOgjuYHbjdpQgfnNlBaboRWkXh6Swr+FnRuDqyWMtbhOIufqfm81eejSvpHlOq2ekSFEVtbwHeBRoJgnSY7MDIFGiQxSJO6V1q+b1uuVpjHmLtXWqFtOXR7ICdTe3tV3fcGEoBQiXRZJuzCkEzTc2Sa0zBogDXrN6QxgB7ldMrgSuqNcZ30p3U78zITEgGh8qbU0rjGBTV9dBPR6Cz357QRJ0pedSHOj4sr2avsHWSl720mN/UUoX/pVOQgRdVP1Igh0vuu4u/cFxi6rIE5hYdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by IA1PR12MB9532.namprd12.prod.outlook.com (2603:10b6:208:595::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 15:53:42 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 15:53:41 +0000
Date: Tue, 23 Jun 2026 17:53:33 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Christian Loehle <christian.loehle@arm.com>
Cc: Breno Leitao <leitao@debian.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
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
Subject: Re: [PATCH] sched_ext: Print deprecation warnings only once
Message-ID: <ajqr_biPOFkugwIx@gpd4>
References: <20260623-scx_warning-v1-1-14bf218f4bd9@debian.org>
 <43d5e4e0-eddb-4a7a-87df-180b9048a038@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43d5e4e0-eddb-4a7a-87df-180b9048a038@arm.com>
X-ClientProxiedBy: MI3PEPF00007540.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4d6) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|IA1PR12MB9532:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ab7f935-dfc1-4871-3b7d-08ded13f993d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|13003099007|18002099003|22082099003|56012099006|3023799007|11063799006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	Ltc5Sv9q1CKbmAYzbu/qSFT31FfLYocWoYLrwFBLga7CmF1wZ+txUM643U1D7B6v2DxGOfTeP16oJ9IbU790hk5OVcnYNnuxhMacLf0u3jZ+pMcLj/P1rglffP5ng/LsL5Mz4ta3ieOh46UAOe7m513JMKr9nGWZZ1yAr6QN678bfMSH3k+1U44f6SETaJORbQsuQv4bMCjlGAM6QQJvgW2cvqKYu3M3kTrRk8pqmABP8g617yczYrxq6TGWjKkg/PAJ28YClh536I6Pb5ngBAm8zmJAbNzUg6LA/EIQybLxOc0QZfcv6ZcvqvEAZ2gqJw781gOgKtkqLhgviqImUF13JI2rHDK6Qbyb0KQtsAOfE/xZwfPF+uytEoDwrkNzEtdMDYRpjWTYRcg91rLsaVTmF08KgaB84IMTnTf/7kmAAuhZ5ToMBohSwW+khlHBSHsTetOZ5jFfZB4qlHz1jctbJvU12A3ZlIp5zSz60NeQSZyiJ8FX08rch4NozEbzfytdUWnXGeWee90ENAkT22tfVmM77i9KweMGVbrzHvRLOrz5aDa4du2xIZyS3sWhtvVsJpD4LsQGVkbBL2w5M3owpvVMjK53pqaDoy4tOiPxknzS2OmzuP78+Gul/WymdKq/F6OZksgMFLOikZDdE2skPfvXpu89iWYEFqelLz0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(13003099007)(18002099003)(22082099003)(56012099006)(3023799007)(11063799006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NhQO+B+EJCeiPtSBvRwV6p8bTrwh7JI489hIR866YU++4GDGuAez99SLW1FU?=
 =?us-ascii?Q?Q/AZhdiOdBaT6uwawUTRsFb7R6LoN7h16haelqdd0j3IRm4gXQ9n/8zX3P4t?=
 =?us-ascii?Q?oMRMJ5vW1YQH/YeIPg0aSBq88MeJkBm9HGyzSd2LQLQHIS4p2ohKIEbxEczS?=
 =?us-ascii?Q?Ac0vw6RZUSBgVl77Y/Y+sz9x6CTGxkFus0OPzAOtfvZx9dQe7js3iL833Tjr?=
 =?us-ascii?Q?TQA7/EM1vhmpiHIcNecGPt93BWAn6pwyV1axMJp1xp/CrJeRfXLSCAf56wgE?=
 =?us-ascii?Q?uN/e9dfkZcljQMDpnHMtknqFRLCGh6bKdZUc5jDp8ZoUDm2354rTtQEaS0Mh?=
 =?us-ascii?Q?XDb5TaufGOX4LbMg6UBNjLelUAYYPkxiPwbRj43Mu3LFUTztirEXJdmjZhFS?=
 =?us-ascii?Q?54+kSqpr40pxGNzHUnioCM4moAzeLHIqtlXB8yx/HH4uuh4eoMKPIbnQA6WU?=
 =?us-ascii?Q?gpWAdEsYeOhHq1KMQkc75OQkoLenwcYu5luxrmmmKzUahevflbVQd1JWbw5r?=
 =?us-ascii?Q?BUdtD2EJ0BHEcmUN7OHN8o+hlrm0+wJGr21dfmsBdxjCLrY+w7zXZjt+9wR3?=
 =?us-ascii?Q?FjGtYRKyGayjWzHgUSzRE6RnzabnHRFgZ6m5qDLU21zMRzfZnFMh71Ov05+z?=
 =?us-ascii?Q?J6IU8SHSubiFwyrNJqbvTvgwJaHaS8LCL0mW8zqQDhVWGzin6I01u7pJNBof?=
 =?us-ascii?Q?n5IgCtBV/Bezbcn2Ueh003zp1qw4U6bA2ATAb5LGIvIc9t0sPm7lotaNbboH?=
 =?us-ascii?Q?DutQCGOedVqUKxgN4z3JcclDwJnZqazEGjhmSWD6RnC3MfrbSijAuQT/aZTe?=
 =?us-ascii?Q?nFTqvCm+naLoUUmH/SHN/YpmuTbRmsZQ0J3sKHxusHi7aBhUlOWX/dIS3GdG?=
 =?us-ascii?Q?YQ9dHZTSCzVcCJ0F/BRVBICCm6eBV2J0Kz+NQtJePkS4PjMeuxxGJpn8/qMK?=
 =?us-ascii?Q?Q4dVzI+Bqe6ri0IMAgjBvWXt7pE4gbklR0gh9VHJRPWnHZxn3OPinIZbEcjJ?=
 =?us-ascii?Q?on7hrz1lv+L+3kmdqPMwEc/A6HSP/qFr8+NZXLd8uiY8ZTGMAWKpHVuGjZ3y?=
 =?us-ascii?Q?uExAs1RIKzcPR1fBgXynDLjyYbHGveY5zRar5YtN2yO5a1BA0og2sx1cOkn4?=
 =?us-ascii?Q?js6Lvy3yzT7NmW3JoDZgw9sFe87UctzqdOEVm4AJXZJGT5vcgKM71VVxyFb9?=
 =?us-ascii?Q?B0jj57X6BTw+KCFfm8TrD4rUje3bxslju8pTdJoSkmxGZXSucTfWsR75vt7S?=
 =?us-ascii?Q?oo23+AV5j08LYViGydyLjXZcB8YAGdwYvHetchj+i+gX1RrcJzGZRw8OaeIG?=
 =?us-ascii?Q?QTaHzVh2lRDpbwv8ykq29w4yBAnIcIgJR8tgqlZAPvTd14fp+lJpTji+kcwL?=
 =?us-ascii?Q?6K5pzJlIhJgFZLJfbI/+B7BOz11ObFor4r2QMLalE3olBGtxv0x8su5UVU/R?=
 =?us-ascii?Q?8CbYOoc1/n7OaJkKPbSl1GQNVS1s9DaErMhhC3PCXOstXVPRUB0IpFn8bulm?=
 =?us-ascii?Q?cpSLYKtFQ33Y/9QgL498iQFAzhcm7kwKBIx5L53lhmpkXIzAyrPNzz3VVobH?=
 =?us-ascii?Q?pJEe6E+aohF4Yo6DfigIbnPflfyWJ1qURuSvUI9gNTT/gKMi9FRxc9LcNows?=
 =?us-ascii?Q?AnNth7X7XjYAaviIYk7mw+xrkh+3Pu7rhLYknpiXldigH4nJb7iPu7KXBCBq?=
 =?us-ascii?Q?SUm9IAlpaqhM5fiKljIldIx2lexlpyKuZ529/fdcu0D9VVKQghL7vSHzNi6m?=
 =?us-ascii?Q?h4+3FC7V0w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab7f935-dfc1-4871-3b7d-08ded13f993d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 15:53:41.8854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v+PuK2ZTEFJ6P/vcC5Hb6MA+d4LCV4EeUI35/sTwIcsCu+nZwxwDmzagavwiyWIvDG5XcpNsZE4EzVuUTpBv2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9532

Hi Breno and Christian,

On Tue, Jun 23, 2026 at 04:45:55PM +0100, Christian Loehle wrote:
> On 6/23/26 15:38, Breno Leitao wrote:
> > The deprecation notices for direct p->scx.slice/dsq_vtime writes and for
> > ops->cpu_acquire/release() use plain pr_warn(), so they repeat on every
> > scheduler (re)load and flood the kernel log.
> > > The slice/dsq_vtime notice is emitted from the BPF verifier's
> > btf_struct_access callback, which runs once per write access and is
> > re-evaluated as the verifier explores paths, so loading a single
> > scheduler can print it several times. The cpu_acquire/release notice is
> > printed on every scheduler enable.
> > 
> > Switch both to pr_warn_once() so each deprecation is reported a single
> > time, and add the missing newline to the slice/dsq_vtime message.
> 
> I guess this should be warned for once per BPF scheduler like
> sch->warned_deprecated_rq

Yeah, I agree. The thing is that we can load multiple different BPF schedulers,
and we'd want to get these messages for each of them. So ideally we need
something like sch->warned_deprecated_rq.

Thanks,
-Andrea

> 
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >  kernel/sched/ext/ext.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > index 691d53fe0f648..708eb9024cb25 100644
> > --- a/kernel/sched/ext/ext.c
> > +++ b/kernel/sched/ext/ext.c
> > @@ -6988,7 +6988,7 @@ static int validate_ops(struct scx_sched *sch, const struct sched_ext_ops *ops)
> >  	 * run past the BPF allocation. Skip for cid-form.
> >  	 */
> >  	if (!sch->is_cid_type && (ops->cpu_acquire || ops->cpu_release))
> > -		pr_warn("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
> > +		pr_warn_once("ops->cpu_acquire/release() are deprecated, use sched_switch TP instead\n");
> >  
> >  	/*
> >  	 * Sub-scheduler support is tied to the cid-form struct_ops. A sub-sched
> > @@ -7806,7 +7806,7 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
> >  		     off + size <= offsetofend(struct task_struct, scx.slice)) ||
> >  		    (off >= offsetof(struct task_struct, scx.dsq_vtime) &&
> >  		     off + size <= offsetofend(struct task_struct, scx.dsq_vtime))) {
> > -			pr_warn("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()");
> > +			pr_warn_once("sched_ext: Writing directly to p->scx.slice/dsq_vtime is deprecated, use scx_bpf_task_set_slice/dsq_vtime()\n");
> >  			return SCALAR_VALUE;
> >  		}
> >  
> > 
> > ---
> > base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
> > change-id: 20260623-scx_warning-0df49c442afb
> > 
> > Best regards,
> 
