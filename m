Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.97
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792479654;
	b=5QGU/AqthLk9iQuSf823ss0PzfL777ndsLCwHDMwsWy5Qm0uvUQpXytD1Sx0aQFCjRbE
	 cu1PYrNAuCgk/NGFWTEf6h/UiBeJRUIb3axoFns4RYXQnvb7iovNycsAKyvSQYEH7SIJH
	 mRTR9cH/iZ3A0DmC7p3DFBoWYYiNro8I/TIlPI8G1f5niYyVA9iBB0oKgZ83Nsaia8ncT
	 RDwKMxJvR/8oMjV7s4WVNIVULN+up/ZUVlfIt0WydVlCPO2nvog7ChjOO4xfIYnBmrL2u
	 oNWstLRaBR/r2/LyzDAFyeky8jOJagqSKjmK5k6HZuongbI254QnkCnmYbgWVZkz0HA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792479654;
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
	bh=/VVvS3p9MVQVPizg+CrUu7Aw+xxCEEdKPpTfT/NgpSA=;
	b=n9jt0JZkIDrUYwO5hXdQokhsEOhOuYVpPXRlgmuXAQjoFPJ5Tt4CEe6g2vG7FDYDJUNF
	 +1mlgp4ghuXWDAjQpJrU1o/TVBC+2K3NQf+fznKkALAuYjNR9lXSFFhYqablEmQxaQovF
	 2APXE6tuSe6zSni3Zcb9o+JgOwtSaozHSBVHHE3vK4QZ/Eg2PpeOM0Zu1p681saS55hPq
	 G8YYsH5Hw3xatfK3PzzXPLZD3C71Eomitg48aEpnDD8/rT+aZJCRWQ0MQXScTKgfezzCG
	 YmScqQlA3C7nZc80is6CX81/mET6aX2CkzrQniJnlACqHA+ZXom9Nq4/ayade7OgQHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vecima.com;
	spf=pass smtp.mailfrom=vecima.com;
	dkim=pass header.d=vecima.com header.i=@vecima.com header.a=rsa-sha256 header.s=selector1 header.b=iR9Uco8Q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.97
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020097.outbound.protection.outlook.com [52.101.193.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E4E606A320;
	Tue, 20 Oct 2026 07:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45E4E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vecima.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vecima.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vecima.com header.i=@vecima.com header.a=rsa-sha256 header.s=selector1 header.b=iR9Uco8Q
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJdyy1QwNSl9C4h5AACrFB6Jh+cOQ8CjlcaeHPezJx5r6aLsyjN/lgSqU0sLwWEH6hioC08HvGVnSeSrN7tkXyqNbffLh1urhuN1Od4MyPDbaBmuvv4UAQFAQUS0509SsCQ3TRH4m94D6PZ6MdM7IUwASeUzu8FvKSw8qStCpjmcumOY9Oy1Sxflaq35tRYnUhoHYKg67JLGidcdmCyC/KXL/oHMMUzFD8NeI5NVmRk6IxZ3atWU6bwJNjME+iM+OTzfai6VFVH3YNPcUsRtQVRc26I6Npn5xwkHpjOEsBkQtbVJswOfru+BeTz7/F+/WVD4LF6hzrwar4jvXwDjFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/VVvS3p9MVQVPizg+CrUu7Aw+xxCEEdKPpTfT/NgpSA=;
 b=ky2M+eWrzM8ADMteRcVDLA40Xikkvx9gDLhEGUBDbhWN4uBjv3921vWscC7yfi14YJ3nRvmXc+Kjd7PjTQiHdN7HBMSyOes4+PWoIML9AkSq6sFx/17PuKD/UgxenNbyi22+vVCfSBl8NcXQOguo4nLSqH0v5j5g+15nTzyssyGUSivu+GvpjaEdmyRo36Mc6pfEeRV+WPUoEugUNYSJ3T1hqVVQqVjLD/B9DfZi2rXi1nTi54Sab774zajDP626MQfp2uYIt2Ue0vRdFqUUphFTBjdAOtNnGeljNZM98W2QNlt+CFw6ayeb3iu3W6+m80wb/rwsuJJvqH7oxBMQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vecima.com; dmarc=pass action=none header.from=vecima.com;
 dkim=pass header.d=vecima.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vecima.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/VVvS3p9MVQVPizg+CrUu7Aw+xxCEEdKPpTfT/NgpSA=;
 b=iR9Uco8Q0I2QY7BpR5hURKBbPzltCrTmfDfRuGOxEHGR7YaKYsoR8lpNlMpestQAIKivAsA4ftdocE1gIZmez9zigy48ymxWoDy0xIyRAYmKjCtFcbobtNQJ42L5mZDa2tpkLu3dGTEPOJCmwvaeqfr1OkKig01fanU5or932+ZwGsthV7bjAlgyFTDoj5nqKU02X3OYVyMrbUwiG8R4rGj6HQbMklS0aJ7LPifbh/Fqh7KnOgsP7nfY8KxgMv1WHIcgZDnc9Dlh0pSU48zeh+Xqz0r8+hDmBZfs+VryRDfpVn5Z3mL/ejgJU77P/idMa0iS7fhvyn46Nj0VTurolQ==
Received: from DS4PPFFD8A841C2.namprd18.prod.outlook.com
 (2603:10b6:f:fc00::ad2) by LY0PR18MB626747.namprd18.prod.outlook.com
 (2603:10b6:404:234::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 07:00:48 +0000
Received: from DS4PPFFD8A841C2.namprd18.prod.outlook.com
 ([fe80::6a72:cf5b:2c44:9ac0]) by DS4PPFFD8A841C2.namprd18.prod.outlook.com
 ([fe80::6a72:cf5b:2c44:9ac0%4]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 07:00:47 +0000
From: Marcin Knap <Marcin.Knap@vecima.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, Simon
 Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, "jtollet@cisco.com"
	<jtollet@cisco.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Thread-Topic: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is
 full
Thread-Index: AQHdX6MW14dMxGSC9k6V0uDc5Tc4vLcFXSSAgACWooCAAA4QkA==
Date: Tue, 20 Oct 2026 07:00:47 +0000
Message-ID:
 <DS4PPFFD8A841C2AC917618A9B1B19453C480672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
References: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
 <ataHK9s/MpNgXWhT@boxer>
 <CAJ8uoz38cE-1diOnih=HYW+ACqq9YQhaM7tz8KCHjTxgZVc+rQ@mail.gmail.com>
In-Reply-To:
 <CAJ8uoz38cE-1diOnih=HYW+ACqq9YQhaM7tz8KCHjTxgZVc+rQ@mail.gmail.com>
Accept-Language: en-150, pl-PL, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Enabled=True;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_SiteId=9d639caa-2d40-486d-ac82-e59b0005382f;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_SetDate=2026-10-20T07:00:47.416Z;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Name=General;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_ContentBits=1;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Method=Standard;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vecima.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFFD8A841C2:EE_|LY0PR18MB626747:EE_
x-ms-office365-filtering-correlation-id: 24995434-ce05-4d4a-5910-08df2e77de7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|6133799003|18002099003|10067099003|22082099003|11063799006|38070700021|260925021311599003|260925021911599003|4143699003|260925022911599003|261009223027099003|56012099006;
x-microsoft-antispam-message-info:
 mPEFDCcK7de6uyjLOum6MnFaXGZ/X5uqyo0KrZZSGkUxR+YdVxPWobihk/tGxUEne94ho621scqYove568dL8I74ZZRLTujsm+DtsiRZ2jOhCC7ah02j5s0m/bX8GU5QtLYyCbykEW5k/XG+NOMOH8u1Xh3/2d55PVeF30mBu+PBptu2At9TgB+TqUCqhbcRwHNiSNgLi8ymqSexonukgAsQbj5qiJQSjkqUKsKRrP39xMfsD+SJpeHcOnpBHJT8c5KpS+v995QuytJzPjCw0rN/AAYBrXA1rkoSZpUfwjRzPOFs/AxCz1Fskn3PN+SDCWw/ZgsdHnw+IzGrNVKkJKF5TnCunaYvGorJBPB02uNEpgzc1ifwpo1ZCHC8eF80as9Nu99ovnW7rqKqVad9nS3p1BE2IhRUu3tLtCPR/ZGNtvC4qBIr2IU62rUSlIYMbILDjWITX4yKcXt5OXnhoA+8eRF7WFFBuKUUbPp/gEjU99N30UGeElunc8ikCHd9+9RcYeNorL8P23WYQe4iTNDmRFHDtv/eHmnQNk1IgsY5n4qjFXQTzcfW1yBjc3YmWOQMkLFLXlJzpfZVBCknYXzIXwibAUZ0qqu1LuE2HkOM1aSej3a4KZItnknkAbNdUSlSCeOzHKLJAGw6bONm7jGRKExu5TfJu7y00ntLcro=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFFD8A841C2.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(38070700021)(260925021311599003)(260925021911599003)(4143699003)(260925022911599003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JSn2t7MJzVvFIJ9FHzsY8xo/OPyHt/AHpuIg3+BTAkqGy5fdbPF1vb+LFMKA?=
 =?us-ascii?Q?7QJm+4oFnFZMSVh1D+hHQamGTrxpCFRFgYzlzgiZEQWMaUtbeihDHj7fBjOs?=
 =?us-ascii?Q?V9Y467ixgNBUOWmW6kOP+SsqPAoGPSRif01X3ii5oqPHlG3BUatEVyBPf8ul?=
 =?us-ascii?Q?c8+QB4CwC/nrkQ3wdPbBeO0QakB07Bnow5ZJGtLYsa56oPkMVbIpHSaWXFPo?=
 =?us-ascii?Q?52csKqKn2QV/pj/U9uRe6PRUc/zQPefAyKLmNcl3s7fHcqgTQYq5HDtvt+aL?=
 =?us-ascii?Q?evUPi78LHj9P72cMR4wXxYKlTV5BR4NaFOPkOCbv4uvJqu5d+yOBeAae14FY?=
 =?us-ascii?Q?7HNeKHiPYPF5VhwUSIeMY7NocyC2G/bNBJJxja2dA/3LR3lRFWhWuLnPU6Je?=
 =?us-ascii?Q?PevzNqqeoSvDl6PYU0/s761ZRvZgTZuEoh90mAMHLeIRKZ2lBwH42JXoTpPg?=
 =?us-ascii?Q?cxtnA80ssYPZZ2SChT92KjL3b++Vo7yzPAYjptSRFHnfr1ClvavI2fQDcXbt?=
 =?us-ascii?Q?WyTkslGqAJbk9d8+Ox5XGBGd+7c5bmxAG8l6lGE8BwJR9RX5TTB/MKzTPfGl?=
 =?us-ascii?Q?wuWlqZE5vpnmpBe2E6/r9rh/eLVhYirxkf5Io4JdxhSPkxfDQKOJMWlhYILC?=
 =?us-ascii?Q?TcXTUYYefcFoQM9HveMTrBpPMhGHChUk4udwgMAPZXkstBJbbaYAooz0JVZh?=
 =?us-ascii?Q?huIHQPRk8dLDCqDZk5QOV+0mZUIMW+dWh061hYBxoNLLVcvimwX8EXb3EQNO?=
 =?us-ascii?Q?6dCN8Bzv65vMRHBw2S4DfQWnTksxPiAmeySmIkI5qNQYn2RJO7UQze/6cnls?=
 =?us-ascii?Q?6+ydjaf5r7bvuvCqtX2zIb34Jv9tWdxdFru0kWFvj1B4rnEVX78+q20+8kdF?=
 =?us-ascii?Q?7VlNgsuAskWIcLpFIzP2rN09GU+mxLsYArkw5+z+huijnwsFTkJw9so4qExu?=
 =?us-ascii?Q?ltgY7TMCzyri14DVKHu/2EqqTPiBd5d8IVBbDnORXgpG2t4SUyAl093702k6?=
 =?us-ascii?Q?1TvT5njiik54pM5YCItVSJHSZwmbk2MIta18LY61t/Mal6Duwo+olsCNqT8V?=
 =?us-ascii?Q?BryIxkE5R+hGmT8QYaDx0kRiDwVbK0R1S5FMBoa2huhrYN4S6MTqWAvBEM1g?=
 =?us-ascii?Q?PyzN66okrFlbmn64Z5tK6EJ+YsXExVhIOjcMaf9Qk0NxQneq6SOwlEqpYwf8?=
 =?us-ascii?Q?jxyirqUxTTf8qkVXdqERgDW505NSLt2fVYfCq90nB4orsNxnT5wKCQ3Gf8Eh?=
 =?us-ascii?Q?2dhOi/ovvy4F0JAmmTvsE0qCaeCF5MqVXFxeo4arbdi01kXf2uttHIIdMO+c?=
 =?us-ascii?Q?H1041NNftf6mRExNSFGxHmSgfsZuMzMJnj1yIRDDNf/Fjr38czzAjJooJcmM?=
 =?us-ascii?Q?Nxt/nlsCeUFIhRgvsQUOLmTUX0OHDlKKW7nd2YnOaL424Yq+zBf6gbF76+eU?=
 =?us-ascii?Q?2syxHohgNYy8CX0btppRTeUTnLhbw7A62TdnrPXH1dyhdF/2YzD/aJ3X+QY2?=
 =?us-ascii?Q?sYMBxAmoUdL2CYoFwtxs73/9FfAQwvrhIM8/3HVsyDnGn3J8x3azM/uVqgVk?=
 =?us-ascii?Q?Cu3FDumRFLLONgml0x+lpFgruhUqnXrlXHSMiW0Bp+3PwLy3b7OtV1F7cuI5?=
 =?us-ascii?Q?6aw5pIq/M8vpIwUgYBHE5tw/6cmQSpkpnDfJwHflqbcVcLORKLBioOD9hFle?=
 =?us-ascii?Q?gGZc4SErx9yZUzfi2T0JHjHDnMwLeekmcuT601RfzKmdjNJl?=
Content-Type: text/plain; charset="us-ascii"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24995434-ce05-4d4a-5910-08df2e77de7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 07:00:47.8062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d639caa-2d40-486d-ac82-e59b0005382f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7QHfLmM8c0VTV6llPecxmh4VUsMY4CPsqhYki0Z4Qa1J0kX1lTkafM7u2Q5ktXxtfi2Ouvur/zHcNb56/p30w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR18MB626747

> Sashiko report shows that drivers are rather inconsistent here=0A=
Yes I missed it, I am working on fixes.=0A=
=0A=
> On mlx5 with striding RQ this also ended in a NULL pointer=0A=
> dereference in mlx5e_post_rx_wqes(). =0A=
=0A=
So in my case I received kernel panic when I turned of striding rq off and =
the rx ring was full, but the panic itself was mitigated by the fixes from =
@Jerome Tollet in the mlx driver. I described the problem with linked fixes=
 here:=0A=
https://forums.developer.nvidia.com/t/ofed-backport-of-mainline-mlx5e-xsk-s=
tale-buffer-release-fix-kernel-panic-in-mlx5e-post-rx-wqes/384752/5 =0A=
But the real root cause is the problem I'm trying to fix.=0A=
=0A=
> Did you verify this or is this rather a speculation? xp_free() protects=
=0A=
> against double-free cases.=0A=
=0A=
I verified this, the origin bug on our own was that we received the same UM=
EM frame several twice even we haven't push it to the ring, that was causin=
g serious damages in our system, we need to add special detection duplicate=
d frames after receiving frames on rx ring, when I removed this additional =
xdp free, the problem was gone.=0A=
=0A=
=0A=
> Have you thought about massaging mlx driver instead of intel + core?=0A=
> Even when that would be correct approach ixgbe would miss being addressed=
.=0A=
=0A=
I was considering and I did as workaround, but IMO the final fix should be =
placed in the AF XDP, because there is inconsistency between different kind=
 of errors, look at xsk_rcv_check() there isn't any freeing buffer, so why =
only ENOBUFS causes that? Maybe there is some reason that I don't know. Mor=
eover, if I fix it only in mlx, the problem in the other driver at certain =
path will persist including Intel, only ZC with needs_wakup flag path is pr=
operly handled there. Yes ixgbe is my gap, I missed it and I can apply the =
patch there as well.  But eventually this is your call where to fix it, of =
course. =0A=
=0A=
> A note to ourselves, we should write a section in the documentation=0A=
> for AF_XDP that defines the expected driver behavior. There are very=0A=
> likely more inconsistencies out there since this was never explicitly=0A=
> specified anywhere=0A=
=0A=
This is good point, some documented unification of behavor across happy pat=
h and different kind of errors would be nice.=0A=
=0A=
=0A=
________________________________________=0A=
From: Magnus Karlsson <magnus.karlsson@gmail.com>=0A=
Sent: Tuesday, 20 October 2026 08:09=0A=
To: Maciej Fijalkowski=0A=
Cc: Marcin Knap; Tony Nguyen; Przemek Kitszel; Andrew Lunn; David S. Miller=
; Eric Dumazet; Jakub Kicinski; Paolo Abeni; Magnus Karlsson; Stanislav Fom=
ichev; Simon Horman; Alexei Starovoitov; Daniel Borkmann; Jesper Dangaard B=
rouer; John Fastabend; jtollet@cisco.com; intel-wired-lan@lists.osuosl.org;=
 netdev@vger.kernel.org; linux-kernel@vger.kernel.org; bpf@vger.kernel.org=
=0A=
Subject: Re: [PATCH bpf] xsk: Do not free ZC Rx buffer when the Rx ring is =
full=0A=
=0A=
CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you recognize the sender and know the c=
ontent is safe.=0A=
=0A=
=0A=
[You don't often get email from magnus.karlsson@gmail.com. Learn why this i=
s important at https://aka.ms/LearnAboutSenderIdentification ]=0A=
=0A=
On Tue, 20 Oct 2026 at 00:14, Maciej Fijalkowski=0A=
<maciej.fijalkowski@intel.com> wrote:=0A=
>=0A=
> On Mon, Oct 19, 2026 at 10:22:02AM +0200, Marcin Knap via B4 Relay wrote:=
=0A=
> > From: Marcin Knap <marcin.knap@vecima.com>=0A=
> >=0A=
> > When an XDP program redirects a zero-copy buffer to an XSK and the=0A=
> > socket's Rx ring is full, xsk_rcv_zc() frees the buffer and returns=0A=
> > -ENOBUFS to xdp_do_redirect().=0A=
> >=0A=
> > A failed xdp_do_redirect() leaves the buffer owned by the caller, and=
=0A=
> > drivers rely on that: mlx5e treats the failure as XDP_DROP and releases=
=0A=
>=0A=
> Sashiko report shows that drivers are rather inconsistent here=0A=
=0A=
A note to ourselves, we should write a section in the documentation=0A=
for AF_XDP that defines the expected driver behavior. There are very=0A=
likely more inconsistencies out there since this was never explicitly=0A=
specified anywhere.=0A=
=0A=
> > the buffer when the Rx WQE is refilled, and i40e and ice free it on=0A=
> > XDP_CONSUMED. The buffer is therefore freed twice. It gets reused for=
=0A=
> > another Rx descriptor, the second free puts an in-use buffer back on=0A=
> > the pool free list, and the same UMEM frame is later handed to user=0A=
> > space twice.=0A=
>=0A=
> Did you verify this or is this rather a speculation? xp_free() protects=
=0A=
> against double-free cases.=0A=
>=0A=
> > On mlx5 with striding RQ this also ended in a NULL pointer=0A=
> > dereference in mlx5e_post_rx_wqes().=0A=
>=0A=
> Please more info on this then.=0A=
>=0A=
> >=0A=
> > Leave the buffer with the caller on both the single-buffer and the=0A=
> > multi-buffer -ENOBUFS paths, as xsk_rcv() and xsk_rcv_check() already=
=0A=
> > do. i40e and ice relied on the core freeing the buffer on their=0A=
> > need_wakeup -ENOBUFS (XDP_EXIT) path, so make them free it there.=0A=
> >=0A=
> > Seen on Mellanox ConnectX-6 DX MT2892 (FW 22.47.1026) with AF_XDP=0A=
> > zero-copy on 7.3.0-rc6 when the user-space consumer could not keep up=
=0A=
> > with the Rx ring. With this change no duplicate frames were seen with=
=0A=
> > striding RQ on or off.=0A=
>=0A=
> Have you thought about massaging mlx driver instead of intel + core?=0A=
> Even when that would be correct approach ixgbe would miss being addressed=
.=0A=
>=0A=
> >=0A=
> > Fixes: 269009893146 ("xsk: recycle buffer in case Rx queue was full")=
=0A=
> > Signed-off-by: Marcin Knap <marcin.knap@vecima.com>=0A=
> > ---=0A=
> > Tested on mlx5 (ConnectX-6 DX) in zero-copy single-buffer mode.=0A=
> > The i40e and ice changes and the multi-buffer path are build-tested=0A=
> > only, as I don't have that hardware available.=0A=
> > ---=0A=
> >  drivers/net/ethernet/intel/i40e/i40e_xsk.c |  1 +=0A=
> >  drivers/net/ethernet/intel/ice/ice_xsk.c   |  1 +=0A=
> >  net/xdp/xsk.c                              | 15 +++------------=0A=
> >  3 files changed, 5 insertions(+), 12 deletions(-)=0A=
> >=0A=
> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/e=
thernet/intel/i40e/i40e_xsk.c=0A=
> > index 9f47388eaba5..d32c7255f0b3 100644=0A=
> > --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c=0A=
> > +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c=0A=
> > @@ -358,6 +358,7 @@ static void i40e_handle_xdp_result_zc(struct i40e_r=
ing *rx_ring,=0A=
> >               return;=0A=
> >=0A=
> >       if (xdp_res =3D=3D I40E_XDP_EXIT) {=0A=
> > +             xsk_buff_free(xdp_buff);=0A=
> >               *failure =3D true;=0A=
> >               return;=0A=
> >       }=0A=
> > diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/eth=
ernet/intel/ice/ice_xsk.c=0A=
> > index 0643017541c3..7c1dd4c87a71 100644=0A=
> > --- a/drivers/net/ethernet/intel/ice/ice_xsk.c=0A=
> > +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c=0A=
> > @@ -636,6 +636,7 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring=
,=0A=
> >               if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {=0A=
> >                       xdp_xmit |=3D xdp_res;=0A=
> >               } else if (xdp_res =3D=3D ICE_XDP_EXIT) {=0A=
> > +                     xsk_buff_free(first);=0A=
> >                       failure =3D true;=0A=
> >                       first =3D NULL;=0A=
> >                       break;=0A=
> > diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c=0A=
> > index 33475b180ea6..0edc160c660f 100644=0A=
> > --- a/net/xdp/xsk.c=0A=
> > +++ b/net/xdp/xsk.c=0A=
> > @@ -224,21 +224,15 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct=
 xdp_buff *xdp, u32 len)=0A=
> >       struct list_head *xskb_list;=0A=
> >       u32 contd =3D 0;=0A=
> >       u32 num_desc;=0A=
> > -     int err;=0A=
> >=0A=
> > -     if (likely(!frags)) {=0A=
> > -             err =3D __xsk_rcv_zc(xs, xskb, len, contd);=0A=
> > -             if (err)=0A=
> > -                     goto err;=0A=
> > -             return 0;=0A=
> > -     }=0A=
> > +     if (likely(!frags))=0A=
> > +             return __xsk_rcv_zc(xs, xskb, len, contd);=0A=
> >=0A=
> >       contd =3D XDP_PKT_CONTD;=0A=
> >       num_desc =3D xdp_get_shared_info_from_buff(xdp)->nr_frags + 1;=0A=
> >       if (xskq_prod_nb_free(xs->rx, num_desc) < num_desc) {=0A=
> >               xs->rx_queue_full++;=0A=
> > -             err =3D -ENOBUFS;=0A=
> > -             goto err;=0A=
> > +             return -ENOBUFS;=0A=
> >       }=0A=
> >=0A=
> >       __xsk_rcv_zc_safe(xs, xskb, len, contd);=0A=
> > @@ -252,9 +246,6 @@ static int xsk_rcv_zc(struct xdp_sock *xs, struct x=
dp_buff *xdp, u32 len)=0A=
> >       }=0A=
> >=0A=
> >       return 0;=0A=
> > -err:=0A=
> > -     xsk_buff_free(xdp);=0A=
> > -     return err;=0A=
> >  }=0A=
> >=0A=
> >  static void *xsk_copy_xdp_start(struct xdp_buff *from)=0A=
> >=0A=
> > ---=0A=
> > base-commit: ff47652a4b66c067c765a7ad464d930b5a9367cc=0A=
> > change-id: 20261019-xsk-zc-rx-double-free-1a3b059cd41f=0A=
> >=0A=
> > Best regards,=0A=
> > --=0A=
> > Marcin Knap <marcin.knap@vecima.com>=0A=
> >=0A=
> >=0A=
>=0A=
