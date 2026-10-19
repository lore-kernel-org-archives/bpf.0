Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010049.outbound.protection.outlook.com [52.101.56.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1657649BD75;
	Mon, 19 Oct 2026 08:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399493; cv=fail; b=tdquBgLNdqcHTdj/GcIm96Z+KeF1N6Te3Po4P4Nsc2WavGvhpTFxzRv9Qs02vlVcHn43Eo/STUpuDHR2PsPBPEvs3UpS67s5pJ3G1dnrm5DPltsl7iIuk6CKBxeKBFuElduu7GdVbFUUCqwwoQK/XvXKt1bXXr1PgSRnbj9Ai90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399493; c=relaxed/simple;
	bh=HNYy9BjfazD7Tl4tfgljotif9WoshD3HTkyQHEIXHYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FD7m1tnd7c+bqSg1dr0G0CN82DZMd864xzdoWgbihXdln4hIY2A3yIMVY66p1oWHp2YSpzeg3PjjjqtCdJ2a9MjhxLiEWctZbcWfZIyduwMuyBSu6cEdMBYsoAEGlPu6faqTqvjSJucxvLvVikQJZ62zKt2J0oRLGsGNs8zs8mQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=icomCeUK; arc=fail smtp.client-ip=52.101.56.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="icomCeUK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFSmvbIlN/aq+9Y0g7bHUGfmbw93bDY1jZ6gqSwmf0uoUYHGetGELv3ulbNhYEP2uOGsS/NI8bhPyLvKc/GpUHoY3XF/UNhDfvo+4ho5ui42DtSalGhUMVtgUU4I+HgFQafaPk2GANrk3KlvHlnvBYclamd+KnKBBTxq7I0811RMvYC6th/rEmVyJF7Fs6vYRoDzo+iH3GaOmROAQENaKbVe1rGiWbdyyhu+vpISSa5O2uXoQj0GPnJTOQCj4S7Xf+u6oIqK/mw0fYv1ToyNTjYUZ2MayDH5/rSvyhAJsdLbDB+gui1u7ngGtCRJKbeFl3XTNNQCk1o8Q4J+CJAGKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WP5S5cLWJi97mBc+7gbDDw5m3EXEvYTG2bxyHGfBQQc=;
 b=AdZilEO/8PtsxqxsdHCL2bkl8XvvtQb5vUibyxKw2qkCNUGXY4yCqkr3tZchLMx6j04EaWYsqtUuiIiB8KGwl+ToE9Y8sBmsWy1bEgf7laXycnATI7cDGLiaa//mpFSkwV/Go4VMSEjI0bWZ4uw6hf6VIDNxvbU2Ubc7Evq2W4U/GYDZQQ2lZ8S9GURWk+8PDVpSEa8sOacLOs7dEYVQdThFeL7Eya2HjmjqIyuvH6VSxo+7M8qFB2+1H0vLOTQk7TaDXiqxb2RKCkEapKiLms0OaA7L5R7TxzCZFDNoU6LD2lBnVCgH6dPkm6K/Hx7P7GVUd24vmxorCTL21Jw19w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WP5S5cLWJi97mBc+7gbDDw5m3EXEvYTG2bxyHGfBQQc=;
 b=icomCeUKoMqRkA2RBGLmy98oieboNw08iXc9vxYAzsooExuOS65KUaGjPyYUdBXOT0e8NwkEfZiwr+HCaQ71ce3o/Ubi7qqFCns/H3jRzRyxBrdx52rzjyaOBLB8YcnMq68prBYqNBCL92KiTZCd20Zs62dgwDvDO/LfpVZ5mP8Z/5ZefvhifPBM2jhWbhKZviGcLCw7ejn6QeMFIwlo/Lp/vjV6+mCy0pEeEqNX+vnCRAarB+SpC1grstb1pLIa2TjuFY6PgwRETvgBSjB7SlEHeCsDG+lNEgzs4LrBIHz9z3LLvFraMGy9ZPdDJJfg6x7mr1fu+POvAPPs6SpaTg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 08:44:45 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 08:44:45 +0000
Date: Mon, 19 Oct 2026 10:44:38 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Josh Don <joshdon@google.com>,
	Vineeth Pillai <vineethrp@google.com>,
	Balbir Singh <balbirs@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Himadri Chhaya-Shailesh <himadrics@protonmail.com>,
	NchangRoy <royfru44@gmail.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 0/5] bpf: Expose pinned arenas as sized bpffs
 files
