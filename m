Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794027081;
	b=5Tc+cvTXoNhPb0unkiGBicw/Lrrgwl+8OtZqdVteL4j9W8CXleoS/MbaPDTR0RAlnB96
	 TgkxTRoZj5LabnL5aK59G6P3HoQKr+hQ1xIxP3CENwPxfCnPVm/BvX245Q8G73ubDYqsp
	 zAz85qqb54fvsQnDoMd83Qt3tU7+NFSEh5+gwlaHx6E10A7zxWDCQBttKvfoCgHAUEiTk
	 kUVMmGQD3QTFth1iI8gB7ciNa/sBJpN7m7J5gdgiMgaf/IfJeEqNbmQp8WDfpYOtO1Tag
	 AqMVyR7qU36kdHrZ45OwnTK2ltMV8TQ2zyWcm3iSw53U6lDuzXM2j7MivHbOWPs3ykg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027081;
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
	bh=pf+XelJyTFEJdrnj1UDoOVn84P22KB/uIFHoLOK3Aew=;
	b=I+UBY2m7aWbWUD2S4ck+XAS7IyUHTkcx6eu/nZwgPPkxMMWKTgNnOrMx9n/H7xpSS/m5
	 fsCw4r6qWPxuI1+kiIsBGFIS3qDsRcJZIybdoBBugcxsnA5+wzP/Y/xcGObFqQ1JeLPQ4
	 I507+kSp/bF5BxCFQyZN7RSX7ePslak/tc6pD6d43TmX56RAFlpXeeRnkeDSm32acWxJG
	 HxWDV04VhkuGzVNnFxmCYT8YWizbTBsjX1DlzPvzUoEr/zBqqTMA29Xec4TD4TnoZH1/z
	 GJvBb6mw3sksMkIzdEYKgp/WYVMdzboi4FexWQR/xkw1FtTupJLadIoiXe8aREvw/FA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ubmrnwm1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66693606A326;
	Sat,  7 Nov 2026 04:51:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66693606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Ubmrnwm1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794027080; x=1825563080;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PL8AbQjMj3PJXdsa5AUXO2tJFPhGC/bO96h4jiy3t+Q=;
  b=Ubmrnwm1bl4ySbpjEsFSi9vejn6LJLD4WP0+Dh77wSzOu6f+1O+pIkig
   HMNtqxbQxCuE6+Fa+FeqCVR9tW3rCzMU0L032I0KuxJrJVNGJ/BEeBmt7
   7jxsACm7Q+ESBecjjD7gQlnYVJB5CLJpFBDO5nYpQZjdj3/oN0B9ioJUf
   k/9NJgFasCO7DcvxnvRCyMYU4sHqHKBVrM1z0Emq2+n54AIRaiXpngjDi
   7OrijPmgYkMzIzDBCp9/I2E8+trerO0H8fSMbXyfxb0RjZ7w4dvgEmrzA
   5kdtl3fSUtoufRtpG9rUtpXFKlNDxwv47bxU1ZxwM1OFRyn1zDiKpKlH0
   Q==;
