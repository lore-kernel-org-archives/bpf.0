Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=198.175.65.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794587465;
	b=zS7osMjzJNkjGuA4ORVJ1d3Gxq1hXUCNLrd0s2COABs7Am6hmO7wy7dc5rdHKFcZ2sk/
	 a4cLP1H60wAwp1J5bhsT9vISA71BfixYtUR91McrWnMYCUbIAOQEkgyY747Kzcrv9LsKG
	 ubJjo0kYT/NT3y01Ml9CUJ7SJSMN98m38SsGTkLg2RRDqX1vC5lhj7r0TOWAIXCHEsyyB
	 mQlqyulAPvfyrrtG69cZ9xsavb+RGh3TqURSNIi8FnGgPyp7OhcvoWLJ75zuxFdz/RmTD
	 sVofrybZwbwTy6mvxb2jMgOurplDvYnvNDogYKhgHdjBTWQSsa5VaowzQ1mRJCzHNtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587465;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:Date:From:To:CC:Subject:
	 Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=l1vdfi5V8EOqUm+KBLEIqbF14HB7qM59fZf3VFt7F4k=;
	b=TSBl6L267fA5PouIEzmHdVaSu5+58SKPwWo7ay+0AwHz6e7jLBsGrumRhJwRR7aNJNmG
	 cMfNjQILvvEtGH6cvJoJpm01YgjWoJDYRMBSEYqLEBSJtdrgK17h0HtKxCN/PHuGT4Hhu
	 B7DHV/8iZkEtZ1BxWHwnVh0KZ+MqgUAZBSPTpg12qCsbsYk5ackHnFzSrzgxfv3uyS+yK
	 kC/wpnXXF5eFcG80RoXq39nKahrkob6jYBme1r2Vv+c3EhgpgMnhuv8KfAuFPagwJs87E
	 cwbBPF8NCfRJRdKPry9IBcV1q//+ijupgHb6JqhFrvRdkhN0yafroXsjWBGXw4OjeWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mvXzMSrr;
	dkim=fail reason="signature verification failed" header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=mVxvO7Bi;
	arc=fail smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B231A606A332;
	Fri, 13 Nov 2026 16:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B231A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mvXzMSrr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=mVxvO7Bi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794587465; x=1826123465;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HpJvJNOdqfEV6YVxkGOVvtVG5aSHwUcUxh57+1q24Ak=;
  b=mvXzMSrraeko9hPZqUDczRYz2Q6+n/5zk/JJmk0mj9CO0jI/9oLP4bB8
   2Ac5iQ1IbESsrrIOH8Ps1yLIfTmU8lX/+KfLYxx8ooEB4I++SlYI5xFy5
   9ksuYydrVIhLrZmrorkzeYSh96Fc+mElvtpwc/SZXeYgiJykAxOt0s5jj
   HjpB/fbuWgkxatAFpxeP4Z6KM56MVCpexTgFB7kq6OWBZgZ7PgMk4DP74
   /ELsg9OXRbKJkW/cGMTSbKwT8O3aapo1yOX4HVv0q2yT4w2+Oa8nuuFe7
   RsavzIxGsnHPhxPpIJ4gJfjBOZvf7ZbpUUCCLUukvelc0JztAhNrPUc7X
   Q==;
