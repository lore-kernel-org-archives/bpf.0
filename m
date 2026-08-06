Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DABD386424;
	Thu,  6 Aug 2026 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786001622; cv=fail; b=oJ69sV9R48NPw71oPULLH2yIat71FHppe8J7GckhSfdATFGiJWlQo93Nfu5U65dqwh/O0Cxu255Ge69Xm39yzcUvmL/z9pfn42qp+SAg/DtXGzBVE5FmVuYWRvtDqsyaaVI9bDOhg+exljfsddPVgrLAX6NyiNbJ3L5xPfGt44g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786001622; c=relaxed/simple;
	bh=jlanj7qVFB128IXmYLuwBCAqpBEg7zkHn/DCJTe5eHM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SMPJHbbkYKQBXrEqiYUuTeZmPkmV2AskX1aEhp2qJOFWiIecnW2YVZAVO5iIZM08NOW8l7DheeyPS+HIFbc9Io9M9c3xJv7LfcZFnLlpr3t8iYmzy4WNkeWbt377xWfajE8/8WzCU5/c5kPFM7pQtPP9ZAkQ50htPs6SgOCb42E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O6ynkTgN; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O6ynkTgN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786001621; x=1817537621;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jlanj7qVFB128IXmYLuwBCAqpBEg7zkHn/DCJTe5eHM=;
  b=O6ynkTgN95EF8X7zJdrbF9vFCibeV6S2frp9Ab2NHvNjiGfkxzmB7U5X
   9oz0Y3W0JAKKx0b9T9IVX+7R/ruzJkTGOzFYhvmyxmIb5uUm00wY46ABH
   KXGXsC/iQQAbzZIc8MSaH0Mo9blB1YwWJykRjPbYMYAPHoGfIqsxkDVpJ
   0yIcmebDALgl1ZVkMdc1+vlan5nh2FS9uRBgO1/GKun8eQCwbnN8zF2hW
   IhTlYbBg51WFCl2tev5B2cVNdlTpdyNFwGI+pYni9kZHgEvaWsXqUHSRB
   y7dhEeVT0Qil6y4IM6yhPATicTdcGHvP0gQ3RMUs5FfmdWN4AwK9sqIas
   A==;
X-CSE-ConnectionGUID: eIU4Jq8gTH6XEN21/MlkGA==
X-CSE-MsgGUID: tgVZx5CdRHijPEgvTAT8vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="109377337"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="109377337"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 00:33:40 -0700
X-CSE-ConnectionGUID: 3bMtjDeESka/FZM7T0uQ7Q==
X-CSE-MsgGUID: lgfi86v+SviwAW8Egj7waw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="259406575"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 00:33:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 00:33:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 00:33:39 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 00:33:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FjxOOm5P89K/gCvLbqEmJ2N9/VPVjHQmmqlTB2YIXJ2QmrROFys3sjS1Xw4fptOcCwXFZhsvr271Nw5rJUv7+eJfmw6ZT7TObVFUoFQiPRdSQuHxHP5Fwieu426G0ymL5Nn7flASq/nNHv7AoqEKEG0GdRDr/eU79MwEb5ctN9XmiNqIgxN591lkhmSFBV81Bas3Vngu8rHLSav8wHt9W9o4zTi1/jOkn3FQJUf3XIHUaoDTp7SpXpw/rCeIvLg8SbT+eRniYkRDHbNQcRIArmIFTj3MRkWCPEIdhiLSat+oHZoUPBH0gQnRv6OeDGp/KHKT4fEWJnRz1yrrpP7J4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6giCS11exa0gYgiiA+ExBCtzqV6ABa8Co0LU4ldcId8=;
 b=BE+S4Gr1LDh0C6m52b1FRnXhHqe9F40hrJ+QRpCThXBXl0N4HcctzX7fqFcA7ONQLQ7AnyPGcdj/qvlEu7PSeWnVrH6Vr5n8MYD8q8wrHlM78ioyUfGsWC+76831L2Gt9B9Nf1ZyBrxSQ1r4nPCfHD9vpmcjP/01J/Fp/kB01KJ1cIH/YEwsMTtOsrmeco/V80WZ/sHcEphu72B91Ak5z0TtpL7iGrAOAEPDlrfEoLAhRfLmY5Qf6LM4v8jZbmr8SJYfZjuE3qpE43N+C6F8j3FtabDs/x25GJkG1T+PPfWA2jonGQ6h/qlVNEg2g68qQvv9kPK3IooeomMF3EMvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by SA3PR11MB8046.namprd11.prod.outlook.com (2603:10b6:806:2fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Thu, 6 Aug
 2026 07:33:30 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0270.017; Thu, 6 Aug 2026
 07:33:30 +0000
Message-ID: <045c0ac7-c784-4162-a01a-1a1d8f8377e7@intel.com>
Date: Thu, 6 Aug 2026 09:33:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 06/15] gve: introduce ctrl ops to set vectors
 and Qs
