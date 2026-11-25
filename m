Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795615509;
	b=Kf/EkaobooEfrt1U8jThKk7bObhhBRf3OEeDJ3S1eqgZllNJObLLaLpR47yQ6BlU6KRA
	 /DFFD7CJBXyX910xVKHu1dsoDBIEvtbMa3muxSlJxCIpMlogCW/kBXkK/TI26Uo3JayI+
	 oo0rWaHekr9m8+keHf8NlGAy+7Yoc+yJmQbi0eoqb4YvyOdiR/2iO2mijR+rmUWCWRvmm
	 oXbVdz81u2y2M5Vf5Ns90nj7Sfyxuu3Cj9PZq66+XX0TElVZpBOsidTyDyaG2hDPQkRXz
	 bhtTglgHw0C6xeWdCCGvxg2KcZpz6RdmKA3zZS6Olzo2czGDGOfraIXiIxSxE58CeKA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615509;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:In-Reply-To:
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
	bh=T99jaVFxiuejvdPI2G5fWVH6Ll0I6CgaqljZcXvlUTo=;
	b=wEpW+qI4WZc7xjpMYnZuzrO22/ArtiCraKAmJLtqHo8mAOEFYHgol4/vrQ3sA6n7/FaG
	 Q8spi0Kf+w4qq17k15F5Lg+ln7Vmm5K0cbiCJqhp4jYXjxl6s+BESsgTYpt82k4CgtAXj
	 S94PM4MkaltqQ65jm739UUmDETAmTHIP25XeQDEk0oer3aPSmYCmrIkorfILZfWH8RkWR
	 bu1IbbrE2y/44098UygaCKwZRDoG4QKWfNmNxKE65kSqzMajwp1/vXE1oA7BJK5kfuOk3
	 LRYfoss4O6rMccochexM/OzJi3k26jHXt5iJJbEyCHpw376qtKWKHbtpxl0jnGhHMPA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I4UoPY2x;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ErPPQkc6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF79D606A31E;
	Wed, 25 Nov 2026 14:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF79D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=I4UoPY2x;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ErPPQkc6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795615509; x=1827151509;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zhwREhgS+nLCV0w8IBH1BoyGSizv6e0cMnKJ9FM6uNw=;
  b=I4UoPY2xacXUBaj2yar0Uqbgfr0N1QkvvjNr6PjtLWq/UEiu1T5yqT/g
   5chq+Vu3owzTLJegA50bE3hyeH3JpD55f+y0ipS+E0VWC/AufMYnNZcKR
   j0k2ocnsnKk+fivTOLZyxwVQabcyQipV6tWJ579xEQCGkO/DAEtuTBVmf
   ywsqglzDDAbCm6BuJlz0/KUOCgxDSnawjwOQffbc7os6oNqk4zZOUoD2O
   jzItpxZ8d5JVtYqFx2NCQIO4RMOYsXlt6HUyjvFf0Nu3pGESgu8ZLWSDM
   icxi3+subJlJ3zGCxj7dcVJVTvo+yhAPTu2Is0BYu2OY4Tb7kIN58bSdE
   w==;
