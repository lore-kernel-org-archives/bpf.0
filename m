Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010006.outbound.protection.outlook.com [52.101.69.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FC643A7F3;
	Thu,  6 Aug 2026 10:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786010817; cv=fail; b=rAjTT5OMq6NBuadh7edvw56xn2p/jRtPiie8xq0/pm748Rq942HcxzDiK0Kyvp+roNzYtzwh67hj70YVyPD0ibwNfxKly7mIdF7gOlG9XUAz4FJPC+mTQM7UzKpi71aRLSA4+15sx00IjisBJ/uYGSKaohER1/ll/8T0CYKhcyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786010817; c=relaxed/simple;
	bh=8CeqvtqQscV2+Tge2DJcfKXdiGu6I/PEO3nw1d4wrXA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ro94HbyzIF4BjzWT7cKqT4k77oRSD3slCnzePPb4qEV1h9Rc7HVtxD/QLz0dpl0h5x95vGrI646jxrcdKaKeTTuMxg0ZqWP498gWeOFW9tb4uC6Xsb64kNA3WP+YSznFuO0jwWgyRiTZoKGDZSE0Hd+bY8oEYEnycCfRaen6E3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=k0c7Z/Xl; arc=fail smtp.client-ip=52.101.69.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="k0c7Z/Xl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/4D+QdHOB3czZVk6izmrotd0N08dZBuN4kk8VuctlF2xG98RVrvcQ5MzioalCfeGzfgaCStP69cTSeuCnAk/+Mgce6PbmgSDu6qMFhZ/MYLeFcE/8+SzKH1K4sLUphQKEpWbacZwm1meXl1ssH7F+hRTcdwFWaWTYeZpS+w7OwgSg4xbY5CMNO21WRCkBjg059VJUdXihd20NsxtDcoDUPUbVujrUrAHLDQZ0E5ILqxLaMW7J0jkpgTjCHi+tNGo8af6rXNgKxkgfY4WA7rtUsZp0UuH5OmlDioMUqkmvZEvSID8geneGRJDaTpCs2DgkJmyGnUoPrDOChCmKBzxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CeqvtqQscV2+Tge2DJcfKXdiGu6I/PEO3nw1d4wrXA=;
 b=QjiV7g/eiryIhRcgjHTupYHWxJnf8RnnoBifLXC5DUdqkicF+q3Ej6RCvCQ/xIrfkjUGCb6BJxkXABIpyoGyG9+LaxDT3Nvr9+U3sR1BPIpq04NFOQxTwkoZHX9OdiVohKaRb848S20tJsvicXKWSGroQ2a5E5CrnDcvF3HVYNeOf7qP30MCU2lk4hLMFg3uBQI52FN+Pk+Adnaq7tvcEJy1tf+qgrSywWpj+LuvGxgojmja2yuUDxC70apJvt8HOxTJ/6neaX9E2i3M3ajN9s22rh0b0fuYZgQXLdOl5fKzo8WhSDjBqrde6sI+6ZoZp0QQZqg8yT3QHsWCkMbhcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CeqvtqQscV2+Tge2DJcfKXdiGu6I/PEO3nw1d4wrXA=;
 b=k0c7Z/XlDawIPF4tzayI72jk3FiDDl2IirzizOGdlgj/PXW9rah+ACV/zErDLo6l+4+HzdIQaNGYqNfin3oaw+Yjd+9TRWaxUr0ldaKelK8MIsvfyycHQjtzMJqJtH8zOM99FsakMgCROQQimzUz0tWgUk/Q1N1AbVy4xwORuNgoMAHB/r4fmPJiLP9UZYI24AFQn3/lztAOCoNM1SnQwb3KVDkmLHgTwVLWqV654TpZETNDpzrTpzVl7pFrv5yYkvFtumTZdZ9gwsxVuGufF4rpi2zwFBtu6/YalIFk8eWIasd4kXHjh3CqtIT9DhimzgtlNvsLAhUZWMs09j2l4w==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by DB9PR04MB9750.eurprd04.prod.outlook.com
 (2603:10a6:10:4c5::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 10:06:43 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%6]) with mapi id 15.21.0292.013; Thu, 6 Aug 2026
 10:06:42 +0000
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
Thread-Index: AQHdJMgipP89sDqcOEu5VK5yASB6z7aPZ/qAgAAGSnCAAVot4A==
Date: Thu, 6 Aug 2026 10:06:42 +0000
Message-ID:
 <GV2PR04MB1173961FAF524C3A3FB49204888D22@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260805105314.3882595-1-wei.fang@oss.nxp.com>
 <20260805105314.3882595-3-wei.fang@oss.nxp.com>
 <willemdebruijn.kernel.4a69732dc0a4@gmail.com>
 <GV2PR04MB11739F20D97C6507DB388951388D22@GV2PR04MB11739.eurprd04.prod.outlook.com>
