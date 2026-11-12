Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794502218;
	b=pm//nfd/HpPl4Fdm0UYx3jdlU9kwsAGJHUXgimYEpJ5dPU9TLvkCHBMjXMYEX+pF8d7J
	 oGFclPqwaRGkCg0eDum4LWWbVWDtVadbGXegbjGnKQ/o2L9RTFx8y//gxX34/WZd7TwH1
	 Eei2/0upO4O7AcVskxezgx5tnZX/1JjeVeEZU0xWyA+hzdjxPXB70BAOo4HNtf62/ECov
	 0ffvShUnEs05msGW6STnb0lqpOlMBr1M4spuqkVNgrvZYfC9JI/vm2R5FXArheLNiPWyR
	 I2v635SzVkQGrqqnTpOaRmphOLlzdHFx5TkaC2VZE2HrzcFdfX8rGbEyrF4y4xfsA6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502218;
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
	bh=nEox/7s3KCJTo0eexCUNYHmtIxEQlkTpXmvD1bsLzWg=;
	b=KM9lAIQyfuH9OmG90y3FJmvbhzEQHLFTSChhupc8t9zMSwKBKsZwhMt9ipo5krWlalXt
	 Eq7R698+nYOFyVYYXLwG+pqC+VM1J9O8WKPZXoa0S9bxC+KTNyAPC9fgiUAZ9xFqdWjzL
	 c2YTSOpEB7wWEXI9DExu6TpictHblGm5VPrmVvb65Dppa2RQvSDnZl23pADagxGEXYa3w
	 mSXFnfCIiB0KryFk4rt058KYTxjrJ0h5Y/tFbRS7WALAF9x9alNY6zgCukDDVds2Grjgg
	 +HHU7kFzmn3UgWAwsj0N1d9VFkjl8cbT2fjEjP9jmyG1gQK/aO/6rc3gIdyu534lBVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sMtPgAmY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.40
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD492606A31C;
	Thu, 12 Nov 2026 16:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD492606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=sMtPgAmY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTuCyxvuInlit1BVnAhS6XFRLIY4louUEsysTX0DcIxdwzsGCtMozxX9yNCdPw62qkMzVxT8vp/WyRuEu/vM6QnbKoKsIgyx6a0F4ytgaDVjFjAA8rmpIR+nirw7Z2AyCsK7Pv5t9RzZ4zqiQe7UZ+K/9A0jrbh2PPQOqJYI0QY2HTO/VU9dbV92W8Ry3p43VRcgxiv3v4oCFGs1UVygowl9LWPzoNK7wDiWAks7QztHW4avp88e71f0NSzqjie0V6OVdNumeqg0rmx6sethj3vlJzX0bxQzNzqxlqSpPn4eIfIYr/ox+wGACM1oTknh9MVT0nmzc91aoOOZrTyb5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEox/7s3KCJTo0eexCUNYHmtIxEQlkTpXmvD1bsLzWg=;
 b=O9ymwKBK4WI6R/LaT9eFxquw9IsvZdxFcicwHDDNhqBAPV2CDq9sYDjL0sHi4PbO0/rHgtxMw1kTvSSm2WsZvR22Ei+jlDbzbVChkwVIaQVrfOaw6q7H3H5eitReLyfeeyenmxb+bfentbOs2IK7ip4/at5HsSqs/5wvt8gk7RmV4vJB4nQexQfKoon6L7MJHnD8uABDjrJbnjG0Ilu9nBzvYuJnrkRoDJV8MLJaOlVsK//sNEmGstlPdOSi/0ERCWwryhP4h070ck/r8+CPbZMVniPp81wwMdg7V6/6x20nbcnkLT9GNcrDiRGqTYU4AYOgl/ti5GDNuHHme4HDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEox/7s3KCJTo0eexCUNYHmtIxEQlkTpXmvD1bsLzWg=;
 b=sMtPgAmYLgb+JrI5zPmQsRlD/D72rHwXIm3j0VUejnefprpdCtVD6Ok+soSP/DDcyNIWXP9EtKFHVQ8WIzbvepukwdBM1/4PH3+fH9cqYWTVo8j58xKhM0dxK5jLYx8uINbDSbu27UHjg5GPJOeb2QgE0iy0Wo1QXA20YIRcXnUqMpVAKEVgvCPLQ0LAqk7g5ivLWjYsdP2fZj4KpqO30bkl8YFun5KC2qU8j7AKh5TDigdSmBAvZDdtfzBgg8cImzKqNSNkvzhU8SpVbrNcobUNtCmgJcEbSkoYR3m9ovRnDv4flzRNgbY4iGw2fx6baUqnCNxZpHR+epZ5JTpXeA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SA1PR12MB6750.namprd12.prod.outlook.com (2603:10b6:806:257::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 16:50:12 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 16:50:09 +0000
Date: Thu, 12 Nov 2026 17:50:02 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tao Cui <cui.tao@linux.dev>, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, mingo@redhat.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 2/2] sched_ext: Block a retained donor before PI deboost
 routes it back to sched_ext
