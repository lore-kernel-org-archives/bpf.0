Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FFB3B14AA;
	Fri, 25 Sep 2026 13:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342416; cv=fail; b=HlJJR6hDj02IXKti0nF5kqVwJtLE5J2PLMoiWk2dONCqZseQy+HewdSo8CxuiDi+nOk/FK1SC8p5lubesHgaeUOTGdLurThaLWWcrtuhgr2fc6TcjlHQEb4eDTEmA/onkBe6xgW6BP1EZY209dE/IzqvcRHS1ICceDlAIAVouOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342416; c=relaxed/simple;
	bh=2UU/WJDbPXGKQBny1nxHqYcugQ8AvLQp3jdbnE6/ORI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MKXPLcmuhl/ZkfKvKGOml+lLQkxqaETsGNmv/WlTrZvqivKxcCwgWj6xmSPyYbsyQnMc0CHpFqVLvJWdjtdLCemIrhg5IypjcYSo+mv0jJ2c9DsKz11R1+7V1raLrBO4H00DuTqFn7FVXbD9xTkWBrZBzD+tfD5vzMCZ0VqebD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JFvPqF8H; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JFvPqF8H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790342413; x=1821878413;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=2UU/WJDbPXGKQBny1nxHqYcugQ8AvLQp3jdbnE6/ORI=;
  b=JFvPqF8HtUz3Wc3Q/ZrCbfQwQj+ciGAYV6EUDBnfcq7H9OPFr5aaOBkC
   01HgL9kh5Z1SdDkGs4g3z6fm9+aL30O+k5f190VD8INKrLilQ/1eCCndO
   50J9ihDcHVOGt75GdEiq8hSl3fnkadIH651GJYrSDC+zsjXQyM+JjYB05
   7zKiGs11x45/LbHSHTYpXc2Wt8pg6Aji80R1IZ9GoiPJqkEoJqIOU6cp8
   64/Hy9aIpC1vZ05Ub7TZZyhS4DtsvilPeCEDD2EEinYswloQtGBQu4j/0
   c3MokPtCwhkl0byes6ozTc60HofxV4Us2pWc3DGt73yxZ2hQAoeryTOi3
   w==;
