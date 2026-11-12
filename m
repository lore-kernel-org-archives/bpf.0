Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.106
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794470336;
	b=QzVSmV1QmxIVWptMYvujgEDyv8kwvGoCsHYTr90g2ugi3Ebm/1Z5Jnnm5e96dDVabSoE
	 HT9Auptecd9rxmCNoiDpRr2Ux5Z78UPjYnSN+YvBFzNlS1QdWxM6VztcoyfK1lPpz2GRh
	 EHv8KlfJCIte3brWKMH313KPLRlxiLdBSQ/ABCaMuD3Cr7TpVDo6WKUWHtlrXqYrbSxTE
	 GJrS9ZW1lIYPwc99q04jSenjFTf7IVTrbUmXMEktmhXJNj+/RXgRLqFJ1rPL0eCqXT7A/
	 gMwYbeAXLlil00+FFElLl+JZogS98DnaPNwoeKHo9tBmeyO0Imi29h4UEQTrPyzVABA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470336;
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
	bh=FhhU/YIhg6dhJIF63IcrV2p9jqPbdVtcxt/KzYdlKWE=;
	b=Xd/Gzl34zrgAOW0rzxBtp9YBYk/RL2SFbDxszD0QLv9CwGwT6Xf3uNq6TNtmVx/LghWT
	 TGELARyktVCsyXIUkZsX0UsdWgjFSCMk/NFpoGCr9CrvgvDlQjjuHM7ZqAftLtPsKVk8V
	 Qxa+8doq91TzUpW4Uhwv3ugppOcmsREaNANJDWfCsZIlLgXaD/Wiicdp7DZNaLZfwEHdz
	 cfGttEC6tUghAETQ3S1YqD8ws8YcwyS9+iYZE4LhydhSqP78ebtzlI+9PZxXBPFnPZOgN
	 YsBT0BZjZQMHE9LizsZZ6JoEBhDdzW0kMvwB4nGTgPHAws0xjBAPe6g6nPiZPTPZgNw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vecima.com;
	spf=pass smtp.mailfrom=vecima.com;
	dkim=pass header.d=vecima.com header.i=@vecima.com header.a=rsa-sha256 header.s=selector1 header.b=lECeJreM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.106
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022106.outbound.protection.outlook.com [52.101.43.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A7C606A321;
	Thu, 12 Nov 2026 07:58:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08A7C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vecima.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vecima.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vecima.com header.i=@vecima.com header.a=rsa-sha256 header.s=selector1 header.b=lECeJreM
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ROe98CgSNNYV6vgfkt2q6j8C08+fye64dpnYYSB4Ad8b8aaQgCSgcegbN9zLXrdKaBPudxtevCXnsIIZCrJRhT9CiDJXXekj/McgSu0yni5U0ThhF0Qp+VDvMHFmynWTzA+SqM9QknITvL4IYpm94dyzuu0maG6felBDZI9zf1aZ4p5dVDgn+UykJDz/hSjcP3RQlNZJEiixji/n07ujL+4cU5sKDL6LzlHhiEUmciytgMVvdyst0qIzJFrwmUldvIkmL4f3/Up/GPL0rUosN2YKo0HkmGB4um4weBtCwEKsur/k7VFO6Tq6WplB3wP6PgMjyY1WWlexBoGGgvtXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhhU/YIhg6dhJIF63IcrV2p9jqPbdVtcxt/KzYdlKWE=;
 b=WXB+AOHma+43WQ9P1dT7FV7jnvgv/mMP///yG7RH+bVPlu+0HuJq7ZpTQOxJY/2R5i9A9FUfKAYe7GtXBTwdQ4tpQLVjoYNZ0EK2Cv5jr20OzBJ9dCQ4s+NbfG5Ba5WydgD2Dsp/PA+pdnleuirYLzRNZpoNaUejYMlg891iLCaerFC90Vxi008xJVy0S6F8nBCk7tCmZd6jMXAqigCL/tFbMEE9cGAHETDOqTwTEU7eYB/Hd//ggNuCz5FQgSskgaxsl3atgm3TIhZZIJrrikhn4X0/S7T6MHKBlyQ7ghT/3Y/z0JjwBdWfAh+5A9u8VTEq/ea6YkMI/4y+SvJ6Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vecima.com; dmarc=pass action=none header.from=vecima.com;
 dkim=pass header.d=vecima.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vecima.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhhU/YIhg6dhJIF63IcrV2p9jqPbdVtcxt/KzYdlKWE=;
 b=lECeJreMNBzaLboVabZ3FzZ5I2yV/s0zQiX3ZmFob3l70W0xoCcbQVo8e0FDsXJitD0Mf3rPnP27Pbl+71Wu3xv4VkvVpLs1y2+gLm4eyNx2bmRf7vg4E85O2UpaMUGtpiA9Resj59z0dUncKNMlA1Bi+MsIaxXTy3vpi4XQvRUzXDLpPCNuvKD2HBu9j/IAhOyCm0XPyiKIcNnUc0LN9/KtLemYsWY9jnjxD3se+owXK/fEL6PDxG8JBcbRwTTHuKCkvfsu5KPJghvBv1rCjoqYddZYLWgstGyaqhxhe7eGf3MnAQIn56NwIcW7Q9HE+CdNjoecV7W0RHxMloUeDg==
Received: from DS4PPFFD8A841C2.namprd18.prod.outlook.com
 (2603:10b6:f:fc00::ad2) by IA2PR18MB6011.namprd18.prod.outlook.com
 (2603:10b6:208:4aa::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 07:58:51 +0000
Received: from DS4PPFFD8A841C2.namprd18.prod.outlook.com
 ([fe80::9899:92e0:30cd:fe31]) by DS4PPFFD8A841C2.namprd18.prod.outlook.com
 ([fe80::9899:92e0:30cd:fe31%8]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 07:58:51 +0000
From: Marcin Knap <Marcin.Knap@vecima.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
	<sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	"jtollet@cisco.com" <jtollet@cisco.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>, Jason Xing
	<kerneljasonxing@gmail.com>, Nitin Shetty J <nshettyj@marvell.com>, Joshua
 Washington <joshwash@google.com>, Harshitha Ramamurthy
	<hramamurthy@google.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>, Bharat Bhushan
	<bbhushan2@marvell.com>
Subject: Re: [PATCH net v4] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Thread-Topic: [PATCH net v4] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Thread-Index: AQHdcDm2vnnEhLN5t0qvtxpdZuY27LcprD2AgABoNOE=
Date: Thu, 12 Nov 2026 07:58:51 +0000
Message-ID:
 <DS4PPFFD8A841C21E59BFBD0D40DF2C5EA380702@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
References: <20261109-xsk-zc-rx-double-free-v4-1-24e00ac221a0@vecima.com>
 <20261111173715.75bccc04@kernel.org>
In-Reply-To: <20261111173715.75bccc04@kernel.org>
Accept-Language: en-150, pl-PL, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Enabled=True;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_SiteId=9d639caa-2d40-486d-ac82-e59b0005382f;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_SetDate=2026-11-12T07:58:50.593Z;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Name=General;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_ContentBits=1;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Method=Standard;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vecima.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFFD8A841C2:EE_|IA2PR18MB6011:EE_
x-ms-office365-filtering-correlation-id: 66872101-317f-4d69-0738-08df4092ca25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|38070700021|10067099003|4143699003|11063799006|56012099006|261009223027099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 NroOdy61ZuzOb1lsYcKYwOzc7S9Wdb75GsT+jD94ymFLabJv5nNDVNuL+Hk8TndxT0+onYF0qvU0bfcqxoHcBtXDWLm6Yk7mYaA7+abVftZ4cK7RMafXNylV22KLvg9iwJNw8hiKt5cTTJuTCikQCSG6DmJM4/YHz1S+JqwhAgEEfSwwZDAjzKIubvt9nTNKjLFKs75/roGSKnrdI3dBVYAmpJDA9H94n/P2Jxeu6JHxh4WvLiyDwudXiVcwPuh25QWFS3HP4sH6+UceV1hvGcqy+FZCPNADffDPRvLeV9iaXznoIp9CqeYUoScHhZei5NCmfAN598XPojV6Fa/Hjcs/OwGcIPMteU8qFjqKDdPwlcTOtHQ6kgvG6Thjiun3cH1py9SN6Vo+BqSg0dk6SBBCcr1+pwmEnoMkdzoo7t17H+bPTjA7mJ5m8oddL82mEBAzBXpub6VmfXtnB/QvjwAJlxsK+jVj8N9Y4tzpbZ1v0khOsV1DmIcYh1rpiD/YMwh7IViox36Fg93QFo2atfOAplE4F6KMJCcP76XaA65ixQgJvR+P0e26X3Wua9DpZ/rxmOFeaqDXtn0PRSFPvUdkPNdFXDOqe5bNgFgs6Umi2nsmgOWYAb7mOIx2LDkxjLxUrTeXyS3XYFD+1KRtJXVIKhuHEpr9mbvr1M4Me08HiEaLOf4+6sFoqUTJyjyhUgB8yNj5D0FLxtY3UXm0zA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFFD8A841C2.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(38070700021)(10067099003)(4143699003)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?JKADal14row2f5K1zJPK0p2tY+hl5Dl+5BzxoWBFcL6kLulUKGI7F2bS9r?=
 =?iso-8859-1?Q?2Ht+Uztk1WhTAnHN7RWv8H0OWEpL3Mx/dFioB55k9jtdWJ5/y4WLJ/LA9A?=
 =?iso-8859-1?Q?9BteBXUPuX7ujJ0vu6HwT2shFy3nmAKmINL9Uk2Zvhg7W0Nyp+cwybicX4?=
 =?iso-8859-1?Q?YBvbFSi7h153clGV59UIwNfs6Nq/Vk58TENrI/Ty7xlVmgYNLC9pSQtzdS?=
 =?iso-8859-1?Q?asLWchKUCtcSi2kdTcpLha9GYSvljU6HzwUqGEbJZRFgN3LG334wHChDgL?=
 =?iso-8859-1?Q?pmOPl3hshUPVczGCNoqlcbBJwfA1CyCvqAAJ5s3Mae53Gi1+oDtWIsjO5A?=
 =?iso-8859-1?Q?ygLDCGLNOrccCtbldoB6yDK4hFy6CIFztfyHiLu1hNNbVHcWqo0rBYM7BP?=
 =?iso-8859-1?Q?4otBTBa9HHWRUo+HksSFBXE7SbQmU5Up6oeRBxUY9VhdyZohL2QcaFDedK?=
 =?iso-8859-1?Q?3vzwwgGAjNuO5kdM17HpOd7WkL/tvREGEScOOF7akt48etgt+gkgJi6b67?=
 =?iso-8859-1?Q?3rkwcb7SsKzfEzJ8QYzDx1PH4373CfaaNveoXKAf2goQen+KYMT1+82ceV?=
 =?iso-8859-1?Q?YdthaPC9zT9MtnhVbLRHeeRi8C59xO4RnRvyzHj+3FWJe2HSGCBE1pgqXu?=
 =?iso-8859-1?Q?o22REZUIHzbWfQ37Nx9NzoJRdrDiS5/oa/Te91EzwH2iWxaPOcw33FKRuR?=
 =?iso-8859-1?Q?Gm3XC+9jxVSvzsfIuv5zTXem3e9qSlm7eRjvVBAYAMk6mU0MLqlbVyw9qf?=
 =?iso-8859-1?Q?uXrfsrN44ePQVQSt4mNl6Fck8DwPndK/cETF22P/7NeZE9flZQh4UxozgH?=
 =?iso-8859-1?Q?RNLMXypGZS6TzEURVDLtV+pukOIXjB0CSDDlJNPdRp71O3tBXQz9u6vyhg?=
 =?iso-8859-1?Q?MTT1u1+anCLQ3lO4YUYN4a2tEyXI0/NXPoW4PdXX8dZDfPYTOEJTnL404T?=
 =?iso-8859-1?Q?WZy0drmLnZw8cXiKoStl/koVUpfIgmbsOGZ9Hny4qOLTHRcF0m2WRZxdCA?=
 =?iso-8859-1?Q?2Wkft6ukkFWWA+gL6ytTcCLJzwPWDy+rJXxsYT2mYRdNnD+Ars+0A89z+9?=
 =?iso-8859-1?Q?vJsUIFrof6jF1SWvNSy0+vHGUOigJQ8uVNYauKzY3YbGW2IpopjBF1LTbS?=
 =?iso-8859-1?Q?UsAGQaK4hayX0Vz+0b2W13CQ8E3JAXTGCVSK+XLIo4pOgbaBC5sD7aQq8U?=
 =?iso-8859-1?Q?uYNKiZzMRaeTnUMwydtKLHAfntPTO/9yAZZ8slzwh58qxQgeOplSNd7E6v?=
 =?iso-8859-1?Q?5f5D1k+bcxtA32wk6+ToM4FRz3BK601mZVfC/qL09c+olozxuIZJFSK+7k?=
 =?iso-8859-1?Q?qQmYSdOc4RaEhk1wgvfGnEpw7YhJuzzSGOjAH3WT7uW/UmDATpQn5CIMLu?=
 =?iso-8859-1?Q?/p7IWzqwgHGmjMKw3HUuCSLJvLyfVEvLgwM4V7NFIk7eotlAr9hwl+Kfc6?=
 =?iso-8859-1?Q?H6J5gP0SnwxvnbePZgysXPuQDXGWqz/HlTX2xjvSf9yV4CwFSqqMoBYkYP?=
 =?iso-8859-1?Q?BBxQRbiA4re4c+slV+cw0UF16/ZcnOCk9jYFfcTV+T65UaYSuAS5J+cA0i?=
 =?iso-8859-1?Q?lSdFMXyN8PPJ3l7RbUdH50XrLECA9Qtkb+n35A1pFggtSGmKCCyejfXg1s?=
 =?iso-8859-1?Q?JgyWIbsE7o89COLEMhpRZMHqYiMBgxH4cwoLMUoMHV7HR/BidQVdBDGG3e?=
 =?iso-8859-1?Q?F5VPU9GOizOYMlswjZeYbHq5BkgBBGwqyE4KAuwNUBIrg9qBFQAzAgJnEk?=
 =?iso-8859-1?Q?2vT/ievzRs8RgRl2LPfPlGWnVMci3W9y1PCFue9T7uJdJX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66872101-317f-4d69-0738-08df4092ca25
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 07:58:51.0492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d639caa-2d40-486d-ac82-e59b0005382f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjAKNv0VOblRVPm/oBZqhtNzzLn7n/9/EV1rsERXqIXTwpQJhgFhUx8xJA/unhIejGbbR8lX9TwTCjg+dakvjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR18MB6011

>But what's the plan for fixing those redirect targets?=0A=
>I think it'd be much better if we had one series which=0A=
>addresses all the cases, which AI can review...=0A=
>If there's consensus that xdp_convert_zc_to_xdp_frame()=0A=
>can be trivially handled later let's document that (and=0A=
>how) in the commit message?=0A=
=0A=
Thanks for the review. I looked at the devmap/cpumap/ifindex path. The=0A=
fix I have in mind is local to xdp_do_redirect(): for zero-copy buffers,=0A=
copy into the new frame without freeing the ZC buffer, free the ZC=0A=
buffer only once __xdp_do_redirect_frame() has succeeded, and free the=0A=
copied frame on failure. That gives the same rule as the XSKMAP path=0A=
after this patch (on error the caller still owns the buffer) and also=0A=
fixes the leak of the copied page. xdp_convert_zc_to_xdp_frame() would=0A=
stay as it is, since its XDP_TX users (e.g. mlx5) rely on it freeing=0A=
the buffer.=0A=
=0A=
I'm away from Monday for about a month and won't be able to drive that=0A=
change and its review properly before then, so I'd rather keep this=0A=
series to the XSKMAP fix and document the plan in the commit message,=0A=
as you suggested. v5 will have that. I'm happy to pick up the redirect=0A=
fix when I'm back, unless someone wants to take it earlier.=0A=
=0A=
Regards,=0A=
Marcin Knap=
