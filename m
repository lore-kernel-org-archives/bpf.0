Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED00B175A9D;
	Mon, 24 Aug 2026 20:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602902; cv=fail; b=CrnAMaBj292XqCu0H6/Pov6YKl3/1XrSOWXPECfThKE3ALBWt6trnPXbuzzo0ODip0BG+DlZqyo31q/LnL7ZidmVh0a7l1D6ew+/Z1sHKswboraHkUKj3ITmmFIb5IHy6pdFC9NClIBaQ8tR01lRKyQPLgvIV4htT2kfvqEdf8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602902; c=relaxed/simple;
	bh=sdwHTi2qohYRNQhrpsMAR5YC6bg4qGhgEjQsv4BHw9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fSA9xRJ4/MY7OPYyiE2S/JGylztwTppkoyMqkun9KAQLrhCK7IuPaFsbURTGx3mtAyYUJVnngQTkLh6Ht5zLPzfpPFjURpU0KIX5VoR2wu7v4kB6V560t6oREgt51JxWZx8H9JojuzIDChW68VXH9FnlkCXlaUWB0t9ESL/5TIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=Q0JCDgZe; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="Q0JCDgZe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=myAjH2+NH1GJZqRdylku+u5L1nL9NVPYEGzZPcnsNBobAZ3N5xTF8wVclUpOXOp0JdDLqhleYjMAhngGF5ibz1sZzZ6+Zj882w7kq9palbOOenjxMBoSxSByYbsKKRqwuD5DTA/Th6aL7PKM9ys6vW0g1FH2pZNxow1OKs6YdUyPeJ/awkfCvZ8i8DowCU9CuaoUnL46xXQloCRXA1GDXDvyeLOcPfAIe+AHvkgH7x0OLwyFgYo35+Gx0+3xdqNVKIl6xildH0fUZA0atuoLuJ7xCygUfTt17sh21RObdyzwl0fH5xcrd5673kLXvbP7fDrsLB+bSPTPAvGczi4DsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdwHTi2qohYRNQhrpsMAR5YC6bg4qGhgEjQsv4BHw9E=;
 b=OVTJnWgjKVxWGCNJZz8ptUnGaz0CB5obq/lvkByUba3qivBaFwJqHMeMz+tTxBu0aoBJEb5lVPyedhH1a3WrqBZsSKhw+TD4mHFb66E4VgxSY2QO1rJffeYkv3T7i4h1HNLyMSCeENAlgQUWxq2uAALVA0reJGTYKk4CHQ9fDi8GPE7QJEP9h9rxnbNnB5lLj1TOPTXG8/5oguwGbzeuBo6Noj0JLUn4YIPl6qm8er25yAbGpeCIyCz6PrIs47YBSJDsH9aO1xqwOOsVZT5PPHw4dWan9VF07zIOQERqgz/Yg3KhL1jV/odDMlONKsIIK/WkgpBj04Zjq+VnVpoGdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdwHTi2qohYRNQhrpsMAR5YC6bg4qGhgEjQsv4BHw9E=;
 b=Q0JCDgZe+WqErBUu6haDBqnL9JiSiErp51mgfo6myuPoOCd5WM60NeUdJvz92ExXBjt/5S/+bJCaCda9NuNSAcKduvWgf70lSiIZTNsZq+KAoFA1wlafvEpfpwaSYGLZrE1eScNlDv+4AV6zM4H63n56yv7td+x6QGtE4wes1hvQ6fHgGn8soS7RP270vtfxuePvOgoEw9Khb5kd6n4AcbwIhIx6wVL7zzXRWBm2+xLu5Ww9GdWJjPs2ns5WAXV22XlzVNL6WM9ZUkXm1K6Y4DKDe5W4+xddDI5p/6+A+9kpMhPXABMa1VYl8RCZY60rHOXeStlsumAQEAhYmABTFg==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by VI1PR07MB10018.eurprd07.prod.outlook.com (2603:10a6:800:1e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Mon, 24 Aug
 2026 20:21:34 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%2]) with mapi id 15.21.0360.005; Mon, 24 Aug 2026
 20:21:34 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>
CC: "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"jakub@cloudflare.com" <jakub@cloudflare.com>, "jiayuan.chen@linux.dev"
	<jiayuan.chen@linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"emil@etsalapatis.com" <emil@etsalapatis.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"shuah@kernel.org" <shuah@kernel.org>, "horms@kernel.org" <horms@kernel.org>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "kuniyu@google.com"
	<kuniyu@google.com>, "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>,
	"Mike_Rudolph@comcast.com" <Mike_Rudolph@comcast.com>,
	"Jeff_Howe@comcast.com" <Jeff_Howe@comcast.com>, "srichard@netapp.com"
	<srichard@netapp.com>
