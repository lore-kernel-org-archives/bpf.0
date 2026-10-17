Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ED63C455F;
	Sat, 17 Oct 2026 14:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792248059; cv=fail; b=XONnyuMTUGQV1hb5yZkxqCW0/LvmLLhDqTXQnAJPnu2yE1hlIiR5I44SxLo0TMduUjwyfxZSk/edLJnOO2bMoGvTdEOAiH0wSJ6o8s4a6iyGB3wm9DMYXcGBORPMqQz0/B9sCo3Cep1790tCXvJI4FCglqPCyh5GqAGmBkgFqgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792248059; c=relaxed/simple;
	bh=vjrGW0bD8rx3WRVS/+vldWpcRkoiJyb9U0oOPE3WnyY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ih6EO6AEJCqicAy2XXPO5QA+ERxkR0KiepqD4XUNDIEB7l7pRIHK0LMwsBsB+a838Y1vgyPkomX9Dg/Pf/W8xBM//V30mrtvaWdQrmwaXlasSn08E2EGziu3lXH6mO/+0ECQAIOn3/TF77Qxp0uOVo8Xd4+SCWJfC9Krj7PxemE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kDW4IEC8; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kDW4IEC8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792248057; x=1823784057;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=vjrGW0bD8rx3WRVS/+vldWpcRkoiJyb9U0oOPE3WnyY=;
  b=kDW4IEC8nBJfJpU6Xt2JM1lUeayVKlIVPX+Sy4sAxksNhT945t2q1TWu
   TEIWW7pxv3OSB0ArJduMaZ6gRmP+3Y0dMZ4UNPraTh6DjVTs2GG2hVIf0
   ft+aFSKzX8eByGOCyFno3gmxtMuGpMGufFAbiVh107Aqljm1UCjmWwQeh
   SFlIBtwBPh5/rQ9xx+Q7hHy3t1D/b3tRivSWrKTgNzmAWaQhOP8kepvhl
   roh60jlEQfEi0bBg4qkZodDLn5j40RjLXOH1cVA5b9KQbbwZeXMIfSlMO
   PXrepseVTVh4nnisJeE0+SpXX5HV0IHraqO12B2JoVj9M0yOi5/9pQdx9
   Q==;
