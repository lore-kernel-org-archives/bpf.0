Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E453D75CD;
	Sat, 17 Oct 2026 18:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263059; cv=fail; b=l8Y3S87kB2iyRv4/sT92KIyEAi72TE00rDJZb3hYUTIOFPsGpT2RvHl7NuoSKYAyr35o5zACCHVz/9ycL108SsMxlNBlxhtVB2m8FNIFfzLaD5x/Q8Q6MVHN/n5hbwFyv49V/BSK37b0jlG4HWW3T24Ht1l/Bn38F6NPvilKrH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263059; c=relaxed/simple;
	bh=te3HHkGhzf6RWFVvaTLaenv9MU50Z6BXRKZxWvBVPi4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Wj+j9493c9M9Cc1A+odPzr0PfugorFosjam4DZuhVV42U8GOo/R8khOpI75ffj3g3xGXBsgnS+kKdSNSun/ypcvDERunDcJwrcqaU4qlIz5r+rwGIb7C/DOorEzS9q0SnsPVjUmJKpshOjL2s0qAAyqXxMCpG25Z/yPlxFc9Pqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcFZ2zVz; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcFZ2zVz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792263057; x=1823799057;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=te3HHkGhzf6RWFVvaTLaenv9MU50Z6BXRKZxWvBVPi4=;
  b=LcFZ2zVzmvtA8QCwdF4oN4ax7MPgFxJFFhdb4Ot1AWuRNpKZSKtIbYeB
   VmyXi9jisp7S8y7pPkKa0qySZob7iZs2ptqCGYCWNtt8ajFRLdnxfGYzm
   U9PDxam/WGZWHIZDMM7JuNSbNnVEKJhkTrXGM6XIGktF+W68/99sQti4r
   /leKmpUKoxkUX4i0yQaFzLDWcipMgh2e0w0iNhjNJNgQywTp3SkZznaWO
   yKkQ1ailFPwainV9FeCerVZWfyuQnXqFEX0oQW4Rr1wv35EtjZRjjgKCw
   //xrQH7rPomsVV6VXGS/+C7tlKg3CpKHan8fnYA04HKwWRR3vCF/vFMG8
   A==;
X-CSE-ConnectionGUID: PULJ+96hSEepGvO4EE3FtA==
X-CSE-MsgGUID: QK0zHKDuT+eJWwH8/fTE8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1115068"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1115068"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 11:50:56 -0700
X-CSE-ConnectionGUID: nOyL6n1yT5q62LPfyhmtRQ==
X-CSE-MsgGUID: ZQyNQ0BySGGhRPjoNKsflQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2252358"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 11:50:56 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 11:50:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 17 Oct 2026 11:50:55 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.64) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 11:50:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5GB5G3MP6h4JbPIB9i9cXnn8759U8KttgMo9L4p6KVll/fron70GkYKXmzWdLF5dIres6sprScW4GygZfH54B8zrP+l+sFBHvrs8U7z0mzhUwnzE2KwKotd9xj3tAn2/wlt03u8m3iyPW0wKcw0TOTXcJ5VhnjfuyR7RZZBTU5HGLZX8RRDblNtVhZ8ge3X5iwUkYm2+4nEnZiwgTgkD8gqbAbis25Lka0rf1TAABJI5jAUgpVwpb3nsLraEk8v4I0W51adGY9G8L+bH4LeHjJ4c2yNZgVQLgZj9QBmWx3b0U5u24QJ+iboTl16nDw6ZkO5ApImnU4KccowHW5aFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/tTLv4bHSxzzaZeouGXh9n4yE/MisKTWD1yT9owMdg=;
 b=i7PNfYe3h9GkwovXrEi3yCylhQK4F1eK5Kqs5tdhn7X/8AcwK/0q2GMpHdv2bSo9m2kjnX8WtWSxveFVsHmna7YfxMIM6KeJQY+6dnxpekG7ZNn8xqxYDnVhHaXvmEaf+PtMM5JQsyhovImYB13XG5hHLqBag/wwbctkOsvBAReF8++Ad4ElitJrXclZfOCFnhOlcfr/Zn+ZyZ/TMszDGKk3ZHPiVpa6fjMHHAIUzREd4qFJ+4pCaFyD1PuFdd4+eWhvkqdRFuTInCJDIsXt3NVVopCC5Kj1nnbrlGzxIAYSCK5PyRRaQzgebnPSWu+bbpgFzXFlzL+/odgMFLFsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM3PPFD7E67F036.namprd11.prod.outlook.com (2603:10b6:f:fc00::f54) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Sat, 17 Oct
 2026 18:50:52 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0522.012; Sat, 17 Oct 2026
 18:50:52 +0000
