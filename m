Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794571380;
	b=RuHWqF7MjcEZFbsi8qFbft9ognwC1XLzH5b4Vv3NHOv6Cu1zmHaN0ZlRnRwTpyE6WsQR
	 j1b825xjYALt1MOzEMmClT3SG/Cg6vZtFfnHDoVDCU0aD2PUrdk4EegVrU1CirWhzFN8P
	 hBIYvDVMpcJOm5IxoLeIm/KHy5eZMSuisim6aloehJ8ZMKhXGO5Ka9dMKLAkxALdeQQBF
	 XPqOw6RfEPOqa2yVnBUSQ8v3AVO061ltid0RjxS3ujEsNwsfTCVVvRnvvIf8Zl7uQnRpF
	 HKq0N4sf7n8civl/WDKp0WR3RFLAynyJLgOqUuNH5bp+c8/3NAJy2rObObvrQ+9l0iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571380;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=o4fZ6NiE58Go47E7elTL2xBVuuAZC1n3IVg4+61jD4M=;
	b=0F/KAhQQDwh2IS8cccIHyoz16kL/sruexYx7X7KjmXvAscG7TO8/xidymi6rEDgkEiiB
	 FoPqfGmkB/jNUccffCIIm1yUddDxdCT+8mJTkbKrzatxHRpDY/FAQxDWbYDsGIizgA/lo
	 Fof10Ahfx4rjy3o1V5m+B7EldL00qhtx8SS8qNDdY/rVeSQ/KmqqWGE7ogu4T6AVeMM6g
	 YdOw863TpPOtt8iy2kHqj7HKty5ZWRfozyixEhzRWV8J66HfuPGuEoxHr0qcwKl2OnPSk
	 LpTuXOYI2wrpCmi5eO9HiCGjlxcv2w1G+0W8H/qsD9Mhz4ItrOkMPb/ZgXUWpuMpGjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n1JTG6hg;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=WXSA12Oi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE6F606A336;
	Fri, 13 Nov 2026 12:02:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE6F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=n1JTG6hg;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=WXSA12Oi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794571380; x=1826107380;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3BVgHsM8mMRKCWNsanrPpMKINm9vGwp1Z4QIQ1r0fjY=;
  b=n1JTG6hg56cpjyBSijIgEXljrHvWVBdLU1HiJrKeNgs8yzatrzF6lXe2
   2658cSGJUmqRTUjqvLVTNgANyoRjhyhmgCglzPUmJ4oqd+JePGgU0UcLl
   KDvSV9ht8TcgVZJzSH74kIuhTEkjCq2YRc+FXUEsICDzoIpLBjey8bgFS
   CEoK6whzakj01BCSQCzXPelgxkVSf3dvVWc1fnT//O+PkTnIK5emntAQh
   4Q1Ho+HqVT6WZoTkHkuhKYle3TzDm6rtp18NdiQ1zsiRwjA63KEvlsUwE
   9iURN+1dhvfsSWkW5H9CebcFOC7VX8wfzgEaGoxmsHpS2zWM8V/hJw8Nu
   Q==;
