Received: from MRZP264CU002.outbound.protection.outlook.com (mail-francesouthazon11020087.outbound.protection.outlook.com [52.101.165.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30CA404BCF
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.165.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782821335; cv=fail; b=Shsnu8EwqqDaewM4TyD2Ad2zcvXPRpedgjopnIetoB1JPn1WJcz/nMfiEwCbq2ubZYg/6/QwjwvD7d27jEjjdzztkT9V3KJLqAEDdi51H1FqZMkf4U5m7IDnohzuSfMnAyh8LvM2tiqb/YyXZ3SCEAttAeljVHAilHRr1uwOMe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782821335; c=relaxed/simple;
	bh=cwm2pC/LPVSTwwqyPxuzE2FIQV8XgnYc0tOqjTcMZoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OGQCy3hj3XyWZdwtzkxc//xPGHdtP0AkhQSVgA09P0kJ2JUyiB2xNpNkddilOY+sQ5ShkfrI7aP9lVtpoZObD6ij6pT+SqxN/sX1Z8qkmzaNAaJkm0lfzJu+Vtnwt/fXzPK8iR/TLSDli9soSkSwex+JSrHpV8IJ0OJEzNm7EwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=harfanglab.fr; spf=pass smtp.mailfrom=harfanglab.fr; dkim=pass (1024-bit key) header.d=harfanglab.fr header.i=@harfanglab.fr header.b=XJicdlyb; arc=fail smtp.client-ip=52.101.165.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=harfanglab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harfanglab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harfanglab.fr header.i=@harfanglab.fr header.b="XJicdlyb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNGd0/ELOzADsX7Tm8QeN7fUx0aOrYSpCn8mUrFlzOIimR31jLWd+0RQm/dmucUUOfpo4m7y8xHHBPYaslfzEQ7G+U44DGiMiHqwL58ysN3DUSXnMGfpxxHWbIy22AGndDvDx+j02LucknAcluVrchLWW7r2qkHvNxe3xscEcTC1ozaaB/pmYDo0CL/ws/GRLtdWPw8h1ACRGHV2hKTghSTBmwDqvn/UgoPL2jr1P8wXtOAJHnWgWeYJUzGMb+Iuq1w24+4IwIQMHGPxfBM2WGR9MlFF1I71W1373wsY1SXlzpb0BobYLWCI2zWzbBKMZBHBJITsku0lVoC/DG91fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwm2pC/LPVSTwwqyPxuzE2FIQV8XgnYc0tOqjTcMZoM=;
 b=rQZyG0bOUdl0G1QGl2HFheTfSXB6mxKLmScpcNsi1IOJTVta1Pk/ZGLy6bi2mc8Ur5Vqz/tEHqPzVusgcORW4N7LVEGxroHUwnQO3xFaADvBZ2OymHiPKrP9/knIqbJ8BfvSTtlDSD4uHvKlATZyl3bp8zB6h8mtmMsMcjNkEGVuJhdgSRL45yL5zBOieX1eIApU8BVVD/G1WyWQoKlIfkOr7uo9iYoA7tRP0EgZ5ktUVQTHY2rcQg3mB8vkzpoyCMGRHIhUGFSYk9hCn6xjEwiu60YMOugWyyKgwYL77Z7DTPuXRCPATvVtCyrW89xIvZh57hKbn/FL11VLYgwScw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=harfanglab.fr; dmarc=pass action=none
 header.from=harfanglab.fr; dkim=pass header.d=harfanglab.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harfanglab.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwm2pC/LPVSTwwqyPxuzE2FIQV8XgnYc0tOqjTcMZoM=;
 b=XJicdlybABgEzhCsTP5aR9s6Xn09LShlS4BubKViRYcxrGG9gZoo2wjcTFAS8w1pusDGACQ2gs6NIVlqwvBJZGYpAqKQSrwj2ub7/4ayB5MU0+RQoxuLFrEVPktBSomFX9+kOKUAytWGiGljQqQiqGSUwczhFOWGr2vJpYPAsS8=
Received: from MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:28::14)
 by PR0P264MB2027.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:169::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 30 Jun
 2026 12:08:50 +0000
Received: from MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7d89:c984:624d:9689]) by MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7d89:c984:624d:9689%6]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 12:08:50 +0000
From: Vincent Thiberville <vincent@harfanglab.fr>
To: Leon Hwang <leon.hwang@linux.dev>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: PROBLEM: BPF interpreter fallback after JIT compilation of
 BPF_ADDR_PERCPU leads to kernel panic