Subject: RE: [PATCH v8 net-next 0/2] Explicit TSO segment count
Thread-Topic: [PATCH v8 net-next 0/2] Explicit TSO segment count
Thread-Index: AQHdM+YO9dhJ9GtTPE6MPcqRiFQGq7atn/CAgAABTwCAAAG/AA==
Date: Mon, 24 Aug 2026 20:21:34 +0000
Message-ID:
 <PAXPR07MB7984EBA84647E27ED9E65041A3A02@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260824163139.990734-1-chia-yu.chang@nokia-bell-labs.com>
 <20260824130511.2955f30d@kernel.org> <DKXG3AFFUMEJ.1RDMQ7LNT1D0S@gmail.com>
In-Reply-To: <DKXG3AFFUMEJ.1RDMQ7LNT1D0S@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|VI1PR07MB10018:EE_
x-ms-office365-filtering-correlation-id: 719e2375-7b53-4f58-297d-08df021d4afe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|23010399003|10067099003|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 vPUWM6whBbzmsYpqWbGDh3bnZKbKlEETh5yFK4Ho2B+ijFjtWEFPvhmkSp21QMOktA1RtNF0KDFkEXmD2MuoqkIt1GiJlRCO8pgbexQEBXEXPixlvL7/AaBj9EiFLaLk2vDOIH/QobgPY36d8DzNIRcegblLbEmNVEyuHxr4JxDVlkMkhy8tgRg7d/Ud/cqLMPRyqCQQrm+eRVnjk5UOcc8fQ0mqItbu0iwHcNwC1lTBkP+SVu4gICNEVV8Z/VEyCqbTvc78uPDm8ejs4Jqov2zBqeYiVctUF6zA0bi0ykuza52dApoloIB98fezSQif2xSB7YBP88kkijbu7/pr/31UR4RiN59tN3qM9PxkTLbYARpWqCl1tOgo7x5xV78hH7l+QNHMHfGN311uDxCooKoefHIQR/Gnq4cPpGvyajMisyg6qY3et1EoTPeCy6gdqIPqbMVODv+JmAwGOaEyWZBeZ8VJhh+lelzBUBt34U+UZwTpOMy5MGSyTqHlc7ZaSVbJ/FVfeEMlPjBqiPWbMCUTqv8rjU/YqIsgLI+ahx6NmeWDH43YDqH2QZ39otlOA7Ol1zBsyXdE6YP3x6ProxeHTDa7aPNvyFhE62qKJRrAow3MgVfPQj+r4uWDjJRAzCY31XIOh2Ycj9GYa7rDUE0K+noRkwS3Aw9MzeOOC+8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUdwWlFWajJoUkl1WWNVbS94blZZNFdpaFUxVGtWWlEvTHRUT1E2eTNmTWRN?=
 =?utf-8?B?S2tBc2wyMFk4dTVVdlJNVHhOSXZDSlBMVGpYd1M2WU9yMjFqa0FhWUFOTEFv?=
 =?utf-8?B?ZUt5U3NDZTdvaUEyZmxDM00zK1hLbU41bHZUOGxiZTZFaHp4cE03UVRCQkQx?=
 =?utf-8?B?Zml3VFhpczY1MFZJWGNRNFJ1U2s3MmViQlJ1NUhjemtCZC9jSk5xRzJEUm4z?=
 =?utf-8?B?aWcycGJPV1B5akI1STA5VkM4QWxzOGY4cHkxV2tiUnY3aW9DNVFpa1hFZnd4?=
 =?utf-8?B?bDBYUk9hRmRSTTh1TjMrbGdCRHpLTW9ybHYzR1pDZ2F6cCtWRmNxVVlMZVJ1?=
 =?utf-8?B?ZW94N2VNOWI3TXVJZHNVVDR6dG43NlQwbUU4aHV0M3NGbTEzaDdVSElTWlBv?=
 =?utf-8?B?Vnp5OVJhTjM3SlM5QUlRMXl6eG9iUk5LZHFNcnIrZWovdUFtQXZtZEt6V3NB?=
 =?utf-8?B?M0hLbXF5dU0xRFFWUlRCdlh3dWl5YitYWTBONzl4bDc0TTBiN2xZUVkyTzNK?=
 =?utf-8?B?QkQ0em1TZFhaUGxiY1NsQUMvWC8vTCtTZUcyYmNYVFJaRWVvazRWMVpmcUxO?=
 =?utf-8?B?RitQb3JIRmh0eFc1V1hxQlY0cC80UmZOdXJGc0M2cklJYXUxd1FBcmtXVnhU?=
 =?utf-8?B?WW8zaDdtZ0lUYXp3bWloUnd2Ti8zQ1ljZmprRkpDTCtNOUhtdFI2LzZaSUZB?=
 =?utf-8?B?aUVwZU4vV3pBU0RKeTVQS0NibThoUWNXV29yQ1ZxSmw2ektnaGd0b1hFcm44?=
 =?utf-8?B?WFpwUDFDWC8vU3ovWi9BdVpPeG43OEZpRmc1cG9qU2FvekN3ZWdWeGRtSlZ6?=
 =?utf-8?B?T2h4NWRQcUNKTGFpaHZNNy8wYzQrOXFIYlhqRjB3OEV4WkRiYWtuUk42dW5o?=
 =?utf-8?B?ZUp6ZzNuUFJIS0kzWTE2VUJnWnBnWnJUQTloUFFEVk9kT2RGWUtUeWZMTXcr?=
 =?utf-8?B?Q0s3YmdxemMwUUpuVitpdmNXSXYzalZJUmkvV01VdzBmUXVYc0hFc3lZSW16?=
 =?utf-8?B?ZCtsWWIrRGd2MCsrRHVOS3FSSFhvTDFraHkzMzJkd3V2OEpYRXQ5dkVrTXlQ?=
 =?utf-8?B?V2hYMjZlejI4VC9iUGt2RitQdmRrdXlYT2pTQjQwUlNaZlQxZ1prTHRKWWlm?=
 =?utf-8?B?bUxaSjdUU29UWmZNQ1NTdkMyQVFEeE9RV3g4OHhacUcyc0ZUQkZBd2lQU2R6?=
 =?utf-8?B?OE9nOGR5N1prRzlVaklWbkMwcnFSd1c5WXcyNU9xUGNkQTNhbEp5TlhDZWNj?=
 =?utf-8?B?NHpNQUJyemYveE54RFRya2pWOWRyNTJBV09PUEExRHhtbXVSNXIySzI2ZmJQ?=
 =?utf-8?B?aVRNcmREaG9nTTg2dkEwOXZsZHUxdkN6OHVqQXIycmJUZ2FJb3hmMUNPMnNq?=
 =?utf-8?B?NkF2S0FOelhyZHE1WWRyN2RhZzRmRGljcnNtL3U0SGJBS2ZzYnBQZXlqOG5q?=
 =?utf-8?B?eW83bzNVZnhxcmZrRUVSVUliME84NnNIZFBDcHQrREVuM1hGR3B4SWdORGFM?=
 =?utf-8?B?Uzl3Y1J3V1EweTJESUJ3SFdXMDhMckxpeFF1MHdialNqWUpLL3JHU1NDL3JN?=
 =?utf-8?B?TmZTdmZKNVFsK2VDeHdITldOM3J2WDB1US9nSWREZmNqUTlhTlBrTzVXejNh?=
 =?utf-8?B?UnJRWk0xSlFoekRQRTFSZ0YyTVMrRFAwSFJidytzZTJ3Mm1Oc3h2bVY5VFRL?=
 =?utf-8?B?WCsxZWMyRHdLR1BPT2NUeFVQeFE1SWNJdUVMUjhOSXVGb0VIVW8xWDFuY3lN?=
 =?utf-8?B?d3ovUUY3cVlnampwRVlrMk9WZnVTcjZ4MzJHcmkxQzgxeWNoVS81emowRDZJ?=
 =?utf-8?B?aTZpSSsvRnB0KzdSOUxDU21Rd1lnR1FjTmdWY252eXNMUW4weXF2S3VFdWM3?=
 =?utf-8?B?MTNlSWVxcXNITTBDMkFBRm5LZHozODV3Uk54c3BXRHA5VlJtUnFvYUxrL2xB?=
 =?utf-8?B?ZDNWQlliUGZMcEtmM0hPRTdNSUhLMWxEaG9YbWRhdjF5UU83TjBoL2diS1Rn?=
 =?utf-8?B?TGZPYm5lWGlpeEpyQlRIeGVaN1QwY2lEY25hSGJsV3ZDaVhnclhpL1lmS0FB?=
 =?utf-8?B?Zm5ORG9NTXlIYVh2ajBXOU5RWGczZDJ2TUloSzVXbkFwV3BpTUVERVVRZHdI?=
 =?utf-8?B?UkQvR0RTMmw4NnJtN2hnWmwxUGlTZDdCUVpPSmpFd2xFZ0dEMTlDMThnUm9k?=
 =?utf-8?B?MDlzWDVGbjFWeGUzdERNeHZSNG9IMFFNSEpRTFFWclI0dVhKV3RrQ3p6RG9W?=
 =?utf-8?B?dHJKSlEyQkMrdnJQUkxHak8yU3dsUlBnK2ZpdVhzL3BvL1haYktHNjdCbWdQ?=
 =?utf-8?B?dTR3c3plcGF2bU9ZOWZUMHU1eXVpck8wRkZwY01PMlc2Q3pvNFRmUXlmMkVM?=
 =?utf-8?Q?af43CIakkL6uacdg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719e2375-7b53-4f58-297d-08df021d4afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 20:21:34.4935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W47oL8LrD4uc4bobGK887vdBq0mp0fHa5WcMj+N5wAauFg3Ue7xs9tVT1uNjeEqNJVMUsZLyt+/i5Jq19roeMT04aYZqN8rgbkanPwG8ApZMLe8pv83CdDO6g0i4JbQF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB10018

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLdW1hciBLYXJ0aWtleWEgRHdp
dmVkaSA8bWVteG9yQGdtYWlsLmNvbT4gDQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDI0LCAyMDI2
IDEwOjEwIFBNDQo+IFRvOiBKYWt1YiBLaWNpbnNraSA8a3ViYUBrZXJuZWwub3JnPjsgQ2hpYS1Z
dSBDaGFuZyAoTm9raWEpIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+IENj
OiBqb2huLmZhc3RhYmVuZEBnbWFpbC5jb207IGpha3ViQGNsb3VkZmxhcmUuY29tOyBqaWF5dWFu
LmNoZW5AbGludXguZGV2OyBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBicGZAdmdlci5rZXJuZWwu
b3JnOyBhc3RAa2VybmVsLm9yZzsgZGFuaWVsQGlvZ2VhcmJveC5uZXQ7IGFuZHJpaUBrZXJuZWwu
b3JnOyBlZGR5ejg3QGdtYWlsLmNvbTsgbWFydGluLmxhdUBsaW51eC5kZXY7IHNvbmdAa2VybmVs
Lm9yZzsgeW9uZ2hvbmcuc29uZ0BsaW51eC5kZXY7IGpvbHNhQGtlcm5lbC5vcmc7IGVtaWxAZXRz
YWxhcGF0aXMuY29tOyBsaW51eC1rc2VsZnRlc3RAdmdlci5rZXJuZWwub3JnOyBzaHVhaEBrZXJu
ZWwub3JnOyBob3Jtc0BrZXJuZWwub3JnOyBkc2FoZXJuQGtlcm5lbC5vcmc7IHBhYmVuaUByZWRo
YXQuY29tOyBqaHNAbW9qYXRhdHUuY29tOyBzdGVwaGVuQG5ldHdvcmtwbHVtYmVyLm9yZzsgZGF2
ZW1AZGF2ZW1sb2Z0Lm5ldDsgZWR1bWF6ZXRAZ29vZ2xlLmNvbTsgYW5kcmV3K25ldGRldkBsdW5u
LmNoOyBkb25hbGQuaHVudGVyQGdtYWlsLmNvbTsga3VuaXl1QGdvb2dsZS5jb207IGlqQGtlcm5l
bC5vcmc7IG5jYXJkd2VsbEBnb29nbGUuY29tOyBLb2VuIERlIFNjaGVwcGVyIChOb2tpYSkgPGtv
ZW4uZGVfc2NoZXBwZXJAbm9raWEtYmVsbC1sYWJzLmNvbT47IGcud2hpdGVAY2FibGVsYWJzLmNv
bTsgaW5nZW1hci5zLmpvaGFuc3NvbkBlcmljc3Nvbi5jb207IG1pcmphLmt1ZWhsZXdpbmRAZXJp
Y3Nzb24uY29tOyBjaGVzaGlyZUBhcHBsZS5jb207IHJzLmlldGZAZ214LmF0OyBKYXNvbl9MaXZp
bmdvb2RAY29tY2FzdC5jb207IHZpZGhpX2dvZWxAYXBwbGUuY29tOyBNaWtlX1J1ZG9scGhAY29t
Y2FzdC5jb207IEplZmZfSG93ZUBjb21jYXN0LmNvbTsgc3JpY2hhcmRAbmV0YXBwLmNvbQ0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHY4IG5ldC1uZXh0IDAvMl0gRXhwbGljaXQgVFNPIHNlZ21lbnQg
Y291bnQNCj4gDQo+IA0KPiBDQVVUSU9OOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVh
c2UgYmUgdmVyeSBjYXJlZnVsIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2ht
ZW50cy4gU2VlIHRoZSBVUkwgbm9rLml0L2V4dCBmb3IgYWRkaXRpb25hbCBpbmZvcm1hdGlvbi4N
Cj4gDQo+IA0KPiANCj4gT24gTW9uIEF1ZyAyNCwgMjAyNiBhdCAxMDowNSBQTSBDRVNULCBKYWt1
YiBLaWNpbnNraSB3cm90ZToNCj4gPiBPbiBNb24sIDI0IEF1ZyAyMDI2IDE4OjMxOjM3ICswMjAw
IGNoaWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbQ0KPiA+IHdyb3RlOg0KPiA+PiBGcm9t
OiBDaGlhLVl1IENoYW5nIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJlbGwtbGFicy5jb20+DQo+ID4+
DQo+ID4+IEhlbGxvLA0KPiA+Pg0KPiA+PiBUaGlzIHNlcmllcyByZXBsYWNlcyB0aGUgZXhpc3Rp
bmcgbWluX3Rzb19zZWdzKCkgY29uZ2VzdGlvbiBjb250cm9sIA0KPiA+PiBjYWxsYmFjayB3aXRo
IGEgbmV3IHRzb19zZWdzKCkgY2FsbGJhY2sgdGhhdCBhbGxvd3MgY29uZ2VzdGlvbiANCj4gPj4g
Y29udHJvbCBhbGdvcml0aG1zIHRvIHByb3ZpZGUgYW4gZXhwbGljaXQgVFNPIHNlZ21lbnQgY291
bnQgZm9yIGVhY2ggZGF0YSBidXJzdC4NCj4gPj4NCj4gPj4gVG8gc3VwcG9ydCBCUEYgY29uZ2Vz
dGlvbiBjb250cm9scywgdGhlIHNlcmllcyBhbHNvIGV4cG9zZXMNCj4gPj4gdGNwX3Rzb19hdXRv
c2l6ZSgpIGFzIGEgQlBGIGtmdW5jLCBhbGxvd2luZyBCUEYgaW1wbGVtZW50YXRpb25zIHRvIA0K
PiA+PiByZXVzZSB0aGUga2VybmVsIFRTTyBhdXRvc2l6aW5nIGxvZ2ljIHdoaWxlIGltcGxlbWVu
dGluZyBjdXN0b20NCj4gPj4gdHNvX3NlZ3MoKSBjYWxsYmFja3MuDQo+ID4NCj4gPiBBSSBDSSBz
YXlzOg0KPiA+DQo+ID4gVGhlIGJwZi1jaSBidWlsZCBqb2JzIGFyZSBmYWlsaW5nIGZvciB0aGlz
IHBhdGNoIG9uIGFsbCB0ZXN0ZWQgDQo+ID4gYXJjaGl0ZWN0dXJlcy90b29sY2hhaW5zICh4ODYt
NjQgZ2NjLTE1LCB4ODYtNjQgbGx2bS0yMSwgYWFyY2g2NCANCj4gPiBnY2MtMTUsIHMzOTB4IGdj
Yy0xNSksIGFsbCB3aXRoIHRoZSBzYW1lIGxpbmstdGltZSBlcnJvcjoNCj4gPg0KPiA+ICAgbmV0
L2lwdjQvdGNwX2Jici5vOiBpbiBmdW5jdGlvbiBgX19CVEZfSURfX3NldDhfX3RjcF9iYnJfY2hl
Y2tfa2Z1bmNfaWRzJzoNCj4gPiAgIHRjcF9iYnIuYzooLkJURl9pZHMrMHguLi4pOiB1bmRlZmlu
ZWQgcmVmZXJlbmNlIHRvIGBLRl9ERVBSRUNBVEVEJw0KPiA+DQo+ID4gVGhpcyBjb21lcyBmcm9t
IHRoZSBjaGFuZ2UgdG8gbmV0L2lwdjQvdGNwX2Jici5jIHRoYXQgbWFya3MgdGhlIA0KPiA+IHJl
dGFpbmVkDQo+ID4gYmJyX21pbl90c29fc2VncygpIGtmdW5jIGVudHJ5IHdpdGggdGhlIEtGX0RF
UFJFQ0FURUQgZmxhZzoNCj4gPg0KPiA+ICAgQlRGX0lEX0ZMQUdTKGZ1bmMsIGJicl9taW5fdHNv
X3NlZ3MsIEtGX0RFUFJFQ0FURUQpDQo+ID4gICBCVEZfSURfRkxBR1MoZnVuYywgYmJyX3Rzb19z
ZWdzKQ0KPiA+DQo+ID4gS0ZfREVQUkVDQVRFRCBkb2VzIG5vdCByZXNvbHZlIHRvIGEgdXNhYmxl
IHN5bWJvbC9mbGFnIGluIHRoaXMgdHJlZSwgDQo+ID4gc28gdGhlIEJURiBpZCBzZXQgZm9yIHRj
cF9iYnIgZmFpbHMgdG8gbGluayBpbnRvIHZtbGludXggb24gZXZlcnkgDQo+ID4gYXJjaGl0ZWN0
dXJlIGFuZCB0b29sY2hhaW4gLS0gaXQncyBhIHN0cmFpZ2h0IHVuZGVmaW5lZC1yZWZlcmVuY2Ug
DQo+ID4gZXJyb3IsIG5vdCBhIHBlci1hcmNoL3Blci1jb25maWcgaXNzdWUuDQo+ID4NCj4gPiBD
b3VsZCB5b3UgZHJvcCB0aGUgS0ZfREVQUkVDQVRFRCBmbGFnIChvciB1c2UgYSBmbGFnIHRoYXQg
dGhpcyBrZnVuYyANCj4gPiBpbmZyYXN0cnVjdHVyZSBhY3R1YWxseSBkZWZpbmVzKSBvbiBiYnJf
bWluX3Rzb19zZWdzLCBhbmQgcmUtdmVyaWZ5IA0KPiA+IHRoYXQgdGhlIGtlcm5lbCBsaW5rcyBj
bGVhbmx5PyBBIGxvY2FsIGBtYWtlIG5ldC9pcHY0L3RjcF9iYnIubyANCj4gPiB2bWxpbnV4YCBi
dWlsZCAob3IgdGhlIGJwZi1jaSBzZWxmdGVzdCBidWlsZCBqb2IpIHNob3VsZCByZXByb2R1Y2Ug
dGhpcyBxdWlja2x5Lg0KPiA+DQo+ID4gRnVsbCBidWlsZCBsb2cgZm9yIHJlZmVyZW5jZToNCj4g
Pg0KPiA+ICAgbGQubGxkLTIxOiBlcnJvcjogdW5kZWZpbmVkIHN5bWJvbDogS0ZfREVQUkVDQVRF
RA0KPiA+ICAgPj4+IHJlZmVyZW5jZWQgYnkgdXNlcmNvcHlfNjQuYw0KPiA+ICAgPj4+ICAgICAg
ICAgICAgICAgdm1saW51eC5vOihfX0JURl9JRF9fc2V0OF9fdGNwX2Jicl9jaGVja19rZnVuY19p
ZHMpDQo+IA0KPiBJIHRoaW5rIENoaWEtWXUncyBBSSBpcyBoYWxsdWNpbmF0aW5nLCBpdCB3YXMg
YSBwcm9wb3NlZCBmbGFnIGJ1dCBub3QgYWRkZWQgeWV0Li4uDQoNCkhpIEt1bWFyIGFuZCBLdWJh
LA0KDQpJIHdpbGwgZHJvcCBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uOyBob3dldmVyLCB0aGlzIEFJ
IGhhbGx1Y2luYXRpb24gaXMgZnJvbSBTYXNoaWtvJ3MgZmVlZGJhY2sgSSBnb3Q6DQoNCmh0dHBz
Oi8vbmV0ZGV2LWFpLmJvdHMubGludXguZGV2L3Nhc2hpa28vIy9wYXRjaHNldC8yMDI2MDgxNDE3
MzAzNC43NDkxNTEtMS1jaGlhLXl1LmNoYW5nJTQwbm9raWEtYmVsbC1sYWJzLmNvbQ0KDQpCVFcs
IGFueSBCUEYtcmVsYXRlZCBmbGFnIGlzIHN1Z2dlc3RlZCB0byBiZSBhZGRlZCBmb3IgZ3JhY2Vm
dWwgZGVncmFkYXRpb24/DQoNClRoYW5rcy4NCkNoaWEtWXUNCg==
