Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD3243F4B4;
	Wed, 12 Aug 2026 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537409; cv=fail; b=YMNKX2bM9KnghQT07lKfR4UMG4A6Q65nMbli7OUMm2PqBDrkvWxKqnlwsvJtv76ms4wYA9dEIL66kDsaxg/aFuGHN1iQsI8aHfNFR7vFLO2oPhIm5H0knMoyXAeQcfx/54dM3KdHxEoYkXo/WlmanOjvpNtcanjaC/WcJGjHUXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537409; c=relaxed/simple;
	bh=sC/oY1ZmGYeqXYRTcCCPvFr1LRDe4/yc6HVTLuIOcko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uU2nSqQ7Srj17ltjlhzLdkZNun5CxbkXDaLrf38ExZGkSPgJurGVOTIxMUjVrp1aoc1xQHbilJva5IhlTsSz4zt3vXLdTP8A5w+hHjRznKzKBgAaoockcfqckxSyv0hnuTNHDfZC/s8PqJZorFYcwo1Poxlco0ToQMoMnZbT0Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=VAJOUOAg; arc=fail smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="VAJOUOAg"
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
	by m0050093.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 67CB7vXx3215338;
	Wed, 12 Aug 2026 13:23:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=apr2026.eng; bh=KLc3xt9E9PGpUllM78jjn6
	CTH/SuNOu376KRvXQ94L0=; b=VAJOUOAg0xVchCaqh1HO6Dj/2elkPNG3VZjjj4
	tC6NAvf2+263XX1JbESOlLnsDaA2lNM8b98AaWkk99BvnIMC11SdZnq6K7D1HXKt
	TZ6w4+etXEWnTHOE/SN5kK5Ba7A/GCX43hstmCJeWribHUeHBssRrvxiaflHvAzr
	J531bRr1Xhn37+u7JFHue/DJpNM/vGBWTZ8l3tGvuoYtgngNKRzeBeXmVlqreelw
	jMYWY/vD+seVjmczfx8kx7juLUIBvCU5G0HKHqGs9W5cYmgxYGcxpfxL3i+MlAD7
	kQtSBxT4SxBmK7CVxu6FypfHo5pH9fE6IyEahyMnKFfTbGjA==
Received: from prod-mail-ppoint2 (prod-mail-ppoint2.akamai.com [184.51.33.19])
	by m0050093.ppops.net-00190b01. (PPS) with ESMTPS id 4fwuqp9aem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 13:23:26 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint2.akamai.com [127.0.0.1])
	by prod-mail-ppoint2.akamai.com (8.18.1.7/8.18.1.7) with ESMTP id 67CCJdXu020367;
	Wed, 12 Aug 2026 08:23:25 -0400
Received: from email.msg.corp.akamai.com ([172.27.91.41])
	by prod-mail-ppoint2.akamai.com (PPS) with ESMTPS id 4fwyswyrvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 08:23:23 -0400 (EDT)
Received: from usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) by
 usma1ex-dag5mb2.msg.corp.akamai.com (172.27.91.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 12 Aug 2026 05:23:20 -0700
Received: from usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) by
 usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 12 Aug 2026 08:23:20 -0400
