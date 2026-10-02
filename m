Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB964FB9AF;
	Fri,  2 Oct 2026 16:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960095; cv=fail; b=aFsS0Emr4LvTgZrc2k4CJoaR8CNuN3TmJyPV6TYWjWX0p9mXTUU6ins3dkR/k+jBLz6q9W4PcZE45zogMA3KsZj/PxP1FYvGBiJVw8fxXtnveZxgsi1CFPND865HG0RCH0xqHYFfQCjfQaFDcJUA+gSG31AHt8ZD0UsFkn0hfgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960095; c=relaxed/simple;
	bh=1pngxN+LNzuckHgnMef5y4Jw0wPbY72oJ9r7C6WpO1c=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JNIBqnn1W1UXOQxZ432RCIgLWtLheRs1zItPo+7Dy9zXBqIEFmLD+6BfAFWldgaJjIeiDm8r0CujghCneTyRyxGQ67upcmvVPjjEyPZa5qotBzMs1JobjmnHEbbqH5MxhiWjuetFCq7+n/b7ZamviafuRbGqfV99pe6fa0JSUEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dHyfdHkh; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dHyfdHkh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790960094; x=1822496094;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1pngxN+LNzuckHgnMef5y4Jw0wPbY72oJ9r7C6WpO1c=;
  b=dHyfdHkhZ1+lzzOsbZMo4kjZ4Hrdpcv9FejvBIvrQZ/ia3l2T13gDIdB
   RY21UQqxJGRdKd18gy+mTcxyKLFGvJc3aRgCcymMKmvidWwuSBjtbVdmW
   bDDAPaVwEjvAC+8AL/y+QW58Gk24IMSxApIXE1AYyJLU+BA4CR6Mlf4aM
   wJcXuqIwVb0AaADK4Lomel12Asez0eaIaeKMFG5yBD0rR5YLVYPBAzpYF
   VDWynTg4tzYXk6TQrWJISrTJx73B1WHsozmnsh4KPLdo4TLFxRmxxapvk
   uQd+opy/WckHrmPNL4nEYUuBykQs8lPWiXMAcBXhGuwmaqWKg3rG7+6s/
   A==;
X-CSE-ConnectionGUID: Pt/YFwhhT0q5vo7DStlRaA==
X-CSE-MsgGUID: uZq+W4wKQlGp9qzQ6cUlsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90497096"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="90497096"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 09:54:53 -0700
X-CSE-ConnectionGUID: RYmyySZ0Q3CV5iPc7qHMvg==
X-CSE-MsgGUID: 7W8TYb5PSIyfjjyMDEktdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="275825371"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 09:54:53 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 09:54:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 09:54:52 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 09:54:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwdhs/uXL1FYTqIjC9SEYGuqsHHROzXXoO8szQTHIU4o5XKZdpr01mndgSbQGV+HExgQp8udsrsgcn0YuPDxT7ara2J2HgbPGjBvASZYsrOENqgQ5jfH+SVDUIYjGQy54gkf8OxJowPn69Jjldlr1NSPnkG5jSbhRvGCHKterGoP5hfTpxJuchiLnTKVFwfKV0jHi7sC2Bkt6+adLeEVPeB0h18LRD7qTF4cTsrV9txdzmQ2THMCNF2JgdWAJJqHvHkiIbszM5BiCutNDKejq4i+cMSEexvMyK6mU/BsGdfxOw/zQ0GL3sIcgzDYixgShhI9aexZMqU70kIwVtaydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psq5/P01i5B1xS5+X4VVj5gDr5chBxGDl8RKRFLsUPo=;
 b=Suy0jF+mgogYwJhfUQTgP90/O9HH733zMIrvFbqyc5AIig4EoXlnoiA0xsIR1gP2oCTl1oAnmX/67pF9q+dzTkBX3PVqNa4GKqDN/2kXEW3hJgUVvijjVIrllRBkaRXHZdBmOWvpxkcToFqwBu1ByhAJvTcQlkYy5/oMfj3F1Kb5sHDlnGQ2O6SYHdAN5vE9OcyXksndf405spgCe4aIa+9eZgVi+4BuXXUlPU98ZjvG/Q3BKppCAIsyGYLoju+NB6rJTtr7qiQ8FLXGgQJx6HwzxHxIRpG9u4d55rN9c92up4TkH3cWqv5LFBfuMf9kLKjucqgXYE/5cSmNgl70gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS7PR11MB6246.namprd11.prod.outlook.com (2603:10b6:8:99::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.21; Fri, 2 Oct
 2026 16:54:44 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%4]) with mapi id 15.21.0451.014; Fri, 2 Oct 2026
 16:54:43 +0000
