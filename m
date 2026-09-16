Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012027.outbound.protection.outlook.com [52.101.66.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9183321254B;
	Wed, 16 Sep 2026 02:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524997; cv=fail; b=SAIf8eAjk+3TCD+tWdbbcDJyJnTNr7y7+mQfJfTp15PU3fTjYOTSvsaFQgRs4+PLXW2hd4vvbDf6z4f5vDM76WDSju1Pt4dgamlXaZIbohVGipydG85wM02FQYVUxDL36VX2uHqHzEsBMDBsB6flsWjIVABYAZWluUopZDWgZ20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524997; c=relaxed/simple;
	bh=U+i8WWJlyxu/4dHfqjE0e2x3vgWwHkDylcKUc8VHYv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lBwvlEWhPcfZ58j6tkiaZnK5RVdirK3Li3VyH6ZKURvna3GPT8mS8HTqEHpHWdyPL6+5T6JuZwJeYg6pJQ7cvl82PQb3I5sGrc19Mk+Dw7EotxvxtmdXJeiRsqiibzNyqgXP4ThdfmzpcEUSm4Rb2Kf4BzRhTYZc4SPaVn51pno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PvnDrrlC; arc=fail smtp.client-ip=52.101.66.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PvnDrrlC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCx3tOn2Suyd+uf5v9E89zFKytU4z7HWw4XTfIJ7aAaeoOVCaUmL8rzNZBPAGXDb1RukyVKCvU8urI+5OWTgyKhxg3Qw23PWRgRt2q20DXZKHPtxxk/6A0besX59fr5nVlTP+iyxUn1rfRccBrpjVIwg0A1f6T/clCbHWEL+5gesBt6LfzP7Brp0ZgDl+eoWm0l9Lo8Wp6xoRT3xtAX6/IctglcVufd7Yfq4nDlq9BBTXHWZjIMzm6XpORsNuHi0Y16Yeuin0R9DuAW1dkV8Nre7QEJHBzmSxkdaHae3U3W8H0K/ILU6BTLI/pCr981tvSt/O+P0t4MaH8vKe/JrQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiLph8+2Rh6LJTiud0qidgkkcllxgZpUgJpFe9YpexE=;
 b=Uk4wUOe6x5g7F0o26e8j5QSuyQFULcbGgi6sxNpI33H0KgdvcpzKbP6FaLa7x1YZw7jcGcmzWdYhaK5jUF9oOUZRfRXRuwpsbazi2jgYiL+NPHqOH/Tj9nxoix5j6/xJ+1kGStxLKGcVubxOPK0pPq61qMFJUc1+580jeX4Mal2ZhV0Ks2YN1zyI+t0R1M6/pv35qyo3j6ZXH/Me0kQIYTDJ1JkYO6VXWGc4d/X3679bY50ChVHWcEDaqwsvpalhEUqiiQdr9C9KKGoRNDo4svDkWmhnrv5JtlWg6M72E1ox7HXnJs/Xn1tWYNojJhy0SN7XwR0wKmauvqHc25uCRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiLph8+2Rh6LJTiud0qidgkkcllxgZpUgJpFe9YpexE=;
 b=PvnDrrlCXp/MBq39cQPXbhKPvgPIuhOo5qxW1nEo1F5LAiYpJrMAjDL0msHFmPZlkzDBexrt7ohpYhpys/If5KojPD9HGOqDoTY4CEjvuJEuIrSNgtvJWEL1ZQzRaA0Fsd2UXgF/ilhmYis4oFHChypPWlreJr7rPqS1TeadGL0otT97XaomA3Ryhmzz2m9JNsO39btn59ASp0zMJVBuRXK8z/4lp+GbjSYfsqnKLwP21nMsZnVq61WjzX4aauLNFkwHzqYKhQhJ3D/5og+3r9+J7u8pj3Op5ArKNolreiqaJsekmDWeYxwHqO9TXsQ9orrDcZoUDBms1duj59wbpw==
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 (2603:10a6:150:2fc::18) by PA4PR04MB7885.eurprd04.prod.outlook.com
 (2603:10a6:102:ce::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 02:16:28 +0000
Received: from GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a]) by GV2PR04MB11739.eurprd04.prod.outlook.com
 ([fe80::71c2:937b:d466:174a%5]) with mapi id 15.21.0406.007; Wed, 16 Sep 2026
 02:16:28 +0000
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
Subject: RE: [PATCH v3 net 1/7] net: enetc: consistenly track dropped frames
 in enetc_xdp_xmit()
Thread-Topic: [PATCH v3 net 1/7] net: enetc: consistenly track dropped frames
 in enetc_xdp_xmit()
