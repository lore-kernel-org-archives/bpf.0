Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEED4369A;
	Fri,  7 Aug 2026 02:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786069304; cv=fail; b=XTWRBdaoLBx94MJ8wTmcWIyGS0gT641DgLnITQdepRLwMMOrTvfwi9Ll2rLAamVYvMDSWgdEfHcpBIsnguLCbp/Sxfcr3HYc/ldHenHT4UCNuSlN6XhGggSKUrALVbilAnxN2kMIvKYz4vlDiTA3JdOdTMpBouA6CVyiaeeFJmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786069304; c=relaxed/simple;
	bh=/zauodbJKl1DcqiRNRf4YKBKvkDeHl2z+9xct54eBl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p1/HxYHGnm2cu7MJRCf5VCfpPc828ovw/E7zeMtteb7OjWUISNb3Ikyt7Sce5WhggpGvPJ/CEslLoBIBj0STxwwtNwKH90inSgUnkozzjiIzEAh/gaGVkJjZ9KiR9nNTuUbouhA3N8yIBBMRfbTRwhQO794Lq7t0SiQcT3VxYK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mo6Mb1QY; arc=fail smtp.client-ip=52.101.84.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mo6Mb1QY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOOJrvWLA6FE8ApOcjYc53OUyDsXA4Q0yZmK/nzneUwXMrUheKaYibXrFfyxCxSlwz31TeJm/TUUP9bJfnUADSVJAALT+oo8A2t4mqCjGCShSFyNsIcNo2gQyrGr3VuQrEKMYWb4njG0dyfEkYt75Y7kFgV1pflS7uVaIkeMBBhHxpwSZfhzLOKSMrK1iEkPQeqj9QBLiTSbNoGtSqMby9IEAoII8NGs286RYs50xRp+YlcQQJx7ltp0C7kCded+fxCnaVv99Ix8W4wqX0e4sG7VAlFhFlX2/6srHMAAL548vGa0/yoTir8Kf/73Q7wIysGmlWCn4gdDSTYCANPF8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zauodbJKl1DcqiRNRf4YKBKvkDeHl2z+9xct54eBl0=;
 b=a8CdOQwg3usBjSZW+vx+qTpyymFly06Ijht4sPGIqgkB+cRg9Y9rE2OJ1xnja5T+Cn5N6t5W+gYpNrcAYLaMMuZRPPfVHItV4+DMAhHQkdD7VwET5JBR3q/j9lGzWGvXnHdBZmWPaaFOr89d2vOTSmOQQBEt/ylIXFMwunYoMlgln153dLR4Sxo3Ma+XTljxKRgSMcqwjdaWxZshow64nzwg/KS7tMEK/Oz4oIT3wXlGiCHYwNTodOlR9TYMsQ0lEfo/8HEBv3O+AaHblJzQyHQ5xlIRH8UPm+WBcTPJ83KCo2N0PAlSz6zsG0iYXrcmMAB9Aw+CeqBTV/7T6APmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zauodbJKl1DcqiRNRf4YKBKvkDeHl2z+9xct54eBl0=;
 b=mo6Mb1QYeUgF3TIOJtqtSJvGALMMgPFEZwwtKE0u9Ba37/eZwAhC7r4sKsd1DlhHPhjwO13hiX0Rr1zWUFkRXfWQalhqrLExJ5BolO1+1GwL9KQWyTbe9rd0PT57HA7gbOSiAjgK0iJuuDVRyPgEWld9umiIzEmpNiclB/zHoiXckszSKprjbjwxChpjC8SQggzqyHP3ZzYEW3Om+NqJIaulDB+rle1ZyNPAFs+AI3Tp2jD/sHRYcCYIBVs9rMbaaptT+atewbmXOX0mymSH62E1HArkh4NMwoG0aiyBRJ8mKS6W5nKiblHQt9HcDRMldB16v/iwf3HKDG1QNKUQ3w==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AS8PR04MB8102.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Fri, 7 Aug
 2026 02:21:39 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0292.013; Fri, 7 Aug 2026
 02:21:39 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"Wei Fang (OSS)" <wei.fang@oss.nxp.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "liuhangbin@gmail.com"
	<liuhangbin@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
	"jasowangio@gmail.com" <jasowangio@gmail.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "hawk@kernel.org"
	<hawk@kernel.org>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>