Message-ID: <5639a56a-249f-4424-b883-140a865d327f@intel.com>
Date: Fri, 2 Oct 2026 18:54:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: inline eth_type_trans() fast path
To: Eric Dumazet <edumazet@kernel.org>, bpf <bpf@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <edumazet@google.com>
References: <20260930172957.897342-1-edumazet@kernel.org>
 <d6170c1d-d8cf-4fd5-b0f2-361b89902fe7@intel.com>
 <CAL4Wiipep_WhfWBGov3vbOCLNKd0oQzFkX413AMU6V5DNN5Pmw@mail.gmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <CAL4Wiipep_WhfWBGov3vbOCLNKd0oQzFkX413AMU6V5DNN5Pmw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA2P291CA0015.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::28) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS7PR11MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: dcc3b27b-bceb-4339-4133-08df20a5db89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10067099003|4143699003|3023799007|11063799006|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: DYSuBS52951eTTdFwDpcMEerHdtc1GVsGS5skg7njhjPIYSJ27TK8Is9LffPO+iUbWPmCi/mcDZmmX/8GfgqqWgc5Fv7Hr6E/RFihFQc/6pG3aG0U7iBhv3tPNmiZjOT1E4xkSUANIq8b7aVaRypPyGDaCMbSffiSPir3YyU5jVNHqWe/JUdJruRjLaY7mYSgpSNrvbqCYNe9sGkV8TnhDzfbBf3NODd7XsmBKohla1EF+Z4M8mTi6hodPGW/d8z6T6uNMbeuNrsSMFKuYeYBdl4PESRi1UWka6G2cJmGunrKeJeQUVb9RTZigxuiQDaJWeLs4dd/4OElHfmxOSCM5tBcpwC2HppT1JjxvqPdxrUU7pBsIjR56RNMf/sigxfDiIHjrvG44gF/DJJ7b/gCEMMWi6qWwbbc2Dh04Bf4GVsB4CRdr5WRgw6db9loNg1eAxsxeUMu1Ep98aDWDggckw7dluCL0l6ldUnERZ6ftZxZMh6b/9TXJcxTwg503vvHpimfG0dyOIx3KJ42g4/clbFm/v5TwyLRNFAbmIMxw+HurMv1+H5zCxHdNq9iUrUhwncz8WwJE5M1py6I7HAeppROoCRHqEUSs8j7vWmn0BMjy8GzGVT9SUiu8cduSgSa8Itigkwn4+pR9+8zodOc/ATXzzzNJ4+bwcMYBnyrtE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(3023799007)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkJGNDU5dE8xMkV0RW1xSzVEU0tPMDNDUWE0M2J6NUErRTA0SEhoQkg4aHJw?=
 =?utf-8?B?S0l0RUd2RWU1WjI2SHBYSTNIYVNyelpIYkJNMzBsNGlQSmNLeHBNaW85ZDA2?=
 =?utf-8?B?U25HN29ibmtSMFFWYmx1TDRDVUJvZlNPQmN5WWdwRmxvamYwYnpSRkJLcWM1?=
 =?utf-8?B?VERDWmxzTHFRZGRBK2RGdzJlbk5DTHBkWHE1cjFUc2dwdmhGY0twV0lyU2NQ?=
 =?utf-8?B?ay9FM2gzRGo3eDEzSEE4SnlOOVBqcTl6MEhuMldRdU1ib0hDM2lMRk5iN0pF?=
 =?utf-8?B?WTk3R1JMeDlERzZ4V1hYMnlyTDZWK2RQTnlydGt2TkFuUXVGUVR2b3A5d1B1?=
 =?utf-8?B?ZnlWU0x5TVJxSjhQblRNU3FaYmZoaERvY25WbmRFVHRMWlFNd2cvMEJlc041?=
 =?utf-8?B?NkZvY0VqakNVWTNPQ3ZnbVdYL29kQTBsUXJqTFhreFMyNGpUQWJqNXBCQzBo?=
 =?utf-8?B?cFpXTW9QNlZES2h1bjQwVUJtLzlVc2ZPQWtSeURuelZYcXdEK2h1RU9QZnVk?=
 =?utf-8?B?MmR3ZCt3RkFpeitpaGhKc1docG1GQitwaXF0QW5zSHJXSXg2U3dsUm5lM3dC?=
 =?utf-8?B?TkNJblBmeHhLY2x6d0p0ZnYvUUhrNFNZL3ZlWldHU3ByNDZjVGtlTjBsRG84?=
 =?utf-8?B?enVPNzZGdUV4eTNRU0pDSXp6Y2FBMHRHaGVFR01xSnlXN1dEdlJqdXM0a2lk?=
 =?utf-8?B?QllaaGdhQVQ3ZHdTRmhQdHBITlRaZzVSbkJKRE1EM3B6SGRnNjhHN3pCTjRt?=
 =?utf-8?B?cmdPYTF5USsyaloyWkdRYVpwM2E0bjh2MEtYTy82Z1dqeFNydk5XeTlsOVFy?=
 =?utf-8?B?YUI0ZzQyWDJLVlA5MmN2QW1kNjlSdXZBN2MyNDl6U05JRk5OOEpISGcxMXdn?=
 =?utf-8?B?dmNqM3RKWDR4QnEvTFFPbWdIK2NVSm4xSkZieUI4b2dNa0pJUmVBU1pSQ0tm?=
 =?utf-8?B?L3J3VlpoU2tscEw3aGpIV0dNYzRieVRvcXVESXhmZ0VmaHFtdWdHcC9hb09R?=
 =?utf-8?B?WTFQd09KUkdhdHFoMFUzckZPL2Z6cXJ5STFjaVMzRGFIdWFUS3ZuamVMTFQ0?=
 =?utf-8?B?ZTZIdVNPL1AxVzNQVXd2em1abk5XK1hHZkttYThMNG5hNmh1SUhOWmlYMFEw?=
 =?utf-8?B?SVJVUXgwbnhxb3E1Rmw2aVlNK284ODBkWVRuRDhlaWlyVmk4NlA1aWlQOHYx?=
 =?utf-8?B?QzRrUVV1d0F4cFVMODdJRlVHTS9vNjNSRUVGOG5SelBFSnArWEdrR0VCYmx5?=
 =?utf-8?B?NWRUQzFQUFRUbWR1ZHF2TmNqOEpsOS9icUUrQjZ3NEFHRjN6VUZ3K3k5MFo4?=
 =?utf-8?B?SjdSUWRRMkF0eVRKekpqTUZscW40b2xOQThCSmVadTJzcXZ3UkZoNEdFd1ky?=
 =?utf-8?B?cjlsMWlGd3JrSEdJcTlTY1FHQ2VJUGJVWWpiWDZKRWJla1RFOHR1NnBiSVph?=
 =?utf-8?B?Nm9kWWJkR00zNVRES25ET2JVdkx1K0ZKQThxNExBcSt5ak9EMis3Zkl2WlJi?=
 =?utf-8?B?V3BVS0IwNDBOaVJjbGNXemx1UFl1SVliemZrOVB3SWM4OW11RFlpa1AzcXVj?=
 =?utf-8?B?R0lLaEoyT1RoZ0MvUkloL1Uwa09kb0JjejRaaXFPSThuM0VCK1lXU0tkc3Jv?=
 =?utf-8?B?Y28yMi9iaGJKWjBobjN2Z1k0Z3Y5Z3JiUjFzR2xkWFE5SU9zbmh0SkNhT1Rq?=
 =?utf-8?B?RWxhd0oyNDVMNFkxc3lLcHJqcUhTMjZjK3VQUWZ6Q0U2My81OFVuU3BDTjVM?=
 =?utf-8?B?bGhCdm55bERJSEJkSE9xMXNIODArYWxWVTQ4a3VCZnRCWVcxT1ZqeUY2WndN?=
 =?utf-8?B?TmhPd2oydWQwKytzbWkvamNyZEVpSkxOc3hFTjJ5OFJ2RzFjWCsvZUdwZmV6?=
 =?utf-8?B?VU05UWRabmNJcXVEQ1MyaTUrK29mY0hEWWZHNGY3ZHIzTi8reW9SK1dWSTFl?=
 =?utf-8?B?R2dpZ1NTN2xoL2ZyM3RCUE5TMGhsbzRORDhPU3NqRnpMcFVzclhvalRiL2Ru?=
 =?utf-8?B?QTRWK1VpU25WcStZNXlTeXRMaVZJU01nTUdSdVI5UVlRME1LR2N5enZCLzRI?=
 =?utf-8?B?OVVOYy9yOFFqTWE1RzR5elZYTWc3cnZvd29XU1lXVXVGTGRRZnBuT083cXBk?=
 =?utf-8?B?anduL2h3YjE3Wkx6bVB6Y1NDU3h3OFdFbzVJSVdtUDhoei8vMkZvVFUwbnpq?=
 =?utf-8?B?NWlld2Q2ZXNuQ0kwdUpKMHpxVW56ZURVd1RGMnUwRWJqcFRpRE1XdzJEWjBU?=
 =?utf-8?B?U2R2WmlzSHlzWmw4S3RZYmY3OEdVZkNZQ0FJbTNDL1h3UTVxaWtTdjd0OHJu?=
 =?utf-8?B?blRGWlJxaFl1WUUzeXlPU29ZNlVyZmZoUXplSUtSRHpwQzNMMjRHV2h1aUNn?=
 =?utf-8?Q?jUD8QGYZvYcq5hdY=3D?=
