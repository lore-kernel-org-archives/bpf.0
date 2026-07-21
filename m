Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486343876B7
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 11:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784632331; cv=fail; b=uKBSLEHs61r9tgKKKP4jd35496qNV8kxU3RySd1RKdQbrhJBmRdu7G8KPo4Xz3zOqKy60Rg81ps9j4EYbKTkyLo5eI22a9LYo6VpGoMswX23Gvih8CO0S++WTEnMU6IZ0xDkf9ABd8VxMXQKmds1xWaBxR2Gh0MrqdqTriMZMcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784632331; c=relaxed/simple;
	bh=gG0paWB0wn+W7Z17yUKwnf+zfQrS2jSxT/CmWJ5jqCU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u+3TqzSA7+hYqkZHuP81scEIMSZysqmrvwUXB25kTQaCzFtSXoOZOUiXYtEHSms3oMqsiSm1JbjzrZxHAo/kUN4MEwHJaG7eWzVGVm8fG1yXAgimq45APBqmoO/wuoNQNIaA20JQCI2mPpTg+SLbLfmSD4MuurrMdZIJoXxqyqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4quEpG1; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4quEpG1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784632328; x=1816168328;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=gG0paWB0wn+W7Z17yUKwnf+zfQrS2jSxT/CmWJ5jqCU=;
  b=W4quEpG1Ew0NAaACMfFrVdkjXlIwxSYL/qu4/zNp/pjIR2tRYyZTeMCZ
   NOTkAkCh4DbzDv5GjgeTjIGrCowQNKlyMxS7Y0ttSvQ6qnMEGE6p2hixd
   p2Kodl71SWw+vfevLfGoXysaIVNlfL26P1zhFFIXsWja9bs1/6C0U6Re6
   lt7mZ/9HwffZVrc7I2LoGGKcaOU3YEHBQDmlL27vVmmAOwOawkFxqtwn9
   IDjEr4OKRwvYBIqJjRJbFkLFMXkLeGa7+VjDb4i5cMRR29YTqkO8vBNOx
   o0avzTDzh25IgaKlA+GynwH684EcqW29UXTx5cAV/YRf7qP9X7sSF3ASk
   w==;
X-CSE-ConnectionGUID: +TVBNWDATGSXsbJXj7TDdg==
X-CSE-MsgGUID: 0H0Hc1ShQSyacEnJ6hHTvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="102778293"
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="102778293"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 04:12:06 -0700
X-CSE-ConnectionGUID: ziuFmeylQt6Y8gQbFnFWRQ==
X-CSE-MsgGUID: cDyBrj9PQOaAr4IR7Kf5Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,176,1779174000"; 
   d="scan'208";a="281009713"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2026 04:12:06 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 04:12:06 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 21 Jul 2026 04:12:06 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 21 Jul 2026 04:12:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+DQCzIFw4B8BeVNoxgBjZfNzJ1m3PQrNWNjuqf90gDCg8XtR3xlBtLqucxrGiVBSeNvaTnatE+v6P0NpPUD1YiN2LWUS9zfWXsGeyJGUnNL0RA3mk2+PXfInspmHctsMORqsyR3j3pd8J+Kdo3GTsHgQylFY5ApYJa4sVAxUOF11M85EewP5iCFwM+oftCpkhKCG7gbZWsYwvpwC9kQmSHxdnTS6xS2WvxfMAg9WibZxQ/XprT96S5O/k9kUkORr7VAYZKLXCgEQbZW29l4Mkp852voB6guqhak+Xg1jUXdcUTST0NagtGJlucAN+Qgy1o5TjkOQKHANmMvdCsmog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/h2fseAgvzwwe+WHSn1d78RO08kwhmGOL1bvNisOmrY=;
 b=uBQ8Izs4xibMaVOYwtMJWyjuYz1cGBPSZ9EufX4+1nRul02pcdqC4UY2Fq5I9zIglGTcAzzawgnf971iXn7W7hx6WGDIfVj5clsLOofh1nHXion/aknzzci15LEm51hieWOJBcNu/6RDTVwIR2ycNYDPt3dGWyZqKy9qz2qdpeZ+l8cs000p4o1Y76x6SX4DvJcZBwMpcMcBf3epnD0RVIPjHDZ89UEtLC7PRPj8UYu2g157/dPnG+ngFsbK4UDTFJXFd7PdWERDO32i9I42VDlfiuLAp0hoxc7ftlILZaISH4nVIZWTrG2Ozq5eAG+S7w8oc3VVk6afXEE48nhKhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM4PR11MB5994.namprd11.prod.outlook.com (2603:10b6:8:5d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Tue, 21 Jul 2026 11:11:58 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 11:11:58 +0000
Date: Tue, 21 Jul 2026 13:11:48 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: Matt Fleming <matt@readmodwrite.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf v2] veth: convert frag_list skbs before running XDP
Message-ID: <al9T9Eto/hRIzP5W@boxer>
References: <20260720140545.461747-1-matt@readmodwrite.com>
 <20260720141859.19FF41F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260720141859.19FF41F000E9@smtp.kernel.org>
