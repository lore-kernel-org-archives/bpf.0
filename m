Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A45C38911E;
	Tue, 29 Sep 2026 19:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790709610; cv=fail; b=kzPxHwKCZkMQaOWEOKnVxHBSaJ+TZxGBAkWIaVzTAtH0qIwoG/0Ov1HtJALPNtHilpwthQqJwRt5isuBLuEM+v2Rw93tf2PeRqjkQn6/N1TKwEnMwl26SfoSnNL5JnUAAwVdYNgNc67n9SqRQig+JbaDhdTkzgJIoEF+GHZ+ip4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790709610; c=relaxed/simple;
	bh=DVrM7A3LuBldqzj/YTxrYRoP8CWKYdMQYhq5TLUxrIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=f+rUJJF1WM0k6tv/8zvSs1K0n9js6N02kgxSsTLlHC7WFMdBQBgz3U8JTTFa9h3VDLTgUOc25V/Qbs7n00+TFBYyPmx5eH1UF+cijLMdwK23bmZ6nFiUqfykDBc8GidC4OJaNhZQ8Vf5k9ffK3v2YyWmD4xpCUQbmNHDNWfTC34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PJZWEaet; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PJZWEaet"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y63LtvOvt7fsprxg3CSblwL55416WdTnxSKijtuxqy7/w8COz8fXj3ojMkVJoKdpXsyqW2+nhKZib1CzDpmR7kAsKHM8rXUgXBa7JAjo7JVZ5Oas0jWK6kkF4ZKcLvcD6wLhPOZaquf2SW/X1QlAHHk1Yu6j+4O8/RdKyBngyYe9s3OC+2UTb9yZ4znixXvQ/ec5MJxi1wipXZF5v5fmfH4erKxPYBRQyXepKaO/0oKLA1N0WLwwcoZlf1hEBVDvasHMouEoMTRheLbQhVHVV7gCKalimvNacLJkgJdSRVqNn1/P8LxPSLyXYEE89QLLUcMXqmzwO44Q0wkTFOwfaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zx6ZLt8mUpI8PjagzJq/Qi37X42TgGpBll4N6eOlTQY=;
 b=f6GNcdts0h8HlxWKZW46PsC9A4TOVDFpBvKIqyxUCBSjD3IjH3Ipagkx9HoChq+shAb22rAHTKRVEqczQBYvNmJVpFt7YIoLOlQsm03SI/6UIoN2TyuVJEtdPQLWcxmahytk4h989dPV2SK6PExM9vs/T8cIm5cprJaT+whLKKc9ZnQyRt5UOPl13Jdt/bktO5DDJbCbXmF0bx+EhGd6jg8AuvpztObIgSgPSAWTHEyYg/hxeX6Cy0BJJGUWR9W35iP3k8PK2JJ3EjAlwCNx1hifsCGm8SLjxwAYyEAxN3R8apX7+jpcUI97ZsTUgnwSTJAooGVH+if1d0M6SecIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zx6ZLt8mUpI8PjagzJq/Qi37X42TgGpBll4N6eOlTQY=;
 b=PJZWEaetYZWcTUTb5kuaqihHq2rI6NmP+2hVMOoTmbkDEJuQdSqeTlwOjxG0xmUTLuICDyFVzO3Pj59c0e5a8IrrdCKUKEQd/BDUQo6FFcDcyWMG4z1hlLjHCwiBJz4lYp4SexKKYW6c7q1p9k8OuQ8IhLg9Lzn8evMkrprRX40N8XtrtlaLAA2nYNRlCFTUEkqD4idMA5eycb+PD6gHW+ySvSCtG8REamjxjtrOeSAjCCO/ppj0xuM9M3B3r60EbbI4GwYljn3kjeIpDWOxwk4D7Wa00o5WIK99V8yatrIzQauznIOdvXgI6LZ6y7/+sni+xxEE0kT3wgrUNT675A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Tue, 29 Sep
 2026 19:19:58 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%6]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 19:19:58 +0000
Date: Tue, 29 Sep 2026 21:19:50 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.4] sched_ext: Work around pahole 1.32
 dropping scx_bpf_task_set_lazy_resched() from BTF
