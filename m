Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794499605;
	b=AJn5gzQA7mEAHLWRQ7DYB7G+u8KZfTzu4VKgIW6l0rQ1dVTrC1CuPJ0ow+HAOF7EIp2n
	 2bP6lLUeZBioOwoEtEDy3+gKMla9ur/mrQMpLhwtby2orvFC8cpmgaV1zG9K3fO2ad+GY
	 xP6A97ZiwlwGYfCkhz9WvlmNv46jOoEj3MMuE0BCIN4COM/qwCSDDLHxX3NHE2Dn2ZjZc
	 aA3ZTWAoDc/WRZZRQfJqGGBA0sxH3P8UKuZ+c7bdVcNcNSb9bGHNdfskOxe3Nnm83EA4E
	 GpAa9z9kfQg7CaKXtnQp/5je8YCsEmNkzJv4b3x5XUpmxe37Rkh/cWfWjglsGqkLxyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499605;
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
	bh=6MmXx0cIG1BO5Vq6gjwpdVoZ25cbH6TfLdbwi6a23iI=;
	b=w4j4SnFw+xq8wyFD4pW7BqyHYMCCzioL02rkOI79VQ+i/5c1onLZZvA1qX4B1ybeAJPp
	 X7hZ4QVrtiJpHkwdkWlGFsSnw5/y/PIdRDEZKWaV6R1lljmMFLuYLOUNUHd0A1OR0CHeB
	 w+uzpEe1D2ADp7fkmDw+p/6qNWxMRfjh34YZ8xewhim37AOhUbfkn2RZGU10PJ/dRVm1B
	 /jVp5AXhpiIwzI4P7DoGzXVw8GgRil6JH8W92ar4iW6v3uzRkVhV4vDR0kQdAUYbTzhUI
	 8Ibqel0zvYUeseQZ/Ukve+wZaBe+jt1J0bZJ3eXgYL+dzruFoa0RhT8ULRUW/sAh6tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Z7euJp4x;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.28
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010028.outbound.protection.outlook.com [52.101.56.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472C3606A327;
	Thu, 12 Nov 2026 16:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 472C3606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Z7euJp4x
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M814BBsy8lz5x9sOYsUIatxaZY9pDN4sscfVM/l19GTRlerq2vmENWxDGcXXnftwIf9FCPs3Zhl/SyE6iTBJ5mbxqx2qIyo2EKgviZiwVZvmTdMshKNLS/Kp3QKxSPYhybf1aMRzyxB5ncc+jP+u+Gv7uM7dQUtpp/jDurK9ihhyKywZIQiSr0RcNWbA2cH/JCmlSU/i6LjH8IPXNCojiP/Cqe5AWPWhYbAhG7wfCxcJrInfoTzVpCKQoDXOfza6qwcX8bg+H2boC6Rp8ovX1l73Jm9CzEH8W7xYJFm5SC8Oel028xndbpOXzHqfoPh9BghUXO4bnG4yUgyi3+ezpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MmXx0cIG1BO5Vq6gjwpdVoZ25cbH6TfLdbwi6a23iI=;
 b=NUvKf8nSfqaQWFDATdrFiUFCXt35pyOxMqnUN0JgBcCRIxitveHnLyL+e5K2uqG8CthkB9K/6M9kKlvOL8xMpU29C2MoIdMh/4Sr5x4eHNfSAN+L62EyxuAPscj56XB+MFULvIMqkq8BlmO1DHvvTy5+EqdPr8vtsVWC5C08yoF6ZdVlYujlCXv0GzZ4RiFpPYX0KGZF05mLuRbwl0YpH0Zeetg3RjtpJ+vaVXwpcctiBXZBizORtEskfKQcYW8EaMB9fFEz9X9O44U3LZuKCghgdu+OHQu4K7p3UD/mp6FB94Ca50jaQxv+Cdg4w+7b0f+tnZz3UdsslrMLZAGNzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MmXx0cIG1BO5Vq6gjwpdVoZ25cbH6TfLdbwi6a23iI=;
 b=Z7euJp4xwQPiVBIj0BWeuNsFYuNcFQwoZ/87y6pJNtDPcYfmaK1gENX0PZrwMwv9rRYfKywrTen6ZpjmKLNBDqCXJtnkG0Kz7WtfecC0eGE66hG768QHlUNglJbX36uomqtUpIQYwvHig2ayqqSRgiBFgKLmVcDPiVn+5km2ZXiORdnAYde3uB5kX4tRHxArxxnyX38dq+GHFQy45ZAnUVrYLB8d1wuBYy1dXvce1EyRBh35xLUGHGPZYod68mheZeeAU1ATfpJF1eBmlO3D9KFEGvrVbOPClrnUL4/qY/07oBBCTDkIYXLbBzvRYfcvILRoZGf+yoxVoDo5nbXciA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SN7PR12MB7450.namprd12.prod.outlook.com (2603:10b6:806:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Thu, 12 Nov
 2026 16:05:15 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0615.008; Thu, 12 Nov 2026
 16:05:15 +0000
Date: Thu, 12 Nov 2026 17:05:04 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Tao Cui <cui.tao@linux.dev>, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, mingo@redhat.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 2/2] sched_ext: Block a retained donor before PI deboost
 routes it back to sched_ext
Message-ID: <avXjsO_fLaUC_4mG@gpd4>
References: <20261112144935.583937-1-cui.tao@linux.dev>
 <20261112144935.583937-3-cui.tao@linux.dev>
 <20261112152118.GD1813469@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112152118.GD1813469@noisy.programming.kicks-ass.net>
X-ClientProxiedBy: MI1P293CA0005.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::12) To BL1PR12MB5174.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SN7PR12MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 649d599f-7e3e-48af-c4f3-08df40d6bd34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|23010399003|10067099003|4143699003|11063799006|56012099006|261022115727099003|261026121527099003|261022075727099003|261026140227099003|261028144727099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0YungozPP5xs1QOIi1DDvvUSr6wYmCSxZMIOL/azvspr8fs04h9+vugny1bM8OVL2DqTjp74c6ezDccFBIujFmftMVDRAI8UOZqzUoFCRBfcwueSv9v51J0bUDd3WUrbqoRgliYcTbrKQcak6cBp2pKwDJJpVTBAL6wYQU6s/O9gmgWKCFXucEjteq8LK3NHX6XO/49XcgwmOSg5HHlSk9v6Zahdf5TweSVKr5mS6RKzLj/WLomUEslxS3QGLojDGIcvHq6+gcH1VaB6n4aFupyHXk1JIQPGL8LeOAET3mrbyyCpv67LxzqY5HaxQTbOKfFZxJimmWWl/DBRw0ckrdl8p01Co9KXcC/ELfJp+QYiUJvjMHsAkAWeb8uvpF1Ox0ZuHMZV5YRXcpvjDGjNy9lWgXyXb2LyZN/3ZaThh/biRts4M0gxF4PfniXKuOIX7I8bsK6NO61yYEEyn3EbFGljKzZwDnODpwAwCTjevZp1i4AiFLHLZosg2ioaTz/+261GaTowcI/EahjAVAU8AifOK81Epk8Mk6ofgUAk77lCyQpjCiBHiUvJJTuVoHHXcB8lqZ4BZj9Kc5oWbSENyXn0k7uBQ3JE15+7iD+pa4vHscrYAwMMWMmJo9UcNBPaZRGA2G8QNOIBFJctiBJKVREKYYyGL0d3JWFaEPOmuaE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(261022115727099003)(261026121527099003)(261022075727099003)(261026140227099003)(261028144727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k5/aTfSTDDWoQ2o8vpxEFZcjxKzh6oS+HmcjnBFd1hX0Grj2Fnnic1c0EAEn?=
 =?us-ascii?Q?Xls1A0BYLA1G9DR/1smtuV8PG8NCpArPjiLK8r96iwJ2Xn6ak0iKVEqNlMhl?=
 =?us-ascii?Q?NpZ8LZHyirdS18Gw/ra2/QLa1lvhV/B0f3nD3KXXQ63IvgeuxoBUSTXMpbhe?=
 =?us-ascii?Q?JFb3Fh0NW6xI555rrnXiYB51xzntZnVMogaLGgO23GHfGnufxBMHAmlcsRjU?=
 =?us-ascii?Q?QmpNe1Zbuf1G4BawC85I6x6xoKX9Yf3vXk1vvpV7qLjuzpO51feYUXqUX6HS?=
 =?us-ascii?Q?OBk/xFzk20lm2lMKP0Q5p34KEAHz+m+NMjAWNY+z8qZWHN4au5rUIIhT7P6c?=
 =?us-ascii?Q?d53CTz0SIws+ZKj6dmRpbSkVMcufmpUshgfZ7csOKJ2WHc2+FMFFSDdHHE++?=
 =?us-ascii?Q?BtRfbBYebzeY3lC2lqidHAiU16N1tAG/fVhOZoDuI5SgpSI/pA1oYNqMytK/?=
 =?us-ascii?Q?0UZecXezEZ9yLIF28F9Fmlt/ZWkvvdHUu+wNJJKUgJpyaXOvojRVPcHTOgTp?=
 =?us-ascii?Q?NlsCVIj9JMDnVkZ033Qf/J96CXevqxwmcwRD8ZKSVh4Dpcsf8uYG1ityNu0x?=
 =?us-ascii?Q?zjMZunUyJaETYIz5+uYUkOQ+9UdlYVJPECjA0loGCWyzLexyFqGQp/jvYREh?=
 =?us-ascii?Q?cMqEbJMmvx1yACOaOeSm6Xp/JgEW7qYthyzEUKMOhG/SPbOiFTdT6ImQtiaC?=
 =?us-ascii?Q?9Pk2P0XJEeWlMJRrXRLzM8DwTmphND2AdVY1llKRX6xjQYr/j9AI9iC/RJsn?=
 =?us-ascii?Q?JT5z1cPJ7J+SPJzRPPMUtCaQ0C+WIntVPGsvA0736bVSffbljbKXTHXgKy2t?=
 =?us-ascii?Q?P/yci6eqy2AcHcGC8XWf+/3BQ99WA427fy+aSoU5O+3N90pOVpGBHuZCv3o2?=
 =?us-ascii?Q?Qdc4wh87SuC8u0D3uIAjU5EqMGyvxs6v2BGYvU4J1S3CrgFihyiUwj7sqnCY?=
 =?us-ascii?Q?+P1g1TEOA33RSpX/lTDm6AZMHGT6toc14NhraiOJh3jpRiswiiQ64ZuBbjTL?=
 =?us-ascii?Q?FF42ZcwA/Y71t7u55vMpdmpQjDOWTSOa2Khv3BVrLTkrp0ng4RGqgoB3mNfW?=
 =?us-ascii?Q?QY5DbZrXpA1ICFhJzYZkoMxr6E2erp/cOUA2GnQpkK5T89JsiVGbw/9TD5Ms?=
 =?us-ascii?Q?ZKjA1pijpeoS16GGfBbtK3GH3zBflAb5Uyc2aVTMLFBUmfa80Y0L82aPUsBn?=
 =?us-ascii?Q?TBR+5AOOaOch2aJO90o2SpMfuqlQxgu1IVqJLZ4IgyY698WKiEX8vNZdlTUv?=
 =?us-ascii?Q?NvWh7dCy7ZHadP7x2CR7o2WWovUrCQF4/TlbBZRJliTZmeuwYOZ42fA0RD9p?=
 =?us-ascii?Q?TF+PkhGDRVTpQEJlRQSJnCVxu9elIRCoHdUxPyL/rGW2fZ8BoYbkUSLQXQ89?=
 =?us-ascii?Q?kO9xwqB5XXMDLtG4+IGtVjnCcRwN2bLXkMZBp8MvbpjdJf8LWogwiY3U4FDg?=
 =?us-ascii?Q?hh3EE95Zp4bEgHP3fkzkGWroEF2CyPpMiF5GOrKauhm3o8K3GiYlPhyZ+hms?=
 =?us-ascii?Q?cvmmbr6LDNFNh+iq9BNlrMvytVVlRuuf4KHRFhdaQAPptnKvp1to2zUgrnfy?=
 =?us-ascii?Q?WZhq3iK0gKUL1jqyDbb8AF2zV8GHGmzIVjbfqzg4mg630XPIDLQohQdX/1NF?=
 =?us-ascii?Q?0MzqxEjwM2B2Vqa3GtKz7uPhbnNjDbZ26BG9+3iMgDp3KxVnpzS/hIWJ8ZPW?=
 =?us-ascii?Q?neZUdS3Bm4qXHHTWxyjGQtXK/zKir0tV/9pLFw3/Xrwz6iiH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649d599f-7e3e-48af-c4f3-08df40d6bd34
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 16:05:15.3696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ncP7E9LE0cE74hGmzPwD2vg6UInetUBmh+nkKAxE6MH5f16H3bqTfBxu+iarqzlmu3Hq0QL6SI8bqIHRYQFChw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7450

On Thu, Nov 12, 2026 at 04:21:18PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 12, 2026 at 10:49:35PM +0800, Tao Cui wrote:
> > From: Tao Cui <cuitao@kylinos.cn>
> > 
> > rt_mutex_setprio() is the only entry path into sched_ext that does not
> > block a retained donor: an ext task PI-boosted by an rt waiter can
> > block on a second kernel mutex while boosted, and on deboost is routed
> > back to sched_ext carrying the queued+blocked state that
> > scx_prepare_setscheduler() promises never happens; every PI cycle
> > hands the BPF scheduler a queued+blocked donor it never admitted.
> > 
> > Call scx_prepare_task_sched_change() before the sched_change guard when
> > the class change routes the task back to sched_ext, which performs the
> > missing sched_proxy_block_task() (plus an update_rq_clock() that is
> > harmless here: the clock was already advanced, so the second advance
> > only applies a small delta). The boost direction (ext -> rt) needs no
> > handling.
> 
> I can't understand this. And I take a very dim view of sprinking magic
> hooks like this. So no.
> 
> The little I understand of things makes me think __setscheduler_class()
> is buggy for EXT and *that* should be fixed.

Agreed on avoiding another special-case hook.

To recap, we ran into this while developing the proxy-exec support for
scx. Earlier versions were handling the PI deboost case too and we also
explored passing next_class into sched_change_begin(). But that didn't
make it into the final version and it was left as a future improvement,
to keep things simpler.

Regarding __setscheduler_class(), the task keeps its SCHED_EXT policy
while PI moves it into RT/DL, so selecting EXT again after deboost seems
expected. The problem is carrying the retained proxy state across that
transition.

Would it make sense to revisit the old idea passing next_class into
sched_change_begin(), so we can handle entry into EXT consistently
before recording the queued/running state and replace the separate
class-entry preparation hooks?

And unlike the earlier version, we could restrict this to transitions
into EXT, leaving retained proxy state across FAIR/RT/DL transitions
untouched. An incoming-class preparation callback would let EXT enforce
that requirement without an EXT-specific check in each caller.

That would address the transition handling generally, including PI
deboost. Does it make sense?

Thanks,
-Andrea

> 
> > Fixes: be8be8acb268 ("sched_ext: Block proxy donors before taking control")
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> > ---
> >  kernel/sched/core.c    | 12 ++++++++++++
> >  kernel/sched/ext/ext.h |  2 ++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index f7a452123ef5..dcb16b006740 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7816,6 +7816,18 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
> >  	if (prev_class != next_class)
> >  		queue_flag |= DEQUEUE_CLASS;
> >  
> > +	/*
> > +	 * PI boost can route @p out of sched_ext: policy stays SCHED_EXT but
> > +	 * __setscheduler_class() follows the effective rt prio, and rt/fair
> > +	 * may have retained @p on the rq as a blocked donor. Block it before
> > +	 * sched_change_begin() records the queued state, the same way the
> > +	 * other entry points into sched_ext do.
> > +	 */
> > +#ifdef CONFIG_SCHED_CLASS_EXT
> > +	if ((queue_flag & DEQUEUE_CLASS) && next_class == &ext_sched_class)
> > +		scx_prepare_task_sched_change(p);
> > +#endif
> > +
> >  	scoped_guard (sched_change, p, queue_flag) {
> >  		/*
> >  		 * Boosting condition are:
> > diff --git a/kernel/sched/ext/ext.h b/kernel/sched/ext/ext.h
> > index d32bc01071b0..1a699be25331 100644
> > --- a/kernel/sched/ext/ext.h
> > +++ b/kernel/sched/ext/ext.h
> > @@ -19,6 +19,7 @@ void scx_rq_activate(struct rq *rq);
> >  void scx_rq_deactivate(struct rq *rq);
> >  int scx_check_setscheduler(struct task_struct *p, int policy);
> >  void scx_prepare_setscheduler(struct task_struct *p, int policy);
> > +void scx_prepare_task_sched_change(struct task_struct *p);
> >  bool task_should_scx(int policy);
> >  bool scx_allow_ttwu_queue(const struct task_struct *p);
> >  bool __scx_allow_proxy_exec(const struct task_struct *p);
> > @@ -72,6 +73,7 @@ static inline void scx_rq_activate(struct rq *rq) {}
> >  static inline void scx_rq_deactivate(struct rq *rq) {}
> >  static inline int scx_check_setscheduler(struct task_struct *p, int policy) { return 0; }
> >  static inline void scx_prepare_setscheduler(struct task_struct *p, int policy) {}
> > +static inline void scx_prepare_task_sched_change(struct task_struct *p) {}
> >  static inline bool task_on_scx(const struct task_struct *p) { return false; }
> >  static inline bool scx_allow_ttwu_queue(const struct task_struct *p) { return true; }
> >  static inline bool scx_allow_proxy_exec(const struct task_struct *p) { return true; }
> > -- 
> > 2.53.0
> > 
> > base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
> 
