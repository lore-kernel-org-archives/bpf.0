Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794501189;
	b=A9u6rFAPP/C0HhK/kXVmR0aZiVDT7llJcu5OuEO4RV2ebSEXILpKFEcNV5YgkYSuq/KN
	 4NKDfjYxWFahNDHUc4ilb45mFjar5BTJGNTRKCDfWFp+5N5swBHc2iFjlx+YzSeGEoQMW
	 9xzjvCacfzm3L+yRFIBDO2H1CZ4HnVM5D/kRran4qzEz7dCSyGPc/nscGNvmuJyDwcBMm
	 5u0bD7UhO3hdXo7l14Dh0BeW681O1NbaEU2WVbKobwwEUEXTcgzXVLuzcY7+wK3bVErJs
	 Jk19CvdVQNsGhtXi6X0rZBjwPOGxvy5u3aKH/tiKMkBbkD21jo9bqopLr3XH6gDXB/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501189;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=hHF+n2dkWlteWW6dgMoH75PVO7coG4FSAUyuoV9GzIs=;
	b=gvkUe90R5TbZ9KF/1qWMF3ztZE3xMUd/dpz8mKfjcQ+2bnsJw9pa8RgKgU2nlajL7NrQ
	 rS0LTSi/hgXCVJ006WpfZCgErlE9YXSQNK9t3NRoniVwK47GnXZOeuGR4tK7LR0NNkYnB
	 oxAFfZNo2wv/Cwv453W3jxaclW2L9fc+oWTzw1xnAqN7XJk6q0GcxBMrBEAU5WatyHXJg
	 Cvfv8uTMU4KeOYY9dM65RkMyfMaX2o8SP4IZZCPwIThFrPn1Gakuq5AE6QNSs7pYmstuH
	 QtO26tVxFjYYNPJjy9PKPu20koP9fk5AkuE7H2Rq4GE2a+K47wDVbPCGsYXhBOfHDbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NwMuVTrq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.198.42
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB5606A323;
	Thu, 12 Nov 2026 16:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67DB5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=NwMuVTrq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OkgqOlmdDplKXPLUqwOrhY03N8+ze6PKiKvRl0q1uag+J1sPifQRzsqwiQ9BI4TLj8ElH+Y1N12Lm3qGXTvPN82ny7BpZrOcPERgumHZsDQf7KTIxaahflYx8k46UWKrG2+GdJ+akeaIyVeaFeI2fK6oJeFGIwrC0fmZIzeiET7aB9xRLJVbqbhoLzFVB+RL+UzA/gc1DgDtwo73OW7vMtSDDpcgffp3XNZ0HjvCer/UYk1zH+g+N8PLLI2O03Ri3cR1zWQ370GqjzDchwMLIcSZ5qooWM4R4qXbIfPed1jWx5VMpPvXxAmolFm9TXDhKMz3z/3folv8ztao4i8hKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHF+n2dkWlteWW6dgMoH75PVO7coG4FSAUyuoV9GzIs=;
 b=oKmTXaPpq2mkrFcbrHh+yFL0qRQf/bS1b7etUp9EGRSyYWUpmG5kYgRaiRdR7YQQbBbsLNCdViocwX4qjv3i+75/cVy25W0mm5T4hzJ+HJlOwyQKZEaQdFZoqD0n2xVtcG4ogm0MZJklw6JiFZ0Ma8DRCn+V/SHa9J9I3ONXHCvPnuVcJYP++PM1cVMwv5qHxyHncBP3byA0qX+0XoxOl0L+/rGjZC0IPVFpCYPFJY2huUBUytv1ZsOEd2j2ixwmf5cv0aSGcpJNwfu9RFQlkQ1UcRvi/Bge7VHTR29dgFK34BSKQVi5VunMLtIAFCytKUXUMsdRl9DvIPrILw7Dbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHF+n2dkWlteWW6dgMoH75PVO7coG4FSAUyuoV9GzIs=;
 b=NwMuVTrqPGL2iYJVNo+wNXb6fXBADqYig5WnNjjF7qxTu5DyBaDsMAM2n1cfqXxN6ueVblTVtR35S1zFDcA/95SUKBcmKShXD3MENYi3CT+1U1Lg2E7scbXGimxVFW7CJ0sW8WFjgkoPXB1Jec33nGYlw444yvkbRJOquMYviucSqJMsufZBg61rs52cEnUmMnmy90VXykniYf42xXJzvILDvHBgzSRoCwkvvyiLf+quWgQt3vUjVOrb4WrK/DaUny6iLny9pkcl4icnDlXjvFF5cPfAPPFamVfM3WVYvv/22rgDDdFX8T+laqsRq/GFT2Q2MF/s91CKyw6VyBDG+g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by PH8PR12MB7028.namprd12.prod.outlook.com (2603:10b6:510:1bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 16:32:48 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 16:32:47 +0000
Date: Thu, 12 Nov 2026 17:32:40 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tao Cui <cui.tao@linux.dev>, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, mingo@redhat.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 2/2] sched_ext: Block a retained donor before PI deboost
 routes it back to sched_ext
