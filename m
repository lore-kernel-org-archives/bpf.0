Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BAE2476CF4;
	Mon,  5 Oct 2026 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196053; cv=fail; b=Z8DTRcW9qamabglmMzQ3XIBejXziDkn6J22LB4zRnzs7pFWaIDflp3C1huKjAXT3bfdqMDxh5nNLkkF1KjILiAOTOXzzdAFTKU8WgVuYO3f5TPL6g56SFEtVd310Cpkrt2tY4MA3B6y0UZ5iQ+ksB070sMGznxXyNvY8L6+MEK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196053; c=relaxed/simple;
	bh=GBp9KT3ypseZWLIhVrWozvaA9s71CtU+clF/SDgecZo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jtqxzR/xty3e+hS5BxHcY39pMQi5b409zlMZQ/UhzmyOBjLxqHJ7/45NPdmA3XJcmXtIeulWNY3sz854xxRlsyHfANPd94c0rAvw1BuX1Rb4EAu0L85GpUlw3lVhlUn+wKrDU54wG7MknekNrAQ+cEfARqyxtCDLhZXULjKpYqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c/KO2IjM; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c/KO2IjM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791196053; x=1822732053;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GBp9KT3ypseZWLIhVrWozvaA9s71CtU+clF/SDgecZo=;
  b=c/KO2IjMPP7kest2qBW/DZGkiCNY5zQl6f5+D0kozYB6IIOelX0DbVlH
   KHcE/hgsF6oyiEW5bLT6Z6mFCI9jkglRwD9t5UM/NMG4CqjaU04l6Vb2X
   3VIuYt2FILuv9B+lR7B89HQWVC4HxJOI/WuadZ3NuES5IHSM9XdcqjLnt
   eYTAGEszO46mmO3x1Gtbacbv78TwnMjucaKoKDWH4bJv5l6PI9l4e/9Vm
   gev7OQ1xlDFYuiHsJZkcOqp+95VJcQBy+smvyFTAkUtrgc9UE8DtcE5zB
   fe3a5kQcBhRj1Pa4vyU/KiltJqgE9vj/VbbOo7FdrmUmbcVEDsdKnHhUP
   A==;
X-CSE-ConnectionGUID: f302kdgoSVKPDsCNxecPsA==
X-CSE-MsgGUID: E5hH2eAZTB6rKPeJjBtS3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="102024607"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="102024607"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:27:30 -0700
X-CSE-ConnectionGUID: IS8DZrCISaOonKxZsR5BgA==
X-CSE-MsgGUID: kicRHkQQRr+Uql9o4KBdoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="280527006"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:27:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:27:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:27:29 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.46) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:27:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iN4sohL9XepLDGkOuEjxX8bI4ksod7SrKb5+D7fxGnyXKOj1lycFhQDIaUOyx21qQ7nFmtnsLctPk4AskI91Mvwa1TP4dtuKpWw3iGNqpZ3rhujvrPbz3H2O5jFUfSNrgI6g0kzOtDLFn2XZvk/L0Ibu3oGmao8ebFGH6ZDZDDilLLUJCCI0gLcxhHKoW1wzy9n5mcFyYto8I6OGVfrQ6zwrj0SUCmjUCoQeq3mT5mfLh8cf9/WWii0qmdC4bRvuWGK1jJyX3GnOUh5yDNmRPCed1ilxntQN97NazzuPP1qsL9uGxMFVTuahZiVS0V71XgajUdDhpynInj3+N2FcEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbtJCDswZaLqbAdnYBGQUijanMXQ+vHGX1bm7a/fcKk=;
 b=TnfCCG87QcN9U6Lq7L+p1x23OWdoSXpvJaGu3An+eRkLgFSsZ/+E9rfqkpxYxsTdsXG/hm7UnKeKlzPuqIkMJaOyTs4zghX5yrNY6d/RYW+sRtYfie2z7nvCTmEBeVqZUjOJJvsmJME/mrDKExUTTXGHJeyy39cCX3ezzRkhexN1y9vIDeyZhZ3N2/DiM1RBlAvF/jOZapggp3PDWALuTvoWqWlK4DIl/mobxkKOx8O3cgr07ccp3nXuXTS+1CAt7ltiTdfMbB7E2hn8gAQcNuWkkvrdfgviAWMfoie+186QKePboB3hzUpc7AFWpw3K4FJ2vqvjlkf0C0vWBJo3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 10:27:21 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:27:21 +0000
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
Subject: RE: [PATCH iwl-net 08/10] ice: detect a PF reset that does not
 complete
Thread-Topic: [PATCH iwl-net 08/10] ice: detect a PF reset that does not
 complete
