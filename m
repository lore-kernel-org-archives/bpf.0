Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C64A2638;
	Fri, 25 Sep 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343055; cv=fail; b=DoypHCoONHuAv5MkB13nsvxDYjBtxtI+RyRBeS6ImqL4jHL6Fand2PzYu4dYDlBqUDQS9/hiMCYTvG6CUFvOTkbnpSAaAExdS2vPgbt2gQ2zac4G1JNiM0eO491kK9XTLXenaGBqSE3RLLqlvslaywQBOhjsQv3XesTTL7/0Zwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343055; c=relaxed/simple;
	bh=+4a0hdrF6RbtFhK6Gdue/d8c3busPWExaaWgzO4UZDs=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Nd53ZVKJV/jNchofCTW3UK+vdcbVOLNAjQL1Oa2NvtnQaGxyr6l+OAKTtC/W3uWzz5yW/T0vMFR1MHvPSiVsoW8VK8vQiMvcuiFuzUj9dAOgQ4r+3m2n5mJ/bvuuvZluJ8FdlwXgBfjrIiZxfv0JH7hvAdVnTWTIKP75eOf50Dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dbpp0RwS; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dbpp0RwS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790343053; x=1821879053;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=+4a0hdrF6RbtFhK6Gdue/d8c3busPWExaaWgzO4UZDs=;
  b=Dbpp0RwSmwqwq6j9tMwscZ/tQDSX7zBb7gRsbyfUQTMtsO5FXR9cTeXG
   7tUXhknyn2hkebIeRv0pDDV/le5xLhk+SjAbM1jh8jnwR7jBrgT7mnDQe
   Ad2cRFmKRU40vuE7s25zFMQg1RuFjGxewLSuRwH9QScHAXEpvT8xDcHua
   fIJ8iSKqAR32pHeE5lDxY31Pb+G4myDkRwkLnjrZpBvxIjju0QWjKjxJX
   rJeQP5eCs6bceiLG1ZlhpJV0/PmIQ8Cx/47/lchQItanCMn0uZBtu52Zp
   vB5QLCCxY/A+nPJPXVm8HvlROg+QdTKnqYsuyhgcYdTe1FkRBLgPCDMJT
   w==;
X-CSE-ConnectionGUID: pOaDugVKSnWreSRtYR847w==
X-CSE-MsgGUID: ujmaEBPXT16qJan6HQmpeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90991440"
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="90991440"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 06:30:53 -0700
X-CSE-ConnectionGUID: tA0rHkCUSO6juVt58ZA+iw==
X-CSE-MsgGUID: kxkp+de6QLi0wZ2Tuv8KxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,122,1787036400"; 
   d="scan'208";a="303843851"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2026 06:30:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 06:30:51 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 25 Sep 2026 06:30:51 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 25 Sep 2026 06:30:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5XEiJy0JPe8oGr20hnmIfa6OZX/wjNRjGv1DVdavyZka14BUhicnFVEMkz5XF43Vn3EnRV6VyuG3t8V0prBAqlv9O7ut0UH2m3J3TJWctzczn2s6o1Y0y4QFL8/tc1PEQGl6bvbFH2wTCg0FmSQU2aT8TKcVzgxtQ+BOlFa35FOrEneBg9zEoeoM2preU5Q1ZDethYKHbUZGodvJ25oZnLX4Z5bd/s/XMQ6ftMRBerDaRb5btq69wLVPJYbraFQfY5vFVWrJBPQyIaZCruwjWZ7q26zQJtBhIDJs/mu+mjs7LYxAY3l+4oatm8YVjBiKa8X+9iZ4eLXEns4v5popg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0r82HT7pHjWnP22CfUsajAD1BN2rp/FqvQ17DvncK4=;
 b=y6t4OczOjNDEjpaMD8r51U3jlyGht+Awwa5QsvLk7PS7bRHesd4YcHqHnn4tGQ01cegpEUEZsIic47hy+d02hZWgUqMG6v+lj9H0p3OlWsGA4IPJ5z9Pi1FW+9RHJhBu/5rN5SqPyAf84kG/LEmQN4UL0LOIV5nnCkZCNYqfjf3CmP0LyasQCxu80E2krt99CXGR0JhF+kna1LVLV9JyacsTCAHf9VL226mZ85Pcho+pCpoq58yaAScDLQnmjsdmCFR5sZm66iFNY5dgkhBibFVGkk/VWG9yXNi3LBeMfDs3U078O1dM/2bGxxThAq0BFkXuDI+0FUF1DeaHXXXIdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 IA3PR11MB8940.namprd11.prod.outlook.com (2603:10b6:208:57e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.18; Fri, 25 Sep 2026 13:30:47 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d9b3:e942:2686:3cdd%6]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 13:30:44 +0000
