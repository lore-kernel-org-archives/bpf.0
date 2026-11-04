Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793796286;
	b=Fk2V3lLY9YnNr2ydp/1YUa32j8ZC3axcfHCWzxkq4kd8KlZxVEvHtNl9jhk0X/m5cVPd
	 +PI8imqG5YKfhf9PAALSXjWlzzs4XsicsYE8zFwgzBWB9ZPXZjGemOTv09QuRJKHLKhPn
	 BYoUlkILU+u1eUshxVb/hchDwc2gQnX58ogwPXd036ktLXqjv7A99OO19UKTGV2PBsBwZ
	 l6xRUPUTVH72nlnb/Pw6oo9r0UeuQU2O55WtpMe8VEeb2kvItFDFRrcz0t1LgFPtJ/tHD
	 ZxP4aODuGs6/FZPgkAc8NGfYkY03qoiNJ/zdQh4IGoCVqajHqlvMJAAfADOnLl5TcJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796286;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Date:From:To:CC:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
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
	bh=0yzs8/EfulQiSGpQnLGNC5ly82N1VH5VytwaHtTi2xY=;
	b=cyOk4sXe4ZimsCZ9gVynhtdsVE0HOJ5vMdY9z/2jlWPvAlB4Q58z9jtAdMOv9/pvbfM/
	 kWCgJe0LRITEa5TZsVgqgeiUwXM6x+tdoPTmXf9YRlQ5nNpw7eWHtfzSoruuGbVNZvMli
	 rz64aIcuXIAs6yIqWR7dwu2VH1XrvDv14cuspMnB68QTwbuWlkhjrZmgiC/QHTQvgM7nD
	 dKcXiXnqTNtfgJ3eHwCF1+/m7TbXLpWe4g+Gi2eUvotkpc+yuil2/+qdZNdBSE7bhQYIJ
	 tD46cRtxh3icRWGE0RX3xWykyfmaHO+8n3JDKLZHVFO+fjE+Po51klvdWiqZ9Lm9bRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e1zmYigc;
	arc=fail smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A7606A331;
	Wed,  4 Nov 2026 12:44:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A71A7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=e1zmYigc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793796285; x=1825332285;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=s/2SlgwOnSVVu2i0HjyTHopXtE+fjuO8Jalb0K92EGk=;
  b=e1zmYigcYLI4/9k9qhzRN8lx+6YEFAopIAuPpDtDJ6YaBBctlZDakudq
   7i0J53FVLYQ6oFPgBSdcuoyVH8+fvAcQi/Wd5r+65IWzwu0Z62v/6gG9g
   Y5Bl8dsAMEpYS87gaf9AStigTWkQP6vtMpuMxFhWlXngeSzWmZ9r59Okl
   m5nzkEFJRfJm1EEu0LCLsfG4lVcqxDOe2cN0GZdhkA35zy0r7kFfzNPil
   12OZhgN+pGDkv/GayaK4MPTEDNx+nU8VkoVElKFlRwNbUyuHrIrZGl6UI
   h+7v3wG43PhGp4iK8yyN2ERotRJTHqLZeGVHLVnn+CHOYrFm9cmmQijhw
   Q==;
