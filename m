Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E783DDDC1;
	Mon, 27 Jul 2026 08:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785139327; cv=fail; b=jN6MTYqXv+IQU0rI0DpTLlBwcQYw3yXmMDRYWZXZBIaxZYExGPlbHSVwsiYfpwcNPA/36jXSg13eDKpHDFMQfVwZRECVoPO+PP9ggbXXJ2Uw7EVrS+DWrYsHmgqlej/hmo+Itk8NpHCAbh7Xs/5k3zSvTiPP9zowik9IhKdIDqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785139327; c=relaxed/simple;
	bh=+92j7YQaLcKeew3wktY5u0MCInCtXGyItZEE6ehRS1E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CIgZHY5VSUbW6CjKz+pPB8aCa45kyW1S7VdMyiVKOEQLmHNul1WuPzlG5XaX58J3QKY993/UA8+uu/YyPzbT3osfLUHLgvc47kaHP5A2DwwCXYMW6QUkwItnnIJrmo4lYf0bCkw8AMViUq/n+5msP1f4OKWjqmIqKPF43hNKmM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com; spf=fail smtp.mailfrom=nokia-bell-labs.com; dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b=G3V9dViE; arc=fail smtp.client-ip=40.107.159.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia-bell-labs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia-bell-labs.com header.i=@nokia-bell-labs.com header.b="G3V9dViE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pb2+BCvtJicZcE0ecnmnyDH0m4HDeXThJRJMnJIS9ELpFdm8wdHR+ep+svu8bKxNgTepc802QinGbps0siiMYWBsr6bWUE4ecZUwjxVeRgX5j5Z4MgMPhY2wCgYE6q5NPupRvbaA2n5LFwQdCPcuJbmq5knA/cGPk/aAAhv12pL6g9QMrKXqhH3JWcM0HLktg8Xjfq7I/UzCOChZTayD5FxieB2YqVC8s+54YwisB11W6nS4XaEMDmBF3HN29hCFdmDpiGkpOhgoEyIZu9hoYQhMhmbETwtYvbBubhC7aBweLH5afURkgf7S9Sda/qa3/0gynEl1WzZ91P1+uXSlNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibt40xemRHHQwPleg2Pqn6TK8pIOAknkGzHPqZtU/RE=;
 b=zCMpTvVQWkegPor4J2gY5AXy2fHSR8e7ip87TSRnw2KsZr0Lfx2QWClvYY3l1gv1I0X0xdfZxJu5pOnEWb7oPZ2raugGcvzNMMfQgqV3ThgKs9OY+9Ib60enwHr9ZDo3i0Ju3wFuL8oJEKWGKjqHHJsWcT3w9/IAzhvTzqmQIwxxlrFfjZohC4A/5hWYZcKDijBqAPhAOhqPnDcYrWkKeKlATy2FXG7qTeCQ3nKi53jW6uJ7+QvBfLthgHTrFylEHAAD+N3YQcGKdHZ5yauRLIRy1dZ+eFlCSCQng6/jdBAM2zERbN6Bx28WT04zRMeZZ1pCs7ElneAMN90ds9Qg7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia-bell-labs.com; dmarc=pass action=none
 header.from=nokia-bell-labs.com; dkim=pass header.d=nokia-bell-labs.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia-bell-labs.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibt40xemRHHQwPleg2Pqn6TK8pIOAknkGzHPqZtU/RE=;
 b=G3V9dViEGsFl3hJTPzmHPnPmstsfWjhw6NsM9id+R0b8tq+tkByRRRKuzVbDG72xX2GZEy3j0Oe+o68t7SzaHEGKN86PVKcp3KkDK3xikk5VoMZ8RsTV8MM70R0U0cDXV50xKi7dqgd1ARQYENyhdQ+3/to27QhB3rXSDj84zrvOk6qLnANm4eWPkYtkmU9vPtwWK4mjXmZO3aobIhneaPwQiPo2AMYmEPlWfTehYcJqts0e3S1q6K+h4igQfO/U2WvP/8KwuSxLpu58ttMnsUeOp1udFPjLHyacEwfYnEJcgJj2Opmm+AEi1KWD4AtxUlytn9uFm1t3QVE7FAZAAw==
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com (2603:10a6:102:133::12)
 by GVXSPRMB0017.eurprd07.prod.outlook.com (2603:10a6:150:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.9; Mon, 27 Jul
 2026 08:02:00 +0000
Received: from PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5]) by PAXPR07MB7984.eurprd07.prod.outlook.com
 ([fe80::f708:4bd3:9987:b9e5%2]) with mapi id 15.21.0270.009; Mon, 27 Jul 2026
 08:02:00 +0000