X-CSE-ConnectionGUID: 7+308PajShWm52/DI9ZUWA==
X-CSE-MsgGUID: 4gSeYLdoQQGlYetmB/z7Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3383404"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3383404"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:31:04 -0800
X-CSE-ConnectionGUID: HXvWAyVsSi6rJhXbHYEcVA==
X-CSE-MsgGUID: 5dUpwJ0QQdq5PtMxdxFY+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="8880919"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 08:31:03 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 08:31:02 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 08:31:02 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.45) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 08:31:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qa0RnA3XR3t8HcTNGOssUytwvQTZJ+M6eUjvBZeiuxwgdZzVTy0mx9CU4TapJWMbICFdT0dMbkpVM7Lyo2D1b/XcRMQG8HWNoJolBCVFUa3czlsK9C4+E3wP/9RerUu2PW5uBDXkWBuckMyPdiunfq/q2frS2xKD4HT4XA9FJI7qbE0hJbW1Z+7eQInyNC/bxt50y9Qt4agWKh4LuV9NGaeCP1T+FtVEf4BXlHPAOXt2ubMEYWGrScRYsce14NS1QZrIZqZl0TpGfhKgTinjFyPDfCpueKEaZy4tJ3F1Esn8hFGXcRAPj4TiGdaVKa+UlyiWkBbZZ99Ev2Vu8IQa8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ey+Zob/OoG4jYWFj08JeDYM3S5QH+Tfjb6YWApyTX7A=;
 b=Z4xDKVhH/GKhH/nc7oDMIoQ3j4fRYTWSU1PhSYVfi5vY/anLZTHL/w9vcRXXHnDMD5ddbmt2X90K6K6X269WGgrlfQtO5XBj4D/Upv/1htbi3eH3Irq6VVkrg30z2OyaRbjCIgsRTBCfq+uareNqRT2rZKikGJJq8a8tkfa04s9L0cQrDdNKFKk+CZA6yw7rD6SmKAb4AnZvT3Vc8uksHic4ePWNcW6O/nhZ/Y7q8fAa8zd9wBvyTZVIOAajnZGE9qrJ6qCuAoBAMXVjmQpc9I4yiCN+chl+JPTg6jz3fihCb81d3Oz/njl4DazKEcYSc2m2n+rtlVxY6HyxIFfzXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ey+Zob/OoG4jYWFj08JeDYM3S5QH+Tfjb6YWApyTX7A=;
 b=mVxvO7BiHfiaQlXv1TxImeF81uXIyDCG8EoG37N1Ax/zw8IQAlFTgDjf+F6gHzltXOD/QRRojcOyimsk6RM1SrnuSwVOFKBUT6hovfWBPfxSM8Ih98bWZcMRgouBZ/cUcYxaMMufU3OyQM5Tpejl6VudWL1L/5F0GlDyTPijWKY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by PH0PR11MB5077.namprd11.prod.outlook.com
 (2603:10b6:510:3b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 16:28:46 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0615.007; Fri, 13 Nov 2026
 16:28:46 +0000
Date: Fri, 13 Nov 2026 17:28:36 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
CC: Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
	<rdunlap@infradead.org>, Alexander Duyck <alexanderduyck@fb.com>,
	<kernel-team@meta.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, Pavel Begunkov
	<asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>, Andrii Nakryiko
	<andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, "Kumar Kartikeya
 Dwivedi" <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	<jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai
	<ihor.solodrai@linux.dev>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<io-uring@vger.kernel.org>, Mina Almasry <almasrymina@google.com>, "Mike
 Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>, Weiming Shi
	<bestswngs@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, David Wei
	<dw@davidwei.uk>, Alexander Lobakin <aleksander.lobakin@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Stuart Clark
	<stuclar@meta.com>
Subject: Re: [PATCH net-next v1 11/11] eth: fbnic: Support AF_XDP page pool
 zero copy
Message-ID: <avc6tIIQ9uDQB4IM@boxer>
References: <20261110102039.1002605-1-bjorn@kernel.org>
 <20261110102039.1002605-12-bjorn@kernel.org>
 <avWk5as19fvZoEJA@boxer>
 <87wlqhq0kb.fsf@all.your.base.are.belong.to.us>
 <87jymhot7q.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jymhot7q.fsf@all.your.base.are.belong.to.us>
X-ClientProxiedBy: DUZPR01CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::11) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|PH0PR11MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc16754-c144-4d9f-ded2-08df41a330a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|4143699003|5023799004|11063799006|56012099006|18002099003|22082099003|261028144727099003|261102123227099003|261026121527099003|261022075727099003|261026140227099003|261021135927099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: fd7iRpv8YFUzDb87VvPQabUtzj1Y6vIlz8M7zppR/p76m3iU5e7tb06O7EaAZ5/clr91ljnKkUxMCddm25Ve2VALnpafLvsFoj8unjIlA07FzaO15LUk+hnXz88NjW/tOySFO6Ww7aLvlPota+wUBK+pau5BO2yJ4+Dpi/SzEOuFNBrORCrHT/UaSxvtbdg4cY9oDLjc3Gq/NnmkSNsR22V2CI9xLWGsN7pqMuIsd3Do1Ij6axyGXhAuhw/Pvxv79D8nOyryhPIqFg5MBnoCBTRcsLiGcBTF8cpRq18rAZn4fzfDnoQPHa0fRTvl56oDwgT/2k0ad9I5hXSonmcd29ebwZCnrVVaEph/NhuDLFLpuSZaz2Zo3QZx2yPmpjQRXNDBeXr80B+2t7wcCxMFERUYJG9UTzKGE7OCW/6vXXuvNYSNe7xCV4pGFVWWQGIxG66FhBlaW7WbZFJK/AeJX8c9DkL1MCItjIU/Okstxo8HFzG53nX9zllwUu6cQ57HILhpqtLsPH8JCz8Ywwccj47lS+QYrmpgB6qeYbGihlqkje3MLm75uRMPsPjX2ju3udjE4IpUX6kJcZRThnIqVMwPOeDZmmV8wedmspC3MhlfSZNjsVAVPiVtk+NM0PfwtXgXjEAxskdvJC0FKy2hPr0nCFEdposln4mfiaCgptk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(4143699003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003)(261028144727099003)(261102123227099003)(261026121527099003)(261022075727099003)(261026140227099003)(261021135927099003)(261022105027099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9yVrFzv9Ccshk1dnmw0XPD42N1KeZsMetiTi/IN1VZXT5A94L3pCuYT9HA?=
 =?iso-8859-1?Q?sNDmScHuojoub/JnYLXI7YXt7fiHwdfCfGRVvLarMdN8G50iwtSldlj45a?=
 =?iso-8859-1?Q?5M+/WTNmRDw3+uCvv8ItKgqo1RGG/DKwyfD8Rr65+V4pL3G6QMYE1BajMu?=
 =?iso-8859-1?Q?gKVYnL1NZ642XR6Rt549lDCNosV6bT2hkYkAyC4Jy73JkczS18FQrA75U8?=
 =?iso-8859-1?Q?RbhONgljC0fkz9Y/GzSSRysTopB5LroGX3zsSVYddY5MejGX2wiaJlaulV?=
 =?iso-8859-1?Q?IixSpWFImbLcjtaQ0r28jllPkLmMh74EFdfPyvtZjRbEVDoP6kzfYzyETh?=
 =?iso-8859-1?Q?bFoMrem3qbE4xnWAb4/VfOeB8DctJ7njvcP57JiOowiJUdf3EAnQk8pdF5?=
 =?iso-8859-1?Q?GDSd4x1XZ4ktsXDDNkgaoKtsk1zYw5IhKwAkDWtTM0Vup7c/OnVHd5Uw9k?=
 =?iso-8859-1?Q?l8hPYyko5WU7s9OvL3Gcomi0qyYdCyf1+DrZnVOlhhC/3gHGr3UnORNfuf?=
 =?iso-8859-1?Q?AxaxVwoYptNlL6cvhqna4dGzzs3oB3K0xiIXuzQJYiEb7KwlszF/W/dTDe?=
 =?iso-8859-1?Q?LftzUEKZfmEWccLNgNmWegC5wCno1sFm9gj7FEysbQgvCYnFw/dUtjnCDp?=
 =?iso-8859-1?Q?Xy4eOw4FoNxg5/XznrBt+cULNwLluGDG54a04yrQnuRrSQntOsaE5mv0WX?=
 =?iso-8859-1?Q?zrsE1q1zm+54dVvTBGPafKFsb4H2x9H+Z5hAkI9TbRcl2Q+3GiJDJdEnpN?=
 =?iso-8859-1?Q?aapWgr/PpJSfz6dme0Gl31FH7l3tk2ZoT3KOl6wAxKiACjAxT8gZc2gwbs?=
 =?iso-8859-1?Q?L6Bh50qIys5nUglbnTe1d+5ZVSHCHqBAcrAIIBcCFmI7BhDRx/OAuFSSeB?=
 =?iso-8859-1?Q?dwBLa1HLv5j2Kx6Yo+EkZR8cUG4j1OMKY52gzAKSlPmXkjfuIFL/pR0/Zy?=
 =?iso-8859-1?Q?gsIb0RvwfS+wnNtSjBk4KiCxNKjSV9Du4Ig3YxSB6GDCLwc7j6FVM2WSCT?=
 =?iso-8859-1?Q?Ca05w1URUZwZZ8VHfNfeqfIhxO+93ZXIxTr4jBJBjNvQh1sAr0tUnjt+Jv?=
 =?iso-8859-1?Q?VDvMJVszflU0vHnNr5V8U1bTLg/ppclIQYDMiWItZONMw+JUKs/guT8tEc?=
 =?iso-8859-1?Q?JGu3gtin+QRQ76SO6CDgPzVXytsAwhbWWKuFuimkAcOYgS3W56STi+nFfQ?=
 =?iso-8859-1?Q?Cwxkf3s/xRSev+AyQBaKbD+ocokZv3zUoIhAmjdK90QTl3hMW0PMk6ZAvu?=
 =?iso-8859-1?Q?ajQk+T/AML7CwnCj0Z5wH5oU6tIBdbiKK7IGVE786dsRMlDe+Airg6ov6M?=
 =?iso-8859-1?Q?ACk6DRFaUZnNXafqM39iB2P6kBPfP8OFMGwVQZlXC8luD3HfiUSoF3J1Kt?=
 =?iso-8859-1?Q?Tk0751Ytgd753odKv9URt2RMeSp30uD2gdjKmM4Aayq8giaWDk1IlW/+87?=
 =?iso-8859-1?Q?Ow5umvPcpZCWHTak6qtjuB/kNbBfLyLKS3PzGHpyc5K4y7cVjWTzlc24Bw?=
 =?iso-8859-1?Q?pmQ98pkDK51Acv7MST0uHT1YJ5Ry6lPDuIRYrPnXMrHtGU+Ctgi3dsOkRf?=
 =?iso-8859-1?Q?9jCP2YSOa94l5LF818e4L7GC9EuXRr0sOdGQFY8QxRd9/ajSkJjxU7i95z?=
 =?iso-8859-1?Q?cLLbliSpYB/EOm0pZn/Olq2Mp71ePatJ8fUY273scNDOoX3Jb0kgbbQ2mH?=
 =?iso-8859-1?Q?WeEMUXGl60R1NE+h7MDmZcFcW5oYd3c4Hf0HXoOQfZ3HUb9qG7+WiCMZFB?=
 =?iso-8859-1?Q?Oq61HEEEMrsmQiC0V07JMdH4Ca0CSt/YhJnf2UIqAndr9hKkcUH93AktTe?=
 =?iso-8859-1?Q?hyzO7gyqmGQ9SMMyhVkM3DpR/1pY/Ww=3D?=
X-Exchange-RoutingPolicyChecked: cYldfRJmsl8AYyhF/AJEwZ9Vyj8L8lAjCrPbCQ7TgpujbaYcwP+/qms657SMk7oTYIqzbvrV+3HOcebAsSExWBsS4AY/Hi2eKusXiZaKEncel4VxiIKts8k6JhKku+askt5VypVpAdBM6oOO8+qZKRT8K0j/RIu6sWwG7A9o1VyAcJy+BdpYfAS6MvXfC6sYXRjK7KjezLjklp7mzkcfqnQzACq5hn8OKPOYbhfoN57TU1kazcoEONo7xwVGOKJ1re4WytS+3jM+PpR3nzlEkdEJHgdyIWe8q0IjFaJJuDXBDH3zSX5ksp9RRaNYL5XulE0P1WY+2SoQklG34zBntg==
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc16754-c144-4d9f-ded2-08df41a330a8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 16:28:46.2638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/3tOb8XGP8mJOegD7kp4zbRL4CsKW+cMBhzxru7NR5/D+6mreQ7M99DVOJqoefJM3jc4PVuodDfyrEBcU4WFNHoqFk38um+NgD5Cr75k7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5077
X-OriginatorOrg: intel.com

On Fri, Nov 13, 2026 at 12:40:09PM +0100, Björn Töpel wrote:
> Björn Töpel <bjorn@kernel.org> writes:
> 
> > Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:
> >
> >> On Tue, Nov 10, 2026 at 11:20:32AM +0100, Björn Töpel wrote:
> >
> >>> @@ -538,6 +547,13 @@ static int fbnic_bpf(struct net_device *netdev, struct netdev_bpf *bpf)
> >>>  {
> >>>  	struct bpf_prog *prog = bpf->prog, *prev_prog;
> >>>  	struct fbnic_net *fbn = netdev_priv(netdev);
> >>> +	const struct xsk_rx_check *check;
> >>> +
> >>> +	if (bpf->command == XDP_VALIDATE_XSK_POOL) {
> >>
> >> do you really need a separate command here? why not rely on existing
> >> XDP_SETUP_XSK_POOL ?
> >>
> >> here it doesn't look like things being validated are something unique that
> >> you could not check during XDP_SETUP_XSK_POOL and XDP_SETUP_PROG.
> >
> > I'd like to keep it. XDP_SETUP_XSK_POOL means "set up driver ZC for this
> > pool": the driver maps the UMEM and restarts its queue, and the core
> > WARNs if it didn't map. A provider driver does neither; it only says yes
> > or no, before the core maps and installs anything. The same question
> > comes up on MTU and program changes of a bound device, with the new MTU
> > or program, which XDP_SETUP_XSK_POOL can't carry. One command keeps that
> > in one place, and v2 runs it from the core MTU path too, so a driver
> > can't forget that case. This is only a burden for the core.
> 
> Thinking more about it, maybe I can drop the callback altogether, by
> doing what devmem, io_uring zcrx and tcp-data-split already do: the core
> refuses a setup that can't work, instead of asking the driver.
> 
> The driver only judges the chunk size and headroom, in
> ndo_validate_qcfg, which the queue API already calls when it installs
> the provider, with a new bit saying the buffers can't be split. A frame
> of up to the chunk size (minus headroom), then lands in one buffer, so
> the core checks the MTU itself, at bind and on MTU changes. And like
> tcp-data-split, a socket bound with XDP_USE_SG needs a frags XDP
> program: attaching a single-buffer program fails while one is bound, and
> the bind fails while one is attached.
> 
> That drops XDP_VALIDATE_XSK_POOL and struct xsk_rx_check, and fbnic's
> MTU and program hooks with them. Not fully cooked in my head, but maybe?
> Wdyt?

Would be nice, what I meant mostly was that a single driver can't do both
'legacy' ZC and new-age provider based xsk at the same time, so let us
have a single vehicle down to drivers, adjusted to both needs?

> 
> 
> Björn
> 
