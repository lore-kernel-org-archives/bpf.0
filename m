Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793903797;
	b=Z73x99eP9+Re2G3UWchAAyr/xvKBVzdQ/FVP54seMBXBpTyRjlo4pqHnudX5JtIcU+V3
	 wmrwA48mgppaFUrbCCtq5mi3CQywspi7jPM2idxtiT6et9lcfM0kU7wlRpE1/kERxHTmx
	 qK5hmiQfZKLqcXC4jxuvujzftsRZy1s2rq0XdvJZCY+n5J7QzWlJNqVcm2FyemJNzhop7
	 6asCHH30oDt5ttiXZKWMR2HBZbjUgQYHR3A19zo4dT1c/CVYhhmlQZtkTB9lBViLHhYQv
	 oXzhqnjFTyP4pbsReYEdWluP7TpYwB7uuoRESP3EHAJWUjInIvhzVaipz5P/WUMfXDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903797;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=6Ir+0jj+rxGz1+jJOL6n351TZq1gLM90FyYCwA9Xi8o=;
	b=vtcYz99Ot18XP4oO2S4at7VIplJgE9L5YGS++nTT0HrlMCwVzHo6iNGa3E97TlUk7NeA
	 Knxmwz35JhEFA4TySu3aKHMLmZZN0ME5HfszPgXVqRaizHxAKQjyY9j3dGJ5LgTriLuc3
	 vSKaGuHaOrVE2WQgihGVswQu30bEgiRYoYbh7Jtgw10hfZ6ZPzUhE+hUyt3kADIv4PoRh
	 J6sq+q2KdTFrg5Ns/DWqI+6zgVfJVuOYW5J3KZcnHTwFLkdqT4kiAT/3xY32lPw+cEfWS
	 KW4rGUY0MfTcanxPcEeqiGwLzD5z1eyIHv4GKKfNbJjxqoYps6vkAoeP16tYVd0SJTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VZt9ZxbH;
	arc=fail smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B6D606A31B;
	Thu,  5 Nov 2026 18:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27B6D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VZt9ZxbH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793903796; x=1825439796;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yidw0sRvmGO2sPAG98FM3T8CpnDAuDp/l+ZcF8rKojY=;
  b=VZt9ZxbH1p+cygDCKxo+8yCTq9AX+ziUlsFifUyQJO7fdHiK2iUn1B90
   AoExGsLlQYLaDzSy8r/As2Sk2CvV1Vv7YpecrA1E/i0B1vSPzdRiRwrNn
   BNmYqcrez/QssxQXte7erxWSyON84pdpeH5XMOWkKowSmmWYVT+4tZp85
   vFELNla6+aTpMKR+xXl1MkGFEjk6Ie8sb8RhLJHvnDDEMVU3etzbVUkaG
   4nZxnk44vJE9P3RR0gkBAvWoLNQ5X5htF4Qm83/8gEPvz8j+sG107Ogtg
   WBU5EOb7EVx8VqWvKCyDx6ziNWCed+Y6Q8yJsyV9mLGr7csprJPHlO1Qx
   g==;
