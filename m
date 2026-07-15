Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A6243F0A2
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 18:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141965; cv=fail; b=DWIAdsZNNWSc2y8h+zOOZfxISNO+kLfQjdSnin+mEME3ag5uKAt5+QE7r512a6JwgDnOQJvEaKTLpSE/cDvMpa76d2JnjW/pUJX6n65T+LRWoLe0iNpOS+ijVTqxXgmE4j8EK4nzJ8DsjpPhc3hSKOb4p8rR23ztOulAjMDlZqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141965; c=relaxed/simple;
	bh=TgWXygycNpVx75F5nKGlzyhsa7ZsPeTtKk02ygrMFVQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RW1nAmMXDgA4w75yLsIAabZmSw4LWwNI1zsDKg2qxyvguLCACZ9NzRRqId3N7mLjQPTe7e2ecLnl37+TBjTZEcAwRY3Jp4/4X+mjLiWRQFyw0QXclo/tw6ff5+e00vujYViokQB4eR7aj2ltEi8ijbRLwNs4UTNVmCS7qygFQN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LSoUfcHS; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LSoUfcHS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784141956; x=1815677956;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=TgWXygycNpVx75F5nKGlzyhsa7ZsPeTtKk02ygrMFVQ=;
  b=LSoUfcHSF+3fStig4qlYfOVmjfjbY+7NBwTaXAlfwWEtT5tyR6noJx9C
   75TJEUh84SQFAJmAnaIurvYDKIN3E0o7oRmUlYXK7LwSn85j+qfL5hb7i
   Xrf3bIrlI9hz+U/zPMV2n2T2NP6bOfh5NGuU8rNUwAbnKR18fmzTZ63Q4
   egzkzWmn6zoKml9omwgRetSwCYhZObKcnuHp0KOXxNX0U83LY1bsVWAfy
   H93Y4E9URVQHq5Pgs23ycRDm+4YU8JE/m2NfoTOy1xYjndMJcCcHwPh9Z
   Esqeikv3bGZ+7xJ/TNkkUFXOlbj3A3D5mHd6uvFrwWU5rre4raO4+VP2h
   A==;
