Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012058.outbound.protection.outlook.com [52.101.53.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6958B3559F5;
	Tue, 17 Mar 2026 06:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773728724; cv=fail; b=eNhhND/4Oa9OhkX6gbaPc1VkrWhXshQlzI/KR5G0uiazKbAu1Kx7EVPLVpja8VH3VESbNDsLoL5Itqk+LWkd0qky+nrQLRraqLi4Ji+S20tB37p+j5BEr28EqIGEojKvlLlBC08jqnQvwejLflcxHZSFS/t98Dw9EesEQE8ypf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773728724; c=relaxed/simple;
	bh=dHlVTnzyzK5VeZuMXXA0O1g9hjNn6zmAyL3c1JmKxLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sxOdcS/ce/LX1xhDHZBABOHtPMocdBr2AUnLR0GMsAKp3sg0KQFGsudVI+pBGflxRU8vr2Gnm/FTcoN1fYQGtBkGYfm3Xf6nBKclVrFWgD5YuKu6NtvkQHeCDS5AKJa98HP8ccAs8wXJEe4t4u8gZLCvi6M0C64grNs4eYqcnj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=un9tHkK+; arc=fail smtp.client-ip=52.101.53.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="un9tHkK+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tkq6YOVxbSwZ39YpafCNFE1euxQ/UYCQ0cqFWWE7MHk35Ng04LewUu2oLtWOs9B7h/4xWSnOZUr2fGMeRVuLK37hxTuFQXPMN+7VXV8+YhsYT2+10RGwCyIe4uGelzl+4KNfkev36uOv0UwODq8UxazO9uZqq63Gj4d6I+VRVMR390CjU0fcFJ9RyTNhNmQ2sHyr/cEqU1Eyt3bQi7dnsmIuIu1d0Mj8a8vjrZ03s4fuV0hUd5jkXVGNRJv4/QpYZMU0cAZ0HQEoUh0CTNd3f5RezOu8YgLDp6FrjDcyfPYMTG6pJMeldlXDK6mCM/Va7mhzcVpgQ+52OeEJAsOUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAxBRB6a5Cxeq9CUtHejQRmnXihsC0Bw44SxSUb1uRQ=;
 b=Cmh18DUETd1Y6aRWoYmg2wKhaNkyIlWjKkXW4hWWYYd+rTRtEFirVNlpo49m/W0oc3l2yLB5iWPIIXjOYCIlM4BiPBnOgOVyYAzp+6IZsE616WGFltHtWwn/C2cc7hMA3RuXLbGpGmT1T0X9jyo7TgNV4gWaDWlJ+lELQApff27R3nNyMRnaquKWZCFl32dsNKziXeKD1hJyqpoZgGkK+uGgXE/Tx+Ck3qtSp22LBNh6LS07qambcrpf+gq1pQ8VViQroTiNdi9NgwdARVSFZSxxob0wjZc5cMPOA+bMnXlKCkheRNdNUrdIaOu95qkCihDAnnO+c7Y77IcwFpXMrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CAxBRB6a5Cxeq9CUtHejQRmnXihsC0Bw44SxSUb1uRQ=;
 b=un9tHkK+2G3lsjdurXKGLDYAwAJSQJfBSooEtv/dwRTUXB8PM9gQ5OWdC1SXmKpLoCNCCHFQdktSCk9c0oYIpsCsvI3nnOpgTUtpw7NcZaS0dpNROswdDMOF/SVmy1yurabQi1fwScI9wB6ApRXisIWZjSENhkRkDC8NZKYmVql3fMUfIIDDcP3LODU7Oj1qLhHeyEmrqSXKTMjYGMPGPF2cZy0hdRU1a1RX+aWK8eXqwHOByvUgKlbBct1N0r8f4si2Yjb5nehWS7obAm9vXi1Q9oiRFIjtPvgREKYCDWdJ7ptxNuLk+DcDhxmvLmwA2dWFBtuYwc/wZP64wBcQwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SJ2PR12MB9005.namprd12.prod.outlook.com (2603:10b6:a03:53d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 06:25:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9723.010; Tue, 17 Mar 2026
 06:25:17 +0000
Date: Tue, 17 Mar 2026 07:25:03 +0100
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
Message-ID: <abjzvz_tL_siV17s@gpd4>
References: <20260316222758.1558463-1-arighi@nvidia.com>
 <CAP01T75eKpvw+95NqNWg9P-1+kzVzojpN0NLat+28SF1B9wQQQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP01T75eKpvw+95NqNWg9P-1+kzVzojpN0NLat+28SF1B9wQQQ@mail.gmail.com>
X-ClientProxiedBy: MI0P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::12) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SJ2PR12MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: 09a0fd10-2c77-456c-03c9-08de83edf4bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Pvq4j3cWoL9hH60HGnA+Ss9Y2Uu6XDOkG2RL6VuJP9B8emClHUgcZMX4DvlC6mIIeQXSbIgmdX6QzNjc5xm97o3ikYUzkHW2AkQMX1Skvux8hfxVttK0zMWeYVV1YWKLOYqOSb3/8YGztFiQrVoC/jbWZlnv8rRGVpF3p3IpRnLrdQ7Qd74ef22amJrBRdhfS86nGs/w/WDbdbmkdfn5yfL2IuQWmkR/lcc/3pExfwR4eJBMRflhAPVMQYn6NMm8xVkhHUa4VmVB0Rrtn7kEEtBUhvh4b41EDzDKY/qu2v3yvuqOnjpzZJnJhh91QjEci1yEh2qmE/dw+Rk6Us6sVNesF020xI81s0NRcYiKWNTOQFNQpz9G8JRPPnRNW7fNRurtcRZGB50BOWWMpiHNC4NLLyNps20yKoOnTEHFMX1wDUaZKQEmW1vKVGwCKzk9VBXNPZ7+fARJWCO02ye15Hy2K2fqCd2tGDRc7qCBMi7S/fmlFrOBvYk87bizLhiz4uaD9LV7yy1j8ex+WXxoSmylchSv3F2jyKQeQdy7JAqzngSa6wlwza77orn0SEs1IBTq7amvZbL5AGbR/tlIzJAQixIUOh2LthDR70GdEgBj3BweNM6/5TTvRBUHSBchZRSwG7afasDub/ULAnF7E/60RhdvlrK+NMTCHUuAwkTMycxpi7CdrF+q4uH4uo5aWBAX1nIY8dNfRGmr9xdnDxw+/yMtaBtnbgeUeQfBXLI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HqcXJZUEl/8iAJTmnKrUHnpMUr9nGCu7D0awyaa1QBqslIo7nL1pCYuGcxeg?=
 =?us-ascii?Q?CD+GLrpZVB9EKO/jJW6JtxBHDCGkGlzCwcVUAH4N+2ZP14McshJrWIiCGYO4?=
 =?us-ascii?Q?sjRkSLunOuycWITWfXPnz3iAo0EvnCql0Wn1z/lOjDAWZN7H0sgksz7fnUsF?=
 =?us-ascii?Q?d7ZvJJe8ewhq6hJBfQTbcDBb/ATGdbDwkRDgPHqSClfkNITY7905BmPuEaUV?=
 =?us-ascii?Q?raIzdEInijFDv1TjcfVdd36K96nN7c/qGcC5AHw6kGq3sRotkB0UaJIOGhDk?=
 =?us-ascii?Q?v0s6yxdrsiAgzSvoXJtQrKl9ysPD3UhpdpdAi5jpmxiOH1PGMzHY+GzTgx9/?=
 =?us-ascii?Q?i5VVGsX0cceojxoUOM6ZtXdMYpAoU7H8EVDRAXmPzNm4k6B5A8YCBwdPo7Au?=
 =?us-ascii?Q?Jjg+uCpUwzbi0QelwlaCM+v4LNpiaPx7VQLOJz0p9GzQt+q9OByN3UYuWbkv?=
 =?us-ascii?Q?Zm+YYzYJL0ohgYzc3Dide2FT6c4DFfvnZPcZt0EzXmZDs2oSCmC7BM5q0hcX?=
 =?us-ascii?Q?/2jDHEIPr5Y+hE8lI7KgI9u18u6MJ362wruWz5n4Cv2jdHEGxVdt+A4+cKJH?=
 =?us-ascii?Q?b/I+PA0+rLNYByGEayAJDYjSu8LtWZfyMs/z1IiUIyOUxVIfdUcQVg0mls/s?=
 =?us-ascii?Q?JaHy0WwKo42w3jXKOnfb2Ontfl5X2E02XMWPBs0f8sgxo9SBW1OzDWWp7xaZ?=
 =?us-ascii?Q?WVPa6QEN0g6oiJo1osDkvsP1aB/0Sq5S7erAjsfsCDqc8qvElXY/Ve8UfyuE?=
 =?us-ascii?Q?CYbyRFDRMWXiYiCYMR6RE0g9WvZPtVBH4yeLDerHhpNoKHn5V4xrOGDtGz4n?=
 =?us-ascii?Q?WQSdFxow4rTRccAPoc4C2kT2uDkWxlUATWO81YzTchycYTwBZaAGHk3P0+hE?=
 =?us-ascii?Q?RMsx+fn9O/e+X9DbGFMy0V3TSKV4oFJ+/NV0cZSToIoGWp9fFeMqFM9PX89Z?=
 =?us-ascii?Q?RQaaE8AdpFOGNDxDi+XvYVOmtNZXweVE9YuRDb3dQMt1eO7FaWuVtozsfhaT?=
 =?us-ascii?Q?HyPd+hRtUC36GytDVqaasU75MfCMg7tGehlLAMabrmo274EimtnUde2OoXS+?=
 =?us-ascii?Q?DRsUgBJ6JfEeaApQeiOjsVCBKZP51DUTbiDgLJh6DIQdC85eLCBZ8W0fnoat?=
 =?us-ascii?Q?S0qtnugVGhZ2rI6cyKjMbKo7aY3Bly3lwhq6uVPpV73Ic3FJOiW+1DSvU6zU?=
 =?us-ascii?Q?Tx01dY8xBSin1CpZ1GGkBA99EMqiP158LzmV7ZZqdwhBq/VLemWgCPguUEF7?=
 =?us-ascii?Q?x6QT28kW+CU8I+nxfSPvCh0M1yjMtZy33MJhsHotpXtxlSHPD34wBrx5b6uq?=
 =?us-ascii?Q?lTk5ra2eFdM6VM69FsJip+E0R1nErxHGrAEfpbrWgMLppYrEVfEMFkv3Oyfy?=
 =?us-ascii?Q?1c2HXJ1tlTcjdhCqt64IBntJVCcvtBfc0yeQVGe3tvwatkCgv0O5LXfPpE4c?=
 =?us-ascii?Q?G5qRWbU+palm7PIzAMG0IzGD2N4QhtLZPgfOMJaPwT+QAyUIm1gmqL0Q4DCs?=
 =?us-ascii?Q?1Rp05y46z3HwC1TF+xhhZOF26Jnzv7oA1tHuuLPxq8GP8XQDxOcxo/vbRz39?=
 =?us-ascii?Q?9creek0zxKDFBaWHnbT7cnzguAoXa+14uaUK8+RBfHYxYPf6m7UcedBUim8f?=
 =?us-ascii?Q?Zsi848K467KTSwG179WqKKm2vpgyShuX3V4NoyQ/tMZKzOYN6BPVp3BGuSim?=
 =?us-ascii?Q?NeF+GUjtIlECLoNH2SxlIIsRCWv5k1FLV1i+ov5NDIsVkJrCN9Y/KVZHRJ9X?=
 =?us-ascii?Q?89Avp4Cs3g=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a0fd10-2c77-456c-03c9-08de83edf4bb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 06:25:17.7563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lJAZrDRL952A9SmuIx1h3LHz/8Ug3xvbxlCmEp/DiGTOJQ9PdKwCpbV48HTlOIl4DalWUa7kdqd9omiy3RJUag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9005

Hi Kumar,

On Tue, Mar 17, 2026 at 12:39:00AM +0100, Kumar Kartikeya Dwivedi wrote:
> On Mon, 16 Mar 2026 at 23:28, Andrea Righi <arighi@nvidia.com> wrote:
> >
> > bpf_task_storage_delete() can be invoked from contexts that hold a raw
> > spinlock, such as sched_ext's ops.exit_task() callback, that is running
> > with the rq lock held.
> >
> > The delete path eventually calls bpf_selem_unlink(), which frees the
> > element via bpf_selem_free_list() -> bpf_selem_free(). For task storage
> > with use_kmalloc_nolock, call_rcu_tasks_trace() is used, which is not
> > safe from raw spinlock context, triggering the following:
> >
> 
> Paul posted [0] to fix it in SRCU. It was always safe to
> call_rcu_tasks_trace() under raw spin lock, but became problematic on
> RT with the recent conversion that uses SRCU underneath, please give
> [0] a spin. While I couldn't reproduce the warning using scx_cosmos, I
> verified that it goes away for me when calling the path from atomic
> context.
> 
>   [0]: https://lore.kernel.org/rcu/841c8a0b-0f50-4617-98b2-76523e13b910@paulmck-laptop

With this applied I get the following:

[   26.986798] ======================================================
[   26.986883] WARNING: possible circular locking dependency detected
[   26.986957] 7.0.0-rc4-virtme #15 Not tainted
[   26.987020] ------------------------------------------------------
[   26.987094] schbench/532 is trying to acquire lock:
[   26.987155] ffffffff9cd70d90 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{2:2}, at: raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
[   26.987313]
[   26.987313] but task is already holding lock:
[   26.987394] ffff8df7fb9bdae0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x24/0xb0
[   26.987512]
[   26.987512] which lock already depends on the new lock.
[   26.987512]
[   26.987598]
[   26.987598] the existing dependency chain (in reverse order) is:
[   26.987704]
[   26.987704] -> #3 (&rq->__lock){-.-.}-{2:2}:
[   26.987779]        lock_acquire+0xcf/0x310
[   26.987844]        _raw_spin_lock_nested+0x2e/0x40
[   26.987911]        raw_spin_rq_lock_nested+0x24/0xb0
[   26.987973]        ___task_rq_lock+0x42/0x110
[   26.988034]        wake_up_new_task+0x198/0x440
[   26.988099]        kernel_clone+0x118/0x3c0
[   26.988149]        user_mode_thread+0x61/0x90
[   26.988222]        rest_init+0x1e/0x160
[   26.988272]        start_kernel+0x7a2/0x7b0
[   26.988329]        x86_64_start_reservations+0x24/0x30
[   26.988392]        x86_64_start_kernel+0xd1/0xe0
[   26.988451]        common_startup_64+0x13e/0x148
[   26.988523]
[   26.988523] -> #2 (&p->pi_lock){-.-.}-{2:2}:
[   26.988598]        lock_acquire+0xcf/0x310
[   26.988650]        _raw_spin_lock_irqsave+0x39/0x60
[   26.988718]        try_to_wake_up+0x57/0xbb0
[   26.988779]        create_worker+0x17e/0x200
[   26.988839]        workqueue_init+0x28d/0x300
[   26.988902]        kernel_init_freeable+0x134/0x2b0
[   26.988964]        kernel_init+0x1a/0x130
[   26.989016]        ret_from_fork+0x2bd/0x370
[   26.989079]        ret_from_fork_asm+0x1a/0x30
[   26.989143]
[   26.989143] -> #1 (&pool->lock){-.-.}-{2:2}:
[   26.989217]        lock_acquire+0xcf/0x310
[   26.989263]        _raw_spin_lock+0x30/0x40
[   26.989315]        __queue_work+0xdb/0x6d0
[   26.989367]        queue_delayed_work_on+0xc7/0xe0
[   26.989427]        srcu_gp_start_if_needed+0x3cc/0x540
[   26.989507]        __synchronize_srcu+0xf6/0x1b0
[   26.989567]        rcu_init_tasks_generic+0xfe/0x120
[   26.989626]        do_one_initcall+0x6f/0x300
[   26.989691]        kernel_init_freeable+0x24b/0x2b0
[   26.989750]        kernel_init+0x1a/0x130
[   26.989797]        ret_from_fork+0x2bd/0x370
[   26.989857]        ret_from_fork_asm+0x1a/0x30
[   26.989916]
[   26.989916] -> #0 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{2:2}:
[   26.990015]        check_prev_add+0xe1/0xd30
[   26.990076]        __lock_acquire+0x1561/0x1de0
[   26.990137]        lock_acquire+0xcf/0x310
[   26.990182]        _raw_spin_lock_irqsave+0x39/0x60
[   26.990240]        raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
[   26.990312]        srcu_gp_start_if_needed+0x92/0x540
[   26.990370]        bpf_selem_unlink+0x267/0x5c0
[   26.990430]        bpf_task_storage_delete+0x3a/0x90
[   26.990495]        bpf_prog_134dba630b11d3b7_scx_pmu_task_fini+0x26/0x2a
[   26.990566]        bpf_prog_4b1530d9d9852432_cosmos_exit_task+0x1d/0x1f
[   26.990636]        bpf__sched_ext_ops_exit_task+0x4b/0xa7
[   26.990694]        scx_exit_task+0x17a/0x230
[   26.990753]        sched_ext_dead+0xb2/0x120
[   26.990811]        finish_task_switch.isra.0+0x305/0x370
[   26.990870]        __schedule+0x576/0x1d60
[   26.990917]        schedule+0x3a/0x130
[   26.990962]        futex_do_wait+0x4a/0xa0
[   26.991008]        __futex_wait+0x8e/0xf0
[   26.991054]        futex_wait+0x78/0x120
[   26.991099]        do_futex+0xc5/0x190
[   26.991144]        __x64_sys_futex+0x12d/0x220
[   26.991202]        do_syscall_64+0x117/0xf80
[   26.991260]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   26.991318]
[   26.991318] other info that might help us debug this:
[   26.991318]
[   26.991400] Chain exists of:
[   26.991400]   rcu_tasks_trace_srcu_struct_srcu_usage.lock --> &p->pi_lock --> &rq->__lock
[   26.991400]
[   26.991524]  Possible unsafe locking scenario:
[   26.991524]
[   26.991592]        CPU0                    CPU1
[   26.991647]        ----                    ----
[   26.991702]   lock(&rq->__lock);
[   26.991747]                                lock(&p->pi_lock);
[   26.991816]                                lock(&rq->__lock);
[   26.991884]   lock(rcu_tasks_trace_srcu_struct_srcu_usage.lock);
[   26.991953]
[   26.991953]  *** DEADLOCK ***
[   26.991953]
[   26.992021] 3 locks held by schbench/532:
[   26.992065]  #0: ffff8df7cc154f18 (&p->pi_lock){-.-.}-{2:2}, at: _task_rq_lock+0x2c/0x100
[   26.992151]  #1: ffff8df7fb9bdae0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x24/0xb0
[   26.992250]  #2: ffffffff9cd71b20 (rcu_read_lock){....}-{1:3}, at: __bpf_prog_enter+0x64/0x110
[   26.992348]
[   26.992348] stack backtrace:
[   26.992406] CPU: 7 UID: 1000 PID: 532 Comm: schbench Not tainted 7.0.0-rc4-virtme #15 PREEMPT(full)
[   26.992409] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
[   26.992411] Sched_ext: cosmos_1.1.0_g0949d453c_x86_64_unknown^_linux_gnu (enabled+all), task: runnable_at=+0ms
[   26.992412] Call Trace:
[   26.992414]  C<TASK>
[   26.992415]  dump_stack_lvl+0x6f/0xb0
[   26.992418]  print_circular_bug.cold+0x18b/0x1d6
[   26.992422]  check_noncircular+0x165/0x190
[   26.992425]  check_prev_add+0xe1/0xd30
[   26.992428]  __lock_acquire+0x1561/0x1de0
[   26.992430]  lock_acquire+0xcf/0x310
[   26.992431]  ? raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
[   26.992434]  _raw_spin_lock_irqsave+0x39/0x60
[   26.992435]  ? raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
[   26.992437]  raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
[   26.992439]  srcu_gp_start_if_needed+0x92/0x540
[   26.992441]  bpf_selem_unlink+0x267/0x5c0
[   26.992443]  bpf_task_storage_delete+0x3a/0x90
[   26.992445]  bpf_prog_134dba630b11d3b7_scx_pmu_task_fini+0x26/0x2a
[   26.992447]  bpf_prog_4b1530d9d9852432_cosmos_exit_task+0x1d/0x1f
[   26.992448]  bpf__sched_ext_ops_exit_task+0x4b/0xa7
[   26.992449]  scx_exit_task+0x17a/0x230
[   26.992451]  sched_ext_dead+0xb2/0x120
[   26.992453]  finish_task_switch.isra.0+0x305/0x370
[   26.992455]  __schedule+0x576/0x1d60
[   26.992457]  ? find_held_lock+0x2b/0x80
[   26.992460]  schedule+0x3a/0x130
[   26.992462]  futex_do_wait+0x4a/0xa0
[   26.992463]  __futex_wait+0x8e/0xf0
[   26.992465]  ? __pfx_futex_wake_mark+0x10/0x10
[   26.992468]  futex_wait+0x78/0x120
[   26.992469]  ? find_held_lock+0x2b/0x80
[   26.992472]  do_futex+0xc5/0x190
[   26.992473]  __x64_sys_futex+0x12d/0x220
[   26.992474]  ? restore_fpregs_from_fpstate+0x48/0xd0
[   26.992477]  do_syscall_64+0x117/0xf80
[   26.992478]  ? __irq_exit_rcu+0x38/0xc0
[   26.992481]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   26.992482] RIP: 0033:0x7fe20e52eb1d

