Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434AB41F5FD;
	Wed, 15 Jul 2026 19:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784142433; cv=fail; b=Xmf/VCs7NVT/QnyKtfK1MvR5EmOqGHPdfF5YTi6gR1hpwdg+lZVygS5ElJgSsutmTN5fS82aZdVqCm/DNkUltc7ZRSVIpB1BcQc3yFR7vTrx6hO63+tz+c6MI3g0rFqvOvWAJllnGSLiRKvKi2eKlbBsYbvHR9XeRhd4SY/mjOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784142433; c=relaxed/simple;
	bh=iElNSeGILfi+EaIv4GyCi4GIBz3XwHys5MMowqcLH/w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jS7sVA8rik1rfMeJfTxnKmZFhqzNNaPhlbUwtV7M2M5nbN9+zY0ayfREY/URD6ba06XKzZfgENqNT857Lfnry0vFWQ0Mcb84kSS4eZ+QE9p8G/dGZ7HXUSiJmmqjUIBjAnyqp/Nf3p4ls79lUiCjPc7OcKtu0Bny8p17UhCsioI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lk2FOs8R; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lk2FOs8R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784142423; x=1815678423;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=iElNSeGILfi+EaIv4GyCi4GIBz3XwHys5MMowqcLH/w=;
  b=Lk2FOs8RCme9kW+FJm0DRnxxG1e0ySTQDQJ5/3TpvCMAuFJAwrIRcyBg
   7H2GFLPejI21J7OrTWP9QBvswoJgzbJ4pxhEmnmHSxu1bIIXyZ4SzkE0m
   huCSE2P3RQEgGh22EIlQCSUAf2pmeCjC+8e3u9qrHcBkjygOjKP8yWx21
   rsOHO+qJGr8gXbdxxsuvK49AYzRnEpxLRbyWy5/2k1GNq4BOksvhAD+27
   B1s1JPrBoC+IktPGmCqIPTPbCgL16WtVWozub9u+E/Yy3Wwu4UBYmXHwz
   kCHw3VkRfJu5CFxDLLU2tq9x8SjPQtTk56k0vqIe19gp2Iw3GRa188rqj
   g==;