X-CSE-ConnectionGUID: Etm6EF7tRc2OSfYh0ke/aQ==
X-CSE-MsgGUID: x9/fCZd9Tg6njYMK8TiYKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4383886"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4383886"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 06:04:49 -0800
X-CSE-ConnectionGUID: ZzgQyY4PTFm9NHlirpFWvA==
X-CSE-MsgGUID: Jay0wj5gQ0a3WqgLhFiRcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11758192"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 06:04:46 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 06:04:45 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 06:04:45 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 06:04:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hfnG8SXTm6H6MVJNLe+40Boe5yQBsRgVpmTsXDZs5uik0ToNT3ygFO7pRLkM3s3gN/Uygm9pShIJx+2+78TM7PEfzaT1jTViHc3LkZO8INluTkdG63/ujqetlxUECkSFEoBYQslrEfF5x4cQzF1gGY9bAFy/F4fzKTflBWyROUltcs/RRH4KPkLnOlBhir6k7NYXTAlXZ7gsZhkh6bp1O78Q2u6tNOQ10iSuKup9xWPyQvaZ8VAyY4lKGiIt5/d3mftjdyFiswXFFmnDNzzab4dtklp525+HKEMU6cXYBjTUdAKxM+ZfAkm16K5L2eArEa6z4S/pFxB1y2QeilzXrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T99jaVFxiuejvdPI2G5fWVH6Ll0I6CgaqljZcXvlUTo=;
 b=xoOxaIZk0TnjExTG2Sa+H4KiSZVsXEXCd0TUo+3NIA2qjS6VO9rQ6fac5whL2irqJum8CTvLVLlz5A0t6nYWTKLEGIGX25LQZw7IEgnITzq/DGE0fYU5TLKlmprnf/Rjq2z+uYlfWEiRVFzeBISqqAuiglFbuaMNqv4pORpDX0PhyI6kcTIqRvXbfMnigbPLg5xuIWNwRc2DgW7aAf6MdbHoIFMa/sli7o14SOOPxbW15fgY9oolnFgfuK3uabwkVD4oTxj+2wxeEr8Tlsw+hq4V+4mu2vGUKDTti/n/xVDyMrdi52ihuMDwDS0/PsiQA50evpAOU+OrE1jheahKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T99jaVFxiuejvdPI2G5fWVH6Ll0I6CgaqljZcXvlUTo=;
 b=ErPPQkc651kkxHjFWXmfjPj0diBeXqqyhsOym2blT0v9y97eEzr2UUxOyrQDECiQj7bgXc2u8jfA2lnkxGwmXVVQ9vPwwhqKxdRc1MSjBT8KM3mEhdCkCStMcPHXt44KHBn0xB3LpX5t8ABMjNK1JxvyUJn7bYZO7E97W32q6y4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by DS4PPF10012BF96.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 14:04:28 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 14:04:28 +0000
Date: Wed, 25 Nov 2026 15:04:16 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Slawomir Stepien <sst@poczta.fm>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	<jiayuan.chen@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, "David S .
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>, Tianyi Gao
	<tianyi@cloudflare.com>, "Octavian Purdila" <tavip@google.com>, Toke
 =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, "Ilias Apalodimas"
	<ilias.apalodimas@linaro.org>, Lorenzo Bianconi <lorenzo@kernel.org>, Lorenzo
 Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>, Andrii Nakryiko
	<andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>, Shuah
 Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v8 bpf 0/7] xdp: fix page_pool leaks
Message-ID: <awbq4F8pF3YSGX2D@boxer>
References: <20261124104016.532341-1-sst@poczta.fm>
 <DN3QVHST3PUQ.3NINFUW0FL9IW@gmail.com>
 <awa0fvxzngTtIYVd@nr200>
 <awbJFmKWy50Dp0yS@boxer>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awbJFmKWy50Dp0yS@boxer>
X-ClientProxiedBy: DU2PR04CA0290.eurprd04.prod.outlook.com
 (2603:10a6:10:28c::25) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|DS4PPF10012BF96:EE_
