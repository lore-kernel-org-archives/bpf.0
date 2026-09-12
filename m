Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A70A2E718B;
	Sat, 12 Sep 2026 07:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789198460; cv=fail; b=MO5xcJUpVem11RG/KC8s3mazaDHKnPC5KOy7iaSqfcYA1aTIDT6xjHk/D7sY9PtLzX5gpz/QDu/pfV5wPGPyONnP6kJ7bkLr7kv1AW8ZhqM8pji5ETuDDj6u92G82Q5Hnnoy3Yox9o/kHTdeJlK/BORCC8wRKhRZ//+PTGXIP24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789198460; c=relaxed/simple;
	bh=eOhYCLh4Wu3Rv7UklBjTDFtk3SESpBm3D5z2TeVFNSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DEFBXPHBcgY53a+M30MVeqAHtm9ar2A1o62RK1IDWfH+ICKzso04WPqfvWo8/DS0/xaxNontKwp2B2ckmxyjoQkzhD1Hkh8iZ8xpcKK9NOaOjn7bZ0HKZOhWRn+0i7jX24eNGUalhOohBPMtAimx6w+c94gZDVEPTyivvO//YGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hldzU/cJ; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hldzU/cJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HGdHMyWbOcCSPmqZjdmg5OdkjANjX4SV+3X0b09DnRH8AY+GyDjHeoS4K2LZrweO7ez+04L4WDWjd1IsJ9H6HjLkvbyLqmAC9wumKnX7/GjW9UCBxNOhtKrdM3r2BPcpkicR+M87tiOFR27rHNDkvHYXi3Y803pCN9nKkAvvp/hBrKUTm5muh6FM04b3t0J8KZjkJ5E49mYM8zeU/1nSB7RMh/UljGpD2p4hGv4V9yNzk/ASAKkUiXaDmpxRHb8fRxufshaQ1qWGLkOTgd2bUY5J5Bd2jAW/JZ1s01QF7EYqLlsn29jeOSE/jnbJi4slC4Uu0NYIoYIfnhfQDN4GAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bR2yPOwPz346SZAFrkBPKsDs56ipVUtXr9SLoUojsXQ=;
 b=mPRZGdRY/BBuh7SfSkdXrZIFA3HgtAAg+r1GRE+UpeJoK4QrACsaDuxuM7QXBJXYqrYSkEWt9AbpJtS4okIOMj3kwRo0tBAvJxw7Q1aAJC5swu/6iwKlcr6vhFDT7U31e79vZErDDSDZnmPmkFDr6DSYGwUC91To1tHDGH2ZyU5hmhZ7OTCUNyvzdzgJwL7Gg+F3evnQMjPPHClTAr7bRSAq6ABfs3q/QzmGlyISh4/HMQY5rgEPgh4sU4UjXaaXo2CppuXzCUkwI2LkN5zFx24oFsbwr0S6lHQmQE19OBPRGuPcAdqHQorQWdgV/0j8m8qtrABxfKyzwp+g/Mp9EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR2yPOwPz346SZAFrkBPKsDs56ipVUtXr9SLoUojsXQ=;
 b=hldzU/cJKsvj7aGjTGyh0GpuKJf+FCbFN+PYyzXxNUmpJY/Y5tbTqHo6ohbqOhiWXLuVyISrhCLnJEQ91tqLFtUn5lTQlZmFvm2Ckekc9RQgF1ySUjraj1rSK1sa4hoDoZIRCVJB4dPu5yAfdjJXdC3+wBQo6uzxKo4lV67pt7QBk80zppMFKr4HcED2SBPC/liB7zjFBvrtuPnlyFD2/lKm4XXwDVriqHJN8ZHlellpq0zeKQrPi8TIale3tnjduu6nIjI7mS6OlY80KeRIWec3ZpYccRloYpIt7n6luI1ajoJpqNLx2HZHiv+kN7wrOIpGH6ihPwHnvjZG2eh3ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.11; Sat, 12 Sep
 2026 07:34:13 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%7]) with mapi id 15.21.0406.007; Sat, 12 Sep 2026
 07:34:13 +0000
