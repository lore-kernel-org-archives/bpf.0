Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794571599;
	b=2CzOas/W8xl4VHXr6dLfy0L6NAXLtbKMR7mUZL4+HLraW4XXR2HwOCLRkAC+g9DkjZn4
	 xZgpb1Fwn85rfWsdT2f4F+absPCbAZLfIALTXEEm4OG+1TEJsVOOKUvofY8UdIrw1yPsT
	 qRf50u78ncvdkK621w7OiltVYXxyuRR07E9aFsAx9YqjorZEefiNEmLj1uVvtvp8y4k/D
	 Th4pMvoUYD9dbTtnRBlE4uDMTnesb8bp2DH+uzW+8JW3hgKMP35sFagVV5Kx8j7EUGisU
	 aY2pGbRL6JWTueLN79z4kx8Y2QkrNjgzRCEgxBwJ4+c598YAT6RjXor/wVb5eewIGZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571599;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
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
	bh=UwkdWp8vO/U4aP7XqQeBZ0id5TyB8V1GEJ80UAYikds=;
	b=U5bVVhLYjuRiNmZstaItIEu/opoVVGefUXUabg5Nq+OIRwC3FWfJxf17I62LBFz0mvhP
	 DNUMXQMoSMp6xkr8JQEeKAhjWld2zXmZhSdlqEEHQmAOKaQ44MUdLx0pRvsWtU8oAEi1a
	 rSehXuz6BmOQovye7ttcbWy5rccEoYM0XLk/qSfRFW9g4F9PbYYBRRrqg9xHDMiUSkJRW
	 oD0zVH7SLBLvdVcTo8gWWqR9H4MsyJBJyHSzbsmW89aPCPLOU1pwEtsYKKi4fIZQ//BDU
	 Ti9Ps8GKyINo10YG+z7tY/jm6zCXQqfi0hCKrUol9s/Qsf4sRIpCQZuK7SFRkfOElog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G5cDSIdD;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=hN7qTyS2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329E5606A33B;
	Fri, 13 Nov 2026 12:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 329E5606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G5cDSIdD;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=hN7qTyS2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794571598; x=1826107598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GSBqnIsJNu67qT1LnNlBQjRg2ZIbrclwQh1iCk/W7m4=;
  b=G5cDSIdDbUGTVBi+teEUYfLXBIYmgaA5cU3/CkzzcKiK4Hri2tbRfmVN
   cuulDu1NsG3YUqrhDiBbaKaytp5BtlcBHDKtCK0LwgfK68gTxLD1wX5kM
   8cdzsGjwvCljvu5vmsLmAY4NsDihChRmH3i8E/b1Eq340hz2uvTT4YRUZ
   RWQdBJw0W7uDbZSDe/PX0q5dOWB6E7bpb9IJSsyR+2vrIXfBT51dcDkHB
   OPjcQk9GDftMyMWaPIqmGN+Y6GNO8uUYjmpI9EN8+gnRu5aodZS/MClWA
   B91bMnaPHej/nD/FQd97YdblDE2fvfjLIJJqmO2BD9srXmdbH4k7I3CXi
   w==;
