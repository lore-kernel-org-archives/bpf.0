Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79884749E1;
	Mon,  5 Oct 2026 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196050; cv=fail; b=YoohuswwNDfWs7cD1ZquZ7D29N+5KM0zTGe/VL9nIzOls2YgJV1CRvuYMGzZVM5I7Y+uAFEBMqr70a/pDVjeeFV4BApay1633s6+hZqDBLIVqPJ7Q6wPHuuIUDpt/cXjIk5N6UtOpuqtdwUft7fKS5qFKUEY7hrMT+wX4htOb44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196050; c=relaxed/simple;
	bh=uWp8SLHw/jLkcARPqGmTEFbxk6Uiu3KZlIreuGNPNSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=byJrW/by5K7W+e9KmnPEwNj5ISYBq9G9qPHNqHK8edBNIK1oD2viNT55C1vf8RIhmZJbcshFdTdQZBwzXCzEeow5qlXAGCK/I3AZWRsaDiXEhoxU8Uz49CocVDUv20xzBqtzOouR/xSXqv5jS7On44BpzY6j95zOvo8YXGQRfaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XrsKfsQE; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XrsKfsQE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791196049; x=1822732049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uWp8SLHw/jLkcARPqGmTEFbxk6Uiu3KZlIreuGNPNSE=;
  b=XrsKfsQE0SpmFy/GCLmlP8JF8j4HS8G9RGZnNGb1uL9+baEQr+wdYZCr
   5MdY65vUg2gaY5N62ayBOP5JTNNhAjeNJeYAR7jrnd3BaVVt8pTdbrt+k
   GCNd+uN54rFxVVn+XvGz1Ob5bWCLAiBmAktFQ62Zb456TyvGdiXpsymZ8
   tZH+OdBRJ2yClE/tT4zKKONLXZitspeqNYKvLVfQdUFnaf+OjIQEjUhSR
   IwI3F8MHUQYMOEorjkWJitZspSR0faPzpnfUXM1cyvNDWUOrHJjyHLEQ2
   f5S4fCLafq2cYwm1J3Yz6RXykDJr1QhgyWq6/0d9Q3f3n/xMSyEj8CqiO
   A==;
X-CSE-ConnectionGUID: u5b+Fo+QSQ2p7g4ZE4oaZw==
X-CSE-MsgGUID: Ekvw6MqtSSmvf82S1r517w==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="90920918"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="90920918"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:27:28 -0700
X-CSE-ConnectionGUID: +JhtXoDBQ8SrYoD4pnlNnw==
X-CSE-MsgGUID: Jl7IpnkkS966l8Zp1vLyDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="864113"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:27:27 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:27:26 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:27:26 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.71) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:27:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rngxXBtwlK8tdO31XpDpl+6hadbb8KOPZu4KaDuwmrfSf6QYgW9YFQY35s+kAvEJ7i4A7ic79WmCe2Ez/XL9dlwY7eMB1w3H0a9RY9/7OlN/1UREZbOdWjH8Pr0FeQsupsb0LIsr+VhI0bHrLnXW2lKdi9dnFv71wtq9cqgMci9v5lGqujEXbEY1+DNyW2xCIQMGjMSxW/zXNdpIjNUv21D6Ryt5hqwxgTnVW+ZIyHXxSXQe/NvYomzZ7hSaAkHelUN6oPSnMBxX6AkHBO2ikgLjBEXNMpsSLIhPRpyAxbtz2lbYoqWNnRiMeT6WR92HPW1ABvVgLxDrSfQ83JQ6QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYc6CGfJGrnp9raoIlQoQQM2RWgAuSeo90ot0b422hA=;
 b=u+BMxRL047zsU9Xlx62SSTNibj57XgfCPYQsirvoQLIerQ8ji2Ei0v3E1O1XEpX6NjUkks8Rm7jgcmYeGyQzgEBkTyFWjaZsX7aS3uxQzJUAku/eYWjOV7ImhI30JtO45LLJJAcvHsPDuIF54htFgiWuLfmnNRO36jYyoKsDselvrH0cE7/wHcTmIxO2U9NxEIe9WylurJlRY564x9j+YKb8/4WGA7eM43d8IQEXzAcO6OS8xpcJIxRoC1jzVofmu4B2uqCttmDMMLP5IQX8VUfQi9IdM8WZ80BQ71U4Ke8OTppYcq6iMLrCq3HhtxepaRP/zWy4vwyC8kJbUvipKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 10:27:13 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:27:13 +0000
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
Subject: RE: [PATCH iwl-net 07/10] ice: take the switch rule AQ error from the
 response descriptor
