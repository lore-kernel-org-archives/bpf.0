Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F1D381B1C;
	Wed, 19 Aug 2026 11:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787139004; cv=fail; b=C1B/nkXe+5iFefIL0dGfCe9Qi8NCPuJYOOhR6J8SRaoX+y7QI4gmiXYu/NDh/x/sk9Dlgs0PJD23muv8CyQI6jaI4KwrwZ77SY5B5KEYy90zzva/B7Y13Hpk8/Ndss8Yegew0KrZiVW+hvACfp/j4WZO0zq53yrBI7mr0symkdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787139004; c=relaxed/simple;
	bh=QpPcAplr72/UT7B4R6IGPF49Qn5YPmHKCp0Oowks9qQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=e7Di5YCOn4wI/E7rmN0M9O/OtOIu5jLtjomng55OJ5P1sVEKJ/6YMmw9lxxQ0KH+7//z75DqbBPzesPjWZv7+Nkta1I+Vs4PTsOP8j3lZAy9Ry3poi8qrzwHogl11skJftzU0hSLADPuUe1L11QGWY3M8UVW5zqYP3BYe/XsGJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KyWcUW28; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KyWcUW28"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787139001; x=1818675001;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=QpPcAplr72/UT7B4R6IGPF49Qn5YPmHKCp0Oowks9qQ=;
  b=KyWcUW28KsuXWfs44mv9sbk03BOKnIBxgPWIFdPvweLLNvGOHKWSok8H
   CoFRXjjYrAeysPL4Vn+AbkBJkxHwr8rty6fTlLWZmUoSYU89NqGdxEEAD
   XwGILcf1MV9+M536gHMHgLXHya50uG3CblxjPNYsBO32knzl15WwL3n1r
   Go+17c62YHpcx5w5r36jETMBwjXc8cQvN4QsLoUuPK+Ue52WCWptt6Bzo
   w/Yzb8nxNzIx5rNVV2HNIWs2Lny06B+I52WkiDxpJLadEzAt0ePP4DpWi
   aSQfqV2g15otOYd1P/A8QVXpuundutQyx6FpfCFt2sN9H6S3rcSaSN+8R
   Q==;
