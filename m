Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616755;
	b=IcmxM/VOHNMgjUMyaAPhRaHPcxuyrvUIBMsdFvT3eG0xHtOgV+owTA6Nor70Y49xmABr
	 33TBBHgfrwRUw2f/CKI+rdjKU9Rjx2BPYJX4dpiDR0t41kXedb5CAdv3aButswxDUM/04
	 druY9WtYBi5J4sRA/StsoDOnB+e+LuEFiXcy+CVAApiqTMmXoKh/8HeSiVIBPtS31DVag
	 dWY18Crh3W6n/y/m3y3/V7E8olh9kj1SgXJG3pbq1vd7ehpNVMuVRY/LjzYUA21ErlmRs
	 WQahpvbIu6jvyJXh7LtseiOR3hDJqV0Rty0g5SgQKN8SdeKH6/7J9jsZL+Rc0SL7B3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616755;
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
	bh=/jKPHAv/h4dzNifBtzton1GmHeyQFYBW3uYQriZloLQ=;
	b=FsJ7j6WmvkULvgicVcFPIqR+lV9ApTx51EHaE9nD5brOBKE9ZWdiwBxpjYk1R6pEChAA
	 1SUJSvDeK6DraRNtuGPGM6tgWED0jvlLravyG2DT9/98OooxugJYFCEQwZz4ZraiIFkkc
	 sMsmntOzvJQd4MaaEqgCD2VKEstq/6WUqTXAndwirrlTvur4DKdZObx+Sq/9MGeo7VVYx
	 7KidWV8b5TKM28QCf/uMtSvOoNWucePqX7foW6uGS/6bSO20V7i/1xHKoiqZQfzjkcsTg
	 wvuuP4pQGI6DpSTJDhLsTyKGtUv9UpoayadnCVt0x08Z1zgbHmeMdmMIspXTBLPy5ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M2y2YpTw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7DC606A326;
	Mon,  2 Nov 2026 10:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED7DC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=M2y2YpTw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793616755; x=1825152755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/jKPHAv/h4dzNifBtzton1GmHeyQFYBW3uYQriZloLQ=;
  b=M2y2YpTw1QGumG6gyonMHqj8mD+pBepSdAMPF8OIff4vMcqv2WD7SIdh
   fp8rlQ4WyGF6kqacDMnuCXkC01L51+PHlvFeZD5s4YZdtX7QtU0el1tQz
   KwyPIbgKQlhNhMzYKg543mUJ5hOY2/0Ua/JPjYM8smiEZ/tf/oL7dqk93
   RhuywMeDi0B+C55/ZzmFWvvpVX59TbEulRcfek0KhVTCuVjNoxqRM/b5r
   KYfb93Uxc0p/khvXPTCLD7cbBLwoOBZEfBoDpPCMlC8z7nCqWk7cV6RDp
   4h7Lp7pXRuDpnBUPdGhy2LM3uhc9O1ThcLPgCdGo+BGxFv7oujvoXn3D1
   Q==;