Thread-Topic: PROBLEM: BPF interpreter fallback after JIT compilation of
 BPF_ADDR_PERCPU leads to kernel panic
Thread-Index: AQHdB8yzqGrNWEhQ9U+ot25Rw6XY5rZWVYcAgACsKdY=
Date: Tue, 30 Jun 2026 12:08:50 +0000
Message-ID:
 <MR1P264MB33143D31DA8982ADB2E0D808B7F72@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
References:
 <MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
 <d255172d-d9e9-4116-9243-975cf4bdf3d0@linux.dev>
In-Reply-To: <d255172d-d9e9-4116-9243-975cf4bdf3d0@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=harfanglab.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB3314:EE_|PR0P264MB2027:EE_
x-ms-office365-filtering-correlation-id: 0d5596c3-1978-40bc-c0b6-08ded6a058c1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|23010399003|18002099003|22082099003|55112099003|3023799007|38070700021|11063799006|4143699003|56012099006|6133799003;
x-microsoft-antispam-message-info:
 3XdyiPeqUnQr4mRMQj0XctzNfGrP6l7tMCmvSTasFT0N+oEZQX3NgHqIMdUBaXmUzWYPfA9MiFt9Pj/fag4YM57Auc6MhNFbLJVfLOIATNR2TN9iOw7akiYp2DxyTur522a9L9R8NA/re27z9RiYmrBZdV0graBRDWg3ta4y/jhgWsy8FVKDxI4HJ6hZH+CdCKZrwga1AbiMe3p/PHQxse7LZnVB7ohRq8KOf8U/w43zNPrsj1Vzuw6cV6bUXsPSdYC1ShVVmxwqnls5RKrKWs1X/hPgsZh2MqfPhpZWwE4qTl2TSwnYUi6sAT3EpaIBDzt+3N7lc7P2ykyUJhD1UwZY+RxekNVl2DMFMTLvLtiwOPCJMIfgPm80HlIwM8F6AtsPQjj5skK9OU3NBFNxwPjQLAvmvwqqoVgoP8ZV2TXpIKA1SCSxOJBFayIfvEJeEYFW88eFrnsqRUqpHlqOeFVNhqmtFzgQbttoPcm5YnN4Y5+u4LwVf7TNLBxAVCFQqGiDQkLJNGHzvXdAfKT+q3oVLCpc0tQ+6S1fpOf/Z6mtMqQrrSk0u21TlGMh5dbbhxgQblscaJNiGbp5YxG6lQZJZ5JsIwTXYdBBTXwHP276SK1SkpVa0p7c5o4MDwb+zZaSaJVK3vK20ELj+gxGTab/YbibPZ29vULU/dhrrzs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(23010399003)(18002099003)(22082099003)(55112099003)(3023799007)(38070700021)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?9Q/d3PQODDtNQ2unPr6HgL20Qaa7QXq9280RBcZ2c+atvZlXDzwYLsdy6s?=
 =?iso-8859-1?Q?VSjAbqbZdOuOiEOgKcX5CHr2oPSWyfgoxFaFr4PCtH5T/6khtpqy3j2BF+?=
 =?iso-8859-1?Q?E1F/WlGb/ex0gvyrHDx22TQQZVP4s2I3R3XsXseFeTkEO5IvtMJbvevK+q?=
 =?iso-8859-1?Q?7eB0scstLrJ1fR9F2geaNW7Qj9FsfKdCO33CWX2YzeTYHCjYs6Ux2T77/K?=
 =?iso-8859-1?Q?9bvX1jMoUs+1O5/x5blI7BztSBijTdNjtxfG5v0tceXWshIYFc7RC8sfhl?=
 =?iso-8859-1?Q?nyEIMBcsPH7BnCEhC51DrzsyLX7FdsoFV6ZhPgLazu8OdbSD1IrNrLYzk4?=
 =?iso-8859-1?Q?HUO2rjHG0ujByUhA8S7q8oAmJWEr7JnmVAlF8gg5miiexBrJ5MouEKZMjN?=
 =?iso-8859-1?Q?JLgs81h43ru4l+6N1NlKu7LeTYb37nhtPnuseH39pEEvIfinkh4o8+M4o+?=
 =?iso-8859-1?Q?9RBiwNB8RNsLxTOtZ8Y6lkP5UVwQipRYGcTCQt7SxNx4uSdglvg58otHIn?=
 =?iso-8859-1?Q?h9Juf6hpKWrFDX0Dmc7SEmaZ8ru0hwYf4Hbz8pFsBzdBtbBrKokYIm6pJr?=
 =?iso-8859-1?Q?U2z/JykoQnbyZVHgOgq9uF8nb6MPvIEzyKtNSITpUWF/z/V6I99bMrKR4t?=
 =?iso-8859-1?Q?4RDMHlgL7ccaT7JvPZxSL+NfO51KuR1cETSDzyxJdeNUldwc02404imphn?=
 =?iso-8859-1?Q?gf4e49q1vAer4uxhNLSUD5pftT14ZI5A/bRfOkba1jEpIMsPVelGN8hter?=
 =?iso-8859-1?Q?OrgJo6qCzXFa2bRI57dhiDkYgrtOc6/NJRw9p+OEcpJIrh4RUUfNzktadc?=
 =?iso-8859-1?Q?smRc28i4OOiyGDfnWe5wwOOjQqJafYBw7ga40I33zcWGbONv0Adt/XhaSD?=
 =?iso-8859-1?Q?GQOpYPBBoIPl4gE5xAanpFZ5TensPRjAK7cYmayVUM4RKgVZHVnnKZBVtm?=
 =?iso-8859-1?Q?8opAV0OzNEB1LsqNSQdU5hyTPJzp7riQKijKtPGgEougzBffUYOmMyvwTz?=
 =?iso-8859-1?Q?haNftyx7vpQe7lkSF4z7kAa8qNYFr99AqUxHeLHBnJx4qdvj/k3dcq8kwp?=
 =?iso-8859-1?Q?d7Kzq22tr2xArPkIdinTZFnuEVTloWeIwsOw8oCDctoB/kV73Lr0Lep613?=
 =?iso-8859-1?Q?r5L5jzLg7Lvq7wQkx4zRM3L44Q92n/IiU/TwS+Y+ijnxZb57Fle2eM0mlQ?=
 =?iso-8859-1?Q?88BG9rtv0fHN+YXF9bSlBLSJshzptC6BF3A60oLZr+wzr/EzUyk05028VX?=
 =?iso-8859-1?Q?4vR1KEh2P2TAJVEHQZ/gfi3tuCWDYlo8l5Yl9InORv1cLlbjaczYgbZ9vg?=
 =?iso-8859-1?Q?0WC4qi6R1MyfimGhDIr4ZAP/5xFfZub7ayPTWQzFVJ/9e1MBO0C1h94RcC?=
 =?iso-8859-1?Q?Z1A0tnJymuURBUTMp5v3NOlOvgoWayfsRAOeg2KmDgVIVfBhITCzUS/wrX?=
 =?iso-8859-1?Q?wF988TA3Dv9XjzaNdzKvf5ItmVl6LU3YP0aL8bLpMIkKFmHbIZM3lj3QFU?=
 =?iso-8859-1?Q?XBqrBDr1hMX0g0zHGm833KP1oKKiI/Nbp77mkW4Nz7qMmXM7Qi13nb+nmj?=
 =?iso-8859-1?Q?u+1IolhYSNnAlYxGJYVneAbD3Szap/TbJnWsAT/EurG7S+qKgCxzCdSbGN?=
 =?iso-8859-1?Q?f6emARknYvVOwwo0Xvb9VkIodRzBRk1EuGzSM9VoKfthtFONAGRrRQf//k?=
 =?iso-8859-1?Q?QcDBLhvPTD/MBtjnyh7GWlDLsxEHXnElUXmdLgIrG71VLj48qc0AZl82xf?=
 =?iso-8859-1?Q?+kI3eykTqOvxVJIQUErHatbOBy1lZzPdu2cALlmq1ED36oBMls4ppgVuqz?=
 =?iso-8859-1?Q?AVzrhwWsl8Amq4LFVn7uCXhvT+miS3PzEbizOz3z6gTTzZkh5cFX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: harfanglab.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5596c3-1978-40bc-c0b6-08ded6a058c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2026 12:08:50.5348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e072cd9e-210a-496b-aa68-c0965404b8f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4cuNGEFHtGHAIYiTyrYFr/tvaPn2Le8aeyeQPxE2GoAyFiupjcTXbt+Cbl2GtvVfuMyF+5ddZU0yW6Eee2CYzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2027

