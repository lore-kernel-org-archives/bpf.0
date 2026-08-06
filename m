Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2725D31986C;
	Thu,  6 Aug 2026 07:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786000775; cv=fail; b=nwqaDAmIUc2ha4KfvMha9yEaJ8aQhRf4gVouzyHJChYF8JARs2526ZG84JAIHy4XTvauWneohpTdU8R+EQ5J5fw8Y56n7XEF5JwsILga4VyozuXdamddOPkZulEat6YBXXyAqNGropjMWzbE9780HtfjQSS57UOqFzFFOsC4TVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786000775; c=relaxed/simple;
	bh=+61jj+TRXzeOPZbo2jlhvgXCG9adsSQ6sXyGbIYPhBk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=g+nUKqZQ8EvdHYD6JKnsX6ZhYtPd9CskUMIrVp0w+Mmofzc44f+6d5nWdvNcOOuEf28X6TT65bAcBMfxr3EClnpSa3VPH/OEtCK6SyXrPzB8RlzFkYEz6vlUXzoLmv1zunHf0GCO/GNrFECQ7P9Z6TWJD6Yf2e3QT13dbpzqJ5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cvw7r8RL; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cvw7r8RL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786000773; x=1817536773;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+61jj+TRXzeOPZbo2jlhvgXCG9adsSQ6sXyGbIYPhBk=;
  b=cvw7r8RLw9UrdvMeYkQfA2NHNCOGapFQvGfHwgWyH0H5BVgFLL7u3N6j
   VFdBQZ9/UGCisFGPAdcAWbsIoceuDU7irHh9My6bCWXrvNMiQj2JEE63w
   0BgOEEvAvlAmyDuIeMgfJCFN4bYkLrzZZ/VoL2ZuqZ4XNvrHnqT+sjFjR
   915sMI8I85A9lCfDAQR42eR1ONgFauZxU93NE4ApGIK8Yq24dW2EstCIj
   ZQT50O6eM63jw0l1B1GFN0wGW1HcNW+mkqh0dnpVMsEYvnVHMZxFgM7fA
   G8p7xoIuWG88UM9ksik1lX8OgsuXc2HsRU/oFypbvFpjdbJ/OYOapSKEC
   g==;
X-CSE-ConnectionGUID: wqpUBL0USWat7bej5zCS2w==
X-CSE-MsgGUID: Jc6aMhXFToKqgGfdvNQNFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="90258758"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="90258758"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 00:19:32 -0700
X-CSE-ConnectionGUID: epz84rhERzWJzH3D8UnWUw==
X-CSE-MsgGUID: wB1a+kGPSbexOVJNJwHd4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="266246852"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 00:19:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 00:19:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 00:19:32 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.9) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 00:19:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opMhCXYi74yuqBerZFLJQrZycw6BkUvsgN90ao3c5wDVryjmyGfaWmlESWQ0f/f38QnQakO/RDiF++aew9ZjAJRb1fXZ+5k0kBKaE1UV2oR31u5TmBf4Wsw8p4NzzPl1Ch4bbOQN1/bmh2VK80UgMZLERPxlBKAHJYgr5K3PQ7ZjQkP0ek4oc43R1+IK1FptCw3BOIOGatLL4gjc+Fq1ana4clqeyxJcusJ/BEEFLwdKPFhGCojYKtpXisPOS4+WcdrmPfchS02vZdo3NBebszqPLG3r75UXLbYdO7qOvoHCu4P30IOJsAKR+IJ0tOhpxAOCLA8iQSpXGzfH94Hvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cvPPFbQwztfDzAW1c+sYbwrKOiWlL5oHdUm//8KCM8=;
 b=nNrrgeh9Lgtr3T9w0VS4ub9ne58uWZliMotnKQzbIU9/WJWLwEwAEfCoPML0ejv/CLA6WcPFLJKw150NqI0z+u0avB+H9UdB6fph0yJWMHMPc6JxLey/6uHklbsWC7Q9M/tHKMXNsI55t9ZZ1wezu2Yhx0dv4cxjnEa5XS7YFazJn36LWjh2wB8fBgbL9nlMZvxIoSBtrN3u6/e2N3RTCOLSjjnns70IB961BfhO5J4U3QbMRHyshP3LgG+7tGmivEiUEHazAZIw3KgJFEXVK2ukRfzriHBCMBQZMiufnGR53BEsQVR8Iihe6aKXWiI41nuagTNNF8N9Q9sLYi2cxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by DS4PPF93A1BBECD.namprd11.prod.outlook.com (2603:10b6:f:fc02::3c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 07:19:24 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0270.017; Thu, 6 Aug 2026
 07:19:23 +0000
Message-ID: <6bb3205d-e9b9-4f18-8d8a-5bde4d014084@intel.com>
Date: Thu, 6 Aug 2026 09:19:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/15] gve: add struct gve_device_info to hold
 device properties
