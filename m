Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CE83B0580;
	Fri,  9 Oct 2026 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791551750; cv=fail; b=Bim60YwRe2k49evktydbv+mTu0xddZFeNC1kB5IqGfYmZfOqs6Zqb+l4GNOXsCe82ciwX6Iv0vjB3Q8iZbbkK5ThmavPO0866vBVI1IjMq6uTiE7s0g9+xVXA8MmQ5+FwvJv89svf2k4d4xhc/+SN8qxKmmy1z8M+5L5izq+kKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791551750; c=relaxed/simple;
	bh=BwRVOrLDnQ9uWEZVHUKapZ2KSCg74kKYVS4Y5Im4pls=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P8crIkabBHQEX9lo8jxcJG8imDZDDXvYNjpa8an7mM7hjb/PyexhVxwbNsuGOKA1Qx4gxLwKVGu59Jqtc8RHRtlWoV/31AuCtMt70KJX5yCfGXCnxg7nNC13vg+enoyDPWjkbHo2jGgh8ehD5tADU+zsYUoBKvNWRHaWIHLJOyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8X8cnM0; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8X8cnM0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791551748; x=1823087748;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=BwRVOrLDnQ9uWEZVHUKapZ2KSCg74kKYVS4Y5Im4pls=;
  b=R8X8cnM0hEeTTV9Uk/BOkQGb2NQl+m71L5RHqI3vbLOTlfHjeVWZBUja
   /hFZLgBJl3zAd1NpWx8qExIwrv7mVl+tSFx2zhdKwcHZEKIAq+9Wo4imb
   a7rTcQerZGFapXIdKdystQTbWarWi/MJc2Co/7JKmtg1ER2X4i3OdbgpY
   PVivHkLWsMPBgtB7CYPFYrPIs0qkVQJKA1LRN87zSHn3JyIHGNuOUa6zH
   QFacq9uqfMYTpJA0i2zuAMzsXfy2+ww2CAD+rR7WNS8zqO5LRERxfhxxZ
   jm6m26SiaQBu0o0SHPupYCU8CwD/ftxmxZumH7mMnTXJynMfYPo8SRe2W
   Q==;