To: Harshitha Ramamurthy <hramamurthy@google.com>, <netdev@vger.kernel.org>
CC: <joshwash@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <sdf@fomichev.me>, <jordanrhee@google.com>,
	<willemb@google.com>, <nktgrg@google.com>, <maolson@google.com>,
	<thostet@google.com>, <jacob.e.keller@intel.com>, <debarghyak@google.com>,
	<kees@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260803184630.3813311-1-hramamurthy@google.com>
 <20260803184630.3813311-7-hramamurthy@google.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260803184630.3813311-7-hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::32) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|SA3PR11MB8046:EE_
X-MS-Office365-Filtering-Correlation-Id: c7e16a65-fb55-4b53-1f2d-08def38d032d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|22082099003|18002099003|11063799006|4143699003|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: qmKCEUDizAxF/fspCbb1XV+wOudtdbAbTgqIZrfzBWhb+N0iEddqZjzZZKfRnhG0s6rUSttOO9LEoYjwGfRrCSCXcc9qlm1PVR/Rk3gmwslwG/aNQiYG9iotGHLqKd55EJJTTob7likOjgLyxQNHiyEMev2tv9EKc6LS/uBbdkauV78HAKLjz4CtbyNPSV8iBZf051mJ1bCyn/o5qju6Nh+ENwGcjMfx1l6eZ9CjXuzO1/HriGJSRkZVF8LBgfr0w8s4Udh1RJjkTmpMEVmytOeYsf+vU8SbSU8OtmtUoqnNxJzPAWT0ifJBkeGINWMNAoOgtLDdpC14a9IzBpTF+KUFaqHBr21E4PRGUfg6VIuuDMLXLYhKE9J6a9BFy8+x+n1CiRUI6+PrQMGMQuMy2FTuBQcvH0vMA46t5UKQmMqPzw6ADwybJPZMXGujfLorF2Tqe7lxF9Xr/HqsHOmwoUX4xLvsVI6IZeqMODu+R6NxQginj5NfnhYLZbUG7X/yaTE9Dqz/xDf9W7sNz/OsLapOoJimVau/dovzWjH8OFk3XddVxI1Rg3kQ4TJ+MAt94vdwf4jR2y4D7RRHGMENrH8lFkRmSRhDnx6tByE9aglyrenH9N0xpMLWUwgrJBCfMr2I2F3xJTdWjdK5br+aqzjvTFPweZqcdt6Xvd6EtRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTRiT0VSNjY4cXA3NWMybG1mYkIyYUlLMFFORE8yVmJwcGlwNGp1anVwdVYy?=
 =?utf-8?B?eVQrUTFJRWwveStTMzdvOWV2cjNjSXFxelA5WnUra25MZk1xTkhkemk5dkMv?=
 =?utf-8?B?YkFWTnJVb0VTUnJtV1FJSDZoS240c080cG9XVlV1M1RCMkRDbTVocWljcVBx?=
 =?utf-8?B?YTFUeU5Mc0ZrYWVES3Q2aHJNNk5TMHRWaVp3K0RmSTk0T20zR3M4elZpTVZq?=
 =?utf-8?B?cGY5eFFwY1lseWFMUURIcWFtM0xSQzlsYk9JejN1ZmlDUENEblpFbUtxQXZU?=
 =?utf-8?B?Y1dCTDQ4VFRaUUZYSUw2TkVacU80SnkzRHBjVENYNHNyMUR0NmpEYW9qVWhq?=
 =?utf-8?B?aHZkeDB0OEFUTDl5OTVYNnhRL0xyQWNQZGtWaVZvZGs0ZXIyTTFzdHQzNisy?=
 =?utf-8?B?aDhURW5TWVd2c1E0SUtPaVFIYTNrbjg3MEw1Q0szM1F1Q0hMQ09sZ3p4a3ho?=
 =?utf-8?B?VFY3WnlJdXRXZGxQd1JrL3l1aGNYYUdGNTkzN1NrTWJPM3BsNE9aUjJkdlJF?=
 =?utf-8?B?cU5jd0FMcTdNL252WnNYSnB5MUdZaFgyK0VvNmRkNjNUWXRJbVJoeEZtamtp?=
 =?utf-8?B?b1dJZHFocXVrMlZiRVp0bGhmMDNRd2x5bGg1cW5EcE1aeWpKdTBkUy8rK0tI?=
 =?utf-8?B?WjlkbC9YRnFBSWMxVzF3MUw4RzNqQW84cms2c1g1amlmUTdCcERmRUV2Skd2?=
 =?utf-8?B?NG95eGs2eHlndXFSa1BWSFVZcnI5WnlYVVVOOWprQnpqZ3BjQlFYTXZqVldz?=
 =?utf-8?B?MDFuYlRUV2s1dFB0TGovNWpmbFl6c1V2Q09XV053dWRwWUFiZzFDS3haTld4?=
 =?utf-8?B?U3grY0prL051QTRTR09qa3ZKYkhKeGJQUjhYSGZnRkpOVFB1VUp0Z2RTV2dj?=
 =?utf-8?B?ZmpHcDZsbW9iRi9IdktQNUUybmxBMjJOT1FZc3QzbEJ1Y1A3WHlkQXhibzF4?=
 =?utf-8?B?YkhsSkRtTmNWdDZWdXBZb3FlT0dlWm1YcU9zaGhvZGNVTXlRdS9oSWJ6dFVO?=
 =?utf-8?B?a2VVRWdleThDd0dhU3lkelhXRFVSUVlLSmhCS2dQOE5xRkZncEpxcnRmSDkx?=
 =?utf-8?B?WkdHYml2RnlQc0FoSkE2Y2JXUmpOZ09rOURHSmFlVDcxci9aZnZSZkg2dkNM?=
 =?utf-8?B?WTRGMzV3bS9KdDRsaTdyeHc2cnhvbmRMam9BSWQxRlN5bm1nWFNiNjFEK0hy?=
 =?utf-8?B?ODhtaTVWK051Z2lodHEvRldPMURieUVSblpRL2o0QVhEcXROK1diTmx3U2pX?=
 =?utf-8?B?ajFVZzdEcTY5VldoOW92Y0RzQytqd09DS0x4eXdocEVtZ2hteVU3czNxaFpi?=
 =?utf-8?B?N3NtcU1jbjhQYWU4RkpZbnRQdjJORzIzbWtjUFdvN1luY1Z6S3NxZzRJSStZ?=
 =?utf-8?B?Wm0vazU2L2J0QSs4QW1OeE9TWC9TOWd4YkJWNWlSck1JUk5qcTRwQXJ6dkhv?=
 =?utf-8?B?Z0o5WXdueVVzQXhwZTF3MldSeWJleWZxME9UZTlRdUpwcm1oV1UvbVlzTmNp?=
 =?utf-8?B?V1VaRm5PNzhQNXNjRlptL1lYSnh5QVd6ODliSzVhbzI2M0N5TGxYRTNKbDRI?=
 =?utf-8?B?YzBLR2Jqck9XNHArQUo0NjJFV1VtQTdXeGJMeXFJbGw2eWlzWFArSUswV2VI?=
 =?utf-8?B?VEZVZHQxSFFMbWZyMmhGUXlkNVRaRzgxUVZnUitscUplTzhKQUFsYkVSczIz?=
 =?utf-8?B?aitqNGIyY3pCVW4wSlpnc1JkTGhuaExlZjR5Mll1OG9KanBQSEwyR1lNOVhz?=
 =?utf-8?B?bytjWDQycWxLZWZjSytYVVJwZXNQL3ZQeHdGM0p4em5iTkoyY0lxRmNQNUZI?=
 =?utf-8?B?VUlOb2swWEQzMkhTdEVwaDNPdDAxa3hDTlgzQ0FBRFVOOVdHNEluQmF5T1B0?=
 =?utf-8?B?SW5TS0QzY0xwY2JNVlN5ZnZvMXlBaWxLQzVySDBXLzAyOHhEUVVRaWZmWGZG?=
 =?utf-8?B?Um5rMWNZNS9hNmExV0FRcUZ5OHIzTlRrN2ZOQTg0NTNVUDIyb3h6eHFjMmhH?=
 =?utf-8?B?cUcwazYxU2xqSDNQMmhWR2xsNXM5K1JHOWo4ZTFxTUIrYy9uODRrN2h4OHJE?=
 =?utf-8?B?eVlJa3ppR1JWdjRHeTFhb2NVVGVNUzR2NS82Ylk5ZEhZdzM2TXVsNnN4Mmln?=
 =?utf-8?B?cHBsOHZXc1U0QXlBNGhoaEVoY1RtTGxKWE1SNHVHVjIxNnF0WFl6bHRjQWk3?=
 =?utf-8?B?MklVQkNpNDlBYzJVU0MxTFppOTNOa0t1NG42SWMwVlczbGNYMjN6cXpWODBT?=
 =?utf-8?B?bHB1YjNvRTRZTkJWTXIxNG5xcDZaWGV6N0h6YUE4aWpaWjFPT1pIbVRBcXZI?=
 =?utf-8?B?WmwyTDdRNXVlV2JXcUliemo5ZFJ1aThIcXltTVlnRWlzUGppaEtTVmFBZHR1?=
 =?utf-8?Q?cJ8M++oZhYD0He1Y=3D?=