Date: Sat, 17 Oct 2026 20:50:39 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
	<kerneljasonxing@gmail.com>, <bjorn@kernel.org>
Subject: Re: [PATCH v3 net-next 14/15] selftests: drv-net: test AF_XDP
 zero-copy with an SKB peer
Message-ID: <atPDf2DpOfWLt9cT@boxer>
References: <20261014184539.774708-15-maciej.fijalkowski@intel.com>
 <179220637173.434549.12610717858136223745@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179220637173.434549.12610717858136223745@kernel.org>
X-ClientProxiedBy: VIUP296CA0160.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35d::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM3PPFD7E67F036:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbd5fea-02c7-475d-aa4f-08df2c7f91a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|261009223027099003|56012099006|4143699003|11063799006|5023799004|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: NRUM02Ssk5Xxiu4EY8zxCGDoO2d04ozfC6AFwWbvZ9rl+OhXbhiomUkMdqDwVm3N/wod/pSZwJ+HH88RztOB2BBnEIHkV+HncOqfhnJAwcd5R/V/fPyTcUe2SyA6aLB+UMABONhz6Jt43RKDnTF1cEWayx19nZjgYIHRngCTscBK5xi5nrI76QOgrgFcyfZpz5sEzMsJgrTCZ5cHqWYTpQGZKtW19i21Neb1Alwomd1b4hWby7kOZxs943SPtgHI5vzAQ25TKC6lPHuzOc5gNbvtSlDfXTuQfEQdi05FStccZCQl4C/v85qoK5y0aqRZz8WHS1DMQKQ8ac7Z/6Dw23fioyaVQ/XAsull6X23rS4HhwpgePM4IkkdsjDY83GJu9z7qny2QUCCpRFS/GnA9EF0FKDgJy4azma/KgvytiM5hgr1GKKLfqkH6WhVU4Ki+c67i2GsyuW9rAJhd04Kcs4QQAnqojEQUEJha6fVCIh/bI0LYir7oo3Kn2oxmpsqOAQmOt6DIDXN8Oz1C6ohUCUOyp8s/yK0puXYKQWjyJU2I+9h7oPZ7bEBU2fCbI6QUCdsB+AOcg5T+P3jDntco3ylJ6yTtwDqQxG3PyVZUbF9IN3vNiB3FMBnmldnkyCf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261009223027099003)(56012099006)(4143699003)(11063799006)(5023799004)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c1N2SmNtenR6VmtXeVBpVmdRUlFuTkt3ZGlMVVpxVTJBdzJ0U2Q1NXFJZGda?=
 =?utf-8?B?VW1JakQ1RWJacFRqRDhCbjVZNllsSFoyT3hMUmNrTHJXUXF0VTlhZW12VnNP?=
 =?utf-8?B?WExuMTJQWlo5N3A2V3NwVTEzakZOMlZmaGNmUEFsK3M1Z3JPZ1FzUzBpZ2p2?=
 =?utf-8?B?dUpNNWZvdUtIMGVWSmhscFpYT2I1eWhtbmNnRDk0cHpHREZVWXpSUzdmUHI1?=
 =?utf-8?B?alNZQVpYMlA4Z1E1d1VIbVJtaVh4TE8rSVBYRmNwcG9QRHNlcG1JUEhlUE4x?=
 =?utf-8?B?VzdOUVEwSm1vR0c3SG9PdDROUWlIT2V5QUVoc09oazA1WFAyRmxuWkU4eG5T?=
 =?utf-8?B?bGUrcmNPUjR2b0tmMWdET2tMQzIxU3dyN1ZqTUg1aEo1R0k5UWg2cXNzYTBL?=
 =?utf-8?B?TjRIMis4U1pLUmdtd1UxVFBuVWttVFlxMitEZE1wdDJMWW9yVE1JZWhwU2gr?=
 =?utf-8?B?eXlDdkxoY1dETGdGNWVkT3ZXdUE0cUZSWVpDVUdsays4bVdrcFFRNDhNTWR0?=
 =?utf-8?B?MStpM29hVUZ4VkxyL1hnM3BxQlhCcElVNDdHanBZMFlMQlZYZk9sd2VnM2du?=
 =?utf-8?B?WURqQUZUVnZpUXZrUWJDN05ocmQrWVNNOUhyb3JBL2p4MjJwQXE1d05NbkRo?=
 =?utf-8?B?NWZsTThNUjdSTWdxN1BKS0pER3oyNlJpQllYRkl3enFOK2JDcTdMcVBpUXlt?=
 =?utf-8?B?YVZIUUc5ZFRLKzk3ZVZ3MmtZM1pRbFVySkdJWFF3dDhSWklZcWthSjBiU0FX?=
 =?utf-8?B?ZktNZURMTVViaEtmVTBJcVBnVEg3MG1MRE1zRTY2TjhwSVRlQ1doT29JdUxr?=
 =?utf-8?B?elVVUkZ1ak91ajFpTTJOOEt0TTBveUtycnNHLzJaQ2xWbUI4WnBraW8wMjhL?=
 =?utf-8?B?U3VDSHRoWEZTQnhSa2tVUWs1Vzk2NE5rNTkvaTlJcFBzVldmVkNGOUEwUFF2?=
 =?utf-8?B?WFBSOGpPR3ZVb1M2MllSWlRlSDdLOVkrTVVMTmVPbElLbE1CcllDRXkxTVhN?=
 =?utf-8?B?THBaQ1pQYzVYZjYzTjZkci9yS0EwMDlUR293RkhmSGpoWUlyUS9TcEVzUllQ?=
 =?utf-8?B?MitlUTEwNVVrVi9uT2JBdDdRSDN2dnNjb3E2VkpnY3VtWGl5dXhUWjVCZGZS?=
 =?utf-8?B?ZmN2dy9tbnJlR1NVcXRjeTNncXdOaDFaSDlQK2d4aytBdGY4MHJETGtZWjR4?=
 =?utf-8?B?OWRQczVySjl1dHpNSFMxalV2dnQzQUtZMUdFOEdMWWhTVEJHRHJ6STdVbERE?=
 =?utf-8?B?alRwWHQ3VnlNSWg0Y1hrODBWZXBZOXliVWFlN3I1SUJzSnoyYXFNUkk1TmpB?=
 =?utf-8?B?R01ta09BWHM0WjRHWFBDZVF1ZStsamNabU4yRi9TTG5GSk9IcFhRWDkzSC8v?=
 =?utf-8?B?U3psazZLMGVDYzVWcGgwZWo4NXRzVU5FdzJtcGtMVUg5cFpVK0J1MWVOekhF?=
 =?utf-8?B?dzgyNWJaQnZhNVFkbmpQczJzcnVpbS9PK0JUNHIrTWVkU1htQTYzcHAxWmZx?=
 =?utf-8?B?UHZHK2FYR2xmb3orYTVSK3o4d0hQWjRRMmtpcGRUVHBvWWxiZVNkOVJIeVRB?=
 =?utf-8?B?NGV1QUo0bUg4THNsVVhjL1hyK3BwYWFVdnNEZStGWjF0UTAxZitaRmhuLzZt?=
 =?utf-8?B?VEozYmlhdzBrQ0p2dG91YTlsM0w0SkF1OEVwbzN2czAvWVl6VmJYc2dyTytU?=
 =?utf-8?B?YnJjbGYrVll2ZG1pWFNjeG0veDBSRTN2SU40ay9mNnd0YldTMUU2eDl3bTVu?=
 =?utf-8?B?b2drcjcrUmViME1SWENweGozWHdRMEg2dStGV0s2WHdIdG4ySFR5bnY4eGpq?=
 =?utf-8?B?RUx6WTdkOERHcXlURmw0RVpLOEZPYUFFTTRoWFlUY0hudUpPcTRNdFNXYW9r?=
 =?utf-8?B?N0NmdzRjYVpTVWlhYU9lMHNHTmVhUzlpOTB0c3BQWjQ0VjQrc3B6Wm5kNzZv?=
 =?utf-8?B?cllVZDhvS1EvSUZTaU1OYmVQU1RUNktNU2R6bnFQOENYRGUxZGxYdjdSK015?=
 =?utf-8?B?U3J0cFhoYmYzbFlFTEc3Tmpnc3BiT2J3WUo4ODIvTWo4L1BRU3F4bDQ2em5Z?=
 =?utf-8?B?aG14UnRPSUd6elhLRnlxN2swRnUzelR3eG11Nlp1U0dLdGJkSGt3eldKWmtQ?=
 =?utf-8?B?TDFKN0tHa1pZSlZWNk1LVExPSHR6RnM5NEJCVGwxZHV2VzhySFBFY0VzZkZQ?=
 =?utf-8?B?S1ZVb1dPTm1GTDZqa1VrS1V4TEJmbGdnb2V0blNBUlE1REFkVXA0SkFYOEc4?=
 =?utf-8?B?QjYvTUkvaDBwaUxLNlhaaUViYkMwNGlmZFpVWkRmNExEWjlSYURLbmZrNGdP?=
 =?utf-8?B?QisyTHZRd24zNEUrQWlwOG9xRkMrbVhsNUhiT0Y3bnd6REQ4dDhGSzR5UkJq?=
 =?utf-8?Q?HAVCIz/uCtFrYFms=3D?=