X-CSE-ConnectionGUID: LzcqBsJaRN2viCJXETckjA==
X-CSE-MsgGUID: syUBemRhSZ2mu0UEZcMFhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3226907"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3226907"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:06:35 -0800
X-CSE-ConnectionGUID: 8yc+x2eoRVC5sm6zKEoFsg==
X-CSE-MsgGUID: o2ogC+T/R8up6SeovJUscQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9457701"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 04:06:35 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 04:06:34 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 04:06:34 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.55) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 04:06:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rspGluU7hGU8fSRcekj5GgZrsYz0Df129C+l7GibzdUspN1WIrE23ehWYfRHHB3RgwY+PsDQ2Ur0tWaJxzjE2J42YIjCLaj9rWwO14I6seP7zXYtf/hxNFGyui797MJy8nvRiz9OBaRAH4gKZMLHsVhaEbWagUeCN2PXHkfZEQSEIlOCbWfQnXCR9Ikvyw1jphAlkzrAy8pyXE4DsFFL037bJ93Sm3VpkaQYhlhwbVkJazIprFLAAJ0e9gOhWgm9plUCZpzN4B7QR80TucBpz3bFeqfuSRRzcmLaoA79QflRe191u92QvIiOWbPZaOqt+S3e/p+PB1Cm7skHWCK/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwkdWp8vO/U4aP7XqQeBZ0id5TyB8V1GEJ80UAYikds=;
 b=mufzyu5nXiuCvtm2AZrx5CWT0d9zbvu3SuGRe7UPl2ueItGxQyf5A3xN5GTiQn5950brH0bOR1tkRXU3VIO53/41x9uoInK9SDJM45veXjLNsuDMvlEEOI5ugN8RoCecuew/QD0eJ6axKz2ZLXDetta/nD/rkVjM9Y93Ezg+QXae4LiHP7eMMHIYKiUKkGug9bbGywxX1feSqcKV+rXZ0QGgesLnKORzEt/oz0cxhioeaVPDUZKwmH7pXO0XSMg3PEBQ3oBrHpvDfqsXQaaFDBfdk5xtw/cJmVQVrwlrgl8dXKTWP/R1IZhgUJ063+Uv0EfshRFBb/dJYVBW/seQdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwkdWp8vO/U4aP7XqQeBZ0id5TyB8V1GEJ80UAYikds=;
 b=hN7qTyS2eo51ifgewsAQhnceG4FHUd/sM7cRujQRedUE5luTUXRvPVjhd4/onVnhqWtanOksG8SpHq1cIv5xVrUeqs4vOWt6hdTWZFE02WDwh283A7g9jHBZ5r2SpqtDEPRPGKq9VZldXmBMiGLc4mrh5g573GM0rHwFdFldmvA=
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 (2603:10b6:610:34d::22) by BL1PR11MB5221.namprd11.prod.outlook.com
 (2603:10b6:208:310::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 12:06:27 +0000
Received: from CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584]) by CH3PR11MB566895.namprd11.prod.outlook.com
 ([fe80::87f5:c8cf:d52:e584%7]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 12:06:27 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Tianyi Gao <tianyi@cloudflare.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
	Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>
CC: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, Vladimir Vdovin
	<deliran@verdict.gg>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter
	<donald.hunter@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, Song Liu <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "Vyavahare, Tushar"
	<tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>, "Jonathan Corbet" <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, "Chris J Arges"
	<carges@cloudflare.com>, Jakub Sitnicki <jakub@cloudflare.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, "kernel-team@cloudflare.com"
	<kernel-team@cloudflare.com>
Subject: RE: [PATCH bpf-next 14/15] selftests/bpf: Test the load kfuncs on
 cpumap and veth
Thread-Topic: [PATCH bpf-next 14/15] selftests/bpf: Test the load kfuncs on
 cpumap and veth
Thread-Index: AQHdcTPDoGbUT8pvwUinc/36MQ5hIrcr7FbA
Date: Fri, 13 Nov 2026 12:06:27 +0000
Message-ID: <CH3PR11MB5668959CB9EB2FF212C119CE46E57F2@CH3PR11MB566895.namprd11.prod.outlook.com>
References: <cover.1794281983.git.tianyi@cloudflare.com>
 <87e20fe4ae289764205f33920e90f3283a478e8a.1794281983.git.tianyi@cloudflare.com>
In-Reply-To: <87e20fe4ae289764205f33920e90f3283a478e8a.1794281983.git.tianyi@cloudflare.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB566895:EE_|BL1PR11MB5221:EE_
x-ms-office365-filtering-correlation-id: 0d10a14a-f01c-41b0-f6de-08df417e8b79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|261028144727099003|261022115727099003|261026121527099003|261102123227099003|261026140227099003|261021135927099003|261022075727099003|261021121427099003|56012099006|38070700021|11063799006|4143699003|261022113327099003|261021123027099003|261022105027099003|10067099003|22082099003|261009223027099003|18002099003|6133799003;
x-microsoft-antispam-message-info: bZM6IeNUIPCZ1JE0Y0oqttitIEE3M8mMASyHxwoUPLhWBEmqyAzgi8GkGQorfBMaO7jtsWnUhmRlKxo/kMSUhNZfan8VTTG0LMAKgp0ZoYXdzzyAFxkIvdQMIOQ08lZrZV5FcmVi5nelhhtKQHA0Lf+5WTHFQVS9ylnRKFb+boC/MNb86JJd4lLywEUsfK6/yvb3tTodGuPWoEk+NS8ZJIBpydqOeS+14XgL7rGeBLdcCxVKGr8icknHrwSpnT6rQwRwl/+eJpgkXbSWE3WmF7luWVtVIhuE29zDJbIRNIABBxojI0T7QUgK4X9vOa5g3TS8uLcSlzZ6PhG9qxvyTtw0tHdFTdN2n4FTMjGRIcsTXu+geQfw/up+CXCQYHskqlroUZAQiZcSFyp/pipKl8ddOSyeJTE7zJC2gyxPdbebLeANxsNt1+aDD5tNi7MplTgqP8MluWvj1kh5cfu52DLqA+uN1TUIIStco0yRf1qOIqZnwWcbmAD9+OimYNDE2e5LH1icJWDU6vzhzijaTSF/Eo1ediu9z6ifo9ydB1UhjGJS1LGnGaN9H0wQcyNzEKb/5V4CCzlaS/e//tyT1n/Ia8BKy0uZPQ+fL4FWj7lMeqJ4z2wzfE7gAL6BO12cOQcgANBsJgywP3gWKdq1SW3e+CIO0CfWjWuqbNhIvU4+63hDjoEv+7HGxvYOH1P40TyCudN+E2LM98MpQLBz+PiGBjx0AfC/IDUGC1RQyNk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB566895.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(261028144727099003)(261022115727099003)(261026121527099003)(261102123227099003)(261026140227099003)(261021135927099003)(261022075727099003)(261021121427099003)(56012099006)(38070700021)(11063799006)(4143699003)(261022113327099003)(261021123027099003)(261022105027099003)(10067099003)(22082099003)(261009223027099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bDI7u2s/AcXnKM+sKkHSZcoWWGn7URd3vhZ8NC5PwTYdlYW8Rm9g/sIXDlc6?=
 =?us-ascii?Q?v3DtGngdkIbp+zFL2jyPNCCZf6YdtvybDEo7pPXO3uctYrut1km5msjstIoj?=
 =?us-ascii?Q?NCknyMOHJiv3CkakrdGITTkbr5bNjR738NLhYhYLZJzkn0I0WoR0ke0zjd40?=
 =?us-ascii?Q?EVDcXEOk5tHwo7q8bFO+2NZWZtZzVgmxfgi/Wr/28XTduFg0Eu+r464p/Fre?=
 =?us-ascii?Q?kc0kwUdPw/02EanEECMNV3KmQA5gNI4ilERJoqiQScV+6kmNa7brt5nBLZu4?=
 =?us-ascii?Q?F5FKlSeaqkvkClN9GU0blHC0z5JFW8pr0e4FyuB6ZDju2viy9UJ4zSj48qUL?=
 =?us-ascii?Q?eTihpDvv+RILmk7gL+OFz9s1CTTzWNlCuQ0tSGWqCTjwR7ayw14/tsP1Tej2?=
 =?us-ascii?Q?xwuhw2xCBUTTOh6CLOm3ksBFsEh9XndqunzsYWQWXxfRFnMeEGo+6evdTjmw?=
 =?us-ascii?Q?SSMnXbCrAG3U4uu2iQTc8+J4AE/KWI3OanpQfpdmHntN7BhkKdf/1Pposvb4?=
 =?us-ascii?Q?9E1KF+AHc7abSO6QnNnNZvAJQc/wxEWu4momcVhKfREQamackAyTKECnaxZQ?=
 =?us-ascii?Q?Fy67871q5lsx0bx39E/qINAB8TWW6zhmqE8AmiKHJ6UbPCIxaKa+cwYKWvlv?=
 =?us-ascii?Q?uhk7/OL0OOmiGnE0hT7KIYOiJJdxrhd9tO4DPOEOVpnP3zrTTOsRRnts5CRU?=
 =?us-ascii?Q?Ha4yB0l/i2sq8c+61bhtTzqP0sFBk3yY6+F02faiW8oV/KTLTgp5PfJSkwrn?=
 =?us-ascii?Q?lZDbFbbM1AxioApze1YzYTZabMzV2VwXj84AOptHn3tK6+ofKv5ma1o8Ux0I?=
 =?us-ascii?Q?1yP0ysS+Js/uChwvTAD9uxbyEz2hbLzWnez02lvsEARr5EMHCk2x21t6r0oM?=
 =?us-ascii?Q?5RGU6d3bpWeR6LKSXo+icekm4nsyN+SIPHNwsUJK2WZiTKdnWWXkP8UXBPmP?=
 =?us-ascii?Q?9LcO/T3K/3xgaANNOqeBwNXqgQujfdbIAhxiuNPu+LuiCHCbtuWHPaMp48gc?=
 =?us-ascii?Q?LBXnLNrruxVKJEaI3UoeTGXZPirtlh71sjPajstGlBpH6ZSx60qE8q4XajZC?=
 =?us-ascii?Q?e7cx/JTq9RtjpCVgbMqRo6WbEW84M+Kl7xT97Q1O3xF0gRlBC24qZEPrRBXI?=
 =?us-ascii?Q?CawgYw8lCF/kphMFPxDP+Qb3GSTWj14T1fi+NvD23eNJh9dSAk19yhkwppDo?=
 =?us-ascii?Q?G9R7qVzLolB5qXH2gDQqdh5l8N4xrK901Gr9z5NtGVOu9S1USdZtwfx19nuJ?=
 =?us-ascii?Q?2R7UtDs8GIJHZuU2a1eZl6wozn+Yq1ON8MzjQXJC/K2AYlfHCPI3pYB0ravJ?=
 =?us-ascii?Q?9ZhMuiG47bRv3D+DUJ4QiGeu4IXiPh8nYfrbtKAEnsSzt87fcJgoWG82rjus?=
 =?us-ascii?Q?sFTZTHEietpvEeN8c0EQchmmGE7WJCJpAqDy+ZRO0tBHuTIpZbkHd8EnBwvs?=
 =?us-ascii?Q?xjcyubxIoN55icspJtMjFNuC1YtWnXwu4QyqsoJBdSaMaUxuIFO93yE6/Vs2?=
 =?us-ascii?Q?tUq0CMHgNVJLccetwLAShxWPeO8WMkTLw/ZWBSsp4pw1SdjofN17FfD4O0L2?=
 =?us-ascii?Q?JFKx0+qNNjEEQasuHsossrVzgYqmtNhAhaGpBWBiLjhGsBQweqFG70qkLTT7?=
 =?us-ascii?Q?wEppHp0sT44zlTTBkRtbCstfI6o6Y89Tv6EZLV9e9rq84Fr66feqS7vwQaMz?=
 =?us-ascii?Q?A237fLV6QE2zXJvOVa8AIB1bIQtqV3nIvsjXgLHWXcGOv3IZvx/43V8zgXbW?=
 =?us-ascii?Q?pEF00FTRHA=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: la9rEMIr9pft7CDHi3Jj5XRL9uKKi692RWmBBWv8hRecapk21KACw/mNTTrBv/SZ+r81345guhVd6DWZQgq2OG0jzDJqemncaFnQQ99hjO4bVEEp3IBtuYu24TehP66AEcgPdGOfJanUGNldPtrsQTVj/m8LfdkDOxDNhsfHP/rhgB/jVd2OzwjSTdwavz96MzLxaXtLNbWRLoh4/LTKshSx5iJGLRFw/cVvcRZlyaGeOsODsx7C8ELM2dSjY3/K+bPyzqhXgIRgdlI7PdqYv6U7xpTFPRzLfe/UgRcIAOv7STI/69TSstcA6tlDCytFXs1KZG3HD+FSD42E2+XfNQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB566895.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d10a14a-f01c-41b0-f6de-08df417e8b79
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2026 12:06:27.1504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVMzT73KK43ziwserL8R7d21e9ie0Y7Y2EESlAyLqUtnMU8ExS5lRu6y+pnRLU2zP4fYElSX8n4OD6Z8vhX2IDiAepJa/VWzW3+44n6ySyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5221
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Tianyi Gao <tianyi@cloudflare.com>
> Sent: Tuesday, November 10, 2026 4:57 AM
> To: bpf@vger.kernel.org; netdev@vger.kernel.org; Alexei Starovoitov
> <ast@kernel.org>; Daniel Borkmann <daniel@iogearbox.net>; Andrii
> Nakryiko <andrii@kernel.org>; Martin KaFai Lau <martin.lau@linux.dev>;
> Jakub Kicinski <kuba@kernel.org>; Jesper Dangaard Brouer
> <hawk@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>; Stanislav Fomichev
> <sdf@fomichev.me>; Lorenzo Bianconi <lorenzo@kernel.org>; Vladimir
> Vdovin <deliran@verdict.gg>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Simon
> Horman <horms@kernel.org>; Andrew Lunn <andrew+netdev@lunn.ch>; Donald
> Hunter <donald.hunter@gmail.com>; Eduard Zingerman <eddyz87@gmail.com>;
> Kumar Kartikeya Dwivedi <memxor@gmail.com>; Song Liu <song@kernel.org>;
> Yonghong Song <yonghong.song@linux.dev>; Jiri Olsa <jolsa@kernel.org>;
> Emil Tsalapatis <emil@etsalapatis.com>; Ihor Solodrai
> <ihor.solodrai@linux.dev>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> <przemyslaw.kitszel@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; Lobakin, Aleksander
> <aleksander.lobakin@intel.com>; Karlsson, Magnus
> <magnus.karlsson@intel.com>; Vyavahare, Tushar
> <tushar.vyavahare@intel.com>; Jason Xing <kerneljasonxing@gmail.com>;
> Nikolay Aleksandrov <razor@blackwall.org>; Madalin Bucur
> <madalin.bucur@nxp.com>; Ioana Ciornei <ioana.ciornei@nxp.com>; Jonathan
> Corbet <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.org>; Shuah
> Khan <shuah@kernel.org>; Randy Dunlap <rdunlap@infradead.org>; Nathan
> Chancellor <nathan@kernel.org>; Nick Desaulniers
> <ndesaulniers@google.com>; Bill Wendling <morbo@google.com>; Justin
> Stitt <justinstitt@google.com>; Chris J Arges <carges@cloudflare.com>;
> Jakub Sitnicki <jakub@cloudflare.com>; linux-doc@vger.kernel.org; linux-
> kselftest@vger.kernel.org; intel-wired-lan@lists.osuosl.org;
> llvm@lists.linux.dev; kernel-team@cloudflare.com; Tianyi Gao
> <tianyi@cloudflare.com>
> Subject: [PATCH bpf-next 14/15] selftests/bpf: Test the load kfuncs on
> cpumap and veth
>=20
> Add a test for the load kfuncs on each path of the xdp_skb_ext_to_skb
> test. On XDP_PASS, the program that stores the values reads them back.
> On cpumap and veth, the program after the redirect reads them. Each test
> case compares them with the stored values. A load that finds no entry,
> also after bpf_xdp_skb_ext_del(), must return -ENODATA.
>=20
> With BPF_F_TEST_XDP_LIVE_FRAMES, a recycled page still holds the entries
> of the previous packet. The live_frames test checks that a load returns
> -ENODATA there.
>=20
> Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
> ---
>  .../selftests/bpf/prog_tests/xdp_skb_ext.c    | 47 +++++++++++------
>  .../selftests/bpf/progs/test_xdp_skb_ext.c    | 50 ++++++++++++++++++-
>  tools/testing/selftests/bpf/xdp_skb_ext.h     |  2 +-
>  3 files changed, 81 insertions(+), 18 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
> b/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
> index 64c6f0268d60..0811c09b7747 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_skb_ext.c
> @@ -7,7 +7,6 @@
>  #include "test_xdp_skb_ext.skel.h"
>  #include "xdp_skb_ext_success.skel.h"
>  #include "xdp_skb_ext_failure.skel.h"
> -#include "xdp_dummy.skel.h"
>=20
>  #define XDP_RSS_TYPE_L3_IPV4 BIT(0)
>  #define XDP_RSS_TYPE_L4 BIT(3)
> @@ -167,7 +166,9 @@ static void set_case(struct test_xdp_skb_ext *skel,
>  	skel->bss->want =3D c->want;
>  	skel->bss->del_hash =3D c->del_hash;
>  	memset(&skel->bss->have, 0, sizeof(skel->bss->have));
> +	memset(&skel->bss->loaded, 0, sizeof(skel->bss->loaded));
>  	skel->bss->store_err =3D 0;
> +	skel->bss->load_err =3D 0;
>  	skel->bss->pkts_seen_tc =3D 0;
>  }
>=20
> @@ -191,8 +192,6 @@ static void check_have(struct test_xdp_skb_ext
> *skel)
>  	bool unnecessary =3D (want->fields & SKB_EXT_FIELD_CSUM) &&
>  			   want->ip_summed =3D=3D XDP_CHECKSUM_UNNECESSARY;
>=20
> -	if (!wait_pkt(skel))
> -		return;
>  	ASSERT_EQ(skel->bss->store_err, 0, "store_err");
>  	ASSERT_EQ(have->hash, want->rx_hash, "hash");
>  	ASSERT_EQ(have->l4_hash, !!(want->rx_hash_type &
> XDP_RSS_TYPE_L4), @@ -208,6 +207,24 @@ static void check_have(struct
> test_xdp_skb_ext *skel)
>  		  "csum_level");
>  }
>=20
> +static void check_loaded(struct test_xdp_skb_ext *skel) {
> +	const struct xdp_skb_ext_vals *want =3D &skel->bss->want;
> +	const struct xdp_skb_ext_vals *loaded =3D &skel->bss->loaded;
> +
> +	ASSERT_EQ(skel->bss->load_err, 0, "load_err");
> +	ASSERT_EQ(loaded->fields, want->fields, "loaded_fields");
> +	ASSERT_EQ(loaded->rx_hash, want->rx_hash, "loaded_rx_hash");
> +	ASSERT_EQ(loaded->rx_hash_type, want->rx_hash_type,
> +		  "loaded_rx_hash_type");
> +	ASSERT_EQ(loaded->rx_vlan_proto, want->rx_vlan_proto,
> +		  "loaded_rx_vlan_proto");
> +	ASSERT_EQ(loaded->rx_vlan_tci, want->rx_vlan_tci,
> +		  "loaded_rx_vlan_tci");
> +	ASSERT_EQ(loaded->ip_summed, want->ip_summed,
> "loaded_ip_summed");
> +	ASSERT_EQ(loaded->csum_level, want->csum_level,
> "loaded_csum_level");
> +}
> +
>  static void test_frames(struct test_xdp_skb_ext *skel, const char
> *path,
>  			enum xdp_skb_ext_deliver deliver, int ifindex)  {
> @@ -232,9 +249,12 @@ static void test_frames(struct test_xdp_skb_ext
> *skel, const char *path,
>  		if (!test__start_subtest(name))
>  			continue;
>  		set_case(skel, &skb_ext_cases[i]);
> -		if (ASSERT_OK(bpf_prog_test_run_opts(prog_fd, &opts),
> -			      "test_run"))
> -			check_have(skel);
> +		if (!ASSERT_OK(bpf_prog_test_run_opts(prog_fd, &opts),
> +			       "test_run") ||
> +		    !wait_pkt(skel))
> +			continue;
> +		check_have(skel);
> +		check_loaded(skel);
>  	}
>  }
>=20
> @@ -266,6 +286,7 @@ static void test_veth_skb(struct test_xdp_skb_ext
> *skel, struct bpf_link *link,
>  		goto out;
>  	if (deliver =3D=3D DELIVER_CPUMAP) {
>  		check_have(skel);
> +		check_loaded(skel);
>  		goto out;
>  	}
>  	ASSERT_EQ(skel->bss->store_err, 0, "store_err"); @@ -275,6 +296,7
> @@ static void test_veth_skb(struct test_xdp_skb_ext *skel, struct
> bpf_link *link,
>  	ASSERT_EQ(have->vlan_tci, 0, "vlan_tci");
>  	ASSERT_EQ(have->ip_summed, CHECKSUM_NONE, "ip_summed");
>  	ASSERT_EQ(have->csum_level, 0, "csum_level");
> +	check_loaded(skel);
>  out:
>  	close(sock);
>  }
> @@ -292,7 +314,6 @@ void test_xdp_skb_ext_to_skb(void)  {
>  	struct bpf_cpumap_val val =3D { .qsize =3D 192 };
>  	int ifindex_src, ifindex_dst, tc_prog_fd;
> -	struct xdp_dummy *skel_dummy =3D NULL;
>  	struct test_xdp_skb_ext *skel =3D NULL;
>  	struct bpf_link *link =3D NULL;
>  	struct netns_obj *ns =3D NULL;
> @@ -330,18 +351,13 @@ void test_xdp_skb_ext_to_skb(void)
>  	    tc_prog_attach("veth_dst", tc_prog_fd, -1))
>  		goto out;
>=20
> +	val.bpf_prog.fd =3D bpf_program__fd(skel->progs.cpumap_load);
>  	if (!ASSERT_OK(bpf_map_update_elem(bpf_map__fd(skel-
> >maps.cpu_map),
>  					   &key, &val, 0), "add cpumap
> entry"))
>  		goto out;
>=20
> -	skel_dummy =3D xdp_dummy__open_and_load();
> -	if (!ASSERT_OK_PTR(skel_dummy, "xdp_dummy__open_and_load"))
> -		goto out;
> -
> -	/* veth_dst takes xdp_frames only with an XDP program */
> -	link =3D bpf_program__attach_xdp(skel_dummy->progs.xdp_dummy_prog,
> -				       ifindex_dst);
> -	if (!ASSERT_OK_PTR(link, "attach xdp_dummy"))
> +	link =3D bpf_program__attach_xdp(skel->progs.veth_load,
> ifindex_dst);
> +	if (!ASSERT_OK_PTR(link, "attach veth_load"))
>  		goto out;
>=20
>  	test_frames(skel, "pass", DELIVER_PASS, ifindex_src); @@ -354,7
> +370,6 @@ void test_xdp_skb_ext_to_skb(void)
>=20
>  out:
>  	bpf_link__destroy(link);
> -	xdp_dummy__destroy(skel_dummy);
>  	test_xdp_skb_ext__destroy(skel);
>  	netns_free(ns);
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
> b/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
> index a63206ff993d..34db1a986f3b 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_skb_ext.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <vmlinux.h>
> +#include <errno.h>
>  #include "xdp_skb_ext.h"
>  #include <bpf/bpf_endian.h>
>  #include <bpf/bpf_helpers.h>
> @@ -14,6 +15,8 @@ SEC("xdp")
>  int live_frames(struct xdp_md *ctx)
>  {
>  	__u8 *mark =3D (void *)(long)ctx->data;
> +	enum xdp_rss_hash_type rss_type;
> +	__u32 hash;
>=20
>  	if (mark + 1 > (__u8 *)(long)ctx->data_end)
>  		return XDP_DROP;
> @@ -25,6 +28,9 @@ int live_frames(struct xdp_md *ctx)
>  			reused_ok++;
>  			bpf_xdp_adjust_meta(ctx, MAX_META_LEN);
>  		}
> +		if (bpf_xdp_skb_ext_load_rx_hash(ctx, &hash, &rss_type) !=3D
> +		    -ENODATA)
> +			reused_bad++;
>  	}
>  	if (bpf_xdp_skb_ext_store_rx_hash(ctx, 1,
> XDP_RSS_TYPE_L4_IPV4_TCP) ||
>  	    bpf_xdp_skb_ext_store_rx_vlan(ctx, bpf_htons(ETH_P_8021Q), 1)
> || @@ -51,7 +57,34 @@ enum xdp_skb_ext_deliver deliver;  struct
> xdp_skb_ext_vals want;  bool del_hash;  struct xdp_skb_ext_have have; -
> int pkts_seen_tc;
> +struct xdp_skb_ext_vals loaded;
> +int pkts_seen_tc, load_err;
> +
> +static void load_all(struct xdp_md *ctx) {
> +	int err;
> +
> +	err =3D bpf_xdp_skb_ext_load_rx_hash(ctx, &loaded.rx_hash,
> +					   &loaded.rx_hash_type);
> +	if (!err)
> +		loaded.fields |=3D SKB_EXT_FIELD_HASH;
> +	else if (err !=3D -ENODATA)
> +		load_err++;
> +
> +	err =3D bpf_xdp_skb_ext_load_rx_vlan(ctx, &loaded.rx_vlan_proto,
> +					   &loaded.rx_vlan_tci);
> +	if (!err)
> +		loaded.fields |=3D SKB_EXT_FIELD_VLAN;
> +	else if (err !=3D -ENODATA)
> +		load_err++;
> +
> +	err =3D bpf_xdp_skb_ext_load_rx_csum(ctx, &loaded.ip_summed,
> +					   &loaded.csum_level);
> +	if (!err)
> +		loaded.fields |=3D SKB_EXT_FIELD_CSUM;
> +	else if (err !=3D -ENODATA)
> +		load_err++;
> +}
>=20
>  SEC("xdp")
>  int xdp_store(struct xdp_md *ctx)
> @@ -99,6 +132,21 @@ int xdp_store(struct xdp_md *ctx)
>  		return bpf_redirect_map(&cpu_map, 0, 0);
>  	if (deliver =3D=3D DELIVER_VETH)
>  		return bpf_redirect(ifindex_out, 0);
> +	load_all(ctx);
> +	return XDP_PASS;
> +}
> +
> +SEC("xdp/cpumap")
> +int cpumap_load(struct xdp_md *ctx)
> +{
> +	load_all(ctx);
> +	return XDP_PASS;
> +}
> +
> +SEC("xdp")
> +int veth_load(struct xdp_md *ctx)
> +{
> +	load_all(ctx);
>  	return XDP_PASS;
>  }
>=20
> diff --git a/tools/testing/selftests/bpf/xdp_skb_ext.h
> b/tools/testing/selftests/bpf/xdp_skb_ext.h
> index 11feee2fa31c..64d4a0511d0a 100644
> --- a/tools/testing/selftests/bpf/xdp_skb_ext.h
> +++ b/tools/testing/selftests/bpf/xdp_skb_ext.h
> @@ -30,7 +30,7 @@ enum xdp_skb_ext_deliver {
>  	DELIVER_VETH,
>  };
>=20
> -/* The entries that the XDP program stores */
> +/* The entries that the XDP programs store or load */
>  struct xdp_skb_ext_vals {
>  	__u32 rx_hash;
>  	__u32 rx_hash_type;
> --
> 2.56.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
