Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B94417BEB;
	Mon, 24 Aug 2026 11:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787572537; cv=fail; b=Jg7P7pOQuq3ZBuYVJphxnemmNF8v+fvo6ZrASr1WeKdAjEeA1MeZRtHmNcSYZar+2f9PMmKgQXpPFyLqHPQ6nANyb9d4L0cYnmvKudXdszz+JyVgz0//lRm3EFz0IB5pxX+wREqEdSyx/jZaW/msTi3ubGG6KxJmddtJrK5BUzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787572537; c=relaxed/simple;
	bh=gEKznmazVAqD3aD5x5HYOQyGYj8AllAjnYlE7jToN0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ONsX3/TgSOoQmdeZ0URkQ2DlVJWIvBh+rwxo4IA3FcirY7My+1SN4QNavMqWc7teASTQQORwIKSjQOqIAMkKTeMT4EjiMq5QlXTypUqVVTs2vjacCweM02qRpiIroJ1sEET/9shZDLhcmzuLyv4hmp10BeaLbEvOy7e2LM0IcIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FOZYdgd3; arc=fail smtp.client-ip=52.101.61.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FOZYdgd3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OISKNRySUbBB0mFgsvYHS/OeLKE/9jrhkqyyeOlyt9T+ffR4PpW1oJCstlwFsm/czAO6oOgxsQeSbVX+TTaap9+ldBmtc3pZj05D7T0KpktUob4L+gzXwNCwTqQAGXB6fPctYRG0KORsZDBJivNI08vQ0SRgW/mklID01pgTmDSk0oNPG9eov67hTUmR3NvxNscU3gcee/kFXq3IKtYDkAXRlg+GUXo1J+PG80xhGvWT4yP3jfioncfWArtXV4yegQdvH6LkuRjKIDEBxl/7a+93K659/7Zq0Db1qSK+m+Vb8bVG2MyHVRJZ1y8QBxYuFfKoC8xeMax5Ym8D6ziEqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N8FQwrTLx14mKpMXPjBPT8NvdFxJOdJU4T32EjJbGg=;
 b=L6SZJMAicrZ52hwHSCrjqdUW0xaKwqg78Fh4zj2IBfMyWduCJ2YY75D4kAIfuy98H3WvuPNcCEYKY0AR8mCTz8uTdgzhm5r+LAUNZB04HcLbDtN9QuG+5eK3gUzkDCc+bPyDihdb4wmC39QE/2x1DF5VWRT+9tR+WtlAEgFPgdXguQ8GdhIhFfcbK0/np2gAD2SrmSjR/0i/6vwGC2hzgjm41ejKHvOEx3vv933s84xUtN84kwN6Nn8WRn55MLISalRp9DxJsnERusi3axmSbPp8nJx5/J8EpdOOFjDc4LSG10sj9fNALSK5nfoy1Y95MC2RMJx5ByC1AySvOHFwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N8FQwrTLx14mKpMXPjBPT8NvdFxJOdJU4T32EjJbGg=;
 b=FOZYdgd3wt45VL+qWsKNjsAcW42+mCwfbvW6L5sv+N07bAvZPsnyl6awKUYvrWfNJfZHEXdI1ZrnZDDhR0V7y8TjWi0eTGOKuxH5FQFzyDgr7nfZ4Ap0BDnhq6g5y6sGVEQXbmDeNPRVjlr+TwpIpfLiPxm0LhC4iCjABCqR4o7oruy9HFlZtiVsFztWuL38mICLXTMLbG3/0VIldA8MLUNiWRBe5O7dOVqoBSmJTH8EgkBUenWP8nHUdbsLzFrTAqp3Adyw/GyThY2rGtyN9ztJZoxquAq60A3f+QvzPcQ6xC8jBuVKGZsz9wkZ0lkyBwDOqAJwirN+vkU3a1v0Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ5PPF8AECCE022.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::99c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 11:55:31 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 11:55:30 +0000
Date: Mon, 24 Aug 2026 13:55:16 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	suzhidao@xiaomi.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v3] docs/sched_ext: document that cgroup CPU knobs are
 scheduler-dependent
