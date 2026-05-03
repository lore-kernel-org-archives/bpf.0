Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021088.outbound.protection.outlook.com [52.101.95.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B0C294A10;
	Sun,  3 May 2026 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777821688; cv=fail; b=DxPc3Uq2LPHLc0MvtHzphADa2+Lmr9Eomh6wmz3/93X9xeEZTuekE6W1iRqn75EbLZt4Q2ZMemBcldSqQKKXsmnljXZsUzNqwESCBTyFaD8TD33c+35/nTjXtKFEVp/yyqfcms7TQr3WJmuwXmrv/Q5SZVZ7a2mzqGdLet6HgE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777821688; c=relaxed/simple;
	bh=zE4m/kBpiTkrE4P8zpSaW2pS9MgkxcMhAto0qwMOANA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ey47TFvhp4wArFGQa4mwRolYB4qYrSb8qcIbZ2AnjG+SQSVq6utg/9JhPSlJwnAbFGAyVeUdNs9dp8FZ9VI84aHHQ0fzljaQK1f6C8UwzgaW5o9JA32nAp4ghWZaUzs3Ev2ekj6PdEjTMz1wfruLd82AzUnU3OTdRy6cEGMBEhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/hGfqf3vJV0j8WTRl7CdZW+2fVU6y731OJSGg9XqPK/YKJjSl12Gwyc/toqUEssAUCcNgsyqzAZQjrmEH6bmgCtbGXZFq17PjA648EYemBRMZnltdbZVkLBpa7ayN+2i4Q37zsw5AoDjXN9pjMR2ANo7TysOhm/FxZd3N86gqEWY3Q/bDQjupuKdokda9AkAHiPDueZnCjpiCZGOYNAd3dVVcDf+H5QdSvpkXECRziSqYO/x6abYUiwnHnqPk5QgDuIHGV6LO5gq0tk/kqL5+7sFOdo4z0JQQJVt7Al3VejbhjKeyNRob8+MOyuY7i43Mj4AggqSWNSsYHX3ZougA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahCXzR5lYEEplkOD4ye1mUbtNaK8pF9UyeNhmXA9jkI=;
 b=e3j0mFOU2zwkUl7NTfkfkgGgEZurHh+PRBIMmVQkyU0Uw97ozNeWuOhU8ansbw5w8FUebWWCx0fCsRN3urNLK8fISrHpgQ5XtEhsuRhP5IIfmEoTOQClIFOeCh9vHJgDTr+g27fWsnAlcsZZtmOt1M8CRhFP+W6KuNzYa/fcfD8ZqF+xvxJ1VegCtAXwsz9OKw7C5tCMYgECFzCDYiVdrDrRbT4QxOMckU0RFVzDKHPeXa1Q2GG1bFIsWHMuU2ThWtY9snaUZ9EUAKyG0opKlXB+RL6NuxoVOYexPAso/h4wuNz3PNFIp5lb7kagerbK8qCrIIQ4XULfjiSnc8dPMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LO2P123MB7019.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:329::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Sun, 3 May
 2026 15:21:23 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sun, 3 May 2026
 15:21:22 +0000
Date: Sun, 3 May 2026 11:21:18 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: bot+bpf-ci@kernel.org
Cc: corbet@lwn.net, song@kernel.org, kpsingh@kernel.org, 
	mattbobrowski@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	skhan@linuxfoundation.org, jolsa@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	mathieu.desnoyers@efficios.com, neelx@suse.com, sean@ashe.io, chjohnst@gmail.com, steve@abita.co, 
	mproche@gmail.com, nick.lange@gmail.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC PATCH] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
Message-ID: <nfwk43nu6ntqzpylhkmqwvep2kqb32y53aswfs6o7yb65wryhg@cl46g3hw2pyv>
References: <20260503035220.520479-1-atomlin@atomlin.com>
 <78ecdb5fbbc2bba3e5d0d001c499c9011ac2e5d7dca29f60b0736c4f70c29d9f@mail.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gjadjj6egzx3gocb"
