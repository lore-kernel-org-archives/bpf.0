Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F1C41D21E;
	Mon,  5 Oct 2026 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196000; cv=fail; b=tM1tJSdPTfhC7nSvCYpkisEU5Z9eldW3Ky2euAr4qeNMQWK1WeFp28VzQKQwOZfC+FpifgboluCxnSE6JM3yUIFOYUOLPewqDYYhSuxC1GWd4Y2ioQUWx/H507WyMM3mGkyAi5OuD8lTIeQyLNcR5/Gp+gOYj/KibKbW13Qd9aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196000; c=relaxed/simple;
	bh=IOc8c0cP57iXOvzjte0MqACjm+syqgyZAne7C07K9i0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B1OAaZOIt2tiAqNuavnER2DrGyALwagKiUaSgJcI5sJdMsy93oobxyJEvJC1kEM866x7zMVXEuEnV/GDTzSaaYPAaNFxew/JC/FBN0knY+Ou9/RrYJeBRFE4Jg9DauNfwLsgK8onDKA1oiSVpZTqqlWl3o92MHi5uYg0SmjbH50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MqgSVCXR; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MqgSVCXR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791195999; x=1822731999;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IOc8c0cP57iXOvzjte0MqACjm+syqgyZAne7C07K9i0=;
  b=MqgSVCXRlRZr6fwMSw0sCc2zQcxPO8R7yMgh94qR6UgfDL3yG1stgkMl
   5YWFLUTDQcoz4T1rBIgxLyDvG/Vv1DVmskQmugR6uiWWBPULpgCj7SIjH
   09BC2RuvqRpeA31LhazIZuwD2XH1hNoTNK1ppi0Jkw84WkjPQlOub7sRo
   JmXS/o0P+3nhkw8zxSXw7abtcKVn5etX8CBlB2x9k/A5nh1BbmJgY0s1H
   8B1vbHcgUBY9gsACxSkIL/ByXZafC/XjKWocRTvUuYGzbfEh7KOPsxeDk
   EXMsWjATamG1z65UIOumK1W+nfIwdHPpMAdDwnCpuftHQrAZMCgtBhuh5
   Q==;
X-CSE-ConnectionGUID: x67tperRTfuoOceP5hrAqg==
X-CSE-MsgGUID: +WT/QtN2Tequ2Dv5R4S8sA==
X-IronPort-AV: E=McAfee;i="6800,10657,11925"; a="113640974"
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="113640974"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:26:38 -0700
X-CSE-ConnectionGUID: dWrYNvuOSo2LjYpqKw+NDQ==
X-CSE-MsgGUID: h1cCHdztRwafrhxVF7y5qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,141,1787036400"; 
   d="scan'208";a="284671468"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 03:26:37 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:26:37 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 5 Oct 2026 03:26:37 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 5 Oct 2026 03:26:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o0+mtzvCDrUNy/G9VpkZrfhlFuRCWecXh1LpOPG2ea0MTBMXlZUaH3N7WSKrxvxL1DNZSHpMG8T3bj0CrmexUN9tQnU8uPE/WY6vy6Ak+3VYfEnS6G6efajtsPdagsiLwg5MVbL3rKYjPYshK6gr1PO/GTgJCCLyx7Ji/JoVUhSWD2kxH2mnOOlfnD0Eg1UnAlRUXSgBB9AGvBqFaTx5HNR1urc1YOVph30aCB1XvkvIdnqsHKq5UTL2X/wHyo2DJjsRzckoaOg0UshegY03CSswPHp4/IBnYqGeV9syy/33LfztHVtWkyUK3QbHT7QKY04gerIED0UmMBnHMl0byA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Al3+t7rtA3VY6t6WkMweNBtS6MVIDZtofPy/asTL7MI=;
 b=eP5/PKfvG8jbeI8Z7GoOB5pcT7/POOCdvmRTnNF9K6Nasu7FpjSmq6iwtyQetu22jGlpzn8CapYVP1l3SL4jNneEnKOsGtfB+cu/PN3FP5i6CPiXIi+KIicRUm1om4AcmadTNlrqcVjCEfbHzoQ5bYfviMsm8tldKEBfIRu2vBN28aBlMwX5F/LsMuw/WnOsOd7rmRDxrF/8BdRUeWH+mt6l18LyWouAQYAAwrfB9WlY/k7IpBglWvF+tfRubCKuWFCv0LDJM7RiUrg56/1YJOmVIzSvG7fAivhiBnfZht0viBn4ropK3+CHC4zyrnehDlN+UASactPqUhbCEVcvgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by MN6PR11MB8220.namprd11.prod.outlook.com (2603:10b6:208:478::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Mon, 5 Oct
 2026 10:26:17 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%6]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 10:26:17 +0000
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
Subject: RE: [PATCH iwl-net 05/10] ice: report VF tx_dropped with tx_errors
 instead of tx_discards
