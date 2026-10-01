Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DDCB530E14;
	Thu,  1 Oct 2026 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869458; cv=fail; b=qXFwNOHCEZxDy7AoqhC9hkw52CSKrdiCMnHtkhN7ZqxTkK5IZf9hid5tyMB9kRLsGY8I6Ip6qZTOT13DGEd2iNTFx2pC+RgsGpHYh4OnAXLfJHXeSAkoLnkIGEiqdrbLHovDaiHqZkwAjyumu08H68onbZUeMwjLRInIQGm5B1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869458; c=relaxed/simple;
	bh=ODbEKku7zmG/ZKzW/47VBp0DV/nfYQfsHJnIEX8BRRw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EDQzy8mTehdMk3TSTGiDmmpkA97/rcpquhMN+G9ob6+vBDc0xda+AMDPdZhz5jykSlXylx8iaERNj6ixavpVucPraVB1AjlvmE0Q2OwTObWi5so1KXf34mr7CzLjCiaQKHtNN7F1mTaGRzNzqCytPmnTiKfMatWQ8dqYsXTODmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fr4SfhvA; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fr4SfhvA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790869453; x=1822405453;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ODbEKku7zmG/ZKzW/47VBp0DV/nfYQfsHJnIEX8BRRw=;
  b=fr4SfhvAFp+0kveYCMex0cz9yCeuXlAmtXPWToPXAkxhCPErCVnDINVW
   9i8MlYPrQmtFMbywG7xPxJf+x9wiZBjEGmtmWFqJzZHgYSjkpxupCYBsp
   F6rj87V33mshbKTKdyPz2malW4q3DLl/AA/+Ggs1kPOwiKfT9du5CXoZ/
   sSCOTr3PhDTXl6QLFWB+FngZ+nbMkzf7hThDNrJ7oCN4fRZe4iDRJdyia
   /gdbtU9lTMOOrliwRAttWnbE+m2NLmayP4VpMtQsZnBVmYJZqWb1bhuMa
   M0rK+Rw+bg07bIGRujMXNGSMotMX4NWpjqiezMUi0+fZf0NX4LmI1efSA
   g==;
X-CSE-ConnectionGUID: VINQA5zTSlSyczExP4IhUA==
X-CSE-MsgGUID: O3pN3FNTROSQDBKDgOy9Yw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90582315"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="90582315"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 08:44:12 -0700
X-CSE-ConnectionGUID: hITx0bMnQ3uls5nbM8hM9g==
X-CSE-MsgGUID: PbPi59MwR/iFi4r5oXDsGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; 
   d="scan'208";a="276137384"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 08:44:11 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 08:44:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 08:44:11 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.9) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 08:44:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKUG798czz50SxG53WLfA5K+4Q6lwxwNtP0q8+i8oIrK5KnC1djZW5BSynV3NnCN1JSm+gl+hbLhq9LHT+ZqJeii3e1PVd5YhSpIBlWa/ukulBWrsRSP6HJez8G4jAG9QoOofchGzHw2DU3A+cYS8It+E3iuKnNgdy5fNs7bq3pzxpeVlscfEsfXKFHnJ0rVQK0UaoTs2kTEv7/CXlhdZRSwEMmJYQORvxwWvQPlU1irmzh8upzAO+vviEDKbBL8PQNuKsMaEGhmFPlYJJaDOxE1Uwe1VXXiBd1umyZwuJA93IjfCYVl+tJdNMWfLo/L3DW+iD7D0KGf28OLMBE6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5ppQLPLcUPJv3IC0RdObsZsx06w9K9iCcZgJVW79LU=;
 b=U3NIzDArjcabaUTAy59TVQDd1qKUd8MzJe1cjs8/5kFl8uoacgVX++yJoaFVpuVDNM/kleAf7gwb6TArCGk3z3wiQEfKNMMs7uvkfrCNX/SOJSdi5oRyjZD3SFm04uIdK94TPJ6zh8KiNZ8n9/QOX0qcai8XlJs+KO7d4C+QT++pjpGDdzNVjw3NBGkc5Eas1Vyy8evLar6/CcRoPp0Qxf2ir6zumefkU1HJFKHt8MyQAKCq8+a6K/N88Gremr3UxlyLITHae5JyY6BT7dphqCl9DVzZvCY1R3hgQaG+au3rjk0nXsgnVhpdY+0RcbohFNKJ5Mx4BTuP57K2HB/VCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by BL3PR11MB6410.namprd11.prod.outlook.com (2603:10b6:208:3b9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 15:43:56 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0451.014; Thu, 1 Oct 2026
 15:43:56 +0000
Message-ID: <e967306a-0505-4f14-9041-5056d00bd8bb@intel.com>
Date: Thu, 1 Oct 2026 17:43:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] idpf: add flow-based XDP fallback for FWs
 without Tx FIFO support
