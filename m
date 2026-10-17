Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F3B288C81;
	Sat, 17 Oct 2026 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792246187; cv=fail; b=rFM77wAqa/UOme6GCCZ33q/rGfVbAr9wszJG6rh7uPnWdj2h1X/nOrLtTDi1DZLXgkHgMkxBbi+Gh1lGhcI9CCwc/zgrHt1GfVDvODMhfRFBwqg9TvF2DCqUitGnaXYxROLdL6Ac5nDk1QT9yPxO8Qe1FaMnVBr0bLeI1/73uPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792246187; c=relaxed/simple;
	bh=QTyl2XgTnz/IFx6q5AkEbJrKZAWmbOjMldSapj9tLfY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YMhdADoGsGrl7JDA7uYnYDYrcw6ILz6O3eFM9w2zok4t8zRLaHfvhO+zCxI+sYC8BQ3JVIBRDI7H29iSEAzSqJhCSVjJk3RyJcKU4Jad9BJz+2cb1aQ8acL7BRuZAz3dlf7IRWcKyCdFLarwbPrUpkiSo44LbrNzJFi0NRbYKqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QB0/zA6g; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QB0/zA6g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792246185; x=1823782185;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=QTyl2XgTnz/IFx6q5AkEbJrKZAWmbOjMldSapj9tLfY=;
  b=QB0/zA6gOSVCndyejizm21Mt+cBIdKvAueeGcT3jlzaEMBA9xzgbmNPz
   +1SaHILiD3tLsRjjbsL3tF+xNLREHO69dD1hSEY8UI7Q5OxO7vQNmlWHM
   Cja3gihdE0DBuVLCAHyA4krK2hLp13zC0hzuAIRBzhwSJlWN+2+d7akPO
   n4WHmG5jg4uPoen97N0UOQ1Zgm49MCSsZH9CvvpdFbenMSAS7R9+kKSyZ
   iVsIyUAQdxZ+7r/7G1wmfGeO4+B1wnU9XUApRdxY0kPvA8akWEQ21pDZi
   OrOgFNivtGLzdXuUNJtVEDnDHRduRF7eipTzxydkg/JPKN/+rkcimw/1q
   A==;
X-CSE-ConnectionGUID: YWsi309zTrm3y5hohAbR+g==
X-CSE-MsgGUID: KtRJLjipQT+iFA77/EXZ9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="1009019"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1009019"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 07:09:44 -0700
X-CSE-ConnectionGUID: 3gWPiDCCT8qa7ravo42Z7w==
X-CSE-MsgGUID: rTO9z/XKQIKY9jTgGX9z3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2161989"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 07:09:44 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 07:09:43 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 17 Oct 2026 07:09:43 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.50) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 07:09:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0odvtL09qtHNvbQq6FWbwoTo+Ud88vL/Amzy33GEqTGRR+h/aSIBNYN0qh6t80RchjyKbi4GbMWwfarfZgKjZqBF5pwiFWmT56/1QpET0GPaWsmhA58TGI/iwaeQ8Pz0d+oUcqJTa33v8E3u47W+BBGhK+F44gTLfyUp7PHi7yBjwx0Se7YHyVN7AyxHpDXV7Yv7FmM8eQDEtoCg1bMOa7iPHo4ppjFwVosyd54zh+5WxE9kXPck7JNtWm4fW1245RfyyYPZPNuyNofkl1p3yBLO+qnw+UZn/EhMeesJv5UVSZasixXBBu1ILl3mguWwUNb0bveCQjmWBkBtZfi2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uT9a+FYmMaV089hyYf35SgPUJmIqj2aEx7GcKtrGLw=;
 b=axYL4j/TvltYB8/brO43DA5kifZ8TWS2yGHNMlrJPRYdsuBWJlqs7rbWBLUumw2u7sHn2UdHeyk5VQPv5DWO+6TA7VFjH0D1bKyvPsfoWwa6vLOx5kYOdQxclEbuuFtNmAZRDg4m1frYVFDByiUrxyURFSlBVMTNDeW18A7fUSgyny9D9QW+7fLHmH/3QYugrmkCshC4oSq5RM2gl7R0xU2UIa3/MDEmGNDj1nriSH4mZ9jtHXmEKFC0/dgHsdFGZ9pvhGSoJlS8f3PHXeQ/ze4V2MpSnkCr642owBBJ+ELDXp0FHrdA0F3bGgMiIDXrs1Dy8MxLG2F8wrNNwnpC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DSVPR11MB736929.namprd11.prod.outlook.com (2603:10b6:8:3e9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Sat, 17 Oct
 2026 14:09:41 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0522.012; Sat, 17 Oct 2026
 14:09:41 +0000
Date: Sat, 17 Oct 2026 16:09:34 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: Clement Lecigne <clecigne@google.com>, <aleksander.lobakin@intel.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kuba@kernel.org>, <sdf@fomichev.me>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>
Subject: Re: [PATCH v3] xsk: fix memory corruptions in net/core/xdp.c
Message-ID: <atOBnjNbppL02n8/@boxer>
References: <20260629072300.1664622-1-clecigne@google.com>
 <87qzhp51vc.fsf@all.your.base.are.belong.to.us>
 <atIfJAKqp3dZdY4M@boxer>
 <87cxt94d1t.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cxt94d1t.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: VI1PR06CA0156.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::49) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DSVPR11MB736929:EE_
