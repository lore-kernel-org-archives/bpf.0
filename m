Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.135
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792458940;
	b=qZv/3hXEfHf0ZZkV2YTyEGNR/G9bbTva5wW4bwJEcLMKhnnMdybkXB5JG3gXEJYh0ys+
	 whVryFc/O50sOlXF7J/FVZm9ky95cEoqs+wyXWzW2RDpfjd9ABOnz6TOTEms1ad7jbk/x
	 q4wRUzPFREQwD0jsbJnodVm+42nW+UeGm0WtId1T7rAvoh4Sl/kNbhW8osLXAAfd3E4Ww
	 rW9w+RZaTJCicao1eYsNOi1RPvP8mqG2VbjW0EKydjpueWlUrP6uxB5v012ozRJtAhJby
	 +SCrSqJ1vQNLqVp7OJpmTqnKHiswwca6Nq6Q6gSlrf2akB89ImVkJ2KRiuHBO96eXJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792458940;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
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
	bh=kkJH3OeK2WLSyFhkCpXGE6fOa/HUHbClqBeDA5I7kCA=;
	b=S0lFPe9hpybqEIu/BS7i4Jl2c5NDGcdbLiF0Z/Xs435X0aAzRM15iq5gbbsYeLviNaEk
	 HGG/DO7fGMbGHTRZvw+K1cOfUUl69xgpHKcaIWhWPgUWW61akxQDFXYDanxHIgWR053Di
	 orUtXamFLWeomQXgRq6e4DAjX7zgxwgM82VzpiGkny2AlhUX5Gk4qXPUGmxgrw9LkYF5h
	 PIbORBXM3CFb60k+m8KRQB1okNsZ4N12XE3w4oYNv1YHnrAcVuy0WYTn2aEw8nDCXWD+J
	 UGVV8iuvGn0anWT/3891TzYWnv4x/WRgLuIwb8d7QafHZSPcvppELBnhQ9VzkFWU/Qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microsoft.com;
	spf=pass smtp.mailfrom=microsoft.com;
	dkim=pass header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=EilCMkqX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.75.135
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022135.outbound.protection.outlook.com [40.107.75.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A837606A319;
	Tue, 20 Oct 2026 01:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A837606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=microsoft.com header.i=@microsoft.com header.a=rsa-sha256 header.s=selector2 header.b=EilCMkqX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cLPdObb0vLubwTZgiiaTr+MGvuZlDufnrwhO96ZUq7DVJCFoO/M6vK8+u22gHjxFMBj4Far9JodCgEAtmXA8eYZed6y3lsPMZcZqjxwRSwYYVO7yQBhquopojIcEW8AQ0gLT0xYL+3jDwJ7U+FS3i5l1Mx5M8IZrcD2Ene4XfMiGFteRAwpjVfyAPbXVKtFIvqsmlKFIn3+6Egrlz0kTP2GwbADfNC+gVawtnBHfNBrlEydb9BBIO4pbNDgGkppWMr51q7nCewUlT92gg7pKE+WDe2l+BWNBycGqiFwaggnG7SCFpEIYfbvfqMNUhSBG9OxDe+tyE0uvC+YyTYL5hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=kkJH3OeK2WLSyFhkCpXGE6fOa/HUHbClqBeDA5I7kCA=;
 b=aGNLGcwxT/d89bJ6Xts79+EueUWJXu3otc2tgkRWNQHJGBpNmaIG6faZ20d6j2OQiXr5lS1r3ZTGWwarc0ew80R+8Qah8eKI/KqRRtWDvV/JCDJi9UrEhOW/VhMTqgpOzLjl4eoQd065xl+FIAU/MTcho5KHyElk+AFDHoQlWTSrwKQpkYjyvoDyda1aFGAswgLdzuvdlhkrD8miP+QDRMO2Mt1aCrb6fNjrw6eEStoAxBv3Hk5WVEF048hkNiYh1ZqIlOJSzhpbV3Qc+1EHBia4iHniBm1VcnL6DeJDTL0Wd0x3hVvvWRCF05j6oWHjBtkwZjMO806J46DBQ8Dd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kkJH3OeK2WLSyFhkCpXGE6fOa/HUHbClqBeDA5I7kCA=;
 b=EilCMkqXEOPiHf/BH0PSpLR8ZbLsPRcLeZs8bOEY0PQrYC5JTKfBmSmyId8gX/uRv5BJcqlOIKURMl3GCBQlXr/H7xYKcIBODKijXHiHwM4AX0aglsZXQ4jvOFV+uYdDwC1418L+ABHvMG2R+ac0DJLDKTjRuPQ5U/zeiuWLR3o=
Received: from SETP153MB2368.APCP153.PROD.OUTLOOK.COM (2603:1096:101:31c::22)
 by OSNP153MB1836.APCP153.PROD.OUTLOOK.COM (2603:1096:604:48b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.2; Tue, 20 Oct
 2026 01:15:36 +0000
Received: from SETP153MB2368.APCP153.PROD.OUTLOOK.COM
 ([fe80::4fc1:ffae:109c:7c4c]) by SETP153MB2368.APCP153.PROD.OUTLOOK.COM
 ([fe80::4fc1:ffae:109c:7c4c%5]) with mapi id 15.21.0569.000; Tue, 20 Oct 2026
 01:15:36 +0000
From: Vijay Nag <nagvijay@microsoft.com>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: mlx5: stale skb encapsulation metadata after native XDP decapsulation
Thread-Topic: mlx5: stale skb encapsulation metadata after native XDP
 decapsulation
Thread-Index: Ad1gL/npNjEGTsShQVG1uX0myvfaCw==
Date: Tue, 20 Oct 2026 01:15:35 +0000
Message-ID:
 <SETP153MB2368281B3138379C3F88AF71C4672@SETP153MB2368.APCP153.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b1809b26-d690-475e-a701-ec26d5645330;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-10-20T01:11:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SETP153MB2368:EE_|OSNP153MB1836:EE_
x-ms-office365-filtering-correlation-id: bd44bc77-24b6-4bb0-0348-08df2e47a545
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|7146999003|18002099003|3023799007|38070700021|11063799006|10067099003|261009223027099003|56012099006;
x-microsoft-antispam-message-info:
 Epj8u4nRuScMJZyjDhtmIeeii4xguy9Mj94ezoTpHEjdZFD8xOFcqeeKIhsHAbsbnip7WcoV+qF0zjCbWBa7nqFS9mlctwyDEfSdTgyUn+TkuQpCgHBPpQi/iLhY0iV8LteknC5bjbgOgRbhSkHBcbYaIuouUdvRZNTI+GQpAwhP6KRQXTBmG/lQOY+q/y0eT6V5X1sdUtC1Po4fBfnGtEBEH833d07t0A28m8HfNc2IBWIuGt+ZAW4aIvBE5R2FRIOI2+UX9JhIV0HSjGiEertRpaPbpnLRqlRtwnVqqn4DleDFZqgYB8G6T8PF43zHI775mh6kUEJhk7Uqi7Pw3q+rnKVuyeSGMSxyHkhVA8Jmldkj9VEpoXDdABXAMyozy7VHg3m7bcOnllUKYVvfyLffK4P1SBG+XAVm5Hk/4ZOuQYPWc+5N4W6Yf9pAyO4vTCNIXkkr7pertFLm+/yHRGeHY34+M9T79jwv2BcPyGJ7F4cgZUw8POJrc66V3JzMaxjiGIraDUHdiLbiKDIPzTl85b/imaAdfXmypGseVxOJFAP5kBgqviry25T3ZeOCA0Bv2D6QpN6RoSO+0jQPFUtN1205jGP2nQQFyEYm1tgq5zKHHURN/E1WAX8RMwI67QWYij7nDluwfT/0D5Rhs0tky43wh7u6EBe5mgsrddY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SETP153MB2368.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(7146999003)(18002099003)(3023799007)(38070700021)(11063799006)(10067099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gHYjmnlLKg8tFe96NqJ83y0lvHtUZc4xfzM72gGBhnyIcKlrojsJqFu3aklG?=
 =?us-ascii?Q?gEeAZjwvnF0UOXBvJFYhRkKhQrm0DX+ojBUJabq/+K5kqi5lVfLabkSj3OFc?=
 =?us-ascii?Q?V05g+l+1h9VADZkDY0jd5nCMOMkwe9dQ0HWK5jCR+ewiP2RJVzId1F6e3tWT?=
 =?us-ascii?Q?KpzFXaAc9WU07tjMHtYvUz+QDE3lzHw/7gaGmcVj7dgEZnEaX+aKsjwsDwBK?=
 =?us-ascii?Q?W4+DQr+q9Nt+f09Any+rjP6CmSvN/Qa9hFX5dJsX1RCsPq8DPrWL3ESVYkCO?=
 =?us-ascii?Q?ldb7ZnQtszUXLu7lZev+G56OVVNEhSuTzQtROu9dwaYBsBWCs9l16iX5nXek?=
 =?us-ascii?Q?ZGK2ZCgeyyEhq+lYc27V344VWLhuFTIbl56RaWujs+tM6O2o47REPtIYOkhg?=
 =?us-ascii?Q?ekeMvf3s0mLKevH6pt0Ru+QokIIWQpzMx1RMneP9t/cbXuU8whkoZD5Gc7Ax?=
 =?us-ascii?Q?zdV9eCBkOk1jPllgazUanVy8CIsxhu9Tkf77l1Kw8xXgFRUzPLd3JXoIFgkx?=
 =?us-ascii?Q?3czXy5tq6Y37ZKZGEqQRffWHKGiY3oEKGgTxAxJf+aI81LThZDnKnt2vg82C?=
 =?us-ascii?Q?dMwRQcFYdKGYKaXsB5upo46tI2iPU62LAsSfYNWqv7syJdcouKJMQ/SnkBs6?=
 =?us-ascii?Q?kHMSlmuWgWAko/Cje/c1ZWJCpkWvsj3PBHgIB/UVyC4NInNwlyefR1WnFkMv?=
 =?us-ascii?Q?Y4XYBtUXXNtjy6FYSmj1LBqHjhs+Ntr2dT6mCGKVN5J4p3dEzHrrZqVTsdet?=
 =?us-ascii?Q?GMcU9O22gzjoyrIn+keLO/kJCw65UgKU1UQbCGdYxGABcGiO1KlEMTxY39B9?=
 =?us-ascii?Q?QCiWekJkTU8wj2Ii37yO06Q1oPkMSBHkG5z+Dwj9XRU3KXkn2ONTtvOAHwf5?=
 =?us-ascii?Q?kI7AGMr4lzp+J+iK7oC4oZDZNq6SeLdOD0wCZMFXeHsMizby2uKOD03Of1Ia?=
 =?us-ascii?Q?c9T0U2qzdZvJHeaMB+7ucFuyaoDFANAmIUurY36DJpM1JbNTLP0oXRjUNQfY?=
 =?us-ascii?Q?uI879PNP7+7IIsCHGoufe9ewAgXmi+qfUj4pxkM/tBciNQmwzf+4nKIH3Vbd?=
 =?us-ascii?Q?2tnIjl//UovnyMF2VjqGZDuXsGCZuiz+1CMd1o26kMawGAzIJMTbEjour/DW?=
 =?us-ascii?Q?P96WfvBnp/fzwYee8Vwpbd6cFSh/J14WRQ+HuoXQQVOIPxcRdB3lNIKgA4Nj?=
 =?us-ascii?Q?mX/8kPshox32eo6vnoE5+B2FNPFNSyznFUfN0mBpYbIz8mygc0RPO0UUTFH0?=
 =?us-ascii?Q?HAMjfFhMB4Bg8rTuY0ayfJu/2rHDIYORk7FL7WiKBFHPQ97i0YszBt10rvo5?=
 =?us-ascii?Q?Bkqiy264AbxEUj4XFCgpvJqhrhxaZbaSkkbciOBus1YD1eokhbQO5hGo6RTg?=
 =?us-ascii?Q?ElWvdq60zcSeEGbw65pwILJ1ha3TIodQzWFk43y7Rc4M8CExALb+108dIS7D?=
 =?us-ascii?Q?+E4pa1O4OnGn2GTFDTh9gZqAVbw7U0R4Qlgm5zvYBfTnWJcnAEOtee5qoejz?=
 =?us-ascii?Q?yFjlrw57RVVg8QfFrACyQf6XdI+heF+94QYL2w56LfoyznBYq0AEMXXO6i8r?=
 =?us-ascii?Q?0S/icXaX5lHNwGR2d8Y44a7F11NWcQuA5z/2gmJYYXKnt+rPBoKEOu4zwnhv?=
 =?us-ascii?Q?zqQtUA4utonc8UzDzzp5x/sJmEDUgj6UpZLMNozjb2gN?=
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
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SETP153MB2368.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bd44bc77-24b6-4bb0-0348-08df2e47a545
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2026 01:15:35.9933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: khCtzGKPevua7zlOqLmI+dNpeOh8/08+4cFt1gTB8n2UvebOTzg5lZ6P2z2XJ5Qz7W7CFvfpqR+NTfHbHlhTaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSNP153MB1836

Hi all,=20

In a setup where native XDP performs tunnel decapsulation before TC ingress=
, I'm seeing an unexpected interaction with RX checksum offload.

XDP removes an outer IPv6 header using bpf_xdp_adjust_head() and returns XD=
P_PASS. TC ingress subsequently calls bpf_skb_change_tail() on the decapsul=
ated packet.

On mlx5 with RX checksum offload enabled, bpf_skb_change_tail() returns -52=
4 (-ENOTSUPP). Tracing shows skb->encapsulation =3D=3D 1 at TC ingress, eve=
n though the outer header has already been removed. Disabling RX checksum o=
ffload makes the same processing path succeed.

The following Linux v6.6 code paths appear relevant.

In net/core/filter.c, __bpf_skb_change_tail():

if (skb->encapsulation)
    return -ENOTSUPP;

In drivers/net/ethernet/mellanox/mlx5/core/en_rx.c, mlx5e_handle_csum():

if (likely((cqe->hds_ip_ext & CQE_L3_OK) && (cqe->hds_ip_ext & CQE_L4_OK)))=
 {
    skb->ip_summed =3D CHECKSUM_UNNECESSARY;
    if (cqe_is_tunneled(cqe)) {
        skb->csum_level =3D 1;
        skb->encapsulation =3D 1;
        stats->csum_unnecessary_inner++;
        return;
    }
}

My current understanding is that the CQE tunnel classification causes the s=
ubsequently constructed skb to retain encapsulation metadata corresponding =
to the original packet, even though XDP has already removed the outer heade=
r.

Is this expected behavior when native XDP decapsulates a packet before skb =
construction?

More generally, what is the intended handling of checksum/encapsulation met=
adata in this case? Is there an existing fix or recommended way to handle t=
his interaction?

This was observed on a v6.6-based kernel with an mlx5 VF.

Source references:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net=
/core/filter.c?h=3Dv6.6
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/dri=
vers/net/ethernet/mellanox/mlx5/core/en_rx.c?h=3Dv6.6

Thanks,
Vijay Nag

