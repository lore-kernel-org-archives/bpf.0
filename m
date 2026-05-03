Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020105.outbound.protection.outlook.com [52.101.196.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CD326F476;
	Sun,  3 May 2026 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777839265; cv=fail; b=Z5ZEJkx1LU7FACeL3kVKJBEwix9bXiokiVkkjlPl7rPofrzUS15naSga1LT15cfwIrdFDdYjzteFmZM5mVuwtyDRhCCZVLZJ187MQzlIsVV/+jAhXjhaFAJjlFbbBXwp4pF0Y7CQiqy79iiEFcl5Jku9EnOzSufkk6nXCwuscac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777839265; c=relaxed/simple;
	bh=chfWLW7469BBLkcDtHWA5ItlAtEtsqWSSKmScKRXDZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UUk3quot+3fUfJvyqEqEvR4qAoPeta3KSzy7L39A1hfKuJ0LzMTLPilOMMAs3BImM9T67UUg3CusZqEuN2Zym69G30o+vIeVGL+2imXJG1NROemf/OH7Aqv7IW81AUKNP9J5QWCoYIcGVvyNIuJ75xlrEcgZq0tSTXcWYIWRfMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.196.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+JcAlUJKuefBp17LhxcKJ3jsK74TBVQcppbZGWqVDhTyi1SPMlQUZBNuSg/Ov7iQ50x1mwEINqfl7jfDAkJi1VpAb2+u3RzTX8FtIi59pigIlXmuFGjFdukSa1N4/TW9OmyIb/Y9MwfRKktoetvuyzo7dBKmQcNRdVSUkQtshib3FrbqljNT5lG/J50nI9ESQBIDpZXy/nnRDetF5qa+Z8n7FdJvanZ8UCzC2x7YiRP/eDRtLVTfs2BHqBxgN+KgqpLPss3gBOiF8bpnwFCiXWT2rgn6LsVvTABqIoaG8W87OGWCt8O9bTepkqLTDY5FsGiO1kBau05r9fX7+6tLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sktZs1orfv2MB4RxqrIXA1EUzquKkhDRBpSMZqTCows=;
 b=jDkwSfY5YOHSUSN78ap3awWU/qz2tQMpbN7qBc/X1vTEHiZ4mfTRp5aATBtCgDbOupg2Ec3p8gaTR4aYuBe3kvMClS1974GheJ0/+oyjc5w18rwXNA+93dqhHQ8mb16nTlY0PcUbhgcpRuTHt4UWw1/eFkLEEuiJhjfTK0LGZ3Xjtuu6TB7w/TXHOtkA8Kr9iksXcy/bfqhCmYCymC1SzKvQcBwOaajfC5A7XCN5YCbr2vk22/WwJ7shNsWnUzgT+BzYWSMQUAXram7t24I3pGag0WOHGBPpdt5XmVAXnX1a8a0jAlSLOjyOE03ALEh33B7IA1+HJnaEP25t5HTT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO8P123MB7889.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:3dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 20:14:20 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sun, 3 May 2026
 20:14:20 +0000
Date: Sun, 3 May 2026 16:14:16 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Randy Dunlap <rdunlap@infradead.org>, neelx@suse.com, sean@ashe.io, chjohnst@gmail.com, steve@abita.co, 
	mproche@gmail.com, nick.lange@gmail.com, 
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v3] bpf: introduce TAINT_UNSAFE_BPF for mutating
 helpers
Message-ID: <n77ttuihdrigv7motoo2le3s644ppztey2qq3ia2t5keiblajn@juqmaefinpgr>
References: <20260503164700.548164-1-atomlin@atomlin.com>
 <CAADnVQJ5fatNF4auH+a8E39zWMfja3rm4BM_xGcTnLX8uuCQ9Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lt2bmbgaiuaa3ge5"