X-ClientProxiedBy: VI1PR04CA0069.eurprd04.prod.outlook.com
 (2603:10a6:802:2::40) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM4PR11MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c1b0ef-57eb-41cc-3db7-08dee718e191
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|4143699003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TbQoEFTli2+/PaUUcNeFDYSxvXmdeW1VoUJKIbRT70yR1JuiWgicdOEfhbhuIUSD5DgFhd5oBNwkWofMLUCsR3mjfMhn2/BCf6Wfy9MRC0jsfNC1LPWqMOXi5RbBkAgy1vv+BTzgdmtNAo2uUPElQdwltO5FnGN9PFKtcET3g2GJirZzFozHV+9juKOcvXxUks7LuqoipjnnXx2W4V9BHepmkaZglGW6H+u++h3FEyRriIUTSZvrH+jde65PDGJDZ61Jr4wA5KqEFaPxvBfLLGF2Trblkb+LAKJPog+FMh4Cf3P/RORpd9P7sk1B5Q+RxtCPrjnbwAXfWZ7dC7uYU8IZHbblABsmDHbNbltPP1tluR8nuZz9dMJQKp13CBqpBMAFKAYbQB+gBJFgDU46LOvHbICOnmwsJEEGNkwtC7vQbXI32qAWs6TqveZYOFJ39mTad6aoXjOIr4SYqnevBtssSoIB3L8eS0vIMCLUo6QKd68X/Rx4rgwDq4+cMUbr1aBHbsSmFV1dJU1y9ksuU16wZS78iZgetyi+5gGg8Mi9pIcc2hpTBhDiL5GtXGdqKW8XEHLR9aOlLz+NosHIQ3Irbwq/Uu0A21gSlPvtjE8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Qkbcy2JPdt5zb7+Ou7IBjTVm/V9vIsx1j0hYHQKpkhX61e3HdnI80Dn6Jo?=
 =?iso-8859-1?Q?NDijUzjCk78r+xycrSEuxxwuPOi1icrfndDqfv4WDQG2CcWOgQDodk4wXf?=
 =?iso-8859-1?Q?Sk+jAfNqAjDaMcvssPxSBDt+o7gpgXtr63mLDMyvYjfyJF0vLulcMGmh0b?=
 =?iso-8859-1?Q?nIcMPn46jU0ZzhFOyDXagxN9H4cuUnoTnvL1TbmR1K5Ae5DqEPLdmBnAH6?=
 =?iso-8859-1?Q?xGgdF62pY2jhy8gkJa0ZB1EbQMlFw4EUadT+xp+Q2YNf8ZQnve3QWY6w0d?=
 =?iso-8859-1?Q?J8PivFyHGIEklCJ5/5fC2A/G+WXrpXFhPpuS0uhq2Q5iIoh9bHFSiIrjx1?=
 =?iso-8859-1?Q?5RI/z8ci3xCHmYDywL/wAAcyTBLnFCcHLrycOVQoT1LIKqqXluexFN+kX4?=
 =?iso-8859-1?Q?MUawdPAFJVJqdLhVDs6Y3TsotDuzpAFIWnjZfhhDxBluhYss9eAC+myKjr?=
 =?iso-8859-1?Q?dI5C678r22IFJZ9XMBDX3JlpPgrlOUdCNFX5Mx+M1JSHujvPV8KsT8y/qX?=
 =?iso-8859-1?Q?4GJEhyuq65dxzucFbeuPwbrYTicL9kLq9HqCvzieL8U/LSrsceyRutVEJ1?=
 =?iso-8859-1?Q?Uw3Eajx3lBtc46KfEhKbvf6eXY3i/gbKWioC8nmOFeEtdZGiJkCuIvN2aF?=
 =?iso-8859-1?Q?CUCy1A6C+Z3LHsqc/oRvI8iK/t/bseBAY1g9q5VRmV7a0u+rLHqCVmSqag?=
 =?iso-8859-1?Q?ogYwNWQ7Y4CRXsvs4PK3tW+JKDw/Zsdy81yLHs3JOuC3s9uzQlJV4xvDFA?=
 =?iso-8859-1?Q?N9+PtohbN9ukz57nUySVkTc6PcmC4esPJ2+a4Y8GEtk6C5hmOrvz/JXmQW?=
 =?iso-8859-1?Q?R/e8NhtW0Q5AgRpctRptsgmjUimBVubc/d9GjlbXn2Ymog8fv/Elkdck9Z?=
 =?iso-8859-1?Q?CwAoJtQu81ULRiYZFl71BJbWFuD1jCQwmQObuJKmkRn76mjYrZpA2r6DeM?=
 =?iso-8859-1?Q?680x4oGyNjQHf3Qz1KzJpLepm+yMqDqZl1V7on71dL/DBfgw3LrQFp815K?=
 =?iso-8859-1?Q?F3nZcLs44NCcvQs36aowLIOP13dp2DDkwVNp3wB1R0PbAQagF2ESLDKcGN?=
 =?iso-8859-1?Q?r/CR/Ob/EDJyA4oSaN14twPbga9YaJw0dd9FPLZeAG5jmbcpOhbC3sQMP8?=
 =?iso-8859-1?Q?WA8U1E8veOehECxPu7x+AOxIGLDE2qg4KFqEU0bhPq8C19p4fN0enSco01?=
 =?iso-8859-1?Q?7aDKJ4jeBOYbCj9z5eZqdUbK7GBr9vB6sVx5J/MAdjawe/z7wKywxlWLir?=
 =?iso-8859-1?Q?U61lK/WKBxcqPPJpZg4RXwMi983rEQLZjnEIdw/qdrZavQQzZjLGeI4qm9?=
 =?iso-8859-1?Q?DIBcbK5R0I/IzK/4LHPyTL3RJ8n+/YgmiDk67rmEPgWqoUwnZ41PSkRuvj?=
 =?iso-8859-1?Q?ovQTfAvYgay57OczCA048pkAPRS3TDzGb/JPodrlLeThkQgiKC50qEiugd?=
 =?iso-8859-1?Q?jR/FqWdLcksxVV6DoD/t/RIOruWK5a3uzdSjn166JxixDKT11hqKZgt/cb?=
 =?iso-8859-1?Q?/e7q8EFPEgKzYTl6AnIPsINDmTBW4zQP+L068r8fD447LGUezkVa1Kbe8P?=
 =?iso-8859-1?Q?Bq0W0efYx8yuZLphWF8xOy8yHp+MC5tRwqNxK8PkcbH8Y3wJPkYHLCwfJU?=
 =?iso-8859-1?Q?xf2LTbJjLfK5cb1ZBhlbNs2NrYxw70vpKnXrCoh0yEPrDFq+boFdOiZh0j?=
 =?iso-8859-1?Q?Y4didw5LFY8K5WBOz7MIW7XSoadkQ4AkDGxguU2k3q93xHd+onfT25sUsp?=
 =?iso-8859-1?Q?LIp8hg3WsvQatoi2vdr/JmpuxdTwAh8nKubhDWbHSVTPZUwbyJ0/JGiewd?=
 =?iso-8859-1?Q?V06VFZwrr0nh0QFVhBy1RxZUYpFero0=3D?=
