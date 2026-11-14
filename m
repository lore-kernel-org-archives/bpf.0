Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.10
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794624633;
	b=nn0cn1vTt9WprsE2j2sRSCFpQLSivVOXtrsGtsUhzJ7p6hPgxnUb43Gb9/WUb0u7OdYJ
	 g1S8J8+JOcyB05iHDRWlgbyFHPv++LruKc44EHfVcMCmguA+KIryDhi0UVkdCGldJbqLs
	 J1Zc5Etg3czEDeKa4oy2giBv3ix4i+3DQ7p7uYfXWmVhGUZtBpV3w7m/biJYn51cscqRr
	 fbTj/7favphQTeOtPdxmBg2kX7Jhu+EoqsBAIvzhkgtqqIP4Cf+/6dJHC5PjBVayWiCPB
	 EWfcme6hP0HnihWUcJjLolc8wz+jRudfPOGYEK29cRTI3j9CbxiELqlnrf+3KIYDh8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624633;
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
	bh=zE6MMOt2TDqRMqtjzeW0x7VRyaBtC5bE2tjDfccg/G4=;
	b=2N9dQFvhW5M0BKNsUYjKybtuh4bF49wo6MQZRh5Q+DgM1gmkqWGsSIw/hlT3HH/w6FiN
	 XzGZPFBu4GYVYq1EHl7a6ZxWYpjcNL5ZN4B3I/VyELSbFOaIaPENQ4npmHW3a3sUrrniN
	 GQ92fwXsIS0LQLgOGPuvVtWwzRUGlDdyDzDxzkNcalbNU0r2ozg/wHW+3mGWoyClfdVCB
	 BKKmyL8V07RAdDI7SHHfsu2ak/NaJODPRB/2cvdnjxsFWwJDJv+RaCJ3cLVFLg0Nkmj6F
	 DjRZWWs4QNo0xAHDrk2+YRnETKin7cHA9Xpav12FgYbJ9NV6JV1vKema5eGSMVvbKTw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=T9bl84ZU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.10
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326F6606A8A1;
	Sat, 14 Nov 2026 02:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 326F6606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=T9bl84ZU
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bip5AGZ3Yfo+6sZgPPrs5TQWtX4KFoCTmzhjQDWn3dwuoKsuP+IDNfhoOTjfJTRW0WMUJhTjxBuqUs7q2qPpZz2UKHe7vNasDUnt3EK+A/l0ls/BecpcgLQzf2MgF7oMUwnqqf6uJdRbVONsawWXKw8wi4sBpUe+lJPalzWaleuT3DW1onHqxqpqPQxxc5th/zS3U0KtzLKRy+58fdc873wf7RVqzC45VpqGFEdA3y3tN2KoXKziwF9tlRmyFnJeGvdyDlYvhX7azNJC8wTiHb1HtZuZvcByXchgFkg2HiAU4BZrVbPtsRT3gW+DzECPefWBIwwctGkMLF76LqQgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zE6MMOt2TDqRMqtjzeW0x7VRyaBtC5bE2tjDfccg/G4=;
 b=cz4hlPM+cfEyHiZfJ9MqgOkRTz0rmE/5qBuVkrKY3t+M5FLN9o01ENHhjMGGsKFEVrcvR5XZt1fjPshsKCjQvHAXwnBGmvMRa0dhEc/8kdRBH3WZ8DxV7yYUrHruQmyna2kaSNjB+K/QyKpsOoPqNiymnc5JB00TutZYNYzA2mrAW9W8rbpo3Xt24dwCcTisWGAROUL1Pu5s/LMuQS5mA5vuWwwEYvP3OkiJCUqVNfaEkahVTUK9j6VTyAEUKWlak0STXs9Xqycd/7oINzFLz27GcVJ/3J+42RtxilD+UcjGzNNc6UN0DHY6UoGQvgAqFP7uhrlGVO8lt5BJ3JXD7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zE6MMOt2TDqRMqtjzeW0x7VRyaBtC5bE2tjDfccg/G4=;
 b=T9bl84ZUPywsTJECLLb+8oiOP2dwd8w5JmxaeibIXyjBUOVgLPbLiMr6sCeNK3Hz5MaPmWERTEYWpAM4JyWN2YGfWLGvCqLti1+iWWgn8Is9WugjPRTWsR0ytg+aEKTibh2nsgLbmgY7RukAink+nLl9rfYeCHl5hHreQ66zqTzog5fyqqJ/enG78DJmk8CSyFhqxadrWYxb9fmZISYiu6fzu7FnLXSu4KlRuWcBDjOGlxxoafQXx9QN6BQRj3nlFm9m7hGd/cfgRhauMUppHnHLQkJDeHAvAchKQRwpSpBqHV4uBddvr6jxtqBcWAg75p2P9AGhvCGuQ5I++O+0rw==
