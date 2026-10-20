Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.129
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792504384;
	b=t52n24ZdtuPnYhvFkiSEuESkTKJuRVGpwcyddh5Y5FLsjGZkFr7a4tAMntUt/eHR8pOR
	 jYWRCDNRdcln3K7WV0LT6+BdjMkDZylIb6w9FcviUw25WKusUpX8B1yx2BRypbCH6i67i
	 gPZzy80Z1jrmODZo5lFFQhNRk2kbOuEK+F8DYQe28dv7bElCgKUb8Oft02Xfndz9Jpqq4
	 ECpUkXOl2VzP+ASHwsrbpo5/nhNIcMy2aLKMZm65un+5k9/Tvk/nKKZ3WfYF6ibFbTjvo
	 LfXpWhdiYzzGagpZlYrdON4oeBqipdhpoaTwY2H4MHPT+SbMnuHa0EqGMO5SbTEDVzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504384;
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
	bh=Sp9BZDCJSPYKYKwWttAGfBpvJHVea57EX6Bnuoov61o=;
	b=S6bDKQ95sS0GnyWzjH4fjzM1CWwtvaeixPoWdL9zhvB3z6ZX7znVgsyeRyBXAWCqMg2+
	 yCGa3WfVxilfkCRjvYLf63INKu8judVGqkam3IjYsa+CepbZaYHU/wYobf7QkqjGIyro/
	 HZqIlWNYWfb0sTttirdPARKshK1Cydd2uKSpUPi0EWL3KehcTf3FQoL+KnZzNUqexXjfu
	 giYPNUtDZ2JEyJoQb/M3xulHmyFSEcLDUvV1BlBFqzyitcUt5EYDAeygA2iDI+1ipKna3
	 rnO4U8CrdxqnDi4jzmhZa9cAKO84QxXmKrvUHmzApLefG8FgZY/UMF88KfTu/w6Ghag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vecima.com;
	spf=pass smtp.mailfrom=vecima.com;
	dkim=pass header.d=vecima.com header.i=@vecima.com header.a=rsa-sha256 header.s=selector1 header.b=iTmMWBSE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.129
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021129.outbound.protection.outlook.com [40.93.194.129])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F75D606A31C;
	Tue, 20 Oct 2026 13:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F75D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vecima.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vecima.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vecima.com header.i=@vecima.com header.a=rsa-sha256 header.s=selector1 header.b=iTmMWBSE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyyNpZb9CvO/bwFPCj5Gncom2OB7Bq3IsmE1HH8Q//+hwGCnlFQsWSSPh+lOX2HDPhLLzfpLVrVIgwM7ZCCKTWM7SXKVdOqbsHw3gjc9VoHVsJg3afMVrjoUlLkwpQS9F9AFe13ACCToP9C6nJPvtWhsvZhmsyknWao0TzBIHUoarLA0YbMSwNOgIEgl48QmExzwWVLrbsVIqG7uACzQMctO+mfgffr/lx14Gh0dx+5X1eCEgzQvYhEKGSAjKM08+jMujqJYZUsHlRNBhyOp8yVhuJUrxSIPhzN9mMqHsAP3UXc5mwyE3JEqGzwYAiRqlEHG9cztDwwWtbxL1W2dHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sp9BZDCJSPYKYKwWttAGfBpvJHVea57EX6Bnuoov61o=;
 b=ak5fLcbn+ZnYooPk2NDaLMJ3VM5KrA6D3k3AhUOku4ZOQHqbpUMWzrRulKsFSnY0uIiU7xUsV8YEgvMiU/hKZtX03rnK/ZuOqoJekICMckEf6cGfssCNqHXYp4L+I0nZ2z2DleRUT2qSp1Ax8p/WtzUp+3SHEq/OAADJgtBg6UVMt4vLvlDPDb/LhqaS16gQVnoLvHBVQKCCrVpvLJML9FOEfZvnEOZsdOKvgDI+G8TV6pmnuestM8iT3uQQuvBsf0VCHK7oi9dHTkiOPDT7B2us+kslib7om0DFG80Q4w6ZRs9aSqp9X8gwam1CLQM4ReP1HIhrFKTz2dbOxIA9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vecima.com; dmarc=pass action=none header.from=vecima.com;
 dkim=pass header.d=vecima.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vecima.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sp9BZDCJSPYKYKwWttAGfBpvJHVea57EX6Bnuoov61o=;
 b=iTmMWBSEU5SNywhHJGm99sPUYgQPyXqxxNMx6WOc929f29jDhjCUBaawdabKdnCeOeS2uKpOJopLsxyQZFNv1lmCIS3EFORwoqth63yhZ9tSgdwzcGATb5QHmMSoRB/3bC4cKd+U5LXeNdE7IO1NtYpukdKswWthG2Rzp9IS9Vy6FBsKEJ1gQBou0Wog/G1bS6vuzLlNFbWRrWMPTPKs2x4HETf9EsGYYbTaLh2RXAoi1xHexPBxm4Y33oZK+Zy/eb48gqGYai6ZC/nz++aWR+1qONdOL7ToSxHr9IbiikBb86xSeZlMjzWyZwTT/36WPcHhPS12Tu/wz3hbDXEH4Q==
