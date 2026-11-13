Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794571464;
	b=IIDjXsqila+fcMfKyQ0Za3M583NU8pVcWvAUJfTrm26JHWCLahJCk6Hyw4ipOnFwGQ12
	 1fduQfdY9mdIh8EtyYeru7rSOKLGsyI2VhuP4QGA8ULRl/GgfEFyjXa3taWIYvfOinHCg
	 nVSJ8L3FYcHQ1jeh4MTrKsyfg+pTM7ZrPw60470jUq5az99yq5Tq1fB2L04RNb8WmnQXg
	 rtG0YpeahCTPfkrq+p7S5nPytw7MKh+fTGlgvm434v2QJtez1kzoSEdmpIwPKfRRjF1jt
	 Jy74tzQHfwWygne4IyV+p7HvteWG7gZ0A5UZjOQkUAra3dptD/qeNoEq5KocQqZFL+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571464;
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
	bh=9wk0T2Qi9FXwPbL85ieDMdkKJ76//C2dJg6SYzMsx9k=;
	b=dwrkcQH6L4Zb2cTYzmWUUeDchpfEcl3epVpspjj4wruIX/ahR4Bk5JlcM0Edg5oE/QiN
	 XscyFWDdtQCp68s2mZDwvupx9spHzeqelxDmsRfuStZLs7bdKRSUkhnZMiKRlGRkqN8hH
	 3z0E0Ntyy6yzQhxfL4byTTCjVHiDQKdFd/LEo7r5vCExAYrFyeRqh7nuU0VWXWG9Fm4xs
	 HqepJo0+eREg8B7D5Q2G7M1FblXm/XFlsuEBz51S7tPOpKlX6oA/5xbOTWZ4YCdQ/FTmO
	 g7Lr8LfftvfewCPctu7U8rGHP/VPx8WKyIFACqXLVFFPu6YUUWtQLvnOO3RXGuTP81Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N3dbeqlW;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=UW7tUJOp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E4F606A8B5;
	Fri, 13 Nov 2026 12:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7E4F606A8B5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=N3dbeqlW;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=UW7tUJOp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794571464; x=1826107464;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KLczQ7Km/NXyRaSwjLeJUO65mqAGEI7OFgh8uOur2Ok=;
  b=N3dbeqlWwafJ4wO13ApOxLhB1GtDlPCR0eq6obT8nybLxHAemOaTXGAF
   2OI0dQfj6G0SjufQiQ5iRgyx5l40fooGSYy1t0vZD9i0uxNuhrCbUmmHn
   feK37+CDOWSP1JZSjrAo5KvC1knH89iwPyhD13E5Sm7xAvyMlKG0YfFwi
   hwdWMzFgHI/ZRir8pIIFxgwltV7SBJY0UJif2pn1QMnXMrd6E9EeHOyg+
   lafZ75WCCV9Mug8NdloiNx0olXh7hRf0FC8GdE+TfImJYfRvpjtRwvq4W
   Ck7KeTF7ZX3qsLLe9Hw2bAIfXSWrAg/ofr/cR5cNfMsK5ZQOwoEABp6FD
   A==;