X-CSE-ConnectionGUID: tUhwU9+uTEWnk05TWKYizA==
X-CSE-MsgGUID: J9mKbLlhSVyvQP1Dmn1I7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="99175681"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="99175681"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 04:30:01 -0700
X-CSE-ConnectionGUID: PsA/+56ASKuelkHbBxYQtA==
X-CSE-MsgGUID: 1cwrxVwjTxO2ppBgmku5JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="264194809"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 04:30:00 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 04:29:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 19 Aug 2026 04:29:58 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.8) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 19 Aug 2026 04:29:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XJvMgwJ2EZz/vw0guuTx33Vupql7QLp1oAHT0ExpUjL0wETjOepJ8mms+r715JlRKgRmBaRqhE8B6h6DBYtm10EA3IcwJsw7waY2eBTa/tkfwbmK90bKcliBVA4K1f4jNBzTEPq+aZ/XoDrNCpWGDOrzerG2/nQ2gZR1OUSs5j19kzEYN4RtK5vlIVORUuysNLWzajubcrUe2s+NwOx5QyMzZaVhw/UohW9qA/VuWvfNR8UkMFhNg6fpfWGKAkJT3qAJ00215KFUcpi+EgRAI4ASL5aihbsxqFhCF8llps4cQHhg+XPkGMmmGEviQG/AuXhG655yRAhN4qNkemu1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2LCPCTpUenvdqOW8B4SPutpAbhMJzmJAf7ZINNW24lE=;
 b=xyn7cjcZKu7lo1PuByCGIVCsi9tgOUkAOXGJE5eVD+lE5nSRXixt/fCsJCx2kCrfM3VXkc0d4o/UBcylQJHgCxA0r8Atg/Rtqb8e6tKOz5D0MN8L60vdb71Kgq0vwRYxWlYsN9GJMLCpzApfBvDlB2R2nke/iAOwE4sXC8IxB5k3Zo6pfARnoLqTtkwwyxOmNHaf9Lojf25C/vM7KRN+2uAU6FOkdgKJkHNevi1AiuB4VBFUC+33wzWKeOlGaYklGIE6OWPgSztiwoQ34RGAHhA6+SRuzlQ/LLacJSRnOOxsR1W71/qHbvvinfXD1JUIm0dhaNTNmvxAVYyTLChKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ0PR11MB7704.namprd11.prod.outlook.com (2603:10b6:a03:4e7::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.8; Wed, 19 Aug 2026 11:29:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 11:29:52 +0000
Date: Wed, 19 Aug 2026 13:29:38 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Simon Horman <horms@kernel.org>
CC: <blbllhy@gmail.com>, <magnus.karlsson@intel.com>,
	<kerneljasonxing@gmail.com>, <sdf@fomichev.me>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <AutonomousCodeSecurity@microsoft.com>,
	<tgopinath@linux.microsoft.com>, <kys@microsoft.com>
Subject: Re: [PATCH net v3] xsk: fix NULL pointer dereference in __xsk_rcv()
Message-ID: <aoWTos9p9CTVfvma@boxer>
References: <20260806204757.47817-1-blbllhy@gmail.com>
 <20260810132505.769431-1-horms@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260810132505.769431-1-horms@kernel.org>
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ0PR11MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f653aa-6f9b-4494-3712-08defde52f6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|3023799007|56012099006|10067099003|4143699003|5023799004|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: uD6AtwWsNq6fy2eCOLLWzH5GZKwtTebkC9XT9xWK3CfFziLksIip/R60K3c+Fagu9rCDTg1xCWea+Bm8oRzyNwG0PVbYtRuD4Qw1j/H9MXPq3Yex4ZIgNVFqxXr3lBcUe9U0PxxSBZ3FrsiupxgI/ZUc0LKxnUmce/4xBzrHi0NkfZTjfflqCJZmmbKB4GRa3t6n4z3+YcZWMOXVnIlkkgP3CzbJsaRkXqVEB9HfsY4TQQgqHEMu77Kb7TeVen2Vbu6cVaccVFDcwxMk/xNeBdOJDpm7vJ9VOqR/oOMafuIaYcOyPr5kuT4UiPZPvA+wx3lppbfllaATRbbjEduanU7RtoOb0f/pCJRyulJI1hqg3D1VaPcmsIMi3Tfp/soottKs28WII+UlIjLgQG7OG/MEw2KGxjFdQqRv5yZyXVIb4AFNX48EmbDglJXdT5xs9jl+4onilstRb4jrbuPm0jzUZ3UiD/d+yuqZ9JspAv5QB5O28NfhXjefp51pgr4ubBT8tKMpvft/0lr5EXHvsOCsyrBj27h8KipopJhyZdeNAFDfb4nTQIUYyzOt9q1PB5DmuBHTXdbUPh03eL/evs9eBlzvXhv8ugGjDHpBQMY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(3023799007)(56012099006)(10067099003)(4143699003)(5023799004)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uD7WDs6aYhaNtAVxo3LXXwMfYt+Z+UBkSI5DWit5m6CzYcCcRPXpeASqKYdq?=
 =?us-ascii?Q?qn9hXUyJuZkZFl1DQmZUKdMa4bULE1einuT18+wgKCiIb6NqTbw2oLUXwmbn?=
 =?us-ascii?Q?2aPPmid1ElNP1r45EjBOKUjdpDuaSSmAkx6kR79XDCTEZqDCBqLBRSkV2v3T?=
 =?us-ascii?Q?ViXxkuN+GqaBWjK0TyP0cHskhV7GN8NyZhvfsPdD2JFCzPjJmtK4U7qTUo5z?=
 =?us-ascii?Q?gFvtI0qk1Z7Bgp2ROEiQklu5b+KkU4qqNncCwhkyZ0rBiz3F0DI5OLh5AjH3?=
 =?us-ascii?Q?lvQQVUvRpMwCSTuSZx9i4j+Le8mvl7IoSOVKfEKcsJJ2AC8yJT9zw/cALJeR?=
 =?us-ascii?Q?MZjR2/MmKKDsUvSu7NNNcH3vrZQDQLWRDO4jY0jhhNI2gTfuv7o7ylAlZxPm?=
 =?us-ascii?Q?VSSFi7NXI+xnSPwfIJj8+zXoLguazo4dCYGui+kQbCJnehoVo0fhRq7dA5av?=
 =?us-ascii?Q?xxrfS6eeVSYd4J2bhFkKjTeaRDbbz+JW4EZOoFZMywVZMQkT4UaWgJV3WZ5l?=
 =?us-ascii?Q?hYEGXbL7N5mF0jvq/AbE7Se846YNaR1FXdhPdP7mtjeJ1Don5CV/BTyj+GeF?=
 =?us-ascii?Q?nimCAYVXly8n7H6UXW9joUFbq/w5Od3EPM6fP536QvqIAVVJgW8US8M9uy6/?=
 =?us-ascii?Q?jzc3or4t/2XtbhZCadZ4pskXJXYWa001h3X5bhv0a5UQ470YWi2i2qKnovXw?=
 =?us-ascii?Q?f3TyUi4PCWrOFyD902JWkh+19lIJxr061Fy37y4pDFTAcylXGxTP78vJWAk9?=
 =?us-ascii?Q?KdYHwAXRSKDODbScnuHwtM+gxfgiIxpYztuf7m0MV31A7lDHRFbl+VBBAowD?=
 =?us-ascii?Q?mfWT285POSmA0CM6cOmEMLcjuAfV1koq3+TYi63uFXqyPFbqtuJqBrvg1Iuk?=
 =?us-ascii?Q?Qhr5ONee5Mbu9I+FXFKCaU1GDcfZCAHnd+M83+Dc3u0Jo4q7BDouTxsrRLWw?=
 =?us-ascii?Q?2ePH8WTATS/LpoHgk5zjI44iZ+UktZ9P+enD4AALzX0wavArGEXTW38YNSdW?=
 =?us-ascii?Q?exW76/E/9ZJj8z1zuqLDHwX7iIgR/0h2TT/V+tBRUdlwJaiLKpTWbDSSNQFf?=
 =?us-ascii?Q?JoWqqgyDBhKZD5mWIOvZHmzR0R6Vl8SzMRRap6Nj/kilDctHu4lZpqhbB4mf?=
 =?us-ascii?Q?Cr0uG61kDZMmQ1Yu+Gg2m0YlJUfpF2rBdLFr5cMkwiYZgGxal9VawX0e+a8i?=
 =?us-ascii?Q?zw+hG4UIXR3QZfJCony+0BGQ19ea1bBU1pkxkP0yU5TDzkRg6kLceXLeuGc9?=
 =?us-ascii?Q?homOjkBA2iX7H+eJA672cvXMJW71m/FlhmUwnDc4Z0ORU2jpKtZgCY6DwLLh?=
 =?us-ascii?Q?c4qtuBq9kSYuhOvl1HAPESEdhMw0mzp0zSWEPwcupgXZkqLXzSxZpSD9YtNw?=
 =?us-ascii?Q?PGL6io1Vnbq7UA10DHL1YJSBTDQV+5E1/vPTD3xn4yzePmdvpzVwsDDdDhz+?=
 =?us-ascii?Q?0LRWU7NINF7ZNj2fzOTCSxpK/Wwf1A5+4+7T9A0cI84Yf/Ih17TSslYicpY1?=
 =?us-ascii?Q?qPw/oXVpHIwBESJxjmYuaDfB6nOOtGXmFix/yRdiRRVALZI8/gRnGDps7FiB?=
 =?us-ascii?Q?P3K3d8ejLF1jtGTBsY6mpSEnzj3HRsYoNZV2BbRxJjp7KtAvV2/luhpxcuG0?=
 =?us-ascii?Q?YOYc0+4YSr1opJcc6/40mQYF9G7Z+/Tl35BwhI+wUttLyHKN6YqK8WxNfRr/?=
 =?us-ascii?Q?APZoWl3nh8TEb9FMi5+gp50+F9lesdRMIK8D2jVTWtjZ3oSFq2Ufu9h7Uo3M?=
 =?us-ascii?Q?PXc/IF8vVJeaNj6+TO0Kq9db5Jy/tnE=3D?=
X-Exchange-RoutingPolicyChecked: TeI+FsvMyBY/A6ull4AymmE1dvnrkUnXDEH7aprgy7O8eWOaw+e/l4bj5qSRHVIFFt5ToFtL/OYrxnCx2017mVEqgJbJcWOlXWoXLB8eHpoeT3OTjmqWcUQZo/hFaj4IXRaMsX4pErU2od966V7dW+i6VRnF5cWdBry2e77wMFrqcSyRrUHGmRnjMmAPzTF45e5q2iT1iTgD3WYF433BOjd5nlB/MNGZzxqA8679yDkND4ugrAthx+JYISjfyC3GX57R06yeSRAF3uka2eAf/odM9vbtCeAy2hUHYsUIvXHBVjemFo6YTpoN7eKhckak/0Xa/NfgVsWCYwu0mmxH/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f653aa-6f9b-4494-3712-08defde52f6d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 11:29:52.1340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQ26OicwHxr7Wy2c/IwUKfO+eKJXYcS1v1Olufw45497NCdvMgA//HAMWczX0wDXrEzluKOuZyqE9RQCvNyxXdjSQzyH7Tc5QdZLb7DO11c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7704
X-OriginatorOrg: intel.com

On Mon, Aug 10, 2026 at 02:25:05PM +0100, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260806204757.47817-1-blbllhy@gmail.com?part=1
> ---
> --- Patch [1]: [PATCH net v3] xsk: fix NULL pointer dereference in __xsk_rcv() ---
> commit ee824acf57213f0a5f7afb287ff22c8b8eefdc3c
> Author: Cen Zhang (Microsoft) <blbllhy@gmail.com>
> 
> xsk: fix NULL pointer dereference in __xsk_rcv()
> 
> The patch converts the multi-buffer copy path in __xsk_rcv() into a
> two-stage transaction: all buffers for a packet are allocated and staged
> on the pool's xskb_list first, and only once that succeeds are the data
> copied and the RX descriptors reserved. On an allocation failure the
> staged buffers are recycled with xsk_buff_free().
> 
> Link: https://lore.kernel.org/netdev/20260724164719.99563-1-blbllhy@gmail.com
> 
> A couple of questions below, starting with the changelog.
> 
> The commit message ends at:
> 
>   "Only after the allocation stage succeeds, copy the data, reserve the
>    RX descriptors, and release the buffers in an error-free loop using
>    xsk_buff_get_frag()."
> 
> [Severity: Low]
> [Finding: main-1-0]
> [Sources: opus-5]
> Should the message also describe the two new drop conditions the patch
> adds?
> 
> The first is the new WARN_ON_ONCE(!list_empty(&xs->pool->xskb_list)),
> which drops the packet and bumps rx_dropped based on pool-wide state that
> is also written by xsk_buff_add_frag() and drained by xsk_rcv_zc().
> 
> The second is the new handling of a Fill Ring that hands out the same
> chunk twice ("xsk_xdp == first || !list_empty(&xskb->list_node)"), which
> is entirely under userspace control. Before this patch, an aligned-mode
> Fill Ring containing a duplicate address made __xp_alloc() return
> &pool->heads[xp_aligned_extract_idx(addr)] twice and the old loop emitted
> two RX descriptors both pointing at that chunk; now the packet is dropped
> and the Fill Ring entries are consumed with no descriptor produced.
> 
> Both are explained in the v3 changelog below the "---" separator, which is
> dropped when the patch is applied, so neither git history nor a stable
> backporter (the patch carries a Fixes: tag) sees them.
> 
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 7855ee09c4b64..02ff3ad97410f 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> 
> [ ... ]
> 
> > @@ -343,11 +344,34 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> >  		frag =  &sinfo->frags[0];
> >  	}
> >  
> > +	if (WARN_ON_ONCE(!list_empty(&xs->pool->xskb_list)))
> > +		goto err_alloc;
> 
> [Severity: Medium]
> [Finding: main-1-1]
> [Sources: opus-5]
> Can this condition ever clear itself once it fires? The err_alloc label
> only does:
> 
> 	err_alloc:
> 		xs->rx_dropped++;
> 		return -ENOMEM;
> 
> so pool->xskb_list is neither drained nor repaired. pool->xskb_list is a
> field of the long-lived struct xsk_buff_pool, initialized once by
> INIT_LIST_HEAD(&pool->xskb_list) in xp_create_and_assign_umem(), and it is
> never reset per packet.
> 
> If a stale entry is ever left on that list, doesn't every subsequent
> multi-buffer copy-mode packet for every socket sharing the pool take this
> branch and get dropped, with the stranded buffers never returned to
> pool->free_list? Since WARN_ON_ONCE only prints once, the drops after that
> are silent.
> 
> Would draining the list here, or keeping the staging list call-local, be
> preferable to a bailout for a condition that persists?
> 
> > +
> > +	first = xsk_buff_alloc(xs->pool);
> > +	if (!first)
> > +		goto err_alloc;
> > +
> > +	xdp_buff_set_frags_flag(first);
> > +	for (i = 1; i < num_desc; i++) {
> > +		xsk_xdp = xsk_buff_alloc(xs->pool);
> > +		if (!xsk_xdp)
> > +			goto err_free;
> > +
> > +		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> > +		if (unlikely(xsk_xdp == first ||
> > +			     !list_empty(&xskb->list_node)))
> > +			goto err_free;
> > +
> > +		list_add_tail(&xskb->list_node, &xs->pool->xskb_list);
> > +	}
> 
> [Severity: High]
> [Finding: main-5-7]
> [Sources: opus-5]
> What serializes access to xs->pool->xskb_list here? The two callers of
> __xsk_rcv() do not share a lock:
> 
> net/xdp/xsk.c:xsk_generic_rcv() {
> 	err = xsk_rcv_check(xs, xdp, len);
> 	if (!err) {
> 		spin_lock_bh(&xs->pool->rx_lock);
> 		err = __xsk_rcv(xs, xdp, len);
> 		...
> }
> 
> net/xdp/xsk.c:xsk_rcv() {
> 	...
> 	err = __xsk_rcv(xs, xdp, len);
> 	if (!err)
> 		xdp_return_buff(xdp);
> 	...
> }

Hi, catching up on emails. Once again this is AI nonsense.
A single pool can NOT be shared in two different modes. Referred race is
about SKB and DRV modes. This is simply impossible to happen.

I see v4 got applied with local-list approach. But to back up the original
idea, pool->xskb_list would be safe to use IMHO.

cpumap issue is real tho, but it doesn't sound right to have workarounds
in xsk due to cpumap being broken.

> 
> xsk_rcv() (reached from __xsk_map_redirect()) holds no pool lock, so the
> per-packet staging state now lives in pool-global list state with an empty
> lockset. Previously each buffer was a local variable in this function.
> 
> A concrete unlocked, non-NAPI caller is cpumap:
> 
> kernel/bpf/cpumap.c:cpu_map_bpf_prog_run_xdp() {
> 	struct xdp_rxq_info rxq = {};
> 	...
> 		rxq.dev = xdpf->dev_rx;
> 		rxq.mem.type = xdpf->mem_type;
> 		/* TODO: report queue_index to xdp_rxq_info */
> 	...
> 			err = xdp_do_redirect(xdpf->dev_rx, &xdp, rcpu->prog);
> }
> 
> queue_index defaults to 0 and mem.type is page-based, so an XDP_REDIRECT
> into an xskmap from that program passes xsk_dev_queue_valid(), takes the
> copy path, and runs from a cpumap kthread that can execute concurrently
> with the NIC NAPI, another cpumap kthread, or a generic-XDP
> xsk_generic_rcv() on another CPU that only holds rx_lock.
> 
> Can that lead to concurrent list_add_tail() on the same list_head, i.e.
> list corruption? And can xsk_buff_get_frag() in the copy loop pop a buffer
> staged by the other context, so the same umem chunk ends up published in
> two different RX descriptors?
> 
> Note also that the helpers touching this list in
> include/net/xdp_sock_drv.h have no internal locking:
> 
> include/net/xdp_sock_drv.h:xsk_buff_get_frag() {
> 	frag = list_first_entry_or_null(&xskb->pool->xskb_list,
> 					struct xdp_buff_xsk, list_node);
> 	if (frag) {
> 		list_del_init(&frag->list_node);
> 		ret = &frag->xdp;
> 	}
> }
> 
> They were previously reached only from the NAPI/zero-copy driver context.
> 
> > +
> > +	xdp_buff_clear_frags_flag(first);
> > +	xsk_xdp = first;
> >  	do {
> >  		u32 to_len = frame_size + meta_len;
> >  		u32 copied;
> >  
> > -		xsk_xdp = xsk_buff_alloc(xs->pool);
> > +		next = xsk_buff_get_frag(xsk_xdp);
> 
> [Severity: Low]
> [Finding: main-2-3]
> [Sources: opus-5]
> This isn't a bug today, but the producer/consumer protocol for
> pool->xskb_list is now implemented two different ways in-tree.
> 
> The canonical producer is:
> 
> include/net/xdp_sock_drv.h:xsk_buff_add_frag() {
> 	if (!__xdp_buff_add_frag(head, virt_to_netmem(data),
> 				 offset_in_page(data), xdp->data_end - data,
> 				 xdp->frame_sz, false))
> 		return false;
> 
> 	frag = container_of(xdp, struct xdp_buff_xsk, xdp);
> 	list_add_tail(&frag->list_node, &frag->pool->xskb_list);
> }
> 
> __xdp_buff_add_frag() sets the head's XDP_FLAGS_HAS_FRAGS and updates the
> head's skb_shared_info nr_frags/len. The new code open-codes the producer
> side with a bare list_add_tail() plus xdp_buff_set_frags_flag(first) and no
> skb_shared_info initialization, while using the official consumer
> xsk_buff_get_frag(). That yields a frags-flagged xdp_buff whose shared info
> at xdp_data_hard_end() is uninitialized. Today nothing reads it
> (xsk_buff_free() only writes nr_frags = 0), but would it be safer to reuse
> xsk_buff_add_frag() here?
> 
> Related: xsk_buff_get_frag() is declared as
> 
> 	static inline struct xdp_buff *xsk_buff_get_frag(const struct xdp_buff *first)
> 
> and every other caller passes the head buffer, whereas this loop passes the
> fragment returned by the previous iteration. That only works because the
> body uses the argument solely to reach xskb->pool.
> 
> >  		copy_to = xsk_xdp->data - meta_len;
> >  
> >  		copied = xsk_copy_xdp(copy_to, &copy_from, to_len, &from_len, &frag, rem);
> > @@ -356,10 +380,21 @@ static int __xsk_rcv(struct xdp_sock *xs, struct xdp_buff *xdp, u32 len)
> >  		xskb = container_of(xsk_xdp, struct xdp_buff_xsk, xdp);
> >  		__xsk_rcv_zc_safe(xs, xskb, copied - meta_len,
> >  				  rem ? XDP_PKT_CONTD : 0);
> > +		xsk_xdp = next;
> >  		meta_len = 0;
> >  	} while (rem);
> >  
> >  	return 0;
> > +
> > +err_free:
> > +	/* Re-set frags flag; xsk_buff_alloc() may have cleared first->flags
> > +	 * if the same Fill Ring address aliased back to first.
> > +	 */
> > +	xdp_buff_set_frags_flag(first);
> > +	xsk_buff_free(first);
> > +err_alloc:
> > +	xs->rx_dropped++;
> > +	return -ENOMEM;
> >  }
> 
> Following on from the locking question above: with the frags flag set,
> xsk_buff_free() walks the whole pool list:
> 
> include/net/xdp_sock_drv.h:xsk_buff_free() {
> 	list_for_each_entry_safe(pos, tmp, xskb_list, list_node) {
> 		list_del_init(&pos->list_node);
> 		xp_free(pos);
> 	}
> 	...
> }
> 
> so if another context has entries staged on pool->xskb_list at that moment,
> does this error path xp_free() buffers that are still in flight there,
> skewing pool->free_list/free_heads accounting?