Thread-Index: AQHdRWFs/AKCnwLCzUukg6Ba8qfMRLbQd+ZQ
Date: Wed, 16 Sep 2026 02:16:28 +0000
Message-ID:
 <GV2PR04MB11739B011069410AB4B517A6188B92@GV2PR04MB11739.eurprd04.prod.outlook.com>
References: <20260915222735.1016937-1-vladimir.oltean@nxp.com>
 <20260915222735.1016937-2-vladimir.oltean@nxp.com>
In-Reply-To: <20260915222735.1016937-2-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV2PR04MB11739:EE_|PA4PR04MB7885:EE_
x-ms-office365-filtering-correlation-id: 803d0c13-9ec6-4730-a999-08df1398846b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|19092799006|38070700021|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 fru/sgaEsusWdCReDGU8PMnzNqHQlwQX19HB23Tefeuyj3yogTqchV4eoFYoB8pqjy2xc1aTIK38IThA/f14p99RI28RZiphRyNNiNVDLUhSqI9lw+cVImk+jQU5EWHfZUnzL9wf32vJ8jORss7Q8XNPTyISG1amS0GTVbUvbcYpYdcKjaowsubHbhmmxD9kCpwyMDdhzCswe77UwaD77W3yrEi05/Msk3sbq71BQlLsltPMGuujBwELz3EhqhT4W+z/K+6Xc/1uLYIFOvaQqMGUgWPkckykorbVTA3M/vkSchHwCsbP4AVmNsdRgClxdf1W9nUcSXCCGookWHTvj//ntRw+YAmUIIsZfMJxnqflwi65mkN485GXB8FnuWwcnVDV+Oztqo40QlU83pMurf6dgUuXp32W6caDeC+FcnQFx6nMJTsrcFPOY8b3BwRntUGXTPoX4yM+Vt609XpVk+zXGz5KBc1xXDayBkgglwKrQCzUKDv8ISJ+EBDVF6OyH9+DxFCXN2WmgzCq+9u/levR7WecUw4Dk6fvD81xnQoiz2xNbpUNWW4B02Zpg7Xy/lv/rWswbojJwuUWaOJUS3vDiODqqASoPhyxGOqOY0IfQzRMgGeyDwUJOfQb8A3IjLFRfstYxtcYXOz50tcHhMZ6OUaGXYs5Jn8/2MoeF+/wawuszfuFZoYQm0GFwPtzS8Wb5gMsUUxa7I5Uh32lhw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11739.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(19092799006)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?02U2LURKwPLxEzWka4OcRJTEpnWo3L7EjeBfCPv4ZgEYW3YKKPqKRbVxL2OL?=
 =?us-ascii?Q?16iICqJcx6jc8TxVInHsIGkY7iaSkDwD3ZEaUs/8b7NcsCKi0fAgPyKETTWp?=
 =?us-ascii?Q?jTPMe79qJ75527kRxFcl+Sk/JNeu7TjvZZGDSQncuNMxFPtrXP1UVuT8Q3UD?=
 =?us-ascii?Q?ZygK3StMVwWtRaREt56YnyJzf3Go+/x/tZMD7eAy6K7ubr0xtW5aarwM0oAq?=
 =?us-ascii?Q?z3uU10/Sb2yn6tC9Loirb9UvHZoRPzFby/4cs0Ip5xDBV5r+6gvZpH5fvFFE?=
 =?us-ascii?Q?TFBtzZUTWN0ASCDkijAMgei88MktZRXCxes/2dmRBzyVcf15wMRzmllq9cZQ?=
 =?us-ascii?Q?RWZvNv++08MOVFTf1qcG8xHycF71X5WZ2CPAqQLUVLtLUjXUIpO3sndjJkwK?=
 =?us-ascii?Q?DD2KGQeYDJYanPFs147xL1Vi8Mc0+nOYEwkBL9by9aYH+M4S7+ZJgNi2dARV?=
 =?us-ascii?Q?HZCcEr2nWOAP5Uyx1Arb13FUK1kLK5bEC72kn2szXitHSp04oLIsZotlKxW2?=
 =?us-ascii?Q?ojCbpwYf6UdRlHtPy9RFovuC7484xoX8GF6SYwC0riD5Sdh8YkPU80M////w?=
 =?us-ascii?Q?j3ExpyPrR+g5Mnmv0Cjipi/atJs8Y3aORf/eAJf9McVBVqrsyQlZEd2TKTyK?=
 =?us-ascii?Q?9ePLeH1NvWjI3r0EA3bGVfeUz0rtte0H9OVOnL8eHMxDMirQaHEvUPUukC4z?=
 =?us-ascii?Q?/OQMp0FQfXONehPdJTcWgAQbXqi0FACSZhlViS+iM7jEDZMZVwUgfwLtYsIF?=
 =?us-ascii?Q?wxhoUt21DDqCKQePd2rdcR1VfgkQ/fN4w2GlByTVKaU6Q2rjtwrXY/d8fm8I?=
 =?us-ascii?Q?sJqU0fUjWldaVB+JZ2pUBA3I002svG7rIctB0KqXwBXSfCnWYvpE8GoJavt+?=
 =?us-ascii?Q?koUoADdATC5owRON4nOaIYgQs0UKuNFqZDvhWQ3FjeYsLmONLOiIwVncNBAE?=
 =?us-ascii?Q?LRp3VBLPE8EOPxir/PkjPUtkP+PrzgTHqamRCriszJuyoB3IkhlkTTeDQQJy?=
 =?us-ascii?Q?wDwy8ZEwetXdmVc3v3/VftidCPPw5A9S/AoLilgdCbRKiCfyPUPY7P5CrAjH?=
 =?us-ascii?Q?5qHcNrowzQRf20U7qXnoDJXjrmAyE3mCGOTBXG0FeSSmt1Cgetr2SgYgQR1o?=
 =?us-ascii?Q?a/ecXLQwbixRAZANhlpPCMikBFldbvDGYDLnvvs+LLTOIDrMXrMSeFRblrFv?=
 =?us-ascii?Q?S5DAi5w4VX1yo9+Ozu+C693yucJ7zxVMnabm45PqaJxKabprsioN3Q2lJ2Ji?=
 =?us-ascii?Q?tlHMS6wthZ/yFY1katIq4/st0Pjt323fCPO7nr3WSR0/m2xAvuVriE4rJwYd?=
 =?us-ascii?Q?oohuRQwk9CbsmvViDzneah1vMGB00Mnw3dvDRpEg/qGa6u6aDV0gXVLJ0UlI?=
 =?us-ascii?Q?9k2V4RbQffPUAjYccJrhDO4lfmprXF1Beh0sMRCTbOytdPvWZKr4snOrbVBz?=
 =?us-ascii?Q?MkJ2RgXQAiG2tnJcTBX5w2Susj+kImXbsg/yxSxFJ33iQIwL5gdgZ2lPRexz?=
 =?us-ascii?Q?zqFtjcd09xhkO4oeBOdILulNzvcyfP6aH9ZD1Lnv+PdZFDyK/NR4kNgXeuuO?=
 =?us-ascii?Q?PVLTL2sCnptOMlmukGYlRGmBYjQ0Urde9MEFAb75+JygJpjzlAu6DJEKtXch?=
 =?us-ascii?Q?Xq1iugn0YQsJIszBeEA+/kcL0m9ILA2MnkxcHMTuuyjbjSdd6s9uxTfG3EcB?=
 =?us-ascii?Q?U+p3W09ISW0ZWsZjndj0Q9Hz93ZTNUMg+OyrAIOSqHXp5zn0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 803d0c13-9ec6-4730-a999-08df1398846b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2026 02:16:28.7143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1Fy5y6EMPfKDSm2bs8EsuzhKIFZHIOS15pFzjSwq8YkM+PBaTAnBSWMHrdEMPsjKBgoLZ7HV/BqD6Gl0JEkug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7885

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c
> b/drivers/net/ethernet/freescale/enetc/enetc.c
> index 80f0082f6c63..e7ecdf8ef67c 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc.c
> @@ -1843,7 +1843,6 @@ int enetc_xdp_xmit(struct net_device *ndev, int
> num_frames,
>  			for (i =3D 0; i < xdp_tx_bd_cnt; i++)
>  				enetc_unmap_tx_buff(tx_ring,
>  						    &xdp_redirect_arr[i]);
> -			tx_ring->stats.xdp_tx_drops++;
>  			break;
>  		}
>=20
> @@ -1854,6 +1853,7 @@ int enetc_xdp_xmit(struct net_device *ndev, int
> num_frames,
>  		enetc_update_tx_ring_tail(tx_ring);
>=20
>  	tx_ring->stats.xdp_tx +=3D xdp_tx_frm_cnt;
> +	tx_ring->stats.xdp_tx_drops +=3D num_frames - xdp_tx_frm_cnt;
>=20
>  	enetc_unlock_mdio();
>=20
> --
> 2.43.0

Reviewed-by: Wei Fang <wei.fang@nxp.com>

