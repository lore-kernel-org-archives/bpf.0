Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C4B38C2A9;
	Tue, 23 Jun 2026 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236051; cv=fail; b=fsSsV7Vhx+plYw4/BwEzQWHuqcTtG205uGlQ+ib79nwC5/WPOjWy2UqWaiyfAz8Oy56K4tVzf7octT5meKiapIlkN+8NHzev81KM8U0FOVIfRBjFWQC+OfovtlhTDnIbXsuxdBwaXBTWjCxqRdkvTUsdGJOpq3KW7zNn241CFMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236051; c=relaxed/simple;
	bh=wZxnUgbrH+DIuu15zijW2oM92TzJPjZyinzkWc18Kzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oKDu5vsqd8fDsTE/HhtdyJ3UQ07pBEHpA7WJssO3PpdM8e3FUzI3BPAN7NPNR1HdiXdKZBA5DpfZj2Ahlak8koRLGX1sNINJmBPAU8TC/lbAcNb5B7+c1YKlDWHkZSu/zMUGGqJBVEbBGA5W2qnn/5pU5HqVt7GnYdIVdM44yTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BLMFR/dS; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BLMFR/dS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfNxxmrb5duEGH4bCidaEHeWJDUbuCpfRxr38oDkN07TUDzh7N8H0BXKAT/WNF8tnabpkhqcU8yXErPlraNEsOgjcx5fF+0mAvWp5VBF35mZrpZZNKnBDi8I9DTbAh7O0JQAvKHyRByzMKkU5zl/kfMKgRzY50aZoMMcTxEfGO0vKjv+IQ9eVR0dmScpShms0SyebE9//48/U+XkILSVendqoKPOrZDzFK9dUwWaepWp91La7NUKwonxlp37ymqdxRtCJZW7Y1wNw3z9f1k8/EWz9z7RzRR3NZP6zlD/pdz4sP18JWaGWWMUtT6vQt+oG7UpSdmKmfmn9krVa/7B7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5soepyB0Vsxi9Wl1AHpolS7Y3yZEz8zRPpTJSkd6eM=;
 b=XH4qLCjMnIKdCagtqxBfoXPHNh7QQUwHgAPDfUZ4uCJcy8Gfc2+EGxZM7u3HclSqrcbkjtEWP6DqUxRv2crtP4onVlB11j8xnJAvuo1BK61213NyV4PSEGV5aycvOn/ZzPteb6hLHnpDtXSHQf/LfiPFa+y4TdxoIYWBYqsiApz9PQNqX9X2367fWi1vXzv4lSEGT+9PH5PDLSUpxnPQTvQa2917utW6k2Ig4wl/VM0NTQTqm4mzhwGVdXztccYELg2eR3zbkLyQI7AVKduLyZnTgIxdc1ceqbztpetpOJEhgJ+KXusmY4rmecwrFOX7BTD4HvaV6B2Rx0iM5z5SfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5soepyB0Vsxi9Wl1AHpolS7Y3yZEz8zRPpTJSkd6eM=;
 b=BLMFR/dSvX2M4xyL1sd49NnFd9+kSkaHGSAolawLYVQfFxkOhwYOnw00iqKZUBI4w1JogA3lMVluGQy79yFiTjGYfu0WZ/kNKOjwQAv/OYYV6a9r0ZIoFblxLCgpJrMLlPNSg4bRn/npi2zMK1DZXgGUs6MimNwLWwm76r7/K3oOftbeZ9cnmkv8IOSa9DWeoMAx7EpvmAv2wy2GFaTquUDkwXPE3hM+0UKryQcRDrJPytr0nYZYySBiNNv6DgSi0rJicAdyB23Z4x6nwhFSQ0bEsAkH4iAXU92rgFu/Lf3trhFRCtgPFkTJUFk3tSDrv4hql1i2kbkB4mjKOyEkag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS4PR12MB9707.namprd12.prod.outlook.com (2603:10b6:8:278::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Tue, 23 Jun
 2026 17:34:04 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 17:34:04 +0000
Date: Tue, 23 Jun 2026 19:33:55 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Breno Leitao <leitao@debian.org>
Cc: Christian Loehle <christian.loehle@arm.com>, Tejun Heo <tj@kernel.org>,
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
Message-ID: <ajrDgwLnu9_FWPUp@gpd4>
References: <20260623-scx_warning-v1-1-14bf218f4bd9@debian.org>
 <43d5e4e0-eddb-4a7a-87df-180b9048a038@arm.com>
 <ajqr_biPOFkugwIx@gpd4>
 <ajq30ImUfS9hQV0a@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajq30ImUfS9hQV0a@gmail.com>
X-ClientProxiedBy: MI1P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::20) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS4PR12MB9707:EE_
X-MS-Office365-Filtering-Correlation-Id: 986233b0-4b9a-4ebe-83b2-08ded14d9ebc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	ql/D/3LARIjt1uVILLRZs2IdjhHEmQL3bhJzs2RLYjNX3mjXKP40h5agbZEWFrcykMn5mvdXh8r8Gh4xkeMo4ULzSDZ03Z1LbHXNlpcLHXjiyM87wokUGzocLTRXZMrC6vEgKjaQvmu/WvsXgQDkpcrT3MHT/qmdQ/4FT4BBCN6Gv9s1BahRZRTQVxUOtNjX67p8GCvmpwy13Feneoo9mCb8wtP6c1zRSFr2WlD4/BVnLoVWaTfo21NMsM8mESshMjM6C/b94F93iaYllZ72j4xb4cKD3SVZFMw0HH8p0Jt7C1cyh1IvOnICWddVqRT46TzgPOh0qedEhkLm+//jwz1lS+LWU+LoxL1sLTKSpEelkqYWfC8kRkg/tMEk3lq0105fuKyEpV26SHI+YcGWzdb+IhcZTXmrLB8NI8ZiIZ0egt/8qGDD5tZm+HhKUY42LfOLQes2Sry7JHVK8PEHCeWCDJvlNejMFeuvSo92hnkSb25m5FfxLcZRVwOLnDGTD9ntjfnpPCdVCAk7bH5NSsIHP62M2R8Bly9jN7wFxPdA4t+xT79R9oQRFRFG+RsHPKlc3gmHuChEwbto+dLRejX/YasOVZL94eAt+Yvb95ly+MFrvTLFh+gK/o/R5bMO6dSnx66Fz6hrd4mVTT5PnJPS6CCnOKaVvjbXGaWsRc4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JEo5ajjFmytHY+tlQigIrPfRNLcnyvTlc+WwtbeebJpJ/HialRyhg62pdl11?=
 =?us-ascii?Q?L1zKaqVzi3aq0lvVp4LKhHckQTkmFIqzGa2aSOyQIhMzkGRFJ+tIXX/YYQCe?=
 =?us-ascii?Q?FLa9PAm9LGkVdpf7qUr1gw+YDmVxmkJUkQSc6xlVg9ZI6qdMjGKlmWxcTvUf?=
 =?us-ascii?Q?2X9vE5afOW92nnR9xfsu4JSXt3CidjKmhHH3nzMJjfN2C/01QqJ6aJyIswWX?=
 =?us-ascii?Q?OuJf9AV+RlCaxHKDoPfKkpBQCXBlsY6wz3de9xb+/K4pjS2KUrwrC5BUIlBK?=
 =?us-ascii?Q?jY4jekCe7em/nJXdHj9XFobimZbQ651VNz+QdoSGrORVk1UPhDN5O0cw9X/Y?=
 =?us-ascii?Q?SOBk4J/8+ubplf99BsVOKWD5G03ZDdG5z7oB0Z05j2rNZZsOB7w8leX7tLmT?=
 =?us-ascii?Q?J3raSpiUv0oNNLNtS7SV3DKKwOOxH/g51WirvBA33McTY41GKY+qWFkqd97w?=
 =?us-ascii?Q?wc9CUH9zQnMgbewVA/1JC+6LwNJY37Sn2uNxEaGPfkdj3IM76IbApdDRLT0y?=
 =?us-ascii?Q?r5xhZOxoj5Llbhb7Vl3FzwLUhIPD1c8GLCiV3K/LLu2+hlwuO41c+7lQLqfj?=
 =?us-ascii?Q?2wm++b75cAwsdkZh3sma6IYgY9TtAtZjZs9zNbAisgOBhu8u6mAy2mluOLA4?=
 =?us-ascii?Q?CoVA6qyxDvjiYsaojLRsle4DFq1MuvzjgtKQ5jjo3bZyg/ozLWfKHzGFAXha?=
 =?us-ascii?Q?OL9qOlMK1zAlsXXTZzYo1dJoll35q8KL8ehjFqtpX7nnNMV+VdNRWGSMiiSn?=
 =?us-ascii?Q?nc89+FLlFYiiWcSaUrbxXsOApb/AhIuvmNGJ6/Awx2yN7Qqjy1uc6Lwf7hcn?=
 =?us-ascii?Q?Mkgg1bn/+GvjA7nyiVBeJd1LukmTQ6Hijjw8ReDYn/YfoH8nf6MUYC/R1HyM?=
 =?us-ascii?Q?JF8wJiOSRHcFgP7iyCZSwk+QJ7elV6Z63SxaX0qVe41Ln6BvfvVVFZi7XjSY?=
 =?us-ascii?Q?EmTFXJINVmwhgxQF1kY3GD+Rpo5p4i/nS0ORPqjrUZn7Yu4hWM1w3wuPtJNT?=
 =?us-ascii?Q?1vsz/1FNP+stXll941KXxeTFdbyosGaFDsAIvfKRg5jCqRpt8iLlMeSAdqmi?=
 =?us-ascii?Q?i3PKklvKsXXf39fjooYJbXq07Iz60fshccY6Nj3HQKuSj1l57DFPjGlGu0NZ?=
 =?us-ascii?Q?bYVCOoQM9IZHEygL2VIID1nbk4fnwGqCAQs2l/vgJ/oyxoPjeTAWmUOudBi7?=
 =?us-ascii?Q?keGbn3JFDL2DVotn+9sNGtbmsAEcdH9Ij+Ou4HOhSM7qoBOpzdd6e5RSPJQx?=
 =?us-ascii?Q?yGl5Ur8mAGdefXSAttSZ0NJyIoYV3BuGYlyXk7I4EpD/rLLLbDLbecf6yh3+?=
 =?us-ascii?Q?p7fJtb40AN6VKY+mhMiyFbu6D+tyX9ulzWjUGuJBcVl7N8exYiOS3bKojS6v?=
 =?us-ascii?Q?xdYbUjIdM7wwEzX3x8YUJcYizgfA0TodeA3g+z3rJH4q0NxRlhptohs+zQV6?=
 =?us-ascii?Q?4VYFScQwpr4HTNU8L30Tk0JgC5RU/vzYKzHsIw8zKHlswVVN5OPWe9fwyZPO?=
 =?us-ascii?Q?cptbqV1wfcRHyoyn2LIwlCv77+LnsR3xiXB8mUF2lCNQl/scK5LhFKlHGapk?=
 =?us-ascii?Q?PaN/f50SeNZjw0ToIAv1hGAEqFUhblwp0OAMnnYrAN9stHL5wQ5MpShjJBZj?=
 =?us-ascii?Q?AFc6hF1NeLau9nGpxY9xvzhGq1kjZJgKm4hqVgWOasVB/pzuExwbE2K8OXMb?=
 =?us-ascii?Q?vxcq0bszalvK1QErFRttdW/NI6GVpt38wgI42YYyZ1iS54p/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986233b0-4b9a-4ebe-83b2-08ded14d9ebc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 17:34:04.0805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oY4fI8yKLKh5YDhCebonTtXntZPo9gG2LIJbNAYPyMRzBD6ZKK1dF2MggOygcSbaQ+oCO8xwlkJVsPud9GBwDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9707

