Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793135564;
	b=e+B/mLWVHUAvp1SwYgfQlIetQIEMZMgH4Qa9/69et8blxaZo/kWb6p92tVUR0kqAOXAg
	 tAuH7L/0uPscscVq2P87LBdFyDR102DA4l2Eg9evi6v7XUJUIqIbDNm5vvUaQ4c91F6+0
	 tj/2VgI2oeyj36/reFbedzhO/vY9GX44kdkEVxylNeX2b8Ww+IZ16KzO2PL+gdpmH9wdG
	 487IqGZOVG4A4wYs+lrqyKNyXvMnEGvMiupMpyp4xQChZSX01jmRIkTZloOsdrXbXBTuR
	 /w7l0yr9y2Aq34a3f2swIK0uQV/t1Bj10xfu6Ml5lL4Q+Ph9Of0++KV0axGyIqM2UeQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135564;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=zd7HvmZW+ZF/65nuzzJVcz9xUHKFvGKFqDEQRFhhbK8=;
	b=f02MYz8yu1WHsf0RCwpFfwJmOolw8gKvFsycNIx2j6p0R9ASK/jRTbrkjWs74UddJ5Y2
	 cPLP1gQsgxJWD1zg1xYPhUKV5d+U3HPAap1F2BAcqQ5v+UAWE/8AqOOJudWTVa6h3wEFD
	 EL7YVysSvuWKJkg4Kp52GpeNOHX6BUOorlo7eLjg8FFFRqneQFsn21Zvl5kEVPIBknK18
	 8ORkFe+XYq6Nc0RfP+ZhS/JLKpBSSTKB5vu+2GaPHk172jyvujmdU3PC+UPWkK7EERRbY
	 0oc1krbzeZzIklubyjKImCA0GYfykCHOiFup+eaB6nO8BiNTgP+4f5X6NFaRBqZ/f5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia-bell-labs.com;
	spf=fail smtp.mailfrom=nokia-bell-labs.com;
	dkim=pass header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=dbi1BhJ5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.8
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2368B606A31A;
	Tue, 27 Oct 2026 21:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2368B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=dbi1BhJ5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U4suTeIL0MniojaS/aPT5IqSLICbj1GYZvhht+Y0veTZdvDywlg6v/QWv/0fwQE9e/AFtjVB411Ole1TnOTHF94/OWdDyoy+HfgMy6/i9xN3NNWIpkR6zrRINA0D8Vjt/Tcy7ZqxNlMZpa/gGsWPjKIjqyS58Rdnsj1u/UQi2CCWrbJwqMFGkzrZWOfNdjmTc7boCeN1SPpMl9W2IBSYSXxb/BAxpvZ7l+vIwrj4MwQIpc9D+BvmpxRGNQZ0Bpw87/NISknxZITH/brWG8ZC+Rg22GZKClbCQxIy9uH1An/7PQEL8VbCI7KT4+/Tb33qx9HRYElqXrKp3CJE+aiqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zd7HvmZW+ZF/65nuzzJVcz9xUHKFvGKFqDEQRFhhbK8=;
 b=y7yCI1aMuHgzbr7Oih6Nahk7Rm/ZBwDsGFyL6q+YUPDWlLnXO4mgQcPCGIw+EVWYljckWfjff8V5CRDpvpHB2kreO177mTNGdXNcS/jZ74vze5IgHOnx0n/tSk8H4MxM5QnSMpK6Un0GUD5hI0utZXYX/VDQASdCLwrGWUv8JmfeiXBBaR8sO7eBqknV1N0lBue5nH2Msc+01G0vUK1QTqqJSL5Epn1Wqpz6vxY1FU5I7/KWdBodl4tbD94P5dVPdjXb3VYaPkqx9REW9kxGnbs3TM/RSCDcSo/9NVvZKfwl15qjPR7J8YlmoG9iAvO+bi75BiCsdqHXLmbP9qVGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zd7HvmZW+ZF/65nuzzJVcz9xUHKFvGKFqDEQRFhhbK8=;
 b=dbi1BhJ5yJ3OKXVTRwSlM/lRH99eQnzIL+sRL/9dQNm1gjAqvPYhjvdcRj1E2IaATZZFdWqKTGEANDq7L9N6mGT5pOkRwDQPeCQ3G7TDniggssOgZnqH+NYyREerVhI92LqranSNVi7SiYMXC0XJJjVO3RR7rTFEEzOz//4eu9NElAL1hYW9rBmzXobOg9PYXG89uueHRmoRowYsRVQrIzTgMNaWjvD3bjg9H9VLr3xrlCfBdPNkK611s2pqzv8TvwEzZWTFFS+tuhGHqAPMyHFBFVXlHKE9aS+1PDwclAvRTTkrF8VGBd9dP6dNZJscHtNUPTfeyPPKL8qf0Ndfpg==
