Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012011.outbound.protection.outlook.com [40.93.195.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6CF429CD4;
	Mon, 24 Aug 2026 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787579374; cv=fail; b=j2o8cgEeugWxPWhNe6kpazuvcHMF2POuDuyaSVuYlY4+aPxf9Z5deZLZgRWP58OabI0ntWBlb5qXrGFHW9U7FL0pE2YCbHLjgCSZW41QlQCkC1oNAqV003WKVjWwgdVMI6cSlkLyZ91Kh4u5WIERo046++Y56ZKUEwRGG611SVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787579374; c=relaxed/simple;
	bh=n4SMrI7y47SrPsbB4dTPJFCQJZvFzV2ZHQTofBNiAMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wz/78DZd0wPYuOyXNdpcRRYW2J9HKKspWW6utuQLqA7DdYEqhwLL3JZm/xpsPjUCRPlj0DsYukyQ5MsXikKRPzBKMvf3Kb/I4i5+u+Hm6ustoBblbTwfsDn+FkDhJP1FMse14V7UV/FVVvbQ5XTej3Ao0QRCd0SnjYLq7qRmU2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nwOFnMEK; arc=fail smtp.client-ip=40.93.195.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nwOFnMEK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WLQZxxX76MgOT0ZpUuwZYhbqk0w2t6FbCC3/fF5CtSOlD2WPFP6kxEfUMoD56wRzWb26ljstgAsfa81Kv4o64J3jSQtdBN4JHVFJHvs5XQwmgaLLHq/0ZMrxgFVJfhnT2niYp6IgNeAkjsuZOxKs0pC9j1LmUy+fkmrPz5jMHJAsyzIYJRXhFAbEWsc8wlBfCPqHIom/1cCNfhCa7HQHBf3sZxRCMneRKY5nz3kxK+/8WJxLXsPy3LBRJlUQhJsGMrxpRpjWwjIw/yb31klaff9eVPd6k4vuF20uoVo1tre+tDGo6jGB5y7baMigcn8FizoSXe7n/5os540FoSUuRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6I11Kg5fDS0jMHm2F7khJvmU0e0aPTbRxmyXiu3xn8=;
 b=rK5iToSs+pKPuTdfgcITIGOtw3/w2ECdOvSYKguaY6d+JI/el1wHY0YQcv1HBJBONM1hAAe4YAEwnzVwg81LeHzI5Sq9Ez+YOquXWY2xypaM3X7ryPT9LZuOXnGQMgOX+gZwO3q2RAUWEkLjuTX/IbOUJDqszxVic4vJVqfevX3/f+N6VOD8kmjxmhC2pVRPRnF3MjX8yFlQQiw+eUvp4r8mPObwRM5S5q4SWyoK9E2v8Q/CU0OOpYbbpZze98ANuombyFGmFCbGxh9c6/IUIyl4nXbm8P8GQ5tTFMrRmuMZzKjoMbb7VwQb7S5pyPW55C6/ehhAX3w6hHQCTnP2zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6I11Kg5fDS0jMHm2F7khJvmU0e0aPTbRxmyXiu3xn8=;
 b=nwOFnMEKekmW1l9lburoKNKEiBFrQ+IuIxYFWb50fTSg0sX9gg80HTD/tCJ5hidiiJWJxlLtHosUm+4VRJ9am6qDW/nCvxocTbtwuJiSFSJo4ps3sFVtpQy9IGs2t9RJ6aP5HK7QjgrOButjgA4PhmhXMw0oLKgeVkXQ+LQooJn/P0uj7MzIMGNyhonLhvxUFbtX0oZmZxqGOVq7fB/KJDiv7lNo1xS3h0qVAB2n4UGyksr+3R+wNEGzDv1uutASuKm/fU6kAqByZbEiIbocAS1qeDXGOvG0hejLkWfP/sHm3Xx9Hd+UMR5cGWZmqI0M6CbRsKszHwWELwgKWnIU3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:49:29 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:49:29 +0000
Date: Mon, 24 Aug 2026 15:49:18 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	suzhidao@xiaomi.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH v4] docs/sched_ext: document that cgroup CPU knobs are
 scheduler-dependent