Hello=0A=
=0A=
Thank you for the quick feedback. I cannot reproduce the issue using my rep=
roducer on bpf-next, nor on 7.1.0-rc1. However, as I said, it works on 6.12=
.74 and on 7.0.13.=0A=
=0A=
My best guess would be that a patch like this one: https://git.kernel.org/p=
ub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3Dd3e945223e0158c85db=
de23de4f89493a2a817f6=A0makes the reproducer no longer work, but I do not k=
now.=0A=
I don't know if this means the bug is no longer reachable on kernels >=3D7.=
1, =A0or if my reproducer no longer works but the bug is reachable with oth=
er setups.=0A=
=0A=
To the best of my understanding however, the reproducer should work between=
 (and including) 6.10 and 7.0. I have not tested to find the exact version =
bounds however.=0A=
=0A=
Best Regards=0A=
Vincent=0A=
=0A=
________________________________________=0A=
From:=A0Leon Hwang <leon.hwang@linux.dev>=0A=
Sent:=A0Tuesday, June 30, 2026 03:48=0A=
To:=A0Vincent Thiberville <vincent@harfanglab.fr>; ast@kernel.org <ast@kern=
el.org>; daniel@iogearbox.net <daniel@iogearbox.net>=0A=
Cc:=A0bpf@vger.kernel.org <bpf@vger.kernel.org>=0A=
Subject:=A0Re: PROBLEM: BPF interpreter fallback after JIT compilation of B=
PF_ADDR_PERCPU leads to kernel panic=0A=
=A0=0A=
Hi Vincent,=0A=
=0A=
Thank you for the report.=0A=
=0A=
On 29/6/26 22:42, Vincent Thiberville wrote:=0A=
> Hello BPF maintainers=0A=
>=0A=
> I have stumbled upon what I believe is a kernel bug that occurs when a BP=
F program is executed=0A=
> in specific conditions. The in-the-wild situation is a fairly large BPF p=
rogram that runs as a kretprobe,=0A=
> and the crash happened on up-to-date debian13 computers, with the paramet=
er `net.core.bpf_jit_harden=3D2`.=0A=
>=0A=
> I have managed to reduce the conditions to a fairly small reproducer (joi=
ned to this mail), that does the=0A=
> following:=0A=
>=0A=
>=0A=
>=A0=A0 *=0A=
> Call bpf_map_lookup_elem (1)=0A=
>=A0=A0 *=0A=
> Dereference the result if non null (2)=0A=
>=A0=A0 *=0A=
> Jump with a large enough offset (>=3D11000) over instructions using const=
ants (3)=0A=
>=0A=
> ```=0A=
>=A0=A0=A0=A0 0: .......... (62) *(u32 *)(r10 -4) =3D 0=0A=
>=A0=A0=A0=A0 1: .......... (bf) r2 =3D r10=0A=
>=A0=A0=A0=A0 2: ..2....... (07) r2 +=3D -4=0A=
>=A0=A0=A0=A0 3: ..2....... (18) r1 =3D 0xffff8f0708cca200=0A=
>=A0=A0=A0=A0 5: .12....... (85) call bpf_map_lookup_elem#1=0A=
>=A0=A0=A0=A0 6: 0......... (15) if r0 =3D=3D 0x0 goto pc+1=0A=
>=A0=A0=A0=A0 7: 0......... (79) r0 =3D *(u64 *)(r0 +0)=0A=
>=A0=A0=A0=A0 8: .......... (b7) r0 =3D 0=0A=
>=A0=A0=A0=A0 9: 0......... (15) if r0 =3D=3D 0x12345678 goto pc+11001=0A=
>=A0=A0=A0 10: 0......... (07) r0 +=3D 1=0A=
>=A0=A0=A0 11: 0......... (07) r0 +=3D 1=0A=
> ...=0A=
> 11009: 0......... (07) r0 +=3D 1=0A=
> 11010: .......... (b7) r0 =3D 0=0A=
> 11011: 0......... (95) exit=0A=
> ```=0A=
>=0A=
> This program,=A0 in most situations, will either be JIT compiled and run =
properly, or will be rejected with the=0A=
> error ENOTSUPP. But on machines with:=0A=
>=0A=
>=0A=
>=A0=A0 *=0A=
> `CONFIG_BPF_JIT_ALWAYS_ON` not set=0A=
>=A0=A0 *=0A=
> `net.core.bpf_jit_harden=3D2`=0A=
=0A=
=0A=
I tried your reproducer with latest bpf-next code, but failed. It did=0A=
not crash the kernel.=0A=
=0A=
gcc -o bpf-interpreter-bug ./repro.c=0A=
=0A=
uname -r=0A=
7.1.0-ga187b7f97305=0A=
=0A=
zgrep BPF /proc/config.gz=0A=
# BPF subsystem=0A=
CONFIG_BPF_SYSCALL=3Dy=0A=
CONFIG_BPF_JIT=3Dy=0A=
# CONFIG_BPF_JIT_ALWAYS_ON is not set=0A=
=0A=
sysctl -a | grep bpf_jit=0A=
net.core.bpf_jit_enable =3D 1=0A=
net.core.bpf_jit_harden =3D 2=0A=
net.core.bpf_jit_kallsyms =3D 1=0A=
net.core.bpf_jit_limit =3D 528482304=0A=
=0A=
./bpf-interpreter-bug=0A=
BPF_ADDR_PERCPU JIT bug reproducer=0A=
=0A=
WARNING: this WILL crash the kernel. Run in a disposable VM.=0A=
=0A=
Current config: bpf_jit_enable=3D1 bpf_jit_harden=3D2 bpf_jit_limit=3D52848=
2304=0A=
Created per-cpu array map (fd 3)=0A=
Loaded target BPF program (fd 4)=0A=
Verifier:=0A=
processed 11011 insns (limit 1000000) max_states_per_insn 0 total_states=0A=
1 peak_states 1 mark_read 0=0A=
=0A=
BPF program was unexpectedly JIT-compiled, the bug will not occur. Aborting=
.=0A=
=0A=
=0A=
Did I miss something?=0A=
=0A=
>=0A=
> the program will fail to be JIT compiled, will fallback to the interprete=
r, and when executed, will cause=0A=
> a invalid pointer dereference leading to a kernel panic.=0A=
>=0A=
> To the best of my understanding, what happens is that:=0A=
>=0A=
>=0A=
>=A0=A0 *=0A=
> The JIT compiler will optimize the map lookup at (1)=0A=
>=A0=A0 *=0A=
> The JIT compiler will fail when reaching (3). This is because the JIT har=
dening enables constant blinding, which triples the size of the jump, overf=
lowing 32767.=0A=
>=A0=A0 *=0A=
> Since the JIT compiler failed, and CONFIG_BPF_JIT_ALWAYS_ON is not set, t=
he kernel falls back to the interpreter=0A=
>=A0=A0 *=0A=
> When executed, the interpreter will badly interpret (1), I suppose due to=
 some JIT optimization not being cleaned after the JIT compiler failure.=0A=