Message-ID: <atXYdpDukXObjE69@gpd4>
References: <20261010224902.1232178-1-arighi@nvidia.com>
 <DM6HVNSP3USV.AJSWS289Z3I9@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6HVNSP3USV.AJSWS289Z3I9@gmail.com>
X-ClientProxiedBy: FR2P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::6) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: d64725c5-b692-44ff-061b-08df2dbd39e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|366016|18002099003|22082099003|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ALdUxzXbyhX7Mt+FKcP5tj5RAjEIZeIPbeSNj1WT6aA7ydVwg9hqxiw5x9Md1aHBt8BKLUCjyVQdBdsj+MYCT4G/WVIK46tLCB+m0gM3sFfLajLSQkw6MOPOlhXglDg7lb0qupDcjHda7c+7msM5hzVnshZnl0ZOrW6/4dZt2DzFWjoJ/yShQbJyGv1NQMe1QHlyFqpOKOZT/IUgrR3sx3aEvdWBMlbuXAJnRipbvUTj4vf1eayZWgXI3OFCVr/6lj3SNsMrhsR4tQFhh2nIt5rJNlUmOWyddArEpMqmDtmJA1YPLS9iol5qKwA1Gt1uo55jNGKtRAQBE3z+q6t948GMWnqjEjv+lx2HZXyxxUBTDWaW/5mDkVB1gjyA3rmrvYrwQJh5AnXFgnD+4BHhqGLom1134SUM9yXXAQDQbMFNzkpLPHZ6WXMev4kiWltsKjMvbfyWFBDdSas9h6sgD+Rj0CO3ee6zKscM9VmcDSmWcjfcd5lrLeJ1Ew5WcxNGVX/jLO8KmA1pGCrUZvAPyKpnWleYy4I5TsPFFllSwUtg7ZAJ+vFSOw8GFd9ZXyYGj3lQUKuOPQtjCXWsuNMTl4qipJ2HpF3t29RtuV1rQothoUv7OjWDWln7zstqcRLEkGG1R6uh2r2JdUjbCqq5Y/qrCcElC+LfZjgwhRpHgh4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dq0uaGR0iQjQPtZUVDs4Iem6bya7hHlKqPGWcwCEqpFes58jhMf9flqxNOdE?=
 =?us-ascii?Q?fF+FamezDzm0A9fNHjEmZjqff65tsQBuzDzvFYsdd0eHR+qlTG3zh16c69ow?=
 =?us-ascii?Q?rxBsLHuShToBitnb0tnASNunn8AqrgXYe9NZL4JS1WoyNSyV/k5o1PuLrzkL?=
 =?us-ascii?Q?JKJX13/mJ86N4b9cy1ZlkaFMrihvJld7fOcQQ3uc0f/hsmx6NKoBoVeWEBTu?=
 =?us-ascii?Q?TlzzKHBjawPrb7E6lwp6XqtB1+EMKowGqrdJVS1344fYpzkgRyzUP6g8geWa?=
 =?us-ascii?Q?sb4wFE7iMd9aZHPMX6jQYjOGPwYO/SQSshdeGL0a/V2MBs6ign9u325zCwmB?=
 =?us-ascii?Q?5VkcD5J8EaXNHF4zwAbfwa9v7d6Y7qCCsfBiLH1wFoZk2KQs5rIEV84OjEiU?=
 =?us-ascii?Q?HWFor5Goyp4/j4CT8N1KIZsPJVlEh0D2P1lxjNl8h1y1YBMfGdXwfUwnGVZy?=
 =?us-ascii?Q?q5detR9em3JEun798obm5+7T0/9dyR1NZncEpJMAdbLF2sphtO2bRpIN3bA7?=
 =?us-ascii?Q?JdtcjdWERvE8imGXtlNPKKGR9yUc+tRxHL7+ETiVaJWhEfmrAtBV2kqQjtgy?=
 =?us-ascii?Q?gFWYYRU0lxPZbDABfiwd8+uFMceRMwWaEgljAM+ujjQAmNUWs7aw3JXOuF+O?=
 =?us-ascii?Q?IJdcXQQgmg8swNt0KgI88gBkPCQUzBF9Gnpjn14N7O09FRSFxqGfNNUwNkuw?=
 =?us-ascii?Q?d6s/DX37oALgGEYYh9nN44A0Dad90HPX1Bt6ZdJIfWgVbOXNJEa6S7o0zc4W?=
 =?us-ascii?Q?hdo+jZ1nm3rrK8oUGqW5SVaNm6jsWrD+m+OvuobIifpx7U+kaBOfXHOEzFCh?=
 =?us-ascii?Q?VevexGzbOPJng6fD5bbLOuK2GRo4wSLPZWLCKFCmk+m4hkyesLO0pUyTG5hJ?=
 =?us-ascii?Q?a/smIEUXaBVYo9NUI11YtXwcEihnsJgmijje7WJ8+DygUR2Bsb8P83Z272sq?=
 =?us-ascii?Q?f5kNfRiGPgdJZjNefREserkFaQwb2BXRPhRoUFHtb95J0+Y+tVkge4yDZPiJ?=
 =?us-ascii?Q?VOPc8tCJjG3EE/LgRHvlUx5SbOsk49tuxXLfKq4FMtejDwHS5ZA2H+h3AHR1?=
 =?us-ascii?Q?5UqjzNqrR9XA17qaKnNOAPP20HycrPOae9Vjx2zQRMK0SzDwxRkqHTceoRbl?=
 =?us-ascii?Q?aonutqHBFTvmSkElRu2hGmGRPxHKSlKSLX0ClzhXZNybYlZuGXKJVltCvqlu?=
 =?us-ascii?Q?smGmj4+uKvomplVQNMe6JNNFtnUs8bHXEW72ylwRxE0rbQLK/SUMcJsQEoev?=
 =?us-ascii?Q?q0uhaKDUO2rRf8LSLN3A7mmGq3QWQE8x0sUrhrryKehlkgFTBAz8WV5fmlH/?=
 =?us-ascii?Q?/yEn/49MPmv/g5HldA1gU5sOV2jSup0rT1b+d9R9ytArINh5I61meYp3+bQJ?=
 =?us-ascii?Q?1YLE/Uw2gnHgpvNMh9mPRAq9o7E/XkGOD4vPsQsr2QMwweilGXkJYT8kR00P?=
 =?us-ascii?Q?bYv50791e5a4U4bm/qsXn06K8zVnr1Tny1GzBfj3vSZk/Y4qmwjfTzCkpr87?=
 =?us-ascii?Q?2r2rv5e7cIUyEmRB2aiQeUTWF6g8c+CN6CA9EbvffUgarghzhNcjC9dVWRbD?=
 =?us-ascii?Q?sx3QFSAaeIKeR7TBQK/uNy8hZw4f7OZDE9Z6veHF0xvf4y61mncX5JvWpz7j?=
 =?us-ascii?Q?xO72OVpApAF+LCCjAY0KOzQXGuZ0PMOPQi2tDtBewQr+G4/aFm7Rej6m5pXB?=
 =?us-ascii?Q?SbZ5b3pqrmefBNUWEG9aU2OERWTEQaR0XIyiTf+kW7Q2XJqf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d64725c5-b692-44ff-061b-08df2dbd39e7
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 08:44:45.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Gb/Oynn5sHiCvpTCMzG5xxPO7Bzc/LLVoGgmQhQoFqWbSZs5Q/zhX6fO7iAwtdQI2O2ab0hlbsbCEyb/2lRkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130