X-Exchange-RoutingPolicyChecked: P+qEZhVHazjBRQobsp8oyo+uZQM1Ryo/GRiIv7N7uumQYskngh/PuU5rtAJ+idRfsD96Bt4ySobQFcWrmXQXvgdR1GkjQ6fFXOaBveE4jnDQ+zxEgtlj+iBumnNe+KmYLVpUy1Y3mX1hv3fvmfbcOcjfFipKZvGUVmSzVmrzw4ch1+qiLsV7WuOnIUAIFg0WXOmsNLYplPFYMmjK8RjcZmIaNN0Qm+i8uS8uGGGiUC5jQrnPO7XpDUB6DaL11OlDtj38IgZdtHHNpzY4zHPhScTtcBeESghAPpnctmmVkAciw1+JBj0EHt+iBsHwLAxnX3ON8aaaMxEGIVssyi06zQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbd5fea-02c7-475d-aa4f-08df2c7f91a0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 18:50:52.6984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVr+pLv0wnZlsiw1efcBNbBsoaPjOfuvzAKSRCLJRp2ZxyyYHwEKXa4RCa8hb4KWxmjvqBgbe7e971I27CeGONiJgGyqHbJwkTz0c64S5GY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFD7E67F036
X-OriginatorOrg: intel.com

