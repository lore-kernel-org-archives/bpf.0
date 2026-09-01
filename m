Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05FE36197E;
	Tue,  1 Sep 2026 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788245240; cv=fail; b=eveU6L7qLTLhvvKVsYUDfuaiTRDrTG6Nlx90XGnBbzqlseZyz4vGHBEfg4DsqoSPcSW0Zh4vnAdmLh6iis/ormQSaTnWJ0dURH8x8bWBD+VZ4asHUkz7sUQC5/Ri8U51ThuSfk108ryIFlYJjv0ISyRYyOXdaOJfFumYi2UO4uc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788245240; c=relaxed/simple;
	bh=vF2DDYRoTV8QzPK45X9fgbavF3vG2kvbDK7NAQ0VBjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pUpQC0c4Y4ShERqT9wyotxLcOVhUhehJmcRN5Y7UnHtHCldaePzJDtUNH3J/kDlkkSqcFGeZ/X1lmk8g+maF3JgEAwAyO+4o2WkckBFa0UZKlwEoGnJPYM7A4YVuf3WZrr1dGhG9reLZ/f/2Vy0D3pJN3fgAqDQoyRbLFZV/bfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AomL78DC; arc=fail smtp.client-ip=40.93.195.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AomL78DC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqAXdQ2E6HkkrIk9reK2k/zMKV0QwbFWHUs8n+BkwOXNXVjE+n1Aa1vmrSqLf4o19wAske0h7eJiW/E/IW1LSgh//OFgSIlQDfH8mxm5kLi4UmcSyRNwU0XI2OnH1YZ56xhh6O0rCbGH9/TyWTaqUYGFNlxnGBVtCONhylfDem1WRZd0ojfWaG/RTbeNCcCb9sSlMpyNPOySi11gZv8QSKb4in2MxS1yYP+28lYWIgFETjlvc3gez5Q1TCDJruzDOn4bNkkH40NnmF3mzifSxmypAbaqZgTbYEoSrSiWEV8+If82rlqRKxVEQ9P09LeszJA+Z6NXU+l/h3qCJ3R7Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caXY0LZnlN7tAM0ud/kbgE8GmNR1rYdypfPlEVC7jFQ=;
 b=W/cTWv3ccQsB1s9ANaqh/5hE7T0aw/FfyOIEwnwLw1wJLq02cGOY7lYOdmP99IAI9UskKY/np3NajVNr20gBV/sMRhz5KNSNNqA20U/dQd96OjX/s7l8LtP8nRTQ/HBa2NWA2BtbVVaSxEEnNZWMBjLSl5bSjC3dFJL/Idt0ZsgJSr0Abe7ZvSgpNs1p8A1yatSatsicHQeckVv3tP/TA2SQots7UAbFnXPJpSvsuwEypACtRP63hxK2EPrAlwLcIs92xA7xh3A6IoycIPfuMKUDGAMMZIX0Sl8zhHLPoFuW1FLGoaQvgXANUm0ub0/ksz0WDPhfYPzGORmgX8XynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caXY0LZnlN7tAM0ud/kbgE8GmNR1rYdypfPlEVC7jFQ=;
 b=AomL78DCsLnqWS5D5sxl3C47mo3NPRKiDf/K1YTOgzIIiKm2ZMwIrHzjZfw75JlMjf1hRdvaZSbpfC0trkmrlXMOAPuPSJsFCAFwkV9GFk0THhZJz84uz0F7XeMDGS4qtrQxJ0nh1UVbd7iSrRZ4Ukx/882ndEZI2NJK2TbXjY12ocJuuZTkKNyniZPsj2XXSnlp0vaROwZM6BHNw6gpgu4E/k+xJhhiA0LEuSY3YAtK8W24pouAMo31rwPtKc5J2sJI2UTJRX8oQLIA5awaIQap4VhZ1cRF6YNiyyLaZo3nFYJ2vIvZ/N9oaBmkYlar6v7zdFNNEGV3XUoD1crHEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by CH1PR12MB9669.namprd12.prod.outlook.com (2603:10b6:610:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 06:47:14 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 06:47:13 +0000
Date: Tue, 1 Sep 2026 08:47:04 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	michalblk@google.com, liwanwu@kylinos.cn, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 1/2] sched_ext: fix vtime priority queue inversion on
 wide vtime spread
Message-ID: <apZ06G_-oC5cTprM@gpd4>
References: <20260901024038.730424-1-cui.tao@linux.dev>
 <20260901024038.730424-2-cui.tao@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901024038.730424-2-cui.tao@linux.dev>
