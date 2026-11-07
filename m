Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794027231;
	b=Jy7mDrqF3aH8jzWKSX66zwAdC/qxYXRDpUB/iL4iuNwJ800s7cfegoDiy7YqGP3ZZXmb
	 qh7GLUv9mLkOaSaaUO8PFRkva9tlqvJNGCy6xZgQMLGbfrdpn4qZOJM2gT7KDUxMb6WWA
	 YRKbbu+MB0T9udeMGDpF2+4FPHdLRI8ETkIvCHFQ+WkCCKOpAfXPOktVjxfiSTSuuF0hQ
	 294WqL4naE592i+TnI3fmdXXmobgMnN0XD4kB1S4RyEiKzEo2wmVEIM6c5a4OvqZS/8Mp
	 naBFeyzcBhK3Q1r9mwUCObEi85PdMhBb7n6AUFqPM4MUMwHV27vq0S2Jj51mUfLNYbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027231;
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
	bh=A+cbNZ30+3A/Gbsl2HKyT6P39ueit/SNGYE2LlSDNsA=;
	b=1NJhJrAhG5guOawWjeYq3N+Rq8SGMXsWdmWTS8R0HeTFFO74HsDmQF8byYzLAjeZ8raV
	 6QrdV7A0ALkoTijkgplTGJS98ElBb0x6Giipj5rZHR6oA5s8ytf8EeieMN24Eo14AzjYt
	 GBx8toUB44Wng6VGuebeKmv8DIWADPKLRmKCpiYuklLk0C82M7RTFTcjeHFGDT2pcZlTb
	 W99iW6KXea9fqbZ/GRfQ7TXlQ9Dkt3HXGgdWq2/VybJP86o/BVRrLS+RSSzZBS61tqc36
	 H6279fV9mA7NNZN+WdCKdbgHySZYwMEqL8HeEk4F2Swjzgrzx+YTZ5U/Mgznhade91g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mRcxtRIn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6620D606A32C;
	Sat,  7 Nov 2026 04:53:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6620D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mRcxtRIn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794027231; x=1825563231;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nJvvvIWF2ekRyLigpQBCBh2jDu6bSntgzscKmWTMRgo=;
  b=mRcxtRInAgq9/iPXdN1Bhbbr1n7Wpsyo5qs+bQ9AK3hkynO+3F2R1hYA
   1Dn0+MIgUcjoJBlrJlMl9EpPPxV0XdOFCHBaWxO1SpS36VrCgjk2VQ6V7
   RXqJaP6l43CRlVwIP4IgsiolfaqeVW/sxsFAS/34jzVZ3Uw0bHyuqvRL+
   nnUSqOYP35OqXWpuPtqEX0hIrJIDTc1Qqh/XhhxCAlDPUp/W0K1qhwO5f
   vicErNUyUqxbq8igEMc8fpP0d6ZbKuC6nTQV96WGVTjN2rc0sBLmKzaHx
   NchDBy3HNurIko6NmYPsv3PT2lELDx4nmAhaDjd3zbT+ku94DbbG5/Fpr
   g==;
