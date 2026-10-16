Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57A438A73C;
	Fri, 16 Oct 2026 12:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155442; cv=fail; b=u+Q8sGSKzFSWpfUkfkuFxYvGPWFFQS/juxt/LJBUD5bw7Va6a7aURLKwZ0VKPPNemGM8l3QGM74hpIp0RvLXR3x34PvkOCZeTcJE1jQ4f1Mhw/JgtC6xaVonmkiZBSZ2bMpPCuF1aDKnU61XU5oB2ooISq9C28DIoCP40zYix14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155442; c=relaxed/simple;
	bh=oygV3tTeWJVaSxZU2x9fDBx6mwkCBtvwevs/extnri8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CYwZINRH8oRmvoNYWRJ2KBLG2dpqAKTza124HMhXF+niO3hegLFuAJ/if3cuF7tWqAeQfrwDCUWzA+IL2LiVPrlpuSwjNA1FGG3ctpDg9NcPs86wjJvzRBHYNOSpjP1qupbs6OCYE3znogml/RXotMrDlIulAX7TR1bTXG1DgZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cxpqqe8C; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cxpqqe8C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792155440; x=1823691440;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=oygV3tTeWJVaSxZU2x9fDBx6mwkCBtvwevs/extnri8=;
  b=cxpqqe8CGIHl7gGcyx5NML5Ux1eUOPDdHeCQ+9n3eUwUwkdZ4H/Rj6b+
   SB/eiZyN8h8WbAQ7XJv1fi1QUiI3G59RufdJzsp0eKB/uF9EqdETkEPCI
   FHnBP7o9x295rPohoCRHdWao45DM3c8RyLm0xxU732mOdwcS84MqIRADI
   TqCGPnst+WB7GE103b70+KG43GtFpmDhXWEaefOqGNiUiB4kWu48E9T1B
   1zmcAA0ecYAnZg4pPF2EgORTp8Ghepd/OV4ye3NG1Zur4fsL21TB6gKPO
   cV9Xhayn1ppxY6u0UaNog++zMlC466I9W0jzUQX9HO7EurwE4EMXjQrow
   g==;
