Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970B94756A3;
	Mon,  5 Oct 2026 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195928; cv=fail; b=f4Am0brZiEE5E/M6cTg1xbgGh3bVFSG4TA2+ODqDKYqBfKtIQ/2WpWA49hihZlCUGZ5198+nI5f0hzNhmqvKX38ivE8a/DthOiovIlNsbH23+OxBDRdyiEkKx19dyI5uwmG4EXrLzD2+qtl5ue9EpmQ3ve+Bj0xSDT+30yoapX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195928; c=relaxed/simple;
	bh=ex1sy6lHMeXja97MdIvJ8UBHZZXzTtYEL9QlwpWkeYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CHmMsYjWuDQCfO3iVP/uLZ+K2+3YnLwhIxdUPbfL9DUaOjvfM8wKb+fsYH6Rn2FucftOe3U99kuqCsgrSxWiphZ4MK8rH8UI1kwGrnBqzINrcBxZIv3HrliItQxp7tbD3PmOq/N71Y51bPujfHTnkCh4MmCMWlltY54P3sbFBf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FxOlJwNb; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FxOlJwNb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791195926; x=1822731926;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ex1sy6lHMeXja97MdIvJ8UBHZZXzTtYEL9QlwpWkeYQ=;
  b=FxOlJwNbIJXB1Ok5bX3F9Fj6W3YXRtWyA7egNa6EDAoNCOw0mDZXkujS
   dYILnkF8RCkZtmXmhBX16dxxgIxZmDkdS1fe/WHTWDNY80Qiaym7xrtu0
   V9bBx8A1Q8WdpxME6T4F1I2thyhIAyVEFV8DI3Hhvx8Fk/glqUqONCqgm
   lGCsCXnrI44u3N11dtfQeplPDfblua0uPHGrSMB1vLHhmN9aVl9aK+hed
   rINd5tLLapkawDWsvWATegCR315db5AdcxrgDmq6bO411hFAB+0G/HKIl
   3Mo2jhd6RRAKTPY9UR4y/nJnWoTeL7ohPHMMxT/hYpgYGhkH3eap8pS91
   Q==;
X-CSE-ConnectionGUID: DtzJ2mrXRriW0t5ZAeZ+tg==
X-CSE-MsgGUID: zL4c8brpRkquZP7zVhL7LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="90920792"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="90920792"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:25:25 -0700
X-CSE-ConnectionGUID: kkisrScOSPuDytGiDxGR0A==
X-CSE-MsgGUID: O8aGLj2DTFGW3vafTP3/gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="863928"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:25:24 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:25:24 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:25:24 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.61) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:25:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oZFJyqDeJFfGG9vXio1uCvZC1AzDJ8S6Luzo/U0Cnvd1Cdbu6w6/sYty77HJQbpkUUImmmz5nCMQwqWEoWHR3HCBz7ZIckqw1L7aIAAM/cp4oNx3hgp2CeryjRPwAztGD45FMtj2A5vsqN80Jqt+BKmunb9af7IUKNGNRQqm05Msdfi7BdAszWPbiMvMCgstAJdos3GGujemES9KLdBOW3i4l+NJJMTx1TeWSzdLWb62/yBhEw+LXW4j1TyTWYsgS/g1Htf5Eokmwk5E3PYSN8zWwLjpdQ9p/IuZHe5nEMmd5lIqiBWPuxfjIxzPfLjV1yjL2UlTkH4CFgVwPZvhAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XP69wW8hyBYFcOO7DZTDO4wcVewp9COcSnTI4s0ewZY=;
 b=SUwIwtY0tUn+zpQhNTZzEol8pCgRf4KsqvOHsse1lQq7jRlo+hlGyEDycka+hSxFsevcELRlKxq1Viv71BCRXGPZ8VChW6r6BmEQCcWk/1bbZ3lbPHpEJrvDXDWx3MSA/kr6j6K47CXQypGkRzUKFIk98uUEGiiT5iOTew13Qo4HdfPnW+7X9y8U7wcyDJoWTTMkuDqcnIkY8qbag9nMwJqNrgkaPAEDZDQrwngvs1nSjETZOP9FTf/Fcr4Ho0v18cuFmpSBVf9di5PeqMjBOmqrK0ylNAMFfKhblkituxwe78HWjTEspRSpDXwlZZTdPUaK5YROj5MTmrSSGdAzrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 10:25:20 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:25:20 +0000
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
Subject: RE: [PATCH iwl-net 04/10] ice: restore the default XPS map after a
 netdev TC change