X-Exchange-RoutingPolicyChecked: opeQJbidvtg9GVpZpeP4tuJ5Yj6vhmZXaRHPVYsb8a5Uch3mVOGraDCnm44quqqnx6oavW9k4ZQdOMj8CtAsMticrDOWf6OjDBJMxU0Yupxi4hsEiyXbOj+sJXGN+JsjTfvRMY2NpeARS9m6pRSt9GCoc8jEeYn9FDv0ZoGO7T1b4R9JCoWB/79KX9Dpkv+mbEYibgQsvnCuN7NVklAT+FUAYeJ50imSPZHrRIzWQUmnG7Pc7L4nmeNgd46oGGw9NlyVV/CvKWr8C5R7xi2fb5WSuV5rR3SA8VFZHzFusKhvZmMXipMeWw9sXxv7/dMhJiY3gIX0sw/iGAMx5kdLSQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c1b0ef-57eb-41cc-3db7-08dee718e191
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:11:58.3638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b0Eo57srAUhey0Vt0tRxN6qXxNUxC55qs33pM/F1zokS88lK3QZwOwb3AWAS5KCdpxT2hnTL4FZYMbBn6To1u7ooCEHXxbmqzTg4xLraGgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5994
X-OriginatorOrg: intel.com

On Mon, Jul 20, 2026 at 02:18:58PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] veth_xdp_rcv_skb() fails to adjust skb->len when an XDP program modifies fragment lengths, causing state desynchronization.
> --
> 
> --- Patch [1]: [PATCH bpf v2] veth: convert frag_list skbs before running XDP ---
> commit c3ece024a1663f1b10d53a17f59581af7993ec1f
> Author: Matt Fleming <mfleming@cloudflare.com>
> 
> veth: convert frag_list skbs before running XDP
>     
> A frag_list skb can reach veth with data_len set but nr_frags zero.
> This patch routes non-linear skbs through skb_pp_cow_data() before exposing
> them to XDP, preventing a crash in AF_XDP copy mode.
> 
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index 1c51421491753..00e34afd858e7 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> 
> [ ... ]
> 
> > @@ -771,7 +771,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> >  	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
> >  			 skb_headlen(skb), true);
> >  
> > -	if (skb_is_nonlinear(skb)) {
> > +	if (skb_shinfo(skb)->nr_frags) {
> >  		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
> >  		xdp_buff_set_frags_flag(xdp);
> >  	} else {
> 
> [Severity: Critical]
> This is a pre-existing issue, but while reviewing the XDP fragment changes, I
> noticed a potential state desynchronization in veth_xdp_rcv_skb() when handling
> XDP tail adjustments.
> 
> When a fragmented packet is received and an attached XDP program calls
> bpf_xdp_adjust_tail() to shrink or grow the packet, veth_xdp_rcv_skb() updates
> skb->data_len:
> 
> drivers/net/veth.c:veth_xdp_rcv_skb() {
>     ...
> 	/* XDP frag metadata (e.g. nr_frags) are updated in eBPF helpers
> 	 * (e.g. bpf_xdp_adjust_tail), we need to update data_len here.
> 	 */
> 	if (xdp_buff_has_frags(xdp))
> 		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
> 	else
> 		skb->data_len = 0;
>     ...
> }
> 
> Does skb->len also need to be updated with the corresponding delta when
> skb->data_len is modified?
> 
> If skb->len isn't updated alongside skb->data_len, could skb_headlen()
> evaluate to a size larger than the actual linear buffer? If the tail is
> shrunk, this desynchronization might lead to out-of-bounds reads or writes
> past the allocated linear memory during subsequent network stack processing.

I think this is a valid find which also affects generic XDP side. Probably
another reason to have generic XDP code being reused here so fix would
happen in a single spot.

We only handle the linear part via __skb_put() when we detect
bpf_xdp_adjust_tail() usage. I assume skb->len = xdp_get_buff_len(xdp); is
missing.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260720140545.461747-1-matt@readmodwrite.com?part=1
> 
