Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3758E1A6811;
	Mon, 27 Jul 2026 12:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785153935; cv=fail; b=eLpfnijaJp1E3q4AwnO1yz48FdKOQ9+u7FLYEMqHV29wF44xWtUhsi8PIcELvjJg2y5zinL7kLLXfS02rGQyqUcqVXwF+Wui0puoa4YHlppw9KVnBR6mYpPejoMjndF5Bd/2levGsfJR0pxl9Ws/etB++v2L8GSXhKIQFDIdluk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785153935; c=relaxed/simple;
	bh=pgk7HlU3naRG7jjRscGtrRLYYNm0pe+qsJdyA+pufKA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KtUbtFfQ+h+eRriNk+bKkWfiKboTum36YCZFldLeftItAxgu2pJpWsdaGsGax20jHcth7Iau0CWnlJCwvqzgq9JBeQ92Rjbm/QaVGP7+MsawQW7TsKpDzloaEc1mEbIJat2CdgE5DU4dFnN9loLS0u6symzOm9r4voUWqDsaVH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BH9wRQgW; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BH9wRQgW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785153933; x=1816689933;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pgk7HlU3naRG7jjRscGtrRLYYNm0pe+qsJdyA+pufKA=;
  b=BH9wRQgWXujVgbrz3kuYtOS+aBsz8aigM1z5RLTclhUFZVxycTNkphwF
   EHNWTKMUMmDhNL4CO6ESRi92gyE22wNxZoQSOSW5ppo1NTZH/IOFTUPDX
   YP2JFq0xFz1v/DTShSls+1Pr8de6pR1Ya6wTlqfT8iNBOoVyA1ok3Ym5X
   k5n5WC/+55sRziMXGnTxn2qmbCiOR1ckZKFKWyxM23sJ2MHiR7l4M2dfR
   r+uo9pOlOWJCyHonm5Vr7k5Fmx5G42icH6nslYEvK4Bst4blED091mMtV
   dVHfdtyhpxw8T6JCoU/6D+eeConhLB/bIA1WQZbJM9E4gRJMC3NdEOkxR
   g==;