To: <sashiko-reviews@lists.linux.dev>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20260929231305.1515873-1-anthony.l.nguyen@intel.com>
 <20260929231305.1515873-2-anthony.l.nguyen@intel.com>
 <20260930231331.1E2051F000FF@smtp.kernel.org>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260930231331.1E2051F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0024.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::8)
 To DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|BL3PR11MB6410:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ecbe9b-a8ea-449a-09ae-08df1fd2cd72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|4143699003|11063799006|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: r1wkSURn6sHClnNCSFmDpvzK51t7jmla9+zy3X5vDWaLMXsRlNezNRs1zRL+4UeK5nMnubhR++4F48Z4fOMxy27Al+633GyxAWL3BDnPGif95TZgZjiqm+O195E7T86rMc8QkfM8zYgQFY6+/mIf7pJwcjSDSWKJDgluccx5SBjBueiku7Oa+IhAoSXARw605abw6YFxp8RSPMEczWAe6FoEVtOGSZw3bl4+YVmUZt4MxlTljsmquYP0LTerCFKcbCU6bIYZqm4MtemmJ/KvtdR/HV0HIBQsvfP6h5UJTOEkVuEupmzZv7ZFDaRGcmemNpaQwAy7XFwrM6FZoWp5WXnE4h/6zI0e/LoVERvXY1/ZKS2q8g2vstewC1OUxXFTzkWC6beT/uB2BOlHOjijZeqOMyZe+l17GRNNV6SB0I+vetRvze9XT4ydBQDJ2T0lljw/yAx1d98dWo8X5g9rbxcHlh51lpeEZESIb+fSxtwuC0p9kqzxEq1Q4PwGZBTzuVHd8tnSMwLX8A71jlYjMKNJG3qRBKScoeYU0mewnuCpZx6wV26Sl1PF1aFH9GAAF73Srt8vQ6aA3PNqUvph/fImcMPMM7cHharqny/QRgTa1agifUZwtL2vfuPoFqh4LG+wEC0I8UuwS6ZU8JWsO+ZIuTtWOpEITrksAUoz2Do=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(4143699003)(11063799006)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2JpSUhhK1NFZ3RRcEFoc2ZhQjNvazI5UVZjUi90Rjdxb24xdjI3ZWRsMW1p?=
 =?utf-8?B?ZUZGWnVOUUNpbGJmTmVkUEdWK3FjT045Y2pEYVB6Q2VEb0JqTVJOUStrbnZC?=
 =?utf-8?B?UVNWaUZXT1FmTDlUZGhNdzVVVlc0WXN2a3pFNHYxTUU3UDN3RGQvSlpJTC9h?=
 =?utf-8?B?REpObEkrYkZIL2J6a0R5ZFloVjBtOFJCQ3dqUk04RE9ma3RPVVZhMzFyeDJi?=
 =?utf-8?B?dHdHNVp4alpPUE9nTFpQZmdRODQxRXhuR2JLZzFadFRKNmRVY09wd1I4MWFQ?=
 =?utf-8?B?SkJCcVBZU0pTb0I1YUNuMHlhb1htcnlpYVRhWDV6YXNDU3NjRnQwYnBUUzQx?=
 =?utf-8?B?MkhLWmE1WmgvWkp4TWFCUU12eGtSZmxkOTZJeTl3T2lqK3lPQXF5QjA0Njg0?=
 =?utf-8?B?d2t3QXhJcmZPTjN0SzJ6WkxUN0tLcTlmK2dkaW1UT2lQa0x6bkxmWEhrc05B?=
 =?utf-8?B?cEFzTFJ4WUtweWlDQlBQZVJMU1NMOVhUQ3IvZ0hwRThmNjBwZ21GVVRxUjda?=
 =?utf-8?B?bWJUSjlrUmpVOEt3L2Q5S2cwVkU0NEtZUTM1WXptS0R5NXNYc3RpZ3pJTUF2?=
 =?utf-8?B?UGRuRlpJNkZiYmhVZXNpVlpEejJmMm9pd1dzS0lBektWRlhEQU5QakQ0L3Bm?=
 =?utf-8?B?djF5TStzY1pvWDhpS3NKcGU2dGo5cVB5TXlVSUoxVUJPNXl0T2V3R3dHVFlU?=
 =?utf-8?B?eUFQa3JRajJXMW1PN3FNcVFHNnFzMk1HUFgxVWc0UUdMTnIzRm1xZVRnS0sx?=
 =?utf-8?B?aCtTaGExRVRIVmN3ZWVmT3RlMkN6Z2piaDVBSkJOSnFGMTBVb3lpbnpNZTBi?=
 =?utf-8?B?UGFoRGI1MStKNksyMW1mOStYa3YxMFZvbnA4dzlJeFU5SHJRQitWZzJOaVZF?=
 =?utf-8?B?SUxVWnNyczVTQUttQ1NRdlZ2bU5YdkFPNGZrSms0R1NKRXpnRUo3MGJRT2pv?=
 =?utf-8?B?U3Z5anRiaHFmOXlkU2FFTHpzdXJMU0pJMEs3elVBWCtsRzZ3WnJDUVhwbEJo?=
 =?utf-8?B?dll5bisxc2tiTWNJd3ZCUXdtcllFSjZjS1I0Z2NTY00zdm5IUHBmdzB0aWsv?=
 =?utf-8?B?STM0a1grUXQzOFhtL3BMMTBuQ25NQVR2NG1pWW83WUlkZXFtbkJhNEI4cEp0?=
 =?utf-8?B?RDRUeklaWXMwZWZYSkJyODczY1RuUlM0MWY0WHppYXlpSU5xRHNsYll1dUdj?=
 =?utf-8?B?OTF3c3dDNjBnMENhSTVwcUhlN1JCMnh6emVXNWFZZVpIZE51TXVTc0pXWFFx?=
 =?utf-8?B?eitTUlBvV1FLUlBZRGp2eDJmUlJQTFlIY2s2enI4UURhVjVxUmlkazhROFQ3?=
 =?utf-8?B?c1UxVE1IOFFLRXdrdWVPZ1hRc2F6K0prZ09ySStHWFB3dGZQUzJhOUw3L3lJ?=
 =?utf-8?B?OGc2bEV4RVo1N2t1Z1pFcFNEVzVTRm1WMTIrWStvNXBDY2trWERXNG5UaS9H?=
 =?utf-8?B?b0d2R1V6cDZmWDRPTXdOSTRuT1JYNFdlakZDK0dBY1hYb21NbDlEZW9SYXRp?=
 =?utf-8?B?aFIydzJtRGRZSVJrZzErMk55S0JUTHZyNE51ckIrLzdnckswVklpYXgxV1la?=
 =?utf-8?B?ckRDakc4azNRM3ArYTZiU1I3QUNINU1QWDd5N2NnUmc5Zkk0OURqcER6RUtN?=
 =?utf-8?B?YmkzdlVxTjFjSTI5M2E4YVA2Uzd2c2pIbG5HVlNKaW9ydXc1cnlDeFh6RXZw?=
 =?utf-8?B?TWpxc3g5aU9kOGFoQ1RNN29FVUdGS1hhTnpJN1pUQmdUaEFJRVZ0WUdGN0ZZ?=
 =?utf-8?B?STdCbGdPcUNGL05CN1QyUC85ZE9EVlI4WVkwMUhLQVRHbXdiNG1jZ2MyR29X?=
 =?utf-8?B?Z2liLys0ZU1wd1FkWUdUSXlKUE1oWlcwVmJoZWNWTS92SDdrdnYxYnZPa2pK?=
 =?utf-8?B?ZTRxM0w4eUVlRDBUWHhxTDNwbW1CZU9mem04YXFaYWpPR0tTQ1Q5WXZRKzR1?=
 =?utf-8?B?RkFjc25EOHk5b2VzMTlEUEZoTTZYNlJjNWdmVHN3VnRKYWg1MEVrUThiQWda?=
 =?utf-8?B?cEpWbmUweDd2MFZqbzBIN3U0OU9aVGJDbXVmVTJHUWFEbWNualhyNExjcUhl?=
 =?utf-8?B?RERDdENOZVhlVEVOamYyQ1AvUmVrY1N5MVN4T1hEOHRUTXFyOWpMM09YZ3dX?=
 =?utf-8?B?NjlNY1hNcURwM2R3UElINEpnaCtRc1V5aCt5UUUxbTdOKzJqLzVEUFNpR0Z0?=
 =?utf-8?B?TkpDSXpQdXE5aDh2dHl4N1haZ3l3WlozaWVXcHBBdVFnMTZxdWNvTldzb0hI?=
 =?utf-8?B?VFVjUDBkWUFHMHhEN1RHZlhOLy9zUzJURTBtSUg2dFlUeGJzWU5EL0ZLa243?=
 =?utf-8?B?ZnJjSGhIck5uMEw4YWtXYjYxcjFOdUxoaHpUbkF5WjRsWnorVUo2aVlhOHJ1?=
 =?utf-8?Q?bdfAE+fTnQz1Gw24=3D?=