From: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
To: "horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org"
	<dsahern@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "stephen@networkplumber.org" <stephen@networkplumber.org>,
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
Subject: RE: [PATCH v4 net-next 1/1] tcp: allow congestion controls to
 override TSO autosizing
Thread-Topic: [PATCH v4 net-next 1/1] tcp: allow congestion controls to
 override TSO autosizing
Thread-Index: AQHdHTZJY1/W9Z6bNUO515FzwIvCqLaBAEAQ
Date: Mon, 27 Jul 2026 08:02:00 +0000
Message-ID:
 <PAXPR07MB79842FC5D44F3964BFEDA505A3CC2@PAXPR07MB7984.eurprd07.prod.outlook.com>
References: <20260726193802.397321-1-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260726193802.397321-1-chia-yu.chang@nokia-bell-labs.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia-bell-labs.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR07MB7984:EE_|GVXSPRMB0017:EE_
x-ms-office365-filtering-correlation-id: 2ece3eb5-b6d3-4d8e-adf6-08deebb55651
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|11063799006|10067099003|56012099006|18002099003|22082099003|3023799007|38070700021|921020;
x-microsoft-antispam-message-info:
 BGOoy25Piio4o5VZmuZB+zcjks0GegiFGfPSqlhacE1iQqB6PcRxo5YCFTAf/FjbiQTj6hTQAHzNKRVPPTPV3YAHK186VUK2YlKE8qFP2381olJFLJf0sy+nugR1/PvM/EQbdgahocTfk1lAPoATYOwWlJcFrGzd1JSnCwF+i1z7iJSB278VSZ/bfuknxCCsDr3GZVHYPSQMCvhdf325+a0npsTUyj2dysErXXJnChMLiI69iiAZ6t0+RrOWQumZ80rdo2SY0aZRcXPQMWK7I5L29X6rwQo27yFBZ8UAF9KynSR+qqIRb9OG8At61SzKZUPWgr4HQpSbP3HXoc+gUqNuyiflctmv1vZMQ8iAbo1YqPaLZfAKMY0WuJFyP/2y8fB/S9QlXEz7BGmWd/qetbV/CYYntivo+LLTMlWw5uhFVvoBr6fNaHfHDdISDMvba6TBAv9xdRfh4Zc5tmHFNsiMcVkRLJLu3HjHOaa5aFYYPG139hriiNEuwSyfKAl8RpXXeJ4ycjhhd1hYNlZ5ZaM/aYL4TBtkTKg+7T7tv0DqBXnAzc9VFQaRNtVCFnHko7T7RxThO/bXdsK7v2bHOGOIH+wBZa0vpJ11/KZbq6YSwYk5vaWhQHT8m/ksRfDPV8s9td6z9V0u5pZE9CVQm4BtQRvWsaxvsOokl5TYvnn22Kk/E9m6Sdv5NeqtRpo1bpKMG+bN8OA18ar2lke6F2LOtILFvyO1aDyuw/rH0EAlXsJL9tfgu9FC+gRKLM3R
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR07MB7984.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(3023799007)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1MS8VUT789gftkLpwcInznBD6sBd9sEZw1sLho/l3vyM3afIEGJtdQWiof?=
 =?iso-8859-1?Q?Rqx17GdqIrZ2RCM+OLANTKxYyvj44jLy8j00zLhT7vuAKnUzsrYRAk+nfo?=
 =?iso-8859-1?Q?ZbWM0Bh+oQhIwqtv4FQm1rs03qCeGgVCr7bRXElre4Ko1jbg5gPtRddNVP?=
 =?iso-8859-1?Q?vYIiHZ6QBGqcgGO5vpgExJ6jsw+/AJXVwrzaiIChZouHU+3AwwCWNjRLUW?=
 =?iso-8859-1?Q?qvpIOZ6bNiA6jKDv+l4w8dJiIRJYs+RC/zsNzvs0olookQziQBsbaVeuHG?=
 =?iso-8859-1?Q?l2bmBc8SlDb92YVwCI/W0WFIfS0hYp7HdX95+y2oAZ/kmx2r2d1dZe8ayR?=
 =?iso-8859-1?Q?1jCzG6yWgLeE470Suv7UDkVTEi0n5E7ydiapex29R+qKWPyeh9yR1tS+vk?=
 =?iso-8859-1?Q?8zKAbsdCvjWzzrG43NflVcs40vXoV5/PtVwRXCK/DdwokFjAapP1B3kYHm?=
 =?iso-8859-1?Q?2CuKrUCBP7livJ1Jd7lAiQRkDgFPmtMErGZgkPqg/V2CBzxHuzNaYvi5rV?=
 =?iso-8859-1?Q?ugoaDTnPc7EOxCisRJCPNAELqYo6KmFi2rVQXemR17ad0Abd6tM6hT3ayZ?=
 =?iso-8859-1?Q?In9bIqkr6Lrph7hD8ir+++xaaJprkajCMg/JmRuotYt5SVe2IA7GmqBPAv?=
 =?iso-8859-1?Q?hlnvag86kqCgUImtZtvoKf2d/4p6hCIE8konRtAI4Ck8F7YuE/J+0rjoy5?=
 =?iso-8859-1?Q?n0LBcJ67BdbrbNqviOkV6jTLvlkJXggGo22Q2ySL5mctioxnDWKLMwYhbt?=
 =?iso-8859-1?Q?Vbp/OiqJlhEAxmb7Whv3OpceqYikaEhi8QE5zUbaasiTz9XClzRhYp5DS/?=
 =?iso-8859-1?Q?TvwiuV4gvlH39HFTnaE5GR7wy2j7lmqYzhsFYngmwnjbrrlQ5+Wd9IKGeP?=
 =?iso-8859-1?Q?8eomY0zshOi0FRl8yobPxfdzEmQcVQ7tHIqDmi16yL6FIPILF7TpAFBpsL?=
 =?iso-8859-1?Q?mHVuiMZDp+oKkOuz0kXEd4ILKmnmZEmW9hfiZPXLE8OdcfEinrCL1PmEjV?=
 =?iso-8859-1?Q?oUAo5jgnd64cK3ckjZFxsDSO+/hbLA3aj2hHEz3cFtWqFU1dOmq3cBOZ5M?=
 =?iso-8859-1?Q?ajefzsWoZSQiFnkVyf57sAj+yCJL5c1EfDRqmwVkS60vBP3OUx0Yg2b0sv?=
 =?iso-8859-1?Q?lESWPq9z6d/x6iDnAwd87JCRbzLkHQLQzln1rqNgIrN0vsDYmEIfVZjMFU?=
 =?iso-8859-1?Q?NkYE2LA01dxxvgw7GymUX8ysUyPKD37dpnyL7+YZeXjdYi5zKlOdlsl/Sc?=
 =?iso-8859-1?Q?4EIBnBQCH+LTXxibx0DEUgh1kP0krY1yTaPIYgCn0oSsdXQ8rovuVLjRVA?=
 =?iso-8859-1?Q?5z379io6fsYThwU/QxJ+HLCNjBb/UHXeG4fT4nY66VRqlhqWO4k0UrZem4?=
 =?iso-8859-1?Q?W85vSe8gK4JB7fvtPfq3RUafSQfuEUIAjFCAfxt0bYTCRi9389JJz2djEA?=
 =?iso-8859-1?Q?fYdH8AIDw6hEqTh7EE1fkrvTUvRbolTtgt3oPonQlkPqpuDx7E3SoVqUfX?=
 =?iso-8859-1?Q?LJHw+pfRqx1EFhQYIe0bG4m/1KXyIaxNivwYyCfvYxguIH4vB1tzNldrNT?=
 =?iso-8859-1?Q?y8LkzdKG0QpRJ06VBCyCSfQQi2Uojn/dPDneE1z6FdHy4bYt8rQ6edVc5/?=
 =?iso-8859-1?Q?JJniHakYnXFHMORAycJs9gwDY+xkbSpiUO2bNHw9O5SZZuNpvWbrBnB2Ze?=
 =?iso-8859-1?Q?nRhZKMEWMacq7Me7dBOmrK6ZKX97e9vuym6FvgyxztaVXyuvV3WAO8HNQF?=
 =?iso-8859-1?Q?I7HSOVhYkb+sb20TXoSFcTiMTdW5mKsVG6/qi1zSgYgUrLFpeuzPqS7P1V?=
 =?iso-8859-1?Q?MlvDG3y00j1UpD5ronQmYO3xyxwUgDc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ece3eb5-b6d3-4d8e-adf6-08deebb55651
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2026 08:02:00.2895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZY3/+7dZeJDeE7VL5TV0zojikWXlUMGow1AGU6sWLpoDLDeO1l++seZnrVDnDQoyl7NiigG7INfsRe9c/KdYDr6amoKSoJlLeW+hvyDpRT7hTZHpcIGQ8J9qeDDrIBm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXSPRMB0017

