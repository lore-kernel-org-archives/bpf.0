Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795606840;
	b=AJjn2bhln5HaOXMRq8QMfNKGwzsWJiWOHchqjLe9bXq425yVX4Rod7sQXxAtQJjDedDl
	 sdCTT0Ep959hWPg0RcXlBDvaTgW8IfVGrs+LkNuP4Rw3w3M1PLatGkyXhnDXrCpXqPf4M
	 HLSBxpV9LqqJV1c7WlOKQlJ/VjVk/alNFwF6g0SCo8AVXPZ9FmmXZB4LcCf5pv28tg/5L
	 OOXcleLV8IgQ82u06tfxowR70nBbIb+IzbL1Z6GMIslrIa2sGDSCrUiNybbZee5IZMafb
	 NVOTxYTwhLdvZs9ad06UADK4cv4zqdwhQfzg3BmVKPcldVyKY7ofQOJFXeWOvdkSSfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606840;
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
	bh=LfWQ/QjQDIc45sVFxdvnE8GLBMYIo0FIdFXR3QXcbQE=;
	b=nuewMNzRA8VyLWLohqO8dUcH8meL9DlqvHoYlB0n5wdJpwElR/+eDt4y3Y0NsqJpoQrO
	 iPiGGJKuNyWZxbHctAfPsh4VA4kUMVlqekWUeHIetMKi5olIY0fI8GIn2ZRrErYEfTyHP
	 0LauYoioveDku8NWBatXHlJz7wsfaEV0rzT5UGZq3ImK26P4WWCualMUqGJUlcc61gCfT
	 ZxOAr1n6+Qnnlfgt/Jp8+NW3YrllOtfWW9gYZrF7h/0hGu+3XXgSwIiluVX7aoyObwGze
	 CIUS6DcRDc8mNTJo2RxjM75wuTBXpzl6nnjQS4iB6AvCJ37Z2bxEBWP5QZjGj5HcnYQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fAkrOEHt;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=HPkt9JIw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C16A606A31E;
	Wed, 25 Nov 2026 11:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C16A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fAkrOEHt;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=HPkt9JIw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795606841; x=1827142841;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IQnNA1q6sPkgH9b7heIRvVGgQPVU+FU99AOqNmu4zsM=;
  b=fAkrOEHtFKm+xPNjewImkcmPSO9CFzbyhvxDoTEy/bGptJMRWndL6XqO
   ko8vtxBW7skjhPh2vK8Tl0O7wHT+h1WocaOvY2TE8X/ncRdlHIRJRUXZr
   gRlaCJkwN4A1wzz0NJOQmqCUDWEk4EVgyb184XvlOTpR+n4mgsymH/xj+
   cT2Jf8129hCvGEQUlrgJgrfdsVIhIwYNBx2G2PFCVtoTnSfLegcfWFA3m
   KOrlr76xa3TIooHLVkKyTcV4XuMrVBmaKEnq5YfwJGltZG8EokfOIhNuX
   wlfIVgJA+U6c4ZoNiK3Fv+zYpDsyx7neE12dvKKwYZKr6MSdd9E983RqZ
   Q==;