Date: Fri, 25 Sep 2026 15:30:32 +0200
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
Subject: Re: [PATCH net 2/8] i40e: avoid null ptr dereference in
 i40e_ptp_stop()
Message-ID: <arZ3eIpeEXM2qFKv@boxer>
References: <20260918212458.550425-3-anthony.l.nguyen@intel.com>
 <179004066689.2160803.12484884497586238643@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179004066689.2160803.12484884497586238643@kernel.org>
X-ClientProxiedBy: DU2PR04CA0176.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::31) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|IA3PR11MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1d38f0-e81e-4856-4008-08df1b0933b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|4143699003|10067099003|5023799004|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: A0e4EYrI4GzHtt+LQ7rOk+3v2BnRN+4Oa8ElVWlFLUzjWn2tJrVoM9Qqus8veewdIOGcSb4r7mQBXKHpbVeZP3CY6X4MVfh+rpHvGv7up+DcQ7HFQZ4DqriT7LJEbNRJpwmKeAlFiQ/P4ge/7WBqf6qN9V90hLkb5KyffGcR5nLEX4NnrDf5umwdRmW9GIp/iEX1RX2OmyiCp39a1qNcHqwWV0aXNR+W/V072nCKcK+wg9UaULTdbygpYID5adpG2Iead+WSR53s1oOG4qlfdD6MkBm86sJIXtalnox01J0/vWOglWMURcCzj4bOdEgNmDqiYRuGVM8hO7KEsFRC3AV59MPnq6elxN7Vk9O6i3SfIlk5s/ucIRqiQRSykqZc9sKlkQNOTRgAI1IBgNvaf/P5JnvDkKt/JFWkc8qs5Fup53Q4JoKIeINC/z3EELNxorDgNChAkCw+ec625EEC5wPZUNFYX5VPiF50EgMOKRd7JwhoAgfhqKv4QdcCGgx1l9scKLKIDvwAm9e4HCXCe594sRmHJmGGpU2+L/OM4svvWC/XarE4qZTJh5cg60S9AJLZjdZToUbR5r6W3qFojj2Wt+BVMyOyOzubDVnE3GF4rM+v1yma71Blh9MIPrHZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(4143699003)(10067099003)(5023799004)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2E3bzY2TC94SWpFa29DN2FaU0ZTT3Q4dW14QWYrTDRmMllHRXR4dXUyYjFt?=
 =?utf-8?B?UkZqUUhaVDA0TExaSW51b09wVjVvV2lKeEpsZGxiNHU2eXdiVUFqeXBuSVRO?=
 =?utf-8?B?ZXQ2SUoyQzJqeUFsOGhhSXhWTWY1ZTlOckJFUEhGQWhNbTNoNEhMVTRKYWpO?=
 =?utf-8?B?cmY2ZlpHVExpSGprd2txV3RIUS9PTEZPNVUzMzJsdURtOXQ3SDEwcWs4Wlgz?=
 =?utf-8?B?NTEzdU1rRXUwWUpIQzh0OVF6eGloeVBOT2F4aGxheUlDdG4zcXJqMkVMN01G?=
 =?utf-8?B?ZFEva0VxUlV5MzQ5aFJiR0NFQWNjVHZnd0h6Wk10S1cwT2ZDODNjUUlJZW9i?=
 =?utf-8?B?RnlhenRBQkhwc0d3NGd0T2IwT28rUS95bThDWlNTMU5mVUZpQnN6KzlkL3ZP?=
 =?utf-8?B?UlMxbnZsMkNFY3dJUWZCRjI3cnZ0OEVSQ3hIUmJkVEdnakFXeFlwMjFIV1dj?=
 =?utf-8?B?UUtWL2hXcTZnZ250YUJsMENXb24yZTcrUjJZRk1BbDFYN0FSSEc3a3dxaThp?=
 =?utf-8?B?UUxydnFGYkgvcUQ5OVpUVmxXSzd6enNNeERXTjBVV3NPZGxGY2h0NTJWZFNP?=
 =?utf-8?B?N3J0MWFTcjVVaCtWOWQ1dHV0YTUzT1p4WjM4Tzl3bU5sREdKdm55Z2cxUWdS?=
 =?utf-8?B?YXZ1UWQ2cnM2eW1iV0xSaVBubjFyK1MxVUVwd1JhNjFFRjZubXJqRjI4TlpN?=
 =?utf-8?B?ZG8ybm1VWDliSm8zeThabVFVNEdlNEdoVE5qaUNTWlFCM0xHbzh2R2FjbU1X?=
 =?utf-8?B?eHhsOEJRTlVZWlpkaGl2NkxBYkZxcDRqa1Npc2ErWDEvdTZkNDBLOCtIQmNG?=
 =?utf-8?B?SmNXSGlhaXl2bk1MYzZEdVV2RVNneTVQWWZhend2aDZnZVp5ellwa3kwZnVj?=
 =?utf-8?B?VWpqTTRVZnBmaWp0bDVKZjFlVUFXamlYZXk0VWJ6QVBhN2xTOWN6OTBCWUts?=
 =?utf-8?B?WWJIZU5iWVA0TWR5ZW54Mlg0UWt1cnVMMkdmK2xya3YvTWlKT09rQzhVUStL?=
 =?utf-8?B?aTJNZWozdU42UWVuaXNxSklmZG43eTczcDBTczJ0ZnRWRmFFZkdUeG1iM1kw?=
 =?utf-8?B?OS9qUC9kaUFJbXNLWUhqNS9ib1dWaWJ5a0l1aEN6S01ZSnBtTE8xdWNmelpt?=
 =?utf-8?B?eEVsUDA0TGJ4QlM2elZzVDl4aFgyZUpWcWVxRUpzaWlTdTVBN2RwaHdBc3RS?=
 =?utf-8?B?YUYwWWU3M3FaYjI0L3lVZ2J2Q3ZEUTJ0dlFqcFlmN3Z6TUNENklXLzlsakpI?=
 =?utf-8?B?N1pLdVRwMXRQU1NuQWdhRXpYcTJ1N3UxbW02N2VVdVpodDFlREtPZDM5eGtm?=
 =?utf-8?B?bWs3bkxuRXVYZXl3T1dtK0Z5R09WRmtvOGF1ZmxJWENFTHFtd29XeUU1SnB6?=
 =?utf-8?B?UTF2Q25zbHlJeFhCT2FCSm1JMVdqWkM2ZE05aGY0TGN1RDR0K3FxRXpQT1ZW?=
 =?utf-8?B?bkNTMzUzTmJVVGVlUTZHdlVjdXhBanlXRXhRNW9MRkRmYytDUStNTUx6eDRr?=
 =?utf-8?B?c09oRm1wcWRncGNSY1B5ZXpxcHJzc3FGeDlHTjdaL254R0ExNmtYQWFHQnZq?=
 =?utf-8?B?bS95eHNVdWtZK3pBVjhXMFoyd0ltL2dVc0w4Yjc2RGlGTkF6VytNY1d1cGI4?=
 =?utf-8?B?YkhpajlROTdpTHhMS3A0TGp2dkJFNWE1MzgyYWpqSGpaZWFGVGsvc2ZHbWVi?=
 =?utf-8?B?WElVQXVCQTZBRFhXSlBsekw1cFp3b1JKVDBMVEdZYTMzN0duZWJVR0VCUjFF?=
 =?utf-8?B?eHhucXgvMzhqQnptYUR6bU5MeG9EVnVEaTJWTThmelZnWGp0MWN3NW5qRGw5?=
 =?utf-8?B?SitCdlEranJLQWVRM1BQSWJjWWhSQ3lWcXd1RUJjMGQ4Y2RxdXpFMk9JVVBC?=
 =?utf-8?B?V0xvQS9IcU85NkwxS3ZxQ3hRdHRhTjhya0RIbkZoNEZvZGRNYVNkL1BHWEs2?=
 =?utf-8?B?MnQ0K3kreXdXQ1FxNlJxN1ZMU3lKUWVHR2tQVlhmNTl5ei9KVkxlS1VoSkhT?=
 =?utf-8?B?SzFubEI2ZmZtREFNUGVyalloTkFKbnpteWNGRlVWRjJ3M0Qra3BzT211bHhH?=
 =?utf-8?B?TVdwUWU3bjFBTXhiQWdzZldSby9wQWFkVDBNcHo1UUpYZjE0U0RWbHg2aS9C?=
 =?utf-8?B?T0N1ZDlKbTVvQ04ra3Y3MDB1WE5HY0dENE5Ublhra3JPT2FFVlVpRjV0MnZu?=
 =?utf-8?B?eXFLNnJCRzFpS0x0LzQ1MTF6ZXpyWnFyWHpxdEpCY1ZMQ2lwaXZzeGtVQk5k?=
 =?utf-8?B?TjhtL3YwcmlqSEhScVR4RFlvaTVUd2hzMXRSb2tOMlZWTUFvcS80akVJMGFs?=
 =?utf-8?B?WlZySEUxaDdFZ2pSc09LYWRkUGRkbWV2Z29tU1RMTGdKeU9nM0VwbE1GdEhR?=
 =?utf-8?Q?EIZ/JNQUHHyrpgX0=3D?=
