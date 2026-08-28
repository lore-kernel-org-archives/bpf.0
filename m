Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C4370ADB;
	Fri, 28 Aug 2026 16:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787935270; cv=fail; b=sWAaHK4xnqnY1slt+Aq21BMPGImw+GqjAmzL5CUJeFXjv5EeIuijeXAZujdUPdLR7x1egyR9ojjhQsMCozQF6K76wUcQoywPwLJvxsw1UdmH/Q+s2rR5h0Y+jhjv/NQehM1Vo7kAV6ZcFZDxT9FwaCSQUlnbguTB96LSlBkpv2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787935270; c=relaxed/simple;
	bh=HDaJb1m25a/d3xfRA4wQUlw8sWQoJcFwSfGJwk4XUzY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u4V8Etjtg44653kBoGmuAd0DQxECiXLi9CZ08UJLu2B/4plAdNSXb7uOFwi7emFsmYnSZyqNrBOWTSWqoPHDyxTARj5sWVaKZnf8EzY4YesNME91roLW0AqwUXeHLXPWsHq6bVHTZYFyj+etPNkTsiXWjN+lx/GZKN2UPBTGrWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ekn4NoAp; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ekn4NoAp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787935269; x=1819471269;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HDaJb1m25a/d3xfRA4wQUlw8sWQoJcFwSfGJwk4XUzY=;
  b=ekn4NoApKHcF2GicaM78/kuZ3uDux72UMmqfp+LTPy6nQqPIJdqBpgtg
   SiAfKtifjDiSOJMW3X1pxlWjNG2+G7E3LxreWOQFnrN9e2hBAIMiyCJrc
   YK++cAUu0W4SZB0eLfaeneh7kSaZXUvMhRCIDrHK2mK6d4puITe2nIxXS
   c3osAKL3kFdi/GouPESwE21Q0fGah1rT5H5plwm7NuKSamUHf6b+NJWTi
   LKMYT47owOGr7ORMMrXGiPLxrl8KnA2QqptAqGZ67Xb3zpY0IZs9lKB+2
   Q49oczV+5XHjHFfPrtoeglgEKUZULKjFvuZFTfqwFSuOlPdarm9cRPqp1
   Q==;
