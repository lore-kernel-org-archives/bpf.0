Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792582260;
	b=cImBiPGJ+3Qc8trAUH01COP22MdZUT77jz/sxYC2zvtB4EA+mw8vzTkAv9SuU+rW7bFy
	 TOfDhOVaGsBNGxXpT5+FFOQnoubsMizB8F09WV5r9QcQ32avUEVKPFX8+tXu24oROXTaU
	 f6ENJ+UAIGCfTkVsA8AmyMt5rKY/BHggGFnvRfnMnMd4YD4qAU7PWD9pikgsHfjGxPnMZ
	 /xmblz044v9XxfyDIYWuH8YuQrlJU8jYzWrX5lZIYkm2VOnWXiGsnl02gp5tYhZfrsqkb
	 wfJXBU4qq3cbd4W/w+zwAwQGkY9PzeI0h4Qqw40iGZLAOGeW1cZo7P1s7Xfd0yWZbbA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792582260;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
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
	bh=bGLEYmI4aJ1ycz3XGX+S3oaNoSKWPFLJDDG54wmf5vc=;
	b=310DuIfGGV4IrewkrbUy4065PKQgLtLNXDPfJxQo/fJvlimNukJMFwFB6r2jDFPqDnJB
	 VOH24HKIxi6pmnb+B2pijQcYHAt10rQ3R/PM7j8lV4LqWm5NZR2X90Nm+K2/m2QW73T8f
	 qdTw+2wGJbTdeMeueHWLU0Wz9JTpux8vb7mziCkQ8V2iVo7L/ADvDjXv+yPY9gOIrlkmq
	 6y+gMVKim/VHrgqR6zyZPPXSHCg8rTzIxY24NJXMOxTzH5/plHyxPaw3ZslTOWUqNcnc0
	 uZcVp0axWIK7K4BHWWphh+LPnpj0KksCTXvfgBfXnYx559XQLch8hML8bRA4yAmyD0A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y5cg6RpP;
	arc=fail smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1261606A319;
	Wed, 21 Oct 2026 11:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1261606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y5cg6RpP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792582260; x=1824118260;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=jPyrgAk2uWBFEq9uMam0KUJ33i/8XQ6NoE6HIYlj/sI=;
  b=Y5cg6RpPgMjuAdBpz7Ili+qL7q+YVi/hoL54qyCb57APc4baeVbXA6pH
   q72qRLq7jUzWP9jM74SMLGXL5bSu7fN3r2WJBdbyyLVKH6OqxesxuJ0N3
   G05w/8GRXf2hkOtduZj9ixvJC7gdY9JT7wX8JXayELTF7l/4E6o/Te5t/
   3gWl+8Ikqs+6FRG6EhBgah/gQdAh1zEjkALrqCVCzeU/lTYARz5JtoiT4
   6sELBUlOF2wRNnxj36tyHpJvyEN9cZU6ZWdoYjbk4dIK2s0xrsnTNd8Es
   5JgRPFAhJAQA+osnbSWuDpVEClydREp02xJn911YOW9uPdFV5ljSp08G1
   g==;