Message-ID: <avXuOma4eMPf2UUL@gpd4>
References: <20261112144935.583937-1-cui.tao@linux.dev>
 <20261112144935.583937-3-cui.tao@linux.dev>
 <20261112152118.GD1813469@noisy.programming.kicks-ass.net>
 <20261112160136.GF1922751@noisy.programming.kicks-ass.net>
 <avXqKIZ1ZkaH2WTh@gpd4>
 <20261112164149.GE1813469@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112164149.GE1813469@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: ZR2P278CA0066.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::20) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SA1PR12MB6750:EE_
X-MS-Office365-Filtering-Correlation-Id: 18ab664a-9ddf-4cb6-1e80-08df40dd0343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|4143699003|11063799006|56012099006|18002099003|22082099003|10067099003|261009223027099003|261028144727099003|261102123227099003|261022075727099003|261026121527099003|261022105027099003|261021121427099003|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	DMKOui0avV0bGYb9uex4zyOqpN0eF3y4YO65vpQnZYPISbC83Pbuy06wDkRtfIoFplH/Uptnh165LtaQaWApgutv/PAW1Tnv/0sVT7l97LZnhR8eL7qlhiCjg1iG/s0vxP8H1oF2TcQSQohFuHry5w+pQ295gtTpBrZOamoxzS9JBFlKtbfVy4PlbUXemUTtPbFHrf5y82Fb9hHYDDQ0k6iYDCLijzCdwtzE256jzqWdNg9E/lmW024ipUDkuhoI1He5mKct0HcNVobLg/57YKcOsSM6f6F8FtgkIA4khl+xqu6jpDQF5t+jDcSXt4mWdzYcrgTmt/laCg482/+8Nop5EyEVJg26v2/zQaGAs1uPBNRAGAfFvaYN9HHJl9RoRsSWQxbmvs6YvW/JX5S5eaNch0g27XMaUPNSOD3TzOx82neNgSrjViM+IslQiON262yxIRWDVPl+fziE04+XCKQI1MEjUDsVJ1nQXiT4SoIbJMxao+XjamoZ1eTkl2dp0bTgwDePkxPkn1JT5EtY2tMJAb70ZsXf6xhNTa+Ms6keQgUzQyduwRZoefKkzsIZ1VnJvFTvdvtk5IlU9p9aQrwtllUCktBoT58hEDjZNEBg1tTTx7cXuV9HPVwdbdgg7Q5rCSP3F4ScgHaViYO7Gk4lvt37LOzUUi5MbtYoNlQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(10067099003)(261009223027099003)(261028144727099003)(261102123227099003)(261022075727099003)(261026121527099003)(261022105027099003)(261021121427099003)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3G+/u7EpnHgkfqybBBH5a7xdkRt+/5ELi5Vj80BY6tTh+erq6OsPXEtReo4t?=
 =?us-ascii?Q?VPNuYEIR4kgX5P0AQjaOFq1dw0i14pH0sU7Rv4z0GzHoDAWlF3DPQv4e0Wp5?=
 =?us-ascii?Q?kmdsTbYbl7Uljf0MIhkM30/EDUXTgDqWbAREPmrh1MuYUxQaFNjhZbzI194x?=
 =?us-ascii?Q?vUaSGsMidyKupfntAejB13JK39OAsAE3p0OMxOZGq7ckDW8IsWxu/Eh/iDz4?=
 =?us-ascii?Q?GIdFQNP9gH2DaX9mUatndV6mPbAzHfZ3EYlUbAZYyCMfFY1sn8G/NUfe22Al?=
 =?us-ascii?Q?kIL52CqH9Ql3B4O7krZlZYf34yJPviRe0s3T+u167FlL8gDyole5+pXd4+O9?=
 =?us-ascii?Q?Z8j/27SnHt/tkMWLX3IzeTp0SPoeRYU59rRPZNzRYd3bCvuN6opeQD7idN+W?=
 =?us-ascii?Q?QxP0htrFy/sCouedOU4JG1ciqmk++ZeAV3DifytKJN/bvZk0XByna3SekN/r?=
 =?us-ascii?Q?4vrr/3jJCIWzhq+Cy6wibW1lDFsQdU8g4ZBMR8L2ANo+hMyzFuX45jmUfrJK?=
 =?us-ascii?Q?egw+7+hzV+vCT9aDl7jLCxHTCcsgRRBUETGCqTU2mC+k2GXjMpQ1cif6IRpU?=
 =?us-ascii?Q?Lu591N3GxUZ4IYgZIwNkLWYtkMlRQ6Z/BphrcNYyur4yH5r/Lapc8t5c147+?=
 =?us-ascii?Q?mFDIqyqz7cWT95kQe/FOVhxIEvKRIPPGdkqeT52YRRIvguvP0CFLmDiHz4mH?=
 =?us-ascii?Q?HUQT+YgXJWGW7Qpr8wsVWo6sAz7dLBhwehoe4ze1F7R+F4AiDlDM2REf0Lcg?=
 =?us-ascii?Q?/xW4xXCMZP9imAHqDWndhYtNXpg690E6EJWFsbi873uGEJrkKuo7EMpL0JGO?=
 =?us-ascii?Q?JSudWaDLpZRoxtVEgTCpBh1H+o/3ZsDBDhsH+qQVQCIVk7jRQ9eHT5twCP+Q?=
 =?us-ascii?Q?bZoEbo36sE9AjDXpZUzKtV3EpYbSsus7G+qc5YPYN6dpK+SQyimMV/he+txc?=
 =?us-ascii?Q?XXMzq1/McYjfMSdSgf2edzDFCan8EdmpFG4V4n/aXvQhp54Dx57TGR0qdEFH?=
 =?us-ascii?Q?I3Jgzu0uZUFho/pGvQTLh1lQy8O1nwRBQxjW5Mumuuc5BngGUJ+jYb1gSyOo?=
 =?us-ascii?Q?AWGTD9JD/dVMgQvKLuiN2/DIuFuX+mv1fRudGmJdqdB8Xsb12qtQfM9EhZXn?=
 =?us-ascii?Q?zS13XwD54jFSZrzHrvGHciwOo66Lf44hPtqXo01sC9UVggTmwFWaHGbl7QYd?=
 =?us-ascii?Q?Ttv6ZQ18FAZOzs+c2btUwi9aYYgwyd+Qpqx8HQ+702a3SCEg30MniYXTDZhF?=
 =?us-ascii?Q?he8BuAbblsas6PZyL8pglEWZnPecvhCS11KIjnjgLb6HAkMHyBppBDkSR9yP?=
 =?us-ascii?Q?lzzk5tsbAAAZ57PQGZhGDLATs5QQvcsA1MEIwGLa4ecUJXtLWusj7E9NihDO?=
 =?us-ascii?Q?SpwXsZk3NlG1Df+m9bwoPFrnuVEATPf2npf0MJGlYWyEOdSgQqW1vZ8ZbHrw?=
 =?us-ascii?Q?IKO4tEdDJ5LEf2cqTH21y4vjmR+1bYCLQBD4JrYlI9wyleBOaAcm2c0UcnVz?=
 =?us-ascii?Q?xmvomNKSsedT7ZPsniCETxpOvF1QDrCdxePRc9W8H/q+cURkVyB+kLTdIh3a?=
 =?us-ascii?Q?TLlcO9A5KfNdrIOAoXjevkjLsy0AGGki1djva7BGoJSsURHXyJL3r/myG3Hv?=
 =?us-ascii?Q?matwLglgNlO4DB3kHBhT7eI2/5XAKW/LCPs6jG03ljioKgVJF/idR/nRqD35?=
 =?us-ascii?Q?rNMivFRV84R0k1wVa5q2PCQ1TQnF3LlFPsvCXn6iRlrRlunV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ab664a-9ddf-4cb6-1e80-08df40dd0343
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:50:09.7681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QomVj+DkiUqHmF137QEGOzkrY76kqTgBwtNh+Y91Z1rgEbr8EnZYT01mqg8QoyQE54zNvH25CgO4jCebPDCLxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6750