X-CSE-ConnectionGUID: V4YOBdWUQz+5vTCup+qGtA==
X-CSE-MsgGUID: qm1NAzHuS++rb9ZdQTHDaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2651540"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2651540"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 04:44:44 -0800
X-CSE-ConnectionGUID: Swuhn3gBRGqZaf2j2jjZkg==
X-CSE-MsgGUID: tAJuNlTITtSf/x+kWeghlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7028474"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 04:44:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 04:44:44 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 04:44:44 -0800
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.34) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 04:44:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FLXKHU5OKXB3Tm8cU1GEjJjXg9bRXTHO6JLir4I7bM5J64SHr1Y4x9ouJ1j63+54brYC8oa1AhjMqGYShSxLV0sDjweYWkqNqNy5rndkvkKiN6etCXq54n4OOVDj8UG/SAiVPjXyc9MnSfGwMdx3AkYGEIoJagG6Cc1SXzuy6UMWxAVCtu+oYzzPxz7ur4Tk62Ci01Ya0SFcDH+wnh5Hpe48WQOSeip21jZEM/FWR5WZbQPGt8HISf382/ursIl7NkhotT9PdZKdGW47PVNSCRfKuwwaI/H+xicG02LHuj8q+u4MV6BTqk3qUbwE4bABFJTpID2LxT8IhqphovMt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0yzs8/EfulQiSGpQnLGNC5ly82N1VH5VytwaHtTi2xY=;
 b=QwoxWJhjhKIwuhAjnVWfU+fhI/mYVbFwhqvrJ6xBApKynIBIPHH237mg/3+RVdgq7UlPzWqlkN7TrejTSEixhRRMhmnzFi/PP6XV36qxvGkCr7/+VejZ4Ud1WgLOQP08TusKOrz88h2hcNXfqrT/MAo22JRmhmeqjIJM40R27H2znTBX4lGPNFGOUmFuB6r7mpAJ3pFqZmB5Gtl2lz0CDhwyCgD48OG7yK+wvEhx7f0DyU0QiKIVkiUdvN/AkHiH5RGv0JID2OIW7uLp+pEEbmt8b+cqvGta/x3zvo8b8VMDTCpyiIX1YFkhgp2CCWdZeoqTSbnZ1G9JnXq3HYANcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by DM3PPF1A34EE115.namprd11.prod.outlook.com
 (2603:10b6:f:fc00::f0e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 12:44:40 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 12:44:40 +0000
Date: Wed, 4 Nov 2026 13:44:29 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Slawomir Stepien <sst@poczta.fm>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
	<kuba@kernel.org>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<sdf@fomichev.me>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, <aleksander.lobakin@intel.com>,
	<ilias.apalodimas@linaro.org>, <toke@redhat.com>, <lorenzo@kernel.org>,
	<ihor.solodrai@linux.dev>, <tavip@google.com>
Subject: Re: [PATCH v6 bpf 0/3] xdp: fix page_pool leaks
Message-ID: <ausorQSZn/tuxUWg@boxer>
References: <20261104121316.1155680-1-sst@poczta.fm>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261104121316.1155680-1-sst@poczta.fm>
X-ClientProxiedBy: DUZPR01CA0276.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::25) To LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13)
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|DM3PPF1A34EE115:EE_
X-MS-Office365-Filtering-Correlation-Id: 85adedcf-4efa-4d5e-5441-08df3a7164aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|11063799006|5023799004|261021121427099003|56012099006|261009223027099003|261021135927099003|261021123027099003|261022105027099003|261022113327099003|261022075727099003|261026121527099003|261028144727099003|261026140227099003|261102123227099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 3ONFt75qCGVKEPCq1o4kJ6DE4tCngVybjx5ZexNKdKQzXAd9jhRlN7U6dqDPspCGm9AziwZZIvlj0Z69Mpxs8mpRs/NvjhqPJE3V/vjcvv0yc6uklrel/qzpELnyTGve3DuGaPeHxh5fT5p9V/zIA6UYisTV2XBSpqqsXxATOoi2mSCvwE/Diuh5JqcnlWFOPJspBfuyO4e5i0mJfxNKd9IMJe5V6VsyAEZ0XyuCY2DvFJ/CntOrbNQBJHfRoGUNMRJe/swbEYt9XUoi5XY7+jEctDGRp+wG5TyFD/7JPvk6XZONUcWpC58u+XFfHKyCiESRyArpxeylUQdil2WKy2kpN3eCIaDsKFHNhFq5gQuqbYmSicn9CQtsqCCm4H0hTtaxTYM09uC0tKhilR7t5kd0+lQeNW2VJ7SOlZvq83PuWngF50XfaF727WXxz27dpwxaNOPiJv71WjSoFFtOUmRLYHzDnHOebjr19dnFyN4CCVmjloB3GZL/GzRuWHSEIkhWDlNLnvXoQaSHqV4y0LxtpWtnXizz+PMizLFaPa3zf9yCkxB9ttfhGC836U8XQpdbHSRlt76solOnJYeuJvoZQItC1WtiSiRhQ2FhqTOun3alKZFI7epgj36M6pmR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(11063799006)(5023799004)(261021121427099003)(56012099006)(261009223027099003)(261021135927099003)(261021123027099003)(261022105027099003)(261022113327099003)(261022075727099003)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TmZr8F78EM2Zo2yH5tOoOV6mZctvJrxI8QO0pHIuikoKfLOTYJAh109D2Uy9?=
 =?us-ascii?Q?I5jv1W6UUqbwCVXJHEmr6w0CiY/QgsYfGDUUAsQpsiywb6QkMM6tbaTFo/yu?=
 =?us-ascii?Q?ouFvEMYyWq+L6ADpqpI02485C+KrR/6WvmWuSSyEEcCrIhDQdr79JSV+mes5?=
 =?us-ascii?Q?htc5YM487y9NXW10Yh3WM5iHkWhD0y2+e0lt5MdsTvmHQIA1+165byB4/OV1?=
 =?us-ascii?Q?jTyrGnzD5ieFRydCNmZxugSDz10bfIdphe39hA7EkBHzWpSe2Wxnwnq5c8DX?=
 =?us-ascii?Q?t+yb20uwqhjIUBlH0n49Ak00A7UTRYFeQIAhrPTPlg1D7Ahkvy9pp2JhIUEe?=
 =?us-ascii?Q?TnPRrmz70CAFU4oAhgN02caRIIaqAz0INuMKBMvRCHCqMWNnRtz21K58E+3O?=
 =?us-ascii?Q?FtofSFkaycBW1uZBeVgBDsuTAJeHYiZ1vQN30sYxEky0DUw1biD9qofBzO7N?=
 =?us-ascii?Q?2rCZlH2AZE5EtQINtTirdHJian9hRu+ga4a+3IbM8J37QJA/iw0WV4gTM1m0?=
 =?us-ascii?Q?UjNOwttH5CzdQLPA+TGI281gckFEj1aErPeo1oBOb1hwnJtWAuQVCSFCn2w6?=
 =?us-ascii?Q?HtFlwVcECWZig9zZOykLdF4ZrXJDlOiJISQUTqIZ1wGK+FXkjfPymkimr54+?=
 =?us-ascii?Q?Q7ttFMRpm/KB68LxwLtd0Ta1XnJcUAtgkCIw+kes8JQm9+BDXrNQL4AuAuSL?=
 =?us-ascii?Q?2dr/5/k5X4NnC8MIuQWJ3q41lTJK8En/qBqQqrTtbeiX0R9MiJR75w6rCQsb?=
 =?us-ascii?Q?UNeirHt5cXpWgOD3LVRgnj2fTHFA3oA6iH/SZLmc6EC0omWvjg7wSFhPkft6?=
 =?us-ascii?Q?dnpttMLduuW2sDU7fBfxNGP/mVTQc8pGX/Oqyuy4jejbmz4oS2nEe/UfjG2y?=
 =?us-ascii?Q?/Pu4G7LYW5p8jpDH0UG4mrBDo/LOROQYQ9JBHOl1hRaB8YYfIGNyDoLRczMB?=
 =?us-ascii?Q?xMkbAa+lLVfTDoDbN1c3qJ6YJDQBmoM6OGi45/MIZcb7sRbUNS80lbiy4FqR?=
 =?us-ascii?Q?6zSrQth/t63hRjhChKterdlX2Ss/d8SIl12I2VnNC5bGfPtzJp03UzW4qy30?=
 =?us-ascii?Q?ikO9xf+WxJ2AWgwvgCmXxSrAEF6a3E4oetgu8alH2qg9bym+rzsbhxDKrhTj?=
 =?us-ascii?Q?0dRU8/SJo8YEZOnO+RTKPvpxy9IxHuxTswPjyiMliDukiV/6zCnP9L3HINTF?=
 =?us-ascii?Q?9Idaj8lwAa2M8cfswWcPh8oV6dYa7PY+vz3Mt5xXQWBKVidXAYqQtSWLI+Nt?=
 =?us-ascii?Q?prQXJuTbEZyuKcjoGuPNae4WElqE9OLBZbv8d+w+yW4gvt3Hq3WuV189Fn6/?=
 =?us-ascii?Q?c5COKJNdrLVMaqxz7rBbJBLoq4yWttW4vvTRAKLKJhjfWYU7k8CmqL2WNlzD?=
 =?us-ascii?Q?6q9i3yqh8S1X+aNaRAKHsKUMBU4vkEEyUUr4qSnfsfxhtLJovvqBU7J848py?=
 =?us-ascii?Q?EaMLDau2epv23v29JYyCukhkxdwRWqIHOpKFBSnsCOqnEHHcpZEoLkwrMJNP?=
 =?us-ascii?Q?sH1+vxujSKY7X/9+Ag6hgK0poClOWqhB5WGvVPgS2CvS79BS4o2buQ8nXwPB?=
 =?us-ascii?Q?1Sk5qv9UQnRaCp85AOdLuW9RZ8qrvDd0AoQHFZxc1AZE4SSO20VSFwuVGviP?=
 =?us-ascii?Q?0jNswz6gOIalTEyNthNRmD8KYsYhkgiENRuQD+hMn8l7Td6Z1d4Sgo+o/7d2?=
 =?us-ascii?Q?dPMEQx2ZHHWXHbYnxGDTXtL/y9cn9f3BP5L9QSVJQutSF+2bZZoNXYWo2WFj?=
 =?us-ascii?Q?C4vTDgMa0W3nOOd2BZkFBy/uKq3G5mI=3D?=
