Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F508287E;
	Wed, 16 Sep 2026 02:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789525227; cv=fail; b=DDwUg7XVlWHcqs93lSbUDUXP1xcz+Hui3LTwpga7OYPkgTTtzd7bxZVa/DH9gpQbW2fImmdNODkZHfdYtPQvEr+zz0HNYVux8i7ZO+V3GAFzPIrnHvlhfN1sxoVSxJb0RVHBA10vFJNSgrk04sa5JZYpr53z8X8S7osHXkkm4LQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789525227; c=relaxed/simple;
	bh=WhoRMoofxvxhLVrueoSmubrRi44WGvqnkTBlgJjs9jM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gdTuqqaZ3TBGDScMKdgGwFmbCICOzmVmlV8BHSGm9EMvwsJI/QfQj6Od0dqgBD+qwbHFYDNzy38LT75PUqRJU27G+tL3b2gVmajEHm3wsMuWsRkEuEplNJ+lqFb8EK5HeQ0BXkKZIF+I0SHEx9BJ73GiSlJvTfxXyXU0bJDPAM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nV/gi5xm; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nV/gi5xm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4cxudBLvWgWsYj1ZshKOu9tgl8iYqGAXOi0isfQe2TOzcxRIArhk7Zl2fQLJWfvbumPbKyYTLXROUR9EKHynHql9FmqwBLuWY3wZm+nqafzBRx3eHLqPIa54yK5/BtZr4/wWaB7XPxdX6nqi3NZdgL0SdmmA6owGN/j3gJ1Qjc6m4rak0XQsxjnqiBiPsBZD1RzGjwabXg1TIJIv72CcxaaABjGikT37TG4YJPAzy8oTBAtpeYslYNwTWkjbwl/FgrGuWvG875STS3atm5XDCWmae+7E9FscHy9UuTmfQ93eK/aX1LeKzGRO59oOaMsIg3tGu+2ONTIs4AEsADsgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U478V79N5VPfcMq0bCi6tB6r7wZHyfgjSGgfT4jgwOA=;
 b=YAyTrvfjko/5NiuFggMon+5so9+aQijzg9jsDrN56LKsrnZnCU4l/yKly7rZJEt7Ot7LuNt+X0+xybsBerJGbJYQXo1J3KIQWqQaPuhOC1jlgracvHRPrNcSMepEDgOBvSuR2EEj8Apyo70yzoYxyPSmTvOWQ4u5edGY7B/6H7FgU8oCaDfRszghUEHY72xCB8CwNgwRMhKiIM4/KraHUczo6JwiX7hc1oNwrxgC8jSpJVKg1Vhw9OWiru0Q/nA6d/yN91s9vBsUcZq3WGRsUi8ZtWH7Nxj+kr6a5GYkOB6CUe4HcWaqfQ3yrjMuxUAoc3RPU9Wk/EXcvtBgAXrn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U478V79N5VPfcMq0bCi6tB6r7wZHyfgjSGgfT4jgwOA=;
 b=nV/gi5xmQJME45O5pSTmfFGeYhQ2on4LeENjyl2bT2RJ3v+hkLMXTzHBVtJ9Pfr94EG98XlmBdamvr/1YXxa/bRWXwBUb/ytxrdxjD6V+lNmdwdwuyT7wW5PuO5MCuzpjBCJ8cZP9vx+jNv13vif655NerlGVrSBJeFbG523+aklkuABg9EjDuvW5RgVUHwGibu2UYwMibz0NsylqCbDynH59MdXoEJePsBoDaaNj9Gzjz9HapkYnDivZBS6icCJOrR3L2W9ScrwVBDdle0taTGNVQbr+wWUmBva5qdxzqjc8uJmETajw7cZ9yNyG+e02NklzDdWQCREr+wxI6NwNQ==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by AS8PR04MB8451.eurprd04.prod.outlook.com
 (2603:10a6:20b:347::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 02:20:21 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 02:20:21 +0000
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
Subject: RE: [PATCH v3 net 2/7] net: enetc: ensure enetc_xdp_xmit() calls
 enetc_update_tx_ring_tail()
Thread-Topic: [PATCH v3 net 2/7] net: enetc: ensure enetc_xdp_xmit() calls
 enetc_update_tx_ring_tail()
Thread-Index: AQHdRWFs5icfT0mSEk6HhNc4f+7o1rbQeO3A
Date: Wed, 16 Sep 2026 02:20:21 +0000
Message-ID:
 <GV2PR04MB11739136B93D0455F1907E10D88B92@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
 <20260915222735.1016937-3-vladimir.oltean@nxp.com>
In-Reply-To: <20260915222735.1016937-3-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|AS8PR04MB8451:EE_
x-ms-office365-filtering-correlation-id: 2a44b9ad-221d-417f-ad32-08df13990f04
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|7416014|366016|23010399003|1800799024|38070700021|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 t6Ovpxh2l5397xQivlBHNigFOiEY40FlgJ1Jzuc+jKX6EEyPRTrvrBPsj7dIeO2ox8e9c+kiAvDkSNwoxyFr0DiwWtgwcPYJy1rX5/9vMK/9O8gUShY4htH8LN0woXHcrfUIb8YVWSNkZ9KDl8r84AaHI27//pB71ZrRqgA6TzK5y7JYEeaIib/QW8eMNxeX+/8fx6k+jNtPi6FVlDnyLVwj9v1IMVrQM8qwi1F97JWwSWoRnXEEeBikl2ur11ahQtMWrw5OII2cvvbBLTpcATccgmEEzVJcNPj7OduHEUu1v9IfliM1jZFcZPrqwDbccK4Z08Dv78P/g7X/ioEE4ZuUm2OYvgw9GWeWuHgwxQZN+7GodIe/kWZKmEzCcrgnBLe+in/fTLxkGQxTPLecZ15GnqaHeutDvDOBtmCAxkwkH2mjiTbND2Hev43WK0PZU5Ua3bgrCyO1DOg/hUOTtmbTnVHdctgHROcSdkX+3Pdr2b4HHavbJ13FVho9CZJbzGGz3NM1M1eJnSivUqAqW9AZaZBrusevYRxw2Re2/fibwPLsTNcARqjGkXGfl7WT7GhTipotE3TuPOWIw8IJqZnf4AAvgNsmyj3+tH1RLuD4/fh+GVcJDEjKTXPlEmXu+iKQdQTkVzQXJFC0iznAT++l1FVXAFqXrUG4L0ljUgScY75MQTlZvdASnDUi27s4RSPGdsE8m4l3TnT9LD2O9rpvxUna4mlB1LVA5P+aWwg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(7416014)(366016)(23010399003)(1800799024)(38070700021)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Dw4V+Jd0CrzdM96Rnnwl3Ik0jf7/1CFpam35ybCE/3OZt+OATonLE3BVChqS?=
 =?us-ascii?Q?plWX3AfmernIahnIjYQ23d9CRr+mq+5C49fFnXyD7uu8yowUtvqQTvQMskNt?=
 =?us-ascii?Q?fIAatx4gQSgqzOcBu/D50tNCFLQ1VZ9gSwqlSw6vVQ6daY8rfW5hAnFkXFAd?=
 =?us-ascii?Q?Uhr77f4UJDnJcimK26hQz4a/XLThenTsonAnu68oNeVxcsme98ttfH6vw2TQ?=
 =?us-ascii?Q?Kv1C1y3/Fypq628CtEePmC34Ew1D60E9XoWiqkapc+fGQ0PSHck1l8wZq58q?=
 =?us-ascii?Q?pn5PAALHWv+Xp/dIE5x4w9RTHzOFFlN6un/kM/ZSUcmrkk0FAoz309FPYAbj?=
 =?us-ascii?Q?l7xuwuXwArMwOe/Bel/HQkPPPBJrUkAEFBILjfFY+3VD9DuoeswxWl6ybUa3?=
 =?us-ascii?Q?nz4tDCT6FHuGxLV2uz/hCWhE7HMOQmmDv3CQm6lYRYqBMZtxhuGtpCh0X2LR?=
 =?us-ascii?Q?2y47OqALHZKDKpX8rhnjwnAK1UapJZEXf3ztKX6Rh3UvKv8Wt6SVWget+HCc?=
 =?us-ascii?Q?r7YatODZMxc0A3jRkl1Tbdy88dw424KWyzfih0mlX9ClqnYIsEQmmIflvqN4?=
 =?us-ascii?Q?fFcnMciGQYeAneP8oXp7zSim0S5RftbBwodTcB8BmIHVLzddZ7Pe/qB3Snuo?=
 =?us-ascii?Q?8wlzllvm4fmslVsG9y6BqxW+HhPPZxn+N6rbRlky7z2IRLY+QXnwpDzIxsvQ?=
 =?us-ascii?Q?KNTU+Gp16YuqY7aF72pjDttokNw0i8GD/uWev7Qhy/Gc4oyUUpO5D+vivq7G?=
 =?us-ascii?Q?f0Elae3uNIBZrv2cQKu2sQsLcyBsIIFpmDCC16xD0Tt+I0mIBvkPeDszPLk8?=
 =?us-ascii?Q?0TvejQr54vUzOHjsTPhHTskgGinY9TNUSVO9EGqGnx36v1t4mi/YTSwLALTE?=
 =?us-ascii?Q?ZjFiXjd8texJniJP064PXKagruIbh78bN98j1cHqT4F6iqU2watEsa8UdlAS?=
 =?us-ascii?Q?FberR3/SZy2MdCrMote9I7V1nsQLlw1o/cobdXrGD5fB8WYpaBd8KyuBMjyQ?=
 =?us-ascii?Q?G/bfwzOhR86QNVyyKo3y2vcgKz1FLCkkuCHU2aL2ehThfrfiSxro79xwiuD9?=
 =?us-ascii?Q?7j907A5z7RIlnOZaSVzZsg/pXH97Ne4ZfyNWJ1kswKjy2vfTBXdSuIN2hL+w?=
 =?us-ascii?Q?tJO0f0klBMr27KPnGLsVVh/TNrXP2JyBvay8WioYkoKctO93qyqV2rdkn+uq?=
 =?us-ascii?Q?bNgp7Oz61rKesSAW4/XC9O8NYsOsbK/hqtF44rH9K4g5+mZ0JSVA5yG4zupv?=
 =?us-ascii?Q?1Nu602Y0qJ2pL7pX1ZaKn44plcMTm3ehJFB8AYFIe76Qto/DLwjnFxLVauxv?=
 =?us-ascii?Q?hfYN3hTUSz7qd38Qcs539GEQ+VegRl3TF7c5z0AvYEugnapB2iYmcwxkGE7r?=
 =?us-ascii?Q?vN1N5+PtCxhNAP3qjSzL6GDZJnOBWi7Qj5ZAqb2Brw8tlDXFGMuNaHkpiPzt?=
 =?us-ascii?Q?jX5KFu6Ie8iyLIzS1gSYVS1KoA+VLm6wMeTV4LtJOYn3iCRHtm3ZBgGm4umG?=
 =?us-ascii?Q?9+BFB/yXmt8LC2YjLPogqDxTyOW/wdJ498XIOUWeAKn4Ga6CXHahvgYX+MOK?=
 =?us-ascii?Q?D7yu0t34g2YeqP3IxLuSmOSf+KLjDSMVmyvNCgsOeHpSNG4rBvY8towALJ1K?=
 =?us-ascii?Q?Bss2W2QB+a+r+i+h9tS2joqw2S7+/rpQH2yl0YyNUJF0xEFdirblutyaxSqC?=
 =?us-ascii?Q?CoXlNBDYOM8GHAheufvz77AfgiNG9d0NrfhYMLSY8d1zAjDW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a44b9ad-221d-417f-ad32-08df13990f04
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 02:20:21.2207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sL76Vf1KyYuEGw+L0yV80YuJ1+r6G29NxPt0Exp7FvUZRN6x/oFLdeukRj3V8WoHjRQGCyOdKhjuoIFwFDN7Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8451

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index e7ecdf8ef67c..c9c23e994f6d 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1813,7 +1813,6 @@ int enetc_xdp_xmit(struct net_device *ndev, int
> num_frames,
>  	struct skb_shared_info *shinfo;
>  	struct enetc_bdr *tx_ring;
>  	int xdp_tx_bd_cnt, i, k;
> -	int xdp_tx_frm_cnt =3D 0;
>=20
>  	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags) ||
>  		     !netif_carrier_ok(ndev)))
> @@ -1845,19 +1844,17 @@ int enetc_xdp_xmit(struct net_device *ndev, int
> num_frames,
>  						    &xdp_redirect_arr[i]);
>  			break;
>  		}
> -
> -		xdp_tx_frm_cnt++;
>  	}
>=20
> -	if (unlikely((flags & XDP_XMIT_FLUSH) || k !=3D xdp_tx_frm_cnt))
> +	if (unlikely(k && ((flags & XDP_XMIT_FLUSH) || k < num_frames)))
>  		enetc_update_tx_ring_tail(tx_ring);
>=20
> -	tx_ring->stats.xdp_tx +=3D xdp_tx_frm_cnt;
> -	tx_ring->stats.xdp_tx_drops +=3D num_frames - xdp_tx_frm_cnt;
> +	tx_ring->stats.xdp_tx +=3D k;
> +	tx_ring->stats.xdp_tx_drops +=3D num_frames - k;
>=20
>  	enetc_unlock_mdio();
>=20
> -	return xdp_tx_frm_cnt;
> +	return k;
>  }
>  EXPORT_SYMBOL_GPL(enetc_xdp_xmit);
>=20
> --
> 2.43.0

Reviewed-by: Wei Fang <wei.fang@nxp.com>