X-CSE-ConnectionGUID: HHFEhYJGSMK9dSyiXP+pDg==
X-CSE-MsgGUID: 93hsU1fvRs21vAlxOnMdVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11857"; a="97232053"
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="97232053"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 05:05:32 -0700
X-CSE-ConnectionGUID: 7Qb/fJIJSe2QF5VNhEiHEw==
X-CSE-MsgGUID: Fxij4y+rRMGnSmOKj9b3cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,188,1779174000"; 
   d="scan'208";a="255462922"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 05:05:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 05:05:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 27 Jul 2026 05:05:31 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.66) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 27 Jul 2026 05:05:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMsx5GVGJrr+bdjf6tlyt0hNRbQfaazcPIiCGPnocydvATeHJngFG9oimEJ8zmZ7Q81MaNHJflxhWZhHEDkVHGnRGrEBbOFO5O03NP40sRgn6KSSKVUetqWgEwicwMm/1JEokKTF7PlqPmiP6o4MsBRuuvXSNnsQ/WgaJLnLlEV57e3vZGNLcxRWwP2vtvkeuPp2PBvrHP5rANE6wEvgzgrnLx7dfahDw1QpfXFixyXdl9bGLJpsqPnX/IvtIDsaonPVZzZqPHI0PsT0GszkbIoeIjqc7xJaE3NBLQ9inu/8NZXQj9vkTMu8OkiYSy4cTkoOgdSQYA0vgEXvp1qS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I16+7u9z75JKtUAU+Hgel/YrKgSpzFq7n1zAAKSlh3k=;
 b=YY3pBeMT4DBk3w5z4+B0DwUxF5B9KE2ZUuFLH78aCia5zYnzpYaoaTBqHdZA6vB99iOUEaiEEMlroTkitQDULWHxyOUAB3GxYpzKWwKfMupY/MtJepIXMOBnh3bz0nzYdrSaQpznA+sTcesfaIXiIGfWJeT1GafCY42p1CV0/AvgbsooM5CJMmY4R1c5UB5qcypTHZt2FtI+GdAu0/LwvD/AHSki+Pow7N6kzrt9tkyK5VHT+YfdrWEd2EokeaQS1DRvAr+aNlLLee6IZHS0Hbnmb8nl2pyFhCGC54+xZ2S3am3ZvqrL2A/cKdu5Eh17E3kHDfEBt12t3wUOyPQBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LVUPR11MB9591.namprd11.prod.outlook.com (2603:10b6:408:3a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 12:05:29 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 12:05:29 +0000
Date: Mon, 27 Jul 2026 14:05:22 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
CC: <magnus.karlsson@intel.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <AutonomousCodeSecurity@microsoft.com>,
	<tgopinath@linux.microsoft.com>, <kys@microsoft.com>
Subject: Re: [PATCH net v2] xsk: fix NULL pointer dereference in __xsk_rcv()
Message-ID: <amdJgi0V3YwWE7oL@boxer>
References: <20260725034246.192091-1-blbllhy@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260725034246.192091-1-blbllhy@gmail.com>
X-ClientProxiedBy: VE1PR03CA0057.eurprd03.prod.outlook.com
 (2603:10a6:803:118::46) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LVUPR11MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5eb63f-67d8-4d8b-fe09-08deebd759ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 7oXWw0Kosr1KbJJV38/PL//qDuf1HtzMChVuC6vgcUin4q3IcVXgStxhiM7NioapzqJOUhoVq/JcISe9dsahVzL0rlAwdt+or9SacNxIhPeVHdl0sHs7p5mDimRm4YScicrDx4JeaxjfacRUkgX4SfXPtCCPJoSpKgn4u5EE/fbmx03IR23am8oRt0a8u3wTOKMLwmEUZLX2PaZFGzIPEkPo6y7bD33pjKDv8z3K72O4OwLu35kgJxpSVO6F/Fui61CnAOhI2XqkzCQ0y49uf3W17Hv3gHgCuf6BNNBu2y2gPyI50gAXjXg5vA8sNXKaSW+0Fv4efqhnuyn++XR82CiqD1BP9E4ADTmVvry+i7ZoGjqZET3wDqOIxlCwHDZSN1NOSdrpaouLNojuA6aKTkHDZVlFFnvj1irzgkz9MW4Y2iwSb4iDiW/XdyBoOLugiN04+AQft03d65RpJ6fGeAiPVIPzdvxM7oj3T+O0n83/weaTHUy/Z7vlqD5iqc63CmY43DOJ+6KAwibNa6cHtmFyuPFKo7MF8vySXVZDvhnZgH7pBmcCAbiSTZ12PLuCqAvBHI/ld3hWwjQvfWxbwnKm5KEGxG7uUGqNnDkX0GR5TtFcRLMWQGnWAuimJdTZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KkAO2WZFbW6GRCav2M3/OlkaJT+fpFpGd3h+yUCloLyBp33nofTTsmLwJj+u?=
 =?us-ascii?Q?/EfImBVXyLPOa6V1h1cnrxCJLjzbJKwcKqHiezM2aANx865ypHIPapX/0gH5?=
 =?us-ascii?Q?uN6DCYIr4ZBsTvdaMm0vyN+wm9HT2vwWWeftIwEC3NBOPCKXQdXqlyOg+etz?=
 =?us-ascii?Q?yxKXTUnFDaHd6VkZZCJM2EThFiHueWcCR1x/7xLYfXF8q/7zWQlGurJHbT4H?=
 =?us-ascii?Q?VaiC4cRBmb17i4RjGXBxQlnqEfY2ZFk+oHP6c38SGkCu8AL6zQO3vCceGwY9?=
 =?us-ascii?Q?k63avabMTou9SV/7iVA91tcNI4RkeGgnaXKvyNYCQwGcKr/fFnbDNJYzTzh+?=
 =?us-ascii?Q?xH0s4Dx3SswlHvenm6akM37loLUV+xxyR+phPmOb61jrmi2+rp/HxPpBuvjQ?=
 =?us-ascii?Q?cuISqcOY+7KGL25GZ8SrMEkCvGSEYGCsC4yeUFoWamfpd86IzUqTaax9GtKx?=
 =?us-ascii?Q?Jn6Ab8aq1yuw7pjolMvp18TDRD6Wk2gFoe/ZtnXNM2TfSIIcAwUHLIVEUgKM?=
 =?us-ascii?Q?oWh5iw6Z+t5lX1nuKno0po8wNnEeOtdki90PvPIIxfTcDqQ8qcSO4f5bxtnj?=
 =?us-ascii?Q?bAAM0YbN6ldjkcqhP/DPvTBxGUkExQKspGf9dZk1WNuG4nOovul1WIz26xVR?=
 =?us-ascii?Q?hgLlPXQEH9GZR60/oF48WbhIYAvIsy7JU6ljkSH/E5tllHhIQXC5aUajk0uO?=
 =?us-ascii?Q?m5YVdEyeJzHOFS25A581mLvModzB3HG+SUpCvK6X8g9c5XSVHxnKQ1GyZ6wB?=
 =?us-ascii?Q?mT9sSQ3OoxlI+yapCak3wj58zwSqAeBIACZ9o/lAy4gmR7CT4ltgCC0o5bse?=
 =?us-ascii?Q?N1JX4aT/iF55CPj5gcOo/Ygos5v7luWvAPpiHJboML3bwTrnLUTKeZcJqpgA?=
 =?us-ascii?Q?b1ojOP8wAEZixWf4RsaXNbdBBaYa741R28DUbpxKNfqUzMd/67V1ajV4aBE3?=
 =?us-ascii?Q?Mq458cRPAPGr7MWFD1XdQDyF0eoOOvRxPBlwrjNhUlujYYfz8hFd0c7AJEy2?=
 =?us-ascii?Q?9KsIGhhXxW4QwbHp+bRsRs5PQSwA15nd1u7IGx8fFD7MnXKEuV/GQeMs6r1w?=
 =?us-ascii?Q?zcBtk70BrmEQMHanSHt+1Ough+EVlufHTgAtw31fSImCTC4dkfG2twQgbO4A?=
 =?us-ascii?Q?Rrl0KuW4lRSW4zwxqTfPLDEq21yaS7pjXEcSNWH8dElUtryEihYAI4PU4pCt?=
 =?us-ascii?Q?fY+lAhpbEPHG0q4H2rXx30VISMlSB4DmsCQ0FxAeRm5GDoAwVgjBV07KneqP?=
 =?us-ascii?Q?8cU/yh4g5Y1uzfzBP0a15iCau5fbPnYkR2JZkoKxF81cjF0TKU30rLhZQn8z?=
 =?us-ascii?Q?m5uAx+IEFdHbHBj2vNnfqNdopQPDkOIRfANx+J3fbRwSOvyZ8jomqgf9pM7n?=
 =?us-ascii?Q?1UaGbpfkdpnAqr6Z28n7W/S07hE7WBUo4WRKFrM2cvVhS/3+NBF15L4Ul5Ps?=
 =?us-ascii?Q?nIZ1sSPY98UQOH3kAbSMYrbjNrtpeeIPYwIAnwyDkj35WOFsLmpDxUeClCcT?=
 =?us-ascii?Q?y+BM6op5DACVcSqFhMekIPeqHCvpcsO3UI4Fogew1aEDDon6PUhooJ9Ps/PB?=
 =?us-ascii?Q?dUsRN2AV6k5NC5BCko3/Yfm3QHO0yfn9Mgo85ag6D5fm6m797xzSKWlZze0M?=
 =?us-ascii?Q?GFD4tX5h+B7JjFkJ4nwRocrdF0Zdo/ab4yt1LpSNHcMX/Yg6Ufl8DKt9qjPQ?=
 =?us-ascii?Q?qWvWk99ABp8DpyuQ6MZ+AiWt2XojUsnAifuRYA97NErKf+RyVEIjAlk3Hnq0?=
 =?us-ascii?Q?MIFi4+n3GEjWLDux/auxmTfK9u0GNB4=3D?=
X-Exchange-RoutingPolicyChecked: cZvX2beGNUlyrOtrp61zJOmyAEF/VoSJFKiLth+/GtvXTAiQwyrA6grJ3NWuittn6nRr3y9kM6kJu+0yxb6t8W9Lp++I4xoxyzQzT9dHmG9Z/w4HstdFyVlkNkqsFh11X/I8qwFvVVQITYPlmLLOqbX7USt52t+JGTvfI5k9JFMjHnNwIeV4jFyrK7cg+HfhaUagmOQksP6FoO0xpaGUQ3fNnnh+lbIKzOSGQpHFKVTjIhensoXr1zbEjHg8i2mb5T4Z1eT0/9ahuJ+1hhoBTe2Kw3v5Ka+p0QiHjj0cWgmwOvGNieYcfzOTVlDWSCzwjl0lXaSZsWzGxziaPxdvzw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5eb63f-67d8-4d8b-fe09-08deebd759ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 12:05:29.3665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbRm1S9MGu9T+teyJ89XMP5q6vyIwEBve4clFEfR1drR9SWygXopYhBxt3QJuYrBo7NHO69Jiy3E82wMHzGh6OuTLEl+rJ0Z7JSS+fNWnrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9591
X-OriginatorOrg: intel.com

On Fri, Jul 24, 2026 at 11:42:46PM -0400, Cen Zhang (Microsoft) wrote:
> In the __xsk_rcv() multi-buffer path, xsk_buff_alloc() is called in a
> loop without checking its return value. xsk_buff_can_alloc() only
> counts fill queue entries without validating their addresses, so it
> can succeed while xsk_buff_alloc() rejects all remaining entries and
> returns NULL.
> 
>   Oops: general protection fault, probably for non-canonical address
>    0xdffffc0000000000
>   KASAN: null-ptr-deref in range
>    [0x0000000000000000-0x0000000000000007]
>   RIP: 0010:__xsk_rcv+0x426/0xc20 (net/xdp/xsk.c:350)
>   Call Trace:
>    xsk_generic_rcv+0x26d/0x5f0
>    xdp_do_generic_redirect+0x3c5/0xcf0
>    do_xdp_generic+0x92f/0xe70
>    __netif_receive_skb_core.constprop.0+0xf7e/0x2b30
> 
> Fix this with a two-stage transaction. First allocate and stage all
> buffers required for the packet, recycling all staged buffers with
> xsk_buff_free() if any allocation fails. Only after this stage
> succeeds, copy the data, reserve the RX descriptors, and release the
> buffers in an error-free loop.
> 
> Fixes: 804627751b42 ("xsk: add support for AF_XDP multi-buffer on Rx path")
> Reported-by: AutonomousCodeSecurity@microsoft.com
> Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> ---
> v2:
>  - Allocate all packet buffers before reserving RX descriptors.
>  - Recycle partially allocated buffers instead of only cancelling the
>   RX producer reservations.
> Link: https://lore.kernel.org/netdev/20260724164719.99563-1-blbllhy@gmail.com
> 
>  net/xdp/xsk.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index f906d51b6699..383fc2b1de48 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -298,9 +298,11 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  	u32 frame_size = __xsk_pool_get_rx_frame_size(xs->pool);
>  	void *copy_from = xsk_copy_xdp_start(xdp), *copy_to;
>  	u32 from_len, meta_len, rem, num_desc;
> -	struct xdp_buff_xsk *xskb;
> +	struct xdp_buff_xsk *xskb, *tmp;
>  	struct xdp_buff *xsk_xdp;
> +	LIST_HEAD(xsk_buffs);
>  	skb_frag_t *frag;
> +	u32 i;
>  
>  	from_len = xdp->data_end - copy_from;
>  	meta_len = xdp->data - copy_from;
> @@ -343,23 +345,44 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
>  		frag =  &sinfo->frags[0];
>  	}
>  
> +	for (i = 0; i < num_desc; i++) {
> +		xsk_xdp = xsk_buff_alloc(xs->pool);
> +		if (!xsk_xdp)
> +			goto err_alloc;
> +
> +		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> +		if (unlikely(!list_empty(&xskb->list_node)))
> +			goto err_alloc;
> +		list_add_tail(&xskb->list_node, &xsk_buffs);

could we use existing xsk_buff_add_frag() ?
then I presume xsk_buff_free() would understand list and walk through
xdp_buff's and free it ?

I believe we could reuse pool's xskb_list instead of fabricating the
on-stack variant here.

> +	}
> +
>  	do {
>  		u32 to_len = frame_size + meta_len;
>  		u32 copied;
>  
> -		xsk_xdp = xsk_buff_alloc(xs->pool);
> +		xskb = list_first_entry(&xsk_buffs, struct xdp_buff_xsk,
> +					list_node);
> +		list_del_init(&xskb->list_node);
> +		xsk_xdp = &xskb->xdp;
>  		copy_to = xsk_xdp->data - meta_len;
>  
>  		copied = xsk_copy_xdp(copy_to, &copy_from, to_len, &from_len, &frag, rem);
>  		rem -= copied;
>  
> -		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
>  		__xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
>  				  rem ? XDP_PKT_CONTD : 0);
>  		meta_len = 0;
>  	} while (rem);
>  
>  	return 0;
> +
> +err_alloc:
> +	list_for_each_entry_safe(xskb, tmp, &xsk_buffs, list_node) {
> +		list_del_init(&xskb->list_node);
> +		xsk_buff_free(&xskb->xdp);
> +	}
> +	xs->rx_dropped++;
> +	return -ENOMEM;
>  }
>  
>  static bool xsk_tx_writeable(struct xdp_sock *xs)
> -- 
> 2.53.0
> 
