Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B8944E02A;
	Thu, 15 Oct 2026 10:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061727; cv=fail; b=e5g+vhiTcWUVGlhI81nzCkk8uMETE58mrMu8Ymeb0cPNurcXXf3D7Bgs3mWWOMRR8g6qX3eWkhgNJcduQ+B9I9nYPvpPSt74r8DGj6qscSeX9taKC1guzK9GWjm2s+256iLq7Tg00lF6RVkwMG1sDXHA2owmoVen9z+OYwsBsNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061727; c=relaxed/simple;
	bh=y3qwbnlgMgo0kHVTsWeFVSunZ/P9KU2HxzvBOjOG7l4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NUI7WijJhVOTF7z+1UmSlNfD3d4JFbtn2WgSnIkeQKJdrYfGQ+O53CKCC9HiOFixvR6Vhvpq+r6+rUpap4VXbUYcffHxU0UHGtsvZHs59uoq8mY33JkvNPy79wgk6hxQ3pXSf+FWesLk0vLo94SFrprXZpE57PV5UOsROzfNkTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qqi1M9rJ; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qqi1M9rJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792061726; x=1823597726;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=y3qwbnlgMgo0kHVTsWeFVSunZ/P9KU2HxzvBOjOG7l4=;
  b=Qqi1M9rJIHFaMh7axBhJubwtpm7pLROPN/D4/RH/KKvKAt78b8cDhYSO
   cT9yi+iVsnKfeJISdoylYz/SEG/FdaL1yOYTW0CxkkQqCkeeLwvES7eTi
   HgAtcU+c4Zkw1DcFuys0tVZxBzP4uh9t66IerS45+xOeDhd54ODiftCTg
   9RDOS1oaykworpCAOy/XwcuVSASn1FLcZURXH+geP2xTN5ebwT/c2T3pv
   S9f9Os6vePjt/SYt55R2CcPGpsZmHHM0Bn11zv73KH77Y/NWZ3XhIA2ZU
   aGWfDFuf1ggtF8Mi1MGxY1qXG9CRGM9gbY9LLPTgOckPvPCsLl02q/w62
   A==;
