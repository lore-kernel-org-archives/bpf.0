Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793136078;
	b=omnzYTpGSPMS11WyJZj09c0EI0muwUsxo5IKpyIfXDaVcW4RSaqpXLdUvJP96sbwGUb6
	 FKc+/i897PRh4ULIzkDMddPQ/FM0JzsRAFJT8vAHrfqjlCuu2nKyWTj1rqJCgR6ENqKsO
	 SGEUpxrDPbeiajjA2k0eo25USBu/Fcq1l321sF009WfhA7Pe3bZAE4XxYlfD0PdlBMQrU
	 uNHqnAmODAVR7lqIOCMQCdXoHu51natkWM/YUhA/gQUASIBba7lM2++KlJrvXJrmX61cK
	 SkIinRNOI6GEjF8CLkSdwwqk6+SpWYIOjSZj1097t92RUuD7iiF78MEuduFUe6PS0/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793136078;
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
	bh=LHs55lKs1HMrK5d/NDXfYO7ffk27n0WZ4Z3QmA7N7b8=;
	b=qVqjUn8U3mm4Mhh9q/crohBoZxHwOXPKtUbtTVdgfHydTy0WtI5gdN1wYOpRaDqAgAXl
	 lnE4F9pqSofUGVXXSU2/uKL5RwzPnGvLVi75UZ5HAIDu1ITZZ5ax/DCRReC9R5490+PmL
	 OVgNqnU1kulc/VcF00ihImUxbAn9aqksMFU5bMVMLI+s1P8WSzA4Gxypx15bYqxCJHZrH
	 dRNvWLGovqGvk1y8ee+ELsVyMOORKDaateHOgbTWLMro+1PPc/gytrHiLe1+imM7z+ob7
	 XBhHFovqB37qzEOqBELVas+evYIq2codMCgDro2o7FlwlfvhQGC2hCAOw7OAcsizTog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nokia-bell-labs.com;
	spf=fail smtp.mailfrom=nokia-bell-labs.com;
	dkim=pass header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=IYI87e5l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.22
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013022.outbound.protection.outlook.com [40.107.159.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91E4606A31A;
	Tue, 27 Oct 2026 21:21:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E91E4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.a=rsa-sha256 header.s=selector1 header.b=IYI87e5l
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWmy6q7bJoKYlA8EhhnANkk1DXVMiFNBSrcCnPXs0Ej0L6T+peKF5MQw5qClXho6yK4h1q2+cBHsRcRvOYjy6RDSBcdAWZhYv7QO+oyhzQTqo3SPsP8aXL8zFyW+jwu3bW/FawsbsFaJ7oKWgKqSZnbjyh/w1q2DOMS53JR6GLdobdmM3udY1CUowpXcHFogfUgVLmbuYwCYvWBZJODW13igczUZA6mC50JDV1Ck2s0XLJbafap57N6km2HFuDIwUqLtIWFlYh/WYRaMwT7APj8NSGEKTn9VTa24rnFCaSAguVFGPcHhedlhL5XxaqE+DDwAwiVy53zWouGlqLWk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHs55lKs1HMrK5d/NDXfYO7ffk27n0WZ4Z3QmA7N7b8=;
 b=m2Fq2hq/Rb1TRLvQibv/ACQ2sqkjo5WpJUZVf5Z/X9FQnnQnj9do3bmP9aiMLy+ebgEkv2EQYzDqPBvb3Xx3yAOCHMdDGrvq0Xg9N9C4uWRVqzCwE6P4u1h3HT0d7EU/4mj+VBdQuPkUDvYR1t7B0BvOzBnW4oZfcSc24ezzVmbQNfe0bsFz2diRYREuoH0AAFqKukfanyXtzQCYHDa/fDeODn3gLthKUbRkIP2o9M2s0u6a9aMZY58mMgqubE9bRH9B9ff2oJwbqLRtylMpo63o8vjWvbexf2Abx6smSdje+GQlyqpfH1tYgwrnB5Txnwm97QIeyongyV6xpFPauQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHs55lKs1HMrK5d/NDXfYO7ffk27n0WZ4Z3QmA7N7b8=;
 b=IYI87e5lnqNqH3JByNiaNQw/TmawsV8biaKREtDxbWWJ1//G2rgGkzlk9ZEem3nhZg/eloMoAwUC7koccylyoVM8Txikv4XNFI/otecKKgJaDQgAMyhgkDvY7Ub8aJh0X/tl/hmHWqYQcFNMc9O9TkRVBylZg47UqOHA0kixDfEy9wbxi6crK3qjuc/ZjGyyn6cvd6+pHp2DsvQWqdMkFNPywddHhZqqV54Kj/HYejzuRF8v61qaRHMzzvlLf/PVhGEgn2DgdMTn3CkpTIW9DOI4d9ft+9TClkQFUq5yC/7A6I59idYjQ0/TX7VurQX7ioME4+7jzUUIHEHmp6zpLQ==
Received: from AS2PR07MB9123.eurprd07.prod.outlook.com (2603:10a6:20b:55a::8)
 by DB9PR07MB9341.eurprd07.prod.outlook.com (2603:10a6:10:456::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 21:21:14 +0000
Received: from AS2PR07MB9123.eurprd07.prod.outlook.com
 ([fe80::ddd6:7bad:4de5:5106]) by AS2PR07MB9123.eurprd07.prod.outlook.com
 ([fe80::ddd6:7bad:4de5:5106%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 21:21:13 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>
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
	<srichard@netapp.com>, Yuchung Cheng <ycheng@google.com>
Subject: RE: [PATCH net-next v2 3/3] tcp: Add mss_cache_set_by_cca for CC
 algorithm to set MSS
Thread-Topic: [PATCH net-next v2 3/3] tcp: Add mss_cache_set_by_cca for CC
 algorithm to set MSS
Thread-Index: AQHdX0XNiQF5A3gqyUyeH6IRwVStEbcFBWWAgAEPGYCAC97cgA==
Date: Tue, 27 Oct 2026 21:21:13 +0000
Message-ID:
 <AS2PR07MB91239686EA0A6363AD1ACBB2A3602@AS2PR07MB9123.eurprd07.prod.outlook.com>
References: <20261018211514.2817293-1-chia-yu.chang@nokia-bell-labs.com>
 <20261018211514.2817293-4-chia-yu.chang@nokia-bell-labs.com>
 <CADVnQyn1sjYzfCRiVKOxvyXbx0j2_3y5t9FsyTr81YG9XjdvxA@mail.gmail.com>
 <CAL4Wiio29vZ1V7FavAH5dXpRQB5U=dpvaHVAjvGPc7K1E=wLEQ@mail.gmail.com>
In-Reply-To:
 <CAL4Wiio29vZ1V7FavAH5dXpRQB5U=dpvaHVAjvGPc7K1E=wLEQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR07MB9123:EE_|DB9PR07MB9341:EE_
x-ms-office365-filtering-correlation-id: ffbb48ee-3b84-456d-c83f-08df34703ab7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|23010399003|1800799024|376014|366016|22082099003|18002099003|261026135527099003|261026140227099003|3023799007|261026130827099003|261021121427099003|11063799006|56012099006|4143699003|10067099003|261021123027099003|261009223027099003|261022115727099003|261022105027099003|261021130227099003|261022075727099003|261021135927099003|261022113327099003|261021133027099003|261026121527099003|38070700021;
x-microsoft-antispam-message-info:
 4nGxst2INAOWfEW3L7Y/YDv6DmG8yyp81SrApos58u6+0r9+GEd71ShlZMC/ne0coCrYBwsUoRR2ErwxL5J+o6qCfkWrYnoTWmuWCc7f/DLk0n0HKog7arX2xMI3uLaczk2invNa7egA5J/oD0Ck5x3peuK2aUpwBZbF2A1EeQ37evEMqYqUV7z2p2jqtOeuMluHKwMj7jMb7CP+OWYe0qDJN+4qtFfzXvpnyBHzuyqhrI06BShE56TzPo7JFEolbr8hlANRV3HUsQPTgQWQGpXNH0cYZ2eq0uHuCtYz7W8cFDJpp6bCBhfB7OMGvoW2akZZqeEGKgie2uCBpsz5Qf9GEO2KCEdo1FkFJMIkYSbuBBV/hJvKW3S/qw8nhPp6Eu0XE6howvib4183SMZYxowi1gJ0/J1sdrMLyQd6N7nJHQLv66CKyIzyR4Z2Kfe9iMAta5FHfc+83BQQgO+3BCPuGi2Sm6ImNKVtomFhDtsf/3hNZsvCB72Tdf/oXMfmLxYMvlsXbs+hoECTg0HiC44WcdQdf9cpb3VoSBrkIR8WBpsBdUp609TP15NLS5fp7voK0IOOE6zhnAwgZNkKnoTACdLb9SNJkOV3Hz5TpOop7EwLLANiWjzWvNd0vZdhs7/eCDCCR9vgLsKq09lXobWc+33hhQqDeG5vQE677D0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR07MB9123.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(261026135527099003)(261026140227099003)(3023799007)(261026130827099003)(261021121427099003)(11063799006)(56012099006)(4143699003)(10067099003)(261021123027099003)(261009223027099003)(261022115727099003)(261022105027099003)(261021130227099003)(261022075727099003)(261021135927099003)(261022113327099003)(261021133027099003)(261026121527099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGJ4d29QeXNrWlVaUko3RWhQN1pxcVpQOGhyVVcybCt0T1lnZzBBd0JTZ05r?=
 =?utf-8?B?K2ZJMDNLdURwemxvYXJpcDhGQWt5Y3gxbmZEV1p0TXNqK3dTUE1kS2F4bFN2?=
 =?utf-8?B?THdrY2tTS0E4RVNLOHRiMitOd2JoWmIzQndDWEd2YWVRV3pSdmU5TUp2Smp2?=
 =?utf-8?B?d0w5RlcxV1dncXltOWI1L1NJVi9EMHpoTldYenB5VXF4WGJpOWhyZllhZHBO?=
 =?utf-8?B?NXJIeTNIRHBGbmVVL1ZXREF5TkM2bEFDTTcvVU9sdVRwZXFQTEV0dEppZHZs?=
 =?utf-8?B?bmE3SUwyUXp6KzEyMEFLanRnT2k0aGJYdkNvdzF3QXJVVElkd25zTlBBaGxu?=
 =?utf-8?B?V3Nla0ZoNXdYcFNXMDVYdjlMMTdvTzV2VHpyNmFFNUVPNUgxc29HSmZtMEx2?=
 =?utf-8?B?ZHZ6eUtCenNUbkQyVmphaDRsalNlT29Dbnp5ZWgvZyt0dnY4b244cFRqbTNl?=
 =?utf-8?B?N3ZVUkM4YkxrK2xpVFBxU0pnaVFvV0o4NkF6U2RWU0FMK3dRVkJJUXd3NlJY?=
 =?utf-8?B?aktZZ3BaMG5zMC9EOUxNY1M3YkF5ODVtcTFLM2JqaElvdEpPbEV3MnhPZ296?=
 =?utf-8?B?QWh0UzlwLzEwL3RnZ2NwckxWSHpqSDB4UHM3eGZmckNrdmtLWmNKMWVLRWdF?=
 =?utf-8?B?SHhQZXRveDRUc3JyUmg3S1N4ZmFvWjNCc0Jzem4ralNEbFB3M2dHdTI3MTJn?=
 =?utf-8?B?SWFKUU9IT3F0NXFIR1RxK2RON2ZxT25qSHVTZThmN3Y3Q2NoVWY4OSsyN2Fa?=
 =?utf-8?B?cFlOVXlZaHNIV2g1ZEJGMi9IYWtZYnBSS1ZkNytUM281N00xK1BrWlNLclVB?=
 =?utf-8?B?bE56bVVZdU90SnR1RmxwSUIvOCt3M3lWc0s3MWh2ck9qT1JoQ2JDQU9uU21u?=
 =?utf-8?B?ckRqRFJhMWY1MmEwSEJSZTJHRFhyTjVqdzRncXE0ZytnUlI2R2xudUluaWts?=
 =?utf-8?B?Y1pST1k4cGlIM0ZmK3plbXQza2JDMGpWRUVlLy8vMkYxWXpKUlRyUUdGeXZH?=
 =?utf-8?B?QXFsZWIvaWRWVVMxaGwwaVZaYldlYkhCWlZCdGNwL2FXYnZRRmlRTkpMakll?=
 =?utf-8?B?QkdpSTVrcEc3VTVGZDVQRkpLbDBuNlUyRjBoSHArT0lJOEZCYVgvY0V2VlEy?=
 =?utf-8?B?Q3l0VmozNWNtdm93Vy9BWGNaTHoxaWtaM3Q4cjJNbEM5cTM2dmZqemZuYUYx?=
 =?utf-8?B?Wlk1SERINGVER3pIRnJ1c3BnU0pFNUtFSFRhYUM3akZGRFV6d0UyUGRCVSs2?=
 =?utf-8?B?c0NBUi9jK3FPWXRYd2NxcnpOcU5sNURZay80S2FYZFFBYmJhY25ZODBocS9o?=
 =?utf-8?B?NlByRU9VNDNHYlE2NHd0QW1hWExnZW9POHY4Y2xHSG81M2J4THhuRVpmeEc1?=
 =?utf-8?B?UjY4YWZxUWNIbUtobGVQSEtjZTd5TWlRRnVmL2o2c3EzYmorYlkzQTBWVmxi?=
 =?utf-8?B?ekwyMUNoOGY0eDdSVVRlQ2kyNHFGUTIwTGVVYUxnKzBpRE9nU1BjWFN6MmlQ?=
 =?utf-8?B?amdxTzBQdWdoS2I2M0dJQnpnNmdSNm1NNjREOTE1L2hlVlQxbFJIMWwyZlh1?=
 =?utf-8?B?WlpMTkYzZXJUbHlDZUQyajRoR2tCc3JBaUFnQTU3UnlXOFFpYlZRQ1NwM0Rm?=
 =?utf-8?B?U0hMcnpyYzQ5RmM5eDNTcFY0VUo0SmxCRlhjZWlUUnJIejlqWGw4VXhVd29T?=
 =?utf-8?B?VjdmN1VqMHg0WXVwQUJNWXhEWEFQOG5nZE8yWUNHa0pwQkJDYkhyMEIxUTYz?=
 =?utf-8?B?UmVDTlg1aS9Idk5IbGhTakY3a2dpOHBGYmgrelRJUThDbmJ3dkxvRExwdHVU?=
 =?utf-8?B?U25FNlY5eUlDUW5sU0ZrVkZ0QmpBR09QcVZYYmJLWExESjJUM1dnK3U2Misy?=
 =?utf-8?B?enlaS2hDcmd3aUtMZnhoVlhLNDk3citmQXFHb29VZ1lqVVBPM0NJSFBhbUo4?=
 =?utf-8?B?eU42M25vMmo3T3dMS25yWFVKcjZYSXlBcVp0U3Y4eXd4U0hEb01jSkoxdGsy?=
 =?utf-8?B?K0s3VjZyOVg2STRiTTU4dE05aWVwOVBPMFcvT2ZSTDJXRE1HbXFlQmdlRXRJ?=
 =?utf-8?B?SjVCQnRZTlp1MTJVNXd5Vm5iN2E1dlZiNGxMSml1clRpeThzRVFTTXJBL3U1?=
 =?utf-8?B?MklOQ0g4SGoxYzg4VEUzamxFM2VDYmYvdGpodmJCMkhxNU4vRFlBdVZjS3Jm?=
 =?utf-8?B?Z0lwVEpYWDRRU0hUOVBVbVlaZXN4NzVpeTZTaXMvNW1JYUtvaXEySVVEREJt?=
 =?utf-8?B?RjZ2U2diTFcwdytCZ3lweXJWdjEvS1NOTnQwWERMSEJCeWpSMkx2V3NiSGdO?=
 =?utf-8?B?U3ZBUFlrZkZVQ2YraXIyRXFkMVpsR1h0NG1ERWduSEhlMzRLREUrYUZPeURC?=
 =?utf-8?Q?6tRgxnCNJ0+hflZA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbb48ee-3b84-456d-c83f-08df34703ab7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 21:21:13.5911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qvRs50GGLAXqLzqKyDmSgwCUdWgMsDaPBT2qT39rSUIzTx+djM0za9b+1X1NDRymIle82F7xvcDlVMO50DvvoWV6y5Jg1VGu27qmVQW+BAms3+E3yn/9CAqdgonxfzJ5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9341

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgPGVkdW1h
emV0QGtlcm5lbC5vcmc+IA0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDIwLCAyMDI2IDEwOjA0
IEFNDQo+IFRvOiBOZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29vZ2xlLmNvbT4NCj4gQ2M6IENo
aWEtWXUgQ2hhbmcgKE5va2lhKSA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPjsg
aWhvci5zb2xvZHJhaUBsaW51eC5kZXY7IGpvaG4uZmFzdGFiZW5kQGdtYWlsLmNvbTsgamFrdWJA
Y2xvdWRmbGFyZS5jb207IGppYXl1YW4uY2hlbkBsaW51eC5kZXY7IG5ldGRldkB2Z2VyLmtlcm5l
bC5vcmc7IGJwZkB2Z2VyLmtlcm5lbC5vcmc7IGFzdEBrZXJuZWwub3JnOyBkYW5pZWxAaW9nZWFy
Ym94Lm5ldDsgYW5kcmlpQGtlcm5lbC5vcmc7IGVkZHl6ODdAZ21haWwuY29tOyBtYXJ0aW4ubGF1
QGxpbnV4LmRldjsgc29uZ0BrZXJuZWwub3JnOyB5b25naG9uZy5zb25nQGxpbnV4LmRldjsgam9s
c2FAa2VybmVsLm9yZzsgZW1pbEBldHNhbGFwYXRpcy5jb207IGxpbnV4LWtzZWxmdGVzdEB2Z2Vy
Lmtlcm5lbC5vcmc7IHNodWFoQGtlcm5lbC5vcmc7IGhvcm1zQGtlcm5lbC5vcmc7IGRzYWhlcm5A
a2VybmVsLm9yZzsgcGFiZW5pQHJlZGhhdC5jb207IGpoc0Btb2phdGF0dS5jb207IHN0ZXBoZW5A
bmV0d29ya3BsdW1iZXIub3JnOyBkYXZlbUBkYXZlbWxvZnQubmV0OyBhbmRyZXcrbmV0ZGV2QGx1
bm4uY2g7IGRvbmFsZC5odW50ZXJAZ21haWwuY29tOyBrdW5peXVAZ29vZ2xlLmNvbTsgaWpAa2Vy
bmVsLm9yZzsgS29lbiBEZSBTY2hlcHBlciAoTm9raWEpIDxrb2VuLmRlX3NjaGVwcGVyQG5va2lh
LWJlbGwtbGFicy5jb20+OyBnLndoaXRlQGNhYmxlbGFicy5jb207IGluZ2VtYXIucy5qb2hhbnNz
b25AZXJpY3Nzb24uY29tOyBtaXJqYS5rdWVobGV3aW5kQGVyaWNzc29uLmNvbTsgY2hlc2hpcmVA
YXBwbGUuY29tOyBycy5pZXRmQGdteC5hdDsgSmFzb25fTGl2aW5nb29kQGNvbWNhc3QuY29tOyB2
aWRoaV9nb2VsQGFwcGxlLmNvbTsgTWlrZV9SdWRvbHBoQGNvbWNhc3QuY29tOyBKZWZmX0hvd2VA
Y29tY2FzdC5jb207IHNyaWNoYXJkQG5ldGFwcC5jb207IFl1Y2h1bmcgQ2hlbmcgPHljaGVuZ0Bn
b29nbGUuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0IHYyIDMvM10gdGNwOiBB
ZGQgbXNzX2NhY2hlX3NldF9ieV9jY2EgZm9yIENDIGFsZ29yaXRobSB0byBzZXQgTVNTDQo+IA0K
PiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGVkdW1hemV0QGtlcm5lbC5vcmcuIExl
YXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFybkFib3V0U2Vu
ZGVySWRlbnRpZmljYXRpb24gXQ0KPiANCj4gQ0FVVElPTjogVGhpcyBpcyBhbiBleHRlcm5hbCBl
bWFpbC4gUGxlYXNlIGJlIHZlcnkgY2FyZWZ1bCB3aGVuIGNsaWNraW5nIGxpbmtzIG9yIG9wZW5p
bmcgYXR0YWNobWVudHMuIFNlZSB0aGUgVVJMIG5vay5pdC9leHQgZm9yIGFkZGl0aW9uYWwgaW5m
b3JtYXRpb24uDQo+IA0KPiANCj4gDQo+IExlIGx1bi4gMTkgb2N0LiAyMDI2IMOgIDE3OjUzLCBO
ZWFsIENhcmR3ZWxsIDxuY2FyZHdlbGxAZ29vZ2xlLmNvbT4gYSDDqWNyaXQgOg0KPiA+DQo+ID4g
T24gU3VuLCBPY3QgMTgsIDIwMjYgYXQgNToxNeKAr1BNIDxjaGlhLXl1LmNoYW5nQG5va2lhLWJl
bGwtbGFicy5jb20+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEZyb206IENoaWEtWXUgQ2hhbmcgPGNo
aWEteXUuY2hhbmdAbm9raWEtYmVsbC1sYWJzLmNvbT4NCj4gPiA+DQo+ID4gPiBNYWtlIHRoZSBD
QyBtb2R1bGUgc2V0IHRoZSBtc3NfY2FjaGUgc21hbGxlciB0aGFuIHBhdGggbXR1LiBUaGlzIGlz
IA0KPiA+ID4gdXNlZnVsDQo+ID4NCj4gPiBTaW5jZSBtYW55IENDIG1vZHVsZXMgd2lsbCBub3Qg
c2V0IHRoZSBtc3NfY2FjaGUgdmFsdWUsIHJhdGhlciB0aGFuIA0KPiA+ICJNYWtlIHRoZSBDQyBt
b2R1bGUgc2V0IiBJIHRoaW5rIGl0J3MgaW1wb3J0YW50IHRvIHNheSAiQWxsb3cgdGhlIENDIA0K
PiA+IG1vZHVsZSB0byBzZXQiLg0KPiA+DQo+ID4gPiBmb3IgYSBDQyBtb2R1bGUgdGhhdCBtYWlu
dGFpbnMgYW4gaW50ZXJuYWwgZnJhY3Rpb25hbCBjd25kIGxlc3MgdGhhbiANCj4gPiA+IDIgYXQg
dmVyeSBsb3cgc3BlZWQgKDwxMDBrYnBzKSBhbmQgdmVyeSBsb3cgUlRUICg8MW1zKS4gSW4gdGhp
cyANCj4gPiA+IGNhc2UsIHRoZSBtaW5pbXVtIHNuZF9jd25kIGZvciB0aGUgc3RhY2sgcmVtYWlu
cyBhdCAyLCBidXQgdGhlIENDIA0KPiA+ID4gbW9kdWxlIHdpbGwgbGltaXQgdGhlIHBhY2luZyBy
YXRlIHRvIGVuc3VyZSB0aGF0IGl0cyBpbnRlcm5hbCBmcmFjdGlvbmFsIGN3bmQgdGFrZXMgZWZm
ZWN0Lg0KPiA+ID4gVGhlcmVmb3JlLCB0aGUgQ0MgYWxnb3JpdGhtIGNhbiBlbmFibGUgZmluZS1n
cmFpbmVkIGNvbnRyb2wgd2l0aG91dCANCj4gPiA+IGNhdXNpbmcgYmlnIHJhdGUgc2F3LXRvb3Ro
IGFuZCBkZWxheSBqaXR0ZXIuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2hpYS1ZdSBD
aGFuZyA8Y2hpYS15dS5jaGFuZ0Bub2tpYS1iZWxsLWxhYnMuY29tPg0KPiA+ID4gLS0tDQo+ID4g
PiAgaW5jbHVkZS9saW51eC90Y3AuaCAgIHwgMyArKy0NCj4gPiA+ICBuZXQvaXB2NC90Y3AuYyAg
ICAgICAgfCAxICsNCj4gPiA+ICBuZXQvaXB2NC90Y3Bfb3V0cHV0LmMgfCA1ICsrKy0tDQo+ID4g
PiAgMyBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4g
Pg0KPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdGNwLmggYi9pbmNsdWRlL2xpbnV4
L3RjcC5oIGluZGV4IA0KPiA+ID4gZTRkMTcyMGY0OWYwLi40MjhkNjNlNDYyMDYgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3RjcC5oDQo+ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4
L3RjcC5oDQo+ID4gPiBAQCAtMjMyLDcgKzIzMiw4IEBAIHN0cnVjdCB0Y3Bfc29jayB7DQo+ID4g
PiAgICAgICAgICAgICAgICAgdGNwX3VzZWNfdHMgOiAxLCAvKiBUU3ZhbCB2YWx1ZXMgaW4gdXNl
YyAqLw0KPiA+ID4gICAgICAgICAgICAgICAgIGlzX3NhY2tfcmVuZWc6MSwgICAgLyogaW4gcmVj
b3ZlcnkgZnJvbSBsb3NzIHdpdGggU0FDSyByZW5lZz8gKi8NCj4gPiA+ICAgICAgICAgICAgICAg
ICBpc19jd25kX2xpbWl0ZWQ6MSwvKiBmb3J3YXJkIHByb2dyZXNzIGxpbWl0ZWQgYnkgc25kX2N3
bmQ/ICovDQo+ID4gPiAtICAgICAgICAgICAgICAgcmVjdm1zZ19pbnEgOiAxOy8qIEluZGljYXRl
ICMgb2YgYnl0ZXMgaW4gcXVldWUgdXBvbiByZWN2bXNnICovDQo+ID4gPiArICAgICAgICAgICAg
ICAgcmVjdm1zZ19pbnEgOiAxLC8qIEluZGljYXRlICMgb2YgYnl0ZXMgaW4gcXVldWUgdXBvbiBy
ZWN2bXNnICovDQo+ID4gPiArICAgICAgICAgICAgICAgbXNzX2NhY2hlX3NldF9ieV9jY2E6MTsv
KiBtc3NfY2FjaGUgc2V0IGJ5IENDQSAqLw0KPiA+ID4gICAgICAgICBfX2NhY2hlbGluZV9ncm91
cF9lbmQodGNwX3NvY2tfcmVhZF90eHJ4KTsNCj4gPiA+DQo+ID4gPiAgICAgICAgIC8qIFJYIHJl
YWQtbW9zdGx5IGhvdHBhdGggY2FjaGUgbGluZXMgKi8gZGlmZiAtLWdpdCANCj4gPiA+IGEvbmV0
L2lwdjQvdGNwLmMgYi9uZXQvaXB2NC90Y3AuYyBpbmRleCBmNGM5MTAxZTU5OTYuLjcwOGUxODMw
MjI3YiANCj4gPiA+IDEwMDY0NA0KPiA+ID4gLS0tIGEvbmV0L2lwdjQvdGNwLmMNCj4gPiA+ICsr
KyBiL25ldC9pcHY0L3RjcC5jDQo+ID4gPiBAQCAtNDU3LDYgKzQ1Nyw3IEBAIHZvaWQgdGNwX2lu
aXRfc29jayhzdHJ1Y3Qgc29jayAqc2spDQo+ID4gPiAgICAgICAgIHRwLT5zbmRfc3N0aHJlc2gg
PSBUQ1BfSU5GSU5JVEVfU1NUSFJFU0g7DQo+ID4gPiAgICAgICAgIHRwLT5zbmRfY3duZF9jbGFt
cCA9IH4wOw0KPiA+ID4gICAgICAgICB0cC0+bXNzX2NhY2hlID0gVENQX01TU19ERUZBVUxUOw0K
PiA+ID4gKyAgICAgICB0cC0+bXNzX2NhY2hlX3NldF9ieV9jY2EgPSBmYWxzZTsNCj4gPiA+DQo+
ID4gPiAgICAgICAgIHRwLT5yZW9yZGVyaW5nID0gUkVBRF9PTkNFKHNvY2tfbmV0KHNrKS0+aXB2
NC5zeXNjdGxfdGNwX3Jlb3JkZXJpbmcpOw0KPiA+ID4gICAgICAgICB0Y3BfYXNzaWduX2Nvbmdl
c3Rpb25fY29udHJvbChzayk7DQo+ID4gPiBkaWZmIC0tZ2l0IGEvbmV0L2lwdjQvdGNwX291dHB1
dC5jIGIvbmV0L2lwdjQvdGNwX291dHB1dC5jIGluZGV4IA0KPiA+ID4gMzI0OGYzODk1YjE1Li5j
NTNkNzA3MTg4MzAgMTAwNjQ0DQo+ID4gPiAtLS0gYS9uZXQvaXB2NC90Y3Bfb3V0cHV0LmMNCj4g
PiA+ICsrKyBiL25ldC9pcHY0L3RjcF9vdXRwdXQuYw0KPiA+ID4gQEAgLTIwODIsNyArMjA4Miw3
IEBAIHVuc2lnbmVkIGludCB0Y3Bfc3luY19tc3Moc3RydWN0IHNvY2sgKnNrLCB1MzIgcG10dSkN
Cj4gPiA+ICAgICAgICAgc3RydWN0IGluZXRfY29ubmVjdGlvbl9zb2NrICppY3NrID0gaW5ldF9j
c2soc2spOw0KPiA+ID4gICAgICAgICBpbnQgbXNzX25vdzsNCj4gPiA+DQo+ID4gPiAtICAgICAg
IGlmIChpY3NrLT5pY3NrX210dXAuc2VhcmNoX2hpZ2ggPiBwbXR1KQ0KPiA+ID4gKyAgICAgICBp
ZiAoaWNzay0+aWNza19tdHVwLnNlYXJjaF9oaWdoID4gcG10dSAmJiANCj4gPiA+ICsgIXRwLT5t
c3NfY2FjaGVfc2V0X2J5X2NjYSkNCj4gPiA+ICAgICAgICAgICAgICAgICBpY3NrLT5pY3NrX210
dXAuc2VhcmNoX2hpZ2ggPSBwbXR1Ow0KPiA+DQo+ID4gVGhpcyBsb29rcyBzdXNwaWNpb3VzLCBv
ciBhdCBsZWFzdCBJIGRvbid0IHVuZGVyc3RhbmQgdGhlIG1vdGl2YXRpb24gDQo+ID4gaGVyZS4g
V2hhdCdzIHRoZSBtb3RpdmF0aW9uIGZvciB0aGlzPw0KPiA+DQo+ID4gPiAgICAgICAgIG1zc19u
b3cgPSB0Y3BfbXR1X3RvX21zcyhzaywgcG10dSk7IEBAIC0yMDk2LDYgKzIwOTYsNyBAQCANCj4g
PiA+IHVuc2lnbmVkIGludCB0Y3Bfc3luY19tc3Moc3RydWN0IHNvY2sgKnNrLCB1MzIgcG10dSkN
Cj4gPiA+DQo+ID4gPiAgICAgICAgIHJldHVybiBtc3Nfbm93Ow0KPiA+ID4gIH0NCj4gPiA+ICtF
WFBPUlRfU1lNQk9MKHRjcF9zeW5jX21zcyk7DQo+ID4gPg0KPiA+ID4gIC8qIENvbXB1dGUgdGhl
IGN1cnJlbnQgZWZmZWN0aXZlIE1TUywgdGFraW5nIFNBQ0tzIGFuZCBJUCBvcHRpb25zLA0KPiA+
ID4gICAqIGFuZCBldmVuIFBNVFUgZGlzY292ZXJ5IGV2ZW50cyBpbnRvIGFjY291bnQuDQo+ID4g
PiBAQCAtMjExMSw3ICsyMTEyLDcgQEAgdW5zaWduZWQgaW50IHRjcF9jdXJyZW50X21zcyhzdHJ1
Y3Qgc29jayAqc2spDQo+ID4gPg0KPiA+ID4gICAgICAgICBtc3Nfbm93ID0gdHAtPm1zc19jYWNo
ZTsNCj4gPiA+DQo+ID4gPiAtICAgICAgIGlmIChkc3QpIHsNCj4gPiA+ICsgICAgICAgaWYgKGRz
dCAmJiAhdHAtPm1zc19jYWNoZV9zZXRfYnlfY2NhKSB7DQo+ID4gPiAgICAgICAgICAgICAgICAg
dTMyIG10dSA9IGRzdF9tdHUoZHN0KTsNCj4gPiA+ICAgICAgICAgICAgICAgICBpZiAobXR1ICE9
IGluZXRfY3NrKHNrKS0+aWNza19wbXR1X2Nvb2tpZSkNCj4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgIG1zc19ub3cgPSB0Y3Bfc3luY19tc3Moc2ssIG10dSk7DQo+ID4NCj4gPiBIb3cgaXMg
dGhpcyBnb2luZyB0byB3b3JrIGlmIHRoZSBwYXRoIE1UVSByZWR1Y2VzPyBGb3IgZXhhbXBsZSwg
aWYgdGhlIA0KPiA+IHN5c2FkbWluIGxvd2VycyB0aGUgTVRVIHRvIGJlIGxvd2VyIHRoYW4gd2hh
dCdzIGNvbnNpc3RlbnQgd2l0aCB0aGUgDQo+ID4gTVNTIHZhbHVlIHRoZSBDQyBtb2R1bGUgY2hv
c2U/IFdvbid0IHRoZSBwYWNrZXRzIGZyb20gdGhlIGNvbm5lY3Rpb24gDQo+ID4gYWxsIGJlIGJp
Z2dlciB0aGFuIHRoZSBNVFUsIGNhdXNpbmcgd2VpcmQgZnJhZ21lbnRhdGlvbiBvciANCj4gPiBi
bGFjay1ob2xpbmc/DQo+ID4NCj4gPiBBRkFJQ1QsIHRvIGJlIHNhZmUsIGlmIHRoZSBkc3RfbXR1
KCkgY2hhbmdlcyB0aGVuIHdlIHN0aWxsIGhhdmUgdG8gDQo+ID4gY2FsbCB0Y3Bfc3luY19tc3Mo
KSwgZXZlbiBpZiB0aGUgQ0MgbW9kdWxlIHdhbnRzIHNvbWUgaW5wdXQgaW50byB0aGUgDQo+ID4g
TVNTIGRlY2lzaW9uLg0KPiA+DQo+ID4gV291bGRuJ3QgaXQgYmUgc2FmZXIgdG8gcHJvcG9zZSB0
aGF0IHRoZSBDQyBtb2R1bGUgb3B0aW9uYWxseSBzZXRzIGEgDQo+ID4gY2VpbGluZyBmb3IgdGhl
IE1TUyB2YWx1ZSwgcmF0aGVyIHRoYW4gZ2l2aW5nIGl0IGRpcmVjdCBjb250cm9sIG92ZXIgDQo+
ID4gdGhlIE1TUyB2YWx1ZT8gQWxvbmcgdGhvc2UgbGluZXMsIHBlcmhhcHMgQ0MgbW9kdWxlcyB0
aGF0IHdhbnQgdG8gZG8gDQo+ID4gdGhpcyBjb3VsZCBleHBvcnQgYSBuZXcgb3B0aW9uYWwgQ0Mg
bW9kdWxlIGNhbGxiYWNrIHRoYXQgd2UgdXNlIGluIA0KPiA+IF9fdGNwX210dV90b19tc3MoKSwg
cGVyaGFwcyBzb21ldGhpbmcgbGlrZSB0aGlzPw0KPiA+DQo+ID4gICAgICAgICAvKiBDbGFtcCBp
dCAobXNzX2NsYW1wIGRvZXMgbm90IGluY2x1ZGUgdGNwIG9wdGlvbnMpICovDQo+ID4gICAgICAg
ICBpZiAobXNzX25vdyA+IHRwLT5yeF9vcHQubXNzX2NsYW1wKQ0KPiA+ICAgICAgICAgICAgICAg
ICBtc3Nfbm93ID0gdHAtPnJ4X29wdC5tc3NfY2xhbXA7DQo+ID4gKyAgICAgICAvKiBPcHRpb25h
bGx5IGNsYW1wIE1TUyBiYXNlZCBvbiBDQyBtb2R1bGU6ICovDQo+ID4gKyAgICAgICBpZiAoY2Ff
b3BzLT5tYXhfbXNzKQ0KPiA+ICsgICAgICAgICAgICAgICBtc3Nfbm93ID0gbWluKG1zc19ub3cs
IGNhX29wcy0+bWF4X21zcyhzaykpOw0KPiA+DQo+ID4gUGVyaGFwcyBFcmljIG9yIFl1Y2h1bmcg
d2lsbCBoYXZlIGEgYmV0dGVyIGlkZWEuIDotKQ0KPiANCj4gSSBoYXZlIG5vdCBzZWVuIHRoZSBw
YXRjaCBpbiBteSBtYWlsYm94Lg0KPiANCj4gQ2hpYS1ZdSBDaGFuZyBJIHN1Z2dlc3QgeW91IHRy
aW0gdGhlIENDIGxpc3QgYW5kIG1ha2Ugc3VyZSB0byBub3QgZm9yZ2V0IGxpbnV4IG9mZmljaWFs
IG1haW50YWluZXJzLg0KPiANCj4gTXkgZW1haWwgYWRkcmVzcyBoYXMgY2hhbmdlZCB0byBlZHVt
YXpldEBrZXJuZWwub3JnIG9uZSBtb250aCBhZ28uDQoNCkhpIEVyaWMsDQoNClNvcnJ5IEkgZGlk
IG5vdCBub3RpY2Ugc3VjaCBjaGFuZ2UsIEkgd2lsbCBhZGQgdGhpcyBlbWFpbCBpbiB0aGUgbmV4
dCB2ZXJzaW9uLg0KDQpDaGlhLVl1DQo=