On Thu, Nov 12, 2026 at 05:41:49PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 12, 2026 at 05:32:40PM +0100, Andrea Righi wrote:
> 
> > > 
> > > ---
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 1a088d4576f5..1c1e669473a6 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -11252,8 +11252,13 @@ void sched_change_end(struct sched_change_ctx *ctx)
> > >  	 */
> > >  	WARN_ON_ONCE(p->sched_class != ctx->class && !(ctx->flags & ENQUEUE_CLASS));
> > >  
> > > -	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to)
> > > -		p->sched_class->switching_to(rq, p);
> > > +	if ((ctx->flags & ENQUEUE_CLASS) && p->sched_class->switching_to) {
> > > +		bool block = p->sched_class->switching_to(rq, p);
> > > +		if (block && p->is_blocked && ctx->queued) {
> > > +			block_task(rq, p, READ_ONCE(p->__state));
> > > +			ctx->queued = false;
> > > +		}
> > 
> > So at this point sched_change_begin() has already dequeued p from the
> > old class, but p hasn't been enqueued in the new class yet, block_task()
> > would dequeue it again, through the new class, and repeat the generic
> > dequeue accounting. I think we should complete the block without another
> > dequeue here.
> > 
> > Also, if p is rq->donor, clearing ctx->queued isn't enough: we need to
> > reset the donor and clear ctx->running, otherwise sched_change_end()
> > would call set_next_task(rq, p) for the task we just blocked.
> 
> Right, I figured there was something missing. Can you take this patch
> and make it work?; you are more proficient with running this ext stuff
> than me.

Ack, I can take it from here and test all the nasty ext edge cases. :)