Hi Breno,

On Tue, Jun 23, 2026 at 09:45:06AM -0700, Breno Leitao wrote:
> On Tue, Jun 23, 2026 at 05:53:33PM +0200, Andrea Righi wrote:
> > Hi Breno and Christian,
> > 
> > On Tue, Jun 23, 2026 at 04:45:55PM +0100, Christian Loehle wrote:
> > > On 6/23/26 15:38, Breno Leitao wrote:
> > > > The deprecation notices for direct p->scx.slice/dsq_vtime writes and for
> > > > ops->cpu_acquire/release() use plain pr_warn(), so they repeat on every
> > > > scheduler (re)load and flood the kernel log.
> > > > > The slice/dsq_vtime notice is emitted from the BPF verifier's
> > > > btf_struct_access callback, which runs once per write access and is
> > > > re-evaluated as the verifier explores paths, so loading a single
> > > > scheduler can print it several times. The cpu_acquire/release notice is
> > > > printed on every scheduler enable.
> > > > 
> > > > Switch both to pr_warn_once() so each deprecation is reported a single
> > > > time, and add the missing newline to the slice/dsq_vtime message.
> > > 
> > > I guess this should be warned for once per BPF scheduler like
> > > sch->warned_deprecated_rq
> > 
> > Yeah, I agree. The thing is that we can load multiple different BPF schedulers,
> > and we'd want to get these messages for each of them. So ideally we need
> > something like sch->warned_deprecated_rq.
> 
> Agreed, pr_warn_once() is too coarse - it mutes the notice for every
> scheduler loaded after the first one since boot.
> 
> For ops->cpu_acquire/release() this is easy: the notice comes from
> validate_ops(), which has the scx_sched, so I'll gate it on a
> per-scheduler warned_deprecated_cpu_rel flag, just like
> warned_deprecated_rq.
> 
> The slice/dsq_vtime notice is the one I wanted to ask about. It's
> emitted from bpf_scx_btf_struct_access(), the .btf_struct_access
> verifier callback.
> 
> That runs at program load/verification time, before the struct_ops is
> registered and the scx_sched is allocated (that only happens later in
> scx_enable()). Any idea on what to do in this case?

Hm... actually thinking more about it, the existing behavior seems fine already.

The ops->cpu_acquire/release() warning is only emitted from validate_ops(),
which runs when the scheduler is registered. It's not in the runtime callback
path, so we should already get one warning per scheduler registration. That
means we don't need a warned_deprecated_cpu_rel flag.

For slice/dsq_vtime, the warning is emitted when the verifier sees write
accesses to those fields. It can fire multiple times while loading one sched_ext
scheduler, depending on how many such accesses the verifier observes, but this
also seems correct.

If we want to prevent potential log spam maybe we can just change those
pr_warn() to pr_warn_ratelimited()?

Thanks,
-Andrea
