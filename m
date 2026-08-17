Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0FD3E5ED6;
	Mon, 17 Aug 2026 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969842; cv=fail; b=mbFRglFDnUDxL7iKVd1L6Ar5NjheggST9HimpZctemvo/L23NmD4Bs1H0SuUH+5V33UVZrl+tNOm9ePKIX/9nblmcLXYmYhKNAxLe17Oy+0p4mIUgj62K4nvGiR6fExUG/48CVLEK7LLqymOg6uSCEFF6jPMldRrN7p98dCRk3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969842; c=relaxed/simple;
	bh=bvyvyIMiCwbRE+0SmcFuy4Xpmf4rmWUaqWKXJQwASdA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kdTjlZwKt34bntnPUGYilo4VbEoTHVYh9isgaQZBv62GgQumGdLiIwIxr3uYqjVTw+73ZdA5mAIRFl0fceX6n/VVzebmZflOL+SPPi0RvXIOnpZ6Spr0bkHvHSJ2qPdSnIKDCGea1E2CUAZxakyyCpABMqiDD8EHgTG2hXrQaKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLtFwNLo; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLtFwNLo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786969841; x=1818505841;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bvyvyIMiCwbRE+0SmcFuy4Xpmf4rmWUaqWKXJQwASdA=;
  b=aLtFwNLoyzMSZfRP4Jp8l2I4E31fx3rJy+nRVv//esvcrCLRS/8Oo123
   23EoOTvcm3wpEMJU3Val++sJ8W6WhrE2nkbPEPcYI7mFc76B4j/xr1Gd3
   kJvs7l8lNql0Z2tyC/Llizm6aptQnxQNwHiRlVL6xCkG4NX/kHeJxyyGe
   NUIb0tj6A6qWB4p+rpFKpsc0Y34MTx5ja+gUbYf7wlhPjk3BZlOQirod+
   niSyhcgH0/UbcUl/iHbr+h8AvYZsWpDrG6oIMAryM1kHVgNgpisiqRbCd
   IYvRwlzB2Pb3k61y2RKVUsFsptTrIjnm99ZbsbSPNFCHloIt9g3aALPCj
   w==;