X-MS-Office365-Filtering-Correlation-Id: cec53fb5-8e03-4dc5-c22a-08df4afd051c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|23010399003|261009223027099003|18002099003|22082099003|10067099003|11063799006|5023799004|56012099006|4143699003|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261022075727099003|261021123027099003|261021121427099003|261022105027099003;
X-Microsoft-Antispam-Message-Info: 6Q5eay616udhBCCAXvVaP8cSlMwhOnPocSEd1mSkvRuPQlqProeAmT82qO2AbUkH6lPvn/3btCj2kzjQ6qHuR7R4H+Lg2Eo6vTnPahS09pxGCicRK4tzko1tlPZNyN+DEt7KbOpPVNByKWbSDzH4y1pryvlTvZSOLudTN3DASPNZzRKlVSRfCYR93jb2o31V885L/xMM+FpSu5AajFs2MFxk/TjEb9Z/hncH7ki0NVDdwp5edYQpHLv5w7nBwMm+Kkit7Jx8HKISR8Zq4+sjl59EF5h7hoxrWnUwBAVzpvhDDiGlV2cyqPNNEDeANDw3t33l4+ndM4rG7MKoIBCmVK2GUSTcMnHrzbJ0vlrUlYNbPdBcRs+YYBjXF5sd6CXNIJPA/aES+PjbS0gmU/qycjvrQFhCMQfPOSpuTzcmv0enKf7QLl6vkQkHWTXeggj63a73mBYSv/cLn2oNc79jDCfBdR8Ouo2eoQT2JIhA+JjvM/eeCljHAmx4mZeEZDe85YqH1EzRZJQH3pbrfQpDkc6HWkYNN6+wwGFlFFC3EUE0Il7IFhf7ziZJHYtybhqGpMIFZSmGzFTY5VaLfC80fFgSDkwj+LxkkzYXo1kerv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OQjxQaS4SK/E83+trLSJsP+SyhXoUBs0eN0wfSaMUhe9vY0KsA3+5fonSuBN?=
 =?us-ascii?Q?mSTtftHbwdrkSZFSLAfhHA9m6sYY4BOau2VwNAnmOffuCS37n4/Z12qfcLMp?=
 =?us-ascii?Q?s4AlYHd4PFkRLDeyLFYeeTP6jcQXRj/e8wCr6yQESeNfkKCA9ixL0JnBJVkf?=
 =?us-ascii?Q?0upNwkBr8vHf5/Bev5PtXCj9P9fbkBhoqPrJLD5fgcNPt9WOiexDzYeUdj/m?=
 =?us-ascii?Q?SoZ3dBJVLVO71Kk5gbFz10ZYH6SfC1zBBz6erfgXSRmcV3HeU9uBf7jNv7ji?=
 =?us-ascii?Q?Rk7gM3qcW+4rZKq/HJRjY7Pd7id2GCmOrJu1f7A+BYcHsrfUf3y7IjDMJKgd?=
 =?us-ascii?Q?wYDvly/04Y7mCSWKXxPODJkLUP8bGVsS1NDXaL7HLPcuoFcYy2u1WgmnqE6A?=
 =?us-ascii?Q?3yTipdcIXpVCRczCoIMw/bKSWVdmSJaee5NkdbZgQ6bS8XREr/ilgj+JDzaG?=
 =?us-ascii?Q?jUnp9w6FH5twUeE4UE5MVouMqcoPWAe3ayhEqJoU7QqHxRIs6Ir9nNu53ujR?=
 =?us-ascii?Q?pckGQlVMlIB05Pf4wD5FcigDikeN13kV+EDFL3LyINsIs1VmQIbVR4kiKXu0?=
 =?us-ascii?Q?wFHElINtKtr0A37nJGnrmZWGddj9VbgBOJmX8TmJ2kcUxXlasAJl+Hp5bEj1?=
 =?us-ascii?Q?DlY0lhOpqtELaVslRlICQn/S4ghuVn4HetZRf9fdICY1u3LoyMXYAwDVRaQ3?=
 =?us-ascii?Q?fTlKX7IABomLHutG0Twtk/L5n5jW/ioeaxxFPd74WIvFL0YB/g0i7mfK/T6k?=
 =?us-ascii?Q?X7AO+iduaw5aJ5gYhRt836m1CFGKTolGI1f6y0g1JjyRhjtzzlWxR46Zo/Qd?=
 =?us-ascii?Q?xJACtf82MuDl4+0pd4VsqdCZZHMsCCDehYBOpKhKg5Dxut+xsNk+mvxoRMiP?=
 =?us-ascii?Q?D7GDpwjss0eznJocyA1vMeFEVi6nRhUjoChCCX37PZlFC3i5gzZ1KFAjR6Xa?=
 =?us-ascii?Q?LfjX8U+jEV9jkeYgJjCLHqP98h6UBDvpLniiKTJtmcKr6EaSpl4U6FWI9pML?=
 =?us-ascii?Q?PQamleG7xgh0jBJ96US6CfeWJkBAK0cdCEyG4RIKAuk2Zmxh5wHfSYLNFp0Q?=
 =?us-ascii?Q?m7wrcClV3L0I+ljvUoGvsRj0bZLb9X6Z0HqwYLOtzn0mrGkHHSMbEDCQ8CLw?=
 =?us-ascii?Q?ZPHFvx1/Mik6RxeL1Yut5aI5pE5kwXgrjagvB4pnFWhn11nrXwbtNMoFGYZq?=
 =?us-ascii?Q?129YXdUSZZ2X9E3wrRutfh3W8BK5avG3UqRXtWy5m3gRhxjkJnzLM1hfb9/j?=
 =?us-ascii?Q?ppOGjruJpY3J+RVUrZ3WsD3w0sSJXGIhdl08MlglJutBakNvMBwiVJ7QPCLN?=
 =?us-ascii?Q?sXWZ+7mJO/IvYaUrelfI1FcHr7PK1J0XSC79kUdiO0W/TQ6EnonxwPzJqNXO?=
 =?us-ascii?Q?gzYPYp2LPm5+K17Mt2/77FweP7C6uzrjZnF2G40kGGfi/Jl7yGbNE1uso5xF?=
 =?us-ascii?Q?5ELEC2Ud6WBMup65nhLUb9WIeLAfT8xpK2mmUhPH9YUiXRFaEZnvtb7okNqB?=
 =?us-ascii?Q?txbaMcRFSS/K8zf38DOLewL28lxEFreHp3BL/ycHTWLep1N6FSq0IhqqnytO?=
 =?us-ascii?Q?u3NO87/0RcUlZYrpyoPNC/EEMwTPTVu03M2oy67gGdto2XC+Z7yrcTcUlsN4?=
 =?us-ascii?Q?NVL1lrKoHrwr1IXRxq/JvL/zQKrbSY4wgrgUO2HsbJG2LmJgbHegZsjBNECR?=
 =?us-ascii?Q?VFqurOVbzhGw5XBkNx3gHpfjkxXrZn3NfDcV68rt/F8mwu3z28jXofInAVMJ?=
 =?us-ascii?Q?MhKMTjx88Ye4T1BJ4USAuU8xOGRTJ9c=3D?=