X-CSE-ConnectionGUID: cGlz5U4QT0Ce6DqU526gZg==
X-CSE-MsgGUID: lE29pRydTv+h+DvR8+Cn3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1335977"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1335977"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 04:30:59 -0700
X-CSE-ConnectionGUID: AJdp0zPRRtelTqLDlexJww==
X-CSE-MsgGUID: yodd5OxZQP6H+KJLVblsTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3132872"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 04:30:59 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 04:30:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 21 Oct 2026 04:30:58 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.59) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 21 Oct 2026 04:30:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGpruCtgrXfg7CJa9ShBfSj8/wfiVH7Hr9tBT6ldlSPKqE0Tpj46iqeJ+qJqJaiRTqua0veBq97dGm55ZY8LXVaRZl62HAo+mCim/oe4FZx0puMtvCUKeT6PIbECtY0tjbeUAdSQZ3Z/lSDaWgX9VdFqtVJ8w9XOA+WCE7vwjXNl3kbHdQOJOE66U4jHp+dBUHsnx/oks0K3G04VAkAySr3cYvvpYiTT0OAgU8cNTyn7nT+B/iRqk8z9KUluEi9JZ6Li8XudKnUjeC5SAU9m5dOTl4S61Avbc8TTkb5rE4EneUqsyMcjsYO01AHZgzHS4fBfV6HwPyGWelfxypwgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGLEYmI4aJ1ycz3XGX+S3oaNoSKWPFLJDDG54wmf5vc=;
 b=K47b3rhILOqz5mc6y1j9FXfjdQaW17bVXN2hb6eyoOx2SmeFbbQkUtCSdw2bSHQ/Muph+olDdZpMs1NvAO/3bnoygsdlsYJkuDIntJ77jToIMi8l6Hk/Ai5ujjILcLgDX8KECW4Z+tAvvjXFCDGUf1mCwgTL94bO2Nuem9nd6jEH8FA0Hk23bIbPulOcbHLjSkGd+5IcjZgJUJhgpviMNbyATitltKJ2wl+t1aEhqxIKppaxSdKkM+TRcKs72TbIWsAyVzub/vKJSIlxpwdlEQIpVM+eHu5jvUD5mN084wejr0Ca+pt81e1KBWE7ljh1hOr/Z497Pcw42P6mzw8cmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH2PR11MB8816.namprd11.prod.outlook.com (2603:10b6:610:285::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 11:30:55 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 11:30:55 +0000
Date: Wed, 21 Oct 2026 13:30:48 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
	<kerneljasonxing@gmail.com>, <bjorn@kernel.org>
Subject: Re: [PATCH v4 net-next 11/15] selftests: xsk: send UDP over IPv4 or
 IPv6 between the interface MACs
Message-ID: <atiiaDMTs5LXdsOX@boxer>
References: <20261016174338.787135-12-maciej.fijalkowski@intel.com>
 <179252462780.3135.9133783864572379009@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179252462780.3135.9133783864572379009@kernel.org>
X-ClientProxiedBy: WA2PEPF000008BB.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::686) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
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
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH2PR11MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: 43354657-eccc-455b-5a4e-08df2f66c532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|6133799003|18002099003|10067099003|22082099003|4143699003|5023799004|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: BempEXzNeGtd69OVpokqLJUjNK/gWJbajJewvD5fP63AxhoE95brpKMAXNjXAQlr6Wd6UvQZDFdG4exZIL7DgbT225R4cQoRwAlRdj5HIFknRjLJo/gi45PEuQBpRi0hkkksueocVIeUxf0nG6kVNiCN//xTJkBCNqYrHOQDtEVxwSOZgp55w1DumqB8K1idooslrzfZ+LTZM33Q+KUins96xizk278cjXoOnczSDdCUDv2/JG7xcA3xqyMNbWeSxhJKtvtLnSpp5tAwHd5KpmsSp92Baczs2dy7x9o8ODy1fNjobRi3eVVe8kp80AyKJpznMaFU5iV6Igye7WG4sfVALs7kvIx5KiPeJi9lSsSQLgKgB+gVlMIZS8pf6NnAA1jTwO2HmKzm71hHTw8x9wXHLWAQVIwENR/FUBO2Usflc0NlT30nNNa2NCb26aGiIctVBldSx06b0l0/w2FVJhlIWCCe3WE0XZQaY50IAyndaAOe4iTBwM3S2FUrYH/IrInFTWbaTb931LuD/nPJtGi9iTxk1DpFqBO+cxrrNc3tAGRcN7iFD2CvsGOKSsQQ6QqTHLS/4o+Vb4xAFptMn3yohLyI9QZ6Onl80I/CbOw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(4143699003)(5023799004)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWZsWFFZMEI1bTJ2T084b0RUU29Md1UxUllxUSs4Z3lYQ0MrSWg4YXJGMzRq?=
 =?utf-8?B?V1ZROWJIUGpzZGpyMmlEZDJoVEs4ZHc1UmNRalF5NG1PVkExUGxid1NwZVU1?=
 =?utf-8?B?L0dXdkxQelQzSmZ0Mks0TVhKUE80L05LcHpxSFh2QU90eWtFd1ZZSHQ5S0xN?=
 =?utf-8?B?bzQyaDc3TlpBbzg5ZXF5VEV4WngwSXV6dTBqNnJUTzNycTRiajYrcUw4emRK?=
 =?utf-8?B?ZVJIM2FoQjN1eTZjK3V5dlJNNjFnZitEa3VpdlFHMkRTNC9PUmlZNUM0cVNH?=
 =?utf-8?B?dEJmZk9rRS8xWU5SWUE1d3pvUmJNVC9pTERMOTQyUkZRbFE3MHkrOWcxbkV6?=
 =?utf-8?B?MHM2UHJsUXp1bVN3S1VqdlV1VEhNTnpQUDUrUlZuUDAzMkd1a3pXVzJCMHdY?=
 =?utf-8?B?anUyTWxXQWxsWlFhZzVNZGZuMUxkdlh6TXlQOVZpU0wzeDdRYW5nRnNIclRl?=
 =?utf-8?B?V3B3WFlNamY1ZHc2bXJxSzFlcUpEZ3Aybkt5NFI3cnBsOEdmalFMSG9SQzV3?=
 =?utf-8?B?aUd1M2RqMEs0ZlhGeGEwRVNiZWRYMnBOSDNCM1pSdXFpdDlCbVhaalFja3Rv?=
 =?utf-8?B?UWhwM3Fvc3h2YzNhRXF0NkcrcDhLMlNVZ2pkNEc4eEZ6cmY2Mlo1MHYySjda?=
 =?utf-8?B?SmszVjNpRnJmanphajc3c2lZLzZwMGVobi9jcXE0ZSt3NzRYc1JNdW40WUNl?=
 =?utf-8?B?eHlNS3NodUR4a085UVZKV1cxYnZvNkcxZW4vaFlVVDJ6MW5WZHQ0bHhCeG45?=
 =?utf-8?B?d2xHMmJmYUtCQVM5RDh6R3VMVU9IL3YwaWJ6MUdtbGtYVFEvQkNmZ1JuM2Er?=
 =?utf-8?B?MWdkVXg0dWZaMXZ6dmVCUVB2OUsxVkY0WHQ0QXQwQ014UzIrblp0Y0FzakVR?=
 =?utf-8?B?L2NRbU9HRXI4Wk55TG1PK1NKNHUrT2pwUTlpV0U2azBKcHN3dnhKSEFhMUpR?=
 =?utf-8?B?ZmFJeE5uM3F3a1lTbE1ab21KbFRxYnZSeHRCMXJjM3FOSVN1RnpCYnhjOFhR?=
 =?utf-8?B?Z2ZxanZsYVhBQUhVbyttUEVrbFFhOFUzRHdWcmd5VGJkQWxmSGhpY0ZFU0Ru?=
 =?utf-8?B?T3VNSnpNNFVGUkl0anVXUlZjdXFuRDF2VTZNaVZHcEZ1Y0lhV1F1OHdUZ2Rs?=
 =?utf-8?B?RW1WdUM0VWZhMFZmMEZSem9mNFlCbkwyV0RGMnlUZjVzaFpmeEdlUHlKYVVR?=
 =?utf-8?B?Nk16aGhDYjdZeHlFQjl4Y1cxZGlVZ2FBOXRKelRPeU9PN3FFSGlqTWtxVXBx?=
 =?utf-8?B?YWUySGt0YUx2cmtkQUlFV2tRcTFsd1N4MEhicDZZaVNKZlFLeTVkYWFEaDN6?=
 =?utf-8?B?U3JveEZpTVFkZ3BNL3p5NGxoeVJwN0pGbnBUODlZeHR3NDZUT2NKR24xQkZY?=
 =?utf-8?B?U1JneEQyTFlpQU42SGpVSWpJcEtUNXY2QUttMFp4S0hsVnZ6KzQ3MWJJVVdF?=
 =?utf-8?B?eU12VzBJQ0tSUnRXV3Y5dmUxaFA0bWdoZGgzVUxUbnB0T3FDaDgrb3lZR2NL?=
 =?utf-8?B?bmJvYzE2QXVJREZTQWVVV3l3VHltTEtTQzhuckNZOU9aMjcyR1B2M04remZC?=
 =?utf-8?B?cmRFR09pbGdFbFhySVBaOFA5RFgxVnczQU9iNEswVm1UUmdtcURFQjRFVEJL?=
 =?utf-8?B?dkR4ak1sMkttMUxvb2R1V1ZMMTg3VnhFeFdRMU1WWk9ySWJRb0U3eldsM2Zk?=
 =?utf-8?B?NXd5MDdiNDk2eEVTblVYeEVPRmhBc1VnUTFrMnpiUmJaVHpJb21URDd4eVRq?=
 =?utf-8?B?ZzN3ckNva3RQUkVOSHcwckVvMmFFVmpQdEw2SGp2VjZFaXFsUTNZb2RSa3M4?=
 =?utf-8?B?VXRPK05YL1ROTEYzdlJ1VU8vdmhLYTh5REo4WG8zRzQ1OVp3L2JGVndUWkhm?=
 =?utf-8?B?N1U5OXpIdXJmOUE0YTM1eTVqcG1YZlZTb0NyTEFHQUU4WXV0aTdMZjJJRm9j?=
 =?utf-8?B?TGlaZ3VhYTlRU3hVUHdvT0tIdWt3ZHo2aVBNUEY5aXVrTWNJUzVNSWZ2aGkx?=
 =?utf-8?B?V2NOM2EyalVpbFBNeHg2VlFLd1NLOVljSCtqTFAyTUx6NXM5TUZnRXp5cWo4?=
 =?utf-8?B?d3JjbVRlQjRlSmhlWEFzcWRhTEhLaVF6RXEvVjgrMFVWbGRvY2Yvd3oxU1lJ?=
 =?utf-8?B?MlFIdlFZVjZWenVMUnRIeVZRQ2pvcjhNNFNuOFdQQjI2YWlxVDd6WFJVRTl5?=
 =?utf-8?B?UlF0Kzg0dEhPSUo3MmFqVEpBVHRlUEEzNDA2d09MZ1AxY0F4U0ZQZlpFV1BO?=
 =?utf-8?B?WUZBUVFmUFdncjM4Z3dTeERiTURBazZBNmxOUWFzRGFRZW5PRitqYlVNaVZz?=
 =?utf-8?B?am1EdzF2czBIK0xYT3RJOWhtWkl0MlVXdi9JRzM2MWlHZmtpZUZrMnhxUEFw?=
 =?utf-8?Q?XYCWqwsSUGnjPLes=3D?=
