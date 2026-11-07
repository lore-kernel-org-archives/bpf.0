Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794027202;
	b=fsYISdZNnYSPkqLkhQJ5xDNgFQfHhM4dJ9hjPQfw9fIzDjQ2GUEGbByg4XU/5Lgyw0/W
	 LFII54WSbulKDLSrq6Fre31deMrswMNiN+sYm+4X1OOL5kUfCTw+3Xp2SB6HFDLjfHspN
	 DL3aXloNvNS1w7OUT/1wrZ/vLPrtA6n95raGOa7cODkP8XbgFZQqcVgAePQAckuLItf27
	 03oRw3EoR4V33w3heisJ9gtKjoIT0Ozu4fogU1sPuy1/aYlZnAyRleiyHXhRdV57q5CMR
	 ay3jz3Yj1ZVVXBx5AmIy03jT46hKV9/XuOJpjWUssi0iN+o3KBTNDja+lyG7atFdRNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794027202;
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
	bh=M9DsYL5k0KmdCJDMqYs86snezpUQf6zPqcU3+8p3eTo=;
	b=bP8gOoZFiJzQ684TXcb1+Jo+c9o5yV9nzbIAWTouJ5UMOWJ/xKxPFg1yws+AJ3s8d6pA
	 VPN3vHvmJdJKb+Y9lxFNi0kJRP6Iz+G3rUnf9ck8a6IbMpZhfeLCsPlXhielHbqcYWwKQ
	 MGCY3K9POhl0Lz6P3qGQNoAL8Gt5E/6UEip62RcUiLZ9ea+mA9HNTYxwsyE+3+m68ynpB
	 4OpSP6iZRhV32M1vAAHBEv8lwYALLtpihVGq3wbdc6NZzrhKIGsDJwCsLMzgts/LMzGnt
	 raaB3wMVAL9exlB0gXrZBSI997CZ/2g8fLhIk7u/y5ZasdTps8WEZXuIhA29yhEiUOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="Qgrskk/d";
	arc=pass header.oldest-pass=0 smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0CA606A326;
	Sat,  7 Nov 2026 04:53:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B0CA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Qgrskk/d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794027200; x=1825563200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5+F71iBhge0zochiEjxvl1P4tiZ43J+DXGjHt56ducQ=;
  b=Qgrskk/dpPKsKuxLc0CiZp/n73vIQhj4uk4X3Yn7c3QmkkshE1b5YT1R
   kMc//zdl5UBNKkw7WwhJNozmF1iU0ORJKgkc77CbyYXYBjv7lJO5i8TuL
   5WjPa7RD+IBHCeg8TEzzj5BGJh8gNAbZdXf4LnJMmsQ4l8G3Hk6DmzLrQ
   ppHNMB8IXBTrjR/tN3dCohYTMf6izAHgnzqMvEGDMDq8Uu4zi6jWhFG/O
   mSvCP43xs4WGG1k2itvUBvqj0zRriqOIAsdIlLU8UxqosuzAtuyiHJF3J
   MFGbDXMYPwcA91wHPIjlNGu9ty01L34Ga5Mohcr10KGkekOqs7nb4lyMM
   w==;