X-MS-Office365-Filtering-Correlation-Id: 624b0d0d-c00e-4cff-4c4a-08df2c58497a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|4143699003|11063799006|56012099006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XqreCj2xOq9sb+2JAMlSJFU1i5Rd8r90z23dMUKJSzT71t+lD1aSxNSob6afbdAYHzrorGV/yBMy8X65trwqgmX5eR+bLCzZkHCQpyeZiEseDPy+aBpTZd8z9hMug1WhRXKrQ3SaIdFkFfZnnJmuDBAkh1/NoALX8m/+yzxi6X1BMs9UT5qapPPD7riOziW3huDmTpW3es9YXM38evV5f98sVvNbfiArz2tGPJSQqz1X/J8iRjToWMZW1/Z8gg7s/lkud9Tkm+5xy/UoGzAdsPtuVkZVCpQRzifb9Q9LpyDG5cYEgRX46UmKhtng5y27K7aTFNTLuk+bAfCdpE4Ua2Vfh1WnTrBT+La2OczzQmQZSuJcXMNdhCx0LQEof+2VGmgeF7+qHYH26gtEYD95e3+KyhDVqrEJvBeQzcFY1EMmtBbDYlOPgjpm/hMP7gKHLKHPjP4JIisu2aaPoAyrAOyRZ0/ZtnIF0L4c5zTsItFsAeVY7Uhg7Yg4Q3PuwTAj/6ZzLbO0Z7YAQg9FXxxPVY+lp/paVgsaorf/ctRXaeviRzJaE5i13dDhcqthzRfwnwQy71S9Vip2ozsQEcgP6FTXicEql5nCUp+Qj5b+UbkqvtuaOmgvqBOHsegJ3ENEpxQAGFPugd88Amyz2LEMc7zXDwP5nZbDs8cXwmnD2b0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Ai8nGDwgQAMBj30I/ewuXlVBnj2chH1RKd00PovBc7XJRoDqQxh9X8wjX1?=
 =?iso-8859-1?Q?k7PomU35ZVBwSqsNNdQVr4UE+yPNpQ4RstIetBL5CB7eC/Pz2ZtbhZEOG5?=
 =?iso-8859-1?Q?Wfbk79JkC88IvY1bnexglgtCspT0zYrCJAXskPVPtf6CPsjnWN5fMwBRMU?=
 =?iso-8859-1?Q?wft6T6njQvv0u0lbt8kY6H4MHZ9WRhmjNRslYMByIkxK9jt2ZEZKisnsNP?=
 =?iso-8859-1?Q?nmvXzEyaa8sy31EUKfnK9UhjSJZQ1FsQhY9C1TqlNJ4/RZRxrQw+7qD8xc?=
 =?iso-8859-1?Q?CjtBWQtx23Bd6k8xb5EumHntoaMQ5hTz9ak1lvD+GWGjOf0nwGjvct1fy0?=
 =?iso-8859-1?Q?Pys7szM6J5RZldIqXWbWHQH2xbla/X/3y7/ajmZwL0rMZ9H28bpbYjGM9/?=
 =?iso-8859-1?Q?hqhxN7RsnkM1qjOJfM4TXwW4ZWyPyta3ApgHtN98L2Mc0XtzvwEufmdd36?=
 =?iso-8859-1?Q?9qm4svp9z5KTvCVs93VGlMdmxFhX+XAI5viX6y52uB5hDHUtHyawt6qJZA?=
 =?iso-8859-1?Q?Jbtv07J9afdP2QKTdzCIK90oIyHeeFS5ihHuMhz35/w6KzVLrolvpkPlDs?=
 =?iso-8859-1?Q?dxMFgyQbqldtfWeie/xasBNlMrzDIhmpXCMoYQUv9Hr36TilEO0IbLAgqf?=
 =?iso-8859-1?Q?4TiRS9nqR22cyWVm9Jilkgzv4vcERWqyt9J5ZMquKeGKfwRTVjD3gzgo/D?=
 =?iso-8859-1?Q?Nj2cs4R/eL4zTsGk3L+sptVI5VaL6h2mIM5H+HHZXg/Z39LwO43zGyBVYT?=
 =?iso-8859-1?Q?lE8HCTtFgtmYkpW0dNFrKhLtG2FYVwJXsS8TzB2/ONJelBK8cWQ7geMOZh?=
 =?iso-8859-1?Q?7lri0CWy15m9AABqMGZwsCIZMZ/XwS+rRYJT9wRf2Dk0Hd/llE2Esny99q?=
 =?iso-8859-1?Q?8pCcC+tGASCj1CZEDdjML+P3o+vtoEYJv+wBN80Nr9lhqBjZd+JHWGJnDK?=
 =?iso-8859-1?Q?0rjnVkDIRzz7Nhep7S3QH5W918BDENApBNoIKK23s2VfXZ4gvIVorSGGyX?=
 =?iso-8859-1?Q?waD0g1wOqCWgUbBwOUM6BLN5ORT+Xa2rwj/7MvuGxq+zMDgbbSjOP887/L?=
 =?iso-8859-1?Q?LD97iOzRFZ+wHkUfoI9L3AWkXudQOBO24+MGeSs34eyh5KDs/a0aId47Aq?=
 =?iso-8859-1?Q?UIr5T8qIu6r4FdknzQJHu0Vp9cRc3aPxFYIas9GcSEL6CxxgE5l9+GLzzK?=
 =?iso-8859-1?Q?dZjvtbnFgjCjRUFB0gkJl/JWddeheAOPex3H5i0DR1Oo+L4PZgSr2bd+Jw?=
 =?iso-8859-1?Q?wDdj3fWc3mZeuVhVeWjvYaDwdV1iWfmj0puv4z5ezMEBSO/qb0OaTwm2YI?=
 =?iso-8859-1?Q?ndyiWFQBFViuR1YiP3dXC0/21BuNHWF0oRpy4Nx2KEMD9XT+rg3UTe6Jkb?=
 =?iso-8859-1?Q?4HsiHEykpFuvYyM+fD0W9qU69o/AJdgE20ARo44bmRE29Wm9rNAdAsjmmt?=
 =?iso-8859-1?Q?YAO/XkbosAmYaVeZoUav0nvI/ZfMEZ0CYMOsGfooUNIn+GiqVhN++u5XpP?=
 =?iso-8859-1?Q?SJpDLMP5lVlb5I1gVamxRyHOU3QIuCuoKC6n9YcNk8hEMfSST/UO9Z/m23?=
 =?iso-8859-1?Q?HQwIjkUFphWL2eMEUvNdZFp47VJ7CXar5yJwXzfpmZ/QWKFgf8r2yAi9Cm?=
 =?iso-8859-1?Q?HHygWxiyGBIcjiEVb7VMvpsWjJKb7r0LQJc2DBUWpwj5JMlCJqKFo7z0n5?=
 =?iso-8859-1?Q?xNcbiwoUZ2udYdqH0Q+5DiTp5eCocVBNWwRxItRW0UtwzBTd3jnl6e/Qv5?=
 =?iso-8859-1?Q?r5izlfa1OoJkqdl2u1G7NvfNoVCP4ks2V2+0nW6uWnfWyk2mg1Urjg1GAp?=
 =?iso-8859-1?Q?Dug1n7wyGRN7nn84K80dAHTH45wqEUk=3D?=