Content-Disposition: inline
In-Reply-To: <CAADnVQJ5fatNF4auH+a8E39zWMfja3rm4BM_xGcTnLX8uuCQ9Q@mail.gmail.com>
X-ClientProxiedBy: BN0PR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:408:e7::16) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO8P123MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0fc670-e8b0-47b1-18f9-08dea9508f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099003|27256017;
X-Microsoft-Antispam-Message-Info:
	Mh9FnxIfBp1wgb8cQ7kT7lpC9Hp+3OjySPKpXdMN/mfa8ck29XIeZKGrOImtJYnJnPHIcfmfPGGlavYmf362b6WqnXJrhXB5XTDM4+79Ef+Wg/0d2gLDfcfFWp73I7OBqQ1G4zYMnAmskv4f4J8ZH8aqmcF6lh/wvCyweCaWPzavoa4jzR2S+wtzk9vlhg1d2CGZk0UsrQbs5KtQxEH7LYpZN4aGs8EGDu4qifhmP4XjNK56lEeRpC/VuWdvbWuwFUzECYFJUNf5XPMGAuYw9Ar2MXlyoJEQiN2S5evIy2LaVkf/CELnKsgB9jV9+UzkROzP3GeOQgm4LBGC61Jj1SwhmzGaH1o3m3tRJb/dDJiepisr+efHs/qcHBB4HSxus24564LuOF9l+XmwUJcK6ElLlglaSITGBCEvv2zTN+7PX4+Nk8BvqoUYq6YPgaTQKzA78cg4TuH/S+opp617y6d2cpyd6leEI7Q1gUs0OjWYdurtMK6OUX9i21roLwKQmER7AiRAYvQbdiiWorTgJpKjqxZP1gz/GpMa2t+plFp1uNaHOFNwAliWJGV9ZKYTbV8Nk1/TVWZ1qa3DuWK1Sn2tfQhWPE95DJ9UE/1ZNABhON6GKRIkCjjFAgdy89f0GR0kK+RalziY9eEiJyyCPj/KS3C5kVXfn7JcAZHAbWVrNrlZNiUR4uHOt6863cSKso6OaVf3xxveHBGybvwux7YAPs2joF0UZBH4YA4YuKKHtoKgL+SFdp3AUlmlwFu9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHRFY05aWHRoNHBjNFhMM0dvdnUwTkJIb1FaaTlaSUVqUlhiRkhkYzFoTGEr?=
 =?utf-8?B?bzFZOENsMUdaTm1QY1VEL0o2K0plMnBLQ2JxTmtUOFJCd09SelUwNk15Q2N0?=
 =?utf-8?B?dFNxWmxjaWx6aHRuNGZtWjFQdW96dzR1ZitZKzNiaFJwN3BKZitEaDdUd3hO?=
 =?utf-8?B?MC81N01aYUx4QkpMU0hpbllnNWFzbnMxTEhUVWVQTlhVQWxmTFdEK250c1lo?=
 =?utf-8?B?Q1l1ZkwvSS9HZ1I5SVhtUFZEWEUvenhvZ1pVWUpMdkV0NTR3bXBxemJyWnNI?=
 =?utf-8?B?MlhqSDdDV2hFVXQ1LzJqS0srN0NHSDBTUWdib2Z6dU9HcU4xYWNzSngvMk9X?=
 =?utf-8?B?WkZSTSt6NktDekJ1c1pER2NHbmdOMXB1SkEvc212a0MyVUwwMUZxZUYybG55?=
 =?utf-8?B?MFJJdEJLMjV4YnZiK1J4V3EvUE9KMUREMHBReGE3VEljcXlJZVJWM2liWW93?=
 =?utf-8?B?bFJINWF4bFl2VEdiSEFCOWZtUkxsTFNzdXc2SHBwREdxUC9Ed1ZyZG9jVkhC?=
 =?utf-8?B?N0pnYVRQV1RGNzRncUVCZkRoeTM0Q0ZVQkZ5TFRDdU5SM21YT0Zndy8ybmw4?=
 =?utf-8?B?WEZua2ZHaEhVNnpudnRvbmRUM1RJaXVHT2JyZFQyY2RudjJCV2g3ekRGZG1v?=
 =?utf-8?B?R1k2dUc2T3pyYzVFOTNIMWlmckdjK3E0WTc5cnFiSGgwN0VOR2NCd3YrL21K?=
 =?utf-8?B?d1ByR2MxbFIrVXdMeGlQL3drTGV5TUZGVGg1TCt5TmZvZlo5L2JUYkl5VWUv?=
 =?utf-8?B?YnFDTFI2UnZwbnBSRHdPaW5yaXNOeHJVU1UvYmplTCtvWEVtMkdFaGxDR2Iz?=
 =?utf-8?B?Q212ZjhiaDl1NlhBcWkwVjNrcDBqQ0dJdHF2TkZNOFlhVmpycmpsUU1neXVz?=
 =?utf-8?B?SXY0T0E0bkVXTkVrYU9nZ3NkT0FwVjl2TTg2akk5eFFoS2tJZTJmV3JGQ0pI?=
 =?utf-8?B?SWlrdWU0TkJUTVNBZFNpNU9qZW5UWkF4Qmw2eGRVdkZiR3VZbHZuVGpxUXpa?=
 =?utf-8?B?L2VIa2pXdGdXc1ZnWTJPTXRldktpYVlnc3FiNkZiYnhtY3lHb3NtUUtsSGY5?=
 =?utf-8?B?QlNxS0c1MGxTUGtxOEp3L3QvWi9XQkdXanFYdDlQY1JEUXp0M1JzVVU0enl3?=
 =?utf-8?B?N1lEZld2WEFnVkgrWklzRzNrV0pkZmJSV2Y4T20waG9pS0JFMUxlNUlqK1k2?=
 =?utf-8?B?a0p3Q253V2pzRjNZQnc3a2I1TkozUWFSVTFzSjh1VVhpMHRoL1gxdVhvZzBl?=
 =?utf-8?B?eEoySFhvNW1tbkE0ekh4aFI4RmIxZ0c1RzJTL2lpL0pmaEw4RUJsVi9UUVI5?=
 =?utf-8?B?VWpYT3ozZkZpTzloamwwRmZObnVaaGZaU0hkaDBWQXlGZFZRYzdQQXFJcXdx?=
 =?utf-8?B?cXV2aEpGNWNSMzZ6SllzYjF3cStXVmg3allvbFo5QTc4TDRTTlpXYlNpbWs1?=
 =?utf-8?B?U1VJVGhzeW1yL3ZZaWtVcC9QTEdSdGtqdzlmUk1MbnM1MkIvOVExVThjN1dS?=
 =?utf-8?B?a0ZSZDlKWGVGZTk4NVdwUjl0L0VjVW1icmQwU01aMm94aWYvTzM5OThrNHVR?=
 =?utf-8?B?YWt1bjV5QVlNVnd3OHhzd3U1YlpMZENPMmZyS21lWjFiclB5aGNxRmpOMUdF?=
 =?utf-8?B?VjM2R2lQQjNvOW90SkpQYUE5Nll1RmprYVBaN3lyQ2JmQ2NITmRwbUxUb3Zp?=
 =?utf-8?B?VzJDKzMyM1ZMNzJlNVFaQlhZL05vaVFDZUM1OC9QUDhUbUNYYnJPTFg4S0lv?=
 =?utf-8?B?SkZGUzhUMmdqR0lWV1U3QzRyejhIQjNnOXAvQ0FNQU9CNzB3cmVvdXRjNExI?=
 =?utf-8?B?T1hxZDk4QUFqbFU3WjNORmJrdFBiemVTVGhqR0ptMlYvMHJ1OERZSXdNblEx?=
 =?utf-8?B?TkJMRVoreDdiMzdUcFB0cFJvaWk3RlpUWm1jSS9IWktSc240eVpEMXdPekJV?=
 =?utf-8?B?WUxKWXJLaFZzbllwZjBOZksxTFo4QXppR1RDVTBqSWNSSHovWW5UVWdjUlYy?=
 =?utf-8?B?UVJmZC9CYVdhUnUrNWxuUldmdHVKU3FzcWhSeDh4Nm8wd1luR0FFUXJVaDVy?=
 =?utf-8?B?MW94bm5rQ3JGQ2RvQk9Zbnd0Y1Q1SXMvWHlJOFF1aGVQOXdoOEhaVm9nVUh6?=
 =?utf-8?B?RllkNWdvb3NpaGdiK3VkU1VNcytLdlNLR3doa0ErRENnM2c4Vi93ZGltaTNM?=
 =?utf-8?B?TCt1NEtvVGZaN1pmYSsxREZxWWtXTlA1SjI2WXIrdTlzZEtvMHU4RU1RZTlE?=
 =?utf-8?B?Z1YvbGJ2d1J4cXRVR2o0NjZSSjcvckUzNDByV29mN1hwQldMTlBPYTBuUWZi?=
 =?utf-8?B?UWJEY0pZNTRJZ3o0clQ0TGVBZE5TQ0IrYmw0bWFPQ3hhR3cySWw4Zz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0fc670-e8b0-47b1-18f9-08dea9508f8c
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 20:14:20.6472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FWUxj2dGbYYf5iN013SuYW5b0iQxme3itHH/rmZ5kk4fNJBXzKuu9j99RVahW0aOZ2iat36BvAdL+kBOhhj96Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO8P123MB7889

