Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E762CCC5;
	Fri, 18 Sep 2026 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789772764; cv=fail; b=c2TmjJvTByPjf4nOaVA4vr8IUlWdjcKqQP+9jm4Nd7G87xZ45x3OozT6UlrKmmni/pyS0Lp7hYL+QZi8f8hHVIuGdpSB9SvPFxtj0dMyT8E+pA5viM+DPdUVIiDHVBCVzYHKVyoZTDJWGUbx90m0uV3KVvjYAN8FiGN0LjQNdmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789772764; c=relaxed/simple;
	bh=gSy+MmdqA6tQGOOqT6nYkooAb6G/XgnspV+ACxmqcIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NhSzFeHLAFNRT2fgYQ2kp0i1hamJY5tTX6Q9n/ixuhyBa2ysvduXUMk72cjqP0YAjziIj2+GouyCksIO1moTxphM+IZtFf9662sv52vKdk57rbAQvNtQP4dWCtxIutOTJOTRSOQB7oTYmwpz4oYyVuKaqhfk8MfsXt1O/Dp7l3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nVfCCy+a; arc=fail smtp.client-ip=52.101.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nVfCCy+a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTqt/3uRPfY36W9XWLI1ZILMB9OPwIuTPd4VBsasQQ25NNdqjBnxq3HWgky+hjmn1irmlphcpyUc7J0VpnAUsMfTuY0EWqudwXI2KpKDAJ09vA5Xt6PAFdSZ7tXR9G9CddwZ9eJwh5gimmCEnyAGX6axFSGss0vl9NupJMEXeH69v62dKR4LYtoURgBzSOg7KF73viPxigg9AIr2RzU0uP+mYFSBy5mav1Oqre5412Ma8zXwPOqXCAOv9bS45Al237JYa+ZV0LbTtAOX7/WQBX59HhNp6KqSRoZid/5jqZ4dvP1Xs1nmyvF5dRZLTkXr7yhUVxhoxVuRrn+XoOkukA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8sTEfqgMvYS8IC5fCum30cXAo5VrL2JqJnun2gOhdcU=;
 b=GU0+yc4Hz8e2YuHhyQY0Ljx/nFYF3XipSF/2azpk9tj1X7qLgIRTk5x9EjXtOARYVDuIygFXVeiayUIudKjcnNsUZw67DLdDnw1t0mj1jSpdorehF1wDDjH0KPzGpGlfgpejVc+1BXixFsZl4gMo3PA4H2h/9RJi+/wRDNFjt8SzYEj8M9CbjbEi0pBznQe5Zpq1N2zxRWeQabrZGayNZNdtAUEPPjpOF+fi9E3cLDvb2dD3MuJ3h2znVDZMyF9iRS4DSUYHytX7toya6epdqsHNF0DX6oYnCBXTmHn+3fGSU8FWmWdhbOWvEYTK/lVwAW98AXQDXZaO08Vauvj6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8sTEfqgMvYS8IC5fCum30cXAo5VrL2JqJnun2gOhdcU=;
 b=nVfCCy+azGTZt67UKNdBvRgI5hqq3Q6YpdBos3J/h0Bn/A5C5TNO5dHoWIySv7I483GJ/5VEnNeoO048pt4HQUvxhcrYfx5jZhzsypIV/dSaxJd8Rt5scUvcDW7497i33eDoCjd/X9JCn1w7RYPEaAcsGZGz5ldhISZvcUlwpyEg/ZR2htjGwtV0FR+czH6FWL2HEl1U8/z/pZEP37wc2uTd+X9PQHOvAWxfYVuSZ0fXHJYFUNlwBdiyAa9NvQgm3zOzfz4fzHHKiRWzvSfOySt41VLSSgzle59ta/6059QB/jYikEIAG4UV2U7KGZEdw7P2d1gCeHVtrpWZFziDmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com (2603:10a6:208:17d::10)
 by AM8PR04MB7906.eurprd04.prod.outlook.com (2603:10a6:20b:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Fri, 18 Sep
 2026 23:06:00 +0000
Received: from AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023]) by AM0PR04MB6900.eurprd04.prod.outlook.com
 ([fe80::7fda:8431:ca1b:b023%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 23:06:00 +0000
Date: Sat, 19 Sep 2026 02:05:57 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 net 2/7] net: enetc: ensure enetc_xdp_xmit() calls
 enetc_update_tx_ring_tail()
Message-ID: <20260918230557.bzboccc22ku7bzhx@skbuf>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
 <20260915222735.1016937-3-vladimir.oltean@nxp.com>
 <20260916222806.6011F1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916222806.6011F1F00893@smtp.kernel.org>
X-ClientProxiedBy: VI1P191CA0010.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::18) To AM0PR04MB6900.eurprd04.prod.outlook.com
 (2603:10a6:208:17d::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6900:EE_|AM8PR04MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: c9630d5a-dfdc-4310-06ef-08df15d967a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|10070799003|1800799024|376014|19092799006|366016|10067099003|5023799004|11063799006|56012099006|4143699003|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tfs4v+Fbt5vCIuiNzRSiQGuOVpalfBJK5YGuF9wD85ZDIhsXSt0efMD6WXe262RQkjCksWjURJW++EjDm014CrNkTYVZRVKA7XPchg3DqWNtVNwViRKiBISHa8JStDpZkEhJ9C9BCB616uXIBYkiUxDnzVG6gm6iLhcnaRgzlNKrZWsr7O7G6esrFSPqftMPoquckdnlYKcsVhtgU3cnx5EClRZySw/Poo9Mf9D6CrFFEBg0FCBhSUNMv2qUrdMNs2C6hkmCGzPvrK2JnjJLIEXaefNKtt/r22PLc/Zpw7d8gd10XbzWcha7axw70VYZsvI7CvrgEbW4qb94bwv8KmMF0aWO+13AwyoN11EsusNie98DmHN4R0ZXEgENlUqk8eTn+wBN9pWpwK/a3vXrPT3vWlNZXZ3VgVgod2aBjVrk7ylLeTh0duGFSnttX0WYlsypAG5pyU/ytEeFJ9ByXZOxNycyMUMpr4KcbyhoV5dom643kHyLlnu54jdVYF8GPx+3aXqX6o0ao8xcICbTYpgkQ8ItSBaVkMDmYCSqtBViCzFd+7N9NYyzirggTwcjjGC0pxKwUvbaDhf8n3gGnyTKMTj/vEy7QOROUmIqmyxMDUoZOE9UJkwj3DO6DDrrunlGJTEFZVGhL0Ezl/oSBxRBjiMQnke4XSbHyiWzGso=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6900.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(1800799024)(376014)(19092799006)(366016)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3vJ5Jk7neJMHhmHGN2BpcFrvV6SSVz6DQc4BBw879u5RkJgHT/8dNvJMyzPD?=
 =?us-ascii?Q?VrdZZe7LXEaQhGSnB+CS9kuNzzSqCPqfbBiMvCGLUlRNvuyY74G09EwGinV3?=
 =?us-ascii?Q?z4Xdr7WFGQd+d+A7VIMFdk2KYW+CTasQrvBLIqkGm45zf8KCraC0KQkR3uSp?=
 =?us-ascii?Q?FsWN7H/AxMmqUGCwFbzX2+sh3H7P3gTXZITn/8lT7ANYldRtsjH4zONnL/bh?=
 =?us-ascii?Q?C96craNi0Lz35rG5aRtac/d9eY7sBUoP1/tV8nVhFj8m43IDc2q+lqFNL69v?=
 =?us-ascii?Q?nlHV5BORZoISGEwql2MtPqgHJQXX9fo/xGXN7ukUh2jiKlMYrQa97SQsNLc+?=
 =?us-ascii?Q?tmMZL+Pli8D2o8lhDATY/z2de95WnFcgRizMinkcl1NNhhIkb69xZCmkaChN?=
 =?us-ascii?Q?iK2kS4HtLiWTvsf0EDYSpVLpnhHndC4g6FjvgoQ+PhD8O6SD80yGrBFfwDOf?=
 =?us-ascii?Q?fPzp+7cV8Y+Yj2GxMmj6NnnDJx8JJpxOgnxm5hUIgNqbmiluA/HvzN9LL2l0?=
 =?us-ascii?Q?G2m2tp+cNvB+U+J2bhTWZmqDw7b1gdEeNK53bglgNS+JWJ4XunXIXZEfR4at?=
 =?us-ascii?Q?CgmBfjvfsGKa29DBJu6tiBzjNFIMRCNoiv+Jd0YBP+fd/N/BP3MjdK+4+rMZ?=
 =?us-ascii?Q?MamiFE4VRhh0bI0AZKQqg5aeI5ux3FmwwXtKxwMBK/d3mdaYXIXmfyk941E/?=
 =?us-ascii?Q?rL91K7PEsHdWsYTahUP3DyynUiD41G6JT9N6qrF0JoybIml5kXSUedZyJPBj?=
 =?us-ascii?Q?Yz4xD942N+DsRrW8aMvU+6TK8md7OCH2YwBiu+30ufSqeBtzD/eAmKo+vKSF?=
 =?us-ascii?Q?nhIvjX7MZzBQBfoGPXO+4iMxBX7CHzFDbc0j1VgskX6HxkON0y/uogp4r/Go?=
 =?us-ascii?Q?C6/u++bEO+Lfqk5Iup30xeiBzH1sZQYi09pM6fTtY3nWjEsQacoSC0zXQ1S1?=
 =?us-ascii?Q?HDcQ7ekU9lVqB3Sn9v/gYxd+lT+I0mPmyOSGly8H3td0jF0RVvckSN3uCVMg?=
 =?us-ascii?Q?xC+qOmJCCMssgu7QD8Xoz4o9ntLUsE2kcuv9S3WfGWv1tp1z5daYGi6S8l4W?=
 =?us-ascii?Q?OLoeK7caEVpjIor6dsMgBKmNaz7WEzMn4nBOuq1jEUdNJmD0nLsKcf/IlnD3?=
 =?us-ascii?Q?vMOd8tEgbsmP1mbYWE2R94Yn9pWXd/DQKZsZhgk562lJWlAfzUy/nvxB3KnO?=
 =?us-ascii?Q?M0p9KzbgG1oTWTf//9rlrSpQF01KdmGYxvxt0Rj/W77Dvh72JKGYkZv11ohr?=
 =?us-ascii?Q?j7H9oa0yXlgz59aL+8YwVjhITZGE6ynr8GYixeyAHrPNb0QyJVa8eREgo0Lr?=
 =?us-ascii?Q?Ra9JALECLiOc07Wz7UtjXrrGnUMXC9YzUaqzRElAH65JnV3I5PTNAU85RtvM?=
 =?us-ascii?Q?mFhpo94PdwdB0QmpetT367SxEw2nE+5kkvcewTNTxSmdEBKSskWNCari4V7L?=
 =?us-ascii?Q?Y3obZsFXLzXeFZqGcunOP9BWjAyUw7j+01MoiMb7iF5BwxlbxGY96C2co7bl?=
 =?us-ascii?Q?Dtf+pREyz64ld6LqkP7jhQKKk9gb09RjyPbbdgUCtAVZRvN9wxCmd7qV5VI/?=
 =?us-ascii?Q?BOtZgwqXnOk0w6OulEWI+2aYotzK/roOxDQE838OCuyJ8Q2cz7mFAvREzRl7?=
 =?us-ascii?Q?fFe/2ljDTWC0LclyayQjD7DzCrxWxVYW4drvekTzipAjAM9a23x3giU5XcZ/?=
 =?us-ascii?Q?DOzbJ9sIxcJBjc5xGzYx3MzUPySvZNRMWidB6N7xWEN5SQ3e8dCwi7bd14v7?=
 =?us-ascii?Q?0lQhjLaJM7EGM3HbfoK8FWtZmV4gkDNLkOP63QxyhXKr7lv7I5TqYvbI41Pv?=
X-MS-Exchange-AntiSpam-MessageData-1: I0H+vCW/KrCWOFTc7ipzelrZvaKH2vL8y60=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9630d5a-dfdc-4310-06ef-08df15d967a8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6900.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 23:06:00.3088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: askH326jMxhL/7AnU6bAOkLT3mD2qbtMbur5EVH/MsFdJGhQn3eTV9PlpHkQESjrBhn79LX4QgXkjFg4/cVxXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7906

On Wed, Sep 16, 2026 at 10:28:06PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] net: enetc: missing XDP_XMIT_FLUSH doorbell when k=0
> --
> 
> commit d8271163a46118cc9a3212492775857b3ece7ba0
> Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> net: enetc: ensure enetc_xdp_xmit() calls enetc_update_tx_ring_tail()
> 
> This commit modifies enetc_xdp_xmit() to fix the condition that triggers
> the TX doorbell. It removes the redundant xdp_tx_frm_cnt variable and
> updates the check to verify if at least one frame was sent along with
> flush requests.
> 
> > diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
> > --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> > +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> [ ... ]
> > @@ -1845,19 +1844,17 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
> >  						    &xdp_redirect_arr[i]);
> >  			break;
> >  		}
> > -
> > -		xdp_tx_frm_cnt++;
> >  	}
> >  
> > -	if (unlikely((flags & XDP_XMIT_FLUSH) || k != xdp_tx_frm_cnt))
> > +	if (unlikely(k && ((flags & XDP_XMIT_FLUSH) || k < num_frames)))
> 
> [Severity: High]
> Does the addition of the k && condition block the mandatory XDP_XMIT_FLUSH
> doorbell if the current transmission call fails to enqueue any frames?
> 
> If the devmap subsystem enqueues a full batch of frames with flags=0
> (no flush), enetc_xdp_xmit() successfully enqueues them but skips the
> doorbell because k == num_frames and flags=0.
> 
> Subsequently, devmap calls __dev_flush() which invokes enetc_xdp_xmit()
> with flags=XDP_XMIT_FLUSH to ring the doorbell. If the hardware TX ring
> is now full, this call fails to enqueue its pending frames, resulting in
> k=0.
> 
> Since the modified condition evaluates to false when k=0, wouldn't this
> skip the doorbell entirely and leave the previously enqueued XDP frames
> permanently stuck in the hardware TX ring?

