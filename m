Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3514B4C680D;
	Fri, 25 Sep 2026 15:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349437; cv=fail; b=bcwX3mzAu3M3WipaR4A8RR23UO9hO3gHGPcSGXZ/CICQCZK1WbSrfesyQ0Z/F3ziYvk5J2vFDoma8680A+TVNPbjOuRkmLA0U39LSX8/KCyuOwEcCcVL9oZMDnuQEtz90yvfKRqiGeLfof8pOgm2TNCl/31BhBi7BHe1p4Cd4Gk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349437; c=relaxed/simple;
	bh=+Wz0fd9zRWn9HBctAy/PWe2CIX2LuU9FIsYEMPwdOj4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hhdqUqHtAWDoL5QT9KS1oB1jp7AROtK8FVqjo/G43Qli2mErf2VIPbe/wpEoAmpOrfe6sPoA84R5Wo2v7lqazVQtjTjJcHLquwI0VvaYyZ836JdCvGuQxqcj5wsLdmgBVyw8Ek64Ri1SZ5zZQvJyYiNmY1/orENI04D2uIAZL78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WBUSquig; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WBUSquig"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790349427; x=1821885427;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+Wz0fd9zRWn9HBctAy/PWe2CIX2LuU9FIsYEMPwdOj4=;
  b=WBUSquig6JeuJ/PvjK9hJoP6EmhtuZ1qQVWFzgyXYMMMMOTsB+of4eZk
   GGrWrjj/8VHkA+sSXYnyZHLaFeVgxTNC80EbknTLJzLPMtOgjI128k+Pc
   g5sA+0yZWyPzJIYYEcmNeieXCKoKpoxr9hXXlYHR6ph9jBmVxUU41I4Gq
   HqCEvpPxoTe0T18WRmBQqvGgjSQVbk/bv11vS3pr2CaeE5waWUNl1KFJl
   9e4Ic3ZyVdwzYGOOlnaOssYcHSQKhoyn4Vozecq01HlA+/bwmG8LZW36u
   RrU6tWWd+5u2kPto4VAoI7rnYlMWgF7Sh3gtxuvZYGKH8n8hPFCVTdOUL
   w==;
