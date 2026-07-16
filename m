Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F184432F748;
	Thu, 16 Jul 2026 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784198861; cv=fail; b=npaMDDyXIl13tZYBYQ8JknadtEz8jCUwCDuvQM+2YXUDYAPVnVrj7lli9BYHtIXWsiGmpNOz5waOKr3IVGKi8zKZdZX3N08CGaAnaDkbJkAi73bMmQZTthzAKzEmgxog/ZbSO9eueoXtTRt4KCfDzoMmQjVE2W+NF8oHgYywWZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784198861; c=relaxed/simple;
	bh=CEbQ6GmJWnpCJ7q3SQOH1XkL2AkpDPr/6Og5oZHkDAk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lqfO779ZdYNdyDk8/gEyoSuzj0NfLerby3Kf6lquYeFwjHOCHuSzdgkBRz9DY9okq/hMjuyzzpbgMO7M9lW9SiG1p9nolN9/m3t1egnaDFdI9u8uj4ugzOjxJoO5PRUa3enNMxEno1itJbt1N/JOLdn33sJAIGig0Um1lFz17IQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GtCXPPRN; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GtCXPPRN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784198859; x=1815734859;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=CEbQ6GmJWnpCJ7q3SQOH1XkL2AkpDPr/6Og5oZHkDAk=;
  b=GtCXPPRNhYubWlSgtcJDcuI0HDVPyuFARmCdirpf2tA85YXKrg71YboZ
   hlj2V8xMDQkK3n6Lq9XdeQqUM8QELZ+tnqDpKaKsMvpvFqX/GHWbxjNrd
   98ZiXkrB9QBEHDpTftEIZq2tiMLaJNb4spqZFTX1spbKC4RUs8s1UH1l7
   xc86TeBJvdwaKcZecpQ4tmcjPnPRMniViBEUxo1MX3VgHa0093KeD8rjV
   xkpf7qxA5FVxPY0mj6LgIPTyWIb8jRF3EhX/vZu1pYSDPhceJn4L7gBr/
   QIsxc/1ZwPQ4QkDo0qtY3Wyfd0Ma1gyR7F/Cr49uulaN4bypIeOEZDVc1
   w==;
