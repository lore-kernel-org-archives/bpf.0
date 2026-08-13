Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBDE34A791;
	Thu, 13 Aug 2026 12:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786623352; cv=fail; b=CKMyRR/EEKWhalvzp7qc+JZSNcpdyOXNe8TIahUEV9j6h7gwmgXw9PBv2bRn2+R2rt+ZhM6tChUAgLJ42O6o6B3Tx54yThj3SZ4X67w7w6jcEymAhyqF52v7berNTQksONNhKM2CUcDkhNA09UNFYAWE8vGzSZrBgIf3DaCaUSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786623352; c=relaxed/simple;
	bh=ciXGEhiQ6PlTbeLdFtq1oYgXGW8IbJWx/DAVVn8jtrc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cFObu9XARodpBdcUiZUqjFRJCtjEp52eJhrWnAMBQlS8stUI5Sxcvgw93/qD5iaFnoqrIdsulW/tOXsdROp2ygJ1KwnvKLGJ0QOFtcHuJQO3/VXQdL/6v2HwWO7OO7G2Md2UW76wuYCmZ5MfZj/V0BjMT1Cm5QRQUPC0n+ldp0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=IGeHBRwz; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="IGeHBRwz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ph5DAYHa48Vq+Ee1OK+o+g3jkgVKp06XL0JMutAlBLqKcLL44UfeKfvEjbzWWrkg5zATH1/Ssq6Bm4cER1klSdCdiUSyIloeRU4TCbHmkOWM+XqKZFVtYoYzupV6FKOS6KLYBvc/piFlwrYe7Q5O3AqE1xHO68BeydV0F7u1zHEO1VRynHUp16u/8XaefYc4aJvJ+DdHfbh4p4ntjRGwLaU01OlcrFpLAGiKgnnORPi7S46SJ61Eq4oBbk6SoDs0JMi/TZTZj8pnMp1DG2XiWBGeKpDMOG3ydIG8EEONjakDW8W9KRciaOg2XKChrCST2XgiODY9G/jRy8PW2bxIVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xk9B2ZNklqX0Ux64Jk9N/RrDZAyMhljZ/1nhAz4Hbo0=;
 b=u+wUnFj1O5oRz8g1bW+TuLXisxAEqVpnIujc9fSOdHKvNdIleD+hi/LBtXKIeWYXjuJ5JBlHwlz8kbKJF6jEdLJtUrCNnCN56NwTHpY8wW12/jwdgX1OeOb7OvQf0MyGoI8vLo3HgoOBHs+5aRn+5ftWbjsQ4xuqZvpDykccgsoyHmTrUncb57yG59hS2v6nd7p3ViflOY+jDoc6dGURvLRqdQChSKo2E/i8EeMwd2gj5F5II3f2RXFK+rkjsepBpm64esvLP+uhS1MWIpjC4Dkz1b6ZUDJtVXTTPPu3igc+JAEYmzb1nY74T/c9f6Jary/kea1u3+KiLg6v/LzSag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xk9B2ZNklqX0Ux64Jk9N/RrDZAyMhljZ/1nhAz4Hbo0=;
 b=IGeHBRwzsXkVSgHmFW6PmYdK9+mTLk9UDShWwFeDM2d1CRnungYZGrKNBaVwPxWo9pOjzGWLYEEGmPSlqAotKBsiZ6qZPvdf8IXTy4udZPgtT4L6TCbCqfbB/9C9dZsU3JfELSshK/XzDd5WXIuD3JBNl5XRhSd7XPimPMJqyRjNLEz33ETXwc/vuVvwv6K1+Dl115AMINXgMa5BMOe5/yA+76dez8jHuGU4vhXpfPA1Ot5VJjomIoDlq9U2cEds4TrsEKnwl5LteKrIVt3H9SCZkhnoN7bOLMm25z1fdCtVZhzrf9qsiK/73CqaZ2QCSZYnUL9PE2FVrcI9UUsjrQ==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by DB9PR07MB10026.eurprd07.prod.outlook.com (2603:10a6:10:4cb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.3; Thu, 13 Aug
 2026 12:15:46 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%2]) with mapi id 15.21.0339.001; Thu, 13 Aug 2026
 12:15:46 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: Paolo Abeni <pabeni@redhat.com>, "emil@etsalapatis.com"
	<emil@etsalapatis.com>, "jolsa@kernel.org" <jolsa@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "song@kernel.org"
	<song@kernel.org>, "linux-kselftest@vger.kernel.org"
	<linux-kselftest@vger.kernel.org>, "memxor@gmail.com" <memxor@gmail.com>,
	"shuah@kernel.org" <shuah@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, "andrii@kernel.org"
	<andrii@kernel.org>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jhs@mojatatu.com"
	<jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"stephen@networkplumber.org" <stephen@networkplumber.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "kuniyu@google.com"
	<kuniyu@google.com>, "ij@kernel.org" <ij@kernel.org>, "ncardwell@google.com"
	<ncardwell@google.com>, "Koen De Schepper (Nokia)"
	<koen.de_schepper@nokia-bell-labs.com>, "g.white@cablelabs.com"
	<g.white@cablelabs.com>, "ingemar.s.johansson@ericsson.com"
	<ingemar.s.johansson@ericsson.com>, "mirja.kuehlewind@ericsson.com"
	<mirja.kuehlewind@ericsson.com>, "cheshire@apple.com" <cheshire@apple.com>,
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, "Jason_Livingood@comcast.com"
	<Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>