Thread-Topic: [PATCH iwl-net 07/10] ice: take the switch rule AQ error from
 the response descriptor
Thread-Index: AQHdUm8/PiOVutH9rUG0cYXhjNCKW7buwzNg
Date: Mon, 5 Oct 2026 10:27:13 +0000
Message-ID: <IA3PR11MB898677B41368353C43AD77C7E5962@IA3PR11MB8986.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: b65277e0-3722-427d-f7e1-08df22cb38a3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|38070700021|56012099006|11063799006|10067099003|21046099003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: kt2pB9dkrvlebPmdOHuj+ayWYy90lOZPaR7kZHipO7sNqNT2LleiEZ20QkoxLs/AKxiowIBrxfPzK6sFFTmzprXZViboN/5WbOvkObIrC0SEztga3+VEO6FZixEPl+8dgz4GyKpgmXXxzrCRT9Yfbee1pX1arDnKNOztkxt3rE8hP+5aOvPSDizzv9FFqmc2UKiAkqnRHlRZ7Hsf67rEU8jz9s/R0X2NspZFpAYP/sx8AmJSeYiw4GgTdgrldlCsd0xQ3d67FC23xciw1lzhobALt3b+jr7Z3fkEmmoQqpV7OY7i6AQgc0n5+OE6OAhGR4P0McTPN7oyi72R2IiUeb9hUU9R+KDc7Y7GHIKynZkDiDWDcHwj1tXHB58pnSzH1mtTS9waRYuEpdcd/e+ryxsHnBRVT0+RZSopkzuR4JeXhqKzSyDIvokLE0VAtaozL1uh5YOVdPeyJFuCT3IsLt0HAYFHuJwSwfP2rcNwNDZ2y41PjIxZsOLsmL0tWyY6y4zf59cko/+37SZXlD8ntj11oo6tzUw7V0rQQEpFED3To5H6NJggVin1wTnXnojz0EENPdyrh8Y3Z+1DkPXQwQw88oFO3Ni0R3yOxhv1lOR/MbHCTaq0MP2tphyXbBZBt+Wqt9LrG2gpt/ZrwZ+DYTfATvLTTm1mCFp9ITqQRgZR5jy7DN4YFZ+ruC93zUMgHgFBv/F7SGMwbYJSKfg13dmGIBrpJuE5RFFyzgMvq5g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(38070700021)(56012099006)(11063799006)(10067099003)(21046099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O0e5apEQckEfZz6qNlfeoPvXri7v9mNJdiTIF1ypIBQ3FrIM33e9DiYi+rkM?=
 =?us-ascii?Q?EOt+kpIL0Z1y7fq3vci7ObRagpe6WBTl786wvxQcKQ8sIoOWotHnxlqHcSR5?=
 =?us-ascii?Q?9lkNNJxoRBlFdnppzCW+9XlakW6YQ1Z72d6yey7MMq+geuRtfmFkG110Aeoq?=
 =?us-ascii?Q?8uVNpRJHOg/ULgGJFwla2WwHma84rcDEqSr+2EyxDZek2pJlOixaoVCNkIoZ?=
 =?us-ascii?Q?xk2lZjVX1cZUTXS1dQ6QA73KFsMYa0eAuVu316u07AoAUU+7VnzX4ScPEcEN?=
 =?us-ascii?Q?X2JiP8Da6X4sV8REdiAmv5Gwfy/WcIkLnevGABMFGs6FBXeK7LPJIxfiulJ1?=
 =?us-ascii?Q?qJq2XO29ewh5If/5EPDDQsF/HAT4NgKXq0Tsc0kNA+YYqj8rVxPYgoTcPX09?=
 =?us-ascii?Q?hekAzqgquYX6GC5ojl7u29T3aFnxVokc3cGkPIgQvehWZgxLQNp9Aw1MFLEU?=
 =?us-ascii?Q?nODspcntN2P6EBpl908pAg6tUZYKVSZ5MlIPwsynka1tEbwWx6vlpW4uHOWk?=
 =?us-ascii?Q?E8UDnk73YDCHAvfw9mak+MYGzio3MaP9dhirN7IKD7AuqwlIekmbnK4JgT7E?=
 =?us-ascii?Q?wcBme5Q6/ornGqA7hZflWeDR1XDg3+jwhMODu0EUSGVT7b/dBlHl+jMTPfZH?=
 =?us-ascii?Q?kjA4Q+vDsY8jid40qUoLRQJzLTtfL5ez+pkSQr9EnrVFm+hVNOAMCP1SxYOf?=
 =?us-ascii?Q?tK0A0YHdt8WSl6J/uA7AgdE/mswgB1IYJsPzmzwGeAcOavsSdRYUf5IRYoCG?=
 =?us-ascii?Q?qGisLqRW9b0d0O5fo5FxCfps0DxtIKxZElkJcRf115rKGz7ynHfzNiv96O5W?=
 =?us-ascii?Q?/gfC05yy/rUl8p/PkmPC52zDipyzQZFxxnqXANj2FONRmJ525zNbYZx4ZI/L?=
 =?us-ascii?Q?7vzp4IPtV1DASTSMsO69+2YC9vIRbnILrVkQr2if1tlbhL6KnrUCxEVOH05G?=
 =?us-ascii?Q?zDUgupjrhfFAzgQwuH4lLPG23n8K2xTNYQ4IB0ob9oGp+cUfel1MHjdwzIMs?=
 =?us-ascii?Q?sUs7B1JFHOT8tJs2Eo7xpF43CFYwP5SN+qUxTTVi7+zpN+exLvyhn/6yxAbe?=
 =?us-ascii?Q?Fj5xTDVO/+56E9OybGrjmcC60yJu43VBq2kunG+JRYnLVyXaB1BGAE6tVtAC?=
 =?us-ascii?Q?BZBIc9NFySJPMsMCoT5QNbI+Vq3IlE9S5q+TF1BU15Es8zRaCts2tUaEXRjj?=
 =?us-ascii?Q?3BrYiUqrHvuD6T26jyF9DNRh7/iAUfpADM4R2BJpkp0TKwTsFlBQZtcFAwJZ?=
 =?us-ascii?Q?BDNcdaUYKu6NI8yJi6K7Cd1Q+FLKWR2uInLGTIy+0fT6qAmSnC7WXtId/Act?=
 =?us-ascii?Q?e10MiXn74jyNem8PAEKZ/od/qcSq04iiQmj2MKDnDOfm7n1jg/AZsvzqG7KU?=
 =?us-ascii?Q?SCc3tjTdGiE+UtfU8VgDgAvePcGOjJZXmypUDQ76U6aPWNEBEOZN1jxQ6Nzy?=
 =?us-ascii?Q?hAw+f0BEVliRLub/8P+blQBP+J1/2Pr8iT1pKbkIdTsXkZGCh6U8ygElEXYV?=
 =?us-ascii?Q?pdNjxn0wb8ucZNrB4/K/QEJKNfbXcC0RUj5tpUxDbfZ4qOcMdM6mEN1Jcd40?=
 =?us-ascii?Q?hBuroeanAsFRPLvdgJm0EFLhd01svy5GyEBUwpS2IW7ej7T8bSqjfGofkp1m?=
 =?us-ascii?Q?3PsibsMXDQBVHr5zrevImKVGyhZODrG6YxH4gSo7tFOdzwp+UHGLJ82rdy9q?=
 =?us-ascii?Q?Lo7uYT6MDJjF6tHrXNjahJZPIKF6ariz8BMe+fESE0nd9WgnrH264EHPFi1K?=
 =?us-ascii?Q?m6dv+NTF/okQBNJM2848nlI08yphpPE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fu1IoQdNuYSjHvmq9e2nFpXpYk8Cw48bDkXZz1uNQUW288ZTLgUTiB9bJQ1wFAFQBoOBE0AsT1JWnaUL6jGSYZvKf8vo7jeCJ/zwz+qor8QiLEJ9hv3uJUOIQmOjF0s45ucEjDKzZAcD5I5LDOcoAbFSAvHMBZW9VJ+d+/p+JfHRr3VqVzDMOoeWPa8gtgO4yHjmv6vxguNvQDNFzyBpm+QnC82H8PvDYmsbWOW9mkfgeDbPjQG3SYwa2fqqRm7IJ/3tIsZCelZJQK24UDHxIZQFL6vNuZnBt1qgOHRM2kmqxDA0hhjBUrwml/3Fi+rdIc1THPDwzIy77ASQ9Hdt3A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65277e0-3722-427d-f7e1-08df22cb38a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:27:13.3668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hL1ny6mUWllIhhXRw+HK6hYmSRFPluNeqb7LhOKGdc04HIa2XrwqsdPDUwl6cblI9rQZux0bsn25xc1emKtXjfYe7taXx8cgNfvcZKUtG88=
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
> Subject: [PATCH iwl-net 07/10] ice: take the switch rule AQ error from
> the response descriptor
>=20
> ice_aq_sw_rules() decides whether a rule removal failed with ENOENT by
> reading hw->adminq.sq_last_status after ice_aq_send_cmd() returned.
> That field is shared by every admin queue user and is only stable
> while the send queue lock is held. Another AQ command completing in
> between can overwrite it, so a failed removal is reported as a generic
> error, and a successful one can even be turned into -ENOENT, because
> the check is not limited to the failure case. A caller that sees -
> ENOENT keeps its rule bookkeeping while the rule is gone from the
> hardware.
>=20
> ice_vsi_sync_fltr() has the same problem with ENOSPC. It checks
> sq_last_status only after it has freed the list of filters it tried to
> add. Every entry is a separate devres allocation, so freeing a list of
> thousands of entries takes seconds, and by then the value usually
> belongs to a different command, so the MAC filter overflow handling is
> never entered. With debug prints of the error and sq_last_status added
> to both places:
>=20
>   ice_aq_sw_rules: opc 0x2a0 status -5 aq 16
>   ice 0000:04:00.0 enp4s0f0np0: Failed to add MAC filters err -5 aq 0
>=20
> Use the retval of the descriptor that ice_aq_send_cmd() copies back,
> only when the command failed, translate ENOSPC on add to -ENOSPC and
> let ice_vsi_sync_fltr() check the return code instead of
> sq_last_status.
>=20
> i40e fixed the same kind of race in commit 53a9e346e159 ("i40e: Fix
> race condition while adding/deleting MAC/VLAN filters").
>=20
> Fixes: ca1fdb885e5f ("ice: return correct error code from
> ice_aq_sw_rules")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c   |  4 +---
>  drivers/net/ethernet/intel/ice/ice_switch.c | 13 ++++++++++---
>  2 files changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index 8a21f87eb6ca21..ceb9fec2af21e7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -396,8 +396,6 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
>  	struct device *dev =3D ice_pf_to_dev(vsi->back);
>  	struct net_device *netdev =3D vsi->netdev;
>  	bool promisc_forced_on =3D false;
> -	struct ice_pf *pf =3D vsi->back;
> -	struct ice_hw *hw =3D &pf->hw;
>  	u32 changed_flags =3D 0;
>  	int err;
>=20
> @@ -450,7 +448,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
>  		 * should go into promiscuous mode. There should be some
>  		 * space reserved for promiscuous filters.
>  		 */
> -		if (hw->adminq.sq_last_status =3D=3D LIBIE_AQ_RC_ENOSPC &&
> +		if (err =3D=3D -ENOSPC &&
>  		    !test_and_set_bit(ICE_FLTR_OVERFLOW_PROMISC,
>  				      vsi->state)) {
>  			promisc_forced_on =3D true;
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c
> b/drivers/net/ethernet/intel/ice/ice_switch.c
> index 239d4d9633baa6..ae96a2003d5c5e 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -1959,9 +1959,16 @@ ice_aq_sw_rules(struct ice_hw *hw, void
> *rule_list, u16 rule_list_sz,
>  	desc.flags |=3D cpu_to_le16(LIBIE_AQ_FLAG_RD);
>  	cmd->num_rules_fltr_entry_index =3D cpu_to_le16(num_rules);
>  	status =3D ice_aq_send_cmd(hw, &desc, rule_list, rule_list_sz,
> cd);
> -	if (opc !=3D ice_aqc_opc_add_sw_rules &&
> -	    hw->adminq.sq_last_status =3D=3D LIBIE_AQ_RC_ENOENT)
> -		status =3D -ENOENT;
> +	if (status) {
> +		enum libie_aq_err aq_err =3D le16_to_cpu(desc.retval) &
> 0xff;
> +
> +		if (opc !=3D ice_aqc_opc_add_sw_rules &&
> +		    aq_err =3D=3D LIBIE_AQ_RC_ENOENT)
> +			status =3D -ENOENT;
> +		else if (opc =3D=3D ice_aqc_opc_add_sw_rules &&
> +			 aq_err =3D=3D LIBIE_AQ_RC_ENOSPC)
> +			status =3D -ENOSPC;
> +	}
>=20
>  	if (!status) {
>  		if (opc =3D=3D ice_aqc_opc_add_sw_rules)
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
