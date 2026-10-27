Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793136012;
	b=1eXt2KQvT5UKU79HHPRPlj5os6FUOPGtPp6JoK/N5zpojSTCi7btOJCTOEzYnToBlWbc
	 FcAQEsF0SuVZFm5vCV4HHW/1M+mjRxC2/ZwwzhC/J6XcrdB5w2IVrDW5RfmJvLJ4iZyYO
	 tSoLQuQ03CUgrfe3Q+2Jwq/BjTxDFWBFalJWHIxehk5/GvcLklvQbL+8E7CPCg79pqv8M
	 WhT3qDqSGT5fNK4n7OXPurJS4/1Dn6Lxa9wr+ZLNWdnGK+4kn8pwA8aaf3kV+g3ONiQD9
	 O+XdgvpxeM8TQg+TFZ+3aUovfFEOGaDmANZFlqjjEelb68piUdEB3sWuQTtS6Gs2z5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136012;
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
	bh=65byYPEorNdxAnCwTqJecB8nAq2bFeN/GtBb+NkAV1o=;
	b=hHeVVBqi9hOxxKVR6h/gkuXfaP3KvUUD4m+/+S7KnCtwGzduyaKnC1CzNvADzWPRTMYk
	 9Ewf7GLcUMtTG522FSXsT/gCm15WHvVAGy2mSaylRUr7vZRHpajkKsXWtf0HWLUwuEQYA
	 gH58k4cODmb+3b7I7wUIEkYbvwAZ6o1FbUP49eA9MjEBUnOVoOkjKOSYqOL1F3xbEiwPP
	 pEm5pVl3QVYOE51okAtma1D3CzpfChvan8WE4wKJ60mA6GS/o+e4oX+ZOS1Fy/glBJqzh
	 fhl1fBv1r45dlHLzZ7I1Vm0/2XXULEf9w479dUphxbmcQlQM8q/t57u1wfPQQhwQRBg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia-bell-labs.com;
	spf=fail smtp.mailfrom=nokia-bell-labs.com;
	dkim=pass header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=MBKab+QA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.36
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6527606A31A;
	Tue, 27 Oct 2026 21:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6527606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=MBKab+QA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xm+yOSMU5eD4zb36MmARaNgJ4aEnox7qSxrVV66vq+ujwJvHkKZ821sSkjOzkTV1Id+UrP2s+7kJwxMxy3yh3JXNeKCaEncelgLeD4eE3BoqvRmdp9hcxQQ7tTC/x2NxRAtFfNbxdwdrp8xOezUfF21721nlA87bk1Ve9OMjhtnFZQvXnmW+og6R7tIlso/9rNeQPLgcKCQnyUNbbb2p+yeyfic7gezY2BfIXWrUGaRzY0ZyFTn7uCXfc4Hvja8XqKol+oKvxXZcRpvwKBLXzddZxve01KfzxUYKIMCe0TJdZTyMeLFxIUm8BNeezBuo/65QpzGy2zbU7hDMoDHCHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65byYPEorNdxAnCwTqJecB8nAq2bFeN/GtBb+NkAV1o=;
 b=l7ohO8qbXjevdQ3Yg7NTdRVuqcawhd7tnu69Ca3okda4n0MhUcsbesEL1rb1FAJPxXjpB6qysIyfAFTEkKmD05Ezepp6GjpbRC8lysJq/rWdH+Np4K0VXGG5yy+hK+6vg84EjFU2tPi23KKyRFnCwqrc7SfqMnimRNHC9DK6p5rgW8WbvbhrlGALYcWsafvf3cfB7JH71/jQHzFQH1b127td3EscYRk0OOsNAeCrAu7Ha06Hlj25hzpsYliKhUB/l8IKaO9RuZcjwksHzzbrz8mpbkmVUacRZEgnkJrdWAHD34ENfHugkNtctVpe3Jvf7VBxJWHPB3BOROngNn+O9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65byYPEorNdxAnCwTqJecB8nAq2bFeN/GtBb+NkAV1o=;
 b=MBKab+QAQ5X/PbIoSZlkD/I0uELR0+aJEFzIuydK3VtNcnnKOyzs8DVzf3f+NnCVJqFcrP9ICII8UPKdjSvWAHcL8C38jq6b52ef/ZANADX1WvRayNu7a6Aq5J1o8rbPmUcpqpJdEANtcWCOg479Jtdvkh//Z5EdWtgaxavMV7VuWxYm/ZBoVndBx6FxajhkKJ5HqlBkKse5RcGI5DvlnIaRHYETkaOKXK9rVNG5p0OKNa7kvlTNDRO343DTVCz2PNI5cPMmac/pOgQmcQRX8DHwCUetrcawGYM7QEFSNz8qYzJD9yKLeQEoMiQ10cDBCJtWNL/57zbWWKwMpgUcnw==