Message-ID: <avXqKIZ1ZkaH2WTh@gpd4>
References: <20261112144935.583937-1-cui.tao@linux.dev>
 <20261112144935.583937-3-cui.tao@linux.dev>
 <20261112152118.GD1813469@noisy.programming.kicks-ass.net>
 <20261112160136.GF1922751@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112160136.GF1922751@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: ZRAP278CA0016.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::26) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|PH8PR12MB7028:EE_
X-MS-Office365-Filtering-Correlation-Id: 8200c721-7748-42e0-ee24-08df40da95db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|11063799006|10067099003|4143699003|56012099006|261026121527099003|261022105027099003|261022115727099003|261026140227099003|261028144727099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hRHbhiItV4XC/obz6okkEY/+Me1TY2GWxMNu0F7NhGw9QNqamfVpfPBN/97e9S9zBnaM2DOSLZeAh5QqVSSgokE2fo16qMldTgMrX9d98VgwJlu5z/Jsef1I7f8detGBJGJ332uBPKa4PPMJDUns0d0C2OxYbRzoDeyq+uBVWUfF0ta95d+idJUGzNOqdIMReHBjsPwtcpYDnPME436w9u4oaMCDJ9qvCggIdty8PxC8LQDPrr3qUOMc1Qlv7SCRGpd/gUIbkV0p/eCIhMrFI4aqjJKCkV+E/en0Oy/fEpKv3QRIs4a/a93DLKWe7roRqdFfwtxbZ9fZFSobZPnJdWtEp9rVdjQfqVpYpDO8rRP8GVFoJyzLormfTYHDpj+3dR/92cmXFhnhyeCfd5YZvtjAE87Dbuwh3GewvIyqZ6/ZyIra2slLJgx/B9YhvgJTZK7wGzZkCjjYYZ7Lit37eWqhRLaw0DiPrnnUQzoNcmP29usxPAMTKNrMv1F54nKBM4vOpQfTaWpnd3ygVrgfaBQ7grbxfHurod5jBxkM2rXWmhnXEWLKHvW4bg9ZubFNIOZZxP7jFkETcMvUzXIyy2vqS8r2G1sUnhYODuV4y2tPgaf3BTfhTOzOQhB8hjXgGuBuQMwzKC62DAFuRRBUsRG9wnGTGdAsB5Im/HQ/DNU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(11063799006)(10067099003)(4143699003)(56012099006)(261026121527099003)(261022105027099003)(261022115727099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rw3daiW2uSpWqLfkynezfQyPeSiMjoFQJSNXRse6iJGlheKEb4KOxZZqdqnI?=
 =?us-ascii?Q?tYX1abamubzky3jqy2ROZzz0msy2BnERg+e6VKPgv3fuGkpov49ULzh1fLjw?=
 =?us-ascii?Q?vmjbns57tUZijGn2ojv/RGYGo8qC4Ef7kbAbw9+028xTYFZZVSZ4C4OEn+8x?=
 =?us-ascii?Q?ptWzKgl+65+UzrkIj3CW7PoPe61D+g8RNH318jIsfCuJN6lyBOcKaxHeq8Fe?=
 =?us-ascii?Q?XkYOwk+z1BJ8bCnzQfayueg7dnjVZpntZXRmpvfRPhWnL51Fqd10YNOZYbWL?=
 =?us-ascii?Q?HNwJvoMQed2hbbWTx560IEH4vfEG/68SNYjrPacOF1zl9iglTO9hAEfJWaq4?=
 =?us-ascii?Q?wrO02SNjNoTutT43RXjHJil3PBT6XiHxcPaFX1JD66eErwfOU/7TQS2SHz6Q?=
 =?us-ascii?Q?H+XYxco0gGHzxrmpBRPLgodric/CdPXIVVhWu3Mb7lrHWHAsMOaCCqbg8edN?=
 =?us-ascii?Q?Qxr+0oONsBVIpWzZwrMTOAdXpb71VLOw0399owBw3HwxkbscdUNPOvAmRgQ3?=
 =?us-ascii?Q?m65BAp8MHupEInNGdyS+FEx+8V14ZTHca/N2ufqC2DwQhY9R8hj1AH4AU54B?=
 =?us-ascii?Q?mkdPpFBxPZjhNpRlCw9MjmlxjgM0EaHNl7K7uosiC0/zK8b9f5HljnihBoK2?=
 =?us-ascii?Q?4IvbhzoFVm+rfPvBoRWxJf4J0rPeBzLwk6vovNepgpmkOidJDd0fn+2wDT1U?=
 =?us-ascii?Q?n0+ckHpQblz4R5U56Qq0PNNFHujx/I7uaDx6YWrvf2+fl3FrF9OZyBtX9mR3?=
 =?us-ascii?Q?/AzBfshg5IiBEp9ARjcmL503NJyzeoBrCY4U5EQJdkV3zq8LR/ADcG3bb146?=
 =?us-ascii?Q?fymfqEX/k4mdGVtCNZeKjhsuCd603YNS0Ta1FfuHev1uiLTDuHO91T0cfDgB?=
 =?us-ascii?Q?y4z9wXs5+3AYqzdPC7c6V2i5uj90EFkLMzXLgunZEVea0FYiZTTsyjFiSQgL?=
 =?us-ascii?Q?zpDmlw839P9eNaF5wRWXw/L5A0jqLNO7rwIY3XuDIpgGla0Ka7/TExmqsMOh?=
 =?us-ascii?Q?2uoMDqKl5Co1lu7tpopHjBMYPLSJFtM3DYO00koFY4RcwSVb2Wl6jmj5sn5Y?=
 =?us-ascii?Q?NlIyHgFPffSuH9af3rqjbQ8g289mg24EhBi+AZWDE9lKz0w/DDXZEKxyu72v?=
 =?us-ascii?Q?FJKoiagL77mjb1WXMnX4da1Cm1e3vJoiaj4+OdMDUhmsR8yjNgOOzRplz4kZ?=
 =?us-ascii?Q?ads9A8hFXzyVsywvGXawcaMTRVV/7UCBUBPGYA+YBJFtkwOiujBJsgwqjnr6?=
 =?us-ascii?Q?Jw+KqvDya3g3AE1km8KYH4Cr1d00FA6uZGXTzF3HX+98OU55PWjUh0ocbl0v?=
 =?us-ascii?Q?DsAXnz4i3uRfzZrsLaoEsvKkjWmMwgwg9zGuHCkHHRJfqUQuOCs3FoyyixR8?=
 =?us-ascii?Q?Jr2xxDGXo5REe91PBMOQqjuYLTUwyFIhuRMqdo50cZC0DZSgubrLen3J22td?=
 =?us-ascii?Q?VMS3N1vzIeZc0XIrGClhoFG6VbQRgl13xGkh/wkQKp2PEwc67816eZw35zqW?=
 =?us-ascii?Q?JqnyjlSm+5v3x6cMDKKvRG+bBo0YDi2Ddqmg/UehWU2MxJbexoZ0F+FR/gRw?=
 =?us-ascii?Q?ZPT+PugqakXQy/zAqVE94RK8SsctyjZVZd2Wbt4YeZBtArA5Uh7FW+ZiJEBR?=
 =?us-ascii?Q?efMgSJ7SP6OC8sL1Xk2Hhqh/DL3k1yso7tKEcKKWxzV2sq5RY2M2tZNSblFO?=
 =?us-ascii?Q?yt4n5f6iPAgILxiXs7pueN6bn9M9QwSiMeGw9IVNvJ5pEKgK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8200c721-7748-42e0-ee24-08df40da95db
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:32:47.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11qanvw9S7hfv3UZP8GdbKjfqYQejnke/K8HYt4qTI4aimndGpJVxtZ/deRPOcwwKnBxI3AZolAL5zLQLMiWPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7028

Hi Peter,

On Thu, Nov 12, 2026 at 05:01:36PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 12, 2026 at 04:21:18PM +0100, Peter Zijlstra wrote:
> > On Thu, Nov 12, 2026 at 10:49:35PM +0800, Tao Cui wrote:
> > > From: Tao Cui <cuitao@kylinos.cn>
> > > 
> > > rt_mutex_setprio() is the only entry path into sched_ext that does not
> > > block a retained donor: an ext task PI-boosted by an rt waiter can
> > > block on a second kernel mutex while boosted, and on deboost is routed
> > > back to sched_ext carrying the queued+blocked state that
> > > scx_prepare_setscheduler() promises never happens; every PI cycle
> > > hands the BPF scheduler a queued+blocked donor it never admitted.
> > > 
> > > Call scx_prepare_task_sched_change() before the sched_change guard when
> > > the class change routes the task back to sched_ext, which performs the
> > > missing sched_proxy_block_task() (plus an update_rq_clock() that is
> > > harmless here: the clock was already advanced, so the second advance
> > > only applies a small delta). The boost direction (ext -> rt) needs no
> > > handling.
> > 
> > I can't understand this. And I take a very dim view of sprinking magic
> > hooks like this. So no.
> 
> Ooh, is this the thing from here:
> 
>   https://patch.msgid.link/20260924075925.GE4121620%40noisy.programming.kicks-ass.net
> 
> where you need to block a task because ext doesn't want to support
> proxy-exec?
> 
> Why can't anybody search email these days..
> 
> Something like so? Although I note the scx_block_proxy_donor() thing has
> gotten more complicated, so perhaps this needs a little more?
> 
> Andrea?

Ah yes, our emails crossed. I was proposing to reconsider passing
next_class into sched_change_begin(), but using the existing
switching_to() callback looks like a better direction, without needing
the extra argument.

A few details below.

> 
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1a088d4576f5..1c1e669473a6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -11252,8 +11252,13 @@ void sched_change_end(struct sched_change_ctx *ctx)
>  	 */
>  	WARN_ON_ONCE(p->sched_class != ctx->class && !(ctx->flags & ENQUEUE_CLASS));
>  
> -	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
> -		p->sched_class->switching_to(rq, p);
> +	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to) {
> +		bool block = p->sched_class->switching_to(rq, p);
> +		if (block && p->is_blocked && ctx->queued) {
> +			block_task(rq, p, READ_ONCE(p->__state));
> +			ctx->queued = false;
> +		}

So at this point sched_change_begin() has already dequeued p from the
old class, but p hasn't been enqueued in the new class yet, block_task()
would dequeue it again, through the new class, and repeat the generic
dequeue accounting. I think we should complete the block without another
dequeue here.

Also, if p is rq->donor, clearing ctx->queued isn't enough: we need to
reset the donor and clear ctx->running, otherwise sched_change_end()
would call set_next_task(rq, p) for the task we just blocked.

> +	}
>  
>  	if (ctx->queued)
>  		enqueue_task(rq, p, ctx->flags);
> diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> index f74ffb3b1aca..4440e32236b3 100644
> --- a/kernel/sched/ext/ext.c
> +++ b/kernel/sched/ext/ext.c
> @@ -46,21 +46,6 @@ bool __scx_allow_proxy_exec(const struct task_struct *p)
>  	return !sch || (sch->ops.flags & SCX_OPS_ENQ_BLOCKED);
>  }
>  
> -/*
> - * End retained proxy execution before changing @p's BPF scheduler ownership.
> - * Called with @p's pi and rq locks held immediately before
> - * sched_change_begin(). The caller must pass DEQUEUE_NOCLOCK so the rq clock
> - * is updated only once.
> - */
> -void scx_prepare_task_sched_change(struct task_struct *p)
> -{
> -	lockdep_assert_held(&p->pi_lock);
> -	lockdep_assert_rq_held(task_rq(p));
> -
> -	update_rq_clock(task_rq(p));
> -	scx_block_proxy_donor(task_rq(p), p);
> -}
> -
>  /*
>   * NOTE: sched_ext is in the process of growing multiple scheduler support and
>   * scx_root usage is in a transitional state. Naked dereferences are safe if the
> @@ -5004,12 +4989,12 @@ static void prio_changed_scx(struct rq *rq, struct task_struct *p, u64 oldprio)
>  {
>  }
>  
> -static void switching_to_scx(struct rq *rq, struct task_struct *p)
> +static bool switching_to_scx(struct rq *rq, struct task_struct *p)
>  {
>  	struct scx_sched *sch = scx_task_sched(p);
>  
>  	if (task_dead_and_done(p))
> -		return;
> +		return false;
>  
>  	scx_enable_task(sch, p);
>  
> @@ -5020,6 +5005,8 @@ static void switching_to_scx(struct rq *rq, struct task_struct *p)
>  	 */
>  	if (!scx_is_cid_type() && SCX_HAS_OP(sch, set_cpumask))
>  		scx_call_op_set_cpumask(sch, rq, p, (struct cpumask *)p->cpus_ptr);
> +
> +	return !scx_allow_proxy_exec(p);
>  }
>  
>  static void switched_from_scx(struct rq *rq, struct task_struct *p)
> @@ -8947,10 +8934,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
>  
>  		if (old_class != new_class)
>  			queue_flags |= DEQUEUE_CLASS;
> -		if (new_class == &ext_sched_class) {
> -			scx_prepare_task_sched_change(p);
> +		if (new_class == &ext_sched_class)
>  			queue_flags |= DEQUEUE_NOCLOCK;
> -		}

