Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794027342;
	b=efodpyKrCgVbX97T+to4SMt04cunyVoeqo2Q+t9LbE26cIuHMsxLvikQN/bcEL++Q4Ku
	 pWkwEM/C2D8RQiehjnJCwhaUXfWx3zVL6jTUGG1xcDAk7+ZS5DY5N0P7KPnPnPkAG6Y82
	 3QkkVuj2hPLDWkedt2+aTB+28OC2JmTdx9U9PhZkbP8olNF4lze3LW3O0XKj2SWSvFiJn
	 O8GTr0N77nYKb8GH3qzgODrYmMnecMaWtFMMzK7NCjfNyz7APjYYipJw0YveC2jMP3Wqy
	 W0ce3Mm+LYPfrqrd2OoOMEkjA330WvTQ9ozy3pYH3u42UjAwpYFH3liUPUY+fqPFa4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027342;
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
	bh=SFg62+RzsHYul8oLtEW5w2cv97Q70jJINKGM6Hfbt+o=;
	b=h5mJipzX34gQ7E9U4g156vUYEnFt8H9897j89E9CjJnfjQowgjVKAnf62C4VSzuAo1Fl
	 O6im8jv7dAeJnOYibxp+kwoZNNbmsCthiGLVviHoQNuXeTa5raKA7LZrVHLJZbljMKvKN
	 CWdTsy2eUMH01eR/SqvYEyP75ltd2RgYOgh5f2yVfvsG72B4kinVArX7ZxJtF8ffaGIcj
	 Ox96u+gQYV4WQrP+UXSZ8JoTJ5nTIE9309CuZ6BgqzEYIQxDDeW18SMOG15OFNV2dnLLZ
	 YPnkq4jYS5OvV22DuJRQ7DJP3Y0xtYG9IjNAoiu0eTLuHPl4TzZ1U/cTaucAwLop9NA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KCxXPwM8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F56606A326;
	Sat,  7 Nov 2026 04:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59F56606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KCxXPwM8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794027341; x=1825563341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ktHI5KOEUjz/gdZ4AGWjVK+2TLFFJ2vX9Q/uvRTU188=;
  b=KCxXPwM8s2Oz4QGsE5YZRfsJ6SWGyWE3q0eeVU4o5glogbde0J1FxrGx
   8Nv02OU8ud7jiVx/uxe6B9PtsuXL2HcaJruRIqQe74y1yk5mghOv2bGKn
   1D2qLdYdBHfnXuOCzxjbuoY8Rz9c53/QHL9iYA/Yi4+MmWwPrvZoCB8zP
   8AbwTPbYseQRGFd2lwLxDQPu/Qg39XfRScliTGNvURbMaVC1FOWDDESUB
   mu4rhNR1Wwrlm/axvoo9pGROuOBGONcnpIk37U36HfgPk7XeeQmfAFHEv
   3nNCYJ7sj2OL7Tv+j6rwHTsdnzZKmSY7vkMJEFHCDEORM7psPWrzQY9E4
   A==;
