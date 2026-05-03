Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022108.outbound.protection.outlook.com [52.101.96.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B04738836F;
	Sun,  3 May 2026 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777826455; cv=fail; b=KlPyR+fdWmQw3ub2wsJli5vClgJkWzDxhcPPLW0eDYc75mtbg1IigmFUOU6UVj7VRcXS8FX+KliVXsyV1cVl0pp+nrL9+Yb4pn3X90vWgVFhJK1fPprHcO57JBsbxDtj4mrCpY9AvtSAlybvfS6Em+L/OmxdurC+r29iLb2SnDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777826455; c=relaxed/simple;
	bh=OmxCLnoyf0C6xDBapcr4Vv/TNLW9FvZmI4iPleGHKvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AKndTP3spMYCo6LtZZ3RHum4tH/RCK/iCJI5o0Daupp2B2Z0txpBsJJckz/evkLzyLnclqGZkhHKnU7/KF7auwjIyzXmeCV/HIzuDE+PFJH32qeSsaAdQay3m5XY0hXlBt9gfxYAF7Ez0bQ++JtOW1cmwWXcjfvc8iA/ddOezLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6pt6kSHGpLbWLXGlMFH3F5ivhLI4nlcx7Q0XA9k8CvMdENfa9ZKXG/+Oxou+HlCW1Sk6+xUm6tM2qM+dimakMeyBh+z8gyPVHCKCQQ0vGvHVhJ6wPhSVnznD1Rt63RcDLUKWmbPYMzzdcRXIUnjhffdhyLgUbNErMx6mcoJjC+1YFoTaaZLoqUxkpjTf79D+TqQpB4nLnLUWGVIDrNE0XanZMnCY2xOEDpiBfSdV5th70TrUs9b27VN7WgbtD/V1dVSN9iOz7JvIWU6N9GuXGdm6eOs/OIoN7iBiWkJK0NOgsDC/YvPzhH5mrMj1zS3HCFlJIlYQSXxnteje/x2tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eqi7m17OWipymC0bntWPq/tDGuvCjxxO7hY1SuvD0Qs=;
 b=C8Y4G/CDxdi5cciN0S5HFlwjSQyaodHKli81dCfb6OJRclsldS/lNHTsN4qSCwuo5plACLcNjE/9bxObduVFSRsAua4yqruJMYbp8kilM/js1lCzu22SYfAdZgRCL3rr70Ne4wlJnKlUngTaXV/hVu+AsJs4AJMCd+47Fsd7vVkH7XvY6e7q+cq9tmiEl89ORGSCRa2UDYIlFKT5P5cB4xkaYAw6kzdcBO1YM9AW5dFNlqt5eCyaZg0J+5czE+f/escCJeO7gOl4KKc+ENMS/NIYmA2T5yJCogEImz3qjBCrcC9yQ6oFcmHKh4C0pLZh9VPe8cYsIv+B9ZHGn6xPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:70::10)
 by LOYP123MB3535.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Sun, 3 May
 2026 16:40:50 +0000
Received: from CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf]) by CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 ([fe80::de8e:2e4f:6c6:f3bf%2]) with mapi id 15.20.9846.025; Sun, 3 May 2026
 16:40:50 +0000
Date: Sun, 3 May 2026 12:40:46 -0400
From: Aaron Tomlin <atomlin@atomlin.com>
To: bot+bpf-ci@kernel.org
Cc: corbet@lwn.net, song@kernel.org, kpsingh@kernel.org, 
	mattbobrowski@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	skhan@linuxfoundation.org, jolsa@kernel.org, martin.lau@linux.dev, yonghong.song@linux.dev, 
	mathieu.desnoyers@efficios.com, rdunlap@infradead.org, neelx@suse.com, sean@ashe.io, 
	chjohnst@gmail.com, steve@abita.co, mproche@gmail.com, nick.lange@gmail.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [RFC PATCH v2] bpf: introduce TAINT_UNSAFE_BPF for mutating
 helpers
Message-ID: <zb2xagnwzslhbdxtiihwzmahzs7kot3k6ekv4r42kkcjuwhnss@gvonok2daq65>
References: <20260503153730.541685-1-atomlin@atomlin.com>
 <43650b10f9e10b3ced4dbd4d99ae3c7e6119faf0edb8dd99b2e99721e52b23dd@mail.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ub2kcbumodqb5w4c"