X-ClientProxiedBy: ZR0P278CA0165.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::18) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|CH1PR12MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e5bbf68-9e1b-4a61-220e-08df07f4daac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|4143699003|11063799006|10067099003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Qo7vRpoGeaxdoZrAwRHPPXb1KZlhJ7yykDyBABWAfZEibWtn8mfVQEG6zwAL+xX0IHJeeh/xhgCO05TEFVmgeb6+pcsmvecjxZQvOumYx2/hBe2Dkf/v4y18FqaH2nAcPYjiRgQSZ8Y95hmUt0zMBuX9InUb99x6HkVrCXUFz6UIYFcGfWb9VzJi4jdLU/0yoY/K3WlP2A4Txcv+8mxFHbu/yJLbUfQeaiqvl7/Q+BWk9Bpchfx0+nJzUzsKY10oR90tIDNg+YOGLsVSfZgufHYWVsn/U70TLdizrpOzUKcxl9Z9s1FtTVMw0UkHqFwOxJXDmi+A70LyAAy9zTcpYY8OC8GS8aJ2UiWu0eWkIUtDf4i431BYLMTa9u2RMvjC7VvuGSWE4nnkCQ3dAxR5eGCEMAvtGV8Hzg02xPYX2ulxR8Kvv1VwRafojtt5DFmzjTZixNaBvNPxPEwqXRrC1Xo9f3sF6PIrwF+eAiX3qsqTeOSWnsIrUBT37Q/O4/9HJ2Ga9dnPo5orL99VWwevnnOXO+CCwPB6XaYsOnjib5SRJx8k/am23HJk1j052hTCHDDl7gsNkGfXrg3n07sja6d1xs/ZjRU+bRue49T1f3rsytvNGmoAuKTtTZ/hriFa/aFd4aob4DygC3vCkBZ0DwgkB2sosVgCrkJ1Wag37gM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nZzquwiS+1LSvCqCG9swbxdIJSbRttpGOAgPk6Ug5uispd0ROOl3LmgQ9Prv?=
 =?us-ascii?Q?6Dkl+EkgyUzOZMuNvjlB7SrP8WzwosmGKSsCw2xBEQndnjX5+JVBoQuTva7n?=
 =?us-ascii?Q?xv/N/2ZsbdaO/GGglMKisEdyskJUYPvK65ECNdP6py6FZ1yp7LSkel37O5wc?=
 =?us-ascii?Q?sivia8Wvpac7qQUhk3KvrGfCoKHtsP+fq/LBuozDZqlf0XzoSQOypeVwP/nT?=
 =?us-ascii?Q?r2ubbdqAVi182jfWCkVGcIb7fJHS8ytcTYLQmNfAD5YR+Q9mBORljiXd2OXp?=
 =?us-ascii?Q?hkn+vbI1v3yaK7Dr7Cd0FB0fiyHZvYgClKtI2/wvpyAhrxllExtgVws59ZGx?=
 =?us-ascii?Q?lKnynFfiluSbLfffBI89IggbUZWqtijV4RgiNglxfbe9SkDe5Nnu3TzVaqFP?=
 =?us-ascii?Q?EPeDNVP5leJebZOodKBjHK5+WqbhwZvmqCS/hwTPSfC9pjvLzE0oTG7Cnxtc?=
 =?us-ascii?Q?UcL+i7RygjdE7YoytAL0YoMY4rSLoj4gpQZRTMY0wUSzyHk9Kmp4acx/dccX?=
 =?us-ascii?Q?C+VZR50dUuXFrLp/SnkHW460u8kgfO8IvFNoQOgRMgzSATaL10AAnBihE8SY?=
 =?us-ascii?Q?wGvWlOto9+EgJ0j4nqg6wimLwygihiDduYx2quMJ2Lar6ADgORqdQxIfVrdp?=
 =?us-ascii?Q?BfqXV/0du5sGZK7VoGUR212hGbvwQEaesytVuZR04s2CNXm4X0Ndh3YKCX/B?=
 =?us-ascii?Q?IMRSVIqzaZ+pf/fxs+FViqgFM56y9/IX9YGgFpffeTRT6R1dpMR/iPUntkSw?=
 =?us-ascii?Q?qaiKRhXh3Th+H0IvTrLVvrWdWdlBHcYhnyUJz55BOsN76lHuCb3V2DnAIULG?=
 =?us-ascii?Q?Vtlcd36tJ2yr15pXcG0KNSjTubLbp26VpVHaYhAn9UrhSaUe2FMz6OClEVAh?=
 =?us-ascii?Q?qbNQKlBCbjX2ch0gCYj8BZrw+HXwq7QiJNsG/ryi3dyPBmQUCqalostOXyeT?=
 =?us-ascii?Q?qoIyD8QnnoY3eSgFmFNhFUY7F+qMSbqwuSGn7KZKNkh1o5SZ0exqalrybUjr?=
 =?us-ascii?Q?KQyjq1PP8sZBpLQD3tbGTqUsgiY0ROrwij1cUFrQtBdH3L3Uo52UTk1lv4hD?=
 =?us-ascii?Q?ytFsJuz1syO5UjbXerggj32yPnnFxAn3ZOE+Y3T10C2OZYcVIPFy2ClGO2BW?=
 =?us-ascii?Q?gPjU7/KVpkB54fFjKywBjZoQ21u0hEdJzImE766HN+J3UaTFYOA0WMBjpLAK?=
 =?us-ascii?Q?PRJvS++VzbVheT50DzfR9YB2SCr/Ck7DjTVKD2sSD/kqyZxRaoZBzOTe0msA?=
 =?us-ascii?Q?U8U7dqFnQJHzxCpBb2Vty83NJjcg6/7u9hPBDi7F6GkQN08GHrg74IkmjRtq?=
 =?us-ascii?Q?IQEC7FiFDsk7tZxn6xFOf5I4PxieAFyDENtCTEhMLh5oE/uI66o/rVFyDULb?=
 =?us-ascii?Q?6f2SEKN3/UdXYqiHaUa2Thy/xpdgWf9nlMmE7NF9Eq39CLtsIkPCH6rlREn8?=
 =?us-ascii?Q?dT7YSA+bId+QcjWVfJ1EH0ZXur3UGMPfP0d+AceDfSsLrOn+7w5FElBxB3YG?=
 =?us-ascii?Q?oqle4pcQ5l0zbulZU8NipesQBWFo6DVly3/OErUisf1/SseQYhPbafFBgG9S?=
 =?us-ascii?Q?oA9ckkFWPqXn7xCuCsm/dmn45EuarYz6/zl0BHll+BP3GVdiLRGXXukA/73+?=
 =?us-ascii?Q?v/fh5ElBfsfCB2H3e+NHC7Qot4b7kn0nK5pVsXbRSs3nJXkFN1nbdz6aZQ8Q?=
 =?us-ascii?Q?mCJ5ebOGMHhgCCRc/5VcX17kNrh9He0rXRvNv4+ODIzwbVV5Bxohw22mQKXM?=
 =?us-ascii?Q?JCfoQY12CQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5bbf68-9e1b-4a61-220e-08df07f4daac
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 06:47:13.3449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yiPXNMO2v9m314yX7fu2MpS9yNRnVK0E7w5DzF7B2p2LCddMAO0N/ZuwjFYJtqB4VyvIXhlIlNUM/95zHOp+ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9669

