Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011021.outbound.protection.outlook.com [40.107.130.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256AE3B0586;
	Wed, 16 Sep 2026 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524008; cv=fail; b=Fb59o5Hn9raHFs05qSypxTroizFOFxnFyYOQZcv8GWofZQdcs+KikT7CrPv7KSIx6JFAeV2yT/ainDMd+zokl/T1hwZjMD+howVoaCT4jxopgOWLQHnM/LRwKMFMie9zEAXliFBG7RZ2HQl8CLu1GnhVUH+JryUJQ3g5lUmCd2w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524008; c=relaxed/simple;
	bh=YaiMyYYRF65cLF51N2K/bW6c6sksaPy0wylpGKQKlzw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=asbNFiSLtz8O7PSquQ/pOtgNEdb4S/i2whc4zLIA9BaCooqVHj7TAsgcA8dkzKVpKfgCpK6j8fP6wI956fjm23UOKNQfFZ/Rj7H9j4aiknM8C8dE6RQZzDayMBJsGDaJQ9DBS7f9wUHz+hnoBE6jQAkNv+TjnTSGJX10OMPTHOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gTOWsmR2; arc=fail smtp.client-ip=40.107.130.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gTOWsmR2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OejfbLExsh9DnVVda5XXZ5tFLV7SGYA+DZk/9i+P6OcPLikzHwgNyF/UBdrFjO/jcbh5Cy9FYHfTfsOuo7xo+0CN48EWwC2XYO01pcUTIObGWlLWM0uglcDIsi9NkOYpZdkB8AN20tkSVtchAKjd0emPB+23uQhX+Yz0sx5NZ/AwU1Xf6d+w9SkXC1jSJ7xG6n53rKdD5Hc1bo//z10wWMcniHB3+AUTS7aTMtiVbeIQeQ2KGcPV/nSvJOtYkWHwDVXdnNMj+HX2M89doKHIVIFBBgkTIFUSBPKW14SFHGaF5/AQVzPBbzZMUS7uJ5FYVH8oq3ddtz0dRIxOGQV6vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6K9PD0k8rVsUExA4QKSHpuNdlwesuvCOSJ53qbCn8M=;
 b=d43J7L2zH678b9rFO5qilPvlhJbIvquEq8HzB03HOgHIE8+QYdVD7Mj93HM6ijBI+cTUt9EfGRjYVELs3MryqryJT8kWaZCNWEAuWXH0By3jOaRHWwEKnKSymdWTUntJ9BM6MWeRcrCvG/H4f7e5+JQZny3ZGsv/G76HTFw8WJnBIjgZmZH81in8PqtLlSilu4RtUAUMhYOQnZ2BXEBS6sFH66LFw2Oi8ObfWohA03wJB41UIRtN5IXi/swVZTzyE9/A936RI769J2ZEdgTg6tQMiWht4bpvr1vKg9hdrE8ipV2wZgOiimW/OQRGaFb7cd+vHc3DAz82XYxmh5PhLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6K9PD0k8rVsUExA4QKSHpuNdlwesuvCOSJ53qbCn8M=;
 b=gTOWsmR268R4I+Ad9SgbrMpyLGzuMWHzi9bvpnTxWEtcbRg2sPRt0vK7zFlFpTTUhX8Phjh6BhWXrrRMalHvSJuTh6kQRUpqIVNvioMyX//8PWyjGIUO7MN8AuFt7dkw9QWKxM4tPvzfL0s35P/0eTEqe3yWdfDtpEaSRF0yHef9bhlS1wVXQenvFB1fF+QIbgAL4rBzKOky7ZPDDoy1jkh6LixJq4XmWYsC5YdnMEgAgpeA7S4AW/WprxY2w+c4ahOmxzDADL7YvUzDVf88eF0E2qC9/G5pT+BtEsuLyj0rMN1tDd/87PmHlSe6mPkk77flSKXZAI0V5FT5gGj6Yw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AS8PR04MB8417.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 01:59:48 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 01:59:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: Zefir Kurtisi <zefir.kurtisi@westermo.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
	"Y.B. Lu" <yangbo.lu@nxp.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH v3 net 6/7] net: enetc: linearize PTP event packets with
 one-step TX timestamping
Thread-Topic: [PATCH v3 net 6/7] net: enetc: linearize PTP event packets with
 one-step TX timestamping
Thread-Index: AQHdRWFw24O9fDAF202+7IqiRxcb4LbQcp1w
Date: Wed, 16 Sep 2026 01:59:47 +0000
Message-ID:
 <GV2PR04MB1173959323D0661626527F64988B92@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
 <20260915222735.1016937-7-vladimir.oltean@nxp.com>