X-CSE-ConnectionGUID: JdRXMiYfSO6Go6cXug11zw==
X-CSE-MsgGUID: B6+Gl6itSpOajNoe8VNBew==
X-IronPort-AV: E=McAfee;i="6800,10657,11916"; a="91153628"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="91153628"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 08:17:04 -0700
X-CSE-ConnectionGUID: 9e6DvfxrQHa/ptqTVFIPYA==
X-CSE-MsgGUID: a/Ze0wrNQkO45ju+OwVNAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="277725612"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 08:17:04 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 08:17:03 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 08:17:03 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.51) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 08:17:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBgPP/0Q3GYNJR4+cegRk0DL4syA24zmiy09m/PoqJVnUcx+QH1CI0BftxVzeDkUkXsuasamL/A0QgNjKFLXFMeHNeJp38jZhzUqBTJ4rVptkcm/D5AArIshzeXOgXQ/2K2xA/yRUR5MtR2F48WwHAmUYT4ENMo8Igcfb0jfW12u8Bqp89rMmHIHzlPWhR62iCEa1LrFHYT4TPpCg2jixQzo84hZqEcHC8+HFYds+p5EoG4+Sa/+o+pebCmZ2rcPIcH1ldydjOWUPWOx4//IGiD8ByDTATNv3IiU98baG8ETTmZo86KjK3McFv2aA7yeAVZxoKzNCjU5C/CAiqW+CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JlRljh4PNoHRg9wMxf6+v6G/Zb/KSQymdLUa/fNhGYg=;
 b=BleGgTEb+Erpi4xxOaymSjJKQfd+EBMvKx4FLA7OaYeEuD5vTy5hkXAfeRq10e+DExOltOjeAtxfFlLtDkDBSxkTT/FRXX7vWMNaoDBlBU1kcS3HJognhCvVlB1cL9vd6QUEu6scYccGd1X2nK25bGNwfcVaSpT4PfpKpJ5rOS075gUesF0MxYAShfrc4CpP01Niv0kWtP3q4crSwU2hEVmEO/34jfX8osSqrmqOAeenvfWeRB8SQHqSpMYBTLrjBtZ7sy6Yl/Ho80Y5Zf/hTrlTliSii3UrlQaYz94B9eL+78I7P7qDVDWUdxBRAhxSNainCj5Ah8muFZ4azA5rew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CH3PR11MB8436.namprd11.prod.outlook.com (2603:10b6:610:173::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.19; Fri, 25 Sep 2026 15:16:54 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 15:16:52 +0000
Date: Fri, 25 Sep 2026 17:16:38 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <zhaochenguang@kylinos.cn>,
	<magnus.karlsson@intel.com>, <jacob.e.keller@intel.com>,
	<przemyslaw.kitszel@intel.com>, <jbrandeb@kernel.org>, <horms@kernel.org>,
	<kerneljasonxing@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
	<bpf@vger.kernel.org>, <sunithax.d.mekala@intel.com>
Subject: Re: [PATCH net 3/8] i40e: make ring pointers unreachable before
 freeing via rcu
Message-ID: <araQVrNwgbfhPKqe@boxer>
References: <20260918212458.550425-4-anthony.l.nguyen@intel.com>
 <179004066858.2160803.3751100830230297898@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179004066858.2160803.3751100830230297898@kernel.org>
X-ClientProxiedBy: DU2PR04CA0310.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CH3PR11MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 3380e31d-31fa-43a9-2971-08df1b1806ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|5023799004|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: TQ3BgkZXOxwLZaQNkx3fq+b+cv/hS7tZG2OAVDF0ideIoEA+83SiFZ1pjhsmrFEGJQ7CCDARzBC6GVuKQMUiO3lWReKF5AXzFSCB6c/5dE3xhrZm5xdrPrOmSwrDH/mUoFPAXikQmlYssRWbfub3mx9jx9a6ufUhbA2x8B3mQZz5tTZM9nsm4yaJYj5S83zakue82rL7/XvwzFJlV2NyfDq9PcijLknx53gcb8fVXsnU+PdNIwNmFs/K0vKcKphCcSxhSl5QneOdWgPL83/xDpNVawQV0cUwBOdjNAZ5KmcB86s5eF9F+73r00rA/4X4fctI/u03kgStt0WRDsAJF2/xcAExTaI2ggRzKZ8pOBo2r7iFyXCR4jXne4qlKl5xXe4Sk197tvP+jX7qxBf8n9yYPGKWnYTJ+OiLsWQRDm5gKrkbxPKTiaeLIAYGly0GdtGovgBsux5I+xQpH9q5Bqe/ZgOfOH4ioKRB6/D1gOoUNHbTtLDgepJCO4Xm/fjLBMiRNuUhlrN/Rev37QRq3pF5RetLQh8Ms63Xs1QS1QxLuzdJuVzGzCQSPT++z01xGQBSqcVZ35ICTGgsQxhsWO52/vz2xzfwB5BukzB9UpNOJOlsHrxuoyRjJCdgd5Kf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(5023799004)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnc2bVo4SktablM0dzFjdEpwUzgrMmI1SExSVWlqbUU5Y1dTZ2FSM3NQUStP?=
 =?utf-8?B?cm9JMnA1NkhjR011NWVEaUptNmh6L0xtNlk2QVU1OCtDZGFiaFRiVUY1bzd2?=
 =?utf-8?B?R0xzMVBleXhCYXdlRThlNFc0RlVUQ0ZqbnRCVXZJUzFOT0RweGsrbWwxMDEz?=
 =?utf-8?B?SWRBYnJCenJYSUZ1L0RubnZYNUJDR2tyQ3FLNXJ3Y0dlTEJrMFV5ZFNvcG5R?=
 =?utf-8?B?OEppaTJWdURiSkh1cVNoZDk2YlpzdjhaM1kxQVJ3bjZJWllaZHIySVp5bk5a?=
 =?utf-8?B?VDB4SEphZTVNNzlTQmQ2VUlZbXM1dG41c3psZHZEa3VUckZ1SjBZSWxibXNQ?=
 =?utf-8?B?ejVDS1ZvV002eFJKWGI1K2lUL0NDZWdiNWIzVGFScUNUK3NBc1dxZ1FpaUlJ?=
 =?utf-8?B?UnhlWjFMd3E3V2hUU3F6d1EvUnVkOHNHK2Vta2VHSDFQUlpINXRWbGJIUTBn?=
 =?utf-8?B?enVxU0w0NlJnZWhYdkdlczdLVHZLTXN5UngxcENJRUFuUUZSL3lrUzI5aWxv?=
 =?utf-8?B?bzhHUzFPNzkzS3VGYU4weU9NUWdkYzlnTWIrR3psaXRxeHBPcFJhVmZEd1BD?=
 =?utf-8?B?bVV5ZEp6QkR6clFwT1lUb3dXYUhlQkV1c04xNllRNWZQck1uRmF6NTcvTk5B?=
 =?utf-8?B?QVVhOXBKNk0zSEl1SnE1NUdZM2FFNUpoWkdnRDE5SEUrSG94RDJ0dUEvQklu?=
 =?utf-8?B?RUxnYkNLam1oNU0yaDhLaFM2cXZDdE5ONEZvMkgxdlBSZmR2NlVrbUZwQzZR?=
 =?utf-8?B?TW1Takl0TzBxcWQvbTBzZHZJc014N2ROVjdhU3prc0lBTkZ3enJITkJxelg5?=
 =?utf-8?B?OFVrVkdKTnFGTnpSNlhxWW56Ty9RWjRYMTJubkoyU2wza0NscjhUQnRFWmtH?=
 =?utf-8?B?aVZXWU9uRE5SelN5c3FSYjNwNHh1MEVpT2JRMGNDd1hDLzdWckMrWXJ4Rzl0?=
 =?utf-8?B?VzVvZ1dRdFFucHpJTnZnVzRQcFpnZG5pMjhzRHFCM2U0dzZMWG9Mc0lacmpH?=
 =?utf-8?B?ZEFkWkxjRkV3MzFyYnEvcENrWk81Zi8ySzdxVUdEQWlCdThvYXVOREpENWhC?=
 =?utf-8?B?Y0ZmVXhsaVdnaXUxazJ3NElSQnlkdmtObVFHbXd4dVJuSjZSOEZwem9McHBG?=
 =?utf-8?B?NEtPUEx0OGdHUjJrbDduaFdEVlpWNVRsVHl0a1lhVEE2d0ZjRml5eWd3TmUy?=
 =?utf-8?B?OS9jclU2cEtWazRJc3FhVVhYdndQblByRHJLdFcwUVBCUTJ2amhmK3hPZ0ll?=
 =?utf-8?B?aHJ0U2RRdVlUOVNlOXdhSmlaZUVKS2ltZ0xTbmJQZkxOdGIvSXNtU2d2WVpD?=
 =?utf-8?B?emdHR2sxVHFGbUVNWVIvYndzRUxGeERIdUZTaFBIMHoyRnhCMXdlWkVUdkVZ?=
 =?utf-8?B?bDE2Qm9hZ1g1RGFEc1J5cFVTaGZmMktEYzlSc1BkaDlaV3ZaSCtvNk1mNXNz?=
 =?utf-8?B?Z1BMNEZSRzFQeDhySDJvT0RsWnU4QzFGM0dJMVBmUlpWNnJRZlEwaE4vRUxY?=
 =?utf-8?B?Z0taenNpMjllY1FaSmtscTFORTBFMTcyZTNjTXRCTVhXTUtkMHB6Tm5ENXph?=
 =?utf-8?B?eTVJemlFZ05wbkp3TWRRdnUzVlhOVnZDS3RZc3FSZ1hVdTlsU0h0NVhlNXdF?=
 =?utf-8?B?ZkJLT0MyVVFlUGtGTkZ5V0EvcVJaR2lOeGtBRXRUa1pHbjJvdStrWEZJRXNt?=
 =?utf-8?B?bG5UZnlZY0dvdmN3b3B1MVEzaldHMmFEYUpQMkNhYmx5bmx4aXd2Yk94MVI5?=
 =?utf-8?B?alJ1UDk4ME5rZkJ6Skp0TUdxY0ZmVW8zM2VPRVBsZEZqZmlYSVBZa0FDTFlI?=
 =?utf-8?B?azlGbVowa09Gemg5ckpWQVYyd0F6RUt3a3pGVmJjWGY4WG9OVHhza0dBYlRL?=
 =?utf-8?B?c1hnSURLOGhpSlFvdFg2SUUxTEE0Y2xhZVFzT1JDRDJFQWdxekJWQzQwTkhx?=
 =?utf-8?B?RmpuRi9WM3dzcGR1VThnSXhtYkZqWTZGcEg5WFBGMVBNL0grelZuTUFhN3hF?=
 =?utf-8?B?NUNMS2Y4YWY3U1NSYzllMVNSZklYUkZmcVZrb3loYnVmMEI0bzhxZVdPV3Nw?=
 =?utf-8?B?eG5sWmdhUmlHS1l0OStYeXA3ZkNaaEhzRWhZYzA5Y0NKQ2YzT1Z3ekk0SUdM?=
 =?utf-8?B?S0xua1RYQTZVaVhRWEZlYjVLamYxdFN2a3BlMVVIbjFSRmZZZWlzSVF2amZh?=
 =?utf-8?B?Y2twSWRUMDVqa01PYVVEWksvOTQ3dXd2T2J3RkJreDM0V0RyRTZYTGMxRTBq?=
 =?utf-8?B?SmhjMVBteFVCeWJsM0pCc1BuWTJpL3VhcmpTNHNFdWZZMHZyK3N6cHhNeHpC?=
 =?utf-8?B?M2k2SlJRSk5oV2lFWWEvNVRiM1lpNWZSNy9KcTNSSjFKdUlGNTUzKzNLZkFR?=
 =?utf-8?Q?A5JNtQlQiovHKHQ8=3D?=
X-Exchange-RoutingPolicyChecked: 32KFCogOIqj7PCOLGkDh/ewpXXdGwRbTM5t+TwvmLaPNsLKB2lBbUSQtpRdRxHZgMf9zjZiychdEaqFNpxtdqmiIpiEt4edirstIJw62LuaFUrszIvGkrMu1C9//aXqKkreyZatnwwGS8iVy59Z6gC4qXMItm2HQyaCYK0P2h0fr1pYim78cJROkoWacKC+HzQohIWXor+R/Eog1N2/CU49r08Chh3cpUYv/qDzd14Gshad3QiUZ/D0iz4nAgsRBMFSki/h1szFW4wiskKSYnlBrFHuY1HK05Zjx9qJM1V7eOC2eQnnYAXq+Uj5UzGx6pOs2S7QA3rLR7QZKiOmkvw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3380e31d-31fa-43a9-2971-08df1b1806ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 15:16:52.2222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulsSDYOiN3zJhfBTxcXzzi2faWpj9kOwqUUMKawaJi/jLehMNypNfh9Ea2YXcVLUpNE8JYPWixQcunYsnYFUlGT4HZmnu49bwXkufwI4QGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8436
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 01:31:08AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] Incomplete RCU teardown: the ring-pointer arrays through which
>   RCU readers discover the rings are freed with a plain kfree() and…