X-CSE-ConnectionGUID: gT5WRW0DRgO2l61Gkor3Gg==
X-CSE-MsgGUID: cF2tOXULTlKgz9fJthy39Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="715810"
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="715810"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 03:55:25 -0700
X-CSE-ConnectionGUID: VwMSaCThSSWwD/D57sOkrg==
X-CSE-MsgGUID: t4Fgu1OpTciBf/TvL7rygQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,159,1787036400"; 
   d="scan'208";a="3428092"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2026 03:55:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 03:55:24 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 03:55:24 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.2) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 03:55:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEmiYW3ORAW+r6+GgUguWH2Kw2p8SacsApOJbYgw4U91sxhUc/ed9zTeNw0a0IEhFW/Cnv9S175dBGup+OSV4Zuqlk8YvzjkkTwLvUzOoOBMAwprv8lKMcP7lQgtj3cH8W5o3OegK5hEo/SI4CNtmIXGvPnYRYUxBiYUX0PSLM2qvc2S4KaUCtrw6/N//Wspos50qtH0HnIuMC11SGhqkJfXAqcjqe9lyGydbEN1lUyB8K+NB+EyVcsZBRF7WlRhVDdzJy55IXuDfUrBxT1mWAmzrh5JgJPenCjzu/RknYN4bOS1WNgia5DKEDM+4Y+gferAcGHm3h1dDsvQgRjGiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4x/8NXfRqTxyqWsPaxIoriLjRI37rMn8ALEJPPEj94=;
 b=ZtoGmAt88SHdDXd5AZZspmrD5zFBmt8Po3oMYlABEuXxXAiLGVnSmRxHrXPTI7jMUHfQ1KpQGkgULR6ZmxzW9mpGzNDZ1oCdgdgVDqlw0QnEUeJrmyb34YnWYjmIl90z4TJAr2KnTCjDUx2e2Ei18oWwOHEdLTRbWv8wSy6KDXvzzvtJpnw68w15Vo99uoc+U6IpaKSgLT1i4JiKlYtBwnegrL3hmW+R/3Ou7S0xhQID2nKUqnRr7+UHt5Jm3wkIMMYihtLjD6NtgXx4FfwYT8qEZlIKYMPFfukO6sJFHsMVuRJVl2FCESZ5YnUROFP0835X9RHYPpByvY0Vuma3DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA2PR11MB4971.namprd11.prod.outlook.com (2603:10b6:806:118::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Thu, 15 Oct
 2026 10:55:21 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 10:55:21 +0000
Date: Thu, 15 Oct 2026 12:55:11 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
	<kerneljasonxing@gmail.com>
Subject: Re: [PATCH v3 net-next 11/15] selftests: xsk: add a hardware mode to
 xskxceiver
Message-ID: <atCxD0EJHCRBR+pI@boxer>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-12-maciej.fijalkowski@intel.com>
 <87tsmn5mg4.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tsmn5mg4.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: WA2P291CA0002.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::22) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA2PR11MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7e82b2-8d28-46b8-4651-08df2aaaced5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|4143699003|56012099006|5023799004|11063799006|6133799003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 9XbiXS6Tqya/lcrjf9yMXpmxUK38Rb0G9Byv3mCpJIXJvWowGpsLKec540cN1tBengMQ/P1vZK6bz7TcpMkuQQ8/LfxBRBDbiP/K49sQXGukmbED54z957pl4X/Z+e4CmSpPseVPCYW4pNNJeqt9zxEbgcgEVU7+4+2A42K0VPbnijr+loJ6Q7h/BABrbMEvvvYxuGOXnoFJ//OzJPV7WzlXHMcp7NZP4DlqwG1Hmu0ARmJypr06ft524kXOME9aCy2xzrumninFyL+TESAZKml3AqHkOQ+RWDY5BV1wpnw0UqshtwQhdjVZgf3Z9c8zIWtf6k/3mH5cvqp35XoXTsrDfyzYXhS6kq/waQFeUZ0Q8H5YyhNtDBksZGzkkP2JDRcW8MsNoA9KB5wj1Hqrxf1smT5tMMNdz091Gk0pBptnO5NtcEB5mo6t6rwzHZJc43EBTmiAeflZLiSMfpCjabhcZbJ//r+FQk0/qMQygTw5SCBfZRU6JsH8Bl1bkSwAvheNM8M8731uUlYreE++xEq5J3Iz48XCGcu3gm00rmRzm9rpt+eJzfuWDFxFAlnA8YQMFmVakQ9sY2TmzzkJOKDmbe+jhuXq27QfDums0bp2h0BjgaHu1Xf97JyTi2j9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(4143699003)(56012099006)(5023799004)(11063799006)(6133799003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hLdZRFrir+5O6eenIToACqOXyujkJ78tqXawv7SXB1TfAHCcfPwvje82BG?=
 =?iso-8859-1?Q?ilWfKURGAyFjD2tNNIgaZ7tyQnXcdd9bNZoIOnBkqBzBw+OPIJEm9knW5Z?=
 =?iso-8859-1?Q?rIY30a0OkPaEDcc+GAFiO82kSbSWA6bNJLcSXJY/Y5ezsJ7pBjTrHueYgU?=
 =?iso-8859-1?Q?gJZYAgexsZCMs4zXPwlXTIN4PsI20nuLLAfEHvvxKPDNgKk65rrhsS6BEz?=
 =?iso-8859-1?Q?xMQzvacaSKVX3aM7no3MkyRNsSc8ilEi7mKpXblzwa6goISWgfDgJ3HwvA?=
 =?iso-8859-1?Q?Ezb2Y0Cpef4JTnstGoQs8PbGQAEnFtB4dCicvifjTiRfAZTDKXKZBpMprH?=
 =?iso-8859-1?Q?ELdzqclOoZuW0uc7EGBRQfiy+yu+VE6EM2Rxfkma7ip2G1nXn/XorR+ijw?=
 =?iso-8859-1?Q?cbfb72Aid8vJDokXcriikmO1NQt7fXnnGit7yjDasmgJSUDxbrF3kH0s8D?=
 =?iso-8859-1?Q?B2kDzYOQBwI5jzk8hC18WU7OqWMxGkHL8pbNyOGnjIja+HQwbViq/60r8q?=
 =?iso-8859-1?Q?qlZEBIn9gvWwRKreMt0uWIloQ7bUAhoQtiYJopLqK8R8E6TmFJgjZZqVmM?=
 =?iso-8859-1?Q?HWq3xL4Kz/wqyNR0nm424QWuivaJWQhEIij64r/RmNxiGviuN1Pj3/353l?=
 =?iso-8859-1?Q?MKiAzbLUBVDLOqZOeSsfxV4Ub+C53lF2jrDuTsHzc/CPRzAJ18A60KFsNd?=
 =?iso-8859-1?Q?+uIGlqDyaG1evfoQuezdqS9sVmOXm0jk/i4Qvt/KMoMqyjNqFr3p/RXvfI?=
 =?iso-8859-1?Q?CX9DqCnJK/MpB0am/m4U7PRuxahuZyVMUUtTel4ai46eWmh7ThLTPScdIM?=
 =?iso-8859-1?Q?oYjGxLMYB6y3mM5heZsc9J1CNwMG9PYSh2WJAiozc+r6ToPOwt17hCWLmZ?=
 =?iso-8859-1?Q?qqpVploTwb8gE9+QdSHOmjm1VJzLSzsPbLTj3qPegozndt5baYrtgXJ2Tm?=
 =?iso-8859-1?Q?Ju+Vy5svXbMrNoZf1FGXaDE4E6W2Ks4yqqSst1D7wES1I5IWcbFT7IWSAh?=
 =?iso-8859-1?Q?H7Dpn/4YP8Pfy4du6rldiQCkLPSzCOCOVbt5wmA6xG14Y8/BohD7e8WYEu?=
 =?iso-8859-1?Q?PjKfPvthLNX61JKk89aTAfcP3TbHC9HdWXuqKmyEMZk7HIRmgKbkfncx9K?=
 =?iso-8859-1?Q?jqm2wU5av8D1lx9DaDz31rufI/x/vMb1g1WyPRNxCmJyLECD1RlTXe/Au1?=
 =?iso-8859-1?Q?lJ5QwxoP7AMdYD0SYCztBIoe08TEygp8xbggE//OCriaHpaU8HhLwbKEaY?=
 =?iso-8859-1?Q?FHP/TjVHBf0KkAtf0kmxcPyZ0hbcr5GQCh/gd+nauG5/sNnRPklW6l0Tuu?=
 =?iso-8859-1?Q?LJqJYnb6ODUHRJgARiJVgQy2gVN+rC3FqhB5krd/7ELgG2SPya5llrbfmc?=
 =?iso-8859-1?Q?c6stPEhibZY9e0IxzuVyWDmtzlH4CMxIctsRI9ww7GlOVCW8Mq0mhw4JRQ?=
 =?iso-8859-1?Q?30jtpUpLMAAVe/Nx9a+OKM6I2Wq/Cx51Bn2eIpQSLANmAS/hTgb0NTFjBH?=
 =?iso-8859-1?Q?nKJKvkBB7jnfOAtFN1yyT/7AiVj7k4mZemLGWaV3u3PkGAjyXgKYFOn24m?=
 =?iso-8859-1?Q?sCLPAA0xZb5iL7L+895e31cqPkTqb+t6IPIOC/MXhqvXbAlkj/qtIm4nRy?=
 =?iso-8859-1?Q?8UpHhavs3ufRlM92V4Wi8w6nPbpsykFf6XKUVlsFHJPT8unPWDfF8o5R6s?=
 =?iso-8859-1?Q?Yidpfjl17j2s+YsXwa/QZftMo4FBxviEoxMWozE6HFUoyS//TQtqLvE4nY?=
 =?iso-8859-1?Q?wKjehulX5UtHsTpcNTnLFOpsAFIzAKg9fNZdNbwO+yNCJQQR32Rxc8OinJ?=
 =?iso-8859-1?Q?q/Y7la3DTWjsN7lP4a8N/k0DyNrwgjQ=3D?=
