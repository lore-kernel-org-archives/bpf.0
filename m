Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C5E476074;
	Mon,  5 Oct 2026 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196066; cv=fail; b=EzjdkazdlIiXezMHRvt0W1q1pSkCFPUSal7nC604GX2FA7y6q+mHyFGnIQk+rlnJAOLFKFLC0P/Ip1GBM91kpIVG/4Su0HlN8OchY/Bt+OeFdLI23RVov+jNl4dp2URAjimAr/Z0wjyR4XReFM5iWM6FhEuYouVI3CvY+KpOuEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196066; c=relaxed/simple;
	bh=ulub+AnKdpUW9KS8GFRRsCL7K1L41ha7HWsn0oWlLco=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zol1jkl9EOAVJZhya0GOH4IerePHERuRD2okg5G8Dc74YFPPe7JxJ5OxVxMhUi64BmAr8sYaSZN6wRoA5UP+pG6AUueBhHkLGXd2YRxCnBqytnsSuiCudTKI7cheW2JyNBNh0bB8KdL5HjGFMH5VuPJspwOoqa5DXN3DjgkV1EE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcGDEKaa; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcGDEKaa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791196065; x=1822732065;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ulub+AnKdpUW9KS8GFRRsCL7K1L41ha7HWsn0oWlLco=;
  b=QcGDEKaa+eW14OXuVcZn/2K0ivZtt5GWlWuv/7vgQ4xp5yIy2K0XR19H
   400VQ9P/iSmTEwR+53D+MANWnj919FbOQSsjpoDbpdfNI5tnMr8OmRTu6
   OXv4JX11PkkTD/s6tvQ6jUTKQO7cyd0H1VKhJf4cT1bniqXRoYX4oSwK4
   YdRDI8bpFt1PKEXUZqQHrEV7a1Tz0w/bE437MTRVR7XKXcHG77YDInZ3Y
   EWHMXRkvPN6lVqYP7N5ryDDBlCox2y8v8PmoRtSMbp8qA9YpvIuhl6Gwq
   r0J4kGwrgJiPORZ2Pt3+48hGb4wbyekJQxdMqTIYVrDHA9ghsxkX4CiXT
   w==;
