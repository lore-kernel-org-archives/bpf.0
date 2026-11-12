Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794480545;
	b=D4aib7+P2zTwr1LqZFC+9e9cNpvB6P1/ilstEzBYVFfk/oSmiD6TpdYyqrv7Qv9AQ9mE
	 zZzkiNv9b3927NQOoJbkr/EImqFW+3xHEqHzsKj8jgz9NFioa+2wXUX195Yo2AvCaDDAQ
	 1zbfNxbrtoDVIFgjnvGpybZYkm0PyejpUSm5Vu8Et8plHXO6hPDvNIsY94/n7thgbj7m7
	 N2oyHSnJFxtWxchmBp8tkuqOtDiBN0W3HvCbCU1GuKLSjdvifuL2sFjm9Jn//1qiyuTW6
	 OWRgSHdgUHId1Qbv8gDujtck8NcSE4elSzuJgp6B8QYwD7wtO7HXl0PTtew8iej1GSA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794480545;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=s+8Bf1JdNsgC7Fofp9ENWj4TB60Ab8AFCKKRNM3h+FI=;
	b=q49iMVF5gkdHc+qxfXSRAQOuwGjEIyxpG+x4rxN2Vskri1hUavFV7Rz6ex2XPoXX4BSm
	 YFvjV/Vy4bYoYvd0OvOmrdNmLbVqvMNmFfDof9V+xGeDjkeXzZR45ep5irVsyiR4K+c3z
	 ALBACQZ4VwXTBznKQqyKpnrByrIb2Iw/64TqRmQeJY2K68jzKWJKrvsMwTwVpT8Fkwrz+
	 e/JUqNYO9BVvl7GnVrhG5tOpKQDnWh62z+mITOU33qx7cK9sHDSLfnlhvkXMkyZCTgHs+
	 /1ASUVplU714+zEXGb2kdhmZzbJo64q3FVlnRM8vHUtK4ItG33LFmQd+xJGyytqZrJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IJpV99Vp;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=SmAPnStx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679C606A331;
	Thu, 12 Nov 2026 10:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6679C606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IJpV99Vp;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=SmAPnStx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794480546; x=1826016546;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=053o4YYfbrSYpYmdBG84htmS0qKHNdXZnpuRxHChw1w=;
  b=IJpV99VpIwR8yTcm/uRhKLb6Jd+3h4TVzVg6rzqTHcgPQxcN/hvbyuzy
   BKR00SbHwC+tsigF89ARipfucHSpz9w0mwcChnOagMRAMr3BKAW4VyZ2R
   9iKAY9fS0u2GJ/X1wnXLBB1XWW8WxVBvKaET+VDXYKx4sUHAOxaqj7twx
   exrDUF9Ck4q61W3SSOEtBU6bqfs9ZDlmF8QAOubU9n3M5KG99aQzelvq5
   y287ZJ6EshkjNXLee67JB6aSike8/aKpGAoOI1FsbKCA9pTRA0PwYPMN3
   N01+eKFBejveUu8FDHLLWj85RhKD26I3kiO6sfIR+JCraJSinHmU3kFpW
   A==;