X-CSE-ConnectionGUID: 0Yu0EQaaQXi/pLy5hDlFsw==
X-CSE-MsgGUID: V8asMbyRSleclh4NVAM2CA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2608192"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2608192"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:36:35 -0800
X-CSE-ConnectionGUID: HOxJsNv9RgCw/x4eDkwLBw==
X-CSE-MsgGUID: uNQ/81C3Qc6sHQUipoLSrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="6971794"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:36:34 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:36:34 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 5 Nov 2026 10:36:34 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.53) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 5 Nov 2026 10:36:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzDeif7sLnrtZaRoYoLC1lQmwti2mDifZLs1fV4gNWrKmFGNprD0GLY8dEYAu4vgzr2T+9H1o6lohET9neftt1QW7I+jTymrhOSqqLxL5TIeC/Zkc7EDJP0zelazD7ARwCUjuM/cs7RUKl72JIxGa2WneRi+yTq9m8KpvH4wJumw9rtJAsTsq4XkLhOVndyG9d321Kb6tJoXzD1Ix0Sxr4ARh8f3m7xgdEUPFFFAsQwdvDg1vDld4E6EzsEOamaclj+RoRCrCH9e5ip1P238Z67WCa+8rxSFT3feLuwl42KRzzeKANRsBxHIbeFKODFS/i+OJFkqH6CurRtq42AOMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Ir+0jj+rxGz1+jJOL6n351TZq1gLM90FyYCwA9Xi8o=;
 b=sy1mbj2WPbvS15wBHBT1d69plfvVCvJ6QwYYQxWUSsB91ywhZTBFPSE9Q4IyEB6jsGKdN4pHcBx2AHwN20Khodd3NglfRSAktwiagXqfSZiRFefWKvAnCk99AX/tUu9yygNrIaPfZG2cGDKIuqGgw+kiks55vGpEchQunwlP3GLskP5Dia3cvrLiexu8NI98o0z66cBSnG2jmbd3uFiS9gcZ4mP2hr/eJff7buT4n33O0wm9krXipHXiJhX/i3VFwVGTMQH2b95tBccUdMznCqkZUIyq8uQoUNciVzjCwDXLqaHYd33T3ENc1CE1bvMtvuxLdqotftX0N9QRILu4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 18:36:31 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%6]) with mapi id 15.21.0569.011; Thu, 5 Nov 2026
 18:36:31 +0000
Message-ID: <b576c53c-7a8c-45ae-87cf-352ba2fbe52b@intel.com>
Date: Thu, 5 Nov 2026 10:36:27 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: mark skb NAPI IDs independently of busy polling
To: <bot+bpf-ci@kernel.org>, <meng.ding@siemens.com>,
	<netdev@vger.kernel.org>, <willemdebruijn.kernel@gmail.com>,
	<davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <corbet@lwn.net>, <andrew+netdev@lunn.ch>,
	<anthony.l.nguyen@intel.com>, <przemyslaw.kitszel@intel.com>,
	<rostedt@goodmis.org>, <mhiramat@kernel.org>, <daniel@iogearbox.net>,
	<ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
	<memxor@gmail.com>, <richardcochran@gmail.com>
CC: <florian.bezdeka@siemens.com>, <jan.kiszka@siemens.com>,
	<wq.wang@siemens.com>, <p@1g4.org>, <gerhard@engleder-embedded.com>,
	<kerneljasonxing@gmail.com>, <horms@kernel.org>, <skhan@linuxfoundation.org>,
	<rdunlap@infradead.org>, <mathieu.desnoyers@efficios.com>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>,
	<john.fastabend@gmail.com>, <sdf@fomichev.me>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-trace-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<martin.lau@kernel.org>, <mason@kernel.org>
References: <20261105071706.7043-1-meng.ding@siemens.com>
 <4c0a0855167cac39dcf8b1c103d0f98a8898a14866daf9b97a127698bb1ea0b9@mail.kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Content-Language: en-US