X-CSE-ConnectionGUID: kyqo6mZDRyKnt/4Gs6lxgw==
X-CSE-MsgGUID: H4tNEp8sRWK5VCVCErRM4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11937"; a="1018096"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1018096"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 07:40:55 -0700
X-CSE-ConnectionGUID: 73eYIZTITQGr2btXmaLNdQ==
X-CSE-MsgGUID: LnckmCUJQFKNasUGbn09bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2227818"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 07:40:55 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 07:40:54 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sat, 17 Oct 2026 07:40:54 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.65)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sat, 17 Oct 2026 07:40:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKUvDs86p8zxgQuY7YMhf0Nt/o6w95sqNglGBty0Z3w/WSa3B8Dw7I1A+BoMVQb9Ef6c1jIRSnw7NDqAc1FaX7U+fpju73EZj7e1w3qcIRNuVD+bnpFScoxPN12BAPDBjajCPgp+rfXnqbehlbsXW+EWYu1kndLuX6YK8WKhusBlUuniqgwXoOHllvh9Vvbb+ir+dRCMFZmTuwGwFLIybr1LX1tLCE8M6CzNjSRIiiR1sMsqVUaPepK11S3sAeWhoZpwqSJUuZjKq6mbZ3uwlghrSkAZoc1thRfmOfIUnCXzRTsKa4/6FOUJDvJS8AlUXK5oaHBofo6DS71Xpkf93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJ/pzOWF9vv7sijguUO0aTRhUL8Ep7ZdBbidiCBnpB0=;
 b=G5gmHmLjnHKHeV3IYwIPGGu2aXE9iFYTPeRTqA0+6CeLGN3UclcyI5nwZ5mdqLGvBQPQ/b3AOyB6HRBqQo1n8XcJeGC7DAx5lPNSy47j/6/PXv7vee3IHhgkhDEk87so6A8LsCOVvSVD5aKHDanIAK47wealFtGSlCe87MPq4j9QXcBtySFJMQDxQv3VAEFGP+R1mVZRWoq4o+Qh1o0BQ0QtnZeP0+l4Oub6y/N6KeXV+jTsdtM4t7fPUUX2/YeJUOAwRQGHLKionOWT0T8fKKV3Iaepx0Zqq+KU6c+CohqkOUNO+jQMkEXOJ2yRNDc3aY0oed1YeZsuMHZkqTZinQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS7PR11MB5968.namprd11.prod.outlook.com (2603:10b6:8:73::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.14; Sat, 17 Oct 2026 14:40:50 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0522.012; Sat, 17 Oct 2026
 14:40:50 +0000
Date: Sat, 17 Oct 2026 16:40:38 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: <netdev-bot+sashiko@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <stfomichev@gmail.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <tushar.vyavahare@intel.com>,
	<kerneljasonxing@gmail.com>, <bjorn@kernel.org>
Subject: Re: [PATCH v3 net-next 02/15] selftests: xsk: size the TX UMEM in
 HW_SW_MAX_RING_SIZE
Message-ID: <atOI5qcfc1TxumvI@boxer>
References: <20261014184539.774708-3-maciej.fijalkowski@intel.com>
 <179220636394.434549.14546514468412075500@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179220636394.434549.14546514468412075500@kernel.org>
X-ClientProxiedBy: WA0P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::28) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS7PR11MB5968:EE_
X-MS-Office365-Filtering-Correlation-Id: cb07c598-7f70-4b94-b1e9-08df2c5ca3bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|56012099006|260925022911599003|260925021311599003|261009223027099003|260925021911599003|11063799006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8JsZElg78T9RnPyz9PYzaRDMPgeDu8QkxBt9g4KsFyDOoqCV5X/v6WGnmNMj7RYMWPpoXI6DDOzt0kfDPduQlIWDvjC9Q6DA/4nF6jv1pfYgj3x6lKK53p5D8bbgcnU+MJJRsiD6UNIFxYMG3QrTOXzsvyRfYBAmr+qSOvI0K0CtezcrEovvH6FK2KKrGfLK8ZymyoE7EXLFehByH3thfzmMoCQtuO7BrQXqCjGSZ3asuDN6bh+7kT/FKmlxg85e+a7IQ549/GUamj1E6jv22wVdENiDh+P/PNisc95zbhPDOlzRcbtkLwf9AzceLrC4RdUDrBoASIWgGSpxjZ7dyQv8INqePxbAOlre9F7Y9TBmmheHUzhznC6/9gDvBvjlu+KZldPlV62RhjDMlHbEWlQF2Q+yKSVLzmkmUII+gPv6kvtcCSGcmTHNTujPR8uCZfr46U0SLtxuFrkJNxmvtPCClmr2pDkHiMIwGigFH+ZxYMT7Y/KJ+RvOhrQLLQMBG8Fz18agiC0zSUfQCa2Jkj8WcGxwRmNrex9Tp7dMqnrJpNnIqhJtDjvjycz3EtzMjLfDzX5Js5X0oXt6doJPQd2VMJehIuI7NhwLpYZekjjdQG+e7xxWUtp/WKhEsSvi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(260925022911599003)(260925021311599003)(261009223027099003)(260925021911599003)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWFSanFtODZQUVNEekRoYk9TVEtpQkpqTjZZQ05MaVdlRmJqdDh6K1JDVGNl?=
 =?utf-8?B?Uk1nR1I1bnBjcXN1RkprSFdIdnlwbENreHRvNDZNdFVCQkZkdHk5ZTJzeitP?=
 =?utf-8?B?MkJsMWE2M1Z6MXRYWEQxTmtRWGFwOHlPUHp6NDdNMUlxMmxueXdkUXM2RCtQ?=
 =?utf-8?B?YnFMU281Q0VBUDZybTVtQkdTazllREtKRmF0MDNvSGkyN3BObmRQQ1FYc0RT?=
 =?utf-8?B?MTNNL2RmM1VOVFNIMUp3bUVTVUxKVlV5dlY0UXdCQmFodlR2WmlEOXhpTVM5?=
 =?utf-8?B?a05pYlRvWWFjTXJOMkQ1bU5QYXNXSkpIeXRTSllTbGlZd3IzUUlTQ3NQVmVF?=
 =?utf-8?B?T1ZrYWwwQkNOeldTanp5Y2tBd1hXdXJhYVltWEtzd2h5ODdVOVBCWXhXazRP?=
 =?utf-8?B?cHdoeWRGSnJ6ekJqcGEwSVQyUE1WWGNsNENqOTVFbjIwdXpKUG1BSHhKVUsv?=
 =?utf-8?B?dFZzdkh2R2ZVR3RScVNVS1hPajhVV00rWllRYnBWMnZNakVOOVVvYlVYSGtq?=
 =?utf-8?B?elNkZkdqUnNOUEpQM3BrUE8rRmExaWJoeldLekhGdFhPNjhXYUpmNHpyU3F0?=
 =?utf-8?B?YnNIMmNjMjNQWXZtaHgvdmtlQlJZUW1IeUFUS2drU1kzTGhZdFV4ajF5SHNr?=
 =?utf-8?B?TitCNnhYMUpzVjVVbDFGNDIrQzJIODVFdHJmU2V4aVhEZnROTUVVbHJ1eDIz?=
 =?utf-8?B?Z0VyQ1FrRUs3MDloSUErYUFFSzlQZlk3eXorSExjbStWdmY2SU8wUHpnZERj?=
 =?utf-8?B?K3dwYlpHMDczOGc5bnBZckFZU0JYMEhvWjN5aU9JNllBbmFzK2hyS1k1T0Nw?=
 =?utf-8?B?V1BSWWFoYkJlcnRtOUhHMXQ0WnozUHBNdElvQkNaM3JudEFZbGxkcVA5MWVE?=
 =?utf-8?B?RzhmNUFVYUtqVit0UkVIckYyYkhYMCt4QTk2VG1MZVUzV0RlZEVOK1ZPOUFa?=
 =?utf-8?B?R0pDYXJrUFViYVNVMTIwcGdnV2ZmYWJpZ1RSWmNZV2dDaVRla3J1Y3R3ek5j?=
 =?utf-8?B?VzNuY2NKbHBjbkJDNlhEYVZFa3JsQTUxRVR3SDVqRVFWbVdnMG91OUJEUGE1?=
 =?utf-8?B?eElnUGhXWHExOWJIUktyOWY3L2VzN2lvckZMdXhtUjRicGdka29zUjV5Rm1M?=
 =?utf-8?B?S2RaN1UzL3VWbmhuYU42WXFEMkNFSXZJeEZDcVluaWgweVZ3SWhIWmo1Qit6?=
 =?utf-8?B?L2YxWWRoQ3YwWE9ZQ3F4b2xqSHdhR0ZJY1lGL1ZoRDhrcDBPRE5HVXlGM3Q1?=
 =?utf-8?B?eHhPWU5GTTFlZEFRMXVFQjJDN0JOOHZERWk5WUlINUJGSjUrcVZwWVlRZmEy?=
 =?utf-8?B?YmRqbVdOS3YyR0hJS0VKVEthbktrQ3NvQ09HUmo3WHVXZDJkd3lGNUZKdnEr?=
 =?utf-8?B?ME9Fam84OTZwR1AzK1poRGJPN2NLRVM2bThuWlpCcHhUVWw0TFJCcGwxa3V5?=
 =?utf-8?B?cnN5cGpJNC9QcTQ5ZisrS2M1b1hiSnBZRytWbjdyWW5RTlY3cmFBSHBUSUow?=
 =?utf-8?B?b2taVm9NcFcxdTdCZE52MnUvSURtTnJtWHdEYi8rbEZSL2s1MnNlR2tQZDYx?=
 =?utf-8?B?Tm5mM25aMXhvWkRtTDVPa3JkTUh6aVJoZmZML0VQR2RNN1lVSkRHanJQbGRl?=
 =?utf-8?B?T1pOT3JtU25kUEpnRU5ycHVySGdTWmkzbStFdUVSdGYxb05xSFZ4MkZXVnh0?=
 =?utf-8?B?bC9KM1BjZDZ5d3MrTEQybzgyaVJqTWZ4SDJzeGZTVnN3OHNxYytJa0lMTnZG?=
 =?utf-8?B?K0Q4VDZHTEFwWVN2RW5iVmFlWWJaMTdRSXd3ZDNFZXJRcUo0K2tGSzUrNmh2?=
 =?utf-8?B?VXR6bllpaXBTN0N3TUd5QzlocVhWMGQ2S2U0WmtuZEFSREhDZk1rYVVZNCtR?=
 =?utf-8?B?d3lBSy8wTFRidW9IaGM5aDliWlJVWkdnSWVGb2xJN0xjZFNLdmlxbDZuYzQ4?=
 =?utf-8?B?OXB4WTJVQVl0T2NNVGJydTRncUZ2SUp2WmhVL1dJUHY3Ri9MNHBmRFU1bzJX?=
 =?utf-8?B?cjc1a2xjQ3ZNYklaVmY4blZXU1FKd3pUdFN3c25sQWNpcHV2TXJnZGhpKzFX?=
 =?utf-8?B?aDVIeXF0NkJOb0lQcWc1elpwU2tIWkFvWjRBbDVQNUdvak5rTG5CUUV4aUpu?=
 =?utf-8?B?VjhRWCsvMHN5WmxnM09ZejJmMkd5SFVWd2lCWmlkNFhxSVlaUTlvUXBZTUFP?=
 =?utf-8?B?dm5RUXVlMFlsZEFMR0JITThPeHR3R0U0UGpLYStqRzVYcXVMbnlPOVNEN2s2?=
 =?utf-8?B?ZG4xb24rTTl2bko3R29GdEJDcFJHdW9JQ3I3VDZqRE1nYTMzWThPSGxhYjJ0?=
 =?utf-8?B?MUdIOTZ3eXNhZERWb0VGOHdiZW9qNkxadElhSjFNMVVXVmNKdjVBTWR4Q1lB?=
 =?utf-8?Q?e62yOtC70nrxAM/U=3D?=