X-CSE-ConnectionGUID: wVTruxxsR4SbYVXxdUg5aw==
X-CSE-MsgGUID: 0pwYV9JqRCOe+zwCyLao/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="91257581"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="91257581"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 05:30:38 -0700
X-CSE-ConnectionGUID: VEm+m/ZYQPu5A+9ZtVaOJA==
X-CSE-MsgGUID: CZGR4oL6SjGVhgZnpUpcyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="265517957"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 05:30:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 05:30:38 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 05:30:38 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 05:30:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q1fe0N164gRWFYtCp1BmAsXrFC2H4PGL/N4/2yZ78eV+ouRDYJ/MZuuD7/SnHjQljboWzjdcJjcWckmC6YjXQKyTgJg3G/AM6DJL44mDMM+V6dbeJRlUxnnZBPmcQQImOJa06Ej4TjwBt/w4BsX9DeKQ4/lNdDFN6Dcv3rx/HIhKO9I2FFnf2WqIOAKYnL7iqlFTr9mgDHhB4pBnHCxWwRWioTq+bN6DS31c5X8io4qLAWe1Vf3Zt8d7UxC0PI6y01BpXJaa1xMtnM7Kl2NxcVVDcoVNq9kS4EGcPG/2lczVbzO/fIxbAwaR5G6z5xO0g03f8UUwBLf2LIVCXyNZdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vi0sJ2GibtjWaTyZ2PhHIfnXTFEzwIKKAfWLnBmpoXY=;
 b=F42Fvfg4IBvzEi537VHnWNO+n2hkBrC1HgIIS0cN0peFVsprfF6nlQXjlMU/Eq+qnu9Wm6whVyE9YERkW+zEWq0iQDRaREUCXn84R8WVQQ2hAwBLBNKfnB7aiPjkMWB0VIQ5juXPmUvHYzRfH/ht3rn9etsryL5idwk3Q/HrrsRxLuO5Sp+n0bhmQCyxyndnnWxNwHZ7HxUu6ibeQzinx0PYXX1u4b4J20iVuDDBuNvWx6Vtz5EnNsEStIH/d7RtIU/UFcQovdiCeWRyOPcnEx0fy+5w8NBWrTlJXF8N2lu/jUTI6N5wgEmx7XHUOiLrmSPd7nAtqL78SPS7rgZ50A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8)
 by IA6PR11MB690409.namprd11.prod.outlook.com (2603:10b6:208:5e4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 12:30:30 +0000
Received: from LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51]) by LV3PR11MB8508.namprd11.prod.outlook.com
 ([fe80::a1e8:1786:e5d1:8e51%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 12:30:30 +0000
Message-ID: <139c01f4-01da-4211-83cb-29bfdd404730@intel.com>
Date: Mon, 17 Aug 2026 14:30:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 00/15] gve: AdminQ mode related refactors
To: Harshitha Ramamurthy <hramamurthy@google.com>, <netdev@vger.kernel.org>
CC: <joshwash@google.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <sdf@fomichev.me>, <jordanrhee@google.com>,
	<willemb@google.com>, <nktgrg@google.com>, <maolson@google.com>,
	<thostet@google.com>, <jacob.e.keller@intel.com>, <debarghyak@google.com>,
	<kees@kernel.org>, <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20260814021406.3044324-1-hramamurthy@google.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20260814021406.3044324-1-hramamurthy@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0196.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::23) To LV3PR11MB8508.namprd11.prod.outlook.com
 (2603:10b6:408:1b4::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8508:EE_|IA6PR11MB690409:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bc8d101-ec08-4303-32ea-08defc5b535b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eSrwLXxdRedWrRJDnL/lIQWRoDEFVlBD0yQdRLjLulSYx+BVGFVmSFg3zhIj1+aiyReR6ZX7n2MTF1K5fbVuVSGVTLyOxj/rkInt95rBFz+n+kbOXtVVwd7IT93vZf4Jt/PZOprd+G1fQKdTp+o6SvbAKxQmS2TxUj/22GN7U86P+AYO15MzIyMUqtHRLYnP0J2MYXx30b0tMJQWlEPJP+7FgSMRovVBCptc2yiW/kA5MU8hfsTsvXyO0sROuIab6iHqhJObCcOAmhUPLONy3TFIOFEcFIPSfYawLng8FaUdWq4rlEa0285rZg1J3GahsCigwHwILHssWRswi3FJ/7iYHnCOfnnlFu+FsnPUQ5RbsTCzwRnv/e3gYkg3YOkifeUhkCd80W3wvDLtNNiUgdHg81d/izN5xrYqjPy0tq2DC2pqqmROizGF8jPwnLIULORB+Xnq4/0rlkkxarxz4x4TLgHzPV1gFiWVaDWUqyi8OBIqYhiIC8p0h2Dmm8OD6WhJRjwT4PPV0V9LHUARsgNJdw1DZX4+xPBqESSI9uCXy4aOW3cDYLnW4QbOQ9nOxmQ8CVHCz2aV//2hibm6tYEJ0YiE+2uIQt1l2uI7TM4jAdEy8V4EHT0R1MMnVpF4AeqoPEQjlLcQS61PLVKUHHLfiJUmNrUfn018TKfMLLI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8508.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cy8vcE5wNHJSTkJRN2NSd2tsbzhKRnJkM3BiSm54VlJmRU0vcWRUOC9yV1A3?=
 =?utf-8?B?OGk5cllpaGEvNndmR2pvM244Y3diWXJaYjRFaHJvZnhPRXBxUGVtWnd4Mzda?=
 =?utf-8?B?N0NxcWJrZUtCeUtIc0drYXFET2xmLzRyVWRMMmJJRXQvRzBmdnZsczltZW5o?=
 =?utf-8?B?QTEzUEZTOFB2UGxIWkE4bTRGNFpQeFhLdFNRVFB0SnJCMnBqNWs1MEhhdFJV?=
 =?utf-8?B?bXZJN21OOGRYdFNlSGxvVzZTeVRibCtVd0NvVHpyajhGbm0zMCsvSnQwbDR6?=
 =?utf-8?B?SDBiTW5CMnlOVGUxU3ZjaE9sWlJMbGVBZkJHakd0cGt6c052U0pnT2hLbE1S?=
 =?utf-8?B?RjdteWwxOU9ERm5zaTI1UTFBRnRBemZhMHE5am1CUnFtYUVnWnhGTnR2Njlr?=
 =?utf-8?B?TFhXR21NSXViUlk1TFA2TmFTQ0UzU2k1SERVdm9IOVhsYTB1OUlzTkZQTVlv?=
 =?utf-8?B?dmFXM0lrQzAwYTFuS2x3Y1JVVkVIcHA4MmplNE5ERUl5OWlxbnFxMGwzMGtE?=
 =?utf-8?B?ZlpYN3lXRWJHL21NTHVzRW9xM1d2Nm9ocjNPS2ppR2JKMmIvaVVYLzlseUxi?=
 =?utf-8?B?TEhSQlMxVG1HZHl0VUZpejQ0WTFULzFJNXJ0b3NmY0hJNzE1ZDczNUNVSndG?=
 =?utf-8?B?RXgzUXJXRDlNYm9DY3ltMTkyNGxjRWtJb0FyNkhweUpPbjlVWFdndUsrSmtW?=
 =?utf-8?B?UnNPeFo1REZ1aWVudm8xRk1zb2xydEJZYUEzWFk0K3BxenJ5bDV2QXdaaUda?=
 =?utf-8?B?dHhYN3dCc1E2OENoQ1B0Wm5lckNLUE5PMEZ2N0U0T1Z2RmM0UVNvTEhTM3g4?=
 =?utf-8?B?NGNURzVFYThzK3Q2N2tUckY0b1UzeHNEenhlZXBUNG5SQ1d1SGl1Y1hZdnVP?=
 =?utf-8?B?NjB0cEovbU52SDN2VW40NVo5bERxcHZNdXRManN4cm5yRkFhM2plejBnbkRG?=
 =?utf-8?B?WnpsZFM2ODQ1L1ZWZDYwM2RVc0JDRFk3eVRnQTRnbXkvODd0Q3VNczdkWjFL?=
 =?utf-8?B?Wm4zYmZPYWY4U3BtTXh1akt4d01admc5UUlEOHJuS3dJNmlKL2l4a25ETjJj?=
 =?utf-8?B?UUpGWTU1TnlUOHRuTEVzMUlvUHQyejNVdjBtbXpuL29qUGM4ZjlNNXhxRjBC?=
 =?utf-8?B?cjJLOS9sNCtiYlNzdDRQTmNFN0g2YlplRUQvQWI5Y3BjMHAwWW1KcC9YbFFi?=
 =?utf-8?B?Q3VoTFhJNnFwSFErYm5VNm1GSnpYaTBEdmZ2aUtjS0RKUUErRVhLUFRJV0lw?=
 =?utf-8?B?cUYwNENHRER2SWN6MG5TVk0wTjU2SUJYa3kvNDBIZnFzbXVCOGdzZnVKMDdQ?=
 =?utf-8?B?VXpIYmo5enN5Q0htSmJkbzJnd0FGaWR3Y0prNEVTUUtaZkpaWjFVWnEzU2pm?=
 =?utf-8?B?elNiQlgzNFlDVGRrY1dLTFF5ZVA5TUpHZCtzRkZCOVU0amJlWDVYYlVhdnI1?=
 =?utf-8?B?STROTDRuWkJ5dkxRQVVQMTdXbUdxcUErZWF2dDRYd2JLYzIyUWt2Z2RQbFpV?=
 =?utf-8?B?YW42NVZrZDZVS3U2NzFmU25KeGlmRWxBcGxvYlJacFZUY2NUbHJsQlk2UXVY?=
 =?utf-8?B?WGRSTFgrTG9TdFdXeFk0L3NnUThDcmQya3dRMERkTDFZY3JCRkxsd1RzbWVH?=
 =?utf-8?B?SkQzSW0yYmtoTkNRUVh4ZFQ5S3lYMDBsTHNqa1EyNFAvcTA2SEdtVjN2Wjls?=
 =?utf-8?B?TG82U0sxL0xRSzdhNU1SMGl6MnhFMWQrcHhHZGcrTWxmcHB3U0JobktFVHZV?=
 =?utf-8?B?cS9VSEJrWHBzbkhTY0hNKy80YlFTenVDNEQ0RjUxTE1TRE03MWNkQWdlYXRI?=
 =?utf-8?B?aWNvNHNLN3praG5ld1lhbm8rZ1k2NnpSMUhtODRmcmIxWG45WWRTdzlaem9l?=
 =?utf-8?B?OERyV0pqQW8rMmlNRjd2VFp2cnR6K0d6bTlDWFNOcHpVOGlIYkpXMk5yNVVP?=
 =?utf-8?B?TUgwTmFqL3MzbU9OZWc3cDM3VEVjaUtYY2pya2lWRmJZQVdNL3V0enVhdmZJ?=
 =?utf-8?B?L0ZQZ0laRmJaRzZNaTY4U3ZPVk9pSmdzOTAyeUplQlY1UitoYlR6eHNVSHo1?=
 =?utf-8?B?WTM5bmlSVGYwazRzSSswN0pqZExmSWhhVWpaY3YxQ3MreGxwZFF5T2lNMTJz?=
 =?utf-8?B?VWowUTFLVnVzQjBuLzFQNjBMeStMUEg3RHVVanJ3WjhiVU14NWR1d2c5d1Mr?=
 =?utf-8?B?Yy9FMEkwRFd5cktnSC9lZFRCZXdIT3V1NVNHWndlcCt2akIzLzFjdUpPSGRw?=
 =?utf-8?B?MHV1WmdXWWh4eUVrdURRWlVRMFV4VUtJOXVKME1YQTBva3Bxcm92ZTNqd3RB?=
 =?utf-8?B?Ym0zVi90Z3hMTy9FWFNpSCtjdW1oN0Zja0FGR3FyWndDZnd5emNpU3c0d2wr?=
 =?utf-8?Q?qktdFxtm0TxQ+1mw=3D?=
X-Exchange-RoutingPolicyChecked: fIB0N4Z9OiFtpl4Fi3WcE4nT57vRYgAmkDE7roH+1kBtBgv/sDuRIvkdIiG/3fI8J/G26k9gtyggm31EUli7euYmbyEYo2cGBsr9zzUGs7qpmLn17qlzelYgR0UfDx0JVodB7O7L3VdKW8g6E+0PaQbNaL7YjiCtAnMfGLiab41ghHS/3bKZiVNYDJbL8VET68cuegDZp08SuUdeJfrgnJq4Tk9IRS37WECMwJJ+SGzhlRUHupoTfOIZS8fO2KL3iHJwPVbcYdSQk9q8aRjh/bCxlNRJhItGE08Zi4OdxtqUeApNRZiFiULXvEZ36z2cb+OrzoM6qf190x7i5uSJaQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc8d101-ec08-4303-32ea-08defc5b535b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 12:30:30.6667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAERb6UeSKVhQlOR2UsAuKOWQokDFMoFZEtQPkDB4A6EJS0daIq5tUD5mMm1otxJu7qsOK/KX238iEe933tcN9IJj1LMEcGL0YN6BbCPhig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR11MB690409
X-OriginatorOrg: intel.com

On 8/14/26 04:13, Harshitha Ramamurthy wrote:
> This series is preparing the driver for the addition of a new control
> plane mode(MailboxQ) by commonizing and reusing as much code as possible.
> MailboxQ is a new control plane infrastructure which uses mailbox queues.
> This is a new control plane to communicate with the device when the driver
> is running on bare-metal instances as well as newer versions of the device.
> 
> This series contains 2 main changes to the gve driver's existing control
> plane(AdminQ):
> 1) refactor some initialization/teardown path methods to make it work for
>     both control planes.
> 2) add gve_ctrl_ops structure to the driver for various control plane
>     operations
> 
> The refactors are mainly around the init, reset and recover paths so that
> functionalities could be moved into the control ops like 'set_num_queues',
> 'set_num_ntfy_blks' etc.
> 
> This patch series only sets the control ops for AdminQ mode. This is
> intended as a preparation for adding MailboxQ mode in upcoming series
> which will add the new control plane infrastructure and then introduce
> the corresponding control ops for MailboxQ mode.
> 
> The entire list of future patches can be found here for reference:
> https://github.com/hramamurthy12/linux/commits/gve-mailbox-queues/
> 
> Changes in v4:
> - Reduce code churn by placing new functions directly in gve_adminq.c, introducing final tab spacing
>    and using local variable (Przemek Kitszel)
> - Fix kdoc formatting and drop spurious management interrupt(patch 9)
> - Propagate release_db_resources naming change (patch 12)
> - Remove double logging in destroy queues path (patch 14)
> - v3: https://lore.kernel.org/netdev/20260803184630.3813311-1-hramamurthy@google.com/
> 
> Changes in v3:
> - Fix driver compatibility verification in the reset and recovery paths (patches 2, 8).
> - Mark gve_adminq_get_device_properties() with __maybe_unused ahead of its usage (patch 7).
> - Refine error handling and resource cleanup in reset, probe, and queue creation paths (patches 8, 9, 11, 14).
> - Keep IRQ doorbell allocation/release in control plane resource helpers (patch 12).
> - Minor fixes: fix TOCTOU issue for link speed, correct kdoc comments, and remove redundant teardown calls (patches 4, 11, 15).
> - v2: https://lore.kernel.org/netdev/20260602235900.3050782-1-hramamurthy@google.com/
> 
> Changes in v2:
> - Rebased against latest net-next to resolve apply failure for patch 5
> - Fixed a few typos in commit messages of patch 9 and 14
> - Fixed a kdoc warning in patch 9
> - v1: https://lore.kernel.org/netdev/20260601175437.3767283-1-hramamurthy@google.com/
> Harshitha Ramamurthy (9):
>    gve: don't pass in unused parameter to gve_adminq_free
>    gve: refactor initialization with helper functions
>    gve: add a few helper functions to set device properties
>    gve: add struct gve_device_info to hold device properties
>    gve: introduce control plane operations structure
>    gve: introduce ctrl ops to set vectors and Qs
>    gve: introduce gve_adminq_get_device_properties()
>    gve: refactor gve_init_priv for reset path
>    gve: add ctrl ops to for queue operations
> 
> Joshua Washington (6):
>    gve: simplify reset logic
>    gve: add gve_ctrl_ops for gve initialization/teardown sequences
>    gve: split up notify block allocation and setup paths
>    gve: introduce new methods to handle IRQ doorbells
>    gve: setup and teardown management interrupts
>    gve: add link status/speed ctrl ops
> 
>   drivers/net/ethernet/google/gve/gve.h         |  89 +-
>   drivers/net/ethernet/google/gve/gve_adminq.c  | 437 ++++++--
>   drivers/net/ethernet/google/gve/gve_adminq.h  |  25 +-
>   drivers/net/ethernet/google/gve/gve_dqo.h     |   2 +-
>   drivers/net/ethernet/google/gve/gve_ethtool.c |   5 +-
>   .../net/ethernet/google/gve/gve_flow_rule.c   |  15 +-
>   drivers/net/ethernet/google/gve/gve_main.c    | 940 +++++++++---------
>   7 files changed, 957 insertions(+), 556 deletions(-)
> 

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

