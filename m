Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794027283;
	b=JFOF8tUKnRNMknVWvOxa7gasIxMSKLQ+SEsmjVY3GM7uf8cl2Y6X7Sny4bPOkXObefxj
	 JDmFuyW9Xcg9CWg9If92Pkw1/nI67/hGWmtxQrpgE6qENqDbmdjfjM5ctQMA+wTjDDiwr
	 irW6aGCdpZkh5kNRwLiKO/RSdEXigcIfPQ50e6xRRe9OO5QD5x04cb9Y2kwqO0Q2y0Ace
	 rkfVtcXdWiewNj0SoJrs1+fAn+z1ugqm+2uIWVdrD8F04XHlUmfbcIzfcoTt5r2D/geaU
	 Tj9Hd6OZXmwTr1qhh4DpdLeCUvF823I6OGpBGg0DPmU0un/uUWZVuPAaAVmpdrxOcBw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027283;
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
	bh=a5QUFltmlv+0irPqDs+BFNI8qvxG3i0D42wNQCVnrFQ=;
	b=YRGhrF4ScWX5H7pbd4fFSQhYzz2buRMwLHAgqquqcY/lSvPw+GEZE48872bVJBIExrkt
	 lFiX+oD+CU3mRR05MbMpt9HDgJbhFbNy887fxPOnglmqoULL9O1EC2EXms9hCFHambk6T
	 /6F1xo3/1but/z+/tdZA46NdJAv5EnSMBk3wnUpLTPLgU8l8n0p9QQJ0rbKehDf8xo/kB
	 0gxgbnVNJoZa+D0dhZXIReNVS9YBBqUUe9oMIgtBAjdZOdEX2qLqJuKSp6tT6ztSs8iM3
	 tNIYa1Ay0UNQN1NZs8T6xx90FMgWkGd2QSwJlv00B/95m0MPKV42KXFN46AP6IgmFcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kG8M3Zvy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043A2606A326;
	Sat,  7 Nov 2026 04:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 043A2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kG8M3Zvy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794027282; x=1825563282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=92vz2gaO4WgbJW1SVRN2DBc59UafZmWt1Ui8hJe+PfI=;
  b=kG8M3ZvyDBmY4g75CpNTgYWEKw/ZFtk6iTGdZxxIY1Bd4eg+MpyXKynR
   7/+jdEBxQTy5BcVkMQDg0eNvk4Li9DMAZnUaHqRqSKz+gXxtw8U4kvUNw
   GwNu4HQ25157yykHqH92f+Zwvlx9Fk0kHSQsV+cY6L/lOWKxmzAjkXS86
   cjJalZbUGRgjk5ECUXxW/C2a8xdTps7+4Z2oSQM4eXeh97R2zx+c90UT3
   Pv/1+J/vupItTs+4NIb8fb7Diwx7vwIjLzZGVGR4EiAgiZJmoNCYooqUQ
   D74/QH9c2BVM7K8rUxE6vcwcpEfQ1bruup9TVifvnKON8hlLgj+d3GT+V
   A==;