X-Exchange-RoutingPolicyChecked: esSVjcmcoU5ZcWcdctHy9cwIlSRe8UuVFKtbcda67fNg0x4It3jx51yqydPpVkC+6AT4xMoLOST3ny9YBvYFY9g+ulqbdcFuG5ojZWM8IPLpmgwYFtb2tPnZR8zgIW57KMduIsaAugAM20xjN+OLdZPpdcVSXTEPGwEhYYH/Ug9HTrXjqFeWD6wMd3F6dSxjXuC6ps5/hE13kw9dYnYHvRsTmdyi0GRxu4qPDW0AyKUrwEcbooybe8Pj5sgq9h/Z1QEakT+dadyZZZFja6/JYa01dllKBZ+CP5X9Ad1LomuqK2jUvp9u4LeMIY+gisjbUIlvRCVkoUDJvfxwQ/NPgQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: cb07c598-7f70-4b94-b1e9-08df2c5ca3bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2026 14:40:50.7430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LvX1E6YWWhXZYrVwBRmDECUOSrnSexvyXb8gEYuTH8yez7P0Mj82k8jAgMeAy3UIL0qX9lQ2cLKHTfwFGX7Qh4yuVdmFpr76FqgYlHpi9jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5968
X-OriginatorOrg: intel.com