X-CSE-ConnectionGUID: mfItZ8cuSLu65mMO9St20A==
X-CSE-MsgGUID: MoQLAzTKT/KHH2NLJFW1ag==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96161170"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="96161170"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 11:59:11 -0700
X-CSE-ConnectionGUID: +45QTPnXRkyBB0n8kaSgZA==
X-CSE-MsgGUID: vZxoqDjtTNOL2IMSJNhT4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="260082318"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 11:59:11 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 11:59:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 11:59:11 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.53) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 11:59:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSZty1qTiWCYawX3+m58Al1AIRCMqFDhJWVQpRpkFsYaR7NZ2NmEjmCWq3J6FKcj5D0oip0gAykHIlYRRwTDt5FciNjzVTl2s4dT1Kwxco0tFlsCyPIpKSAxMyx/4gMI5B2aGCA7WmAYKyEaVYxEC94v2gBuj3sHf5rev0IXRvMu9qrS2xzSdPTdJWBxmUymL+pMmxbF0Rn5GDigAsZGWY1tnQwd1ywFrWYcxtKtReHm1/1hwfntYINo5O9QQNpZ3pILK9FZCoKuODhGAZMkJgbgTgjW1BbqG8qEayFOUWqjNyavVCQ7bI3VmwWycXa6E4s8CnTlz03a65x9rntYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TA7gHrUG1LemM+WP1q2QDDkU4mE3NinvZNuYMaHU+Wo=;
 b=FV7VnBGsVyFg3X+MZMjdu+zQDAiqyC/7yyrI6PPeB9eXLMHObA2BXM+XIaz5OhdPu7Utd+O5uxfgbtK2IbxRZOoWu15MV9AXLUmWQlP/dgTKIZYNJZwLoHYYdPISgv5cr+dSC/hOZek3dGAjTaWzGUnpzwVut1SwFyPPWoxDRrEJGjjpTFomN1KrCotWkdsyJr7WCXkaXTl/AmObbeYDyYGYQf6Fkj/AShMgVD+qeO1tie3wrl1gOBSGVdtoQ/HmNWdiLfQFfSbl/yXU8hgakvOiuR3Zybp89U3VrLfyr5XC1XGd+zI8gU3UJUy4SJKs7VNBpopImobLQW8YjHxpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA4PR11MB8915.namprd11.prod.outlook.com (2603:10b6:208:560::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.11; Wed, 15 Jul
 2026 18:59:08 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 18:59:08 +0000
Date: Wed, 15 Jul 2026 20:59:03 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: <bpf@vger.kernel.org>
Subject: Re: [PATCH v3 net 3/6] xsk: provide sufficient space in
 pool->tx_descs
Message-ID: <alfYdzVgqUQEz/lI@boxer>
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
 <20260714140722.111645-4-maciej.fijalkowski@intel.com>
 <20260715140844.873211F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715140844.873211F000E9@smtp.kernel.org>
X-ClientProxiedBy: VI1PR0102CA0025.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::38) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA4PR11MB8915:EE_
X-MS-Office365-Filtering-Correlation-Id: 16859653-3905-4896-11d2-08dee2a32662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|11063799006|4143699003|56012099006|6133799003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: qewjqACSzv6UjvgrgxI0JgnHQD0HW1z876SlQOSMQKYG8WITfM24SwehXVnL/UgjHp19EJ3a063WPDeh+YYVFlBZT9vfPVzgZTnLpG3t/5g/i1ikTOubdFHe+ymfeL24TE2/7g01jZIcFdPZl5C1cYYpOmFPTi/Q2d4LcInq1gUhuqkF/OIat5X4Atly+kHJ3oOXYtD6hCjuiJbdWRr+7UoV8rpbaqgy4GmsGCYyXdvHqqIIjdrS0ns1DaWEIoZ5vTZpcq3woWXN2N9JFiNVOJ1HVDQOYCCrDhA4Ed2aN+mZgjJxqvuveLVAkap4UZXLyUa/akw2F2u2lVJmYaq3HBdPFK2rl4eCpm4M8zAYQNtN6O1phhhAkLYdyw+4XSaSPwiqgg/K+mfuC5uwzR0AxOdDzFyUmGv8uSPHArK47fD6NvXTIxavzz0edrX0OH2C3k1VYBQW6fn+SoS79j1YytKpOu1Hw28LZi0gJi9zsx+A7FGgjumZ5mynkHOdoxkBI9NAHxqyk2wQTnjpqsRu3/b1r2BP81Hh/trOxIKv/8EfMe09Q6vT1/vtuQU1kqzNstWeofZ8NjB9Zkm2/+7Kdm/XfZUH9LwKtxWUNnvN6ms=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(11063799006)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5mJMwyzJyc4X5AeSkBpH3QA7XzXI/5RqWlWZ5SVXGznKZzQ/688t5N5F+p?=
 =?iso-8859-1?Q?40IjOWL9nTxclAnNQFm5w1C6lxq+xEo0DAXeVLNBjJUAPCF8i7Y7STQjqd?=
 =?iso-8859-1?Q?LOHIsydLIpVtH3NA6r0PXbNciTAMNu4Ao45kzj2fS6ThSlIPoxc8xj6R9y?=
 =?iso-8859-1?Q?bytSdtV2st73DKi2SahoA+wOceoa7RHnyfzbTcBbxgSlbHVr/9g7y4QrkP?=
 =?iso-8859-1?Q?yQD7IQzYfdQhGJh4iTsejCUcTOmokdo3KSU1iX/9sPrqgR3rp9hA3ncmpG?=
 =?iso-8859-1?Q?eafUR3WoewFarspa7tQWehisBghVOyapxkBl3G0iaGVh+i16Hs5Nda+Yqq?=
 =?iso-8859-1?Q?Fk7frde4GnXxCWj4ZBQq3NBDmirnC5BtaFi0gC+YytitcAxe0bGiGHVPpB?=
 =?iso-8859-1?Q?WR82+lHPszAaAEUa/98alzL+v566oOSTVe4UqhT+e/zjydEt1SWzEIEbk+?=
 =?iso-8859-1?Q?0zu+cai5OOgBvH/Uz/g55H+aSwDNcvWS0xEcWcDSHvQJWlJy20X3c00CFX?=
 =?iso-8859-1?Q?7rg+o4A5wNF8lwqH9+1KB+3BGiIP1dFMeRsbZ4bRFWxM6k3C7igr1Xuebc?=
 =?iso-8859-1?Q?B9wZTKYnIOcJx1I7E7rkvc22UVBQON+Ej5BlIo7jnnE08OlOjBriKgH1X5?=
 =?iso-8859-1?Q?3kDISD86PcCsAngZXisRShjUq7nYO+D8mSEVB54zR9RfieVM7JkVjIwBNl?=
 =?iso-8859-1?Q?DkyFzX4IM41B/KPiH3/2Vw86yQuFYXN0G9YSb52rySS4CaE/Ie5smVkeFN?=
 =?iso-8859-1?Q?Kbu1KO1IlMpBQsHNVr88iISHEIMHbKdDiBNkMA2WSIBlSwLJrfoT7M1EGR?=
 =?iso-8859-1?Q?hgAKXUM0caGV4GFCRTcX68x6fENnTmApBtfB565aa69goobEXyhZE5P//E?=
 =?iso-8859-1?Q?MpaYWOnIar/gWqsyVg8dgymyi/JKurAjWaBGCpcVFd1lL8XtyNl7l5SD2L?=
 =?iso-8859-1?Q?Uh16PCAbxsRr0/m86FNRD13ERAGyxqECABg3jAxeAdvHuEumAnTpySMlw8?=
 =?iso-8859-1?Q?yZHvBEpfaR9bpiK82yIiMA/PHsrqcCcOjbg9pgTBHB5kDppJS120Dkjsa5?=
 =?iso-8859-1?Q?cY0WcvXXE5t6SBUfyNjFrZF/2C+vjPPoHppKkcJqvS79BAJf4BpOdCZc6x?=
 =?iso-8859-1?Q?n5TJZTN5nfFEa7Rfwj5OBE5Rlx5BTb/A0sPYY0BbuOo1X9vKmbgwV1np9S?=
 =?iso-8859-1?Q?gFJ1tbKSNDY+uQ5VFKAADW5bx4PmaZJ3zApUku4KjlTicqCZ0SfvnkmZup?=
 =?iso-8859-1?Q?GYlCejEEOXdqI6GGx3piQNzEWwqY+11u+J00pmY//4z1QxK9zFL80jJaes?=
 =?iso-8859-1?Q?LQbTjlB3zpjZiE+hJOW3m1xq+fWH2Elad5EhP0OPhKpUK97iscJmdzX2pM?=
 =?iso-8859-1?Q?AJ8qg/+ztKXMCahkS45FZi9BRAbw0liqWKGfBjOUGHKoEvYD/eoW2EaP9w?=
 =?iso-8859-1?Q?zO1KtJf4tD5zF53g3a9D6wjT/PJ5zVJyTdAfhF+mtBFdlEsjrlw0qpLm1d?=
 =?iso-8859-1?Q?u+O1jhDKTLN/M2swpYXMF2kCg4qjA5PCuCzxcFJFNrZZdsYK+IglHIBsQb?=
 =?iso-8859-1?Q?zWGv/QHdFuEXRTg3Dyam8y5SJ1x3yB25yIkarLhYQcRsLolkrbJqVmfAgw?=
 =?iso-8859-1?Q?+95e8v0540HCPjB37lyS/6UvXCTEQ+oMcqIpf/fzNcjgvzNyPh6O13yrQ8?=
 =?iso-8859-1?Q?ebnxGkc767unVRFYFR/Iwiesa4LDc3pRJzq4CErxfI+U+VRf2CcgnQX7VC?=
 =?iso-8859-1?Q?85OH41QKWyFNJG8LiEmpYsSy1JDAdsh/M/EccvI0BV1VO3myqw+EGoHj/S?=
 =?iso-8859-1?Q?pKhpUALKTqeooxT742G/C62N5Nyu33s=3D?=