Content-Disposition: inline
In-Reply-To: <78ecdb5fbbc2bba3e5d0d001c499c9011ac2e5d7dca29f60b0736c4f70c29d9f@mail.kernel.org>
X-ClientProxiedBy: BN1PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:408:e2::33) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LO2P123MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a17ae4-79ca-4a70-53f3-08dea927a261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Gxb2bDPvk3Hxp+ViJcxHEcFs0dfyc2uac4gq+UgP4eqitjCzdwTMCPkVzHnEGKOzxOgXvs126PFWGKo5QTI5xkSMErwnkBsZhJo6Z1/eZBANEGDfT7DjFudmvgaWtryi0C7ALpSIm35eUU0vnypUh3O6i77I8WgRf0YZ5CWrTThpqyEqP9oANhuur0LQ4KN0MiJM6VtcVrV7dKOIvX0qMxYsAl1U5IWtgNXhk8q+b3tmsaLKNZNDjTJ94fTokoDV3qjXkFakH8nTeYdWjpy+k76U0ps2c1tll+rZUzLHeyalYtbugt0KRu6ilEmv9KfNiQvFNDKbhyIWXMUn+eOLi6i2wDKmQYXSvweZ42vCjFR8pQmq8haVGNQr1rkKquuT2oXugnA2HnUY1UOeM+9LFoPBZAZNbRkPUkXhu+cS5KYdKTs7DGkqkBXh/g+6+QHxJM6XqqSTUoZN2qHJwKGv2ccz/VBxj4bK41C4vCqk/yKvkfNf54tW+w2jaQTBCvAqtwacljnlh3ETVJCGHv5jf8ppGjfpxXhzAjiCh0lmRLZmVZIMJYvlT+n6MwDPjX2IF4JK9maf8bKurOrZE3iWRA2xdgETgb+FydC/yDkwdKf2evpgGaDFkAuq5U6U5SST8aSGbddp8+G0aU3ZvFgFDGQSljlDn+BDTaVZeUbVXhSt/1/i8j574dK9LCucr+TW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVByYTc2MEhMZDRUL3o2R2Fuak55QXA0bFI1NHBwVFIxNDdYU3ZJam1iZGdj?=
 =?utf-8?B?RzhBekNVc3JBelN4eFIvR1BuTWxJTFNkQjErTzJzWWtwb255RDFacFdKVnBl?=
 =?utf-8?B?YUNsT3Bkd0JFeDI5MlpNV0lYZmNkbll4TWw3ekVRVGUwM3M1M043UzJ4a09P?=
 =?utf-8?B?QkZrRmpNeTRsWlhDc3hYU3lVZlFKYnBybUJLRFNpKytta1RxTTlzSGhpK1Zr?=
 =?utf-8?B?L01Pc1RQcWk0MktwZW56ZVBHYVFRWWZvOXlqNHZxVTh5Z0tBU2trNjlMMVlu?=
 =?utf-8?B?aUlhTTRBNVFEeVU3WElwN3I1bEIyS2pDUm1UVXhIMHIyUWQ1TmpWZTkvYjQx?=
 =?utf-8?B?SERRaTk5SWtuVlY1bGRySU1xQll1RHBOcjdjRCswdWUrakF6bkU4d0VlOVdK?=
 =?utf-8?B?SWhnV3V3ODIzMVUyK29RKzZBdENRMlFuR1VYdGdXaENsblNGTzgvWHFyNnE5?=
 =?utf-8?B?YjJuMDR5M1ZTNFFFbjdNdFkzTGxXUjh1NlNudGZma0NWYk1ESXNJNGxQY2xD?=
 =?utf-8?B?RHZtekUxU25qa1RVeWw3VXRFNjNHbkxUdWdsbEZTMjVNUFpHbFJiRDZabmZQ?=
 =?utf-8?B?UVN5ems1MWg2Z3dpVjZnVFNYY05OYnQ1LzZPTW90bjEwMHk4cjlUTC9EbXFU?=
 =?utf-8?B?SmxPRnA2YUx6blFxUlE1NHg0Zm12bDcyWVhJQVhzTC9IZ1hrTXZyWDZabDdX?=
 =?utf-8?B?S1o5L2ZNSklWVWR5OXBxTzIvQS9BK1hjNTluenowRWRQZzArSWZsZ2lsSk1l?=
 =?utf-8?B?dnJoSXhJM3VSeVVvKy94d2dVelprazBFbzcvZ2xrSnBtL3dYZVZhN05mWkhn?=
 =?utf-8?B?Y2FBNnlucWg5ZkJiQ3RJMy9jbm45a3RxUVVFUGkzL0diMU9Ydkc5QVIrVjR4?=
 =?utf-8?B?Z0hSR1ByNDZrTVNZUUJPVVEzcTFvUkRSaUUwVVYrM0Y5MzRiRlhSTVJhQlNm?=
 =?utf-8?B?ZXRKQ2U2MTg0RkxMUkgxWFF6Z09lUTdvWCtIbEFpb2Q4WWZ0RWJIempBbkFK?=
 =?utf-8?B?N3FQRW1LakNjcEVya0RBbVdRd0RlaVlndXhOVUtvVUV6T3AxOVJmVnNGc1Z5?=
 =?utf-8?B?SEVUaDBZU29iNjI1VmoyWERBRTJKYS9iREdhTFRRVFA0YVRYM0xnLzJtbGxS?=
 =?utf-8?B?cGpDVTJqZ1o4bzhUNVk3dml5QWt3YXVYcU1YSVcraFVhUkJSUkVCVVRPRUIw?=
 =?utf-8?B?SCtYOUJWanowZldPQUJxejZIY1RIUnpPN2Z6dVJpWEdCRStlTTh2ZHc2WnFQ?=
 =?utf-8?B?NHVQZXR6N3JRWUp0OWZwMzdzeUN0WDdCekRCT1RBalJyVDIyR1poUlN2cUJC?=
 =?utf-8?B?M0FJZnN6UHN3SC90bDdvUTlJSTVwM24wUTFOL0JlTzdXZHIxSThjb01hV21M?=
 =?utf-8?B?UTl6VUducGVlYVMxYk8yaStlY0FGMXNvVW1ickVzNnhKeE02dzk5TXRVSHNs?=
 =?utf-8?B?QmphbDIrMmg0SDZLMHlCMUJHOW5NWUpOcFYyaGNCT2ZaTFNpdHhEd3JQNjV0?=
 =?utf-8?B?ck9yT1NEUS9ITjVyenhZbVAzYzlybDRtZXBBMGdBcWpFQnc0amJOTDEyTkxH?=
 =?utf-8?B?QWxSWWI5OGZhSTVleW02Rlhua296UTA2SlN3NUZqNkxieXhFUlQ3OHBNUEZm?=
 =?utf-8?B?S2FwbHNkcU5xblMwMHJ6RFpBRlJPQVd1SHFIV2FEc1F4K2FFV3pCZzE3dFNu?=
 =?utf-8?B?aHlnZHZ6bXowSERySFg4RnVRd1hFcGField1OGJNU0I3SmVLNXA2bDVIZnJJ?=
 =?utf-8?B?N2VCUTM0WFVSYW1NWEwyN2E5SE9abWdBMGx4ZDhmS3ZHdHlmbjNUR21xanA1?=
 =?utf-8?B?c3dMQ01JcTBIczl2d2pZZlBtOHVVR1czT2kxTkJFdm5Pa2RsQ0VHblk0bGUw?=
 =?utf-8?B?ZDQrY2dBaERSVkVSdms0Lyt5blRzai9Wc2E5cEp6NmFDaFhUK1Nrc1pZR1Jt?=
 =?utf-8?B?SDlHV3JEQWtCeTRJSGxNM3JzTGpLaDcwOXFrTkw2ZUNWMFdOdTVRODNsenN3?=
 =?utf-8?B?a0pCSEVUME52VmFPWE9IV1R1aW12N01GK083T2VDTkZoMEs3OXhpWElkSnBm?=
 =?utf-8?B?TjZjQlpYN1BBVXpUMHZpRDIwd3VmWkw0T1F6Q2xTY0JyUjhXY3Irc3MxZmxl?=
 =?utf-8?B?Ym84N3NYMUFoUTg1YUduR3hkZFM0cFIvdlJ5WVhSZEdqTUMzTlE5Zlg5bkc5?=
 =?utf-8?B?WmhtOUw2TUNaUlJaekVZQzVwc0NVaHBLdEFRL3hMaWljMDNHbHBTak9HR0Ur?=
 =?utf-8?B?UW84UzlEQ3lUMEQzczR4RGd3bzVvZXp5WjhJamlkczFMYmtaMWJRV0dRbVJX?=
 =?utf-8?B?UWUxZVhWRktTaUtvS3pmOCtPZWMrWGRDdzBIcjBKTUlJMzhuTUNyUT09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a17ae4-79ca-4a70-53f3-08dea927a261
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 15:21:22.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Xf/m/R4FhCcMZFtvRPQqqyYowKxa0aJ0J4D/HGEPeO9eHwtSf+xsG7g5HxcYBdws2CwOillFDonSYM6rbJTOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB7019