Hi Tao,

On Tue, Sep 01, 2026 at 10:40:37AM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> scx_dsq_priq_less() compares dsq_vtime with time_before64(), a cyclic
> comparison that is only valid when the values in the queue are less
> than 2^63 apart. Unlike CFS, which enforces that invariant with
> min_vruntime clamping, sched_ext takes dsq_vtime directly from the BPF
> scheduler and cannot bound the spread. A scheduler that inserts tasks
> with vtimes wider than 2^63 apart into one DSQ gets the order inverted:
> the tasks it placed last run first and the rest starve. Reproduced with
> a probe scheduler assigning half its tasks vtimes near 0 and the other
> half vtimes above 2^63 -- four of eight busy tasks monopolized the CPU
> while the other four starved.
> 
> Compare with plain u64 < instead, which is a total order and always
> honors the order the scheduler asked for. The transient misordering
> around the natural 2^64 wrap is the same class of anomaly the cyclic
> comparison trades it for, but bounded.

I don't think switching to plain u64 ordering is safe here.

The current scx_bpf_dsq_insert_vtime() documentation explicitly defines the
ordering in terms of time_before64(), including wraparound. For example:

  a = U64_MAX - 5
  b = 3

a is earlier than b in cyclic vtime ordering. time_before64(a, b) correctly
returns true, while plain a < b would place b first.

Moreover, this is not a short transient. If post-wrap tasks continue to be
reinserted with small vtimes, a can remain behind them until their vtime
traverses almost the entire u64 range, resulting in effective starvation.

Can we preserve time_before64() and document or enforce the half-range
requirement instead?

Thanks,
-Andrea

> 
> Fixes: 06e51be3d5e7 ("sched_ext: Add vtime-ordered priority queue to dispatch_q's")
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
>  kernel/sched/ext/ext.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index 8041c87a3562..dd0ce01370d1 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -1417,7 +1417,8 @@ static bool scx_dsq_priq_less(struct rb_node *node_a,
>  	const struct task_struct *b =
>  		container_of(node_b, struct task_struct, scx.dsq_priq);
>  
> -	return time_before64(a->scx.dsq_vtime, b->scx.dsq_vtime);
> +	/* dsq_vtime is arbitrary BPF input: keep a total order */
> +	return a->scx.dsq_vtime < b->scx.dsq_vtime;
>  }
>  
>  static void dsq_inc_nr(struct scx_dispatch_q *dsq, struct task_struct *p, u64 enq_flags)
> -- 
> 2.43.0
> 