Message-ID: <aowxJK_KgBLLnyiN@gpd4>
References: <20260824091501.547649-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824091501.547649-1-cui.tao@linux.dev>
X-ClientProxiedBy: MI3PEPF00007544.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4cf) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ5PPF8AECCE022:EE_
X-MS-Office365-Filtering-Correlation-Id: ca5238fc-7a30-4a6b-73ba-08df01d69871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	u0Cp6JYqRwOQAx1q6/BoFfFDM/SdCqFt9aSJ91OY1PAMRfPttiNzDJWDXdpt5sb5YOcqAks7r7U7JkgQmrePOfBrSOR3fDCCsIS5uspaC71KFTWmgodP/2S12uXKCWDRF8kYngZ2pJobP/kVCYRX+HfQuhRxDltNoFj6sGo/K0Yxj1B/CfXzaYZstSnMgNd8mU8A70/Umyodcm2PgaU19/yRNiIBRDcEUxG1iiZe4/pJJMKxYDXs0cOjQZGRSDXBWnzihrm4FFar4mEcqlJJIOszbDXud/AtYgPbK4HUh+gjrBqpxZbiwCrmGv9PJJzS0LFa5R9JAcyVPTQTi/CPUO9mcfBcrIpoh4ga1gwk0qJkQNlB06IcZUf5OZGnvkWx1CK6dAeYerC5/bpZJianrWvOl+aUCC5h5G2BNFanaSJnOI/J73UHRjnMB+EEWOsLZS0riMsJaKWaqa6LikEmcwC42s8+VaJoMHl783nWopPS7+PS/7PQAPeduWW8bIPTGgjSSoDm+VuZ1smAxfYHU7CLasZ3ugnX6ENsKZ+G4u8AJubeLjI/wpQ261MnxzNKUhxqHh8wYAh67BcnGTAf1HL6YZNs+W5aJX9E6foIHHF+jw1MauCjjyWQFz/NpHd9iu9zn4aG/fF1Wrt1FPvX5bujvqsk2y6sgnVEzLVREUI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y+5adPFMfAgsb6cHxS3tTJfGqu6WYlHCKWMtKdGpBSzQuSTEmHm/FqDelDJr?=
 =?us-ascii?Q?vrXwszQH4slgc8miHYNw+8BS3/zcJ9ANQhtQ/uVBjpbcc1JiW16hGgk6myqM?=
 =?us-ascii?Q?zdExYsqk3fj2+qkCjnWTR2Mh2cS/VX7ytQeQlDLNXgSM421fdeaX+1lC1+o1?=
 =?us-ascii?Q?NB5X5JbZfiFz4dNOdOHRAbnOwRE1iV8B/ySMT+SrbJZjE7ptC15qTSujT0+k?=
 =?us-ascii?Q?UUXsOndI1iaoICcc3gtaHqm06QAA5ZKrsDH6TX8jhmo3WXnm2mY/BK8MWl1j?=
 =?us-ascii?Q?8t/vU3/TOwAhyffRDuchEfQbn7P847shAD3ZPB6hxf3uU+MWbUX+6OScZluT?=
 =?us-ascii?Q?sqwRGjOhR0adYq/3qOKjrYrPcAm56vWqrBbxTaps7WUJ2cz9bqUWHbSLXdmq?=
 =?us-ascii?Q?lB7pk1zky/Ysa30oy5fADAgMYV1aMyNQ540NuQabrzeJRJh5tVaTXCs5AeTO?=
 =?us-ascii?Q?IIq9S85HCXdLZS9NRQQSDWClwnWxFkl80LmV7Zwc9OIlKoAD5R6gPnk5JPeF?=
 =?us-ascii?Q?xtEx9Kj2dEVlMuuRvOUCFCQjCiDlU96YLph+PMjROZZ9LvidssFSX2ILRNx+?=
 =?us-ascii?Q?T76ekvdT5A1qgYovRCVVC1X3Hr/LGp+73OfOHrDYXeYYOHr9TUFeXZZ4OBl6?=
 =?us-ascii?Q?CbCEk4Y/3JAvYOIAjH/mMKNLN+OywdohlMzSVLdc9h8QJPHTWhqrmTxltm0k?=
 =?us-ascii?Q?xMOrPITN8yIxDGiAyzv0RLFXnfdiPrsWf+urDXBLmkflkX74/sq0J/mI5PBl?=
 =?us-ascii?Q?Aac+JDcs5GsUFSwre10LIbyFXfZNY1pQddJoGRt383dFU6oF6IBFHkzlx6rn?=
 =?us-ascii?Q?ar9nWp2HxdQBIVRLVQZNdxuT5bp+uaQ/zCHZB6gHuLuj70fxaXOPr77WksOg?=
 =?us-ascii?Q?CLsnnyx4FHXm3lDyaULKyXSLD9q8ScqtQjpwrnO4COy6CR5EPeGu/L5D26T0?=
 =?us-ascii?Q?IxE0Z/z1IsCRg7Za4tdy5+SCNiLAdUAG25l9VFSRlgDl1lu7aDKdQXFczMzV?=
 =?us-ascii?Q?bewOdd6WAXoKUU9GMdEFc7LHW3J47xf5TazT/nUvSL8SZZcjfKKaBP7CRl7F?=
 =?us-ascii?Q?chX36rMViMf7Sewnkdbz48O5R0ZdFYj9dzJpJAhkweCKiUBX4i2kdcJXyxGq?=
 =?us-ascii?Q?us/x0Mk6NRVXjQPLuTvj1QYCpIysWGjdeGERsK85hCWvOPvkwjHX+Aw50ARO?=
 =?us-ascii?Q?QPmV3oFCtRbdfYOQLFE6xHNkYVWm6dwfhmhL+7jt9dys/Ls48KuMDzPKpAkK?=
 =?us-ascii?Q?SX6ZKLuQney9uU9eJkdwmxXgTsxfX+cDNW1dHvcbtb16E8lncJFfHV6TwVXY?=
 =?us-ascii?Q?J2xAzptygayelwEZVssTWzgS9ZaNh3cYzUlPnMXkXyc2XjnRqo+ZkqJWKTgA?=
 =?us-ascii?Q?vlJe4FCuNUh0hvYsowdhmiExej9O/BYKDAtnsZI3qcWID4nFYsf57nnZsZAx?=
 =?us-ascii?Q?j17re7cmGl3usb2K3CUm1TSIbY7umHrtIFONP6Q4tdtMqzNs6ChDkJdtFWKA?=
 =?us-ascii?Q?Il52eY9nJTF01ZmaVb5ZP3DuVHYIMnuZQttClIEH+LKOrUwyyWLU2qYefuB/?=
 =?us-ascii?Q?hsuMWV0v+w+DI40+ewjg9ua56cn+oCrL54F3Ek8y8LWyvuCwD3vz9G4QVBWD?=
 =?us-ascii?Q?7kX4IIOvIeIRLDTq0dLiJ1z5rDB9uAa2T2IvBwA+Mo4Rf3T2eU8RYaSPdSPq?=
 =?us-ascii?Q?pdLT8/mJaCi9HVx5jdRt04k2+u7wXMl/YQxjVcESMdm5HP1wgmZz0ZyeuMCC?=
 =?us-ascii?Q?jsW8s9DWdg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca5238fc-7a30-4a6b-73ba-08df01d69871
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 11:55:30.7412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBnIU1rrWB4oQvK801CT5oO+/pOKwfn67JlbAMoRBUgbGjS4uXfruMMMFskpehcwvfOIUP9RwSNoGAvYxrNHXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8AECCE022

