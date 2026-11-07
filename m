Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794027167;
	b=X/Y3bQmqtUH6Ws8J0j8HkaWSmattYKZH8/4T4KxZzMclIxIULRybu0pVTEciUXquVWd6
	 C5u4FImCtxKEUlAXk0aW+yGsgFq4AZhPbPjSeYMLfkUlWCIko6ZIpNMhR/SMkovsOx4sd
	 9szwXKAyZqG7BYMGpvpN2Cp3AiAxRUIih1X5JqcRAQVjrhdVucBG6NLrsdEnQ3azQQwj7
	 oNCIP6SXT2S+q81wtXM3j6BQngRqcVla+AGhwrU0GjCUsNAN4tivun7CDovdLnfPJL39w
	 br5TfRNIIFxN9h226AOXPfi21obHBwd6b91DpwaXyihbxHuuw+DLyo3Rh08oUFEAsjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027167;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ld-processed:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	bh=DQ2CxmvT3XsseZe5DoIlvXuw6SrwXzjZ4D697go2oq8=;
	b=f8QivrSIUZnFQS+rUzdrjtAesvHJGS2zo0hq+WZ4mUXmkJ9OueAVIvNuKvy+6jBmcrC8
	 Vnt76xyV5ZvPioLoXClcL4kZl9YAN5Re1hJnUgu3801Z4wSAvN2NdDKcE3mTzeSOkAH3x
	 V2+V9AujcM51IygBTGPmTdWukRTpqWXrOuh+QIqjpuQRont9LenGddxVI951AZlkwkR9h
	 6z/JVjfcgv4VHPOZD5sBorZben0Xit9HYa6QPBDMqzmi11aEKqK1jGwOceFrbIYa+AIZl
	 3025FFLshAOrLNWTNejyj023UciF9Unq8wSyvBALfdrI9Pvdd/Kz78Z/M1jfcxGiZJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JdM44WZR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B5606A326;
	Sat,  7 Nov 2026 04:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 201B5606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JdM44WZR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794027165; x=1825563165;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BrOgqVpNkiAmgOwKOCyDdYSBHrCp+Ld5uPyu2K2LqJw=;
  b=JdM44WZRJK3t8XQikRQ0X5rGPtDKEzTFtHcy9mK2feaAmLTmYj8az9mc
   OEpzF0LD43TAYzdzeIC6iU+k5JprHnShRd725sBE/0Zs3hSN/zlw53od2
   Z13ceeIBf+abMBf1m550D4VWLCA7gcYMPDRrOwLsIV5gB1yA8jdf3sbzj
   7yITye3VVTSuRNOQVMLKugzx9iCwq/RRitgZg99T4C4dDNfhA/h7Fes1X
   Al/1yKc0iv891vzYpcCr0WvJcoOtPbkAWiGlYOi7wDwPskWMOctHl4JPw
   4cQUZiVECd+oA1JIU0Sruc+3+2f6HABDOHoH+d8Wmv1bjMfDKeB4OWgKu
   A==;