Received: from AS2PR07MB9123.eurprd07.prod.outlook.com (2603:10a6:20b:55a::8)
 by WA4PR07MB781042.eurprd07.prod.outlook.com (2603:10a6:1d0:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 21:12:38 +0000
Received: from AS2PR07MB9123.eurprd07.prod.outlook.com
 ([fe80::ddd6:7bad:4de5:5106]) by AS2PR07MB9123.eurprd07.prod.outlook.com
 ([fe80::ddd6:7bad:4de5:5106%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:12:38 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Neal Cardwell <ncardwell@google.com>
CC: "ihor.solodrai@linux.dev" <ihor.solodrai@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "jakub@cloudflare.com"
	<jakub@cloudflare.com>, "jiayuan.chen@linux.dev" <jiayuan.chen@linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
	<andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org"
	<song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"jolsa@kernel.org" <jolsa@kernel.org>, "emil@etsalapatis.com"
	<emil@etsalapatis.com>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "shuah@kernel.org" <shuah@kernel.org>,
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "stephen@networkplumber.org"
	<stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"kuniyu@google.com" <kuniyu@google.com>, "ij@kernel.org" <ij@kernel.org>,
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>,
	"g.white@cablelabs.com" <g.white@cablelabs.com>,
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>,
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>,
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>,
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>,
	"vidhi_goel@apple.com" <vidhi_goel@apple.com>, "Mike_Rudolph@comcast.com"
	<Mike_Rudolph@comcast.com>, "Jeff_Howe@comcast.com" <Jeff_Howe@comcast.com>,
	"srichard@netapp.com" <srichard@netapp.com>, "Olivier Tilmans (Nokia)"
	<olivier.tilmans@nokia.com>
Subject: RE: [PATCH net-next v2 1/3] tcp: accecn: Add ece_delta to rate_sample
Thread-Topic: [PATCH net-next v2 1/3] tcp: accecn: Add ece_delta to
 rate_sample
Thread-Index: AQHdX0XLtKNDi/Fk0EuQQKnROljrjbcE5B0AgA0H0iA=
Date: Tue, 27 Oct 2026 21:12:38 +0000
Message-ID:
 <AS2PR07MB9123BC4A323D8B1BC50773F9A3602@AS2PR07MB9123.eurprd07.prod.outlook.com>
References: <20261018211514.2817293-1-chia-yu.chang@nokia-bell-labs.com>
 <20261018211514.2817293-2-chia-yu.chang@nokia-bell-labs.com>
 <CADVnQy=jqk0vZUsG6JKv44cBbnR5pG5+7Tvacohuz3tzFpF6pQ@mail.gmail.com>
In-Reply-To:
 <CADVnQy=jqk0vZUsG6JKv44cBbnR5pG5+7Tvacohuz3tzFpF6pQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR07MB9123:EE_|WA4PR07MB781042:EE_
x-ms-office365-filtering-correlation-id: 5800ff7b-6e79-4ce9-afb8-08df346f07a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261021130227099003|261021133027099003|261021135927099003|261022075727099003|261022115727099003|10067099003|56012099006|261022113327099003|261026121527099003|6133799003|22082099003|18002099003|261026135527099003|4133799003|11063799006|4143699003|38070700021|261026140227099003|261026130827099003;
x-microsoft-antispam-message-info:
 /iJRqaOu+Nqe+KcBAfDLnSVvn7aRU3J3FTNxJIfwOPr5T1Ck5MKHdEul96QzA/19yES4iGY6dCTTr4P3VfJqi2dOWHj3uqQFS5D8J7m/EfCPff4t92kYTwl4wBee9S7re5V0KIvLYnFQWypoQGi2wV4N5kLa+t9v+aU1jjYu3SGbQpejfUmgIHYfCP2tE5nU/SmZVPzWe9h90r6DXpu0JUNMigaqKTyelwhdrGQ39s1kMYZbOTsp1j6i9kXo1N2kBWy6iLOW/SUBSpJpOFzyDS9RjP/8b15uqQIbgDAP3cqWK9Wk7QbtSMu89PHieewqh3I23DXG/uWhEZ7Io8Wqg0iiW9N0+8URJFYQPZHk+5igkugCsFf3sm89ENeMlRGmktJJ2L74L+BBm/uYy+TR3pQPyefG4LcuthxOsvNngfLtdMHl2ufaHKsmi5gLF+RN4UDBdUH2K4Ci8hwbGHFqJ4SZ890omzIBZ5YTKNNtAhKp//V9IiK/aPTU7GfEZPIiTbH7mYfL9wGCTFd+snwYvlA3jSE9oHwQAIP1rxLqO4uvgQaX53nWGl//q1/gVaZ8Fo5hy6xZ5r7ZRp5skfMLz83zdEYOak0p+9Zc9oXkFexk2PTzO+2hLH4XK+cZbsxjMHzHvL/1IAi9OA3c9T3JHT2UWEkqam15OalyUpxsPR8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR07MB9123.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261021130227099003)(261021133027099003)(261021135927099003)(261022075727099003)(261022115727099003)(10067099003)(56012099006)(261022113327099003)(261026121527099003)(6133799003)(22082099003)(18002099003)(261026135527099003)(4133799003)(11063799006)(4143699003)(38070700021)(261026140227099003)(261026130827099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dC82aWFqN0p4NVFhbGh5TWJ3NW5DaTJ5WUpMdElvRHFSdWlNcGY1dDhlV0dr?=
 =?utf-8?B?Q1NHbmovOGlicmpEdXZJekp5L044MHp0bDhWcWhjREtONlowMlBHS1Y2YUVS?=
 =?utf-8?B?QUZrSW1lZm04dGZHeGRxd1g3eXFGS0tFQ2Q0WHpDSW1VcGJCTFB5NENTTUUz?=
 =?utf-8?B?bTRWck9OWmNNRkN3aTFJSFVGOTI2UE9kbnlreExHN3JKYmtDeHFuTEZ3Snc5?=
 =?utf-8?B?YUowMHIwbnJHWGlhc3ZwSno2Z1dpak5xZ3F4RGoxK2JianJ3NmhEaVk4bHN0?=
 =?utf-8?B?aXFrQ3M4Wmo1ZDFyVlFtOXVZNGliSG11UVVoSjEzblJ5WjR1TTcvSzRsMllt?=
 =?utf-8?B?TFM2bkNpSWQxQzZEdmFuSDVOeTdGZ043bnZpdzNpSGpacHVzcEY2WDZjMHkv?=
 =?utf-8?B?TWdlMm43eEVNbnRiQlc3TERrazdTUU1ITU9rOXlOelFkL0dmWXhFWGlYaHQ3?=
 =?utf-8?B?bTdCSTBVVUNzd2txTjkxcW16NHZ1UTJOZFJPODJjT2dPeWNWL1FGeGQ4UjRO?=
 =?utf-8?B?d29ZVUpiUWljRENpWGtrSkdGMGJlVFdETEJYUDVqK2NjU1ZHNlFsNTBkMWxZ?=
 =?utf-8?B?aGpXdFlzUnpJRVZxTDA5M2tyQW54bHduV05CMWZDK3JJdzE4bDZERkJ5MlZM?=
 =?utf-8?B?NGhRb0tKQWJPeDQvOWpPcjFyVGdZNC9qcEhPc2VUS09RRDZwV01mbTNJemRV?=
 =?utf-8?B?cGZWSkpKZEI3R1BHcU1nM2xSNzdhaW03MEZYT3JJRjBVSzY0M2tHMmNkdVZ2?=
 =?utf-8?B?WkFxdXZDbmhKSnJWWGRxcnFaRDRUM0FPQkMvaW0yNWJWTUdac3d5MEplMkl2?=
 =?utf-8?B?S1Iva0lQNTY3cGx0dHp5ZjdSbDZveUxueHIrZHd0MTVxUWNzMlg1dUVXOWZQ?=
 =?utf-8?B?dnltZ2pEQSt5Ri90MEg3V1dpODhnRFVkMnRid01ybWZtOThmMDFPalNkbFBT?=
 =?utf-8?B?QVY2SXZxRDk4cUxQSHVxalVzTVVFSS9MNXlzS09TM0FjVzlPaVdaTkpJQTdW?=
 =?utf-8?B?V29tNW95cnB3SG8yVUp0V1A2QkcySUwvc1IvTllJdi9ZVklXQmFndUhEb2tl?=
 =?utf-8?B?ejNTajlReEsybmlRcllzcWlWNmppNG8rNWZoelJtekwyZ3pndTgvUDIyRktL?=
 =?utf-8?B?eUVaV0RyWER3bFVwaW5DQzNabWhMTmo2V3RVcFRyUmZsUGdjOEpWbVNmMTBq?=
 =?utf-8?B?U0FpTlN6T09lWlN2am90SzZwVU83emIzV3dPaEY2Q256LzQvVE9NQUl4MFVh?=
 =?utf-8?B?YlhOVjVnUGpjdWVPaEMyQWJrSmRrbjhLcTQvNFlKc3BvSDNaVk4vL0xVS1JM?=
 =?utf-8?B?cGN2MC9qNEVqb21zbUd3enBWQktBMk02elladnp5cVFBOFRaYUR3VFYwcTBr?=
 =?utf-8?B?Zkh6SmVsQXhVU00rM1lwMjBwYXYxb0VzbUlXMTV0VkQ2cm8yM21kdGNsc3pr?=
 =?utf-8?B?T0pyQ21SaVh1cGVXVTVNUHNTWmptbVZOTEo5bS8zQmZXSCszMFF6RGpOYis0?=
 =?utf-8?B?dCtUSkwveTRuVmJGZVdaTnEvcm9KQWI5cHRWMkNNYnlKbktzeDZXSng3WVhk?=
 =?utf-8?B?T2tSRFJIK3BJdmgydWRWeGhLM1Vrb2hNWkMrNGFWK044dnBJRlc0K0dKU0Mr?=
 =?utf-8?B?RHN4YTNFZlNCZkVNWGRxN0ZlOE12TERkYlk1eUJuRWQ3Z3FlTFErc0VaSlZm?=
 =?utf-8?B?V01NaTNSMmpIcXFRT3NPWXcyM3RtV2NmZ0tSM0lZV3JCaC9abVcvQzI5STA1?=
 =?utf-8?B?U3A5K0lXWjl3N3BWMHZtallCWExHVEUzaEQ1L1JwSGJ0NjcvQkNKaUlSdGtw?=
 =?utf-8?B?TW9OREwzSTRhUERvQldvckZ5MTR2TFh4UUZROUhZajJVVWsxUTJ3TVliRzhv?=
 =?utf-8?B?UUVyaXowTkdTRDNBb1d2MGRDbzhkSjlPZ1dmZngwTldWeEVIY2VmUFYxNXY0?=
 =?utf-8?B?U2k5SGljcVdTbDdSVTlxdXdjS3N4NmIyRXpKREpXc09mVXVvT2gwbG1yYmtJ?=
 =?utf-8?B?ZkFydGF0VjY0YTVsWGdkSUt3dnJvMWhtdVJnYUlzU3RrLzhJczc1eTdMY2I4?=
 =?utf-8?B?VzRRN3ZGeDRscVNuM0xLaitoTXgrMVZSTXhyd3l4alBIeUo0ZFR0d3JQK3V1?=
 =?utf-8?B?NFhTZThveTdvRThHNkkycmxXSjE3MitGWkFUS1pqTTBWaHZjTGh6d2dMSHZu?=
 =?utf-8?B?S3plY1Vob2hFZmlDN3djRDI2UGpreEZ5SmlTOUQ1OUZ0bVFXcFJtN2lUeFFr?=
 =?utf-8?B?cVFERzU0ZkRienRJOG95QmlSSVVudWxSaWNYNUdNaTg0TEthTzBuTmI4QzI3?=
 =?utf-8?B?M3YzWk9kN3puSTYyc3RyM05kOHNwdVVqSGlwOTkwOGtiVDYwak11Y0ExSGp2?=
 =?utf-8?Q?NOoTvxsLS7c9mSZI=3D?=
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
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR07MB9123.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5800ff7b-6e79-4ce9-afb8-08df346f07a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 21:12:38.3671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cKzOHp24TgtK3gzkF0QAiRt3QtOtbAZwC8U8/BEeGdFLQLMSQCNIZcM0pVRAv3PZ3B1zIZ/mZunGKtp6mGsXiPnzmhBd8KIqyU0JCyhPuXFKnE54AOowQzKAZWJzE1sN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WA4PR07MB781042

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZWFsIENhcmR3ZWxsIDxuY2Fy
ZHdlbGxAZ29vZ2xlLmNvbT4NCj4gU2VudDogTW9uZGF5LCBPY3RvYmVyIDE5LCAyMDI2IDM6NTQg
UE0NCj4gVG86IENoaWEtWXUgQ2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxs
LWxhYnMuY29tPg0KPiBDYzogaWhvci5zb2xvZHJhaUBsaW51eC5kZXY7IGpvaG4uZmFzdGFiZW5k
QGdtYWlsLmNvbTsgamFrdWJAY2xvdWRmbGFyZS5jb207IGppYXl1YW4uY2hlbkBsaW51eC5kZXY7
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IGFzdEBrZXJuZWwu
b3JnOyBkYW5pZWxAaW9nZWFyYm94Lm5ldDsgYW5kcmlpQGtlcm5lbC5vcmc7IGVkZHl6ODdAZ21h
aWwuY29tOyBtYXJ0aW4ubGF1QGxpbnV4LmRldjsgc29uZ0BrZXJuZWwub3JnOyB5b25naG9uZy5z
b25nQGxpbnV4LmRldjsgam9sc2FAa2VybmVsLm9yZzsgZW1pbEBldHNhbGFwYXRpcy5jb207IGxp
bnV4LWtzZWxmdGVzdEB2Z2VyLmtlcm5lbC5vcmc7IHNodWFoQGtlcm5lbC5vcmc7IGhvcm1zQGtl
cm5lbC5vcmc7IGRzYWhlcm5Aa2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGpoc0Btb2ph
dGF0dS5jb207IHN0ZXBoZW5AbmV0d29ya3BsdW1iZXIub3JnOyBkYXZlbUBkYXZlbWxvZnQubmV0
OyBlZHVtYXpldEBnb29nbGUuY29tOyBhbmRyZXcrbmV0ZGV2QGx1bm4uY2g7IGRvbmFsZC5odW50
ZXJAZ21haWwuY29tOyBrdW5peXVAZ29vZ2xlLmNvbTsgaWpAa2VybmVsLm9yZzsgS29lbiBEZSBT
Y2hlcHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lhLWJlbGwtbGFicy5jb20+OyBn
LndoaXRlQGNhYmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hhbnNzb25AZXJpY3Nzb24uY29tOyBt
aXJqYS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmVAYXBwbGUuY29tOyBycy5pZXRm
QGdteC5hdDsgSmFzb25fTGl2aW5nb29kQGNvbWNhc3QuY29tOyB2aWRoaV9nb2VsQGFwcGxlLmNv
bTsgTWlrZV9SdWRvbHBoQGNvbWNhc3QuY29tOyBKZWZmX0hvd2VAY29tY2FzdC5jb207IHNyaWNo
YXJkQG5ldGFwcC5jb207IE9saXZpZXIgVGlsbWFucyAoTm9raWEpIDxvbGl2aWVyLnRpbG1hbnNA
bm9raWEuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHYyIDEvM10gdGNwOiBh
Y2NlY246IEFkZCBlY2VfZGVsdGEgdG8gcmF0ZV9zYW1wbGUNCj4NCj4NCj4gQ0FVVElPTjogVGhp
cyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVuIGNsaWNr
aW5nIGxpbmtzIG9yIG9wZW5pbmcgYXR0YWNobWVudHMuIFNlZSB0aGUgVVJMIG5vay5pdC9leHQg
Zm9yIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24uDQo+DQo+DQo+DQo+IE9uIFN1biwgT2N0IDE4LCAy
MDI2IGF0IDU6MTXigK9QTSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPiB3cm90
ZToNCj4gPg0KPiA+IEZyb206IElscG8gSsOkcnZpbmVuIDxpakBrZXJuZWwub3JnPg0KPg0KPiBU
aGFua3MgZm9yIHRoZSBwYXRjaC4gSSBhZ3JlZSB0aGlzIHdpbGwgYmUgdXNlZnVsIGZvciBjb25n
ZXN0aW9uIGNvbnRyb2wgbW9kdWxlcyB1c2luZyBMNFMgRUNOLiBGb3IgZXhhbXBsZSwgSSBzZWUg
dGhpcyBmaWVsZCBpcyB1c2VkIGJ5IFByYWd1ZSBpbiBodHRwczovL2dpdGh1Yi5jb20vTDRTVGVh
bS9saW51eC9ibG9iL3Rlc3RpbmcvbmV0L2lwdjQvdGNwX3ByYWd1ZS5jDQo+IC4uLi4gaXMgdGhh
dCB0aGUgY3VycmVudCBVUkwgZm9yIHRoZSBjb2RlPw0KDQpIaSBOZWFsLA0KDQpUaGUgY3VycmVu
dCBjb2RlIGlzIGh0dHBzOi8vZ2l0aHViLmNvbS9MNFNUZWFtL2xpbnV4LW5ldC1uZXh0L2Jsb2Iv
dXBzdHJlYW1fbDRzdGVhbS9uZXQvaXB2NC90Y3BfcHJhZ3VlLmMNCj4NCj4gPiBJbmNsdWRlIGVj
aG9lZCBDRSBjb3VudCBpbnRvIHJhdGVfc2FtcGxlLiBSZXBsYWNlIGxvY2FsIGVjbl9jb3VudA0K
PiA+IHZhcmlhYmxlIHdpdGggaXQuDQo+DQo+IEknZCBzdWdnZXN0IGEgY2xlYXJlciBjb21taXQg
bWVzc2FnZSwgbGlrZToNCj4NCj4gSW5jbHVkZSBpbiByYXRlX3NhbXBsZSBhIGNvdW50IG9mIHRo
ZSBudW1iZXIgb2Ygc2VnbWVudHMgdGhhdCB3ZXJlIG5ld2x5IG1hcmtlZCwgb24gdGhpcyBBQ0ss
IGFzIGhhdmluZyBiZWVuIENFIChjb25nZXN0aW9uIGV4cGVyaWVuY2VkKS4NCj4gUmVwbGFjZSBs
b2NhbCBlY25fY291bnQgdmFyaWFibGUgd2l0aCBpdC4gVGhpcyBzaWduYWwgd2lsbCBiZSB1c2Vm
dWwsIGluIHVwY29taW5nIHBhdGNoZXMsIGZvciBjb25nZXN0aW9uIGNvbnRyb2wgbW9kdWxlcywg
bGlrZSBQcmFndWUsIHdoaWNoIHdhbnQgdG8gcHJvY2VzcyBBY2NFQ04tc3R5bGUgRUNOIHNpZ25h
bHMuDQo+DQpJIHdpbGwgdXBkYXRlIGluIHRoZSBuZXh0IHZlcnNpb24gKGFmdGVyIHRoZSBzdWJt
aXNzaW9uIGlzIG9wZW4gYWdhaW4pLg0KPiA+IC0tLSBhL2luY2x1ZGUvbmV0L3RjcC5oDQo+ID4g
KysrIGIvaW5jbHVkZS9uZXQvdGNwLmgNCj4gPiBAQCAtMTM0Niw2ICsxMzQ2LDcgQEAgc3RydWN0
IHJhdGVfc2FtcGxlIHsNCj4gPiAgICAgICAgIGludCAgbG9zc2VzOyAgICAgICAgICAgIC8qIG51
bWJlciBvZiBwYWNrZXRzIG1hcmtlZCBsb3N0IHVwb24gQUNLICovDQo+ID4gICAgICAgICB1MzIg
IGFja2VkX3NhY2tlZDsgICAgICAvKiBudW1iZXIgb2YgcGFja2V0cyBuZXdseSAoUylBQ0tlZCB1
cG9uIEFDSyAqLw0KPiA+ICAgICAgICAgdTMyICBwcmlvcl9pbl9mbGlnaHQ7ICAgLyogaW4gZmxp
Z2h0IGJlZm9yZSB0aGlzIEFDSyAqLw0KPiA+ICsgICAgICAgdTMyICBlY2VfZGVsdGE7ICAgICAg
ICAgLyogaXMgdGhpcyBBQ0sgZWNob2luZyBzb21lIHJlY2VpdmVkIENFPyAqLw0KPg0KPg0KPiBU
aGlzIGNvbW1lbnQgc2VlbXMgaW5jb3JyZWN0LiBJdCBpbXBsaWVzIHRoZSB2YWx1ZSBpcyBhIGJv
b2xlYW4sIGJ1dCBpdCdzIGEgY291bnQuDQo+DQo+IEknZCBzdWdnZXN0IHJlbmFtaW5nIHRoZSBm
aWVsZCBmb3IgY2xhcml0eSwgdG8gc29tZXRoaW5nIGxpa2UgYWNrZWRfc2Fja2VkX2VjZSwgc2lu
Y2UgQUZBSUsgaXQgaXMgdGhlIHN1YnNldCBvZiB0aGUgcGFja2V0cyBpbiBhY2tlZF9zYWNrZWQg
dGhhdCB3ZXJlIG1hcmtlZCBhcyBDRS4NCj4NCj4gU28sIGZvciBjbGFyaXR5L3JlYWRhYmlsaXR5
LCBJJ2Qgc3VnZ2VzdCByZW5hbWluZyBpdCwgYW5kIHBsYWNpbmcgdGhlIGZpZWxkIGltbWVkaWF0
ZWx5IGJlbG93IGFja2VkX3NhY2tlZCwgYW5kIHJld29ya2luZyB0aGUgY29tbWVudCB0byBiZQ0K
PiBsaWtlOg0KPg0KPiAgICAgICAgIHUzMiAgYWNrZWRfc2Fja2VkOyAgICAgIC8qIG51bWJlciBv
ZiBwYWNrZXRzIG5ld2x5IChTKUFDS2VkIHVwb24gQUNLICovDQo+ICAgICAgICAgdTMyICBhY2tl
ZF9zYWNrZWRfZWNlOyAgLyogbnVtYmVyIG9mIHBhY2tldHMgRUNFLW1hcmtlZCB1cG9uIEFDSyAq
Lw0KPg0KVGhhbmtzLCBJIHdpbGwgdXBkYXRlIGluIHRoZSBuZXh0IHZlcnNpb24uDQo+ID4gICAg
ICAgICB1MzIgIGxhc3RfZW5kX3NlcTsgICAgICAvKiBlbmRfc2VxIG9mIG1vc3QgcmVjZW50bHkg
QUNLZWQgcGFja2V0ICovDQo+ID4gICAgICAgICBib29sIGlzX2FwcF9saW1pdGVkOyAgICAvKiBp
cyBzYW1wbGUgZnJvbSBwYWNrZXQgd2l0aCBidWJibGUgaW4gcGlwZT8gKi8NCj4gPiAgICAgICAg
IGJvb2wgaXNfcmV0cmFuczsgICAgICAgIC8qIGlzIHNhbXBsZSBmcm9tIHJldHJhbnNtaXNzaW9u
PyAqLw0KPiA+IGRpZmYgLS1naXQgYS9uZXQvaXB2NC90Y3BfaW5wdXQuYyBiL25ldC9pcHY0L3Rj
cF9pbnB1dC5jIGluZGV4DQo+ID4gMDJlYzBiMDExNmQxLi5hNWE3MzAyMDUwYzQgMTAwNjQ0DQo+
ID4gLS0tIGEvbmV0L2lwdjQvdGNwX2lucHV0LmMNCj4gPiArKysgYi9uZXQvaXB2NC90Y3BfaW5w
dXQuYw0KPiA+IEBAIC01ODgsOSArNTg4LDEwIEBAIHN0YXRpYyB1MzIgX190Y3BfYWNjZWNuX3By
b2Nlc3Moc3RydWN0IHNvY2sgKnNrLCBjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiA+ICAg
ICAgICAgcmV0dXJuIHNhZmVfZGVsdGE7DQo+ID4gIH0NCj4gPg0KPiA+IC1zdGF0aWMgdTMyIHRj
cF9hY2NlY25fcHJvY2VzcyhzdHJ1Y3Qgc29jayAqc2ssIGNvbnN0IHN0cnVjdCBza19idWZmICpz
a2IsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTMyIGRlbGl2ZXJlZF9wa3Rz
LCB1MzIgZGVsaXZlcmVkX2J5dGVzLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHU2NCBwcmlvcl9ieXRlc19hY2tlZCwgaW50ICpmbGFnKQ0KPiA+ICtzdGF0aWMgdm9pZCB0Y3Bf
YWNjZWNuX3Byb2Nlc3Moc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3QgcmF0ZV9zYW1wbGUgKnJzLA0K
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAq
c2tiLCB1MzIgZGVsaXZlcmVkX3BrdHMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHUzMiBkZWxpdmVyZWRfYnl0ZXMsIHU2NCBwcmlvcl9ieXRlc19hY2tlZCwNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50ICpmbGFnKQ0KPiA+ICB7DQo+ID4gICAgICAg
ICBzdHJ1Y3QgdGNwX3NvY2sgKnRwID0gdGNwX3NrKHNrKTsNCj4gPiAgICAgICAgIHUzMiBkZWx0
YTsNCj4gPiBAQCAtNjAwLDExICs2MDEsMTEgQEAgc3RhdGljIHUzMiB0Y3BfYWNjZWNuX3Byb2Nl
c3Moc3RydWN0IHNvY2sgKnNrLCBjb25zdCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLA0KPiA+ICAgICAg
ICAgaWYgKGRlbHRhID4gMCkgew0KPiA+ICAgICAgICAgICAgICAgICB0Y3BfY291bnRfZGVsaXZl
cmVkX2NlKHRwLCBkZWx0YSk7DQo+ID4gICAgICAgICAgICAgICAgICpmbGFnIHw9IEZMQUdfRUNF
Ow0KPiA+ICsgICAgICAgICAgICAgICBycy0+ZWNlX2RlbHRhID0gZGVsdGE7DQo+ID4gICAgICAg
ICAgICAgICAgIC8qIFJlY2FsY3VsYXRlIGhlYWRlciBwcmVkaWN0b3IgKi8NCj4gPiAgICAgICAg
ICAgICAgICAgaWYgKHRwLT5wcmVkX2ZsYWdzKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAg
IHRjcF9mYXN0X3BhdGhfb24odHApOw0KPiA+ICAgICAgICAgfQ0KPiA+IC0gICAgICAgcmV0dXJu
IGRlbHRhOw0KPiA+ICB9DQo+DQo+DQo+IERvZXMgdGhpcyBjb21waWxlPyBEaWQgeW91IHRyeSB0
byBjb21waWxlIHRoaXMgcGF0Y2g/IFRoaXMgcmVtb3ZlcyB0aGUgb25seSAicmV0dXJuIiBzdGF0
ZW1lbnQgZnJvbSBhIGZ1bmN0aW9uIHRoYXQgcmV0dXJucyBhIHZhbHVlLiBMb29rcyBsaWtlIGlu
dmFsaWQgQyB0byBtZS4gOi0pDQpJdCBjb21waWxlcywgYmVjYXVzZSB0aGUgZnVuY3Rpb24gY2Fs
bCBpcyBhbHNvIGNoYW5nZWQgdG8gcmV0dXJuIHZvaWQuDQo+DQo+ID4NCj4gPiAgLyogQnVmZmVy
IHNpemUgYW5kIGFkdmVydGlzZWQgd2luZG93IHR1bmluZy4NCj4gPiBAQCAtNDIyMCw4ICs0MjIx
LDggQEAgc3RhdGljIHZvaWQgdGNwX3htaXRfcmVjb3Zlcnkoc3RydWN0IHNvY2sgKnNrLA0KPiA+
IGludCByZXhtaXQpICB9DQo+ID4NCj4gPiAgLyogUmV0dXJucyB0aGUgbnVtYmVyIG9mIHBhY2tl
dHMgbmV3bHkgYWNrZWQgb3Igc2Fja2VkIGJ5IHRoZSBjdXJyZW50DQo+ID4gQUNLICovIC1zdGF0
aWMgdTMyIHRjcF9uZXdseV9kZWxpdmVyZWQoc3RydWN0IHNvY2sgKnNrLCB1MzIgcHJpb3JfZGVs
aXZlcmVkLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1MzIgZWNuX2NvdW50
LCBpbnQgZmxhZykNCj4gPiArc3RhdGljIHUzMiB0Y3BfbmV3bHlfZGVsaXZlcmVkKHN0cnVjdCBz
b2NrICpzaywgc3RydWN0IHJhdGVfc2FtcGxlICpycywNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdTMyIHByaW9yX2RlbGl2ZXJlZCwgaW50IGZsYWcpDQo+ID4gIHsNCj4gPiAg
ICAgICAgIGNvbnN0IHN0cnVjdCBuZXQgKm5ldCA9IHNvY2tfbmV0KHNrKTsNCj4gPiAgICAgICAg
IHN0cnVjdCB0Y3Bfc29jayAqdHAgPSB0Y3Bfc2soc2spOyBAQCAtNDIzMiw4ICs0MjMzLDggQEAg
c3RhdGljDQo+ID4gdTMyIHRjcF9uZXdseV9kZWxpdmVyZWQoc3RydWN0IHNvY2sgKnNrLCB1MzIg
cHJpb3JfZGVsaXZlcmVkLA0KPiA+DQo+ID4gICAgICAgICBpZiAoZmxhZyAmIEZMQUdfRUNFKSB7
DQo+ID4gICAgICAgICAgICAgICAgIGlmICh0Y3BfZWNuX21vZGVfcmZjMzE2OCh0cCkpDQo+DQo+
DQo+IFRoaXMgKHRjcF9lY25fbW9kZV9yZmMzMTY4KHRwKSkgZXhwcmVzc2lvbiBzZWVtcyB0byBz
dWdnZXN0IHRoYXQgdGhlIHZhbHVlIHdpbGwgbm90IGJlIGF2YWlsYWJsZSBmb3IgQWNjRUNOIGNv
bm5lY3Rpb25zLiBIb3cgd2lsbCBQcmFndWUgdXNlIHRoaXMgcnMtPmVjZV9kZWx0YSBmaWVsZCBp
ZiBpdCdzIG9ubHkgYXZhaWxhYmxlIGZvciByZmMzMTY4IEVDTj8NCj4NCj4gSSBzdWdnZXN0IGFk
ZHJlc3NpbmcgdGhpcyBzbyB0aGF0IHRoZSBycy0+ZWNlX2RlbHRhIGlzIHVwZGF0ZWQgaWYgdGNw
X2Vjbl9tb2RlX2FueSgpLCBhbmQgcHV0dGluZyB0aGF0IGNoYW5nZSBpbiBhIG5ldyBjb21taXQs
IHBsYWNlZCBiZWZvcmUgdGhpcyBjb21taXQgaW4gdGhpcyBwYXRjaCBzZXJpZXMuDQo+DQpUaGlz
IHBhcnQgaXMgZm9yIFJGQzMxNjggRUNOIG1vZGUgb25seSwgdGhlIGFja2VkX3NhY2tlZF9jZSBl
cXVhbHMgZGVsaXZlcmVkIHdoZW4gRkxBR19FQ0UgaXMgcHJlc2VudC4NCkZvciBBY2NFQ04gbW9k
ZSwgaXQgY2FycmllcyB0aGUgZGVyaXZlZCBDRS1tYXJrZWQgcGFja2V0cyBmcm9tIEFjY0VDTiBv
cHRpb25zIG9yIEFDRSBmaWVsZCBiYXNlZCBvbiBSRkM5NzY4IGluIHRjcF9hY2NlY25fcHJvY2Vz
cygpLg0KPiA+DQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgZWNuX2NvdW50ID0gZGVsaXZl
cmVkOw0KPiA+IC0gICAgICAgICAgICAgICBORVRfQUREX1NUQVRTKG5ldCwgTElOVVhfTUlCX1RD
UERFTElWRVJFRENFLCBlY25fY291bnQpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIHJz
LT5lY2VfZGVsdGEgPSBkZWxpdmVyZWQ7DQo+ID4gKyAgICAgICAgICAgICAgIE5FVF9BRERfU1RB
VFMobmV0LCBMSU5VWF9NSUJfVENQREVMSVZFUkVEQ0UsDQo+ID4gKyBycy0+ZWNlX2RlbHRhKTsN
Cj4gPiAgICAgICAgIH0NCj4gPg0KPiA+ICAgICAgICAgcmV0dXJuIGRlbGl2ZXJlZDsNCj4gPiBA
QCAtNDI4OCw3ICs0Mjg5LDcgQEAgc3RhdGljIGludCB0Y3BfYWNrKHN0cnVjdCBzb2NrICpzaywg
Y29uc3Qgc3RydWN0IHNrX2J1ZmYgKnNrYiwgaW50IGZsYWcpDQo+ID4gICAgICAgICBzdHJ1Y3Qg
aW5ldF9jb25uZWN0aW9uX3NvY2sgKmljc2sgPSBpbmV0X2Nzayhzayk7DQo+ID4gICAgICAgICBz
dHJ1Y3QgdGNwX3NvY2sgKnRwID0gdGNwX3NrKHNrKTsNCj4gPiAgICAgICAgIHN0cnVjdCB0Y3Bf
c2Fja3RhZ19zdGF0ZSBzYWNrX3N0YXRlOw0KPiA+IC0gICAgICAgc3RydWN0IHJhdGVfc2FtcGxl
IHJzID0geyAucHJpb3JfZGVsaXZlcmVkID0gMCB9Ow0KPiA+ICsgICAgICAgc3RydWN0IHJhdGVf
c2FtcGxlIHJzID0geyAucHJpb3JfZGVsaXZlcmVkID0gMCwgLmVjZV9kZWx0YSA9IDANCj4gPiAr
IH07DQo+DQo+IEFkZGluZyB0aGUgZWNlX2RlbHRhIGZpZWxkIGhlcmUgaW4gdGhlIGluaXRpYWxp
emVyIGlzIHJlZHVuZGFudC4NCj4NCj4gQWNjb3JkaW5nIHRvIHRoZSBDOTkgc3RhbmRhcmQgKElT
Ty9JRUMgOTg5OToxOTk5LCBTZWN0aW9uIDYuNy45LCBwYXJhZ3JhcGggMjEpLCBpZiBhbiBhZ2dy
ZWdhdGUgb3IgdW5pb24gY29udGFpbnMgZmV3ZXIgaW5pdGlhbGl6ZXJzIHRoYW4gdGhlcmUgYXJl
IG1lbWJlcnMsIHRoZSByZW1haW5pbmcgZmllbGRzIGFyZSBpbXBsaWNpdGx5IGluaXRpYWxpemVk
IHRoZSBzYW1lIGFzIG9iamVjdHMgdGhhdCBoYXZlIHN0YXRpYyBzdG9yYWdlIGR1cmF0aW9uLg0K
PiBXaGVuIHlvdSBleHBsaWNpdGx5IGluaXRpYWxpemUgZXZlbiBhIHNpbmdsZSBzY2FsYXIgZmll
bGQgKHdoZXRoZXIgdG8gemVybyBvciBhbnkgb3RoZXIgdmFsdWUpIHVzaW5nIGEgZGVzaWduYXRl
ZCBpbml0aWFsaXplciwgeW91IHRyaWdnZXIgdGhlIEMgbGFuZ3VhZ2UgcnVsZSBmb3IgcGFydGlh
bCBpbml0aWFsaXphdGlvbi4gQXJpdGhtZXRpYy9TY2FsYXIgdHlwZXMgKGludGVnZXJzLCBmbG9h
dHMpIGFyZSBpbml0aWFsaXplZCB0byAwLg0KPg0KPiBUaGFua3MgYWdhaW4gZm9yIHRoZSBwYXRj
aC4NCj4NCj4gQmVzdCwNCj4gbmVhbA0KVGhhbmtzLCB5b3UgYXJlIHJpZ2h0IGFuZCBJIHdpbGwg
cmVtb3ZlIHRoaXMgcmVkdW5kYW50IGJlaGF2aW9yIGhlcmUuDQoNCkNoaWEtWXUNCg==
