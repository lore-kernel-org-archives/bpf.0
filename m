Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013032.outbound.protection.outlook.com [40.107.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CF63ED3A6;
	Thu, 21 May 2026 17:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779386066; cv=fail; b=AaO3MJ580NQ94c3OgBDJrV4nXY0/R2IG3IOuKJ126b4I4h8iL2yCQEJA8Z+5uM6ZT60uD1BUJ+ZG8fR1M0UyRrSWZgBwfJjDLLsJ4aES5/Wx2pR6sIlrKKHYcrSO6cResTbND52BVoMlaP6uVhl0b/8olpuHGx2MwjAbBjrQ/IE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779386066; c=relaxed/simple;
	bh=3Mps/cd4UwVvowGst3oeor5ZUpiRJywTImffQ9RRSmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a81HckZrOdBqJLMpMQXVbMq+/44kpS/G7mvhRFpon5LcQ48wUrVwSseQuKdcaW7wv3xQ0WYimjvSPbNIRqGAyCy/yvZZTovGp3RAzPhIKSAO0vL0AL9TGN2o6WKKLBcbmiB8qVFwfeyBPE5dGYEcq/PnKK4ctOWCH2gpjzq8VFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UaCHoS/o; arc=fail smtp.client-ip=40.107.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UaCHoS/o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTN0EwjQ4Vms/YtSKDNyYHToBFXDuX2tpPNCqZ+QBeQFCgD/k3bywgZV9X0vDD7RhcId2V0UwysTNBcWQnY2ZkEl5H6bne/bCZtGoLFWjaF784YS3G5JRDD/u5xJB0XnxCCnF1I1QLHzq4y8h5G6gmD1wG4RVMeS26ujE4tWge10wNq/r39dcU7hITV36hDsY+mWT419pupBSY3Gfvp8u2EcWhhIZI5gA4q+re91S22A3il7CO+sKEa1EbUytgyy+LRQTDpFvEnA0kcjpl+nd+5UmdmeUTn8jDKss+j2MYQP9D2XFTJ1+qwCjPu2/V+3D/65He7F4ZpoOyh3ph62vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=so62lmvalNGHYXnTLlkhtEozcdx4e3jF7sm6R9jA+MY=;
 b=ViuZOBBDKoCC6+7p+j42vsFHV+NujSwAbQLNPTH8MgdrezNwf+ryV+iP94GQcfjXe/PfEp5g81BhnK6W1SNwcYLrBiDhriT0kkX43kBZYnEFE8kPn+6nRXbkEu4akVMNWCNZx7hgJNCCc01jNEqoI1ocD7KjT+hNkd3WZRj4+kzMmtyv0ljl6X5ZQ020xGe3+3VoJhD99MX6wsugMOsZt7fuuwnnVBYn8znhOSW1yomhkDFn5hq6kJuVdEcI2RjcDVXsG1h72L/cWRZpMI+zGGad8BWZ77YbR7ovZoc5LtN0PzcnaDjNrNrMp9L6i7SU0cl4OLzBCFYhlJtmMTTdZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so62lmvalNGHYXnTLlkhtEozcdx4e3jF7sm6R9jA+MY=;
 b=UaCHoS/oblPH9R85sdt81y9MPDkOfugEHaEF/pGthy9oceUmASO27mTKWCjq6A5VcDGhnuFX+t/aPqxMY+kzwS7b6xK+415kbGGT7bMvKiSQhmg2N/9SUdN8ipw8JXCFW1oHzKr1t2X0L9QRDXAjZbidfvxCTK+jvX5uqzZHzqF/GTBzHHW2w9dYX4U6X3kRj3TX/dbtfLe712A8MX+lx9FchsAVV7gspSqnJEhW6yP30mGOv6cP3KTZRZI/zeTTyG6qhaZzoBL7jkVWTneJxUocTBgeyuN7/xbMTY9qdJNuUQH8HJbCtnAzRuaXQU+P3l4uTE7CCu/jzNXUkDKC7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::623) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 21 May
 2026 17:54:08 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 17:54:08 +0000
Date: Thu, 21 May 2026 19:54:01 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	bpf@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] sched_ext: Sub-allocator over kernel-claimed BPF
 arena pages
Message-ID: <ag9GueVem_OAkdMQ@gpd4>
References: <20260520235052.4180316-1-tj@kernel.org>
 <20260520235052.4180316-8-tj@kernel.org>
 <dd5b3702a826666242b6eb6e805bf83f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd5b3702a826666242b6eb6e805bf83f@kernel.org>