X-CSE-ConnectionGUID: YreYkr50Reeffi2Zs1r6AQ==
X-CSE-MsgGUID: CgDElku1TYWeAKno6VDG0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3146216"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3146216"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 02:49:05 -0800
X-CSE-ConnectionGUID: 7U39q39xSuqM2dQcNQRUqA==
X-CSE-MsgGUID: +cl2c3B1SkuTichbRtrqDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="8555560"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 02:49:04 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 02:49:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 12 Nov 2026 02:49:03 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 12 Nov 2026 02:49:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pehv7n39Vazw+eWsYesQoBU8TlQ5g51OAte2Mbs7c9q/BJ19fvbTcs4laek66u+VwlNuOU7gUpv0ZfzIEjyD1rcu6azEXtK6V21M2JSB0W6ttrRkG+1yGOynpvcsyrYUPXaUPPShz2+SXAJCqg7du9X4Gr3V+GNl0H57I4G4pVgpQf+CJtD1s66BjCeonB6p8UbvAtEcuY+thrC4cbYcApUGw9TDDad50ImR86K9qR2dwaiFgOV3YoJ1KSdTWBW3hhcmfHw2nK1j8XYocfT3zxrQEmfq8xuhfpoFrQ7dC7VC1OY5oFDw4Fhkmg4Ae1r4zxZPx2fEOYGUB7495H1SZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s+8Bf1JdNsgC7Fofp9ENWj4TB60Ab8AFCKKRNM3h+FI=;
 b=HOwdKPCDr5I2qY8AxoX/usNy2ihqqQWae17BCxBXxfMQEdmYxx3byAWGTiedhiZHzgi8BlfmWk9Zhg8FWmmFuXuKr1ONcZVn2UojDVjMJc2MiFNbGnXYDmTgdhJNLEgWzoe7FVhML/26mCur2hVnOCPYo1JoZBfN/C5oVCtfJ9szqowGTaFU9cNzF5RKo8kUcOuMuqb+ms+jueFKoXY3f/trYpZ3eTUbW5y9bAlN+VGSQ3qwopJEKYz1FC++A/1Zrk4SplpKZ6tYlXIuNpj+wR6S3mO+620zRP+nZqwdPhf/w6DOqGM8UgunCTPT9LYzhF7ZMIjQdWWyf/wPUGncPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s+8Bf1JdNsgC7Fofp9ENWj4TB60Ab8AFCKKRNM3h+FI=;
 b=SmAPnStxDh3gCHCAFudOhMTxMnZbptWbI7gjQnzMTr1TT884XI35ZWr8WEbpcyXIrRdiRQ2r4dsuQGpe8GJ1gW0JkuBwz3FpOlcTI/NjbtTyaDlb1+MdhpRzN+efIJK+gMCFYZxZXK1wHVzWQg02S7P2pKIMxfrSSXG12kr1jbk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by LVUPR11MB9835.namprd11.prod.outlook.com
 (2603:10b6:408:39d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 10:49:01 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 10:49:01 +0000
Date: Thu, 12 Nov 2026 11:48:48 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Marcin Knap <Marcin.Knap@vecima.com>
CC: Jakub Kicinski <kuba@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, "jtollet@cisco.com"
	<jtollet@cisco.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Jason Xing
	<kerneljasonxing@gmail.com>, Nitin Shetty J <nshettyj@marvell.com>, "Joshua
 Washington" <joshwash@google.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Sunil Goutham <sgoutham@marvell.com>, "Geetha
 sowjanya" <gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>, Bharat Bhushan
	<bbhushan2@marvell.com>
Subject: Re: [PATCH net v4] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Message-ID: <avWZkOvpKXVzpALX@boxer>
References: <20261109-xsk-zc-rx-double-free-v4-1-24e00ac221a0@vecima.com>
 <20261111173715.75bccc04@kernel.org>
 <DS4PPFFD8A841C21E59BFBD0D40DF2C5EA380702@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS4PPFFD8A841C21E59BFBD0D40DF2C5EA380702@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
X-ClientProxiedBy: VI6PEPF0000022A.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8e6) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|LVUPR11MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: d220307f-89ce-43cd-4dce-08df40aa8ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|261009223027099003|18002099003|261022105027099003|261028144727099003|261026121527099003|261026140227099003|56012099006|10067099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: iq9T7Pu7Xp9j96CT4lDnPEXSxd3+2iXtAeFOpnxE+OtBiKHijubTpg909EnIvBhUx5QHpIbedtFhLdNYauXfYjXWq1OKyE4qUYeblmwQFGwbtFLRaQuVXs673nnC9uaypJGZ84oaSI149lJ3STgC4DYL0tJvC1Z7PivCa6/K4a9B730Ckv70m5VdMG6L1IpEjaW3g7CYPKAD44GWOxLUnHd+EDsp/oRAGrn1Nfd/MdJ6StpEA4xLdKbSKDMQRDpk+56X7wieHfDpsiKHILid08zjwp86ZFTULwwi7aaAoMbI9aVSMf1mcG358sqQUvH3kiygJmcHMkF0VbUexlOE16LHfTUmeU5QXA499tKOrJq88nNj+zfH1QOvpEbUy5lu+vWimjIQGo7qUeOtVAL0p5SkJ7lzn3N2dlPaFaanDdVV8F2S4lBX6QYUw2XjNC71SO00ef3mlmqF2qEWjzzwKgD0Ihc81aOPc780p+4U4LD2MH9ncfOgja9W35z/7G4+vj48TjXZF+uVJuh7xYrnJ+X7uxm78/Py4bHpTwqVr+zpc6u6doHwCXOiqIOBjHWX5uimwRAI61i1BTJsUXaHTflCMh7no7qJBChbDoJUUZmXDw5ZGsFsXHB7rE21DzH++l3BQD8th93pYEJsL3nEjqGhjtjlorpCtFjTh29kC1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(261009223027099003)(18002099003)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(56012099006)(10067099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?be7V/tj5MqRP7HjK/U2H0ua4CV4rPwkkmlRVG8dsQNV0zsbDSKHeEP35Kpl0?=
 =?us-ascii?Q?oKkUymUePmJhrzhFQQuZcfeB/HVIpjRv/rAZ1Bv8iOR7X8jwnGQeuHlWSkLJ?=
 =?us-ascii?Q?stl4YMaZPYejt5wPtfh/3bjyyF134ti2DoZ5wjLhcD8NOs+SfERliFXkk0+S?=
 =?us-ascii?Q?caf0P+URX04xuz9f0WWBpME/0contOaJ5JZFmlTWmqVt9RjvxUSuULX7CmLQ?=
 =?us-ascii?Q?GOXdV2/EXR6b6TUvE+CeKTdos/XJz9Y1lpgfhOooq/mr09k1gHpu/oLWdpuh?=
 =?us-ascii?Q?H6xzWCOm+eBYji7+ZR0x3BCZeK7e7pYsnTkP/uAwjOn3Pw6opCGeNK4SI7Ql?=
 =?us-ascii?Q?XM1EZrFJe7WkwIEwsA4/XsvwQSh1VxmpZMoPPUQsN4LFpK0/HESmjvylOpeT?=
 =?us-ascii?Q?JPv1f8X6xMBv5vG74vSFDHELGPJZRG+XPKBonCuaf5YYTVishdu+gL9FFNbJ?=
 =?us-ascii?Q?1Xw6WARVJz+PCbsUuyiePnpUd7weNA1h3zG7UqpXvJvlVk4D+Wy0MYoTQv6B?=
 =?us-ascii?Q?t0WWvhyZkfy1ZNMZ89x4rDHODtKa+WzH2Lyz7iKqVR6kE74rTolngc0Ot64X?=
 =?us-ascii?Q?OVXok3YjtSt/ei0oHMRYoMkMIXMXeqMZHfTqpAwfzGDAceHMmHDK1vwmPLud?=
 =?us-ascii?Q?somuhKnyIMe+milwkNHTiZuMmRyc/jNALXCXpHXLDRdgA2YYJsDX9I+v9p2S?=
 =?us-ascii?Q?qNWNYXdZUENmaCII4m5kIiWHxaEGsj+QojEQ3b/qHLo6gvY2/1ucQfJULydF?=
 =?us-ascii?Q?HbSIS7T9RSImVMtAUuCTVDzxTLrtfZOKQL7SxgSfdHMkFMPi59tnV+hKm7EN?=
 =?us-ascii?Q?N8uaGbP9Yub6Udxd6KDfzSs7NXYoJ1a/yh7TNBgjU15T67SNbINOzW5MMLrO?=
 =?us-ascii?Q?YWyY1555vtUB/w3R8fpZp4zX2jLb9hotJOiohJ6jIRExVD43NoyydYdn5UB2?=
 =?us-ascii?Q?XQdxAl6tyZh84MYj1Y+AnMDwlhDWTBep9/UZbfyPqUlWPfdK73+8V7/zIPDm?=
 =?us-ascii?Q?VxmD6P/Wdd1zwIiWFYXMlnusXrLVbrZM3lJH1Rpe9lOuy583bhvpsI1TT+4C?=
 =?us-ascii?Q?ujLDNfNj6QGFk6256S9lQFphc2kZKTYTHLs2b+fJxXjevCWJAj2F3qZCbTfl?=
 =?us-ascii?Q?ih6/wTU2eyKzhi6D7xobDAEyaiag0KlW5IGcpbhG4lF81fLNI/pY9pUIN3Zd?=
 =?us-ascii?Q?oWGQpoSQCm5g7okGcWCQlRBs60x7RnSbLUzDdixFJLuwrrJWeb2QGETOb1R1?=
 =?us-ascii?Q?nIKRW6zGWtE408fcaqE1OaT6tTBASrHW7LU6XnFspyMcGtbLcwGrMEpNCQV5?=
 =?us-ascii?Q?UzjKEfMd2cW8fGM04whZBn+sXX7uWrmye5jS3zSAGIHp44PPmD3NMhPol6qE?=
 =?us-ascii?Q?1L149y7YCXa72NB3JlZoFBYM6EPbk2uJ4HMmY2STBpKvlTMVkuS1lqepCqQp?=
 =?us-ascii?Q?/LLF2VP68DIFQbpu6BvuM3hXFbm2YpBJ8Iszx/InpAiFP1W1HDlFIoZLxWPN?=
 =?us-ascii?Q?+BW3iWwrkr4VRWgo53zQIzXcBFYZEtQVutGDnQrd7YOXjPpAetangwUj4LfR?=
 =?us-ascii?Q?L4q8ep4fSIsArW5gTgU3u0tIP2Gn4/crb6Cl61s7rIOhG2YXBRPGnmrI1c49?=
 =?us-ascii?Q?+QDIySdA2NwJ4nKhfnIUOan+Bm9IprLY0SU5dgff1evqG7DgiXRIzoZyFxfg?=
 =?us-ascii?Q?4TDhGxhCcVa1Tidpy0LDrpr/6pEtqoj+gtAoauSKDchQInSJB3Gxq50O2+si?=
 =?us-ascii?Q?fBiXwKIIlsI71LFOpdnf0+vGdAa0kbw=3D?=
X-Exchange-RoutingPolicyChecked: 3K2lDuKRJqKtKT0YRfVaJfwjoUbb61r/25e3xntHz9GUBF4ak6W+Yb8CtP+mjQi8ITzalkrW7+saW0REp8WdEovc7nBbudehzFi/Tgz65HEjfFsY2ERN33hxkZ8xodDyzHpBTi5q8qIp/TdRKkYffLvVgSZctPPeRIusfBcc/msCTeyq5DAmLvslztT5eZzwGbJBjIRvjO/LajrhBxc1NH4xcTEngb8g26EXUDjHLCpcEH4KJjk/uyov741Y4J75/ib9pihuT1NNMMjeetXdxgQqjjx3MntYRTrm/gAztpm8Js1QXCSekGf27OilNiLtXgemDSPBKWAZzCDBuTLs2Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: d220307f-89ce-43cd-4dce-08df40aa8ff5
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 10:49:01.4534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LuQw/HKPG8s3j+sEcSpjyup6HUTLCyF1gBFtN7cgkbXuctGbC+PzT5QXQlEMhNWx2GgZ3eLUT1zgNZdPvdXxeIKuzA8tw64KDu8yhOlNa6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9835
X-OriginatorOrg: intel.com

On Thu, Nov 12, 2026 at 07:58:51AM +0000, Marcin Knap wrote:
> >But what's the plan for fixing those redirect targets?
> >I think it'd be much better if we had one series which
> >addresses all the cases, which AI can review...
> >If there's consensus that xdp_convert_zc_to_xdp_frame()
> >can be trivially handled later let's document that (and
> >how) in the commit message?
> 
> Thanks for the review. I looked at the devmap/cpumap/ifindex path. The
> fix I have in mind is local to xdp_do_redirect(): for zero-copy buffers,
> copy into the new frame without freeing the ZC buffer, free the ZC
> buffer only once __xdp_do_redirect_frame() has succeeded, and free the
> copied frame on failure. That gives the same rule as the XSKMAP path
> after this patch (on error the caller still owns the buffer) and also
> fixes the leak of the copied page. xdp_convert_zc_to_xdp_frame() would
> stay as it is, since its XDP_TX users (e.g. mlx5) rely on it freeing
> the buffer.

Hmm. So it seems like currently, when we managed to properly copy from zc
the 'normal' page and redirect failed, we would interpret this as (based
on ice implementation, not sure about other zc drivers) ICE_XDP_CONSUMED
which would do another xsk_buff_free() which would be a no-op on this
xdp_buff at this point but 'normal' page would indeed leak?

> 
> I'm away from Monday for about a month and won't be able to drive that
> change and its review properly before then, so I'd rather keep this
> series to the XSKMAP fix and document the plan in the commit message,
> as you suggested. v5 will have that. I'm happy to pick up the redirect
> fix when I'm back, unless someone wants to take it earlier.
> 
> Regards,
> Marcin Knap
