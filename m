Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.142
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793176965;
	b=2Ooac81GNpH0dGfW6UQJjBx7joQXjAX9KfuW0T6IzuB92Rvrmr+h/QTvyDi0kPMOu59z
	 B0W3+3vAF76cR1C4pYbvKkQYel8dk1X+QuFvg2kjLixSGAGraWcDkuOmmGd70hQBWpi08
	 YyEE1356YHEPneWJSaQviH1CcoMpD7XbntRtvebn8v8qY4G0+z8m4mvqdUngEXk2N9OaE
	 VPy8oyXdUKuuXPUjHccz2J1JZH0Wq9s3KkCiTxCyyRJl0sL2jPtEvdi8TMDvrR4bYYYyC
	 vt5e7uUy+XxNKqWogb+LOnhA5yiYCD/5gYvwI9kUE7TLrpdY6Ukj9YD6QVEDkVaFsFw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793176965;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=RkzP348H0sHnY/ZP4OTCBz9VJGCcXeIaljpzW+uzk2c=;
	b=y5GBZs05jyVS7z6SWDTJMrbbrwyZYKHqiRYPYwIqnFVJMTiDAPSU97ayb/53g+X41K16
	 RkobowyeFsS6S6XwUXxsYRtaf/MMrLS1lPWmW5jVIlvn08aagVFevoqNHJrBOQCmdSXzR
	 tIE0gR5MhaPA2jVn7s30/F4U2J5ZiB5x01gnbkwLEQfOF9jvnNF6YpIhw5FO8L06BduvT
	 oT+zVu/xRrgbSa34g6KXrD1rV9ALA4WqVpZdqHsJn7RfoCUtNrj2kNRY8RDXUzm6gijA9
	 9R4wcRiQd0jNd2GmfylbiQwOiiju68eHrdsLpORflNnz50+xV/NoRrtJQWNlLDrq+CA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vecima.com;
	spf=pass smtp.mailfrom=vecima.com;
	dkim=pass header.d=vecima.com header.i=@vecima.com header.a=rsa-sha256 header.s=selector1 header.b="sG0/VjL4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.201.142
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11023142.outbound.protection.outlook.com [40.93.201.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCF2606A31A;
	Wed, 28 Oct 2026 08:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FCF2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vecima.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vecima.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vecima.com header.i=@vecima.com header.a=rsa-sha256 header.s=selector1 header.b=sG0/VjL4
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTRpJwavuN0bHV4ADpV4RFNj40s3b/wC/ygaW5hO4KyilOm7BSp7u/oqrOGsANBZPfy/NNlqxtSaYWi/jLmYtXLp8D9y2r9/WppL7J+pyQNlvXg64VmRpOJIGV7OlyaY1OCnNfbu1b6To8jdl8F/5IDwixBC3/ESIj8G+tx+nhowZT2YsSOVlo4jYknZl+ZDdQkBMhFKF8VHVqqJbw48D7y7Auvv8kIWaOy6FapeYLV3En6XmrDl/+67N6A+ynUsEPPpwNv8wFKwcazUc40RKBAzvY0HRLY+zR/n0WVyZHT2Q531avYjX+4ZuiQsbFz7Hof/a8jY5ApTmE2semLREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkzP348H0sHnY/ZP4OTCBz9VJGCcXeIaljpzW+uzk2c=;
 b=tWJnadYO8ifH7FjqivE2ZxU8BCFk3wMdYIk98io+FNSs6ihUTRAXjX4Me2PswaIq7iLO3QN6IkrJ6RPwE828gjT81NRY6tVhEbMtWW6AiVVdfCCyaDMT0WsMNKtEZdiyTzmOhug3WV4vQ1l5TzL1x27NA2IcmYXvxTLM3hd6XhbbeT3gYQmFb5kJmmgqa1TabZrYTjlC1rAGsrayEthsFAp4jHO3U8KNuYF/MevSlJDRjcHtT/xH7A0XJ3AQ+OQierqjEeuonGCp8V0IuyJqZdl9bfRBjWm5zXlbtw5/+f+pJXjD1PAFmyXZnbIxzdAZbpZR7J0jEz8FBPjTXvnIsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vecima.com; dmarc=pass action=none header.from=vecima.com;
 dkim=pass header.d=vecima.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vecima.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkzP348H0sHnY/ZP4OTCBz9VJGCcXeIaljpzW+uzk2c=;
 b=sG0/VjL4ZZPLdKayvR4ABzAfSfXTR/sBgdQ6MAOADuM+dZ5uAkAcs/kWKEx07fQ2GGReQPxrPz8dzqKyILqW8vVnWSrecx76q+SmaH1LETIp9SaOCFrCbitXcHfkrNkqRzkQIFsnyeGvzuvfY9DlOkPJhzvf8VPssikU+bw/xcpxDFX0+kkuMY8I2dmqFLV5PEBNKyWZQoH2qJi5v7dEGMcUKmlQktYtvSn0SEAJykw0jDzA60NTHQmvWVPoWsfV8dhwavb1unt3yp5LOYQC2x+0JxPW24aQjNDEZIx4idVeqcbnAPURqpPLvdWY33zxNVm27D4T6nrtJauhH+UR4Q==
Received: from DS4PPFFD8A841C2.namprd18.prod.outlook.com
 (2603:10b6:f:fc00::ad2) by IA3PR18MB6311.namprd18.prod.outlook.com
 (2603:10b6:208:529::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 08:40:06 +0000
Received: from DS4PPFFD8A841C2.namprd18.prod.outlook.com
 ([fe80::6a72:cf5b:2c44:9ac0]) by DS4PPFFD8A841C2.namprd18.prod.outlook.com
 ([fe80::6a72:cf5b:2c44:9ac0%4]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 08:40:06 +0000
From: Marcin Knap <Marcin.Knap@vecima.com>
To: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>
CC: Magnus Karlsson <magnus.karlsson@gmail.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"jtollet@cisco.com" <jtollet@cisco.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Thread-Topic: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Thread-Index:
 AQHdX6MW14dMxGSC9k6V0uDc5Tc4vLcFXSSAgACWooCAAA4QkIAAWoaAgAAN7TOAAYa7AIAKu+BU
Date: Wed, 28 Oct 2026 08:40:06 +0000
Message-ID:
 <DS4PPFFD8A841C2FF8203BAD3C773A7784D806F2@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
References: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
 <ataHK9s/MpNgXWhT@boxer>
 <CAJ8uoz38cE-1diOnih=HYW+ACqq9YQhaM7tz8KCHjTxgZVc+rQ@mail.gmail.com>
 <DS4PPFFD8A841C2AC917618A9B1B19453C480672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
 <atddQ8qN/R1tU1fk@boxer>
 <DS4PPFFD8A841C22E2663DBBA3A1B4F581E80672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
 <87ld7r6xqh.fsf@all.your.base.are.belong.to.us>
In-Reply-To: <87ld7r6xqh.fsf@all.your.base.are.belong.to.us>
Accept-Language: en-150, pl-PL, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Enabled=True;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_SiteId=9d639caa-2d40-486d-ac82-e59b0005382f;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_SetDate=2026-10-28T08:40:05.739Z;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Name=General;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_ContentBits=1;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Method=Standard;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vecima.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFFD8A841C2:EE_|IA3PR18MB6311:EE_
x-ms-office365-filtering-correlation-id: 648bffac-eb9d-4a25-b7bb-08df34cf116c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|38070700021|4143699003|11063799006|10067099003|261026121527099003|261009223027099003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 iOeWfwVjztS1TrXXI3J43h2Kg/0UiCQDouBWjonWUgQz4BaO8h2YqLFw36kfljFL/9QLnjZvNpRwyfauMxP0OrYBMkIEIWatf8P2NgXUsOauHcffztzT/1jGUJKLldrBaHWnBK+fyNocf962MPVRZEqO62DM55j2dLyMEUaolgwr8j3QRNreqGtQkZBp2u93P94O2GCc9I5HwogKLiLpBSKNfPgmrwm9c8NPml2tSRcNjVdVB7Bhejkvx9BHQWw6Xo8645b8YUBESMLJCc7KKwTLamGokzHDbV0Ry9+rg6gH7b8fY2TFj4BYi6snqEXLgJyPpXyrT6vgLMdqSNGJwE40Wst45Kg+yKJ7xfro2kV7kjhFcuyZTco2qra6WjE29XQ5UvUB3Zrn/V1CkSKr7IK28aPHw8cVp5lKlNOZ5X3JqUFYQiPwleBcavkN/66HmLEEojeYbUYN4voQ7/pbZr+LrSqbVpbfa4nvA5skTtQCSWFvY+vJ0Y8cExCRj8ACAgrVnJcCZYO9VGmKDWa+YDbVfuikR+LpU30RtbGjSCqVeJxc+V7gSaZYNRrdhQfvbsC7DO24CBACb0P6r/YRiXHfw/zNmJhfNIWZZbYGjOCUvSTyVLcvg8hbRle7/bS9Ty++KDADSvnzcK+Gq7jDIK49Nvr1tWR+gPIZHDIErVQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFFD8A841C2.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(38070700021)(4143699003)(11063799006)(10067099003)(261026121527099003)(261009223027099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?iXAoD1Oewkpn2EmU/I/XeUeIfBh0De4mLKhUnZ6jOY+1hrWWvOojniKdht?=
 =?iso-8859-1?Q?Rui0tY6XooXZa4c5RH5s0d0qZvN7MOWUYnGjYMrUv1Yr4jZtOuBUG7Bm8R?=
 =?iso-8859-1?Q?ENVahVfLzTfTptTHMRgx8R5GPnj8iX2OiUXL5Sf0lbzsS9MTNBNb5b0c4k?=
 =?iso-8859-1?Q?uzqz8uSZx0HiaU8iWaKKC5GmnRF8o50CTTwLYZguPvUTc/1CT36vhrJgpR?=
 =?iso-8859-1?Q?RoCVbhMApYbW0exXzF4mS6RWcXWO10BEYblKi24pCeiuuqpmt9p5Bc6asz?=
 =?iso-8859-1?Q?1/EV+zwLFUEulcZWsrEV1tZxw+8rA7mOGsKYmTJEnfW+ynNk19IraODgU5?=
 =?iso-8859-1?Q?cTjrKsMqqxvP51wiDlZQo34rLxofQPBJ+dxgO6G9dmng6NylWXJ7z+Eqv/?=
 =?iso-8859-1?Q?NGqnNwYgCjQWB9kQk1ugsuT1EGDE3+BJAhnSlKfiLcln8LEL2z2JXuX1FT?=
 =?iso-8859-1?Q?bbQ+ztlPtPmRmnMdbiXT+lQbB6cIsMg9xyIQoU/QjA6ObXBlhZDJfZ/ZX7?=
 =?iso-8859-1?Q?THDnk289OlbZp5F+CcFHfCX3YfSiMQe6mFfYDYd2CDpnNwCaV6n5edeILh?=
 =?iso-8859-1?Q?2tWtnC3UFieiqwGdqyU9jl8MRof/Kmddm2o3HFmMYMcv6UM+6PQyp3qefs?=
 =?iso-8859-1?Q?i0pcHeonMBaPEnJYbyRbojyCmoD069QKZa29aaX0sqWlMXO4c7LPn4ysWq?=
 =?iso-8859-1?Q?5jiuFVBRUaHz8PV7yB25nL9Q8sXRnAwsSHhKcEDkjA5iOaAfQvRWhI1Fiv?=
 =?iso-8859-1?Q?b3whnBL6H4vzy/sYYOMUzE6nQOxraWA4HuqFl9UzS/e3aTlEzfQy0CKAex?=
 =?iso-8859-1?Q?J4TskvEHXIivPtTqrHj6XqLRhhuiVrI0H2/DGmjoacvhPa5ApKD/yt4HWG?=
 =?iso-8859-1?Q?Hg8tXJLa/vy9mK11DKYybSWHWmTghdLg16PfltIYBGRqKO0EGkTtHf6IbK?=
 =?iso-8859-1?Q?LJZOijs+fGYmcBk8YGMAZ43LB2e50y4wAnmHJVu6BUWGbew+TXdcvFJ3WV?=
 =?iso-8859-1?Q?hDh1LHJGKMxTgeI1/RfFxbP1hIjpOEpmgcCMZoWlKiJXK82pPCyMkRgm0h?=
 =?iso-8859-1?Q?dEdyrklMcsJGyCQ5uf1m+raC5LGMRWs36smlrM/czOhpuUKUV2Oeiq1c3l?=
 =?iso-8859-1?Q?N+JnETkVsQbmzmhOT55DaPIm70SPIezxC+mpOJeBFR0bxBejRtPuHdGCi9?=
 =?iso-8859-1?Q?6daGRJT+S7PcANZWwQJP91LjM6GJGYkZts9tB5rZSpQxPT272R2CvNnDHV?=
 =?iso-8859-1?Q?iFZCJU5ABqR9MQFuL8vT87m6vxeQbT96BgtTU9V6hrgMrMUWK55Towghgz?=
 =?iso-8859-1?Q?IDj71+k6GUH698Jevqg3qCKrURRByYvO4YGBWGBwRddpzmqZy1pmDBAwYW?=
 =?iso-8859-1?Q?rUMRYZNQb2XCe1b06UWQ0sl7zwvq3Ayvhff51WcSjdAAg0rRp2dUJ337/k?=
 =?iso-8859-1?Q?SEu14+HObT0IarF0Tcj30B0PLN9EsWIqfmy6WhsuAyyOxL1fjw+FUwNCxV?=
 =?iso-8859-1?Q?wtO8KPJqqS0iktIr2FHYpfxbYs6/lXYJ69rb/Ivv1fz4shKhlbT1gqSzdK?=
 =?iso-8859-1?Q?UmCEmyUsHqCjdsf5HtlK7wei0422PI9Gpdcxxoz5dRT3oTZLkYst9NTxA2?=
 =?iso-8859-1?Q?/47NciZOQuQOtsZ0/Og4t3QEAZVfFvwzgyTalXHJr/1vy4ALij8L5o0bt/?=
 =?iso-8859-1?Q?ZFSnhBmN8V27yCwdTc+fZPxf0tx38H4pLxZdLFHrxEbGk6l7bDjh+aulyA?=
 =?iso-8859-1?Q?XYVhKW86E+vdM0oUt1o7aXr6qDSkCwm8l68ZNY3RPA2eOXdoSIGe2+yti/?=
 =?iso-8859-1?Q?62VEK5Mqug=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: vecima.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFFD8A841C2.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648bffac-eb9d-4a25-b7bb-08df34cf116c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2026 08:40:06.4567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d639caa-2d40-486d-ac82-e59b0005382f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hg+bLekeqOdZ8MLEqpnqt3hzJRvVQOdWQMEt0wRUVLSxaqbMlxXHKhPFwnX1/oI89Vg07hxIeUz6j0stzwbb8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR18MB6311

> Marcin, FWIW, we'll discuss this topic on the office hours today [1].=0A=
> Feel free to join! I added a link with suggested wording for a future=0A=
> doc [2], and asked an LLM to audit the drivers [3].=0A=
=0A=
> Bj=F6rn=0A=
=0A=
> [1] https://lore.kernel.org/netdev/aqPxxX9MeGmAqGy6@boxer/=0A=
> [2] https://gist.github.com/fb-bjorn/d6835c49650bc3433b427a9c9708fbe2=0A=
> [3] https://gist.github.com/fb-bjorn/181786547c4dd8182ba09e23cf394dbe=0A=
=0A=
Sorry, for late answer, I couldn't join last week, I can join today if need=
ed.=0A=
I saw your audit which is very descriptive, that helps with understanding i=
t.=0A=
Thanks! As I understand you would like to fix the drivers ,which broke =0A=
the R2 handling considering RX Ring Full rule.=0A=
I can send fix proposal for mlx5 driver. if so should I create another patc=
h=0A=
from scratch and link that conversation only?=0A=
=0A=
Regards,=0A=
Marcin =