X-ClientProxiedBy: MI2P293CA0002.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::17) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 48a307fd-cd12-4059-04b2-08deb761f502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	40N558pEG7e5q6d8azC/UoPjrX3feUnns0SSOVXdqGjiukmVNQO9KVTmFQhxvD8f2Fcqa42TJHODM/5aGa8C/xJPVRl/0s9bsSkbt1iI578foHvydo3K50xGWFkemCcREqjIU9TMaT3+luEHR4oM0lMapf2/nBcw3DqvYF2d44TSKj7kdK+epkaRC2sBiXsb48ItZxr1X/Y/XJaq8taG2yB09iwF44FWw6kyUJt7xdQJs/f98yJoV9hZWxGWjwUmAEl3l+nl1tg54AjROXc/pMhAWkcs9k7UvvrlUq3r4qSj4bbasAUptXxvmxHQ9MhUYj4Enn8e9E1XVpVdhfDehxF7LxLWqTpsuw2dpQ9YMgYIVY4PqCMlzb/b13one0sPCnZ10pmY5ccRZLWSjgX8B/AN8ffSYSObvnWNZ8MOCYs8LBFts2yqIS70kfA2hkT+irS4g8hV/EXA0fiCulFcvcq5b+qpUdgzZOHsYm6Iinzl/1PuEEHNy952kYISuLQGKrE3LjPoQhdKtO1+1B0aFb35eBExVJpnLbGj+7xMuD8qW2ObC++Oy9Es4l3HMH6yayK2U73Xa00ftIckeFCRtXZx7DiZW8auN9SwiZSwdsLa0AzTpunvZ9dLw6nqoIJiLhtViUKLIUnKrrqZohMFO6e+4Q9e8uRRM60xFfKIsBRFgX/xxRZtxur+C9Ss9s0f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Znlx5a248uuSW1OB6JJpVXiugw0BfBClf8V9qKwRoWqYe8WZ6oGx/9N/DVWA?=
 =?us-ascii?Q?IPX8dFZDjYfajqylrSLpqU/EgnxsN/Rg4QfpeTbzm3NEwIE95QacmZrgNiyJ?=
 =?us-ascii?Q?/G34qyLQCvJMIzuPwVJhh+a8Y4929LSG8703iRa1H89mZpkD8ndFOPHCMwvp?=
 =?us-ascii?Q?vfJIppxiz2c8Vr0PN33XufNs0xiKJq/6qNdzbkng7Km5MqpQzvasFbwfc5zT?=
 =?us-ascii?Q?mzVV2ZnNdjkqhHRNfiMfXOwVm9balrYzy4gb+z40x87R2O7NuLPuuo3xCh2P?=
 =?us-ascii?Q?tOpe6I/jYZHmJsYbo4znodaq/7ORn0usgrbeRX97ObTXV9fczP87WCP2yU8l?=
 =?us-ascii?Q?tZ9iB02SszreLjcrHgb++z7S7FpSMUbSD2j9ZucuuaUvMLTMp/2iRZ8sKH6U?=
 =?us-ascii?Q?Ar4uBCmOdrJw3oz/Ah4IWstTk2ytyyJvXxL5BY9rL4LALORfN2o4TXy7kCZU?=
 =?us-ascii?Q?pPVgMB9vk31INit2dGGi5u/ENBKTEKxYBp8tOtlAsacb0bIPhlkTOFGqZbUX?=
 =?us-ascii?Q?K2oC+zqh30XJFX6uk9hJJ2je+UsGwEWo9pyNFVxPnP9iX9PN99h8apFamTkw?=
 =?us-ascii?Q?XEYD4INloGNvxB3X01mR02qkwdGhV1lVfH9es80IIdqzLDbrZGYt5EcAAukI?=
 =?us-ascii?Q?/TYdnPaB5j5SEHdKZWGQNnH3D5wVMFOzuJFVLaOxouCpAfcm6S9VLBKzmSSZ?=
 =?us-ascii?Q?0trU0AcxN3zMgogPxfEaJfw7VOw3Xt5W+BxA9f6FawUKF3quIEyNVLea4gL4?=
 =?us-ascii?Q?YJOsoUzOMk1EJWklFpjgJH+y2BgaFRk+9ldd5FMknxglbrdjeE0kj9H9uRbb?=
 =?us-ascii?Q?W9vKXtgSL2yauKABiQzitPwYU/hfuV/+wAMXKeyg0RjBiQLlZ+xMtlMQPn7N?=
 =?us-ascii?Q?PYcj/kStzWFuGnIqGvospPDqtliykX7qA5nZhsovYttVxFOF5DQUmENZqBPP?=
 =?us-ascii?Q?a+bqqnJeW6TS8BD9F/Ae5l7tJVYFhZ3MaIa0SiNQp5jdp6eyiRVPr3WLSFGp?=
 =?us-ascii?Q?E8UZ4Qtcm7PEVqD9L8/6ogTYu289bJELrVmBIOel/iuWQXLOj1XWFKupukAn?=
 =?us-ascii?Q?laD0UOfTueBa34mXrYliK4E1QBQb3PGrfCZZr8Y9edtywGPYYWqN7Q8G3A3W?=
 =?us-ascii?Q?bdunUOfjIRS49V8mmA8SJloaihWye2vET0B5Qc44Za82wafh8yMoJEwMvUa4?=
 =?us-ascii?Q?URumheRHdPlzyltkSb08xY+YmOQARddiwKltYph2Sng/6N/ru4+HSMynrWKy?=
 =?us-ascii?Q?X/Hz6v3Y/aXWW/BmX7Kc0AJvpOJYBgnGhLRcZ1/yTXFey2OZ0JqqCT6tbfC/?=
 =?us-ascii?Q?URTffD4BAqS7SQmBby4EAt21xlIxgN0oaycgjVPQ+p49aPpzaSag9Eq7pDRV?=
 =?us-ascii?Q?G83aiRs1XjjwIC662i2GnuT1mpJR8GmG0rmfuSut+UCB/R8wpyeHlixjQFhm?=
 =?us-ascii?Q?zxV5Jo0nN5B589mJlSdrZn0/zdFnp5hb657vql4vDw605ZKJGII14CvtlVTA?=
 =?us-ascii?Q?4kUMS6tYrT+5aKWrYsg9JRMld0LSwKhYVsKeEvAD9MYpNP9RZYi5i/q8ri1I?=
 =?us-ascii?Q?b6db4lKezb2VletDAWdrD5uHtcN0FYZb8/0Y8Ch2F6jClagSTvmswJ/rdCjQ?=
 =?us-ascii?Q?C8/P0VPtsOTjgouOhBgyoVIwSmKO2MK1gzRQnqrzNwr3baU+Xd5g/TAJSbFi?=
 =?us-ascii?Q?2K5pCSQUU0dxFB37/kspqgCgO/fFpRkVQmBMKvkp42GMiv9G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a307fd-cd12-4059-04b2-08deb761f502
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 17:54:08.5763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lAqAhsFs0DTBXZDS2C5HRUbbCXR33sNOVY7OEecNTazMkw4RttreIPLQAR5BGVqxHJRiPmpoOANiVi2P2Gxnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1

