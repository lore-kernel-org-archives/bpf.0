Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012037.outbound.protection.outlook.com [52.101.53.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEA0396B63;
	Tue, 17 Mar 2026 08:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735370; cv=fail; b=YuhP41Ex22nCBpiKvCwQWfwvSZIxGIIojcTj9XazczNsmMwn7d4xHC//SOKU7yTYpf8V/vM/Yt/qSuxF3ao1oDRwfrY376iTO9V9fAiHCt3E6yUfjG387suutggT+uGHdXeA+Sa013tdJGJNKmO5y1ZmJm7pGIUzWqaixZ90nys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735370; c=relaxed/simple;
	bh=wXVHUyB7yfaoxUUd0nld5M/iQyYVH6r48MJLg4n2crw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IGRIDb1pO+5R3+sWBubGh+JPnkeHqlrxtUIlRGpqYNUQYdPRBrYAA6LBYQmX2Gx958VjAvoWAtptWEo9WGK93dd/HpS0K36Y6HEvDPnvB1ql1n7S6G4c4l0RCTS9zaRQUVJUjZlEyyxXAKh8XMWicFi6QdZNnanmqtDWYR7mEqs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CbGFiwoK; arc=fail smtp.client-ip=52.101.53.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CbGFiwoK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qBzdelwkcB+cZMRp0E1KLJee1exyNmhOXyqCYA1KkfaJ3O7eGUtF5zLzC3HpGwHUJNtUQnOgC+MkdPu902UWXgsKgbnoMxgbhSfhrrX540roD6rbHNt5zTpKYMH/iRzG7IKK2WlyxZtV91qj787nJn8xJm8M+w63yLqi6TphVInh9HaZj3XtvQMSNrDF4JtIqep4g0YW2ONYo3CHzsY0BGPwBbYiGX3zEM0XQ0GqTe38HKleuVV3yEXa1SmgZBVEeGWSoHj3g4umas+VSET40KPZ35tjSM92uyZ34ge1vTvE8AWR9iGokVmivr8bC/wTI5ZbADHDO785AMnPgiGhhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvoHqeDOEpMT8mB2ZC3KUtrYkZtcoK1kVMdCYJ2D98Y=;
 b=RUcuBiere/zlnNS5odQRL7njLyZI+xMUIhEPDslxCk7DtVOh1lxz69ghbTUO9WqYqyEHwxFzsbWBeUZYpF0F2gaLeSLajK43hK9xCFbP8tINqMovxWuah9Aqly0jxmlVHe0umD9z6gNQNWmW0IiT9mi6A/UTnMD/vNybE9KruWm0PsYmwjfSvYQemsxt2zEiHwU4iN4jZoW6NWlPTYHuctM0X7q4fPgc+ACx4JatsG1Z3M9beIZRIolibpuRezXNuD9v34/YXCy5PF4Sys2+fdkkWSk2xS7WrABKDYRZGfbA1Dl+TtAmV+F/koKg06R86pXQgVnlh5xBNHqx4y0qxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cvoHqeDOEpMT8mB2ZC3KUtrYkZtcoK1kVMdCYJ2D98Y=;
 b=CbGFiwoKujKmKsfGIshHgQhwVXZTkUBkyiLw6dB+uFaQM1aj0UoPLQDCjyczOAsJz4IMsTvQiRel16augOBpgXshPVrBP08CUDU7zjbPo2+mpgkcmfC6PNVwP88sj+FhINykayXQ+5TOQThUdcRI2OB6UX59Y7Pw/pHplNvqSViVz69wr/UjOBLZhdtjr2vyRz2rTb/KN1NWnrOnytFNMv5EPXjgH3cQ3pBkRK/2dMt07rcCV47SqpPEpoO36KvghtibKvEz3Vwj1srvUE26mLbrpECPnKty87AGSWjo5A/+A2nP5uA5pZL+KILkAQ0J6E0TNWTeYyWCYFFAInVFog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB6567.namprd12.prod.outlook.com (2603:10b6:8:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 08:15:59 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9723.010; Tue, 17 Mar 2026
 08:15:59 +0000
Date: Tue, 17 Mar 2026 09:15:49 +0100
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
Message-ID: <abkNtYPMARqxXibW@gpd4>
References: <20260316222758.1558463-1-arighi@nvidia.com>
 <CAP01T75eKpvw+95NqNWg9P-1+kzVzojpN0NLat+28SF1B9wQQQ@mail.gmail.com>
 <abjzvz_tL_siV17s@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abjzvz_tL_siV17s@gpd4>
X-ClientProxiedBy: MI1P293CA0010.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::7)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB6567:EE_
X-MS-Office365-Filtering-Correlation-Id: d202af13-8ba2-419b-4f7e-08de83fd6b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1zAuk3yhVmfvJeYhFUeRdqb/Ebz3jHY1wAezJ3VXJ/vCc9uXQhvRgIloXakyJpoMIcqDJ/v4ptHKuGG2EKCyFLdu14wCGtT4+wUWyuf1siif/Y3kpRKs/oZ5UCw2C/0PQXnASavKfY86OwQMMIkqcsif15PZx87xXNdJzbses4qKL/e/CgwhqfnNNmADICtgw/NDmdZDdmSNv0WUJw6VFcWT7QiDwQYvIe2xiNgheDK4npff9tSrf0Pf5gb5K+qibm3ASzrgKIwzjgq4/CSVkMBXIVY6jjkZ3t1/M96yIh+YPAn+jAdTZXgWEAeUFwOxVyMkCjCyEcKD4Xaas4WJZsMCfnPa4Pz1LvHhyrxZEE2XQC9ghIiNUY7owe0HLUqB3KNuyfN8AgMS1xiUNi+0BpdlmLiJAJNIFfNWYg98sJ+izvhMhTIQexJhhuuS/cLbXQnf7lph3rP04BMQ+CLr9ftCcfuLfZIx+io+Gs2CQmUD8ITeEMAkaG2r1jw5C8gQVbHsDCjJyJFSM/YVYLNQCk+zNTElIV94aznr3fjRNyICE7iWsL3IfHf+pp6V8uhuwYA6kfSvmFlr00TIEEjyYjfShd5JAtQiG3uisX7ohqdaG6JP+7JI7PPvoUujJUmwRyHzrcogQe2jMSi7K6O7mq2DDATowgwafQCSGV3CGH2mozPcNbhL0RphqL1gXPwsKw+bszargLeH4mSnR5BKvCtsVyR5G1/CUq8QVdkf2eo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6b36avJeE7elZJkK4ECPsobELNBPK5+hjC2AEwzfVSrSnp96OXznL1x4GlSM?=
 =?us-ascii?Q?v+1HJ48mVOhI2NZNJ8hq5uWSvviZX0uEHS8mpNOdI4/48KQEr7EPYJp1Ztsm?=
 =?us-ascii?Q?iK9L+uYKF/Q8/HRjAs+wH+g+RzUiJjKFQ6b4IRNAGZQ9xTWuLPNsQ7WdogEk?=
 =?us-ascii?Q?M1GH2BecGuRH7dp7Q28sTviTFBd6W0rwa4wPr0k+VMTtPkpzRcRwRsvvypUs?=
 =?us-ascii?Q?l2Zv+PqiK16xuFNPHkaIwzyIY90NclJnJj2qfdT//0aO4AIgVHbsA9vhZ4sZ?=
 =?us-ascii?Q?62Z9uRnRRXh0n0hvYDV3EUPz5BAJuqdvRo+Sp4gCofA1lvhm8VC68rLzVSo0?=
 =?us-ascii?Q?Si3NI5/Jm8+2sP2aNQcZXoxf83WOLQw6HgnsbyCKp5+WfMz9NGxUUywBDGgm?=
 =?us-ascii?Q?snzBWMf30d/J2Lq9gS5346kNvEqScwXpYy0QgYBBAYMAeB0NlkOHLYSRjBny?=
 =?us-ascii?Q?YcEzSPslT69X5x4IbyNLBbe0NaRuqkFyBGk2uTnaJZZerF02uZ4HTAbe192o?=
 =?us-ascii?Q?G8O8KY+2dPiWNVCaFg6VqascizHYNhA/b1PtmQOMHsiMa74kifkj5/hPrdUC?=
 =?us-ascii?Q?B59ue6bZQ3Vz3d3D5NzaKgrBMIqWnu3g0TenBqycPAC+VHvLjiqdrHV3WqVI?=
 =?us-ascii?Q?BMYkCtJGD/nCukDoX5kUNiXnZEOviZ2/eO7n+HGdRsQdkICivtVWc0Sv/QAC?=
 =?us-ascii?Q?/amtYhyjgkiFjFPt46/6JeBcJAtKPCx9iukS1epnqAaoB7NfeoZMDAlFt69x?=
 =?us-ascii?Q?ThShYidnWdHxOm9TxIjTrIoxRMQc0kFgrjYH1kqFN87QjQ4Gp/AI6WEI7Mnx?=
 =?us-ascii?Q?lK99eTKS+9w0DY9HgoxqYSvT/5rff+5cqmR2Reel8swSUvBMCRxcqVzB+KIk?=
 =?us-ascii?Q?y2seYlXRpqluK3qMfbcMScy3QF8PkuwHaWqOOZN5wfbH7Z05GBtAZP9wD3U3?=
 =?us-ascii?Q?6EQz5xG6VZP7c84lCPcFKs4IxMc+OEPWgHKCnvYM6Q/zIROxkHcVS4E2eDv2?=
 =?us-ascii?Q?MsrXeR2lsDLwsMuU8El8oXcPixKa/pUN0q4/Lm/054ULllEj2I3IAoRk3fO5?=
 =?us-ascii?Q?Lobhumyjcw9fLB3qSLajWlOqd3KfcMkpL9CIBJarm9SvKCSp/tTssNiFBo81?=
 =?us-ascii?Q?TqeTIOn6hJbaHznQLNmH32Zjl/U2h5ZuQfjGl1JHw8saBoW33+Wschno7wCQ?=
 =?us-ascii?Q?G9QWMnUAOzuSJ/iWX0rRRAjHdQjHzNpoIqocTcDbLNNj9wf0A1UEshdsaN40?=
 =?us-ascii?Q?MKlKzkhRl493haJlQcEguz5nzesx2LyJlgs2nfC8iOSIJ+gPrmoYSdJmJcik?=
 =?us-ascii?Q?CyuxvcnO4GFWfa6d+Td1dBojIUOO9WlkLGHYKAUoU6p9CT7YVZe4d6HzrODB?=
 =?us-ascii?Q?rmimHeN2CM5mS8etreBW6ZVI5EeAl75I0kC0M5+OT80i0Eh5gXanF5Ek25IM?=
 =?us-ascii?Q?GdqC8ax1Xi9+8GxhhoY25Zb2GLNKCN4P1LWSoj7qJNt5FYakTo3mD7C6x9Qc?=
 =?us-ascii?Q?BzThrE4bEDlXwAzKkDKYWpdcs/q082uSOR9Rww6FrgaWpnShMwXw5tZ+J03W?=
 =?us-ascii?Q?Oo9f92WklJcmw3ADxeR6IUyJxk9Hus1syrX0UmFulodxZfcLLGzBT2iix0PH?=
 =?us-ascii?Q?V6kqiOjvp/Qv+AEEHdQrwL8qyKQGIfS5KcIETwxQjZMdXBoBNcabr+xSF0VN?=
 =?us-ascii?Q?arVjPB/gtF9Vrd1hTEvEqiijodWirtihdcbAPQc8XfP0siIlpkT4P0lzGN7U?=
 =?us-ascii?Q?fyT84WEqzw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d202af13-8ba2-419b-4f7e-08de83fd6b73
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 08:15:58.9698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4nrbV106EBwcTJMVtUiKUy+FxFOA8MtQL772zYwu6zPfMIA62EIOdM6wfDqKH+BUTDb9cT7A/8N3AX7a+RenfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6567

On Tue, Mar 17, 2026 at 07:25:18AM +0100, Andrea Righi wrote:
> Hi Kumar,
> 
> On Tue, Mar 17, 2026 at 12:39:00AM +0100, Kumar Kartikeya Dwivedi wrote:
> > On Mon, 16 Mar 2026 at 23:28, Andrea Righi <arighi@nvidia.com> wrote:
> > >
> > > bpf_task_storage_delete() can be invoked from contexts that hold a raw
> > > spinlock, such as sched_ext's ops.exit_task() callback, that is running
> > > with the rq lock held.
> > >
> > > The delete path eventually calls bpf_selem_unlink(), which frees the
> > > element via bpf_selem_free_list() -> bpf_selem_free(). For task storage
> > > with use_kmalloc_nolock, call_rcu_tasks_trace() is used, which is not
> > > safe from raw spinlock context, triggering the following:
> > >
> > 
> > Paul posted [0] to fix it in SRCU. It was always safe to
> > call_rcu_tasks_trace() under raw spin lock, but became problematic on
> > RT with the recent conversion that uses SRCU underneath, please give
> > [0] a spin. While I couldn't reproduce the warning using scx_cosmos, I
> > verified that it goes away for me when calling the path from atomic
> > context.
> > 
> >   [0]: https://lore.kernel.org/rcu/841c8a0b-0f50-4617-98b2-76523e13b910@paulmck-laptop
> 
> With this applied I get the following:
> 
> [   26.986798] ======================================================
> [   26.986883] WARNING: possible circular locking dependency detected
> [   26.986957] 7.0.0-rc4-virtme #15 Not tainted
> [   26.987020] ------------------------------------------------------
> [   26.987094] schbench/532 is trying to acquire lock:
> [   26.987155] ffffffff9cd70d90 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{2:2}, at: raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
> [   26.987313]
> [   26.987313] but task is already holding lock:
> [   26.987394] ffff8df7fb9bdae0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x24/0xb0
> [   26.987512]
> [   26.987512] which lock already depends on the new lock.
> [   26.987512]
> [   26.987598]
> [   26.987598] the existing dependency chain (in reverse order) is:
> [   26.987704]
> [   26.987704] -> #3 (&rq->__lock){-.-.}-{2:2}:
> [   26.987779]        lock_acquire+0xcf/0x310
> [   26.987844]        _raw_spin_lock_nested+0x2e/0x40
> [   26.987911]        raw_spin_rq_lock_nested+0x24/0xb0
> [   26.987973]        ___task_rq_lock+0x42/0x110
> [   26.988034]        wake_up_new_task+0x198/0x440
> [   26.988099]        kernel_clone+0x118/0x3c0
> [   26.988149]        user_mode_thread+0x61/0x90
> [   26.988222]        rest_init+0x1e/0x160
> [   26.988272]        start_kernel+0x7a2/0x7b0
> [   26.988329]        x86_64_start_reservations+0x24/0x30
> [   26.988392]        x86_64_start_kernel+0xd1/0xe0
> [   26.988451]        common_startup_64+0x13e/0x148
> [   26.988523]
> [   26.988523] -> #2 (&p->pi_lock){-.-.}-{2:2}:
> [   26.988598]        lock_acquire+0xcf/0x310
> [   26.988650]        _raw_spin_lock_irqsave+0x39/0x60
> [   26.988718]        try_to_wake_up+0x57/0xbb0
> [   26.988779]        create_worker+0x17e/0x200
> [   26.988839]        workqueue_init+0x28d/0x300
> [   26.988902]        kernel_init_freeable+0x134/0x2b0
> [   26.988964]        kernel_init+0x1a/0x130
> [   26.989016]        ret_from_fork+0x2bd/0x370
> [   26.989079]        ret_from_fork_asm+0x1a/0x30
> [   26.989143]
> [   26.989143] -> #1 (&pool->lock){-.-.}-{2:2}:
> [   26.989217]        lock_acquire+0xcf/0x310
> [   26.989263]        _raw_spin_lock+0x30/0x40
> [   26.989315]        __queue_work+0xdb/0x6d0
> [   26.989367]        queue_delayed_work_on+0xc7/0xe0
> [   26.989427]        srcu_gp_start_if_needed+0x3cc/0x540
> [   26.989507]        __synchronize_srcu+0xf6/0x1b0
> [   26.989567]        rcu_init_tasks_generic+0xfe/0x120
> [   26.989626]        do_one_initcall+0x6f/0x300
> [   26.989691]        kernel_init_freeable+0x24b/0x2b0
> [   26.989750]        kernel_init+0x1a/0x130
> [   26.989797]        ret_from_fork+0x2bd/0x370
> [   26.989857]        ret_from_fork_asm+0x1a/0x30
> [   26.989916]
> [   26.989916] -> #0 (rcu_tasks_trace_srcu_struct_srcu_usage.lock){....}-{2:2}:
> [   26.990015]        check_prev_add+0xe1/0xd30
> [   26.990076]        __lock_acquire+0x1561/0x1de0
> [   26.990137]        lock_acquire+0xcf/0x310
> [   26.990182]        _raw_spin_lock_irqsave+0x39/0x60
> [   26.990240]        raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
> [   26.990312]        srcu_gp_start_if_needed+0x92/0x540
> [   26.990370]        bpf_selem_unlink+0x267/0x5c0
> [   26.990430]        bpf_task_storage_delete+0x3a/0x90
> [   26.990495]        bpf_prog_134dba630b11d3b7_scx_pmu_task_fini+0x26/0x2a
> [   26.990566]        bpf_prog_4b1530d9d9852432_cosmos_exit_task+0x1d/0x1f
> [   26.990636]        bpf__sched_ext_ops_exit_task+0x4b/0xa7
> [   26.990694]        scx_exit_task+0x17a/0x230
> [   26.990753]        sched_ext_dead+0xb2/0x120
> [   26.990811]        finish_task_switch.isra.0+0x305/0x370
> [   26.990870]        __schedule+0x576/0x1d60
> [   26.990917]        schedule+0x3a/0x130
> [   26.990962]        futex_do_wait+0x4a/0xa0
> [   26.991008]        __futex_wait+0x8e/0xf0
> [   26.991054]        futex_wait+0x78/0x120
> [   26.991099]        do_futex+0xc5/0x190
> [   26.991144]        __x64_sys_futex+0x12d/0x220
> [   26.991202]        do_syscall_64+0x117/0xf80
> [   26.991260]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   26.991318]
> [   26.991318] other info that might help us debug this:
> [   26.991318]
> [   26.991400] Chain exists of:
> [   26.991400]   rcu_tasks_trace_srcu_struct_srcu_usage.lock --> &p->pi_lock --> &rq->__lock
> [   26.991400]
> [   26.991524]  Possible unsafe locking scenario:
> [   26.991524]
> [   26.991592]        CPU0                    CPU1
> [   26.991647]        ----                    ----
> [   26.991702]   lock(&rq->__lock);
> [   26.991747]                                lock(&p->pi_lock);
> [   26.991816]                                lock(&rq->__lock);
> [   26.991884]   lock(rcu_tasks_trace_srcu_struct_srcu_usage.lock);
> [   26.991953]
> [   26.991953]  *** DEADLOCK ***
> [   26.991953]
> [   26.992021] 3 locks held by schbench/532:
> [   26.992065]  #0: ffff8df7cc154f18 (&p->pi_lock){-.-.}-{2:2}, at: _task_rq_lock+0x2c/0x100
> [   26.992151]  #1: ffff8df7fb9bdae0 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x24/0xb0
> [   26.992250]  #2: ffffffff9cd71b20 (rcu_read_lock){....}-{1:3}, at: __bpf_prog_enter+0x64/0x110
> [   26.992348]
> [   26.992348] stack backtrace:
> [   26.992406] CPU: 7 UID: 1000 PID: 532 Comm: schbench Not tainted 7.0.0-rc4-virtme #15 PREEMPT(full)
> [   26.992409] Hardware name: Bochs Bochs, BIOS Bochs 01/01/2011
> [   26.992411] Sched_ext: cosmos_1.1.0_g0949d453c_x86_64_unknown^_linux_gnu (enabled+all), task: runnable_at=+0ms
> [   26.992412] Call Trace:
> [   26.992414]  C<TASK>
> [   26.992415]  dump_stack_lvl+0x6f/0xb0
> [   26.992418]  print_circular_bug.cold+0x18b/0x1d6
> [   26.992422]  check_noncircular+0x165/0x190
> [   26.992425]  check_prev_add+0xe1/0xd30
> [   26.992428]  __lock_acquire+0x1561/0x1de0
> [   26.992430]  lock_acquire+0xcf/0x310
> [   26.992431]  ? raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
> [   26.992434]  _raw_spin_lock_irqsave+0x39/0x60
> [   26.992435]  ? raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
> [   26.992437]  raw_spin_lock_irqsave_sdp_contention+0x5b/0xe0
> [   26.992439]  srcu_gp_start_if_needed+0x92/0x540
> [   26.992441]  bpf_selem_unlink+0x267/0x5c0
> [   26.992443]  bpf_task_storage_delete+0x3a/0x90
> [   26.992445]  bpf_prog_134dba630b11d3b7_scx_pmu_task_fini+0x26/0x2a
> [   26.992447]  bpf_prog_4b1530d9d9852432_cosmos_exit_task+0x1d/0x1f
> [   26.992448]  bpf__sched_ext_ops_exit_task+0x4b/0xa7
> [   26.992449]  scx_exit_task+0x17a/0x230
> [   26.992451]  sched_ext_dead+0xb2/0x120
> [   26.992453]  finish_task_switch.isra.0+0x305/0x370
> [   26.992455]  __schedule+0x576/0x1d60
> [   26.992457]  ? find_held_lock+0x2b/0x80
> [   26.992460]  schedule+0x3a/0x130
> [   26.992462]  futex_do_wait+0x4a/0xa0
> [   26.992463]  __futex_wait+0x8e/0xf0
> [   26.992465]  ? __pfx_futex_wake_mark+0x10/0x10
> [   26.992468]  futex_wait+0x78/0x120
> [   26.992469]  ? find_held_lock+0x2b/0x80
> [   26.992472]  do_futex+0xc5/0x190
> [   26.992473]  __x64_sys_futex+0x12d/0x220
> [   26.992474]  ? restore_fpregs_from_fpstate+0x48/0xd0
> [   26.992477]  do_syscall_64+0x117/0xf80
> [   26.992478]  ? __irq_exit_rcu+0x38/0xc0
> [   26.992481]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   26.992482] RIP: 0033:0x7fe20e52eb1d

