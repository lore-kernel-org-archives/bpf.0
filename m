Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012009.outbound.protection.outlook.com [40.107.209.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB78637D120;
	Tue, 17 Mar 2026 18:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773871; cv=fail; b=E+fR/DYyGxqhF6g/PHML+nj3GXhhG/cNB4MOwMbInV/szdxIv12QHpWsc+cDPXVImyqXtJj4q9ku+1mylnygFyEvFCRpDrafhWecDNWhPigMNsm8n7uvijOo2FN1cvrn/s/h+JP6mr9peLTBMnHTgOOnQtcZJGlRJUIs7SX0lcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773871; c=relaxed/simple;
	bh=uHydt6JGz65rKl5Bju/EYUmWmKjug6CI0ays3mDY59U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mty/oFSHcZ6zB5My7LvT4zj2TLdmi/74dexhh+KMdFxVcl+kPlc95kmwgLZVbrN14rkwE5hcxd+xnYfJPSloIaGlzODDNGfC5zGXMGfZLuXwOWZcWANAG1nKFZgoOG7UiXCNW8GTYhTsCMGFbiCfB3vyZyKVJlxXB3g3QXqCRxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ic2CEmeg; arc=fail smtp.client-ip=40.107.209.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ic2CEmeg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ltiF7sSx/1T8oqLqzTBuhePibwmacQCd7yEsX1xXZ1ZLe5UyvvKgznV3TxZDOHgqrU7dKzV8tC4Ea0hmP4aarZ/OR54HDVQqn2wNgxei+bFQW3pS1ANj+VJucyQoU2UwabQtGxZ1bJ0Cr4fwyxlaENfTMGRvaXSDmZQYGiuoA87NuQqk4YbWqyhDX/ZqGTRSdXI16vpSLV4/qa20bISyWokE09YMMjqsY94Y6w1eEP1w2UxOGQG4GZLrg1Id7YWBUpAW5gXRFYUBwNM31+vmETl4OX3/4jLNGK/9GWXZmm4JAVi8uFhDbOTEq7yW5RthYlZz6t93lyYDV+zOsmZ2Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/lZ7ASDw2gwtkxp2CMWS+nSHAyJrHsf73EwtrnJ4Wo=;
 b=lI4P2zb2QNMcYTCFlv1VNIKrrQz/DFXBMs/Vm6OUnypmNgdlpf5e5R03Qi55fm3RNCqM5DJ4j+BL6uJBqHJg7QsoAr8OH24wLFwI9qG+V1qJ8DjPensDw54cTA/N4zOFpeja0+/mnwET3hXW5H+Rg+uxLcwG5sAjO6UwhsRndaGiAffZ4endMghK7s5QJfVT8bFRSmMX97gmjrjUYSiDSrLuMHks1Rg0tiezpqW0lO/DC69PfPWUbmjwAsF5ufGK1ah3g8srVY/EW9QqO3C6hl56EfG7+omT86ozsxPLrUAZJjo40gy7yyOLEFLBuRz2Hg0eHh5AqKHzLidIo9X2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/lZ7ASDw2gwtkxp2CMWS+nSHAyJrHsf73EwtrnJ4Wo=;
 b=ic2CEmegRPQ4K7R7IsNHiqiOzVNCDv+/IlMzSPfxAXn2pmEkGEQtXEt7vAL60r62DoVVA5cisLPC3Z2zX9a7O7rMv84tpGA1fNgKY7MuxHZMqmn4CKL29bflyAdUWRQ2zQNjxUZHvi2VY9P75fe9sFGUQwy8lPrjjM5l3YRMioC/ihHkBQKET6zWoMONi03VtJGozMYhYkC7lZSrF8mLycmsfiGRL/sqxATCIoXqkmixGXVrzDKfkPhOwdkTAL9pILyRGApVya9gdwkFpAS3Whtx3lZxjfytsDM+XWue1YO9gDrvXW6WXQObm+yd41PbmT2WKMr3EsxI1ZVCUB165A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CY5PR12MB6178.namprd12.prod.outlook.com (2603:10b6:930:25::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 18:57:46 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9723.010; Tue, 17 Mar 2026
 18:57:45 +0000
Date: Tue, 17 Mar 2026 19:57:38 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Amery Hung <ameryhung@gmail.com>, Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Always defer local storage free
Message-ID: <abmkIt5LD9VGiWh_@gpd4>
References: <20260316222758.1558463-1-arighi@nvidia.com>
 <CAP01T75eKpvw+95NqNWg9P-1+kzVzojpN0NLat+28SF1B9wQQQ@mail.gmail.com>
 <abjzvz_tL_siV17s@gpd4>
 <abkNtYPMARqxXibW@gpd4>
 <CAP01T75+2GWPbuda+NUBn+oon8Zdq=_45Me8BUE8B9=xcCoqyg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T75+2GWPbuda+NUBn+oon8Zdq=_45Me8BUE8B9=xcCoqyg@mail.gmail.com>
X-ClientProxiedBy: MI1P293CA0016.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::8)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CY5PR12MB6178:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d0300bd-4f69-4d6b-249e-08de84571351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	pUAnSxD5CE4zhxap1K7TRVseeDIdaflg8ot7s0GTFKJRKmbbSTRVLB+nS0ZoyEb5+7ZVyXY4zUEceD+25TFag7jLMJSbtv4RojMSuWDP6DcaIhPkLU60RsfC5ZQWMh7AIldR72PleDm0EkaKIhpoP5PkUdgbPCCpi/eYI3IOJ4sSqAott+FSvQEzDvU8DmVkl/MvaltmkdQjFJ9CFmJqMbwr+0R4fVOiVHTHs/c5NkbJIIfJYG7loPaINMWRj73+7HsqdsgtOlX5m8olerU2f02B51GyjM6Hf8xZSnafFg7obq+Ry1Ny1NHleou3QRCw7QUnz2UJzh/57ZUvWZtBkStIZsbWvXhJ4OtahOFkNQa9J26N4fr437y9kilBIB11rNgBbjww7nmM+BRHWl8rSJO88COqqKwpz3xNt9IlZjynxOqK2w9IPYSIb53BFE+oelUnT21/igC1MPwQhwqpI1s6F9DL4YghHwR45PxF3LbLGxayTtf3gy4zAlzBTyCsjD4kehspEkei3I0mFqD1PdJhss+cxJ2ekZ+OPHM4NR5CSqJWe83KTy2PDGYSLM2q1tfjnFquy1jVKwesHo+4B2r7+2RkVtY/yQivvWWqnubH6EwR0Zq6RxaTPiIaXzkBZ42LPuXBVx6IkR7JIvHtkSTqHhAEmVKkyfiPkO03Ohz418B/g33ZG3mfYLH/yx0aPJtuf0xb639B7dZJIVbDtTT/07eeLWVQqVCUywUdVzA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X9zXELM0z/gIqJXOlcjfdW8rJtBv25jJF3odRcbm/2QXv0vw98lLZQnLRou0?=
 =?us-ascii?Q?gk8l2C7ZlkpLnfZuhyHdvY+duS9gLu2ZXtafXgzlPmjvd5eHiAGtX31jcYjq?=
 =?us-ascii?Q?bWyjKEF6y4INubADVxPzYCRL6WFXVBdrcRJ7V3S3AQA1E6MmMye9g54JQCP4?=
 =?us-ascii?Q?vgrnjI/Y4QP3YPVRlPuIGszCfJJN1wO2JlsPPuJ+oRkic1DA8FlA+YJBStHk?=
 =?us-ascii?Q?WprtVkmq6xZ/op8f2PG/3DtwEBm0t4evAL3MTzBHrwmZJUmpluHizXof7ZqT?=
 =?us-ascii?Q?u+dxJnjU0vD+DFNXBraPU8w/3lPVI1F5CLKoXwVqxbN7Nw4B+5hnVeUahnqo?=
 =?us-ascii?Q?TRbrJC+uXdFvVctzS19d+XmcU7E7APJjB84ihdomKl5GR5Po3ZDEI1jUuuks?=
 =?us-ascii?Q?pjzy5ZykCvFxhSoIN1Ws9E+j73NKZB2/XBs88iF8oEmsH3mfYiz4YV+sGUTB?=
 =?us-ascii?Q?oRNsJ5JB62JpwstgUynqd6Cfh2sk0lmhVgVwcosgUKpau+uGMUtqa+RHV+H5?=
 =?us-ascii?Q?WdRxlTnlcmRTCAA3PHXPnHHbfknJhz1Q2h4MWRaN03sqRUWtlLeEZrvdavw4?=
 =?us-ascii?Q?YiT9Mcr1saW1SHz3EB5ht2KdXtvVinmJY9FiqfzjPkG7AtdgF6sZ3udHaWKD?=
 =?us-ascii?Q?fLGWzmfLieXq9dAS8sSTQLDUY9cRAXnDCoqniJa7Z+GaGouDgSa3wbBwB4eR?=
 =?us-ascii?Q?sZZK2yHEEftdjMAj49IvihxZLyyDpO/mMNAtwYBfFj0Fj/JRoEJimDQJhu1y?=
 =?us-ascii?Q?fUUyHdEYEPWOUZd4r5021hp6i1nPvv4TT4QG46TOLdIHYcfSftBV2Fadu8uT?=
 =?us-ascii?Q?TfQsrL2PbLozXBUfOiUjeY8ikBGXLq+vJTMBiAnVek0BO/7duJr5P4isV02U?=
 =?us-ascii?Q?rzd37hbp9w+q+hI6JJrOJCC4x3ZgtvKRw3W60bViZCp2KGL3j+WpUPGGbBb+?=
 =?us-ascii?Q?5dYqO4pmvDj3Ii7CMvwRZCVUbu7iyZrZgQuCnRZK8gRDJMsCU3NorftkGkhK?=
 =?us-ascii?Q?o78BpK0A9TZvHtcKTY7eRfpVUDIhoSXCWzcyxVU1Cc/pJsavENx1tSTdoqNG?=
 =?us-ascii?Q?HnIzzbkQQ02h5krQiV3KBIO3/a+RAYCwCd4o3GBXtqd/ZCMPj3oWl/NOzzcF?=
 =?us-ascii?Q?KsWDInwV1+iqHRbQ+WwuGQhnLnsaMrZTIp/422CpQVoBYOw4TClFdFXM//Q6?=
 =?us-ascii?Q?sDyTMv9opCFPJbdOWViRvtXxidLn4KNfMwdz1xUOEuX7vaK2rGz+25ysPyFP?=
 =?us-ascii?Q?OMHh1Waj57ZIMZrUk+JERYLTo8l51mdzRurzPxdDIw4OR7+fIvLnX3HBUUcX?=
 =?us-ascii?Q?75JiYQecDS1ddArmmYGSc+mGXaHx5ihwMUjAd6cAE2fvnnGR9u/5YzTVRuv/?=
 =?us-ascii?Q?db9G0TTmoeNnRRHKL/GjkiI9kJWDWdDm3iq7jWu0G0kPMamf9NsAX3N3Zjvu?=
 =?us-ascii?Q?DDqRFrRxr/nU6cloEOX0/Es058emMZAPvCtUROY1YHDTvzAihmvExxKB8JfR?=
 =?us-ascii?Q?Z+2oKhWlP/wkZ/IQx0uWbNAWmvwdpedcs9Muk52jTBaGT2/7aXlEIkP/uLCU?=
 =?us-ascii?Q?2kibrwe+iceZjZb1s/nTxTygXrFDPuXU/wucbUKHCxJ+bJ5shAjrkhELoWtU?=
 =?us-ascii?Q?AAagJzOtKT2n8m9rOsyO9n1SNzwe4ZdZWJZ/d2q9LaCO14sTXucvQroOt/uo?=
 =?us-ascii?Q?Ckrxap+x9KRnpdRKVF2twiB6vQjZ8dO5crbFrcYKFlehef2Of9Q2+rW9FEO/?=
 =?us-ascii?Q?gwLnfRCxIw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d0300bd-4f69-4d6b-249e-08de84571351
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 18:57:45.8610
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vpcX/Klp8TubhkNw6hFFk+PsE2RAwxSAo3FlNe0hbkzS5PKHZ5b2qOP+yKBQNFAmasJ0b7G/tnAsF9gIxcLtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6178

Hi Kumar,

On Tue, Mar 17, 2026 at 07:53:04PM +0100, Kumar Kartikeya Dwivedi wrote:
> On Tue, 17 Mar 2026 at 09:16, Andrea Righi <arighi@nvidia.com> wrote:
> >
> > On Tue, Mar 17, 2026 at 07:25:18AM +0100, Andrea Righi wrote:
> > > Hi Kumar,
> > >
> > > On Tue, Mar 17, 2026 at 12:39:00AM +0100, Kumar Kartikeya Dwivedi wrote:
> > > > On Mon, 16 Mar 2026 at 23:28, Andrea Righi <arighi@nvidia.com> wrote:
> > > > >
> > > > > bpf_task_storage_delete() can be invoked from contexts that hold a raw
> > > > > spinlock, such as sched_ext's ops.exit_task() callback, that is running
> > > > > with the rq lock held.
> > > > >
> > > > > The delete path eventually calls bpf_selem_unlink(), which frees the
> > > > > element via bpf_selem_free_list() -> bpf_selem_free(). For task storage
> > > > > with use_kmalloc_nolock, call_rcu_tasks_trace() is used, which is not
> > > > > safe from raw spinlock context, triggering the following:
> > > > >
> > > >
> > > > Paul posted [0] to fix it in SRCU. It was always safe to
> > > > call_rcu_tasks_trace() under raw spin lock, but became problematic on
> > > > RT with the recent conversion that uses SRCU underneath, please give
> > > > [0] a spin. While I couldn't reproduce the warning using scx_cosmos, I
> > > > verified that it goes away for me when calling the path from atomic
> > > > context.
> > > >
> > > >   [0]: https://lore.kernel.org/rcu/841c8a0b-0f50-4617-98b2-76523e13b910@paulmck-laptop
> > >
> > > With this applied I get the following:
> > >
> > > [   26.986798] ======================================================
> > > [   26.986883] WARNING: possible circular locking dependency detected
> > > [   26.986957] 7.0.0-rc4-virtme #15 Not tainted
> > > [   26.987020] ------------------------------------------------------
> > > [   26.987094] schbench/532 is trying to acquire lock:
> > > [   26.987155] ffffffff9cd70d90 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{2:2}, at: raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
> > > [   26.987313]
> > > [   26.987313] but task is already holding lock:
> > > [   26.987394] ffff8df7fb9bdae0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x24/0xb0
> > > [   26.987512]
> > > [   26.987512] which lock already depends on the new lock.
> > > [   26.987512]
> > > [   26.987598]
> > > [   26.987598] the existing dependency chain (in reverse order) is:
> > > [   26.987704]
> > > [   26.987704] -> #3 (&rq->__lock){-.-.}-{2:2}:
> > > [   26.987779]        lock_acquire+0xcf/0x310
> > > [   26.987844]        _raw_spin_lock_nested+0x2e/0x40
> > > [   26.987911]        raw_spin_rq_lock_nested+0x24/0xb0
> > > [   26.987973]        ___task_rq_lock+0x42/0x110
> > > [   26.988034]        wake_up_new_task+0x198/0x440
> > > [   26.988099]        kernel_clone+0x118/0x3c0
> > > [   26.988149]        user_mode_thread+0x61/0x90
> > > [   26.988222]        rest_init+0x1e/0x160
> > > [   26.988272]        start_kernel+0x7a2/0x7b0
> > > [   26.988329]        x86_64_start_reservations+0x24/0x30
> > > [   26.988392]        x86_64_start_kernel+0xd1/0xe0
> > > [   26.988451]        common_startup_64+0x13e/0x148
> > > [   26.988523]
> > > [   26.988523] -> #2 (&p->pi_lock){-.-.}-{2:2}:
> > > [   26.988598]        lock_acquire+0xcf/0x310
> > > [   26.988650]        _raw_spin_lock_irqsave+0x39/0x60
> > > [   26.988718]        try_to_wake_up+0x57/0xbb0
> > > [   26.988779]        create_worker+0x17e/0x200
> > > [   26.988839]        workqueue_init+0x28d/0x300
> > > [   26.988902]        kernel_init_freeable+0x134/0x2b0
> > > [   26.988964]        kernel_init+0x1a/0x130
> > > [   26.989016]        ret_from_fork+0x2bd/0x370
> > > [   26.989079]        ret_from_fork_asm+0x1a/0x30
> > > [   26.989143]
> > > [   26.989143] -> #1 (&pool->lock){-.-.}-{2:2}:
> > > [   26.989217]        lock_acquire+0xcf/0x310
> > > [   26.989263]        _raw_spin_lock+0x30/0x40
> > > [   26.989315]        __queue_work+0xdb/0x6d0
> > > [   26.989367]        queue_delayed_work_on+0xc7/0xe0
> > > [   26.989427]        srcu_gp_start_if_needed+0x3cc/0x540
> > > [   26.989507]        __synchronize_srcu+0xf6/0x1b0
> > > [   26.989567]        rcu_init_tasks_generic+0xfe/0x120
> > > [   26.989626]        do_one_initcall+0x6f/0x300
> > > [   26.989691]        kernel_init_freeable+0x24b/0x2b0
> > > [   26.989750]        kernel_init+0x1a/0x130
> > > [   26.989797]        ret_from_fork+0x2bd/0x370
> > > [   26.989857]        ret_from_fork_asm+0x1a/0x30
> > > [   26.989916]
> > > [   26.989916] -> #0 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{2:2}:
> > > [   26.990015]        check_prev_add+0xe1/0xd30
> > > [   26.990076]        __lock_acquire+0x1561/0x1de0
> > > [   26.990137]        lock_acquire+0xcf/0x310
> > > [   26.990182]        _raw_spin_lock_irqsave+0x39/0x60
> > > [   26.990240]        raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
> > > [   26.990312]        srcu_gp_start_if_needed+0x92/0x540
> > > [   26.990370]        bpf_selem_unlink+0x267/0x5c0
> > > [   26.990430]        bpf_task_storage_delete+0x3a/0x90
> > > [   26.990495]        bpf_prog_134dba630b11d3b7_scx_pmu_task_fini+0x26/0x2a
> > > [   26.990566]        bpf_prog_4b1530d9d9852432_cosmos_exit_task+0x1d/0x1f
> > > [   26.990636]        bpf__sched_ext_ops_exit_task+0x4b/0xa7
> > > [   26.990694]        scx_exit_task+0x17a/0x230
> > > [   26.990753]        sched_ext_dead+0xb2/0x120
> > > [   26.990811]        finish_task_switch.isra.0+0x305/0x370
> > > [   26.990870]        __schedule+0x576/0x1d60
> > > [   26.990917]        schedule+0x3a/0x130
> > > [   26.990962]        futex_do_wait+0x4a/0xa0
> > > [   26.991008]        __futex_wait+0x8e/0xf0
> > > [   26.991054]        futex_wait+0x78/0x120
> > > [   26.991099]        do_futex+0xc5/0x190
> > > [   26.991144]        __x64_sys_futex+0x12d/0x220
> > > [   26.991202]        do_syscall_64+0x117/0xf80
> > > [   26.991260]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > [   26.991318]
> > > [   26.991318] other info that might help us debug this:
> > > [   26.991318]
> > > [   26.991400] Chain exists of:
> > > [   26.991400]   rcu_tasks_trace_srcu_struct_srcu_usage.lock --> &p->pi_lock --> &rq->__lock
> > > [   26.991400]
> > > [   26.991524]  Possible unsafe locking scenario:
> > > [   26.991524]
> > > [   26.991592]        CPU0                    CPU1
> > > [   26.991647]        ----                    ----
> > > [   26.991702]   lock(&rq->__lock);
> > > [   26.991747]                                lock(&p->pi_lock);
> > > [   26.991816]                                lock(&rq->__lock);
> > > [   26.991884]   lock(rcu_tasks_trace_srcu_struct_srcu_usage.lock);
> > > [   26.991953]
> > > [   26.991953]  *** DEADLOCK ***
> > > [   26.991953]
> > > [   26.992021] 3 locks held by schbench/532:
> > > [   26.992065]  #0: ffff8df7cc154f18 (&p->pi_lock){-.-.}-{2:2}, at: _task_rq_lock+0x2c/0x100
> > > [   26.992151]  #1: ffff8df7fb9bdae0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x24/0xb0
> > > [   26.992250]  #2: ffffffff9cd71b20 (rcu_read_lock){....}-{1:3}, at: __bpf_prog_enter+0x64/0x110
> > > [   26.992348]
> > > [   26.992348] stack backtrace:
> > > [   26.992406] CPU: 7 UID: 1000 PID: 532 Comm: schbench Not tainted 7.0.0-rc4-virtme #15 PREEMPT(full)
> > > [   26.992409] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> > > [   26.992411] Sched_ext: cosmos_1.1.0_g0949d453c_x86_64_unknown^_linux_gnu (enabled+all), task: runnable_at=+0ms
> > > [   26.992412] Call Trace:
> > > [   26.992414]  C<TASK>
> > > [   26.992415]  dump_stack_lvl+0x6f/0xb0
> > > [   26.992418]  print_circular_bug.cold+0x18b/0x1d6
> > > [   26.992422]  check_noncircular+0x165/0x190
> > > [   26.992425]  check_prev_add+0xe1/0xd30
> > > [   26.992428]  __lock_acquire+0x1561/0x1de0
> > > [   26.992430]  lock_acquire+0xcf/0x310
> > > [   26.992431]  ? raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
> > > [   26.992434]  _raw_spin_lock_irqsave+0x39/0x60
> > > [   26.992435]  ? raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
> > > [   26.992437]  raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
> > > [   26.992439]  srcu_gp_start_if_needed+0x92/0x540
> > > [   26.992441]  bpf_selem_unlink+0x267/0x5c0
> > > [   26.992443]  bpf_task_storage_delete+0x3a/0x90
> > > [   26.992445]  bpf_prog_134dba630b11d3b7_scx_pmu_task_fini+0x26/0x2a
> > > [   26.992447]  bpf_prog_4b1530d9d9852432_cosmos_exit_task+0x1d/0x1f
> > > [   26.992448]  bpf__sched_ext_ops_exit_task+0x4b/0xa7
> > > [   26.992449]  scx_exit_task+0x17a/0x230
> > > [   26.992451]  sched_ext_dead+0xb2/0x120
> > > [   26.992453]  finish_task_switch.isra.0+0x305/0x370
> > > [   26.992455]  __schedule+0x576/0x1d60
> > > [   26.992457]  ? find_held_lock+0x2b/0x80
> > > [   26.992460]  schedule+0x3a/0x130
> > > [   26.992462]  futex_do_wait+0x4a/0xa0
> > > [   26.992463]  __futex_wait+0x8e/0xf0
> > > [   26.992465]  ? __pfx_futex_wake_mark+0x10/0x10
> > > [   26.992468]  futex_wait+0x78/0x120
> > > [   26.992469]  ? find_held_lock+0x2b/0x80
> > > [   26.992472]  do_futex+0xc5/0x190
> > > [   26.992473]  __x64_sys_futex+0x12d/0x220
> > > [   26.992474]  ? restore_fpregs_from_fpstate+0x48/0xd0
> > > [   26.992477]  do_syscall_64+0x117/0xf80
> > > [   26.992478]  ? __irq_exit_rcu+0x38/0xc0
> > > [   26.992481]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > [   26.992482] RIP: 0033:0x7fe20e52eb1d
> >
> > With the following on top everything looks good on my side, let me know
> > what you think.
> >
> > Thanks,
> > -Andrea
> >
> > From: Andrea Righi <arighi@nvidia.com>
> > Subject: [PATCH] bpf: Avoid circular lock dependency when deleting local
> >  storage
> >
> > Calling bpf_task_storage_delete() from a context that holds the runqueue
> > lock (e.g., sched_ext's ops.exit_task() callback) can lead to a circular
> > lock dependency:
> >
> >  WARNING: possible circular locking dependency detected
> >  ...
> >  Chain exists of:
> >    rcu_tasks_trace_srcu_struct_srcu_usage.lock --> &p->pi_lock --> &rq->__lock
> >
> >   Possible unsafe locking scenario:
> >
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock(&rq->__lock);
> >                                 lock(&p->pi_lock);
> >                                 lock(&rq->__lock);
> >    lock(rcu_tasks_trace_srcu_struct_srcu_usage.lock);
> >
> >   *** DEADLOCK ***
> >
> > Fix by adding a reuse_now flag to bpf_selem_unlink() with the same
> > meaning as in bpf_selem_free() and bpf_local_storage_free(). When the
> > task is in the TASK_DEAD state it will not run sleepable BPF again, so
> > it is safe to free storage immediately via call_rcu() instead of
> > call_rcu_tasks_trace() and we can prevent the circular lock dependency.
> >
> > Other local storage types (sk, cgrp, inode) use reuse_now=false and keep
> > waiting for sleepable BPF before freeing.
> >
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> > [...]
> 
> Thanks for the report Andrea. The bug noted by lockdep looks real, and
> Paul agrees it is something to fix, which he will look into.
> 
> https://lore.kernel.org/rcu/fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop

Thanks!

> 
> The fix you provided below unfortunately can't work, we cannot free
> the selem immediately as the program may have formed pointers to the
> local storage before calling delete, so even if the task is dead
> (which is task specific anyway, we don't address other local storages)
> we can still have use-after-free after we return from
> bpf_task_storage_delete() back to the program. We discussed this
> 'instant free' optimization several times in the past for local
> storage to reduce call_rcu() pressure and realized it cannot work
> correctly.
> 
> So the right fix again would be in SRCU, which would be to defer the
> pi->lock -> rq->lock in call_srcu() when irqs_disabled() is true. This
> should address the circular deadlock when calling it under the
> protection of rq->lock, such as the case you hit.

Sure, I sent that "fix" just to provide more details on the issue. :)

-Andrea