To: Harshitha Ramamurthy <hramamurthy@google.com>, <netdev@vger.kernel.org>
CC: <joshwash@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <sdf@fomichev.me>, <jordanrhee@google.com>,
	<willemb@google.com>, <nktgrg@google.com>, <maolson@google.com>,
	<thostet@google.com>, <jacob.e.keller@intel.com>, <debarghyak@google.com>,
	<kees@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260803184630.3813311-1-hramamurthy@google.com>
 <20260803184630.3813311-5-hramamurthy@google.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260803184630.3813311-5-hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0098.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::29) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|DS4PPF93A1BBECD:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2d5b39-1031-4028-e7cc-08def38b0a32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|23010399003|366016|11063799006|6133799003|4143699003|10067099003|18002099003|22082099003|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: /7picoTbkVg5RnSeEVatf0gXZhflvQGQCKY5aASlrSB0dZKwrnamHcHDbmK3maoyzlrf7ctwdtECv/HwF7UfHvkmLmygiuG9JvwUmIGp4q6dCteyHovzb2Cg2Hm/I6BA7gsJPGdpWOnfLO6LCIQLD8sBCEM5QZnu7X2nxb1yO4osr766/gLW+w1eF3+nrWKrPpSQe1QkESyC5OSkquACGb/1231SoxbcDRQe8qs+Mv6nmX1WmiD8cEKrQ3pOtRGsPsbCJcayUHlDb5Eaf8SWqnq085K1FVJPdqfyUmVG8gDFT52neX6Xng2gVgurcy93FNBgCT0n6h+8Y7KkXgV734o0oXXV0qC1qIZgajRgehCac5FDpUuRL86FT5lzeIJqU9/Zw8JsrtxY205OP468gTVqtdph63q2tflEnQghMw4MZd+9eGGMFwUxBQu1s0NdTa0PQr6Ik/fs0FMRAgx/WDh0WiQMGKwXHpzsKlJ+7y6cF2EQjRUKLKaXzbA6jpFo4NYgXZfmIqBxcmyrzO1bMykSMGrUulDee1LVs2sawcmJ/6YXrxRpLLB3G9ydvhxzo5cjwLKW9YS3f97+cREcfoAeH38HPTQV7srTBclcKQBSdFLcSdgyopO/WzlVwPpewaTeOqwWkPqfbK1hGjm/2OYBCXHDtclvxrFyERi7aCg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(23010399003)(366016)(11063799006)(6133799003)(4143699003)(10067099003)(18002099003)(22082099003)(56012099006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qy9rSm9YOUhKRFJOSWFNSTB4OUhzLyt5dHVDa0lLOE5KcW1ZUzdUNlNNcUN2?=
 =?utf-8?B?Ry9lMVN6NHZMNUJBQTZLR3IxdUZzQVUwelR0NUpaSjJTVm03L05SUDhqSnhS?=
 =?utf-8?B?ZU1JWDlNMlhsRkE5OVZNL3BMRG1DRXpUTlJTY3RKdFgwR0tJeEw3RWVYREFU?=
 =?utf-8?B?MmpRa1p2YnpJVEczRXB1MUkvWUo1ZlNjb25acVFZTWh3VVN1MEpadFdMKytU?=
 =?utf-8?B?WWR4UmtOVlRoYXZPdmkzdDBuWW1iM3pPRytJOVhMaEl1WTEvOHowaWRreDN2?=
 =?utf-8?B?cVp4NEFkWkc4dTdWS2VqbS9LTTJIbmVudFp2YVhKcURJOVJzM24zUnZxMnNX?=
 =?utf-8?B?ckRpa1hxT014SndNM3FwK0Zpb3BjSTk3YUdzTGdZcUVkM29qUHdQajFzcWtz?=
 =?utf-8?B?Z0ZYYWhtOGR1OS9Yc3RlVlRySzZZbHQxbmNIeVJ6ajN5NFZvS2xQN2taVSts?=
 =?utf-8?B?Sng2MFA5UGI5S3BZclNWdWx4RWNaVHFkZ2tkUUdWclAveEoxdDI1eU13NWYr?=
 =?utf-8?B?Y0pvYk14akVFUkxuWHhZQWpBOWtYRnZWMHVib0hybCtrRnVWckJnbVhzK1Ro?=
 =?utf-8?B?M25hNUJoOFRLdmgxaHdTbTNGNkp2NzZTQ3V3Ris0VmN1UjhONi9aNUJYMUJH?=
 =?utf-8?B?LzJRdVBKbTlFWmV2eTJickhZVVNidmdYOVBUMmFHdGJ5OWVSb1czUDJHb0cv?=
 =?utf-8?B?TlJ3RmxaUG5iQUxOSy9PVW9WbVFqS0Z5RTg0NklTYkJiUjYyRUlNQ3lGT3Va?=
 =?utf-8?B?VmRUdnAvdW1yTmNnNFZ3L3FuSHo4R293ZE1iOGg3RTZEYkRqV0Z4TTFoK3FJ?=
 =?utf-8?B?OFlLOFVzUmJaK09aaVF4bk1pdXhKNlJvVWxsTGh6RUw0RDgzMTc2RmZqbEdh?=
 =?utf-8?B?QUpqU1RtWVJ0Qi9iWFo1ZSs2K3Z3cWcwaXlhajZzWlZkaElNVzFKSm5pVUNo?=
 =?utf-8?B?YUowY1lhOHlkYXBkVW8vZmpOdEdCV05JaG9UMnA5UUx4NHdJZ1R5UVZxQnJw?=
 =?utf-8?B?dW9pYlVHbU9JVXdmWEZQRml1aENQaDZaTkYvRVpqNWw3KzQ1VThLTlhHL25t?=
 =?utf-8?B?Zno4MXo0WjN3cmtPZTVJQVdPUkZraVh0czBUQzBDR0cwdHcreERGaTlRclRW?=
 =?utf-8?B?TmhOZDAvTkFqZ1JDb0w3d3k3OVRlNlcwOVB4SHk1R3hNS1VsRXRaMHZNdDhs?=
 =?utf-8?B?dXRReHBISDU1LzhtdzBZWUZFa2d5a09jSmNXRXJNeWplSlFuRm1OVmZEcmZl?=
 =?utf-8?B?c1NyZzV5dUVGWG9QYTVVVXl4RnNiUUU2UXF0Wmx4czdLRWFDSEhGNlVOVys1?=
 =?utf-8?B?S2p1OUx6cXA0ZFl4WnpGcWZQWWZ0TVdnc2VtZkFjVWRZV3NBaEk3Q0Y3TGtF?=
 =?utf-8?B?cmhlVk5McUlZOWZnZXRMM2NreHN1Mmt2dHluUjlPc3RLRFJHMms3ODNFR0xu?=
 =?utf-8?B?N2RVSlRGc3dSRkdVaGxsb3JweUpOdDluMnFYTDRwL3lTZDkyUXBWUUNqSXI0?=
 =?utf-8?B?ZDhpZVovME92NlFqYklrR2ZreExtSXRESllHOThYOXVab29tWU44bVJVaHpj?=
 =?utf-8?B?ZWM4dW40MlBvMDE4R3haZDlSTnAzd2tUQW9QZklSNjMrU2tmRmw2bUlUT2lQ?=
 =?utf-8?B?VkhPOU9TNmx6OVR3TEhVOW1jV3FuNWZYRC81bFI0MUpTMk9OeU5DSE5CZDdU?=
 =?utf-8?B?aDZjRXY0Y2FVZE02RHIwMThNOENSRWdDa0ZqM0MrZkQ0NHVnU2tzODJkVFBr?=
 =?utf-8?B?Q1Y2ekFmVGdSMVVoTDYycHdKdkx1dTFYWG1NL2h3S2JIOHg0ck0rckZXdFJC?=
 =?utf-8?B?bUlOeG9uTU5mbXRla1o1MHRMcTM0ckplNWVoTlp3bnptVzAyYUVMTUY4WWhU?=
 =?utf-8?B?WDJvZ2tiVXVSc1M0STV3VExPUnA0ZURnUEgrcFRCWnFOYWF5OVlhMXlOeW5N?=
 =?utf-8?B?NEtPTEN2Z2tnVlhJQ2xXTXNUSU5id3k2WVFBS2NLS0o1Y2JnY2k4KzVpc2p0?=
 =?utf-8?B?d1lxYnNwbUNJSWZXNER1b3BNRHN4Rk5kV3dhWnZWU1dGdURQMkVwOHZaRFE5?=
 =?utf-8?B?TWdzTGJ6NFQ0WWM2ejlhcy9mQWIvUVZoSWZaZXRIZGxpVFk1dEV6bGk0T2w0?=
 =?utf-8?B?aWJIbi9yMVJ4NGpoOExDTW1IdC82ZjVGZEN2akFQUytSUlJlalRNaEtUczZY?=
 =?utf-8?B?MURueXJieWF4TE1QUjZUa25TUWlEODRKbnpHc3hoNm5rVzVyZG5lblNsaFhZ?=
 =?utf-8?B?eEJYQzVlRlZUTmJWM0dVb3lTVnVOR1hnYUcyczMvMTRra3h2NmVHMU1Uc1Uv?=
 =?utf-8?B?TG9IalBzakl1TEtwOEU1cG45akR6MTV5QjJINkM0azMrSXpwNWQvdmlja2Rn?=
 =?utf-8?Q?2i/e9OmhIZmGMpFo=3D?=
X-Exchange-RoutingPolicyChecked: JMxqE2gOZmKOYkPyhKBQeq8fT4dJhMxlFqZ/vkHdshjytJovPI2Q2rSej/kaY5bXlnJ6thzbkIRd3GxeyUzoC3D5VTH5ljCG0HiHtjQcTMCcrNq3nQwLyIrCUEALghhDO1W+mwiVdwhd8Fe4Vk72XBwy8KWVvVLw7PxON20VLLDUVrPkPtCuvivbPvL7XSatki0n6IJPcybu35snXjNGEe/illlVK+iy53jKv/4KzuPH9xsoQxEAdblaMNaiQM5B9mal/19/ele+vJHBge9SeUQo2MdoNWGXjO1NWvKi+emjQvC1JSdXDXVAfkaOMWC6GcsleLHtQEVFvWbuAgj9Cw==
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2d5b39-1031-4028-e7cc-08def38b0a32
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 07:19:23.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5fBHULMi4VPIwmUNItQYDCX/Pqc3HbcQC7Iu4I1MiXBmCW0fpNHX8QYUoqLhOkYHWWdrmq7YO78d52+vI/dQYeLxnmpxxqUhsFEgSansTME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF93A1BBECD
X-OriginatorOrg: intel.com

On 8/3/26 20:46, Harshitha Ramamurthy wrote:
> In the current AdminQ mode, device properties are written into
> struct gve_device_descriptor that is allocated in shared memory
> between the driver and device. In the upcoming MailboxQ mode,
> these properties will be returned in the response of a mailbox
> message. Hence, add struct gve_device_info as the structure that
> holds all the properties that are negotiated with the device in
> either mode.
> 
> Change the AdminQ mode method gve_adminq_describe_device()
> and its children to fill up device information into this newly
> introduced struct gve_device_info. Move a few helper functions
> and code that set device properties in the priv structure into
> gve_init_priv(). So now gve_init_priv() calls/does the following:
> 
> - gve_set_mtu()
> - gve_set_mac()
> - gve_set_queue_properties()
> - gve_set_buf_sizes()
> - set flow steering and RSS properties
> - set other priv properties
> 
> When MailboxQ support is added, device information will be filled
> into the same structure and the same gve_init_priv() path would be
> used to set device properties to ensure common code reusage.
> 
> These changes are refactors only, no functional change.
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
> Changes in v3:
> - Read default_min_ring_size from device info instead of priv
> 
>   drivers/net/ethernet/google/gve/gve.h        |  29 +++++
>   drivers/net/ethernet/google/gve/gve_adminq.c | 115 +++++++++++--------
>   drivers/net/ethernet/google/gve/gve_adminq.h |   6 -
>   drivers/net/ethernet/google/gve/gve_main.c   | 101 +++++++++++-----
>   4 files changed, 170 insertions(+), 81 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index c280ff35ee77..021adb9108df 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -797,6 +797,34 @@ struct gve_ptp {
>   	struct gve_priv *priv;
>   };
>   
> +struct gve_device_info {
> +	enum gve_queue_format queue_format;
> +	u16 default_tx_queues;
> +	u16 default_rx_queues;
> +	u16 max_tx_queues;
> +	u16 max_rx_queues;
> +	u16 default_tx_ring_size;
> +	u16 default_rx_ring_size;
> +	u16 max_tx_ring_size;
> +	u16 max_rx_ring_size;
> +	u16 min_tx_ring_size;
> +	u16 min_rx_ring_size;
> +	u16 max_mtu;
> +	u8 mac[ETH_ALEN];
> +	u16 max_rx_buffer_size;
> +	u16 header_buf_size;
> +	u32 max_flow_rules;
> +	u16 rss_key_size;
> +	u16 rss_lut_size;
> +	u16 tx_pages_per_qpl;
> +	u16 num_event_counters;
> +	u64 max_registered_pages;
> +	bool default_min_ring_size;
> +	bool nic_timestamp_supported;
> +	bool modify_ring_size_enabled;
> +	bool cache_rss_config;
> +};

you could save some bytes of the struct size by reordering fields

> +
>   struct gve_priv {
>   	struct net_device *dev;
>   	struct gve_tx_ring *tx; /* array of tx_cfg.num_queues */
> @@ -929,6 +957,7 @@ struct gve_priv {
>   	struct gve_nic_ts_report *nic_ts_report;
>   	dma_addr_t nic_ts_report_bus;
>   	u64 last_sync_nic_counter; /* Clock counter from last NIC TS report */
> +	struct gve_device_info device_info;
>   };


[..]

> -int gve_set_mtu(struct gve_priv *priv,
> -		struct gve_device_descriptor *descriptor)
> +static int gve_set_mtu(struct gve_priv *priv)
>   {
> +	struct gve_device_info *device_info = &priv->device_info;
>   	u16 mtu;
>   
> -	mtu = be16_to_cpu(descriptor->mtu);
> +	mtu = device_info->max_mtu;
>   	if (mtu < ETH_MIN_MTU) {
>   		dev_err(&priv->pdev->dev, "MTU %d below minimum MTU\n", mtu);
>   		return -EINVAL;
>   	}
>   	priv->dev->max_mtu = mtu;
> +	priv->dev->mtu = priv->dev->max_mtu;

nit: I would just use `= mtu`

>   
>   	return 0;
>   }
>   
> -void gve_set_mac(struct gve_priv *priv,
> -		 struct gve_device_descriptor *descriptor)
> +static void gve_set_mac(struct gve_priv *priv)
>   {
> -	eth_hw_addr_set(priv->dev, descriptor->mac);
> -	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", descriptor->mac);
> +	struct gve_device_info *device_info = &priv->device_info;
> +
> +	eth_hw_addr_set(priv->dev, device_info->mac);
> +	dev_info(&priv->pdev->dev, "MAC addr: %pM\n", device_info->mac);
> +}

whole function is rewritten (in git sense), and it was just added in
previous commit

one way to avoid that is to extract "mac" variable in the prev patch,
and here only update the assignement and function signature

> +
> +static void gve_set_buf_sizes(struct gve_priv *priv)
> +{
> +	struct gve_device_info *device_info = &priv->device_info;
> +
> +	if (device_info->max_rx_buffer_size > priv->max_rx_buffer_size)
> +		priv->max_rx_buffer_size = device_info->max_rx_buffer_size;
> +
> +	if (gve_is_dqo(priv) &&
> +	    priv->max_rx_buffer_size > GVE_DEFAULT_RX_BUFFER_SIZE)
> +		priv->rx_cfg.packet_buffer_size = priv->max_rx_buffer_size;
> +
> +	if (device_info->header_buf_size)
> +		priv->header_buf_size = device_info->header_buf_size;
>   }
>   
>   static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
>   {
> +	struct gve_device_info *device_info = &priv->device_info;
>   	int err;
>   
>   	/* Set up the adminq */
> @@ -2514,7 +2533,7 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
>   	if (skip_describe_device)
>   		goto setup_device;
>   
> -	priv->queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
> +	device_info->queue_format = GVE_QUEUE_FORMAT_UNSPECIFIED;
>   	/* Get the initial information we need from the device */
>   	err = gve_adminq_describe_device(priv);
>   	if (err) {
> @@ -2523,6 +2542,8 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
>   		goto err;
>   	}
>   
> +	priv->queue_format = priv->device_info.queue_format;
> +
>   	err = gve_set_num_ntfy_blks(priv);
>   	if (err) {
>   		dev_err(&priv->pdev->dev,
> @@ -2546,12 +2567,34 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
>   		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
>   	}
>   
> -	priv->dev->mtu = priv->dev->max_mtu;
> +	if (gve_set_mtu(priv)) {
> +		err = -EINVAL;
> +		goto err;
> +	}
> +
> +	priv->num_event_counters = device_info->num_event_counters;
> +
> +	gve_set_mac(priv);
> +
> +	gve_set_queue_properties(priv);
> +	priv->modify_ring_size_enabled = device_info->modify_ring_size_enabled;
> +
> +	gve_set_buf_sizes(priv);
> +
> +	priv->max_flow_rules = device_info->max_flow_rules;
> +	if (priv->max_flow_rules)
> +		priv->dev->hw_features |= NETIF_F_NTUPLE;
> +
> +	priv->rss_key_size = device_info->rss_key_size;
> +	priv->rss_lut_size = device_info->rss_lut_size;
> +	priv->cache_rss_config = device_info->cache_rss_config;

I don't know, especially with your MailboxQ coming next, if following
makes sense, but I wonder why you have to copy whole device info into
priv (or IOW, hold two copies of most params)?

Alternative will be to use variables from device info everywhere,
you could even achieve that without any code changes via struct_group

> +
>   	priv->numa_node = dev_to_node(&priv->pdev->dev);
>   	priv->tx_cfg.num_xdp_queues = 0;
>   	priv->rx_copybreak = GVE_DEFAULT_RX_COPYBREAK;
>   	priv->ts_config.tx_type = HWTSTAMP_TX_OFF;
>   	priv->ts_config.rx_filter = HWTSTAMP_FILTER_NONE;
> +	priv->nic_timestamp_supported = device_info->nic_timestamp_supported;
>   
>   setup_device:
>   	priv->xsk_pools = bitmap_zalloc(priv->rx_cfg.max_queues, GFP_KERNEL);