X-Exchange-RoutingPolicyChecked: v/ga53QfqH2b/xK959qfXd++YRVw6pfnFCaQvF5c9YEr7aRhPWvwJzOvUR71JZYjREg+0WLmsAcot86cLAC46SjpmvVNrpyxRMd7ZsyFUbWgr4JPXO12QGNZBo3mi+kwLwcDWApO7BTZpBDJK9AawQ/Td1Op6QXS8IL6OFHFd/0I151qTVYfs3PecKweUAAoRVOltpCLI+qFmUjNMmgkc36b5giKrJzgjx0dB4VRqOQ04LQmYeTJItK3nfGrucw6owcTC0R/+0yjrToOxE4cXOAzHeHL5C6Wn243ldqp71FqxGUgdk4gghQvLU9gaHbL/pmstc91lYF3hVCcErKeuA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ecbe9b-a8ea-449a-09ae-08df1fd2cd72
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 15:43:56.4123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKOthbgSwnUpFMnZmOAtyJiOe8DLY5dr3/J3SBl4yc4sdZA1BlNtYhqevG5i0Qvo21xGvSKcRp7OOutrZYdetJyNQMdJG7eTRIXqVZcw1lQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6410
X-OriginatorOrg: intel.com

From: Sashiko-Bot <sashiko-bot@kernel.org>
Date: Wed, 30 Sep 2026 23:13:30 +0000

> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] idpf: data race on pending_mask and last_ntu in XDP Tx finalize
> - [High] idpf: out-of-bounds write in idpf_xdpsq_poll_fb due to unvalidated completion tag
> - [Medium] idpf: mixing goto-based cleanup and __free() in idpf_xdpsqs_get

I think this already appeared earlier and I replied to these a while ago?

> --
> 
> commit 512d4db75f1d8f6ab37619b2712b334a77a2df35
> Author: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> idpf: add flow-based XDP fallback for FWs without Tx FIFO support
> 
> This commit introduces a static-key guarded flow-based XDP fallback for
> firmware that lacks queue-based scheduling support. It generates a
> completion for each Tx descriptor and serializes them using a dynamically
> allocated bitmap.
> 
>> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
>> index cbccd45467681..c771663677a52 100644
>> --- a/drivers/net/ethernet/intel/idpf/xdp.c
>> +++ b/drivers/net/ethernet/intel/idpf/xdp.c
>> @@ -149,10 +151,12 @@ void idpf_xdp_copy_prog_to_rqs(const struct idpf_q_vec_rsrc *rsrc,
>>  
>>  static void idpf_xdp_tx_timer(struct work_struct *work);
>>  
>> -int idpf_xdpsqs_get(const struct idpf_vport *vport)
>> +int idpf_xdpsqs_get(struct idpf_vport *vport)
>>  {
>>  	struct libeth_xdpsq_timer **timers __free(kvfree) = NULL;
>> -	struct net_device *dev;
>> +	unsigned long **masks __free(kvfree) = NULL;
> 
> [ ... ]
> 
>> +	masks = kvzalloc_objs(*masks, vport->num_xdp_txq);
>> +	if (!masks)
>> +		goto err_masks;
> 
> [ ... ]
> 
>> +err_masks:
> 
> [Severity: Medium]
> Is it safe to mix goto statements with __free() scope-based cleanups in
> idpf_xdpsqs_get?

Safe. __free() can be used only to automatically cleanup pointers that
are on the stack. Here we have 2 dynamically-allocated arrays of
pointers, then can't be cleaned up that way.

> 
> The cleanup subsystem guidelines recommend that functions should either use
> scope-based cleanups entirely or rely on goto-based cleanups, but never
> mix both. Mixing them can lead to confusing ownership semantics and
> double-free or resource leak bugs.
> 
>> +	vport->xdpsq_fb = false;
>> +
>> +	for (u32 i = 0; i < vport->num_xdp_txq; i++)
>> +		kfree(timers[i]);
>> +
>> +	return -ENOMEM;
>>  }
> 
> [ ... ]
> 
>> @@ -250,6 +308,65 @@ static int idpf_xdp_parse_cqe(const struct idpf_splitq_4b_tx_compl_desc *desc,
>>  	return upper_16_bits(val);
>>  }
>>  
>> +static u32 idpf_xdpsq_poll_fb(struct idpf_tx_queue *xdpsq, u32 budget)
>> +{
> 
> [ ... ]
> 
>> +	for (done_frames = 0; done_frames < budget; ) {
>> +		int ret;
>> +
>> +		ret = idpf_xdp_parse_cqe(&cq->comp[ntc].common, gen);
>> +		if (ret >= 0) {
>> +			__clear_bit(ret, mask);
> 
> [Severity: High]
> Could this result in an out-of-bounds write?
> 
> The 16-bit completion tag parsed from hardware by idpf_xdp_parse_cqe() is
> used directly as an index for __clear_bit(). Since the mask is sized based
> on desc_count, a completion tag larger than desc_count returned from the
> hardware or firmware might cause an out-of-bounds write in the kernel
> heap.

HW never returns tags larger than desc_count because we actually set
these tags when filling Tx descriptors -- a completion descriptor only
carries the tag which was written by us to the corresponding Tx descriptor.

> 
> Should the tag value be validated against desc_count before using it as a
> bitmap index?
> 
>> +			done_frames++;
> 
> 
>> diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
>> index 63e56f7d43e00..95e47ea2ccba8 100644
>> --- a/drivers/net/ethernet/intel/idpf/xdp.h
>> +++ b/drivers/net/ethernet/intel/idpf/xdp.h
>> @@ -93,12 +93,34 @@ static inline void idpf_xdp_tx_xmit(struct libeth_xdp_tx_desc desc, u32 i,
>>  #endif
>>  }
>>  
>> -static inline void idpf_xdpsq_set_rs(const struct idpf_tx_queue *xdpsq)
>> +static inline void idpf_xdpsq_set_rs_fb(struct idpf_tx_queue *xdpsq)
>> +{
>> +	u32 ntu = xdpsq->next_to_use;
>> +	u32 old = xdpsq->last_ntu;
>> +
>> +	if (old > ntu) {
>> +		bitmap_set(xdpsq->pending_mask, old, xdpsq->desc_count - old);
> 
> [Severity: High]
> Could there be a data race on pending_mask and last_ntu here?
> 
> When idpf_xdp_tx_finalize() calls idpf_xdpsq_set_rs_fb(), the xdp_lock may
> have already been released (for example, by the bulk flush callback).

idpf_xdp_tx_finalize() takes the lock.

> 
> If multiple CPUs submit XDP frames concurrently when xdpsq_share is true,
> it appears we could have unprotected, concurrent, non-atomic bitmap_set()
> operations and updates to last_ntu. This might also race with the
> __clear_bit() operations from the consumer context in
> idpf_xdpsq_poll_fb().

idpf_xdpsq_poll_fb() is called by prep callbacks, all of them take the lock.

> 
>> +		if (ntu)
>> +			bitmap_set(xdpsq->pending_mask, 0, ntu);
>> +	} else {
>> +		bitmap_set(xdpsq->pending_mask, old, ntu - old);
>> +	}
>> +
>> +	xdpsq->last_ntu = ntu;
>> +}

Thanks,
Olek