Received: from BL2PR08CU001.outbound.protection.outlook.com (184.51.33.212) by
 usma1ex-exedge2.msg.corp.akamai.com (172.27.91.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 12 Aug 2026 08:23:20 -0400
Received: from SJ0PR17MB4711.namprd17.prod.outlook.com (2603:10b6:a03:378::6)
 by BY5PR17MB4066.namprd17.prod.outlook.com (2603:10b6:a03:21d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Wed, 12 Aug
 2026 12:23:17 +0000
Received: from SJ0PR17MB4711.namprd17.prod.outlook.com
 ([fe80::bc8:ae55:d179:ebac]) by SJ0PR17MB4711.namprd17.prod.outlook.com
 ([fe80::bc8:ae55:d179:ebac%4]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 12:23:17 +0000
From: "Hudson, Nick" <nhudson@akamai.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 6/6] selftests/bpf: tc_tunnel - validate decap
 GSO and encapsulation state
Thread-Topic: [PATCH bpf-next v7 6/6] selftests/bpf: tc_tunnel - validate
 decap GSO and encapsulation state
Thread-Index: AQHdKjT+y3yxYCdLQUa5GYB/o0DE/raaM90AgAAiYAA=
Date: Wed, 12 Aug 2026 12:23:16 +0000
Message-ID: <606C1D33-B265-4F10-B269-A20D41F8F9F7@akamai.com>
References: <20260812083115.73100-1-nhudson@akamai.com>
 <20260812083115.73100-7-nhudson@akamai.com>
 <20260812102004.BF6001F000E9@smtp.kernel.org>
In-Reply-To: <20260812102004.BF6001F000E9@smtp.kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR17MB4711:EE_|BY5PR17MB4066:EE_
x-ms-office365-filtering-correlation-id: da9aadfa-b3f5-4368-3dfe-08def86c7cf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|6049299003|10070799003|23010399003|1800799024|366016|10067099003|4143699003|56012099006|4053099003|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: tQSe4nvQSXLzMLbhv9OWfoSABr+Pabp8CUutN0zi85BYOmUWOND5ohEImDWz8QMZpAg3p140mOgY9cdLvnmjt5K+ai9n6JNpROk85DgECY6dDvOlDpklyHsC7yQdDjX9ejPYpS59oaMSXIZ1Up0DAjwT0kqKeIbZQlYj41Y8F8xGH73fPpHXc7PVg35UFoP9EVca744MqjJoPfosM/zoNemAF2Eq5KS97QGeqvDWA5tJ9X5UBFF6rQ59e5sEvJTdQFMPVB8ppxzyYJOzAVyoQmKGUlt/QoNxw/hr6CKVgULNYy1Zx9Z9J6Q/4n0tvXtdXXBr+BXH1t8hY0zWFBLJ0ZDo3RoQ1bZuKXbe6CJkOAP8NLb91CKvB1idSiFPLAgUuOVGdzXOrZ9LQai/aFEV5uI9RZoBAEcO2Mv6Ewu4lcJUr7Fk8VPesmQaCe9OPKfr/WUPad3FKj29vkOD7akX3ZIp+B8MHw2Yw9S1xK4Sna8kMTJ62OK6uOOYa9SZ2CptksDo00USUuWQRszuAMgmIX+PVxfm+zp3BbcdhNIsn5wrQvojUZbz36c4RlgU/irLJlgBqsvbN6G8wkd0Fz3AIZ6fBUYO8CV+eqaS0FrEqwE6j3IT/zb7JEGoE2c9ahrGeu4+nEZ6NDxc7bfMTfzx2El9QjVSNS92dvaYiT2YAQFtxzcF/4YyS+KQHO449LJci+iQoPJEwemDHnnf0q0Vjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB4711.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(6049299003)(10070799003)(23010399003)(1800799024)(366016)(10067099003)(4143699003)(56012099006)(4053099003)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VmNCQlVSTFN6NkNTOWp3ZnNYdFJhV3B6YmlnUXhPd2YwNnk0YmRNTnBvMUNZ?=
 =?utf-8?B?SkVmblZQUFNTenJUSnpZeWhwQjE1MVBMdGNTajRQc0YvbTR5UGprcFpyeUtq?=
 =?utf-8?B?UURWbnNqaFBRSVpjRGl4dXZGU0xJQXFtNTQ0Und1akM1QmtoUkRrZU5MdWdz?=
 =?utf-8?B?bGRvTzkwWmkvUTlmZFowbkJUM09Qd0c0Um8xdGM2NW9lL28wKzFUekluanFh?=
 =?utf-8?B?cXVsWGtXeS82MVYvRysrMFJtbnRlajhBaEVIQUZ2UUJuL0NZQU0yNi9yY09m?=
 =?utf-8?B?OUF2U1kvMHhGZTc2TGZUTDlrS3F1WlpGS2JkUGhyN3Z0K1p4cVZZS1ZuSnh5?=
 =?utf-8?B?eWlnUzNxRWphUE9XVVRDb2U4bjZJR0NvbjVXZ00ra2RseUozTHMrNEh3RHZJ?=
 =?utf-8?B?bEoxSkIrcE1EQk5ObXFtcUtieXBiRmZGb3FPZ04yNHM4SUtwWkJwbHVpb2NR?=
 =?utf-8?B?VjA3MmFjdERTMzF2RVprNlFoaWJ0NUF5RVdSU2Q0WWdhSHhBNGphblAzQ051?=
 =?utf-8?B?dGVTdkh5WmxDYTkzTWxHUTl2YmNsalZwK01UQTQ5REpoM2lXRW81MjZrdVhI?=
 =?utf-8?B?VnhQK3dqMVdlNnpZZHV2Q0o5T2xFR1NGTGorU2QrWG4rNkdWWG5YSFdVZTlS?=
 =?utf-8?B?VmZWbnBjeUowMWtHVWl1RGdXdlZkVTVaU09xSE80bTJ4bkozeHZaQ0daWFBu?=
 =?utf-8?B?dmdLdkNhZW9tMHFpaGEydHd4ODBQWHQrU3ZoSitkZTlnS2lkdEFqTHJDeXZy?=
 =?utf-8?B?VlhQOE5mektLMFJIOGtEVWIydXBodXVLZlJsc1VMeHMwOThsM3kreTg5NDh0?=
 =?utf-8?B?bjBaK1hXckdoRHFCNVVVZlcyYTZDMmlKdjFzVnNYLzBPYW5GdXYzQytRVVpW?=
 =?utf-8?B?UDlUcHgvM0IyZW5WVWV1SFVEdzhJUDg0dDNpV2lOY0xWNC82TW5jL1dhNTN1?=
 =?utf-8?B?Njl5Z0JyeVZlUnk1Rmh0WHFWSEZZYUhQOFhsdG5IemlWMURYUzlvcWZ6bm01?=
 =?utf-8?B?bXMyYnRpTG84NTUxVEhSaE9Zc0x4WFIyY0F1N1BDdHdJckRmWC9TWmtOdnhF?=
 =?utf-8?B?a3pKemNvS2g4UTZnMkw5L2xXckVwOStKc1REVDlvR2tTenVEVHArVjFPN05v?=
 =?utf-8?B?OUpJUHNnaUJpaVQwVXg2Q0lncGwrTXgrNmVINlJNbW90RGN4dWx5eFVGZXNy?=
 =?utf-8?B?REkvdHlCSXZuRDY0c0FxOWdNMmQ3cVU2Z0p4QVNsUVJGbHN0MGN6ZGRnSCtz?=
 =?utf-8?B?eWRoR3pXejFVcnhoa25XZkppQUg2ZXB2T0ZsK0llRDlwNlU3T00yd2pXS3RZ?=
 =?utf-8?B?dDBFL2gxS3VBaExaQ1BNcEkwOGFZT0JnbDdhajB1Mnlzb0RQdk91MzFqTWFG?=
 =?utf-8?B?TFdPNFlIdFZWMW1naUJ4VEVRdDFDNlVRNEdWODg5WWVIeWhGTFBiQWJwRW9H?=
 =?utf-8?B?NDNLcHZ2Ny81TTFhSGtrZ3c0dGJFR1h3dDJHWE53dWJZZjA1OHdBdWR3T0pW?=
 =?utf-8?B?K3JzVWhCU29ZeHlvV2lncDlvL05kbGNiaHl4SDlLUXZmVGUwZXlrRnc0ZVRl?=
 =?utf-8?B?ZVNHZzYrdDgyUytaZ3BWUFR3c01QeUJnL3hFNm9RTE5MYTExdmptY24yUHAy?=
 =?utf-8?B?T1gram9QSjBZWmdwNEM4S1BSNTFkR051dzBQWHVTbytFZmlrdWVXYnVQbmtz?=
 =?utf-8?B?c3pjZzIyditnSitEN3hTYzdPQ3ZrUHhDYllLOVFlblBJR0htejk3T1A0cEo4?=
 =?utf-8?B?MytTNUpZSWV5YzBkb2VJakc5N2JOZXd2UGltcWcxZWJJMjlqd2NZQVpOTm8x?=
 =?utf-8?B?NVp3QWNhZ1EvaUlWZVMrVkJPa0VXMWdKV1RNS09ERGFRd1o5V1l4a3lLN0Y3?=
 =?utf-8?B?UmJtNEQ2L0tORmNkNk9meVRKdTloVVF6YTltd3pYV3dVMmg1dkRFdVBpK250?=
 =?utf-8?B?ay9kZStKNWt6MGE3Y3BNaGtkRWRUUkJjWXhvL1ZPS0N0MUNVTE9LRmtCYngx?=
 =?utf-8?B?cHE2MFBhU2l3YXZSNUxkVDNUclF0dTcyaTRPVHhYRFI0Z2JxWndnd1MwOUho?=
 =?utf-8?B?V2JGcTRvVUhXYStTeU5Fa2dabHh4T3orY3BOcFNyS29kaW8rNGNvOHNDeHFV?=
 =?utf-8?B?cUhhSnJGbEs2aWRTY1N0N1Jvck5KTkVwbDY0bktiZEFZUWo3d0RJNG53bXpi?=
 =?utf-8?B?NFRXSm5TbzNSWjk1YUhJTlJmaFdBS2JuUk9pTUxqYkQxMmNwM21KNkpUclNO?=
 =?utf-8?B?bXVmYXRKdWtLcHoxZU1KQkRIbTRLMzBudjRkbGJ5Z3dHOFRBaFd3WGdZVW5o?=
 =?utf-8?B?NjJvajh6bTM5MWRPeVQ1T0JxVm1HbUowQVU3bjY2WWNUOUJTeGZEbTAxUVMx?=
 =?utf-8?Q?ltB1UZV24ZmpyPGiHmnqVXWIDueMQDscpmcJmG7HN5WBL?=
x-ms-exchange-antispam-messagedata-1: k7l5TS+vuctNsA==
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bjCOeOKLD16+1nTzD6enPSc6efMhrWWZgNGGIm/XNYicAj8uNsXTQzK2wGkG/gNEtyubqxWtP9Z7TqI9h68/Sr8b7bWBictwE+Wtsq0b7tQyfm9t35AbmNfO4Bo83NmTWOUUOx/tFYJJeQS0kcULEB3aIIwFan9Jh4Bu1DyTzo4NgVmu+tH15KKvK6/YMB1v6PdRJDJWIX7CcmjgYOCUEi4YOHoUeWQmA9DTdJu6yvznd97jZXM3gc+PSuA4xCJpVGZrKvc6zQYHDCHfmx6TUQuf/Im6sGUKXw6PGpEC9AEez4asN/4bI3VJ37hwYNrogtneZZH0FmnUU03cHOG/MQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGzO4M0YN3cWcfativeFAXB5wyU4hkiho0dkb/UXkg8=;
 b=JST6ja9p4ZGrSrxtnT4ZAoC8x3unkt3sMzJWGOEw0MJ9E46RyMIM5qmITIArXX33HiDhIsPhfmNfCae6hZWrVRMsIiWxxY4zdFYGHVYlK23XTkjS4+d3sJSRp/Ru6U20L/p4BJNDTFfYHkcMbiqGuSGK0IlZmg8E7zPzn/qCSQQTJ89YfC3nKElds5Vq1CF35nKBayHdWdD1gQx/39LeaQdssc0HHoV2d2+GM0dME+nji8+y4dKMBuN7C9iIjF576DDta8dxiacKdDFqa4EiGQO2NinceTI+6Z40CdbxSFZFTj8WyKXieOsytT7ZsMsjLT3+Kiz75GtzzIYNct7crg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=akamai.com; dmarc=pass action=none header.from=akamai.com;
 dkim=pass header.d=akamai.com; arc=none
x-exchange-routingpolicychecked: iH3Iihho02biGW921TwMgBhXupkx9m6ZZZj4opBLXHnRxqiVu02XBuOiPfgZ0xzr1f2RO4+Bp6SXG3ElXCRC3XBEffa6MaM6+AXRncM9pBG111ZIyhQ67cpSYcl6ExtColZeNF9tr3eFOC4WdE7SyInxBojyaVoIAz5JfWxLfyetHEdIefLd5cS02BSQZifC5q+XboIjvBl3vzXEFcITJKfhtsgDWwhPVRaMgVOfPEdMgr064711ovc753OJwpcl+sE2wqFc1kejLjPlfle8yEHnZVo0UnJM+HTV/6iCWDR3ivRMxGhNx1a1Wq7lYjYRkOBUW4CPClDngJFMDSi/lQ==
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: SJ0PR17MB4711.namprd17.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: da9aadfa-b3f5-4368-3dfe-08def86c7cf7
x-ms-exchange-crosstenant-originalarrivaltime: 12 Aug 2026 12:23:16.9784 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 514876bd-5965-4b40-b0c8-e336cf72c743
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: MjxK/Rm4shll3x6cScuDSujNYLTb4/AERly8eXKRH4RaOzMaOe4usOzfpUKnFOooZvKntGT8uEccomxNTaXfwA==
x-ms-exchange-transport-crosstenantheadersstamped: BY5PR17MB4066
Content-Type: multipart/signed;
	boundary="Apple-Mail=_7B8956D9-068E-47B5-96D9-4142EE5210DA";
	protocol="application/pkcs7-signature"; micalg=sha-256
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: akamai.com
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2606160000
 definitions=main-2608120100
X-Proofpoint-ORIG-GUID: HbkwjPHo5aA-AoQIE_L0lNGsVECirUGA
X-Authority-Analysis: v=2.4 cv=b/KCJNGx c=1 sm=1 tr=0 ts=6a7c65bf cx=c_pps
 a=BpD+HMUBsFIkYY1OQe22Yw==:117 a=BpD+HMUBsFIkYY1OQe22Yw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Ifg-1AOnLHOf1gn6spyb:22 a=d4nn1RXdvEacMIURMw2s:22
 a=VwQbUJbxAAAA:8 a=lNLhqd9CESnsoGaXVO4A:9 a=QEXdDO2ut3YA:10
 a=aUQEjLJJORIxqg3IqZUA:9 a=ZVk8-NSrHBgA:10 a=30ssDGKg3p0A:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEwMSBTYWx0ZWRfX1J0qYr2mN7I0
 /smXZCH1iiDIFA5SLsVROG02bHLhMyhNne0HrBRIjRVmbTuw4exI6kT3hZ1OnVJTHJw7wnu7m7N
 LTYb0Oxe4USz22dyrTsGVLmPO8N7szc=
X-Proofpoint-GUID: HbkwjPHo5aA-AoQIE_L0lNGsVECirUGA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEwMSBTYWx0ZWRfX7GLsb1m0ARL3
 NaUsZ6jP+IfW4OZCehJTd6HoIBFuESiDK5Gac60RJYLn1Km20Rskpgp867gECpMEMfCPAZWOe3x
 +UD2FhctH73HfFbubF/wijm9JobKf0xt3d9lTm2pmUK6WFLzXHgLIEOmJ34zgncegY1qSw5WZKS
 Jzr0H9W1z7A6Q2jPCWTk2SzliMr/kpSlMBQZtRqUI5KgIb7gqQsEDbGqcDYgSrsGrTOZFRPxrRI
 vwpC3hon5nxQRmstqNRxXGAe5YEpabhsD9+Z/5cAGN5r+A/b1zgd+BAEAKfYR/uVEDWpaqCyv75
 IHXnCc+n9Z1e7JQy5vAKFQohjFiRmZ68yn+lBq+Vwc2BW+F7ZkslJu8urpg+8yW8EG9Dlm63B5N
 ELU6GLMrmAi7fvp0fmLdg/VyuM0x7wTLOmKnJumSx/gKwaCoHWjMrFCU2dLG2URWhGp5gCl+4NX
 IMW7XORnrphKUkjHs4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606160001 definitions=main-2608120101

--Apple-Mail=_7B8956D9-068E-47B5-96D9-4142EE5210DA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8



> On Aug 12, 2026, at 11:20=E2=80=AFAM, sashiko-bot@kernel.org wrote:
>=20
> [Severity: Medium]
> Does this pointer arithmetic break compilation on 32-bit =
architectures?
>=20
> Since kskb->end is a pointer on 32-bit systems (rather than an integer =
offset
> like it is on 64-bit), adding kskb->head and kskb->end together =
attempts to add
> two pointers, which is invalid in C.
>=20
> Additionally, CO-RE does not translate this pointer-integer addition =
to a single
> pointer dereference when cross-compiled on 64-bit and run on 32-bit =
kernels,
> which can lead to a garbage pointer dereference.
>=20
> Is there a safer way to calculate the skb_shared_info offset in =
decap_internal
> that is portable across both 32-bit and 64-bit architectures?


Martin KaFai Lau previously replied.

"Other tests have been using it to get shinfo already. I would leave it =
as is.
If it really would be needed to run and compile on 32-bit in the future,
it could use bpf_core_field_size(kskb->end) and then do things =
differently.=E2=80=9D

https://lore.kernel.org/all/2026416193859.IJ9_.martin.lau@linux.dev/=

--Apple-Mail=_7B8956D9-068E-47B5-96D9-4142EE5210DA
Content-Disposition: attachment; filename="smime.p7s"
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCCc8w
ggShMIIESKADAgECAhMxAAAAIa0XYPGypwcKAAAAAAAhMAoGCCqGSM49BAMCMD8xITAfBgNVBAoT
GEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEaMBgGA1UEAxMRQWthbWFpQ29ycFJvb3QtRzEwHhcN
MjQxMTIxMTgzNzUyWhcNMzQxMTIxMTg0NzUyWjA8MSEwHwYDVQQKExhBa2FtYWkgVGVjaG5vbG9n
aWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcD
QgAEjkdeMHsSTytADJ7eJ+O+5mpBfm9hVC6Cg9Wf+ER8HXid3E68IHjcCTNFSiezqYclAnIalS1I
cl6hRFZiacQkd6OCAyQwggMgMBIGCSsGAQQBgjcVAQQFAgMBAAEwIwYJKwYBBAGCNxUCBBYEFOa0
4dX2BYnqjkbEVEwLgf7BQJ7ZMB0GA1UdDgQWBBS2N+ieDVUAjPmykf1ahsljEXmtXDCBrwYDVR0g
BIGnMIGkMIGhBgsqAwSPTgEJCQgBATCBkTBYBggrBgEFBQcCAjBMHkoAQQBrAGEAbQBhAGkAIABD
AGUAcgB0AGkAZgBpAGMAYQB0AGUAIABQAHIAYQBjAHQAaQBjAGUAIABTAHQAYQB0AGUAbQBlAG4A
dDA1BggrBgEFBQcCARYpaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNQUy5wZGYw
bAYDVR0lBGUwYwYIKwYBBQUHAwIGCCsGAQUFBwMEBgorBgEEAYI3FAICBgorBgEEAYI3CgMEBgor
BgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAwkGCSsGAQQBgjcVBQYKKwYBBAGCNxQCATAZBgkr
BgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNV
HSMEGDAWgBStAYfq3FmusRM5lU0PV6Akhot7vTCBgAYDVR0fBHkwdzB1oHOgcYYxaHR0cDovL2Fr
YW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNvcnBSb290LUcxLmNybIY8aHR0cDovL2FrYW1haWNy
bC5kZncwMS5jb3JwLmFrYW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3JsMIHIBggrBgEFBQcB
AQSBuzCBuDA9BggrBgEFBQcwAoYxaHR0cDovL2FrYW1haWNybC5ha2FtYWkuY29tL0FrYW1haUNv
cnBSb290LUcxLmNydDBIBggrBgEFBQcwAoY8aHR0cDovL2FrYW1haWNybC5kZncwMS5jb3JwLmFr
YW1haS5jb20vQWthbWFpQ29ycFJvb3QtRzEuY3J0MC0GCCsGAQUFBzABhiFodHRwOi8vYWthbWFp
b2NzcC5ha2FtYWkuY29tL29jc3AwCgYIKoZIzj0EAwIDRwAwRAIgaUoJ7eBk/qNcBVTJW5NC4NsO
6j4/6zQoKeKgOpeiXQUCIGkbSN83n1mMURZIK92KFRtn2X1nrZ7rcNuAQD5bvH1bMIIFJjCCBMyg
AwIBAgITFwALeewU5YRKbvcMWwABAAt57DAKBggqhkjOPQQDAjA8MSEwHwYDVQQKExhBa2FtYWkg
VGVjaG5vbG9naWVzIEluYy4xFzAVBgNVBAMTDkFrYW1haUNsaWVudENBMB4XDTI2MDMyMDEzNDgw
MloXDTI4MDMxOTEzNDgwMlowUDEZMBcGA1UECxMQTWFjQm9vayBQcm8tM1FIVDEQMA4GA1UEAxMH
bmh1ZHNvbjEhMB8GCSqGSIb3DQEJARYSbmh1ZHNvbkBha2FtYWkuY29tMIIBIjANBgkqhkiG9w0B
AQEFAAOCAQ8AMIIBCgKCAQEAx+gvYqVaQAmc/yNlMv3t5CK6FN7++3ZChJpOElnFyZWj3h+VwSqN
5WD4VQn5DL515KovgCiv63DeQ1NuXNu3XKKeakHyssixhIL2hqjlPFnsrwXJ2R9B9hAGIiOBy2rK
Var+w87AFUZ70jsZlI70IBnJOYsPYnZRmXBytTxVWk9V7Nnh10RuUfkZE2Ry+P18Z7glHYoQeksi
hz/9uqRUEqt23qDYBR1J7bB+SSW5A3LmoTEugWYzayxb9iM0vVleEHqeuN5nihGn8Y7nIrs5sIo8
6AG2Bjl0O2VgWWVfqhl9IMQlx1ZxHAicuMvDN49LD1yMkqx+LeBLboiFQQ0MVQIDAQABo4ICzDCC
AsgwCwYDVR0PBAQDAgeAMCkGA1UdJQQiMCAGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNwoD
BDAdBgNVHQ4EFgQUD8PIZa7GFc+oX4RLtUq8oUrOL/IwRgYDVR0RBD8wPaAnBgorBgEEAYI3FAID
oBkMF25odWRzb25AY29ycC5ha2FtYWkuY29tgRJuaHVkc29uQGFrYW1haS5jb20wHwYDVR0jBBgw
FoAUtjfong1VAIz5spH9WobJYxF5rVwwgYAGA1UdHwR5MHcwdaBzoHGGMWh0dHA6Ly9ha2FtYWlj
cmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRDQSgxKS5jcmyGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3
MDEuY29ycC5ha2FtYWkuY29tL0FrYW1haUNsaWVudENBKDEpLmNybDCByAYIKwYBBQUHAQEEgbsw
gbgwPQYIKwYBBQUHMAKGMWh0dHA6Ly9ha2FtYWljcmwuYWthbWFpLmNvbS9Ba2FtYWlDbGllbnRD
QSgxKS5jcnQwSAYIKwYBBQUHMAKGPGh0dHA6Ly9ha2FtYWljcmwuZGZ3MDEuY29ycC5ha2FtYWku
Y29tL0FrYW1haUNsaWVudENBKDEpLmNydDAtBggrBgEFBQcwAYYhaHR0cDovL2FrYW1haW9jc3Au
YWthbWFpLmNvbS9vY3NwMDsGCSsGAQQBgjcVBwQuMCwGJCsGAQQBgjcVCILO5TqHuNQtgYWLB6Lj
IYbSD4FJhaXDEJrVfwIBZAIBUzA1BgkrBgEEAYI3FQoEKDAmMAoGCCsGAQUFBwMCMAoGCCsGAQUF
BwMEMAwGCisGAQQBgjcKAwQwRAYJKoZIhvcNAQkPBDcwNTAOBggqhkiG9w0DAgICAIAwDgYIKoZI
hvcNAwQCAgCAMAcGBSsOAwIHMAoGCCqGSIb3DQMHMAoGCCqGSM49BAMCA0gAMEUCIBZ79THtRc/r
DXpg8rSeL4tPy9/eLjXnJvYW5Ek2SUJ8AiEA5j0Wa0K9P2Vumn7N4F5MpbHW2t/kxsdwUu2Vzp6S
5BUxggHpMIIB5QIBATBTMDwxITAfBgNVBAoTGEFrYW1haSBUZWNobm9sb2dpZXMgSW5jLjEXMBUG
A1UEAxMOQWthbWFpQ2xpZW50Q0ECExcAC3nsFOWESm73DFsAAQALeewwDQYJYIZIAWUDBAIBBQCg
aTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjA4MTIxMjIzMDZa
MC8GCSqGSIb3DQEJBDEiBCBuwhtZJFJ3W7ckTE8sXb8IHe0HS+VgDTyvUvSm3YBojjANBgkqhkiG
9w0BAQsFAASCAQAGSVC4PDHMcltJdj22zPg0G0JSpH8nVrU07KdIvIzIzZNnY1yt2vU84VCkZRz3
YqRANnAhW5LkQkLuGDAIs9IQK/4lqAWo84i3CsaMvZ4q11ejoV9xI7nQxqSDov1w8caGe4I0ikuX
5gAA2rK/zAgmg5VwXNWeDhaazLqVLEwqz/N25IykAGMxEPHmr5OVwoP8/MCvmTx9KOKIZY4lmGGq
KjyvOHEaElwVsdm1pltk7orwyyVJ1K3rVSgAXan7Wk0c/KTaXcTcKc+W7hrpaOzTQc19tZY5Kn8J
skqtx+2ldm9rnfmdwnT9VmpNNmSqmXRExmrMRNwpesgyBbRLpJ7HAAAAAAAA

--Apple-Mail=_7B8956D9-068E-47B5-96D9-4142EE5210DA--