I can easily reproduce this (or the previous one) inside virtme-ng:

$ cat << EOF > /tmp/config
CONFIG_BPF=y
CONFIG_BPF_SYSCALL=y
CONFIG_BPF_JIT=y
CONFIG_DEBUG_INFO_BTF=y
CONFIG_BPF_JIT_ALWAYS_ON=y
CONFIG_BPF_JIT_DEFAULT_ON=y
CONFIG_SCHED_CLASS_EXT=y
CONFIG_KALLSYMS_ALL=y
CONFIG_FUNCTION_TRACER=y
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_AUTOGROUP=y
CONFIG_SCHED_CORE=y
CONFIG_SCHED_MC=y
CONFIG_PREEMPT=y
CONFIG_PREEMPT_DYNAMIC=y
CONFIG_DEBUG_LOCKDEP=y
CONFIG_DEBUG_ATOMIC_SLEEP=y
CONFIG_PROVE_LOCKING=y
CONFIG_BPF_EVENTS=y
CONFIG_FTRACE_SYSCALLS=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_KPROBES=y
CONFIG_KPROBE_EVENTS=y
CONFIG_UPROBES=y
CONFIG_UPROBE_EVENTS=y
CONFIG_DEBUG_FS=y
CONFIG_IKHEADERS=y
CONFIG_IKCONFIG_PROC=y
CONFIG_IKCONFIG=y
CONFIG_SCHED_CLASS_EXT=y
CONFIG_CGROUPS=y
CONFIG_CGROUP_SCHED=y
CONFIG_EXT_GROUP_SCHED=y
CONFIG_BPF=y
CONFIG_BPF_SYSCALL=y
CONFIG_DEBUG_INFO=y
CONFIG_DEBUG_INFO_BTF=y
EOF
$ vng -vb --config /tmp/config
$ vng -v -- "scx_cosmos & schbench -L -m 4 -t 48 -n 0"