On Thu, May 21, 2026 at 07:37:46AM -1000, Tejun Heo wrote:
> Build a per-scheduler sub-allocator on top of pages claimed from the BPF
> arena registered in the previous patch. Subsequent kernel-managed
> arena-resident structures (e.g. per-CPU set_cmask cmask) carve their storage
> from this pool.
> 
> scx_arena_pool_init() creates a gen_pool. scx_arena_alloc() returns the
> kernel VA. On exhaustion, the pool grows by claiming more pages via
> bpf_arena_alloc_pages_sleepable(). Chunks are added at the kernel-side
> mapping address; callers translate to the BPF-arena form themselves if
> needed.
> 
> Allocations sleep (GFP_KERNEL) - they may grow the pool through vzalloc and
> arena page allocation. All current consumers run from the enable path (after
> ops.init() and the kernel-side arena auto-discovery, before validate_ops()),
> where sleeping is fine.
> 
> scx_arena_pool_destroy() walks each chunk, returns outstanding ranges to the
> gen_pool with gen_pool_free() and then calls gen_pool_destroy(). The
> underlying arena pages are released when the arena map itself is torn down,
> so the pool destroy doesn't free them explicitly.
> 
> v2: Switch scx_arena_alloc() to a loop. (Andrea)
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Andrea Righi <arighi@nvidia.com>