X-CSE-ConnectionGUID: LbfATrD0SQGmXYlSPyGF6A==
X-CSE-MsgGUID: IaaS1zjYQ/2aBDD5lwBsYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2741041"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2741041"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 20:53:50 -0800
X-CSE-ConnectionGUID: eq7Vofd6T0CMdUgLCZxe9Q==
X-CSE-MsgGUID: RDqjrVg+RQKTx3aBYMLm8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7761443"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 20:53:49 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:53:49 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 20:53:49 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.15)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:53:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPNLhf+2w9355Aqau+86RY8z+4CwhCiy4TXqKJ7LmcpfKVa0j9OP8oIU8v94YGsmOjPqTOcnXHIJYJu1TzznY9c0pUnKuctLOeR2IPL4dAf3ksxUEfiPeHLBKS8wjS2evESiUVExSViO2WpE87aFEzMJZEl8/TDDQ7O2iCzDn2zjxb9U5Zx2f3ib7XIzturJBGBf70SdKpL0EQ3zyvmm3zV3shizVMYCHLEvtgxY7p5Q4UMO3fjKFgQ01loVEGltS/C5J/uLOzZhOKcyxwcDivoP0J3TAEWYc2EEYAo5oQQxCs9CcQCI8I57Ph1BYLRUuotVzIwLuHE8njtv5aAYGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+cbNZ30+3A/Gbsl2HKyT6P39ueit/SNGYE2LlSDNsA=;
 b=FlsP9hYUHJQV2gtO4tzsboR4SS5s8OTHcFhAIsPd7v9/aS8OzBhrgh0dEyYE2evdfIfe/FDv4s8NKlaRaHfVjyO7o0jyT2CQuAS/XPveOtWJUvg6yeiXwi8QlefWl2p6+hVdoNJQaknXNu7gXmYJt+G+pL+UZS1xOoFq3v5Ek2W2bkxPMwCQo49RfduZ6FzBq5cUsYHc/5hMD8bvf3rbJcWIV6HF9W+b6cG8lJ80yhbBZ0V1BNzzAWZ6Rs02iexBiJcSe2cfHgT6WteffAThY/864j0d/5tJtsh9LXpYdrO8F67JMMrgIZUpKI1GcrLDl/mQVqAKXUQtZjLEXezAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 04:53:46 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 04:53:45 +0000
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
Subject: RE: [PATCH iwl-net 06/10] ice: keep adding MAC filters after one that
 already exists
Thread-Topic: [PATCH iwl-net 06/10] ice: keep adding MAC filters after one
 that already exists