In-Reply-To: <4c0a0855167cac39dcf8b1c103d0f98a8898a14866daf9b97a127698bb1ea0b9@mail.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0300.namprd04.prod.outlook.com
 (2603:10b6:303:89::35) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
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
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|IA4PR11MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d8dcc2-5ce2-4c6f-c81f-08df3b6bb5e8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|6133799003|10067099003|18002099003|22082099003|56012099006|5023799004|921020|11063799006|4143699003|261102123227099003|261028144727099003|261026121527099003|261022075727099003|261026140227099003|261009223027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: hBKASUU8sDGI174sWkXkadub9tonALbfHgmvlhv6lOHW43h2sy//jN7wQPSVrBgru/6H3wWO/piHHPus0B8S8ozW8QLsvrmdTKQWqdWADxIEObDwjSgN1rk3MSdmjN3wEvnhtVGpE8n9TE0Ynp/Nky/meKsAZIWbC76dPMkw7vpF6eFh8VojQ6XxFREgCQM+51oqEx6j9QuR0LcZwTWG46pRYi4zsEGRl7D42PZ8B/+LRYhkwZ6/MLwBFhxDRJo1f8yrPOlrD2TDpObYTF4ubd3gD+R01gzU+Fk+JrKc2PWb+8M6N/51Vzwgp/0bW3rcbDC0gm1/LpuTjhoNTW1MuahxZlSYcavb6q0+3n0Sal0LRITU0vCco9j4i3UPvN0+P1965YuOMp0HzCpRDObN9hhAPHaaE5j1I7XZ4FzHPCqnJ9OHqKGFwYtTa+2/C/cSFP/nELFtBtiiwE9AEO8OkP4XOXOqxIfQTbBCij4Sw0mq/TNlXIlJ2Z0KtThrbH691gWWMRDRnmOweJe8EI3BcTdwhMDzbHZ3X++90N/Yb+xMVY04WiAAlv1NbsbqIYrI/JSJxmaia6dfsLcddcFRvA045q+HwxuudDvrh0Tj9WizfpVEMnVX0M0UDV59W2olS2I1tN07J3RFYuILncX5/KciRUwmvworYAnF6RPk4dhGpdIHVYkLh83Bxcngq5nglAa4UBx/OhNitV/7LNuhQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(5023799004)(921020)(11063799006)(4143699003)(261102123227099003)(261028144727099003)(261026121527099003)(261022075727099003)(261026140227099003)(261009223027099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVErN3lmNG1BdXlFTVdkNmw2S2cvQkxxc3VybUgrSXhKdWNtcEhoY0c5Q1Zw?=
 =?utf-8?B?SXFUMVIyVWUrVmM2Y1RDT1JlcGs3bG1NTFYvamVYQTRFQ3lDM1JFRHIydHU2?=
 =?utf-8?B?Ym5SMjlEYmNVQVV0ZlVaZWlTMDZWODM5SzVJRjN2TnNXaGVJa09JV04wUUNp?=
 =?utf-8?B?WUNKdWVtZGs3a0Y4Znlpd2daTmJidU0wUUd2MUx6eWlRdkNsazJWME16SVk2?=
 =?utf-8?B?d3hSMy85YjlWSkVONXpnb3Q0NkF3KytETXliMlQ2ckNXdGNXZVp2M25kNCt2?=
 =?utf-8?B?K1lHdDFUc3N1a2RGWGJBclNKMnBnckVNYW9HMFFmRVd3eTlLV1R6RUdSU0dw?=
 =?utf-8?B?MmlZNldzdDl3LzM4QVB3bVc2QTZZYmhKM1o1N3k2WHpQd0dEUUpHR3lSbStu?=
 =?utf-8?B?SWwzekNLRHEyUENxOTRoaGNhaHZJcjhIdnpXcWdoNGRlWlJoVkFETnhpbTJt?=
 =?utf-8?B?ZytpY3BYS0JmVzJ1OVkyK1pvNTZDdGpWL1g5UVJQa1NNdjFNejYwbVozaFpl?=
 =?utf-8?B?T1AxSWVhcHRvNkJMdGRSTi9aL3pQK2lzd2hMYmp2Y3ltMTJSUVlRd3lJbzRs?=
 =?utf-8?B?ZFZCTVlLb3JDdEZBSzRSU292NmxlQ2FWbGpYY1dFSEtYbm5nOHhZWkVKdGR2?=
 =?utf-8?B?Nkx0STZmaTFpZ0FIV2I4eDFLekJXbXJsU2YrYktpZHlvMnNDK2dXOUFIVjA1?=
 =?utf-8?B?NkpScmU4Rm1mM0s3ZEZlQ0UxbFkxbldWNnI5MmJ0dFBCOCtRNHdaVGxNZU1Y?=
 =?utf-8?B?QXZPbE1qSXZpVEllaTN5QlhoeEtQTDJac2pzaHdTcXRtNzd1YU05eTZXa1o1?=
 =?utf-8?B?VmxYUVNnVDdxS0hkRDExSG9qSlEvOS9ickpaa0dkWG95Tk1rZ3gwdGhucTEz?=
 =?utf-8?B?a3B4N1lJK1NhblJMQVg0U04zYXlYeGtneHNzSUJ3ck5PTklsTW05TFhaYmhM?=
 =?utf-8?B?ZVZWUGEzMDJ2Nml1dGpRRVRyYXltODRZTTVEakVZWnRkVHlKcGpBa1JXUnRk?=
 =?utf-8?B?U2tRby9lOGxPalZWdkt6cllZZHorVWdZTUJ4c3NBamhhekpvODdMMDZ1RUZI?=
 =?utf-8?B?c2tTK1pxNXM1ZndzeVdyQnc0TnJMTnloT3pFL25jUE1GNXhRWW1zQytEK1ZY?=
 =?utf-8?B?MWJRQkRkV3grdDYrdVNOc2FRQ1hKK3J1bDFtS29nUVNDUW9rMHZWZWhlUW5E?=
 =?utf-8?B?eXpaNjRpNGxLRnlEdmZVaW10bFJ3T1dOcE4xa2R0RXUxdng5RCtkNWV5MHhF?=
 =?utf-8?B?Tkhtc3krZjliSWQ4aVNlVjg0dGJBRG43RUhZcmkrRkNPMGhvK2dCOW91eTNm?=
 =?utf-8?B?MERQSUk0WUNUcVlRTk93LzNwTENCYVAwYkhoU0tncVBSdEpqcnhSaDhQWjZJ?=
 =?utf-8?B?b0Y2NTBobG5HZVhpU0x5NVJPRWNta1piNGhYbkc0TmVOZ0tDRmhxMWcxejJm?=
 =?utf-8?B?dEE3dTJuNit2cHE2SzhySC9CeFVzLzFvQlljT2RTa0craGc0aUpSSnBoQWw3?=
 =?utf-8?B?emJ0WTFRSEpNN3ZXOThab3N3RGpLYTZYYWpSRVVRTjNwT0FuWE8zTjBlVk9G?=
 =?utf-8?B?US83RGNzNktwaUR5eUZCcnFKck9kUmZZRGN3c1FybmwzaGtKc1hZMzIvRmJV?=
 =?utf-8?B?L2paRVR0NDlFT0x3UEg3Sk8wakJQcVgxRURVVlp6VXRSdkY0dytmY2ptN3J0?=
 =?utf-8?B?d3RlK21FdDdQdmF6OGhrT3ZDZXNSaktmZ2RrMEtia0hoN3p0ZktNaFpjV0lH?=
 =?utf-8?B?YjRqYWVZY1R2dEt3QkN4ZjhqVml0dkZDMWdxd01kb0VEMjliRnJCNko0b2hD?=
 =?utf-8?B?dThRZlB1dm85Q3hkcjVWV1pwSTRIVGRkb2l6VTVPL1A2cUIzZExVN2JkMFZI?=
 =?utf-8?B?SitjeDZIaUVENnorckpwT1ErT2ZUMDdlNFhoUFFDMmxCbGtLSWxrbjBTeXEv?=
 =?utf-8?B?M2JoOTBPbGlValJ4cDJXUXI1S0h6alBjcllEQUNyUlFLd2F4T3ZJUXNpT2k3?=
 =?utf-8?B?c0tadjJHNW1FSVZaTkg5dU5VUlgxOCtLc2NvUVFJWWRwWW9YcW9lVzNGcU1i?=
 =?utf-8?B?NFByZys0ekpQZHBBNkI1bFhydDV5REMrWDlvQWNwNkFVYjNESy9XNE14TkFj?=
 =?utf-8?B?dzVBRmo0bVo4MTRXL1J1djV6YmVsbDAreFE4bnE2QUxwVDJmMmRZSCt6cERj?=
 =?utf-8?B?V1RjVGRtbVk1UXF1SXRCTDVrdStHMGJpNXlJNit3SExqbEQyQWUyaEIrcDJN?=
 =?utf-8?B?SmVxczBZZHpDR1kveTBUbjhjcTJwVy9oeUd0V3JsTFhtL2NJa2F3SUo5cXE3?=
 =?utf-8?B?dk5adWtGaFJpZlA5bkFLclJiR25jdkQ0eURCeUxtSnQ1NWE4NUlWUEZXa3Iy?=
 =?utf-8?Q?JEWkLnjP1udtUyLM=3D?=