X-Exchange-RoutingPolicyChecked: GH4sl1SlFECdfyLLvqrJ5Tie0hmoFRdxZwqpHhPBwgXRB1Qp/udOg7fKPj2c7tjklMv/eyr8pu7Hpej+l/hn0akya8hH6ehhTwBgjcAl3MFuEcynbOqi9c7xkJKFA5wwOvQi5Uc7ZCQRvbbwU1l2Gq4UEsnvkeOOEk+q8k6nUNsyV0ajsegB/jTOT8Wyq5M1+qiypwXAnNDh2CQwe9f2YlTa7fNdI6/d2Q+vo8oKe1/PP5YVL1E+ImnqRnY7SrqBilMm1Op0uYaqjHoq9Ne2QlZ1Xe7MQSZnvMVaqk0z3KFuKAbUE4Z7u8eJYP5dW55ZZwrvTj78uC0uKKHfYKrJDg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 16859653-3905-4896-11d2-08dee2a32662
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 18:59:08.5779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vUC7JHn5sndrwWa/E/l2VcDuRrRj9eCVkmdB+TJGxku4ZWtl6865SmCKm2OiCZPPxQCri8HmVk3CSgg+aCFCGUpama/H9wEoqdONJv+mp0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB8915
X-OriginatorOrg: intel.com