Content-Disposition: inline
In-Reply-To: <43650b10f9e10b3ced4dbd4d99ae3c7e6119faf0edb8dd99b2e99721e52b23dd@mail.kernel.org>
X-ClientProxiedBy: BN9PR03CA0664.namprd03.prod.outlook.com
 (2603:10b6:408:10e::9) To CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:70::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB3523:EE_|LOYP123MB3535:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f372c8d-f8cd-4f55-dda7-08dea932bc00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	AzbcP0h6YTcdMtxQSu7DiKzYqhxskV0OcokJTz7OkDjYAZsu0D+rLaSs6HxSizQXhrQOPuTQBgfiWCrXeZR1kOdRvVzZpChhQqjBoufvx5PcLD26RLaabqk2xNoIJnHHVKN1mUcw/vSijBNuv2l8aa+1Sm9Qal3G/eH2/EjGa4nMX1TETZzFfEDkAOBHOmJENzs5wKLPHhh64Hb8h7zPoULvrS0KjcgSd0HdLkLKRlMwOnxaulMdLw9F76JVkkQ4A41gAvRXj3zMV5VGP74X/gyVxVwHJTCXZbKI2Zu5eblK5tccsdoqWiHyVkkxFBDzwbypybSyrH+ZuPGRGM3zJDTmQSkG0A5vV+GQONpPljZaV5PXqMTmpcLXF1y3qfdmvawfsUBNS8hfC8QXYl8PIBO+orf+IUGTMm5TocSBjPZHiIwcm5KOSLeUTH+VrxfYzxf6Qx5rrhl9z0jiSbRkznWSEAU/4RZRA7icthXuQ4/epaPhKzwl2ZCnasheQ72K3MOsifit9nPHv13QAuJFrP42CaJZtRgqhURbn3EYvKq+c9E/zCd+8337iwIip0OOkYJ22mMWuv+xjWMnMm1Tzw0uOK3DARk+O8JS/jhuvtmeoPYrCIoZ3kL9dptJf+1p9K7QNBP6xgnjuC++chB75LSe1fnT58dmhNmC7+/gbxBz3VAk/XYQ/RlL+qt4e4/k
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WjZ5RHJ1TXNQWCtYeEpDdU9DcXZYUXVJYTBqV2UyVDhsMUZRbGhXUjNXTWVV?=
 =?utf-8?B?UjFRTkdieVVmUU4wZXlacnRwMndPRFM3QWxlV2ZXR3JoVkVFZWhzdk5KWHpm?=
 =?utf-8?B?cmRLWHFXN3hHYWNpN2VmdE45Q2wxdjFxeVc4cEcwd3QrYWNxK1lxVFI2ZUZC?=
 =?utf-8?B?TkV3dUNxUjZpSWNnVmhOTHpPS0VCbWdyMk1KbHNwcWxDSEtNWGQ1aitLUW1p?=
 =?utf-8?B?MXR5Vjh6OGs0cUZZam5aRlIxcmQxcmI1ZW11TWtYR3dLMnM3RWlIallSaDB5?=
 =?utf-8?B?RERRM1IxbDlxWlNWVHpJbDdHL21vaTRNYlNYUnpxUTN5Ny9yQWROQkRCMDIr?=
 =?utf-8?B?TnQ4K2ZUM1huWGtFY2o3aldwVU5yT0xLc01qS2I1NFBtZWM0QmRveUxSZGUv?=
 =?utf-8?B?TUVVcVcyRXZBMlBrYm5wdTQ3TmIrZWZMaDhoSFA5ekJ5NW04aFc4dytIUjZq?=
 =?utf-8?B?SmhVakZHcis0UkxieGJZRW5uZXkvOXB4VGhUellhZDBJblF2OUNjc3NtRGtv?=
 =?utf-8?B?WEphNTRwN20vbWExV0NqY0dCM1RaZmYzWGZVQWRaeUUwMVM2NU55ZTEvR1RP?=
 =?utf-8?B?dXRwZ1h0R0lNeWdLVkQ1TmprcURldWFHMnBCd1VYcENCMlN3cHBuU3ZOSzFM?=
 =?utf-8?B?L1lJTGxBeFVCQWdLV2g3WFU3TlR5a0lLNFNpTlBRV2NYNFYzaVBUQmE1QXd3?=
 =?utf-8?B?MDBlS2w0c0VnQVpyaEttZkJ3S1lLdEc0YkhFUnZOU21HUGJwMWgrWVVLM0k3?=
 =?utf-8?B?VUhEWjZ2WmdFNFhPZnNTTXVnNjY1dFc1dWNxY254bWF6QWJZdFYwVitzMjNa?=
 =?utf-8?B?Mytka2huendMaFM4TWlYN21uUkdtNTUrSzZlUm1iSnFnRFpqWWlFNHVENURy?=
 =?utf-8?B?S1lrcmFCRGxTZkJLbURJYmVGWlRVZVNJWTJtekxOdlFHNjY2Z2VsdHZSRSt1?=
 =?utf-8?B?QkRXdnhlM2NDMkpsajVaN3lScXJZUm5CN2czMEFXOEpXRittRDN6dVpiNThR?=
 =?utf-8?B?RHdIVlJrYUdzVExCdjFVdEY0Zm1lbkdBVjZETmhwZEMxbVJwM3lSZ2Z5RTZt?=
 =?utf-8?B?MXJKa2dORDBVN2YrVk9NQTlYNThSeUQ5aWc3NXJjenFNWG9IMmFwcy9ycklU?=
 =?utf-8?B?K1R1MmJvU2JhS25ZL2srVTYrQm1QMTA5d3JISUVJU3YvN1h1SVB1d2htWXpk?=
 =?utf-8?B?WHI4RTh0Rk9IS3J4bVpiNmQ1Yi9HVHc0RFZtazZ5N0RoSnRZSHhIL3Z0MXg5?=
 =?utf-8?B?Q280VXdKR01ENzlsT05oRUVkSmRJVFFFNitLS1NuVHU2cXNhdGhNbFY3YWFs?=
 =?utf-8?B?ZXFmMithWVZ3YVprREkySzhrZUhoa2ZXd2RtYVlxTzVrRmFydkxDSTJlQTl0?=
 =?utf-8?B?a1QrcDR5YmVjNXc5MVpXRUF0cDlXYWZSTzc0aWFEeENtV0NzLzJZVlBzTXNB?=
 =?utf-8?B?ZDFMS3ZRQ3FOb2RuYy9xTExlUjQyU1Y3SGQveTVyZHNXMitmSDI1K2ZqaWRG?=
 =?utf-8?B?UUJlaDBEZTVoaGkrdmFkd0hoUmhOWldCL3B5Q1hEVGpQcjhFWkFXbEIzSC9N?=
 =?utf-8?B?MlI2NG5UVkgzQ3Q5MEhOMDJFc1pDTXFHMEhwdit4cUZVM3RPblcyUWVibWxV?=
 =?utf-8?B?OGFOcFo2VEdkd1U4OVQ1VmVJWVpmRm5va1dTNXdib3RwenovVXhxQnFSQ2hO?=
 =?utf-8?B?T25LQlQ3c255eWN4Sy9la0hoUGFHNXdxM1ZCdFd3blA1Tjh5VG5CRjFoWDZu?=
 =?utf-8?B?RmlaQTc4Zm1ZWUlLZzJMLzc2Q3J1ajI2WWhSUEh5NjJZcmk0c3ppbDhqQ3RL?=
 =?utf-8?B?ZkpPOFJid2Z4ZGVkZlZHOHNYdzB3NThXWWZVUHozUUY4MFdleWs3NHRVRVpG?=
 =?utf-8?B?MVlhRVduNDlKWDBRY0c4cmFZeFM4WmlXbmRtUWZCS3NPeGZINmhIVDYrZXdO?=
 =?utf-8?B?bjErcE1TVVI5Y1N6aWU3YTJZZDhoTVlIaEdacVQvV2J1dm1SRVhLSk5JNU1V?=
 =?utf-8?B?VVJlYVhzaW16NFk2UTFERGdYNHJNUkxTQWJjUE1NS3loNEtSVG83c1Jjbk9H?=
 =?utf-8?B?cFRNbFpaSDJ2VHZqSWQrREI5T2dtR3I3Y0NqeFdEcUhxcWZHZCtzZDl3TVdy?=
 =?utf-8?B?d3VuK09Nb2pjZSs4aXNKY2xqRUlPN09mek9kRDFPQ3M2Z2Q4V21xcUJWdVBM?=
 =?utf-8?B?ZHBqblp0aHlBSERzQUJkRy85RHd1OUpCdWRRaFc3N3g4T2JtSmVneklyT08x?=
 =?utf-8?B?NmpESTNMMlZuZlFRdC9VQkdLMGs3QzRxMUlaMitxWHdpcGlsUmQybHR2dzVy?=
 =?utf-8?B?MTJ1aytkandTZnZMSDhqVWlOb3UxS3kvV0hLZEUranJ6RmM2eW9Tdz09?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f372c8d-f8cd-4f55-dda7-08dea932bc00
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB3523.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2026 16:40:50.3620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/Y+Kba234j9bjSOdloGsSkviyGBn5acgbSa6oPpUYrN3bxOH8FqJigEldeMTa2zDfs6HvY2gGWXFoEOqnRAMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB3535