On Sat, Oct 17, 2026 at 03:06:11AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 8 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 6 · Low: 2
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In tools/testing/selftests/drivers/net/hw/xsk.py, main()
>   changes state on both hosts and has no try/finally to undo it.
> - [Medium] In xsk.py, _run() starts the DUT zero-copy endpoint with
>   `local = cmd(local_args, background=True, fail=False)` at line 142 and…
> - [Medium] main() in xsk.py calls `xsk_reserve_hugepages(saved_hugepages,
>   cfg.remote)` (line 227), and xsk_reserve_hugepages()…
> - [Medium] If an endpoint is killed, the NIC's TX/RX descriptor ring
>   sizes are never restored.
> - [Medium] Taking the zero-copy queue out of RSS (_reserve_queue(),
>   xsk.py line 74) is the only thing keeping non-test traffic off it.
> - [Medium] _reserve_queue() in xsk.py assumes every reported channel can
>   be addressed by RSS.
> - [Low] The commit message says 'A host without ntuple support skips' and
>   'A DUT with fewer than two such queues skips'.
> - [Low] In xsk.py, _steer_udp() runs `ethtool -K <if> ntuple-filters on`
>   (line 86) when the feature is inactive and not fixed.
> 

I believe here I am done with responding to comments from our beloved
bot. There is one issue that indeed needs a fix before getting this in
(see below at ATR comment). Let me know if any fixups are possible...

