Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB60C3E4100;
	Sat, 26 Sep 2026 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790425277; cv=fail; b=O3QvNBrjCRGUv10p4lmlm6GZ2hhqDEhwwkm9e45DVtJGoSENrl5yTYwlRjZg4McR/oMxxXOdmZnAiZB6h8dWsBAvTW8bqiO53S6bF0HU7NIHIm0kcgqSfPGBfZRFF60u0/r/AGTknQcRR/1jAgZztSECD9sx8zNdIdvK/F19Gkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790425277; c=relaxed/simple;
	bh=7EsMnkwCcmXqKPu7Mqvqpu8VsRMRTiAo1jjVkJGuZhY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tVlMZbUIhJZW1MetEWc6sRvcag7gISSsRbxoKZx58j/ntnBzexAkur+g1JIwGviLlV8x88HrrmfAuzUIHnpxtXxqU4LAQwuLDnEDcfL60gVzaNnecmV/TzmKy5LURnLZ1B7hAiiW7mZNx055xdEI7s7BkM416UaO1cWnoJIwHhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KljaKVzq; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KljaKVzq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790425274; x=1821961274;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7EsMnkwCcmXqKPu7Mqvqpu8VsRMRTiAo1jjVkJGuZhY=;
  b=KljaKVzqx1LFQQMhXLOyJpNg0STSy2oVS0v20Yfx+6JjDDI75u/5fvz2
   Zo+v8hGpHWe9Rg2KCz3u+EsWWk2pcxhRjjg3QiXDXvCvcvMhcezd3lK8N
   5hMc1zbBF9Ikj6YYGM2PyDb05WrTe7xgmvPJ6AzJlwc9TvCwt4PJY21c5
   5skB2PZd7wxGYTUAxRDSjJtpkngXVEWQ70rJu6O2odK+nIUZ0KEGBy64w
   W/DYuHCq9FbF1FudhAOdd4EfSzj9g470T8MBNm+1XNxFKiRaVbFBEKCn4
   MlwryU6PzS4U/BbdFT6f/2dpDeXIcqgqgJtl5R4M0v3IJdu6tWb+wuG3t
   g==;
X-CSE-ConnectionGUID: l3n+cZH6TOuD9U6f204+Hw==
X-CSE-MsgGUID: 5x7wW0zjSe+V6PzO42m5Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="91293660"
X-IronPort-AV: E=Sophos;i="6.27,124,1787036400"; 
   d="scan'208";a="91293660"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2026 05:21:13 -0700