--lt2bmbgaiuaa3ge5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v3] bpf: introduce TAINT_UNSAFE_BPF for mutating
 helpers
MIME-Version: 1.0

On Sun, May 03, 2026 at 09:51:49PM +0200, Alexei Starovoitov wrote:
[ ... ]
> > +       /*
> > +        * Flag the program if it attempts to use mutating helpers.
> > +        * The actual taint is deferred until successful verification.
> > +        */
> > +       if (func_id =3D=3D BPF_FUNC_probe_write_user ||
> > +           func_id =3D=3D BPF_FUNC_override_return)
> > +               env->prog->aux->taints_kernel =3D true;
>=20
> Nack.
>=20
> Please stop this spam.
> We're not doing it. These helpers have been around for a long time.
> There was no need to taint then. There is no need to taint now.

Hi Alexei,

Fair enough. I will drop the entire series. Please ignore the v4.

Thank you for your time.


Kind regards,
--=20
Aaron Tomlin

--lt2bmbgaiuaa3ge5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmn3rJMACgkQ4t6WWBnM
d9aeQw/+KlH2/OrE/xs/dB2AMinkjHVJcE3O3PsZeiljn5Bqs5R4pGzuctW86azu
mnzgKUJogmdV7gIEDH28GwUVY5/krBwlpx4vJawAnkMIGcREohHU+01MWZPiX/U+
fF6kaAqN7SinbXAfDacW9zp8hb1uXhpcBDSjpugsPSlN356naSTeHK3FrUdNvJd9
6REMtQa4XTizCNKu2G3/yJ4wYV/y/SVv+7zXpxTIqsDPlcu3lbRc6iOJauvotDpF
iEPaoyejVaS8cq/9yljySSJkK6gxBD3N2MqcK/mtHMsKm8Y1B1CIR1fauvvPrtZf
E85IxcJ7OU5KoRfhFQNaHftlYLrZiyfJlSTsz79fX+xXH8GBy6bay2Z3YzN104k3
viE9l5kl8b8CwzEnoD8gaHt0uPCr8BZu7t4MXQBa0KC4i1z0j7FF0QxW7oem30zC
HhS1Jsmvzjf0xNjuwUAyg+SUu0Xp8KhUgLw3YHFGA6o8FlWyItvMLsIBw949trAz
G2XWx0Qf8d266KYC8jO1Kl5fJactYAnekgHgvnfBVumQvKfxLj3Yjk3LSO8AHqMH
jdrNNkE3M07dGh7li9cb7ybbiF3ITmPbd12M7KLo87/AkxpjgZR5VKEXomWi2TZS
XzV5Fp2Wdho5kGySO38eLHITcz+yCrQI9VkSxB6wO9DPUDMH1iY=
=jknt
-----END PGP SIGNATURE-----

--lt2bmbgaiuaa3ge5--