With the following on top everything looks good on my side, let me know
what you think.

Thanks,
-Andrea

From: Andrea Righi <arighi@nvidia.com>
Subject: [PATCH] bpf: Avoid circular lock dependency when deleting local
 storage

Calling bpf_task_storage_delete() from a context that holds the runqueue
lock (e.g., sched_ext's ops.exit_task() callback) can lead to a circular
lock dependency:

 WARNING: possible circular locking dependency detected
 ...
 Chain exists of:
   rcu_tasks_trace_srcu_struct_srcu_usage.lock --> &p->pi_lock --> &rq->__lock

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&rq->__lock);
                                lock(&p->pi_lock);
                                lock(&rq->__lock);
   lock(rcu_tasks_trace_srcu_struct_srcu_usage.lock);

  *** DEADLOCK ***

Fix by adding a reuse_now flag to bpf_selem_unlink() with the same
meaning as in bpf_selem_free() and bpf_local_storage_free(). When the
task is in the TASK_DEAD state it will not run sleepable BPF again, so
it is safe to free storage immediately via call_rcu() instead of
call_rcu_tasks_trace() and we can prevent the circular lock dependency.

Other local storage types (sk, cgrp, inode) use reuse_now=false and keep
waiting for sleepable BPF before freeing.

Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 include/linux/bpf_local_storage.h | 2 +-
 kernel/bpf/bpf_cgrp_storage.c     | 2 +-
 kernel/bpf/bpf_inode_storage.c    | 2 +-
 kernel/bpf/bpf_local_storage.c    | 6 +++---
 kernel/bpf/bpf_task_storage.c     | 7 ++++++-
 net/core/bpf_sk_storage.c         | 2 +-
 6 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_local_storage.h b/include/linux/bpf_local_storage.h