Date: Sat, 12 Sep 2026 09:34:00 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sechang Lim <rhkrqnwk98@gmail.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Set need-resched flags before tracing
Message-ID: <aqUAaH6fSMhHF0EF@gpd4>
References: <20260911213300.1305763-1-arighi@nvidia.com>
 <71619AD0-A163-40DA-94B1-39052E808DDC@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71619AD0-A163-40DA-94B1-39052E808DDC@redhat.com>
X-ClientProxiedBy: MI0P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM6PR12MB4233:EE_
X-MS-Office365-Filtering-Correlation-Id: 1936e611-d8ab-4b56-d386-08df10a03dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|6133799003|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	+D/DDWopuMP0FWoxtRG0nNJ/astwJgmESHpACE1JanompD+W7yui4+G2bZLHbTjer0HO4PMSmq5zdnn7awcl6UPXhJ2qoHGMRwaAmoRXtHRO1n09yO7ZtDELN5TzRJK5DTIds6MBFvpOk90eggZctqL2Kc79G9B6MaLfP8nHFqkMfnJkjIsUh0ip4pnArdSn9OVmd8skDuUY9rckAIye1COwks0ktORtrQ9GDF0m36P1RVPJ6HSOUmf2h8sXpcP4bYczz9Ff0MViuy9Zfq5XQdYWz6b/EIK0bzQ8xSg8n0ne2MQJXtj1fbFR4dGt044b4DwYxL/p1jUBZIkyiJGKWOXb0eFNnihMMsFemT75OXzwnn9YAqLwnQCxZhHNB+pvO7gyI1lSwMyD+cCF1qgXf9UapoAl55HXsghuEAGMsUMct4d/cWn8a9RPe2DIhsenPAhgdL+qQMu+XYLB+H9WZHEUCLeKig9hoAiwId0xlsmrmuXEOM5mEIA0SNPrdcUfxIwC8zAOdeBzkGP6KKJJIp1Jc443iH46u5KGJi1IMkBNs6eI9hnG/Po6yMOo1KU3wMCuD5crvmpjmDpq1OvSek6d6xIpW+Y/Q8DElHMSKa85WC6zJb2ciogCH769rPu3z2kiJMIWwu6e2ApKhD/XPGCyxVTURVgM1qO7ESHDtIU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Ntz66b1jzVqFKsbdr5OhqNAqYXTPSBnqodVyVHkgugq7MA+VOTLI4pCYuRC?=
 =?us-ascii?Q?dz67CjQJLXG+Uxp4vBH6pRulw471z1ybc7apuKDxPOqZr1qb7ayWnFlt/i0s?=
 =?us-ascii?Q?bgnPSBrN+NdvmI2hL9MpA6jf5hlzGRIhghOzlHmiMPd66p9/OxZEdMwIGuUC?=
 =?us-ascii?Q?4G5LLm1sd+S9EZdY+lpr1E7K5zrZCa4l/0JI8CEttrgTJmqdOgDk04/5Udyu?=
 =?us-ascii?Q?32mElQ09ncBD4Y+A7T8s/oOEya7+FNzr2hf0hJCimXbfYA7HIn/7R3jJ0oYX?=
 =?us-ascii?Q?fnF8Gpi1WlSD5pFegrlg8E9ZHEAS6ESe+lCrQNE3gk+l9cleFmpUEVosL/RE?=
 =?us-ascii?Q?5K1zZBuvPcfh5IdNAKOrHLsbSmElvQnYuwSaG2sIv/8Ps3mFbFInNAk4KLD7?=
 =?us-ascii?Q?OBHbh7M8RkGBje0JgLMdDv55IjoVSyja5qeNt5F2/IIGmp4U0UdKwA15J26y?=
 =?us-ascii?Q?1zvkR3SSO5bfuj36JXxczRULfT+LbC/f2R4PVvgARVDfHIV8FArZe/mBsmH0?=
 =?us-ascii?Q?O4fbwnh509zMECTGe+Nsuau1OYyj9EBNS8IzUK7RU3+wtBdKKrFCgQ4g+Ch7?=
 =?us-ascii?Q?Db2pvkKPQ1JH+OC9THmhG8bwYkc6Ukgv4UHsEI8NOdWxubXjZAN3p6ND7WFB?=
 =?us-ascii?Q?FbCHo5N6z2IzVAZx9EypjrYN07bGvKtbaRKy/3bHCP+xjsLVgpDEyH0gNh+2?=
 =?us-ascii?Q?mrHuHUVXZ9bbJ5QTmEQax2rl06uajwOjTItazBEgkhhmKIf6KcyqVsJLSRkV?=
 =?us-ascii?Q?DNtQwqjCg2OwIdnKrLlyNaUJPBd0Kn/zmZigkI2GsjggZ8kXbrdVr7oR6mG5?=
 =?us-ascii?Q?peJ472bdKgNnoHhRLrar5vWnsXQpREKXTRixLomPwcE3rh8l+mYUgoJLr/yn?=
 =?us-ascii?Q?6t7fNZ52B8wMxySI2iwflKDJtm2g0Tsr6Y17tYRVIWPcFTNTcVcgOI63jqVQ?=
 =?us-ascii?Q?c94UVOPOYag2yGXRKa42OGO5cRFvjtNTdZ/9eJapu+NjchJFpQw8rJ54eeZD?=
 =?us-ascii?Q?GLwEy0T9EUzpGMkpnf2/agD7bg0yJDnL31f3JgGak/mRd68G9r3gCb0qwjwd?=
 =?us-ascii?Q?x5WURhF/q+aadfzA7TWkBkT29174e9Q3/8uVvf/mSpTNo68c/FhOT6FlyqV+?=
 =?us-ascii?Q?NVOkGBdBEUVVelfhfvw7a+ZzzuxyWiM28iQ7GPPf4ghl0nxxZmhKm1Jjl90m?=
 =?us-ascii?Q?kZLbRusxy6V6cS0hZvLshDtfr68hffwV5x/zjKQsQlBBTk4LAAHTZ+6B8B7C?=
 =?us-ascii?Q?LGdDTfNGKi9MdA22wnHIeRX9T0WTnj7zVz/axFo9j+LbiWd2VkovdyTKChGH?=
 =?us-ascii?Q?EsQybobr1dbpBKdzhq4F3U2Jb4IPOkK2oT3QsJ+sMVPuROnRE95Sa0iDZYxs?=
 =?us-ascii?Q?a3ezg57bNj+UGd+DdjhWUav+CwZ6qsBTpnDkf+B76xLs1lhOpM/7dMsRBeNM?=
 =?us-ascii?Q?Noivvq1wETa54kqJh7Cgnh2sYb1Ru7NLyM3W9IgLwmVChkguaKRmIRnhxosY?=
 =?us-ascii?Q?hOjVHrUtA0fprMopGZWmmgIrfKRU0utvqhY6xlYTbN+/O5hW9XoxsJo628je?=
 =?us-ascii?Q?Q4N6h8+79+Zd9MxY+acsAyY8nX+r8qr2LGJ3aPOpP0KaqBW37xCZLGNjqQhu?=
 =?us-ascii?Q?YX4ri8IxNxvJSNLapHGfM7svYNhM4pqlgnVCPkY3LQQzltKkKAIve7SVCELA?=
 =?us-ascii?Q?LH3iucHHTqqcv+UQpj4SBtTMmQ6D27ZWQYdZnwHzR+5yM4ki/SzKeT9Hdbv2?=
 =?us-ascii?Q?NmDJXTCgnA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1936e611-d8ab-4b56-d386-08df10a03dee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2026 07:34:13.1325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aY0fjpbRXLHcaLZkqHjSCCJMmuX4LkhiU9zXJPp+wKr5P2lRRQbiUUfhrKPHqvbUHtbV7wVxUc3kCTKXynAnQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233