X-CSE-ConnectionGUID: gLz5ctxxRQS4GxKDIJF2BA==
X-CSE-MsgGUID: 1UHJp4FWRBqLf16s+H7EHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2941225"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2941225"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 20:55:40 -0800
X-CSE-ConnectionGUID: QaB5zEqPR8K9PwAS0BJ4uA==
X-CSE-MsgGUID: tKgjQXqiSp6zQRfXnuZnQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7458922"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 20:55:41 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:55:39 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 20:55:39 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.64) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:55:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aVjLZ1ojvKoPwiwe5p08gMWaiT+YUN9LfYFfW10ZGwFqCDJV5j6NAxBToGOTrQB7EbL34HG6sHe5wi2FQrZCn2vDiLvoTlrzTKKzjnYW1K8tvQd+AhPdRMkCgA467SVkIka+HDKIjZBk43nBkwfYSQ0W+k70OU7oB3CnVzOYui2YiytDL958yzOM0mXjNCPpT5fjhRY1p+QWnFeIN2fFWVwW9UFDEk+qRVemny12Y6ABeGSULHs9srV/JTcH//QTeNWRQTbcTNCOLHKbMD06ldGwJmnlJ6bIm+EqN+0o5G6iSUeiRJeqYwMIJOPR7BljUNZIOyy2ejB9fRBjGuJ8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFg62+RzsHYul8oLtEW5w2cv97Q70jJINKGM6Hfbt+o=;
 b=zR8RnAmAfZp/coQEFjD9q++psp7ILzie3JqNaXfMlppv/TbFptGpXD0S1fRTs/W+D8A6V8pc0BULKHrZXTkoD5bDie6y7NHE6aYF83P98thgIseain122tOlNjRNl6ubbhdgXYJA6KLaETJOcB7EBlvhb+E91dMmFGxbV1b0/bWT3YoAJzZJuji9W04D1pmfMm+DNVliWN58Ow3pdvsud9kbszGOfE0uzOeIS/i2EqfWJOx8k9pDtPB6Zd0wSYTXrxjAX0D87/o7h1yd9kFu+uS5Jm6LlkwbqcTbQ4h0H6qu0G4zX/Q6C2pOtjb+c1+Tduy3kGa1MONVbgGQ7lDXOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 04:55:36 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 04:55:36 +0000
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
Subject: RE: [PATCH iwl-net 09/10] ice: program multicast magic wake before
 tearing down the main VSI
Thread-Topic: [PATCH iwl-net 09/10] ice: program multicast magic wake before
 tearing down the main VSI