Thread-Topic: [PATCH iwl-net 04/10] ice: restore the default XPS map after a
 netdev TC change
Thread-Index: AQHdUm813uOd1HWIf0yBeB9nUTFQkbbuwrkg
Date: Mon, 5 Oct 2026 10:25:20 +0000
Message-ID: <IA3PR11MB8986FB61889C420E3DC5D0A5E5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-5-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-5-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: e02bde87-e971-4b70-a7fd-08df22caf574
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|38070700021|56012099006|11063799006|10067099003|21046099003|6133799003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: NCa7e1AVuarFcQMomP3PNq9lVR7CnmaU/qaDZPn1m1nOWfXgebXzAO/JvU4UNAC4yse2QU2T3mlpmXwQl5P+ffAq4t3aDSBDpgAgvlav9bRJ+ltyOFeIWSsH0lZ565lx+fL6LnF+RyVPWCq6pu0V2cctpaOqGme2ZRbn2gDfsMO95WsytRmo8WM9Kz/QEbbclD1z0sUOGJly/f8BFLm/LvJlQ9vnNuD4U3W/W9KkGC0ZezIW37navz0fXR2J02JtKDtFnWsJLIvA3t8m8x/9eaFwpsjIkdET/pjF5qfDSQyB1aHYuY62M+MpilF8a5EQFQ7Gj9mvmleFEkHhX4d02EFVH8QPs27TadUBVgdqhnUn6xIArOJ1tMIkrwqjy8z4zbKyTb3xpwOhndu+7utLMWHfXTm3A+L24iNXTTh5KHQ+/oSmtP3WCGZqezL5Mai65OyvokcwJVnuRaX+Yug+W+1FTc0Ail0E+QAmsqG+HzLaaJi8F/mVPg/HKw80T/z79SuqzJyB5RPkx8eZsD0shg1ux9Lwy/fuee6nk4fwwsAy0oT5nTrkyJUNQL3XRoYcmSInPrNub2zC2zgBDwqjzePJRy7EGOy3dsolvwZGrYLhP2fj6VXGbPWoyYLPL/1aYydmn0AlNxr/OMG4dmkyyINfGxfphs/apE3z+YwBHiY8LK3ZdPefB/4gp7hcXb63FWtdMvrBr9AmfkgFrI8kHJKeCnvzOCf9wMdhGJ1hZZI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(38070700021)(56012099006)(11063799006)(10067099003)(21046099003)(6133799003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AnrXJFWmUBFWBI1nq9JUtD3ZaizEsqYdx9DxOKf0as4JKI6Cg1M/Hz9CJTew?=
 =?us-ascii?Q?jbdYmv6/bq5sdBVeFfYVd7EGIXpizOgKJYAsr+JoAjaeliCuXKrOOfjTK6bQ?=
 =?us-ascii?Q?78vp9uQ/SsqkJvNggQx29zYQIxNGZCzjep0T4x7WyZBEIhSEJiCopo+kpYIC?=
 =?us-ascii?Q?LfXQR388QGbE5x6mXVdaWBFK+F03N6OuZTvakXXqxjiSW+RjHxJCfcarrtBV?=
 =?us-ascii?Q?WbQjuTXSQp9j/MiJQOU6kXKAQrz/GS43XWSPKrvRnph87KAGOYpMNPdY7rBb?=
 =?us-ascii?Q?tgEvoUYwvSIzZQ80wVPGZz29ttXRe5xuHxSq9+NfbBPrD22x+ARlQV+4/6MK?=
 =?us-ascii?Q?jM0VgwfZuB8mCNcV8fpZ0o6Oars/8diZ/iJsp8/AGO/YLTKOziXdH+PE/3sS?=
 =?us-ascii?Q?yWXxiXXnFZWWD1QsD03IMXdcL7pWBiKso9QWKBTyA3toSzHstZP6gFSqf8Tm?=
 =?us-ascii?Q?SWWWhQwxVKac8hE+iEHsDkBsfVBHzURSkwab13LjydwQn7zXBIgELFQGjaMF?=
 =?us-ascii?Q?WFucSQg9gFO63v0OaGZGP4wA+MFoStXPtWEPgYtVObXhiFOLloRXGDdqbh8y?=
 =?us-ascii?Q?N7XPd7Q0NI1w4vUFxVbhE8x+FP1VjLBVPi9hB1Ir8vYNnNAABXq76OfvuvHi?=
 =?us-ascii?Q?xruGmrrrL7tkio/tkz2ZDJWlDia8H00h/xf/DtiCNmT4IerSh+rp0yG1T7E4?=
 =?us-ascii?Q?lVZvOV0jdh2KCP6yab+ewss0xgHMxVs0ozwRBntE911WUAmJK9dDyvTFxezI?=
 =?us-ascii?Q?QAxp1XtBD/MUb9qYmMaVGGGwis1x+xGH/vp6EHJU7tNcfpGBXh+i6ngC3P0P?=
 =?us-ascii?Q?2D9LWPJk+dcmutUqoJommdD9WrjllcckERPjsJ5ceDTHq+6E1ZGQbSryNTk/?=
 =?us-ascii?Q?fhGW3fLjh97CRwHUH78xFadSTNJUTobRSNzD6a3uktQyu+bWLvTXPakFV7fr?=
 =?us-ascii?Q?MfBAzU7rke6qJD+cewHHPmAYd/UoN71tG7sZuc/30bHeMrxls9LnfuJFZYVy?=
 =?us-ascii?Q?FHJ0eEXSGHZkSY4CKd7hijhZk0WQMm6tCCNRKlRQfiHzE5hhnUF/EIlmrqEO?=
 =?us-ascii?Q?tuG2H2h4Kcw5+7dxpMaED/49WZrNjx3FTv591ylukkDzb2BnhkxqpOnFekYz?=
 =?us-ascii?Q?LVPwXANkhK3gKpVBpvw25Bz1HEXDhI3x0p4h+itskDkJ7RBk9eXj8snuluNB?=
 =?us-ascii?Q?MkAbO55pnd79GGYAccdPV63lX0X+Y1cxuT3LuibYvf9OkLQ8papueO7rCMNX?=
 =?us-ascii?Q?5z+7d0HIDQNNQenP7nVJDeBhpgtjGiEfatuBm/l0fpfxnig0eOMlKiiR83wK?=
 =?us-ascii?Q?lkwSe9ooYE3iBJkQN5CNZRif2Ftza/S/90SGtouC3/Ut8vNOoN/nKLMoXwPY?=
 =?us-ascii?Q?7O+cG0CyU65mFA0+lq6DeWgQmiH9YDoFvWOR+3N5HOYiyT4ZNmJl/Mr2eVo0?=
 =?us-ascii?Q?TcQCrrB7TzR18c7uG/iBNi83T4OnNZpoqDhwmD5SBU1v1Z1e4+fdsAfmldPB?=
 =?us-ascii?Q?os04dVb5rbRra/xaJD7TMIsVzJ+FIaq5r4GH5PkY4u/10JlM421Y/WFr0smu?=
 =?us-ascii?Q?aYo+/3TPp0lhy/5FiwrExLnQpb0wAEGTRa4+U7GpZrkCKhKbjGaa5PLzEc8f?=
 =?us-ascii?Q?FP6F47oaty6LQZ9ZBxdcw+G7+3Ok8DyyVpqfnnyts0nCG/WOHuoWQINSz3by?=
 =?us-ascii?Q?FQCDAjxwzSMYjrvTDtQLCGfzzX7MVvOtnK5mOxUC+sshFrzLYf3zIej++WKd?=
 =?us-ascii?Q?lv3DrhqHO43USWE9O/4M85UG1AroAxQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: F5vuHtglBKgL20SKN8IFLJdFoBbHTM7ukFmyEZrfN3AvT7szCxO7tdNr59bBZ6uufgjGVvCToYXKpAlXS1NUIlY64vG5yzAaqm9uFIVT3HvI9CzBJu74pGjrr+3jn3CJMhr9qqpc0T0D32EmkzKNG9XnTqaEmI949QmFVRKanQBqlsFQ7gi/49hKxMG0gK2EessgImRYmpxY7n9xB6zVSKHvUZExNxD6U6izOT4sX9Fr354e/Jp+/rUF5fQ5czmsziOWCfieisHTpSA16DS8eQgzdsiuPlv6GduSxIzylhnt30FIVW3YE0p9XlerzvY+kmWOsShvDemTtHCAtK4qKg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e02bde87-e971-4b70-a7fd-08df22caf574
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:25:20.6004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: laU5snzMoY28jqIKV0olcUZprkQ7gqg9f2x5pF/5TcYh+4IKo9gPLWeawv3eNHSid6NIR+2sSbz3Dh+bT63i6CbcVFgnbc+txuRToaSCqLE=
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
> Subject: [PATCH iwl-net 04/10] ice: restore the default XPS map after
> a netdev TC change
>=20
> ice_cfg_xps_tx_ring() programs the default XPS map only once per ring,
> guarded by ICE_TX_XPS_INIT_DONE. netdev_reset_tc() and
> netdev_set_num_tc() drop all XPS maps of the device, but the bit is
> never cleared, so the default map is not programmed again.
>=20
> Since commit 122045ca7704 ("ice: config netdev tc before setting
> queues
> number") ice_vsi_open() calls ice_vsi_cfg_netdev_tc() after the Tx
> queues have been configured, so the map is wiped right after it was
> written on every open and stays empty:
>=20
>   # cat /sys/class/net/enp4s0f0np0/queues/tx-*/xps_cpus
>   0000
>   0000
>   ...
>=20
> A DCB reconfiguration ends the same way through ice_vsi_cfg_tc().
>=20
> Clear ICE_TX_XPS_INIT_DONE in ice_vsi_cfg_netdev_tc(), which resets
> the netdev TC state, and configure the netdev TCs in ice_vsi_open()
> before the Tx queues so the default map is applied after the reset,
> not before it.
>=20
> i40e fixed the same stale bit in commit 82e0572b2302 ("i40e: Fix not
> setting default xps_cpus after reset").
>=20
> Fixes: 122045ca7704 ("ice: config netdev tc before setting queues
> number")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 6 ++++++
> drivers/net/ethernet/intel/ice/ice_main.c | 6 +++---
>  2 files changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c
> b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 5e183314e0d792..416e2d6a6f1709 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -3218,6 +3218,12 @@ void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi,
> u8 ena_tc)
>  	if (vsi->type =3D=3D ICE_VSI_CHNL)
>  		return;
>=20
> +	if (vsi->tx_rings)
> +		ice_for_each_txq(vsi, i)
> +			if (vsi->tx_rings[i])
> +				clear_bit(ICE_TX_XPS_INIT_DONE,
> +					  vsi->tx_rings[i]->xps_state);
> +
>  	if (!ena_tc) {
>  		netdev_reset_tc(netdev);
>  		return;
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index e62a8f544345a3..8a21f87eb6ca21 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -7559,6 +7559,9 @@ int ice_vsi_open(struct ice_vsi *vsi)
>  	if (err)
>  		goto err_setup_rx;
>=20
> +	if (bitmap_empty(pf->txtime_txqs, pf->max_pf_txqs))
> +		ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
> +
>  	err =3D ice_vsi_cfg_lan(vsi);
>  	if (err)
>  		goto err_stop_tx;
> @@ -7569,9 +7572,6 @@ int ice_vsi_open(struct ice_vsi *vsi)
>  	if (err)
>  		goto err_stop_tx;
>=20
> -	if (bitmap_empty(pf->txtime_txqs, pf->max_pf_txqs))
> -		ice_vsi_cfg_netdev_tc(vsi, vsi->tc_cfg.ena_tc);
> -
>  	if (vsi->type =3D=3D ICE_VSI_PF || vsi->type =3D=3D ICE_VSI_SF) {
>  		/* Notify the stack of the actual queue counts. */
>  		err =3D netif_set_real_num_tx_queues(vsi->netdev, vsi-
> >num_txq);
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