X-Exchange-RoutingPolicyChecked: jbP0aQsL3R0mUhEpLAwPA3r0gbzRFnA5Kqq07WMbCpOYANsXvnhUwkoMczqpLiqEtD1q/DeOs+Xd/ItQrcaLeqoiENngjN1XeJ+ehwENUROO26Y2rJJhPCgPv6yk4e6jeYNUQTvNKPIGWX0QHY3LiXwiFAUvBHg+jcMp8OKJT7vyX9n08q2WSmgPKAGgwmiuaF2xec7GhE53oya3/rMlgOWQLt06apAQOVlcA6qMKfUOAG6hX7WiVLWOyBpl1j0Al1sFd4WxHji4cbk08pcHq40ggx2UtuGu3SjuUagSCEPR8O1Co/wiLDK1SWwVnG0U0QxpcvpoWtePGghuOBstfA==
X-MS-Exchange-CrossTenant-Network-Message-Id: cec53fb5-8e03-4dc5-c22a-08df4afd051c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 14:04:28.3779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pjWK1+7POiJbqWo3gzmPwTIRO5TYmtoQpD1Fr4xItbZxujw7Dkn/ZMCEZfojXvWoj3iPB9t0R8J+vH6P+sAPdcnZb+8UQSAulcSHv12XWvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF10012BF96
X-OriginatorOrg: intel.com

On Wed, Nov 25, 2026 at 12:40:06PM +0100, Maciej Fijalkowski wrote:
> On Wed, Nov 25, 2026 at 11:12:14AM +0100, Slawomir Stepien wrote:
> > On lis 24, 2026 21:04, Alexei Starovoitov wrote:
> > > On Tue, Nov 24, 2026 at 02:40 AM Slawomir Stepien <sst@poczta.fm> wrote:
> > > > Patch 1 prepares bpf_prog_test_run_xdp() for patch 3. Generic XDP runs
> > > > on the rxq info of the device queue, which is shared with test_run; with
> > > > patch 3 alone, any packet through generic XDP on lo makes later
> > > > multi-buffer test runs free their frags as page_pool pages. Restoring
> > > 
> > > The store into the shared rxq is the problem.
> > > Patch 3 does it for every packet on every CPU, for linear skbs too.
> > > The comment in include/net/xdp.h says that rxq must not be updated
> > > during NAPI poll.
> > > On Dudu's patch I proposed to put rxq on stack:
> > > https://lore.kernel.org/bpf/DMAP8LNBJRPN.2THUHLKURP25G@gmail.com/
> > > It works for veth too.
> > > An skb leaves veth as a MEM_TYPE_PAGE_SHARED frame, like today.
> > > No need for xdp_convert_skb_to_buff(), veth_xdp_get_pp(), pp_cow,
> > > rq->xdp_mem and patch 6.