Hi Alexei,

On Fri, Oct 16, 2026 at 07:03:55PM +0000, Alexei Starovoitov wrote:
> On Sun, Oct 11, 2026 at 12:45 AM Andrea Righi <arighi@nvidia.com> wrote:
> > The guest scheduler can create its own arena and allocate pages from
> > that NUMA node. Those guest physical pages are backed by the host arena,
> > so host and guest BPF programs can access the same memory through their
> > respective arenas.
> 
> in addition to what Josh said...
> 
> That node is ordinary RAM for the guest.
> When the guest scheduler exits arena_map_free() does __free_page() and
> the page goes back to the guest's buddy allocator. Nobody tells the host.
> The host prog keeps writing at that offset into whatever the guest
> allocates there next.
> NO_FREE in the guest doesn't help. It covers the kfunc only.

Right, that's a design problem, NO_FREE only protects the host side, the
guest side lifetime is not covered at all, so the host can corrupt guest
memory after the guest scheduler exits.

> 
> Patch 5 needs a 16M node (256M on ppc) to get one page into the guest
> arena. Arena is 4G at most and it's one arena per prog, so that's
> 256 guests per host scheduler.

Agreed, the memory block granularity makes the NUMA node approach
wasteful and doesn't scale.

> 
> The NUMA node is a way to avoid teaching arena to use pages that it
> didn't allocate. I think that's the missing piece in either model:
> host allocates -> guest arena is populated from a BAR,
> guest allocates -> host arena is populated from pinned guest pages.
> As Josh said the BAR is needed for the doorbell anyway.
> 
> If arena can do that, can the host side take the pages from memfd
> with memfd_pin_folios() like udmabuf does ?
> VMM can map memfd at any address and offset already.
> Then no need for NO_FREE, EXPORT, sized file in bpffs, 2nd kind of vma
> in arena, etc.