X-Exchange-RoutingPolicyChecked: EsNyDT7oz0cX11h6tx5SaWOOBnv4nR8Bh8/jy4E4Ywacs7WLF+owVL4igBPR0k4V4/awd4t5Pclhvmrlbnqpl0vA4B6iIdt+6fQ7SHwCpoUepyO8s9vL3CyT8e5AB7vFzHhtOW/gd0t69vHUXShENS2eFct7PnkuRHBC1LNoF4n70Z06yeWgw2flDs1enj7One9bLX2lqGIuVD6FEa13KRMf52Yy2qjV2ZmHoU4ltU+ZK1bz/qj0OVEcKsSPd1z6vif5Sux3SFAVVFvdQONjJZOg4oE82BE4ZlosRF9qgSinrOI0eTfwy+navFcscEncrGCeegMUAborL5Ik+WQoVg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 85adedcf-4efa-4d5e-5441-08df3a7164aa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 12:44:40.5309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txeOLih204pVH+6Hgy+gEi1LVDYBX1NNVNGySCzFiDFMxMkBgMdUeLtvB+SNWwwYRyDhkJHnOF5T6tfvDo1Uy/xPFXZIevwLAmzHWidvxxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF1A34EE115
X-OriginatorOrg: intel.com

On Wed, Nov 04, 2026 at 01:13:13PM +0100, Slawomir Stepien wrote:
> v1:
> https://lore.kernel.org/bpf/20251003140243.2534865-1-maciej.fijalkowski@intel.com/
> v1->v2:
> - add skb to xdp_buff converter (Jakub)
> - postpone restoration of veth's xdp_rxq_info mem model (AI)
> 
> v2:
> https://lore.kernel.org/bpf/20251017143103.2620164-1-maciej.fijalkowski@intel.com/T/
> v2->v3:
> - make skb->xdp_buff conversion agnostic of current skb->data position
>   (Toke)
> - do not pull mac header in veth (Toke)
> - use virt_to_head_page() when checking if xdp->data comes from
>   page_pool (Olek)
> - add ack from Toke
> 
> v3:
> https://lore.kernel.org/bpf/20251022125209.2649287-1-maciej.fijalkowski@intel.com/
> v3->v4:
> - include skb->head when calculating packet length (Toke, lkp)
> 
> v4:
> https://lore.kernel.org/bpf/20251027121318.2679226-1-maciej.fijalkowski@intel.com/
> v4->v5:
> - rely again on sk_buff::pp_recycle when setting mem type on rxq
>   (Jesper, Jakub)
> - add ack from Toke on patch 2 and restore it on patch 1
> 
> v5:
> https://lore.kernel.org/bpf/20251029221315.2694841-1-maciej.fijalkowski@intel.com/
> v5->v6:
> - rebase onto bpf/master
> - patch 1: set MEM_TYPE_PAGE_POOL unconditionally in
>   xdp_convert_skb_to_buff(); mem type only matters for frags consumed
>   by the program, and those always come from skb_pp_cow_data() (Jakub)
> - patch 1: add DEBUG_NET_WARN_ON_ONCE() for a non-linear skb without
>   pp_recycle and document the expectation in kdoc (Jakub); the warning
>   is limited to non-linear skbs since linear ones legitimately skip
>   the CoW
> - new patch 2: veth_xdp_rcv_one() ran the program on an xdp_frame with
>   whatever mem type the previous packet left on rq->xdp_rxq; use the
>   frame's mem type instead, as cpumap and devmap do. With patch 3 alone
>   veth sends page_pool frames to its peer and the peer's program
>   trimming frags crashed the kernel, so this comes first
> - patch 3 (was 2): veth turns the buff into an xdp_frame on
>   XDP_{TX,REDIRECT}, so the head is released through mem type too;
>   keep the queue's original model unless the buffer was copied into
>   rq->page_pool (Jakub)
> - patch 3: take page_pool refs on compound heads via netmem helpers
> - patch 3: do not restore the rxq mem model after XDP_{TX,REDIRECT}
>   and on the error path; with patch 2 every path sets its own mem type
> - patch 3: veth can now redirect MEM_TYPE_PAGE_POOL frames, which needs
>   commit b3ca872947ef ("bpf: Use the frame mem type in devmap egress
>   XDP") in devmap; list it as a stable prerequisite
> - drop Reviewed-by/Tested-by tags as patches 1 and 3 changed

I mentioned the changes [0] that were developed after v5 revision yet you
decided to go with what you had - that might be okay but to be transparent
it would be worth stating *why* you chose not to pursue further or explore
approach where __do_xdp_generic() is called from veth.

Was it due to semantics change pointed out by Bjorn? Or is it too big a
hammer for fixing page_pool leaks and should be implemented as a
follow-up?

Regardless, thank you for reviving this work, I am to blame for not
dedicating further effort here.

[0]: https://lore.kernel.org/bpf/20260509084858.773921-5-maciej.fijalkowski@intel.com/

Thanks,
MF

> 
> Hi,
> 
> here we fix page_pool leaks which happen when fragment is released
> within XDP program and memory type is set incorrectly. The reports come
> from syzbot and AF_XDP test suite.
> 
> Most of the changes are about pulling out the common code for
> init/prepare xdp_buff based on existing skb and supplying it with
> correct xdp_rxq_info's mem_type that is assigned to xdp_buff. A bit more
> stuff, page_pool related, had to be done on veth side.
> 
> Originally, this work was started by Octavian Purdila and continued by
> Maciej up to v5. Maciej then took the larger veth rework from the v5
> review to net-next as an RFC [1]. This v6 picks up the v5 series, with
> Maciej's agreement, as the minimal fix for bpf and stable, and addresses
> the v5 review. Maciej stays the author of patches 1 and 3 and my changes
> are noted in their commit messages; patch 2 is new.
> 
> For veth, Jakub listed three options: stop turning skbs into xdp_frames
> in veth, decide the head's mem type when the CoW was skipped, or CoW the
> head on the Tx/Redirect path. The first one changes veth's XDP handling
> beyond a fix (it is what the RFC does), so patch 3 takes the second:
> veth knows whether it just copied the buffer into rq->page_pool, and
> only then advertises MEM_TYPE_PAGE_POOL. An skb that skipped the CoW is
> linear and keeps the queue's original model, as before this series.
> The two do not conflict: the RFC can go on top of this series and
> replace the veth parts of patches 2 and 3.
> 
> [1] https://lore.kernel.org/all/20260509084858.773921-1-maciej.fijalkowski@intel.com/
> 
> Patch 2 fixes the same problem for frames in veth_xdp_rcv_one() that
> commit b3ca872947ef ("bpf: Use the frame mem type in devmap egress
> XDP") fixed for devmap; cpumap already handled it.
> 
> Testing (x86_64, QEMU via virtme-ng, KASAN + DEBUG_VM + DEBUG_NET; the
> series ran on bpf/master fb7bd3a2aad7 and, rebased without changes, the
> reproducers, kprobe path checks, devmap test and selftests below ran
> again on 05441d697f7f with the same results; the runs without the series
> on bpf/master c8a8a68d3ab4):
> - reproducer: an xdp.frags program that trims all frags with
>   bpf_xdp_adjust_tail() on 8000-byte pings over a 9000 MTU veth pair;
>   without the series both generic XDP and native veth XDP hit
>   "BUG: Bad page state ... page_pool leak" followed by
>   VM_BUG_ON_PAGE(page_ref_count(page) == 0) and a panic; with the
>   series 20/20 packets are trimmed with no splat
> - native veth XDP_TX of multi-buffer packets, with and without
>   trimming frags first (200 large + 200 small pings each), then veth
>   teardown and a 75s wait for page_pool "stalled pool shutdown" or
>   negative inflight warnings: none
> - BPF selftests on bpf/master with tools/testing/selftests/bpf/config:
>   ./test_progs -t ns_xsk,xdp: all 34 tests (205 subtests) passed, no
>   splats, with and without the series
> - the standalone AF_XDP suite (test_xsk.sh) also runs the tests that
>   test_progs skips as flaky; XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF reports
>   PASS either way, but without the series dmesg shows 60 "page_pool
>   leak" splats from generic XDP (bpf_xdp_adjust_tail -> __xdp_return ->
>   page_frag_free on pages allocated by skb_pp_cow_data()); with the
>   series there are none
> - frame path: one veth bounces 8000-byte pings with XDP_TX, its peer
>   trims all frags of the resulting frames (IPv6 off, so no skb touches
>   the peer's rxq first); with patches 1+3 only: "page_pool leak",
>   VM_BUG_ON_PAGE() and a panic in veth_xdp_rcv_one(); with the whole
>   series 50/50 frames are trimmed, kprobes show all __xdp_return() calls
>   with MEM_TYPE_PAGE_POOL, no splat, also with IPv6 on so that skbs and
>   frames interleave on the peer's queue; bpf/master alone passes as well
>   since veth only sends MEM_TYPE_PAGE_SHARED frames there
> - remaining veth paths, each confirmed with kprobes: skbs that skip the
>   CoW (frames passed up by one veth and forwarded back into it: 1229 of
>   1260 runs without skb_pp_cow_data(), heads from the page_pool),
>   XDP_REDIRECT failing on the skb path (40 xdp_return_buff()) and on the
>   frame path (40 xdp_return_frame()), XDP_PASS of 20 frames after their
>   frags were trimmed; no splat, and none of the page_pool shutdown or
>   inflight warnings 75s after teardown
> - devmap egress after patch 3: veth redirects copied skbs through a
>   devmap whose egress program trims all frags; with the series 20/20
>   trimmed, all __xdp_return() calls with MEM_TYPE_PAGE_POOL, no splat,
>   nothing 75s after teardown; with b3ca872947ef reverted on top of the
>   series: "page_pool leak" from page_frag_free() under
>   dev_map_bpf_prog_run(), VM_BUG_ON_PAGE() and a panic, hence the
>   stable prerequisite in patch 3
> - W=1 builds of the touched files with LLVM=1 and with DEBUG_NET=n: no
>   warnings
> - XDP_ADJUST_TAIL_GROW fails in DRV mode with and without the series,
>   so it is unrelated
> - not tested: page_pool frames from hardware drivers redirected into
>   veth, bpf_xdp_pull_data(), multi-queue load, the full test_progs run
> 
> Performance (the same VM with 8 vCPUs, non-debug kernels with
> PAGE_POOL_STATS, bpf/master fb7bd3a2aad7 with and without the series;
> pktgen sends skbs into one end of a veth pair, the program on the other
> end counts packets; median of 6 runs of 8s over two boots per kernel):
> - 64-byte packets with native XDP_DROP, XDP_TX and XDP_REDIRECT (devmap
>   to another veth), and generic XDP_DROP on 1 and 4 CPUs with 64 and
>   8000-byte packets: within 2% of the base kernel, no regression
> - native veth with 8000-byte packets (3 frags): XDP_TX +8.8%
>   (0.507 -> 0.552 Mpps), XDP_REDIRECT +8.4% (0.613 -> 0.664 Mpps).
>   Without the series veth_xdp_get() takes plain page references on
>   the head and frags, so the pages copied into rq->page_pool are
>   released from the pool instead of recycled (~1.2M/s
>   rx_pp_recycle_released_ref plus slow allocations); with page_pool
>   references they go back to the ring (~1.4M/s rx_pp_recycle_ring, no
>   released_ref)
> Absolute numbers in a VM differ between boots, so only the relative
> change is meaningful.
> 
> This v6 was prepared with an AI coding assistant (Claude) from the v5
> review thread; the assistant wrote the code changes, all of patch 2,
> the changelog updates, and ran the tests listed above.
> 
> 
> 
> Maciej Fijalkowski (2):
>   xdp: introduce xdp_convert_skb_to_buff()
>   veth: update mem type in xdp_buff
> 
> Slawomir Stepien (1):
>   veth: use the frame mem type when running XDP on an xdp_frame
> 
>  drivers/net/veth.c | 56 ++++++++++++++++++++++++++++++----------------
>  include/net/xdp.h  | 36 +++++++++++++++++++++++++++++
>  net/core/dev.c     | 25 ++++-----------------
>  3 files changed, 77 insertions(+), 40 deletions(-)
> 
> 
> base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
> -- 
> 2.56.0
> 