Hi Gabriele,

On Sat, Sep 12, 2026 at 07:13:48AM +0000, Gabriele Monaco wrote:
> Il 11 settembre 2026 21:33:00 UTC, Andrea Righi <arighi@nvidia.com> ha scritto:
> >sched_set_need_resched_tp is emitted before the corresponding thread
> >flag is set. This allows a BPF tracepoint program to recursively invoke
> >the same tracepoint while leaving its RCU read-side critical section.
> >
> >If rcu_read_unlock_special() must defer a quiescent state while
> >preemption or interrupts are disabled, it calls
> >set_need_resched_current(). Since TIF_NEED_RESCHED is still clear, this
> >emits the tracepoint again and repeats until the kernel stack overflows:
> >
> >  __trace_set_need_resched()
> >    bpf_trace_run3()
> >      rcu_read_unlock_migrate()
> >        rcu_read_unlock_special()
> >          set_need_resched_current()
> >            set_tsk_need_resched()
> >              __trace_set_need_resched()
> >
> >Set the thread flag before emitting the tracepoint in both
> >set_tsk_need_resched() and __resched_curr(). For a remote reschedule,
> >retain the result of set_nr_and_not_polling() so that tracing remains
> >ahead of IPI delivery while still observing the updated flag.
> >
> >Fixes: adcc3bfa8806 ("sched: Adapt sched tracepoints for RV task model")
> >Signed-off-by: Andrea Righi <arighi@nvidia.com>
> >---
> 
> Hi Andrea,
> 
> Isn't this mostly what was done in [1]? I wonder if that patch was just forgotten.
> 
> There was a discussion that apparently didn't go anywhere, but it doesn't look like a blocker for the change to me.
> 