X-CSE-ConnectionGUID: sVaKFmy4S8mGQa8IKbzjTA==
X-CSE-MsgGUID: GUKJszzsR+S28iib4vk5yA==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2882059"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2882059"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 20:53:20 -0800
X-CSE-ConnectionGUID: EsuT3PZTROif+bDYF5JehA==
X-CSE-MsgGUID: Kn8YmYwJSxGNxtiFMtsflQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7768843"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 20:53:20 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:53:19 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 20:53:19 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.55)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 20:53:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ytxs2Vc8m36nEogdKm+JXk8knhZ8GK2+MKQ9emr+zh1d5h+02O0SdgCy48vZIzJMhZK7+ErwJ0hJehRvAqTQDJMdJmfPUdllry2hAW0JDXppJv3A6YE/UOD00p6t1AonxQOmu0kp/oJYlyo2JNgatX7bDcjUrxG4cN+9YCr/ZfKknkflsMvkWmKagob8nZf82sYb5sM+F4rW4q/K1QDmEjl3RM1pC3wkA1iRemadSFddgc4d/zAXcKbDroWzDoQTiqe6YncUYvnWysWCzyV9dHBRHQ+49TiY7Rf3ESyjnsdTKdsm962GEYp1hNlhjCu3SvLUTCEMFSxJ+2I1U0nPxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9DsYL5k0KmdCJDMqYs86snezpUQf6zPqcU3+8p3eTo=;
 b=OU+537r02cjZDvx8dSUGLyPTPiaC7j/K2C4Mb2f/5YEENtZnQZ61AMDH9NSO15D3ZPC0LlFGzKdkZl1jEDoKrnb+pC7W6OvZ+EDF8PmV86NLFPXqB/rw1cWK38BZnLz82kaZY5Hl0fi4+RjyBMJ0/v15MngCifbdCec0UrL3VCEWt9QI5kdkKkAwip6FFd95Vd6acV4zHFWAjC2lZT+AZsGpZ0sKzPMvHgWgWfg/KwnCR+1kI6x0wT0zSIiakF62rDbOZiP07uYAKECIaMHW+e6Vy7NxLy7MwcfzMbnNw9nQWjlXqdUg1mkJfM1mjs4KVCCEf/XSMUnCRMEmpsJz+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV1PR11MB8790.namprd11.prod.outlook.com (2603:10b6:408:2b1::16)
 by PH0PR11MB9727.namprd11.prod.outlook.com (2603:10b6:510:399::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Sat, 7 Nov
 2026 04:53:14 +0000
Received: from LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a]) by LV1PR11MB8790.namprd11.prod.outlook.com
 ([fe80::27cb:7a60:19bb:584a%5]) with mapi id 15.21.0592.007; Sat, 7 Nov 2026
 04:53:14 +0000
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
Subject: RE: [PATCH iwl-net 04/10] ice: restore the default XPS map after a
 netdev TC change
Thread-Topic: [PATCH iwl-net 04/10] ice: restore the default XPS map after a
 netdev TC change