X-Exchange-RoutingPolicyChecked: QM5/alcbFFB8mUP/giMMYBWsmswuj26FOd/vS+tIWXsgzZuZqgbZt425/YVUadyfKN1wBAl5nQbZIgjRkHn/zkAWhuWVnsxJ1GfN56nk94vUh5qWehhS4nhf4pmFqyF9bS2wSme9LruWK9RsOuj9OySY5QFKYaIttCHD75+GVqBEAORA+NQss+9PyhQD3luKKTkBvdOd0vB2sonfrbrTbtT7EKS6/Bf2GKVKTs5YnzA1kpNuBRbGDBijoO6FKwd+HGSgydCvLXgyPoSbVsOKn3b2wx6bGeakmp1UzW66cx+WNM1/pCCBhdkEZsgOPYDyRde3ZxVLCe0cHKh1Vapc+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 43354657-eccc-455b-5a4e-08df2f66c532
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:30:55.2684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrHi4imkginCSNjJNIe0ii+wOAeVkB8fu0fcBGsyRZne/wmlPmt4IZ7d7OyMJSu8/kQ82fUqKerUpE2NS02CxShvmn4cacPcLr2KclOXCvY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB8816
X-OriginatorOrg: intel.com

On Tue, Oct 20, 2026 at 07:30:27PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 2
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The new XDP filter makes the INVALID_DESC tests less able to
>   catch a kernel that transmits a descriptor it should reject.