In-Reply-To:
 <GV2PR04MB11739F20D97C6507DB388951388D22@GV2PR04MB11739.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|DB9PR04MB9750:EE_
x-ms-office365-filtering-correlation-id: 0e1a3b9b-7790-4cfd-3143-08def3a26a3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|19092799006|23010399003|18002099003|22082099003|38070700021|3023799007|56012099006|4143699003|11063799006|10067099003;
x-microsoft-antispam-message-info:
 WAWbOaayaGIJomY3qujoCGNog3ZTznL7Z8v2Amq0wNA0Fw/GVtFTn4zTuJ1OQwvQ4YCZ+VAr95i9RmBqUwhSdcKWQvO33kPmStu6OhiHPzeA9Zw6ylvgTDJ5H8F0z3+BiyD0oV0QDkKpXhFfzfsobHUdUvbkxVMwrsxSYQK0RS3Ed2G5boGxa5oi945pAeoFhV5dfcvyxPe1byq+Xewhremw0l+jEaR4TJZj0rETBbP6ULWjf8+grGH8BtubdTmDB6c+lTu6+mDeQKrZnp4Q/qTUp9MowV7iwg3cq2X+9/vYGbjDF8to+rYMognfwLGPyTuJU68VAihxDTdu2GlNfZivaoMpqqCKo5VjcnfdvsGh6wm8cWjsuPyZv2CVTy+y2rwlWW2Z51TK6gbPSfwEgUG0Zi/SfBGXZNIT1n8wcjPV+JOaxA5H/6oBZHaaKNE2O8XxySoZyLcW8p2S0kfyUeXZ5u5zB80q8SPudzYO+VAAr6WXipzPH3qo805jrkQGaplCo3MNigTQ1gVTh7mX6mMHL4jOoyeGUdLSktiuBISC1nq2QjqpMVSN0Pw9TYKe5+5xdqzTwqCYK7C7AtulGVicGuDlgKKjLnobXGXoODaMi7AaaS/Q9FBuBmlGiLyekwqOaW/YnRcs35CusbCsxa770ITqNVaVhS020cpqQ3r77097I7bzEZZariUC3qXp2FOAT5Q0lU0oIp3FeIFQvPRE6+jLasDUuhPPSmOMbvw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(19092799006)(23010399003)(18002099003)(22082099003)(38070700021)(3023799007)(56012099006)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YkNEY1ZxVTlmUWxMdWsrQzVmaEJDdjJIUlU0YTJRZFpkc0toZy9NeXlKQmNP?=
 =?utf-8?B?U0tla1F5dTg2Mk9DekYwQktXeHNGZmNnWWp3eXo0VGdmdFdwS3U3WG4zSWg1?=
 =?utf-8?B?NWpjdDJKczVHTGJMYmRjYnAzQkxVSS9abDQ1MnlacXZRQ2h3ZkpneC8yVDZw?=
 =?utf-8?B?NFUrRnJOaEI2QzlFcnV6R0RhekM5U2hVVWxBV2NMMUNPRlI0Q0RoVkRkOEQx?=
 =?utf-8?B?Nk1zTk5vbkxqYlVBeWZ4MVEzVkhRSUdCbHJsNWkvUjljTkxkYnlTdzErM09Q?=
 =?utf-8?B?S1Vod25NVjgvZkRiWHZKU2tKcThLU2dLMDVaTVdkSHdCTDgrSENDT1IzOW4z?=
 =?utf-8?B?c0xyb2VRMGp2RFpLMURoeE5OVnBWOFhUYm9RcWZoaUw3eGQ0WDBMQ0ZsdmdQ?=
 =?utf-8?B?WEVhbXozZnBzUDlrN0M3V0lLMWlodi9wVUVQeHZkQmE0QlEwMm1HSzIwWGJn?=
 =?utf-8?B?cVl0Z1VtWWNyVm9GN0dwcm96MWJuUWJCYVdYRk4ybk1DL1BNV0UwekRFQm9s?=
 =?utf-8?B?RzBwMmxEN2NNdmFIUTBlUmE4MGY2YnFQSncyams2SWcwUVQ5M05nMzVUQXk5?=
 =?utf-8?B?TFB3RG4wNDFBdjJTRGtEM1dYa1pJQndQbzk2Ykp0aTRwVFZ4SzQyZ3dZUlhI?=
 =?utf-8?B?bW5nQnZXQ1FkRmg0VE5DekZ2a3RUbSszcWdobFFvYTI3SUh4TjNob0xBUnk3?=
 =?utf-8?B?MVB0VitzSTUrYkYrVWN6RWFBcDBrUzBkUDN5bWF0aEJpNEVzWFJTcURxdmhE?=
 =?utf-8?B?VVBuOUNBK2dmcXpSWWRnSFZEYmN5bmlzcHZ5TnlXT09Ia1hxak5QVUVRUVRt?=
 =?utf-8?B?SGE2cHRPd05jcVhnNFRpYUQ0UzFBdzVQRVFpUjV6R3B4NWVDdE5TakFjUmVn?=
 =?utf-8?B?aW9vVWxGNlRsdnBxVUo3VzR0Tnp2Tzc1TmozOFJsd0JBSnJsMlRmSmhRODBq?=
 =?utf-8?B?Y0xxZ2FJOC9nNk1TbkJkVkc4WituNTk3K2JLYytEaWZwV05qeFY0a0xXanBO?=
 =?utf-8?B?VE11TUNqY3R3UnpyV1VMTGV0d2twWjdQMHhRNmZMR01EZGFncHBEenJyZ3Ey?=
 =?utf-8?B?VnAwMXVacDUyaTRmVmt3cm5Kb2I3WS81UUNqMW9MNUw0dkdTOHd5VE9OcG9J?=
 =?utf-8?B?MU92WnZ4NWpZcHR3OGRxdXpPMjJORXdGQU5ydXVIczlMS3FBVThZaVA3T2hm?=
 =?utf-8?B?bEx3Sk5UVGJyRlhRVVdFdVl3blorUklEd1lGYnl0TjRGaXJCY1EwVTlMSkVy?=
 =?utf-8?B?U0l4WXJpQWtIVnV3a3pIN2djcFNScjVrcDVTTmRpRGZ4elZjMnZQVG5HQUdx?=
 =?utf-8?B?UDZuaEEyM25PaDRoZm56eTVIdCtGMzJ3ZmVwb1pMZk5yNGtrTzdia1pVclNz?=
 =?utf-8?B?V0UwWFlieG82aWVVWHF2NFZpc2ErYkRXaVozUlZ6L25mU0N4MjFqVUt6WlFt?=
 =?utf-8?B?U1E4aHhNM0x4UkFPYTU5NXc5ZFBqS250RVRqa1RaLzJoODZRYlRGbkFNSkNP?=
 =?utf-8?B?L3hKRThSeDRBb3FFUWk3MVRQU1JlVmxiY3F0ZXhYdHp1TVF5VzM1bUFjNDMr?=
 =?utf-8?B?cDNRYU96eU1vZDBVVGhxNmJKY0FBM0crNlM1UVlvaEIrM0NaeS91OUV3Y0Fy?=
 =?utf-8?B?aW1RNVIreWVxNmRIUWZQUnJxRm9zSDZVbWY1azlKa2F6UllwdDV3MURJOEow?=
 =?utf-8?B?bE0yRDBmTTFsZ2ZjUDZ5a1FESXRpejhWTDljMTBFMEVCeXpYVUZGUWRNaTlm?=
 =?utf-8?B?YUI1bFdrRy9kQmtkZGppcFI3ZERqZWc1VHNlcCt4NC9LaVFyK3l4cDNoRm1o?=
 =?utf-8?B?QkR1SmF5UExQTUhqRXZRSkg1Q2dMT0E0QlAwUzl2WEVudllXRFdxcFhGclRp?=
 =?utf-8?B?Vmk0WTc4N0xBaThHUUQyTWV3cFFndllmY3d6SjZxNGJqMUVjdE0xWXNDTkti?=
 =?utf-8?B?bm9BQ0JnUkZGdDRJcUwwdHMzSDFud2lKODFTZlJTU2NZRmM2U2wvdXZGekU2?=
 =?utf-8?B?WkRBSjU3OUd1ZDNrMk42cXRQOEZwVFZrcExZT0kzMU42ZTFNWE1CMXY4dml1?=
 =?utf-8?B?bEo3WXBWTmt3VXlFWnFsNG1SVC9SV3hTNVkvOEJVZjFTR244UDlvUHRLc2pn?=
 =?utf-8?B?Y29EZWg0RGJFSGZNYlZEb25WUGMveFB0TzVmYjFNYXFJbjRlLzRod3B1dFJn?=
 =?utf-8?B?UnhpUHUvbjBpOW1nckZSRXNROWhZSTFtaVNpTzJpYXhEQk1TTGJPaUZucWI1?=
 =?utf-8?B?ZEZZWTVLWURyMU8vNzVUd05Ccy9xMWYwVXRQTUlZZm1Zc0VqVnFaQXgyVUtn?=
 =?utf-8?Q?ieu0l+5wML4DK5GRsW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1a3b9b-7790-4cfd-3143-08def3a26a3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2026 10:06:42.5743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TzWasqHB7atDPoLzgG29iL97oe6S98lpFtUbukcMMrYbZBpAprC30tbLJq69f6grGLWMwjbxy8L4oZpXcdYVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9750

PiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdGFwLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvbmV0L3Rh
cC5jDQo+ID4gPiBAQCAtMTA4MSw5ICsxMDgxLDE1IEBAIHN0YXRpYyBpbnQgdGFwX2dldF91c2Vy
X3hkcChzdHJ1Y3QgdGFwX3F1ZXVlDQo+ICpxLA0KPiA+IHN0cnVjdCB4ZHBfYnVmZiAqeGRwKQ0K
PiA+ID4gIAl9DQo+ID4gPg0KPiA+ID4gIAkvKiBNb3ZlIG5ldHdvcmsgaGVhZGVyIHRvIHRoZSBy
aWdodCBwb3NpdGlvbiBmb3IgVkxBTiB0YWdnZWQNCj4gcGFja2V0cyAqLw0KPiA+ID4gLQlpZiAo
ZXRoX3R5cGVfdmxhbihza2ItPnByb3RvY29sKSAmJg0KPiA+ID4gLQkgICAgdmxhbl9nZXRfcHJv
dG9jb2xfYW5kX2RlcHRoKHNrYiwgc2tiLT5wcm90b2NvbCwgJmRlcHRoKSAhPSAwKQ0KPiA+ID4g
LQkJc2tiX3NldF9uZXR3b3JrX2hlYWRlcihza2IsIGRlcHRoKTsNCj4gPiA+ICsJaWYgKGV0aF90
eXBlX3ZsYW4oc2tiLT5wcm90b2NvbCkpIHsNCj4gPiA+ICsJCV9fYmUxNiBwcm90byA9IHZsYW5f
Z2V0X3Byb3RvY29sX2FuZF9kZXB0aChza2IsDQo+IHNrYi0+cHJvdG9jb2wsDQo+ID4gPiArCQkJ
CQkJCSAgICZkZXB0aCk7DQo+ID4gPiArDQo+ID4gPiArCQlpZiAocHJvdG8gIT0gMCkgew0KPiA+
ID4gKwkJCXNrYl9zZXRfbmV0d29ya19oZWFkZXIoc2tiLCBkZXB0aCk7DQo+ID4gPiArCQkJc2ti
LT5wcm90b2NvbCA9IHByb3RvOw0KPiA+ID4gKwkJfQ0KPiA+ID4gKwl9DQo+ID4NCj4gPiBEb2Vz
IHRoZSBzYW1lIGFwcGx5IHRvIHRoZSBzYW1lIGNhbGwgaW4gdGFwX2dldF91c2VyPw0KPiANCj4g
VGhlIHNpdHVhdGlvbiBvZiB0YXBfZ2V0X3VzZXIoKSBpcyBkaWZmZXJlbnQsIHNrYl9wcm9iZV90
cmFuc3BvcnRfaGVhZGVyKCkNCj4gaXMgY2FsbGVkIGJlZm9yZSB0aGUgVkxBTiBhZGp1c3RtZW50
IGJsb2NrLiBTbyBJIHRoaW5rIHRyYW5zcG9ydF9oZWFkZXINCj4gc2hvdWxkIGJlIGNvcnJlY3Qu
IFRoZSBvbmx5IGNvbmNlcm4gaXMgd2hldGhlciBza2ItPnByb3RvY29sIG5lZWRzIHRvIGJlDQo+
IHVwZGF0ZWQgYWZ0ZXIgY2FsbGluZyBza2Jfc2V0X25ldHdvcmtfaGVhZGVyKCkuDQo+IA0KPiBJ
J20gbm90IHN1cmUgYXMgSSBhbSBub3QgZmFpcmx5IGZhbWlsaWFyIHdpdGggdGhlIHRhcCBkcml2
ZXIuIEkgYWRkZWQgdGhpcyBwYXRjaA0KPiBiZWNhdXNlIFNhc2hpa28gcmVwb3J0ZWQgdGhhdCB0
aGUgdGFwIGRyaXZlciBoYXMgdGhlIHNhbWUgaXNzdWUgYXMgYWZfcGFja2V0Lg0KPiANCj4gPg0K
PiA+IEFuZCBpbiBnZW5lcmFsIHRvIG90aGVyIGNhbGxlcnMgb2Ygdmxhbl9nZXRfcHJvdG9jb2xf
YW5kX2RlcHRoLA0KPiA+IGluY2x1ZGluZyB0aHJvdWdoIHdyYXBwZXIgc2tiX25ldHdvcmtfcHJv
dG9jb2w/DQo+IA0KPiBJIGRvbid0IHRoaW5rIHRoaXMgaXNzdWUgZXhpc3RzIGVsc2V3aGVyZS4g
VGhlIGlzc3VlIGFyaXNlcyBiZWNhdXNlDQo+IHNrYl9wcm9iZV90cmFuc3BvcnRfaGVhZGVyKCkg
aXMgY2FsbGVkIGFmdGVyIHNrYl9zZXRfbmV0d29ya19oZWFkZXIoKSwgYW5kDQo+IGF0IHRoaXMg
cG9pbnQsIHNrYi0+cHJvdG9jb2wgYW5kIG5ldHdvcmtfaGVhZGVyIGFyZSBub3Qgc3luY2hyb25p
emVkICggSW4NCj4gX19za2JfZmxvd19kaXNzZWN0KCksIG5ob2ZmID0gc2tiX25ldHdvcmtfb2Zm
c2V0KHNrYikgYnV0IHByb3RvIGlzDQo+IEVUSF9QXzgwMjFRIG9yIEVUSF9QXzgwMjFBRCkpLCBj
YXVzaW5nIHNrYl9wcm9iZV90cmFuc3BvcnRfaGVhZGVyKCkgdG8NCj4gZmFpbCB0byBzZXQgdHJh
bnNwb3J0X2hlYWRlciBjb3JyZWN0bHkuDQo+IA0KPiBQZXJoYXBzIHRoZSBjb3JyZWN0IGFwcHJv
YWNoIHdvdWxkIGJlIHRvIHJlc3RvcmUgdGhlIG9yaWdpbmFsIGBza2ItPnByb3RvY29sYA0KPiB2
YWx1ZSBhZnRlciBgc2tiX3Byb2JlX3RyYW5zcG9ydF9oZWFkZXIoKWAsIG1haW50YWluaW5nIGNv
bnNpc3RlbmN5IHdpdGggdGhlDQo+IHByZXZpb3VzIGJlaGF2aW9yOyBvdGhlcndpc2UsIGl0IG1p
Z2h0IGludHJvZHVjZSBuZXcgaXNzdWVzLg0KDQpGb3IgQUZfUEFDS0VULCBpdCBoYXMgYmVlbiBj
b25maXJtZWQgdGhhdCBza2ItPnByb3RvY29sIGRvZXMgbm90IG5lZWQgdG8gYmUNCnJlc3RvcmVk
IHRvIGl0cyBpbml0aWFsIHZhbHVlOyBvdGhlcndpc2UsIHRoZSBlZ3Jlc3MgdGMgZmxvd2VyIGZv
ciBwcm90b2NvbCBpcCB3aWxsDQpub3QgbWF0Y2ggdGhlIHBhY2tldC4gQSBrbm93biBpc3N1ZSBp
cyB0aGF0IHRoZSBwYWNrZXRzIGNhbm5vdCBtYXRjaCB0aGUgZWdyZXNzDQpUQyBmbG93ZXIgcnVs
ZXMgZm9yIHByb3RvY29sIDgwMi4xUSwgYnV0IHRoaXMgaXNzdWUgZXhpc3RzIGJlZm9yZSB0aGlz
IHNlcmllcy4gVGhpcw0KaXMgbGlrZWx5IGEgbGltaXRhdGlvbiBvZiB1c2luZyBBRl9QQUNLRVQg
dG8gc2VuZCBwYWNrZXRzLg0KDQo=