X-CSE-ConnectionGUID: jwCfGsxSSXOvAtY1j4d8rw==
X-CSE-MsgGUID: 6RRoXyksTWKnFDhXdSGaRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="255778"
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="255778"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 06:15:47 -0700
X-CSE-ConnectionGUID: FHsE47Y8S0+bkIBCcPD55w==
X-CSE-MsgGUID: JIhIYr49RBCeVlJGvYAWqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,148,1787036400"; 
   d="scan'208";a="268305"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 06:15:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 06:15:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 9 Oct 2026 06:15:46 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.45) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 9 Oct 2026 06:15:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eIsLDLSmrLl3WqH145m241Tp3In15yT83qXR8yGbq07kDRop4BydxMzMn8JX7sXxU3aNEkyv3KO+RXBwF4NkmbfwwSLVTT5+b/Po7su8DF02/2BNrdpHXe0smOndghFP2ov7UhwSTEgOwn9d6Tb0pXUJx0rg4ItMrTPhHOXcXeLQI+Eh7zvYVX9pm7tnCyjN2RNnQXkTAFK3jc9HzAWzxCC7en3SfDa5CbhcBEv67eKYdsDbp+2FkmNGw3lriMWYsHZJ6dywhQxRTSgV/AJuvOBDYhMv5BAdqUwbRbPjaEnRhbgNqnkgJqGPgXdC9LEtR5S6pE6jN3DaGnAE2eloqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yqMcW/sFprxv5XY6SNi0QWMW02xKedAbEJLmaMdmcm0=;
 b=CqdFGjtaL1hW2tXVtlDXRZswLMmRBkCzAQtpADSp1Y4VS9cboMrBTkhSXqrnWygS3xVYlK1yeNsDnsxvcDIRMgklHhCJp4SVwaJ4p7b3Co1Tu+FYpP6tTCqOIZG/AXKl56GmtmSrbssNVc5BW0XANzelinNSrC9VscsUYtzIsI/1BktuMyiKJes7zxsnnQhFAQOFOpEsupmcBLIr/rnNoSGfkpaqwLbSFbp2IDZIGwXEHWf+trEmxlQPqK4RFDEMQW3OTR6mxXpuXyQCuPNebfZ51ZTf10CXg1aqB6jLIz5ZopTdjuGO4PQ3+zPJgFuuY2foFv8ZZLzTTR5qfzppLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV2PR11MB480600.namprd11.prod.outlook.com (2603:10b6:408:40f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 13:15:38 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 13:15:38 +0000
Date: Fri, 9 Oct 2026 15:15:32 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<bpf@vger.kernel.org>, <magnus.karlsson@intel.com>, <stfomichev@gmail.com>,
	<pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
	<kerneljasonxing@gmail.com>
Subject: Re: [PATCH v2 net-next 00/14] selftests: net: migrate AF_XDP test
 suite over to net
Message-ID: <asjo9DTBq9fH7P6+@boxer>
References: <20261008114909.734364-1-maciej.fijalkowski@intel.com>
 <20261008143013.55b0f462@kernel.org>
 <87cxtjqdza.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87cxtjqdza.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: WA2P291CA0048.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV2PR11MB480600:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fdbef6-5e66-4473-cc56-08df26076973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: B71s48NEb+8CrgQXr1ykFIkHyK8JMu1c1vacJVspBsFWs3G/ReRqqdj/jQ3KBPMNcouQEX0fqVMsDFhsBWnNLoucvgRki+/eULHlhg3MPn/nbclGmq60w21FpVxhxcigp2quZEJhUvyx/hsM4Z/WTyoHjeD7l0ju9HhHqIFYHfRyUAzc8vu2BCZZWpgykUELxTgkCNcnDTuu7xpsmEsfnsBrah4XEzA90PDjYWt9rSDexdqN9OFw8NmnH+MG9J+5yVeK7FWNLoZWqk52POcbN9Gzlia90enDXgIku+idhfymTVp6hvlk84cVCZl74j6/Nlp2q9+J/VD2pNlooB/zapdGiByRtsZ2/QL16VghOVfDije/EFzzgcs7jxhE3LwhJqG/hLMBlmqTQ3dqNnl5iXFBNqVSuZg24er1zAp3lTeR8obrIJPAZM/D1XLCoCFxjf4KbbWcV760hou09hDXtkrK25Ii5ZVs+rLROksVKhwB/IB4KTkudgdMW/2svOz7tP3RuomEPB6IqXmIXx8Yi9bnbgjGLWVQ4o7CvWJkb7FbNnOGKE0VjZk1hMThyKMIotbhzYf/EkxAjoIUDRtkGPFOgGw/7jDWBHTLwhKl2u+u8RADSFmOxPzF4Q5TtraN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?ss/Ggq+4yHYbuzJK+LEcNI+pyJKhI8+jxtefCdGgpBXRmkjs0/kHdk4uv0?=
 =?iso-8859-1?Q?YAGMLoRiQtEcUWQGAaB6VQLnYdxfOJFYNh3A6Fy9GRGkZuiVXOBluDIxuK?=
 =?iso-8859-1?Q?FmrbjzQpbO/htvoDDr64FTc6Y+W31AyP9VeBuPIGVwR0CFezNtVxwGsgA2?=
 =?iso-8859-1?Q?oyRVolUF8zupnB0ShVa3HwUF+GJ3UVWZknKXYxLpRgTNxQU72Z9tu8XEQv?=
 =?iso-8859-1?Q?SAj0wYNABeaIZQYUW2mViOOA2OP8Q/xP85MkWDp1GV1ePP7n8q9rEgTG5m?=
 =?iso-8859-1?Q?6d3Cs4hg0FWNrUDmyWDSAz8QJZMVU42nRJ1E538FHPbAwEvkBVA4pw++k7?=
 =?iso-8859-1?Q?7g4n1qLmD+/Bj1Y/Dwsdcz0ELBI8jxJELf/ISEPtoACyngCMKmnMBLUCDk?=
 =?iso-8859-1?Q?qfTCLmAT4/AKQE9+UmyGC/yNW4KjwbQaMCUcwl3QyCy1XgNgXqlT7RD+E1?=
 =?iso-8859-1?Q?2agmfiBZ9q6Xx76F8ssxyQ50g6vOyBNsHY82GojAAAxiDEjRIcgYuDavRz?=
 =?iso-8859-1?Q?+e2+42UkRWnZftVgYKQabo0P9Kj87eR7Hwmgu9cF10K1vTaULmxkgMQVMF?=
 =?iso-8859-1?Q?pPdgVVmgLwoMsUjwwXsYZANUrDLI7V/9i7psuVFJxyMjlK6l/WAXtRChu6?=
 =?iso-8859-1?Q?0Jepzsprt8e/DdfnzrE9V5OoxRS5VL67dYbHs14lVfz7dBnr9WxvzhEOui?=
 =?iso-8859-1?Q?zey0oLR0VFEno9RThGIFCM9qeEOSpc9ouIbw1dOTG47QH34A3SIwa/HKId?=
 =?iso-8859-1?Q?OyyI2CdjBNahBgFnqszWNydTr2anW6npmD4BbhQg/Fo8ax4T3HbIq1/myT?=
 =?iso-8859-1?Q?gGuWWuM1hf0RIFt2Fe4eO/s9d343vCcy2dn8w3x0ZhTEYAx7DSvSMtfoad?=
 =?iso-8859-1?Q?I5dizr2uDa8CyEMfAm3Xgt3mSCMI6GdF7yOUNz3Gw8kmNV1K18h+PbbdYG?=
 =?iso-8859-1?Q?aw+p2r6FaPNATrSmNxMDfQXVONat1zH48qzDHY6pGPJlye9/tbDn7oYSyE?=
 =?iso-8859-1?Q?fNeCFIKi4ZPr2gbV7UTx8EztNUjGL5dP+K7tbJUCOvp9eE4gKxs67Yipf+?=
 =?iso-8859-1?Q?B51LUvM4xHBO7svE2R0mrwdLuXMhGFrZOlahbMYR20ACYJYY/0pnf1Qqf/?=
 =?iso-8859-1?Q?xWxgijlSG/cfigx8tKVYhm5ZpCw5Yhs9NEgQlW3X/g+bilTtmnF97Me6Cc?=
 =?iso-8859-1?Q?ettNer4e6FfOqi/vIk4pmkF5wSEtDTqdNjhka5i879yaKE+sbd6bJ6/Xkf?=
 =?iso-8859-1?Q?IUGlH3FD1oN1rMo41e55ntXWN4OlU6Qzc/T5l7SzTDgky+QeL6xm3rnJc4?=
 =?iso-8859-1?Q?gRavUV8l4bNPTn0t6TsZ15lReQqu6Wk2tpL5lCmq3k4KxaNM9hoTj15kKW?=
 =?iso-8859-1?Q?lAKsANxs84N2b3Y15VJ2xHGwG8Vs9nLfa7pYPd5KWG4pYqrthAJE3pLqm3?=
 =?iso-8859-1?Q?MtplYNE3uyxmGJS/VuwZBi3/RQpvZLU9hz2nUML91D2sWfdfb8O91Nr9lM?=
 =?iso-8859-1?Q?v45fGSnBpwQoNVsEm9F6uVOdxH+9eYM4iN/11pPSQIf3IbIpwNOJie4s0d?=
 =?iso-8859-1?Q?9azADl2+croI7u8oTStbRdy2zLPWkJm1xdyxGjBVCUCDI4YIritQf+Wtcj?=
 =?iso-8859-1?Q?xHlKYicUktYbSES/paP1cjg0wdHtH//6O5QESQN2gA3DkVV+42Xu+nn84B?=
 =?iso-8859-1?Q?2PX0VOHwFJQ9vKE1ZOf9PZK6XTNOK4dB6lvOL147eXCfI9IdDJAPn/3IQ7?=
 =?iso-8859-1?Q?IIdbvZp2cHd1f18jOPMBpUphmqFt3JJDoByLLUjSSex6btrf9w93A1CNQ7?=
 =?iso-8859-1?Q?bbvMjQUR+6tKGyKT91bTrmPX4y/GFNE=3D?=
X-Exchange-RoutingPolicyChecked: O8tEAtWRDVFQCmtxmyPv6vFYb4jvct5SY7ilnaExqI75oHWDPDXeTSbMBbcUqRIJJKqJwDli8jjUI36wG13yOZiTXr4y9qBHfHL2s12z532ij9xrXrpxJUo40s2kBx0A/12NyNmzIgKDHs/sXRyZZCWDfkchekUxSP0lcBJKQOHIcLqvPHjzZ5fHdg3Y8quD3w6Av45trjVXJK7Qb4PzsvW1mnSOFrh98ADCzw+pw5FkfCgRIy3xbwhiCKAkXRXwJYMwjGzd24/sBfLzbJzgyOGiMt7PH3ofrRO21p5j7r1B18IpFRwWSibFDCoBW8u7jlZ0i20CbIs41rhHjeAYVA==
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fdbef6-5e66-4473-cc56-08df26076973
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 13:15:38.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sOyVbseLcDyLMB0R1GBpogKNwBi2GGuAhDpK7kFLjX6elqEa6lTbtyrQpwaUxsL6nxjsKReWUmXhWbX1BYPrOVMTeRj7DoWYvjYbX6TyvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB480600
X-OriginatorOrg: intel.com

On Fri, Oct 09, 2026 at 02:02:01PM +0200, Björn Töpel wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> 
> > On Thu,  8 Oct 2026 13:48:55 +0200 Maciej Fijalkowski wrote:
> >> Heads-up for ice: to reserve a queue, xsk.py updates only the RSS
> >> indirection table over ethtool netlink. On ice this also turns on
> >> symmetric Toeplitz hashing, and restoring the table afterwards fails.
> >> The fix, "ice: keep the RSS hash function on indirection-only updates",
> >> goes to iwl-net separately [0]. Without it, the first case that takes a
> >> queue out of RSS fails in its cleanup, and the table stays modified.
> >
> > Good news it that it applied, bad news is that the non-HW test_xsk.sh
> > crashes the host:
> >
> > https://netdev-ctrl.bots.linux.dev/logs/vmksft/net-dbg/results/857863/166-test-xsk-sh/stderr
> 
> That's also good! A bug has been surfaced by the test! XD
> 
> AFAIU this is a know veth issue [1] (right, Maciej?).
> 
> Disable until a fix a landed?

Yes that's the ever-lasting veth issue where mem_type is changed during
skb's CoW and system page_pool comes to play.

Gonna disable tests that adjust tail on veth side until we resolve the
veth side :<

> 
> 
> Björn
> 
> 
> [1] https://lore.kernel.org/netdev/20260509084858.773921-1-maciej.fijalkowski@intel.com/