X-CSE-ConnectionGUID: 8Cd0W6S9TLeMvN22Ny5AFA==
X-CSE-MsgGUID: 6uAkgZsBRFmZIJnIF4tfsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2941177"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2941177"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 20:54:41 -0800
X-CSE-ConnectionGUID: AoOnwmE4QhyfjocETu1v1g==
X-CSE-MsgGUID: 1oPuBBM6S66kWBst1CK8WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7458740"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 20:54:41 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:54:40 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 20:54:40 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.55) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:54:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKMLCxEtz1B7NFHUuHVPJIdoMsyMOlUE73optx+F6sK7THIkxIUrE8rrtqz+TdDCd8VKY0xlRrZ56yE7X6LwF7DZpibYy9U3GSSH298+e5a2Ri7cVey4VpX0aXeliki90R7WYvzBzL1dFLiS076Z6F1rqfWEAapRQnjYNrfZ6vMc1I+zypuHyyUfPsqmd07nCo/tzM7DBHaqFo/JH0X7WtgGvIAdRwA405ToYN36nLwr8/Pv1kyKO9GgWjdbzGI07yzJpQePo5kKz/hcaFoaFKg6aJrCHnwF7/zTkFGjDQVCzoIqygeAizE+m35fSZcGQSxYL+zjtxBmDEOeO/PDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5QUFltmlv+0irPqDs+BFNI8qvxG3i0D42wNQCVnrFQ=;
 b=V6yjQpkV4oRLJCyT1jvfOsVqbV3J05/JtWw+IyiAPm9wTMqGA/vtgQ7nTtvTNJa9j+jMxh2do8ons19jEQvQ0K54wF2hhczBQqxNHaCSJXhxDXD2O4P8/qreyfbeDcYESmekpByqhi9Z6h2IJaW/WVuBu2GF0W88rR0EK/+BY1yWtrGF3/yARwOSiWwRLqVcoQ+nfHwkfsbJnPorfYjKmnvBpTPg0hfH1osbPS4WgXSe00TEcQSJ5WW+5YMkduoYUzWUDKzQbh5i+gj7PYvIzx2YLUAPkmt0UoLX4Klt7CtYDTtg4t5eIYHuDpPjAguUBPQ5s9Dj3T8rAW7FehDysw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by IA0PR11MB7840.namprd11.prod.outlook.com (2603:10b6:208:403::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 04:54:36 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 04:54:36 +0000
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
Subject: RE: [PATCH iwl-net 07/10] ice: take the switch rule AQ error from the
 response descriptor
Thread-Topic: [PATCH iwl-net 07/10] ice: take the switch rule AQ error from
 the response descriptor
Thread-Index: AQHdUm8/f0cri7lr0UO0+Iu+GrOUC7ciQy3A
Date: Sat, 7 Nov 2026 04:54:36 +0000
Message-ID: <LV1PR11MB8790A8D241A07D5C0666F26890752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-8-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-8-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|IA0PR11MB7840:EE_
x-ms-office365-filtering-correlation-id: 337d34af-f904-4af0-3b50-08df3c8b38f8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|22082099003|18002099003|21046099003|10067099003|38070700021|56012099006|4143699003|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261022113327099003|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003;
x-microsoft-antispam-message-info: duADFSw48GJCk+lrxHNPn2gG/MTazAdZ0RQE2ys5azN2EltBRWI3FfNc5pshfDDRsyJhb7oLFCVuoQrgMVbsGKO4kSQyIqbw006F90R8SBvnbX118/e/1VNRDemu5VZiWIPutlE4XhIgD4MFaZsCa9sxi2MitdiGI1SbrKV4i+6qqFvXOWANRzNMdm/3Ug+Jf8VSxCSRs0IDszHMNuywjYRbqt0pWl5lyOuFyEvkvYelevRrfnw9wLxv/JAXyxx98MV6BPV+1iA0juypNHeBEDzJkgqSNlOdtfNIUM0IsCkaHe7k4zPuF7zoel+H/pTgXNGFvMOapuksqfZNeAOALXmvsTvCeeE2xaCZgwniHM1UV+yHM04UKeSK//vi7MjWTDTh8vAEtOZa6znNCfbGMhzN4O269kjU6g+JrJrk1/Itt9zAuXOz1uDBaH4q/+0zzsiz/2CpUcgAwPk3zjqmiXdOdBoFwkBtQR0Svd+c9ZRTmhiYisy8nw2OHP7LR/6rUKQtVewArjQDviP4qQrCBRx2itOj9/3GShjI/o4C7VFc5744k6s04fEwJYW+47/as56uJ2tlm9ArWGes5q31mD9d1mfijT+CwuOk3q9KMSmdsdvW9PdpgC8GEGe6jv51dB//jkVu5pDLlgo2/jpmhnvnbLRI6vZev8mIEgixUy1QivqrbFPK7KmFt/0MjCnSp4FB+wG4gX4VllcmeSJY9TF9F4sRW9JXnQ0Ah0OjHkw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(21046099003)(10067099003)(38070700021)(56012099006)(4143699003)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261022113327099003)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ut2pmN/BlqJxb4vbSvAqb0kFhtE4kPKFjeSUA0FvkCb3Z8WtmM3wSv1V9nta?=
 =?us-ascii?Q?gisYNrR/Wvc+CUrlXKJ2eCMPhc01DNe4+KbYLXBaQc0Wwb8mSYvKdSoUbMff?=
 =?us-ascii?Q?4qARMe73dJA5xU2f1e9iCXzDNe2h9N3XtktufZimap/aAxEbP2cFQUG0uIfx?=
 =?us-ascii?Q?ipohy1ccBtmBcGNaUFc88q4t1obtoqXz8lw7j1F4BuECbcULCbP70zljJbtG?=
 =?us-ascii?Q?9GBdmHFKW5VNwcf1Td7C9LWQ3ExZrzFNagyDL91NaxVN+V2j7TPIzN8LnrDY?=
 =?us-ascii?Q?9qvW6nTywbh9pce2dRNIrls4fyfy6wsvFl2w7djMS0Ds4N+keBgwEAamIhrV?=
 =?us-ascii?Q?MuczTOI7H3QBPSBIaJJhCodJPA1iE9UxDhao8EdYFQkyxYDGSzES86rxPnJN?=
 =?us-ascii?Q?c73OgsBaiCUlu9vvlUstCY2X1LT0Hlzpa3BZXtLCwhuv1ey6ypdm/WJUI1cr?=
 =?us-ascii?Q?Mx4xx2lB3NqnT+sVd9ggLG+Utr2JxYlwmT2kOZ5Ng4vvncyqqy2ENIb2XHsr?=
 =?us-ascii?Q?NkTcW+EdEU0ADLVCZLZNjTovsQs2UPgDG9L+7+ca7aM8XqPyCj2l/CUuB+wt?=
 =?us-ascii?Q?4ql+TuqBshonFSNbIHQb6PDMjhYlivSyUrrO8IyfSPh9P1TDzSIAzePn8eAr?=
 =?us-ascii?Q?0snJ1P8DCvuUJP+0BRq3x2GNk5iKTi4EnzbMqwPEyZCS5/Z/BrKUDDSU/1fc?=
 =?us-ascii?Q?Mqrurb4RpUnj59Pj7yiKodzYlv9w1iWg00i3IG+tj8odi+cWRO05duMhHhKG?=
 =?us-ascii?Q?04QbUDAk6xtVoipIGF6eSWdDuh7Pku+SS/HvTxyGgw4oBHfjnF0PSDA2ddNc?=
 =?us-ascii?Q?V96B0iYI1P2XsPfaMGIzycTLEbaQR/dHbW7YAtkAR/81tumHG4PO08ByerYv?=
 =?us-ascii?Q?gmkQPgweI9Z4YEJ5T+95nBkOjj1nIAJaVthoIzyiFaH890gziq9+bITIDYEe?=
 =?us-ascii?Q?ZSob0u2IzwoPe+YmZhhTC4aVy0LcOK22nwei8UXIYliP2h0NUwL4R2zIwve6?=
 =?us-ascii?Q?XCmrTotNe5GipbvgYR7hDdCG/g+emVuzJgOb95D6AAUSZFcaJHlVyN+bp+w8?=
 =?us-ascii?Q?xID6hz0si2xR08W15DDPtjvcGjlq4xqwWsCM//KvhyfU/CQvemPEBbIJeZpY?=
 =?us-ascii?Q?DlHB9hcITFkjBa9ExZGWVTRioR9JBNn9QssVWlQa5UysOZfferoRTBkv5rNG?=
 =?us-ascii?Q?aoJq5XpyRgjDPHW1u7hX60MOBy2G0o8hzWy5uuW5BjIpGTyEpjMZb45MbiMe?=
 =?us-ascii?Q?AsFYWBwrVvuW1myY7DT1CcHKlWXWDHSwa7FwGDeeRczqYcC9Db5CZvFQ5Gvp?=
 =?us-ascii?Q?0RlxHVDp5GiOK/cDPe8/clYLXwM1v8clahZB8JOECDSAaVFtbuLYaGUnoaZc?=
 =?us-ascii?Q?8icdrN4DIeAe2J40JTtq0sSb7xyL9LcPftk9ni1tXn7jGav3NyXtjmdJXatH?=
 =?us-ascii?Q?lspTyUUhsnxhv/l1MElhZ74puUU+jVX2GKnR6JD7c9Ggc7Y2TrWcNdTOtxQh?=
 =?us-ascii?Q?KLLXW1xJa5q+be/WM42NnaPISCEVN4Zo/Mrfa9rp1sG9nkdPyidx96a9MvMD?=
 =?us-ascii?Q?n1dm8audKdI7ylUh2GMuRCYgfcPGtAoPP1RY/YDoF9lZ+84jlE9bcGmb/zd4?=
 =?us-ascii?Q?PhNVhFKeO1rj1BrQUwsYyiynmGRM7Yx4NuifsBisMAmKFjOlGuTnXM8TvGOi?=
 =?us-ascii?Q?5ipbTQ+mQcvZ+ynnKyywiU6IZe8jgvB//YPMfAGu72LBTa7oapjvIjkhbjFm?=
 =?us-ascii?Q?JGxOc2DVJQ=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: Yj43rpC63BqiHM19Vctth3IHKZWfzSQPLlRVb5aHdYlmlR4tkrcsY/xAvXvfHV7hsDmj78qgPPlr6aO4sS3wvjYOmIgvtCDqj30jYcLc73GmWPTjbCmWuLCKSJdo+oHzFatkiiElH7fZyNsqQwSFwgJruxAunFcWzIraetcp0r/r93IeIFrbkD0JZnUAcO3vHVRZA4IA9kAM/2sHZNV3eW0TN+YWZLgYzq/2nLM5ysX+qTHPSplEGLO3dNaYUJdVMcYE+lbS/+Umk9lUuuc+bonFqiXV1+91FOP8OBc/j6u09bjBqmHBlEf01u7DBs9gJXVOd4xm1nmu5/o6sYXsLA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337d34af-f904-4af0-3b50-08df3c8b38f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 04:54:36.3415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SZh3AvUNLWgr2wOJ35vYO10SsQO9fHkrM5Od3G+iuwPtIGFz+jGqj4ASqHUeSUeGulhm02rQUm+zYqTq7D3/WZVLO6JvEpHZGJtEiKZmY/o=
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
> Subject: [PATCH iwl-net 07/10] ice: take the switch rule AQ error from th=
e response descriptor
>=20
> ice_aq_sw_rules() decides whether a rule removal failed with ENOENT by re=
ading hw->adminq.sq_last_status after ice_aq_send_cmd() returned. That fiel=
d is shared by every admin queue user and is only stable > while the send q=
ueue lock is held. Another AQ command completing in between can overwrite i=
t, so a failed removal is reported as a generic error, and a successful one=
 can even be turned into -ENOENT, because the check is not limited to the f=
ailure case. A caller that sees -ENOENT keeps its rule bookkeeping while th=
e rule is gone from the hardware.
>=20
> ice_vsi_sync_fltr() has the same problem with ENOSPC. It checks sq_last_s=
tatus only after it has freed the list of filters it tried to add. Every en=
try is a separate devres allocation, so freeing a list of thousands of entr=
ies takes seconds, and by then the value usually belongs to a different com=
mand, so the MAC filter overflow handling is never entered. With debug prin=
ts of the error and sq_last_status added to both places:
>=20
>   ice_aq_sw_rules: opc 0x2a0 status -5 aq 16
>   ice 0000:04:00.0 enp4s0f0np0: Failed to add MAC filters err -5 aq 0
>=20
> Use the retval of the descriptor that ice_aq_send_cmd() copies back, only=
 when the command failed, translate ENOSPC on add to -ENOSPC and let ice_vs=
i_sync_fltr() check the return code instead of sq_last_status.
>=20
> i40e fixed the same kind of race in commit 53a9e346e159 ("i40e: Fix race =
condition while adding/deleting MAC/VLAN filters").
>=20
> Fixes: ca1fdb885e5f ("ice: return correct error code from ice_aq_sw_rules=
")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c   |  4 +---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 6 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