X-CSE-ConnectionGUID: VgTp/zToQEyU7/LglOb4sA==
X-CSE-MsgGUID: 7CGB9qmrR4CKY+6hAIsKcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3264060"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3264060"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:04:24 -0800
X-CSE-ConnectionGUID: SkklmmMNRECUd3DptcOLvg==
X-CSE-MsgGUID: 7jI2QcjsQqWUNmBKlYwBnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="10623488"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:04:22 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 04:04:22 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 04:04:22 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.48) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 04:04:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkqlpeORBgFjw3g+z01VET2esv2fY2v7annByqOv+xYwTrvkM05JTaoaHcxWJNrGLTU6rBXdyNNeNT96Sa0mn9Ds0feHiqufnzpumoCIYOAJqRIIRUEtdC3hI2nSWpvjglsDRWsChh4oKrTXNIbceiVzlI+RWDyR48geM9ygZKyup9XX13aECe+6w/1rAHcqwevs23XJO76ltux9muA/Yzy/qCUwl4HWEPGa4yAl6XgfwKEB9mGp+6QOM1B+bgekFabCGlK4rp1gr/13+pom6xh7Nw+Ctay9C19QeDYEgFA7lmLbV+48tkKD9Ndy9bgr1oMOqITG4iikcPlm6jSoIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wk0T2Qi9FXwPbL85ieDMdkKJ76//C2dJg6SYzMsx9k=;
 b=W4MHwRUaARuarlt8oe9QXZohXn4TWtwZ2agWt44QTQIqgRXyo5taNM/UKXfBQn0uK+8VCULOpv/D2RRjThkhGlYMvXHGgh+CQCfsdHjngOtpZ6w7DVXHJDOvy63l+H05iTWf+OT5Cbi/v54Y64IxXaW4U8kGXtpEoFliPQKTQNhmdDtso51kqrc7O+akR1KAJYWab4kvAvgHGmcKTWbjM+UAxQf4LISqHaMokSa1GpY1HMU4gRu/9GyUaEObIPANXD57veQjPucE0NG8AiOgPrIhiHNReXdUzlQwRNP4zRZShUEbDlqveJHTongA5prMQJcW2/3mJ91uJQSFoKLUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wk0T2Qi9FXwPbL85ieDMdkKJ76//C2dJg6SYzMsx9k=;
 b=UW7tUJOpdP8VavUigdH7MikbLkJmXh4C8UX43ei6jOWRlvkwJAcChq8V7wcIRB8i8J6IO5G9lluS9hisHvMzTqbPGdZvnOF8mW+BdGhtuFbnZ71gVOYZFqugTWbV29OUVDFq2SrgpDx2msSLicUy4zitXCLW4McJAt4SqECienc=
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by BL1PR11MB5221.namprd11.prod.outlook.com
 (2603:10b6:208:310::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 12:04:11 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:04:09 +0000
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
Subject: RE: [PATCH bpf-next 04/15] xdp: add a kfunc to delete skb core
 extension entries
Thread-Topic: [PATCH bpf-next 04/15] xdp: add a kfunc to delete skb core
 extension entries
Thread-Index: AQHdcTPFRloa4I39P0O7yUUlFKolDbcr67Lw
Date: Fri, 13 Nov 2026 12:04:09 +0000
Message-ID: <CH3PR11MB566895F0222F46F58DA8D5128EE57F2@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <2892d19e606e3809c268de0610a4ccc8bf68625a.1794281983.git.tianyi@cloudflare.com>
In-Reply-To: <2892d19e606e3809c268de0610a4ccc8bf68625a.1794281983.git.tianyi@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|BL1PR11MB5221:EE_
x-ms-office365-filtering-correlation-id: b3b382c4-d154-4471-a474-08df417e398e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|261028144727099003|261022115727099003|261026121527099003|261102123227099003|261026140227099003|261021135927099003|261022075727099003|261021121427099003|56012099006|38070700021|5023799004|11063799006|4143699003|261022113327099003|261021123027099003|261022105027099003|10067099003|22082099003|261009223027099003|18002099003;
x-microsoft-antispam-message-info: DXEqyDO6PdjPAoY01S35+fKnDteu7Vj6szFHPf4nfXfcMpsUvic3LrwWHyEvMinF3bvqC26/4JfDXrIoF+t30AaMLCx7tc+WMN/ZQMeVOAZh+FBoQVKrhumt/M3ZXw+0zu/KpdGyTh9ZM4jMmCOYVxmZf6SK9L60Ncm09vmEHstEVs7A9YRUM7N7GungzeAYc2vEBXN2k9Jez8zIOMhxKruCI6MR4YbIDTDKXPONHDaSomh8vcAV2zRjBifO59HX91RURrolTUnz/yw/rn4G95Ab7AQkWoh9+yVzwXuGiv9/nCKeAvoPSxPjRoRgQivae/TTyuv95DRrxUK98Gs9MtEXUUuZwKpQ+IsrKo2Dof54ChVZnZ/Rhnv24S0WZu4m+Nhs0eufgBqxW8d2wluC+aERfpchAIvSvkuqnfSbXuI511WVRnxA+srz0yBTZZYn0jyWEDdLREfOyVhXfMjTtq10OeRZz1De9DZGcaBQzqr6sDhDYIK7WVjLEAFO9oCG88At+RRwYkRbB/bhESIukM5Fx8JaEozZQYejuxnERvwR2M0A2saMsz+ysedyBRL41Rh4zhhFIC370aLvdq9tXcmWxwh0vHw7rbFj9hdohHTLl24Ki7pJo06/bOYQJF9NxAqv2+i3jZbRZBs5HDchuMyAT1/ItlwhGADHpkQdQdeUxN4lLMieVcO4TtKdulmOFV/GQmvvfz/HuI99/mJQjlRz5154aK3VdkCoQNZAIOM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(261028144727099003)(261022115727099003)(261026121527099003)(261102123227099003)(261026140227099003)(261021135927099003)(261022075727099003)(261021121427099003)(56012099006)(38070700021)(5023799004)(11063799006)(4143699003)(261022113327099003)(261021123027099003)(261022105027099003)(10067099003)(22082099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VFEieli19j71nYqDbJ3BseJG4NiBOwAvQ/ZFfZXQJ5gG4YIMPVGTvypPhNhk?=
 =?us-ascii?Q?IEikLS2Q5+rWBnhogJ0z12/VeLdqvDqTtVGfXFOa2MIZYF2g+/aMtzKsTnmP?=
 =?us-ascii?Q?04PDlcAUo0braUIoiBETtFx90ICA7jr5x6Esg1hEfGCE2xPxtGsluiSb4Cqf?=
 =?us-ascii?Q?FecTbZCVqZMdSr4bgAXB34/zztpfB0r24FVFG/EfAlFoN6mLqHfAPqxi4cOY?=
 =?us-ascii?Q?B/j6vUNzW0LaiTfVXSDSO4JJ3pAbQinx2GYvJv2Vd9D4Hii9OP1m6eaW4ycr?=
 =?us-ascii?Q?PytrI1pM69HpZumnardnn9+UCHrXhMeIE618nztCkjani/yL9UbtiXJ+iW76?=
 =?us-ascii?Q?WC9ZflEHAIsxWZ5nqsmE6u6PoXJzXoMPWWASOt7Hi7sJQWnPGiYoAn681Xao?=
 =?us-ascii?Q?NOsBpxBkMmca43Wy2En1186501pPlipEAZn21ZWBTcloti/OaF4tSAhUZfP5?=
 =?us-ascii?Q?8ajlc78JtTorlk/dMjl6JF1FvhVJdbKNyWvD61c3CO/7N99VSXFG7IuUSMKP?=
 =?us-ascii?Q?Xy86OIP5+IV8Hb4r5cz2WFSIm6TmOKDE9KS0rYmBYraBS2yl0b64FJBqSidC?=
 =?us-ascii?Q?uZi9MAVsl3pr3pQUtBzEyC/r0GYwQ7k+7lU0i9eFe/reoqoIysHQWgoR8IAF?=
 =?us-ascii?Q?n1xJT8KsoRNVHdsEXIt4u4xKdC+PDzU6ptMIzjanU+P5RzvIf5uJFwHrt/9F?=
 =?us-ascii?Q?hL0sGk9GWLWqJ5tWI9Lr5DJWEPDrYF6QAwTxB152Ow4eaqRBk3lMUtj3WJND?=
 =?us-ascii?Q?NJrbRRR5GGn5wXOIfBJWXKYm6smNT53Q7ixh2RX7pdTSB6/jXiibXy6oN/2z?=
 =?us-ascii?Q?qgRHi7NvlK4HRhqSK+7vDgJoNk3o/eeRkWwgzWQRX0tQP4IySZyvHGVCpEra?=
 =?us-ascii?Q?6FXlkIzWTP8dBtI+p5IEaTT8btoX1u9tgS7Io7WIY0UNMxE/AYNxef5Lgiy3?=
 =?us-ascii?Q?cTMKQ6/+JDdpJjNRFSsuCfJADigPB9y2ymH2cDKqJaZfplkOTb/LHw7GZFDN?=
 =?us-ascii?Q?TMSh9/F9fzdxaFW+/f93ZCG73bFRwAP9KfPMIxNWK2w88LiJviaL4MUZk+cn?=
 =?us-ascii?Q?I2KEiPmzdsLcbhkF1dpp6UUZlrbDc7LmgssocALEkDlHeYZHrpdPIE7OLDzT?=
 =?us-ascii?Q?FW7OUN+nG1C8uTRp4nKYlJMfaFPgX2GOiiNaBGeCK6JEHIBdG5GpNx2725N2?=
 =?us-ascii?Q?n5Z+u66+In9aaviPLdNYTvawLsNgUHmkluNdp9JM8EYC/9y9zKKCtwDtCxfG?=
 =?us-ascii?Q?ra9MBMVqy06GaElFrk87cTKXexHZbEcZXJ/R1xSPg6UdZ7jZs+G8Pdb/0dFZ?=
 =?us-ascii?Q?VhAnDxLilPPvVOeZFejV96KldPNFiKxrVVAqL1b73lDgfNEL1h4LOChVVlzZ?=
 =?us-ascii?Q?rgrPOfJlInWqcj4aX+pY8wTrTZGT401RQUKGEePW4PYOH7rf6HOi7pHVONxV?=
 =?us-ascii?Q?0aJw2EYXCv/4BCM5BReag7TkFCEbDImriM3l4cB1cE+dv8dtFwY4pjx/sauA?=
 =?us-ascii?Q?olUIKKPJVZIqWpW0ZeyzKzqFOp0oSdLzGrHwaJ8rQyD+vRP0cXMKnrv8FRCT?=
 =?us-ascii?Q?4TZiJNQa8Rj6uvZcP7rdASbLcm4Su4CF+EMfzWRcyMdeByJ739e2SEdeNqN4?=
 =?us-ascii?Q?1u8LBmhE8wYg7DK+xnE5cXZRr0gR38oc73q5BTibA8Z/XmZSulMLGSrT7u1+?=
 =?us-ascii?Q?AwCSO//+fOPTMYTbuP4VQOa4YeY/RjQCjuScUs/dLJyjSfZcUoLqrJVFLgmk?=
 =?us-ascii?Q?oGxaOJMQ+vdiaFqKIjdbQtt3QC6d6Zw=3D?=
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
X-Exchange-RoutingPolicyChecked: UbmUTyGNB8vJhRGAGHqY1ba5U4qPUF6RT/+VCujvzgeCfF0mhCXjLSJrvoXAsHUIAWQpPS+0nkWqAJ38TZbo+ixQ+PJTGpd+/y5vGwadJ7LdWwTT8kEWsbse4vPYEUkb4pJ4PxdP4KxDs5vwFqYKr6DKcJ0W6d+0a/aUVWGseQxpKIB1MhGqxFe04LcxlLjidFbE8CCUl6xSMOMHCFy/liWXhxRNUPlf12+sR5u/24tjmifM3w6LgjO14fnu3j7J4Uj5MBEyxTVQ6pzXdd1dv2EUMZxWpGXu6z0Rogjmxkx18gXQq2ks3+ywnlgjf/5HCjvE7T8lFnjANVjjmR5OiA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b382c4-d154-4471-a474-08df417e398e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 12:04:09.6615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +EiOiVL0Wq1tOw98/A2U9YzZQ2DXV2DNpQzdKt9SOWDBPMSKOY5zvAW0m7JBba0M9YaHmfT0DdO+vzSANuhqupZUlC6hn5M5oBxacJhnWQ0=
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
> Subject: [PATCH bpf-next 04/15] xdp: add a kfunc to delete skb core
> extension entries
>=20
> bpf_xdp_skb_ext_del() deletes the stored entry for an id. A program on
> cpumap or veth can use it to drop RX metadata that an earlier program
> stored.
>=20
> Without the XDP_FLAGS_HAS_SKB_EXT flag, the kfunc does nothing, because
> the header bytes may then belong to the packet.
>=20
> The kfunc only clears XDP_SKB_EXT_ENTRY_ACTIVE, so a later store of the
> same id reuses its offset. The flag and the size of the area stay the
> same, also after the last delete. To give the bytes back, the kfunc
> would have to move the entries after the deleted one. The cost is
> headroom that bpf_xdp_adjust_head() and bpf_xdp_adjust_meta() cannot
> use.
>=20
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
> ---
> __skb_ext_del() frees struct skb_ext after the last delete, because it
> comes from a slab cache. The skb core extension area uses existing
> headroom, so it is not freed.
> ---
>  include/net/xdp.h |  8 ++++++++
>  net/core/xdp.c    | 26 ++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>=20
> diff --git a/include/net/xdp.h b/include/net/xdp.h index
> c888353425d4..23c976e92898 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -486,6 +486,14 @@ static __always_inline struct xdp_skb_ext
> *xdp_skb_ext(struct xdp_frame *frame)
>  	return (void *)(frame + 1);
>  }
>=20
> +static __always_inline struct xdp_skb_ext * xdp_buff_skb_ext(const
> +struct xdp_buff *xdp) {
> +	if (!xdp_buff_has_skb_ext(xdp))
> +		return NULL;
> +	return xdp_skb_ext(xdp->data_hard_start);
> +}
> +
>  static __always_inline void *xdp_skb_ext_end(const struct xdp_buff
> *xdp)  {
>  	struct xdp_skb_ext *ext =3D xdp_skb_ext(xdp->data_hard_start);
> diff --git a/net/core/xdp.c b/net/core/xdp.c index
> 97dc0e403a78..2c1d5ec3311b 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -991,6 +991,7 @@ bool bpf_dev_bound_kfunc_id(u32 btf_id)  }
>=20
>  #define XDP_SKB_EXT_CHUNKSIZEOF(x) DIV_ROUND_UP(sizeof(x),
> XDP_SKB_EXT_ALIGN)
> +/* A deleted entry keeps its offset, without this bit */
>  #define XDP_SKB_EXT_ENTRY_ACTIVE BIT(7)
>=20
>  struct xdp_skb_ext_hash {
> @@ -1119,11 +1120,36 @@ __bpf_kfunc int
> bpf_xdp_skb_ext_store_rx_vlan(struct xdp_md *ctx,
>  	return 0;
>  }
>=20
> +/**
> + * bpf_xdp_skb_ext_del - Delete a stored entry of this packet.
> + * @ctx: XDP context pointer.
> + * @id: Entry id, see &enum xdp_skb_ext_id.
> + *
> + * Return:
> + * * Returns 0 on success, also when the entry is not stored.
> + * * ``-EINVAL`` : @id is not a valid entry id  */ __bpf_kfunc int
> +bpf_xdp_skb_ext_del(struct xdp_md *ctx, enum xdp_skb_ext_id id) {
> +	struct xdp_buff *xdp =3D (struct xdp_buff *)ctx;
> +	struct xdp_skb_ext *ext;
> +
> +	if ((u32)id >=3D XDP_SKB_EXT_NUM)
> +		return -EINVAL;
> +
> +	ext =3D xdp_buff_skb_ext(xdp);
> +	if (ext)
> +		ext->offset[id] &=3D ~XDP_SKB_EXT_ENTRY_ACTIVE;
> +
> +	return 0;
> +}
> +
>  __bpf_kfunc_end_defs();
>=20
>  BTF_KFUNCS_START(xdp_skb_ext_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_xdp_skb_ext_store_rx_hash)  BTF_ID_FLAGS(func,
> bpf_xdp_skb_ext_store_rx_vlan)
> +BTF_ID_FLAGS(func, bpf_xdp_skb_ext_del)
>  BTF_KFUNCS_END(xdp_skb_ext_kfunc_ids)
>=20
>  static const struct btf_kfunc_id_set xdp_skb_ext_kfunc_set =3D {
> --
> 2.56.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