Thanks,
-Andrea

> 
> >  =============================
> >  [ BUG: Invalid wait context ]
> >  7.0.0-rc1-virtme #1 Not tainted
> >  -----------------------------
> >  (udev-worker)/115 is trying to lock:
> >  ffffffffa6970dd0 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{3:3}, at: spin_lock_irqsave_ssp_contention+0x54/0x90
> >  other info that might help us debug this:
> >  context-{5:5}
> >  3 locks held by (udev-worker)/115:
> >   #0: ffff8e16c634ce58 (&p->pi_lock){-.-.}-{2:2}, at: _task_rq_lock+0x2c/0x100
> >   #1: ffff8e16fbdbdae0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x24/0xb0
> >   #2: ffffffffa6971b60 (rcu_read_lock){....}-{1:3}, at: __bpf_prog_enter+0x64/0x110
> >  ...
> >  Sched_ext: cosmos_1.0.7_g780e898fc_dirty_x86_64_unknown_linux_gnu (enabled+all), task: runnable_at=-2ms
> >  Call Trace:
> >   dump_stack_lvl+0x6f/0xb0
> >   __lock_acquire+0xf86/0x1de0
> >   lock_acquire+0xcf/0x310
> >   _raw_spin_lock_irqsave+0x39/0x60
> >   spin_lock_irqsave_ssp_contention+0x54/0x90
> >   srcu_gp_start_if_needed+0x2a7/0x490
> >   bpf_selem_unlink+0x24b/0x590
> >   bpf_task_storage_delete+0x3a/0x90
> >   bpf_prog_3b623b4be76cfb86_scx_pmu_task_fini+0x26/0x2a
> >   bpf_prog_4b1530d9d9852432_cosmos_exit_task+0x1d/0x1f
> >   bpf__sched_ext_ops_exit_task+0x4b/0xa7
> >   __scx_disable_and_exit_task+0x10a/0x200
> >   scx_disable_and_exit_task+0xe/0x60
> >
> > Fix by deferring memory deallocation to ensure it occurs outside the raw
> > spinlock context.
> >
> > Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage")
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> > [...]