Received: from AS2PR07MB9123.eurprd07.prod.outlook.com (2603:10a6:20b:55a::8)
 by PA4PR07MB7085.eurprd07.prod.outlook.com (2603:10a6:102:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 21:20:08 +0000
Received: from AS2PR07MB9123.eurprd07.prod.outlook.com
 ([fe80::ddd6:7bad:4de5:5106]) by AS2PR07MB9123.eurprd07.prod.outlook.com
 ([fe80::ddd6:7bad:4de5:5106%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:20:07 +0000
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
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "donald.hunter@gmail.com"
	<donald.hunter@gmail.com>, "kuniyu@google.com" <kuniyu@google.com>,
	"ij@kernel.org" <ij@kernel.org>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>,
	"Mike_Rudolph@comcast.com" <Mike_Rudolph@comcast.com>,
	"Jeff_Howe@comcast.com" <Jeff_Howe@comcast.com>, "srichard@netapp.com"
	<srichard@netapp.com>, Eric Dumazet <edumazet@kernel.org>, Yuchung Cheng
	<ycheng@google.com>
Subject: RE: [PATCH net-next v2 3/3] tcp: Add mss_cache_set_by_cca for CC
 algorithm to set MSS
Thread-Topic: [PATCH net-next v2 3/3] tcp: Add mss_cache_set_by_cca for CC
 algorithm to set MSS
Thread-Index: AQHdX0XNiQF5A3gqyUyeH6IRwVStEbcFBWWAgAzsn7A=
Date: Tue, 27 Oct 2026 21:20:07 +0000
Message-ID:
 <AS2PR07MB91235FE378EE7AB28C8E80DCA3602@AS2PR07MB9123.eurprd07.prod.outlook.com>
References: <20261018211514.2817293-1-chia-yu.chang@nokia-bell-labs.com>
 <20261018211514.2817293-4-chia-yu.chang@nokia-bell-labs.com>
 <CADVnQyn1sjYzfCRiVKOxvyXbx0j2_3y5t9FsyTr81YG9XjdvxA@mail.gmail.com>
In-Reply-To:
 <CADVnQyn1sjYzfCRiVKOxvyXbx0j2_3y5t9FsyTr81YG9XjdvxA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR07MB9123:EE_|PA4PR07MB7085:EE_
x-ms-office365-filtering-correlation-id: 0b136e7e-504c-4f3e-3668-08df3470136f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|261026135527099003|261026140227099003|261022113327099003|261026130827099003|38070700021|4143699003|11063799006|261021133027099003|56012099006|261021121427099003|261022115727099003|261021135927099003|261021130227099003|261022105027099003|261022075727099003|261021123027099003|261009223027099003|10067099003|22082099003|18002099003|261026121527099003|6133799003|3023799007;
x-microsoft-antispam-message-info:
 ww9eH1rjF4vtYyA2sj0LMjj+qIZaY1uIYU1pOBKkXs94naCiPk49GHG2+ZxZrYXtIX+JcQRT3slUTqW1J/32cqeHkiVKEpI1qjW9e3cmhw+dsE4xhtW+cJhSUM8uK9UQeFfgG/0uwTZOifpQ3u/+UKJ1MDB6UIyEC+effk6WszCh1NcAeYHo4r8ClrqIXf8zq965aGBT1065OSEFy2GcpFRf7EvXCPLRQbcN4kqqw9owLZaR5Auaax+n/UszEBwMhX8uglFgfZS8YCtqCnjV0B87oKwS3zokEbvCJNTc7pgHUlBfeAF74UVNx1tWJEkhbLkY+rvOr2tyF9uJlGhUf6cUx+8aXIR3VdYiTT9k4NN++1GzQE0r8dSWfynK+rEzmKHXvt1YNJxE3nHo8Snm1uvCR5IykqGMsOuJrVKz/DMsT4NM+o7zpYWNHh4OcjkZsXjzzJz7Rl0F75IQvCnztOJ/2jxw35s4HV0Feqqfirjl9b45+yKYP0KrW+RxeCyenzoeYv1GDNuAmK1OF8/TPtazdiugSg8trekNIWHFR5bbGxClNN4/E+aZiKmKtciTjHXDDiI6LlvN5YiVnBxG+1dOLvzIQRq4/XOMN/mpRuUoG+OunoEhM+X8cBJ1IA9eXuiGlPDZ7NANAeM1m7ocLqGDgXaQ0ZauWNEMCMdY8C0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR07MB9123.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(261026135527099003)(261026140227099003)(261022113327099003)(261026130827099003)(38070700021)(4143699003)(11063799006)(261021133027099003)(56012099006)(261021121427099003)(261022115727099003)(261021135927099003)(261021130227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(261026121527099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1pNcE1LMXFld2dQTlZ0UjlpSGZwcHphUkxLdU5CMlRFNW1acEVnU0dXNmZY?=
 =?utf-8?B?dEp5bnFpYnlTd05rUXR4TjRrVjV2RmxselFTSEhjZzN1bWRPaVAwMmplTHhW?=
 =?utf-8?B?VTlnY0ZUS3VCVDF5NnBoRDZrTUJ1ekt2R2trYURTQ1pXMkhETXpzbG8zNWhn?=
 =?utf-8?B?VkdITUx0LzhRTmM2dWJEeHliclRJNUdrckZvc0hwdmlkM2FldWpaQk4zR1FG?=
 =?utf-8?B?Tm1VbFhlNVQzL2NhU2E3NTh4ZTR2V014SEZ5NmFIV1EwVUw3cmdYa1J1aHZD?=
 =?utf-8?B?VkRGbFcwanhNMURXOUdPTERxWVZ4a21GUVRTVGszUDV6VzE5cis1TXNxbEdF?=
 =?utf-8?B?YkNDYmxJcFp4N25VYlhTdXFyVjNKdkI3MGZwRVRlRGQ1dHRXTDJRbTFqN3JF?=
 =?utf-8?B?UTFWOTBtOFBNZitLdWpWT3Y0KzRyVklTS1l5bStnRXdJOXFEYi8rcU9XU2RH?=
 =?utf-8?B?TW5MUmlCaFpoLytUOU5iMk5OQ2V0elppZ3NmaTQwajM1eDRsMWJmQy83ZzlC?=
 =?utf-8?B?cWp3a0JXd0xLTEx2Y0M3YStiQlhoL096VXptL0xKekluYldiT2RGbHp5MmpC?=
 =?utf-8?B?d2ZyVjFrd3VjS0paejdiR1g3L0NNTHVlNEFXLy9ZTExHTXlFREU0YVM5K1pC?=
 =?utf-8?B?TW1BNjhEUGIyRHN1MysyVWV0RzRSWWhjeVM5bG1MN1k5RlFxdStxbEM4eTA3?=
 =?utf-8?B?SmdsbWpneG5WQk51dmt3TGhFcTJ4ZTZYUElSZUtadlFqTUZBUjRZVkYvVXkr?=
 =?utf-8?B?QXdhaWZ1QmFnN2VpYStSU01kODlURVc2UHlvdGdIakp0RytQdXh1RVFWTzBE?=
 =?utf-8?B?TDIzaWY3UC8vN1Vza2xqR0k3b1JBNmJWdlNHQ2R1aFZkN08zWEhlSjU5TUZh?=
 =?utf-8?B?ditURnUzQWdJWHFvNGthYS9obmJNcXlzWk0yTkZGa1VMSGJ4WGpzN2ZmVlhn?=
 =?utf-8?B?YmtwR296VW4rRkFMeEsxNjRGNmVMeUsxYVNNWUdtd2lpQ0xuVEZ6TzlpTnBH?=
 =?utf-8?B?NVRxQmRGQTJ4T0s5MWVUTFpWZEUwZTlSc2VlOTZicVZDWWZJUXJDT2hIOVI1?=
 =?utf-8?B?Nk5JREYwZ1kyMWFhU2RyTHhmTVZPZFA3TnpQNlZVajcxRSswVUpMV2ZBc2NN?=
 =?utf-8?B?MitjeThtdDNHNzhwelhaS1ZZSXU4K2FnelpOTkdLd1l0MHlONU9lZGk5TjRL?=
 =?utf-8?B?WEVldFhuMEdoRjlPZElCeXQ3R29OcVdKT3J5RitXeXVVQWhUeEI5NjlOb2Jp?=
 =?utf-8?B?YmtPbnB3S2J4NlJ4MjVsblFGVE5JMzNrYWVxS25CeTZxRUJuOTdESlg2OVhL?=
 =?utf-8?B?MmhpaEI1V3pZNjRaQ01KQmFaNG9aZ2FrUFFqQTROOU5oRFhnNEc4UFJrbWNi?=
 =?utf-8?B?aGNlQ0NOT1NFQy9WTG5oMmdlWWNUekIwUGFnVUNFR0VhckF4c0xQeHFsZVUv?=
 =?utf-8?B?NGR0VXVUTGkyMFhYZjVjc2JvYkQ0cmRxclZ3QTBacXl5L3lpUUtSYW5oS2hQ?=
 =?utf-8?B?dW0rcUtCMktzek84SmhBSDd1K1U3QWRJNmJOMkREN2tVWnF2NDFGWXU0N2xX?=
 =?utf-8?B?OUxlejlWUmQvb3N0UVU5UTNUMm94WFVQR1Q4ajdicEJJNTBFazRRZHVlVkth?=
 =?utf-8?B?Wi91NGsySnRiL25QU0NmS01xNXJUY3dnM2xoUmpIYmptdW9iK0wwSnpyRXEr?=
 =?utf-8?B?aFY2OFR5Q2VqRGFvUkRqRmluM2VrTUJLM2pVcWFCTmI0QnRFTjlkSCtaZjlW?=
 =?utf-8?B?L3FDN0g3eDh3YWFEb1gvSWU2WXAweVdIWUk2bWxnL1lXUVB0V1FmK3RiSWdY?=
 =?utf-8?B?VzVRYmxscG80b05qTzRJbTlnNHpLRWJzZlgvYVJUM2NJRjdmUFFmbmlSMUly?=
 =?utf-8?B?U3FVaVlVVmtJZ2hZU2EzTHhXRVVuM0N6QnRGcnI2OVRBN3Q0aWpBSHJ5R3F5?=
 =?utf-8?B?N0hja1JacDlrTGxGQk5XLzZzL00zNGx0NHN3c2hSay93TzQzSTJlcVcvcXcz?=
 =?utf-8?B?K2oyMDZpOU9BME1lM2ZlNlprSVZPcHlNT3pYWjhEbDdBTVovZWZXc2FrWWln?=
 =?utf-8?B?cXRXMWl2bVA1VnRYZ09zc3RQeUcrUVdSWlA5Z0ZXMkkrQ3dYZkZIWm85SmV4?=
 =?utf-8?B?UHdRRStLZVBTeVAvcTFPdjVlVzJZeVRsU1lWd1pHWVM5bDJvRk1WVE1VUlpj?=
 =?utf-8?B?RDdoQVJWMDNlazJ4RWRjL0ZncmJLTlVORlAvOVVCZGw2SlE5eWJvUTRFSlFo?=
 =?utf-8?B?OFJwU2QwTmZuYkYrcDJ3c3plYzdTRnBFZ0NNQXNpSWMzdFIvVmJZeS93R1Vp?=
 =?utf-8?B?K2VBZStpTnYyYThOQjJQc3JGamZRdVZTU2pTZjkrZ0RKK0kzYVdyelpuK0xK?=
 =?utf-8?Q?bM5KQ9jAp0RyvMqQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b136e7e-504c-4f3e-3668-08df3470136f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 21:20:07.6610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VVz+f98mdks9mqvEOmYBcPN5k7vHY17NME/wyKZpeenlEeq5HJdPa4D15YquJpRZ7FYogfV3y8EUzeZUUzCaJu3Lw9QmOXTnl3ePT2QrGgX05kKAGQQfCuYEAu6Ssrz6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7085

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBOZWFsIENhcmR3ZWxsIDxuY2Fy
ZHdlbGxAZ29vZ2xlLmNvbT4gDQo+IFNlbnQ6IE1vbmRheSwgT2N0b2JlciAxOSwgMjAyNiA1OjUz
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
dDsgYW5kcmV3K25ldGRldkBsdW5uLmNoOyBkb25hbGQuaHVudGVyQGdtYWlsLmNvbTsga3VuaXl1
QGdvb2dsZS5jb207IGlqQGtlcm5lbC5vcmc7IEtvZW4gRGUgU2NoZXBwZXIgKE5va2lhKSA8a29l
bi5kZV9zY2hlcHBlckBub2tpYS1iZWxsLWxhYnMuY29tPjsgZy53aGl0ZUBjYWJsZWxhYnMuY29t
OyBpbmdlbWFyLnMuam9oYW5zc29uQGVyaWNzc29uLmNvbTsgbWlyamEua3VlaGxld2luZEBlcmlj
c3Nvbi5jb207IGNoZXNoaXJlQGFwcGxlLmNvbTsgcnMuaWV0ZkBnbXguYXQ7IEphc29uX0xpdmlu
Z29vZEBjb21jYXN0LmNvbTsgdmlkaGlfZ29lbEBhcHBsZS5jb207IE1pa2VfUnVkb2xwaEBjb21j
YXN0LmNvbTsgSmVmZl9Ib3dlQGNvbWNhc3QuY29tOyBzcmljaGFyZEBuZXRhcHAuY29tOyBFcmlj
IER1bWF6ZXQgPGVkdW1hemV0QGtlcm5lbC5vcmc+OyBZdWNodW5nIENoZW5nIDx5Y2hlbmdAZ29v
Z2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQtbmV4dCB2MiAzLzNdIHRjcDogQWRk
IG1zc19jYWNoZV9zZXRfYnlfY2NhIGZvciBDQyBhbGdvcml0aG0gdG8gc2V0IE1TUw0KPiANCj4g
DQo+IENBVVRJT046IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSBiZSB2ZXJ5IGNh
cmVmdWwgd2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBTZWUgdGhl
IFVSTCBub2suaXQvZXh0IGZvciBhZGRpdGlvbmFsIGluZm9ybWF0aW9uLg0KPiANCj4gDQo+IA0K
PiBPbiBTdW4sIE9jdCAxOCwgMjAyNiBhdCA1OjE14oCvUE0gPGNoaWEteXUuY2hhbmdAbm9raWEt
YmVsbC1sYWJzLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBDaGlhLVl1IENoYW5nIDxjaGlh
LXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+ID4NCj4gPiBNYWtlIHRoZSBDQyBtb2R1
bGUgc2V0IHRoZSBtc3NfY2FjaGUgc21hbGxlciB0aGFuIHBhdGggbXR1LiBUaGlzIGlzIA0KPiA+
IHVzZWZ1bA0KPiANCj4gU2luY2UgbWFueSBDQyBtb2R1bGVzIHdpbGwgbm90IHNldCB0aGUgbXNz
X2NhY2hlIHZhbHVlLCByYXRoZXIgdGhhbiAiTWFrZSB0aGUgQ0MgbW9kdWxlIHNldCIgSSB0aGlu
ayBpdCdzIGltcG9ydGFudCB0byBzYXkgIkFsbG93IHRoZSBDQyBtb2R1bGUgdG8gc2V0Ii4NCj4g
DQo+ID4gZm9yIGEgQ0MgbW9kdWxlIHRoYXQgbWFpbnRhaW5zIGFuIGludGVybmFsIGZyYWN0aW9u
YWwgY3duZCBsZXNzIHRoYW4gMiANCj4gPiBhdCB2ZXJ5IGxvdyBzcGVlZCAoPDEwMGticHMpIGFu
ZCB2ZXJ5IGxvdyBSVFQgKDwxbXMpLiBJbiB0aGlzIGNhc2UsIA0KPiA+IHRoZSBtaW5pbXVtIHNu
ZF9jd25kIGZvciB0aGUgc3RhY2sgcmVtYWlucyBhdCAyLCBidXQgdGhlIENDIG1vZHVsZSANCj4g
PiB3aWxsIGxpbWl0IHRoZSBwYWNpbmcgcmF0ZSB0byBlbnN1cmUgdGhhdCBpdHMgaW50ZXJuYWwg
ZnJhY3Rpb25hbCBjd25kIHRha2VzIGVmZmVjdC4NCj4gPiBUaGVyZWZvcmUsIHRoZSBDQyBhbGdv
cml0aG0gY2FuIGVuYWJsZSBmaW5lLWdyYWluZWQgY29udHJvbCB3aXRob3V0IA0KPiA+IGNhdXNp
bmcgYmlnIHJhdGUgc2F3LXRvb3RoIGFuZCBkZWxheSBqaXR0ZXIuDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+
DQo+ID4gLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvdGNwLmggICB8IDMgKystDQo+ID4gIG5ldC9p
cHY0L3RjcC5jICAgICAgICB8IDEgKw0KPiA+ICBuZXQvaXB2NC90Y3Bfb3V0cHV0LmMgfCA1ICsr
Ky0tDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdGNwLmggYi9pbmNsdWRlL2xp
bnV4L3RjcC5oIGluZGV4IA0KPiA+IGU0ZDE3MjBmNDlmMC4uNDI4ZDYzZTQ2MjA2IDEwMDY0NA0K
PiA+IC0tLSBhL2luY2x1ZGUvbGludXgvdGNwLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3Rj
cC5oDQo+ID4gQEAgLTIzMiw3ICsyMzIsOCBAQCBzdHJ1Y3QgdGNwX3NvY2sgew0KPiA+ICAgICAg
ICAgICAgICAgICB0Y3BfdXNlY190cyA6IDEsIC8qIFRTdmFsIHZhbHVlcyBpbiB1c2VjICovDQo+
ID4gICAgICAgICAgICAgICAgIGlzX3NhY2tfcmVuZWc6MSwgICAgLyogaW4gcmVjb3ZlcnkgZnJv
bSBsb3NzIHdpdGggU0FDSyByZW5lZz8gKi8NCj4gPiAgICAgICAgICAgICAgICAgaXNfY3duZF9s
aW1pdGVkOjEsLyogZm9yd2FyZCBwcm9ncmVzcyBsaW1pdGVkIGJ5IHNuZF9jd25kPyAqLw0KPiA+
IC0gICAgICAgICAgICAgICByZWN2bXNnX2lucSA6IDE7LyogSW5kaWNhdGUgIyBvZiBieXRlcyBp
biBxdWV1ZSB1cG9uIHJlY3Ztc2cgKi8NCj4gPiArICAgICAgICAgICAgICAgcmVjdm1zZ19pbnEg
OiAxLC8qIEluZGljYXRlICMgb2YgYnl0ZXMgaW4gcXVldWUgdXBvbiByZWN2bXNnICovDQo+ID4g
KyAgICAgICAgICAgICAgIG1zc19jYWNoZV9zZXRfYnlfY2NhOjE7LyogbXNzX2NhY2hlIHNldCBi
eSBDQ0EgKi8NCj4gPiAgICAgICAgIF9fY2FjaGVsaW5lX2dyb3VwX2VuZCh0Y3Bfc29ja19yZWFk
X3R4cngpOw0KPiA+DQo+ID4gICAgICAgICAvKiBSWCByZWFkLW1vc3RseSBob3RwYXRoIGNhY2hl
IGxpbmVzICovIGRpZmYgLS1naXQgDQo+ID4gYS9uZXQvaXB2NC90Y3AuYyBiL25ldC9pcHY0L3Rj
cC5jIGluZGV4IGY0YzkxMDFlNTk5Ni4uNzA4ZTE4MzAyMjdiIA0KPiA+IDEwMDY0NA0KPiA+IC0t
LSBhL25ldC9pcHY0L3RjcC5jDQo+ID4gKysrIGIvbmV0L2lwdjQvdGNwLmMNCj4gPiBAQCAtNDU3
LDYgKzQ1Nyw3IEBAIHZvaWQgdGNwX2luaXRfc29jayhzdHJ1Y3Qgc29jayAqc2spDQo+ID4gICAg
ICAgICB0cC0+c25kX3NzdGhyZXNoID0gVENQX0lORklOSVRFX1NTVEhSRVNIOw0KPiA+ICAgICAg
ICAgdHAtPnNuZF9jd25kX2NsYW1wID0gfjA7DQo+ID4gICAgICAgICB0cC0+bXNzX2NhY2hlID0g
VENQX01TU19ERUZBVUxUOw0KPiA+ICsgICAgICAgdHAtPm1zc19jYWNoZV9zZXRfYnlfY2NhID0g
ZmFsc2U7DQo+ID4NCj4gPiAgICAgICAgIHRwLT5yZW9yZGVyaW5nID0gUkVBRF9PTkNFKHNvY2tf
bmV0KHNrKS0+aXB2NC5zeXNjdGxfdGNwX3Jlb3JkZXJpbmcpOw0KPiA+ICAgICAgICAgdGNwX2Fz
c2lnbl9jb25nZXN0aW9uX2NvbnRyb2woc2spOw0KPiA+IGRpZmYgLS1naXQgYS9uZXQvaXB2NC90
Y3Bfb3V0cHV0LmMgYi9uZXQvaXB2NC90Y3Bfb3V0cHV0LmMgaW5kZXggDQo+ID4gMzI0OGYzODk1
YjE1Li5jNTNkNzA3MTg4MzAgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2lwdjQvdGNwX291dHB1dC5j
DQo+ID4gKysrIGIvbmV0L2lwdjQvdGNwX291dHB1dC5jDQo+ID4gQEAgLTIwODIsNyArMjA4Miw3
IEBAIHVuc2lnbmVkIGludCB0Y3Bfc3luY19tc3Moc3RydWN0IHNvY2sgKnNrLCB1MzIgcG10dSkN
Cj4gPiAgICAgICAgIHN0cnVjdCBpbmV0X2Nvbm5lY3Rpb25fc29jayAqaWNzayA9IGluZXRfY3Nr
KHNrKTsNCj4gPiAgICAgICAgIGludCBtc3Nfbm93Ow0KPiA+DQo+ID4gLSAgICAgICBpZiAoaWNz
ay0+aWNza19tdHVwLnNlYXJjaF9oaWdoID4gcG10dSkNCj4gPiArICAgICAgIGlmIChpY3NrLT5p
Y3NrX210dXAuc2VhcmNoX2hpZ2ggPiBwbXR1ICYmIA0KPiA+ICsgIXRwLT5tc3NfY2FjaGVfc2V0
X2J5X2NjYSkNCj4gPiAgICAgICAgICAgICAgICAgaWNzay0+aWNza19tdHVwLnNlYXJjaF9oaWdo
ID0gcG10dTsNCj4gDQo+IFRoaXMgbG9va3Mgc3VzcGljaW91cywgb3IgYXQgbGVhc3QgSSBkb24n
dCB1bmRlcnN0YW5kIHRoZSBtb3RpdmF0aW9uIGhlcmUuIFdoYXQncyB0aGUgbW90aXZhdGlvbiBm
b3IgdGhpcz8NCj4gDQo+ID4gICAgICAgICBtc3Nfbm93ID0gdGNwX210dV90b19tc3Moc2ssIHBt
dHUpOyBAQCAtMjA5Niw2ICsyMDk2LDcgQEAgDQo+ID4gdW5zaWduZWQgaW50IHRjcF9zeW5jX21z
cyhzdHJ1Y3Qgc29jayAqc2ssIHUzMiBwbXR1KQ0KPiA+DQo+ID4gICAgICAgICByZXR1cm4gbXNz
X25vdzsNCj4gPiAgfQ0KPiA+ICtFWFBPUlRfU1lNQk9MKHRjcF9zeW5jX21zcyk7DQo+ID4NCj4g
PiAgLyogQ29tcHV0ZSB0aGUgY3VycmVudCBlZmZlY3RpdmUgTVNTLCB0YWtpbmcgU0FDS3MgYW5k
IElQIG9wdGlvbnMsDQo+ID4gICAqIGFuZCBldmVuIFBNVFUgZGlzY292ZXJ5IGV2ZW50cyBpbnRv
IGFjY291bnQuDQo+ID4gQEAgLTIxMTEsNyArMjExMiw3IEBAIHVuc2lnbmVkIGludCB0Y3BfY3Vy
cmVudF9tc3Moc3RydWN0IHNvY2sgKnNrKQ0KPiA+DQo+ID4gICAgICAgICBtc3Nfbm93ID0gdHAt
Pm1zc19jYWNoZTsNCj4gPg0KPiA+IC0gICAgICAgaWYgKGRzdCkgew0KPiA+ICsgICAgICAgaWYg
KGRzdCAmJiAhdHAtPm1zc19jYWNoZV9zZXRfYnlfY2NhKSB7DQo+ID4gICAgICAgICAgICAgICAg
IHUzMiBtdHUgPSBkc3RfbXR1KGRzdCk7DQo+ID4gICAgICAgICAgICAgICAgIGlmIChtdHUgIT0g
aW5ldF9jc2soc2spLT5pY3NrX3BtdHVfY29va2llKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIG1zc19ub3cgPSB0Y3Bfc3luY19tc3Moc2ssIG10dSk7DQo+IA0KPiBIb3cgaXMgdGhpcyBn
b2luZyB0byB3b3JrIGlmIHRoZSBwYXRoIE1UVSByZWR1Y2VzPyBGb3IgZXhhbXBsZSwgaWYgdGhl
IHN5c2FkbWluIGxvd2VycyB0aGUgTVRVIHRvIGJlIGxvd2VyIHRoYW4gd2hhdCdzIGNvbnNpc3Rl
bnQgd2l0aCB0aGUgTVNTIHZhbHVlIHRoZSBDQyBtb2R1bGUgY2hvc2U/IFdvbid0IHRoZSBwYWNr
ZXRzIGZyb20gdGhlIGNvbm5lY3Rpb24gYWxsIGJlIGJpZ2dlciB0aGFuIHRoZSBNVFUsIGNhdXNp
bmcgd2VpcmQgZnJhZ21lbnRhdGlvbiBvciBibGFjay1ob2xpbmc/DQo+IA0KPiBBRkFJQ1QsIHRv
IGJlIHNhZmUsIGlmIHRoZSBkc3RfbXR1KCkgY2hhbmdlcyB0aGVuIHdlIHN0aWxsIGhhdmUgdG8g
Y2FsbCB0Y3Bfc3luY19tc3MoKSwgZXZlbiBpZiB0aGUgQ0MgbW9kdWxlIHdhbnRzIHNvbWUgaW5w
dXQgaW50byB0aGUgTVNTIGRlY2lzaW9uLg0KPiANCj4gV291bGRuJ3QgaXQgYmUgc2FmZXIgdG8g
cHJvcG9zZSB0aGF0IHRoZSBDQyBtb2R1bGUgb3B0aW9uYWxseSBzZXRzIGEgY2VpbGluZyBmb3Ig
dGhlIE1TUyB2YWx1ZSwgcmF0aGVyIHRoYW4gZ2l2aW5nIGl0IGRpcmVjdCBjb250cm9sIG92ZXIg
dGhlIE1TUyB2YWx1ZT8gQWxvbmcgdGhvc2UgbGluZXMsIHBlcmhhcHMgQ0MgbW9kdWxlcyB0aGF0
IHdhbnQgdG8gZG8gdGhpcyBjb3VsZCBleHBvcnQgYSBuZXcgb3B0aW9uYWwgQ0MgbW9kdWxlIGNh
bGxiYWNrIHRoYXQgd2UgdXNlIGluIF9fdGNwX210dV90b19tc3MoKSwgcGVyaGFwcyBzb21ldGhp
bmcgbGlrZSB0aGlzPw0KPiANCj4gICAgICAgICAvKiBDbGFtcCBpdCAobXNzX2NsYW1wIGRvZXMg
bm90IGluY2x1ZGUgdGNwIG9wdGlvbnMpICovDQo+ICAgICAgICAgaWYgKG1zc19ub3cgPiB0cC0+
cnhfb3B0Lm1zc19jbGFtcCkNCj4gICAgICAgICAgICAgICAgIG1zc19ub3cgPSB0cC0+cnhfb3B0
Lm1zc19jbGFtcDsNCj4gKyAgICAgICAvKiBPcHRpb25hbGx5IGNsYW1wIE1TUyBiYXNlZCBvbiBD
QyBtb2R1bGU6ICovDQo+ICsgICAgICAgaWYgKGNhX29wcy0+bWF4X21zcykNCj4gKyAgICAgICAg
ICAgICAgIG1zc19ub3cgPSBtaW4obXNzX25vdywgY2Ffb3BzLT5tYXhfbXNzKHNrKSk7DQo+IA0K
PiBQZXJoYXBzIEVyaWMgb3IgWXVjaHVuZyB3aWxsIGhhdmUgYSBiZXR0ZXIgaWRlYS4gOi0pDQo+
IA0KPiBCZXN0LA0KPiBuZWFsDQpIaSBOZWFsLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjayBh
bmQgSSd2ZSBnbyBvdmVyIHRoaXMgcGF0Y2ggYWdhaW4uDQoNCkluIHRoZSBuZXh0IHZlcnNpb24s
IEkgd2lsbCBhZGQgTVNTIGNlaWxpbmcgY2FsbGJhY2sgZm9yIGNvbmdlc3Rpb24gY29udHJvbC4N
Cg0KQWxzbywgSSB3aWxsIGF2b2lkIGV4cG9ydGluZyB0Y3Bfc3luY19tc3MgYnkgYWRkaW5nIG9u
ZSBleHRyYSB0Y3BfdXBkYXRlX21zcyBmdW5jdGlvbiBleHBvc2VkIGZvciBjb25nZXN0aW9uIGNv
bnRyb2wgdG8gdXBkYXRlIGl0cyBjYWxjdWxhdGVkIE1TUyBjZWlsaW5nLg0KDQpGaW5hbGx5LCB0
aGUgYXBwbGllZCBNU1MgY2VpbGluZyB3aWxsIHVzZSAibXNzX25vdyA9IG1pbl90KHUzMiwgbXNz
X25vdywgaWNzay0+aWNza19jYV9vcHMtPm1zc19jZWlsaW5nKHNrKSk7Ii4NCg0KVGhhbmtzLg0K
Q2hpYS1ZdQ0K