Received: from PH7PR12MB8794.namprd12.prod.outlook.com (2603:10b6:510:27d::22)
 by SN7PR12MB7810.namprd12.prod.outlook.com (2603:10b6:806:34c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Sat, 14 Nov
 2026 02:50:26 +0000
Received: from PH7PR12MB8794.namprd12.prod.outlook.com
 ([fe80::275a:bcb7:918e:7313]) by PH7PR12MB8794.namprd12.prod.outlook.com
 ([fe80::275a:bcb7:918e:7313%3]) with mapi id 15.21.0615.008; Sat, 14 Nov 2026
 02:50:25 +0000
From: Daniel Trujillo <datrujillo@nvidia.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	=?iso-8859-1?Q?Dani=EBl_Trujillo_via_B4_Relay?=
	<devnull+datrujillo.nvidia.com@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman
	<eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
	<emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: mask speculative out-of-bounds skb helper loads
Thread-Topic: [PATCH bpf] bpf: mask speculative out-of-bounds skb helper loads
Thread-Index: AQHdc6uzG1gpx7ZaXkuKXK5YXvYSNLcsrEGAgAAOYYI=
Date: Sat, 14 Nov 2026 02:50:25 +0000
Message-ID:
 <PH7PR12MB879437C51235E3A3094EBCB9B27E2@PH7PR12MB8794.namprd12.prod.outlook.com>
References: <20261113-cbpf-ind-nospec-v1-bpf-v1-1-764ac4c14573@nvidia.com>
 <DMUHIJ5FC8EA.2XFM7TJ6AH0YB@gmail.com>
In-Reply-To: <DMUHIJ5FC8EA.2XFM7TJ6AH0YB@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8794:EE_|SN7PR12MB7810:EE_
x-ms-office365-filtering-correlation-id: e75118fc-7916-4bbc-1af6-08df41fa08d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|261026121527099003|10067099003|3023799007|261102123227099003|261021121427099003|261022075727099003|11063799006|4143699003|38070700021|5023799004|56012099006|6133799003|921020|18002099003|22082099003;
x-microsoft-antispam-message-info:
 mM51B1zcEVx+RRbsg/IDX018wQD0En2tjYcq7ZmqfU7+ZaaehPLhqfIX8IMcXZ8DpanfyXaR0iL+e/odewW71sJtXqEkGQaTENWXvLd/IAzntwoVyUEIt5oHYuL0UnPcUhmfbkDc14GC7JYK723QiL7V1T1RMzLoS3j6hGRLQxjxlY+Eq/327rwhWox2iuRl9ePMLWKTjLCe5RvTmEvDkXp3YZ8uazaYLzhJc7c4UntxH805w4byVKcRaEvsWeyB07wYK6px8YGoPwRJV0gWhe0ek8fmKkvz4QL5b2agSeixvto6Wvk1i2klDi41VwZcitWEiRAvgq9tZA2VpzeIvXf6l8zARRuV8Quaaic20iKr9uKaZ9hV+FvzpbZEeRMbwddqKEIrGukY5bW/5/4uDbs5yNzALD4ojNX6cjsEnjJOANK2WCIDgeJtFIrfIfc1vxbNKqiZMvGBYAqSD1FQM2wbyOINkNxVPzcI6HpcCD+aA9QMbxT+2TfgquVUi1es9VspdUXLmBuNfn2mjS0PEZsDDwGVPSg7fGSzL2Lp399N9wkccLZk0d23cuLrUpVg7Blgkf1fKP3kemnkNvCaFRmM8ef/fsmMvkPUm4h7jqGlzEs4Nb05JvQCiqzNGal8CSTUhH8+5YJiHBas8bltOozBfhHOF4fE5d7nn947VxGfkVPwu+8pRB0KCaWGiilGQspzM0sGh/YgnH2eVVyWHCPS++9nG5I4P7T/h1qqIzA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB8794.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(261026121527099003)(10067099003)(3023799007)(261102123227099003)(261021121427099003)(261022075727099003)(11063799006)(4143699003)(38070700021)(5023799004)(56012099006)(6133799003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?t0LOwofxa/t1RKevcLkx1ks/ebXDN8dGqaG6Mg/faEn30NrwRlmr4YlgXe?=
 =?iso-8859-1?Q?4yTwTjaNqYZJOJqv+2U+9MhrgyM6XBLGSN91tBRE7T/32rZD5BuNFonxfz?=
 =?iso-8859-1?Q?r5a2TpcfKk9ruotvxcfOEANwUdqX4y+mR5yp3Wr9OhhZ0b0D/Lert+n05d?=
 =?iso-8859-1?Q?V6IFoc4pqJQoC6doRAwUDN9gXtkl3jVmSI5aApjFNCN1LN/yPavtgnDtOY?=
 =?iso-8859-1?Q?/y+sgtaKVpucfx5ZCujkRz3V6lzY9QhwzKhC3sR4CPSgfbHzoUFYcdDqoG?=
 =?iso-8859-1?Q?L6xMyejQIzVLALg2KM0uPdScRI2a3s9OgVBwahvb2PRigJynFD+5+zkgwC?=
 =?iso-8859-1?Q?Fmfj1oYqdDZpowIz3e/84eSoGc6DyXKl6eZTjNuhovBZHgNRS82yUHni7c?=
 =?iso-8859-1?Q?Ky7JIPVHyYh7bknCQJVkAfgFAmv52DZd38eStobgo+RDKFryUX9ru3s0JX?=
 =?iso-8859-1?Q?cTG+A019pK/cvfBby2gBFr+mfbRqHoocL8FoXu2G9N1b0v4b4+SmtYE8q8?=
 =?iso-8859-1?Q?89ygrcHaTzuoeRLUXk1MZKVhM0+QDTjkf1epqPuusOn7ogrdaESKZaJx1C?=
 =?iso-8859-1?Q?X8Ne8DMwUI/Gb2wxegYKXp9BMotTxF2i7KRDA8DeHlkrN+rAApQ0ulmUUg?=
 =?iso-8859-1?Q?BOdEYuAO6gEM/1/dmp+E/tI08OxMDDiTdlVwzJUuc5xP2b+nYBKMK+jS1z?=
 =?iso-8859-1?Q?dKdAgoqfCA+svuevVNoJvocROv/teRLMku7paMuj9cEpvAaa48asUwQrKo?=
 =?iso-8859-1?Q?qXVx7dJVY5xiXCaHaXuD1D2AmRBg2ma8+d1SOhYYfwbAfA7O8WfTo70OoA?=
 =?iso-8859-1?Q?iBrbnsazppSlAnxU4oicmhRf9dRyQQOtr2p6ExY3ZMTKw30oeyY75ayd2c?=
 =?iso-8859-1?Q?ob9MsNjJr8ykDFeOlpd/E7fCF2dGgsfwxsdNmFAwZX/4h8NPQes9FZYJYX?=
 =?iso-8859-1?Q?c5mtTZuA/tIGASK9hywRI7g9+UcqyvpqSDjv486DuOTNZkfup0f2R2VFCq?=
 =?iso-8859-1?Q?Ut47Wmssr4Xe6I99WX7FrQnEnO8F37oApL9TXr0mxcsrZXw0XNUc/4YqY5?=
 =?iso-8859-1?Q?XdDqhOAIOoPx57VAs2YkIBbIoT6YeBxPUYtDnoCPW2n7Aow5cNncR9RFsN?=
 =?iso-8859-1?Q?T06OgN5dpZs3Rl/UN9Zla7P7WwmSDflm2erF3mRswEXyzGawd8SUDE08uW?=
 =?iso-8859-1?Q?EOtgvBJscJeXye9Xfn3Lw1/QF4JvHN+q/qKOvfQQk9plnXJ9aTgj23A48u?=
 =?iso-8859-1?Q?T/it2OUuyXr4FVOZTupe9u1Qzd6EjXTLHngucUMBUGQQQ5kGGuP6KEXWds?=
 =?iso-8859-1?Q?iV/XoNLjfKAmaQaXpKBEE+JkZxUxeLpnO55VVZKZ/MX6EZhUSWANwatY8L?=
 =?iso-8859-1?Q?twVuuJlgBt8BCU2L9oI+byftUYfl/G7N27aYrP1QaCDsNJ3ZHPxBY5z5vu?=
 =?iso-8859-1?Q?gK3oT9jBRUGedfX5b4gbih7GSSarIPI1MGHjEo0xvuR6m2rntZo2FhcbF2?=
 =?iso-8859-1?Q?3a/GzWdDi29003+q1VSKooay71mV3BMbI05UupJQcVzG0nHhX01t1cfuFH?=
 =?iso-8859-1?Q?RwfEvWbzHLWDKuaXFShvuvhqtw8NhtuAWD2X5uIziysefLLBAJ+07kKTLS?=
 =?iso-8859-1?Q?tsircCThYcHfLlidQ94cciOfg6P+VazTOj6jKDYFUAA/OTlEbNTmbll0or?=
 =?iso-8859-1?Q?ZwoxFAmuxjHHSusFZDgSnKnhlMLQfpnhNuB6Y0qA85b/cOgS5dIo1F6PHM?=
 =?iso-8859-1?Q?Gu5dDuucs/W+8Rqaf71PJjdgsYf0i6dJfN3e2YpQJWq8LC?=
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
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75118fc-7916-4bbc-1af6-08df41fa08d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2026 02:50:25.5619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w+OZwIiREVlA/cW+F6W6xs9y/MFpRO/gfCWjrpQW0HQVck18QlnFyIYd7KJ3S9ULsqVC1qHIndqsfWGB4NG6WA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7810

> I suspect you don't have a reproducer and it's all theoretical.=0A=
> Because if you had one you would have seen that your patch does nothing.=
=0A=
> convert_bpf_ld_abs() inlines the LD_ABS fast=0A=
> path with its own bounds check.=0A=
=0A=
The out-of-bounds read in my reproducer is BPF_LD | BPF_B | BPF_IND.=0A=
convert_bpf_ld_abs() emits a call to bpf_skb_load_helper_8() for that=0A=
instruction, which this patch hardens.=0A=
=0A=
With the instrumentation described in the commit message, the=0A=
reproducer recovered the target bytes on the unpatched kernel. The same=0A=
reproducer did not recover them on the patched kernel.=0A=
=0A=
As I noted in my previous reply, this patch does not cover the separate=0A=
inline LD_ABS fast path.=