X-Exchange-RoutingPolicyChecked: zQGnB3WNAeZ+SxrCu/hyfXzLQJ5zUbeL9XwjCaOqpuJA4+p74MHQyLDGOj7dcxZBrxtr9SMYt8klMjOgpFjAJY4NJurqHrmrS0PzNX+U+EYxn6uBoRSj5evlC5sz2/fcpFOL7pMp3jdT7SHacEMG1Y116bJCvWysgnF2ZP1JJ7VyEtgkuta0ViG+xFwmiSDgH3ervSZOCzBL3vgob3WgpKMVXXY9Zvbb40+XlZWuZo7pwDaaspJ1MHEFh27Ch/6Xsm7vImqyBPjmU5NLy6aczJvEcqE579YkJ4oYRMO1ZnvXeu35wrXSUcSGCRQ87+3LIO7N0cDbsypdwDXVBw8duw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7e82b2-8d28-46b8-4651-08df2aaaced5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 10:55:21.4320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHOw05Tyy7Lv+f6FFeb7OzPPpNvzJNI3pvfbf84WIZHYzi751NzJW5COnWg44Y71ZuiFUwZ+G7VEyD4pHEZLEU0fdEbW5TCEvQj7tUM1YIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4971
X-OriginatorOrg: intel.com

On Thu, Oct 15, 2026 at 11:42:51AM +0200, Björn Töpel wrote:
> Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> 
> > drivers/net/hw/xsk.py, added later in this series, runs each hardware
> > AF_XDP case as a zero-copy DUT endpoint and an SKB-mode remote endpoint
> > over a physical link, without negotiating capabilities between them.
> > Add what such a run needs to xskxceiver:
> >
> > - --hw sends UDP/IPv4 test packets (--udp-src, --udp-dst, --udp-port)
> >   between the real interface MACs (--peer-mac); XDP_SHARED_UMEM, whose
> >   program picks the socket by a synthetic destination MAC, skips
> 
> This reads weird to me.
> 
> I wonder if we can avoid introducing a separate "hardware" mode here? It
> seems to bundle packet format, link handling, and assumptions about the
> endpoint modes. Those are separate concerns, and much of this should
> work with veth too, no?
> 
> Could we first make the real MAC addresses and IPv4/UDP format common to
> both veth and physical-device runs?