> -----Original Message-----
> From: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>=20
> Sent: Sunday, July 26, 2026 9:38 PM
> To: horms@kernel.org; dsahern@kernel.org; bpf@vger.kernel.org; netdev@vge=
r.kernel.org; pabeni@redhat.com; jhs@mojatatu.com; kuba@kernel.org; stephen=
@networkplumber.org; davem@davemloft.net; edumazet@google.com; andrew+netde=
v@lunn.ch; donald.hunter@gmail.com; kuniyu@google.com; ij@kernel.org; ncard=
well@google.com; Koen De Schepper (Nokia) <koen.de_schepper@nokia-bell-labs=
.com>; g.white@cablelabs.com; ingemar.s.johansson@ericsson.com; mirja.kuehl=
ewind@ericsson.com; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@com=
cast.com; vidhi_goel@apple.com
> Cc: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>
> Subject: [PATCH v4 net-next 1/1] tcp: allow congestion controls to overri=
de TSO autosizing
>=20
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>=20
> Today, congestion control algorithms influence TSO sizing through the
> min_tso_segs() callback, which provides the minimum number of segments us=
ed by tcp_tso_autosize(). However, Prague congestion control requires finer=
 control and needs to determine the final TSO segment count directly rather=
 than only providing a minimum bound.
> =20
> This patch introduces TCP_CONG_EXACT_TSO_SEGS flag and extends tcp_conges=
tion_ops with an alternative tso_segs() callback. When the flag is set, the=
 congestion control algorithm supplies the final TSO segment count directly=
 and bypasses tcp_tso_autosize(). Otherwise, the existing min_tso_segs() ca=
