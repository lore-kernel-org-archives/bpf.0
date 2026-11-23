Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795458877;
	b=mJRRBapWcDlM/c/r34IP/d3KjGQB9kGym3oNblxZIItuUmPZiJlBZRnDRob0huDqY0oc
	 1LjF7gM/EvjfHVVxliyWQdLcFzt2UN0OVQ92OvcYZx4lGFybEBm4ryl44Jn9zOu2cDwtY
	 Z+tVdpzMZzVKaKir0rFKnkYdB0Avx+p24W4fIHRgC60Gknxj5siu+A7ujphTpEPZGgy5i
	 ldJ9p4Zq3yBS543Upm9b4cQl7mNgwB2HJHwZRB/CuG6iRLmwyRJGwiPtCGgjt4QUzcH9b
	 sREE7a/iinYCH4iHN7GhY/DQQSqYI/Y7wZUB65E3Yb2vqqDXfGB2cRT2X3m3hy/HGdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458877;
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
	bh=Ymz/Zi8/7Bgcftdw5ey3AOr/wb4O0xhgZiM8gT3e844=;
	b=YUVRdIlh8nNrVC7xEjepNq+aw7uNjy7rDuxeG86+Hmwya3MgFXYoBc/PO0TSkjXbAql2
	 uRCjqm12/gUNZORBpwA8wdyxXjJaa3ltkUOZvma/Zd1hxJoMD261wfmhrT+pq9ig6HLTu
	 lEKAwo+0q38xLkyW2lgmaUFNZD8vYEkg8K4OnqRv7yel+k2FG56albAtOh51YCG9jn1OZ
	 RsPtJF0BkoT+eXPgO2CQ343pmCQApuI4t83bHMb3NDTMsG+/oLEGnXrVG2pi/JeeBM+vo
	 dwfbE7Ci0MtVNcYCCgv3VF+/LR6KS1ifv0sW/r7uyEWh2/zIJ3SVmNV34or087oHE7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QmGOXi5o;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ioUFijMs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.13
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0A0606A31A;
	Mon, 23 Nov 2026 18:34:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD0A0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QmGOXi5o;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ioUFijMs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795458876; x=1826994876;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HM3Ap8e7ocK4MKXCnxBe1tdcneJJZxNeQfxB4S92NB0=;
  b=QmGOXi5oC38eJyHhmH/JBq3a+18Dc4LsUcn75L3H9OP7UckZstJpka6Y
   CGQQH287R1rmzEqror5q0+GzEk6h7s8o2ZtOTMpLEh1CmGG9qZBgYMPWn
   tFeUk4TTuN2167K0SEBJwi7Oozy9aSs1magNyvs5dlJN7kCta32Zs2ZHH
   Z3Kf54h5HO4yF6VPBvvZuFYHn97nV+qQGLN6GCEuRYp3eeZL2SfhYgX/K
   OF7dus36jDjq+5e5OWwH+89aL8ASE9/wGbhBh/XTDrGPEmQ0R6eQwjGAr
   djYB5aXE9rWUD+C3dnYM8yaNXSyhClQktxusO+S0GDCqOUhd0z6aGN8lE
   w==;