It is **exactly** the same fix! I hit the same issue and missed Sechang's
series. There's also a v3:
https://lore.kernel.org/all/20260630084750.2792851-1-rhkrqnwk98@gmail.com/

We can ignore this one and go with Sechang's. Sorry for the noise.

Thanks,
-Andrea

> Thanks,
> Gabriele
> 
> [1] - https://lore.kernel.org/lkml/20260627081657.499781-1-rhkrqnwk98@gmail.com
> 
> > include/linux/sched.h | 5 ++++-
> > kernel/sched/core.c   | 7 +++++--
> > 2 files changed, 9 insertions(+), 3 deletions(-)
> >
> >diff --git a/include/linux/sched.h b/include/linux/sched.h
> >index 59f6366fdf501..6003dcd080e6c 100644
> >--- a/include/linux/sched.h
> >+++ b/include/linux/sched.h
> >@@ -2105,8 +2105,11 @@ static inline int test_tsk_thread_flag(struct task_struct *tsk, int flag)
> > static inline void set_tsk_need_resched(struct task_struct *tsk)
> > {
> > 	if (tracepoint_enabled(sched_set_need_resched_tp) &&
> >-	    !test_tsk_thread_flag(tsk, TIF_NEED_RESCHED))
> >+	    !test_tsk_thread_flag(tsk, TIF_NEED_RESCHED)) {
> >+		set_tsk_thread_flag(tsk, TIF_NEED_RESCHED);
> > 		__trace_set_need_resched(tsk, TIF_NEED_RESCHED);
> >+		return;
> >+	}
> > 	set_tsk_thread_flag(tsk,TIF_NEED_RESCHED);
> > }
> > 
> >diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >index 91f059a556950..aed403fd2f82e 100644
> >--- a/kernel/sched/core.c
> >+++ b/kernel/sched/core.c
> >@@ -1196,6 +1196,7 @@ static void __resched_curr(struct rq *rq, int tif)
> > {
> > 	struct task_struct *curr = rq->curr;
> > 	struct thread_info *cti = task_thread_info(curr);
> >+	bool send_ipi;
> > 	int cpu;
> > 
> > 	lockdep_assert_rq_held(rq);
> >@@ -1212,15 +1213,17 @@ static void __resched_curr(struct rq *rq, int tif)
> > 
> > 	cpu = cpu_of(rq);
> > 
> >-	trace_sched_set_need_resched_tp(curr, cpu, tif);
> > 	if (cpu == smp_processor_id()) {
> > 		set_ti_thread_flag(cti, tif);
> > 		if (tif == TIF_NEED_RESCHED)
> > 			set_preempt_need_resched();
> >+		trace_sched_set_need_resched_tp(curr, cpu, tif);
> > 		return;
> > 	}
> > 
> >-	if (set_nr_and_not_polling(cti, tif)) {
> >+	send_ipi = set_nr_and_not_polling(cti, tif);
> >+	trace_sched_set_need_resched_tp(curr, cpu, tif);
> >+	if (send_ipi) {
> > 		if (tif == TIF_NEED_RESCHED)
> > 			smp_send_reschedule(cpu);
> > 	} else {
> 