scx_prepare_task_sched_change() also calls update_rq_clock(). With
that call removed, keeping DEQUEUE_NOCLOCK makes sched_change_begin()
skip the clock update even though we haven't done it here.

Maybe we should drop this flag too and let sched_change_begin() update
the clock.

>  
>  		scoped_guard (sched_change, p, queue_flags) {
>  			scx_set_task_slice(p, READ_ONCE(sch->slice_dfl));
> diff --git a/kernel/sched/ext/internal.h b/kernel/sched/ext/internal.h
> index ff0a3d508533..961694e4c27c 100644
> --- a/kernel/sched/ext/internal.h
> +++ b/kernel/sched/ext/internal.h
> @@ -2300,7 +2300,6 @@ struct task_struct *scx_task_iter_next_locked(struct scx_task_iter *iter);
>  bool scx_set_task_slice(struct task_struct *p, u64 slice);
>  void scx_task_slice_ended(struct rq *rq, struct task_struct *p);
>  void scx_task_unlink_from_dsq(struct task_struct *p, struct scx_dispatch_q *dsq);
> -void scx_prepare_task_sched_change(struct task_struct *p);
>  void scx_dispatch_dequeue(struct rq *rq, struct task_struct *p);
>  void scx_do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
>  			 int sticky_cpu);
> diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> index b5d92d89629b..e73f3474d685 100644
> --- a/kernel/sched/ext/sub.c
> +++ b/kernel/sched/ext/sub.c
> @@ -1647,7 +1647,6 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
>  	lockdep_assert_held(&p->pi_lock);
>  	lockdep_assert_rq_held(task_rq(p));
>  
> -	scx_prepare_task_sched_change(p);
>  	scoped_guard (sched_change, p,
>  		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {

With sub-schedulers these paths can move a task between BPF schedulers
without changing p->sched_class, so switching_to() won't run. We still
need to end the old proxy session before changing ownership, even if the
new BPF scheduler also supports proxy-exec.

Can we keep scx_prepare_task_sched_change() for these ownership changes
and use switching_to() for the actual class transitions?

>  		scx_disable_and_exit_task(scx_task_sched(p), p);
> @@ -1680,7 +1679,6 @@ static void scx_punt_task(struct scx_sched *to, struct task_struct *p)
>  	lockdep_assert_rq_held(task_rq(p));
>  	WARN_ON_ONCE(!READ_ONCE(to->bypass_depth));
>  
> -	scx_prepare_task_sched_change(p);
>  	scoped_guard (sched_change, p,
>  		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {

And ditto here.

>  		scx_disable_and_exit_task(scx_task_sched(p), p);
> @@ -2459,7 +2457,6 @@ void scx_sub_enable_workfn(struct kthread_work *work)
>  		if (!(p->scx.flags & SCX_TASK_SUB_INIT))
>  			continue;
>  
> -		scx_prepare_task_sched_change(p);
>  		scoped_guard (sched_change, p,
>  			      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
>  			/*
> diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
> index e0c10a5dbda2..cda367bd92af 100644
> --- a/kernel/sched/idle.c
> +++ b/kernel/sched/idle.c
> @@ -547,7 +547,7 @@ static void task_tick_idle(struct rq *rq, struct task_struct *curr, int queued)
>  	update_curr_idle(rq);
>  }
>  
> -static void switching_to_idle(struct rq *rq, struct task_struct *p)
> +static bool switching_to_idle(struct rq *rq, struct task_struct *p)
>  {
>  	BUG();
>  }
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 1d76950dbb0a..979c520034b1 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2782,7 +2782,7 @@ struct sched_class {
>  	 */
>  	void (*switching_from)(struct rq *this_rq, struct task_struct *task);
>  	void (*switched_from) (struct rq *this_rq, struct task_struct *task);
> -	void (*switching_to)  (struct rq *this_rq, struct task_struct *task);
> +	bool (*switching_to)  (struct rq *this_rq, struct task_struct *task);
>  	void (*switched_to)   (struct rq *this_rq, struct task_struct *task);
>  	u64  (*get_prio)     (struct rq *this_rq, struct task_struct *task);
>  	void (*prio_changed) (struct rq *this_rq, struct task_struct *task,
> diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
> index 1e0109ec36b3..b7541bb7b593 100644
> --- a/kernel/sched/stop_task.c
> +++ b/kernel/sched/stop_task.c
> @@ -78,7 +78,7 @@ static void task_tick_stop(struct rq *rq, struct task_struct *curr, int queued)
>  {
>  }
>  
> -static void switching_to_stop(struct rq *rq, struct task_struct *p)
> +static bool switching_to_stop(struct rq *rq, struct task_struct *p)
>  {
>  	BUG(); /* its impossible to change to this class */
>  }

Thanks,
-Andrea