On Sat, Oct 17, 2026 at 03:06:03AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] In testapp_hw_sw_max_ring_size()
>   (tools/testing/selftests/bpf/prog_tests/test_xsk.c), the patch gives…
> 
> --
> 
> selftests: xsk: size the TX UMEM in HW_SW_MAX_RING_SIZE
> 
> In testapp_hw_sw_max_ring_size(), this patch gives the TX UMEM the same
> 8k frames, fill ring and completion ring as the RX UMEM. In two-interface
> mode the TX UMEM has only 1k frames, so the 2k batch stalls in
> __send_pkts(). The patch prepares for removing the single-interface mode
> in the next patch.
> 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > index 2a13628740924..16fe32e5afc06 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> > @@ -2513,6 +2513,9 @@ int testapp_hw_sw_max_ring_size(struct test_spec *test)
> >  	test->ifobj_rx->xsk->umem->num_frames = max_descs;
> >  	test->ifobj_rx->xsk->umem->fill_size = max_descs;
> >  	test->ifobj_rx->xsk->umem->comp_size = max_descs;
> > +	test->ifobj_tx->xsk->umem->num_frames = max_descs;
> > +	test->ifobj_tx->xsk->umem->fill_size = max_descs;
> > +	test->ifobj_tx->xsk->umem->comp_size = max_descs;
> 
> [Severity: Medium]
> Does the second step still stall on NICs that report a tx_max_pending of
> 8200 or more?
> 
> max_descs is fixed at 4 * XSK_RING_PROD__DEFAULT_NUM_DESCS, which is 8192.
> The step-2 batch later in testapp_hw_sw_max_ring_size() still comes from
> the maximum the driver reports:
> 
> 	test->ifobj_tx->xsk->batch_size = test->ifobj_tx->ring.tx_max_pending - 8;
> 
> Here is the in-flight limit check in __send_pkts():
> 
> 	if (pkts_in_flight >= (int)((umem_size(umem) - xsk->batch_size * buffer_len) /
> 	    buffer_len) && !test_timeout) {
> 
> With batch_size == 8192 the limit is 0. With batch_size > 8192 the u64
> subtraction wraps, and the truncated int is 8192 - batch_size, which is
> negative. In both cases TX only kicks and returns TEST_CONTINUE.
> 
> Even if that check passed, xsk_ring_prod__reserve(&xsk->tx, batch_size,
> ...) can never reserve more than the 8192 slots of the TX ring. This is
> because xsk_configure_socket() sets cfg.tx_size = umem->comp_size.
> 
> Some hardware that supports AF_XDP reports larger maximums:
> 
> - octeontx2: otx2_get_ringparam() reports tx_max_pending =
>   Q_COUNT(Q_SIZE_MAX), which is 1048576. The batch is 1048568 and the
>   limit is -1040376.
> - hns3: reports HNS3_RING_MAX_PENDING, which is 32760. The batch is 32752
>   and the limit is -24560.
> 
> ice (8160) and mlx5 (8192) fit within the limit.
> 
> On the larger NICs, TX never sends and RX times out. That seems to be the
> same failure the commit message describes:
> 
>   "the in-flight limit in __send_pkts() turns negative for a 2k batch,
>   so TX never sends and RX times out, and the second batch would not fit
>   in the TX ring anyway."
> 
> At the end of the series, tools/testing/selftests/net/lib/xsk/test_xsk.c
> still uses the fixed 8192 and xsk_get_cap(test, tx_max_pending) - 8. Once
> the single-interface mode is gone, two-interface mode is the only one
> left, so this case would keep failing on those NICs.
> 
> A 1M-frame UMEM would need 4 GiB. Could the step-2 batch be clamped to
> the software ring instead, for example min(tx_max_pending, max_descs) - 8?

I have sent v4 already which addresses this:

	batch_size = min(tx_max_pending, max_descs) - 8;
	test->ifobj_tx->xsk->batch_size = batch_size;
	test->ifobj_rx->xsk->batch_size = batch_size;

> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014184539.774708-1-maciej.fijalkowski%40intel.com
