Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794027311;
	b=33UumbAsRNf2MBopImw0ovCQGAPxnWquEGkAOIkBId8qLPfT1fTcdq2RoeKV/pcwVyXu
	 uQWw+GI2HF+gb22Ajtg0Ebpl+AyBj2ue9KOwuC8KXGZqg2Iwn8qnVQr5fyOZRfOrZzSNK
	 6TzR7rDoWTDdAH0YXFqsTlIcncGheHIjUe29krXuxnk7MJTo5WaDtA1XuF8m0WkUkhvsI
	 CmDf13zBwPaYyBe4ZRGaTu4CMP7d6K+WZuu6fqV1rujWQNt54Hhgy2C9kHjva3miOERAH
	 nDHOoE5oywI1SeRkMX20s527xaZPNxYM6mYsUhqVI8Ywpkp0hP55DRKbTGWCafEeuSQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027311;
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
	bh=S5zMR99YlensC68I2TrBuzpciw5c5JBAVgVuD1Lh3yQ=;
	b=UeC5s3V1Ebtn9EEn4QVgTHnM9omqi2zyz4oLv/yTkjM+N2sLyfqTa+HTujzZ1RCDr1Ms
	 JjA6ZfsmFaVB+Sjf7HXIdX2cGyTckbU5H5ZJbB75UcAMdA9c9tK6AN3Cl1kUn5gfayC7x
	 pVhwItXcbSoIcO9CpoKTZ8eD8K4PSxQXMjv6KScRAjjfhSgPi2o8uyXD6Lg89oZOifP/a
	 9kpGEs5HKggQv10ODawhLObURB8mdc113qLQtmlcdeK+aFhSNnP79qRZ/IEXvZDOHB21n
	 d5xAeD9hUB8XBoxqkQvV9wDExymcoAThd4PyHCxNNWFZolDeWlAQ1+Fs7pNdV3k5L5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AMLfHa1n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF88606A32E;
	Sat,  7 Nov 2026 04:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4EF88606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AMLfHa1n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794027311; x=1825563311;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GLYbFMYa141uVrykQg95fZfIBO6PAbirhPyWoHGpWxI=;
  b=AMLfHa1nmb0Dpmxvb/6GkCEd9N0OmDOv4CSz0Ak6ROiqrgv+rddop0dE
   qvPozUMILLmTD3YCjP38pcXql6O0djP4gs6yHy/doC96q8p6ZTSx5By5z
   nWBpoLyM3m5jUvXdTLK3rt+YE2nIv+OKDcI2ltUbOBRWCPtEZNX+ytTSz
   gGlfIE3JMTrVx4SUOkUeYoUxW9HsO+1RJzHf1uruDFFnOpyIewEJlg6yj
   H7T5KPhNQhN5c9sqbKcOVkpp2Qv92+ammByYl1mZ+fREfTHk6FHBT1b4K
   RctuMQlvsmy/SM3sG4k5HmECYoG/6FSBWITw9AJkRTtC9iQqOPdWARIew
   g==;
X-CSE-ConnectionGUID: ZTUrYdFwTzO1LGvhx8lb2Q==
X-CSE-MsgGUID: nN0ve88ZQFeK3wfStDuA3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2741091"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2741091"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 20:55:10 -0800
X-CSE-ConnectionGUID: UH3SUz26SO2IRPvv11zYZw==
X-CSE-MsgGUID: 8Fv+SlCJQJam/xvgD2EeOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7761598"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 20:55:09 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:55:09 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 20:55:09 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.38) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:55:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XS1sJGL6heXbVbFj6SOvgpqczLcYppXvNmqJk95FT0M6QlKlAlHTWCUs5AO90nH6vMG8R6MndBf9QsQ15M9AVPmbKPk+k6YSGuGkcB7NuyHe8abhctr+vtxMhr7Q0kabarGN9XMItH//pbO8qumZi3qIJJgAPR4p3PNt+dAPT9gEklEj7MUk3NitTQAlLbY8CdlQU9x5jaKVEAXp8kDJn99A6YPiQvE5s3IYyq9UKvJTVJfjeI1D+Fwu41InHurSaj/0mVrBmOkQOwGX0OhxHVetxyyuTVORhUEu4ByYDW6k9FoOSB2/qF/Ir73bxj3Li+SruFCZOBqSxDV1HFHj2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5zMR99YlensC68I2TrBuzpciw5c5JBAVgVuD1Lh3yQ=;
 b=e62SSjfZIs8tqeiLkA4Rhjszpl1RVuS/ym9AtKTn/6wmpHz6UY3A+dHBAHh2VaTt99bumgJDLvjO3xsMqDFls2ukMssdPwZvpOLVkR5Bn3w1Dqt5tL10CTJTzVSGzeHWpIC639gqNmKmW7TwnMpgW/jo4P2DMmrM4oyyZh/7WLQqPAus2kdcbn9xa1H+bxrZmsJu30qEvEjM3F35Ecp52k58F8j7sLOl7yVsBCVA4xyQsUnKzzxyigTqwOU7uRmKk9hTU4L2H1GJnA+R0mTis5XbpjomOBZfSQLAFigEvLU3BI0gjXjlMdQ9rLC0TbOeGLCsDfKA6lw97iWIQyVFjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 04:55:05 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 04:55:05 +0000
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
Subject: RE: [PATCH iwl-net 08/10] ice: detect a PF reset that does not
 complete