X-CSE-ConnectionGUID: kOlbQ+udSKiFBiMv6eQiaA==
X-CSE-MsgGUID: dACIkr6bRAqd51IrEkliDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,124,1787036400"; 
   d="scan'208";a="272351516"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2026 05:21:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 26 Sep 2026 05:21:11 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sat, 26 Sep 2026 05:21:11 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.11) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 26 Sep 2026 05:21:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myFWp+04Bl76l9XcjUIWpwleNTh1ScliAoh8LCxu/VLMx7/MCN58syPGqquwWDOCLHv+LTaEWm7ixAOTaxmU0LYE+f8bjXxkVKE1itGq8qbprGM5gHOA3xhGj1gMkJygFKqz1rk6092wnu3WqbNHudhDEgSAJgjUYU8YYk9ICAfx7jFWW/cLIp3OqxgNVz0mwAmcJfEZBdvrRY1vja71Zg49AqBraHLAmUIYqFV76SJ7j95YjqhpDBtdm14D5vQi0uSTir9mALmws45XQa/TaKsc4ughr+YxErlJZ8cK/mA3jwPvb4K95/3fJQNN2j8TZmqDwTnBmONenF/hxxXnFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLRvXv7/A3znQl2GIsKOSLKyWdzKcbEJ5r1x6xbTwsA=;
 b=xzdJL8g9Nve3KVFV1jpAeEEnaq2yfxD42c+clf3j4OZ2MjdfT4hD1kK8fDz10vOHZdOzFrFZLqa8z5IOe1jmgKJojhUA1JY7lj/z8fytJZpfCN+vYW4XMB0JflUNHc7V5GxwHw8usionvzxcz5ut4RFEx67OtJYR+80GERHetmGCtkn1IZ2l/h8RPC5WDlnDNW/VISMwfarwY7+a4Gva5kLpkGnjwEFakx7Zk0oqkbbJgKwHHNKOz6LQOAqacG2J6obzPMLQ5pLaj+LfocDwcJczwaB86TxSHI63FbqobrIv5KIqJA/ycxl8pRbkmt8VLr2YGObE2pPGhuWZS2BzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SAVPR11MB9575.namprd11.prod.outlook.com (2603:10b6:806:4e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Sat, 26 Sep
 2026 12:21:08 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0451.014; Sat, 26 Sep 2026
 12:21:08 +0000
Date: Sat, 26 Sep 2026 14:21:00 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <zhaochenguang@kylinos.cn>,
	<magnus.karlsson@intel.com>, <jacob.e.keller@intel.com>,
	<przemyslaw.kitszel@intel.com>, <jbrandeb@kernel.org>, <horms@kernel.org>,
	<kerneljasonxing@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
	<bpf@vger.kernel.org>
Subject: Re: [PATCH net 0/8][pull request] Intel Wired LAN Driver Updates
 2026-09-18 (i40e)
Message-ID: <are4rBUJO3mzrkO8@boxer>
References: <20260918212458.550425-1-anthony.l.nguyen@intel.com>
 <b67609c0-d640-47bc-b25d-d40bb59f237c@redhat.com>
 <b5e4e86b-356b-4ec8-b6c9-e5ef6a3b2d50@redhat.com>
 <arZtNCWXQMA5Pm+/@boxer>
 <20260925130042.7e20db0c@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260925130042.7e20db0c@kernel.org>
X-ClientProxiedBy: DU2PR04CA0179.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::34) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SAVPR11MB9575:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f483e96-c627-474a-7d48-08df1bc8a49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|56012099006|3023799007|6133799003|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: wOYMvvpcGo2QVeCKOaKCE6So/4DzIM64JRWDrr8XG/YCGTehAzNJ8QIoV/ysLER7tAPSuyrL/YRH1QZ3N4NGiq1dTmMUKPGMy1bT4lsGChoqIgOhdtz/f4mwvnZ0cCtP9kdareFucsXcunWyhpz9BlJVl80Pebe7PE0ZKf4UrmB2Vu0bG7PAwMWtCTcXmQJfGwRqBXBYdlphwfBg95v5Fgw7kWo7cE2alPnF1MO4MxsW+6lmYcvPt0nhI6vv/2P6zaVAorVbecUbgLOihC4pO+VoQ6wfUNQpuU0W3KCqw3Z2g2CKHsXzqYcFFMQ4hAbDGeTPvZwwAKJ5jTH5R11MYWSUqu/TTJK1Lz52oqtIM0wgx5+z+8U2tBuCv5dua9dKdHbOyu85vJNNQ03nXH14hxrLJqriyNDu3KlrInrEV1MXxyDo1EPj7fBY5SL2fJgjh4A0ntMlOLb68RfwVaArzh1EcJ7PX3Y9GY+nwHQUBIs1Iby/XO5Oy4J1n7XK+fVQsqx+wNdBlULWx3yOBO0HpbiBHH/naEscSfSJ0Lg5mmHTcZyG6Fjci75tQO3YcDUf35usJ9Ka5U5Tp0I2aKb38kE0zVbfF/9u5Dal1CL5ytuTYFhshAijPLF3wozLnEoMUJSwP4EW8RCFj5LXLvBpUVcNBN911rFwpjJ3/RRChAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(56012099006)(3023799007)(6133799003)(11063799006)(22082099003)(18002099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YuZl0b1KgHDAaueiYe41VigS9/8U/0YUdFwb+AASfPWz8Bs4SUd6h4Z3tPH2?=
 =?us-ascii?Q?gLh3Q0RdpoqsdvT2lQW9LWOEzuQCv6a5sjP43Dru7ystBidyAQ8tGsjS/fSN?=
 =?us-ascii?Q?3W2q0NWSvjYCCXIaslUlrDGZ7XhPAx4zdHrEqkR7RZcrDYeB+iHlc87yS9tG?=
 =?us-ascii?Q?FRk10kikbsWWXeXb/nf1NULCYbENwUkhhn1ayTrE1yJ4saONHfQWHbzPocfe?=
 =?us-ascii?Q?2xMQoHISj4JH0pEpoPCwqcZ3nkQajoOMUTokIvpMg2dvUTT2/Knrs6TgxOIB?=
 =?us-ascii?Q?9KdlsDKRvbSe+2zbXq9ZuPoTt7VW+tJdyKirzDxI6ATbZcR4m8cr+tnJv2MV?=
 =?us-ascii?Q?uyfsM2Gcx1emWZAU64wwsnuCWWJFHMIWegy4Adq4GKWb0t9YX5FtzEubz8sD?=
 =?us-ascii?Q?+ihwXTX8wW3Lrz+TP1mXtAjzrfJIhX2j9sWU3v14K8q7n3/SxqOih/SbOYtq?=
 =?us-ascii?Q?wsE9bTvIA5LfEsiSX0dG5JzqEudSNIi4RZODzzxAaEC/xNHkvmGGUcWPe9XY?=
 =?us-ascii?Q?FW8FDoZg9EGignKocyWvgHIXqJxYAb23xxZT0xXlQF8biXefEYaow+MIHpj4?=
 =?us-ascii?Q?t+3+eASeEevx5xL9S9xfDypZ7HwjUv7wkj9CiYVChg31GTJNrUWnIyHcX9hZ?=
 =?us-ascii?Q?PWaYzLPdGFw3NBjDT5zhcRDNA+zesCOwuyGyEdFPSJZxOl4NmFLyWAYUVSYc?=
 =?us-ascii?Q?znozuUh/Fx0RGSaq2zVuSiggUDZXvk4InRc+9CcNl4U/YlLe32F5fA3jUj6f?=
 =?us-ascii?Q?8zMAmdRd5SsN0JB10XAOn+r3W+lPlNPmKJ75NDQsM8Y+59Qw5CNf4rQ0Gad/?=
 =?us-ascii?Q?5UM33MWYAZUdBkwL0Mdf0ar8G9bVvwxqHZosIU9NSANul2uKoDo63qQyv8Dg?=
 =?us-ascii?Q?pfmn7CKSfXpGODS5qEEDeurTFDBPdGvTUyAVh3JlyXEjoHcqCliKBKf7LKBu?=
 =?us-ascii?Q?XHgoHlbzUXqxPqGBtEd4CnY96dehUJdccYoeXsIV3qy7NAFwrZLYKBG9o3sZ?=
 =?us-ascii?Q?b/rJ0X1S/7SEE9LZPflIOTjCLcR39m1gcacnc2+ngViYEEzQDKJup/KQVuyv?=
 =?us-ascii?Q?Q97MwMSjdmp/i9HE0Wxaib1CYwy82OpxEfQL7R8LMavfNeI7ZvvXr11o9Q46?=
 =?us-ascii?Q?17G4VPALL+4WSTX0qOnOzLXH1oteyVBhCPSv7o1s7wUjrAWwDz5teRdjokmf?=
 =?us-ascii?Q?mbOeXBo+t++0aSULOWTYfcgxMvNvK4KC7zlRR0sH+s/ceb1sTs4Vs8e55yGP?=
 =?us-ascii?Q?VaGqZSMAqwnsnvh/VXW9fVVZxDr+RpOVVhJqsjQ7izOT0T83ObQ8WtTCvbJL?=
 =?us-ascii?Q?8gI1bZd+SstWgauIWLgpvZXL7FIGEMbYlO/87PGlUPPm7j56CyLq9fGpRYRT?=
 =?us-ascii?Q?HiKSjh+FsPaoMHb4SqKep9b7nRByLbh7qcSeLtk4MKYhLE5/P8YGpdOSDEzJ?=
 =?us-ascii?Q?8Wjp/4wzGkNCRqIgGTn7sgjvoZcCKMfCnXMTDhDa0u9JaqDHHJotAFh7qE4q?=
 =?us-ascii?Q?G5StOcOSMKqwiuErwrFZVeuTtb4gVUd+Y96mhF4meV361XU/jWRSmP6y1+dW?=
 =?us-ascii?Q?VsCWeTUQnkK383HtE7TFvEUaPJTcpUzIwZUKqoSDhX/kbN62zbpnhEXso47p?=
 =?us-ascii?Q?xWwSzPHnoGSstT4emoC9zJE1cDXXuX6OAJJHgg3LTn8E3R6BHVymfKxARBwQ?=
 =?us-ascii?Q?CV7Tea3Aqxz3VqhX3t3x6gdFChq3yCaJAQr0wWXWD1uHho095jMssU0ei2UF?=
 =?us-ascii?Q?OY+gwNhg8YhH6/fXzPR55FYTnozIaKs=3D?=
X-Exchange-RoutingPolicyChecked: x6TisklNNRGuo1LilH0A6cu7058nu4b/WZKI4EllcXXtMt2oQyFn1bgEv/682OStCYYKRNuhNiwy+p6zmQ6PITtn70Lq05Sm3TimOUNNgeG+nqkseTCwPDavUg1ygCMtas7fRfIkQRWhiSQR4yrNrFkRKdpPvUnqgZPoJ03NtievWwQcuL0Bhm3Bi9E8ArRTdkPcD8Rzgj0DT+1kWSJKfMtPMzwNkJ/YKktrgBIAAfniny5eBoyAxr7UZ0V3Ti39YK5dWdqWR1KE/uU545aDlYkYde8CslZDxk+YH9UyDFmYd4LFp5AAVc/Dy38m2JXjC25m9JfKxGNAyf+82M7p8Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f483e96-c627-474a-7d48-08df1bc8a49e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2026 12:21:08.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZOXbAF99Jmq/WR/C3ydG8uz3018CYHef1PK01ls3N+ujCIYwAVy573AxKf0gkvkjR7eI+jJoNwANRMMwWKrf/DSgLf4S6FTvi3ycHXwQ/8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9575
X-OriginatorOrg: intel.com

On Fri, Sep 25, 2026 at 01:00:42PM -0700, Jakub Kicinski wrote:
> On Fri, 25 Sep 2026 14:46:44 +0200 Maciej Fijalkowski wrote:
> > On Thu, Sep 24, 2026 at 01:25:14PM +0200, Paolo Abeni wrote:
> > > On 9/24/26 13:23, Paolo Abeni wrote:  
> > > > It looks like clashiko has found a few serious regressions, worth a respin.  
> > > I almost forgot: please note that the current expectation is for you to
> > > address the clashiko comments on the ML.  
> > 
> > Okay, there is a bunch of stuff that are reported at early stage of change
> > set which are later addressed - I thought bots are taking this into
> > consideration and therefore would skip it ?
> 
> We changed that because people order their code poorly, break stuff 
> and then fix it back later in the series. But, indeed, it should not
> report pre-existing regressions if they are fixed later.
> 
> > Has the gemini LLM fell behind the others given that it reported no issues
> > whereas gpt/claude produced way too much of output ;)
> 
> We probably have a better models but we fell behind Sashiko in terms
> of the pipeline itself. There was a major redesign upstream, needs some
> time to rebase across it.
> 
> > From trying to fix one thing I'm about to be in a place where I have
> > refactored most of the rebuild path, which have been used without much of
> > a problem for (at least few) years.
> > 
> > It is what it is, but I have a mixed feelings for where we're at, not
> > mentioning where we're heading.
> 
> Well, maybe let's go the other way? Given Linus's recent complaint
> can you trim this series down to just patches which address real
> issues you are able to trigger? The bigger rework can target net-next
> as needed.

That would be a start from beginning. First 3 revisions were a single
patch that fixes real issue which actually you reported via
napi_threaded.py hang. In order to fix it correctly q_vector management
was changed and it touched rebuild path. Gemini-based Sashiko reported
issues and next two revisions became a patchset.

My grumblings came from a suprisingly huge mismatch between Clashiko and
Sashiko. I'm gonna try to reproduce locally with new fancy models the
reports Clashiko had and then do some back and forth AI review rounds
before sending next rev.

Hope this time we're gonna be a bit more robust with validating these
changes within Intel ;)