--ub2kcbumodqb5w4c
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH v2] bpf: introduce TAINT_UNSAFE_BPF for mutating
 helpers
MIME-Version: 1.0

On Sun, May 03, 2026 at 04:13:01PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentat=
ion/admin-guide/tainted-kernels.rst
>=20
> [ ... ]
>=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 11054ad89c14..e2060c6f3e13 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -9906,6 +9906,14 @@ static int check_helper_call(struct bpf_verifier=
_env *env, struct bpf_insn *insn
> >  		return err;
> >  	}
> >
> > +	/*
> > +	 * Taint the kernel if the program attempts to use mutating
> > +	 * helpers.
> > +	 */
> > +	if (func_id =3D=3D BPF_FUNC_probe_write_user ||
> > +	    func_id =3D=3D BPF_FUNC_override_return)
> > +		add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);
> > +
>=20
> Is it possible for the kernel to be tainted here even if the program is
> ultimately rejected by the verifier? check_helper_call() is executed duri=
ng
> the verifier's static analysis phase. If the program fails verification l=
ater
> (for example, failing the GPL-compatibility check immediately following t=
his
> code, or encountering an invalid memory access), the program is safely
> rejected and never loaded.

Yes, the above is true. The check should occur in bpf_prog_load(),
immediately after bpf_check() successfully returns.