X-CSE-ConnectionGUID: 38b1CczZSB2zpx0FpdiCgw==
X-CSE-MsgGUID: BAwc3bMwT/OawWqBPWV+xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="102346484"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="102346484"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 12:06:56 -0700
X-CSE-ConnectionGUID: 3SxAcUMRRPGzmy8Y44QpYg==
X-CSE-MsgGUID: Id7QXXvIRvyGXUvpxJ4wTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="255766715"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 12:06:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 12:06:55 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 15 Jul 2026 12:06:55 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.26) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 15 Jul 2026 12:06:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vn6NIZMABGc7UqCXQoJjyNyvYdkjcBVwT6wJ3q+mQCwUZ6JCnyOBo74r/cUXIk2lpqRPy8ZIBXjX3nhwzAHkLfzh45EQJttYABFnGnq+Gxr72B7vrAQk7aq/pHfU8Uo5ajNL5S14JaglkOBkuZqwDCPUxvkp+xDmq6mBnjc8hNxrf7HLLUnZ03qeJeD+x2+bDNb5qQdb/LjX6zKeuHvzI3Sohe6NQ6+6snURLo6glZlhynnO0KqbIDmH5a+plZ0m3abOd6pi8Xwph7UHfrTh/ihKAc3fjgeZt1VwouzMFdTMrcoPtnLDN+lmA8/9ubxsWmO8D6+x16NchbK1VOulJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PJmh15iq0/AtwW/3nUUZMvA0i6E5pGFxVZFbE6DP0XA=;
 b=xP/mUHa16ZknOmo9hcdarK/If8viqAYRABJuSNBHdXFs7hqjlj7GCO16P6vTpfkOWwNxTS82Y1bNH0ELlgmvUeJGMBp3ftPjEoymyjp+RhxAszltkKLmigFnCWNW8CLTumZKcI6UdZttDQVeNYKh/9AyF+XPQ2p216GIdnOssi44WCm893zjKB106cgr3w4CtCmtuY4X4qmXE63eSp27+zwK+C5yz2ShQk64EqYmu4o6IEey4eYjNduCTFhb4hRKvVv/EMUUMYsvw+fVkgZpkCBpbek/0AIj1JNohwxidWLiHwawDPGVQEds70LaAyKDxJREmAqWe0nys7XaoAVxEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA1PR11MB7176.namprd11.prod.outlook.com (2603:10b6:208:418::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.18; Wed, 15 Jul 2026 19:06:51 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 19:06:51 +0000
Date: Wed, 15 Jul 2026 21:06:46 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev@vger.kernel.org>
CC: <bpf@vger.kernel.org>, <magnus.karlsson@intel.com>,
	<stfomichev@gmail.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <bjorn@kernel.org>, <kerneljasonxing@gmail.com>
Subject: Re: [PATCH v3 net 0/6] xsk: fix AF_XDP multi-buffer Tx descriptor
 reclaim
Message-ID: <alfaRiK4Ok3gS2Sm@boxer>
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
X-ClientProxiedBy: VIVP296CA0120.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:358::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA1PR11MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e672419-a9e1-41a9-ae2a-08dee2a43a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: Yg6TNqyn+Z/IBRXiphamy6j0NrA5Q2Owq+nsbKJUJN5vvEuzhCsAk85J+0VyWq5PivYFFAuMJsxlMnnzX2zSgw+3a6dmkIMZJk7wpz9jL9INM22dgk84UOk6kVXKFvSKspBzIGsacZq6VCdkM8/B5LBqLuyAOmfezUJyPFhcoSa2VPOhPy+boS0+1G9T51iDAEawOml2AiLL/FQv1aPodpT3VZ9YE+LO8DaxqLz/ODGrVbzmv5AA4auwuufJFkr2IgTlTVNnhbybiJXa7FzyD8sCYmfZJdUsbXtPmgZfz+HSjVufAOVstOlqzWDTnme2MyLdH7Bm/OWpd3XQkGBhjVVSh93ssf4/eM4/jHYJJUdLJ2tzpq2gj8Geq+Q8MRDGs1tYMi9Lda6CtKyjyKY9QN7EoyymKJfgsPxRAnTd477Ql8kQyXL/VDyZYvFs/vKPYTAQ+AdBuaUHflvy2xmmUbuxNghvjRuruVCs+tvv+IoymXIL7VvVYzVEKBCh7xW2bsbPLGBMk6mdlPCnCE+FPUwyRFgmF1DP+bkCDjOmVabAmQbOQiY+97GFPPIxrcXDixImUWGyEBWiht6xASbm0JMmQY/r3wxhJRqy4RXREsvmzO9LzxUxLgr9JfZnMVTLz119SpMXrzL4Zh0oMmvRELRmRN+dINlSNTS1Dhugd5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TDZm5NQqO5U5w8vdQ6OjKznVL/YP+tfAC472QRikiW27ic4RxGpowB7G9ib0?=
 =?us-ascii?Q?23GMIGtkDQbNYe+WYF+KONY/dCZ2r7+fZY/dKizIdjsbrAAsWpDc8m4Y5pFo?=
 =?us-ascii?Q?nJMDAFnrOkKTD2ot6ZGP40i/HVUlzy2iFOWeuomX8VvkEYDTQ8ebyCcCHU6/?=
 =?us-ascii?Q?WdEYH0SNNrdEpWBVWZdUZb4Gk02NXbAAf8D04OhA7dIwmiyCc2X653x3BHpf?=
 =?us-ascii?Q?LS+6ir5edXQhBnO2ZEAwNCQGF6yWf2zQBoaL4DXNy2D58ui2SAa8Bmv83AFJ?=
 =?us-ascii?Q?v7CX8zWhrAQplhWRE9Rb6I3wkzp5rBMHqRG74kM/eclxkOCi8T7iykp9TdNJ?=
 =?us-ascii?Q?SLcA4AOAPnGME/iWyjqg9Enag9t0wumTIKj/cNKllqfBYSeA5rl76eccs/5n?=
 =?us-ascii?Q?Vidfrr1VIZ3XkRyrLS3e3AnYJgn/gTLvAcCOLKWF4AtYGJ3dFejJPJt0zOxA?=
 =?us-ascii?Q?mQb5z3+/lJL9CL0JmnJrCaL+N3sHLhgsYuotv3jkGXc/SaGbeMOJDNaPHwXI?=
 =?us-ascii?Q?SJloIkBH6KgWwnBGrHhRHMZwfnRH+n1wWyodH738RKogA0OTmUSlhc+Uk5Nq?=
 =?us-ascii?Q?KIglNmRIEKi+3RivK1PZyqgnH72YOiDjIEvPU6zursUqJfsbvQHH4SyjxxCM?=
 =?us-ascii?Q?/IrT3PWKTFtuvxRiCNrtGoktHcnN/A+H44GyVZ6i4C+hV6OrP9eecEj5xyXV?=
 =?us-ascii?Q?tq96inpX2iCHwt4eXfwsnLKeeTMG74y4CLDfasjMwspufI8sjFciuDLY6v03?=
 =?us-ascii?Q?QT7s7MGW1jLaVAUVdYro1nurgeHQpk6ehhxaSJErFVLhji7GetXetT20NuNM?=
 =?us-ascii?Q?1J+tPlHogp3olKC4Zw+u8BNU23GVI7VZnn9OHKt1Qn2AVk2faHLSwZ3rFH/O?=
 =?us-ascii?Q?eUVgzaH7ye5mXUXDjXzoUXlnfrtffdvU5GgcDRLYh+nkmfubX41fJaaG/t3B?=
 =?us-ascii?Q?323oR5nFc2FCTI7nIp5Xe6LP63mWRN+SzUUPKtuyXgOHOHdxOkPJgMO4pVYK?=
 =?us-ascii?Q?GPlXgPmJQihRq6fcureuBiLW/vLVcPy1cmjMTjNMrK3h4lT+oNoWigxg9tqm?=
 =?us-ascii?Q?ohQoDHcSGO/5rHoIjU0pJHBtNnmkK+VUiKGYT9XJZI7zxJpHL3qg02yVMR9k?=
 =?us-ascii?Q?FmPjnhKwfjO6YWTCo0tH95Il9CUEi/d5ESG9y+7Dx8HtQ+yYHDiEehE/40bU?=
 =?us-ascii?Q?hEjAxBRbxynzPwZzebI6RMH0qcUn6RrIre8P6zhB51kHhc207kJPwa5xTZ+d?=
 =?us-ascii?Q?5VlPCc4EBN3R9JTRru9aG1aNzpuS14XczlyymORSP69/D2Sa+EK4wvj1SsQH?=
 =?us-ascii?Q?I3goV5eGVsWL2z1k4C6k86GuK7AeXOdgusA7aK+Zq/Ue+HYuhSy8C+aGg9B9?=
 =?us-ascii?Q?1pmkfEQqD2I1VdcgaY2yxugHs2zDntJt4GeDgGBqb1d4AS+GjXET3TbIJ2yK?=
 =?us-ascii?Q?YnBT9Cda+Ne8q5wBYZQmLItcjTibRrS3oy+F5UYp9z8M85K1PQIfrvZzW0nb?=
 =?us-ascii?Q?gkv0fUxdavtQ6Iv+3kVhSZ/VlzevIFBLbqgt8pByS4v+RHcE9dYBLvM71vVS?=
 =?us-ascii?Q?ST4UsyABTzfMZf9Ia9UTin6DrtN7l79bjLoVCp0V7KWvDJrURPyi1Ih5F+Bl?=
 =?us-ascii?Q?zemZMisltLs1UwKa+vow+JCXobS1YfAIq1uJnWG2SBhwYJL6aGrS2sLap6le?=
 =?us-ascii?Q?gd2VfokbIT6RL99eEb7Qhq4JhPyPqi0AWVpj5Q93sZ3wglFV98X3kxMQvX1b?=
 =?us-ascii?Q?zfSa4WbJm0q02fzdCwu0FIiTyHe+Uo4=3D?=
X-Exchange-RoutingPolicyChecked: T0DncRHr7fDBxuOpCjuIbdVxDW+LobskNbLuW+MsqohaWL6Hh36Hw1lzi/OZdUh6Mq+VDGYl4aFQBFs//ZfgFJWST7Bl15EVs/VCZTo9XHN2CdUMvt5qfSvcySeg0uC2FvjYAzfMndl9iXp+81B0MtvQYazoqGkieT/s6Lbt6r4lVIdHw5le4bTzvm9kxBZbotFXOpfkaE/8jKHJ1HXBOh6wmBUcQDb6kt75TqWtt7xf4B/KZ140qg9ZW7nfdcsVIrh5BkbCBQufz3Dp+DvHAXAhytHuSdEq6Sxmu8BBxe6VO7hCedfyLRU094slpbUxHLlTSHseOlvuzQE3UUrerQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e672419-a9e1-41a9-ae2a-08dee2a43a72
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 19:06:51.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3ZZinwVob4xK3dV0eh+vV7uFVAzrUdyRkQU+Id/n+bBsb+7ustoYpQwxBMle1MGnA6kG9/fneskzWHUqmme8D13BdMJ5Dh2Yp/4ih6Yg440=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7176
X-OriginatorOrg: intel.com

On Tue, Jul 14, 2026 at 04:07:16PM +0200, Maciej Fijalkowski wrote:

Top posting!

I took a look at sashiko reports for this revision. I believe we can
continue the process and get human interview now (or everyone including me
are sick of this code). I would say the AI review evil has been
suppressed.

The need_wakeup issues which I brought up at 4/6 can be send as a
follow-up.

> v2: https://lore.kernel.org/netdev/20260710194424.84844-1-maciej.fijalkowski@intel.com/
> v2->v3:
> 
> * Added a preceding patch that sizes the pool-wide temporary Tx descriptor
>   array to the larger of the first Tx ring and the device's
>   xdp_zc_max_segs capability. This guarantees that the shared-UMEM path can
>   inspect one maximum-sized valid packet even when the socket that creates
>   the pool has a smaller Tx ring. Consequently, this patch now records the
>   actual allocated size in pool->tx_descs_nentries rather than the first
>   socket's Tx ring size.
> 
> * Fixed a possible infinite retry loop when a shared-UMEM socket contains
>   an incomplete multi-buffer packet. Pass the original descriptor budget
>   to xskq_cons_read_desc_batch() instead of the number of descriptors
>   currently available, so the parser can distinguish producer exhaustion
>   from actual budget exhaustion.
> 
> * Moved the completion-ring space check to the common batched Tx path, so
>   it is performed exactly once for both singular and shared-SG pools. Keep
>   the legacy shared non-SG fallback outside this handling, as it reserves
>   completion entries one descriptor at a time.
> 
> * Reworked xsk_tx_peek_release_desc_batch() to use a common singular/shared
>   batched flow. Resolve an empty Tx socket list before checking CQ space,
>   select the shared-SG walker through an explicit shared-pool condition,
>   and commit the resulting batch through one common path.
> 
> * Simplified xsk_tx_commit_batch() by moving the cached CQ producer
>   snapshot into the helper instead of passing it from each caller.
> 
> v1: https://lore.kernel.org/netdev/20260623133240.1048434-1-maciej.fijalkowski@intel.com/
> v1->v2:
> 
> * Reduced the series from seven to five patches by squashing the three
>   generic Tx drain and reclaim changes into a single patch. The resulting
>   patch handles overflow, invalid descriptors in the middle of a packet,
>   and reclaim of the offending descriptor as one coherent change. This
>   so it will be less likely to have things reported by Sashiko that are
>   fixed in later commits;
> 
> * Reworked the zero-copy implementation substantially:
>   * removed the bind-transition mechanism, including tx_share_pending,
>     xp_prepare_xsk_tx_share(), xp_finish_xsk_tx_share(),
>     synchronize_net(), and the transient bind() -EAGAIN behavior;
>   * added packet-framed parsing for shared-UMEM SG pools, allowing
>     per-socket drain state to be resumed by both singular and shared Tx
>     paths;
>   * retained the legacy one-descriptor fallback for shared non-SG pools;
>   * preserved the existing per-socket fairness quota while allowing the
>     shared walker to consume multiple complete packets and continue
>     filling the requested batch across fairness rounds;
>   * made the fairness quota large enough to process one maximum-sized
>     valid multi-buffer packet;
>   * extended the parser result with consumed-descriptor and
>     budget-limited accounting needed by the shared walker;
>   * recorded the size of the pool's temporary Tx descriptor array and
>     capped batch processing at that size;
>   * kept reclaim-only descriptors ordered after preceding driver-visible
>     descriptors and protected the delayed-reclaim state with
>     READ_ONCE()/WRITE_ONCE().
> 
> * Rewrote the zero-copy patch description to cover oversized packets,
>   continuation draining across calls, shared-UMEM SG handling, and CQ
>   publication ordering.
> 
> * Corrected the too-many-frags selftest description to state that the
>   invalid packet contains max_frags + 1 fragments and terminates at an
>   explicit packet boundary.
> 
> 
> Hi,
> 
> This series fixes several AF_XDP multi-buffer Tx paths where descriptors
> consumed from the Tx ring are not consistently returned to userspace
> through the completion ring when the packet is later dropped as invalid.
> 
> The affected cases are invalid or oversized multi-buffer Tx packets in
> both the generic and zero-copy paths. In these cases, the kernel can
> consume one or more Tx descriptors while building or validating a
> multi-buffer packet, then drop the packet before it reaches the device.
> Userspace still owns the UMEM buffers only after the corresponding
> addresses are returned through the CQ. Missing completions therefore
> make userspace lose track of those buffers.
> 
> The generic path fixes cover following related cases:
> * partially built multi-buffer skbs dropped by xsk_drop_skb();
>   continuation descriptors left in the Tx ring after xsk_build_skb()
>   reports overflow;
> * invalid descriptors encountered in the middle of a multi-buffer
>   packet, including the offending invalid descriptor itself.
> 
> The zero-copy path is handled separately. The batched Tx parser now
> distinguishes descriptors that can be passed to the driver from
> descriptors that are consumed only because they belong to an invalid
> multi-buffer packet. Reclaim-only descriptors are written to the CQ
> address area and published in completion order, after any earlier
> driver-visible Tx descriptors.
> 
> The last two patches update xskxceiver so the tests account invalid
> multi-buffer Tx packets as descriptors that must be reclaimed, while
> still not expecting those invalid packets on the Rx side.
> 
> This is a follow-up to Jason's changes [0] which were addressing generic
> xmit only and this set allows me to pass full xskxceiver test suite run
> against ice driver.
> 
> Thanks,
> Maciej
> 
> [0]: https://lore.kernel.org/netdev/20260520004244.55663-1-kerneljasonxing@gmail.com/
> 
> 
> Jason Xing (2):
>   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffer Tx
>   xsk: drain continuation descs after overflow in xsk_build_skb()
> 
> Maciej Fijalkowski (4):
>   xsk: provide sufficient space in pool->tx_descs
>   xsk: reclaim invalid multi-buffer Tx descs in ZC path
>   selftests/xsk: fix too-many-frags multi-buffer Tx test
>   selftests/xsk: account invalid multi-buffer Tx descriptors
> 
>  include/net/xdp_sock.h                        |   1 +
>  include/net/xsk_buff_pool.h                   |   9 +-
>  net/xdp/xsk.c                                 | 254 ++++++++++++++++--
>  net/xdp/xsk_buff_pool.c                       |  13 +-
>  net/xdp/xsk_queue.h                           |  76 ++++--
>  .../selftests/bpf/prog_tests/test_xsk.c       |  48 ++--
>  6 files changed, 329 insertions(+), 72 deletions(-)
> 
> -- 
> 2.43.0
> 