Message-ID: <arwPVufx2ZUOc_sp@gpd4>
References: <7c139810be5ffc9764ed4236efc28794@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c139810be5ffc9764ed4236efc28794@kernel.org>
X-ClientProxiedBy: MI2PEPF00000B7E.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::412) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: ba6eca95-ee45-4c4f-2674-08df1e5ea668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|56012099006|11063799006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DTdPhltc0cJ5T6XT90YTSNxOeT+0Y1rbUCslm75TGFD7Mt2yln6xsfnlBKif5/R5QLw0Dn9bxpDwpOJth/pFs7GjccfP9GmURu17o7LG7nlJyX8eaH0gKIs0L2XU2h9EylqnRiza9+3r+S3ZC9MTOykS4+ylh4RV2hH77dQBpIpiQpjaWzzwhxAuBmt1+wlxHB9bc8uxl9XXtsrsH1mlz+VnF6xw6CrJMzykOnnkWoHFVgU1WvHqpOdLKYlUmp+nmgPOAffFVKmE0foGnfoX6Pu1FG5FguBT2V82MV+3dc2NMSMZiTceCJyesBrfSkmNF+WxVtC3ssEMqG4clPKWPKr7u/FBsNWx3rpZ60x8sjfL8cJ3rBs93nJ8OSKGU8qhWlx44Nv5F5jeikPJSKE9DITJYxSpzjjrEeu6FJ9uSQhuGjg8PJudF65TiLvicixZw/GtcZ+IHjxkaGFL/0s+QNJgw4PhpVbnFE2r7N9QhWT3RSvHqPOWDXud5pntX2yzwIb5EQ6FbFdcXR4ZdUOUcKCfLn1PU8PDCewAK/QDJm4Zet6mo56q6v7O8+snMaTpfftg1YOCgH0Aa+sDBiLemxB6ZDjKz4QfLhVfVpTXqHu+tHS7Tf+s57CRfJET+m80yO52u8+mndwNs+wfR7ieLr7khTlkp/tsgRMIMc49POc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(56012099006)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+WbswySy5mSA/HtAid9cad/7iRQb9zc6wDKK3Np2xbvVWO0QYFWXksMES8ww?=
 =?us-ascii?Q?TNiOxdaNi94spWbwhf7n0QQIoynIov8iXlvSFbX2QfG3cbuTu+dxd8mQb6ms?=
 =?us-ascii?Q?7xXvXixRkix1WurRkEZo+LoMS8pT0VJhfBRa2T2Z57acOcyIctwj+7AnbwJ8?=
 =?us-ascii?Q?Mmz/iOvTXQQ5rbgGIqSyzMs5erSLrOoRWb9HIU8zJo+BYz8/ZN+SV2nnEUQh?=
 =?us-ascii?Q?GQqjg5ZFn7/QxzEB0BmBmnk6alTqreBpYv56EJKdRLleydLq5TGFJgOVRPPe?=
 =?us-ascii?Q?hNscfxKFroHcWwAtYcZBSFEn5OlB67I7vEXNSRu6l3yQcn+iBL7mYDv+oOqO?=
 =?us-ascii?Q?dw43Ju/mwHChs5qKPvDQp/UmVevtZmFBNU47q9FfSeVgZFWzq6zMHmjP43IH?=
 =?us-ascii?Q?8kzowGnNJKrQ/Jb3hm5g2s2pojKBe+oycxUQtOnNkS/NRPvhVlT2fbg0aWrq?=
 =?us-ascii?Q?tmgwXZzi5Wz1oazFz687qrCy6tqQhIdnDwgBFtZlqs/1/hhZeq5vej5grT9Z?=
 =?us-ascii?Q?ahdS05l18bOkpPI8R96GhEIYn3qYw6izpZaOCru67KgYpeoMPepmn3225+GC?=
 =?us-ascii?Q?w4bRo+RExFFH5MAQ3VqspqFZu0kMS7MQrOxjxTAZuf0pBPgf595ev7tYEJHO?=
 =?us-ascii?Q?ESZZ9JB5QmxRihQwk6SIVXVNZ0ttYuxEohkfOobdK2ys5jJZQLw/g2ZtoDb7?=
 =?us-ascii?Q?CO5tW0JReTm4rEG8O9kuj0Fqw2Oc3MlHrBb3Rbh4giseCr3FZxA9tmJiEupy?=
 =?us-ascii?Q?58I7kzGsNkzMShz1QVo/48nYtf6ieVw1ucY9wkfiVJDZ1thrqNjrf/4nhxy0?=
 =?us-ascii?Q?TmSVT+leezTiKl74N6D3zvINScqkh9neVIsiQo/HkArcF5S2KH8f6LPqpTJc?=
 =?us-ascii?Q?FxdiCgbp7iATjfkf3M8cKhKmzPw1eZ/6ttRaEPBjo7I0fXnayWmUSFV6d3wS?=
 =?us-ascii?Q?oiAk+9dUTYJYQk96MpR8ZhECpXV4AqtdMe7tmAO5dXZu4Fg/DUmuerqgZ53h?=
 =?us-ascii?Q?kB9A0vzFc3tRE+tjXX2IVBeW1w1+kZOR7TfIuxHtX5esWasayX1NCZMxmnnd?=
 =?us-ascii?Q?4Hrn+Ar5RN7k7yPFDkJPJZU55nd8OpnD/zhvYM1fzH/0qdOBc4fPaT/6yO+O?=
 =?us-ascii?Q?oq3f3kY1gOzyOmQyccl3npiLNWstoaX5/Zg9BEIlyQHoDIEvMBf7v352s2FU?=
 =?us-ascii?Q?klCBrEds7Iv1y9psFowCrBgLcutwc+lvj2cFMzIav49hgROsqdnqFz8Z5Z56?=
 =?us-ascii?Q?eyD0F86tSSOeFlhR8iXMXrDPChbIHxRqOlx/1TCNgo6+ol5cF2NESV+v8HJn?=
 =?us-ascii?Q?588Hp9OJ3NwhDACLemvx8T76k0tQlUcSSb2vSpeb3ydQYiwcz6YhwpWuKHLL?=
 =?us-ascii?Q?15JjaG3qxLQUUA000pkChTyrQN1XtmmBa197IPwKyaQFgHiPUohYyyp/Y2AK?=
 =?us-ascii?Q?swJnp3YYiBznFBnAMBqZUhG/RUT9u2RloqGQyzVG4/t2op8pmzb55wLvwHfn?=
 =?us-ascii?Q?g2r7gr3qB14CdGKogp/TIyhSVrRpk4duamhC/e7wdXFlTxCBLVNZhvMr6UTO?=
 =?us-ascii?Q?DRlO7L4I7eAbWrmmnVIHjw/jdPKijUVw9fVeW/RpT9qgclnilnuqXFF0B093?=
 =?us-ascii?Q?0V3meyqEEcXegDp1y6avjPa6Kdh5XwmqMUdsCdaG2yzaqsUyg/IREYgIjF2l?=
 =?us-ascii?Q?jDZFNJNAY1mKWcm21AnugbboAjuWWxYws7+rjfb+pjcvgRf3zPRxiTG1TuPc?=
 =?us-ascii?Q?q9oYGcJRjw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba6eca95-ee45-4c4f-2674-08df1e5ea668
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 19:19:57.9511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ngeCnL5l0IAVrSEmp/REZcvbdneBB9xIBBpO1hDclAXToxIrlUZbhicI292dX9+YjfMXV20dMwyp/IduVute8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418