Hi Tao,

On Mon, Aug 24, 2026 at 05:15:01PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> The fair class enforces cpu controller knobs such as cpu.max,
> cpu.weight and cpu.idle in the kernel. sched_ext only passes them to
> the BPF scheduler through the ops.cgroup_set_*() callbacks. Whether
> and how a knob takes effect is up to the loaded scheduler: it may
> implement the corresponding callback partially or not at all. The
> same applies to other knobs like nice levels.
> 
> Document this in the basics section so users and container
> orchestrators know what to expect from a BPF scheduler.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> ---
> v2 -> v3: Drop the scheduler list and the nr_throttled example, keep
> the section concise and generic, per review.
> 
> v2: https://lore.kernel.org/r/20260819012157.220932-1-cui.tao@linux.dev
> 
>  Documentation/scheduler/sched-ext.rst | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index 35b550671ca7..b594d93dd6aa 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -242,6 +242,18 @@ optional. The following modified excerpt is from
>              .name                   = "simple",
>      };
>  
> +Scheduler-Dependent Knobs
> +-------------------------
> +
> +The fair class enforces cpu controller knobs such as ``cpu.max``,
> +``cpu.weight`` and ``cpu.idle`` in the kernel. sched_ext only passes
> +them to the BPF scheduler through ``ops.cgroup_set_weight()``,
> +``ops.cgroup_set_idle()``, ``ops.cgroup_set_bandwidth()`` and friends.

Existing cpu.weight and bandwidth values are delivered via ops.cgroup_init(),
ops.cgroup_set_*() callbacks handle later changes.

Moreover, cpu.idle state is not included in scx_cgroup_init_args, so apparently
BPF schedulers don't receive an initial value (only subsequent writes). This
should be probably fixed separately.

> +Whether and how a knob takes effect is up to the loaded scheduler: it
> +may implement the corresponding callback partially or not at all. The
> +same applies to other knobs like nice levels. When relying on these
> +knobs, check the documentation or source of the loaded scheduler.
> +

"nice levels" can be a bit ambiguous, per-task nice changes are converted to
weights and reported through ops.set_weight(), writes to the cgroup file
cpu.weight.nice are reported through ops.cgroup_set_weight().

Maybe we can rephrase the whole paragraph as following, or something along these
lines:

  The fair-class scheduler enforces CPU controller settings such as cpu.max,
  cpu.weight, and cpu.idle. For sched_ext tasks, the scheduler core communicates
  these settings to the BPF scheduler through ops.cgroup_init() and reports
  subsequent changes through the corresponding ops.cgroup_set_*() callbacks.
  Similarly, per-task nice changes are converted to weights and reported through
  ops.set_weight().

  Each BPF scheduler is responsible for implementing the scheduling semantics of
  these settings and may choose to ignore them. Consult the loaded scheduler's
  documentation before relying on these controls.

Thanks,
-Andrea