X-CSE-ConnectionGUID: NcZNoxq2SXiZeWei1b+msg==
X-CSE-MsgGUID: wjOED3pNQUifiT3MnMR+1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="75993111"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="75993111"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 09:41:08 -0700
X-CSE-ConnectionGUID: fhK2NxsRSe+dwk0KhtHq/A==
X-CSE-MsgGUID: NF7LhHy4RkueDZcVi0B7pg==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 09:41:08 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 09:41:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 28 Aug 2026 09:41:06 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.46) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 28 Aug 2026 09:41:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cg0F3PI1sWwRvX1I2eJutWJqEiHcJZNGRr10WEmqdVmf2at3Mra3o+hDobBwdhSrToOtYo3AeRPiAmUSZGiNGEoDGPiofHgE5jVZNj8vM0VMdZLA+lsUU7ErzzQO2cKeEhK/W4R0T1j4hjL3k7JhrWxtYTPpEHBDkZOSLrHQ8QnxKSR476SZ6K/AIiU8Epy30QJxI8MG9vD79KQ/LaPfDueWOoC8W3JrSs552auO7wXvNKY2RGA9NZ2Jq7VZuu9Hq0sMjmVFwzrda78naFf68EqvYATMXrKDo23A3zoW/OmwIG3icjnAfuXOpkhjHru3T9hRG/l3gaIWGKjtSAvDtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEtHApf00HDzzdbGONy9QJxR40bkAXWT1X27JAiQbjY=;
 b=d0u0zwU05QRWPteyPKVOEynBqYuE70feShAYZdXaBXFbjlR9OS/YOKdXrCq5KChsED5bl44Bf/wt7Uf+uIuwK3fy/GsjM4+Q6eBwssNOfySzSe+6IhrjVPCVzToHqyyJujPaoYNLHHNy6DYPTDrcEgQ07cJOIS+fG0XUtarjdyDGkE3WMDVDQJwNt3RikcRhZ0u+lxno7uDgrc8AsLPhft++fE8N20pt5TToMFEMVS/Cjb8WHhd43nSRrEDVtpjKec3BY/gLG4tVO7fjSE2NkDH0TuFD/PKW63LUnClx56YcWBEzB+TDBu4IF+ANtLr7lVVVE7PiDEPc+deqQyL1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS6PR11MB400772.namprd11.prod.outlook.com (2603:10b6:8:528::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 16:41:05 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 16:41:05 +0000
Date: Fri, 28 Aug 2026 18:40:59 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
CC: <netdev@vger.kernel.org>, <andrew+netdev@lunn.ch>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <magnus.karlsson@intel.com>,
	<sdf@fomichev.me>, <bpf@vger.kernel.org>,
	<syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com>
Subject: Re: [PATCH net] ipvlan: unregister upper devices outside pnodes_lock
Message-ID: <apG6GyB1uzXpmCiO@boxer>
References: <20260827132133.439890-1-maciej.fijalkowski@intel.com>
 <CAAVpQUC3w4b5KG+YGrK7bDNoaL-RPpmEu3FVJiyzWPewoJt2=g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUC3w4b5KG+YGrK7bDNoaL-RPpmEu3FVJiyzWPewoJt2=g@mail.gmail.com>
X-ClientProxiedBy: AM8P190CA0024.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::29) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS6PR11MB400772:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df8e264-b69b-4a92-a3f9-08df0523271f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|6133799003|22082099003|18002099003|5023799004|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 4pZ6WCBa6BOCNUQJqsf9OyBNaLobHmIx/VMSJQVcnvTKWO7mVjtf/h6ijIyvdhBJxoh97DyX1CpUpZBy+LsYtORLj8RhhlDae2iOHu861pVMwPo9cE70oqoKKm32qHqQGgI+D0Eee6mv25SFmvn2KYJfHJqaFRkEXmH7e6iTwb37J5uJrGZnTi0dD3AsAljCf1yMT0aKNZ/YCCIvaUAKLZzRkrtHyQW+IRIUO8J7sLteQZmtQDXvHUpUWoadP2I76BTip7SnoMCwihMmxGN2YvHDEWowVmHH4VesouzaNMBgi9TDpiGLB8x+tLbQrPrTwR26nW3K2VoIzQPghzXwXWcHmreOuNS6//bvETnJRegDvGyV1S/+7DuIhAv+tmZnl3+KmuXbvsQqXMBPc4xPfxX4aYCdSTlrsKvl2+sSs3FTZRLG85XeeMGMuVER0onkdTKAgmND6azQMiEZP/Ec5q1tuYM2g/edEgDjPcSJTd+7z6KmlUmdptA6cHsVelev0rG6ACIA3JUYWgWaAIfTwEkXfPqSCAvT0C2psVN/pKoKAxvgbdJDICpoVICzY17sYC49qEcyY9H3iVO6LbihemQNCu5O+hRjCHNbdvFmVfgN7o7a9EcYjmr0eK3NI0Ev
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(6133799003)(22082099003)(18002099003)(5023799004)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHdOKzUzaVF0UlNuMWNiSjJOMEFoMkEyeS9obFJJNnNuVkNBUm1IeGtnYjhX?=
 =?utf-8?B?RTlhL0xVVXdkc2FCZkFwRzcxRzdvUC81MVMvN0M0Kyt6K2RlNmw1TjVoVHhv?=
 =?utf-8?B?dGNKQUJhT1YyREJiUTcwSmU2TDkxZVgxN0VOaG5YdmlXdjNTNzU4YTJOSncz?=
 =?utf-8?B?SVpqWFhDYmZCZ3o2bWxHUHgwL3gyQ2ExTGFtQytJRi9iNkhuNkVTbitxS1dG?=
 =?utf-8?B?OEpMc0U2elE0ZWc4UjFjOVVlZkJZTnRTOGdEeUpJRlJNMnk0L2VvbDNRUFVy?=
 =?utf-8?B?a29taHhhWHRqOGwrZUNHTXpXVi8wdm92NVc5Vm1jRk90b3drY0ZjNjh1bjlO?=
 =?utf-8?B?SVZEYkUyTFNxYm95TzMzbTcrOTMyWEtxdlFmOHZob0JWTDA4RjROdmkzU2Vv?=
 =?utf-8?B?OXo5UU9VWjl6VGJpUGRnaVVwU1JoRytpN1h6Z1hXRStKQ3U4REZXOTlvNm44?=
 =?utf-8?B?cFV1UlZzWnd1YjdCUDB2R2h1VGFtWmg3UmVlRld6QUFoTWE4WHMwUi9DeVFJ?=
 =?utf-8?B?WnZHczRjQk54czE1SmFaS1YzejF2M0xJTEdTc0hSNjV0M1FxRW9jOWhwOC9T?=
 =?utf-8?B?R3FmWmtwRkRlcitjR2E5UjloNUtYUnJQSldhTlhEa3NIMlNOUkJLNUdLL09I?=
 =?utf-8?B?b0hVZFBQdUNVS01KREhpWGpWVjBaR0dtZ3JZNVFpL1BMa0lpMXdYOUhmUnNh?=
 =?utf-8?B?WDQ5S1orb3BvUFlJb0hTSlpTMXdXaGt2U3RtOHhNNWlTN0dISnFWU0UxSTRX?=
 =?utf-8?B?MmZlUDZHbHdNdG12TlZUOTA1ZFFwR2NCSEdVYnpIV3dvN3ZUZ2psM0ZJZnVL?=
 =?utf-8?B?WnhKQjJLdnc5bVh2L0NPdFIyY0REZHBsL25IYjIvdUQwWUErSUwxYmNiNnpG?=
 =?utf-8?B?WmsrK3NhSXB6YUQrU3I1Y2xTcmpjQ2lXR2F0QnBDNjJZMEdHeHZRaTF2eEVh?=
 =?utf-8?B?V3RqVnM0eFFZVUVBRGYzRkdMV0pYU3RwRndSczNMdVdpT3VjajYzYnhpTHJG?=
 =?utf-8?B?V2tOR0xJOEg4UWQzU01hYmUyRkpPUVoxOGdkU2pVTnhBVXlORXRqTlhBT1I1?=
 =?utf-8?B?cWdSUlR2d1Y4clFlL2hGeE5UZEZkMStYa1psYWcwNVRES0ZXVStnZy8zUkNh?=
 =?utf-8?B?bW1wd1oyQWRmVXlOVDJQQ1BWSkc1SFVLcGV0b1F4YXgzcjZIbGNqOWNzWm9a?=
 =?utf-8?B?U2RtSnpZVDE0L24vMWw3d3ZGcDAxUFFIaG95eWtVTDR6WDBRd3k2SFhhQVhK?=
 =?utf-8?B?SGZtYk81T3lRTEdYbnptem10UHJieGUxUm0ra0dkN1hKaDhhNVpCa1JqQzVB?=
 =?utf-8?B?MVpNZitBRTlpVlU2ZGJZM1ZGaVZPcHJCYmZNdGZzUEZOYXE5ZzRrMjZzV2Np?=
 =?utf-8?B?TyswUXN0SGFPTVZQMVliRXM0dll4VDVlMmkxYlZqUG0zSXZOcEJvWDhlK1NK?=
 =?utf-8?B?YlVzS0N6TWxBYXFmdUhsMmFtN251eWh3NEVRTlVDZmZGN1d4VnBtbDBFa2lp?=
 =?utf-8?B?M3hkRWNuN0xFRTlYcllFMjNuNlo1bERhNlNKSHZsZDlwK1ZoTEx6OG4rRk5T?=
 =?utf-8?B?SEJ3SEgvVDgvMDlsRmJBVWhwWk5VZ2t2RUlBa0hCdFExVDFCalBZVDN3NEQy?=
 =?utf-8?B?cGlyVFYzVHIvWVZrUjdYeEx2TCtzMFNZSnc0Rml4OElGQTNKVmlsS25COXRn?=
 =?utf-8?B?LzFxVDZvWURlcXpPMWhyckdINzJvNnpxTmg0c3dDdmtUYzN1andpWENLajUv?=
 =?utf-8?B?R3B0cldzdG9zNVpKM2ZqL3k5Ri9GQW5mUlRUSHMxOGdpT1hXV0JDZldYVUFp?=
 =?utf-8?B?VnVlbUg0VUhucDlyNERJOFJWMkF2Sy94bW5oRTdTRHBVTEdVNkNxbUVrNml3?=
 =?utf-8?B?K1cycjI3N2VEV0dtZWtwWGVhN0U3ZFU3OFZ0MmxsYjJib0J5UHN6dmdYY3J0?=
 =?utf-8?B?ci9mQktQejFBZlllN0tEQ1J5K0Zvelk0Q0Q1M09haTNDckFvOXZtb3Q3RGY0?=
 =?utf-8?B?c0ROWEwvQnhYMXRJcHVLTkpSbWNyeFpzcVVEQXBQZkdCMmlMUFdWRjg1MjZU?=
 =?utf-8?B?bHF0L1FMS29OTVFkeEd3ZEZvQ0xFWUlrQWo3TndQOUxVcXRDQ2YrdkY5SVk1?=
 =?utf-8?B?YUxJSGV2elZ1bVBZdm81bGxweHYzMWZ0aE1sbkdTSjJzWkZGMzljcGV1VUdD?=
 =?utf-8?B?Q1hVQTNNSTcrR0laeWcwL2RZNlQrYnBHRkpObnpaUjhoSEZXQWR2ZUlXdGIw?=
 =?utf-8?B?S1dpeUhMOHY3ZVVwbUYvUnpMOW90MnVxODRrMldjODN5MEFkSTJNZkk0SnJs?=
 =?utf-8?B?dmxxZW9qQXFUbDR3aDJlU3QrenF4MDR4WXloRWphamFOZnV4andyYmVFRWhJ?=
 =?utf-8?Q?Yx5AOzkZ7TGu8fX0=3D?=