X-CSE-ConnectionGUID: TXr29s+WRKyNHpO3kMa7HQ==
X-CSE-MsgGUID: 4PB5hEOuQ3yurWQucjV2AQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="949322"
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="949322"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 05:57:19 -0700
X-CSE-ConnectionGUID: 1Zmk2VtbSIiv1PqDzXOoyg==
X-CSE-MsgGUID: 29rEdGapTV6h1UbKijiFMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="2319858"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 05:57:19 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 05:57:18 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 16 Oct 2026 05:57:18 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.43) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 16 Oct 2026 05:57:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePVrSQjwwYY9RWSP3efT+BSb2jAMbcmDu3Nrn9Q5DA0D9UDfH2PGQepikL1uujSZzCX7zALRuZXElzSQxdsEi0rFOCpK5wjvlwsgDhwvPnUwkIaWbUWorrEtUbBiP66X9BwID5oeTgfNajAwgJLLJ7OgN2BUrkrtNoD9EGbvbs7+vVtVlJQXJIKtqAJSSlkCqRaHIrvQdNJOrnpoBC1aqIfi3M3L/lyyTHueVJc8LzFBY3VuPNJAmhzpSuSegSlpHRiaadJ8WvaIlj0Waq+of9gzYjKwYMCXNK6S2/rsJqG/5bjDZVLugq3m1E+FPEplXD0RS9QqOqq/YL07liK3aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H2eJkqTL/gR2VEJU9Q4lHbH9QohkCHCrdQbQr0cB1Is=;
 b=GwbpFFLvm4QG3hdOrud+j6PUYNntUEPraWPjLT/Iy1gi7FWN/BLVbGv5ePmaMJ0+GHsDBzcckoxeiQUgJAnQz2r2vw1WfydEo6Z2T/f3WrOy/rmOCUO4zw5/JukAvsCTAEp5FMuKOXFnSnjW0+RGmhwGC7OcWVVhjIBCuXAhbieiCrUqirCYv0mMKpKKGhC6naMpmfP5un1151qPvEGwhV7ielAzHs2Mq/yAQXvmODk0zk1ITazWt1IV/bKL4ZrUqiD0RVTnUUPK6pJPszYmuuUvY/pdOzxT2oTPmes0rKduPwdbIMJsoSM+QHiDUD9FTh4KsMUmrym8FBxQHjVo+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB6543.namprd11.prod.outlook.com (2603:10b6:8:d1::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.26; Fri, 16 Oct 2026 12:57:15 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0522.012; Fri, 16 Oct 2026
 12:57:15 +0000
Date: Fri, 16 Oct 2026 14:57:08 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: Clement Lecigne <clecigne@google.com>, <aleksander.lobakin@intel.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <kuba@kernel.org>, <sdf@fomichev.me>,
	<horms@kernel.org>, <john.fastabend@gmail.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>
Subject: Re: [PATCH v3] xsk: fix memory corruptions in net/core/xdp.c
Message-ID: <atIfJAKqp3dZdY4M@boxer>
References: <20260629072300.1664622-1-clecigne@google.com>
 <87qzhp51vc.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87qzhp51vc.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: WA2P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: af3455ef-a633-4376-0d4b-08df2b850086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|261009223027099003|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bBK0AnJ7Sf9Sx7fAj0wqRtqmRdH2IfQAuSakPxmfK/NHly7aHpmQ0UvUqUzxzAmV7XmDT+5r63o5+SUcs12TVHuhwEsKr/AnQOqZh6y1lMju4c/ju1GFr6q0/CPENAd6kstZ/bj36f8S+8n0A2UhgfhtTwwy4h0oEPULUbW7jEgipeA10ThvK+0D5Ehuegly+ttpIuk+/KKFL38uoSDNCit3dlHEzVtD8ziGnZXWGgp4E/faCkykDCifgVZG4nfUc4xJsHzp/0ZPi8VJ3tEm9DD+qInSe/IGhABy8r7iFe56YjNVcI41+xsUjJH8g1u7i0Ov3WTiXVueL58rmZpGy+kcNbOieFtoS3qhjev84eIWarNlcM9/Y9QHRS4gjj1Gv/+HGltPCxF7IiADcTUg2k4fYYVf1EQ8w9sdVU2+fTTDEiltxBkYd3gcrpTbsY2fpg2BSU7SR8O+s5hji6Xx//Bw1Ul9ReKegVtu+8xLpdb/QU9w3zjzrUS8vjloYKUhM3iEpsYFHaRFj7/nGCtqKseg1Dtm0uJPc56qphiGyVlTfygNnRHef8o4lFpiCSjlRx+h7IFoQNHFcy9CpkYKRE18iJ0e17Nh2U5dCnpewKfFm5MVimY8nxNNa9C6vMqDcH9LUfI6+ENa3abPywsSaYisQwu4DwX3vZAoy3MfCRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(261009223027099003)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?J7VzIGuks/22/vzWDK8rZPDKMnkBrTHn6HvYdoQQ9AEmxSEL08Xcow/0XF?=
 =?iso-8859-1?Q?jJ6U8EPBUPmyqVS99IqyEgCLYx9IyW5BBxCIEXlOAFavwnEYyY2ZtWsH3p?=
 =?iso-8859-1?Q?PEL2TsItH7oqM95V0zGDDrClj8YzQzGddyQoWFdAh8W4lpsI1EXgt3j0Tg?=
 =?iso-8859-1?Q?tX0HtDmwVbN9QfNkRjqNVEhVlbkIYOEdxBpmhDwoCbdGZkX7xU+i1+xfv4?=
 =?iso-8859-1?Q?MUbRGXgvPBbESjdbOhS8lzQuXzMy2xT3IBDMPRDyq8CewwlP3pnPWV/fNG?=
 =?iso-8859-1?Q?lgaWB2jew482XRdAiS+jr+QVX3ffbW19hsUBtbaQPJsZDPffwAg8MtSj6N?=
 =?iso-8859-1?Q?dIa64VEhM3dB3R2pE3euOiiN97kv6BB6zEOkgpW1SnD66AF2SN+5rwgTQk?=
 =?iso-8859-1?Q?xDe6P9btGTwD8T6cBBPUZBpvfakg2OWegNPkl8ezfrzKWmpZBdlmG4OlU4?=
 =?iso-8859-1?Q?CcOoN2zPp3k6LdbD3G5XzFTyGzvfkLbCR/UbYXjgyEqgYHqNIJSDQxNVmE?=
 =?iso-8859-1?Q?vVBzUu9Q3+sVMz/r0IFlqlV0h2FwwlnjBCgdElw6ayELdlZ8is8phADf7R?=
 =?iso-8859-1?Q?nA0MUrATufiEgRHxNsMC70QWM8gDzqt/onZcyYK+zlIHKeJ5kc+zeftu7v?=
 =?iso-8859-1?Q?CtFvqUsOUECBevLAFbt+vxy4tfop+/V0UQ4RIf1i9lYb7zjuChbMjNTSiW?=
 =?iso-8859-1?Q?ORf2s9jLXf9MN1fHQIjWN8TqIwoD/KDKK7XKSbYbJttEMalZ9NvXQMmQ8Z?=
 =?iso-8859-1?Q?PUXZBxhcVt4Zds19sINZfjRGxStQjlyrU9oYn89D7lwS0jyxDtiAx4GTty?=
 =?iso-8859-1?Q?dBA9nEFyQ+vIMjYKXA/gGAdUxNmMAyQ2bkCYfcyyCu7ALCvBrXoOLgypif?=
 =?iso-8859-1?Q?wxkPb2Hc3AbJXlDp2wUiKA5R2Xle7yzAZaC3OBT7TTqis2jCq1tXRM/RmC?=
 =?iso-8859-1?Q?2gTT8D8+ufPpT/chr0uI5TmGfzNZ56OvBwKCjzQYNu2Dnxzo8ZZTT4W6/j?=
 =?iso-8859-1?Q?h7pLeU7CYbxTC1DHeLXVAMqTbvUC9g3wAZC1Faq1Zbe+jk68z49y3hTkdJ?=
 =?iso-8859-1?Q?BDSvi2bx/r8RawU/jKj8i1Ejd5kxZ3scaRfExixe+UhnAW9YE3N3ta5OVe?=
 =?iso-8859-1?Q?CY8IuNe+7iwLJ2h1pa+6av92/HN1itaQa2H4K2Mq88qO+Kj3ANM3X342IX?=
 =?iso-8859-1?Q?McZJ+UR+vGU3gmGpTvcDphq2yTH+4Sz2vNmwVxKOkR8N0fylOqhvEzgP7R?=
 =?iso-8859-1?Q?iI3w/Yys4LbnRSsXO52rX2nHseZjKuYf1yHx7Wp+A2nNd/9D1JBdzcDBmY?=
 =?iso-8859-1?Q?baq0MXYzRiu9Njmeo0lmcTegWIstRuDWehrX4LEWsjyEnwsdhYyzI9nXpD?=
 =?iso-8859-1?Q?8ZUk04Ho4AK4TfahVJ3EA7JZRZ9qsALEH+hhsBLTleoRtF0lr91rqv+RnN?=
 =?iso-8859-1?Q?3Siq2lHtaPZ6Bm1HEaiHVIlpeK4oPWTtwaURP43kHkrX8fMs18sVdnLTnE?=
 =?iso-8859-1?Q?H/8tA2oZ0vylUgzyGmzTyi6vN3rYHyejBLYseVfk0UgZVlohkwKz8P22Xi?=
 =?iso-8859-1?Q?QCuqmgjeCflPBBKDSJy8eFoQrpMk2nw/Nn9dEbE4eeimXV8wCBcxYi1Gms?=
 =?iso-8859-1?Q?L7dVv29vyfDBDbLj9Lsqpd8cg5TOKOTe8I6kvAMCLBLah1ync3l3P2cAln?=
 =?iso-8859-1?Q?BkxjQI7SCQxonymkMLRHP6NLAcdtyefaIqcgoNE/2ztwAbqD6wCRmO7fGZ?=
 =?iso-8859-1?Q?84ZRgQjQwc07PEZCODzW3cs4foqyBCjz8T0gO+UPOwq9yNEcYKHcMfmNQH?=
 =?iso-8859-1?Q?LUbW/mAvxPr/w92yuKp6Ywr78Lk2xqs=3D?=
X-Exchange-RoutingPolicyChecked: 5NfvM1+qHsWlvmV/s03n0681pIZ5mF3bdwPW4cNr9VHRNF5hmgIvZQ/iLV9zPa8wludgj9fqg1VUqLFf5oWW2HaNLZcD7oB7la955HTxyvKgBvSlyDFtRv7bTNpnP6KyLCdQGDsrkUREcCU8elE7ocVVZFa9Axmlj6+6yz/kctgtfl3nLr29NclrloxqWdUKn+AY9bMbU8fiqwbWhP4jmBc9IWSASda/ChgUIkDAhhFToNDTQNJgAHSiFXUsCBVJq8W+Qt8nSK1p9us/1J0gdM56NRj9uMenvElS1dAJg9Zp+O/O4/DHVdk1/Aie+9hl3Q7OGSIv59HPfJs9sYszvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: af3455ef-a633-4376-0d4b-08df2b850086
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 12:57:15.1500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ig5EV4j8Zh8v8eTGSgVwPk70AMeCzPWO8M5X50qjaUHo6RfHWgWSjJlQpjBNXZwIbU6xzbgQ1nz1LEzChDgrc57/I1eRvzzFVDjDoXGDILg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6543
X-OriginatorOrg: intel.com

On Fri, Oct 16, 2026 at 01:19:35PM +0200, Björn Töpel wrote:
> Waking a dead thread: RISE FROM YOUR GRAVE!
> 
> Clement Lecigne <clecigne@google.com> writes:
> 
> > From: Clément Lecigne <clecigne@google.com>
> >
> > Commit 560d958c6c68 ("xsk: add generic XSk &xdp_buff -> skb conversion")
> > introduced a vulnerability in the handling of XDP_PASS for AF_XDP zero-copy
> > frames.
> 
> Hmm, I acually hit this in my WIP for UMEM page pool provider hack.
> 
> > Note: Currently, this specific AF_XDP zero-copy conversion path is only
> > reachable from the drivers/net/ethernet/intel/ice and
> > drivers/net/ethernet/intel/idpf drivers.
> >
> > When building an skb, xdp_build_skb_from_zc() uses the chunk size
> > (xdp->frame_sz) for the allocation. However, napi_build_skb() automatically
> > reserves space at the end of the allocation for the skb_shared_info
> > structure. 
> >
> > Most high performance UMEM applications use 4K chunks, where the
> > corruption cannot happen.
> 
> I think this can also happen with 4K UMEM chunks.
> 
> For example, on ice, use MTU 3800, 4K chunks, and no extra UMEM
> headroom. Attach an xdp.frags program that returns XDP_PASS, and bind
> the socket without XDP_USE_SG.
> 
> A 3814-byte Ethernet frame fits in the UMEM chunk:
> 
>   256 headroom + 3814 packet = 4070 bytes
> 
> But the copied skb also needs space for skb_shared_info. Using
> the 320-byte size from your example:
> 
>   256 headroom + 3814 packet + 320 shared info = 4390 bytes
> 
> The old code allocates only 4096 bytes, so the packet copy
> overwrites skb_shared_info.
> 
> Am I missing something?

I was pushing back on relying on scenario above as we respect the tailroom
now since some time:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a315e022a72d95ef5f1d4e58e903cb492b0ad931

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1ee1605138fc94cc8f8f273321dd2471c64977f9

> 
> 
> Björn