X-CSE-ConnectionGUID: Mzkd+gt6S/ur8jMZvLqCCg==
X-CSE-MsgGUID: Aup0XR6sRxe3v9D3rMfsJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2740972"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2740972"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 20:51:19 -0800
X-CSE-ConnectionGUID: R9JV48KrS1ORNGAhU01row==
X-CSE-MsgGUID: ejLjn/JNQo22w8ORB+nz/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7761212"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 20:51:18 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:51:17 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 20:51:17 -0800
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:51:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEX4wFS8pp0JgaaBZ58tfWZV3TYgcyifJzSZQ5ri74FXuDOljm9DDnvdv+ir4718RWIT63wNIHR2nIZaQC7jbuKADSwYK4fUJrVjpAn7IT+nr/o6KobXOeupIDNGWiITXKi2W8QZYnq3vE0LhA5Lfch/v0xAIrX8b7Qa3mU1nBN6MW4pJ0Ta1fu2yaSh46+H8D0M7mWhqegJoNW2gc8TdAj9I8+iduq0rAObhnj2SgZqLGsMVogZEfYSm8ylS2Q8MNeAYpM7l3iT87+qc49tfaCC8cwac4L+J6LJiCMmBJwFHhxH56WWECsm/97xc4q6i/mVsR/wIhlf6Oitn1TZfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pf+XelJyTFEJdrnj1UDoOVn84P22KB/uIFHoLOK3Aew=;
 b=VqQS4OQK3jrZBfR0N9+VeXwo+E6ANtGlCmUAWHctcqK7JpwCR7u9jGWrRMKlglR7sSmT9t8jvk0JQPnFC3zyewVaMXnfYAZ3TIA6uIQ7px6buRcwe9/OZdKguyViaew3R21qyfJchXU2yDSvsXeXXb8hmyPeVEsg9pStA0m4/BDAKqo0wtWUPfMxY7LWYJptJuhNBXC57qaukKvTs8VworiuIvlFb+gi2izE5XNMZ9aPSL1dj+u12QqKBUwcV2Xw+iJNG5AWxKMxIfQcrcw9LwTcva3gshGYGn9huB123haAsTmWGzv2SV1AVwLCEL8mnYJQKb8kDv0XeXJPgdoUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH0PR11MB9727.namprd11.prod.outlook.com (2603:10b6:510:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Sat, 7 Nov
 2026 04:51:13 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 04:51:13 +0000
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
Subject: RE: [PATCH iwl-net 01/10] ice: replay UDP tunnel ports after a core
 or global reset
Thread-Topic: [PATCH iwl-net 01/10] ice: replay UDP tunnel ports after a core
 or global reset
Thread-Index: AQHdUnCR8NVgYb1VWkWR5w+JFJAcZ7ciQhDw
Date: Sat, 7 Nov 2026 04:51:13 +0000
Message-ID: <LV1PR11MB8790323F9B0D363161F9296F90752@LV1PR11MB8790.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-2-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-2-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH0PR11MB9727:EE_
x-ms-office365-filtering-correlation-id: d15b6263-0be9-4add-2fc3-08df3c8ac002
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|11063799006|4143699003|261021121427099003|261022075727099003|56012099006|261022105027099003|261021123027099003|261021135927099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|21046099003|18002099003|22082099003|10067099003;
x-microsoft-antispam-message-info: dLBoBqQxdSKAbPdtVHjvUOhN2a8VmvW4oQwndZV4upi3bYgQs2pEil5h35bk886jkttE556N1YLZZ2CAgg5KltoS4/5PpWZeWpAYNEwyu65SslxwnsWLLJg6v5UO8JQi9EAQ6E/Y/LXHj7lJacZJ8GYl4qG7RUQqadkZ1ctObRFsqpWFbV1viVVLjX69f8bUxWvaOFBO0Dn2qZX2MgTFkIZqePsKTxNCUId6sGAM539gNU2RxpE5+Kq/Z2OXW94aBeDi8XX9Nmbr51H431RWzjMqiGYlG4dDZ1u/mhBGPQ7F0eTbZu/Ow6+BVIIANQe4RwHxkv8bzxg/I3H8CpV/pC7Z1sOHrrubLi64Bjw5/+yr1QB4AKG+0gIFX1d9o4EWHWcuXCQNtRUXBe2SP8UdOJ72cpMcOta60jS+5dbVxdidEs7MztMQMPB202ZjiDuNp5UQYIsn5DrcbX8Qj8zASvp3BsiFUs88lx5RjK9b9AOWEhTQ2CGbdMK58wtLqZmsSISdM5+I4Fq7jNRAeq9nVWAT7D88vLefZGhTG91QdLXnGJKiUxyGBcwshdklmx9LQTd3ZUBFDigrOhCTyhfFqbJZDuU02o9Lcj3n6H8BABQBiTgIJNxPhalirVKQ+M2S5fBjpWkaMFE27fMCX5dQYxR/G9/HocFaIHn5LJJYWt5G7eDZYRy101HnFYHTvkAkDlMFeFfowmyWpDj9j1wk7ptD7RaE/310kkC3sExIqU4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(11063799006)(4143699003)(261021121427099003)(261022075727099003)(56012099006)(261022105027099003)(261021123027099003)(261021135927099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(21046099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gMt7/xzyUGJJfLbcYT9qHiVLoxMyE+oSE1MJzwTcCeqwtC3EXZCGLbSxuRAG?=
 =?us-ascii?Q?18y2ht1LPVkw6pzvL91blwV954QTMgi2w9LG6ERjEAZQUXbN3CN6W4y1IX/g?=
 =?us-ascii?Q?IwlTQjNhMniVxQA5S4DfCM0AIZ+k+v7GPO1V0qlZvL8LAa8da662kbM0jteU?=
 =?us-ascii?Q?hFx1nzA153pIUuv4AiPCERyFHv42bOrqbOo8sAfwgQypnp70tX2oJT9eIdSM?=
 =?us-ascii?Q?3mvzS+z/ovEbmDEafSaPrUTjzCjT56jG9Naz3tEBhmTlCtqDXKhn/LxwrKT0?=
 =?us-ascii?Q?4tpY9+lBCisundCjCR6fxSFVXkCbjeEoenFpEhZQgKNfYnt59n1f7PvK1LaE?=
 =?us-ascii?Q?mTSPjdhrug3gVDZTivoO4TptfRXls1zBNaBfEGDcAx8Cqfm9luCLYAIUlTKF?=
 =?us-ascii?Q?jpg35TZzl10vvneI1m0obd0/6305E0RyUMLgXeM7zUpFCDPECi2Q/r06NaI0?=
 =?us-ascii?Q?0quD0MPWnFw7IRqUiTQESlpL109eWBi8viMA55B5ciDt1A/uspprZrZf+sUg?=
 =?us-ascii?Q?XWSX9lAUEMcQbiqfoeOeibP2W42GAfoUSfyVkhjNzoue98IVP7Sa3WlKn5WW?=
 =?us-ascii?Q?j7WP6XOv43HKfxqAQnWycSMful+zvzaJUAQ47n7wpcETeoR/II/4vKXVFuJ7?=
 =?us-ascii?Q?c+JoZbrxGqJIBvVk/IYi2Ap7ZljKjjnulTuqEWD6N+AgWTBss5DzDd4DJsdB?=
 =?us-ascii?Q?XDF2MxtloDsFm9KJHbbkTX0YCTMUY2aY+JZ/pcv+8iNqpM8doE1TNh7eL71+?=
 =?us-ascii?Q?zY1yRvhrx/e3qcwnBnKIwLiI0ww7R8nWl42eiGFKqLC3piaGaOZsBf1vQkXP?=
 =?us-ascii?Q?V6rEPorAO4MOKC+3WP+Gz17SyzA6BiaFYsRaNvyJwcGqObiOPh2ySjJElD4F?=
 =?us-ascii?Q?3NpXz3STxGodBcAVNtESHxd9u7L7CCl23ycBPmIP7XeuR2p/UDnif9ZNDwjj?=
 =?us-ascii?Q?y2/70GjTikx1USC8T9JPdGwYZCV9eIHzDEUq5uHoKyimWe61yxsXQTdzdBLc?=
 =?us-ascii?Q?xtjzJyvhHjwolxuhoLPaQiSxeiqI+u5YFl3xuaE5BVEl4CtptOhvJEWfPOFi?=
 =?us-ascii?Q?t6PdfhTnSuTtNEGrXIrNx8cselcCunuU8bTvtcIw6Vy/uT3PettSrasSwTwX?=
 =?us-ascii?Q?Y6yLCrUZ+8zlNQPQIfjNWSWGzwwlNRPMIRIT6lDHF7/cBVhjyfo1eiOnNzp7?=
 =?us-ascii?Q?qZpjqUHXZvd6ok1aLUjskJYLBVwAqQMr57juWQ90Fh+OPMMY0d/DhNHMVhoD?=
 =?us-ascii?Q?q+zPJ0fb0+QfmS457BTZ4OurwJOwkbRmC1NfcHcT8/oa39vvw4ngZjwftSjr?=
 =?us-ascii?Q?ieZvnBiL6kgEvAtdde3eF2HoH9SNpBxHW4RZpLMmpWqwL+8t0ianQCaMygqk?=
 =?us-ascii?Q?gUUQwwGK91dx9aKETHjBo/ZPdR8TEZ55i/80hB7J4jIBnYILKjrc1ymAqc/S?=
 =?us-ascii?Q?Wgi6o6vkEFfrTK94C2EFN2ChPwMSMC8oR1xIo4UPaZVeZK61kNZXBgh2mUCP?=
 =?us-ascii?Q?2riACaP1Az/uXpgxSpzZYQ55UCoER5+V/N6PtRiMxhZT0R5cvZa4aT3msCfz?=
 =?us-ascii?Q?2/mK25GLvLCgc2ohE25LlNMo0x3g1cP3zncjlLI1hBxSzpAV/zXhcJ1ENj/x?=
 =?us-ascii?Q?3NoGKssCpjJXM7R4S4nRJz0LOWKQhQ9K5pvd3fBtsXjs1UpWDyxV84mSjWwa?=
 =?us-ascii?Q?XV7mJ332kh2lzk4xilCN/YYdGB301xT5o6NZpwbB6OAAFJeP6u6TLD9bEKPN?=
 =?us-ascii?Q?ON55n72xWA=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: DC7aLIfH/G5rckS4Ne1l0WmNwVrvXofNTUGKoPWVZJrE1pJUEBxOEzPbAzeTQXfIqLIrPKUt+yV7p7gx+wn+0b3/ajNANo4phXMgAhvIwzTVcCE7FFSOFKZDFoOBiVSVlWSAnsEdr04Ii07aX6oILtz7pbgyzRoL1FHScXJmsoXQJwmr9tzdJh+9eorltq8n0tQAhRKD2kJ+rfezx7dqy0dqm+m7UZT8gAgxYtQ/pBDGJ4pDpnbFo2uaLQrEHSrO+0SGpc7dKBxCyiVYf428RwxHk1M3/OK8ahbXOi+K86fd0qFVFl6JzIlLyxvgnhh2P95htpZEpaXl+ep9StBfZw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15b6263-0be9-4add-2fc3-08df3c8ac002
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 04:51:13.3897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mVsrhCvrMhbMUfHk1NqN9oz5e9g2FhgZ/zHFu+utYlbz9ziVI0777ow50s8MFtKg8pcmX7rEaZr5EWJqdno61eu4qAYMmg6jaGENY3olWNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB9727
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
> Subject: [PATCH iwl-net 01/10] ice: replay UDP tunnel ports after a core =
or global reset
>=20
> A CORER, GLOBR or EMPR reloads the DDP package in ice_rebuild() and
> ice_init_pkg_hints() clears hw->tnl, so every offloaded VXLAN and GENEVE =
port is gone from both the boost TCAM and the driver table. The udp_tunnel_=
nic core is never told about it and still considers the ports > programmed,=
 so the Rx tunnel offloads silently stop working after the reset. With VXLA=
N port 4789 offloaded, 64 flows that differ only in the inner headers are s=
pread over all six Rx queues of the test port by RSS, after a CORER they al=
l land in a single queue, the same as without the port. Removing the port l=
ater trips the WARN_ON() in
> ice_destroy_tunnel() because its table entry is no longer valid:
>=20
>   WARNING: ice_flex_pipe.c:524 at ice_udp_tunnel_unset_port+0x56/0x280 [i=
ce]
>   ice 0000:04:00.3 enp4s0f3np3: Error removing UDP tunnel - -5
>   ice 0000:04:00.3 enp4s0f3np3: UDP tunnel port sync failed port 4789 typ=
e vxlan: -5
>=20
> Call udp_tunnel_nic_reset_ntf() once the main VSI is rebuilt so the core =
programs the ports again. A PF reset keeps the package and the table, so it=
 is left alone. No rtnl_lock is needed since commit 1ead7501094c
> ("udp_tunnel: remove rtnl_lock dependency").
>=20
> i40e fixed the same problem in commit 1f190d936948 ("i40e: Reprogram port=
 offloads after reset").
>=20
> Fixes: a4e82a81f573 ("ice: Add support for tunnel offloads")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