> 
> > > +	}
> > >  
> > >  	if (ctx->queued)
> > >  		enqueue_task(rq, p, ctx->flags);
> > > diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
> > > index f74ffb3b1aca..4440e32236b3 100644
> > > --- a/kernel/sched/ext/ext.c
> > > +++ b/kernel/sched/ext/ext.c
> 
> > > @@ -8947,10 +8934,8 @@ static void scx_root_enable_workfn(struct kthread_work *work)
> > >  
> > >  		if (old_class != new_class)
> > >  			queue_flags |= DEQUEUE_CLASS;
> > > -		if (new_class == &ext_sched_class) {
> > > -			scx_prepare_task_sched_change(p);
> > > +		if (new_class == &ext_sched_class)
> > >  			queue_flags |= DEQUEUE_NOCLOCK;
> > > -		}
> > 
> > scx_prepare_task_sched_change() also calls update_rq_clock(). With
> > that call removed, keeping DEQUEUE_NOCLOCK makes sched_change_begin()
> > skip the clock update even though we haven't done it here.
> > 
> > Maybe we should drop this flag too and let sched_change_begin() update
> > the clock.
> 
> Sure.
> 
> > > diff --git a/kernel/sched/ext/sub.c b/kernel/sched/ext/sub.c
> > > index b5d92d89629b..e73f3474d685 100644
> > > --- a/kernel/sched/ext/sub.c
> > > +++ b/kernel/sched/ext/sub.c
> > > @@ -1647,7 +1647,6 @@ static void scx_rehome_task(struct scx_sched *to, struct task_struct *p)
> > >  	lockdep_assert_held(&p->pi_lock);
> > >  	lockdep_assert_rq_held(task_rq(p));
> > >  
> > > -	scx_prepare_task_sched_change(p);
> > >  	scoped_guard (sched_change, p,
> > >  		      DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK) {
> > 
> > With sub-schedulers these paths can move a task between BPF schedulers
> > without changing p->sched_class, so switching_to() won't run. We still
> > need to end the old proxy session before changing ownership, even if the
> > new BPF scheduler also supports proxy-exec.
> > 
> > Can we keep scx_prepare_task_sched_change() for these ownership changes
> > and use switching_to() for the actual class transitions?
> 
> ARGH, are you *sure* you want to support crazy like that? Just have the
> thing mandate consistent proxy support.
> 
> Enforce the primary scheduler's take when loading sub-schedulers. If it
> does support proxy, dis-allow loading sub scheds that don't and
> vice-versa.
> 
> Alternatively, make the support the logical and of all sub-scheduler
> support. Ergo if one sub sched doesn't want to support proxy, nobody
> gets it.

Yeah, fair point, mixed proxy support across sub-schedulers makes this
unnecessarily complicated for zero benefit. It seems more reasonable to
make proxy exec opt-in hierarchical.

I'll look into this along with the switching_to() changes.

Thanks,
-Andrea