X-CSE-ConnectionGUID: UXiko8m+QQqr+kDj8tAN4A==
X-CSE-MsgGUID: NGx01NtBQ4yVCzmGzVPORQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="101653543"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="101653543"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 06:20:10 -0700
X-CSE-ConnectionGUID: rUq/TW7bREKDDOhHKZwBkg==
X-CSE-MsgGUID: QFNhFtPjSvyna/j7P+QKCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="272143436"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 06:20:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 06:20:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 06:20:08 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.25) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 06:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTcb56geQXsXk3F9KtF+B2ohGvem7BtepbhIZg08Imt4bmKdE9L3cYQtRmSjtegU7EyBQN9oUp4bFHKQxLf3+v9sx6iIvyygY6+YOFFGcYLqs3C5xTswAIrhn22uf+tOtdRG+v3jbQOruhRJW8DVD/Lul+4evLNhNaXFKD514XQXeZ0x1a/gLciNAFreSn7SeWWUKAqsBqU3SKL2/iegQfeQdlQ8Fp+3gCGXRsR2WeHva9x6aULg07nU8+4GbMRQUpY5fJXIJKxZr/BFZR6/K4j6ZTB6sgkIgFFP96glWqY/eLAjEKPuNRsdZkMZKP13D8We5vRUa/jzrTTDWk+oBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ix/mE3KcNCUK0vGry8ZJgu0qNKy8fw0eNsdOdlz27ZA=;
 b=hycqTVBYj5gH83Gv90atfSLhViBNRCfk0BOylr/qUnZ3ZEwNsnWJ23sN9HJSsfV6woluIHS8a9P1jsxiUvVjFNHmmVPKtZPTiZi93VYZGHQhFrcXv48QXmZAbQqMEBsv3AUmQF4qqYZpPW/IIJJxMffUUqruEW95jI441aPYGYGJByknN4nCAkVFR6uEj1jkinAV7xW7ogyJlHaSS/iGcppiFX1jmjGKQzpW0cSCwqoT4Uu2aS29gDRcdbze3MIvjNR0X01aDwcVPvjwsgcYZ5Coe3gZinGqQPk95JqMXwYwJnNSJscYL8b8x1Bz1TsXfTrupBZcJ/fjjCCypTrp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB7013.namprd11.prod.outlook.com (2603:10b6:806:2be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 25 Sep
 2026 13:20:05 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:20:03 +0000
Date: Fri, 25 Sep 2026 15:19:51 +0200
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
Subject: Re: [PATCH net 1/8] i40e: unregister netdev before clearing VSI on
 reinit failure
Message-ID: <arZ09/F8fAbLIWDv@boxer>
References: <20260918212458.550425-2-anthony.l.nguyen@intel.com>
 <179004066503.2160803.6283752728775415263@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179004066503.2160803.6283752728775415263@kernel.org>
X-ClientProxiedBy: DUZPR01CA0171.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b3::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB7013:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0c668e-14a4-40bc-5369-08df1b07b5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|7416014|11063799006|56012099006|5023799004|10067099003|4143699003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: Yf11R6MJ4YiB26sHey3QKLKlgNItiqWgrtyEYdD9OOp6RSUdWqr/jGbkABJAEQnEq3vRkQzwlsVSf63Pw9J4HyObwG1FZ0gKLRbmsJxQiyCP0Pfi9BmsMH5txHmGF1YKjUkx5XQllwCeMEfVFSjKkDUzx77YAmIMSjAxbROBQmwBoIvdaBq/lHYyMQQkcLncCjX9hYfgF+sbS2EK1xzUpch9wqng1fsYET4cmoBlUzUhG6inwIXmqi6GEIWnpEiQ1qymJj4F6fSg7/eMUm0nfStu90lyB5+V/X1o4eQBZgEKdcKdAVsmabaP83i+xbctMo4/Hl4CH4ca6kNtBbmguJhGLqKeZe0HQ8HrmQOBDG0z/m5vKbNiKAbiwjRQgVMjCkOnMXdZHYVNfJC2GA0fEXPasFsdtMTcL1Q+aj0jv+qh2sJe6neWd8M3YXXqxZr8+4kOJDONmo5770vbr/vn3E5pWyaF3XHYgIJH+NkugETEhkuTy+gmni9Xw/GrcDlmVvu20NAoqyi1s5PmN60th/+m89BlDtezPmbSFWy3o6lyUBSMs1HvnprUSK+iLUXXDqDJ+82dkh9aLF6H4/+9XKi/caEewxjNvXlpLVCkMVVlMEs0scZVeNs7djU+0Eum
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(7416014)(11063799006)(56012099006)(5023799004)(10067099003)(4143699003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGJiM0lGbjAxZFdzU29wU28xQXc1bHUzendSRi9zc0RGV0dGaTR3Qjl5WVJ0?=
 =?utf-8?B?Y1BnUlp0VW51dmtqODljZUhBVlU3bG1JV0w3dEtDdlliUmNHcEREWkpWeHRj?=
 =?utf-8?B?dnZ5eTJhZ1N3TENWUXdSMFU2UTNSa3NYYkgydDBaaDl1UG1nRk8wcUN5dkZF?=
 =?utf-8?B?QnAvem1oUFJpNExmbUhkdmVtU1BjWEcvTnVYK3NtM2dLWWdWcmlKc1hUVk1r?=
 =?utf-8?B?c1FCZ2RnWlFGaXBxNFJjMzJCZHIzYU5WQXh6eXVGeXBidFpRL3VZSytyMFU5?=
 =?utf-8?B?K1RldVdSMENJVUFxZitPRWFGRmRuOFdieUNUdnFyWDVIMUhtdVk1S0gzVnl0?=
 =?utf-8?B?VFNBSWpmQlJqUE9WcDBKR3FDSlF4bkE2ZFlxUlJvUkx5aGo2R0M4elh2Qm5n?=
 =?utf-8?B?ZnVxN2ZoRE9BcjJadmhHQ09UVkFtRk05QmpnT0lxYkVueTNMZE9vZEo5dStP?=
 =?utf-8?B?Ui9IUWM2REJGK2VVUzY4dTZ0TkVrS3lCdjBkc245Q3ZIMWUyVkJBckU4Z3JP?=
 =?utf-8?B?a2lNWmVBcWNRTWZGc0E2MHhHZWtTLzZZWDRyVW9rUjZuWnM0VEE0NEJBcFFm?=
 =?utf-8?B?cGlkb21pdWpJZjBoR0N6bXNxcnk4WXN5L2NIUHdObWYxV3pMZkR1aXhSbEk4?=
 =?utf-8?B?eHRxM0VEQ3BHRFc5Mno1VTl3OG1WaE5GcDBETHowWGhVQlIvb01yckd1c01U?=
 =?utf-8?B?ZDF6aE9rVHVxYzArcEpnTVgwci91TnJaeS91QVdtS2RWa2VucEswY2J4dk1v?=
 =?utf-8?B?M3krVWl3SnBVVGRYcnhiamdYbENEVnczaW8yRHZmVXRoVEpOYWpFTnkzUWVK?=
 =?utf-8?B?UHp1dWUzLzA1LzZUNDR3ODBTdmNES2d2eWFYbC9FYnNncFlJbTMvL3hDeTFY?=
 =?utf-8?B?R1d3bFpOUFNacWxuY0oyZTFFWjBCNDVKUDZ5SCtLYlRwemtyMkhsNFRPTWxX?=
 =?utf-8?B?b0hXU1BpR2pzSTJnYzJJMzRJZ3p0ZEg2S0ZNU2dURmVaQUFhbjZuOWd4c21v?=
 =?utf-8?B?azFpcEtCWG1ySkdBYk95bUJwdU93VmRnMklDcHRuWjV0MGt4YWNwOE5neGZt?=
 =?utf-8?B?UC9qTjZxSTlBTmZoQ2xBZGo1dWYzK1UvZmhmU2pTM2VtSDNYWEZUd21heHo3?=
 =?utf-8?B?aWZFTGkzejVHQXIxeEt6dE9HbkoxYk0xa045OHl5TkNRZ2NKa0NtWDlzKzFr?=
 =?utf-8?B?NXhQR25LRkpGbllUVVdYQVpwMndtRHJOZ0lIcVd0L3lDYS9Fd25aNjhwUVMx?=
 =?utf-8?B?T3FMUjZ3czJoNldFaW8zYndxdndCemZHK0I2NSs1WThmaldDeUptSzFDeFhB?=
 =?utf-8?B?TzhQeTlob3ltRjZCUHlYTjdNTHcyQ0JNZGRzMXVZc285K2E4MEZKWHZCK2ti?=
 =?utf-8?B?ZjQ2TnlnQTJlMEN2eHp0NWtlc0xxSU5aVEtXZFBqLzRRcWlCaWRLU0dhMy9O?=
 =?utf-8?B?R2VjK1RXbWI2VEdtQ1Z0c2dtQkdYcEhlOGNJdTRnbGpSME1mL2c1dFBIVmM5?=
 =?utf-8?B?WFd5RjhQRXhEWTVDbUhId08xQmh6VmRlSjRLV2NBOWhMWTBCNEZMSGRhWmdC?=
 =?utf-8?B?NkI5WkhDL2VHSThFTHlmUDI2Sk9MVXkzajkxNXNHZlpHQStka3VtMHRaQmsw?=
 =?utf-8?B?K2NxOFNxc282MjdoVldRMEhka3Y0WTJDY2dzajhMK29tK3dGakd2ZjdKZzdw?=
 =?utf-8?B?VlcwUUpJUHk3Szh2bkdRVVQ5bVRHcXArVlBVekJhamtMem1Rdm5IbVJlVU1u?=
 =?utf-8?B?Q2FEMjhNRzRrQ2NWZUJYMkZZVnBNL1ZVNE5qcHZCVmUxenpBdnBDUFV6bnl4?=
 =?utf-8?B?Rml3YXBJcFRPMUZsUklDdSthZ3pweGJYZnhHcnpEMFRhRGsyWlpxdjlrY01w?=
 =?utf-8?B?UHJEVWZpSXE0cXdUdzdLV0NMQ01vaFcyMFZvOUdiUXNrcHJIaXB5d2lsRWhp?=
 =?utf-8?B?cHBGWENRbVRXRVAwaHFhN1ZINlNKdFJBc29PbHArdGdDbXU1L3FEK2piVUtY?=
 =?utf-8?B?bi90TU4za3Rvd0xRU243bEFKNnpqL21uUmJNTDRKdUJhc0VjU1VsMWNrU0dl?=
 =?utf-8?B?Ry9Td1BjN2prU1l3d2htak1mbzVDUmw3TXg5RnZ4R3FHem1VdHJmV0sxcnBh?=
 =?utf-8?B?VU0zSktmYUkwa0VybFREUUt2blVZRmg0dXBsT1ZkVGtLU2IvaHUrQk5LVEZV?=
 =?utf-8?B?YU12NzJvR2tiVnYxV1QrWndGeHdUektTLy9sWFR4MDdNUkRmNy9TQmsrZCtS?=
 =?utf-8?B?OTlqemM5aXY1Z0prTks1dEhYTGI0NThXSEo5RlVWdm1wL3Rnb1Z0ck1hUWgw?=
 =?utf-8?B?UjBvSE1qVXFrOTlkMkE2WnU0OUtTdEpoQ1FkNmlKKytOOGFEcUxNOW5xWEdj?=
 =?utf-8?Q?JL9LUpT9SNbZF/Ow=3D?=
X-Exchange-RoutingPolicyChecked: 5P2wFffcFnTUe1MyzUhzxAr/q6fztEu3HlAcTG8JxTAZdBClfqdsqMvttvGkqBotii4iy7FfOebeS+Pi6S8cFKrr34xWuJf+ApxehaxKBz95wyxdwUyuxNilA/aKI5Tkh/ho4iHEgB6RI768v4Pyz2S9P0HaKruWMMOtDC9QFDgLe5VAfQoWDP3IUI+u9yGrP0TaekhIdKIxz8s3Ya/0ZmIX0jDhSkEVpvFiwomkdoU/xtHCJQ6pXn4IJ3AdNfgki7PgtZDIrPKy+wZWW29SnKy8pjEF9Lue/E7qFJ1tg4uVbJryOWt6JhH7axBmRfioazGuOkJI/WGJXCPuCPwX+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0c668e-14a4-40bc-5369-08df1b07b5a4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:20:03.7925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NVy6demXasbLn+/A8S0sxzhnZswfP6KQ5zk4sEs2eAngm2KTDSj+bPEvbyyKe8gvroJBpG8kLIJ127xKtTcvyDg23s3uEPRBTlxFJqNYZNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7013
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 01:31:05AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The patch makes the two early allocation failures in
>   i40e_vsi_reinit_setup() jump to the new err_netdev label, which calls…
> - [Medium] At this commit the reinit teardown at the top of
>   i40e_vsi_reinit_setup() deliberately keeps the existing per-vector…
> 
> Pre-existing issues:
> - [High] When i40e_vsi_reinit_setup() fails it ends in i40e_vsi_clear(),
>   which does kfree(vsi) and sets pf->vsi[vsi->idx] = NULL, and returns…
> 
> --
> 
> i40e: unregister netdev before clearing VSI on reinit failure
> 
> The patch splits the error path of i40e_vsi_reinit_setup() so that the two
> early allocation failures (i40e_vsi_alloc_arrays() and i40e_get_lump())
> reach a new err_netdev label which unregisters and frees the netdev before
> calling i40e_vsi_clear().
> 
> A few questions about the new error path below.
> 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > index 0cd0e5597c90..de4c0737f72e 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> > @@ -14268,7 +14268,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
> >  	i40e_set_num_rings_in_vsi(vsi);
> >  	ret = i40e_vsi_alloc_arrays(vsi, false);
> >  	if (ret)
> > -		goto err_vsi;
> > +		goto err_netdev;
> 
> [Severity: Medium]
> Can these two new gotos leak the struct i40e_q_vector allocations?
> 
> The teardown at the top of i40e_vsi_reinit_setup() intentionally keeps the
> per-vector objects alive:
> 
> 	i40e_put_lump(pf->qp_pile, vsi->base_queue, vsi->idx);
> 	i40e_vsi_clear_rings(vsi);
> 
> 	i40e_vsi_free_arrays(vsi, false);
> 
> With free_qvectors == false, both vsi->q_vectors and every individual
> struct i40e_q_vector are still allocated at this point.
> 
> The new err_netdev label is placed below i40e_vsi_free_q_vectors(), so the
> i40e_vsi_alloc_arrays() and i40e_get_lump() failures skip the per-vector
> destructor i40e_free_q_vector(), which is what does netif_napi_del() and
> kfree_rcu(q_vector, rcu).

This is fixed by patch 7, which frees the q_vectors at the start of
i40e_vsi_reinit_setup() before the allocation paths can fail. The
i40e_get_lump() failure is also routed through err_rings so that the
newly allocated q_vectors are released.

> 
> The final i40e_vsi_clear() then calls i40e_vsi_free_arrays(vsi, true),
> which frees only the q_vectors pointer array, and kfree(vsi) — so
> num_q_vectors vector objects, each with an embedded NAPI, are never freed.
> 
> Would "goto err_rings" be the intended target here, since it falls through
> into the same netdev teardown block that this patch wants to reach?
> 
> For the record, the leak is gone at the end of the series: "i40e: keep
> q_vectors array in sync with channel count changes" adds
> i40e_vsi_free_q_vectors() to the top-of-function teardown and reroutes the
> i40e_get_lump() failure to err_rings, so nothing per-vector remains
> allocated when err_netdev is taken. It only exists in this intermediate
> commit.
> 
> >  
> >  	alloc_queue_pairs = vsi->alloc_queue_pairs *
> >  			    (i40e_enabled_xdp_vsi(vsi) ? 2 : 1);
> > @@ -14278,7 +14278,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
> >  		dev_info(&pf->pdev->dev,
> >  			 "failed to get tracking for %d queues for VSI %d err %d\n",
> >  			 alloc_queue_pairs, vsi->seid, ret);
> > -		goto err_vsi;
> > +		goto err_netdev;
> >  	}
> >  	vsi->base_queue = ret;
> >  
> > @@ -14303,6 +14303,7 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
> >  
> >  err_rings:
> >  	i40e_vsi_free_q_vectors(vsi);
> > +err_netdev:
> >  	if (vsi->netdev_registered) {
> >  		vsi->netdev_registered = false;
> >  		unregister_netdev(vsi->netdev);
> 
> [Severity: High]
> Is RTNL already held when the two newly redirected failures land here?
> 
> i40e_vsi_reinit_setup() is only reached from i40e_setup_pf_switch() with
> reinit == true:
> 
> 	else if (reinit)
> 		main_vsi = i40e_vsi_reinit_setup(main_vsi);
> 
> and i40e_rebuild() wraps that call in RTNL:
> 
> 	if (!lock_acquired)
> 		rtnl_lock();
> 	ret = i40e_setup_pf_switch(pf, reinit, true);
> 
> unregister_netdev() takes the lock itself:
> 
> net/core/dev.c:unregister_netdev() {
> 	rtnl_net_dev_lock(dev);
> 	unregister_netdevice(dev);
> 	rtnl_net_dev_unlock(dev);
> }
> 

Patch 4 passes the lock state into i40e_vsi_reinit_setup() and uses
unregister_netdevice() when RTNL is already held.


> So a kzalloc failure in i40e_vsi_alloc_arrays() or an exhausted
> pf->qp_pile in i40e_get_lump(), reached via ethtool -L or an XDP attach
> going through i40e_reset_and_rebuild(pf, true, true) -> i40e_rebuild() ->
> i40e_setup_pf_switch(), would recursively acquire RTNL. Does that hang the
> task in D state while holding RTNL, blocking further network configuration
> system-wide?
> 
> Before this patch those two failures went to err_vsi and never touched
> RTNL, so the exposure is new here.
> 
> This is addressed later in the same series by "i40e: avoid deadlock when
> calling unregister_netdev()", which adds a lock_acquired parameter and
> selects unregister_netdevice() on the RTNL-held path, so the final state of
> the series is fine. Could the label split and the lock_acquired plumbing be
> folded into one patch so this commit is not broken on its own?
> 
> > @@ -14312,7 +14313,6 @@ static struct i40e_vsi *i40e_vsi_reinit_setup(struct i40e_vsi *vsi)
> >  	if (vsi->type == I40E_VSI_MAIN)
> >  		i40e_devlink_destroy_port(pf);
> >  	i40e_aq_delete_element(&pf->hw, vsi->seid, NULL);
> > -err_vsi:
> >  	i40e_vsi_clear(vsi);
> >  	return NULL;
> >  }
> 
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918212458.550425-1-anthony.l.nguyen%40intel.com
