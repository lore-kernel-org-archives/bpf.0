Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.27
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793135724;
	b=oY7IPGCMgCZqrS1BnoCp7DNcxHc1tmnpnWwSBuEp2bKu7N4NorppuPHh0dixXOuHob/l
	 2W234rwQMme0bP0NCmqacbufwWWiXgG0dwS8nAS9Ad+ZYnrDx1nCgHj8zTUYpJgD4vlcK
	 oGJe8zVNxVKyd9XmL4wFWBN7CzynID/7NWUAQw/qLyL73HXqHXb6TEEnBbhdWmazGqBJq
	 DeNWHw+Vna/D5xqEX9/HJr9dZQuqwyZ6ueJGuLMdFyUZhlv1Paoz1W/xnIrMFq+ZX24iT
	 GwleGqAQSHu0tRfyf598J327eVoihT4F6gNriXSfeX3wZYJLDeQzw0Nzry/hTyvKEHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135724;
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
	bh=OUoJwUeHwPVBd+AtcVTeI/zoyVWnKR1f5xArAVfYylA=;
	b=oLTxINy5CC4kV9bA0lfv1/zwHqyfgCLwFJVf7H8lFpeke80p9q2Y1n5vCvk9Nicxia55
	 SlT2MESU6xdAlpPJXIRUOqjIuFxdNBNbML5Vk0uUSHUWRbizYnU31auapyP0Ace+IUwXP
	 tUwkK4LLQ4zhxl1EoUJIiWfxMNUnNReDaWBhu19NXAJAKQZHPqb5a+VQyQuKMdB6AZCyY
	 69ngN426Y+ORHFAtG3/suEV1/amm7V+hC6t81V1sIyDZrT1moqTyN1b9FumGTuY+Yders
	 8h+DN9Arpl0QUcTrxxWszJG3bm7+Kvt8qiAI3kQXRKEWfzVZVCaQ37gXYuJetx+P8oQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia-bell-labs.com;
	spf=fail smtp.mailfrom=nokia-bell-labs.com;
	dkim=pass header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=n5L+HWjC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.27
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013027.outbound.protection.outlook.com [52.101.72.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA6B606A320;
	Tue, 27 Oct 2026 21:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFA6B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=n5L+HWjC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/ngd3gOGiIiNGsMpH1yBNQXl0QNLnd3BCXY246kP1xk4SCdzrC8FwAGKXrjAeJFgDt9IXDs1U7BWcWNw2Y/ghHkgRFkE1HWqOYpYuq+rvDFVRzFAiJ6/tlh8WTl4obp0j2sTdyUcDZJ5bJmo1OwO+cw2B68dxmBBI7XzOyONoc16NqAQkbhxvh9lqpAI63yJyLX+H5/uJ/kqK0L4mm5JVyIUHTRZJ+KIvDtIcNWcm4fJg11EcRVD5uqolr5avQ/TqluAEV1TplQQ/T0YX0eAwwz4qxIYgtSV3wx2JICKC0Ni5Ssr0WypFnWhTfvSN+jqE2rmwDRZrXR8JPm6TDDXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OUoJwUeHwPVBd+AtcVTeI/zoyVWnKR1f5xArAVfYylA=;
 b=M97ZNMWQRpWPHc0SYY2En5DpfNYy6XiqkIL6ygftqbIbiK/3kchxTjRuT3pMUjJvBc6W9eYWclIl840y6+eF0rqJEBPJTOnYb7o8secnqAqaoyRxXBCoV1hNBhZiwcVe85/TBEJL5W2IVZftfnO33MRyCICWGTJQXQIJ9YeZH7YL3ZdSFYsNnsCYpeNdkhRdu23TBMIC3ZGfqoxmP+65Jdtd0Ox1dMEXdmvs2L+7w0hD2FZOc05EgHNc6g8igAk73dcqgxFtA3LTyvHDzehTAtLy/Sc0I1rqCroGLvcR0JuYkeWoKYyLYqk4PdK64kZ2T+TzTXk8kWJpaZVu25Z6nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUoJwUeHwPVBd+AtcVTeI/zoyVWnKR1f5xArAVfYylA=;
 b=n5L+HWjC1qWO7EGPLn4ScGuoEF9MAnuPAbMKmt/hYO1/c/wAf5AcJruebNui4gMHMLRyKaxOIfiVCgFenJnH3aVy9yEbgNMC+4FdSmxg4BfdfXoRteIznWqChM8RdfZWW8rzZaA0/sF2D87EzFYqpn6IVeYVRIGhMRQxuADFMFZkL5agzSdqKKr74/oqvPqcQTsStuBxAgDilaHgTvkuik63IPbtrHqUUZZKtclXfxDrEVju2dLuM6+u817nnquI4kbR/as3ZBm334uxGyQhOjWJUM1Rov4y5JiXWqUn93C/oJVOuXP9GsvXIHhC4hkmqoz0G2RXwxYbyw7ckqbHQA==
Received: from AS2PR07MB9123.eurprd07.prod.outlook.com (2603:10a6:20b:55a::8)
 by DUZPR07MB9997.eurprd07.prod.outlook.com (2603:10a6:10:4ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.20; Tue, 27 Oct
 2026 21:15:19 +0000
Received: from AS2PR07MB9123.eurprd07.prod.outlook.com
 ([fe80::ddd6:7bad:4de5:5106]) by AS2PR07MB9123.eurprd07.prod.outlook.com
 ([fe80::ddd6:7bad:4de5:5106%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:15:19 +0000
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
	"srichard@netapp.com" <srichard@netapp.com>
Subject: RE: [PATCH net-next v2 2/3] tcp: ECT_1_ESTABLISH identifier for CA
Thread-Topic: [PATCH net-next v2 2/3] tcp: ECT_1_ESTABLISH identifier for CA
Thread-Index: AQHdX0XMLlnxAyC5N0OdKjV7wAuxpbcE/yEAgAzyKWA=
Date: Tue, 27 Oct 2026 21:15:19 +0000
Message-ID:
 <AS2PR07MB91234D3A403CEDDDB1CB537FA3602@AS2PR07MB9123.eurprd07.prod.outlook.com>
References: <20261018211514.2817293-1-chia-yu.chang@nokia-bell-labs.com>
 <20261018211514.2817293-3-chia-yu.chang@nokia-bell-labs.com>
 <CADVnQykcesPYsRFmZGRJm93knNbPnWf81s6qu30g8Et-rYjsYg@mail.gmail.com>
In-Reply-To:
 <CADVnQykcesPYsRFmZGRJm93knNbPnWf81s6qu30g8Et-rYjsYg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR07MB9123:EE_|DUZPR07MB9997:EE_
x-ms-office365-filtering-correlation-id: df3921cf-87a2-490d-b64a-08df346f67aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|22082099003|18002099003|56012099006|261009223027099003|11063799006|261026121527099003|261021133027099003|261026135527099003|261021135927099003|261026130827099003|261021130227099003|261021123027099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|261022115727099003|10067099003|261022113327099003|4143699003|38070700021;
x-microsoft-antispam-message-info:
 jfkaOsSxWGT899klrmvjVEkoX9c9qexOlU2bEvBkHpk4vgplMMhZka6AaVHhnYaACo+XieWP5F4b26aemNOKBd3FMFPWoJtwo1Z3AQfB0zloJB0bjnoBoqIsXqFQjnTpvTb1iDgYMAsmylQecmOuvZbOXTozUL7PmVBI9LujC/lI9A2IsPdUyZWpG8+O6SHskb69ghmyd4aCidSvWFvQbMfDwcGDTnTz2W1BNF4ikhRifCT7bI4vtoFV0HVY9+aaVyslwRgxBNdzqBOMrx0ZTTD0AAAjFMVSO3DVL33CHtyWZMIPPgBiSUzHZentv/a4pQCjYvCRVaSOd3cY6TiSjiUj9rwuXps0zIC2ldT4tN0MjzDQKYpoWg6szmuEV1omxL/GsbY7nRHyHm3LGoMhzGSGKOaIGk+9cCRdVPeQ6P62RiNxlX917yGdWjCRLxzlUYPqGASKWH+BaNziEfCBBcWaIM2ycy0MHdluEf7y5EGydk3y3r6JUCN1hSvZ/P4T0bjO4rWYYua0L/dogjDoOT7iiwNU7ZCt6h/R/pyLPNxwe1MkRNMvV0KXA1/bBir+Xh3j9rxhhXk+Gdg8lO2YXtRK6KVYrjY8jIb9BFdXv7HL81xF8fGOib36MdMrKB3y88ctbxFKL41RaoqQesNMOReq0O5t4xT3Q0EQHnjj5fw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR07MB9123.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(261009223027099003)(11063799006)(261026121527099003)(261021133027099003)(261026135527099003)(261021135927099003)(261026130827099003)(261021130227099003)(261021123027099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261022115727099003)(10067099003)(261022113327099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFpUUnhhKzBaWkhmL3EybFhTQzUyK2pzMDJ5V0p6TVRXUlRlV1JGUGxTcUhD?=
 =?utf-8?B?bVFGK1JkR0NlZFZocjRzM2NzcDVjVnBGWjRkbnJMRllxbDVFa3dwa1BUNXhK?=
 =?utf-8?B?ZWtEUEZDRk9BWC9SeElZOWZ3NUV3OUV3ZXR4ckVIVU5CM0lUSXB6RkdCNFpX?=
 =?utf-8?B?WE91Q3VKQXIxK3hkWU5qa29Hb1RwdUNFeTZmT0xHdGY0YUNucDhHNHpxMHdG?=
 =?utf-8?B?L0NySlVySWRXZzQ2QTZBSGhKbUdYNXQwMEtiT1NNTk9tVmZ0dXhYZWdYcXla?=
 =?utf-8?B?SFpIQ2FlOWs0RGs0WFYvZnFxQWVVbml2VDU4em1qc0xxOENwL2xtdW9kcGVR?=
 =?utf-8?B?YzlyKy82SXRSTmlsK1ZJUGlubWpWdE8wdUJ1MmpNamRzWWNIODhmMG5zVVpL?=
 =?utf-8?B?U3JSLzRGemxWeTZ0dVFNSzMxUkdCTXhvbitsS1UyWE8ycXhLVmJla0lnYkhU?=
 =?utf-8?B?V2VMLzVNVDh3RjY3TzQ1OEpnckV4Qk5PWDJyeE5LLzNhbWZqU2V4SXZ0NktF?=
 =?utf-8?B?bEpMVEVoMGNNdlJNcnBoeXY3YktJMkNVaWpCVDVmUGtrOGxsdFlhTTliRDRk?=
 =?utf-8?B?WVc1RGtMc1pyL1FTQXpqSTlvckxlaFNzZGFGS2lRdjVERko0dkNSNXQ4T3J5?=
 =?utf-8?B?MkQ2ZjJhbGYzUHRwUnpiWmtUSFBvOTNudlFrQ1B5Mi9hUEtQcnQyaVo5K0dk?=
 =?utf-8?B?bjZaUGhDY3BDeEZUZFcrSWQ2bnJGTDNyV2NXUi9OelpBc2ZLM3hoQy81SWxC?=
 =?utf-8?B?Q2JoMlRRbXUrRTRvSzU5MVJTaWt1d3dxVzQrUzlQblV0amhnRGd5ZG9idlBw?=
 =?utf-8?B?QUt5TG16NWo2dGU1MHlNSUR1TUlJcHFRenlJQngybGFKaWhMbHRQS2sreTF1?=
 =?utf-8?B?SUNSdXFFbjVCTzJYVnZTWG9FVGExQlBVNFliRm44UDAzeHFuR21iTmR5Y1BM?=
 =?utf-8?B?Skd4L3ZMNU1BdzJjWENSOEFCdmNVbVhLQWhCV21jdEpiSUVyazllMVJXNStH?=
 =?utf-8?B?cXVndXRheW1vVzNycnY5RWNrdW5ZU1liUGwzRVFHSVJEMmtMdHRPMml1a0lL?=
 =?utf-8?B?QkZqVXlXQXNOczFRODVjdWV6RnIvT2JoQmZvTkV1anJ1Vk5Jb0F0NVVRUEJn?=
 =?utf-8?B?NDNvVlR0UTExZHZqOGxLWS9kaHFTSm5uSDFORDB1VTQvQTJySERka3NJM0Z1?=
 =?utf-8?B?UU9KZ21VWUY4UGwvb3RSTERMTk5vYzBZZnFueUgzT2lnd3paV3RjbnZITnpQ?=
 =?utf-8?B?VWcyQlZrQXU1MkE5aThzYlRsZUtsMkQ4d0xhaWhXWTcwa1hoOFlaMnVmMlZQ?=
 =?utf-8?B?VHIxUkt5RS9JRUd3cEs2V3FDNWltL1NJZUdoNHRlWDRJaWRac0NVQm5HZFNO?=
 =?utf-8?B?cnZOUWs0bngxU3JWZlZqLytkNE1rZVRnOUVTeFgybmcrYW1Yc3g5c1NZNGJ1?=
 =?utf-8?B?c2p2S1ZMRHdIZ1FlRDZEekdqWFJpcEVoOVFmTnZCdkhiZXRIT1RlaFUvem9y?=
 =?utf-8?B?UUFxb25YWUhiK290L05USW5mMlhDNitZRU5SRnNmTFBzL1hiLzJJcjlpckpX?=
 =?utf-8?B?d3N2MnBVMjhKcnFWN3NSL1NuaWorV2FwZFVUR1B4Q2JzS3k2NSt4UXlCVjZy?=
 =?utf-8?B?VldSVHpmTERsYjUyZ0UxcHVDUU92Y1RpdEp1cm5OR1N1a2VQMmpvZzY0cjhH?=
 =?utf-8?B?YmV2alFTdVV1ekJLUHVFeWlvY2xuWlRMSStSck9FSUNESm82S05wOVRxNGtK?=
 =?utf-8?B?VkRsYTd2bWpCZzhpc0JGaE1iRWJQbndWVXpLUzZxVkJjOFYrTEZtM0Jrb0RO?=
 =?utf-8?B?WVUwT29Gd0JPZVV4L3hObmFhSzRCL0p6L01pNGIzNFNiVkRzZFRxVzhTTXVP?=
 =?utf-8?B?Zkk1Z213VFdjVGhXUS84UGl3YlZSMTYwbnAyNVdvYU92ZUZCdGFBNmFZaFlu?=
 =?utf-8?B?T3R0YVByU3dJTGpyV1YwTVVZOGFCQnJjOFAvTnJCNjFOaHpXZ0FKbGo0RFU0?=
 =?utf-8?B?aFB4UVg5T2poNWV3WTM0cG9BNmM1UzloVzZBT1lHMzhjSFdXeFNMSTlSM09S?=
 =?utf-8?B?d2NyRXdRR3JmSTUzWForSXliQ2JMOHRkOVZkenNOOE94SEtyVjR2NWVDWDNL?=
 =?utf-8?B?QWp2UUc2SzZQRGQ2cWNsUzRNK1lsYjZGV1Y0Smg3d3E1Q1Fibkh0RjZyVEJB?=
 =?utf-8?B?YnJOV2FBTTdhU3BuY0xpdmJmYmQwcmJOYkRFR254MmdqNHVWb3hVSWVBdnh5?=
 =?utf-8?B?UEMrN3FsU3B6Y0w1ejVKZldyUXY4R2pUemIzRnJtSll0ZzIyWTBvdmpRMXBX?=
 =?utf-8?B?UzBvSTd5dUJhRk9samVXSnk5K0dINC9iSjM4WXZraTZKUW1wa3hkZmpsRHdr?=
 =?utf-8?Q?RC0qkcULyJVC1j14=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: df3921cf-87a2-490d-b64a-08df346f67aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 21:15:19.5028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lIZ+ateJ5IYV4mDUQrIpUvzbwHSMgLXkAVtDWAX4bkbRy8KEKbfN3T5uGH7CgPoxq221YbexPd10O7qwW8jI1oB9mh8APrE7Zlc92h6QJCaIIAAyE9uZfHzrP4hMOR1n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR07MB9997

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZWFsIENhcmR3ZWxsIDxuY2Fy
ZHdlbGxAZ29vZ2xlLmNvbT4gDQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxOSwgMjAyNiA1OjMx
IFBNDQo+IFRvOiBDaGlhLVl1IENoYW5nIChOb2tpYSkgPGNoaWEteXUuY2hhbmdAbm9raWEtYmVs
bC1sYWJzLmNvbT4NCj4gQ2M6IGlob3Iuc29sb2RyYWlAbGludXguZGV2OyBqb2huLmZhc3RhYmVu
ZEBnbWFpbC5jb207IGpha3ViQGNsb3VkZmxhcmUuY29tOyBqaWF5dWFuLmNoZW5AbGludXguZGV2
OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwub3JnOyBhc3RAa2VybmVs
Lm9yZzsgZGFuaWVsQGlvZ2VhcmJveC5uZXQ7IGFuZHJpaUBrZXJuZWwub3JnOyBlZGR5ejg3QGdt
YWlsLmNvbTsgbWFydGluLmxhdUBsaW51eC5kZXY7IHNvbmdAa2VybmVsLm9yZzsgeW9uZ2hvbmcu
c29uZ0BsaW51eC5kZXY7IGpvbHNhQGtlcm5lbC5vcmc7IGVtaWxAZXRzYWxhcGF0aXMuY29tOyBs
aW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOyBzaHVhaEBrZXJuZWwub3JnOyBob3Jtc0Br
ZXJuZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRoYXQuY29tOyBqaHNAbW9q
YXRhdHUuY29tOyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkb25hbGQuaHVu
dGVyQGdtYWlsLmNvbTsga3VuaXl1QGdvb2dsZS5jb207IGlqQGtlcm5lbC5vcmc7IEtvZW4gRGUg
U2NoZXBwZXIgKE5va2lhKSA8a29lbi5kZV9zY2hlcHBlckBub2tpYS1iZWxsLWxhYnMuY29tPjsg
Zy53aGl0ZUBjYWJsZWxhYnMuY29tOyBpbmdlbWFyLnMuam9oYW5zc29uQGVyaWNzc29uLmNvbTsg
bWlyamEua3VlaGxld2luZEBlcmljc3Nvbi5jb207IGNoZXNoaXJlQGFwcGxlLmNvbTsgcnMuaWV0
ZkBnbXguYXQ7IEphc29uX0xpdmluZ29vZEBjb21jYXN0LmNvbTsgdmlkaGlfZ29lbEBhcHBsZS5j
b207IE1pa2VfUnVkb2xwaEBjb21jYXN0LmNvbTsgSmVmZl9Ib3dlQGNvbWNhc3QuY29tOyBzcmlj
aGFyZEBuZXRhcHAuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggbmV0LW5leHQgdjIgMi8zXSB0
Y3A6IEVDVF8xX0VTVEFCTElTSCBpZGVudGlmaWVyIGZvciBDQQ0KPiANCj4gDQo+IENBVVRJT046
IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNhcmVmdWwgd2hlbiBj
bGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhlIFVSTCBub2suaXQv
ZXh0IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IA0KPiBPbiBTdW4sIE9j
dCAxOCwgMjAyNiBhdCA1OjE14oCvUE0gPGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5v
a2lhLWJlbGwtbGFicy5jb20+DQo+ID4NCj4gPiBXaGVuIGNvbm5lY3Rpb24gaXMgaW5pdGlhbGl6
ZWQgYWZ0ZXIgRUNOIG5lZ290aWF0aW9uLCB0aGlzIHBhdGNoIA0KPiA+IGVuYWJsZXMgQ0EgdG8g
Y29udHJvbCB3aGV0aGVyIEVDVCgwKSBvciBFQ1QoMSkgc2hvdWxkIGJlIHVzZWQuDQo+IA0KPiBB
RkFJQ1QgdGhpcyBzaG91bGQgYmUgIldoZW4gY29uZ2VzdGlvbiBjb250cm9sIGlzIGluaXRpYWxp
emVkIiByYXRoZXIgdGhhbiAnV2hlbiBjb25uZWN0aW9uIGlzIGluaXRpYWxpemVkIi4NCj4gDQo+
ID4gQSBuZXcgaWRlbnRpaWZlciAoVENQX0NPTkdfRUNUXzFfRVNUQUJMSVNIKSBkZWZpbmVzIHRo
ZSBleHBlY3RlZCBFQ1QgDQo+ID4gdmFsdWUgaW4gdGhlIElQIGhlYWRlci4NCj4gDQo+IFVzaW5n
ICJleHBlY3RlZCIgaGVyZSBpcyBub3QgYXMgY2xlYXIgYXMgaXQgY291bGQgYmUuIEl0IHNvdW5k
cyBsaWtlIHRoZSBleHBlY3RlZCBpbmNvbWluZyB2YWx1ZSByYXRoZXIgdGhhbiBhIHZhbHVlIHRo
YXQgdGhlIENDIGFsZ29yaXRobSBpcyBzcGVjaWZ5aW5nIHNob3VsZCBiZSBzZW50Lg0KPiANCj4g
QWxzbywgdGhlIG5hbWUgVENQX0NPTkdfRUNUXzFfRVNUQUJMSVNIIGlzIHF1aXRlIHZlcmJvc2Us
IGFuZCBub3QgMTAwJSBhY2N1cmF0ZSBBRkFJQ1QsIHNpbmNlIGl0IGlzIHVzZWQgaW4gdGNwX2Vj
bl9zZW5kKCksIHdoaWNoIGlzIGNhbGxlZCB3aGVuIHRoZSBTWU4gYml0IGlzIG5vdCBzZXQsIHdo
aWNoIGNhbiBiZSBpbiBhIG51bWJlciBvZiBUQ1Agc3RhdGVzIG90aGVyIHRoYW4gRVNUQUJMSVNI
RUQuDQo+IA0KPiBJIHdvdWxkIHN1Z2dlc3QgY2FsbGluZyB0aGlzIHNvbWV0aGluZyBzaG9ydGVy
IGFuZCBtb3JlIGNsZWFyIGFuZCBjb3JyZWN0LCBsaWtlIFRDUF9FQ05fU0VORF9FQ1RfMS4NCj4g
DQo+IFB1dHRpbmcgdGhhdCBhbGwgdG9nZXRoZXIsIGhvdyBhYm91dCBzb21ldGhpbmcgbGlrZToN
Cj4gDQo+ICIiIg0KPiBUaGlzIHBhdGNoIGludHJvZHVjZXMgdGhlIG5ldyBUQ1BfRUNOX1NFTkRf
RUNUXzEgYml0LCB3aGljaCBlbmFibGVzIGEgY29uZ2VzdGlvbiBjb250cm9sIG1vZHVsZSB0byBj
b250cm9sIHdoZXRoZXIgdGhlIGNvbm5lY3Rpb24gdHJhbnNtaXRzIHVzaW5nIEVDVCgxKSAoaWYg
dGhlIGJpdCBpcyBzZXQpIG9yIEVDVCgwKSAob3RoZXJ3aXNlKSwgd2hlbiBjb25nZXN0aW9uIGNv
bnRyb2wgaXMgaW5pdGlhbGl6ZWQgYWZ0ZXIgRUNOIG5lZ290aWF0aW9uLiBBIGNvbmdlc3Rpb24g
Y29udHJvbCBtb2R1bGUsIHN1Y2ggYXMgdGhlIHVwY29taW5nIFRDUCBQcmFndWUgdXNpbmcgTDRT
IEVDTiwgY2FuIHNldCB0aGlzIG5ldyBUQ1BfRUNOX1NFTkRfRUNUXzEgIGJpdCBpZiBpdCB3YW50
cyB0byBzZW5kIHRoZSBFQ1QoMSkgY29kZSBwb2ludCBpbiBvdXRnb2luZyBJUCBoZWFkZXJzLg0K
PiAiIiINCj4gDQoNCllvdSBhcmUgcmlnaHQsIEkgd2lsbCBtb2RpeSB0aGUgY29tbWl0IG1lc3Nh
Z2UgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KWy4uLl0NCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9uZXQvdGNwX2Vjbi5oIGIvaW5jbHVkZS9uZXQvdGNwX2Vjbi5oIGluZGV4IA0KPiA+IDg2NWQ1
YzVhNzcxOC4uMjEwZWM2MzUzOGY4IDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbmV0L3RjcF9l
Y24uaA0KPiA+ICsrKyBiL2luY2x1ZGUvbmV0L3RjcF9lY24uaA0KPiA+IEBAIC0zOCw2ICszOCwx
MiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgSU5FVF9FQ05feG1pdF9lY3RfMV9uZWdvdGlhdGlvbihz
dHJ1Y3Qgc29jayAqc2spDQo+ID4gICAgICAgICBfX0lORVRfRUNOX3htaXQoc2ssIHRjcF9jYV9l
Y3RfMV9uZWdvdGlhdGlvbihzaykpOyAgfQ0KPiA+DQo+ID4gKy8qIEFwcGx5IGVpdGhlciBFQ1Qo
MCkgb3IgRUNUKDEpIGJhc2VkIG9uIFRDUF9DT05HX0VDVF8xX0VTVEFCTElTSCANCj4gPiArZmxh
ZyAqLyBzdGF0aWMgaW5saW5lIHZvaWQgSU5FVF9FQ05feG1pdF9lY3RfMV9lc3RhYmxpc2goc3Ry
dWN0IHNvY2sgDQo+ID4gKypzaykgew0KPiA+ICsgICAgICAgX19JTkVUX0VDTl94bWl0KHNrLCB0
Y3Bfc2soc2spLT5lY25fZmxhZ3MgJiANCj4gPiArVENQX0VDTl9FQ1RfMV9FU1RBQkxJU0gpOyB9
DQo+IA0KPiBUaGlzIGZ1bmN0aW9uIG5hbWUgaXMgcXVpdGUgdmVyYm9zZSwgYW5kIGEgbGl0dGxl
IGNvbmZ1c2luZywgc2luY2UgaXQgbWF5IG9yIG1heSBub3Qgc2V0IHRoZSBFQ1QgY29kZSBwb2lu
dCB0byBFQ1QoMSkuIEkgcmVhbGl6ZSB0aGUgbmFtZSBpcyBjaG9zZW4gdG8gYmUgY29uc2lzdGVu
dCB3aXRoIElORVRfRUNOX3htaXRfZWN0XzFfbmVnb3RpYXRpb24oKS4gQnV0IHRoYXQgb25lIGlz
IGNvbmZ1c2luZyBpbiB0aGUgc2FtZSB3YXkuIDotKQ0KPiANCj4gQWxzbywgdXNpbmcgImVzdGFi
bGlzaCIgaW4gdGhpcyB3YXkgc291bmRzIGxpa2UgYSB2ZXJiLCBtYWtpbmcgaXQgc291bmQgbGlr
ZSB0aGlzIGZ1bmN0aW9uIGlzIGVzdGFibGlzaGluZyBzb21ldGhpbmcuDQo+IA0KPiBIb3cgYWJv
dXQgc29tZXRoaW5nIGxpa2U6DQo+IA0KPiAoMSkgYSBuZXcgcHJlY2VkaW5nIHBhdGNoIGluIHRo
ZSBzZXJpZXMgY2FuIHJlbmFtZQ0KPiBJTkVUX0VDTl94bWl0X2VjdF8xX25lZ290aWF0aW9uKCkg
dG8gSU5FVF9FQ05feG1pdF9uZWdvdGlhdGlvbl9lY3QoKQ0KPiAoMikgdGhpcyBwYXRjaCBjYW4g
cmVuYW1lIGl0cyBJTkVUX0VDTl94bWl0X2VjdF8xX2VzdGFibGlzaCB0bw0KPiBJTkVUX0VDTl94
bWl0X2VzdGFibGlzaGVkX2VjdCgpDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBwYXRjaCENCj4gDQo+
IG5lYWwNCg0KWWVzLCBJIHdpbGwgYWRkIGFub3RoZXIgcGF0Y2ggdG8gcmVuYW1lIEVDTiB0cmFu
c21pdCBoZWxwZXIgZnVuY3Rpb24gZnJvbSAiSU5FVF9FQ05feG1pdF9lY3RfMV9uZWdvdGlhdGlv
biIgdG8gIklORVRfRUNOX3htaXRfbmVnb3RpYXRpb25fZWN0Ig0KDQpUaGFua3MhDQpDaGlhLVl1
DQo=