X-CSE-ConnectionGUID: JozmTe6bQMGtH/TvUDYlWQ==
X-CSE-MsgGUID: aGNFKey/RIqauUDHSWjgBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2842074"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2842074"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 20:52:44 -0800
X-CSE-ConnectionGUID: SZmUTUuGRJ62DABdluLsKA==
X-CSE-MsgGUID: Anvd7501Rruv+xPSCsdkZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7777599"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 20:52:45 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:52:43 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 20:52:43 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:52:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIkoBfpF7SXQPIT+Vr1x+u88rupA/u8ys4pPoss1ItMH+n/B7paVA5WAmaO04MXfWnC68xyfniUL2v4vsl0Pb6Xpr7S0xNhdF87IImZyCWnhMbsfyA6kdVjROEif/WYTyx8XVffXoYCbp//6Y1Z0lNwqm8Z4nGgxu1AqgLJZ84ue+ZqgOQ4ZQhYTKFeuHqmQ/REP87ZnTVoqzA+sDNy8K81a0noNQDFkdA6goHK4RmekjEqWl2ORksH0Nf+HGKnTUB2BAKtiRLpF5KIJ6Q9pl18t9ak4ciKsx3SM0tyWuntbPPqMMMhQCjNpoZed7Ix3Ld0JmnO5YKpIDlzLXg0m6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQ2CxmvT3XsseZe5DoIlvXuw6SrwXzjZ4D697go2oq8=;
 b=o/SpzVhTPVDgfgjlPV45vkhG11aZvIEbBP30PwdYtITc+paHp8P36C1kB+IIjyMwtbgr/JxwEBzoD+GsBcGH8YuxXy0CbtTfirWI6F/9Scx/MCe3gsxID7Q/fahkJE211rBwN3Sd1rtvtbsXhrAQXhIpfunnBoC5e9qEew4F0VYZMAm+iQ/YX+R3KLD0HBSSsMUZYAKtHwiIo3I1zWCIfxla2vV7sq9IQjr0UMDit6K+OGwykYbv1O8P6/mlkxfuPLJbqUTkkKnEgG4HhQWxy4bvxITviRLq6+NQMOKEiIyMyANFFBI9PEHKy2m02BnTIDNJogDggOk/Cop5e0w2rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH0PR11MB9727.namprd11.prod.outlook.com (2603:10b6:510:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Sat, 7 Nov
 2026 04:52:41 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 04:52:41 +0000
From: "Nowlin, Alexander" <alexander.nowlin@intel.com>
To: "Oros, Petr" <poros@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Oros, Petr" <poros@redhat.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Lobakin,
 Aleksander" <aleksander.lobakin@intel.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper Dangaard
 Brouer" <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Henry Tieman
	<henry.w.tieman@intel.com>, Anirudh Venkataramanan
	<anirudh.venkataramanan@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>,
	Preethi Banala <preethi.banala@intel.com>, Kiran Patil
	<kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>, Stephen Hemminger
	<stephen@networkplumber.org>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH iwl-net 03/10] ice: stop the LAN Tx queues when
 ice_vsi_open() fails
Thread-Topic: [PATCH iwl-net 03/10] ice: stop the LAN Tx queues when
 ice_vsi_open() fails