Subject: RE: [PATCH v6 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback
Thread-Topic: [PATCH v6 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback
Thread-Index: AQHdIBl4Q0erzo4OIUyjTJghsy2AuLaN9UuAgAB/cBA=
Date: Thu, 13 Aug 2026 12:15:45 +0000
Message-ID:
 <PAXPR07MB798410DDB16464A335902FE4A3DB2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260730114919.658373-1-chia-yu.chang@nokia-bell-labs.com>
 <3ad893be-c46a-44ba-bcb4-8665eeb41fc2@redhat.com>
In-Reply-To: <3ad893be-c46a-44ba-bcb4-8665eeb41fc2@redhat.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|DB9PR07MB10026:EE_
x-ms-office365-filtering-correlation-id: d8a3f5a5-0a60-4c97-38d7-08def9349a9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|7416014|22082099003|18002099003|56012099006|4133799003|3023799007|11063799006|38070700021|6133799003|4143699003|10067099003|921020;
x-microsoft-antispam-message-info:
 kRSSdH6EhUDbLTMRMIIZ8am42R+l7TRCEtpVKRxsPZMfcfSJwmcpcNZz4TQOnKMgi10B+otipi1PiyS9IFvgEHQp1pONCj076TVVQRTmt9dn3r89bIMVTnvyBlih4A7xafhRCbQpL2cuLrKLGhx26YGk04R5wxvIecLL9UK95t/TDqDUav4+efCDGd2616d0OovKpMKTtJEP61fsgePwrhNkFzhp0nfffN1nJxkLremNI4wTREtNb+CZDTYlaMdVBnoRwN4qWZJa16Cbfn4cfvdZDO6gVZ8irX6TflMGgDPhU9/T/xWjYz3y5Qzwgmk1KPxetJmzgPGc263cr0aKY0SV5POl7wHmuUi2KVd0737m3LZS8NfkBPaVzXOaI9PSW3+jUCjrp9cnRG3ge58mb7Ut0U/pyo3mnJNK5tGz7ZsTEX4R0oMFlihlUUmP0j3MrSeJxIAbGg/sS8yErCzD/0fqdZRCkPvP8McAKIj5F5GNhplDgKYhUqbxIhDYobpJbXNVL8oLIq3n3+1MlqTe6wsjx6ajTB266TSxWOOTtAZizuJXZUe0byeT2BRD4TGlVlJZJf8jgOw2RgtV5Imc/+FqfBzv4RCybXFZnmKGsEVftakJqfqdAToKtAsStHbWt/fW65pKWHd7ctr7l4PvapG2TVcco1UN7ybdqW/TPifXtcC/0tPlht6+TZcayjoI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(7416014)(22082099003)(18002099003)(56012099006)(4133799003)(3023799007)(11063799006)(38070700021)(6133799003)(4143699003)(10067099003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3iJtmprULz5neSV0fCZ8FWccO6R5cXl2Tyrlt+2jwfURimc5EIIO8r9ofh?=
 =?iso-8859-1?Q?n4nfzDmf6wfLDcQifKCGQF9bZsMaOTLtG4JWxys84UXwDbIJo1caYDVIft?=
 =?iso-8859-1?Q?PUMW2a59npVoX4pv0n5GbIv4xaU3PTydfUxi72Mi37/w35e7FI0pyZ83gH?=
 =?iso-8859-1?Q?N0AHvc8cxoxGQ+MgJP7gThYkcI40KBM2WC/Y8RuF0iJcdpJhRDfJmBGQLg?=
 =?iso-8859-1?Q?sghmept3q3mNAw4pBeDURIFZCh8mmtvSJEHAOEm4Novdwzb6gs/RP95RTV?=
 =?iso-8859-1?Q?218Il2hREJk7WSC9UN6H5sOB25Lb9YQdgwuUCn5PNp6xLD08x/oyySbP0s?=
 =?iso-8859-1?Q?Y8T5cuKJfxwiQeIVtaayeNwtzrL4tGmmGEoUPRZejGb3+7Ir3Js9sBfP5k?=
 =?iso-8859-1?Q?6nZOwzNxH5y9SPUC7eeLzCqLOclo7lhF8N/hHLG6GqdgQKOlin/23Skwbc?=
 =?iso-8859-1?Q?N++X1atVYrN9YSOMiqoTuHP66km6BFRhbUzkIq8YI/G72NDt1IIge5p13F?=
 =?iso-8859-1?Q?j8jhBlxkfQVFYa4ejcH1gk8/N+uVfnSWaiJa/ADdmG/oBJKeEf/3EEFXfD?=
 =?iso-8859-1?Q?Ahz7ein7i41sAOYLxfnzZU++PX4pv8kbXiR9Lu4XtiWYVbyKIW4BT735v9?=
 =?iso-8859-1?Q?LJPrnoGTcJRQBVBFR8TwSYFdreOOov5Z8iiTN3L5PYw3ZSLpW9v9IV1hFM?=
 =?iso-8859-1?Q?oTYPuLO1oS/jta6eBRtgVej8ribcTbQ5Tx+0Gep2tjjr+afPORsgwe8x4t?=
 =?iso-8859-1?Q?6NJ0yWm8EtfMkyo8ks81WnIYcpgYreOWZo52mpCe2p7pFtYnym9O3YJh/+?=
 =?iso-8859-1?Q?cqyERPhIAQ8dGBWCONJAZGZLWRadycB7t2QHQ6SmcaFoALr6iVJwo8Xocq?=
 =?iso-8859-1?Q?lZp12cyzvmAppbdD/FNOPCmyP1ZXXxwRfX4Xa058kNC2nhvOQZCMedslQ/?=
 =?iso-8859-1?Q?K8DYkkLL4f9rCzg15Ybt1vVDZVv4bOe/Fxo0I/j6CitzOTY6oKXywNIJL7?=
 =?iso-8859-1?Q?MlLTdEF7jhc6xpJBiH/B6OCwaX4Be3vAlmMkyWCsSTzkAyMw6QXGpCoe3V?=
 =?iso-8859-1?Q?SiGm+7hj5k9sTmax2tB5MaiVvdxpePjo8h4VZgFzMCb87qkArVAlWvdUmm?=
 =?iso-8859-1?Q?xApzpeEp1wixbnLQjVXVeRYi5fLVeX3SeJOL1aeD1VNzABXgpMAr5dbU27?=
 =?iso-8859-1?Q?hZnf7sixyJr0+p+rB3O6eMOfO2dXSVCBWQc1vnO4fRK1Zv3FEVLmGO9qdQ?=
 =?iso-8859-1?Q?X55uJMxroy2onVG3VMic6RJJLH7d4w54vfQ2iexMDmSAGJAk2kfP7QWydI?=
 =?iso-8859-1?Q?23oCws1KEMniSDV0mXVxXYD+LAi6Gsr1D2I0hGeoLlp6QYAegeYKUrRIno?=
 =?iso-8859-1?Q?+YDdombX0K1cfmS1sTwTHIcfJgWqpbzU82QJDigHcGLY47lbLopHaoE+kJ?=
 =?iso-8859-1?Q?CBv/sl6nmg4OHsNZmphzsxTzUtFKjSYJ86y36/NLpDVjtKVrwqJ+ODHM/1?=
 =?iso-8859-1?Q?YGrv0Ruz1whhX0yFSENFjHlHLGtDAbr0QaYG7SS3dNcRr+lrS9OBhElVb4?=
 =?iso-8859-1?Q?D8HbfOWaQpubGfg0empTVqDL78YfvPrxvp3FHGTn6NYu+oyI928jNzicKl?=
 =?iso-8859-1?Q?N+5C+l8NwYMa4GPg016bRQh4t2vLiux6j/foeTEXvaBbUCmc02juMHVexY?=
 =?iso-8859-1?Q?c5YGOQ1vpEdWHJhaFMcK9NzpSbuVOZrKTcEJyVKLYmgfI9wvI2C7x5W8Sf?=
 =?iso-8859-1?Q?JmJRHukRXRLKg1xAnjSkjfUSwB3xBuk45n6r943ZMRcJM+hqAzATSdkBH1?=
 =?iso-8859-1?Q?rmR2vwMcS348LryR0wrDQLoD63t/5Yc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nokia-bell-labs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR07MB7984.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a3f5a5-0a60-4c97-38d7-08def9349a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2026 12:15:46.0348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G8MgH/tcmnle71kdTxZYHtZJHN/nZyO+0idqISHglruSwDh6FEYgI2Vhb484G9Xv/9I+FYykwjB+pkfEzXVKc1zpBbHMFsyoM5N++oHm2RrLGvKE/IVkc6NKO+MJQbb1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB10026

> -----Original Message-----
> From: Paolo Abeni <pabeni@redhat.com>
> Sent: Tuesday, August 4, 2026 4:09 PM
> To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; emil@etsal=
apatis.com; jolsa@kernel.org; yonghong.song@linux.dev; song@kernel.org; lin=
ux-kselftest@vger.kernel.org; memxor@gmail.com; shuah@kernel.org; martin.la=
u@linux.dev; ast@kernel.org; daniel@iogearbox.net; andrii@kernel.org; eddyz=
87@gmail.com; horms@kernel.org; dsahern@kernel.org; bpf@vger.kernel.org; ne=
tdev@vger.kernel.org; jhs@mojatatu.com; kuba@kernel.org; stephen@networkplu=
mber.org; davem@davemloft.net; edumazet@google.com; andrew+netdev@lunn.ch; =
donald.hunter@gmail.com; kuniyu@google.com; ij@kernel.org; ncardwell@google=
.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.wh=
ite@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@erics=
son.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; v=
idhi_goel@apple.com
> Subject: Re: [PATCH v6 net-next 1/1] tcp: Replace min_tso_segs() with tso=
_segs() CC callback
>
>
> CAUTION: This is an external email. Please be very careful when clicking =
links or opening attachments. See the URL nok.it/ext for additional informa=
tion.
>
>
>
> On 7/30/26 1:49 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > This patch replaces existing min_tso_segs() with tso_segs() CC
> > callback for CC algorithm to provide explicit tso segment number of
> > each data burst and overrides tcp_tso_autosize().
> >
> > This change provides below impacts on BPF struct_ops users:
> > - The callback is renamed from min_tso_segs() to tso_segs()
> > - The signature gains an extra u32 mss_now argument
> > - The return value semantics is changed from "floor value passed into
> >   tcp_tso_autosize()" to "final tso_segs value", bypassing autosizing
> >
> > As a result, BPF programs shall be updated, because returning a small
> > constant will now directly limit the final tso_segs value instead of
> > specifying the minimum value passed to tcp_tso_autosize().
> >
> > Signed-off-by: Ilpo J=E4rvinen <ij@kernel.org>
> > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Sashiko nipa has more feedback, that looks relevant to me even if it's ta=
gged not hi prio:
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260730114919.658373=
-1-chia-yu.chang%40nokia-bell-labs.com
>
> /P
Hi Paolo,

Thanks for the pointer and I have a look on all comments.

About the first medium comment, this is indeed an API change because we wer=
e asked not to introduce an additional callback.
Emil reviewed this from the BPF perspective and agreed with the approach.
I do agree that the callback comment can be documented more clearly.
So I'll clarify in v7 that implementations must handle mss_now=3D=3D0, and =
that returning 0 results in the caller clamping the value to a single segme=
nt.

Regarding the second medium comment, this version does not expose tcp_tso_a=
utosize() as a BPF kfunc.
The initial goal was to support in-kernel congestion control only.
If BPF maintainers think it would be useful, I will expose it as a BPF kfun=
c in a separated patch of the same series.

For the low-priority comments, I agree and will:
- Change bpf_tcp_ca_tso_segs() to return 0.
- Change EXPORT_SYMBOL() to EXPORT_SYMBOL_GPL().
- Move the READ_ONCE() into the fallback branch.

Thanks!
Chia-Yu