Subject: RE: [PATCH net 2/2] net: tap: fix skb->protocol not updated after
 VLAN network header adjustment
Thread-Topic: [PATCH net 2/2] net: tap: fix skb->protocol not updated after
 VLAN network header adjustment
Thread-Index: AQHdJMgipP89sDqcOEu5VK5yASB6z7aPZ/qAgAAGSnCAAVot4IAASRiAgADLp1A=
Date: Fri, 7 Aug 2026 02:21:39 +0000
Message-ID:
 <GV2PR04MB11739828521F49658D691669E88D12@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260805105314.3882595-1-wei.fang@oss.nxp.com>
 <20260805105314.3882595-3-wei.fang@oss.nxp.com>
 <willemdebruijn.kernel.4a69732dc0a4@gmail.com>
 <GV2PR04MB11739F20D97C6507DB388951388D22@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <GV2PR04MB1173961FAF524C3A3FB49204888D22@GV2PR04MB11739.eurprd04.prod.outlook.com>
 <willemdebruijn.kernel.1f5ad76837fbe@gmail.com>
In-Reply-To: <willemdebruijn.kernel.1f5ad76837fbe@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AS8PR04MB8102:EE_
x-ms-office365-filtering-correlation-id: 0e757d57-c7c2-454f-bb67-08def42a9d17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|19092799006|7416014|376014|366016|18002099003|22082099003|38070700021|11063799006|4143699003|56012099006|10067099003|3023799007;
x-microsoft-antispam-message-info:
 goc4+VUOmzMqUbCWfkOYRQbQBRWvFzibb/cjKFiDqvkXeq19Wd8XY3sfvFXkJB85pDTTW4SaXfIFqS7azX43jpAauKOeCBIOXV5HgpdJIeTLEdKhMQ4WgmwFqmrmF+20WBfL10jRKkqeOY6OzfKkx6YL7UmrEVwHK+F2zGPL28rx3i36nir18zYzUltwEZf36X41WTrBcsz/yQ2Gp+fGhXCmBtz4xtoJmXwfgYkQgbhtdsNuargBR/vXq6No4tnAiXqjmTyfi2YmHfJh3FLV8Yw5PyG8I9lLKuDeN2v5qB0psPBRpwzshT9Fao7l2Z+YoExomejBtPvcd8kas2qX37x7WkbbFfOrXuN7/1c/rn6Hz+l9i082IIuXxwJ/L6t9NsOInO+LrfToxhxfw4yfiAnnxsyshD2A7VvUSnDjH+wLn7P0ckSq2KqMrHlGSvR7s2hzd1PA1BhOYhYpd9hp+KYt97PnH1hwrfsCsCh7VWoZgXkw4wL6A7VpEMiFzwVCDZONV1cfenhWSxQRJOjAujY/Rx7NjCIXUpj/VPOQz5X6mVWQlmr0MkTWGP93qzJPEFg/8DoHVVkVHY47AzLiEM1mwHfXavV+qB4zNXkxwVMdmmQP4zaKR3+5eVZGByQUQtXy15Ga42lQMUU4DVulRyKU7fwQR75aZvz+vJqFeODk7ifqtqjpukguFpC3wnlHJ2wbX0nz/HniIzv+diQlXeY2ZQpqDXadtnVBIKFuUwY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(19092799006)(7416014)(376014)(366016)(18002099003)(22082099003)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QUNodDUrWXdPOWIrd1NDN0NPNldsVUZ3M0tyZFBqRFZ4UzY3TjVJbEFlRlcw?=
 =?utf-8?B?Q0pXU0VZa1F6eW1uK3BJM0hSZzUrVGxwbGUvM2RpMW1CWnJra3BvdWFNd2d4?=
 =?utf-8?B?cjk3TUhzUlE4RnJTcVRuT1k2K1RYOXRZTW9MQVNkV0xtT1YwMUgxRzRGdFJz?=
 =?utf-8?B?WHVEc0U5OXN6VGdYZnFieEw1bTZaNTM5WUhQdTZJbUhlWjdzOHhla2VwWWZu?=
 =?utf-8?B?ZnhyYS9ZajY5aE1GOXZlREhTZkI4NkxkM1JtTHZpVXA5a0V0VC9NWEJTMGF0?=
 =?utf-8?B?NDhnZkZMR1hRU0FYL3I0ZWlyTnpISnVVR3BQT1YzWk5DZkMzVzgwRXJOckJI?=
 =?utf-8?B?b3V4ZTdTZ015ZmNtMXl0YmExQXZySnlUOUsxeVpDalBtK2xxTkdHQm9zakZm?=
 =?utf-8?B?RVY1NURHb0NYSW5hVGpESGFLN0ZaN3pieXhzVktYUlVpSytsTVhQelZ3R2oz?=
 =?utf-8?B?dDVhTTFKeHREaCtCMzRyWXc3MXB6ZXVjcVdUcGlBRHYrUTFGYmdLd0NVY0FU?=
 =?utf-8?B?YXlvLzBSK2UzWDJFUStkeXdtSmd0aTRieGZoWitoOHQ5Ynp3ZHZZeHFlYVEx?=
 =?utf-8?B?cFMzTGRheHB4UDNJd2l2MmkydW8zK1Z5MkwrWG9sR202T0pWWHJqZ0M4d0hD?=
 =?utf-8?B?RStFY00yV01tN2hNcGdzNGpacmNVdUx2NDlBMDg4MTVpZmsxenduMWVVT3hU?=
 =?utf-8?B?RHM2R3EvYy9YS3g3RVN5Z1FsK0oyQk1WS1lQV0tFblkxeWt1VDhPOEtuMVhy?=
 =?utf-8?B?bkVpME9odXVXK2c2MHhabHdEdEx3S0VINGo0NlQzS050Q2d5U3FKVzBLdTZY?=
 =?utf-8?B?WE1lUTl3SldaRkVMWW03cnNrdXhyTUFKRjlKTTJJblJuMVYvalNyUDQxeFp0?=
 =?utf-8?B?dHVhSEwwa2EvTlROWS9NV3R0RWF5Z3JxdEZJUHArRlVidWhCbGZ1b0NBc25U?=
 =?utf-8?B?ZFlaVnFtSzgxYXA4UnB1TnpKL0drM1hyVnE3WWxhaE51ZmNjTVZ1SGpPUVRO?=
 =?utf-8?B?cEtXREd3dmtMeVFBeEtTMGlZYm9JaDRhRWNsMFlIMVZWN25PbnMzNG5lZ2k5?=
 =?utf-8?B?Yy9sc2o3ZHFKSnZYTisvZGY4ZXVBOStma1BNWk9jMEdIRFdDdUU3UHMvbWU3?=
 =?utf-8?B?ZWlCTFV0OEd5UmFJWWhzeXpNQWwwVWdMRjdGVVN5alRPWngyTGJwS0Z4UlN1?=
 =?utf-8?B?NDNhS0ViOVBMUWduWjUrVHdNSThkREc0enZRcFJHVjl6MlVzK2hScEhyK3Z2?=
 =?utf-8?B?VWpFbEJrbjRRUnRKaDBqdktxQXNiNGJweXpCdDUwNXBwUytiTTFUbGNEMEkr?=
 =?utf-8?B?dXZGb0lhQWE4emp2RUcrQXZwODZvL0RSOUR6T0lJOTI3N0kxL2lzSXVHUmg3?=
 =?utf-8?B?SE5xUytKMWtobEc0OXZ6VVRFNXhSdXV2UTJNQnh5WDNUa29HRW1xOHp1azRE?=
 =?utf-8?B?L1JjUjRzbFExS1pWUDZDSDhtZytwQ2F2NTg2ZFNtVytSNjJWS2dyTS9jSzFp?=
 =?utf-8?B?cmpUQmZJaDNYTklkVlg1UXBqQm43UkZGWnhZVmpaWFJrYnFzMFdXb3p0WGpq?=
 =?utf-8?B?SndIYVRCV0NUR2NGOG83OVgwVUZhUFc0NzNjMldJRkJ0cUpmU3JUZHkzQWFP?=
 =?utf-8?B?d3MrZk1LWHJlcFhEbWlNR1hRM2l4NUF6Zno3ck5jMU9EYXFyNkt0QkVGckVo?=
 =?utf-8?B?d1dkczNTaXY5UFVnck9kcFU4T1BLL0U4SUYzMWltTGdSRnVoVHo0WTh1UEE1?=
 =?utf-8?B?N1RmdmJORXhwempnMjNqWmJmMG43NGdGd1hXL2R4QTg1dEltMWN1ODhzTW5S?=
 =?utf-8?B?SWN5UHFZaE16eUdDdlM0ODVvaVhSWkxkd2REVHdnK1lXakZianh5SHE0Mk9C?=
 =?utf-8?B?UFlIQWk5S1RDYjdYMTA3L0tGL2hyQ2ozd2t5R2pIVHZtS0hiRnd5bi9TWGZU?=
 =?utf-8?B?cWVqZ211QTBpYmYyUGw4MVNqL21GWTdtaHRnMXJrRTlybGF0YkN3WXlzSExY?=
 =?utf-8?B?OVZxVmtnUG1lQVUxU2Y0NDlWakg0L0NvTkZ6Ymh5ckFTdklrenFYeUM0TzBj?=
 =?utf-8?B?d3R2aS8yQUdPR0RCb3BvTElKMjBEd3Z1UTlYY1RXeXE1SXVlUXhoQWdBa1Nr?=
 =?utf-8?B?dExoREgvWnhhcTJaRENLcmJ1N3NuMnBFK3NLSTlvbVo3dTluSE85UlBGaHll?=
 =?utf-8?B?YXRlams3TXpLN21OZ0xhTW5Wb2VZQkRzWjl6cUViaUdTNk5jeTYrcGVlVmxy?=
 =?utf-8?B?V1FISGgyY2wwT2lvSndSd09CaHhjVittcDdQTVJ5ZVVUUSt0T2xEcmVSMW12?=
 =?utf-8?Q?n+01I3qwiAYrdMasO/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e757d57-c7c2-454f-bb67-08def42a9d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2026 02:21:39.4213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MrHqvfwfvfS1sblxQwtrLpwoJo5aSkricfqSjJy6Q0I586vQqFZ58IoyFZ4Pry/RzAanXt/WVMcwfJ/nthcUew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8102

PiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3RhcC5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVy
cy9uZXQvdGFwLmMNCj4gPiA+ID4gPiBAQCAtMTA4MSw5ICsxMDgxLDE1IEBAIHN0YXRpYyBpbnQg
dGFwX2dldF91c2VyX3hkcChzdHJ1Y3QNCj4gdGFwX3F1ZXVlDQo+ID4gPiAqcSwNCj4gPiA+ID4g
c3RydWN0IHhkcF9idWZmICp4ZHApDQo+ID4gPiA+ID4gIAl9DQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiAgCS8qIE1vdmUgbmV0d29yayBoZWFkZXIgdG8gdGhlIHJpZ2h0IHBvc2l0aW9uIGZvciBWTEFO
IHRhZ2dlZA0KPiA+ID4gcGFja2V0cyAqLw0KPiA+ID4gPiA+IC0JaWYgKGV0aF90eXBlX3ZsYW4o
c2tiLT5wcm90b2NvbCkgJiYNCj4gPiA+ID4gPiAtCSAgICB2bGFuX2dldF9wcm90b2NvbF9hbmRf
ZGVwdGgoc2tiLCBza2ItPnByb3RvY29sLCAmZGVwdGgpICE9IDApDQo+ID4gPiA+ID4gLQkJc2ti
X3NldF9uZXR3b3JrX2hlYWRlcihza2IsIGRlcHRoKTsNCj4gPiA+ID4gPiArCWlmIChldGhfdHlw
ZV92bGFuKHNrYi0+cHJvdG9jb2wpKSB7DQo+ID4gPiA+ID4gKwkJX19iZTE2IHByb3RvID0gdmxh
bl9nZXRfcHJvdG9jb2xfYW5kX2RlcHRoKHNrYiwNCj4gPiA+IHNrYi0+cHJvdG9jb2wsDQo+ID4g
PiA+ID4gKwkJCQkJCQkgICAmZGVwdGgpOw0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArCQlpZiAo
cHJvdG8gIT0gMCkgew0KPiA+ID4gPiA+ICsJCQlza2Jfc2V0X25ldHdvcmtfaGVhZGVyKHNrYiwg
ZGVwdGgpOw0KPiA+ID4gPiA+ICsJCQlza2ItPnByb3RvY29sID0gcHJvdG87DQo+ID4gPiA+ID4g
KwkJfQ0KPiA+ID4gPiA+ICsJfQ0KPiA+ID4gPg0KPiA+ID4gPiBEb2VzIHRoZSBzYW1lIGFwcGx5
IHRvIHRoZSBzYW1lIGNhbGwgaW4gdGFwX2dldF91c2VyPw0KPiA+ID4NCj4gPiA+IFRoZSBzaXR1
YXRpb24gb2YgdGFwX2dldF91c2VyKCkgaXMgZGlmZmVyZW50LCBza2JfcHJvYmVfdHJhbnNwb3J0
X2hlYWRlcigpDQo+ID4gPiBpcyBjYWxsZWQgYmVmb3JlIHRoZSBWTEFOIGFkanVzdG1lbnQgYmxv
Y2suIFNvIEkgdGhpbmsgdHJhbnNwb3J0X2hlYWRlcg0KPiA+ID4gc2hvdWxkIGJlIGNvcnJlY3Qu
IFRoZSBvbmx5IGNvbmNlcm4gaXMgd2hldGhlciBza2ItPnByb3RvY29sIG5lZWRzIHRvIGJlDQo+
ID4gPiB1cGRhdGVkIGFmdGVyIGNhbGxpbmcgc2tiX3NldF9uZXR3b3JrX2hlYWRlcigpLg0KPiA+
ID4NCj4gPiA+IEknbSBub3Qgc3VyZSBhcyBJIGFtIG5vdCBmYWlybHkgZmFtaWxpYXIgd2l0aCB0
aGUgdGFwIGRyaXZlci4gSSBhZGRlZCB0aGlzIHBhdGNoDQo+ID4gPiBiZWNhdXNlIFNhc2hpa28g
cmVwb3J0ZWQgdGhhdCB0aGUgdGFwIGRyaXZlciBoYXMgdGhlIHNhbWUgaXNzdWUgYXMNCj4gYWZf
cGFja2V0Lg0KPiA+ID4NCj4gPiA+ID4NCj4gPiA+ID4gQW5kIGluIGdlbmVyYWwgdG8gb3RoZXIg
Y2FsbGVycyBvZiB2bGFuX2dldF9wcm90b2NvbF9hbmRfZGVwdGgsDQo+ID4gPiA+IGluY2x1ZGlu
ZyB0aHJvdWdoIHdyYXBwZXIgc2tiX25ldHdvcmtfcHJvdG9jb2w/DQo+ID4gPg0KPiA+ID4gSSBk
b24ndCB0aGluayB0aGlzIGlzc3VlIGV4aXN0cyBlbHNld2hlcmUuIFRoZSBpc3N1ZSBhcmlzZXMg
YmVjYXVzZQ0KPiA+ID4gc2tiX3Byb2JlX3RyYW5zcG9ydF9oZWFkZXIoKSBpcyBjYWxsZWQgYWZ0
ZXIgc2tiX3NldF9uZXR3b3JrX2hlYWRlcigpLA0KPiBhbmQNCj4gPiA+IGF0IHRoaXMgcG9pbnQs
IHNrYi0+cHJvdG9jb2wgYW5kIG5ldHdvcmtfaGVhZGVyIGFyZSBub3Qgc3luY2hyb25pemVkICgg
SW4NCj4gPiA+IF9fc2tiX2Zsb3dfZGlzc2VjdCgpLCBuaG9mZiA9IHNrYl9uZXR3b3JrX29mZnNl
dChza2IpIGJ1dCBwcm90byBpcw0KPiA+ID4gRVRIX1BfODAyMVEgb3IgRVRIX1BfODAyMUFEKSks
IGNhdXNpbmcgc2tiX3Byb2JlX3RyYW5zcG9ydF9oZWFkZXIoKQ0KPiB0bw0KPiA+ID4gZmFpbCB0
byBzZXQgdHJhbnNwb3J0X2hlYWRlciBjb3JyZWN0bHkuDQo+ID4gPg0KPiA+ID4gUGVyaGFwcyB0
aGUgY29ycmVjdCBhcHByb2FjaCB3b3VsZCBiZSB0byByZXN0b3JlIHRoZSBvcmlnaW5hbA0KPiBg
c2tiLT5wcm90b2NvbGANCj4gPiA+IHZhbHVlIGFmdGVyIGBza2JfcHJvYmVfdHJhbnNwb3J0X2hl
YWRlcigpYCwgbWFpbnRhaW5pbmcgY29uc2lzdGVuY3kgd2l0aA0KPiB0aGUNCj4gPiA+IHByZXZp
b3VzIGJlaGF2aW9yOyBvdGhlcndpc2UsIGl0IG1pZ2h0IGludHJvZHVjZSBuZXcgaXNzdWVzLg0K
PiA+DQo+ID4gRm9yIEFGX1BBQ0tFVCwgaXQgaGFzIGJlZW4gY29uZmlybWVkIHRoYXQgc2tiLT5w
cm90b2NvbCBkb2VzIG5vdCBuZWVkIHRvIGJlDQo+ID4gcmVzdG9yZWQgdG8gaXRzIGluaXRpYWwg
dmFsdWU7IG90aGVyd2lzZSwgdGhlIGVncmVzcyB0YyBmbG93ZXIgZm9yIHByb3RvY29sIGlwIHdp
bGwNCj4gPiBub3QgbWF0Y2ggdGhlIHBhY2tldC4gQSBrbm93biBpc3N1ZSBpcyB0aGF0IHRoZSBw
YWNrZXRzIGNhbm5vdCBtYXRjaCB0aGUNCj4gZWdyZXNzDQo+ID4gVEMgZmxvd2VyIHJ1bGVzIGZv
ciBwcm90b2NvbCA4MDIuMVEsIGJ1dCB0aGlzIGlzc3VlIGV4aXN0cyBiZWZvcmUgdGhpcyBzZXJp
ZXMuIFRoaXMNCj4gPiBpcyBsaWtlbHkgYSBsaW1pdGF0aW9uIG9mIHVzaW5nIEFGX1BBQ0tFVCB0
byBzZW5kIHBhY2tldHMuDQo+IA0KPiBBY3R1YWxseSB0aGlzIHVwZGF0ZSBvZiBuZXR3b3JrIGhl
YWRlciB0byBzdGFydCBvZiB0aGUgSVAgaGVhZGVyIG1heQ0KPiBoYXZlIGJlZW4gYSBtaXN0YWtl
LiBJZiB1c2Vyc3BhY2UgaW5zZXJ0cyBhIFZMQU4gcGFja2V0LCB0aGF0IGlzIHdoYXQNCj4gc2hv
dWxkIGVudGVyIHRoZSBzdGFjay4NCj4gDQo+IEJ1dCBmb3IgdGhpcyBzcGVjaWZpYyBpc3N1ZTog
d291bGQgaXQgbWFrZSBzZW5zZSB0byBqdXN0IG1vdmUNCj4gc2tiX3Byb2JlX3RyYW5zcG9ydF9o
ZWFkZXIgYmVmb3JlIHRoYXQgYWRqdXN0bWVudD8NCg0KSSB0aGluayBpdCBpcyBmZWFzaWJsZS4g
VGhlIHRyYW5zcG9ydF9oZWFkZXIgd2lsbCBiZSBzZXQgY29ycmVjdGx5LCBhbmQgb3RoZXINCmJl
aGF2aW9ycyB3aWxsIHJlbWFpbiBjb25zaXN0ZW50IHdpdGggYmVmb3JlLCB3aXRob3V0IGludHJv
ZHVjaW5nIGFuDQpuZXcgaXNzdWVzLg0KDQo=