I must admit I have not tried that and --hw introduction feels like veth
approach is still a first-class citizen here. Aligning both test runners
would simplify stuff I assume, will look at it.

> 
> Then --listen could work independently, timeouts could be configurable,
> and test selection could reflect the actual endpoint modes and
> capabilities.

You select cases based on DUT's endpoint and its capabilities. Regarding
timeouts, we can add a knob for it, sure.

> For example, skipping TX_QUEUE_CONSUMER because hw_test
> implies mixed ZC/SKB endpoints seems to encode the launcher's current
> configuration into the test itself. "Real" endpoints could also run the
> same mode.

This test has nothing to do with ZC at all, Jason added this during one of
the many xsk_generic_xmit() bugfixes.

https://lore.kernel.org/bpf/20250703141712.33190-3-kerneljasonxing@gmail.com/

Remote endpoint's role is rather limited and I wanted to be sure that we
cover both tx and rx sides from particular test cases, that's the purpose
behind --direction and storing test cases within 'hw_group's.

> 
> If we need to keep both packet formats, something like
> --packet-format=udp would maybe describe it better. I'd prefer keeping
> these behaviors independent rather than giving the combined mode another
> name.

Nah, let's make veth runner use what currently 'hw' side does.

> 
> Also, we need IPv6 support here in addition to IPv4. You can't assume
> that the DUT is onlink or IPv4.

Is that currently a show-stopper? That is another left-over from old
architecture where data path was rather on a local and isolated
environment... /me finding excuses ;)

> 
> 
> Björn