Thread-Index: AQHdUm837jfy9ezxEU6d6cSnmHgRlLciQvLw
Date: Sat, 7 Nov 2026 04:53:45 +0000
Message-ID: <LV1PR11MB87903346C6B1C86EB3345A7D90752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-7-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-7-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA0PR11MB7840:EE_
x-ms-office365-filtering-correlation-id: b09209c4-1d9d-4052-e185-08df3c8b1ad9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|21046099003|10067099003|38070700021|56012099006|4143699003|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003;
x-microsoft-antispam-message-info: xd6SHvwYPybPCla/efS7T2hg1mtPlimqiEgXZPoZmoEvTO7MM/tUl3hc7h+5xHglf1so0m0WVeNeWDzwbaaXOapjY4cPZUEm+UR/S8TqXTDyb4OIJRn8+Y8pOlXZ7NdDiCZTX86jAx+v8K3vZbFWIuNvSTZAMo5tw70HIZJ753pO7pHxSrf8g3Prp/NS1CNdNu/L9y1tGf+U3a6Zmmq1qSCcZ8Xffk+B3o3A73PVlL5Hs+J+uIZ0OdxaM82poha2OzcoajEdICqeS4GAbkYx59+xpoTDmp3293G1FC71zvzxWuVQVzlUDN36XnpzWrT0YUZPWKwp0Zwd8kc/6by+tZRJxM8H1p/esoFAVU7bPMzY4caI6ZS55kVIblZht2r5mY5DUGh3hGTQOC9G6cKODZgSY23YkE2zCVTGVlfaBgYFjWmgo0gloe0neq9kk8Up848n004BG2jc5HYfUc9ePjGZYssqhUo4Cl+e+QYcXGLDVEQhvkDQWjf4zqQuFw+XPjeu2Xy0N0XGM+zmNbSnsVs6jmwcjRlh5wRLX8mMdrMfIz+LEbSFYpAWL1HBEO3Cajkkapy61/PuEfuB2OCjm6Wg3OOAtRKwkvmNSsV2DCtbN3htad3O+pTFbL7oxNqQwmg6bxb3Ew8lTYJEigZ2NLTL95YJhE4i6lio040AT1Pm5614Suu7m5FwpdXKYRZ2sAwcJzl1mtQtOutBXDj8shaBxQUl5gQQDb0j/K9rBXo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(21046099003)(10067099003)(38070700021)(56012099006)(4143699003)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?660eFt5BAmYt83nLrWTwgDgm+V6ziWuKhuELoSmivI0uNguyOlOnrmPWrLzU?=
 =?us-ascii?Q?MtSsq3N1SUJKf/GGqiZocpDeWvINNDbGgpif0xidAbSzq2gskVV2c1mZg5ya?=
 =?us-ascii?Q?sOqm+T79KsWrcetVfnyv6DV3m4FVoBoXis1fNvGNCpXchEtq5BjlyomCXKjc?=
 =?us-ascii?Q?BgQNVMTA5IfkqcHCqOyq/mS07OUYr7Gj8dtrefQMtLUOEtnW2QwRI+JOevnr?=
 =?us-ascii?Q?irGBMfLuSpMTyscIPStXF+irE20Ri4vGuwbLvntdG0hnZE+RjLG044bV04j/?=
 =?us-ascii?Q?GYpIuXOmU+GZDmFXA9vpcRenjea1l22V8WgsegVC65tFhhloxj6ldstoEnuo?=
 =?us-ascii?Q?Vcqykjl/ROoPdz5aJnUN9A5vTposDGVxOuU426zZ48jHSequ2O9Cn0jXpc80?=
 =?us-ascii?Q?PbLCiZSgWpKs6SBAvwGzQVQvCF+hjEBR2LswxSw6I1IifC0OJjCVu1X3Z9EL?=
 =?us-ascii?Q?r++fU5PIemm7LpTcn+yiaMCWddYtcZICwJaHHUpq13u/DjOu9Q5UDRZOUwpB?=
 =?us-ascii?Q?9WvBE1dHOWjx5vx6LzJ6cTPv9fqH4aXW8EWKwg1BpToTDke+uwOyov/aVwK1?=
 =?us-ascii?Q?1gX5hs2BOjPBm7ZAlUc1d7Ee7BakowZoQK59cVxXpSSsSjbTbSy6Rosze5iM?=
 =?us-ascii?Q?+h4lrkHQSdphYOkh75ivMLLIK7R29OXMJqNDRZ/+2PZlQDh5xSpdD5wkid25?=
 =?us-ascii?Q?m6xvuxotYRwy6sROBGNJUQC1wuPamd/12nr7zQv7DjZPa6/umqaqyVjKXPa7?=
 =?us-ascii?Q?4x2v+s0BDBsBA4kitZrJAFcYFVjUdMPRSYo2f0fk00xrN7L9ILf5MAusHtVy?=
 =?us-ascii?Q?ypHFwYZQI3Jr2ltNCfHRnDUpRa003mzm+biToZgUFadC8pBd5M7QlNze9xOz?=
 =?us-ascii?Q?8Pake/N4gF2EQ85BhhFW0XUAwbST2NPbOE8EJc+eD2DKyFzyhdNAh8jH6AUo?=
 =?us-ascii?Q?I/PPacutmQi0GTpKMjYTrg8FNaBrTTND6TLLp/Ccps0ApjRzT7RBB1uauP1W?=
 =?us-ascii?Q?UgXbDuMeQZq8Uh7FlsyrT+nUI8Dbxoa07l6iJ/7ByvI8QyYW3bmEWgSez3xo?=
 =?us-ascii?Q?yXPx8WtFoC9IsA31onXZgvRYNHgNnIo6iOUWttxRq8rz/FX9rJBW+ZsL9Xna?=
 =?us-ascii?Q?LgWz9Djk5ZDWdpCKItikDkkx7bxmdqZtitq0+VfGcTfQbX5go/99ow5u+Z7i?=
 =?us-ascii?Q?wHzCyBR4G49WCWCjEGMuSKCsEZfs7o3fad2aKy1y54EXSIn1TG/Ah1ftTV7E?=
 =?us-ascii?Q?TSN8WC/L6stLnkvl/ZFa+PdIr4xbIdg7zPW5pa8ajdHlI7l4KeG/fhEA/GMW?=
 =?us-ascii?Q?zIKPEnbNuyg4Zlahw5R2QX/bh96eaVwk0rmeUHf6IQXIhWSwteoaPvmgdUQT?=
 =?us-ascii?Q?ys/4N1drbt0vVlK1ZpWYYfFFpH+ad07ncx2pAQCJ+u/89lV9O2I3dghYqdxm?=
 =?us-ascii?Q?wNq/xbv2z5QbJUIBoxnU77u19xpxC7wQoDfT0cLortJlMgDTx0zETiWaGGJw?=
 =?us-ascii?Q?5BNVWi2I/YFZT3Y3YNMWDsnqKf9F95lcyIJuRgTDHt977cBXew/+bKgv5UuZ?=
 =?us-ascii?Q?ZJalhx0WRq7pryCx1sOfZr6+jxirIj209r7Mp00Ryv9gHHXImPXw29HKAutJ?=
 =?us-ascii?Q?FD2CzIJTSBQXxGUYb7NavOoQdHdLRZgac+r7HA6pP/9d6R7V7ZMbKGAyD8He?=
 =?us-ascii?Q?3XBdgMO9SkHmHeK/ap5NA7raQi9Ps5R22rZf9lJnCUg1nysd/Ct1V0CQEU8g?=
 =?us-ascii?Q?+/FNiEgf5A=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: H079O6HinVdtJE/HF81VcquoOqdpDP+pDhhOJvJ6pdjP5hSsnb6oX1180Q0hqaAhko/Y8odPGSI3z36FsGGKyiBwxgyZl/ey2W8xuUVends+0lxzaZMKsn4FIylmS7S8kCr/dHVtSx9W4qvJJgdxa6fpyflifzS2v8JVYUMHctv6lPAF0RvVExVmGTU9LSwSWlMk75uL6lt5DixDcV0JJSb/FZ3GYWxdEX62+bb3XAdg0o8PtsLQln1Czo7e//30JVs6EOo5yxBav9RKz9jOVHQ5g9iSI0vDLLjEIQ/udZJWLVg/Y1VoDl7CsUNp0Iv9uWbEm/QufTQM07XYCL5vVw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b09209c4-1d9d-4052-e185-08df3c8b1ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 04:53:45.7925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKC/iHswyZ9aoPrqAzPMQKqweXyouGyf8VvEE97A/ioGpUZ8jSf+QiLcGo7It6nB+g6cTdkHp4iOk90m0DkNdAHLlE+4q+eKRpoedOFJOkY=
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
> Subject: [PATCH iwl-net 06/10] ice: keep adding MAC filters after one tha=
t already exists
>=20
> ice_add_mac() returns as soon as one entry of the list fails, including -=
EEXIST for a filter that is already programmed for the VSI. The rest of the=
 list is never added. ice_vsi_sync_fltr() treats -EEXIST as success, so the=
 skipped addresses are considered synced and their traffic is dropped until=
 they are removed and added again.
>=20
> In a test that adds 50 multicast addresses to a port in a burst with the =
port MAC address in the middle of it, 19 of them were left without a filter=
.
>=20
> Continue with the next entry on -EEXIST and report it once the whole list=
 has been processed. Other errors still stop the loop.
>=20
> There is no i40e counterpart of this fix, i40e keeps its MAC filters in a=
 hash with a state per filter and syncs them differently. It was found whil=
e building a reproducer for the MAC filter overflow handling that i40e > fi=
xed in commit e58872398684 ("i40e: fix disabling overflow promiscuous mode"=
) and commit 7363115efb04 ("i40e: do not force filter failure in overflow p=
romiscuous").
>=20
> Commit bbb968e8b34c ("ice: Fix issues updating VSI MAC filters") dealt wi=
th the same problem for the VF MAC filter requests, which are now added one=
 by one with -EEXIST tolerated, but left ice_add_mac() and the PF filter sy=
nc as they were.
>=20
> Fixes: 89f3e4a5b762 ("ice: Do not bail out when filter already exists")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