X-CSE-ConnectionGUID: yAtemSlrTkyBWnvR3/fpEw==
X-CSE-MsgGUID: ntdX/dTXSd6rtBd3u7mn7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3260801"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3260801"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:02:59 -0800
X-CSE-ConnectionGUID: u6+wZ0wdSoeL8eQ5brPQ7w==
X-CSE-MsgGUID: Gl+GRKGtRXeQXmWYBH1twg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="8796726"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:02:59 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 04:02:58 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 04:02:58 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.33) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 04:02:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GwcUkb9cu3R1Qr+p+ruMZkjAOU3L/M/Q87lXAH+okMwzsG1A3dFBVz+4SpiCPVoZ7QQA7a0CnLbMwuBIcVFXdKejkbno/dwUB38IAHneHkFAktmL5vGFXjsBwTH5ArrnArzs+e18Z37Csa6B6u/8rw5/wVShkShSPi5+NolmkOJvQr2vKpEuk4UQQn45nCUlVn73aby2X2q5xZTrxmssb8rL06teV2bldjrF85lUPMG1xAyodorQEqA0tigXiTKsfUba2VjfDXWDEm3IC/VoOhIZRRlvAzD+UR+CfutTKtGZ77tmFSPvDigbB78gO9RGkTgjGuG0+1EHsqjw7AQmyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4fZ6NiE58Go47E7elTL2xBVuuAZC1n3IVg4+61jD4M=;
 b=oQOxj/yBNXxK2THlb8n8+GZvv5i/BaA6i8+21K+EBEC7j3ktVufeHh9lxAmGAAHKrFmYoQG11S14JcLJIxt5xoUDQ6aEypZcVC/aa+K5ReitQRpp4LE6SvJTlxSoMNBMjnnUBpqrU/rePwOP+HMFdzPrbQ0Vm1ikaaUecMUhwQq3aQwLny367l63K3aeFTTI8cv+h7BEoiSjlnt9DBeuS9VdI6IjY5UVqUrVzkkudDlmG4kvKwmCdvXamJK6yiw+ys/FPufTgs70rdVnYTbwKuVYqr/HQeCYrXIxN5uy+5snSOz9JOWjZXqWT+JAaotAZGGIH+GidO1ZHZfBytUsjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o4fZ6NiE58Go47E7elTL2xBVuuAZC1n3IVg4+61jD4M=;
 b=WXSA12Oixu2ta12ZxS4/HEh1lHdxc4IaRz0rhOEexIGTGL1HSE0bh7Fy6TycPeooF7QN3B4JWvNU2yFD/N9wV5yqoqWYHk+QLcjn4NTMn1KVkNrbzfPI+nYMNKP+h1147APeR4vQHkFeLsB82IDLGz4wTPnMsawCmxTHU+okEKQ=
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by BL1PR11MB5221.namprd11.prod.outlook.com
 (2603:10b6:208:310::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 12:02:47 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:02:47 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Tianyi Gao <tianyi@cloudflare.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
CC: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, Vladimir Vdovin
	<deliran@verdict.gg>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter
	<donald.hunter@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "Vyavahare, Tushar"
	<tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, "Jonathan Corbet" <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, "Chris J Arges"
	<carges@cloudflare.com>, Jakub Sitnicki <jakub@cloudflare.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, "kernel-team@cloudflare.com"
	<kernel-team@cloudflare.com>
Subject: RE: [PATCH bpf-next 02/15] net: dpaa, dpaa2: clear the skb core
 extension flag
Thread-Topic: [PATCH bpf-next 02/15] net: dpaa, dpaa2: clear the skb core
 extension flag
Thread-Index: AQHdcTO+77YJv7IvfEGuCfkav4RF7rcr60Iw
Date: Fri, 13 Nov 2026 12:02:47 +0000
Message-ID: <CH3PR11MB566895F1CFCD1EC995B08E6E51E57F2@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <bff7f72c7c28f67497e23a6629b9e4db74332da6.1794281983.git.tianyi@cloudflare.com>
In-Reply-To: <bff7f72c7c28f67497e23a6629b9e4db74332da6.1794281983.git.tianyi@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|BL1PR11MB5221:EE_
x-ms-office365-filtering-correlation-id: 10ebc469-c347-4e7a-1603-08df417e08b0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|261028144727099003|261022115727099003|261026121527099003|261102123227099003|261026140227099003|261021135927099003|261022075727099003|261021121427099003|56012099006|38070700021|11063799006|4143699003|261022113327099003|261022105027099003|10067099003|22082099003|261009223027099003|18002099003;
x-microsoft-antispam-message-info: /S7paou6+w9cioE2JxMu/wFgTmyYdXEnGlzq/SUt9uvjCTji7WVSy2oZ1zqp/NDqmfn47jCpkP1d5VB/i+YwHjt3zUgWCA/pGzD4U9mHfsJ7V8BvCNf/s91STauvM3Zo/3YCwbOKSYA8ZQwwexG4SWd0+VQDPuWgyT9OX0KCJNccmYbXSzuSfHskCdIt4b7sSZZCsAdH9OXmNtm2R2ajFxAdfT6FH6CaVXezRF3j/3eA1wnEaXOdcnY0eVRBAiN84W4Qn5R73PLPq5T8YLKBgSTCo9OjN1zu7qS+mRvjoS/w99dkojNFNf9ADw6UvRBri6qyn1Fpsouh90fw5lj5oxLatkodt7OuFQBtnpRFvvBhVQkzjxf2rdgBLrB+dymMq5fk3tSdBsHWEz9J3thfg2jXMfhAuiweqtiyPYWmN+6T0cb3wWZlvOqVA/qwE6uqAqQH6B+1wclKCW/Mtcg87nGO5z0zrLXfo8zsClrmkYFgtVsxc/U52mFuxZFvJdXLCSGIACQDzaoil7sdjz8HSvujJ09YaCShu+Z6hxvvRHo/65BDBQSLq0e6EQJ4aOIAOG9sDJmltyVe2ns8x7cD0yyB/ebxthTXRVpUI1r0b1CrhWDPYauLTeDZ9pf5oJBpAtwRu4vfy4aTpcsHxGtevMj43XGK9QQs6iIdLdK2LUr6ifz8GJUpvIlORM4fiyXNazhSMiLqlFziCdVvekwhfaXs/alLZwtYcgAh3UWXj9s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(261028144727099003)(261022115727099003)(261026121527099003)(261102123227099003)(261026140227099003)(261021135927099003)(261022075727099003)(261021121427099003)(56012099006)(38070700021)(11063799006)(4143699003)(261022113327099003)(261022105027099003)(10067099003)(22082099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4c92mINoUhB5d4XxQAcX1vl6O793sgcfSIgHTft3ao/c6bmsIcJGDbVAlvnT?=
 =?us-ascii?Q?HRwXchvqu7bkukXPJ9k9jkBB97Ln15OsTWh9yaIfKDriURXCRFDKKqX9zHBX?=
 =?us-ascii?Q?zMOa6b3Jxy7TSKOhdL2sYryvD/2rNLOxDs7bYaoZrBbgpZp+ti/J3n2yVWP1?=
 =?us-ascii?Q?waN7pXsk+gOcRKG0nnnT5wYk/vQvFq1jnXssbUzwI6l2Tyk34tLidml8yWKv?=
 =?us-ascii?Q?L/1kIDeah46zEJ4HX4pA/2Wg4qudM5dc+S5z4DF1nJx4b44FiTBrlGKs9T//?=
 =?us-ascii?Q?QPNUVMFhKg0BeMUP8LgHc9OI2i6FIdCg0K9p07cURMp+bQgaXNfqba/csYBq?=
 =?us-ascii?Q?uOVBaoEqFctvsHF6hscEXVw+kzoFtmjUt0jcj62BTw+3RU30Ffe+95iU+UCQ?=
 =?us-ascii?Q?gQqey5D2RPANXhjLCkEGb0IFIRHBjYrp+bii3o3cPizdD54L49XgTWHlO966?=
 =?us-ascii?Q?ldJdcgoQIZZ+kFSRv56U9NeUNupeHtKb5Ud2qm0kY0Jmp4cGD1ZGMY2kk0Io?=
 =?us-ascii?Q?GkSxvO9Q0l5eJpuvskTt6ZoyxFEOO1qIadTwbeHf1yAM5qyxD3+wWivotkZM?=
 =?us-ascii?Q?5rpWhiPIn508gqNXN+vrGuCuiGblcKivYNAZFEQP0ROeuz2dpqLqNQuVAuiT?=
 =?us-ascii?Q?3jnFGHdT/2JZjkbt7jvAztdwXevq7qQD8HYc8fdulm9ezzw+I/iIvqLOreTt?=
 =?us-ascii?Q?5Fv3kucOu+ErlsSxkD/OJsD2SUKd23alJAeKyVev3AakN8kawYNy+G3itF8O?=
 =?us-ascii?Q?5LVSehtJttMsGosI4RUnnQybXTjRWpgYB6GTGRla3m2h9rbnxYOAz3UTFzeg?=
 =?us-ascii?Q?r0fuNJqJHISw9qCblxxj1RQPKpEAsJNLeDu37iyCQaNl+M5gQo0Njg1RT2xI?=
 =?us-ascii?Q?5LwmNXpW3XoHfNDrP080mUiFURtk6QpQ+IoSan4P8UEHwa+A9W/dDAeGZfUR?=
 =?us-ascii?Q?cgGIA+ZHB2b/0zapRYWDrHXPSdV680ehKEqQOWqK5GXYGqhxO+mJc5N3fXpH?=
 =?us-ascii?Q?m6a9gt7e9uTKN4R3gvlrGJPAsc1D/6iOLT0khVjapwzxB37CAuuf1+71MpB+?=
 =?us-ascii?Q?+5WFThVMbZGBixzcpeDac1u8KXIQH9rP+RKa1DzBt5sT5EjCjVFfatGw3zEx?=
 =?us-ascii?Q?Ht4mbDzvXkON/linJo6l5GqykopAiU5tSfrmpdWKKlyeBwGfGEoNvjs0Bl3M?=
 =?us-ascii?Q?XeDx4UaM/QvP3U/GNlBw14CXIvggqRFRn+N9/ZSH68msAdtpSFUO+ZJktb4f?=
 =?us-ascii?Q?Pbmx1NgfyMXnFI4xLNMdCtWfiwnHiUNZz+22BHSXwtACwuW2LZsjr8iXubpE?=
 =?us-ascii?Q?DpPLkq2zcUp39NLuTgwGqK3Uy7UkXXYO5zSU5ZvUnNNz78zjkbdppqL0uLCy?=
 =?us-ascii?Q?fJ9QiKDYRoAeFR+cadnV2Pj1AGCKG6xiqx7R4NaKfhyRtVVHlxZDKUH7/yd+?=
 =?us-ascii?Q?v3k/flP6ax6cI95H2dNSDBXXrpZXuxGIKHRymAqH6i19fLmL3ymQsrefz2jZ?=
 =?us-ascii?Q?Rzb+8EAl0n1dRwJQm+5Qopw+71lA2el6+i3t9GiIjf0dllENTWw4h72SrS8u?=
 =?us-ascii?Q?Gy8xljeDrQZUELKUHDVnPjl59J6/WYyvMkIretqKiu7IBogO0/bDDO+7pHjn?=
 =?us-ascii?Q?j4AYw75oN606nEofEbzUB9uD82GNVmbJ9wBduOPVw5Gej36xWLz3IsbnKnT2?=
 =?us-ascii?Q?F8XjF908h/G+Xe6QUQxDtnbj8FF8EWWNxsLGP/aXE0Wi4T/xxx82AtkOd0W+?=
 =?us-ascii?Q?Ad2qY77D0+v/NkQ8liwo7a2NKUC1alM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4cARNF/zIeUIHz3hmjyDtAZIpS72JrcmAr4OTBB47AaXf+WMgECbodpmw6H1twaXmP0vJAIUzZlNkT2yQlQS7VcDFN9UIFX51BBK78mdMpd8hZuEiKbrPiYY9a3d1g437GmYOjC03o3zVWGwvVXbwBel9ynhFoCPjcfDd81NUWwL6Md1cVmoTNLtzghatddWhOVLaw/nczLlz8GiFBABwkN14qYBfo6y7shgttJJkd326mDCXnO+GCDhp1pkcXfrAOONAD65L5GBjyzHNHbnCbgKFluJWsswguEjmIB4d3I7dO+/0VmSkitSvRLrlDVWv9xC2SerLjzoqw/PorVrZw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ebc469-c347-4e7a-1603-08df417e08b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 12:02:47.6983
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRCU93zqFBWUYLE5olPaxhDf2RDAvrnN3Bdtrae9x+w3k85Rd1uUUpoebTDzj7FE3Xi7DJGKxy47tNSYsPn6Dfx7SAMc+LOTzRlk0390o30=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5221
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Tianyi Gao <tianyi@cloudflare.com>
> Sent: Tuesday, November 10, 2026 4:57 AM
> To: bpf@vger.kernel.org; netdev@vger.kernel.org; Alexei Starovoitov
> <ast@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Andrii
> Nakryiko <andrii@kernel.org>; Martin KaFai Lau <martin.lau@linux.dev>;
> Jakub Kicinski <kuba@kernel.org>; Jesper Dangaard Brouer
> <hawk@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>; Stanislav Fomichev
> <sdf@fomichev.me>; Lorenzo Bianconi <lorenzo@kernel.org>; Vladimir
> Vdovin <deliran@verdict.gg>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon
> Horman <horms@kernel.org>; Andrew Lunn <andrew+netdev@lunn.ch>; Donald
> Hunter <donald.hunter@gmail.com>; Eduard Zingerman <eddyz87@gmail.com>;
> Kumar Kartikeya Dwivedi <memxor@gmail.com>; Song Liu <song@kernel.org>;
> Yonghong Song <yonghong.song@linux.dev>; Jiri Olsa <jolsa@kernel.org>;
> Emil Tsalapatis <emil@etsalapatis.com>; Ihor Solodrai
> <ihor.solodrai@linux.dev>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Karlsson, Magnus
> <magnus.karlsson@intel.com>; Vyavahare, Tushar
> <tushar.vyavahare@intel.com>; Jason Xing <kerneljasonxing@gmail.com>;
> Nikolay Aleksandrov <razor@blackwall.org>; Madalin Bucur
> <madalin.bucur@nxp.com>; Ioana Ciornei <ioana.ciornei@nxp.com>; Jonathan
> Corbet <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.org>; Shuah
> Khan <shuah@kernel.org>; Randy Dunlap <rdunlap@infradead.org>; Nathan
> Chancellor <nathan@kernel.org>; Nick Desaulniers
> <ndesaulniers@google.com>; Bill Wendling <morbo@google.com>; Justin
> Stitt <justinstitt@google.com>; Chris J Arges <carges@cloudflare.com>;
> Jakub Sitnicki <jakub@cloudflare.com>; linux-doc@vger.kernel.org; linux-
> kselftest@vger.kernel.org; intel-wired-lan@lists.osuosl.org;
> llvm@lists.linux.dev; kernel-team@cloudflare.com; Tianyi Gao
> <tianyi@cloudflare.com>
> Subject: [PATCH bpf-next 02/15] net: dpaa, dpaa2: clear the skb core
> extension flag
>=20
> dpaa_run_xdp() and dpaa2_eth_run_xdp() move data_hard_start to the start
> of the buffer after the XDP program runs and before XDP_REDIRECT.
> xdp_skb_ext() then returns a different address from the one used while
> storing the entries. These drivers have not implemented the XDP RX
> metadata kfuncs. Hence they now clear the XDP_FLAGS_HAS_SKB_EXT flag
> before XDP_REDIRECT, and their redirected frames carry no stored
> entries.
>=20
> With the A050385 erratum workaround, dpaa already moves data_hard_start
> before the XDP program runs, so the entries remain valid. The flag is
> cleared on that path too, to keep the change simple. This can change
> when dpaa implements the XDP RX metadata kfuncs.
>=20
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
> ---
>  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c   | 2 ++
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 2 ++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> index ad2d8256eb8d..4cafc0b84dc9 100644
> --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> @@ -2654,6 +2654,8 @@ static u32 dpaa_run_xdp(struct dpaa_priv *priv,
> struct qm_fd *fd, void *vaddr,
>  		/* Allow redirect to use the full headroom */
>  		xdp.data_hard_start =3D vaddr;
>  		xdp.frame_sz =3D DPAA_BP_RAW_SIZE;
> +		/* data_hard_start moves, so the stored entries are lost
> */
> +		xdp_buff_clear_skb_ext_flag(&xdp);
>=20
>  		err =3D xdp_do_redirect(priv->net_dev, &xdp, xdp_prog);
>  		if (err) {
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> index 7227a35dfaf2..fcefdc9daf2b 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> @@ -472,6 +472,8 @@ static u32 dpaa2_eth_run_xdp(struct dpaa2_eth_priv
> *priv,
>  		/* Allow redirect use of full headroom */
>  		xdp.data_hard_start =3D vaddr;
>  		xdp.frame_sz =3D DPAA2_ETH_RX_BUF_RAW_SIZE;
> +		/* data_hard_start moves, so the stored entries are lost
> */
> +		xdp_buff_clear_skb_ext_flag(&xdp);
>=20
>  		err =3D xdp_do_redirect(priv->net_dev, &xdp, xdp_prog);
>  		if (unlikely(err)) {
> --
> 2.56.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