Thread-Index: AQHdUm8vQOWWpreEhEihZFaCQaUJq7ciQqEg
Date: Sat, 7 Nov 2026 04:52:41 +0000
Message-ID: <LV1PR11MB8790E5A86995DE21D2BEA39290752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-4-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-4-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH0PR11MB9727:EE_
x-ms-office365-filtering-correlation-id: 0add34df-491a-430b-72cc-08df3c8af498
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|11063799006|4143699003|261021121427099003|261022075727099003|56012099006|261022105027099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|21046099003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: 5jbifSLhdjY8ETQFy5OQiZ46ppj/ukCUmiX7HKf7n7yydfhuA1DojBo2TdamvDRC3BfPfNE/JuE3i3ej8pkZPopwPNxCDX/pUadYRYo/j752YHuDF3C9nvr5gdaarftU5GJQzYo7/BbuoBoN0iQCc3Ln8j7LJa0cBtS0W+nQ/S9TW8eTM6hXclgSd/vfOLXxb39Trc+ctr8soFAR9RlPDXViqdgfd3Z0lZGZQuWxltlwNrfZjVYaDNpJvH+s9tbxrjnvJrgH/Ou+nK40uUk11O21OimHxPemJmPZL3StmyPil6Rw02OCtWp8AoXfqi3S5X7D2JZbWkDYhIObg0KouX/J0mw41TtvynI2/BnyCN+tts5VUd/OLHCKziksPch4nP5NMohxRcEu1Jg8rc+giiXP5lHhsICI2NK9I5Kxk32XyAUZoZinEHpjaE/s7W0Du1lNP175z/h6Ahd7d3ICRSpCpwqT3z4R6fkTa38trFsDUj9QawbgZI6HUEKt3Hv64COt48rHUaPhZVgXO7SZDxhzZ89p82oGXfuFrnEN10LS6oF6PYyDlebLPVYR71884Q5RH4QqWmZ7yYK9IjXyI0LpbubkMZav8ECD2Oveb/WGLWuSajhWaEoDeXiUdXNHOlOpGXJSqwNJTBh4ngEcni7sIeb1PRjAsK2mEtzaCNGBKZelTIpk4CGPQFPjdaGMRByWqrn2qz4MI9xyPqcIiR8+ZzAgtty0eesvwPk4hig=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(11063799006)(4143699003)(261021121427099003)(261022075727099003)(56012099006)(261022105027099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(21046099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1n6NgU16cN2hFC92Na7F0/vyICvkLe304hKA0vpMONlPwVS9ytI0zFLeaTF4?=
 =?us-ascii?Q?JW4IjJ7pcDI3KvNaBjyp1n1md8rVMm9OI6f9F5jYZ+rKwnv315ij6Pd0lukf?=
 =?us-ascii?Q?UEIgEsF1vwWfoXkYaUMAy0ful73SpspVvyfHtH0vcxXdxgnODucJS41a9zSh?=
 =?us-ascii?Q?Yh9X1Xd/hHyaoKout4OCk5fSJgOweU3+UmEWr63FImG8msfIvP97ZUHeai1p?=
 =?us-ascii?Q?yKjOhahy3PVDDMMZPeYA6z2VzaW3vlhaVjNW0lQ3xIeJRaQbO+nUu5uLwd07?=
 =?us-ascii?Q?+x7JGQ95SMNahHuD/Xgebf+hClO7fXwiaqA869m6DhBKyeacfLKH+FOel1ln?=
 =?us-ascii?Q?2G3FQyvE1IMhH/7hZuCjmtamRueeWN9CvlV8gTSdSaI/OKBm7C2dHMZIHEUH?=
 =?us-ascii?Q?gHqRAJYsxvwt1RYZfNo87aOlQ1/HbCpxnxNI6W0HRoUdXr/rlXsincHH8joM?=
 =?us-ascii?Q?oyKRiGVudIrFUtI8kSqPH/DGQeTCt1kp+bfJfK6nyXAIgfKeC9TX+x1AuQSj?=
 =?us-ascii?Q?eu0X2GJQYO3V7xeifG4YOqqYFO7D4DxDTSqhC5VqJd7dwM6QLNvViCaNd3n5?=
 =?us-ascii?Q?XPUW7h1zx/ETi1tSB54Uk7QF/Jl3olIIFUo6V3qSnuxrQV5CyJjQz6auTi4d?=
 =?us-ascii?Q?dFHgQGukmi2mkF9vtFKRC+aoKyJSvx2wWiSIOSRRMAcrDWCp5NxTcgyyGZ94?=
 =?us-ascii?Q?J7iYCFVWvwQu479/XA903mz7jW9laeNYCNtmfqULMs864NQOYPTkzw2SCx1s?=
 =?us-ascii?Q?NvVb1HN5/fr1BpPg/fkwZ6pPjfQf5fI/boayU82MhQo3nTo+vGFxBmKqfP0j?=
 =?us-ascii?Q?AOYOe6govxkVuxYoCimTtyN7FmUBf7xop6ypxeE61jxnSqtXYF3MVAXdJa5W?=
 =?us-ascii?Q?hYOL5BykTFqvd8BZ/S+/kG0sindg3qqgcX32B0AhSL+v/xvtOYT5U8vmyoQX?=
 =?us-ascii?Q?Uu+SRmsIKtfGEJXhrGgdok5VoV7d2RqMXcJ4t/np1SuzQVbD4Pdq5ITjh56H?=
 =?us-ascii?Q?u8RYORzGsXgc4MWxOAGEub6PL1iI34eZleQjRbIY+XGXROcNlSXTVlQG6Oqc?=
 =?us-ascii?Q?nGhEuNizVYGXlEvaMcxohWnstbxlI06+sCPqSNo2GAtm73L53iR6eRfOpOQI?=
 =?us-ascii?Q?W7vT76uzC1iGM8JKOt1EowDdWyRg6FoHmfyZ4ycIWIZPcu8DZ6q2q7P9q/Yv?=
 =?us-ascii?Q?46lIX7mWeOi593QYHjtbMrfhVOA9onKkha9J5ioShqJOhAXWp9eTbnEQIL5A?=
 =?us-ascii?Q?uM/EZUOXE0DweCvQkxQIy4CVcb7QaLaOsWEus/H6Y1xwK6X5NeLUVkZyDJ4/?=
 =?us-ascii?Q?S/gNwRLEIq8J9xhkUxxzc1sANrwh5zOMbPf5HF0Ew7b+QFqMV8AHZjnsJ9iT?=
 =?us-ascii?Q?W92IYj+4GJF2HIYrDZNfor3sGavEDgoEzAGqCRTTI9Ocr8vDgneIUQyuTGh1?=
 =?us-ascii?Q?1yZUKb4gj0hffD8xt3t5atffV7RmGWfpCYSON70bIytqSZnPUIVCAtt5vJZW?=
 =?us-ascii?Q?Ct/OItTzRwMJU0GVQ/FZM3B6z7zbEvObaqwbJHgFxf1mFmGznqlnUxXMKkVv?=
 =?us-ascii?Q?1OytMydsKyFK0UpdUiPum21V6SEYqzOxAIN3++Rfr5z9nHf2o9RoRPcEVy0V?=
 =?us-ascii?Q?XBogUl//cWxjh/Zu607u1nOE9nhIJ/0+e/zRSdinw0/1jeuxcuvIOFbC/inl?=
 =?us-ascii?Q?X2pR0PAjMhzZvCk3senJ0vA+ui9cyylhIysLTUsA0GbLUApkWAkJ6svFyRS+?=
 =?us-ascii?Q?IkOzq4f4yQ=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: gyNQfBdZRtsapKsMEG53TF/8ODbDQqn6mLBjdg8RdldAqV3DEm3FQvMfmRdpnttZW4+hErjeoBE9bR9BL1BwfCULzu5zeXq162wXjWZ7aPmePQyAnG1CymUkI7D6LTXO5lpPywoftyaYU4qNnuIsqPqiHq916lsp0NK2uQUTZhJBdR5zpf8JUC3gecJpnNRaeu3j07UHiKpw5RjlKpQdzgO21DQl4kHEgDph1/qzJ2y5Q0OaPp7bxbRNx84tYt0Mo6u/B3BUTS0BjX5eutCSF8KLzrz7n3qbuJ3LruU9U/n2N5Jv+ScuqVDkl2VhiH3NOOkTwtdP/CQismwpH4I2hg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0add34df-491a-430b-72cc-08df3c8af498
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 04:52:41.6184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6eyzVvZmkt59Vl9p7wW9dkVnCAi+sN2eghEVp54/qUUsPLPgyMTG62xUp3N88FGfANhQ433yahBndl+YxF6IID1xDaK6buYXeCtjL9jotY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9727
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Petr Oros <poros@redhat.com>=20
> Sent: Friday, October 2, 2026 6:08 AM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L <anthony.l.nguyen@in=
tel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn <=
andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric Dumazet=
 <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabe=
ni@redhat.com>; Lobakin, Aleksander <aleksander.lobakin@intel.com>; Alexei =
Starovoitov <ast@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Jespe=
r Dangaard Brouer <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.c=
om>; Stanislav Fomichev <sdf@fomichev.me>; Henry Tieman > <henry.w.tieman@i=
ntel.com>; Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>; Micha=
l Swiatkowski <michal.swiatkowski@linux.intel.com>; Jesse Brandeburg <jbran=
deb@kernel.org>; Preethi Banala <preethi.banala@intel.com>; Kiran Patil <ki=
ran.patil@intel.com>; Dan Nowlin <dan.nowlin@intel.com>; Stephen Hemminger =
<stephen@networkplumber.org>; intel-wired-lan@lists.osuosl.org; linux-kerne=
l@vger.kernel.org; bpf@vger.kernel.org
> Subject: [PATCH iwl-net 03/10] ice: stop the LAN Tx queues when ice_vsi_o=
pen() fails
>=20
> ice_vsi_cfg_lan() adds the LAN (and XDP) Tx queues to the scheduler and e=
nables them in hardware. If anything after it fails in ice_vsi_open(), for =
example requesting the MSI-X vectors, the error path only frees the ring me=
mory and leaves the queues configured. Every following open then fails to a=
dd the same queues again and the netdev can not be brought up until the dri=
ver is reloaded:
>=20
>   ice 0000:04:00.2: Failed to set LAN Tx queue context, error: -5
>   ice 0000:04:00.2 enp4s0f2np2: Failed to open VSI 0x0010 on switch 0x000=
2
>=20
> Stop the Tx queues on the error paths that run after ice_vsi_cfg_lan().
> The ice_up_complete() failure path already does it through ice_down(), so=
 let it skip the new step.
>=20
> There is no i40e counterpart of this fix, i40e does not add its Tx queues=
 through the admin queue. It was found while verifying the previous patch. =
With the IRQ unwind fixed the warnings were gone, but the netdev still coul=
d not be opened again after the forced request_irq failure.
>=20
> Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