this rcu'ing rings but not containers always felt a bit incomplete to me
and while i could say it is a pre-existing issue i think it will be a good
thing to address...unless it's gonna open up this Pandora's box further :<

> 
> --
> 
> i40e: make ring pointers unreachable before freeing via rcu
> 
> The patch reorders i40e_vsi_clear_rings() so the published slots in
> vsi->tx_rings/rx_rings/xdp_rings are cleared before the saved Tx ring
> pointer is handed to kfree_rcu(). The Tx pointer is saved first because it
> is the base of the per-queue-pair allocation block.
> 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > index de4c0737f72e..65aa50330aac 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > @@ -11693,11 +11693,13 @@ static void i40e_vsi_clear_rings(struct i40e_vsi *vsi)
> >  
> >  	if (vsi->tx_rings && vsi->tx_rings[0]) {
> >  		for (i = 0; i < vsi->alloc_queue_pairs; i++) {
> > -			kfree_rcu(vsi->tx_rings[i], rcu);
> > +			struct i40e_ring *tx_ring = vsi->tx_rings[i];
> > +
> >  			WRITE_ONCE(vsi->tx_rings[i], NULL);
> >  			WRITE_ONCE(vsi->rx_rings[i], NULL);
> >  			if (vsi->xdp_rings)
> >  				WRITE_ONCE(vsi->xdp_rings[i], NULL);
> > +			kfree_rcu(tx_ring, rcu);
> 
> [Severity: High]
> The ring objects are now unpublished before kfree_rcu(), but is the array
> that readers index through itself RCU protected?
> 
> The commit message states that after this change "new readers can no longer
> discover the ring through vsi->tx_rings/rx_rings/xdp_rings before the object
> is queued for deferred freeing".  Does that hold on the i40e_vsi_reinit_setup()
> path, where the arrays are dropped immediately afterwards?
> 
> drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_vsi_reinit_setup() {
> 	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
> 	i40e_vsi_clear_rings(vsi);
> 
> 	i40e_vsi_free_arrays(vsi, false);
> 	i40e_set_num_rings_in_vsi(vsi);
> 	ret = i40e_vsi_alloc_arrays(vsi, false);
> 	...
> }
> 
> and i40e_vsi_free_arrays() uses a plain kfree() plus plain stores, with no
> grace period:
> 
> drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_vsi_free_arrays() {
> 	...
> 	kfree(vsi->tx_rings);
> 	vsi->tx_rings = NULL;
> 	vsi->rx_rings = NULL;
> 	vsi->xdp_rings = NULL;
> }
> 
> Meanwhile i40e_get_netdev_stats_struct() (ndo_get_stats64, reached from
> dev_get_stats() without rtnl) re-evaluates the non-volatile array base on
> every iteration inside the RCU section, and never checks the rx_rings or
> xdp_rings bases at all:
> 
> drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_get_netdev_stats_struct() {
> 	if (!vsi->tx_rings)
> 		return;
> 
> 	rcu_read_lock();
> 	for (i = 0; i < vsi->num_queue_pairs; i++) {
> 		...
> 		ring = READ_ONCE(vsi->tx_rings[i]);
> 		...
> 		if (i40e_enabled_xdp_vsi(vsi)) {
> 			ring = READ_ONCE(vsi->xdp_rings[i]);
> 	...
> }
> 
> i40e_update_vsi_stats() does the same with no base check whatsoever:
> 
> drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_update_vsi_stats() {
> 	rcu_read_lock();
> 	for (q = 0; q < vsi->num_queue_pairs; q++) {
> 		/* locate Tx ring */
> 		p = READ_ONCE(vsi->tx_rings[q]);
> 	...
> }
> 
> So can a reader that is already past the "if (!vsi->tx_rings)" test, or
> inside the loop, reload vsi->tx_rings/rx_rings/xdp_rings after
> i40e_vsi_free_arrays() nulls them and dereference NULL[i]?
> 
> And once the pointer-array slab is recycled, for instance by the
> i40e_vsi_alloc_arrays() call two statements later, or by the SLUB freelist
> pointer written into the freed object, can the same reader read a non-NULL
> wild value out of the freed array and dereference it as struct i40e_ring
> (->syncp, ->stats)?
> 
> The __I40E_VSI_DOWN test at the top of both readers is evaluated before
> rcu_read_lock(), and nothing on this path drains readers that already passed
> it, so it does not appear to close the window.  Should the arrays be released
> through kfree_rcu() (or after a synchronize_rcu()), with the base loaded once
> via rcu_dereference(), for the unpublish ordering established here to actually
> take effect?
> 
> Separately, both readers bound their loops with vsi->num_queue_pairs, which
> i40e_set_num_rings_in_vsi() changes between i40e_vsi_free_arrays() and
> i40e_vsi_alloc_arrays().  Can that let a reader index past the end of the
> freshly allocated array?
> 
> >  		}
> >  	}
> >  }
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918212458.550425-1-anthony.l.nguyen%40intel.com