>=A0=A0 *=0A=
> This will leave R0 with an invalid value, which is dereferenced when the =
interpreter reaches (2)=0A=
>=0A=
> But of course this may not be what is happening, I am far from an expert =
and you will know better than me.=0A=
>=0A=
> This is easily reproducible on debian images, which do not set CONFIG_BPF=
_JIT_ALWAYS_ON. I have reproduced it on 6.12.74+deb13+1-amd64,=0A=
> 6.12.94+deb13-amd64 and 7.0.13+deb14-amd64. Setting `net.core.bpf_jit_har=
den=3D2` and running the reproducer is enough to trigger the kernel panic.=
=0A=
>=0A=
> I am not entirely sure when this bug was introduced, or if it is fixed on=
 the latest version. From some research, it may be related to this patch:=
=0A=
>=0A=
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D7bdbf7446305=0A=
>=0A=
> and there is a commit in review for bpf-next that mentions a fix for the =
aforementioned commit: `bpf: Disallow interpreter fallback for BPF_ADDR_PER=
CPU insn` in https://lore.kernel.org/bpf/20260622143557.22955-1-leon.hwang@=
linux.dev/T/#t=0A=
=0A=
=0A=
I've posted another patch series to fix the assorted interpreter=0A=
fallback issues:=0A=
https://lore.kernel.org/bpf/20260626154330.33619-1-leon.hwang@linux.dev/=0A=
=0A=
Thanks,=0A=
Leon=0A=
=0A=
>=0A=
> that would indicate an impact since 6.10.=0A=
>=0A=
> Joined to this mail are the reproducer for the issue, and the dmesg of a =
kernel panic caused by the reproducer on the standard debian image `debian-=
sid-nocloud-amd64-daily-20260629-2524.qcow2`.=0A=
>=0A=
> Thank you for all your work and for your help on this matter.=0A=
>=0A=
> Best Regards=0A=
>=0A=
> Vincent Thiberville=0A=
>=0A=
>=0A=
>=0A=