> --
> 
> selftests: drv-net: test AF_XDP zero-copy with an SKB peer
> 
> This adds drivers/net/hw/xsk.py. It runs the xskxceiver cases as pairs of
> processes: a zero-copy endpoint on the DUT and an SKB-mode endpoint on the
> remote. main() sets up the shared state once (an RSS-excluded queue, ntuple
> rules on both hosts, huge pages) and undoes it after ksft_run().
> 
> > diff --git a/tools/testing/selftests/drivers/net/hw/xsk.py b/tools/testing/selftests/drivers/net/hw/xsk.py
> > new file mode 100755
> > index 000000000000..fd708bb3420d
> > --- /dev/null
> > +++ b/tools/testing/selftests/drivers/net/hw/xsk.py
> > @@ -0,0 +1,263 @@
> 
> [ ... ]
> 
> > +def _reserve_queue(cfg):
> > +    """Take the last queue with both an RX and a TX ring out of RSS. A TX
> > +    endpoint fills no RX buffers, so in zero-copy mode its queue drops what
> > +    it receives, the control connection included."""
> > +    ch = cfg.ethnl.channels_get({"header": {"dev-index": cfg.ifindex}})
> > +    count = ch.get("combined-count", 0) + min(ch.get("rx-count", 0),
> > +                                              ch.get("tx-count", 0))
> 
> [Severity: Medium]
> Does this assume that the RSS indirection table can address every reported
> channel?
> 
> On pre-X550 ixgbe (82599/X540) with ATR enabled, which is the default,
> ixgbe_get_channels() reports the Flow Director queue count:
> 
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c:ixgbe_get_channels() {
>     ...
> 	/* report flow director queues as maximum channels */
> 	ch->combined_count = adapter->ring_feature[RING_F_FDIR].indices;
>     ...
> }
> 
> That count can be as high as 64. The RSS table on those parts can only
> address 16 queues:
> 
> ixgbe_rss_indir_tbl_max() {
> 	if (adapter->hw.mac.type < ixgbe_mac_X550)
> 		return 16;
>     ...
> }
> 
> ixgbe_set_rxfh() rejects entries beyond that limit:
> 
> 	for (i = 0; i < reta_entries; i++)
> 		if (rxfh->indir[i] >= max_queues)
> 			return -EINVAL;
> 
> On a host with more than 17 CPUs, would "ethtool -X <netif> equal 63" fail
> and raise CmdExitFailure during setup? That would abort the suite on a NIC
> that advertises AF_XDP zero-copy. In this configuration the chosen queue is
> already outside RSS, so the table doesn't need to change.
> 
> > +    if count < 2:
> > +        return None
> > +    queue = count - 1
> > +    ethtool(f"-X {cfg.ifname} equal {queue}")

in v4 rejected ethtool -X skips the run instead of raising exitfailure and
any previous setup is undone.

Current get_channels() output interpretation is targeted towards modern
NICs, but later on if there is really such need we could check if chosen
queue is already out of RSS...?

> 
> [Severity: Medium]
> On NICs that steer flows based on TX, is taking the queue out of RSS
> enough to keep the TCP control connection off it?
> 
> Flow Director ATR is on by default on i40e. i40e_atr() samples TCP TX
> packets, including the SYN. It then programs an FD filter that steers the
> flow's RX to the queue of the TX ring:
> 
> drivers/net/ethernet/intel/i40e/i40e_txrx.c:i40e_atr() {
>     ...
> 	flex_ptype = FIELD_PREP(I40E_TXD_FLTR_QW0_QINDEX_MASK,
> 				tx_ring->queue_index);
>     ...
> }

SO CLOSE! This one has to be addressed as atr is turned on by default and
this could cause i40e runs being stochastic. I must admit I did not have
i40e setup on my side, but it has full AF_XDP feature support (including
mbuf zc) so its coverage matters.

Fix would be:

