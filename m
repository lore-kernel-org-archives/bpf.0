Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010061.outbound.protection.outlook.com [52.101.69.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EBE33AC0ED;
	Thu,  6 Aug 2026 02:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982244; cv=fail; b=s9dH9bIcK1lR0iDGn/v6mlyaS0GHMNuwsWflSYyUav0YSdVibe2kMl1E91aKzJwKcAaw19w/NAvXd78afrhA0hLVj6Gy9I8SKguXwsAY+fJXDSOarHP2H42lMk0XtjAb818q6Fs8RzL2D0lDGAuYvymCRb6Bl50UUfz4WcCDPQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982244; c=relaxed/simple;
	bh=GI8hYNh68N1nN4Qi8ht/DGWFBh5NrfeYS7dO7rC4eAc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EZODGTYbfVZnI+jIoH+O6RKLmjVWowAM7RdNhtedTMaceTu7WDaReaHBOqFC0jCnXYrJIUsG5UQphkfH47nfgyceh7yUCo9YmvwJybk886P3BZBQE1U70EL+xRDLzKfy+YTuMnZq67C45Ep/e4ipGReflrFaYIGXRSFUfu1LFzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C33CTDlh; arc=fail smtp.client-ip=52.101.69.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C33CTDlh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hK+TPnbWoxk4C9N9392lqxw7wEszvH8dLDhtjrUjdRGzvSVdFsVCbmRshRKTpmGW1DGhn3+BlQoVlw5VORaYG3eWWmCm3mbu9itp5ryTuM+DKTJdi4WB3p9CGXFSEyThS1OtYgo0lnpZMfXqLDKbrAyAhUcGK9hfZJqPCl7L0J1v+moHsJtL6aPCclIc71guSBouHQVqGx+FATtLeiYghx0Lyq9XbgvUlV0kwzVV/OIbmSBd5fxllL41mUcfIq4dWpSmMwBQfn/MfASWO59uber1UMtAzLouP2LLLdLJ0YutGVBrpChtNz90EHzDHYGE/+jHjALNRVSlC2SI88ZkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI8hYNh68N1nN4Qi8ht/DGWFBh5NrfeYS7dO7rC4eAc=;
 b=gBvQ+OVYX8FLqB8icxfkJMUzSx0W8/vLyuxvgr6CUTEcAkUv975Evwux+zgfqzPDBnzbPD0/NveTYVlN7axl0cktrE4E296mks54UADSMQ4KeD+h0wm/wXdwc5FVyJkoHrpGjOS4irt0gH894AGXGl/9PRxO46sYYu4FDcVf+ri9hpZFwqqQzfvuMS6ViRHdHJoSo+VlCCNYPXe/ojPE1ui54mZgM6eLPQs0xGswZClMjXpNSq3dzs8meKcozFHaOUw7JwgS7qrEl9V3HxMvIPnXr6BM87yVe36Gd+w5S+xfLGzw2zDUvLcuhmemCiSarjyynXAq4RcV1okBgGm+bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI8hYNh68N1nN4Qi8ht/DGWFBh5NrfeYS7dO7rC4eAc=;
 b=C33CTDlhs+0vNjhz1NQIQ30PRqFeAj+tWJsnWc5kiggAyrtIKro/Gz3uZIpLZ1gDgz8fXJThfe4qJPDMuUZ84za14L1Y6Ji0rdzOKA+Pm9LqZ55RpDks2ujXy5jEGW/2udfuTi9R2lxcXHP6w0YvgB4ATa5A9C5nh+udB8CVOEkDiORtX80zuU4xzFUahib0y8g9QAzSFouFNnwnh2AE7B6to57zH4gC3fCU0i89qse5WqwFXWHaN/xY0ng8yMm637+A/D1JfX82qmrCrOsHaRx9FK8Dl7hyrIjOkQO1cMyDjs0yKNLpPb35vlhex5qkq6KKJ347j0FfT/sIOmO8Qw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PAXPR04MB9447.eurprd04.prod.outlook.com
 (2603:10a6:102:2b2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 02:10:36 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 02:10:36 +0000
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
Thread-Index: AQHdJMgipP89sDqcOEu5VK5yASB6z7aPZ/qAgAAGSnA=
Date: Thu, 6 Aug 2026 02:10:36 +0000
Message-ID:
 <GV2PR04MB11739F20D97C6507DB388951388D22@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260805105314.3882595-1-wei.fang@oss.nxp.com>
 <20260805105314.3882595-3-wei.fang@oss.nxp.com>
 <willemdebruijn.kernel.4a69732dc0a4@gmail.com>
In-Reply-To: <willemdebruijn.kernel.4a69732dc0a4@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PAXPR04MB9447:EE_
x-ms-office365-filtering-correlation-id: dba27836-54e0-4219-7e08-08def35fe772
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|7416014|376014|23010399003|22082099003|18002099003|56012099006|11063799006|4143699003|3023799007|38070700021|10067099003;
x-microsoft-antispam-message-info:
 VYhJeX8irfrN/F4vgyO6XBShoG3ELALSmdwQV3D+TvjTA/oMZvB4YK/c87xw2Mh73DFppbFzhpP7B0mlU08sLGGQZym6+YDletXEDKOnWIx3d64LnAiB5jRcmr/b2NVzPHjjXe670rRiDCLp+1UV2lLQngyQLLtbRL43H+oc6YQnu1+opvXiNY3/pSTQ46aKR+HYXJYx40x0GUgdM8nrjImJVmkviL5dOtYyQ/wUcSiThbBd03wbtATOFzQfit2jHuMMw5+VPbIjIIHvTlLkLqRegQTV9G+r7isnRKKdKs0M2OS1o8BEY+fUUBnLZTChoK3g1IAalovFJWiYY0OnjeZDztpbaNo8WJD26Kcdv34FcMjUA353r54J4Ues81bMBuP5cY+4w7JNSS9srJvm5R1Cm9hvBNVhV3EfmqqTWEOEFsNEpegc2ZCTxr2tbUpZvLvr3n5SO9ZYXstP0ZJqEcpZn2nIrMkt4DWc6YFkevKINiKGLNlmEMtOm+vhJGVmO8ISuAOzdKhyfVLsz79zzIZz3Wik3Xg8LFCb8XXmobSeRiJqkNifCCKJoBgakHUwMJG4B5uTdkFzYRdVJth8GAYbWxbzp5e8FKVZl5O+mxRxrO7CrrcxDgBo3k4Ttp7qTRBc3mt/3KlZaD5vKxpcqVwBa0bpBC2WE5rXWZ78qCMXj0cEj1OX/cGolaiSdgc2NghXsQvigrYxoWMVv9lnlx29+pdVCPmpHw96KYhE+qQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(7416014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(3023799007)(38070700021)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QmJTQ0pwR3JyTmlJTTBlNHZ6YUhjU3dXaGg1czAydXlLSkVtQVp1TGJ1bnV4?=
 =?utf-8?B?ZDZseUsyRWsvRnRXamI2Z2laV2R0S255TVByMjJSdDlJTDVPamI5MU5nL29R?=
 =?utf-8?B?ekdzdWlEMnhoTzZUM3QrRFNFQjQ1U0lQMktxNWVJRzh6U0h0RW5ZODBteFNu?=
 =?utf-8?B?aEx1NHpkV3QvVjNKR2NjaXlkK1QzSS9TUnhBUFpvZ2lqS3p1anVLUHB3UDBL?=
 =?utf-8?B?SjR4SWszNXZzUmd4WERvMkN4V3hZUm55S25YQkZuaVozMVVSVkdzM3dXSitK?=
 =?utf-8?B?cGhBZTZuRmRlODU2RW9rdXdjNVJUanIzQjkzaXVNMkdiS0E3enRraGY3aHNt?=
 =?utf-8?B?WG9OeWFweXlEV3dnWUFUK2JPRFF4Nkpjc0ZlV2NzV0VFbDFXK3R4eXlybWZs?=
 =?utf-8?B?WXZnK1VqZ0dGTURHQnowUWtlVjI1U05nRHVxTEo1cStuZy9HbWtvZUgyS29B?=
 =?utf-8?B?MGc0dG4xWVpaVnRtR1dudXIwOXpPeE4vL3NZcTBPZ1p4bDdqblkxSnAwTGlD?=
 =?utf-8?B?K2JSbW85Wm9hMVl0SXlwVGR6L1ZHWHY2K0p6MWZWdEhxYytqUnhwQ1VuaTBT?=
 =?utf-8?B?OWdPQ2VjRUhrb2E0ejIyVzNveU5pVDhBMFgwYmVmbXFSZE1tMEkrS3NwTGlt?=
 =?utf-8?B?Sk43OFNjMjNzNGJiL283US9KL2cvazNqakUycjBla1lsbmRHc1RMRFVLU3Q2?=
 =?utf-8?B?QzNadkg4TnZ0RHVzaFV3OURNeVVkQ1dmSzRMQzZoLy91eVZZUUtqOERvQVlV?=
 =?utf-8?B?RnhCeGo1T1dIbzlJa25nREVkMWMwRVpvMys3Vmw3d3E1eStmZ1dpWFdQcTVO?=
 =?utf-8?B?bWp3SEpjSXBlOVVvVXZUNVlwejFiaVU1VnRFckdJNTZkQ3A2NzdMSXc5NzlT?=
 =?utf-8?B?bXU0Q2llTkprQ2dpdklDY2t6RVVZY1hxeFZFams4cXlFcGZOYTN2VDFscGo2?=
 =?utf-8?B?dldRelFvK09kZU9zdGI0ZVRod2JwKzMveWFwZ3BqcWdEWEczeTBaUFNWRldT?=
 =?utf-8?B?TmlmZG9Yb2RFL3FZMDUvU3Y1SmdSODF3NXU2Q1oxWnIxOGM5ZEdJNWZ3WnZM?=
 =?utf-8?B?ZzJ0SHBXbkpkVHJiSnhuVFl5L1BIcWx5dUFhMExkM080SzhCQmlxRGVrNG0y?=
 =?utf-8?B?aVI0aTVJOHQvYk9IUEZBWkFGdFVrdmZMdUdQOVpUdmNKR2o3a3BtQjdGcVZC?=
 =?utf-8?B?ZWxoU3hCZllQSXFBaVlNSUJRcC9obUJDSittdHl5ZkhNeTZna1hIREFJbDJV?=
 =?utf-8?B?VngrQXF1NXAxb3VFT0RwOS9mdWkxZXNoSjRwa1hSbjZ1R1drZThFeFplbG9q?=
 =?utf-8?B?Rnk5L3FjZ2hIN09VdW9lVnZJK1NUQWU4dEFHNFBSVndXZFVqd201Z1ltclNq?=
 =?utf-8?B?OWgrYjROOVRnNTl6bUN4WHBOaDd5RkJDTHRhaFJFWDY2eUhoM1VaSTduMDFz?=
 =?utf-8?B?RjZwV3BJOFR0NWhkVkQ1eC95R2VqRzNzZExrMExoNVdOYW9sYU84NStNdmEx?=
 =?utf-8?B?STVBNlRFTDRrRzllR1dnLy9ORkc2QldpOTlLVkozWk92OWhnWFhvS3Uzcy84?=
 =?utf-8?B?L3Q0L0hjdWVrMlNuemxpdGk0aVRnNTdNeldWNE5WbUp5UFRPbzdBZjJLTnhK?=
 =?utf-8?B?cjJYMGlHLzk5eVVaejRMQzIvdWM1TGorbTIzQlhJS3g4QVhlbnh4U0luaDJv?=
 =?utf-8?B?ZlFGV0pncEFKMlp3RTBReTVQTmtGNHJUQ1pqT2tNZ1QwaWRhdEZmNmpWdzVW?=
 =?utf-8?B?dENxeXA5ZG9udmJ5NTFJU0xBazRPMEIyWmZXWU44TXM2OW9EME9YY3luamZh?=
 =?utf-8?B?alFqQXYxLzVBb2JnQnUvSnlaK1RFZit5WDZJK2Z1Vzl5bStMdjBXSkFSL0Vk?=
 =?utf-8?B?dlplN1JMWGZobkZwZzROYXRFZTRmTktaQjdIQ00waER2TXZjbG5oVVVnMWtZ?=
 =?utf-8?B?ODlmOHVSamQrNW1QcmtleGQ5T0Nab3ZKMXU4SnVlcVJCcDI1SGdqL2trLzVx?=
 =?utf-8?B?dm5XM1RTS3VlYUVsQzZZbURCcGtyVjNjS2p3M1ZmYzUzUnV5QkFZSzZGL3hZ?=
 =?utf-8?B?Rk5sSUYvQURJWHZtYWQ1bXFNZVh5L0VKTTlyeGhMb1dneFJQR2JTaDAzYVgz?=
 =?utf-8?B?OEFBZVRCQlhkOTE0UmRodHNxbWVZOE5vWG9GcVkvTm9PMnRoMXNXQ2VVbWxq?=
 =?utf-8?B?UHRleHR5RmppRVNmNzF5MTdDb1dmUmlKZVA2WFNMVi9OQ1RkWVFIak9MTkRo?=
 =?utf-8?B?bm5XS3pmSDhIbXdxbUV4NlhtSElZUVpTSnRuM013ZHJaTFdJWTZFczg0WGxz?=
 =?utf-8?Q?aHpQwkif+DmIZnbYsq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dba27836-54e0-4219-7e08-08def35fe772
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 02:10:36.3256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZY+VTgTNE74ky/ZloH1YLux8lDyB04n9EIYw18n64MmAAvW4jaNS1zrU0hflqj3djtAWOh8F+zgl1O0vwu3Q1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9447

PiA+IEluIHRhcF9nZXRfdXNlcl94ZHAoKSwgd2hlbiBwcm9jZXNzaW5nIGEgVkxBTi10YWdnZWQg
ZnJhbWUsDQo+ID4gc2tiX3NldF9uZXR3b3JrX2hlYWRlcigpIGlzIGNhbGxlZCB3aXRoIHRoZSBk
ZXB0aCByZXR1cm5lZCBieQ0KPiA+IHZsYW5fZ2V0X3Byb3RvY29sX2FuZF9kZXB0aCgpIHRvIGFk
dmFuY2UgbmV0d29ya19oZWFkZXIgcGFzdCB0aGUgVkxBTg0KPiA+IHRhZyB0byB0aGUgaW5uZXIg
cHJvdG9jb2wgaGVhZGVyLiBIb3dldmVyLCBza2ItPnByb3RvY29sIHdhcyBub3QgdXBkYXRlZA0K
PiA+IHRvIHJlZmxlY3QgdGhlIGlubmVyIEV0aGVyVHlwZSwgbGVhdmluZyBpdCBwb2ludGluZyB0
byB0aGUgb3V0ZXIgVkxBTg0KPiA+IEV0aGVyVHlwZSAoZS5nLiBFVEhfUF84MDIxUSkuDQo+ID4N
Cj4gPiBUaGlzIG1pc21hdGNoIGhhcyB0d28gY29uc2VxdWVuY2VzLiBGaXJzdCwgc2tiX3Byb2Jl
X3RyYW5zcG9ydF9oZWFkZXIoKQ0KPiA+IGlzIGNhbGxlZCBhZnRlciB0aGUgVkxBTiBhZGp1c3Rt
ZW50IHdpdGggcHJvdG89RVRIX1BfODAyMVEgYnV0IG5ob2ZmDQo+ID4gYWxyZWFkeSBwb2ludGlu
ZyBwYXN0IHRoZSBWTEFOIHRhZyB0byB0aGUgaW5uZXIgaGVhZGVyLiBUaGUgZmxvdw0KPiA+IGRp
c3NlY3RvciBpbnRlcnByZXRzIHRoZSBpbm5lciBoZWFkZXIgYnl0ZXMgYXMgYSBWTEFOIGhlYWRl
ciwgZmFpbHMgdG8NCj4gPiBmaW5kIGEgcmVjb2duaXphYmxlIGVuY2Fwc3VsYXRlZCBwcm90b2Nv
bCwgYW5kIHJldHVybnMgZmFsc2UuDQo+ID4gQ29uc2VxdWVudGx5LCB0cmFuc3BvcnRfaGVhZGVy
IGlzIG5ldmVyIHNldCBhbmQgcmVtYWlucyBhdCBpdHMNCj4gPiB1bmluaXRpYWxpemVkIHNlbnRp
bmVsIHZhbHVlICh+MFUpLCBjYXVzaW5nIGFueSBzdWJzZXF1ZW50DQo+ID4gc2tiX3RyYW5zcG9y
dF9oZWFkZXIoKSBvciB1ZHBfaGRyKCkgY2FsbCB0byBkZXJlZmVyZW5jZSBhIHBvaW50ZXINCj4g
PiA2NTUzNSBieXRlcyBwYXN0IHNrYi0+aGVhZCwgcG90ZW50aWFsbHkgY29ycnVwdGluZyBhcmJp
dHJhcnkga2VybmVsDQo+ID4gbWVtb3J5LiBTZWNvbmQsIFRDIGVncmVzcyBhbmQgZUJQRiBwcm9n
cmFtcyB0aGF0IGluc3BlY3Qgc2tiLT5wcm90b2NvbA0KPiA+IGRpcmVjdGx5IChlLmcuIGJwZl9z
a2JfbmV0X2Jhc2VfbGVuKCksIGJwZl9za2JfbmV0X2dyb3coKSwNCj4gPiBfX2JwZl9yZWRpcmVj
dF9uZWlnaCgpKSB3aWxsIHNlZSBFVEhfUF84MDIxUSBpbnN0ZWFkIG9mIHRoZSBpbm5lcg0KPiA+
IHByb3RvY29sIGFuZCBiZWhhdmUgaW5jb3JyZWN0bHkuDQo+ID4NCj4gPiBTYXZlIHRoZSByZXR1
cm4gdmFsdWUgb2Ygdmxhbl9nZXRfcHJvdG9jb2xfYW5kX2RlcHRoKCksIHdoaWNoIGFscmVhZHkN
Cj4gPiByZXNvbHZlcyB0aGUgaW5uZXIgRXRoZXJUeXBlLCBhbmQgYXNzaWduIGl0IHRvIHNrYi0+
cHJvdG9jb2wgYWZ0ZXINCj4gPiBza2Jfc2V0X25ldHdvcmtfaGVhZGVyKCkuIFRoaXMga2VlcHMg
c2tiLT5wcm90b2NvbCBhbmQgbmV0d29ya19oZWFkZXINCj4gPiBjb25zaXN0ZW50IGZvciBhbGwg
c3Vic2VxdWVudCBwcm9jZXNzaW5nLg0KPiA+DQo+ID4gRml4ZXM6IDhjNzZlNzdmOTA2OSAoInRh
cDogY2FsbCBza2JfcHJvYmVfdHJhbnNwb3J0X2hlYWRlciBhZnRlciBzZXR0aW5nDQo+IHNrYi0+
ZGV2IikNCj4gPiBBc3Npc3RlZC1ieTogV0NoYXQ6Y2xhdWRlLW9wdXMtNC04DQo+ID4gU2lnbmVk
LW9mZi1ieTogV2VpIEZhbmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvbmV0L3RhcC5jIHwgMTIgKysrKysrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5IGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvdGFwLmMgYi9kcml2ZXJzL25ldC90YXAuYw0KPiA+IGluZGV4IGZhZTExNTkxNWM4ZS4u
YWZjYzQ5MTliZDA0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3RhcC5jDQo+ID4gKysr
IGIvZHJpdmVycy9uZXQvdGFwLmMNCj4gPiBAQCAtMTA4MSw5ICsxMDgxLDE1IEBAIHN0YXRpYyBp
bnQgdGFwX2dldF91c2VyX3hkcChzdHJ1Y3QgdGFwX3F1ZXVlICpxLA0KPiBzdHJ1Y3QgeGRwX2J1
ZmYgKnhkcCkNCj4gPiAgCX0NCj4gPg0KPiA+ICAJLyogTW92ZSBuZXR3b3JrIGhlYWRlciB0byB0
aGUgcmlnaHQgcG9zaXRpb24gZm9yIFZMQU4gdGFnZ2VkIHBhY2tldHMgKi8NCj4gPiAtCWlmIChl
dGhfdHlwZV92bGFuKHNrYi0+cHJvdG9jb2wpICYmDQo+ID4gLQkgICAgdmxhbl9nZXRfcHJvdG9j
b2xfYW5kX2RlcHRoKHNrYiwgc2tiLT5wcm90b2NvbCwgJmRlcHRoKSAhPSAwKQ0KPiA+IC0JCXNr
Yl9zZXRfbmV0d29ya19oZWFkZXIoc2tiLCBkZXB0aCk7DQo+ID4gKwlpZiAoZXRoX3R5cGVfdmxh
bihza2ItPnByb3RvY29sKSkgew0KPiA+ICsJCV9fYmUxNiBwcm90byA9IHZsYW5fZ2V0X3Byb3Rv
Y29sX2FuZF9kZXB0aChza2IsIHNrYi0+cHJvdG9jb2wsDQo+ID4gKwkJCQkJCQkgICAmZGVwdGgp
Ow0KPiA+ICsNCj4gPiArCQlpZiAocHJvdG8gIT0gMCkgew0KPiA+ICsJCQlza2Jfc2V0X25ldHdv
cmtfaGVhZGVyKHNrYiwgZGVwdGgpOw0KPiA+ICsJCQlza2ItPnByb3RvY29sID0gcHJvdG87DQo+
ID4gKwkJfQ0KPiA+ICsJfQ0KPiANCj4gRG9lcyB0aGUgc2FtZSBhcHBseSB0byB0aGUgc2FtZSBj
YWxsIGluIHRhcF9nZXRfdXNlcj8NCg0KVGhlIHNpdHVhdGlvbiBvZiB0YXBfZ2V0X3VzZXIoKSBp
cyBkaWZmZXJlbnQsIHNrYl9wcm9iZV90cmFuc3BvcnRfaGVhZGVyKCkNCmlzIGNhbGxlZCBiZWZv
cmUgdGhlIFZMQU4gYWRqdXN0bWVudCBibG9jay4gU28gSSB0aGluayB0cmFuc3BvcnRfaGVhZGVy
DQpzaG91bGQgYmUgY29ycmVjdC4gVGhlIG9ubHkgY29uY2VybiBpcyB3aGV0aGVyIHNrYi0+cHJv
dG9jb2wgbmVlZHMgdG8gYmUNCnVwZGF0ZWQgYWZ0ZXIgY2FsbGluZyBza2Jfc2V0X25ldHdvcmtf
aGVhZGVyKCkuDQoNCkknbSBub3Qgc3VyZSBhcyBJIGFtIG5vdCBmYWlybHkgZmFtaWxpYXIgd2l0
aCB0aGUgdGFwIGRyaXZlci4gSSBhZGRlZCB0aGlzIHBhdGNoDQpiZWNhdXNlIFNhc2hpa28gcmVw
b3J0ZWQgdGhhdCB0aGUgdGFwIGRyaXZlciBoYXMgdGhlIHNhbWUgaXNzdWUgYXMgYWZfcGFja2V0
Lg0KDQo+IA0KPiBBbmQgaW4gZ2VuZXJhbCB0byBvdGhlciBjYWxsZXJzIG9mIHZsYW5fZ2V0X3By
b3RvY29sX2FuZF9kZXB0aCwNCj4gaW5jbHVkaW5nIHRocm91Z2ggd3JhcHBlciBza2JfbmV0d29y
a19wcm90b2NvbD8NCg0KSSBkb24ndCB0aGluayB0aGlzIGlzc3VlIGV4aXN0cyBlbHNld2hlcmUu
IFRoZSBpc3N1ZSBhcmlzZXMgYmVjYXVzZQ0Kc2tiX3Byb2JlX3RyYW5zcG9ydF9oZWFkZXIoKSBp
cyBjYWxsZWQgYWZ0ZXIgc2tiX3NldF9uZXR3b3JrX2hlYWRlcigpLCBhbmQNCmF0IHRoaXMgcG9p
bnQsIHNrYi0+cHJvdG9jb2wgYW5kIG5ldHdvcmtfaGVhZGVyIGFyZSBub3Qgc3luY2hyb25pemVk
ICggSW4NCl9fc2tiX2Zsb3dfZGlzc2VjdCgpLCBuaG9mZiA9IHNrYl9uZXR3b3JrX29mZnNldChz
a2IpIGJ1dCBwcm90byBpcw0KRVRIX1BfODAyMVEgb3IgRVRIX1BfODAyMUFEKSksIGNhdXNpbmcg
c2tiX3Byb2JlX3RyYW5zcG9ydF9oZWFkZXIoKSB0bw0KZmFpbCB0byBzZXQgdHJhbnNwb3J0X2hl
YWRlciBjb3JyZWN0bHkuDQoNClBlcmhhcHMgdGhlIGNvcnJlY3QgYXBwcm9hY2ggd291bGQgYmUg
dG8gcmVzdG9yZSB0aGUgb3JpZ2luYWwgYHNrYi0+cHJvdG9jb2xgDQp2YWx1ZSBhZnRlciBgc2ti
X3Byb2JlX3RyYW5zcG9ydF9oZWFkZXIoKWAsIG1haW50YWluaW5nIGNvbnNpc3RlbmN5IHdpdGgg
dGhlDQpwcmV2aW91cyBiZWhhdmlvcjsgb3RoZXJ3aXNlLCBpdCBtaWdodCBpbnRyb2R1Y2UgbmV3
IGlzc3Vlcy4NCg0K