In-Reply-To: <20260915222735.1016937-7-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AS8PR04MB8417:EE_
x-ms-office365-filtering-correlation-id: afc2b7ce-e797-4f0a-a7c0-08df13962fe0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|23010399003|376014|366016|7416014|22082099003|18002099003|38070700021|10067099003|4143699003|56012099006|11063799006;
x-microsoft-antispam-message-info:
 MOomF/UeRYva3W+IPZnjlUuKi9sW/u6WmvPO7Y0llvZcVyQQfUYRsM9pPl2YYA9Es6ae7wkxpQKOYpBKhg3A7cBY15fYiSI16FgaIz50U6qmcpOXavmPUfO0gj4KLc7xrJTjN93kc8VfAhLk8W3ReBsPv+oxFpXiSc/RTcwJ0LR5+PVJGuy4l6+PRoNzhv6Ov7th7HyIB0HLXQ1VgMFcp9svQ1oggDUuyBa5fobJ1fdrxRkMYE34kwYpfJH1tAasE2CvRPW5Tn2BLbqW7YcKw3erHgZIy0S/1TNTg3InpMXCUCBBaca9+OL7vAvi4VvFCydLn0H+28OOJ2k/E1OH0X3S15nEHN62taZUMnmSEmnqLB27PKVvJ/9KAifeYwG81xiI5Kz1sjRvbRSLkqnZLfo4tfjx/HWepEAzgWZLIW1JK7XkqIsyVsq31bJsUcUGUmkOTgMPyemsKKuruVKN/JZgtaS7sipozoI98YfWIaQs51iAwWW1p7GDnJG4j3TC2AfEuUSIOAdwhGBAVwYNCz5ZiaWGjcbA5yZzx4iSyPKthyKZNc8Gac+Lsx0Cx47jn1JwTqVP1tN+77FAAiM2noTWmdmhWTrX3PWnutMtlwgmmr2zziUpp/LUABYGl0Sylv5eBE9/5Dv5DbmKGDegGwOUa5Pp9ToEIqZnTvonzQEqma3mMDjF0HQ4+coJlwg/JI+Fm9PGPDK3CZS7blZHJxVEBN5XT/zMMhT9Jiz+dU0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(376014)(366016)(7416014)(22082099003)(18002099003)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CU84chpZZplTbPJixhei1zRdfABTjlrA9nxYgab14eYyL59NUCxLWU3ZkXBO?=
 =?us-ascii?Q?6jOr9WQuRho0Lk8ypcP4JUCLNIlSun8YT+/y4qePAd91SVoAjfK25PVJ+grm?=
 =?us-ascii?Q?sIXJ45nWPn/S6O72x5EamR/bUyMNNWU6B+qzCqlNz0OaAdGy/j5g5/rTwfmG?=
 =?us-ascii?Q?V5EB6m7OrYfWQ2zYibEY6Rhj4aJVS/toC3guG3ltKwRHlhcmKriSgtgPddJ2?=
 =?us-ascii?Q?tPAEb2OpReTRBUCZL36MjZLQ10oDd+9UoKmMiHXz1YlWwXGH23Y1c9P8Y3xL?=
 =?us-ascii?Q?WM6gEP6MhhHpqpZy58PG99JKLjew32FOZlGOMugMvwDEiQ/l4hHTLdjFt6JB?=
 =?us-ascii?Q?qMfBEPBteAPiMjV4LpaOxdGw8Ry+/BYmosZ3Js/7qvvxvP1dRLtDMeekyQbw?=
 =?us-ascii?Q?Sgtv4Qtp9X6Hu8O+6cMshEWGtHq5Z4d6Svgyl6NO1JQntmB1G5U0SEsOulzY?=
 =?us-ascii?Q?8gbpNFMYKxDFt0as66bjnNYJXCIK3XImwpeLmwaK55Z3IoYrJbpNVVy8zhkb?=
 =?us-ascii?Q?G6VlvzOu74FsB1b1fPzlMLC7UEJ0Ofr607ZFA/ZGWYouQg57MuVZgJUQaIXj?=
 =?us-ascii?Q?yyhqPEqXtdv983Hqq2JsWUJeCvLn1gYhk6ib0toy9GzKFQoUbYkKjF9ffHX+?=
 =?us-ascii?Q?8pHLspP6rTWJqy4JUJwVC4PSx5mcPqWQv8Fr3E5UN3TtU6jZB3F2BdjHnuTG?=
 =?us-ascii?Q?aVcIi4FURQXsobThc2DRERMf9tQe54Va65IzZoGXwK2HZdyISZASTCrWfgI2?=
 =?us-ascii?Q?YUh/KJ4oRRjtiEf2J5SmZgB9l9n27+uWxoEfg7oPJ6cBN07nLrgAXzGAimhN?=
 =?us-ascii?Q?vNxP9bDIwCiu8rp0somb3PVXfD5wMlnED4HPpmVZ0KRwQ15tEIOt6kF2J6EM?=
 =?us-ascii?Q?Ji9qGwh0w6eaHdPBeDbrnBcFjRMP5ihmx70i7Z+03DA/4WI0pTWj4tWdCmHu?=
 =?us-ascii?Q?eM09dUZvIQszZW/Uob6ZF80969QPbc3OuN2LiObI0TqvkkOyLOlGcsamNlfh?=
 =?us-ascii?Q?zlgCbajeINnVT59TlJC6Ditzgfp3JnldDQl47K9jxekQvrM3AOl6W68YUB8u?=
 =?us-ascii?Q?Pb60AHCsURi/QcfXSi7NGWB5mYZnhftuEXiiBEFdlSJTIbiQlnyaWAOTDbvu?=
 =?us-ascii?Q?SBEfPDqLYEz9qd64vLPgBQh8BrocPHYsAfZ0ZXARxGcmnZnE2xBQj9L3A1am?=
 =?us-ascii?Q?ThnyQ/3T08tRLdNvuGThIHK4ptVDKvxThiMKIRE1s6p8VCZStpxQgTPgNvxN?=
 =?us-ascii?Q?msBqTebSxCGCPU7xH6GLdu/751ZH1z56LyuO0uIP036RcmujmZko54A+kovT?=
 =?us-ascii?Q?xx/NN09sUQ64tJXBqD+Ot019aaHcvV7DxxMxOd6wlp9mAprlA5WDQPR0sqfK?=
 =?us-ascii?Q?iYk4QiUGkT3xTqaQug1HqDniLOjwke3HUqLzc4zvyL8Ap8OtLY+0BW3UYFJN?=
 =?us-ascii?Q?7xoibHFFAerAl7wcTVVeoriAFK+jVXJXo7rksiKTS59bopzsbDrIcIQV8mrn?=
 =?us-ascii?Q?Y8xdgkAHUJb4i2HdkH0iVIGVTioi+nfMpAq07KS/KeY1x0aOeUGyLP2uLSq1?=
 =?us-ascii?Q?S43ZaL0ElQiIzWBFGOwfV259rRf0AGoBCXFka6Y5+FwH2OD6uxCxbMZFqhWe?=
 =?us-ascii?Q?1KSMELEG+XcCRhXw0KM779zR2VggXRxXzUkh9NmWsWReVqoANaoNUsZ50bPq?=
 =?us-ascii?Q?wRaKQ5DJ26KM9WM629cJEQZvS2So5NpEfE+vkmmnhDG2DuIg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11739.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afc2b7ce-e797-4f0a-a7c0-08df13962fe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 01:59:47.9009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhiu9EIbHBPhlaqXux/rHFL56j0Jx6ybjxi4eXDGcVCepGAT3LgASH9GsgQJueUDC7NMS02oIDW6D5jB/FO5Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8417

> ---
> v2->v3:
> - replace skb_linearize() with skb_linearize_cow(),

This is not true, this patch still use skb_linearize().

> - improve justification
> v1->v2:
> - patch is new
> ---
>  drivers/net/ethernet/freescale/enetc/enetc.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 8a9ba168eab1..62cdcaab3f3f 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1099,6 +1099,11 @@ netdev_tx_t enetc_xmit(struct sk_buff *skb, struct
> net_device *ndev)
>=20
>  	/* Fall back to two-step timestamp if not one-step Sync packet */
>  	if (enetc_cb->flag & ENETC_F_TX_ONESTEP_SYNC_TSTAMP) {
> +		if (unlikely(skb_linearize(skb))) {
> +			dev_kfree_skb_any(skb);
> +			return NETDEV_TX_OK;
> +		}
> +
>  		if (enetc_ptp_parse(skb, &udp, &msgtype, &twostep,
>  				    &offset1, &offset2) ||
>  		    msgtype !=3D PTP_MSGTYPE_SYNC || twostep !=3D 0) {
> --
> 2.43.0