X-CSE-ConnectionGUID: DvKdJmFWQMKpldSe7FVCHA==
X-CSE-MsgGUID: URWda4qPRVemCzlCkG8n6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84814034"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="84814034"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 03:47:39 -0700
X-CSE-ConnectionGUID: 8K1Z0oPCSZ+wVH7m58y8Dg==
X-CSE-MsgGUID: m8kZ7UC2STSsVQQ3RRlP8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="253055079"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 03:47:38 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 03:47:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 16 Jul 2026 03:47:37 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.29) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 16 Jul 2026 03:47:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PmylDZe87ni8ECTdTn/xkMImkVBejrZwp5fBNL5/73Xg1g0nh0b8ilvEiEGoXV6G1tmoWsMxbtP0p/10QUwuKwacK/BoTF8HvcCMrcQCi34zuZj7EuZIjbUWJlILYNDWj/m0cgqkVYNVfCdljY9cEntkV26F3vIwNDfLJCOAKmcV2txpc3RC5nr7RLYMhua3gnD+skzSPphTNVm6b2aqqHlPplqI/WIAwV1J9NoUp1cRHxdYwBYTviXz7s5uT7+OoZvX9oYMc83pK+HGwt3MRmqwNOhoVmGz35vff56PE8bkkLOY1evGZ4FfMeKrUr/Mz55T32NZKgssyCuFNqoW5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dhTWwvo1FizTUgFxPFQ+COvuele4rDF+Q63fD5IGDYU=;
 b=sP8DK3O195LcIGjv6gCaGPCa/eKGqMafBHgMoSYqXqOGvwEYtfKQgU/dh5y4C/Jm/OlJ38FhWveGO9PNEoBjXFu0i5wI/8KLbiMWMddY4UHzc+APO4a3i3TVVoQsGVmGTlQi9uiVhXAYKMzHhLUJL8/1iO/uN0vQGsDM6ib6gJ7FM7djoHkIQCSMznuAHwiIla6uAMyc1FVH0cRconf4DmkZN04Rh3j4Av32kltDMe7x7RDcEygy1UMZusw5tmPAup0ffFvfiOp5GjW4h2Vj5u/kcDnUCXNdf4Z8OWnOfYFWyId7/HHB8EzmAY+F3uSFJzdFvEYtcP/A025pi+HKEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6990.namprd11.prod.outlook.com (2603:10b6:806:2b9::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.11; Thu, 16 Jul 2026 10:47:33 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0223.008; Thu, 16 Jul 2026
 10:47:33 +0000
Date: Thu, 16 Jul 2026 12:47:27 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <bjorn@kernel.org>
Subject: Re: [PATCH v3 net 3/6] xsk: provide sufficient space in
 pool->tx_descs
Message-ID: <ali2v31fXqzAKrEP@boxer>
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
 <20260714140722.111645-4-maciej.fijalkowski@intel.com>
 <CAL+tcoDc-a=Tx3VGfjnPoLq2hWaGCBjUe+NzHeaz=QPvjWEXjA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDc-a=Tx3VGfjnPoLq2hWaGCBjUe+NzHeaz=QPvjWEXjA@mail.gmail.com>
X-ClientProxiedBy: VI1P194CA0026.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:803:3c::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 299390a1-3e25-48d5-3b5c-08dee327a436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|4143699003|56012099006|18002099003|22082099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: 4gChi4bOVIpkHrTZRShTxDdqTCx7bJ2S3qyqjASUgFKgNMWJTbL5EnKt1UDMZBzeLKIAw3OfdT629ZzNixJ6Y8gAmauQeIXNWM/KRDc1bmjQpWR+NEq6eztYloGPN58223OMNZpaOBijnzYiFO+ZpweC1K/MIUzsdFXV9WdhIuASVON75UGcxPwh0p5DGgZ5gKWEistq1dGn+uUkzEKa3VpJSLSw2bcruzLLtFZvEBu7r6iKctBqr8Sp+BSI/49VfbrGqb41F/xZrWaTmnREqortOj7wmrRHHxaIY40nC4Im8q2hXYaZ0EA+k49yC0i7oPpEdxAHDhsudlXTzl4+wVbelWFuHatzM507ZpkVaMm6/Ce4EdcvxTVYlSeApqmbUxc8kf1P2cf2TQdprYjPs271abNHeutPnY6QrUCVbZ2G7ok+db0A9gAMrwqh6RaLQIwUGHM9D+9wZiKr5D0hhcvejnkrkrNmo+Wm6YX6T2lHVEMgMs6TJDXbB9aFEvjeC4rzpYH66cfOm5iHSqhoYeCH3YFnLkAiv4/MwypukZjJaMxFXie34xacFg7ve6/zkPe/fTUPYKd9zOGUvGUBVuHg1yj7sG9Z9qI9hRRLDa8nq5/0pJxx8PBAijWcz7Pki+XbNkw3Lw+C5HYmwRUrTM4v691fcSWCoBv91knI41I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(56012099006)(18002099003)(22082099003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWFKQmtYenIzclZJanRRU1VYZTBHWmRpMnU0TDRGenFLbXFDK0JucmV0YU9H?=
 =?utf-8?B?Y3NsbndyUWVNMG11ZzNJQXZ2TUN5RWxJbC9sSEVKUlJMNlVqeGQ2Z0NhNjRk?=
 =?utf-8?B?M3B1eWV2ZUFkelVsdS84ei84em9pMGgxaXJlL1hXQUMxbTBLcU53My9GOG11?=
 =?utf-8?B?ZVNOUU1ERGNlT3BCRDNKSnc1cW1XeTB0YTNHcG9GbklXWmloWThFelR4ei9R?=
 =?utf-8?B?MUx3SUI0WWtHci9EWWpOdzN5K2dYNUwxL1RhZFIvT1o2eE5nL3hobm1BcVlE?=
 =?utf-8?B?cGlTYWYyb0FLM1I2TzR5bm1ya1o2SHNSRGtZRHBaUUtyQ1gvNHgzVnNYSHNi?=
 =?utf-8?B?WTl1Qm9nczRkOHhLdm5ibUN5b0puSUV3cGpSN0xDYUkvMXN0SmpxeENRaTRX?=
 =?utf-8?B?N0pDdHZQVFJDeGpHeWJlakI5ZlE2NU1JdFNObkN0dGhvQnFjTjRiNE83WHg0?=
 =?utf-8?B?VFdZdUczSm5jTzE2aWl3bEFYdTZlYUc4T3JMSFZVNzVOQ2J6OXQ5UCtYNTVW?=
 =?utf-8?B?VHZPeUY2REFHN1Z1ZGxySHRpeVdmTzJ3cTVzY1dxalRscmYvbnA1a0xNUWhB?=
 =?utf-8?B?bkh1bENEdkdxSHFaKzVob3NRdzFCL0VWSzAvQmxTalVSRmFRWnhpelZzRzJa?=
 =?utf-8?B?NGZsMzZtL0diYlcyMmF6SlN2S1VyMk54VjFHS1cxZ1g5Nk52Z2xZTGt2SkM5?=
 =?utf-8?B?aXMzbzlaRC9yVlR6MTRLaVh5cVFKU2s5TXhoaytvcmM3S3dGZ00yUTg1Umc3?=
 =?utf-8?B?M3dzNWFRM0RkUkpOMldPQ3Zia3NlNGlPRSs0OHN6MkFVNUVsdmNkdFZybmx1?=
 =?utf-8?B?dGR6VzZ0M2N3NVFRZUJ3dUFQQ3VGdFZJSGFibE84VVhlWHFhS296ZWdiMWJw?=
 =?utf-8?B?SG5MRmo3cUt3SG40SFZ5Snc0d0xsWlkxNVFzcVZYQ3Qxb0hBNDk1QmN1T2x5?=
 =?utf-8?B?Y2xCYVFBV1dhZzJ2MDIzN1BmZ0VVenhqU3djR1p5SiszTXdLa1YvbWd6cThP?=
 =?utf-8?B?UU5nc2FnUFllTm1YN1M0VDBWQmtsbHBiVVM1a3AySXltVVhITnE2cFI4ak8w?=
 =?utf-8?B?RDAvNzNRVDM3MnZLK0JmZitRRnV0NmFDQmttdmt5ZHA0UWxxUDRLYk5PSTdy?=
 =?utf-8?B?WnlGUHZ2SEw4SEFReWViOUE2cGVGdHpnNElpb2lOZHFPL2xrTGNkT0tiU1lZ?=
 =?utf-8?B?czJyRW5WR05JQkJFdkxETjRVOURWY21YcklPK2NtMisvdlhONnIzdmp6NSs1?=
 =?utf-8?B?bHFNZkVOVVNwQ2JXZjYvSW15djNJU2NzR3RhaXp6Y3dYMFczVGhqTWlJL1Iv?=
 =?utf-8?B?K1J3Nkc4bkpPQ1p0UC9FWlhmU2tpRXpnY0VJc0NGakpJMHVuL0hsZ3JoZmcw?=
 =?utf-8?B?MXhNVWVjUmxoZVZkZVZPUTJoY0ljTGIxWnlyOTdoa01iTDMwTk1pVUdNdys3?=
 =?utf-8?B?Z1pWNUI0S0ozNXE1S1lQeTJMWmRYaDRTQ2t1ODFNNjlCTS92NjFRUXI2b1hs?=
 =?utf-8?B?TnVUeTdTMXhES2NvQklGNmdsUm4wOGNMUFZHdjFTUjlZN1JGNFNxVkQ0ekJR?=
 =?utf-8?B?Q29lU0gramgwQkJxQXQ4Qm84Si9tQ09GRG1CY3NjNU5KRXpOb0UwNDVXOVdH?=
 =?utf-8?B?OTFXSDdkUklhYUFHVGFxaER1OXN5MytGako5QWNHK0hFSmlEOGxvNGhkVTZ3?=
 =?utf-8?B?KzhWWTdXeklUT3pKTGV1SUNkSlUrZ3pJc1RkMVFVSEIzc01wWU8yckRSTjNC?=
 =?utf-8?B?OVZER0VRbWVaM1lOVi9vNDl5NEdEMUVxYUR1N0JsVHBWOHQ1M3VoMEYvcHZr?=
 =?utf-8?B?OTVwRytrTU11MmZsZ1BRbklnQmc1Z0MvaWwyYVh3UGdNNW1jeDViL2NQblA2?=
 =?utf-8?B?cmhwVTJtM3pCSVlLc3IrWjl3SjVORzl0WUpDKy8yUy9ZN0lObmJON0hSQzRn?=
 =?utf-8?B?UGdJUU8zOWFlNWt3a3F3a0s2N00vUXI3cWo0VFVadTBreVErMHVLbjU1czc1?=
 =?utf-8?B?VUwxNVNGQURFMmFuMXEvMmlTMDRnRmdqZHhpL3BDdlNmRDhWd0xnRmxtOTlR?=
 =?utf-8?B?N2VuTGM0YzliZlloaGNwcXkyYkQ5OG1nbmpuakY5dlVFQ2FlazZ3ZEFWU3dO?=
 =?utf-8?B?NEFWaFpjVnBseW5nRkJPaXRJaEIvWldVSXF3K0tlZlppVTBWblAyUnhRelNG?=
 =?utf-8?B?K0Y2VFpYdExoalNXc09Qai9peGU4blVlYTl3V0pHc1BoMWIyekFscE1TK0dU?=
 =?utf-8?B?QVFBS1lCYUdkV2F5SWVBSEN3eXhqWC9YT281bjRNU2creFlQUExLc1d1cjJ1?=
 =?utf-8?B?SWFqREtaenZ0V3EvU2FTZXlyTzdqTE9KQXdnMWhyQU01SWtGSG9aaktqK01z?=
 =?utf-8?Q?7hW6i5Lcp+Q9uJO0=3D?=
X-Exchange-RoutingPolicyChecked: NXl4KjYlntICRoFghpPVKPqpUo8Z2HAoJ9kHC8/gnkMvOKCVmZZHpntksEC/RJrKgkF/VL9JJb2C43hODcziBocM7TVR8s942N2g7fC2Cx16hwHfS8xSyyk5R0Alu/x4Byw2bBC0LVgpjzPnGmmPT2xYuKX3OpPTFz6FMNhH/lT4QUJXLltlVZBNrSQuNROcfRZI1wppt/Z/qi89w5A5RwiGinUUH84T2+5Xuzna2PXCuJT5NXjVUiBu+T1qz/Zvaj7JquvvU3xY8USE8XA5n6MI5nhkMgPN+b9FqbOeVs81S5aKnR2rFk+ndOvAjspx09dS+KDdUu5cqLOpzJ8F6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 299390a1-3e25-48d5-3b5c-08dee327a436
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 10:47:33.3677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgCOQHUC+xqIT5BgJjZzVm8p7Hhx9QJevw3nqTY4uacsQq/Y8hUGrInJOab7fyZN31HW3BN/QpC7+gyGSCXmoLLjsyisBeIHqyKu7pp0OM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6990
X-OriginatorOrg: intel.com

On Thu, Jul 16, 2026 at 11:29:49AM +0200, Jason Xing wrote:
> On Tue, Jul 14, 2026 at 4:08 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > The temporary Tx descriptor array in an XSK buffer pool is currently
> > sized from the Tx ring of the socket that creates the pool.
> >
> > This is insufficient for shared-UMEM Tx. A later socket may have a
> > larger Tx ring and submit a valid multi-buffer packet containing more
> > descriptors than the first socket's ring, while still remaining within
> > the device's xdp_zc_max_segs limit.
> >
> > A packet-framed batch parser bounded by the temporary array cannot reach
> > the end-of-packet descriptor in that case. It leaves the packet on the
> > Tx ring and encounters the same packet on every subsequent attempt,
> > stalling Tx processing for that socket.
> >
> > Size the temporary descriptor array to the larger of the first Tx ring
> > and the device's xdp_zc_max_segs capability. This keeps the array large
> > enough to inspect one maximum-sized valid packet. Larger shared Tx rings
> > do not require further resizing, as they can be processed over multiple
> > batches.
> >
> > Following commit will actually address the data path side.
> >
> > Fixes: d5581966040f ("xsk: support ZC Tx multi-buffer in batch API")
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> 
> I noticed there is one interesting comment[1] from sashiko, which
> actually I think is valid. Probably we don't need to do it in the fix,
> but we might need to target -next branch. Now the tx_descs is limited
> by the first tx ring.
> 
> [1]:
> "...since tx_descs is not
> reallocated if it already exists, the array size is permanently frozen
> to the first socket's size.
> 
> Should the array be resized to accommodate the largest shared ring, or
> should the batch readers be updated to cap their reads to the array's
> actual size?"

My take here is that this set will not break the user space by providing
at least pool->xdp_zc_max_segs at pool->tx_descs. Let us rely at least a
bit on user's intelligence here - if you would attach one short ring for
whatever reason among with bigger ring to the very same umem and whine
your performance suck, then I'd say it's on you :P

Hope this makes sense!

> 
> Thanks,
> Jason
> 
> > ---
> >  include/net/xsk_buff_pool.h |  6 ++++--
> >  net/xdp/xsk.c               | 10 +++++++---
> >  net/xdp/xsk_buff_pool.c     | 12 ++++++++----
> >  3 files changed, 19 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/net/xsk_buff_pool.h b/include/net/xsk_buff_pool.h
> > index ccb3b350001f..f5e737a83055 100644
> > --- a/include/net/xsk_buff_pool.h
> > +++ b/include/net/xsk_buff_pool.h
> > @@ -102,12 +102,14 @@ struct xsk_buff_pool {
> >
> >  /* AF_XDP core. */
> >  struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
> > -                                               struct xdp_umem *umem);
> > +                                               struct xdp_umem *umem,
> > +                                               u32 max_segs);
> >  int xp_assign_dev(struct xsk_buff_pool *pool, struct net_device *dev,
> >                   u16 queue_id, u16 flags);
> >  int xp_assign_dev_shared(struct xsk_buff_pool *pool, struct xdp_sock *umem_xs,
> >                          struct net_device *dev, u16 queue_id);
> > -int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs);
> > +int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs,
> > +                     u32 max_segs);
> >  void xp_destroy(struct xsk_buff_pool *pool);
> >  void xp_get_pool(struct xsk_buff_pool *pool);
> >  bool xp_put_pool(struct xsk_buff_pool *pool);
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> > index 43791647cf18..385a3f4a1b32 100644
> > --- a/net/xdp/xsk.c
> > +++ b/net/xdp/xsk.c
> > @@ -1525,7 +1525,8 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
> >                          * and/or device.
> >                          */
> >                         xs->pool = xp_create_and_assign_umem(xs,
> > -                                                            umem_xs->umem);
> > +                                                            umem_xs->umem,
> > +                                                            dev->xdp_zc_max_segs);
> >                         if (!xs->pool) {
> >                                 err = -ENOMEM;
> >                                 sockfd_put(sock);
> > @@ -1557,7 +1558,8 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
> >                          * utilizes
> >                          */
> >                         if (xs->tx && !xs->pool->tx_descs) {
> > -                               err = xp_alloc_tx_descs(xs->pool, xs);
> > +                               err = xp_alloc_tx_descs(xs->pool, xs,
> > +                                                       dev->xdp_zc_max_segs);
> >                                 if (err) {
> >                                         xp_put_pool(xs->pool);
> >                                         xs->pool = NULL;
> > @@ -1575,7 +1577,9 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
> >                 goto out_unlock;
> >         } else {
> >                 /* This xsk has its own umem. */
> > -               xs->pool = xp_create_and_assign_umem(xs, xs->umem);
> > +               xs->pool = xp_create_and_assign_umem(xs, xs->umem,
> > +                                                    dev->xdp_zc_max_segs);
> > +
> >                 if (!xs->pool) {
> >                         err = -ENOMEM;
> >                         goto out_unlock;
> > diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> > index 1f28a9641571..12c9fb29af05 100644
> > --- a/net/xdp/xsk_buff_pool.c
> > +++ b/net/xdp/xsk_buff_pool.c
> > @@ -42,9 +42,12 @@ void xp_destroy(struct xsk_buff_pool *pool)
> >         kvfree(pool);
> >  }
> >
> > -int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs)
> > +int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs,
> > +                     u32 max_segs)
> >  {
> > -       pool->tx_descs = kvzalloc_objs(*pool->tx_descs, xs->tx->nentries);
> > +       u32 nentries = max(xs->tx->nentries, max_segs);
> > +
> > +       pool->tx_descs = kvzalloc_objs(*pool->tx_descs, nentries);
> >         if (!pool->tx_descs)
> >                 return -ENOMEM;
> >
> > @@ -52,7 +55,8 @@ int xp_alloc_tx_descs(struct xsk_buff_pool *pool, struct xdp_sock *xs)
> >  }
> >
> >  struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
> > -                                               struct xdp_umem *umem)
> > +                                               struct xdp_umem *umem,
> > +                                               u32 max_segs)
> >  {
> >         bool unaligned = umem->flags & XDP_UMEM_UNALIGNED_CHUNK_FLAG;
> >         struct xsk_buff_pool *pool;
> > @@ -69,7 +73,7 @@ struct xsk_buff_pool *xp_create_and_assign_umem(struct xdp_sock *xs,
> >                 goto out;
> >
> >         if (xs->tx)
> > -               if (xp_alloc_tx_descs(pool, xs))
> > +               if (xp_alloc_tx_descs(pool, xs, max_segs))
> >                         goto out;
> >
> >         pool->chunk_mask = ~((u64)umem->chunk_size - 1);
> > --
> > 2.43.0
> >
