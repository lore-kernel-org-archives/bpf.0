Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF9A457E49;
	Mon,  5 Oct 2026 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196012; cv=fail; b=in+IsjRucsnygwNGrBavfsLJUzTrtTIFgm67d+F9lFfOBPXYBQ6KmYpJLFryZLJi6i3DoifS9tPI2FTTZGU5DWs4Jhgp3uLzRLUZ/HZx1Uwi/YQjdKu8klhTmonBawGWUIRs+hOVn1M0cubwBRLIP/8Unr7cNP7pR2GDsCXoQss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196012; c=relaxed/simple;
	bh=/RGRaXAtONRbY9aJd+6HHGOkUtHUEYYu310yAFUxWsc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JUbjsF4c6rEPuXIkaFvSmzqO0mbMBGaX7pjCETtmWtRfVRg7XYgMvoBUm6FTa3n3M7vPL14woBVpaP3Rl8Qez1bZPnYc3BZO4PftAKyaC/CU3EJczjIxjIrinuUK00txH8YZW4Xc+LegDWPsgbq3CdZXFAk9mfjo3fwC/qIutd8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lg5g8oT9; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lg5g8oT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791196009; x=1822732009;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/RGRaXAtONRbY9aJd+6HHGOkUtHUEYYu310yAFUxWsc=;
  b=lg5g8oT93iNabpfZQuZMFljPuJ55s7eIHNn+z3vwcbbqsU15MJcXaCUS
   q/rQUrocnKsTCH32xV46r3XCW4nGD1LEZdjfvTebxwSJ5mfHuPPS4APFs
   cTcDJUIGH07EaWAT3a0mIdjg1QFjRdOadhFoDOmZtB9cod1HUKIBiP/op
   b9BQTPIRTBHZRM3Cik40BLYijEyRLyZ8ND7oy/T2Q136nAcG7eL8gHXB/
   Zp+YBKDaLYVJQB9sMsoa4umtHzB4S1HqiMcxYoNQrRj1QDzsAsO0kPcuQ
   cEn/hPFQ3A5VjXELrMLAELQEDqwAgZYFQVlGuUvlJrl5KgbmolbrnoScT
   g==;