X-CSE-ConnectionGUID: ULux8rfVQ7K3Fj9HmafYhQ==
X-CSE-MsgGUID: oY6/HtC7SYy+GF/Gz7Dv/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4368568"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4368568"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 03:40:40 -0800
X-CSE-ConnectionGUID: 3qnA0Of5TGuD0YKGjbxSiA==
X-CSE-MsgGUID: VYBHUKmASvOPGrNQqspFgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11955444"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 03:40:30 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 03:40:29 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 03:40:29 -0800
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.23) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 03:40:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=exxygXA/MwbAqobuUlYJCxyATq0sKp09ki8VcGzXrduWsLMgBQYVVfqlRTFW8JpYPwgNGN5lhFK0GVQG0lD5ujIl27r/pbXBGKxMYXEOlTsXcXoJylAGk5AaZunWe6alTWBk7DoiO4+Mt0OYeaNsqsQoiTUW3L3sQaam8MOzC0dGKbO1PcIUSG6t6HLtnDCY/xx+qjpt+QBn5V4SHnppXloQ7g4tA4NCUl2XDsRvJ/obkMTN9WH4Qj7vQZa/cC/+PR4b4mMfE8/F0r0nUEdqH8H/QZHAfYZkdTerLjtpdhrfSO2fo7+NuQ5kZ1k/EzxZESlrVUwYZ9ykaPE2baHRnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfWQ/QjQDIc45sVFxdvnE8GLBMYIo0FIdFXR3QXcbQE=;
 b=YFEVbJp8uyIWvXPRYFrxz6koD/FHdvCpm13wqX7qACO/kUS6Ww1ivuUO9LNoeqLVHtE9PbQ6YusKmAFO5lTiEDN65wcFSyYWRag6psc2JxEi1OwU1QQel4UMjXt18D9SoqQ1y6htl16omu0UiJPwBtPn08n4nN1OfYZlwbfWqnhvkhRnRTfH+la/59Qv1bGgF/RNoD5lUq9bRrDbDL5YJ2LFKlKR3j6kK/RknQy2jVyCVi0URaNWw+DHVpIAV5bbz38YMxvRGvq6u6Be8V0FM+6wCDeXPn8Wk6U2OY0snzEWh1jc5iHUxAKH1mGCkySjSFzK3F4Fpb+fG96fiYk62g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfWQ/QjQDIc45sVFxdvnE8GLBMYIo0FIdFXR3QXcbQE=;
 b=HPkt9JIwquhiigF9vY7dNGV+lwCR//sbr1l9ldlSVLBnyR/luC0jdACfCsWxXe8cPZxWcuOy0G2YzuU9YqX5aH9LZDEScRSZLtqvZvEg/wjmWoy05U0avcmFYCUC+YtiZcpEl4KQNnqZzEZJRk0R6qdJqEdUjS7l9XYIkzmmNw8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by PH7PR11MB5960.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Wed, 25 Nov
 2026 11:40:21 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 11:40:21 +0000
Date: Wed, 25 Nov 2026 12:40:06 +0100
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
Message-ID: <awbJFmKWy50Dp0yS@boxer>
References: <20261124104016.532341-1-sst@poczta.fm>
 <DN3QVHST3PUQ.3NINFUW0FL9IW@gmail.com>
 <awa0fvxzngTtIYVd@nr200>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awa0fvxzngTtIYVd@nr200>
X-ClientProxiedBy: DU2PR04CA0247.eurprd04.prod.outlook.com
 (2603:10a6:10:28e::12) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|PH7PR11MB5960:EE_