Thread-Index: AQHdUm9P8m4mm1Cw1ES9VCZNMLz1zLbuw08w
Date: Mon, 5 Oct 2026 10:27:21 +0000
Message-ID: <IA3PR11MB898634CAA7D482FD59CA546DE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: b93a6de0-914f-44a3-fe3b-08df22cb3d44
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|38070700021|56012099006|11063799006|10067099003|21046099003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: RGKuNuIo1G91riGf2a1LsplSHI9Tr6XJ8j/P+9GFzezfnCHVpYpGZB5DAip1u/XmCFTGM0SpjmF1X4HYsDby/Tp0zGdtvcbdbnJuJmPH7g9/0ujS9aaieScgwoDoQBtbpbM90ghgxajjbngbBbKHtxgAJC7qi0PzQcJ3XN0z6U12BcACAGVsoj591dU83ad3UZYlHgDmOCu41bUAqbdYqQXoI/YAIWb6JarbWRBm2t2u3GPvC3gaZZBEkcnXSWI9sYxjdL/Fyi1X1Ys3EaoNheSqNMb30aBXc5HKlRbGSmOodbopl4HnalITAfM2yqDUDEMj+K23zM5oCMsW9Ihmj6RvlYjU7Sv0Gb5K5p8OUbkPw6iYE5HMRoIySkRmbAIYxJgH38iwio3icWN2CiGW/ym2hBlgp+T3D9NLf5g4TZmXE71uiqzLNvtWPngid7mAAQ7Qzgs9CYQLUhek82E9v+wU/rEf1CVkt70ZAtsCEgZ/6CqAHLSsSpq8bMhqMT0GkbmKJtUMi+1enDcbVoOhcx7iMtizRItwrswjaD5hahld4rLji7hbh0laEK3QJO2HFGtbUSTVrQHXc4XQb4JpUXHCIE1TtbFElijOGVk+lWn/ECEv/uDOXqu1j7b3MDem7JIz6ikpxj6Fummo0mdh9vppiusUvl1erWw0yS39PtHQ0n3IzimUv32W+ymyBBUTtCyV+dB68IXr6bWZ7KOy0rfWfZyeUrQz7jfeIAq1SkQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(38070700021)(56012099006)(11063799006)(10067099003)(21046099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ldh9dBGLPEsdKwGtCFKJsSufo2gyY8Gqrrk6HZVu/3MoWY9qLWFsAHph6WxG?=
 =?us-ascii?Q?IEqSM9q/s3XCUOsrZvPeYi7IpT1U4nc3SEVr6laugVuFC/ziz3B9cpx4Gqs/?=
 =?us-ascii?Q?kk27/vY+y8vEUyXxXyK02WmuQw2+KckvbH/vYOxaJnbc6VAmDZSzOqOrVJGB?=
 =?us-ascii?Q?V4K4U0QrDZyOLwuedx1mv+6/7SyCZN7kXZP4EaeJnBOe8tRX0+yjgNtOeJvX?=
 =?us-ascii?Q?jqMAj1W5mZ8ue+kOvKQMnYvD1rVFJtjjnvsqEFjvRMia1HQXU9uQ50+qW2GM?=
 =?us-ascii?Q?7bXI0tInW1BEoWTSTxZD+4HgTE7mtm/PRnt5hbMIsYsktdg08JSUErZpgPoO?=
 =?us-ascii?Q?m5Rjqoxp5zhf6cHpS2pBbUS2Tf02BxDzp8spvw8/3z0tvTKR0H9PDFJDcOcE?=
 =?us-ascii?Q?MztrfLozDWVRrY3DSbuMe/8CWlMY+xJuWlCGb2PWKHtdfUmTG2v8LcOna1JQ?=
 =?us-ascii?Q?afryNnNGoei/iLo4mJGmKfeT78aQGkXKKaTlvT5Ig/LdLPWS5HlZXrbHlGDs?=
 =?us-ascii?Q?s2qLyZADmsxwiJEC/NCj9U/LgH7rrzvDaqVA0kFzVh8lmg5lCwchrfXz2YoH?=
 =?us-ascii?Q?0uRnqrFFP7S82aumnljxO2zSKgC+Rbac4grmaRkVW2LREyGR+dyFEwk1/amJ?=
 =?us-ascii?Q?8QCSbH73BE2si6rMLqkEgZ6OuOKWjCJKaOD1+mkgHllEOU6t58XmOIoVpM2j?=
 =?us-ascii?Q?yd1dZ498HjnFKEvIX2LdGD7pI0x6WCJ8TjOd8qWB7BeDrDuS6RvnSfOaHIUh?=
 =?us-ascii?Q?iGq1P6ENTyyHdXec63mNFukM451Z2XfvLNQgQe9kx38J3k4d2mFOJQzHl1kP?=
 =?us-ascii?Q?g4URxUHFKZijoJO3Kq8KqLCGrEg9gT9PgqN8p3vWOXscBxBy3GYA0td7FrcB?=
 =?us-ascii?Q?iP3QuMj4KwcUBnxveoOdqIjDOpy1uao0BHKl+N3lJV32jwlA7yya2llSxvtS?=
 =?us-ascii?Q?NITJ2KnGWo3xMlA62ejZBYcNFnxyMb1/jEKePRWyT2b029/vYRsHhiNNiM8W?=
 =?us-ascii?Q?sii7Bpsk4f/7/PG6Y/IMrMCfx8hamfgSeVB+d/B0+DdP+CNLqxjeqzDu4cqb?=
 =?us-ascii?Q?JRCKKb9KFbIwQzg3Y54/qJd3SkIu0G5/ZR+OezZ6dt3GeMCXtMr0gApyn7Rk?=
 =?us-ascii?Q?YqBnPcw33ncGsStIMIRQCag3Znbd90PhHXjOE15etEQPOkzwJYH4lduhlNxm?=
 =?us-ascii?Q?HEdHucBszd4Km3uKYoRCCR/+/3EN8SPjashqNA9WlsbTC8XfouMGaOF/ruUx?=
 =?us-ascii?Q?nMZlvZnOU0BEkeGDCa5Y3hUaBQ8ZapV1Fv/cEj2rKEcOq/vj81IO4l8UFnGA?=
 =?us-ascii?Q?F3Pq76MVpcQvyRkEMiHWT/BPgnwfMDwmL3PDtwPu9+HCT3y/5jiP/wo9swhO?=
 =?us-ascii?Q?zO77LxdltMbwGssECyGMh/4fWu+BuJGBF6gH48vrRMvqCqcpJjgg39kzH9mx?=
 =?us-ascii?Q?9xUwkR9YcCabWJ0pRKxwS02iNyPssqaCtJkFrxb87hDqiDdv/js605wkYDVY?=
 =?us-ascii?Q?+IE62lq/7QWAxF0yFKSNoRpXqJg9sMDj2X54LfGZ3bkHuwLU6A54gPFov5Pe?=
 =?us-ascii?Q?Q0FjDAp/KwmdLITwrf2n9e1LxXBeZ4qDw8QdHmN9TiGbTGGR2KaC8fAojMjJ?=
 =?us-ascii?Q?7DIYC2TFMiYTIAj68J0YtfC70By7A9zNmY83SoK9xMAH4Zynjx5wc7l36cru?=
 =?us-ascii?Q?S1bjbPvgsZ7OxYxgD6Rwd1nqeqfMVjjiaP2peoaoTVakI5p9liPwvovF2fYT?=
 =?us-ascii?Q?Rw/nQakZLXJQcuCrfkVYNy4FRK3Z7cM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4Cnk+B3Uy2tziYZJmULXARRJEPxww0gpOHu/IS1lGMzEXtvXOjwzV2QlWNmg57d9fjPo+qhrZO72VhWh3439lZbxN1B3UaZbYgLZFCqZzWrCG+q8UcDWkX8mpf0pTCMejIj3DeYKJp2Km9lJ9oKTRa43QGKV5ocUcxIE5gEm4HE+G9UhqiIl0fejpOoQVO1yKuihPbopCovV8DjBnpDtwn3Z0mMvXneiN2g5cyedc/dsiBukNXoWtCvb4T9g0uOpr5CMx+xaXi+it2B8WvQ+/t6FXmqfHjFZsvL4YUifxTOaZr3cM4zMkpo43b0Yl+YseRVUYtCctZTxqVYD4eUkVA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b93a6de0-914f-44a3-fe3b-08df22cb3d44
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:27:21.1142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kQv6y1/MIp7oC0SFhVaRxUDAAacYy/8NgzQCeACT8rxNt8q4pY+OxLI1GDofk/MJN/35adfsg9yvPRRWPNCj2ZdmU8k2uIjdHEhCXKmUWfY=
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
> Subject: [PATCH iwl-net 08/10] ice: detect a PF reset that does not
> complete
>=20
> ice_pf_reset() polls PFGEN_CTRL.PFSWR for up to
> ICE_GLOBAL_CFG_LOCK_TIMEOUT + ICE_PF_RESET_WAIT_COUNT iterations, but
> the timeout check after the loop still compares the counter with
> ICE_PF_RESET_WAIT_COUNT alone. When the reset never completes the loop
> ends with cnt =3D=3D 5300, the check does not match and the function
> returns success with PFSWR still set. A reset that completes just when
> the counter reaches ICE_PF_RESET_WAIT_COUNT is reported as a failure
> instead.
>=20
> Check the PFSWR bit read last instead of the loop counter, the same
> way i40e_pf_reset() does after its poll loop.
>=20
> Fixes: c9a12d6d2091 ("ice: Increase timeout after PFR")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c
> b/drivers/net/ethernet/intel/ice/ice_common.c
> index 04633103e3e610..0ffd6b5b81239e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -1291,7 +1291,7 @@ static int ice_pf_reset(struct ice_hw *hw)
>  		mdelay(1);
>  	}
>=20
> -	if (cnt =3D=3D ICE_PF_RESET_WAIT_COUNT) {
> +	if (reg & PFGEN_CTRL_PFSWR_M) {
>  		ice_debug(hw, ICE_DBG_INIT, "PF reset polling failed to
> complete.\n");
>  		return -EIO;
>  	}
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

