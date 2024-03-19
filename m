Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2090.outbound.protection.outlook.com [40.107.220.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCBE3FB90
	for <bpf@vger.kernel.org>; Tue, 19 Mar 2024 21:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882989; cv=fail; b=OHTsAdXFCvS5ZMb3e/JH6sKdS4VBBsZ7WAeNP6WuPIxF4Nt5+XWV1WePpZPALijW0800xsVLe+i1GHBNSynUNgTXMziFrjt9ZQ/is4U1p7DrbDQBGnpnh9cwtTooc4UOctc+WPDfdUuVRRSAUk1/lCbInM0+ijsFjrYr8fTTlZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882989; c=relaxed/simple;
	bh=NkZwuhpxsYEFGetOINWUY9dbnetnOuY2cm3bYPCxYD8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f20D1RmHWeY8pQfoAflMnKyUN5ri9QC9nRsPSt/wG+0Ni5bW2evWJCOa80zw4ygDHuEFxSJRzcOiVtK6dxEs8PHpE2LF++e5TuH4Uw83dNrSaxGhp2P7Z+L3sEe2J7tSBqP3qt3hAGNZGSXMl+F0vMEj17ITQiXg6+JlwB8YzEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu; spf=none smtp.mailfrom=rutgers.edu; dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b=qPKhEoBt; arc=fail smtp.client-ip=40.107.220.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rutgers.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rutgers.edu header.i=@rutgers.edu header.b="qPKhEoBt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSOkGDRK/+lLy4A5axB2SaSc6DGEwhx9yPtX26zzsHFR9RAkC6VyeNc4t9duvNHtNt0lV26/VYzsSk4d5suZ6bcdxvQiowIzBKto3OpLNGmg5xqJYIEezpx9ZnvwbhE+M1OW91ZknHd3CThY+OiJ97m1X5nnft67qXqOnkFzsq63zmyqrCJf8YJEo+nbzencDA5S1YZaRxKPBaApkiiGKw44jM11DwA9d9Hquvo8O0244h/2XJAtN2YO/v8c6D1INno/LcCSMRmlTPA2CNeqykd60S1SMdfE2H7tppqTbuA5cwXr3BsihuHKDU6slUvL+xVfe8xXJqi3Sh7h1Fywag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQ8VpPmHNeKe1dIyUQ2le3IUy4usj59Ci22KaZ1JIVY=;
 b=NFycqOLSXcNFu3ULsCJwT0YdlQkOOPZtC3+c/SRgGO9WeW1hUuWf2FCcp/pWZXAhuyjBN+uQY9mBRVEHzdKz0yM6F/Ti9D9vkzyxjz2DsbJ5vefPvjpbqyCs4R78Vq8ja2Z1uYY0U03+DLuVex9zVnxQYxyE11sWLwG7yjFVYWfSZOrXub9tIlz0Ua4wHMUuRFtdlcKD2QqEsHq86+1kuYC0bmuYF6c/Cho9FEp7X6cGBxr4sA2nTRHJ251rM1zEEi/Uzd+xTwojgCTXTuWFxJfrG1MVIKmE3GcqUNAsHyF/uluIdnz7aoM4pmKuVjUaCsyaa0KYmb8kIEABTJdoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQ8VpPmHNeKe1dIyUQ2le3IUy4usj59Ci22KaZ1JIVY=;
 b=qPKhEoBtiwX3xa0il2s3SAV+d8Bvcc2QkYl8QNxsCkcwtt31GR1UTa9YRBOB1vrgvy40d0Oh/QZRcB6yAno5+ZgCfL5D78jFCwjKP8cp3IwpM53MjEsqJvQwXkzhX0dgrI4/S6vxWrSAYSUCoRXEqia8ReQEd1W7m3oZ890HwOkvQi/3yfPmhEOhJ4Oh+ahktmph16Xveiqcx9WdVfubGkivAbx7SUve/94KdDhq6/FDQYT38nvVKISoUDR6vBWzWNBkx7kQLhh9xwLDRLv3JGeJt97KEMwzSh/t5cWrKw5VPH6PctCaGwcEXcXJ4MaYGZ5XBcoeQ+tr6VRfKG6lYw==
Received: from SJ2PR14MB6501.namprd14.prod.outlook.com (2603:10b6:a03:4c0::14)
 by BY5PR14MB4052.namprd14.prod.outlook.com (2603:10b6:a03:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 21:16:26 +0000
Received: from SJ2PR14MB6501.namprd14.prod.outlook.com
 ([fe80::fe7d:3e2f:e3d8:4b5a]) by SJ2PR14MB6501.namprd14.prod.outlook.com
 ([fe80::fe7d:3e2f:e3d8:4b5a%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 21:16:25 +0000
From: Harishankar Vishwanathan <harishankar.vishwanathan@rutgers.edu>
To: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC: Paul Chaignon <paul@isovalent.com>, Daniel Borkmann
	<daniel@iogearbox.net>, Srinivas Narayana Ganapathy <sn624@cs.rutgers.edu>,
	Santosh Nagarakatte <sn349@cs.rutgers.edu>, Matan Shachnai
	<m.shachnai@rutgers.edu>
Subject: [bpf-next] bpf: Verifying eBPF range analysis on v6.8
Thread-Topic: [bpf-next] bpf: Verifying eBPF range analysis on v6.8
Thread-Index: AQHaekEEXwavwD8qdEOBFYtheIwylA==
Date: Tue, 19 Mar 2024 21:16:25 +0000
Message-ID:
 <SJ2PR14MB650171C32E2AD95B67FD51CD8E2C2@SJ2PR14MB6501.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR14MB6501:EE_|BY5PR14MB4052:EE_
x-ms-office365-filtering-correlation-id: 1ee7c64f-7294-447e-a43f-08dc4859d5ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iGlbcGOD2KdpkEURdn01BIg4CFnSwSMCLlaEZfwpLVhCbNnMdPkiSPkx8zMRA5q4gIREb03hyF6M8siVV7FZcB3FT5B0Vxq4fDd6SXX+KZUlPZ2Lj7S3h6JtoVSaCpkOM8va1lPK9CvMpagTmZdiy+YRqTiCzpUoSmtLhnaW/mHOi11kwr92UZ9NNhUAnSugsUtIUDq6/ISgkb+nyB5AKEGuyJegDXIQz4ofzgdaZM9we5rDjQAEmitqFrA19cFcYfxsNf6ikOkTBcBA/YtNnywSgZho2+rNjPiZ7OYHyY8f+z+yXb/uPH3OWki1TS9QH95IhtuEm7y6rXkHXBQ4Nvbf409GeteCkefxKRBT2dv9n1yYUPwUABcHy+3fmTeY7k8zIcnBQaHIHzACE6a6Gp1GrsHlDv7eGD9h3RfRfWrT/D+O7EteCI+9hzfc73H2YcjzU6Kc2K8shjwI1EzkxX1Xvd296y0NXLih4jQ9F4jJjrkRFBhngGKFz3VHrHJy7RUYpKpPdlVKnG16roMiULY06o8DvOdOO/vCAQ/Oq+Jq0HqZox60ufn028Ja2PjCf4jG2WBe4jb4jwfjQHIxKFszgBbvipO5ye3mhieY7oZ//4dh3bj5MuHiDy0IpPjVsrMaX0u6jLu1zlXMV3y6tYH1k6wX/80ClsxSZ1+d4Z8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR14MB6501.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?UOQW+krwDWpjKkhV8tiUCmQkmN8Fk4PWcnqTP4UlBczMBcaHfDA5As8A?=
 =?Windows-1252?Q?zQbOuMQ6Sp7FfRQKUYf5eO//sbz15R5MsVJy/SPowJOwmE64iBaLyW/3?=
 =?Windows-1252?Q?KI9U7tBa4Zeuyt0HXA97TaaASLoffJX5HNRptW2smDVgNxMmrv46Fa2i?=
 =?Windows-1252?Q?Iph1/WqsW6mheaGn4EWMfYAjfzf5p4Kb9sD0ASulrAhXc+Ya0h5BCkbb?=
 =?Windows-1252?Q?CIRxWFiLr1M4Zpz4SLgjZxC0UPIPf92tFo66FDB2gwO38giudTZWdBpP?=
 =?Windows-1252?Q?VndPTH68tAem1wjp07Te13TiESfFHgL/mhqeNWj9OdVTOImqXRuoTxAA?=
 =?Windows-1252?Q?b+sN+3ztKgx7l2+gBn5QP4zYiel1/PxvS0BPDU3uClWG9nXfWTtO+1lk?=
 =?Windows-1252?Q?5ThAFTqmF5NUENK+pZYE4I0n3twOEgKwCmZbVf8Van9uSyELMNPyCXf0?=
 =?Windows-1252?Q?MXc+tbPqU7ws/m4uf5cO2HFEYEeFquc1rYPOrwBzAomj/Qzl+2vXfSS3?=
 =?Windows-1252?Q?vpnPOtl+5ERt45EAAyN8ygh/Ff7Dthq3hLiFnBiVmoKHEHbOO3rMM0oD?=
 =?Windows-1252?Q?cA+Ico6zshiITupya648zNiI3N3AL8uvDmkZpPRu8LoCuXQCbppLzJOj?=
 =?Windows-1252?Q?rMV7f5lnU1/A+ZJJ7qpghazXfmj1kwf7wFni3gZk61JGsCvbWY47awnb?=
 =?Windows-1252?Q?6HBj14VgePsDrAsqqZpkXRBrt9q/I4v3CXWPE+BBjhHFreuQneA/rX5/?=
 =?Windows-1252?Q?8rEUaBtO97d9IqWvz6U9CYTqXT38N13PzLlldExWQFc6rqeTEVN9SZvv?=
 =?Windows-1252?Q?jYNACng+vQzHDNCpVLlLfryX509M7IHV3DO7afxvK3+NN2InnVuvav74?=
 =?Windows-1252?Q?LkLJ4Lu9eSP4hcICv/Lu9DDOrZX2TdLyO17eWeub8ZsBH6ZklHr6QPxA?=
 =?Windows-1252?Q?WUhU32HIkvG/03TUAJcmAq+uT/AsyX9lfOdUkuNu9xP5Nko1OtOa3Cy0?=
 =?Windows-1252?Q?4udP5LUstAk7Lq8+ow1uIwTD+uqElwzCLhjHVVKWZkAYnsD+f4hEbT1G?=
 =?Windows-1252?Q?q6EbkC7YYp1seOXWP1Wh56IAKAoTb5sdDTkCBo1OMkfLx4mzcA/Uq4ue?=
 =?Windows-1252?Q?4cUdmy88gaCIL5UDhU9TWlmgOAnY8FdjfK/v03+sgZ6SHXfE+NNfDUmF?=
 =?Windows-1252?Q?E934mePNL/xoHRE31jdar6kOS3j5evZRJdmELV1b2CAX2dN69GiZdMGp?=
 =?Windows-1252?Q?xw0XfUDJq9667IYmANLkyto1snFWaGkVdJ8fhDQBIoNWqRuu/iB18U5Q?=
 =?Windows-1252?Q?2j9SeEuLfs2PTChznvjPuJIf+aUH/CTA3dg+Y5YZz0L/olCJ+9Qpna/q?=
 =?Windows-1252?Q?ZJrciJnt/76phVYsiOE0uovo17BmEYa5Y7m76sZK2S1ifV1/Mtj7fTtp?=
 =?Windows-1252?Q?IZAl/ML2BxAtii/uU7NNx0vdWJB1VVP5lsmtgHzoKElsj1ap/QAZ7LoI?=
 =?Windows-1252?Q?kP1x06KG65nB6A/nPyKmGR20r5tuzBg4TGcLhpadbMR0BjFzDkgEAej/?=
 =?Windows-1252?Q?a2oOiWL17fb7CFsbimy2glZIxY/BbN96sUK2GOUskGc1Fdkg5Pd8KWBj?=
 =?Windows-1252?Q?nJvezhKQeAiCsqVmoUyfJjUOwVGlWhY4ot7OqVHkeqVSxtCyHG6d/ah6?=
 =?Windows-1252?Q?ekZnSyXbVL4=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR14MB6501.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee7c64f-7294-447e-a43f-08dc4859d5ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 21:16:25.7992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y9sFVpegcB8hd78AGnnNxnNJ4QQWybq2GnyBMi47fzn1LCQshjhwONg46bv/JI9VtPcvCmHX0P05sxq2Q2Wraw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR14MB4052

Hi,=0A=
=0A=
We wanted to give you an update on our recent results with verifying the=0A=
soundness of the latest patches (Re: "BPF register bounds logic and testing=
=0A=
improvements=94) to the eBPF verifier=92s range analysis using our tool Agn=
i [1].=0A=
Specifically, we checked the range analysis in the functions=0A=
adjust_scalar_min_max_vals and descendants (for arithmetic and logic=0A=
instructions) and reg_set_min_max and descendants (for branching instructio=
ns).=0A=
We were able to confirm that the range analyses in kernel 6.8 is sound, wit=
h the=0A=
following assumptions: we only consider parts of the verifier concerned wit=
h=0A=
range analysis (that is, the part that updates u/smin, u/smax, and tnums in=
=0A=
bpf_reg_state), we only consider scalar types (SCALAR_VALUE) in bpf registe=
rs,=0A=
we assume Agni's translation of the verifier's C code to logic (SMT) is cor=
rect.=0A=
  =0A=
Starting from kernel v6.4 onwards, Agni used to take several days to verify=
=0A=
these kernels. Further investigation revealed that this was due to the chan=
ges=0A=
to reg_bounds_sync and descendants, which introduced a lot more control flo=
w=0A=
(branches) in the verifier code, causing a symbolic path explosion that deg=
raded=0A=
the performance of the verification. To address this, we adopted a modular=
=0A=
approach to verification.=0A=
 =0A=
Consider adjust_scalar_min_max_vals, it can be split as a prefix <X>=0A=
(adjust_scalar_min_max_vals minus reg_bounds_sync) and a suffix <Y>=0A=
(reg_bounds_sync), such such that the entire function is represented as <X>=
.<Y>=0A=
We were able to verify <X>: assuming that when <X> starts in any well-forme=
d=0A=
abstract state, <X> will only produce well-formed output states. Similarly =
we=0A=
were also able to verify <Y>: assuming that when <Y> starts in any well-for=
med=0A=
abstract state, <Y> will only produce well-formed output states. Hence, the=
=0A=
entire function <X>.<Y> is sound. In earlier kernel versions, we have found=
 that=0A=
this modular soundness property is untrue. However, in kernels 6.4 through =
6.8,=0A=
modular soundness holds, making it easier to scale verification by breaking=
 up=0A=
the monolithic verification task: since <Y> consumes the output of <X>, the=
 full=0A=
chain of operations <X> followed by <Y> must also be sound.=0A=
 =0A=
To run Agni on the latest kernels requires a preprocessing step because=0A=
regs_refine_cond_op has a goto-label that introduces a backwards edge in th=
e=0A=
control-flow graph of the verifier, something that Agni does not support ye=
t. We=0A=
provide a patch that essentially removes this backwards edge and makes the=
=0A=
verifier code a DAG, while keeping it functionally equivalent. The patch an=
d the=0A=
instructions to recreate our results are available at [2]. =0A=
=0A=
Best, =0A=
Harishankar Vishwanathan=0A=
  =0A=
[1] Agni: https://github.com/bpfverif/agni/=0A=
[2] Instructions: https://github.com/bpfverif/agni/wiki/Running-Agni-on-6.8=