Thread-Index: AQHdUnGWYM0pjQG2sE2d6zteEAs7RLciQ3dQ
Date: Sat, 7 Nov 2026 04:55:36 +0000
Message-ID: <LV1PR11MB8790F37EB4C8A9916032424C90752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-10-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-10-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA0PR11MB7840:EE_
x-ms-office365-filtering-correlation-id: 09089a5d-e5a1-4185-0fb0-08df3c8b5cdf
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|6133799003|21046099003|10067099003|38070700021|56012099006|4143699003|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261022115727099003;
x-microsoft-antispam-message-info: 6MFvI1N3nE+S5+mwj04BeAvcRi8ykR8mmmzfnOpZm6CXe0foVcEl/wg1EOBfEjCLgQHX85u/aUy9uPZPJBFnTYqMKxP5r6YJeIhVjI+e5rGlFQ2vBm45aJTdY5l9KCntxzxd0bXKRLm0DejJTd81l+W4x94xA5+dLRz5+FezoB1a1QQpI5h6gwBF5yef+87LMb4IwZfEzo0cJtOi5MDWiHKfzL73IATZBRkQrEdWAv58Z9dg2ZPp5yYzXe+7t/2F2F1A1VZ7sZB3IIyaV8gbS26ZhGV9EYd8Rc03nLOdKqr9B10h+AW9XFSGsQGw/u4OmsjGgwCoD6GjEmJ5rSYDAPhdlX6vtMnUyjThgZSa+FpPdD85sbOctgrtB9UuXsnC3IWBYM/HyYt+vAliBVLZn7VmPMiTb0CMfX1ilS+AyYq2sevC9PoqNffBSWxOvboQNQrTw8fBgXEC/OGVeS7lyB7uPQp9ns1h+FV4EiOIf/Dz2afAyGSTgAuAFCYCiyL4ybWfDTO/F62P9NlNy+SQwT71CJeJbPcLf2WXMN2B7llEfA1q8l7Tv7QAlnkdzKsB/hOhJG9YruaQgvGJDVX4anZM9EevTKWpIjWuIgtC98Atu/drMf1njxTcldPZaMrNJG6eoxCU4S7n43IlGDqA5iYs7zxa0vMrnR+Uwbe1zJ/ZDh3Q0YRfq8ICLcQn3ZiF8kTYu9l0MCQER/kEO3W413hDyRRUp+X1cXtAysUiggo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(6133799003)(21046099003)(10067099003)(38070700021)(56012099006)(4143699003)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261022115727099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OJWH+tzHOU1D2wiXBKG+MxGNSyg+6ufIfSVaFVmkruFzqXGvQWCSTQejQNx1?=
 =?us-ascii?Q?9A9obrMvJ0J+HZc+JsfUVWWskILP7ztmQJCSrSKfRmojOZkenI4MqAztRL05?=
 =?us-ascii?Q?rzdprYePehjofgWY7Xhzb4YYQ2fXhF1BCImIpmh5vnOnfRXTWludbd55z8Ag?=
 =?us-ascii?Q?Zfy1Kl9srPkAsV7bZZDqGWzFoawyTQHKxOBVQ+7u07xeSGN8HrDAHm14NAz5?=
 =?us-ascii?Q?W3mpqccw49fOP7GvW52nc6AMKW+HhAQ7PKRKPW5ayjsHsAS2dhEu06V+DDt1?=
 =?us-ascii?Q?/vrYw4kXAdaH6DUXwdT/JVF0iSW6Xb81KA7SoJX/qvWRv3VBwrQ+4U3vkUBh?=
 =?us-ascii?Q?DDTZ8Cn06ADIso5XgbIElW4CZw4pI0iyoebdZ6JSB+07jT+YVUl3ijIN0o1o?=
 =?us-ascii?Q?8BlNWM4XbC0wYwxwpUYbfMaPz3zeFBRKygaTx/5HsyCDgHiVY4fBqtyy8Uoq?=
 =?us-ascii?Q?aX29GmKfpxDTHMvq4gcit6v2di8RnUAqMJE3Sogvt/tElU2J6EbMBfD4AEAi?=
 =?us-ascii?Q?vW8Wxyr8u8j9+o2KpdlW1oEzQ/UDDXyjCSZwQRjII9j2r0J6DeF9FfMMJXZ0?=
 =?us-ascii?Q?PL0bo+q/1EDF2Bxeq88EeOWSd+/t96X8CX0u6Y9YC6ZYtYlNQyHdpvvs+T8x?=
 =?us-ascii?Q?kABWk1xvTDfuQfdv/WxhtYV9wq/TIb6G+xPYFFwwd29OhkTaqWaQ0SI2ongv?=
 =?us-ascii?Q?Mo4+qTDvsISgcEGWo2JZ3v2rnpC4ou2Izsweh9DdG32UxdUNqwOAXAByV4Sx?=
 =?us-ascii?Q?qiPE+4cGrCEBTLbjLFnx8mTGe+dLK5ia2QU+06KgC4I3Jhd7mA7eo8ETvzy/?=
 =?us-ascii?Q?tkubRu7cH213Gk6sI80qw9cJHnnUsLOnlPOCaukNz/HscGB2R+7DnRNUNaKk?=
 =?us-ascii?Q?YvewBa4pj4c+KwKdDyXK8JW/3rkDrCn01u/aXQIIVkC9naTO0/hhNaFOYc87?=
 =?us-ascii?Q?tjSe4CHMCajbQrTx0KflQb5BUjxSl3JfudmMqqcT4MzgweiP6bUrxhkzBqkH?=
 =?us-ascii?Q?4Zs4VKV17B81IHmUtgPn7QfoqmPvA2NEAQVlj9Bahl723GZWp2GrPkZTLZCA?=
 =?us-ascii?Q?TwhYzI0k0JUZ29XEZia706prAjoe0AT38gZNNr9FTHwfTl//Gzq1nxqfkNlV?=
 =?us-ascii?Q?1ERpd7oEXmdJ45QaQayuPQFBxJZCqIkt//9LDmVFrGBfImpxJRysC8duRVRR?=
 =?us-ascii?Q?Mzye+Nh7iRGJuMSzSajsjgxLmXgSmMIAj4wB8SikaH0btSzRXWwftgrJXXr9?=
 =?us-ascii?Q?z+oifN/dbVq/lbJGqOGNTa+iZTmbxY8i+eW9lwhFxQ1rgT8EXYeFiYjVzanH?=
 =?us-ascii?Q?H8WrXyLawcAWeJN3hAxe4MEvre30Drq5ollkhJUKpUZVZ7gG8i8G4o5dwTOs?=
 =?us-ascii?Q?8MQObKO5tYLIGyD2svrbYzYJuh4h86PBuNnHXmT/tKS2vdj8fic/V2u+ftae?=
 =?us-ascii?Q?PX9GS7xYJjOw2SQR+CDKl5mon2yWtXDOO5gyUuCAfOuDVeAXMX4xwSppVgW2?=
 =?us-ascii?Q?Z3dRKmzXM3BLPprtgdYIxJB+440Mhg++DVjpwgsFEVpUqaULz2x+mLtDfIuk?=
 =?us-ascii?Q?pPPDYk7ySW7or/VEjG92wVeGuQGs587qLzNOnadTDnrRr/3WBZYIChNte14S?=
 =?us-ascii?Q?7cfqVQ0H4+PdKaedI56UJM01/gLC3Yd0LcDRM49rQw4xXdMzwhMiLR2hD1rt?=
 =?us-ascii?Q?kpPHY8a0bVdYH4ljxTt5aj0BiRnmU5T9ch3qHSHVjfMwltEe9OQ7k57pu1Zh?=
 =?us-ascii?Q?UFFx73SfwQ=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: qNgfZuDVyTyZGG82fyRCyK+WxtsmFCxA8mNpz34urINTVh/5bQzTi1pL42pA96v0dgI96UQvUEwG68KpE/ct3cXRcF1Dp62he076lxVw0yvmCGUTWI3hKdo1GmlPckM+S8ksS3afyQdgc6s/4KCqaKr+TQiye9eJw8L0ac3XQVLsSi1VnevbiO3Q6R0cSZ7nub7pJmB/Yv9O6w2PkS+RqK2DmWkieYGUzWBEG+Ji9FbvgsFjJqBQYD2zDenC71a5jKgQkUGbzmQTGjmthHXnA9UKx+Ncy+rsWbXwAKQ4XcqQ5Kqjxceke6p4fJtrgXwl7QOaUtCC+y1Rjztpkm3xpA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09089a5d-e5a1-4185-0fb0-08df3c8b5cdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 04:55:36.5603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FCruzf0FzZOZ5pL3n3W52lugESGz9n8REso4AllLnS6IABsZpbaD8F++6RPXtjNmx++rJc63k2YIVpTtxD4C0Of3GO5KhMuHHeYYYDzmSjg=
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
> Subject: [PATCH iwl-net 09/10] ice: program multicast magic wake before t=
earing down the main VSI
>=20
> Since commit 5b246e533d01 ("ice: split probe into smaller functions")
> ice_remove() calls ice_setup_mc_magic_wake() after ice_deinit(), which fr=
ees pf->vsi. ice_get_main_vsi() then returns NULL and the function returns =
before it sends the Manage MAC Write command, so multicast magic packet wak=
e and keeping a locally administered address across the PF reset are never =
set up on shutdown with WoL enabled.
>=20
> Program it before the netdev and the VSIs are torn down, as it was done b=
efore that commit, so the current netdev address is used again.
>=20
> i40e had a similar problem, where the multicast magic wake setup ran afte=
r the admin queue had already been shut down, and fixed it in commit e66141=
4c98df ("i40e: Remove duplicated prepare call in i40e_shutdown").
>=20
> Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