X-MS-Office365-Filtering-Correlation-Id: 017549e8-428d-4f86-4f0b-08df4ae8e307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|18002099003|22082099003|11063799006|56012099006|261026140227099003|4143699003|261026121527099003|261028144727099003|261022075727099003|261021123027099003|261009223027099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: YhaoOi6l9JPs6n8ryK/O3j/l23uGX8A+nB4kRmd3MwaXFk1Xquw2I6sLiaHC63+36CcLd6p0OjdDrNFJHFINWRuaTqhs2b0d2e7lanO7rUf9ohMM7fWPny/JrhG2XIbjbDLkl4t7U3pPJyLKWFnKFvdg/fo9xX46sayk9k2+Q83bFCJkQqHFkRHU9WZb86RAmTkcYb+dDbTY9xZNii5kpGlhYL9P1BwYfAcNkoxV79vzTkf08kb47Gib18E7dZepEfSHKLRHeAt3PSS6zczGyP6J9cjlW6w6NzCvMG01e4sWHwm4aJzF7f0EcX/Le4gv28itKpH/tBivvkdwrfGqpaY5d2rS1OoJVSVZNfixFeCdlAxXmtWUbkHPmKH/4IYwg1Wx8gQ7N3KdpY0xaxK/0T4WOFoWkto8H1oFTJWQjJrI+C9O5kbu+Ihw+PWT5j78nFKAAYJPgrHyjXWjfiitjV8jroPxGBhbpGTQBP7WWhQ1/fTqKv8idVmnFsUEfvrSCbynqiFgYLb13/K2ibXa6X8cQ8kaYpcFwbIlj3tFhFYRttHI+TS0GZYUC/RP5UPygDoJAs9rhREQRzJyuzjxTrPQRSAYlQwKdqwfgZpX55A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(261026140227099003)(4143699003)(261026121527099003)(261028144727099003)(261022075727099003)(261021123027099003)(261009223027099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+2hxixd4B38NbU0tlHL3wm+w6YDC5njdwekoxeW8DKmJuFrsFQ3JsbLMEapT?=
 =?us-ascii?Q?ptbppmG1shrAEdDaTEGqKQ1Wj0837KR/m8k9/F3PxkULImoQzYrKlgv9iPfc?=
 =?us-ascii?Q?Yi+s8uGC93sgdTb8xwy3VijksBwHaj5BKedW4b9JD8V0TnTA9D65bQWYuXmS?=
 =?us-ascii?Q?gbaQy8XpaOLxzFrQR+8Og1AaRVSUgJCx98a8uDwcrDYxHXKPC9+lSGkCmJXI?=
 =?us-ascii?Q?VhwTXCQjZXZ+YeVEs6TGpvYqzuC5TAe/FVm59eBZ7Hs+zSRP5w/tZ2PDza+F?=
 =?us-ascii?Q?tc6WYfxNJJ1Q0SC5+VZrv09gXKm0lqerpfi8dL0HTSEUlLY6oEZcEruLcKgy?=
 =?us-ascii?Q?oOwqZBhmKncgqDmW4d1oEG+cb9La1vvHD+0yOOFf9rFvyU4RG5fzWNbKvgIl?=
 =?us-ascii?Q?eorYqBTYsosZrqwKOSyZu+KFo75eKqRb4PA0JZOMxjx7a/YUXcrEaRypTJi/?=
 =?us-ascii?Q?H1/bAorqzcdFOxTuPIUn3/eTDyI0WwuXrgiSKeEibOV5IifcZV+pNkH9Wq+s?=
 =?us-ascii?Q?e01S6c/RWHp0ABj6T2/kFXLh1BRZEwqOimyBTWZlGvWYwIKtfklUvy/dVkCu?=
 =?us-ascii?Q?vo73w5qR4NBJuOyK3+ZA15fXXy524GsEdkBA3umTnosOAA7neRforYZaiSvC?=
 =?us-ascii?Q?4IxdlV2MKjlfoHxIeH8xKjkgYewcFXAI9PhCuv8jzkyvjQPSNPQhjcSfWTnR?=
 =?us-ascii?Q?6tLmla1lx4iCqTWZdV6X9h4NfBJ+r2AUW1fZfQF55PuurBQ5pJFkTUR2rDMj?=
 =?us-ascii?Q?NPii8uauFgFB67D+5YwvWCu+ojgpZRGezGWEBclDP58pnmS3ioWsdvwCeZm7?=
 =?us-ascii?Q?d0APiJaU5KQyGIyTjWbSoieVp9MEhc6QH6H8VyVKnhghoNrtFlX4sIQ1VN9a?=
 =?us-ascii?Q?gvOs9mzRUM0HrOSMQtdgFdeLBM0on5op7YaG/khShCAgK8rYt4tLpj1UqEgG?=
 =?us-ascii?Q?/Lla40tVziOJZFDB0QpPbb3rbPrAHbhw8D+JS1Gkb3qs8m/b3+5COyDIuODX?=
 =?us-ascii?Q?Jhlsy/CkEHgiCj0B3jzdP4eHuY7EvkeC+VuiLGbhSMhb05+vJd2RZXLyZz+h?=
 =?us-ascii?Q?b1V/dzGln6nPkfF3F7K8wbTm1BEXJxpLXrWyDJvFN2ULfT+J/je0G/gejGdw?=
 =?us-ascii?Q?9RFdbgjHZVCkoxxs9DQZzrO6qTmWcZJlECGIid33zJxf5z9LXPnxjUyEbDLP?=
 =?us-ascii?Q?BNCKMJXNH07yVA8iu1fxPOzLkCKSZN6FTHN8lMVpemZ13Af/kVDnV0tN4r1D?=
 =?us-ascii?Q?xgrSwblp6pPrGcDyrt1yYc5VVBl+TI71ci708jdCpWj7sC40QWPtWhBAyEfh?=
 =?us-ascii?Q?k7dqwVEMADh417FbjdTaNElq8KH+xhs0RjUmlZjzPsZbpOBA1ojAV14SkURO?=
 =?us-ascii?Q?wTrHbFLGTDLZkn4Dk91Z0p65RYMK1d5ENLBnbxEA/nIWmfQ16pR4Jrn0f0kM?=
 =?us-ascii?Q?A76g1BmPhRSYv5FuToB6AE+4l0Mce3ttJbNv6/fpTc4kRq5wH3ObMAMcMl/I?=
 =?us-ascii?Q?yh7e7DgiRi2hDjYS/2CewRh67vIYcwdCvR3UO83Uwh9ymWB7Fxn+cYeWl2ru?=
 =?us-ascii?Q?I5OQsaJ1onEA6FBeYvW26iruheR4iRP5GGYvB1WyO9btIibJhJDWZjwfCtyR?=
 =?us-ascii?Q?KztYOFw0TqoJAhfdaPf0Bw5tbruF5obVyZP0FxV3CsKLiww61+TwW4ah9fjM?=
 =?us-ascii?Q?klYtOd4H5yYxyeE5h9Ilj4nDuhkSHCOyD8GtUiaFecsnENq6ScA0kKYWKtpz?=
 =?us-ascii?Q?C4JTDQcwjIHrWcfGGer2QX0pGvcXEow=3D?=
X-Exchange-RoutingPolicyChecked: X5vIS6ic8Jdmvffci8cB8F7JaXOLmYB+KLne01i+wK1gtUof4+qfJDMnUbXQIf2aZmXi6a2dwO5seFj718cnKzE//9gGrsNq1EFGtIMYeH5bSTNA5ISVxUrBtCwKKcENPcxGz7vYGSPPqAIH4HVHFNCWJi98b9Q4pwGCw6eGSEapSHNpPnjmhWUHe99Fbh/LSa78YNcF7MX9NwhkP8mILxc4dNgnXCZvW/+sBWUr1FxEY4vh5VNi7pSlZr5V5YIBuldlotwRyfkOTAihunpnD6E33DwVRnrMZ+/Dt5grucYCfaQT2I7F8CpjJuAhxWX0H/96+5HkUiSmwqy5I/HC/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 017549e8-428d-4f86-4f0b-08df4ae8e307
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 11:40:21.3661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyhXDPgHv5v9uMTZNNJtqGTWg3nxlfQimDWRrD8cBVTB6e2uhqdUFllbeY8lWrj8YMt8bSXhz4fmoEAuea3yiRSUaCMDqn2vzuNELepd9BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5960
X-OriginatorOrg: intel.com

On Wed, Nov 25, 2026 at 11:12:14AM +0100, Slawomir Stepien wrote:
> On lis 24, 2026 21:04, Alexei Starovoitov wrote:
> > On Tue, Nov 24, 2026 at 02:40 AM Slawomir Stepien <sst@poczta.fm> wrote:
> > > Patch 1 prepares bpf_prog_test_run_xdp() for patch 3. Generic XDP runs
> > > on the rxq info of the device queue, which is shared with test_run; with
> > > patch 3 alone, any packet through generic XDP on lo makes later
> > > multi-buffer test runs free their frags as page_pool pages. Restoring
> > 
> > The store into the shared rxq is the problem.
> > Patch 3 does it for every packet on every CPU, for linear skbs too.
> > The comment in include/net/xdp.h says that rxq must not be updated
> > during NAPI poll.
> > On Dudu's patch I proposed to put rxq on stack:
> > https://lore.kernel.org/bpf/DMAP8LNBJRPN.2THUHLKURP25G@gmail.com/
> > It works for veth too.
> > An skb leaves veth as a MEM_TYPE_PAGE_SHARED frame, like today.
> > No need for xdp_convert_skb_to_buff(), veth_xdp_get_pp(), pp_cow,
> > rq->xdp_mem and patch 6.
> 
> Thanks for these points. This approach is less complex. Let me play with it and I will respin it in
> v9.

Whatever it takes to get this fixed! :D so many tries.
Thanks Alexei for picking up the gloves here.

Looking forward to next revision then.

> 
> > Patches 6 and 7 never free a page_pool frag. Jiayuan's test does:
> > https://lore.kernel.org/bpf/20260911135711.109338-3-jiayuan.chen@linux.dev/
> 
> Jiayuan Chen, can I use your selftest then in v9? :)
> 
> > Below replaces patches 1-5.
> > 
> > diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> > index faa837a..8bb015c 100644
> > --- a/drivers/net/veth.c
> > +++ b/drivers/net/veth.c
> > @@ -63,7 +63,6 @@ struct veth_rq {
> >  	struct napi_struct __rcu *napi; /* points to xdp_napi when the latter is initialized */
> >  	struct net_device	*dev;
> >  	struct bpf_prog __rcu	*xdp_prog;
> > -	struct xdp_mem_info	xdp_mem;
> >  	struct veth_rq_stats	stats;
> >  	bool			rx_notify_masked;
> >  	struct ptr_ring		xdp_ring;
> > @@ -642,6 +641,7 @@ static int veth_xdp_tx(struct veth_rq *rq, struct xdp_buff *xdp,
> >  }
> >  
> >  static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
> > +					  struct xdp_rxq_info *rxq,
> >  					  struct xdp_frame *frame,
> >  					  struct veth_xdp_tx_bq *bq,
> >  					  struct veth_stats *stats)
> > @@ -657,7 +657,8 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
> >  		u32 act;
> >  
> >  		xdp_convert_frame_to_buff(frame, xdp);
> > -		xdp->rxq = &rq->xdp_rxq;
> > +		rxq->mem.type = frame->mem_type;
> > +		xdp->rxq = rxq;
> >  		vxbuf.skb = NULL;
> >  
> >  		act = bpf_prog_run_xdp(xdp_prog, xdp);
> > @@ -669,7 +670,6 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
> >  			break;
> >  		case XDP_TX:
> >  			orig_frame = *frame;
> > -			xdp->rxq->mem.type = frame->mem_type;
> >  			if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
> >  				trace_xdp_exception(rq->dev, xdp_prog, act);
> >  				frame = &orig_frame;
> > @@ -681,7 +681,6 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
> >  			goto xdp_xmit;
> >  		case XDP_REDIRECT:
> >  			orig_frame = *frame;
> > -			xdp->rxq->mem.type = frame->mem_type;
> >  			if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
> >  				frame = &orig_frame;
> >  				stats->rx_drops++;
> > @@ -746,6 +745,9 @@ static void veth_xdp_get(struct xdp_buff *xdp)
> >  	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
> >  	int i;
> >  
> > +	/* the buff holds plain page references from here on */
> > +	xdp->rxq->mem.type = MEM_TYPE_PAGE_SHARED;
> > +
> >  	get_page(virt_to_page(xdp->data));
> >  	if (likely(!xdp_buff_has_frags(xdp)))
> >  		return;
> > @@ -755,6 +757,7 @@ static void veth_xdp_get(struct xdp_buff *xdp)
> >  }
> >  
> >  static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> > +					struct xdp_rxq_info *rxq,
> >  					struct xdp_buff *xdp,
> >  					struct sk_buff **pskb)
> >  {
> > @@ -773,7 +776,9 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
> >  	/* SKB "head" area always have tailroom for skb_shared_info */
> >  	frame_sz = skb_end_pointer(skb) - skb->head;
> >  	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > -	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
> > +	/* the prog can free only frags and they came from skb_pp_cow_data() */
> > +	rxq->mem.type = MEM_TYPE_PAGE_POOL;
> > +	xdp_init_buff(xdp, frame_sz, rxq);
> >  	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
> >  			 skb_headlen(skb), true);
> >  
> > @@ -794,6 +799,7 @@ drop:
> >  }
> >  
> >  static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
> > +					struct xdp_rxq_info *rxq,
> >  					struct sk_buff *skb,
> >  					struct veth_xdp_tx_bq *bq,
> >  					struct veth_stats *stats)
> > @@ -815,7 +821,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
> >  	}
> >  
> >  	__skb_push(skb, skb->data - skb_mac_header(skb));
> > -	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
> > +	if (veth_convert_skb_to_xdp_buff(rq, rxq, xdp, &skb))
> >  		goto drop;
> >  	vxbuf.skb = skb;
> >  
> > @@ -830,7 +836,6 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
> >  	case XDP_TX:
> >  		veth_xdp_get(xdp);
> >  		consume_skb(skb);
> > -		xdp->rxq->mem = rq->xdp_mem;
> >  		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
> >  			trace_xdp_exception(rq->dev, xdp_prog, act);
> >  			stats->rx_drops++;
> > @@ -842,7 +847,6 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
> >  	case XDP_REDIRECT:
> >  		veth_xdp_get(xdp);
> >  		consume_skb(skb);
> > -		xdp->rxq->mem = rq->xdp_mem;
> >  		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
> >  			stats->rx_drops++;
> >  			goto err_xdp;
> > @@ -914,6 +918,11 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
> >  			struct veth_xdp_tx_bq *bq,
> >  			struct veth_stats *stats)
> >  {
> > +	struct veth_priv *priv = netdev_priv(rq->dev);
> > +	struct xdp_rxq_info rxq = {
> > +		.dev = rq->dev,
> > +		.queue_index = rq - priv->rq,
> > +	};
> >  	int i, done = 0, n_xdpf = 0;
> >  	void *xdpf[VETH_XDP_BATCH];
> >  
> > @@ -928,7 +937,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
> >  			struct xdp_frame *frame = veth_ptr_to_xdp(ptr);
> >  
> >  			stats->xdp_bytes += xdp_get_frame_len(frame);
> > -			frame = veth_xdp_rcv_one(rq, frame, bq, stats);
> > +			frame = veth_xdp_rcv_one(rq, &rxq, frame, bq, stats);
> >  			if (frame) {
> >  				/* XDP_PASS */
> >  				xdpf[n_xdpf++] = frame;
> > @@ -943,7 +952,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
> >  			struct sk_buff *skb = ptr;
> >  
> >  			stats->xdp_bytes += skb->len;
> > -			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
> > +			skb = veth_xdp_rcv_skb(rq, &rxq, skb, bq, stats);
> >  			if (skb) {
> >  				if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))
> >  					netif_receive_skb(skb);
> > @@ -1149,9 +1158,6 @@ static int veth_enable_xdp_range(struct net_device *dev, int start, int end,
> >  						 NULL);
> >  		if (err < 0)
> >  			goto err_reg_mem;
> > -
> > -		/* Save original mem info as it can be overwritten */
> > -		rq->xdp_mem = rq->xdp_rxq.mem;
> >  	}
> >  	return 0;
> >  
> > @@ -1180,7 +1186,6 @@ static void veth_disable_xdp_range(struct net_device *dev, int start, int end,
> >  	for (i = start; i < end; i++) {
> >  		struct veth_rq *rq = &priv->rq[i];
> >  
> > -		rq->xdp_rxq.mem = rq->xdp_mem;
> >  		xdp_rxq_info_unreg(&rq->xdp_rxq);
> >  
> >  		if (delete_napi)
> > diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> > index d6c9dc6..1d89b6f 100644
> > --- a/net/bpf/test_run.c
> > +++ b/net/bpf/test_run.c
> > @@ -1349,6 +1349,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
> >  	struct netdev_rx_queue *rxqueue;
> >  	struct skb_shared_info *sinfo;
> >  	struct xdp_buff xdp = {};
> > +	struct xdp_rxq_info rxq;
> >  	int i, ret = -EINVAL;
> >  	struct xdp_md *ctx;
> >  	void *data;
> > @@ -1417,8 +1418,7 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
> >  	}
> >  
> >  	rxqueue = __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0);
> > -	rxqueue->xdp_rxq.frag_size = PAGE_SIZE;
> > -	xdp_init_buff(&xdp, rxqueue->xdp_rxq.frag_size, &rxqueue->xdp_rxq);
> > +	xdp_init_buff(&xdp, PAGE_SIZE, &rxqueue->xdp_rxq);
> >  	xdp_prepare_buff(&xdp, data, headroom, linear_sz, true);
> >  	sinfo = xdp_get_shared_info_from_buff(&xdp);
> >  
> > @@ -1426,6 +1426,11 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
> >  	if (ret)
> >  		goto free_data;
> >  
> > +	/* generic XDP uses the same rxq and its frags can be smaller */
> > +	rxq = *xdp.rxq;
> > +	rxq.frag_size = PAGE_SIZE;
> > +	xdp.rxq = &rxq;
> > +
> >  	size = linear_sz;
> >  	if (unlikely(kattr->test.data_size_in > size)) {
> >  		void __user *data_in = u64_to_user_ptr(kattr->test.data_in);
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index 6140fd9..fe9f222 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -5684,6 +5684,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> >  	void *orig_data, *orig_data_end, *hard_start;
> >  	struct netdev_rx_queue *rxqueue;
> >  	bool orig_bcast, orig_host;
> > +	struct xdp_rxq_info rxq;
> >  	u32 mac_len, frame_sz;
> >  	__be16 orig_eth_type;
> >  	struct ethhdr *eth;
> > @@ -5707,6 +5708,13 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> >  	if (skb_is_nonlinear(skb)) {
> >  		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
> >  		xdp_buff_set_frags_flag(xdp);
> > +		/*
> > +		 * The frags came from skb_pp_cow_data(). xdp_rxq is shared
> > +		 * with other CPUs and with BPF_PROG_TEST_RUN, so use a copy.
> > +		 */
> > +		rxq = rxqueue->xdp_rxq;
> > +		rxq.mem.type = MEM_TYPE_PAGE_POOL;
> > +		xdp->rxq = &rxq;
> >  	} else {
> >  		xdp_buff_clear_frags_flag(xdp);
> >  	}
> > @@ -5719,6 +5727,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> >  	orig_eth_type = eth->h_proto;
> >  
> >  	act = bpf_prog_run_xdp(xdp_prog, xdp);
> > +	xdp->rxq = &rxqueue->xdp_rxq;
> >  
> >  	/* check if bpf_xdp_adjust_head was used */
> >  	off = xdp->data - orig_data;
> > 
> > pw-bot: cr
> 
> -- 
> Slawomir Stepien