--gjadjj6egzx3gocb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
MIME-Version: 1.0

On Sun, May 03, 2026 at 04:44:33AM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentat=
ion/admin-guide/tainted-kernels.rst
> > index 9ead927a37c0..630f24996e7b 100644
> > --- a/Documentation/admin-guide/tainted-kernels.rst
> > +++ b/Documentation/admin-guide/tainted-kernels.rst
> > @@ -79,30 +79,31 @@ which bits are set::
> >  Table for decoding tainted state
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > -=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -Bit  Log  Number  Reason that got the kernel tainted
> > -=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> [ ... ]
>=20
> > + 19  _/J   524288  userspace used a mutating debug operation in fwctl
> > + 20  _/V  1048576  an unsafe eBPF program (mutating helper) was loaded
> > +=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> This isn't a bug, but the bottom border has 7 equals signs (=3D=3D=3D=3D=
=3D=3D=3D) for
> the Number column while the top and header borders have 6 (=3D=3D=3D=3D=
=3D=3D). Will
> this cause a Sphinx 'Malformed table' warning when rendering the
> documentation?

[ ... ]

> Earlier in the same file, around line 77, there's a shell command example
> for checking taint bits. With the addition of bit 20, shouldn't that
> command be updated from 'seq 20' to 'seq 21' so it checks all 21 bits
> (0-20)?