X-Exchange-RoutingPolicyChecked: zm3jfE8vJgf3vIfgf/7NqSz6yM4brxakVZcX1OiGnlyD8IumT/EMg9wOUErd1sV6xRAIsDzQdj8zleASDq9aQj0rnQZjrYChFBoTXfJqAwEX6TIk90+V1wj+kSMfCggtFq62X1ZpSoZnduFSwj/1WJ2lzlkA9uDVQTqeraHcLugaGB9RCXrQegT37ppWx9J4DUyxBG7IWqx7zq/Go7enWthwALrrReVUL/icpFYUtUqgwIYFpx2LwHH2YuQbSTfkBZbuWDUhYpjN+obFqTlzCPYGFwGtYvbqMFCBXx8Z03K2TdouCVVn4HY5PWtI2gw+hkXRTTUM0JkrftJy34UOBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d8dcc2-5ce2-4c6f-c81f-08df3b6bb5e8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 18:36:31.0792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYRfQfdGfIpryxBT+Bm8i8lv/cweMWWBo/bYX4xHfZ3UwFN+0oZINRBsc9JqPjLFeGH79Sk7vKICuaapxO2W7uOGBmJbfbfGRXIq63d1wEc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9204
X-OriginatorOrg: intel.com

On 11/5/2026 12:04 AM, bot+bpf-ci@kernel.org wrote:
>> net: mark skb NAPI IDs independently of busy polling
> 
> TL;DR: Commit message only: it blames e68b6e50fa35 for gating skb NAPI IDs on
> busy polling, but that gating predates it; 97dc7cd92ac6 introduced the
> dependency. Suggests rewording.
> 
>>     net: mark skb NAPI IDs independently of busy polling
>>
>>     Commit 97dc7cd92ac6 ("ptp: Support late timestamp determination")
>>     added support for deferring RX timestamp conversion to
>>     ndo_get_tstamp(). When the timestamp is consumed, get_timestamp()
>>     uses the skb's NAPI ID to find the device that owns the timestamp
>>     cookie and invoke its callback.
>>     Commit e68b6e50fa35 ("udp: enable busy polling for all sockets")
>>     gated NAPI ID bookkeeping with CONFIG_NET_RX_BUSY_POLL. As a result,
>>     when busy polling is disabled, the skb may not carry a usable NAPI ID.
>>     The device lookup then fails, so the driver callback is not invoked.
>>     get_timestamp() falls back to hwtstamp, which does not contain the
>>     converted timestamp, resulting in an incorrect RX hardware timestamp.
>>     Record skb NAPI IDs independently of busy-poll support to support
>>     drivers that use deferred timestamp conversion and future driver
>>     features that need to look up a device by its NAPI ID.
>>     Signed-off-by: Ding Meng <meng.ding@siemens.com>
>>     Reviewed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
> 
> This isn't a bug, but is e68b6e50fa35 the right commit to name here?
> 
> Before that commit, __skb_mark_napi_id() / skb_mark_napi_id() was already
> inside '#ifdef CONFIG_NET_RX_BUSY_POLL' with an empty stub in the #else
> branch, and struct sk_buff already had napi_id under
> '#if defined(CONFIG_NET_RX_BUSY_POLL) || defined(CONFIG_XPS)'.  That gating
> goes back to 8b80cda536ea ("net: rename ll methods to busy-poll").
> 
> e68b6e50fa35 only moved the socket-side sk_mark_napi_id() out of the ifdef
> block and added sk_mark_napi_id_once().  Both act on sk->sk_napi_id, not on
> the skb.
> 
> It is also about six years older than 97dc7cd92ac6, so the message reads as
> if a later change broke the deferred-timestamp lookup.  In fact
> get_timestamp() has depended on a busy-poll-only skb field (skb_napi_id()
> returns 0 when CONFIG_NET_RX_BUSY_POLL=n) since 97dc7cd92ac6 added it.
> 
> Could the message say that the skb NAPI ID was always busy-poll-only and
> that 97dc7cd92ac6 started depending on it?
> 

I think the AI is reading a bit much into the commit message. Clearly
the bug is that 97dc7cd92ac6 depends on busy polling. The wording could
be slightly more precise to not imply that e68b6e50fa35 actually
introduced a problem, but I think that is a bit of a nitpick, and not
worth a reroll of this work unless something else needs to change.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41989099174