X-CSE-ConnectionGUID: fumXMWuhTZSHoFJzjsKGzg==
X-CSE-MsgGUID: QeWFUBOaRoy/SWe8Dwl9Uw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4175466"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4175466"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:29:59 -0800
X-CSE-ConnectionGUID: ZP9waf26Tqau1QppGNZ7/A==
X-CSE-MsgGUID: dMDXAPmEQtaEoE8zNAKIYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11381150"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 10:29:25 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 10:29:24 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 10:29:24 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.44) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 10:29:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S2zXx0gmhdrwg4jAGbjO5NI9bgTa4ktTi5zaSn5Wth7c0VzO5RHFgSHWt7kmLgr/Q3cMd5gtXyXWiw3MndTt3hBJY6ixAM1NbbclTODJOQ54shHqnJPPd0AijywHAe3Z6loiYyIRzovszgWchRtzBezG8yyfKwkOdnRsmesQmZ1L+oQ/JRgxDp2kZt2zDIE8sTtNslaE9de+Dmqi0hw4u32PsNXTfAhiQWVcQSYAbHLfsN4ryLCvqOYjva3DaIjAKCZfB4YfPjidSGT3H3DBnNV2ACToCdh4dYCDGoc7k7yDKpxKEtX1rBbhAO+mqnrvbaGpSnvFG8y2p3uJNXe/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ymz/Zi8/7Bgcftdw5ey3AOr/wb4O0xhgZiM8gT3e844=;
 b=kgUMrIEgWvHGChBcw6CLJr7sPfxVOP3asMDE3T1m6IG5E3pjnG9t1DVreYNrHRPrBxUZhoZ9wB9bVTWS1n2BnFb+9+0vStChDV39kHzVolwRR78G1DXH+XcSHZHYj73nyHu7bdUGvRxfUw4ko2Ad1OjHUWj0H+mbu8bTwSMkMV9TdgY58iIzx73D14eO8wuUDA1oFKyf6Jcr7FfvMFkyeqCm2nYwdhOpAjpwmuthQi/RghMdWEOzpaNqd/cc+KVPVQUT9fuuD2++fjhDy4bi0AfjuFsUSImCoMX+sOwIx6Heu/egEPsjEgfshZN1MtA60nij5217VhHs4Cf48xe9rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ymz/Zi8/7Bgcftdw5ey3AOr/wb4O0xhgZiM8gT3e844=;
 b=ioUFijMsv2YviUnhLU8YXD1EtSnmCz8IEn0xPKH5QnWo3jXs9XgqA3c6SRBXAPWbCHXKb2rzTXBU4sJUSO7x9mterT/QUCRDsZ41riZ7TdO5+MLqQbDc70MJpi8SmFGJ0Opq6qzUz5W9/5M+DsGhcZsadEQpaaafDFZieF1PM70=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 (2603:10b6:408:422::13) by SA1PR11MB7063.namprd11.prod.outlook.com
 (2603:10b6:806:2b5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 18:29:21 +0000
Received: from LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de]) by LV2PR11MB868673.namprd11.prod.outlook.com
 ([fe80::5bfd:6afe:a9db:b7de%4]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 18:29:21 +0000
Date: Mon, 23 Nov 2026 19:29:08 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tianyi Gao <tianyi@cloudflare.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Paul
 Greenwalt <paul.greenwalt@intel.com>, Alice Michael
	<alice.michael@intel.com>, "Eric Joyner" <eric.joyner@intel.com>, Jesse
 Brandeburg <jbrandeb@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>,
	<bpf@vger.kernel.org>, <kernel-team@cloudflare.com>, <tianyi.gao@linux.dev>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP
 program is attached
Message-ID: <awSF9MseWZF7GXoT@boxer>
References: <20261121012402.84848-1-tianyi@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121012402.84848-1-tianyi@cloudflare.com>
X-ClientProxiedBy: DU2P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::34) To LV2PR11MB868673.namprd11.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: LV2PR11MB868673:EE_|SA1PR11MB7063:EE_
X-MS-Office365-Filtering-Correlation-Id: a284f129-51aa-4443-c8b0-08df498fb143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10067099003|261009223027099003|261026121527099003|11063799006|260925022911599003|260925021311599003|56012099006|260925021911599003|261021121427099003|261021135927099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: DvnxPetNDocrZO6AssCao2kM0flRGThQ3VCKN+WaZAbffRMSlYPNQpoIo45vn2pTYFOGAov3qNZRO8yVWg1AULeiJJh612DS/QUNOgIat0QWpaXLbx409UB5s7/0kSiDzULBNHvX5eCfuWpAhRgcO4sdDBTZlk4kvu4mmLC1lA9b4LtjwniRk4T6tEucVBSgAiwa6mCVyhmPkg2Wu2YiT51hScBcX+nwkS6IjLt8QayauYwNow02uu3g22A3Z5aanpzFG/hPg+zbJgKCSuw1YoffdOUANkWABTTo7um0jGav05ihrcdvIhJYs3PxGOlk7yusPZlYRHFZCH5z9FqrDOdRiUYu2xiDLSQI2MS3HnKjG7Ohf6wPXE40+v4yw9btDjajgXpOTXAMsnBVIQKn3gjx9Tjn5/LPWat9BdxpiQunpGbosDDAjv4f1IkjFDPFx9QZzNyU8tjHmVZaj815eGrPyEi6Rvedck+eVonwfs/kLrFxq+IFVcO7uLwt725AfPhXon6t5insTU+M5+eRh6vl94Y3srgAlFiMQOeJ0iH5aewz2EmnFJP0NypPI4EMsh6Q3uN2bmzI9iBpeGEnh4Htye5BQNA7KJ4nQ0P/rRIbv7NngJn9hG9+vai6qOdp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB868673.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10067099003)(261009223027099003)(261026121527099003)(11063799006)(260925022911599003)(260925021311599003)(56012099006)(260925021911599003)(261021121427099003)(261021135927099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(261102123227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?flM64zVOCXsz9auCMGmJHVQhaZXYSQ9qPMKyhEmABLcHzfj+JShNqaPYcntn?=
 =?us-ascii?Q?CtfWla57h8azYEDoDYFV2K5aoUVt3RJGjaMUir4RZOvNenEqm6MNYIpmVrat?=
 =?us-ascii?Q?Qiyb39o43LAWpW9XsehtKZa7wf/TZBlv9Mp8GfEBhM8VYKp2fKICxkqWIoZo?=
 =?us-ascii?Q?jtebcXx5RPhvmwtCUzFzcOfisOzF1dh+LkakAbyJvfGY0xSCFbBEjR7Q/APU?=
 =?us-ascii?Q?L9Lf8kFi1DhOZbLElVtJtcp1j6U516cX+6Lvk7i7eiNwPJiWBibwjyLkPWmj?=
 =?us-ascii?Q?ZGgugKLI3cC3U33sTEibiOp6JhxShoiJUzo/AegRmtIsxcW8iTwOleokqy1c?=
 =?us-ascii?Q?8yougNwQm48rLsx9pcx80+Npp0PfHKc879rTcscHs/mzUOEsF0JZfSks6wCa?=
 =?us-ascii?Q?ViCuUvAJdhHcQwrUBMF4deKXiIorbtvzgvombkEyuGfnh7GZNThjf0o6PB4v?=
 =?us-ascii?Q?dPopeqehz9MVMUueXkDZo+H8DbqPPo6shho6nwqWtC9iJ0ahJPtoXlJZJm6E?=
 =?us-ascii?Q?8aqYlWINe0SBJlsg8hTA8ong7qkT7Sht6fwv4KWvN4t9MCxdRcBgRlQpFbzj?=
 =?us-ascii?Q?YkaCDPH5feqRhGmuEB/TOB3/UAPagagiS8+hXhk4e557TYs9KQ8n7lfoJgnp?=
 =?us-ascii?Q?BYymMqNwPJPXAc/0JlrtHsKXVTHL8a0SR0Tqlxjcfr9vsQCTVvzF6YS1aVEA?=
 =?us-ascii?Q?ns3RTh+kiEAwBCJXjYCPAPtTe/tEc1/uAlmPZOp6XEIGhfp7ma55TTKMhmzI?=
 =?us-ascii?Q?14jYWIxr2SfVUaHzjeZ3DqGdSMUgClEoBMx5hq9Z4zfky0Sy3XFATVMBrdMN?=
 =?us-ascii?Q?JMSnG8i2LyhmyY9ZLOYH7F54rnoadVj+aAzTuPKqvKTJbsG7wAVLd5423a3o?=
 =?us-ascii?Q?pluwLR9YV2AWfbv8hyhBD4hTqVhY6Kf9YCBGnMMtsDdRVDsjBVaKER7K3Xf0?=
 =?us-ascii?Q?Gb8Ig0CooKk2m+NgZKXm++cnS892LuxNdTky2yONYzkVTmAWYn4uxsQpnov+?=
 =?us-ascii?Q?gMzsbsRNoBD7amC/n5z/WaLu/mctBYWvwuGXNNWnHHitaIHDuAYyjiwVVv8j?=
 =?us-ascii?Q?MHoNsWIWN6saxbUNTZgvq56SkbRh8zSkH3U9CTKgOkaHI+iadvN9wL4Z011l?=
 =?us-ascii?Q?Xd1Wxh9HEwITS5pzqzgZWhfPZBF+2cI90z8dvb5h/6jljWQldZ3P4ZcEA2nZ?=
 =?us-ascii?Q?I8YPf6Rxq4M2mwCq+yN2mpzjH0pYnf3nCtQkFi580M3uGvrJhYpRPglnFH0f?=
 =?us-ascii?Q?JRZVYIiDtygNo2Rsal+D4p7s4Ec7Typ9+o4b0GNECmxlmFd7UzXf8iWTNPG0?=
 =?us-ascii?Q?Xl9WzMJ4OqsN/JXJl9LpnfHY5+VV/mySC5nbCKeWDiFYMqxHDqclrfLvqxHl?=
 =?us-ascii?Q?tltnpEc2SoMY80J0st3XV9zWZb+2jegNVVrrVa2zduPzMoMjAmJCGYFH/gBO?=
 =?us-ascii?Q?pLQwMJfaTQ02exSzaxfae2bxvcDXTQ9WLBxdtfFP8yKQOitORy30TMTXlYVU?=
 =?us-ascii?Q?1FTPJ+ksp7B4xkYTozc+m0rXdxVPBd46aR9d6x0J9EdxdRfTTmybj46Kh7bH?=
 =?us-ascii?Q?beei1A70R2ov2EL5n/LyyfHub8ylq3kNM1DLVXarcSP5FLijryVzO06ZiIR+?=
 =?us-ascii?Q?CQB5VW6zvYpPs36XqNrLkIs0GB7nG+JVIawfIdZy/CAvvVIgVxBDiUl1czaY?=
 =?us-ascii?Q?GLROfWzaWSW64o1hrJltOcHfzXDdTvt6E60vMDNFqIYCkTfHwFjF/HbD1ui6?=
 =?us-ascii?Q?B7QrrMqGNLc7m52fkdjcTkdZighNA0k=3D?=
X-Exchange-RoutingPolicyChecked: G586kpVYKCMRi36w4CFAHEIGc9mDIOf5LD4v37m1RATgz+yOQ3ytgNyp4PgaoWL+kM3iToggwKTr7bsSqHvqt7FPV/o1Y9HtA6GUJVWk+ucPd3/KYRXKyW5EF4POyIWJzAd3/rc673eK/jRE1rfzQqPS+0Q+g383wOtWQ11XIf7wZZ1UGpTomOUNjunfAdzWPO8fCxuHsgshscPGQW87DdrcVuNivVejrC1MLQavN5VtVZA2KsfneUS0kwKlaABK/2tzNgEfzkXkYytNnsHpNsm5DcbznNccBdb4CHnQvpjv750pXPGyuUxBckl4jZTVtS5AZpr9EN2rlp8uDjG6mg==
X-MS-Exchange-CrossTenant-Network-Message-Id: a284f129-51aa-4443-c8b0-08df498fb143
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB868673.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 18:29:21.4217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9VS24AE832csArBZSZ6rcN/IWj4h7Nrcs/D0UZsZzFGKxg4TRN34/PTz/NeFulhHZWIDsZ2Y/eRRzfw+BIf7HR27v4MHUxVbpG7qzzAFhfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7063
X-OriginatorOrg: intel.com

On Sat, Nov 21, 2026 at 01:24:02AM +0000, Tianyi Gao wrote:
> On E830, ice reports CHECKSUM_COMPLETE with the generic checksum (GCS)
> that the hardware computes over the received frame. If an XDP program
> changes the packet and returns XDP_PASS, that checksum no longer
> matches. The stack then checks the packet again in software and calls
> netdev_rx_csum_fault().
> 
> On Cloudflare servers, an XDP load balancer removes the encapsulation
> of the packets that it accepts locally. Our production traffic hits
> netdev_rx_csum_fault() all the time.
> 
> Do not use GCS when the ring has an XDP program, as mlx5 has done since
> commit 5d0bb3bac4b9 ("net/mlx5e: XDP, Avoid checksum complete when XDP
> prog is loaded").
> 
> E830 also sets the L3L4P and checksum error bits, so the packet gets
> CHECKSUM_UNNECESSARY or CHECKSUM_NONE, as on E810. For example, a zero
> UDP checksum over IPv6 is marked as bad and gets CHECKSUM_NONE. A zero
> UDP checksum over IPv4 gets CHECKSUM_UNNECESSARY.
> 
> Two pending series [1][2] give XDP access to the checksum status.
> Neither of them supports CHECKSUM_COMPLETE.
> 
> ice_rx_csum() reads rx_ring->xdp_prog again after the poll loop ran XDP.
> While ICE_VSI_REBUILD_PENDING is set, ice_xdp_setup_prog() can replace
> the program without stopping NAPI, so the two reads can differ. At
> worst, a packet in that poll gets CHECKSUM_COMPLETE as before this
> patch. The pointer is only compared with NULL, so this cannot crash.
> 
> Link: https://lore.kernel.org/all/20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org/ [1]
> Link: https://lore.kernel.org/all/cover.1794281983.git.tianyi@cloudflare.com/ [2]
> Fixes: 905d1a220e8d ("ice: Add E830 checksum offload support")
> Suggested-by: Jesse Brandeburg <jbrandeb@kernel.org>
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
> Tested on an E830 (8086:12d2, board N31483-007, fw.mgmt 7.9.5, DDP ICE
> COMMS 1.3.63.0) with an XDP program that removes a UDP encapsulation
> header with bpf_xdp_adjust_head() and returns XDP_PASS. The kernel was
> based on 6.18.64, where ice_rx_csum() is the same as in net:
> 
> - Before: 63322069 netdev_rx_csum_fault() calls in 30 s.
> - After: 0.
> - Without an XDP program, the port still reports CHECKSUM_COMPLETE.
> 
> On an E810, which has no GCS, drivers/net/xdp.py, ping.py and
> hw/csum.py give the same results with and without this patch.
> 
> Request for comment: I also prepared a drv-net selftest for net-next.
> It removes 16 bytes from the UDP payload with bpf_xdp_adjust_head()
> and fails if the packet reaches the stack with CHECKSUM_COMPLETE. I am
> not sure we want to enforce this for all NICs, so asking here.

Anyone else besides mlx5 behaving this way?

> 
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index e695a664e53d..ad22d855436e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -123,6 +123,7 @@ ice_rx_csum(struct ice_rx_ring *ring, struct sk_buff *skb,
>  	rx_status1 = le16_to_cpu(rx_desc->wb.status_error1);
>  
>  	if ((ring->flags & ICE_RX_FLAGS_RING_GCS) &&
> +	    !READ_ONCE(ring->xdp_prog) &&
>  	    rx_desc->wb.rxdid == ICE_RXDID_FLEX_NIC &&
>  	    (decoded.inner_prot == LIBETH_RX_PT_INNER_TCP ||
>  	     decoded.inner_prot == LIBETH_RX_PT_INNER_UDP ||
> 
> base-commit: 92e97d7cffc7ec6adfa4699203c18b1ab0c8b314
> -- 
> 2.56.0
> 
> 