Message-ID: <aoxL3gADCc0X47Go@gpd4>
References: <20260824132116.560347-1-cui.tao@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824132116.560347-1-cui.tao@linux.dev>
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: 5df69acf-0fab-457f-2a2a-08df01e68496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/1/jUtKAPbvyIYjKMwhM8TK4SboKf1WXWIZTqTQKvwpyXy/3TCzsMRBAy7uKOFCr20ZVN9LfIS6dZTOKSABTwHKsEHuQX7x7e+r02v9nLTnDRO46SlPyIkmpHThATUjf44rgWv1nXN5x8b3dViL2Cygci2gTZe7bMUlGRLh3zqTtjLePXohpeNyrDf7ekue4VMQI3WS+ucXjM61sMKw2yvWcpzy+XV788RgJyDZpSshRFYXrE9IrvZZbZYy7zkW8/1s7txN7Tag9t5vZsftguQseD8LESTc84UHFcZ16PWl0BDKdes92dnnG0PNIXuV29twjyeLdWoOhC3JZ/Un7n7S/mnKRdozLhIMwYODelmM3/pCJtPSafKIj1EbEi5dwihQQY76+sP6/iOmfp6hkCMpP/dSqGHTm+rkVzFi5SXmGTtFfZkauiolXTSDIM0zUF+GbdfEbzu8sKxKR8YFFvi6q2MMIe7NGZQ2ZOojcVs5IgBO/GI+wgFqUfiT/Uqgy9mu9sLdsmsseyFXjGoihAhYyC+drdXxEGrBZnbKUcHdZo1Dr+1ODkhaCwf+lzKW4Lc7ARvhRiw7rq80dCBsOH9CpTF3YMrtj6WmxW4BAFDUrGJd5N0YefYj2e1CHfogUxuIYyl6OVLh9zo53yNDGjgk5q/8GXppwqqM2abBSLuo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/AtQYa7M8ps/z6LtGn7pAc+pVBHSqavlsqEfd7NdictIuFA34j/gfYDf1ZrO?=
 =?us-ascii?Q?e2+iLkVWkx97hwxwwSULoPuht7u8BjqpWuQ58bjUphwTNTuMpD6++8fPIZDd?=
 =?us-ascii?Q?VmJKFdkqZLpOcfflIogp/aCHKyOcgeHIM0j23n7P2zq+qm08Fn+hLSyxa4mp?=
 =?us-ascii?Q?JUDSXvcLuQD0Y3R44RF/dgyzzvbWeEdZZcm24f9Jl9vhqhdaBwVr8HOFNPZH?=
 =?us-ascii?Q?Lunk6I1zCx+wjIyXOIFpBw+Nt4e2CMrLDmRoGwomE99u1pPxs7Kha9wNUZuT?=
 =?us-ascii?Q?zQ/AALN8W0cmB5oCQYfTkG3tqBd1bCaclxL5VXvLSZj+k0Gst0fv1bqmjGec?=
 =?us-ascii?Q?DdYGDuvrOOq5e6wpuCcF3QshnP5zIN3WToVdUpLVbuzBw+XTvcya5X1ftnu2?=
 =?us-ascii?Q?lCOvSzGrfMtwi/BiQm0LqrbNMJecgaprcWF7XIiaMd9ZeNXh8kVnIrNM9wMo?=
 =?us-ascii?Q?6mwFUtLcUpGYIc9rNznyBfZP0adZChHJXTcAoCBee+S5RDFuElLHBh0h82q3?=
 =?us-ascii?Q?3NK0Xfnu3hxBdz5613kgPQXRqSqMn6QrB5qJYC8wHIkRE0Qtik7srewv86sU?=
 =?us-ascii?Q?qJMCFhWTqL2yLsdFNwAIe2yeEKqgdd15iBIiXJb/WzvoCmEa+6q/Xo/Vvmux?=
 =?us-ascii?Q?xt2/l7hQRaF/iBHiIyF/n5mn3frisZI1vZd5qq9eaXKlb8RL3iO5URC46TWX?=
 =?us-ascii?Q?QuqQSD3xkU413QC2BUlKF1/yqoDbJU3UdJzcAciAkr+ei0v3niBv1Re3V8ci?=
 =?us-ascii?Q?4ipUc9jd17xmzJGHYP9gA2NwJJUz55VxBfZiQsSTSaE+rm+0hDRIgUNK790o?=
 =?us-ascii?Q?lQrrPpu06GzOrn9wuC2ocQBSjr0J6SJHTXX/zQRxn9ckMLAOInlVyk+AfwXI?=
 =?us-ascii?Q?f6nYsYKnFdOQPog49UeMB9cX1zTWoGLtcaOrKHkiQPx5Q4SXiiAIyzQe7GSo?=
 =?us-ascii?Q?cMrmgBo17V5CAQwptQT32yrd6yG3AmDnnOXmd+rgaZAln5APLdHO5XgnfInM?=
 =?us-ascii?Q?eHZDYAbb24lrlRI+SvQw5JmJJzU2d49D0cALxvVtq+wsKzYFVf+8zdnreY7K?=
 =?us-ascii?Q?ZlP8pHktPHw82BAf3wu20HG3sz2HIz1aAakcwrpJ6nb8/CY0+2YFPpbV/3eA?=
 =?us-ascii?Q?+7/yiu1V1k3ekWwGnW3DyN67fx9F65RSnDcaHGaNlxkafxJ3xtb+faVy7aYH?=
 =?us-ascii?Q?Ud5l/hsNJ1zkHemr3q0NLbTw3pzNhTnmNJMjlDTTJK5g0vfpWXuBd/rkRxTN?=
 =?us-ascii?Q?y2O24EesZCMS2FhZpnOmj2V6n6EfjXrABBHkAum2oNAjW+LKSwRtgBncUsME?=
 =?us-ascii?Q?wBuFkd4pOJ3pG/7+om981BiWXkhiWDsrwZt/9281SaNRPmVkbT/peqISlFCu?=
 =?us-ascii?Q?9FBkUApAZeVwC3x+R5DQv22biJEXPzPgJ4eIGUvVqT74DWWTUOyRHM15VUVN?=
 =?us-ascii?Q?2qRxngPKEmWn3ZTCSXc/EsUZANhIoNZnBvUPPCBPhPh0ygVM4Xk5coaoms+p?=
 =?us-ascii?Q?cwX1lmHQlRcVrVqjpKfOL3Wax7xfTn/2AA7m10PRmFTIhUqD4hh7YORZcRY2?=
 =?us-ascii?Q?j/uzmHBpqIZ3pAh1Og9/3buSmxu/bwq2i1Nxiond0SKV4c/O2JIW8cv3kWlR?=
 =?us-ascii?Q?667Xf9c6y9uLXe5AItI2GmDor4cyh36qo/Lwbt5xp5/qVocEgQlTK0x1p4MZ?=
 =?us-ascii?Q?4oZKv3BtcNObPzv3778pjrYRPcs4KCKBTZGmyUEfo+sDapOTPxXcChP6BF2u?=
 =?us-ascii?Q?5FOomnWWoA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df69acf-0fab-457f-2a2a-08df01e68496
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:49:29.0745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /nCj/pvP2A7lvXVLQfisYfKmCB0lfCX4DCYCPtLvNz6g4EL0ChLfKuvOVFCv+e0pMjYGRhj3oZ4HT2kMyinDmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667