Hi Tejun,

On Tue, Sep 29, 2026 at 07:32:26AM -1000, Tejun Heo wrote:
> With clang and pahole 1.32, x86-64 vmlinux BTF lacks
> scx_bpf_task_set_lazy_resched() and sched_ext fails to initialize:
> 
>   sched_ext: Failed to register kfunc sets (-22)
> 
> clang describes the lazy argument only after the prologue moves it into a
> callee-saved register, which pahole 1.32 rejects as not being the argument
> register. Released pahole is affected whatever the eventual fix. Keep the
> argument on the stack with barrier_data() so that its location names no
> register. OPTIMIZER_HIDE_VAR() would fix x86-64 but break arm64.
> 
> Fixes: f8e5a4e3f3be ("sched_ext: Add lazy preemption support")
> Link: https://lore.kernel.org/r/20260925213619.2187751-1-yonghong.song@linux.dev
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---
>  kernel/sched/ext/ext.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -10136,6 +10136,11 @@ __bpf_kfunc bool scx_bpf_task_set_lazy_r
>  {
>  	struct scx_sched *sch;
>  
> +	/*
> +	 * clang's register locations for @lazy make pahole 1.32 drop this kfunc
> +	 * from BTF. Keep @lazy in memory so its location names no register.
> +	 */
> +	barrier_data(&lazy);

First of all thanks for figuring this out, it was really annoying, I've been
holding pahole to 1.31 because of this.

I also looked a bit and it seems to be triggered specifically by the bool type.
This is with clang 22.1.8 on x86_64 without barrier_data and only changing the
type:

  bool  movl %esi, %ebp    -> dropped by pahole
  u32   movl %esi, %ebp    -> ok
  u64   movq %rsi, %r15    -> ok

With u32 the generated code is identical to the bool case, but clang keeps the
RSI entry range, so pahole is happy.

Should we just change lazy to u32 (or use a u64 flags) instead of using
barrier_data()?

Thanks,
-Andrea

>  	guard(rcu)();
>  	sch = scx_prog_sched(aux);
>  	if (unlikely(!sch || !scx_task_on_sched(sch, p)))