On Wed, Jul 15, 2026 at 02:08:44PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Heap buffer overflow in AF_XDP TX batch processing due to undersized `pool->tx_descs` in shared UMEM configurations.
> --
> 
> --- Patch [3]: [PATCH v3 net 3/6] xsk: provide sufficient space in pool->tx_descs ---
> commit 6f635cabf694299ed3f7be4ce0e5f328e6bd90e0
> Author: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> xsk: provide sufficient space in pool->tx_descs
> 
> The temporary Tx descriptor array in an XSK buffer pool is currently
> sized from the Tx ring of the socket that creates the pool.
> 
> [ ... ]
> 
> > Size the temporary descriptor array to the larger of the first Tx ring
> > and the device's xdp_zc_max_segs capability. This keeps the array large
> > enough to inspect one maximum-sized valid packet. Larger shared Tx rings
> > do not require further resizing, as they can be processed over multiple
> > batches.
> 
> [Severity: High]
> This is a pre-existing issue, but is the statement that larger shared Tx
> rings do not require further resizing accurate?
> 
> If a secondary socket shares the UMEM and has a much larger TX ring than
> the first socket, pool->tx_descs is not resized, locking its size to
> max(first_socket_nentries, dev->xdp_zc_max_segs).
> 
> However, the batch reading functions don't seem to bound their reads to
> the allocated size of the array. They appear to read up to the driver's
> budget (e.g., 64) and the current socket's available elements. 
> 
> Could this cause a heap buffer overflow when writing into descs?

This is clamped on later patch:

+	nb_pkts = min(nb_pkts, pool->tx_descs_nentries);
+	if (!nb_pkts)
+		goto out;
+
+	umem_shared = !list_is_singular(&pool->xsk_tx_list);
+
+	if (umem_shared && !(pool->umem->flags & XDP_UMEM_SG_FLAG)) {
+		rcu_read_unlock();
+		return xsk_tx_peek_release_fallback(pool, nb_pkts);
+	}

> 
> net/xdp/xsk.c:xsk_tx_peek_release_fallback() {
>     ...
> 	while (nb_pkts < max_entries && xsk_tx_peek_desc(pool, &descs[nb_pkts]))
> 		nb_pkts++;
>     ...
> }
> 
> net/xdp/xsk_queue.h:xskq_cons_read_desc_batch() {
>     ...
> 	while (cached_cons != q->cached_prod && nb_entries < max) {
> 		...
> 		descs[nb_entries] = ring->desc[idx];
> 		cached_cons++;
>     ...
> }
> 
> If a user binds a minimal first socket (e.g. 2 entries) and a large shared
> second socket, the softirq batch process could write past the end of the
> array. Since ring->desc is memory-mapped to userspace, could an attacker
> control the overwritten heap memory?
> 
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 43791647cf182..385a3f4a1b320 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -1557,7 +1558,8 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
> >  			 * utilizes
> >  			 */
> >  			if (xs->tx && !xs->pool->tx_descs) {
> > -				err = xp_alloc_tx_descs(xs->pool, xs);
> > +				err = xp_alloc_tx_descs(xs->pool, xs,
> > +							dev->xdp_zc_max_segs);
> 
> This isn't a bug introduced by this patch, but since tx_descs is not
> reallocated if it already exists, the array size is permanently frozen
> to the first socket's size.
> 
> Should the array be resized to accommodate the largest shared ring, or
> should the batch readers be updated to cap their reads to the array's
> actual size?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260714140722.111645-1-maciej.fijalkowski@intel.com?part=3