I have some second thoughts here.

It covers only half of the problem though; "like today" is the other
half. When veth copies an skb into rq->page_pool and the prog returns
XDP_TX or XDP_REDIRECT, veth_xdp_get() pins head and frags with plain
page refs. consume_skb() then drops the last page_pool ref while the
page refcount is still elevated, so __page_pool_put_page() releases
the page from the pool instead of recycling it, and the PAGE_SHARED
frame later frees it to the page allocator. The pool keeps allocating
fresh pages; that is the ~4.8M/s rx_pp_recycle_released_ref in the
benchmark of Slawomir's RFC [1].

In v8 these frames were MEM_TYPE_PAGE_POOL with page_pool refs
(veth_xdp_get_pp()), so the pages went back to rq->page_pool.

Nothing leaks with your diff, it is only about recycling, so I'm fine
with keeping it out of the fix and following up in net-next. On top of
the on-stack rxq it should be small: for skbs veth copied (what pp_cow
tracked; an uncopied head is usually not page_pool memory), keep
MEM_TYPE_PAGE_POOL in veth_xdp_get() and take page_pool refs instead
of page refs. Unlike the RFC, which keeps skbs as skbs, that preserves
the XDP_TX/devmap bulking (the RFC loses 8-17% there [1]).

Would you be OK with that as a follow-up?

[1] https://lore.kernel.org/bpf/20261110101941.1059662-1-sst@poczta.fm/