Kind regards,
--=20
Aaron Tomlin

--ub2kcbumodqb5w4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEeQaE6/qKljiNHm6b4t6WWBnMd9YFAmn3eokACgkQ4t6WWBnM
d9ZmvRAApiJmVB6sqE7YlFd+hrUei6vnriMhkX0Uqp5YJ4XWGg95PVbR6d7Pt9ma
tfZXIa9EdMjONdlZD6umtzYXfwc4d0mMk7ENXm0mwZzQebjND7UWRWj9D9xNm1Ur
AeYHQv0WTbzhJBQD1d2xK+tGICMv9XfqtT8lIQ5wDWdhTI1Pwa1NEsL1OLLod+ER
ofVhRTjkLtIqrff1Z7Of4oTTnsOSeKMP1eECtmyZ5qhXudxQ93lhUSE0EbLyJUNr
LRk+RnOqWSPG1JiM+NJo/HBJcvO5QU99AoJUR0c+H/7iQ8bSvjWqRVvrjLXOn4NL
ylvmw4E+/hzKijYrW8Ye/wBmFWAyECXi9OhBOP3UI01E265qoN0E+LBPJyJNjBsm
jdfWnnEHutegWnA1n91Oymnl5o75hE3lwYsG7VADBk6MqT6x7krMWhb2/5g+jSf8
KnMwDxxGGmEEW45Ry5WEWcCN3qhA2PKncPGwh1x5g7c1Kq/TU0Pcdvo7Q4Egehkv
MKO/tnXLtdkl2XcjepKY5N/2VIAX5hzIa3WIMZ6IGnsS0nIcoUhv3ZGCBnkJB8s6
s6glJEi1O4gG6E4MkQANKyiZ9EMyoCuINrZSRBZv9cSiZm54tCol2ZSbb4EkjdDt
a9flrRsOdXSYyIXnJAlrH1obg5UkeyjVCNmXIfzRM0HePPoe+A8=
=xs1e
-----END PGP SIGNATURE-----

--ub2kcbumodqb5w4c--