X-Exchange-RoutingPolicyChecked: Kz3IMxKWQEPHR+SRix2hc8CJn4GiTOKz43f3+Y/Q7j0ag/mQy3NT/BYIdL9N3lSKz0oa/+Cwdg6pqanicSri2hZnRduBj9ylHfiJHFu7xrv3YgOLSU9YZL4M3WDPjNmLMbIH88/WczXrUovZdrKZE1Voqu1NBH8B3VwglkDkk0PH3Uq3hSETMqG6ndf6mHt+2MEZIo5zZ2Es8nshYidHVHJkiWPx6abHEVbGl6sEz3egDKcwMTD1Gh1P+AFMzFQvg6mqOCA1ZFhXPcrozaCi5DwTwCraItP5bgr4D3/+dRestoT2SuOW+JdXc/D61VPY+PU/7TPhHjXpZ6GaGKZsMg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c7e16a65-fb55-4b53-1f2d-08def38d032d
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 07:33:30.3655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3iILmX66qp+CcJY3D7865V2jijNqURgalQK5iwyN26iFDLk/CQXm+tXdrGC68aiUrncyIKxmh4v5ZAxnXZmexdXhOwaE7eqy+yWrsESxvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8046
X-OriginatorOrg: intel.com

On 8/3/26 20:46, Harshitha Ramamurthy wrote:
> Introduce following ctrl ops for Adminq mode. This change does
> not introduce any functional change, just movement of code into
> ops.
> 
> - set_num_queues to set maximum and default TX/RX queues in the
>    alloc structures used in the initialization flow.
> - set_num_ntfy_blks op to set number of vectors(ntfy_blks) in the
>    initialization flow.
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Reviewed-by: Jordan Rhee <jordanrhee@google.com>
> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> ---
>   drivers/net/ethernet/google/gve/gve.h        |  6 ++
>   drivers/net/ethernet/google/gve/gve_adminq.c | 45 ++++++++++++++
>   drivers/net/ethernet/google/gve/gve_adminq.h |  2 +
>   drivers/net/ethernet/google/gve/gve_main.c   | 64 +++-----------------
>   4 files changed, 63 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index 56148ea3cfbf..1bc5e32b6618 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -829,10 +829,16 @@ struct gve_device_info {
>    * struct gve_ctrl_ops - Control plane operations structure
>    * @map_db_bar: Maps the doorbell BAR for the device and store in @priv.
>    * @unmap_db_bar: Unmaps the doorbell BAR previously mapped by @map_db_bar.
> + * @set_num_queues: Sets default and max TX/RX queues into allocation
> + *                  structures stored in @priv to be used during initialization.
> + * @set_num_ntfy_blks: Sets no. of vectors into @priv to be used during
> + *                     initialization.
>    */
>   struct gve_ctrl_ops {
>   	int (*map_db_bar)(struct gve_priv *priv);
>   	void (*unmap_db_bar)(struct gve_priv *priv);
> +	void (*set_num_queues)(struct gve_priv *priv);
> +	int (*set_num_ntfy_blks)(struct gve_priv *priv);
>   };
>   
>   struct gve_priv {
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 9c3ebdb547cf..1d9ae601cdeb 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -1612,3 +1612,48 @@ void gve_adminq_unmap_db_bar(struct gve_priv *priv)
>   
>   	pci_iounmap(pdev, priv->db_bar2);
>   }
> +
> +int gve_adminq_set_num_ntfy_blks(struct gve_priv *priv)

Would be best to change patch 2 to introduce this in the gve_adminq.c,
to avoid trashing. Same for the other callbacks.


[..]

>   
>   static const struct gve_ctrl_ops gve_adminq_ops = {
> -	.map_db_bar	 = gve_adminq_map_db_bar,
> -	.unmap_db_bar	 = gve_adminq_unmap_db_bar,
> +	.map_db_bar		= gve_adminq_map_db_bar,
> +	.unmap_db_bar		= gve_adminq_unmap_db_bar,

pleaase instead use final spacing in the previous patch

> +	.set_num_queues		= gve_adminq_set_num_queues,
> +	.set_num_ntfy_blks	= gve_adminq_set_num_ntfy_blks,
>   };