llback continues to provide the minimum segment count used by tcp_tso_autos=
ize().
>=20
> This preserves the existing behavior of current congestion control algori=
thms without introducing additional callbacks while enabling future algorit=
hms to implement custom TSO sizing policies.
>=20
> Signed-off-by: Ilpo J=E4rvinen <ij@kernel.org>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  include/net/tcp.h     | 16 +++++++++++++---
>  net/ipv4/tcp_output.c | 17 +++++++++++++----
>  2 files changed, 26 insertions(+), 7 deletions(-)
>=20
> diff --git a/include/net/tcp.h b/include/net/tcp.h index 2c5b889530b5..82=
cd82a19ff9 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -1283,9 +1283,11 @@ enum tcp_ca_ack_event_flags {
>  #define TCP_CONG_ECT_1_NEGOTIATION	BIT(3)
>  /* Cannot fallback to RFC3168 during AccECN negotiation */
>  #define TCP_CONG_NO_FALLBACK_RFC3168	BIT(4)
> +/* Congestion cotnrol provides the exact TSO segment numbers  */
> +#define TCP_CONG_EXACT_TSO_SEGS		BIT(5)
>  #define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
>  			TCP_CONG_NEEDS_ACCECN | TCP_CONG_ECT_1_NEGOTIATION | \
> -			TCP_CONG_NO_FALLBACK_RFC3168)
> +			TCP_CONG_NO_FALLBACK_RFC3168 | TCP_CONG_EXACT_TSO_SEGS)
> =20
>  union tcp_cc_info;
> =20
> @@ -1361,8 +1363,16 @@ struct tcp_congestion_ops {
>  	/* hook for packet ack accounting (optional) */
>  	void (*pkts_acked)(struct sock *sk, const struct ack_sample *sample);
> =20
> -	/* override sysctl_tcp_min_tso_segs (optional) */
> -	u32 (*min_tso_segs)(struct sock *sk);
> +	union {
> +		/* Used when TCP_CONG_EXACT_TSO_SEGS is not set,
> +		 * override sysctl_tcp_min_tso_segs (optional)
> +		 */
> +		u32 (*min_tso_segs)(struct sock *sk);
> +		/* Used when TCP_CONG_EXACT_TSO_SEGS is set,
> +		 * override tcp_tso_autosize (optional)
> +		 */
> +		u32 (*tso_segs)(struct sock *sk, u32 mss_now);
> +	};
> =20
>  	/* new value of cwnd after loss (required) */
>  	u32  (*undo_cwnd)(struct sock *sk);
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c index d7c1444b=
5e30..0de27a87c39e 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2278,11 +2278,20 @@ static u32 tcp_tso_segs(struct sock *sk, unsigned=
 int mss_now)
>  	const struct tcp_congestion_ops *ca_ops =3D inet_csk(sk)->icsk_ca_ops;
>  	u32 min_tso, tso_segs;
> =20
> -	min_tso =3D ca_ops->min_tso_segs ?
> -			ca_ops->min_tso_segs(sk) :
> -			READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
> +	min_tso =3D READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_min_tso_segs);
> +
> +	if (ca_ops->flags & TCP_CONG_EXACT_TSO_SEGS) {
> +		if (WARN_ON_ONCE(!ca_ops->tso_segs))
> +			tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
> +		else
> +			tso_segs =3D ca_ops->tso_segs(sk, mss_now);
> +	} else {
> +		if (ca_ops->min_tso_segs)
> +			min_tso =3D ca_ops->min_tso_segs(sk);
> +
> +		tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
> +	}
> =20
> -	tso_segs =3D tcp_tso_autosize(sk, mss_now, min_tso);
>  	return min_t(u32, tso_segs, sk->sk_gso_max_segs);  }

Hello,

I see this commit is marked as Changes Requested; however, I do not see any=
 request yet.

Could anyone let me know which specific request it is?

This commit updated our previously submitted v3 https://lore.kernel.org/all=
/20260630120145.286497-1-chia-yu.chang@nokia-bell-labs.com/ to have no impa=
ct on BPF.

Thanks!
Chia-Yu