Thread-Topic: [PATCH iwl-net 05/10] ice: report VF tx_dropped with tx_errors
 instead of tx_discards
Thread-Index: AQHdUm841sTogxzfpECywV/kSryXurbuwvTA
Date: Mon, 5 Oct 2026 10:26:17 +0000
Message-ID: <IA3PR11MB8986E52546199D4EB4431014E5962@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-6-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-6-poros@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|MN6PR11MB8220:EE_
x-ms-office365-filtering-correlation-id: 3deef9f5-2cc8-4ac0-6b13-08df22cb1766
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|7416014|38070700021|56012099006|11063799006|10067099003|21046099003|18002099003|22082099003|4143699003;
x-microsoft-antispam-message-info: X+0qEn9VIgJz8p6NsxwViQs51h3/ZNOKXKCoEMn3biK0TX0WT1EeEQtILitLpi70Cn2QXAx/0UiaS8+Uz1xRVglxzXOr5RkKdDxZUX4AobQaDaOGNB4FhZDsKQXpDrHc0GAEqAGi0gm5dU53QnctutiMwM1NWm4OPTwCK+6tMhq8iZ0AeXxvJITMTLMvbki+FnoueW24dar9CEYkz+L7HKc8NSscENRZ3vYbQuomyMvZdANAmJQMDxRjEnIXAiQ5Non26KMEB3kPOJbkK7TFor8thLQBQAW4VOa7GSWmY8ou0xm3R/hly3pJG7L9DssUG+KEWDdHlbx5Em3sD39xdOgRltHIOVp3vYUilv56pkpDLI6QXyRW6IWl9JpeUfAF/ZepctQJvUo6dooOhtSmoe9ZeBLXQ6u2VaZRwau+0gM7T5c5AQFrBjNAhOGt2SJHRym9XCMZ2Vbs3NgA2VUYJFQYM25CGJmircDAQ+HXq9QKxnvXDulLs+mf5zxR+N4ttdqMfUpkMCvsvChNY0+MMiLR0AOw2TgcuS9wzEd0mOdd0ZsEFb8LAo97wYgsDAWn5hErLmZa7jeRgHB6cXWqYYy6IdboZXgdFclk9jCXTDC6meSxPCcx6Tb3oKVw0knlHh57YF/i1ppARjvzJzE9VFIGfsYniPgs+mQINttHPzRWcYI70qIPVWKLvx687FSGk5CYSLZSy59y52eFJR6Gt1Zf7sf4bJoJOi1W2UPkVyc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(38070700021)(56012099006)(11063799006)(10067099003)(21046099003)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UfmBfCyBFMTM9BwNRmCvsm4vIituNrzo4P+IY7uCk40OouWNVTONlgiqtISn?=
 =?us-ascii?Q?m6hSnj99+6soraPTmlM+udF8YHHEd581Vpr4ccQHnMKy2a5IdKUfybl3kFQd?=
 =?us-ascii?Q?ZZ87awH5vPWY4G5CWjVy5ZVc1bQ04otNZ9qdnIujweVCX/Dk274LxhqhSK3L?=
 =?us-ascii?Q?MhVBpjwJmP1SvsHT8y+4lYYV0HLpqv7LiKeUg4RhhZkVAIXq/bRyCtGV0mVm?=
 =?us-ascii?Q?vui6Q+xvcquk4cxJ6BCuw/utS5qBX2sOi7aaEyh04Hcw+XqRa2aoylrqXa9s?=
 =?us-ascii?Q?tZlWV96JMUlOo+9bOpKDiBS/SJ7uWErkKstcwuw/ZmRTZV2YafPkYpKaQSwJ?=
 =?us-ascii?Q?IixNbNa3AnTXWQkE95Qwte+fRo/riByXVew3R5Wdct6vBtLy9iefCQFB7AC0?=
 =?us-ascii?Q?zetOHlJp5BDG+Z8y35t4fCshAJS2eka177chgv4Z2giqW7Ya9Fyc3DBLvY0q?=
 =?us-ascii?Q?IIVbu/6eh2GGMAe72Lu0cgrdmEkj8hiYy5dAdxzZt7qOAdUbf8BBBsHkBlaF?=
 =?us-ascii?Q?6r8wDpWfHy4WVJjBCw9ZpDZ6+2nurmUuC8Lu5x2hDSHM+kUqTKtB+LVl7wyF?=
 =?us-ascii?Q?eRwm60s+wLyWb1AUHvA9Gv8jNu04YsAEpOHEi4lPZfH5khiZfRWBGHr8xRc4?=
 =?us-ascii?Q?nOQjmVzgtlZemMxA0AciSSihxMnAQANFU5NMt5U2y8Ou2Qo4V4xnhJeRBCid?=
 =?us-ascii?Q?U2ONfD3xyVvgXoSDwa87qXiUTbb04r7jBPFmAHYAlFBk23tUgz0tTr/3XPcZ?=
 =?us-ascii?Q?cknfVrzZpo5StRGAPSEYVFbgmU8ugKvVxqRBrAeafGlH6VIt8/EfhMGGNDKi?=
 =?us-ascii?Q?G53xCIsZOeVb/Hqj0RExF1mqIJqyCUAem9govUMIOrxZ/2hXinecxWqAh9QD?=
 =?us-ascii?Q?L2Cbx20w8YcdegQy3++RX/iKsiXzOMFEyCXsjV/qb1jP9w4FgetRrzVg7dNq?=
 =?us-ascii?Q?Z06tpYIgNrQIgamlokwbYWa5dwXE0CkEyzU2LvykdFq5hkpPfJkkSVxDihFM?=
 =?us-ascii?Q?a5ufaYvktwvQe7NnN6zYT69OYz5ujtCHOpHB7PxTbMz4v5DrpsqCjKlSs/4X?=
 =?us-ascii?Q?EjVKNUW6ySmDjae0kN9oJmLOZIX4R+k5cP6Cd8HlIt9Db6SQAGeeH3qwLEya?=
 =?us-ascii?Q?Mbi2Z57zsKH01heWoQ3/v0BvEqNeD682i5tUxbOtbWVjE0s/R3bbU0G4gizE?=
 =?us-ascii?Q?ckRDFWDO8OP2XL/uCHQYcwNMcAF/JGJLrYqXYudOv1g/E+YfRfM9gpRy+eq2?=
 =?us-ascii?Q?6LwRIFEL+jLuCeYgaCBhpjUcIgS3gZPKsY7hajJp4uYQxu8otakRVrqGzkzX?=
 =?us-ascii?Q?EgZbYbwxCJfOTw+ThK13MJmIXDSOxBJ1dLnfsprPLOMrnrNPA6l/aqQPncDh?=
 =?us-ascii?Q?7U4OeftgmD2UNnnm5YDm3xgWXZ+xnYvJjHkBtbHOZpfNaiGxUYnXlWlCNsh+?=
 =?us-ascii?Q?E/U29OCALTeX9iauCSDKh9Lst5vDtULOiAWi8HFC7xFWYC7kPt10ztnT7Vl6?=
 =?us-ascii?Q?98pmrJP89ux+ikvet5QJbkNZqeiQUhIsrhF/7tJiH3b4q6oirIPAkO4SQcxh?=
 =?us-ascii?Q?8ijH0UwdYOl6on7hfXpzvy3GiBorubdeKQei2/Ub+Q59xbtQlpWcPsUfzsxD?=
 =?us-ascii?Q?29p9wU2LX9Td2i09V2Y6ZKNbtB3E1NJU7LSg9NVVmGjeRnkedtRV3JJL+pR0?=
 =?us-ascii?Q?Lxe7MiOkXOUgX9YtaSUxG9+bAQX1Y6YDTuKER6pnpxv4LYrRt8m6tT2xXruR?=
 =?us-ascii?Q?yibw21jGq4BYBi+vEG/SBl0CFfgzh8I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: h7HgT3PpefjOZDpR8UnUs7oL4aAreo1xEtmkvYKFLkvPCIQWDtv95vcGUR+A3BfY7E6+SUWbp8W1EK6txryLtRsh9zlMn6xzF/iOgAvfT18DZBDvuqu59CrGYmf6xgOYbTWkI3g0yqXK6+9/LaoiqeH7Cl17D3hQOYuHjsyVLPkScgGWU/sXklETXeUeu5YY/OTNefVSzngT+SmyGpuaU9xEuONqGbMTmig08Vvsyi8UdAoYZ3djtI+xAnHMVIfoFmft+7TxFOpGGnMhV9lCvQxX00L28ctLbYqO59VXDrZ+tPHEBccQyNZnJuPansl/yWrw9Z/dUwd1BVy952zpqg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3deef9f5-2cc8-4ac0-6b13-08df22cb1766
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2026 10:26:17.6048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QVf7MhuRJ4K6H50XwVKQhYH/bPk7eMukuyh+0RAc8nWqv+0/udSyVnsylzxzuM6S6FmfRIfG1qOGZjmNlTqXtMo/CqbrvmglOcEFAUl+rrI=
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
> Subject: [PATCH iwl-net 05/10] ice: report VF tx_dropped with
> tx_errors instead of tx_discards
>=20
> ice_get_vf_stats() fills tx_dropped from eth_stats.tx_discards, which
> ice_update_eth_stats() never updates because the GLV_TDPC register it
> would come from is not implemented in E810 hardware. The Tx drops of a
> VF, such as switch drops on an anti spoof violation, malicious driver
> drops or TTL expiry, are counted by GLV_TEPC into eth_stats.tx_errors
> instead, so the VF always reports zero dropped packets.
>=20
> With spoof checking on, a VF sending 60 valid frames and 30 frames
> with a forged source MAC shows:
>=20
>   vf 0 ... spoof checking on, link-state auto, trust off
>     TX: bytes  packets   dropped
>           3600       60        0
>=20
> Report tx_errors as tx_dropped, the VF stats have no separate error
> field. With the change the same test reports 30 dropped packets.
>=20
> i40e fixed the same issue in commit 50b2af451597 ("i40e: report VF
> tx_dropped with tx_errors instead of tx_discards").
>=20
> Fixes: 730fdea40bef ("ice: implement VF stats NDO")
> Assisted-by: LLM
> Signed-off-by: Petr Oros <poros@redhat.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sriov.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/ice/ice_sriov.c
> b/drivers/net/ethernet/intel/ice/ice_sriov.c
> index b21279f0f5f1e1..8faddf8ba0d523 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sriov.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sriov.c
> @@ -1640,7 +1640,7 @@ int ice_get_vf_stats(struct net_device *netdev,
> int vf_id,
>  	vf_stats->broadcast  =3D stats->rx_broadcast;
>  	vf_stats->multicast  =3D stats->rx_multicast;
>  	vf_stats->rx_dropped =3D stats->rx_discards;
> -	vf_stats->tx_dropped =3D stats->tx_discards;
> +	vf_stats->tx_dropped =3D stats->tx_errors;
>=20
>  out_put_vf:
>  	ice_put_vf(vf);
> --
> 2.55.0

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