X-CSE-ConnectionGUID: S3ynyK1yS16dJ+eAbQYyUQ==
X-CSE-MsgGUID: 0v86KJz/RpK9Ris4RfVmrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="102024663"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="102024663"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:27:45 -0700
X-CSE-ConnectionGUID: OFldWsU/QMio7sVMH9hWrw==
X-CSE-MsgGUID: Dg6qb7RkT5m3GawAzbUyaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="280054138"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:27:44 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:27:43 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:27:43 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.38) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:27:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHvecJYZShAVyAD9byDsY3/GeJ5IAp4H6rk8SxuHZYvfwswZf49nZ15kgolyq6RCmzPwmsM0Xbi2cel4wy5HU89alVIyNK02aY3kS0WVXyiR2UNMe06XszXqFMuM2eyIST8aC8aaDZCmAMJeoXrJbL4rfuyz/HMEJqFIbMcopRhtmZ9K/v3lf1Ba5khqqPTLgqvCvV2Ag65G2C2m+Tk6R5qlIRpsfkEYWKXH5MGpZzRLYku5YjxMpDpXz0uwhmN/8lhIFQq9fxInp+/2UArF707dsK2VSE7BhtBFPqtbuVSHiLgmsfb8fIe46T9B9TiDa0pwYIX2rpHeCdMJs90yAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kb0BqDmv0bLbBPUmzHttpS95U0iG0lgBoTK67MB/hhk=;
 b=kQfMbPq2Yy8r4v25LgBw0jHEz/Iz0Y6FdgQjsY7PP+HegkPi3+fD5qz2y1fxIOAD8xzzUwgWGLxlp71a9mRByXjAQbuNsBKTSx4KHB4oloyArFycqWgL7p1O4LV5gVhQ5WfLlZ7oGZFpXKdOkGM6mqj5z6VTntSoCkx+3EIxHhu9OiAhN7UP4rNGkxc+qBl5eVuOy6Ajy4ZSelWFhYPJRob/D7pV/IQD6eOBNq5pSyBHF1y4ItnoIOq94jQo7412ponGqmgwmNoLpSgOWHcWDyIEA+WU7pvOEGQeqMk+0yn4s7iVEBc41PfQ+X259AFjruLRraWAwykiWVVBZzENeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by DS6PR11MB610166.namprd11.prod.outlook.com (2603:10b6:8:469::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Mon, 5 Oct 2026
 10:27:39 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:27:39 +0000
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
Subject: RE: [PATCH iwl-net 09/10] ice: program multicast magic wake before
 tearing down the main VSI
Thread-Topic: [PATCH iwl-net 09/10] ice: program multicast magic wake before
 tearing down the main VSI
Thread-Index: AQHdUnGX+i4BPdDfgkashWYrFzvSRrbuw16g
Date: Mon, 5 Oct 2026 10:27:39 +0000
Message-ID: <IA3PR11MB89867C3F35B4206892F02E2FE5962@IA3PR11MB8986.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|DS6PR11MB610166:EE_
x-ms-office365-filtering-correlation-id: 9c3ede42-c3b0-4fa5-fcfa-08df22cb4822
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|7416014|1800799024|376014|10067099003|4143699003|21046099003|56012099006|38070700021|22082099003|18002099003|6133799003|11063799006;
x-microsoft-antispam-message-info: YABHgOH5wvNf7e4UzqVYOs3No2heup8igVugwgW+I/AADIFLUIYZ4HGruM/grVI9TUtEufI3inumVgxBh86vO9c1yNhh6ienuCgbJgBR9TqBtcAAhNo57+gt0OhC2omjjGeW6bPsrCWDA1fviLgwlXPOoRHTkBtpWIEPGDsMgIDdMy0rLH1kCN8XWwhKEW4qzJ/qoqvl3DVUIuvkstsxdrPS5E6TJkjrA8YAnlhAR/uxlU+K20FARfQMXNugq/2I/NmfeUdoQyz8YBD+EHUag2uUY2D13TgcUQvwV6pWMHqocjHMV29fe1ZkU2vsuSbk8lHOtBlpUUg1/EASx9dDm0/ykRdOSXEoNlHU5fRope750ScEmS+slz6GzRJ8omTDGcdbliiMPXqq6o9hvQTQqi2bmSmv7qFiE/N12p5kdibPtYi7n5JlQFO0jiVLJ0vg1vzMCdkqp5fnXpaAm/9gPHmfzpNMJKMg0p470agBgrR6KaQQ83DOJNL9ocEevWH3cJluBTwSfPEXPMTN7pXAbehiddyKX3dHAgXTnouOIzFeqhw9sKLZVuPvfBRgZkfj0nlamsHsj9U5pXajGurXaXM+1ZepQ1TjQ8kFS805X8fuK58NzSHAvbOIiYAEMcLCtTHihLOhgZ1kejwRfke8Sk6DP/x4lJKQjNVN6gR+u2HXqCeYqWDjU2G2EH3+H3UBR0mluEQQUMDCqfYBkhuBkPouPVzB/VSmp4zNEXnkqX0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(10067099003)(4143699003)(21046099003)(56012099006)(38070700021)(22082099003)(18002099003)(6133799003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DAs2GM3Srx46qdfgCGVOC0PwrsO3OFZGmcYSOLlOTN2DoycbCX2YzLtSM9jb?=
 =?us-ascii?Q?M1LkF46ev8sXQLoggGCVUbwQJjG/9Qpk/8caeGraEN2jfXUNg5+EWnZ9OeZo?=
 =?us-ascii?Q?Yv2oslnkN2jizzryH3QSSa1f/ZOoAZ7CC37mlxiM4Y8GzpxVZV439NWBQ99/?=
 =?us-ascii?Q?rtWCRYa0mH5g/FdjLFYGMNB9UIlzYu9VZ8pCyk55OybTHWvA3H8ShPFy0v5I?=
 =?us-ascii?Q?rpjlUDP88Sz7cCQpkyQZmXc61ioN2fAiGtdXegWnO7LG+oJ7su0aOgx/m0hQ?=
 =?us-ascii?Q?2qsO77fYHTH1+9DHXcoo1A9IyorjBqHrAbq4f+tkRuuU5MAazPwPBZIdkGL4?=
 =?us-ascii?Q?t+X1aZ8TU93cNydQf4FJwOTay/jCfSIfRDZPZjrcWp3GE386chnFPzx6Wcll?=
 =?us-ascii?Q?cWn7zMGwW5UTtC6okD1hf/uUN9CLC1XoyA5jOM2Q/hxxegmQDd7X0i4SORa5?=
 =?us-ascii?Q?fPSmrnM5uWrvwacAwK1ruVeRiYpULhxEAEtbbBL2WqSYwUFbWFEJxCy3PGx2?=
 =?us-ascii?Q?YaHU/Tvo/uDysSRBfFBTJF+AL482LrWkNQX1fzH/U1OOHK63DhnhsPvbsl4S?=
 =?us-ascii?Q?Bxq3VtmHhB95Uk7kUm3mB7luJ6oz06xNByRLIYclChhCPKKbTg4XKzgqi8j1?=
 =?us-ascii?Q?TJe2eLkalSNf11RZsLLbMKpz9JYL9WSOgnAZFn9iwcDe1ntGlTNEAo8tvDER?=
 =?us-ascii?Q?F2Ib6jNSaN4BL3MtUgd5mdvvb+Qe3p3gGucT1b4K0BEJjA5n75XQmEYr2dRq?=
 =?us-ascii?Q?GgZh1fga7SB2G31b0pTnxFnrGz/c+7Ub3yBiU0z1H8X//p3D2um2eCjGQpMV?=
 =?us-ascii?Q?K3kv60h2u9z0qb9t7veflVHO+nDjHRhrabXOsCH6fVhBhbzz+nr4lCy2Gi/M?=
 =?us-ascii?Q?e0hbyY+Xx/snAkxKL9NDskghP/g+a7gIlMzlVIHPu7dmIFCO3iMHcdnje0wg?=
 =?us-ascii?Q?5XYNiea6ZnnSV7tef0KpZz8QKteTaDnk2tmrDAzn5kxoFYBHR9tr4evVzUM8?=
 =?us-ascii?Q?Ig90rmQu7Blkk9MpZx/atbYXY9K7dupBWJa3Js9Rp1p9StFD5OJv335OLRhy?=
 =?us-ascii?Q?psRaidBdw03NIteLgX9m6s44LG95mCP6bOvJZzBeYAZw8/G8gLRw16vRTbIt?=
 =?us-ascii?Q?9wgPCHfkGZFJTldY0zG4vOSHXXFHhr5shseGX5bKqrtsblwTp+0rCtVuNhKV?=
 =?us-ascii?Q?IqZUyjye+HLLO6qERyeOUvGU0VTFtYS76XviWlR5lqxS39WDE+nTX/IiKMkt?=
 =?us-ascii?Q?0ksgvn8stkCwmGTEvS4w0wmD2VKcnuZAXL+DFpV/HXHcHvbGsRuaVqAVj4V7?=
 =?us-ascii?Q?kiIiizGARQ8fqGzwBboQBqwh2HpTwqDYaciy1s9DDCd2Lq1PxkpmJRn1sU5c?=
 =?us-ascii?Q?BMu343rvWpLubAQN3cC4cIiWpNPm5oijlXVRUkujv0jVXQZtmRUAlSszQ8PI?=
 =?us-ascii?Q?VFcsLK/K4RUZABwaDdDdywb6uKUXOXdYYuIKKcPqAr+O6/buq1U8LyA2w563?=
 =?us-ascii?Q?1jgeXeTkjKaxfvsGTfBWnFZ2sdTfSJh1hKhcRIpJXvg1ccaUGYErGmiwhu6F?=
 =?us-ascii?Q?0F7djgB1IGgxefpTIY1YybsyMv+B9nTi4mTebq2kwosRChIgLhDyNjwzsTgo?=
 =?us-ascii?Q?yCZbgpQmqQh2o+j7Ak96E1sO1Vf4bwEhL67yknKT/O1s3rWm2b3vZQAnH09c?=
 =?us-ascii?Q?RNt+xU2dJFQ8xprz0fZcs3W6qx0KtldumC2XUNid+eT+xtNZ6WnYA5ByLeoW?=
 =?us-ascii?Q?SsYfRy/OQAtfm4/OFvHUOSvFqM+gqQc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: xK+6cpK923NsNRu4vTNkdrFFJPMb/EFv5RrQ5scW60jS8lJKJcu/CTycmtOICIvCKrnZjaoHneE1Q/W9VoLPbd+48u2azadhVxyZhUL6DWG1mscuXteVA9Uo3lTHvIaFcuajzUqveTIx66GTDlI4Q+r2qTwmRyCEaZrXSjNzq/O0mmH2pSoX/LsWx+kviUgXyTmAD4Je+9dbvrrzpaJk8vgCHS1/0TaMEA7arp4Sk/zY52hhWLThxDYCMDpt6NhKueCEvttPWXbOT9Hl0v6Wrr22sBvt+iLV1sw/w1SELNfVEce8Gta5p+h2HMcNR1JCJeYxX9dnKZKkLd3snX1YSw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c3ede42-c3b0-4fa5-fcfa-08df22cb4822
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:27:39.3780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RTx0XnKRe1mWiK0C6y4aFhS+86lD7tEKShRP5M8OSKToUjuAsFBjFz29KDhoY5jMvtFPxn/QeAHSVjYBYCmqsfBfJI7Z5RdvKweHsZsAEIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR11MB610166
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
> Subject: [PATCH iwl-net 09/10] ice: program multicast magic wake
> before tearing down the main VSI
>=20
> Since commit 5b246e533d01 ("ice: split probe into smaller functions")
> ice_remove() calls ice_setup_mc_magic_wake() after ice_deinit(), which
> frees pf->vsi. ice_get_main_vsi() then returns NULL and the function
> returns before it sends the Manage MAC Write command, so multicast
> magic packet wake and keeping a locally administered address across
> the PF reset are never set up on shutdown with WoL enabled.
>=20
> Program it before the netdev and the VSIs are torn down, as it was
> done before that commit, so the current netdev address is used again.
>=20
> i40e had a similar problem, where the multicast magic wake setup ran
> after the admin queue had already been shut down, and fixed it in
> commit e661414c98df ("i40e: Remove duplicated prepare call in
> i40e_shutdown").
>=20
> Fixes: 5b246e533d01 ("ice: split probe into smaller functions")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c
> b/drivers/net/ethernet/intel/ice/ice_main.c
> index ceb9fec2af21e7..a885b3e0baaa5d 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5456,6 +5456,8 @@ static void ice_remove(struct pci_dev *pdev)
>  	if (!ice_is_safe_mode(pf))
>  		ice_remove_arfs(pf);
>=20
> +	ice_setup_mc_magic_wake(pf);
> +
>  	devl_lock(priv_to_devlink(pf));
>  	ice_dealloc_all_dynamic_ports(pf);
>  	ice_deinit_devlink(pf);
> @@ -5466,7 +5468,6 @@ static void ice_remove(struct pci_dev *pdev)
>  	ice_deinit(pf);
>  	ice_vsi_release_all(pf);
>=20
> -	ice_setup_mc_magic_wake(pf);
>  	ice_set_wake(pf);
>=20
>  	ice_adapter_put(pdev);
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