X-CSE-ConnectionGUID: 5GPeeZObSpSIjxCm7KnQyw==
X-CSE-MsgGUID: xKEV6eqNQTSEl/LCmt8UbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="91887907"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="91887907"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:26:49 -0700
X-CSE-ConnectionGUID: GXkBwczLTt6onUH6/PO2+A==
X-CSE-MsgGUID: oCXCQUpAStOxdvXBlnlyVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="276878457"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:26:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:26:48 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:26:48 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:26:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXQiojSSeHQbJilinS0NYLgxB7PKvXQWJUCcMtriGIV/GWS9E+QsZNGVQQ0jecqcwwPYqzn4aMT1kl67IRTsmq9iS/LWrl8mnySHKHVv+An4sn8bma52UKK+meb+63C1erDJqPsnzN1vy1ML129No537FOSfPp5RKwkkNUGaycjORSQ5V87QQ4e248HylR2ASx2PA5zcECbOYWs/3FhM1AqQayiDiT055LN7SWrC9DMT0ir7TgvOgLA0TemUnMsxGAR2MdPNzzyvS8ldaxW7NxS/X7ySFGGQN6V5RTLZDFm8YYDhaWfh5AgI3doC6POYSvp7LyOoUS8ycL9bxgIUHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YqGQy4C4AIoqZMd5EZwgmPOhhFS4mwiXV/+poiAIdT4=;
 b=Gam5cufApZGZSm9mCNSL456CUYnxN4x9dJanuKcv+s5p1FIMIijRL1Kh3jEmOl2CmN2kG3Decr4eN/XzYCvE4Q/PzSXANECk80P7rbZIiTUcsqHMH2QIpvJv7IgcClwmiK74Z3QS+m2YabpQFysRGlt69YIqMg601GhJfZVxDZ6wmfGUS4GV2XMBPV7d8yYDoNc1dtGsaj8v/6lFqgSVfNf8Pcy4FQOWqpUeb4KBRZ7ylNprCu8xX8nR1NLlCFcfqhwnUYuQEJdTH7Yjcfnyx84H/03pQ/+aHyHknVauW+sNG7kaxvAPxm35VD/rAzazA4RQKo3OuUSVGphxkUV9FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 10:26:45 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:26:45 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
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
Thread-Index: AQHdUm83Y/uiip96Lky+3BNuELoUerbuwx6g
Date: Mon, 5 Oct 2026 10:26:44 +0000
Message-ID: <IA3PR11MB89863ECABCF08E6CE7BF6E6FE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: 02849b31-24b0-4ef2-bf56-08df22cb27bc
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|38070700021|56012099006|11063799006|10067099003|21046099003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: IIGnKJ8M6GLvMDHp2Ore4lgGgr5dWGf89dKipPJzDxdv8g8oaQ0VC7yGpVGFqCyL+HMsvyazs5uCWUFjLw4vWJyR6d7DftOTYoDI2oVludf8xI7Olr4cPSVEIkJ5Q5A54BU1seFnRIyoFAKIQFTvHQPm0Tc9it9tVFZQyl8asVxCXIQ6pitC74kqtgAeaWyAkn1I73Ru9D/4NirgDJuWiupBfs8wCE284JoZeaHf+wy8vvHgJzlhL7qGSAE6sVlJ169T/aIH9XNSMVvN2wtH1X9yrOd++/qp4hQO9p23zMCHdisuHPje7pMATEEjzo4Mmz6wauHmAM+FRQr6kWAQMD8rjFKHbKQ679Yb8nI89hSatsHYJUC+V8pFIe2F0DN7WST8iqZC5qlruoOzkiDVU++emuP5BqHL2yyx2vi8pHyYoTRhIaGI4FdER9g1jUH9QhqXkIboz7yqEGb1G/zrYrF/+nVlduxNfFfLzAzq70umJ09zXVFa8cw2DBb00sTwI7BqSo04PFWsLIdqYxOKX9rzP//Y+9/nmpHW9ESUHzPGrGaIiD4KYeboJEA/aXxG1JYcXec5eMXQyyzt6ywoP40rjEncPF8LsBLXKZu25jbnYrDL1eKU3FB99gFqHWp6qHXDNtlXmvGYxv7xPL2el5OStqMuAlBiI3qHr1gpnkg7m+jqy4FzdsTTDRJVrTBeL5DNkgBzLS29DT0BifJtflIg1G5puwuSfJVBw2Uq1yQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(38070700021)(56012099006)(11063799006)(10067099003)(21046099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zQFvEH8CEUzpjkC5dxBE8xAkPHustkMOalmcEy/Pqclj5ixe+kYZ3YEx5c9w?=
 =?us-ascii?Q?KF4JzNFWAIPHEoY0489iYGwIxxewonGzp2flR9EAORRhtUAhT61spftlgG5K?=
 =?us-ascii?Q?jQNXUmzXoueWgFu/GficNh/3pyhrI9ZXZ/rbfcErElrrIueV72SRK5KVSzQC?=
 =?us-ascii?Q?v0Y0vaw/jhBb5zREaejfnSfDMH8GqMEDmMyvN/SucxaElusoLomXJw7xkUXM?=
 =?us-ascii?Q?yL+z2SoDQMpjuRf/JsoapHAfIZqYGCgC9S5LgkFjCWIRGiHKKwDUvvGEvORh?=
 =?us-ascii?Q?laTt+9YrrcL5sskDI8HyMMa3gEJ0GVvFO1LnzleSV5LLR4VYhTifp0KPJoz7?=
 =?us-ascii?Q?VPRnsf4WG5/ba2FQB1EPNrY8B2rDH1yWZUBlswY0WCjPmTUdqu/keuL3ycnN?=
 =?us-ascii?Q?EJMYjCu7BphQrPs5ulCrZUfGJFKJLin+wZOCduOedRO5kwPlxnIMA55z2o8u?=
 =?us-ascii?Q?LDvnesBUEglVry65T40Zr4rUFzrUw30tdYodCLROswX28N0kQ28hhiLtxRpL?=
 =?us-ascii?Q?v3fd6/klB+Vx5tfyFFhhJS93OzN7mX9qZj+owX5/86w7Ih6cHJSRR7wWqK+c?=
 =?us-ascii?Q?gcQLA+JaQtx763djQfb4XSg2UyW/ydgaDZ3WdPbTH0Oh+sNrdysGBUtZ4XzN?=
 =?us-ascii?Q?yzFXM2diXlt0wegHmLVWP9RKRMxthr9dAtxh41c+H1pvaQBuIXc4lov+IVX6?=
 =?us-ascii?Q?0HM7e3AyG9HEBqAD/Ev7nOMI9jzMmhxYJA3PuLblxzffXRKJXEAuEe1m54wv?=
 =?us-ascii?Q?Wuy05dXo+eo7FjCJYTdxPoNCaFSfaEQcA/QF6NnXlypewio+I5W6m/j0YVuo?=
 =?us-ascii?Q?8ujKc1J6ULv2S1bQr0uBa5kAhEdjhvq0lBD7GRhY8bQgOWTzCRnBjwAqs4Zu?=
 =?us-ascii?Q?mkPR4fgHXqNqBclEdgJyhCdqoDrgl04tPyRb+tcMnoDJW7EYiHTEAOdKgifW?=
 =?us-ascii?Q?lGSSdRQC4ZZ1t94R+TYgy21As1BUO93Zufw/tz6JGX5UOokB994JJqoKTBx1?=
 =?us-ascii?Q?BRoyTld++Pfyblhhi4h5adViMLluLoOJ3OkBYhtok16FKX3rJLF554LZlUts?=
 =?us-ascii?Q?vBKT/NffTk2LkSMsIBSUk6pYGO6HItiyldYS2Wht1HqxfNQ83VGA/wZ9IxDG?=
 =?us-ascii?Q?ncNrxvCBSYI5CKZ7KT2zu/tj+X6NMY7+h5m4E4dI7Fo7OMyc/wlUyQHYU+a+?=
 =?us-ascii?Q?SxbPkBGsgqLidWcGCmmV9/bwMskcQv0sC80E1Ud+oErWW8fil89HNLGLsnnR?=
 =?us-ascii?Q?uccHlT8URGBVV6nPIH2K2DfCJkU+wwQDxSh7sr0+VwRmMMKJh5MwWYS9+pUf?=
 =?us-ascii?Q?0ffjy19f/wZtezviAk3vkXV1NAyU8hrfjhoK9+71wgtkfjPxJJU0njKRzU0m?=
 =?us-ascii?Q?V9LhU/aw08qMXzoA2OatOjErqzrwkPAfOtBe8ftCLBc7/q2M/Xmb5FQcrIGq?=
 =?us-ascii?Q?saeDDSNFqwmrrzR2V6oUSi9n17f7Ymu02VqhYjzKgTbGYRbFsQwjjJaB3z5y?=
 =?us-ascii?Q?eYIhE+bB3fRENbDjVnWLd62kGWY92HZr/mAGlTtIz+WtUnlsuicdPo1r42ON?=
 =?us-ascii?Q?IIskJoUENfZG+5ty7o9GTJ1RHi7rdNxOW7yal6/bSlS4AZ8m5dcRDf5vqLJ5?=
 =?us-ascii?Q?H7Qr40VGOv1WfdiuPnbb/ZH+Hgq76rhwocAV4tPSTsdLIMj2CbXIxJZSdzvx?=
 =?us-ascii?Q?juMIxk78cg3opuKbHz+WB54BqYYKlNc77P0TMBLaMTDO1Lj+8SGkIhqsLTkl?=
 =?us-ascii?Q?U2ifeap0Syazan3WVEnnRSwvcI+RYuM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jEmbsDiHXU3Sm32YIaoOabJ4GIpuLDKL7JGiz0JMfwilePwZMTl5zCugovgjGorFXksFYnE4DbVGLIpFQjuEeNPRYPAFzMNhMtkEuEHI8cxeTyv3HOK4mk+uFLAbrUhmpfrEJb80Ai7KyfAsknrqGR4gRAZrTefVrk1fLvlCl5dUl9NllqeV2QztK3YnwH4bu4U+GXmyl5d456JuJ8nGYAAb/3IfcMQzay4pMG1WxdpLwf5cLDnSQcqcUxfret3CjC/l4vI8PeM8vRdAuOJh4g+YTjfy6SVJBJqgEDTg8tMFBKTRfnqNOgZqzDYapSlBMair592hogW2JPmol54KNA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02849b31-24b0-4ef2-bf56-08df22cb27bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:26:44.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0at200+7s3QNOuJQj/Qbfv69t49xG1AJ7oOCZYoPGQrsC25i8F0rtTFdQy8HdisPvmSns/GFXGh/3fk4tBPpwmHN2cs+cpc0N2pm8YfZj4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8220
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Petr Oros <poros@redhat.com>
> Sent: Friday, October 2, 2026 3:08 PM
> To: netdev@vger.kernel.org
> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Alexei Starovoitov <ast@kernel.org>;
> Daniel Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>;
> Stanislav Fomichev <sdf@fomichev.me>; Henry Tieman
> <henry.w.tieman@intel.com>; Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>; Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com>; Jesse Brandeburg
> <jbrandeb@kernel.org>; Preethi Banala <preethi.banala@intel.com>;
> Kiran Patil <kiran.patil@intel.com>; Dan Nowlin
> <dan.nowlin@intel.com>; Stephen Hemminger
> <stephen@networkplumber.org>; intel-wired-lan@lists.osuosl.org; linux-
> kernel@vger.kernel.org; bpf@vger.kernel.org
> Subject: [PATCH iwl-net 06/10] ice: keep adding MAC filters after one
> that already exists
>=20
> ice_add_mac() returns as soon as one entry of the list fails,
> including -EEXIST for a filter that is already programmed for the VSI.
> The rest of the list is never added. ice_vsi_sync_fltr() treats -
> EEXIST as success, so the skipped addresses are considered synced and
> their traffic is dropped until they are removed and added again.
>=20
> In a test that adds 50 multicast addresses to a port in a burst with
> the port MAC address in the middle of it, 19 of them were left without
> a filter.
>=20
> Continue with the next entry on -EEXIST and report it once the whole
> list has been processed. Other errors still stop the loop.
>=20
> There is no i40e counterpart of this fix, i40e keeps its MAC filters
> in a hash with a state per filter and syncs them differently. It was
> found while building a reproducer for the MAC filter overflow handling
> that i40e fixed in commit e58872398684 ("i40e: fix disabling overflow
> promiscuous mode") and commit 7363115efb04 ("i40e: do not force filter
> failure in overflow promiscuous").
>=20
> Commit bbb968e8b34c ("ice: Fix issues updating VSI MAC filters") dealt
> with the same problem for the VF MAC filter requests, which are now
> added one by one with -EEXIST tolerated, but left ice_add_mac() and
> the PF filter sync as they were.
>=20
> Fixes: 89f3e4a5b762 ("ice: Do not bail out when filter already
> exists")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c
> b/drivers/net/ethernet/intel/ice/ice_switch.c
> index 2ee5cb6ffdab1f..239d4d9633baa6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -3659,7 +3659,9 @@ int ice_add_mac(struct ice_hw *hw, struct
> list_head *m_list)
>=20
>  		m_list_itr->status =3D ice_add_rule_internal(hw,
> ICE_SW_LKUP_MAC,
>  							   m_list_itr);
> -		if (m_list_itr->status)
> +		if (m_list_itr->status =3D=3D -EEXIST)
> +			status =3D -EEXIST;
> +		else if (m_list_itr->status)
>  			return m_list_itr->status;
>  	}
>=20
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