diff --git a/tools/testing/selftests/drivers/net/hw/xsk.py b/tools/testing/selftests/drivers/net/hw/xsk.py
--- a/tools/testing/selftests/drivers/net/hw/xsk.py
+++ b/tools/testing/selftests/drivers/net/hw/xsk.py
@@ -115,6 +115,16 @@ def _reserve_queue(cfg, undo):
     return queue
 
 
+def _disable_atr(cfg, undo):
+    """i40e ATR steers what a TCP connection receives to the queue that it
+    sends from, which can be the zero-copy one, so turn it off until undo."""
+    flags = cmd(f"ethtool --show-priv-flags {cfg.ifname}", fail=False).stdout
+    if re.search(r"^flow-director-atr\s*: on$", flags, re.MULTILINE):
+        priv = f"--set-priv-flags {cfg.ifname} flow-director-atr"
+        ethtool(f"{priv} off")
+        undo.callback(ethtool, f"{priv} on")
+
+
 def _steer_udp(cfg, undo, ifname, queue, host=None):
     """Steer the test flow to queue until undo, return False if ifname
     cannot."""
@@ -313,6 +323,7 @@ def main():
         cfg.queue = _reserve_queue(cfg, undo)
         if cfg.queue is None:
             sys.exit(SKIP_CODE)