X-Exchange-RoutingPolicyChecked: JP4Bo2M77MDF4v6NFbBHL5Gc6jQ0wxVeIUHoVyJdAb8DGaxdkjsppHHQSUX8/TgEtZIR82de2o/X7vmpQeE1vfCPBeZLZ6VNzseo4S+B8w5iw9FMS/fcULvIdN0VJmxZtVGvVSW/giH9vp4vm4TgZJzMAa/M51glVf6ltFQKQAC1vbR4kiBvBUEzhhO0hn4dIsc39X2Oz11o/EpW+hccejkzbmbmaB9uAiQLLVdRMqa9GZbmaPjtPsy1RrR8vvp9aMw4nNko6NIfdFmA/xRj3LixKse0WOP7HYxLq0GExcXkep2+lE8fwYl+jfQN2FHaEvhyUkdUFOJnjBudzoGCkA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df8e264-b69b-4a92-a3f9-08df0523271f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 16:41:04.9504
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: st6nP1Hkzqe816PIBB1EYLSciyviIvcD7PwIr71k8MpOG88pmPR8PGiMSET/oCBwMCdTaWgrvJ5uhNJGlG454Cmv/SZID0tjt5EyuoMxeEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB400772
X-OriginatorOrg: intel.com

On Thu, Aug 27, 2026 at 09:27:06AM -0700, Kuniyuki Iwashima wrote:
> On Thu, Aug 27, 2026 at 6:21 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > syzbot reported the following circular locking dependency:
> >
> >   xs->mutex -> netdev lock -> pnodes_lock -> net->xdp.lock -> xs->mutex
> >
> > The pnodes_lock -> net->xdp.lock edge is recorded when
> > ipvlan_device_event(NETDEV_UNREGISTER) calls unregister_netdevice_many()
> > while holding pnodes_lock.  A nested NETDEV_UNREGISTER notification for
> > an IPvlan device enters xsk_notifier(), which acquires net->xdp.lock.
> >
> > Keep pnodes_lock only while marking the upper devices as dying, removing
> > them from port->ipvlans, and queueing them for unregistration.  Once the
> > devices have been detached from the protected list, release pnodes_lock
> > before unregister_netdevice_many() invokes notifier callbacks.
> >
> > The port remains alive across unregistration because
> > ipvlan_device_event() holds the reference acquired by ipvlan_port_get().
> > The dying flag prevents a concurrent ->dellink() callback from deleting a
> > queued device again.
> >
> > Fixes: 35add1093e2f ("ipvlan: Protect ipvl_port.ipvlans with mutex.")
> > Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=aa48b5fe7bfda62d1682
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >  drivers/net/ipvlan/ipvlan_main.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
> > index ee46a55f73d1..2730581e0a56 100644
> > --- a/drivers/net/ipvlan/ipvlan_main.c
> > +++ b/drivers/net/ipvlan/ipvlan_main.c
> > @@ -846,7 +846,6 @@ static int ipvlan_device_event(struct notifier_block *unused,
> >                                 __ipvlan_link_delete(net, ipvlan->dev, &lst_kill);
> >                 }
> >
> > -               unregister_netdevice_many(&lst_kill);
> >                 break;
> >         }
> >         case NETDEV_FEAT_CHANGE:
> > @@ -895,6 +894,10 @@ static int ipvlan_device_event(struct notifier_block *unused,
> >
> >         mutex_unlock(&port->pnodes_lock);
> >
> > +       /* Avoid invoking nested netdevice notifiers under pnodes_lock. */
> > +       if (!list_empty(&lst_kill))
> 
> nit: unregister_netdevice_many() takes care of this.

...right. I'll send v2 without it. Thanks!

> 
> 
> > +               unregister_netdevice_many(&lst_kill);
> > +
> >         ipvlan_port_put(port);
> >
> >         return ret;
> > --
> > 2.43.0
> >