> > 
> > Thanks for these points. This approach is less complex. Let me play with it and I will respin it in
> > v9.
> 
> Whatever it takes to get this fixed! :D so many tries.
> Thanks Alexei for picking up the gloves here.
> 
> Looking forward to next revision then.
> 
> > 
> > > Patches 6 and 7 never free a page_pool frag. Jiayuan's test does:
> > > https://lore.kernel.org/bpf/20260911135711.109338-3-jiayuan.chen@linux.dev/
> > 
> > Jiayuan Chen, can I use your selftest then in v9? :)
> > 
> > > Below replaces patches 1-5.
> > > 
> > > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > > index faa837a..8bb015c 100644
> > > --- a/drivers/net/veth.c
> > > +++ b/drivers/net/veth.c
> > > @@ -63,7 +63,6 @@ struct veth_rq {
> > >  	struct napi_struct __rcu *napi; /* points to xdp_napi when the latter is initialized */
> > >  	struct net_device	*dev;
> > >  	struct bpf_prog __rcu	*xdp_prog;
> > > -	struct xdp_mem_info	xdp_mem;
> > >  	struct veth_rq_stats	stats;
> > >  	bool			rx_notify_masked;
> > >  	struct ptr_ring		xdp_ring;
> > > @@ -642,6 +641,7 @@ static int veth_xdp_tx(struct veth_rq *rq, struct xdp_buff *xdp,
> > >  }
> > >  
> > >  static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
> > > +					  struct xdp_rxq_info *rxq,
> > >  					  struct xdp_frame *frame,
> > >  					  struct veth_xdp_tx_bq *bq,
> > >  					  struct veth_stats *stats)
> > > @@ -657,7 +657,8 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
> > >  		u32 act;
> > >  
> > >  		xdp_convert_frame_to_buff(frame, xdp);
> > > -		xdp->rxq = &rq->xdp_rxq;
> > > +		rxq->mem.type = frame->mem_type;
> > > +		xdp->rxq = rxq;
> > >  		vxbuf.skb = NULL;
> > >  
> > >  		act = bpf_prog_run_xdp(xdp_prog, xdp);
> > > @@ -669,7 +670,6 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
> > >  			break;
> > >  		case XDP_TX:
> > >  			orig_frame = *frame;
> > > -			xdp->rxq->mem.type = frame->mem_type;
> > >  			if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
> > >  				trace_xdp_exception(rq->dev, xdp_prog, act);
> > >  				frame = &orig_frame;
> > > @@ -681,7 +681,6 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
> > >  			goto xdp_xmit;
> > >  		case XDP_REDIRECT:
> > >  			orig_frame = *frame;
> > > -			xdp->rxq->mem.type = frame->mem_type;
> > >  			if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
> > >  				frame = &orig_frame;
> > >  				stats->rx_drops++;
> > > @@ -746,6 +745,9 @@ static void veth_xdp_get(struct xdp_buff *xdp)
> > >  	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> > >  	int i;
> > >  
> > > +	/* the buff holds plain page references from here on */
> > > +	xdp->rxq->mem.type = MEM_TYPE_PAGE_SHARED;
> > > +
> > >  	get_page(virt_to_page(xdp->data));
> > >  	if (likely(!xdp_buff_has_frags(xdp)))
> > >  		return;
> > > @@ -755,6 +757,7 @@ static void veth_xdp_get(struct xdp_buff *xdp)
> > >  }
> > >  
> > >  static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> > > +					struct xdp_rxq_info *rxq,
> > >  					struct xdp_buff *xdp,
> > >  					struct sk_buff **pskb)
> > >  {
> > > @@ -773,7 +776,9 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> > >  	/* SKB "head" area always have tailroom for skb_shared_info */
> > >  	frame_sz = skb_end_pointer(skb) - skb->head;
> > >  	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > -	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
> > > +	/* the prog can free only frags and they came from skb_pp_cow_data() */
> > > +	rxq->mem.type = MEM_TYPE_PAGE_POOL;
> > > +	xdp_init_buff(xdp, frame_sz, rxq);
> > >  	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
> > >  			 skb_headlen(skb), true);
> > >  
> > > @@ -794,6 +799,7 @@ drop:
> > >  }
> > >  
> > >  static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
> > > +					struct xdp_rxq_info *rxq,
> > >  					struct sk_buff *skb,
> > >  					struct veth_xdp_tx_bq *bq,
> > >  					struct veth_stats *stats)
> > > @@ -815,7 +821,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
> > >  	}
> > >  
> > >  	__skb_push(skb, skb->data - skb_mac_header(skb));
> > > -	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
> > > +	if (veth_convert_skb_to_xdp_buff(rq, rxq, xdp, &skb))
> > >  		goto drop;
> > >  	vxbuf.skb = skb;
> > >  
> > > @@ -830,7 +836,6 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
> > >  	case XDP_TX:
> > >  		veth_xdp_get(xdp);
> > >  		consume_skb(skb);
> > > -		xdp->rxq->mem = rq->xdp_mem;
> > >  		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
> > >  			trace_xdp_exception(rq->dev, xdp_prog, act);
> > >  			stats->rx_drops++;
> > > @@ -842,7 +847,6 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
> > >  	case XDP_REDIRECT:
> > >  		veth_xdp_get(xdp);
> > >  		consume_skb(skb);
> > > -		xdp->rxq->mem = rq->xdp_mem;
> > >  		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
> > >  			stats->rx_drops++;
> > >  			goto err_xdp;
> > > @@ -914,6 +918,11 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
> > >  			struct veth_xdp_tx_bq *bq,
> > >  			struct veth_stats *stats)
> > >  {
> > > +	struct veth_priv *priv = netdev_priv(rq->dev);
> > > +	struct xdp_rxq_info rxq = {
> > > +		.dev = rq->dev,
> > > +		.queue_index = rq - priv->rq,
> > > +	};
> > >  	int i, done = 0, n_xdpf = 0;
> > >  	void *xdpf[VETH_XDP_BATCH];
> > >  
> > > @@ -928,7 +937,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
> > >  			struct xdp_frame *frame = veth_ptr_to_xdp(ptr);
> > >  
> > >  			stats->xdp_bytes += xdp_get_frame_len(frame);
> > > -			frame = veth_xdp_rcv_one(rq, frame, bq, stats);
> > > +			frame = veth_xdp_rcv_one(rq, &rxq, frame, bq, stats);
> > >  			if (frame) {
> > >  				/* XDP_PASS */
> > >  				xdpf[n_xdpf++] = frame;
> > > @@ -943,7 +952,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
> > >  			struct sk_buff *skb = ptr;
> > >  
> > >  			stats->xdp_bytes += skb->len;
> > > -			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
> > > +			skb = veth_xdp_rcv_skb(rq, &rxq, skb, bq, stats);
> > >  			if (skb) {
> > >  				if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))
> > >  					netif_receive_skb(skb);
> > > @@ -1149,9 +1158,6 @@ static int veth_enable_xdp_range(struct net_device *dev, int start, int end,
> > >  						 NULL);
> > >  		if (err < 0)
> > >  			goto err_reg_mem;
> > > -
> > > -		/* Save original mem info as it can be overwritten */
> > > -		rq->xdp_mem = rq->xdp_rxq.mem;
> > >  	}
> > >  	return 0;
> > >  
> > > @@ -1180,7 +1186,6 @@ static void veth_disable_xdp_range(struct net_device *dev, int start, int end,
> > >  	for (i = start; i < end; i++) {
> > >  		struct veth_rq *rq = &priv->rq[i];
> > >  
> > > -		rq->xdp_rxq.mem = rq->xdp_mem;
> > >  		xdp_rxq_info_unreg(&rq->xdp_rxq);
> > >  
> > >  		if (delete_napi)
> > > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > > index d6c9dc6..1d89b6f 100644
> > > --- a/net/bpf/test_run.c
> > > +++ b/net/bpf/test_run.c
> > > @@ -1349,6 +1349,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
> > >  	struct netdev_rx_queue *rxqueue;
> > >  	struct skb_shared_info *sinfo;
> > >  	struct xdp_buff xdp = {};
> > > +	struct xdp_rxq_info rxq;
> > >  	int i, ret = -EINVAL;
> > >  	struct xdp_md *ctx;
> > >  	void *data;
> > > @@ -1417,8 +1418,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
> > >  	}
> > >  
> > >  	rxqueue = __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0);
> > > -	rxqueue->xdp_rxq.frag_size = PAGE_SIZE;
> > > -	xdp_init_buff(&xdp, rxqueue->xdp_rxq.frag_size, &rxqueue->xdp_rxq);
> > > +	xdp_init_buff(&xdp, PAGE_SIZE, &rxqueue->xdp_rxq);
> > >  	xdp_prepare_buff(&xdp, data, headroom, linear_sz, true);
> > >  	sinfo = xdp_get_shared_info_from_buff(&xdp);
> > >  
> > > @@ -1426,6 +1426,11 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
> > >  	if (ret)
> > >  		goto free_data;
> > >  
> > > +	/* generic XDP uses the same rxq and its frags can be smaller */
> > > +	rxq = *xdp.rxq;
> > > +	rxq.frag_size = PAGE_SIZE;
> > > +	xdp.rxq = &rxq;
> > > +
> > >  	size = linear_sz;
> > >  	if (unlikely(kattr->test.data_size_in > size)) {
> > >  		void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
> > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > index 6140fd9..fe9f222 100644
> > > --- a/net/core/dev.c
> > > +++ b/net/core/dev.c
> > > @@ -5684,6 +5684,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> > >  	void *orig_data, *orig_data_end, *hard_start;
> > >  	struct netdev_rx_queue *rxqueue;
> > >  	bool orig_bcast, orig_host;
> > > +	struct xdp_rxq_info rxq;
> > >  	u32 mac_len, frame_sz;
> > >  	__be16 orig_eth_type;
> > >  	struct ethhdr *eth;
> > > @@ -5707,6 +5708,13 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> > >  	if (skb_is_nonlinear(skb)) {
> > >  		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
> > >  		xdp_buff_set_frags_flag(xdp);
> > > +		/*
> > > +		 * The frags came from skb_pp_cow_data(). xdp_rxq is shared
> > > +		 * with other CPUs and with BPF_PROG_TEST_RUN, so use a copy.
> > > +		 */
> > > +		rxq = rxqueue->xdp_rxq;
> > > +		rxq.mem.type = MEM_TYPE_PAGE_POOL;
> > > +		xdp->rxq = &rxq;
> > >  	} else {
> > >  		xdp_buff_clear_frags_flag(xdp);
> > >  	}
> > > @@ -5719,6 +5727,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> > >  	orig_eth_type = eth->h_proto;
> > >  
> > >  	act = bpf_prog_run_xdp(xdp_prog, xdp);
> > > +	xdp->rxq = &rxqueue->xdp_rxq;
> > >  
> > >  	/* check if bpf_xdp_adjust_head was used */
> > >  	off = xdp->data - orig_data;
> > > 
> > > pw-bot: cr
> > 
> > -- 
> > Slawomir Stepien