Looks good to me.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  kernel/sched/build_policy.c |    4 +
>  kernel/sched/ext.c          |   11 +++
>  kernel/sched/ext_arena.c    |  126 ++++++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/ext_arena.h    |   18 ++++++
>  kernel/sched/ext_internal.h |    5 +
>  5 files changed, 164 insertions(+)
> 
> --- a/kernel/sched/build_policy.c
> +++ b/kernel/sched/build_policy.c
> @@ -59,12 +59,16 @@
>  
>  #ifdef CONFIG_SCHED_CLASS_EXT
>  # include <linux/btf_ids.h>
> +# include <linux/find.h>
> +# include <linux/genalloc.h>
>  # include "ext_types.h"
>  # include "ext_internal.h"
>  # include "ext_cid.h"
> +# include "ext_arena.h"
>  # include "ext_idle.h"
>  # include "ext.c"
>  # include "ext_cid.c"
> +# include "ext_arena.c"
>  # include "ext_idle.c"
>  #endif
>  
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -5003,6 +5003,7 @@ static void scx_sched_free_rcu_work(stru
>  
>  	rhashtable_free_and_destroy(&sch->dsq_hash, NULL, NULL);
>  	free_exit_info(sch->exit_info);
> +	scx_arena_pool_destroy(sch);
>  	if (sch->arena_map)
>  		bpf_map_put(sch->arena_map);
>  	kfree(sch);
> @@ -7155,6 +7156,12 @@ static void scx_root_enable_workfn(struc
>  		sch->exit_info->flags |= SCX_EFLAG_INITIALIZED;
>  	}
>  
> +	ret = scx_arena_pool_init(sch);
> +	if (ret) {
> +		cpus_read_unlock();
> +		goto err_disable;
> +	}
> +
>  	for (i = SCX_OPI_CPU_HOTPLUG_BEGIN; i < SCX_OPI_CPU_HOTPLUG_END; i++)
>  		if (((void (**)(void))ops)[i])
>  			set_bit(i, sch->has_op);
> @@ -7473,6 +7480,10 @@ static void scx_sub_enable_workfn(struct
>  		sch->exit_info->flags |= SCX_EFLAG_INITIALIZED;
>  	}
>  
> +	ret = scx_arena_pool_init(sch);
> +	if (ret)
> +		goto err_disable;
> +
>  	if (validate_ops(sch, ops))
>  		goto err_disable;
>  
> --- /dev/null
> +++ b/kernel/sched/ext_arena.c
> @@ -0,0 +1,126 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
> + *
> + * scx_arena_pool: kernel-side sub-allocator over BPF-arena pages.
> + *
> + * Each chunk added to @sch->arena_pool comes from one
> + * bpf_arena_alloc_pages_sleepable() call and is registered at the
> + * kernel-side mapping address. Callers translate to the BPF-arena form
> + * themselves if needed.
> + *
> + * Allocations grow the pool on demand. Underlying arena pages are released
> + * when the arena map itself is torn down.
> + *
> + * Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2026 Tejun Heo <tj@kernel.org>
> + */
> +
> +enum scx_arena_consts {
> +	SCX_ARENA_MIN_ORDER		= 3,	/* 8-byte minimum sub-allocation */
> +	SCX_ARENA_GROW_PAGES		= 4,	/* per growth */
> +};
> +
> +s32 scx_arena_pool_init(struct scx_sched *sch)
> +{
> +	if (!sch->arena_map)
> +		return 0;
> +
> +	sch->arena_pool = gen_pool_create(SCX_ARENA_MIN_ORDER, NUMA_NO_NODE);
> +	if (!sch->arena_pool)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +static void scx_arena_clear_chunk(struct gen_pool *pool, struct gen_pool_chunk *chunk,
> +				  void *data)
> +{
> +	int order = pool->min_alloc_order;
> +	size_t chunk_sz = chunk->end_addr - chunk->start_addr + 1;
> +	unsigned long end_bit = chunk_sz >> order;
> +	unsigned long b, e;
> +
> +	for_each_set_bitrange(b, e, chunk->bits, end_bit)
> +		gen_pool_free(pool, chunk->start_addr + (b << order),
> +			      (e - b) << order);
> +}
> +
> +/*
> + * Tear down the pool. Outstanding gen_pool allocations are freed via
> + * scx_arena_clear_chunk() so gen_pool_destroy() doesn't BUG. The underlying
> + * arena pages are released when the arena map itself is torn down.
> + */
> +void scx_arena_pool_destroy(struct scx_sched *sch)
> +{
> +	if (!sch->arena_pool)
> +		return;
> +	gen_pool_for_each_chunk(sch->arena_pool, scx_arena_clear_chunk, NULL);
> +	gen_pool_destroy(sch->arena_pool);
> +	sch->arena_pool = NULL;
> +}
> +
> +/*
> + * Grow the pool by @page_cnt pages. bpf_arena_alloc_pages_sleepable() and
> + * gen_pool_add() (which calls vzalloc(GFP_KERNEL)) require a sleepable
> + * context.
> + */
> +static int scx_arena_grow(struct scx_sched *sch, u32 page_cnt)
> +{
> +	u64 kern_vm_start;
> +	u32 uaddr32;
> +	void *p;
> +	int ret;
> +
> +	if (!sch->arena_map || !sch->arena_pool)
> +		return -EINVAL;
> +
> +	p = bpf_arena_alloc_pages_sleepable(sch->arena_map, NULL,
> +					    page_cnt, NUMA_NO_NODE, 0);
> +	if (!p)
> +		return -ENOMEM;
> +
> +	uaddr32 = (u32)(unsigned long)p;
> +	kern_vm_start = bpf_arena_map_kern_vm_start(sch->arena_map);
> +
> +	ret = gen_pool_add(sch->arena_pool, kern_vm_start + uaddr32,
> +			   page_cnt * PAGE_SIZE, NUMA_NO_NODE);
> +	if (ret) {
> +		bpf_arena_free_pages_non_sleepable(sch->arena_map, p, page_cnt);
> +		return ret;
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Allocate @size bytes from the arena pool. Returns kernel VA on success, NULL
> + * on failure. May grow the pool via scx_arena_grow() which sleeps. Caller must
> + * be in a GFP_KERNEL context.
> + */
> +void *scx_arena_alloc(struct scx_sched *sch, size_t size)
> +{
> +	unsigned long kern_va;
> +	u32 page_cnt;
> +
> +	might_sleep();
> +
> +	if (!sch->arena_pool)
> +		return NULL;
> +
> +	while (true) {
> +		kern_va = gen_pool_alloc(sch->arena_pool, size);
> +		if (kern_va)
> +			break;
> +		page_cnt = max_t(u32, SCX_ARENA_GROW_PAGES,
> +				 (size + PAGE_SIZE - 1) >> PAGE_SHIFT);
> +		if (scx_arena_grow(sch, page_cnt))
> +			return NULL;
> +	}
> +
> +	return (void *)kern_va;
> +}
> +
> +void scx_arena_free(struct scx_sched *sch, void *kern_va, size_t size)
> +{
> +	if (sch->arena_pool && kern_va)
> +		gen_pool_free(sch->arena_pool, (unsigned long)kern_va, size);
> +}
> --- /dev/null
> +++ b/kernel/sched/ext_arena.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * BPF extensible scheduler class: Documentation/scheduler/sched-ext.rst
> + *
> + * Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
> + * Copyright (c) 2025 Tejun Heo <tj@kernel.org>
> + */
> +#ifndef _KERNEL_SCHED_EXT_ARENA_H
> +#define _KERNEL_SCHED_EXT_ARENA_H
> +
> +struct scx_sched;
> +
> +s32 scx_arena_pool_init(struct scx_sched *sch);
> +void scx_arena_pool_destroy(struct scx_sched *sch);
> +void *scx_arena_alloc(struct scx_sched *sch, size_t size);
> +void scx_arena_free(struct scx_sched *sch, void *kern_va, size_t size);
> +
> +#endif /* _KERNEL_SCHED_EXT_ARENA_H */
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -1116,8 +1116,13 @@ struct scx_sched {
>  	 * Arena map auto-discovered from member progs at struct_ops attach.
>  	 * cid-form schedulers must use exactly one arena across all member
>  	 * progs. NULL on cpu-form.
> +	 *
> +	 * @arena_pool sub-allocates @arena_map. Each gen_pool chunk is added
> +	 * at the kernel-side mapping address. Grows on demand and pages are
> +	 * not released until sched destroy.
>  	 */
>  	struct bpf_map		*arena_map;
> +	struct gen_pool		*arena_pool;
>  
>  	DECLARE_BITMAP(has_op, SCX_OPI_END);
>  