X-CSE-ConnectionGUID: h+9Dcx7CTmKwvVFPNdR/0w==
X-CSE-MsgGUID: 70nmmp2+SRuCjAhEYXMlAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2336322"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2336322"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:52:34 -0800
X-CSE-ConnectionGUID: mp6gmjOHShuQaiBVrwSYDg==
X-CSE-MsgGUID: GI4/WaiLSeqfnx9KlXrX8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7864026"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:52:34 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:52:33 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 2 Nov 2026 02:52:33 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.31) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 2 Nov 2026 02:52:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jw8TsxSfVewEtem57YwvMJ1m5fWU+PZ2D2LSvk1tYlCuc7Q/jzJ6xiYlJ1HR+6G02y2IYSsMou0w91HmWCGKTcpw3pJoiUVWnT1bwqOhYJEScBbCgmwte7D7/fFMpTqwSBe/Ax5nwiJFWWMfGzc/tQjg77oT5NQaKeYOtfe+SdSg3OGWLLzHCiRRehRnC2Z6YsQ77JnN3mjATiytt3kE5tuSTIX4Y0bRfEANFWjObgikPwp5HV4jSpfQ3nJoWNHtswM20Z0LNfCjNb3+MPn5ts/+jvjHp4by17UigRHF9vdNVBYl26zsymEDOK+ZKtFtmXslzPYTJGfVJq0LrTIfEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jKPHAv/h4dzNifBtzton1GmHeyQFYBW3uYQriZloLQ=;
 b=rbmbfQiSLbmBra6VeTdSVsK8pReOajMZXoXcP/FReir3hqiBURKps5hhqetA/HFyPBJig4VEqgMIN2e6kIhXxSBOdRJO2My9Fe8rxpS9fYsbhuyoOwBLZb1zcV8MtHWyOm9ZIIZh3SKw/3dIi7MmvjsLrDe8r8qGqzsob8qz6UHx7FkkPXJ0EdShfvltvJF0nhcbsooR2toQwxwJZHPDAKVeW8A8Xw8BzaELosu9DgD6oauRmK33GP+566RtWg4q6QmirxDDPpM94po3X5BpDsm7rVbqoI7jOozMJiEK0SVvnJMYChsXmlTOJfKah4C9Jdx+r6qmN/kZTNIPFkxplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8985.namprd11.prod.outlook.com (2603:10b6:208:575::17)
 by CY5PR11MB6416.namprd11.prod.outlook.com (2603:10b6:930:34::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 10:52:22 +0000
Received: from IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d]) by IA3PR11MB8985.namprd11.prod.outlook.com
 ([fe80::355c:96ca:a45:dd5d%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 10:52:22 +0000
From: "Romanowski, Rafal" <rafal.romanowski@intel.com>
To: "Vecera, Ivan" <ivecera@redhat.com>, "intel-wired-lan@osuosl.org"
	<intel-wired-lan@osuosl.org>, "Oros, Petr" <poros@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
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
Thread-Index: AQHdUm81y9pXTbq4BU2aXGTKKhZ+MbbrlbqAgC81zdA=
Date: Mon, 2 Nov 2026 10:52:22 +0000
Message-ID: <IA3PR11MB89852F5B2A2F392E34E587A58F6A2@IA3PR11MB8985.namprd11.prod.outlook.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-6-poros@redhat.com>
 <42067B5C-78B8-4580-BAC9-7E03520EB167@redhat.com>
In-Reply-To: <42067B5C-78B8-4580-BAC9-7E03520EB167@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8985:EE_|CY5PR11MB6416:EE_
x-ms-office365-filtering-correlation-id: 11305d21-c9ed-4deb-9677-08df38cf5fe6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|261021123027099003|261021121427099003|261022075727099003|261009223027099003|38070700021|261026121527099003|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003|21046099003;
x-microsoft-antispam-message-info: gfF0K6GvUTp9w3CueZqujFgMole6xZQPzqrJ3vOn2q3XGZCIvkUF4Ic3+UiAonr2nMKDKNQfDWXbiz4kEgpVAHqbEXhaxon3Sms9+M98uU1+860WIfCVZxMETD4vb/3R3pWrCl76pDNXzK/5bCcH4hW0gwEAstjSVnXBmquKqhS+rxcN9tyOfVQD10nVH9HAexpkX+3dKn+q2oRV3Mk9PCoJVU87QDpZZrZV04dnhVqo/F2kIdkuwNYh6tEL8WG5EWI2uACfTjPkpGsHjxfwc5ibR1EDyUMcPGuGObD0sFC7zrlJPlXl8bQlYn5wP8nSF2pl/7nh9S1nbL+Zm3B3zzhnliTM6bSPpccjumFiW0wm80zTII4xc4VWjXk/euhYqyhQKRV/FibYxz8afE7VAhOvMCoEFv2G8pa6K5t6J31Ls3H78FyndbhPc6mXdrgjtyiZ60vrxcvjbJNRN/Ddulkb15NbnZDjBCyiTRJoatVnT5WL99hr/uIJl4zOyJcg/EGFYbcWLoMEBnbDTrHIcbcxnxqojWes0ldrlu4WHJ71AtXYv04DRrHkhWurjAu5gcqFOr0gVcTO4WwBWQtVz09K88lu/Z2eEa64EROpdaAh+Xie5OTHF9WfkqDtROqt1dtLYF6L+tNXnU+VcrcaxTvoa+4d+1mRmwKSMeJiCs3bvLB0n+sJ3uCI3J6UYf93opPd0GH8aL7pN9T3Uev1Tp8pDbN9gi96FDErA81lD24=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8985.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(261021123027099003)(261021121427099003)(261022075727099003)(261009223027099003)(38070700021)(261026121527099003)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003)(21046099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmJmbll5VGdZMjhERHRRRnZ0VHhmMVBCa2wyeTVuUDNIekt1QnVCdE1hZTVI?=
 =?utf-8?B?dTJnQmZ3T0VTenRZSjhoUmk1bFRKQ0lhRnl5UWRIeU9SeW02KzFSZlBCRlZF?=
 =?utf-8?B?SnlRM2J1K0t3cWRQZVhwY3ZPUjJiUTNCcU1BOHdUUWRDeW5xTWxJR0RrK3Nx?=
 =?utf-8?B?b1dqeUZnd1lDRmc0YWRpSVFJbW9OVzNFV3dicmlVOEU0MWVkZUxxRDExL2JU?=
 =?utf-8?B?cGhKR29HWUtwNEVFdlBlWnZRaGpmUUlUUTAvVnRSYzdHNEpIbHBBNFpHQ2ZQ?=
 =?utf-8?B?VWZHRlZNYlpoTWkyeERBQkdtaVNQR1hrZG5qbklaNTdNV0xBVm9NbUMxc2h4?=
 =?utf-8?B?aEd3cGdEYmpIcUpJT3FxWjNXSkhUaXRvWmRpdTBjWnlpUklzZU04Y2F4eTls?=
 =?utf-8?B?NjMzTkRYMm1aUlppcGcwRFh6RlF4cGsxWUtoQUFUWFZTSFovT0ZjUWZUU3ln?=
 =?utf-8?B?Y2ZZZmZONy9BWGtUUkd5Z2ZqZmFEeUhEbUhOMFhpSmZ3eTlDcC9rVFp3RWty?=
 =?utf-8?B?eW1Kb0JkUDZDOTNwU1VQZnBvVDR3Wlp5T0FOVThzQi81NHcrRnRSRnJ2dWhQ?=
 =?utf-8?B?OGZXZ2xFNW15aEdoK1h1UWlsRFNtRSt3dnVrQm5wbnVaejJXcTFud21EYVhE?=
 =?utf-8?B?ODBjQmFRMklBMGZoS3ExSjhqSEFWK2l3REhzbXViM1pEZVVXcVVVcHVMT2du?=
 =?utf-8?B?MTNvWlpaK2ZlSDI1ajFyUm1wd1c0KzdaTzI1ZituYzZ5MkpOZHNYaitvcGZF?=
 =?utf-8?B?UlU0dW45UUhuT0tJZENGY3JRdUtYdE5DdG5sNFZwakxIYWhYRmdMVHlJejlv?=
 =?utf-8?B?QlNmeHBZNzlQMmhjWG5RWjFBZWM1VnFSUGxwanZER1FKS0NaNUFFT05LVXpU?=
 =?utf-8?B?bUFLMWQ1TjVVcnpaS2szVXJ3M0l2bEF5c1hpTE5JTGVNN0JEMXlVdXkrNjlZ?=
 =?utf-8?B?QXlZWWVReE96U3p3YzVBL1dQM2pYaTY1MUxkR1NVWU5IM3JiUDV0SWRPQ3FY?=
 =?utf-8?B?WVJWNGxJcVlzM2sycjRZRFU1UHBBcTFaQkV3aHdxN0o4bnY3Zy9ZWEZobGlD?=
 =?utf-8?B?aDR6ZytWVE55U292RHhFd1ROT2NRWWY4NVhUU3RseWxmbVVVNy9FOWJGWkN2?=
 =?utf-8?B?WnFSaXFrdHI5WWhKNmFCbGdIQVdiTWYvMHlhQ2w5TlY3NGo4WHQ3NEhsYkty?=
 =?utf-8?B?aTBjQVJHeVZ5a0Nvc1lpbElFNU5IOVlxcUpiMDNsK1dEQ3ArM2tSeWQrdjZC?=
 =?utf-8?B?RSsrK0VqM0pZU3lmZTRBRkFNd2FjRGxyZUtUWlB3eTRKakZLUm9na2hzNWlO?=
 =?utf-8?B?bldOb3pOMzNCSmw5eURJcE5PY0lkTml0MGJHRjgxU2l5WWE2MUVOQ3dJaUNJ?=
 =?utf-8?B?TWRrTHFoRStpanZ4R2grVUhDVzRMTXAzbjZWTTMvTXhMREhKdVNXYW1CVDFv?=
 =?utf-8?B?c0kzeG03VEVsbi9jZFllQVMwT3dSeGROeWRCTjRyTkgvU2wxQ25rVGk0enhj?=
 =?utf-8?B?d0Z1ZkhIR2gxSE9NUGFrY05RQ0xWd204MURFdkpKVWNUWnFxT24rTEdGQWth?=
 =?utf-8?B?UVBiOElHR05xQTA1enpEUVkzYnRWUmlxQ054Y2ZLNnV2UzdkMGp0MDd1cTNY?=
 =?utf-8?B?d0tpblk5NE5QYUJuZW5HTnhmbmhFZk9sZXM1RWVINTd1dFNwVnlOQVlMaktu?=
 =?utf-8?B?WnhqdWl0aWNwY0VNa1kvdStSM0dWZ2tZNTdIL2hhSndJSXZBTUU1U0Mva2M4?=
 =?utf-8?B?V3JFSTR6RXJiaHFOdVRDdkpnYmVYNS9sVFBlL1VVN3hOUFJmTkRqTExwNFVP?=
 =?utf-8?B?T2Qva3UzZUxuSzVaLzRZTUIxSWpNZUlkbldIdnE3SU1RYTJHVldseExIdXVF?=
 =?utf-8?B?ZHFoeWZQc2xjelUzelhvZ09YWXkwT3R2YXNCemdZVHdGZ0JVdVh5bTE4b3pt?=
 =?utf-8?B?YVM1NkxNNjlMRmx4RlJSZVBiWm1OWlFOcHJoUmlPMW5sL1FrSmwwMms1U2tm?=
 =?utf-8?B?MmpMMDVIcGpnT2ZHUS8xbURqZjFhbWNtMDk1LzJpV09tcm8xcWhzOG5TaVVz?=
 =?utf-8?B?akQ1MENRcWlmb1BmbFNFTVg1emFIbFFvbEVGQjNxZzZFZlZEMGtSWFR2QWk1?=
 =?utf-8?B?a3c5NXZNdzh1MDhtcGRINk5Ua2huRTdXeU9hdmJpNC9pOW5iTERsSzJJRG1t?=
 =?utf-8?B?L0lGQ1FDaUliN1d2elVEWmZhaWtmWkNiS3hibXZvOWVzTW1wSkRQc3ZYZVB3?=
 =?utf-8?B?NG82b3NGOGxJQVJRcnNvd0FiOWpYOVplMy8zTHZyYzR1S1JxK0lQWVZldE5R?=
 =?utf-8?B?R0JBZWhrY1BCbW9Xdm0zOTVNbTJvdTR5a3NybWZ1ZTJyL3FobG5wUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: M6C80aPLpuSveGBdbcG4jZNlHZiHtOCXYyh37Xp7252ylvEc0wSPPZ6yjN8MRdOwsUUHOMnsvUuHY0HQs1aGW7HX5vrOCk1VUBeqfVIubDW6l/1r64PLKYXmqU7j1AJyVcARkgXFUfFbgpL+OZk8s5VoZAJaS8Xys9D5k1XxcK//+H2our718Ah9awrV6AM5YpvNiNE+wHoVxvfhbLYqIBN0dV6RupL7sqzM5WZeQPmp2RVu4NXDfye7hcnUJonrsYOMVobZ1pDc8II+OuZDEf+Beoqi1ShdeugqEYjLh6lx0wVVN7bXQGgAZ9c0+gEMo7q1NmfEvNGdhECD/cK30Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8985.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11305d21-c9ed-4deb-9677-08df38cf5fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 10:52:22.7813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /20KetvZNZDmaCAOnsHa/Jv7Nv9K09cJwILzIsqP8aOcw++fspUyRVlxVtq5gK9Y3Ckd2Rb1gUxjgFsvDgiUTGJwefj3O/lUMZXCFVFI9l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6416
X-OriginatorOrg: intel.com

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBJdmFuIFZlY2VyYSA8aXZlY2Vy
YUByZWRoYXQuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgT2N0b2JlciAzLCAyMDI2IDExOjU1IEFN
DQo+IFRvOiBpbnRlbC13aXJlZC1sYW5Ab3N1b3NsLm9yZzsgT3JvcywgUGV0ciA8cG9yb3NAcmVk
aGF0LmNvbT47DQo+IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IE5ndXllbiwgQW50aG9u
eSBMIDxhbnRob255Lmwubmd1eWVuQGludGVsLmNvbT47IEtpdHN6ZWwsIFByemVteXNsYXcNCj4g
PHByemVteXNsYXcua2l0c3plbEBpbnRlbC5jb20+OyBBbmRyZXcgTHVubiA8YW5kcmV3K25ldGRl
dkBsdW5uLmNoPjsNCj4gRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJp
YyBEdW1hemV0IDxlZHVtYXpldEBrZXJuZWwub3JnPjsNCj4gSmFrdWIgS2ljaW5za2kgPGt1YmFA
a2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNvbT47IExvYmFraW4sDQo+
IEFsZWtzYW5kZXIgPGFsZWtzYW5kZXIubG9iYWtpbkBpbnRlbC5jb20+OyBBbGV4ZWkgU3Rhcm92
b2l0b3YNCj4gPGFzdEBrZXJuZWwub3JnPjsgRGFuaWVsIEJvcmttYW5uIDxkYW5pZWxAaW9nZWFy
Ym94Lm5ldD47IEplc3BlciBEYW5nYWFyZA0KPiBCcm91ZXIgPGhhd2tAa2VybmVsLm9yZz47IEpv
aG4gRmFzdGFiZW5kIDxqb2huLmZhc3RhYmVuZEBnbWFpbC5jb20+Ow0KPiBTdGFuaXNsYXYgRm9t
aWNoZXYgPHNkZkBmb21pY2hldi5tZT47IEhlbnJ5IFRpZW1hbg0KPiA8aGVucnkudy50aWVtYW5A
aW50ZWwuY29tPjsgQW5pcnVkaCBWZW5rYXRhcmFtYW5hbg0KPiA8YW5pcnVkaC52ZW5rYXRhcmFt
YW5hbkBpbnRlbC5jb20+OyBNaWNoYWwgU3dpYXRrb3dza2kNCj4gPG1pY2hhbC5zd2lhdGtvd3Nr
aUBsaW51eC5pbnRlbC5jb20+OyBKZXNzZSBCcmFuZGVidXJnDQo+IDxqYnJhbmRlYkBrZXJuZWwu
b3JnPjsgUHJlZXRoaSBCYW5hbGEgPHByZWV0aGkuYmFuYWxhQGludGVsLmNvbT47IEtpcmFuIFBh
dGlsDQo+IDxraXJhbi5wYXRpbEBpbnRlbC5jb20+OyBEYW4gTm93bGluIDxkYW4ubm93bGluQGlu
dGVsLmNvbT47IFN0ZXBoZW4NCj4gSGVtbWluZ2VyIDxzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9y
Zz47IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
aXdsLW5ldCAwNS8xMF0gaWNlOiByZXBvcnQgVkYgdHhfZHJvcHBlZCB3aXRoIHR4X2Vycm9ycw0K
PiBpbnN0ZWFkIG9mIHR4X2Rpc2NhcmRzDQo+IA0KPiBPbiBPY3RvYmVyIDIsIDIwMjYgMzowNzo0
NyBQTSBHTVQrMDI6MDAsIFBldHIgT3JvcyA8cG9yb3NAcmVkaGF0LmNvbT4NCj4gd3JvdGU6DQo+
ID5pY2VfZ2V0X3ZmX3N0YXRzKCkgZmlsbHMgdHhfZHJvcHBlZCBmcm9tIGV0aF9zdGF0cy50eF9k
aXNjYXJkcywgd2hpY2gNCj4gPmljZV91cGRhdGVfZXRoX3N0YXRzKCkgbmV2ZXIgdXBkYXRlcyBi
ZWNhdXNlIHRoZSBHTFZfVERQQyByZWdpc3RlciBpdA0KPiA+d291bGQgY29tZSBmcm9tIGlzIG5v
dCBpbXBsZW1lbnRlZCBpbiBFODEwIGhhcmR3YXJlLiBUaGUgVHggZHJvcHMgb2YgYQ0KPiA+VkYs
IHN1Y2ggYXMgc3dpdGNoIGRyb3BzIG9uIGFuIGFudGkgc3Bvb2YgdmlvbGF0aW9uLCBtYWxpY2lv
dXMgZHJpdmVyDQo+ID5kcm9wcyBvciBUVEwgZXhwaXJ5LCBhcmUgY291bnRlZCBieSBHTFZfVEVQ
QyBpbnRvIGV0aF9zdGF0cy50eF9lcnJvcnMNCj4gPmluc3RlYWQsIHNvIHRoZSBWRiBhbHdheXMg
cmVwb3J0cyB6ZXJvIGRyb3BwZWQgcGFja2V0cy4NCj4gPg0KPiA+V2l0aCBzcG9vZiBjaGVja2lu
ZyBvbiwgYSBWRiBzZW5kaW5nIDYwIHZhbGlkIGZyYW1lcyBhbmQgMzAgZnJhbWVzIHdpdGgNCj4g
PmEgZm9yZ2VkIHNvdXJjZSBNQUMgc2hvd3M6DQo+ID4NCj4gPiAgdmYgMCAuLi4gc3Bvb2YgY2hl
Y2tpbmcgb24sIGxpbmstc3RhdGUgYXV0bywgdHJ1c3Qgb2ZmDQo+ID4gICAgVFg6IGJ5dGVzICBw
YWNrZXRzICAgZHJvcHBlZA0KPiA+ICAgICAgICAgIDM2MDAgICAgICAgNjAgICAgICAgIDANCj4g
Pg0KPiA+UmVwb3J0IHR4X2Vycm9ycyBhcyB0eF9kcm9wcGVkLCB0aGUgVkYgc3RhdHMgaGF2ZSBu
byBzZXBhcmF0ZSBlcnJvcg0KPiA+ZmllbGQuIFdpdGggdGhlIGNoYW5nZSB0aGUgc2FtZSB0ZXN0
IHJlcG9ydHMgMzAgZHJvcHBlZCBwYWNrZXRzLg0KPiA+DQo+ID5pNDBlIGZpeGVkIHRoZSBzYW1l
IGlzc3VlIGluIGNvbW1pdCA1MGIyYWY0NTE1OTcgKCJpNDBlOiByZXBvcnQgVkYNCj4gPnR4X2Ry
b3BwZWQgd2l0aCB0eF9lcnJvcnMgaW5zdGVhZCBvZiB0eF9kaXNjYXJkcyIpLg0KPiA+DQo+ID5G
aXhlczogNzMwZmRlYTQwYmVmICgiaWNlOiBpbXBsZW1lbnQgVkYgc3RhdHMgTkRPIikNCj4gPkFz
c2lzdGVkLWJ5OiBMTE0NCj4gPlNpZ25lZC1vZmYtYnk6IFBldHIgT3JvcyA8cG9yb3NAcmVkaGF0
LmNvbT4NCj4gPi0tLQ0KPiA+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2Vfc3Jp
b3YuYyB8IDIgKy0NCj4gPiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gPg0KPiA+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lj
ZS9pY2Vfc3Jpb3YuYw0KPiA+Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pY2UvaWNlX3Ny
aW92LmMNCj4gPmluZGV4IGIyMTI3OWYwZjVmMWUxLi44ZmFkZGY4YmEwZDUyMyAxMDA2NDQNCj4g
Pi0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ljZS9pY2Vfc3Jpb3YuYw0KPiA+Kysr
IGIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWNlL2ljZV9zcmlvdi5jDQo+ID5AQCAtMTY0
MCw3ICsxNjQwLDcgQEAgaW50IGljZV9nZXRfdmZfc3RhdHMoc3RydWN0IG5ldF9kZXZpY2UgKm5l
dGRldiwgaW50DQo+IHZmX2lkLA0KPiA+IAl2Zl9zdGF0cy0+YnJvYWRjYXN0ICA9IHN0YXRzLT5y
eF9icm9hZGNhc3Q7DQo+ID4gCXZmX3N0YXRzLT5tdWx0aWNhc3QgID0gc3RhdHMtPnJ4X211bHRp
Y2FzdDsNCj4gPiAJdmZfc3RhdHMtPnJ4X2Ryb3BwZWQgPSBzdGF0cy0+cnhfZGlzY2FyZHM7DQo+
ID4tCXZmX3N0YXRzLT50eF9kcm9wcGVkID0gc3RhdHMtPnR4X2Rpc2NhcmRzOw0KPiA+Kwl2Zl9z
dGF0cy0+dHhfZHJvcHBlZCA9IHN0YXRzLT50eF9lcnJvcnM7DQo+ID4NCj4gPiBvdXRfcHV0X3Zm
Og0KPiA+IAlpY2VfcHV0X3ZmKHZmKTsNCj4gDQo+IFJldmlld2VkLWJ5OiBJdmFuIFZlY2VyYSA8
aXZlY2VyYUByZWRoYXQuY29tPg0KDQoNClRlc3RlZC1ieTogUmFmYWwgUm9tYW5vd3NraSA8cmFm
YWwucm9tYW5vd3NraUBpbnRlbC5jb20+DQoNCg==