This is fun. The LLM has no idea what it's saying, but it's saying the
words that are gravitating in the right direction anyway (kind of).

Specifically, it's unable to articulate "the original code was
functionally correct, it just needs some cleanup".

All other drivers only ring the doorbell if the XDP_XMIT_FLUSH bit is
set in 'flags', and I wasn't able to understand why that is correct/
sufficient, either when I wrote the original commit, or this 'fix'.

My concern was: "if a full batch with flags=0 fails to be completely
enqueued, don't I need to ring the doorbell anyway? what if another
ndo_xdp_xmit() call never comes?" and as a result, I remained under the
impression that this is condition that needs handling.

But the answer is "it _will_ come; the only reason why you got an
ndo_xdp_xmit() call with flags=0 is because there's even more data to
send, it's just that there's no more room to store it in bq->count,
so let's first send what we gathered thus far". The remainder _will_
result in another ndo_xdp_xmit() call, which (if terminal) _will_ have
the XDP_XMIT_FLUSH flag.

What is even more interesting is that, after dead code elimination,
enetc _does_ behave like every other driver, and there is no bug, just
misunderstanding. Because as identified, "k != xdp_tx_frm_cnt" is always
false, we have "if (A || false)" which simplifies to "if (A)". So enetc
flushes the doorbell based on the same 'if (flags & XDP_XMIT_FLUSH)'
condition as everybody else.

I will remove this patch from this series, and resubmit the cleanup part
only to net-next.