Agreed, this is much simpler and it covers both models. Mapping the BAR
linearly into the guest arena also gives both sides a fixed rendezvous
point (offset 0 of the memfd is a known address in both arenas), which
removes the out-of-band offset discovery that the selftest does via
/proc/self/pagemap.

I'll drop NO_FREE, EXPORT and the bpffs changes and rework the series
around arena_map_ext_pages() + bpf_arena_import_memfd(), starting from
your patch.

Essentially the plan is:
 1) host: bpf_arena_import_memfd() (based on your patch),
 2) guest: populate the guest arena from a BAR using
    arena_map_ext_pages() (in QEMU, ivshmem-plain with the same memfd
    as memory backend, so no VMM changes),
 3) convert the two-guest selftest to this path.

> 
> The loader does memfd_create() or opens a file in tmpfs, calls
> bpf_arena_import_memfd(&arena, addr, cnt, fd, off) from a syscall prog
> and gives the same file to QEMU the way patch 5 does with the pin.
> The imported pages stay until the arena is freed, so it's NO_FREE for
> the shared part only. libarena keeps working in the rest of the arena.

That's fine for a single long-running guest, but with VMs coming and
going the host arena would only grow (this was also Josh's concern about
the high watermark). Would it be ok with an explicit release of an
imported range (clear the ptes, flush, set rt_own back, unpin the
folios)? A BPF prog touching a released range would then hit the usual
arena fault handling, like any unallocated page.

> arena_map_ext_pages() is what a BAR in the guest or pinned guest pages
> in the pvsched model would call.

For the BAR case the guest needs struct pages for the BAR memory
(memremap_pages() / ZONE_DEVICE or similar) to go through
arena_map_ext_pages(). I'll look into the least invasive way to do that.

> What is missing: user space has to mmap the memfd to see these pages.
> The arena vma gives SIGBUS there.

I think that's acceptable for the hint channel: the userspace side of
the scheduler can mmap the memfd (or the BAR in the guest) separately
and use offsets.

Thanks,
-Andrea