I took a look at reports on v4 and besides one above nothing major stood
out that would need a fix, imo.

This one *could* be a follow-up as a hardening of invalid descs handling.
Indeed it would be worth generating udp header on invalid descs so if such
descriptor make it to rx side it should be redirected to rx socket and
test should catch that desc and fail the test case.

Let me know if this set still could be considered to be taken in or I
should send rebased v5 once net-next opens.

Thanks,
MF

> - [Medium] (Baseline: not a defect, handled later in the series.) The
>   concern: on a multi-queue physical NIC, nothing steers the new UDP…
> - [Low] This feature commit, which changes the wire format, the XDP
>   programs and the CLI, also carries three fixes for bugs that predate…
> - [Low] (Baseline: intentional design, the launchers validate.) The
>   concern: parse_command_line() stores `strtoul(optarg, NULL, 10)` in…
> 
> --
> 
> selftests: xsk: send UDP over IPv4 or IPv6 between the interface MACs
> 
> This patch changes the xskxceiver test traffic from loopback-ethertype
> frames between made-up MACs to UDP over IPv4 or IPv6 between the real
> interface MACs. The XDP programs now redirect only UDP to the test port
> and pass everything else to the stack. The patch also fixes several
> helpers in test_xsk.c that could overrun buffers.
> 
> > diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
> > index ce88218fef00b..9c401a43da435 100644
> > --- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
> > +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c
> 
> [ ... ]
> 
> > @@ -238,10 +364,10 @@ static void __test_spec_init(struct test_spec *test, struct ifobject *ifobj_tx,
> >  			else
> >  				xsk->pkt_stream = test->rx_pkt_stream_default;
> >  
> > -			memcpy(xsk->src_mac, g_mac, ETH_ALEN);
> > -			memcpy(xsk->dst_mac, g_mac, ETH_ALEN);
> > -			xsk->src_mac[5] += ((j * 2) + 0);
> > -			xsk->dst_mac[5] += ((j * 2) + 1);
> > +			memcpy(xsk->src_mac, ifobj->caps.mac, ETH_ALEN);
> > +			memcpy(xsk->dst_mac, peer->caps.mac, ETH_ALEN);
> > +			/* xsk_xdp_shared_umem() picks the socket by it. */
> > +			xsk->src_port = udp_port + j;
> >  		}
> 
> [Severity: Medium]
> On a multi-queue physical NIC, what steers this flow to the queue the
> AF_XDP socket is bound to?
> 
> If RSS hashes L4 ports, the flow could land on another queue, and
> xsk_rcv_check() would reject the redirect there. With XDP_SHARED_UMEM,
> socket 1 sends from udp_port + 1. Its flow could therefore hash to a
> different queue even when socket 0's flow lands on the right one.
> 
> At this patch the only in-tree runner is veth, so nothing breaks yet. Two
> later patches in the series cover this:
> 
> "selftests: drv-net: test AF_XDP zero-copy with an SKB peer" adds
> drivers/net/hw/xsk.py. Its _reserve_queue() takes the bound queue out of
> RSS with "ethtool -X <if> equal <queue>". Its _steer_udp() installs a
> dst-port ntuple rule, which matches both sockets' flows.
> 
> "selftests: xsk: document generic and hardware endpoint runs" documents
> the ntuple and RSS requirement in README.rst.
> 
> This commit message is aimed at physical links. Should it, or the header
> comment in xskxceiver.c, mention the steering requirement too?
> 
> [ ... ]
> 
> > @@ -792,31 +933,12 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
> >  	return true;
> >  }
> >  
> > -static int is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx, bool *supported)
> > +static bool is_adjust_tail_supported(struct xsk_xdp_progs *skel_rx)
> >  {
> > -	struct bpf_map *data_map;
> > -	int adjust_value = 0;
> > -	int key = 0;
> > -	int ret;
> > -
> > -	data_map = bpf_object__find_map_by_name(skel_rx->obj, "xsk_xdp_.bss");
> > -	if (!data_map || !bpf_map__is_internal(data_map)) {
> > -		ksft_print_msg("Error: could not find bss section of XDP program\n");
> > -		return -EINVAL;
> > -	}
> > -
> > -	ret = bpf_map_lookup_elem(bpf_map__fd(data_map), &key, &adjust_value);
> > -	if (ret) {
> > -		ksft_print_msg("Error: bpf_map_lookup_elem failed with error %d\n", ret);
> > -		return ret;
> > -	}
> > -
> >  	/* Set the 'adjust_value' variable to -EOPNOTSUPP in the XDP program if the adjust_tail
> >  	 * helper is not supported. Skip the adjust_tail test case in this scenario.
> >  	 */
> > -	*supported = adjust_value != -EOPNOTSUPP;
> > -
> > -	return 0;
> > +	return skel_rx->bss->adjust_value != -EOPNOTSUPP;
> >  }
> 
> [Severity: Low]
> This isn't a bug, but this feature patch also carries three fixes for bugs
> that existed before the series:
> 
> 1) is_adjust_tail_supported() used bpf_map_lookup_elem() to copy the whole
> xsk_xdp_.bss map into one stack int. At the baseline, .bss held idx,
> adjust_value, count and drop_idx, 16 bytes in all. That overwrote 12
> bytes of stack past adjust_value, and the int got the first word of .bss,
> which is not necessarily adjust_value.
> 
> 2) is_frag_valid() did len -= PKT_HDR_SIZE on a first fragment shorter
> than the header. len wrapped, and the later reads went out of bounds.
> 
> 3) is_pkt_valid() passed the total packet length to pkt_dump(). On a
> multi-buffer packet, pkt_dump() read past the end of the first fragment.
> 
> The commit message describes all three. But because they ship with the
> wire format, XDP program and CLI changes, they can't be backported or
> reverted on their own. Older trees still have the original code in
> tools/testing/selftests/bpf/prog_tests/test_xsk.c.
> 
> Could these go into a separate patch at the start of the series, with
> Fixes: tags?
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
> > index 023d8befd4cab..2b55dbaf13b24 100644
> > --- a/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
> > +++ b/tools/testing/selftests/net/lib/xsk/xsk_xdp_progs.bpf.c
> 
> [ ... ]
> 
> > @@ -15,12 +23,64 @@ struct {
> 
> [ ... ]
> 
> > +	} else {
> > +		return NULL;
> > +	}
> > +
> > +	if ((void *)(udp + 1) > data_end || udp->dest != bpf_htons(test_port))
> > +		return NULL;
> > +	*hdr_len += sizeof(*udp) + PKT_HDR_PAD;
> > +	return udp;
> > +}
> 
> [ ... ]
> 
> >  SEC("xdp.frags") int xsk_def_prog(struct xdp_md *xdp)
> >  {
> > +	if (!is_test_packet(xdp))
> > +		return XDP_PASS;
> >  	return bpf_redirect_map(&xsk, 0, XDP_DROP);
> >  }
> 
> [Severity: Medium]
> Could this filter hide a kernel that wrongly transmits a descriptor that
> the INVALID_DESC cases expect it to reject?
> 
> Before this patch, xsk_def_prog() redirected every frame to the XSKMAP.
> An unexpected frame on RX then failed is_frag_valid() on the pkt_nb or
> seqnum check. Now any frame that test_udp_hdr() does not see as UDP to
> test_port gets XDP_PASS and never reaches __receive_pkts().
> 
> __send_pkts() writes a header only for valid entries:
> 
>     if (pkt->valid)
>         pkt_generate(xsk, umem, tx_desc->addr, tx_desc->len, total_len,
>                      pkt->pkt_nb, bytes_written);
> 
> pkt_get_addr() also gives invalid entries their raw pkt->offset. So the
> bytes behind a negative descriptor are usually not a test header. For
> example, this entry in testapp_invalid_desc():
> 
>     /* Straddle a 4K boundary */
>     {0x1000 - MIN_PKT_SIZE / 2, MIN_PKT_SIZE, 0, false},
> 
> starts in the zero-filled tail of UMEM frame 0, so h_proto is 0.
> 
> The "Straddle the end of umem" entry starts inside the payload of the
> packet at umem_sz - MIN_PKT_SIZE. The invalid-options and chunk-crossing
> entries in testapp_invalid_desc_mb() look the same, for example:
> 
>     {0, XSK_UMEM__LARGE_FRAME_SIZE, 0, false, XSK_DESC__INVALID_OPTION},
> 
> If the kernel transmitted any of these, the RX program would pass them to
> the stack, and the case would still pass.
> 
> The TX side would not catch it either. __send_pkts() adds every frag to
> outstanding_tx (valid_frags += nb_frags), and these cases don't check the
> tx_invalid_descs statistic.
> 
> Could these cases check tx_invalid_descs? Alternatively, could the RX
> program redirect or count non-test frames while they run?
> 
> [ ... ]
> 
> > diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> > index fbfff586e0e5e..9704702f60fc9 100644
> > --- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> > +++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> 
> [ ... ]
> 
> > @@ -293,6 +314,20 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
> 
> [ ... ]
> 
> > +		case OPT_UDP_PORT:
> > +			opt_udp_port = strtoul(optarg, NULL, 10);
> > +			break;
> 
> [Severity: Low]
> Should this check errno, the end pointer and the range? The strtoul()
> result goes straight into a u16, so:
> 
>     65536 becomes 0, which is rejected
>     70000 becomes 4464
>     "-1" becomes 65535
>     "123junk" becomes 123
> 
> Only values that truncate to 0 are rejected, here by !opt_udp_port and
> in xsk_set_flow().
> 
> With --udp-port 65535, socket 1's source port in __test_spec_init() wraps
> to 0:
> 
>     xsk->src_port = udp_port + j;
> 
> Both endpoints truncate the same way, so the flow stays consistent.
> xsk_xdp_shared_umem() still gets idx 1 for source port 0 through the
> __u16 wrap-around.
> 
> Later commit messages in the series say the launchers own the range
> checks. drivers/net/hw/xsk.py calls _check_opt("--udp-port",
> cfg.udp_port, 1, 0xffff), and test_xsk.py takes the port from
> rand_port(). Within xskxceiver, only --max-frags is range-checked, since
> it sizes an array. A hand-run xskxceiver could still quietly use a
> different port than the one requested.
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016174338.787135-1-maciej.fijalkowski%40intel.com