[ ... ]

> The current command only checks bits 0-19:
>=20
>     $ for i in $(seq 20); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tai=
nted)>>($i-1)&1));done
>=20
> Since 'seq 20' produces 1..20, and the expression uses $(($i-1)), it only
> computes bit positions 0..19, missing the newly added bit 20.

Acknowledged. This will be resolved in the next iteration.

> There's a comment earlier in this file that explicitly states: "if you
> modify the taint_flags or TAINT_FLAGS_COUNT, please also modify
> tools/debugging/kernel-chktaint and
> Documentation/admin-guide/tainted-kernels.rst".
>=20
> While the Documentation was updated, was tools/debugging/kernel-chktaint
> also updated? The script currently processes flags 0-19 and ends with the
> J flag check. Without adding a section to check bit 20, the script won't
> decode the 'V' character in the taint string output when
> TAINT_UNSAFE_BPF is set.
>=20
> The script would need something like:
>=20
>     T=3D`expr $T / 2`
>     if [ `expr $T % 2` -eq 0 ]; then
>         addout " "
>     else
>         addout "V"
>         echo " * an unsafe eBPF program (mutating helper) was loaded (#20=
)"
>     fi

Acknowledged. I will incorporate the suggested check for the "V" flag into
tools/debugging/kernel-chktaint.

> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index a822c589c9bd..3f893d9ea764 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -183,6 +183,7 @@ unsigned int trace_call_bpf_faultable(struct trace_=
event_call *call, void *ctx)
> >  #ifdef CONFIG_BPF_KPROBE_OVERRIDE
> >  BPF_CALL_2(bpf_override_return, struct pt_regs *, regs, unsigned long,=
 rc)
> >  {
> > +	add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);
> >  	regs_set_return_value(regs, rc);
> >  	override_function_with_return(regs);
> >  	return 0;
>=20
> Since bpf_override_return is a helper invoked at runtime and can execute
> frequently on hot kprobes, will calling add_taint() here cause severe
> cache line bouncing?
>=20
> Looking at add_taint(), it unconditionally calls set_bit() on the global
> tainted_mask.

[ ... ]

> Also, the commit message and documentation mention the system is tainted
> when an unsafe eBPF program 'was loaded'. By applying the taint here
> during execution instead of at program load time (e.g., in the verifier),
> could this allow an unsafe BPF program to remain dormant and avoid
> detection until a specific trigger occurs?

Acknowledged. I'll move the taint application to check_helper_call().


Kind regards,
--=20
Aaron Tomlin

--gjadjj6egzx3gocb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmn3Z+4ACgkQ4t6WWBnM
d9YtGA/9HCrj8+eeUd2p1VoCHQ+ZXNHS13JVjdwkpgoxNQI5UPrD7Tozy/WVZE8P
k/lTI3ZPsLzpV3jhP5t1PipnShRSc0WuhUF4D4+hTg2TIax8oHFlvXI12+YkrhLT
Jj7dCiAQG+4ug+RzmIU/dCT236FoSfCu247P0oc2crPePT56CRcrqD6jRe+dEpZE
9lNigyARbhvRKWMxD0XQX9mJdD+xaSnMPKNLhY+r7ORlKVPci5qypHPSewG0G/j0
nyR4PrAVuBThf7jo0lD9cwM5vc0lWIfrXJLFFgEh7g1RvJqQZIQfoTVJuVgaeSvs
oPE3zt/BkqN8ddwn8qGzVRij7ZCjddTIp47rX6XgIpR52Ut/H88jFm5QA+DmhhrC
MDX6pgavJhy+nUUHoAV+LbPvzlQTK1lqXykaE2JWPC2bg1HP/1+B3UHN9X+6jzm4
Sx7hguvJ9lLbZp1DQ5yy+CDI9pz6gfZC6oBZUhBk8OLosx2pyueLrjscJ3XuMShf
/k0etoBwx1j1X6xeMQR4Y0NrPdfrMj6opdoqfqepW+pvlVEzxnJTjoH09v5/3is2
DtYQnlNLue+K2tW/FoxEb3z30BwAhQWgU8sck5GSe+dX3/5UMx5BvFkhT69O4YWA
rriiqoiMQY8355R9UQ2W5uq1y0B8yxZtifypYkFlr7iuDf/YzKg=
=xhPQ
-----END PGP SIGNATURE-----

--gjadjj6egzx3gocb--