X-Exchange-RoutingPolicyChecked: tk8JHyVn8XMpcOv14K358pVdSXsPUo/YAdZKzSKJEqybCbLiV0Ff9wIn9dkxD6zm6Jy8NWPMLD7PpbORXLjFTtABTsyFb2HTD3h9ZUSLV8g+UPwJI2hFwPAygKGBN7WaBsntKg0w9kYbKRU8vELCzDMbw2fVAqB6W4SZc0McBBmQk7aQ/HSkytuH29t+MmGkF9PYXzPkZS+BYWQyln9GEpllvXu30xoA8Oqo+2NePo69+5jSAoyTigqqonodifEzsJn/ajNab+Q01ENOKvquKPfExdO0pON+2ZhiDFO7Ng8FJXM+JkT0WLFdmSN9XCmWNdUPKw0WLLTnKv/buI3LZw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 624b0d0d-c00e-4cff-4c4a-08df2c58497a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 14:09:41.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jQIU0xTYAaKPRrDlEM8642CgEG9HXUdeEZqLUnXNYoYHrTfIySIxv8wUpv3ZL+uxcVxV1jezHa038SejM5gg5Sxb1Qr7Qbku/+vSPDXIGEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR11MB736929
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 10:15:42PM +0200, Björn Töpel wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > On Fri, Oct 16, 2026 at 01:19:35PM +0200, Björn Töpel wrote:
> >> Waking a dead thread: RISE FROM YOUR GRAVE!
> >> 
> >> Clement Lecigne <clecigne@google.com> writes:
> >> 
> >> > From: Clément Lecigne <clecigne@google.com>
> >> >
> >> > Commit 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
> >> > introduced a vulnerability in the handling of XDP_PASS for AF_XDP zero-copy
> >> > frames.
> >> 
> >> Hmm, I acually hit this in my WIP for UMEM page pool provider hack.
> >> 
> >> > Note: Currently, this specific AF_XDP zero-copy conversion path is only
> >> > reachable from the drivers/net/ethernet/intel/ice and
> >> > drivers/net/ethernet/intel/idpf drivers.
> >> >
> >> > When building an skb, xdp_build_skb_from_zc() uses the chunk size
> >> > (xdp->frame_sz) for the allocation. However, napi_build_skb() automatically
> >> > reserves space at the end of the allocation for the skb_shared_info
> >> > structure. 
> >> >
> >> > Most high performance UMEM applications use 4K chunks, where the
> >> > corruption cannot happen.
> >> 
> >> I think this can also happen with 4K UMEM chunks.
> >> 
> >> For example, on ice, use MTU 3800, 4K chunks, and no extra UMEM
> >> headroom. Attach an xdp.frags program that returns XDP_PASS, and bind
> >> the socket without XDP_USE_SG.
> >> 
> >> A 3814-byte Ethernet frame fits in the UMEM chunk:
> >> 
> >>   256 headroom + 3814 packet = 4070 bytes
> >> 
> >> But the copied skb also needs space for skb_shared_info. Using
> >> the 320-byte size from your example:
> >> 
> >>   256 headroom + 3814 packet + 320 shared info = 4390 bytes
> >> 
> >> The old code allocates only 4096 bytes, so the packet copy
> >> overwrites skb_shared_info.
> >> 
> >> Am I missing something?
> >
> > I was pushing back on relying on scenario above as we respect the tailroom
> > now since some time:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a315e022a72d95ef5f1d4e58e903cb492b0ad931
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1ee1605138fc94cc8f8f273321dd2471c64977f9
> 
> Hmm, isn't that only with XDP_USE_SG? My example binds without it.
> 
> Then xsk_pool_get_rx_frame_size() returns 3840. XDP_PASS still builds an
> skb with skb_shared_info, even if it's linear. So we only have 4096 -
> 256 - 320 = 3520 bytes for the packet.
> 
> Or am I missing another check?

I missed your trick with xdp.frags on prog side. Get this fixed then! :D I
had a thought like 'who cares if we overwrite struct not used in linear
traffic' but as Clement said somewhere destructor_arg overwrite would make
a mess.

Side note is ice currently still only allows 3k buffers for linear XDP
progs but it currently works with page_pool not with magic page split
mechanism, so the limit should be lifted.

I might take this as an AR but anyone reading this in future feel free to
pick it up.

Bjorn, let us see if Clement responses in some nearby future, otherwise
please go forward and submit a standalone fix out of your series.

Thanks!