+        _disable_atr(cfg, undo)
 
         cfg.udp_port = rand_port()
         steered = (_steer_udp(cfg, undo, cfg.ifname, cfg.queue) and

> 
> FD filters take priority over RSS. Suppose XPS picks the last TX queue for
> the CPU that the DUT xskxceiver runs on. The remote's replies on the
> control connection would then land on the zero-copy queue.
> 
> In TX cases that queue has no fill buffers. Wouldn't the control
> connection stall, so the case fails or times out depending on CPU
> placement?
> 
> Only a udp4 ntuple rule is installed. Unlike a TCP4 sideband rule, it
> doesn't disable ATR automatically, and the flow-director-atr private flag
> is not cleared.
> 
> Some drivers gate aRFS on NETIF_F_NTUPLE, which _steer_udp() may turn on.
> When RFS is configured, aRFS could steer flows the same way.
> 
> > +    return queue
> > +
> > +
> > +def _steer_udp(cfg, ifname, port, queue, host=None):
> > +    """Steer the test flow to queue, return False if ifname cannot."""
> > +    ntuple = ethtool(f"-k {ifname}", json=True, host=host)[0]["ntuple-filters"]
> > +    if not ntuple["active"]:
> > +        if ntuple["fixed"]:
> > +            print(f"1..0 # SKIP {ifname} does not support ntuple-filters")
> > +            return False
> > +
> > +        ethtool(f"-K {ifname} ntuple-filters on", host=host)
> > +
> > +    out = ethtool(f"-N {ifname} flow-type udp4 dst-port {port} action {queue}",
> > +                  host=host).stdout
> > +    rule = re.search(r"ID (\d+)", out).group(1)
> 
> [Severity: Low]
> The commit message says:
> 
>     A host without ntuple support skips.
> 
> and:
> 
>     A DUT with fewer than two such queues skips
> 
> Here a skip happens only when ntuple-filters is fixed off. There are two
> other failure cases:
> 
> - The feature can be toggled but the NIC rejects the udp4 dst-port rule.
>   ethtool -N then raises CmdExitFailure.
> - The output has no "ID N". The re.search(...).group(1) then raises
>   AttributeError.
> 
> Would either of these bypass the skip branch in main()? The run would then
> error out instead of skipping, and the _unsteer_udp() and "ethtool -X
> default" calls in that branch would never run. If only the remote rule
> fails, the DUT rule that was already added would also be left behind.
> 
> Similarly, _reserve_queue() runs "ethtool -X equal" with fail=True. A DUT
> that rejects the RSS table update, such as the pre-X550 ixgbe case above,
> would crash during setup instead of skipping.
> 
> > +    cfg.rules.append((host, ifname, rule, ntuple["active"]))
> 
> [Severity: Low]
> When ntuple-filters was inactive, "ethtool -K ... ntuple-filters on" turns
> it on before the rule is added. The toggle is recorded only here, after
> both ethtool -N and the ID parse succeed.
> 
> If either of those raises, the toggle is never recorded. _unsteer_udp()
> turns the feature off only for entries in cfg.rules.
> 
> Could ntuple-filters be left enabled on that host after a failed run?
> Recording the undo right after the toggle would avoid that.
> 
> > +    return True
> 
> [ ... ]
> 
> > +def _setup(cfg, busy_poll):
> 
> [ ... ]
> 
> > +    fallbacks = [
> > +        defer(ip, f"link set dev {cfg.ifname} mtu {cfg.dev['mtu']}"),
> > +        defer(ip, f"link set dev {cfg.remote_ifname} "
> > +                  f"mtu {cfg.remote_dev['mtu']}", host=cfg.remote),
> > +        defer(ip, f"link set dev {cfg.ifname} xdpdrv off"),
> > +        defer(ip, f"link set dev {cfg.remote_ifname} xdpgeneric off",
> > +              host=cfg.remote),
> > +    ]
> 
> [Severity: Medium]
> What restores the NIC ring sizes when an endpoint is killed?
> 
> xskxceiver changes ring sizes with set_hw_ring_size(). The only restore
> happens in cleanup_iface(), on normal exit:

Addressed in v4 by moving ring changes into  xsk.py . The runner saves the
sizes and registers their restoration before starting the endpoints, so
restoration does not depend on endpoint cleanup running.

> 
> tools/testing/selftests/net/lib/xsk/xskxceiver.c:cleanup_iface() {
>     ...
> 	if (ifobj_has_cap(ifobj, XSK_CAP_HW_RING))
> 		hw_ring_size_reset(ifobj);
>     ...
> }
> 
> xskxceiver has no signal handling, so this restore is skipped in two
> cases:
> 
> - xsk_wait_endpoint_exit() sends SIGKILL to the DUT endpoint after
>   CASE_TIMEOUT.
> - timeout(1) sends SIGTERM to the remote endpoint.
> 
> These fallbacks cover only the MTU and the XDP detach.
> 
> The next endpoint's capability probe in test_xsk.c then adopts the
> leftover size as its default:
> 
> 	if (!get_hw_ring_size(ifobj->ifname, &ifobj->ring)) {
> 		ifobj_set_cap(ifobj, XSK_CAP_HW_RING);
> 		...
> 		ifobj->set_ring.default_tx = ifobj->ring.tx_pending;
> 		ifobj->set_ring.default_rx = ifobj->ring.rx_pending;
> 
> Would a hung ring size case then leave the NIC with a min or max
> descriptor ring size for the rest of the run, and after it?
> 
> > +    return fallbacks
> 
> [ ... ]
> 
> > +def _run(cfg, local_args, remote_args, ctrl_port):
> 
> [ ... ]
> 
> > +    try:
> > +        head, listening = xsk_wait_listen(remote, ctrl_port, LISTEN_TIMEOUT)
> > +        if listening:
> > +            local = cmd(local_args, background=True, fail=False)
> > +            dut_ret = xsk_wait_endpoint_exit(local, "dut", CASE_TIMEOUT)
> > +    finally:
> > +        # Even if the DUT endpoint did not run, so that the remote one is
> > +        # gone before the next case starts.
> > +        remote_ret = xsk_wait_endpoint_exit(remote, "remote", REMOTE_TIMEOUT,
> > +                                            head)
> 
> [Severity: Medium]
> Can the DUT endpoint be orphaned here? The finally reaps only the remote
> endpoint, and xsk_wait_endpoint_exit() kills the process only on a
> timeout:
> 
> tools/testing/selftests/net/lib/py/xsk.py:xsk_wait_endpoint_exit() {
>     try:
>         endpoint.process(terminate=False, fail=False, timeout=timeout)
>     except subprocess.TimeoutExpired:
>         endpoint.proc.kill()
>     ...
> }

Addressed in v4 in the shared helper: interruption kills and reaps the
endpoint before propagating the exception.

> 
> When the kselftest runner times out, it sends SIGTERM to the Python
> process only. _ksft_intr then raises KsftTerminate inside the wait on
> local, and the exception propagates while local.proc is still running.
> 
> ksft_run() catches the exception and runs ksft_flush_defer(). That
> detaches the XDP program and restores the MTU while the AF_XDP socket is
> still bound. main() then deletes the ntuple rules and resets RSS.
> 
> xskxceiver would keep running after Python exits. It would later run its
> own cleanup_iface() against state that the runner has already changed.
> 
> Should local also be killed in the finally?
> 
> > +    return dut_ret, remote_ret
> 
> [ ... ]
> 
> > +def main():
> > +    # ksft_run() exits on -l and -h before main() can undo the setup.
> > +    if "-l" in sys.argv or "-h" in sys.argv:
> > +        sys.exit(f"{sys.argv[0]}: -l and -h are not supported")
> 
> [ ... ]
> 
> > +        saved_hugepages = []
> > +        cfg.hugepages = (xsk_reserve_hugepages(saved_hugepages) and
> > +                         xsk_reserve_hugepages(saved_hugepages, cfg.remote))
> 
> [Severity: Medium]
> What happens when the remote kernel is built without CONFIG_HUGETLBFS?
> xsk_reserve_hugepages() starts with:

addressed in v4 and described on veth runner comments

> 
>     have = int(cmd("sysctl -n vm.nr_hugepages", host=host).stdout)
> 
> vm.nr_hugepages exists only with CONFIG_HUGETLBFS (mm/hugetlb_sysctl.c).
> Without it the sysctl fails, and cmd() raises CmdExitFailure instead of
> the helper returning False.
> 
> The commit message says the UNALIGNED cases are "left out without them".
> Wouldn't the whole suite abort before ksft_run() instead, leaving the RSS
> change and ntuple rules in place?
> 
> The drivers/net/hw config covers the DUT, but nothing constrains the
> remote kernel.
> 
> > +
> > +        cases = _get_cases(cfg)
> 
> [ ... ]
> 
> > +        ksft_run([ksft_variants(cases)(test_xsk),
> > +                  ksft_variants(cases)(test_xsk_busy_poll)], args=(cfg,))
> > +
> > +        xsk_release_hugepages(saved_hugepages)
> > +        _unsteer_udp(cfg)
> > +        ethtool(f"-X {cfg.ifname} default")
> 
> [Severity: Medium]
> If main() leaves early, does anything undo the RSS change, the ntuple
> rules and the huge page reservation? These three calls run only when
> ksft_run() returns normally, and the setup has no try/finally around it.
> NetDrvEpEnv.__exit__ doesn't know about cfg.rules or saved_hugepages, and
> defer() only works inside a case.
> 
> Any exception after _reserve_queue() skips all three calls. Some examples:

addressed in v4 via ExitStack introduction, suggested by Bjorn

> 
> - a CmdExitFailure from ethtool -N on either host
> - the AttributeError from the rule ID parse
> - a failing remote sysctl
> - a failing "xskxceiver -L" in _get_cases()
> 
> The "-l"/"-h" guard at the top of main() matches only those exact tokens.
> ksft_run() parses arguments with:
> 
>     opts, _ = getopt.getopt(sys.argv[1:], 'hlt:T:')
> 
> This accepts clustered options like "-lt NAME" or "-hl". It also calls
> sys.exit(1) on a GetoptError, such as an unknown option, --help, or -t
> with no value. All of these exit from inside ksft_run(), after the setup
> has already run.
> 
> The commit message gives the reason for the guard as:
> 
>     so xsk.py rejects -l and -h, on which ksft_run() exits without
>     returning
> 
> sys.exit() raises SystemExit. Would a try/finally around the setup and
> ksft_run() cover these paths and the -l/-h case as well?
> 
> There are two smaller points about the teardown itself:
> 
> - "ethtool -X default" installs the driver's default indirection table,
>   not the one that was in place before the run. A custom table set by
>   the admin is lost.
> - If xsk_release_hugepages() fails, for example over ssh, the rule
>   deletes and the RSS reset after it are skipped.
> 
> > +    ksft_exit()
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014184539.774708-1-maciej.fijalkowski%40intel.com