X-Exchange-RoutingPolicyChecked: ESdrsM/F6cpHtgYU/BoyVcQEMTOX2pHJSNPILDeE2YMcZOjr0DcoBOqqrCZxweup12om58/8F7os2YyICTj52/KZW5F6R49/53TxoYn55huoUoSMKHRZ1KvpbC2Di7TJXxzqAkOqXibKXy/wOJZe3AUedxtvU8SLJ8lMJVGyqo8Z9zNWtvaZmwX6K/Fmtlm53E04zQ+FoqVytcO6zQ5eNX3nlNylD90KhcN9KGFSRqvUpr3wN04NBtZeQGpafEKzXBjwljpN36ARGBZ9f8hiGIlH5AFrY/peXauSwRnPFpZei+E6dsO40lUmzsyxJwvt4PO3em5r4ulvbWRi6b4qcw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1d38f0-e81e-4856-4008-08df1b0933b6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 13:30:44.7196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQthLpfW9IdUbdA9IWg7HpoITZZwZwSB8blJOSAIEaZfSKLAmN6LrMEfgAa5djd23pnjrnUov19ZpS9J9lVJDNvV84GEpmSTd64hNrQ5b0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8940
X-OriginatorOrg: intel.com

On Tue, Sep 22, 2026 at 01:31:06AM +0000, netdev-bot+sashiko@kernel.org wrote:
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
> - [Medium] Symptom-only fix: when `i40e_rebuild()` aborts because the
>   main VSI could not be re-created, the PTP subsystem is left in an…
> 
> --
> 
> i40e: avoid null ptr dereference in i40e_ptp_stop()
> 
> If the main VSI cannot be re-created during a reset, i40e_rebuild() aborts
> after i40e_vsi_clear() has freed the main VSI, so a later i40e_remove()
> calls i40e_ptp_stop() with pf->vsi[pf->lan_vsi] == NULL.  The patch adds a
> main_vsi NULL check around the dev_info() that dereferences
> main_vsi->netdev->name.
> 
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > index ff62b5f2c815..ca93df4d6785 100644
> > --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> > @@ -1556,8 +1556,9 @@ void i40e_ptp_stop(struct i40e_pf *pf)
> >  	if (pf->ptp_clock) {
> >  		ptp_clock_unregister(pf->ptp_clock);
> >  		pf->ptp_clock = NULL;
> > -		dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
> > -			 main_vsi->netdev->name);
> > +		if (main_vsi)
> > +			dev_info(&pf->pdev->dev, "%s: removed PHC on %s\n", __func__,
> > +				 main_vsi->netdev->name);
> >  	}
> 
> [Severity: Medium]
> 
> Is guarding the log message here enough, or does it just make the window
> between the failed rebuild and the eventual remove survivable?
> 
> In that window nothing appears to touch PTP at all.  i40e_ptp_stop() has
> only two callers, i40e_probe() (error path) and i40e_remove(), and none of
> the abort paths in i40e_rebuild() (end_unlock / end_core_reset /
> clear_recovery) call i40e_ptp_init() or i40e_ptp_stop():
> 
> drivers/net/ethernet/intel/i40e/i40e_main.c:i40e_setup_pf_switch() {
> 	...
> 		if (!main_vsi) {
> 			dev_info(&pf->pdev->dev, "setup of MAIN VSI failed\n");
> 			i40e_cloud_filter_exit(pf);
> 			i40e_fdir_teardown(pf);
> 			return -EAGAIN;
> 		}
> 	...
> }
> 
> Across the reset, the only PTP action is i40e_prep_for_reset() calling
> i40e_ptp_save_hw_time(), which is a pure read.
> 
> So after the abort, pf->ptp_clock stays registered and I40E_FLAG_PTP_ENA,
> pf->ptp_tx, pf->ptp_rx and pf->tstamp_config stay set, even though the main
> VSI and its netdev were freed, and the register programming that
> i40e_ptp_init() normally redoes after a reset never runs:
> 
> drivers/net/ethernet/intel/i40e/i40e_ptp.c:i40e_ptp_init() {
> 	...
> 		regval = rd32(hw, I40E_PRTTSYN_CTL0);
> 		regval |= I40E_PRTTSYN_CTL0_TSYNENA_MASK;
> 		wr32(hw, I40E_PRTTSYN_CTL0, regval);
> 	...
> }
> 
> i40e_ptp_set_increment(), i40e_ptp_set_timestamp_mode(),
> i40e_ptp_restore_hw_time() and i40e_ptp_set_1pps_signal_hw() are skipped in
> the same way, and i40e_ptp_init()'s own kerneldoc describes it as
> reconfiguring the device after a reset.
> 
> Does that leave userspace with an openable /dev/ptpN whose gettime/settime/
> adjfine operate on a timesync block the reset left disabled, and PF flags
> still advertising timestamping that hardware will not deliver?  A Tx
> timestamp request in that state would set __I40E_PTP_TX_IN_PROGRESS for a
> timestamp that never arrives, recovered only by the watchdog.
> 
> Would it be better to quiesce PTP on the rebuild-failure path, for example
> unregistering the PHC or at least clearing I40E_FLAG_PTP_ENA, rather than
> adding a NULL check per consumer?  As written, every future user of the main
> VSI or of the PTP state in this window needs its own check.

I didn't want to touch ptp initially and this commit was rather to satisfy
sashiko (which was successful!) and here the broader concern is being
raised and I suppose I won't escape from addressing this :<

> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260918212458.550425-1-anthony.l.nguyen%40intel.com