X-Exchange-RoutingPolicyChecked: U+PFmZjvufU1K0ny7LMD9BkQ2lCTytHH4gNwT0ftPa6loSubzSDEKPUycu4nKSSZG7wm8dOXqeF67TzAWc793Rbmw9+nJesquE9JkIZLsPyCplwBZXyklmAhuTC0Fz9MEs1N2IUP2k8NUHMOVFjC+2OcuXwrhU22oUcn5EYT9Dv992zYcKAn0o5sK4ojnPDUOajIw3P7s03DnAPQIqc8SX5ouWDhyW1ufHMtR4tva4LesSbV/Lapr1eNt6PVkZvXVKhe2164uE9AfWNAve8zr0/nl/Iuw9ZO9OaZp0Ly8H71pow5kDo9iENLO0yp2VHCcSMrVb1OIbZI6l5jfuu+wQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: dcc3b27b-bceb-4339-4133-08df20a5db89
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 16:54:43.8618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzIn0pIfK6Yx1XlOfe+kjqHDnQkg79zLmgj21dbzNjbLXbWDRTc1mZbBQkLTmJ4XK30YW2jjIDp4mPMJXEJZbyEPJW7Q5Sokz5pL0W0kF1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6246
X-OriginatorOrg: intel.com

From: Edumazet@kernel.org <edumazet@kernel.org>
Date: Thu, 1 Oct 2026 19:10:46 +0200