Thread-Index: AQHdUm81zeJD44qYo0GjhvKuv6sga7ciQsyQ
Date: Sat, 7 Nov 2026 04:53:14 +0000
Message-ID: <LV1PR11MB8790E16E985E64675FDE65EE90752@LV1PR11MB8790.namprd11.prod.outlook.com>
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
x-ms-traffictypediagnostic: LV1PR11MB8790:EE_|PH0PR11MB9727:EE_
x-ms-office365-filtering-correlation-id: 7f8a7d45-40e6-486a-1029-08df3c8b0864
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|38070700021|11063799006|4143699003|261021121427099003|261022075727099003|56012099006|261022105027099003|261021123027099003|261009223027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|21046099003|18002099003|22082099003|6133799003|10067099003;
x-microsoft-antispam-message-info: P41i5RNu2+DNn+Z4By2SJbIFDFmOo9iNVzpqPBn+JzPJv/7eMfy06IvzFQ2ock6uBvyU4GgOpuh78dFGDQfrh9PPI5yqYBxs+WWq0uwX+koIKFQkTXdWqCRuF2eGwequdpInmnrdlHqSJ55rfzBOcVp3WrmRs1JWGBp621JKAKE5g8bqDeJzf2E9+IXRmidGmRlwaTIZO9yNmP9wSK8J2pOOBMjViby95CfjKiqYE6Df7FxtLni4eQTp0aZa9OXfeduTBwsSR9bFRAtpwqlRwzxrDx5oRfeWXJ3tnQ9CBuiufLkb2Xf8Z8r9cF74QF+lefBK/V6utr80d+DKtm5GFKL9BQEQ1ceyqXrPVKxwc7EWQopdtikIgfaLX53WWNVUo2GfkDix50q0kRAgpkRXEUZ8BcupFw3zhdKJnLdu3RUSXudTd1uei19A9s5fbaCli1Ng51NCH4fo0yZmZJJxfZy/2VsquUUcSh5OsffADtk1NeydeONFec8kS7NANJMYab4g8ZFXxLkUWiUCItGLClZ9roM7uhSLuV5BXeRx9ScVYmByzDH+c6zFgtQUASVJQ9Prz6qk//TkJx6iwEDuusp6fbFKpvZkTwvkRnf+wVprUJID4fS7eJpEwyEkOGhwGVNkWU61yco0gc2zJPsNX2pV3DThfaUL9O9C3Ncaa8SAvUoBxx+ZFS0IdlmR5kVsTNKwkSoQG0ETeN1B7m6/VqzFwFAeJvV/3PhhxzD325Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV1PR11MB8790.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(38070700021)(11063799006)(4143699003)(261021121427099003)(261022075727099003)(56012099006)(261022105027099003)(261021123027099003)(261009223027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(21046099003)(18002099003)(22082099003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EAUqzN3Wiv1CWTKzgRwDxbcWPtdCZilbP1GesilHUIMMgACPP6fkxCSb3Aj+?=
 =?us-ascii?Q?6AJsSRZNHFlW2FLyY3hEjjbYSjlCberMWDmK04LCWEDTW84O6axN4SFfpwJz?=
 =?us-ascii?Q?36tr4XAgk/w0P+kCHQOa/+pmq04cmzEfuHxvNEFaDyC7CyPlEorJ+khVl2hj?=
 =?us-ascii?Q?x/oMpQ1k6YxApOwDiHifncaDNDctsyNEXPiWhzs8Za7pNG+SJCd0a7C0aaYQ?=
 =?us-ascii?Q?qMj59gEbIm59O1HJPpsRPg/FsC82KmMFCHrmSwnEyBisKJIxEGKmNJpkNRLl?=
 =?us-ascii?Q?ICeHcZTytoNlSXEAwlK8vBw3Fqn27bOfwzsXn4jm0n3CDkqsFv4CvNxBr16G?=
 =?us-ascii?Q?HAjGPYi1GS75WIdI169jhbXiUKXTELUvUdWsMfBS4Dx8oOMSl9dds6weKfBM?=
 =?us-ascii?Q?Ery0Ld/4w9KJLplTBTIVQr1M8yhYJnd3ssRStlLCCoYuaS9djZzg7Dh80ln7?=
 =?us-ascii?Q?AHKE9j1vlgsiHF2P6zdIYLx/60QvT2C+wJ3wMYS7c0h+Y7zasju4gwGhd8Ax?=
 =?us-ascii?Q?aPR/KDOlRQqKSwzWkUy0+bLPmo1AA50/7W7DVHos2QHsk98DOdBIVwR/bRtx?=
 =?us-ascii?Q?ieF8cXMH2+l944hicGhaybrUOpn3GlftxwNVUydr9Xvj3GNbbypss90JevZU?=
 =?us-ascii?Q?210JZiqi9KtZg0cVwtkynLgRdmCgvhaOXMhtFpiTXHq5sWLcfH/PInshCD+A?=
 =?us-ascii?Q?Z2Y7gGOIu6amUIkAfoA8hJxRM+aIlym9y5ZiYBZCdsIdnbMkomSsPl/ptPv0?=
 =?us-ascii?Q?vTHEPS4t/CQR9xRyx2rY9Nf3rm1fjdDjRi3g83moKjXRjLU28xZIz4BGeieG?=
 =?us-ascii?Q?1bHqHHl7cHKHyi2rrgGWd3Fp6jXgozzNQL248LzM7x9UOPW+PZVl4/xrrQDg?=
 =?us-ascii?Q?twm1fJkWwpBzBA0ELrpittfza3kz3Exe6HjPGIfzN25abOCsSlcXbDrqrzUY?=
 =?us-ascii?Q?ep6e6lVj7g7qEvhnESvwwXTJTDREY8DB+1UInr4bRRGx8xsXEdmkQmErM8pZ?=
 =?us-ascii?Q?h6u639yh0nEQU2P5Ve1qkDxHiDyqSPBXkCtyP4M7Af6n6zPYA8i+AQeoJB5U?=
 =?us-ascii?Q?PFaAF1H2QQ58d+/W4g6DsKo5SnacUrZpHcyZuurFGtjAY3loZOougpw1+DP9?=
 =?us-ascii?Q?fMcSca1BqvCYa4GjZLF3OinLVp2O1bOogUjYZMq36VpQ2bFV+kxN7AAx1+jQ?=
 =?us-ascii?Q?fD4by/ip9oCV8NOEr4aaIGdL+ofwIi7HmjLRGKH9ROxZtev8H37Jru0sIaXq?=
 =?us-ascii?Q?y4pYG91Q3AkiB4cJ7PWZKX9SfISuOrF6nve4FGIC9TK87zOI8prZJJygsHOQ?=
 =?us-ascii?Q?qWaC1NvGffP/dQoyAQxnOdQrWrT/Yn8EJh+n4GVezgcZaUVauamtosvGHO/P?=
 =?us-ascii?Q?qu5YEiBrtyFtbw/G7qcaW9+408gzh6uGzHyVW8PRgiz8mP9+rBr6AA6JwBnp?=
 =?us-ascii?Q?xA5lD2f3Qb9vTjaxlzIZ717dV4WfV69nyXkPaP0RDknbp48QEWkBqYqGufzs?=
 =?us-ascii?Q?tz2Eomp2u5yKFsKMyTiF+KJNWmHQ5N2r27RpjN0nwOWmTFODU+AiKKJ54t9L?=
 =?us-ascii?Q?KrZcKcnkWQkAcx0HA+260pexHJhzJD1C1NuFitMdVr88D7ZihYLfiy2HG2pq?=
 =?us-ascii?Q?W95E4tn38roZDs0kfDktBGS8Uy1cX26N45hVVPpLOTcrMmgHq5hnTU3Uwn29?=
 =?us-ascii?Q?G+OD5h8Z9QNBgl7mJxladF7e5qKwDrhOysOxI4NoHnrALhqVdmWT1Wssl6uQ?=
 =?us-ascii?Q?vvt2D6B3yA=3D=3D?=
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
X-Exchange-RoutingPolicyChecked: vuzuBnCwQ2wfRxEQzhrLVrNX3ity3HQz7jqoo57y7Zho7eIQZsBHrI4URjELfiIHzDgwpReryOoXAHtz3YvWIPVQTeB/dXFaD7hPH6Ri18OECNU2kTbvdwfRXiqGoXbZzUzbN1/D/j1NTVxsl93j3wvgw2RXt+TN4MEPQC6vKwyMHml1x+4ueG2rlv1mMGL880lPhYN1ABtLYG4ElIfhupVaEKRspyM+9V/PSy9/oGTebH8Ki5FnG2MP5dv/WNtBhuk3ojJYZJYhabiJhDcAb0165Hr5ZIkORM9x9vUXU7M2GevDckWIn4RmUmAlOoqeT7fmrTcM42ThTrR93WQt2w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV1PR11MB8790.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8a7d45-40e6-486a-1029-08df3c8b0864
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2026 04:53:14.8331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pstZZSBkAykCJP3Xa6YjyFZu/GYysvoqM3z/2hJWYGNhLWS6oUevb/QP+smktHYKsmzRl+tsy/gdWEn9oqGaUI8hfUGsB4jrdhujjODnE3Y=
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
> Subject: [PATCH iwl-net 04/10] ice: restore the default XPS map after a n=
etdev TC change
>=20
> ice_cfg_xps_tx_ring() programs the default XPS map only once per ring, gu=
arded by ICE_TX_XPS_INIT_DONE. netdev_reset_tc() and
> netdev_set_num_tc() drop all XPS maps of the device, but the bit is never=
 cleared, so the default map is not programmed again.
>=20
> Since commit 122045ca7704 ("ice: config netdev tc before setting queues
> number") ice_vsi_open() calls ice_vsi_cfg_netdev_tc() after the Tx queues=
 have been configured, so the map is wiped right after it was written on ev=
ery open and stays empty:
>=20
>   # cat /sys/class/net/enp4s0f0np0/queues/tx-*/xps_cpus
>   0000
>   0000
>   ...
>=20
> A DCB reconfiguration ends the same way through ice_vsi_cfg_tc().
>=20
> Clear ICE_TX_XPS_INIT_DONE in ice_vsi_cfg_netdev_tc(), which resets the n=
etdev TC state, and configure the netdev TCs in ice_vsi_open() before the T=
x queues so the default map is applied after the reset, not before it.
>=20
> i40e fixed the same stale bit in commit 82e0572b2302 ("i40e: Fix not sett=
ing default xps_cpus after reset").
>=20
> Fixes: 122045ca7704 ("ice: config netdev tc before setting queues number"=
)
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 6 ++++++  drivers/net/ethern=
et/intel/ice/ice_main.c | 6 +++---
>  2 files changed, 9 insertions(+), 3 deletions(-)

Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