Thread-Topic: [PATCH iwl-net 08/10] ice: detect a PF reset that does not
 complete
Thread-Index: AQHdUm9PLke8h6g7E066QeSQ/250F7ciQ1dg
Date: Sat, 7 Nov 2026 04:55:05 +0000
Message-ID: <LV1PR11MB8790D36DFE6D4B2560AFD57090752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-9-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-9-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA0PR11MB7840:EE_
x-ms-office365-filtering-correlation-id: cbb06aed-fe78-4d35-b85a-08df3c8b4a41
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|21046099003|10067099003|38070700021|56012099006|4143699003|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003;
x-microsoft-antispam-message-info: qcQmz76petffJ9GGDym9yPg0SLC82z/1O/s4XSmM2KkbOxWs8bQctZM8mu0Z53W8Nzl86jK6UJI+NIUuCBLsuyyflIa2TOgB5vK7CaXjzkQgxI9QFslsh0mBv0T0f+NvdtjR6a9+G8rj06Hl2VpQbcGnLxLpkPiBn02ubgzu8MNSN5YsUb9c1WQgKjFVnHxyQW93wxlMZUgay8p//fbaRf60AAFF98qiME9iESUzKNRKKWnQZfT2oeIPtOI+WKramVDpFJjXltC9JkwjQqdjYCF+pBn76XTsCOuUVitvtAtiFuVpOU9EUg21jBKIUSa+MRe82cOYdL+6tW3sEzcriySf2oQ9VDGeltBj6UnIHQNAu/5neAnkC4Oy0uMVExUqX1L+IUkBVmrX7vW91486hcIqfGQdU31gZvZ6RCXtH/Ua0rqPaPE1x5I+tUwYpArA5qB5aJydrnxgRTDGrtubfpiVvlQ8tX7aUx3s1LFJrVGoAyzH6CoQPF7xXcrOoST5EU88nEmzwLnHt2+0h7O2XOkEQjf/oSlDgpvEhhk0F8YVBxl6upn1j5hGrRBe5rshK+6sdHYrtN5c+AAOhlyxUZjU3rJVve2ak0MrwitTwla6P8nlaNlla6upXiINZiZ+/MHmPTY1+dX5UUyjBjYvytKBcjqSIu82UiqrCjnedvU8ARpgmVEp1tILvylECvwqUkmBGp+T++E86/v2SqWVbroTjVYIyLShi5yn3ynGNbo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(21046099003)(10067099003)(38070700021)(56012099006)(4143699003)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ChjidxRL8r1AHz7wQ0dWhHP6ejk+unqcvQtJZF2fDLvaWGw47Qyxuiewgb9E?=
 =?us-ascii?Q?V5zENsi3cdXeaaIh11iYC4DeXEUJgC3R6CKmK/USUXB0dKVgpWFHLdhixaGH?=
 =?us-ascii?Q?OIqAuQBo2iR7DCrsNw9fKowj6dRXshb/zVQaq7RQAoM9DOC//Fft61s88GMe?=
 =?us-ascii?Q?nGMdm7eIbFbipDlg1y5QqyG4N93jitP6pa2YCb7W6G9ZVQ0Xdlf6Pwk3epxy?=
 =?us-ascii?Q?FxaOlddPE3QzcaeWtqLN+ba5CEk+oTE7xzteDWyjQNGmI2K7pdv2eg1va0pV?=
 =?us-ascii?Q?IBaNfxCVD0b52PpbNIBXXSw5J624YQ0NaU3NTm/hVVGB1V/GgcL6X/pQlZi+?=
 =?us-ascii?Q?CXjukyU1lpupZw1XFeGGinB4itGTNpwHK0+9Z55f304GmT4QShszvS3nE2PG?=
 =?us-ascii?Q?w6JBhj6B8NWax2EV3U+2Ngq7/3k1SGomf6RO+lEznAfzvIdakHZnGHFQzsyI?=
 =?us-ascii?Q?7akv193AKihgGWiApUITHohm5pB2XanEt/HkemnrEPbYiZkxmQSBgBt5xNNI?=
 =?us-ascii?Q?8wkyE7rXvT29EyMuUkdMwBC2FUVUYXBqzj/4w5NV6uyUnUPwzpffsc6M6G88?=
 =?us-ascii?Q?1Evi6MpEnAZCF9LYaiQQqGqjlcOLVTYKkFqKvlI6mb/40VQW+kQO/Zmcxodw?=
 =?us-ascii?Q?86vTv/9DBmv9uAyvkEnsmcl3XtP04jh4VXC/5z4SoyGAOGtHqoogFJDZPHBq?=
 =?us-ascii?Q?yCntQcOhO+zOzqq6IY8j5FeONpuChA9TeBAcuE1s6nl6VUjpnNRusB3JTgrk?=
 =?us-ascii?Q?W1SLUX7ZW0lVlp1RHUTTJdH5wVeWsJA0b9XeRXP8WzeV+6FmlEDACNS9oF6x?=
 =?us-ascii?Q?RcELqkPOrEvXd2mGR7ap1x4qkJ4XYh2df04i9oWqJLx9fxM3qZI3tlqW67p/?=
 =?us-ascii?Q?cU8xhUSSsuOlM6yRO6tHju4L+3Ed0pKUPaqX+MBc8pWc4NbiXnObuEyi5IiX?=
 =?us-ascii?Q?h/vdjV87kNbbJ0IwZhWLcb5SVSeaFS0DAbf7h4mWogRqKhk6eIUuSJBm/75t?=
 =?us-ascii?Q?+oLt5ldYgbHXvn7QsZzeWBjhVedygVk7/PWOm85lj1WyrQ7Wx+0i/+/x0bSA?=
 =?us-ascii?Q?EKKY8UGqVC7jfthVrbPogfh9ggqv16Zy9qoUaYzxP4YII97DqFWRIhdXkpoN?=
 =?us-ascii?Q?dX4qkLnhK0M1cfctD5ZmDR2pNF/HxJ4QGMVlF8j40TG4se6HqZeTYHJky47g?=
 =?us-ascii?Q?nfnFhaWXODrHLuvnofR0AuvM1RvywYwiGCYCTQuHxNVCRcnPf4F9JtFPRB0H?=
 =?us-ascii?Q?NW/9XrScAOlEPhyHk6DjFvLSXWIg3eG8P44DLWv9HGPb902xTltRnFAiT1wX?=
 =?us-ascii?Q?doJHGJq/xMhDwk8b5y9kOi1/PJvdp56ya9kFaMX5ieCpjt4CWzMHhxYwPzLu?=
 =?us-ascii?Q?TlIpMBEyYayKvhfLpf6ynXYIEuGjUOynsOstWUSYNicBrA1qU2WR57yJ/0WJ?=
 =?us-ascii?Q?rA2AXpIL4Cv9pFoNeAULWqNvUIWL8S2+8R9gUH9VYnqDZpSB3E9RKpDGQDdr?=
 =?us-ascii?Q?AeoUhDXivrlFLL5W39VsBoAv0D6CU6sXPgVfEHkKxT9TLNiOlSdaBNXUx1EF?=
 =?us-ascii?Q?ZAND5E6HPszttNZiLNEAgyDlvgKwg4Fi7WRvbSYSYSUxIJ2vMCX5fLkGxNSf?=
 =?us-ascii?Q?Efg0lUz7CMms5QkKbgsjgx1kIOVeEaJpcDFOws/+GceMlQg1c1tyRUoKQk/Y?=
 =?us-ascii?Q?S/jKNRCW5Z4DskucEFi5HPDsv0EWmhHb8j5sqb+w7NT8RxorbwxUxQ2AJJkA?=
 =?us-ascii?Q?qLBSCt+MgQ=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: g0j59OrPkMmTuzMzb0ajWcdCcrIxim3e1maINgTuz7UQXDs2IeGX1kmnb770CsVLRrzEILu/MNuAJBfvKIichmbF8KMvgn3pglBOSokHWIQ3aV9wGd+mEriRqi2P+3EnoCxZhYgCOBIe9ONUxqyhfwCZIJQ0jzsJhxhCX/UdSHDuJoHJ4JjF2+N1a5dg76qos/2hwjfMTey70ts/w50FS/dxPnHwC+gKQr+bBpFdrJczz6uLqsmPWAmwVRHwLIwTwL1qCRphcpbr/Acgaj5pARWOHO5v1ovgZBiQUZZ1k9Wf4wJ/aZdMhDxCIu0NWvcC6MMmwXwm4DZC5lhQtOaxpA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbb06aed-fe78-4d35-b85a-08df3c8b4a41
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 04:55:05.2845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0bTZhtIhMHIkyAhFoof7Vjv6Slbyr6bpia7fBQqwO/ZBuPW8y9XaloY4Xw2tqtQWHgAuCrw31pXHdKYxBAaqVPXUod/3gX75ivqfOQlB6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7840
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
> Subject: [PATCH iwl-net 08/10] ice: detect a PF reset that does not compl=
ete
>=20
> ice_pf_reset() polls PFGEN_CTRL.PFSWR for up to ICE_GLOBAL_CFG_LOCK_TIMEO=
UT + ICE_PF_RESET_WAIT_COUNT iterations, but the timeout check after the lo=
op still compares the counter with ICE_PF_RESET_WAIT_COUNT alone. When the =
reset never completes the loop ends with cnt =3D=3D 5300, the check does no=
t match and the function returns success with PFSWR still set. A reset that=
 completes just when the counter reaches ICE_PF_RESET_WAIT_COUNT is reporte=
d as a failure instead.
>=20
> Check the PFSWR bit read last instead of the loop counter, the same way i=
40e_pf_reset() does after its poll loop.
>=20
> Fixes: c9a12d6d2091 ("ice: Increase timeout after PFR")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