> On Thu, Oct 1, 2026 at 5:58 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Edumazet@kernel.org <edumazet@kernel.org>
>> Date: Wed, 30 Sep 2026 19:29:57 +0200
>>
>>> eth_type_trans() is called once per received packet by most
>>> Ethernet drivers, and by core helpers (napi_gro_frags(),
>>> xdp_build_skb_from_*(), veth, tun, tunnels, loopback...).
>>>
>>> With CONFIG_MITIGATION_RETHUNK / SRSO, the call and return
>>> are not free anymore.
>>>
>>> Add eth_type_trans_inline(), handling the common case inline:
>>> unicast frame sent to dev->dev_addr, with a real ethertype,
>>> on a device which is not a DSA conduit. All other frames
>>> (multicast, broadcast, otherhost, 802.2, runts, DSA)
>>> are handled by the out-of-line eth_type_trans().
>>>
>>> eth_type_trans() is now a macro calling eth_type_trans_inline(),
>>> so that all existing callers get the fast path. The out-of-line
>>> version remains exported, and can be called with
>>> (eth_type_trans)(skb, dev). bpf_prog_test_run_skb() uses this
>>
>> Shouldn't it get renamed to e.g. eth_type_trans_slow() to avoid this
>> confusion?
> 
> This was my initial idea, but this would make the patch a bit more
> invasive and touch bpf selftests, something like:
> 
> Let me know if I should send a V2 and CC bpf maintainers, thanks!
> 
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 513354e928cb58f837fdc93a77f2e896de1ef916..8f4e9dd18001a4c32455fefd74fe38db270756d1
> 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -1165,7 +1165,8 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog,
> const union bpf_attr *kattr,
>                         goto out;
>                 }
>         }
> -       skb->protocol = eth_type_trans(skb, dev);
> +       /* Always call the out-of-line version, for fentry/fexit selftests. */
> +       skb->protocol = eth_type_trans_slow(skb, dev);
>         skb_reset_network_header(skb);
> 
>         switch (skb->protocol) {
> diff --git a/tools/testing/selftests/bpf/progs/core_kern.c
> b/tools/testing/selftests/bpf/progs/core_kern.c
> index 004f2acef2eb0b0d80184423a3e8ba399feee1f3..fca26af98a7b92898a4adfde19f63b342f29db74
> 100644
> --- a/tools/testing/selftests/bpf/progs/core_kern.c
> +++ b/tools/testing/selftests/bpf/progs/core_kern.c
> @@ -47,14 +47,14 @@ int BPF_PROG(tp_xdp_devmap_xmit_multi, const
> struct net_device
>         return randmap(from_dev->ifindex, from_dev);
>  }
> 
> -SEC("fentry/eth_type_trans")
> +SEC("fentry/eth_type_trans_slow")
>  int BPF_PROG(fentry_eth_type_trans, struct sk_buff *skb,
>              struct net_device *dev, unsigned short protocol)
>  {
>         return randmap(dev->ifindex + skb->len, dev);
>  }
> 
> -SEC("fexit/eth_type_trans")
> +SEC("fexit/eth_type_trans_slow")
>  int BPF_PROG(fexit_eth_type_trans, struct sk_buff *skb,
>              struct net_device *dev, unsigned short protocol)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/kfree_skb.c
> b/tools/testing/selftests/bpf/progs/kfree_skb.c
> index 7236da72ce8055f9a0165d3b4334a04d17d110b8..678c15c151944b44e276cf1280c77cb436ff7b10
> 100644
> --- a/tools/testing/selftests/bpf/progs/kfree_skb.c
> +++ b/tools/testing/selftests/bpf/progs/kfree_skb.c
> @@ -114,7 +114,7 @@ struct {
>         bool fexit_test_ok;
>  } result = {};
> 
> -SEC("fentry/eth_type_trans")
> +SEC("fentry/eth_type_trans_slow")
>  int BPF_PROG(fentry_eth_type_trans, struct sk_buff *skb, struct
> net_device *dev,
>              unsigned short protocol)
>  {
> @@ -132,7 +132,7 @@ int BPF_PROG(fentry_eth_type_trans, struct sk_buff
> *skb, struct net_device *dev,
>         return 0;
>  }
> 
> -SEC("fexit/eth_type_trans")
> +SEC("fexit/eth_type_trans_slow")
>  int BPF_PROG(fexit_eth_type_trans, struct sk_buff *skb, struct net_device *dev,
>              unsigned short protocol)
>  {

This shouldn't break anything, but CCing bpf just in case.

Thanks,
Olek