Received: from DS4PPFFD8A841C2.namprd18.prod.outlook.com
 (2603:10b6:f:fc00::ad2) by CH9PR18MB074315.namprd18.prod.outlook.com
 (2603:10b6:610:351::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Tue, 20 Oct
 2026 13:52:54 +0000
Received: from DS4PPFFD8A841C2.namprd18.prod.outlook.com
 ([fe80::6a72:cf5b:2c44:9ac0]) by DS4PPFFD8A841C2.namprd18.prod.outlook.com
 ([fe80::6a72:cf5b:2c44:9ac0%4]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 13:52:54 +0000
From: Marcin Knap <Marcin.Knap@vecima.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
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
Thread-Index: AQHdX6MW14dMxGSC9k6V0uDc5Tc4vLcFXSSAgACWooCAAA4QkIAAWoaAgAAN7TM=
Date: Tue, 20 Oct 2026 13:52:54 +0000
Message-ID:
 <DS4PPFFD8A841C22E2663DBBA3A1B4F581E80672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
References: <20261019-xsk-zc-rx-double-free-v1-1-2aa19f6628fb@vecima.com>
 <ataHK9s/MpNgXWhT@boxer>
 <CAJ8uoz38cE-1diOnih=HYW+ACqq9YQhaM7tz8KCHjTxgZVc+rQ@mail.gmail.com>
 <DS4PPFFD8A841C2AC917618A9B1B19453C480672@DS4PPFFD8A841C2.namprd18.prod.outlook.com>
 <atddQ8qN/R1tU1fk@boxer>
In-Reply-To: <atddQ8qN/R1tU1fk@boxer>
Accept-Language: en-150, pl-PL, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Enabled=True;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_SiteId=9d639caa-2d40-486d-ac82-e59b0005382f;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_SetDate=2026-10-20T13:52:54.153Z;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Name=General;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_ContentBits=1;MSIP_Label_93f18445-29d5-46c2-bca3-016d3ef06464_Method=Standard;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vecima.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFFD8A841C2:EE_|CH9PR18MB074315:EE_
x-ms-office365-filtering-correlation-id: b6cd637d-625d-4ec3-6e8b-08df2eb170e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|6133799003|10067099003|22082099003|18002099003|11063799006|4143699003|38070700021|56012099006;
x-microsoft-antispam-message-info:
 R/mH1Fvunx+g1aBqDz3oBWgFO2z35h2ARcaRv9wxEgCHizQnkVurZdg89gSSwg8Aw4hGq6xCwvVuIIO3CQj+ugeuutLJr4WadlMm57di7Y9mk09eiRnAhvGMYyBzn5Aq4byOrO+43WFhSiJR1eQtisM/AJAYFGBgDybYVLSwJTa5h3Obw04+E46M1idL93gcfBLz51R+7tyMhXpd95VHumkVsD0zHQtZ1ej5ApFN88x2h5YYVpQJuovxgfnBDupAv8Gg4N4xO3LkObCP4CBZnlcfRRCq0rgIEQEFXcKosF8CyXpwrBmD5XYTWWtmW5IaKTSmUsxjc44LrZsre2LbjuqRPVZT+vpWP+w2wH85nLBrgRNpYA5Fez9Tw1RFEQ0GPGGCynEvhhR1/kcwDP3TrcfGH0TUWA+mNoHl7V3oS+YFLF0RtLlQ/oa1xfnPxLqSQtA6NT5HTqV2RepFSTyfZFOH9cgf8tE0FiZ7pcTy3nKY5AXqGBMsAdUoQE503UxqvKb7GskE5an/WWsTYMyF5xsXd3JDZkXFaLHRkmy2bdiNo7pdGqQD3LKim588sZ//Vulvzcxt99s0QKFu+o9kretzVfiMir/UWaCcRbU7CtJHCPJ/pg2QnZiAyky+QyepArZbeVe86Rr68+ThLiyPoyejJwqPqc7ebXcTwma+RBLvr+umDjbFTN7TuAJCGYsre6+vCsQX0wmPRpNgwyFc+5aeAeT2kcIOkiPB+w10bds=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFFD8A841C2.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(6133799003)(10067099003)(22082099003)(18002099003)(11063799006)(4143699003)(38070700021)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pp2IvRtMth5VFOsJKXUQ67AJdB2AQQ61oLKKeJ0PhiXB0HXFkjeL544lOhDE?=
 =?us-ascii?Q?ab8xEAVuQ3tYLo3cnEfkgrBUHMwKycAKV9CxdrzqPRH6z3SxJjsdxbJfC/6D?=
 =?us-ascii?Q?h5c+t3uEBH5eWGSWzyR9AupRmNnqF959LCzK5Pzmy5/uelwLmEGli+GKM4sa?=
 =?us-ascii?Q?4Uueab9erd0FhRF5p5MwNsox3tmiqsHLVsXuMoC8ISHmdbW4wAY7zk5OrQBG?=
 =?us-ascii?Q?tVlkzq4dtvbPZx+GsIK9FUkAqzknAa7ZkLDzr4K4tRO7BeNcB+7pLg3T5Chr?=
 =?us-ascii?Q?g/3rkldrwPzp77o0B9IXIgnpE5yr/XBRlQ85EvoqhY/st/Wf3ag+D1LKn8nT?=
 =?us-ascii?Q?Yg2uzpdWkgYXUBOh/4yPehdoK6n4izMZB2Iz1VelEfIMOO8isp5FSfN9t/tn?=
 =?us-ascii?Q?Sue6PS3YLbJqOcZdu8Zyq8N3LyjX1/YNzjnlHU0+FAbjG7qe9NTG8pjcqWp4?=
 =?us-ascii?Q?a9cESzq26dHLk1siOH9PnYyRzF2e1O9yWapwwJfQqj+xudHj6mPHAt2pLiK8?=
 =?us-ascii?Q?yfrjxVfSPqwQYFOYVRNYyur8up/ZYftZUBkbOfO2/J6fnYg0FJz0Elf4NAHo?=
 =?us-ascii?Q?ZeEq1SDl9IbQlPZ4+gX80fEg4U6aTeoqyWp3xB0NUABqfVi6evtCML+aAQDf?=
 =?us-ascii?Q?XrG+wk3+fFk1YfZSHjlYqQyDrZq6jsL5/XSYs6JC2WwPTwK4/gsvxcjmzJEA?=
 =?us-ascii?Q?UFxZ0fB3EN6YmarN7qbxxfDZmR0Y6Cv31RatfetlnGZ63d3dmek0+Jb8BaXq?=
 =?us-ascii?Q?PLdPQ7sANwUIcgATWwq/ajSgPVUa8MPKeAKgrS3Ql6zc4aNUV5LgQCfRk4Jj?=
 =?us-ascii?Q?xkuQovBJA+LaBp6mLBfQ0uoCwc2VGdpWHq5X79UFE0Xy2kIPyaEQHFsPjjRz?=
 =?us-ascii?Q?ono1soG/orJKCM6G8y+44mWS4aUPgAK41lV7VHBULKtTWR+UU7uAvBOwZVhk?=
 =?us-ascii?Q?TFErVSK6cbxxJflVgdHVePj925iSk+lEC1V7E0ojQ+P/0FgPTrxuEwQ21Dye?=
 =?us-ascii?Q?U7pbaRokR84da9Uz1yzwvCYe/rhBsB1BI580wDkgryDW61kCES/QsSmnDeeI?=
 =?us-ascii?Q?RrcNOzlspQGWlKiQf+TTpb2FQLEZWjRvEuwDyhw2/pOfYEJVvAzqK9ShgjXI?=
 =?us-ascii?Q?RO+JvnLdDGGZZhePsI2CmUDlEP+1m2azLKQSDGmXJ486BTu1ZZfAN/aJfT3R?=
 =?us-ascii?Q?/LTUTHR8R1RPiP3K79JQfSkefbf2ap0jrbICJWFS23qMvwNKw5MYr6xQ/BH3?=
 =?us-ascii?Q?jUwoPLOUmjW+F+4jNdvLx8EwiOqjNLMjMMEDgCG55GQxyX1de/X4CmLnfq64?=
 =?us-ascii?Q?UrprJcbuWkDjnn/r8EK7Xw7O0cDAKgVLDRXwc1yubt8bjOWu+J2GUd6xngKT?=
 =?us-ascii?Q?ICK49bBrkMN6Sx2WicAnNjQOapvQxCIr/yeZWMtmOWkrus+wILf/vnOMQQA9?=
 =?us-ascii?Q?d/OngPbYTnKftyEvJdA/TKdlN8Rw46Ge3A6LozMzKV4FntCKifTYRuwBgJ+m?=
 =?us-ascii?Q?w3Rx9J3lI1ZA8FqwkcDqDSq3k6uV5JizMiYlmBCGFa0zrHQqjnSicoiTaKXo?=
 =?us-ascii?Q?h5+8MJs6+/UsyiP8AUkn+lqxiyaKncoCIFg/jH82z3uqA0yXwuDwSrhYfRwC?=
 =?us-ascii?Q?KqL1VrLNaJFe6WMB2k1HItz5GG8tNWZTSY03sbPaBuitkIUgSoyjUmiwHPs9?=
 =?us-ascii?Q?qXYJemmPdqrlg5ayaPbqhOzFFnchiZs83HUNB35ZjFXuQAcs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cd637d-625d-4ec3-6e8b-08df2eb170e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 13:52:54.7406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9d639caa-2d40-486d-ac82-e59b0005382f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: djdKji4WsOIg8z4skYSW7/2mSdcDevjKT+AgAmoJy5JW79m9YoSRD1K/bJVFT52Y6/D1xxck4k+iS0eQjasf+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH9PR18MB074315

On Tue, Oct 20, 2026 at 07:00:47AM +0000, Maciej Fijalkowski wrote:=0A=
=0A=
> Please don't top-post on MLs and configure your mail client to wrap your=
=0A=
> lines. Kernel people get triggered by this :P=0A=
=0A=
Sorry for that, I was trying but not good enough... =0A=
cannot setup this on web outlook and I have blocked every other client.=0A=
=0A=
> ZC drivers are supposed to break processing and yield cpu to=0A=
> application when xsk rxq gets full. We didn't want to expose=0A=
> particular packet multiple times to XDP progs as that might confuse=0A=
> internal logic of progs. Therefore we drop the packet in the core and=0A=
> let driver side know about this via ENOBUFS return value.=0A=
=0A=
Thanks, that explains it and it makes sense to me. =0A=
I will drop the core change and fix the=0A=
drivers that free the buffer again after -ENOBUFS instead.=0A=
=0A=
> Marcin, could you re-iterate why Jerome's fixes were not enough for=0A=
> you?=0A=
=0A=
This is how I understand this but I don't know this code well and I can be=
=0A=
wrong.=0A=
Jerome's patches stop mlx5e from releasing the same WQE buffer twice=0A=
when a refill is retried. They don't cover the case where the core=0A=
has already freed the buffer on -ENOBUFS. mlx5e_xdp_handle() treats=0A=
the failed redirect as XDP_DROP, skip-release isn't set, and the=0A=
buffer is released again when its slot is refilled.=0A=
=0A=
xp_free() only catches this if the buffer is still on the free list.=0A=
The free list is LIFO and refill allocates replacement buffers in=0A=
bulk, so the buffer freed by the core is usually handed to another=0A=
WQE before its old slot is refilled. The second free then puts a=0A=
buffer that is still in use back on the free list, and the same UMEM=0A=
frame is later published twice.=0A=
=0A=
> Would also be nice to align mlx-5 to -ENOBUFS case.=0A=
=0A=
Will do, I have potential mlx5 fix (this was my workaround).=0A=
=0A=
I did quick analysis with AI tool and it sounds like all drivers have =0A=
similar problem and they don't handle -ENOBUFS correctly except =0A=
Intel drivers needs_wakup path. Given that, would you prefer the driver =0A=
fixes, or do you have any other ideas?=0A=
=0A=
Thanks,=0A=
Marcin=