On Mon, Aug 24, 2026 at 09:21:16PM +0800, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> The scheduler core communicates the initial cpu controller settings
> to the BPF scheduler through ops.cgroup_init() and reports subsequent
> changes through the corresponding ops.cgroup_set_*() callbacks.
> Whether and how a knob takes effect is up to the loaded scheduler:
> it may implement the corresponding callback partially or not at all,
> so cpu.max, cpu.weight and friends can silently have no effect.
> 
> Document this in the basics section of sched-ext.rst.
> 
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

Looks good to me now.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
> v3 -> v4: Rephrase per Andrea's suggestion: mention ops.cgroup_init()
> for the initial values, ops.cgroup_set_*() only for subsequent
> changes, and disambiguate per-task nice (ops.set_weight()) from
> cpu.weight.nice.
> 
> v3: https://lore.kernel.org/r/20260824091501.547649-1-cui.tao@linux.dev
> 
>  Documentation/scheduler/sched-ext.rst | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
> index 35b550671ca7..794ae80b3ba3 100644
> --- a/Documentation/scheduler/sched-ext.rst
> +++ b/Documentation/scheduler/sched-ext.rst
> @@ -242,6 +242,21 @@ optional. The following modified excerpt is from
>              .name                   = "simple",
>      };
>  
> +Scheduler-Dependent Knobs
> +-------------------------
> +
> +The fair-class scheduler enforces CPU controller settings such as
> +``cpu.max``, ``cpu.weight`` and ``cpu.idle``. For sched_ext tasks, the
> +scheduler core communicates these settings to the BPF scheduler
> +through ``ops.cgroup_init()`` and reports subsequent changes through
> +the corresponding ``ops.cgroup_set_*()`` callbacks. Similarly, per-task
> +nice changes are converted to weights and reported through
> +``ops.set_weight()``.
> +
> +Each BPF scheduler is responsible for implementing the scheduling
> +semantics of these settings and may choose to ignore them. Consult the
> +loaded scheduler's documentation before relying on these controls.
> +
>  Dispatch Queues
>  ---------------
>  
> -- 
> 2.43.0
> 