index 8157e8da61d40..f5d4159646a83 100644
--- a/include/linux/bpf_local_storage.h
+++ b/include/linux/bpf_local_storage.h
@@ -184,7 +184,7 @@ int bpf_local_storage_map_check_btf(struct bpf_map *map,
 void bpf_selem_link_storage_nolock(struct bpf_local_storage *local_storage,
 				   struct bpf_local_storage_elem *selem);
 
-int bpf_selem_unlink(struct bpf_local_storage_elem *selem);
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now);
 
 int bpf_selem_link_map(struct bpf_local_storage_map *smap,
 		       struct bpf_local_storage *local_storage,
diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index c2a2ead1f466d..853183eead2c2 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -89,7 +89,7 @@ static int cgroup_storage_delete(struct cgroup *cgroup, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata));
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_cgrp_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_inode_storage.c b/kernel/bpf/bpf_inode_storage.c
index e86734609f3d2..470f4b02c79ea 100644
--- a/kernel/bpf/bpf_inode_storage.c
+++ b/kernel/bpf/bpf_inode_storage.c
@@ -110,7 +110,7 @@ static int inode_storage_delete(struct inode *inode, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata));
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 static long bpf_fd_inode_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 9c96a4477f81a..caa1aa5bc17c7 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -385,7 +385,7 @@ static void bpf_selem_link_map_nolock(struct bpf_local_storage_map_bucket *b,
  * Unlink an selem from map and local storage with lock held.
  * This is the common path used by local storages to delete an selem.
  */
-int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
+int bpf_selem_unlink(struct bpf_local_storage_elem *selem, bool reuse_now)
 {
 	struct bpf_local_storage *local_storage;
 	bool free_local_storage = false;
@@ -419,10 +419,10 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 out:
 	raw_res_spin_unlock_irqrestore(&local_storage->lock, flags);
 
-	bpf_selem_free_list(&selem_free_list, false);
+	bpf_selem_free_list(&selem_free_list, reuse_now);
 
 	if (free_local_storage)
-		bpf_local_storage_free(local_storage, false);
+		bpf_local_storage_free(local_storage, reuse_now);
 
 	return err;
 }
diff --git a/kernel/bpf/bpf_task_storage.c b/kernel/bpf/bpf_task_storage.c
index 605506792b5b4..0311e2cd3f3e6 100644
--- a/kernel/bpf/bpf_task_storage.c
+++ b/kernel/bpf/bpf_task_storage.c
@@ -134,7 +134,12 @@ static int task_storage_delete(struct task_struct *task, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata));
+	/*
+	 * When the task is dead it won't run sleepable BPF again, so it is
+	 * safe to reuse storage immediately.
+	 */
+	return bpf_selem_unlink(SELEM(sdata),
+				READ_ONCE(task->__state) == TASK_DEAD);
 }
 
 static long bpf_pid_task_storage_delete_elem(struct bpf_map *map, void *key)
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index f8338acebf077..d20b4b5c99ef7 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -40,7 +40,7 @@ static int bpf_sk_storage_del(struct sock *sk, struct bpf_map *map)
 	if (!sdata)
 		return -ENOENT;
 
-	return bpf_selem_unlink(SELEM(sdata));
+	return bpf_selem_unlink(SELEM(sdata), false);
 }
 
 /* Called by __sk_destruct() & bpf_sk_storage_clone() */
-- 
2.53.0

