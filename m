Received: from MRZP264CU002.outbound.protection.outlook.com (mail-francesouthazon11020143.outbound.protection.outlook.com [52.101.165.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7B23B6366
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.165.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782744141; cv=fail; b=O3S8tVaAEoWyjJUWyKgG3p18+eGCHuYTydacTsqptlTmsCTijmfg6d80jwCn/gso09I98pWovGwJ2KICjk0ejmdIF2wHN5VwGYQ+4Ns4p3m8aAhFBsiXqKv3QtFTCxQpNgFbF11QO0/WEYM8iDG5cO4dqOVBwUXCpFJxW+5zyeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782744141; c=relaxed/simple;
	bh=8AWdv5JX4Jd2979aStfRi0v3ayasJylHTN7TQLJ+VLI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=F7/3VmINTsGiH+dfKbZs9S8JVwd2EybH6axZ3DUxATT3khJFH6T5JfsP4OeG6TD2BAXdNG/Cnj5jhe76GbwXPgoP5/AEYqCOAMRMI2ODOb8JN4Zst0f8HHsORhJBbTjfkyeRPhoDmZ6PI21ZU678EXq93Qulkk1ss0118F+bQuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=harfanglab.fr; spf=pass smtp.mailfrom=harfanglab.fr; dkim=pass (1024-bit key) header.d=harfanglab.fr header.i=@harfanglab.fr header.b=lNVV74sE; arc=fail smtp.client-ip=52.101.165.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=harfanglab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harfanglab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harfanglab.fr header.i=@harfanglab.fr header.b="lNVV74sE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpkpqaJySSx2saRznn/JwFh88shOVLGWp9o7UR0ZcFymNFB4vgs/v/pAO503fCeGrfz6vQ+R/GnDiHYid1vya0TLN6ZT3xhghTcQ6GM9QBKxyp8js2w4gtUOrlnqrBCfP0Xp38ifOXYJ09nWHXrSWeeMaWhNcFLNEnfW//rNm/wKwmdXSvEKjWhB/8jF1h9bxSrOHijqKrL2D4cxOyJFcorK9EIXE+HQkcf7ULilgY15KsZRtgqxWeUD62G7Z4saocr9iJRmj1UPf0DuVh14xY5Bkd2qtyglj0ub2IjGfrRbyd2CvrYzd1f3wibYeECgxXqCei/Phu+sQIjMe2nLhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=krkcZ5eXOw9cITNmqlxPefTgl1Al4a/ejRyGMFS23Ho=;
 b=ymsF4Rb+0kwYIigeqLoSuCEUVzwm8JNCK97D33O7O94ipHQisHAadd1WlWwR7YJDgM4JZcrbCT8rsPPjnRGpqnPDfqJdu0MTgAGXQEtml6cMt8fidwyEWR4fOOiT2zeuz4L/WVS48R/rFw+45C1eK6rhkJz/SwIXY4LlsNM5TprI0VyjAKCJP0RtIX8ft74kZp/6uPz6ihnQS/D2yzc9iqA4x8vxk8a5ZJ1dnlAuoHXP/Ke0FYhanHN/iJxlq6vpzqbZ0QZOwdJzw07UZ/yHVm949kPDf4g2Nub1vm37gWX13TRlnUJ5AX7X5ASbHBjW0gGkF4yetFN+NgiUlEbZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=harfanglab.fr; dmarc=pass action=none
 header.from=harfanglab.fr; dkim=pass header.d=harfanglab.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harfanglab.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krkcZ5eXOw9cITNmqlxPefTgl1Al4a/ejRyGMFS23Ho=;
 b=lNVV74sEgEAIDNQhlrZRuej/nfBbwFUWu4/jY5kUXKQ2y2xboUzOZdYN/e7lEanTM3OpOKYApiONQNvnpx6eewgeXeV3lYPqOdPsRr+rEqzX/tI8DvuXJC4uV10U/lzcdJvJY/Z05a+xCc1kd0VHBqFqA9eDHGDJrQ0e4AGEBsc=
Received: from MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:28::14)
 by MR0P264MB5115.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:42:13 +0000
Received: from MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7d89:c984:624d:9689]) by MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7d89:c984:624d:9689%6]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:42:13 +0000
From: Vincent Thiberville <vincent@harfanglab.fr>
To: "ast@kernel.org" <ast@kernel.org>, "leon.hwang@linux.dev"
	<leon.hwang@linux.dev>, "daniel@iogearbox.net" <daniel@iogearbox.net>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: PROBLEM: BPF interpreter fallback after JIT compilation of
 BPF_ADDR_PERCPU leads to kernel panic
Thread-Topic: PROBLEM: BPF interpreter fallback after JIT compilation of
 BPF_ADDR_PERCPU leads to kernel panic
Thread-Index: AQHdB8yzqGrNWEhQ9U+ot25Rw6XY5g==
Date: Mon, 29 Jun 2026 14:42:13 +0000
Message-ID:
 <MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=harfanglab.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB3314:EE_|MR0P264MB5115:EE_
x-ms-office365-filtering-correlation-id: 55f7f6bc-4511-4b73-edc6-08ded5ec9bb3
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|31052699007|39142699007|376014|23010399003|10070799003|1800799024|366016|6049299003|6133799003|13003099007|4053099003|3023799007|8096899003|55112099003|18002099003|38070700021|56012099006|11063799006;
x-microsoft-antispam-message-info:
 sNfVDg6b7kP9epijB3bKwZgz5m6Z3X+QSQPbsvwIqhPe4EDn41/s6eC83vuUAEeWQ7jgVwA+pNPngDkGnrthW920iXR++fMLu9gzT8OQsQcR64u2c4E+FWVR2GezhXnpojQ1iBGJbB2XpwDjMtHU2B0rcbSU/II+H9Su3fX9qvb4F5wMU6WdCJ4QQKgL3tw6LD18iXoSpJJ3YNppDgApmJ8ZSWl29at/IUVxB7mxjtKeqdXqfTDDgwLPABNfSKoMJNBX0WxI0BnFCkC/l+nBIY1XzxuYMjEAVbYiXsWbU21CH+scMZV/Z8PeozzfHqVrcgr45CFo4kzCvdoj0hviwsO7xoj1vVvKyAHEpBZQKvKN8a+ImfZ35tWZb9W+ER/r7f5ldKfoTkyK8ZVVg10mqESjM2WUeHaetEmI6M2iG9UXliqeJPqG7KrVjSlR7ohsATwKlF7/T4hfchwPQ3MzEHG+rPlwoxT0gnVHTnPnyR5sC5f2EXCDhhKlG0BL+GMlVgGUGsWREaMlVgk7XLgpeEAYtxxGuviDOHqvtbz4IkzmY7x9XIqK1GyuptEmGGJk/NkqrSWBOHcUwJ6N3RojYYFTF8eLgw9YO9WkNE3uH/g8/Yc80piu6SfGmBTHNIsSVfxITv0L2wDaf4L4O+S7O5KSNvYIKYGh10qQW9QNEao5FFWKWwFAaruvZr5mPtGU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(31052699007)(39142699007)(376014)(23010399003)(10070799003)(1800799024)(366016)(6049299003)(6133799003)(13003099007)(4053099003)(3023799007)(8096899003)(55112099003)(18002099003)(38070700021)(56012099006)(11063799006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?XHMIiluQNDpm72HV5RmC5yPCNa5DfCT78Hl1aUwr9qyogdprxzqyZAN0YZ?=
 =?iso-8859-1?Q?dYevo0PRf1SjakOyFA77XU+MgU8zwfTI2O8zjsFlci/nctDxGedzKpFVvq?=
 =?iso-8859-1?Q?OmOieLtYrFe0Zwl3Y5MKrPrV1fs5A1SAydOjWoPAiuI0k2ue14Ax72okAm?=
 =?iso-8859-1?Q?I/3RmuDEjQ0d+iBHuuwTEJBePjfbf1QJ+zwFpqhDPEBKnMfYmZg+XyVARf?=
 =?iso-8859-1?Q?T/GLifVVEblUtcHTeva9z7cu0i9K4d+NmGxpM5qZjUgEmMEDOrRFlY4SK8?=
 =?iso-8859-1?Q?QWrDDqIovfoNvkLfeAurwIfky+2H//Mb2hARfr1W+h9ADiI7hKealM7AQG?=
 =?iso-8859-1?Q?vEp6EYZpplW+/DdNT/5kVhAtcWDvEre66ITN7F0gHJ6GCw65W9fa7Xcd8O?=
 =?iso-8859-1?Q?2HlZNJhAH7+XChT5gCAOjusiwd/8d39DfOf1qlEvLvqyjXVTxT1DB4hqRM?=
 =?iso-8859-1?Q?n49hUpT46+UkPM6AW1u5qfEdx7CBgsemzUfs5SgH5/sHGqUMzwY7WJd+Fz?=
 =?iso-8859-1?Q?W9Bttq3pk0wIbsQNge8tUqqbWjemQQMys/I4TWjNxOcF0lgMaoQZ9lgyoF?=
 =?iso-8859-1?Q?A9bTcPfDYQXZQsSCwfbBRCzGhFCsRCvEmlH/NYMP3scM7knFMHtucewUA5?=
 =?iso-8859-1?Q?sySl0hcfP5bC283+8rP8W/In20PZ/Gccs+uHUIty++ubvbw/RkWSgoOQ5s?=
 =?iso-8859-1?Q?kFwVST/XP9boBUIFFRpw5WaYt8l+sFflR5maPfpqPEFGnZhODVTMuOYMj/?=
 =?iso-8859-1?Q?l5auiVoDOhD9ZDh274jpEPE2PMdcVKIXVqN2/OWID/RrAuoYcF7FFa/iYb?=
 =?iso-8859-1?Q?6lQNypMkXOgih/6zk8ROodJ+b9DGpSYOcxQVctO5gwYmnsojI5X1JAO6e6?=
 =?iso-8859-1?Q?G1zYQ9nPQ0iQCbpIO8RZ0kaiUYgC7HXlCjiOvJCpbmmfmM92c4joVm15Q/?=
 =?iso-8859-1?Q?OEoKPhNEX6p/9rtLi9pjsu3HvWDptY6Fryt8DiR44nwz40PEXPVJr+4j0y?=
 =?iso-8859-1?Q?fYKXHJ+ZcNIqDkXni/Mt4PRQXs/SyK+/mi48R0NaioSl+lNYykcexPYn8c?=
 =?iso-8859-1?Q?iPZcnEiq/gw9uo/4sbde3Ibw0A22ymC2YPwpAmf9HL9KwXx4SSqIotEmpg?=
 =?iso-8859-1?Q?zF/V/ARsinZfovjpN/9yInp4CTd+KiD6IBSOM5CHCSO7IK5zcEqLYVA2Rb?=
 =?iso-8859-1?Q?dj0KARjtQvPR/AwUTkeD1E6l19lCJu+bekSLUtA9sjxM8PImnTu7BYboJp?=
 =?iso-8859-1?Q?6E1IuPOkJkq3u8ca4e8QTYi6YJhiMHfjH5L8sYEBerJjQ4eutKW0oZXG/x?=
 =?iso-8859-1?Q?bO0kvOYncUaFtrYOf8rsVEXMC5I4YLzLdSM1WwLs8WPotoDLnEkKd0B6XP?=
 =?iso-8859-1?Q?G3A3Dfugd5jOWaq3DPJaDghqPIypEQ4gM7ZMhjsC13AUDclErzszkNLCHU?=
 =?iso-8859-1?Q?uSOANo8Q36jK5ssTTtpgVNM2+3bd/bUq4c64pecXyq03crxF/sW6Mk2LZQ?=
 =?iso-8859-1?Q?HyXXwhIIVlIv8JchVmGJBi2y2Y0338G/upL9gpek8415Jgze+9KeDhoqGd?=
 =?iso-8859-1?Q?y/KgPsNB89OvCAhHpTW+7uKDlybvRXd9kUewtrsJL2/IZLcZ7rYa4cCeoZ?=
 =?iso-8859-1?Q?Z91MsuqD7+1Ca71GSrMDePRcKlyuXTrIVJL9G9QOn/ewv+uqC7L/WIto2u?=
 =?iso-8859-1?Q?cuDORjy93JEYkl+A36nfb0Cs5P2iMCX1h/zqi+a8YOmdh7XPXUkgG+pCiM?=
 =?iso-8859-1?Q?yPgdddaRzn5+mp4rTQkrdxh3yqe9krUHrLk73ySuMKV5Q6aL0RoQXiyXKG?=
 =?iso-8859-1?Q?q/8EOgYCCEiAh79jr4Svno6p/pKo1rHM4FLYWfPJngibzQJh6VtK?=
Content-Type: multipart/mixed;
	boundary="_005_MR1P264MB331494502C9D13D8A9EAFB99B7E82MR1P264MB3314FRAP_"
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: harfanglab.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f7f6bc-4511-4b73-edc6-08ded5ec9bb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2026 14:42:13.3831
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e072cd9e-210a-496b-aa68-c0965404b8f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gm0cLRFlncr7E23etirwKWKGbfpLjnxYnurnj+m2fIeqYDNinWk6badKZpRW3+GsOJhUpYh4GJP0j8a7heJdGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5115

--_005_MR1P264MB331494502C9D13D8A9EAFB99B7E82MR1P264MB3314FRAP_
Content-Type: multipart/alternative;
	boundary="_000_MR1P264MB331494502C9D13D8A9EAFB99B7E82MR1P264MB3314FRAP_"

--_000_MR1P264MB331494502C9D13D8A9EAFB99B7E82MR1P264MB3314FRAP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello BPF maintainers

I have stumbled upon what I believe is a kernel bug that occurs when a BPF =
program is executed
in specific conditions. The in-the-wild situation is a fairly large BPF pro=
gram that runs as a kretprobe,
and the crash happened on up-to-date debian13 computers, with the parameter=
 `net.core.bpf_jit_harden=3D2`.

I have managed to reduce the conditions to a fairly small reproducer (joine=
d to this mail), that does the
following:


  *
Call bpf_map_lookup_elem (1)
  *
Dereference the result if non null (2)
  *
Jump with a large enough offset (>=3D11000) over instructions using constan=
ts (3)

```
    0: .......... (62) *(u32 *)(r10 -4) =3D 0
    1: .......... (bf) r2 =3D r10
    2: ..2....... (07) r2 +=3D -4
    3: ..2....... (18) r1 =3D 0xffff8f0708cca200
    5: .12....... (85) call bpf_map_lookup_elem#1
    6: 0......... (15) if r0 =3D=3D 0x0 goto pc+1
    7: 0......... (79) r0 =3D *(u64 *)(r0 +0)
    8: .......... (b7) r0 =3D 0
    9: 0......... (15) if r0 =3D=3D 0x12345678 goto pc+11001
   10: 0......... (07) r0 +=3D 1
   11: 0......... (07) r0 +=3D 1
...
11009: 0......... (07) r0 +=3D 1
11010: .......... (b7) r0 =3D 0
11011: 0......... (95) exit
```

This program,  in most situations, will either be JIT compiled and run prop=
erly, or will be rejected with the
error ENOTSUPP. But on machines with:


  *
`CONFIG_BPF_JIT_ALWAYS_ON` not set
  *
`net.core.bpf_jit_harden=3D2`

the program will fail to be JIT compiled, will fallback to the interpreter,=
 and when executed, will cause
a invalid pointer dereference leading to a kernel panic.

To the best of my understanding, what happens is that:


  *
The JIT compiler will optimize the map lookup at (1)
  *
The JIT compiler will fail when reaching (3). This is because the JIT harde=
ning enables constant blinding, which triples the size of the jump, overflo=
wing 32767.
  *
Since the JIT compiler failed, and CONFIG_BPF_JIT_ALWAYS_ON is not set, the=
 kernel falls back to the interpreter
  *
When executed, the interpreter will badly interpret (1), I suppose due to s=
ome JIT optimization not being cleaned after the JIT compiler failure.
  *
This will leave R0 with an invalid value, which is dereferenced when the in=
terpreter reaches (2)

But of course this may not be what is happening, I am far from an expert an=
d you will know better than me.

This is easily reproducible on debian images, which do not set CONFIG_BPF_J=
IT_ALWAYS_ON. I have reproduced it on 6.12.74+deb13+1-amd64,
6.12.94+deb13-amd64 and 7.0.13+deb14-amd64. Setting `net.core.bpf_jit_harde=
n=3D2` and running the reproducer is enough to trigger the kernel panic.

I am not entirely sure when this bug was introduced, or if it is fixed on t=
he latest version. From some research, it may be related to this patch:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D7bdbf7446305

and there is a commit in review for bpf-next that mentions a fix for the af=
orementioned commit: `bpf: Disallow interpreter fallback for BPF_ADDR_PERCP=
U insn` in https://lore.kernel.org/bpf/20260622143557.22955-1-leon.hwang@li=
nux.dev/T/#t

that would indicate an impact since 6.10.

Joined to this mail are the reproducer for the issue, and the dmesg of a ke=
rnel panic caused by the reproducer on the standard debian image `debian-si=
d-nocloud-amd64-daily-20260629-2524.qcow2`.

Thank you for all your work and for your help on this matter.

Best Regards

Vincent Thiberville



--_000_MR1P264MB331494502C9D13D8A9EAFB99B7E82MR1P264MB3314FRAP_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, &quot;Aptos_Embe=
ddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
Hello BPF maintainers</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, &quot;Aptos_Embe=
ddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, &quot;Aptos_Embe=
ddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
I have stumbled upon what I believe is a kernel bug that occurs when a BPF =
program is executed</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, &quot;Aptos_Embe=
ddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
in specific conditions. The in-the-wild situation is a fairly large BPF pro=
gram that runs as a kretprobe,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, &quot;Aptos_Embe=
ddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
and the crash happened on up-to-date debian13 computers, with the parameter=
 `net.core.bpf_jit_harden=3D2`.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, &quot;Aptos_Embe=
ddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, &quot;Aptos_Embe=
ddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
I have managed to reduce the conditions to a fairly small reproducer (joine=
d to this mail), that does the</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, &quot;Aptos_Embe=
ddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
following:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, &quot;Aptos_Embe=
ddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<ul style=3D"margin-top: 0px; margin-bottom: 0px;" data-editing-info=3D"{&q=
uot;applyListStyleFromLevel&quot;:false,&quot;unorderedStyleType&quot;:2}">
<li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apto=
s_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px; list-style-type: &qu=
ot;- &quot;;">
<div class=3D"elementToProof" role=3D"presentation">Call bpf_map_lookup_ele=
m (1)</div>
</li><li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot=
;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px; list-style-type=
: &quot;- &quot;;">
<div class=3D"elementToProof" role=3D"presentation">Dereference the result =
if non null (2)</div>
</li><li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot=
;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px; list-style-type=
: &quot;- &quot;;">
<div class=3D"elementToProof" role=3D"presentation">Jump with a large enoug=
h offset (&gt;=3D11000) over instructions using constants (3)</div>
</li></ul>
<div style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apt=
os_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; co=
lor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
```</div>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: &quot;Couri=
er New&quot;, monospace; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; 0: .......... (62) *(u32 *)(r10 -4) =3D 0</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; 1: .......... (bf) r2 =3D r10</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; 2: ..2....... (07) r2 +=3D -4</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; 3: ..2....... (18) r1 =3D 0xffff8f0708cca200</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; 5: .12....... (85) call bpf_map_lookup_elem#1</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; 6: 0......... (15) if r0 =3D=3D 0x0 goto pc+1</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; 7: 0......... (79) r0 =3D *(u64 *)(r0 +0)</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; 8: .......... (b7) r0 =3D 0</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp; 9: 0......... (15) if r0 =3D=3D 0x12345678 goto pc+11001</div=
>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;10: 0......... (07) r0 +=3D 1</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);">
&nbsp; &nbsp;11: 0......... (07) r0 +=3D 1</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);">
...</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);">
11009: 0......... (07) r0 +=3D 1</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);">
11010: .......... (b7) r0 =3D 0</div>
<div class=3D"elementToProof" style=3D"font-family: &quot;Courier New&quot;=
, monospace; font-size: 12pt; color: rgb(0, 0, 0);">
11011: 0......... (95) exit</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, &quot;Aptos_Embe=
ddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
```</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, &quot;Aptos_Embe=
ddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-s=
erif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
This program,&nbsp; in most situations, will either be JIT compiled and run=
 properly, or will be rejected with the</div>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
error ENOTSUPP. But on machines with:</div>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
<br>
</div>
<ul style=3D"margin-top: 0px; margin-bottom: 0px;" data-editing-info=3D"{&q=
uot;applyListStyleFromLevel&quot;:false,&quot;unorderedStyleType&quot;:2}">
<li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apto=
s_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px; list-style-type: &qu=
ot;- &quot;;">
<div style=3D"margin-top: 0px; margin-bottom: 0px;" class=3D"elementToProof=
" role=3D"presentation">
`CONFIG_BPF_JIT_ALWAYS_ON` not set</div>
</li><li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot=
;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px; list-style-type=
: &quot;- &quot;;">
<div style=3D"margin-top: 0px; margin-bottom: 0px;" class=3D"elementToProof=
" role=3D"presentation">
`net.core.bpf_jit_harden=3D2`</div>
</li></ul>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
the program will fail to be JIT compiled, will fallback to the interpreter,=
 and when executed, will cause</div>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
a invalid pointer dereference leading to a kernel panic.</div>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
<br>
</div>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
To the best of my understanding, what happens is that:</div>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
<br>
</div>
<ul style=3D"margin-top: 0px; margin-bottom: 0px;" data-editing-info=3D"{&q=
uot;applyListStyleFromLevel&quot;:false,&quot;unorderedStyleType&quot;:2}">
<li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot;Apto=
s_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt; col=
or: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px; list-style-type: &qu=
ot;- &quot;;">
<div style=3D"margin-top: 0px; margin-bottom: 0px;" class=3D"elementToProof=
" role=3D"presentation">
The JIT compiler will optimize the map lookup at (1)</div>
</li><li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot=
;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px; list-style-type=
: &quot;- &quot;;">
<div style=3D"margin-top: 0px; margin-bottom: 0px;" class=3D"elementToProof=
" role=3D"presentation">
The JIT compiler will fail when reaching (3). This is because the JIT harde=
ning enables constant blinding, which triples the size of the jump, overflo=
wing 32767.</div>
</li><li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot=
;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px; list-style-type=
: &quot;- &quot;;">
<div style=3D"margin-top: 0px; margin-bottom: 0px;" class=3D"elementToProof=
" role=3D"presentation">
Since the JIT compiler failed, and CONFIG_BPF_JIT_ALWAYS_ON is not set, the=
 kernel falls back to the interpreter</div>
</li><li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot=
;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px; list-style-type=
: &quot;- &quot;;">
<div style=3D"margin-top: 0px; margin-bottom: 0px;" class=3D"elementToProof=
" role=3D"presentation">
When executed, the interpreter will badly interpret (1), I suppose due to s=
ome JIT optimization not being cleaned after the JIT compiler failure.</div=
>
</li><li style=3D"font-family: Aptos, &quot;Aptos_EmbeddedFont&quot;, &quot=
;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; font-size: 12pt=
; color: rgb(0, 0, 0); margin-top: 0px; margin-bottom: 0px; list-style-type=
: &quot;- &quot;;">
<div style=3D"margin-top: 0px; margin-bottom: 0px;" class=3D"elementToProof=
" role=3D"presentation">
This will leave R0 with an invalid value, which is dereferenced when the in=
terpreter reaches (2)</div>
</li></ul>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
But of course this may not be what is happening, I am far from an expert an=
d you will know better than me.</div>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
<br>
</div>
<div style=3D"margin-top: 0px; margin-bottom: 0px; font-family: Aptos, &quo=
t;Aptos_EmbeddedFont&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helve=
tica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementTo=
Proof">
This is easily reproducible on debian images, which do not set CONFIG_BPF_J=
IT_ALWAYS_ON. I have reproduced it on 6.12.74+deb13+1-amd64,&nbsp;</div>
<div style=3D"margin: 0px;" id=3D"C02U29APFKR-1781620989.182979-thread-list=
-Thread_1781627072.443529" class=3D"elementToProof">
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
6.12.94+deb13-amd64 and 7.0.13+deb14-amd64. Setting `net.core.bpf_jit_harde=
n=3D2` and running the reproducer is enough to trigger the kernel panic.</d=
iv>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
I am not entirely sure when this bug was introduced, or if it is fixed on t=
he latest version. From some research, it may be related to this patch:</di=
v>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<a href=3D"https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/commit/?id=3D7bdbf7446305" id=3D"OWA62801682-f19c-216e-4115-f7498d53dd6b=
" class=3D"OWAAutoLink">https://git.kernel.org/pub/scm/linux/kernel/git/tor=
valds/linux.git/commit/?id=3D7bdbf7446305</a></div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
and there is a commit in review for bpf-next that mentions a fix for the af=
orementioned commit: `bpf: Disallow interpreter fallback for BPF_ADDR_PERCP=
U insn` in
<a href=3D"https://lore.kernel.org/bpf/20260622143557.22955-1-leon.hwang@li=
nux.dev/T/#t" id=3D"OWA917ee2f0-6427-e15a-2665-f31c55b43341" class=3D"OWAAu=
toLink">
https://lore.kernel.org/bpf/20260622143557.22955-1-leon.hwang@linux.dev/T/#=
t</a></div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
that would indicate an impact since 6.10.</div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Joined to this mail are the reproducer for the issue, and the dmesg of a ke=
rnel panic caused by the reproducer on the standard debian image `debian-si=
d-nocloud-amd64-daily-20260629-2524.qcow2`.</div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Thank you for all your work and for your help on this matter.</div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Best Regards</div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
Vincent Thiberville</div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
<div style=3D"margin: 4px 0px; font-family: Aptos, &quot;Aptos_EmbeddedFont=
&quot;, &quot;Aptos_MSFontService&quot;, Calibri, Helvetica, sans-serif; fo=
nt-size: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
<br>
</div>
</div>
</body>
</html>

--_000_MR1P264MB331494502C9D13D8A9EAFB99B7E82MR1P264MB3314FRAP_--

--_005_MR1P264MB331494502C9D13D8A9EAFB99B7E82MR1P264MB3314FRAP_
Content-Type: text/x-csrc; name="repro.c"
Content-Description: repro.c
Content-Disposition: attachment; filename="repro.c"; size=9195;
	creation-date="Mon, 29 Jun 2026 14:25:33 GMT";
	modification-date="Mon, 29 Jun 2026 14:26:53 GMT"
Content-Transfer-Encoding: base64

LyoKICogUmVwcm9kdWNlciBmb3IgQlBGX0FERFJfUEVSQ1BVIGludGVycHJldGVyIGNyYXNoLgog
KgogKiBUaGlzIGlzIHJlcHJvZHVjZXIgZm9yIGEga2VybmVsLXBhbmljIHRoYXQgaGFwcGVucyB3
aGVuIHRoZSBrZXJuZWwKICogZXhlY3V0ZXMgYSBCUEYgcHJvZ3JhbSB0aGF0OgogKgogKiAtIHVz
ZXMgYSBwZXItY3B1IGFycmF5IG1hcAogKiAtIGlzIEpJVCBjb21waWxlZCwgYnV0IHRoZSBKSVQg
Y29tcGlsYXRpb24gZmFpbHMKICoKICogVGhpcyByZXN1bHRzIGluIHRoZSBrZXJuZWwgcnVubmlu
ZyB0aGUgQlBGIGludGVycHJldGVyIG9uIHRoZSBwcm9ncmFtLAogKiBidXQgbWlzLWludGVycHJl
dGluZyB0aGUgbWFwIGxvb2t1cCAocHJvYmFibHkgb3B0aW1pemVkIGJ5IHRoZSBKSVQKICogY29t
cGlsYXRpb24gYW5kIG5vdCBwcm9wZXJseSByb2xsZWQtYmFjayBhZnRlciBKSVQgY29tcGlsYXRp
b24gaGFzCiAqIGZhaWxlZCkuIFRoZSBtYXAgbG9va3VwIGlzIGEgbm8tb3AsIHRodXMgbm90IHBy
b3Blcmx5IHNldHRpbmcgUjAsCiAqIGFuZCBhY2Nlc3MgdG8gdGhpcyByZWdpc3RlciBjYW4gdGhl
biBjcmFzaC4KICoKICogVGhpcyByZXByb2R1Y2VyIHNldHMgdXAgYSBCUEYgcHJvZ3JhbSB0aGF0
IGxvb2tzIGxpa2UgdGhpczoKICoKICogYGBgCiAqIHIwID0gYnBmX21hcF9sb29rdXBfZWxlbSht
YXBfZmQsIDApOwogKiByMCA9IHIwID8gKnIwIDogMDsKICogaWYgKHIwICE9IDB4MTIzNDU2Nzgp
IHsKICogICAgIHIwICs9IDE7CiAqICAgICAuLi4gLy8gQ29waWVkIEpVTVBMRU4gdGltZXMKICog
ICAgIHIwICs9IDE7CiAqIH0KICogcjAgPSAwCiAqIGBgYAogKgogKiBXaGF0IHRoaXMgZG9lcyBp
czoKICoKICogLSBDYWxsIGJwZl9tYXBfbG9va3VwX2VsZW0sIGFuZCBkZXJlZiB0aGUgcmVzdWx0
CiAqIC0gU2V0dXAgYSBsb25nIGp1bXAgYWZ0ZXJ3YXJkcwogKgogKiBXaGVuIEpJVCBoYXJkZW5p
bmcgaXMgZW5hYmxlZCwgdGhlIGluc3RydWN0aW9ucyBpbnNpZGUgdGhlIGp1bXAKICogd2lsbCBp
bmNyZWFzZSBpbiBzaXplICgqMyBJIGJlbGlldmUpLCBtYWtpbmcgdGhlIGp1bXAgb2Zmc2V0IGlu
dmFsaWQsCiAqIGFuZCB0aHVzIG1ha2luZyB0aGUgSklUIGNvbXBpbGF0aW9uIGZhaWwuCiAqCiAq
IFRoZSBvdmVyYWxsIGJlaGF2aW9yIGlzLCB0byB0aGUgYmVzdCBvZiBteSB1bmRlcnN0YW5kaW5n
OgogKgogKiAtIElmIEpJVCBoYXJkZW5pbmcgaXMgZGlzYWJsZWQsIHRoaXMgcHJvZ3JhbSBpcyBK
SVQgY29tcGlsZWQgcHJvcGVybHksCiAqICAgYW5kIHRoZXJlIGlzIG5vIGJ1Zy4KICoKICogLSBJ
ZiBKSVQgaGFyZGVuaW5nIGlzIGVuYWJsZWQgdGhlbjoKICoKICogICAtIGNvbnN0YW50IGJpbmRp
bmcgd2lsbCBydW4sIGluY3JlYXNpbmcgdGhlIHNpemUgb2YgdGhlIGp1bXAgYnkgMwogKiAgIC0g
SklUIGNvbXBpbGF0aW9uIHdpbGwgb3B0aW1pemUgdGhlIHBlci1jcHUgYXJyYXkgbWFwIGxvb2t1
cAogKiAgIC0gSklUIGNvbXBpbGF0aW9uIHdpbGwgdGhlbiBmYWlsIG9uIHRoZSBqdW1wLCBhcyB0
aGUganVtcCBzaXplCiAqICAgICBvdmVyZmxvd3MgczE2LgogKiAgIC0gU2luY2UgSklUIGNvbXBp
bGF0aW9uIGZhaWxlZCwgdGhlIGludGVycHJldGVyIHdpbGwgYmUgdXNlZCwgYnV0CiAqICAgICB0
aGUgbWFwIGxvb2t1cCBvcHRpbWl6YXRpb25zIGFyZSBzdGlsbCBwcmVzZW50LgogKiAgIC0gV2hl
biB0aGUgcHJvZ3JhbSBpcyBleGVjdXRlZCwgdGhlIGV4ZWN1dGlvbiBvZiBtYXBfbG9va3VwX2Vs
ZW0KICogICAgIGlzIGJ1Z2d5IGFuZCByMCBpcyBub3QgcHJvcGVybHkgc2V0LiBXaGVuIGl0IGlz
IHRoZW4gZGVyZWZlcmVuY2VkLAogKiAgICAgdGhpcyByZXN1bHRzIGluIGEgY3Jhc2guCiAqLwoj
aW5jbHVkZSA8ZXJybm8uaD4KI2luY2x1ZGUgPGZjbnRsLmg+CiNpbmNsdWRlIDxuZXRpbmV0L2lu
Lmg+CiNpbmNsdWRlIDxzdGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CiNpbmNsdWRlIDxzdHJp
bmcuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8c3lzL3N5c2NhbGwuaD4KI2luY2x1
ZGUgPGxpbnV4L2JwZi5oPgoKI2RlZmluZSBCUEZfUkFXX0lOU04oQ09ERSwgRFNULCBTUkMsIE9G
RiwgSU1NKSBcCiAgICAgKChzdHJ1Y3QgYnBmX2luc24peyAuY29kZSA9IChDT0RFKSwgLmRzdF9y
ZWcgPSAoRFNUKSwgXAogICAgICAgICAgLnNyY19yZWcgPSAoU1JDKSwgLm9mZiA9IChPRkYpLCAu
aW1tID0gKElNTSkgfSkKCiNkZWZpbmUgQlBGX01PVjY0X1JFRyhEU1QsIFNSQykgXAogICAgIEJQ
Rl9SQVdfSU5TTihCUEZfQUxVNjQgfCBCUEZfTU9WIHwgQlBGX1gsIERTVCwgU1JDLCAwLCAwKQoj
ZGVmaW5lIEJQRl9NT1Y2NF9JTU0oRFNULCBJTU0pIFwKICAgICBCUEZfUkFXX0lOU04oQlBGX0FM
VTY0IHwgQlBGX01PViB8IEJQRl9LLCBEU1QsIDAsIDAsIElNTSkKI2RlZmluZSBCUEZfQUxVNjRf
SU1NKE9QLCBEU1QsIElNTSkgXAogICAgIEJQRl9SQVdfSU5TTihCUEZfQUxVNjQgfCAoT1ApIHwg
QlBGX0ssIERTVCwgMCwgMCwgSU1NKQojZGVmaW5lIEJQRl9TVF9NRU0oU1osIERTVCwgT0ZGLCBJ
TU0pIFwKICAgICBCUEZfUkFXX0lOU04oQlBGX1NUIHwgKFNaKSB8IEJQRl9NRU0sIERTVCwgMCwg
T0ZGLCBJTU0pCiNkZWZpbmUgQlBGX0xEWF9NRU0oU1osIERTVCwgU1JDLCBPRkYpIFwKICAgICBC
UEZfUkFXX0lOU04oQlBGX0xEWCB8IChTWikgfCBCUEZfTUVNLCBEU1QsIFNSQywgT0ZGLCAwKQoj
ZGVmaW5lIEJQRl9MRF9NQVBfRkQoRFNULCBGRCkgXAogICAgIEJQRl9SQVdfSU5TTihCUEZfTEQg
fCBCUEZfRFcgfCBCUEZfSU1NLCBEU1QsIEJQRl9QU0VVRE9fTUFQX0ZELCAwLCBGRCkKI2RlZmlu
ZSBCUEZfSk1QX0lNTShPUCwgRFNULCBJTU0sIE9GRikgXAogICAgIEJQRl9SQVdfSU5TTihCUEZf
Sk1QIHwgKE9QKSB8IEJQRl9LLCBEU1QsIDAsIE9GRiwgSU1NKQojZGVmaW5lIEJQRl9DQUxMX0ZV
TkMoSUQpIFwKICAgICBCUEZfUkFXX0lOU04oQlBGX0pNUCB8IEJQRl9DQUxMLCAwLCAwLCAwLCBJ
RCkKI2RlZmluZSBCUEZfRVhJVF8oKSBcCiAgICAgQlBGX1JBV19JTlNOKEJQRl9KTVAgfCBCUEZf
RVhJVCwgMCwgMCwgMCwgMCkKCi8qIOKUgOKUgCBIZWxwZXJzIOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgCAqLwoKc3RhdGljIGxvbmcgcmVhZF9zeXNj
dGwoY29uc3QgY2hhciAqcGF0aCkKewogICAgIGNoYXIgYnVmWzY0XTsKCiAgICAgaW50IGZkID0g
b3BlbihwYXRoLCBPX1JET05MWSk7CiAgICAgaWYgKGZkIDwgMCkgewogICAgICAgICByZXR1cm4g
LTE7CiAgICAgfQoKICAgICBpbnQgbiA9IHJlYWQoZmQsIGJ1Ziwgc2l6ZW9mKGJ1ZikgLSAxKTsK
ICAgICBjbG9zZShmZCk7CgogICAgIGlmIChuIDw9IDApIHsKICAgICAgICAgcmV0dXJuIC0xOwog
ICAgIH0KCiAgICAgYnVmW25dID0gJ1wwJzsKICAgICByZXR1cm4gc3RydG9sKGJ1ZiwgTlVMTCwg
MTApOwp9CgpzdGF0aWMgaW50IGlzX2ppdHRlZChpbnQgcHJvZ19mZCkKewogICAgIHN0cnVjdCBi
cGZfcHJvZ19pbmZvIGluZm8gPSB7fTsKICAgICB1bmlvbiBicGZfYXR0ciBhdHRyID0ge307Cgog
ICAgIGF0dHIuaW5mby5icGZfZmQgICA9IHByb2dfZmQ7CiAgICAgYXR0ci5pbmZvLmluZm9fbGVu
ID0gKHVpbnQzMl90KXNpemVvZihpbmZvKTsKICAgICBhdHRyLmluZm8uaW5mbyAgICAgPSAodWlu
dDY0X3QpJmluZm87CgogICAgIGlmIChzeXNjYWxsKF9fTlJfYnBmLCBCUEZfT0JKX0dFVF9JTkZP
X0JZX0ZELCAmYXR0ciwgc2l6ZW9mKGF0dHIpKSA8IDApIHsKICAgICAgICAgIHJldHVybiAtMTsK
ICAgICB9CgogICAgIHJldHVybiBpbmZvLmppdGVkX3Byb2dfbGVuID4gMDsKfQoKaW50IG1haW4o
dm9pZCkKewogICAgaW50IHByb2dfZmQgPSAwOwogICAgaW50IG1hcF9mZCA9IDA7CiAgICBpbnQg
c29jayA9IDA7CgogICAgcHJpbnRmKCJCUEZfQUREUl9QRVJDUFUgSklUIGJ1ZyByZXByb2R1Y2Vy
XG5cbiIpOwogICAgcHJpbnRmKCJXQVJOSU5HOiB0aGlzIFdJTEwgY3Jhc2ggdGhlIGtlcm5lbC4g
UnVuIGluIGEgZGlzcG9zYWJsZSBWTS5cblxuIik7CgogICAgbG9uZyBoYXJkZW4gPSByZWFkX3N5
c2N0bCgiL3Byb2Mvc3lzL25ldC9jb3JlL2JwZl9qaXRfaGFyZGVuIik7CiAgICBsb25nIGVuYWJs
ZSA9IHJlYWRfc3lzY3RsKCIvcHJvYy9zeXMvbmV0L2NvcmUvYnBmX2ppdF9lbmFibGUiKTsKICAg
IGxvbmcgbGltaXQgPSByZWFkX3N5c2N0bCgiL3Byb2Mvc3lzL25ldC9jb3JlL2JwZl9qaXRfbGlt
aXQiKTsKCiAgICBwcmludGYoIkN1cnJlbnQgY29uZmlnOiBicGZfaml0X2VuYWJsZT0lbGQgYnBm
X2ppdF9oYXJkZW49JWxkIGJwZl9qaXRfbGltaXQ9JWxkXG4iLAogICAgICAgICAgIGVuYWJsZSwg
aGFyZGVuLCBsaW1pdCk7CiAgICBpZiAoZW5hYmxlICE9IDEgfHwgaGFyZGVuICE9IDIpIHsKICAg
ICAgICBmcHJpbnRmKHN0ZGVyciwgIldBUk5JTkc6IE5lZWQgYnBmX2ppdF9lbmFibGU9MSBhbmQg
YnBmX2ppdF9oYXJkZW49Mi5cbiIpOwogICAgICAgIGZwcmludGYoc3RkZXJyLCAiV2l0aG91dCB0
aG9zZSBwYXJhbWV0ZXJzLCBidWcgd2lsbCB2ZXJ5IGxpa2VseSBub3QgdHJpZ2dlci5cblxuIik7
CiAgICB9CgogICAgLyogLS0tIENyZWF0ZSBwZXItY3B1IGFycmF5IG1hcCAtLS0gKi8KCiAgICB1
bmlvbiBicGZfYXR0ciBtYXR0ciA9IHt9OwogICAgbWF0dHIubWFwX3R5cGUgICAgPSBCUEZfTUFQ
X1RZUEVfUEVSQ1BVX0FSUkFZOwogICAgbWF0dHIua2V5X3NpemUgICAgPSA0OwogICAgbWF0dHIu
dmFsdWVfc2l6ZSAgPSA4OwogICAgbWF0dHIubWF4X2VudHJpZXMgPSAxOwoKICAgIG1hcF9mZCA9
IHN5c2NhbGwoX19OUl9icGYsIEJQRl9NQVBfQ1JFQVRFLCAmbWF0dHIsIHNpemVvZihtYXR0cikp
OwogICAgaWYgKG1hcF9mZCA8IDApIHsKICAgICAgICAgcGVycm9yKCJCUEZfTUFQX0NSRUFURSIp
OwogICAgICAgICBnb3RvIGNsZWFudXA7CiAgICB9CiAgICBwcmludGYoIkNyZWF0ZWQgcGVyLWNw
dSBhcnJheSBtYXAgKGZkICVkKVxuIiwgbWFwX2ZkKTsKCiAgICAvKiAtLS0gQ3JlYXRlIEJQRiBw
cm9ncmFtIC0tLSAqLwoKI2RlZmluZSBKVU1QTEVOIDExMDAwCiAgICAgc3RydWN0IGJwZl9pbnNu
ICpwcm9nID0gbWFsbG9jKChKVU1QTEVOICsgMTIpICogc2l6ZW9mKHN0cnVjdCBicGZfaW5zbikp
OwoKICAgIC8vIEZpcnN0IHBhcnQgaXMKICAgIC8vCiAgICAvLyBgYGAKICAgIC8vIHIwID0gYnBm
X21hcF9sb29rdXBfZWxlbShtYXBfZmQsIDApOwogICAgLy8gcjAgPSByMCA/ICpyMCA6IDA7CiAg
ICAvLyBgYGAKICAgIC8vCiAgICAvLyBpLmUuLCBjYWxsIGJwZl9tYXBfbG9va3VwX2VsZW0sIGFu
ZCBkZXJlZiB0aGUgcmVzdWx0LgogICAgLy8KICAgIC8vICooZnAtNCkgPSAwIC0tIHN0b3JlIDAg
b24gc3RhY2ssIHRoZSBrZXkKICAgIHByb2dbMF0gPSBCUEZfU1RfTUVNKEJQRl9XLCBCUEZfUkVH
XzEwLCAtNCwgMCk7CiAgICAvLyByMiA9ICZrZXkKICAgIHByb2dbMV0gPSBCUEZfTU9WNjRfUkVH
KEJQRl9SRUdfMiwgQlBGX1JFR18xMCk7CiAgICBwcm9nWzJdID0gQlBGX0FMVTY0X0lNTShCUEZf
QURELCBCUEZfUkVHXzIsIC00KTsKICAgIC8vIHIxID0gbWFwX2ZkCiAgICBwcm9nWzNdID0gQlBG
X0xEX01BUF9GRChCUEZfUkVHXzEsIG1hcF9mZCk7CiAgICBwcm9nWzRdID0gQlBGX1JBV19JTlNO
KDAsIDAsIDAsIDAsIDApOwogICAgLy8gcjAgPSBicGZfbWFwX2xvb2t1cF9lbGVtKHIxLCByMikK
ICAgIHByb2dbNV0gPSBCUEZfQ0FMTF9GVU5DKEJQRl9GVU5DX21hcF9sb29rdXBfZWxlbSk7CiAg
ICAvLyBpZiAoIXIwKSBnb3RvICsxCiAgICBwcm9nWzZdID0gQlBGX0pNUF9JTU0oQlBGX0pFUSwg
QlBGX1JFR18wLCAwLCAxKTsKICAgIC8vIHIwID0gKnIwCiAgICBwcm9nWzddID0gQlBGX0xEWF9N
RU0oQlBGX0RXLCBCUEZfUkVHXzAsIEJQRl9SRUdfMCwgMCk7CiAgICAvLyByMCA9IDAKICAgIHBy
b2dbOF0gPSBCUEZfTU9WNjRfSU1NKEJQRl9SRUdfMCwgMCk7CgogICAgLy8gU2Vjb25kIHBhcnQg
aXMKICAgIC8vCiAgICAvLyBgYGAKICAgIC8vIGlmIChyMCAhPSAweDEyMzQ1Njc4KSB7CiAgICAv
LyAgICAgcjAgKz0gMTsKICAgIC8vICAgICAuLi4gLy8gQ29waWVkIE4gdGltZXMKICAgIC8vICAg
ICByMCArPSAxOwogICAgLy8gfQogICAgLy8gcjAgPSAwOwogICAgLy8gYGBgCiAgICAvLwogICAg
Ly8gaS5lLiwgc2V0dXAgYSBqdW1wIG9mIGEgbG9uZyBlbm91Z2ggbGVuZ3RoLgogICAgcHJvZ1s5
XSA9IEJQRl9KTVBfSU1NKEJQRl9KRVEsIEJQRl9SRUdfMCwgMHgxMjM0NTY3OCwgSlVNUExFTiAr
IDEpOwogICAgZm9yIChpbnQgayA9IDA7IGsgPCBKVU1QTEVOOyBrKyspIHsKICAgICAgICBwcm9n
W2sgKyAxMF0gPSBCUEZfQUxVNjRfSU1NKEJQRl9BREQsIEJQRl9SRUdfMCwgMSk7CiAgICB9CiAg
ICBwcm9nW0pVTVBMRU4gKyAxMF0gPSBCUEZfTU9WNjRfSU1NKEJQRl9SRUdfMCwgMCk7CiAgICBw
cm9nW0pVTVBMRU4gKyAxMV0gPSBCUEZfRVhJVF8oKTsKCiNkZWZpbmUgTE9HU0laRSAxMDI0ICog
MTAyNAogICAgY2hhciAqbG9nX2J1ZiA9IG1hbGxvYyhMT0dTSVpFKTsKICAgIHVuaW9uIGJwZl9h
dHRyIHBhdHRyID0ge307CiAgICBwYXR0ci5wcm9nX3R5cGUgPSBCUEZfUFJPR19UWVBFX1NPQ0tF
VF9GSUxURVI7CiAgICBwYXR0ci5pbnNucyAgICAgPSAodWludDY0X3QpcHJvZzsKICAgIHBhdHRy
Lmluc25fY250ICA9IEpVTVBMRU4gKyAxMjsKICAgIHBhdHRyLmxpY2Vuc2UgICA9ICh1aW50NjRf
dCkiR1BMIjsKICAgIHBhdHRyLmxvZ19idWYgICA9ICh1aW50NjRfdClsb2dfYnVmOwogICAgcGF0
dHIubG9nX3NpemUgID0gTE9HU0laRTsKICAgIHBhdHRyLmxvZ19sZXZlbCA9IDE7CgogICAgcHJv
Z19mZCA9IHN5c2NhbGwoX19OUl9icGYsIEJQRl9QUk9HX0xPQUQsICZwYXR0ciwgc2l6ZW9mKHBh
dHRyKSk7CiAgICBpZiAocHJvZ19mZCA8IDApIHsKICAgICAgICAgZnByaW50ZihzdGRlcnIsICJG
YWlsZWQgdG8gbG9hZCBCUEYgcHJvZ3JhbTogJXNcbiIsIHN0cmVycm9yKGVycm5vKSk7CiAgICAg
ICAgIGZwcmludGYoc3RkZXJyLCAiVmVyaWZpZXI6XG4lc1xuIiwgbG9nX2J1Zik7CiAgICAgICAg
IGdvdG8gY2xlYW51cDsKICAgIH0KICAgIHByaW50ZigiTG9hZGVkIHRhcmdldCBCUEYgcHJvZ3Jh
bSAoZmQgJWQpXG4iLCBwcm9nX2ZkKTsKICAgIHByaW50ZigiVmVyaWZpZXI6XG4lc1xuIiwgbG9n
X2J1Zik7CgogICAgaW50IGppdHRlZCA9IGlzX2ppdHRlZChwcm9nX2ZkKTsKICAgIGlmIChqaXR0
ZWQgPCAwKSB7CiAgICAgICAgZnByaW50ZihzdGRlcnIsICJDb3VsZCBub3QgY2hlY2sgaWYgQlBG
IHByb2dyYW0gaXMgSklULWNvbXBpbGVkOiAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKICAgICAg
ICBnb3RvIGNsZWFudXA7CiAgICB9IGVsc2UgaWYgKGppdHRlZCA+IDApIHsKICAgICAgICBmcHJp
bnRmKHN0ZGVyciwgIkJQRiBwcm9ncmFtIHdhcyB1bmV4cGVjdGVkbHkgSklULWNvbXBpbGVkLCB0
aGUgYnVnIHdpbGwgbm90IG9jY3VyLiBBYm9ydGluZy5cbiIpOwogICAgICAgIGdvdG8gY2xlYW51
cDsKICAgIH0KCiAgICBwcmludGYoIkJQRiBwcm9ncmFtIGlzIElOVEVSUFJFVEVEIChKSVQgZmFp
bGVkIGFzIGV4cGVjdGVkKVxuIik7CgogICAgLyogUGhhc2UgMzogdHJpZ2dlciB2aWEgVURQIGxv
b3BiYWNrICovCiAgICBzb2NrID0gc29ja2V0KEFGX0lORVQsIFNPQ0tfREdSQU0sIDApOwogICAg
aWYgKHNvY2sgPCAwKSB7CiAgICAgICAgZnByaW50ZihzdGRlcnIsICJDb3VsZCBub3QgY3JlYXRl
IHNvY2tldDogJXNcbiIsIHN0cmVycm9yKGVycm5vKSk7CiAgICAgICAgZ290byBjbGVhbnVwOwog
ICAgfQoKICAgIHN0cnVjdCBzb2NrYWRkcl9pbiBhZGRyID0gewogICAgICAgICAuc2luX2ZhbWls
eSA9IEFGX0lORVQsCiAgICAgICAgIC5zaW5fYWRkci5zX2FkZHIgPSBodG9ubChJTkFERFJfTE9P
UEJBQ0spLAogICAgfTsKICAgIGlmIChiaW5kKHNvY2ssIChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRk
ciwgc2l6ZW9mKGFkZHIpKSA8IDApIHsKICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIkNvdWxkIG5v
dCBiaW5kIHNvY2tldDogJXNcbiIsIHN0cmVycm9yKGVycm5vKSk7CiAgICAgICAgZ290byBjbGVh
bnVwOwogICAgfQoKICAgIHNvY2tsZW5fdCBhbGVuID0gc2l6ZW9mKGFkZHIpOwogICAgZ2V0c29j
a25hbWUoc29jaywgKHN0cnVjdCBzb2NrYWRkciAqKSZhZGRyLCAmYWxlbik7CiAgICBpZiAoc2V0
c29ja29wdChzb2NrLCBTT0xfU09DS0VULCBTT19BVFRBQ0hfQlBGLCAmcHJvZ19mZCwgc2l6ZW9m
KHByb2dfZmQpKSA8IDApIHsKICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIkNvdWxkIG5vdCBhdHRh
Y2ggQlBGIHByb2dyYW0gdG8gc29ja2V0OiAlc1xuIiwgc3RyZXJyb3IoZXJybm8pKTsKICAgICAg
ICBnb3RvIGNsZWFudXA7CiAgICB9CgogICAgcHJpbnRmKCJTZW5kaW5nIFVEUCBwYWNrZXQgdG8g
dHJpZ2dlciB0aGUgQlBGIHByb2dyYW0uLi5cbiIpOwogICAgcHJpbnRmKCJJZiB0aGUgYnVnIGlz
IHByZXNlbnQsIHRoZSBrZXJuZWwgY3Jhc2hlcyBOT1cuXG4iKTsKCiAgICBpZiAoc2VuZHRvKHNv
Y2ssICJ4IiwgMSwgMCwgKHN0cnVjdCBzb2NrYWRkciAqKSZhZGRyLCBzaXplb2YoYWRkcikpIDwg
MCkgewogICAgICAgIGZwcmludGYoc3RkZXJyLCAiQ291bGQgbm90IHNlbmQgVURQIHBhY2tldDog
JXNcbiIsIHN0cmVycm9yKGVycm5vKSk7CiAgICAgICAgZ290byBjbGVhbnVwOwogICAgfQoKICAg
IGNoYXIgYnVmWzFdOwogICAgcmVjdihzb2NrLCBidWYsIDEsIE1TR19ET05UV0FJVCk7CgogICAg
cHJpbnRmKCJObyBjcmFzaCDigJQgVGhlIGtlcm5lbCBpcyBlaXRoZXIgdG9vIG9sZCBvciBoYXMg
YSBmaXguXG4iKTsKCmNsZWFudXA6CiAgICBpZiAoc29jayA+IDApIHsKICAgICAgICBjbG9zZShz
b2NrKTsKICAgIH0KICAgIGlmIChwcm9nX2ZkID4gMCkgewogICAgICAgIGNsb3NlKHByb2dfZmQp
OwogICAgfQogICAgaWYgKG1hcF9mZCA+IDApIHsKICAgICAgICBjbG9zZShtYXBfZmQpOwogICAg
fQogICAgcmV0dXJuIDA7Cn0K

--_005_MR1P264MB331494502C9D13D8A9EAFB99B7E82MR1P264MB3314FRAP_
Content-Type: application/octet-stream; name="dmesg"
Content-Description: dmesg
Content-Disposition: attachment; filename="dmesg"; size=6887;
	creation-date="Mon, 29 Jun 2026 14:37:56 GMT";
	modification-date="Mon, 29 Jun 2026 14:38:56 GMT"
Content-Transfer-Encoding: base64

WyAgICAwLjAwMDAwMF0gWyAgICAgIFQwXSBMaW51eCB2ZXJzaW9uIDcuMC4xMytkZWIxNC1hbWQ2
NCAoZGViaWFuLWtlcm5lbEBsaXN0cy5kZWJpYW4ub3JnKSAoeDg2XzY0LWxpbnV4LWdudS1nY2Mt
MTUgKERlYmlhbiAxNS4zLjAtMSkgMTUuMy4wLCBHTlUgbGQgKEdOVSBCaW51dGlscyBmb3IgRGVi
aWFuKSAyLjQ2LjUwLjIwMjYwNjE3KSAjMSBTTVAgUFJFRU1QVF9EWU5BTUlDIERlYmlhbiA3LjAu
MTMtMSAoMjAyNi0wNi0xOSkKWyAgICAwLjAwMDAwMF0gWyAgICAgIFQwXSBDb21tYW5kIGxpbmU6
IEJPT1RfSU1BR0U9L2Jvb3Qvdm1saW51ei03LjAuMTMrZGViMTQtYW1kNjQgcm9vdD1QQVJUVVVJ
RD0xZmVmOTA0MC1kOGQ0LTRhOTEtOWQyMC0xN2VlZGM3ZWM1YTUgcm8gY29uc29sZT10dHkwIGNv
bnNvbGU9dHR5UzAsMTE1MjAwIGVhcmx5cHJpbnRrPXR0eVMwLDExNTIwMCBjb25zb2xlYmxhbms9
MCBjcmFzaGtlcm5lbD0yNTZNIGNyYXNoa2VybmVsPTUxMk0tOjE5Mk0KLi4uClsgICA1MC4xNjQ5
NTVdIFsgICAgIEMxMl0gQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2UgZmF1bHQgZm9yIGFkZHJl
c3M6IDAwMDA2M2MxODY0ODQ4MTAKWyAgIDUwLjE2NTk5OV0gWyAgICAgQzEyXSAjUEY6IHN1cGVy
dmlzb3IgcmVhZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUKWyAgIDUwLjE2NjgxMF0gWyAgICAgQzEy
XSAjUEY6IGVycm9yX2NvZGUoMHgwMDAwKSAtIG5vdC1wcmVzZW50IHBhZ2UKWyAgIDUwLjE2NzM5
N10gWyAgICAgQzEyXSBQR0QgMCBQNEQgMCAKWyAgIDUwLjE2Nzc2OF0gWyAgICAgQzEyXSBPb3Bz
OiBPb3BzOiAwMDAwIFsjMV0gU01QIE5PUFRJClsgICA1MC4xNjgyNTNdIFsgICAgIEMxMl0gQ1BV
OiAxMiBVSUQ6IDAgUElEOiAxMTUxIENvbW06IGdvb2QtcmVwcm8gS2R1bXA6IGxvYWRlZCBOb3Qg
dGFpbnRlZCA3LjAuMTMrZGViMTQtYW1kNjQgIzEgUFJFRU1QVChsYXp5KSAgRGViaWFuIDcuMC4x
My0xIApbICAgNTAuMTY5Njc0XSBbICAgICBDMTJdIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRh
cmQgUEMgKGk0NDBGWCArIFBJSVgsIDE5OTYpLCBCSU9TIEFyY2ggTGludXggMS4xNy4wLTItMiAw
NC8wMS8yMDE0ClsgICA1MC4xNzA3MjFdIFsgICAgIEMxMl0gUklQOiAwMDEwOl9fX2JwZl9wcm9n
X3J1bisweDJlMC8weDIzNzAKWyAgIDUwLjE3MTI3OV0gWyAgICAgQzEyXSBDb2RlOiAwMCA0OCA4
MyBjMyAwOCBlOSA1MyBmZCBmZiBmZiBmMyAwZiAxZSBmYSAwZiBiNiA0MyAwMSA0OCAwZiBiZiA0
YiAwMiA0OCA4MyBjMyAwOCA4OSBjMiA4MyBlMCAwZiBjMCBlYSAwNCAwZiBiNiBkMiA0OSA4YiAx
NCBkNCA8NDg+IDhiIDE0IDBhIDQ5IDg5IDE0IGM0IGU5IDI2IGZkIGZmIGZmIGYzIDBmIDFlIGZh
IDBmIGI2IDQzIDAxIDQ4ClsgICA1MC4xNzMzNTZdIFsgICAgIEMxMl0gUlNQOiAwMDE4OmZmZmZk
MDFkODAzOWNiZDggRUZMQUdTOiAwMDAxMDI0NgpbICAgNTAuMTczOTgwXSBbICAgICBDMTJdIFJB
WDogMDAwMDAwMDAwMDAwMDAwMCBSQlg6IGZmZmZkMDFkODMxMjEwZTAgUkNYOiAwMDAwMDAwMDAw
MDAwMDAwClsgICA1MC4xNzQ5MjldIFsgICAgIEMxMl0gUkRYOiAwMDAwNjNjMTg2NDg0ODEwIFJT
STogMDAwMDAwMDAwMDAwMDA3OSBSREk6IGZmZmZkMDFkODAzOWNjMjAKWyAgIDUwLjE3NTc3Ml0g
WyAgICAgQzEyXSBSQlA6IDAwMDAwMDAwMDAwMDAwMDAgUjA4OiBmZmZmOGM1YjA3NTJlODAwIFIw
OTogZmZmZjhjNWIwZmFkM2YwMApbICAgNTAuMTc2NTg5XSBbICAgICBDMTJdIFIxMDogZmZmZjhj
NWIwYTE1NTU2NCBSMTE6IGZmZmY4YzViMGZhZDNmMDAgUjEyOiBmZmZmZDAxZDgwMzljYzIwClsg
ICA1MC4xNzczODNdIFsgICAgIEMxMl0gUjEzOiAwMDAwMDAwMDAwMDAwMDAwIFIxNDogZmZmZjhj
NWIwMzBmODU0MCBSMTU6IDAwMDAwMDAwMDAwMDAwMDgKWyAgIDUwLjE3ODIxOF0gWyAgICAgQzEy
XSBGUzogIDAwMDA3ZjVjNjUyNWM3ODAoMDAwMCkgR1M6ZmZmZjhjNWJmOTg3ZDAwMCgwMDAwKSBr
bmxHUzowMDAwMDAwMDAwMDAwMDAwClsgICA1MC4xNzkxMTddIFsgICAgIEMxMl0gQ1M6ICAwMDEw
IERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpbICAgNTAuMTc5NzY5XSBb
ICAgICBDMTJdIENSMjogMDAwMDYzYzE4NjQ4NDgxMCBDUjM6IDAwMDAwMDAwMDcwOTEwMDYgQ1I0
OiAwMDAwMDAwMDAwZjcyZWYwClsgICA1MC4xODA1ODBdIFsgICAgIEMxMl0gUEtSVTogNTU1NTU1
NTQKWyAgIDUwLjE4MDkwMl0gWyAgICAgQzEyXSBDYWxsIFRyYWNlOgpbICAgNTAuMTgxMjI0XSBb
ICAgICBDMTJdICA8SVJRPgpbICAgNTAuMTgxNTc4XSBbICAgICBDMTJdICBfX2JwZl9wcm9nX3J1
bjMyKzB4NjkvMHg5MApbICAgNTAuMTgyMDM5XSBbICAgICBDMTJdICBza19maWx0ZXJfdHJpbV9j
YXArMHgxN2YvMHgzYjAKWyAgIDUwLjE4MjUzMV0gWyAgICAgQzEyXSAgdWRwX3F1ZXVlX3Jjdl9v
bmVfc2tiKzB4MTIxLzB4NTIwClsgICA1MC4xODMyMjFdIFsgICAgIEMxMl0gIHVkcF91bmljYXN0
X3Jjdl9za2IrMHg3NC8weDkwClsgICA1MC4xODM2NzVdIFsgICAgIEMxMl0gIF9fdWRwNF9saWJf
cmN2KzB4YjE0LzB4ZWMwClsgICA1MC4xODQwODNdIFsgICAgIEMxMl0gID8gZnJlZV9mcm96ZW5f
cGFnZV9jb21taXQuaXNyYS4wKzB4YTUvMHg0YTAKWyAgIDUwLjE4NDY1MV0gWyAgICAgQzEyXSAg
PyByYXdfbG9jYWxfZGVsaXZlcisweGNlLzB4MmQwClsgICA1MC4xODUwODVdIFsgICAgIEMxMl0g
IGlwX3Byb3RvY29sX2RlbGl2ZXJfcmN1KzB4Y2QvMHgxYjAKWyAgIDUwLjE4NTUwN10gWyAgICAg
QzEyXSAgaXBfbG9jYWxfZGVsaXZlcl9maW5pc2grMHg4NS8weDEwMApbICAgNTAuMTg1OTk5XSBb
ICAgICBDMTJdICBfX25ldGlmX3JlY2VpdmVfc2tiX29uZV9jb3JlKzB4ODUvMHhhMApbICAgNTAu
MTg2NDM2XSBbICAgICBDMTJdICBwcm9jZXNzX2JhY2tsb2crMHg4Ny8weDEzMApbICAgNTAuMTg2
Nzg4XSBbICAgICBDMTJdICBfX25hcGlfcG9sbCsweDMwLzB4MjAwClsgICA1MC4xODcxMDZdIFsg
ICAgIEMxMl0gID8gc2tiX2RlZmVyX2ZyZWVfZmx1c2grMHg5Yy8weGMwClsgICA1MC4xODc0NTZd
IFsgICAgIEMxMl0gIG5ldF9yeF9hY3Rpb24rMHgyZmUvMHgzZjAKWyAgIDUwLjE4Nzc2M10gWyAg
ICAgQzEyXSAgaGFuZGxlX3NvZnRpcnFzKzB4ZDgvMHgzNDAKWyAgIDUwLjE4ODA3M10gWyAgICAg
QzEyXSAgZG9fc29mdGlycS5wYXJ0LjArMHgzYi8weDYwClsgICA1MC4xODgzODZdIFsgICAgIEMx
Ml0gIDwvSVJRPgpbICAgNTAuMTg4NTQ1XSBbICAgICBDMTJdICA8VEFTSz4KWyAgIDUwLjE4ODcw
Nl0gWyAgICAgQzEyXSAgX19sb2NhbF9iaF9lbmFibGVfaXArMHg2MC8weDcwClsgICA1MC4xODg5
OTRdIFsgICAgIEMxMl0gIF9fZGV2X3F1ZXVlX3htaXQrMHgyYzQvMHgxMGIwClsgICA1MC4xODky
NzZdIFsgICAgIEMxMl0gID8gYXJwX2NvbnN0cnVjdG9yKzB4MTM3LzB4MmUwClsgICA1MC4xODk1
OTBdIFsgICAgIEMxMl0gID8gX3Jhd19zcGluX3VubG9ja19iaCsweGUvMHgyMApbICAgNTAuMTg5
ODc4XSBbICAgICBDMTJdICA/IF9fX25laWdoX2NyZWF0ZSsweDcwOS8weGEzMApbICAgNTAuMTkw
MTI5XSBbICAgICBDMTJdICA/IGV0aF9oZWFkZXIrMHgyYS8weGMwClsgICA1MC4xOTAzNDhdIFsg
ICAgIEMxMl0gIGlwX2ZpbmlzaF9vdXRwdXQyKzB4MWMzLzB4NjYwClsgICA1MC4xOTA5MDBdIFsg
ICAgIEMxMl0gID8gX19pcF9maW5pc2hfb3V0cHV0KzB4NDYvMHgxNzAKWyAgIDUwLjE5MTMwNV0g
WyAgICAgQzEyXSAgaXBfb3V0cHV0KzB4NjMvMHgxMTAKWyAgIDUwLjE5MTYyMV0gWyAgICAgQzEy
XSAgPyBfX3BmeF9pcF9maW5pc2hfb3V0cHV0KzB4MTAvMHgxMApbICAgNTAuMTkxOTMzXSBbICAg
ICBDMTJdICBpcF9zZW5kX3NrYisweDg5LzB4YTAKWyAgIDUwLjE5MjE5Nl0gWyAgICAgQzEyXSAg
dWRwX3NlbmRfc2tiKzB4MWE3LzB4M2MwClsgICA1MC4xOTI0NjhdIFsgICAgIEMxMl0gID8gdWRw
X3NlbmRtc2crMHhhMWMvMHhkZjAKWyAgIDUwLjE5Mjc0Nl0gWyAgICAgQzEyXSAgPyB1ZHBfc2Vu
ZG1zZysweGExYy8weGRmMApbICAgNTAuMTkzMDU4XSBbICAgICBDMTJdICB1ZHBfc2VuZG1zZysw
eGE0MC8weGRmMApbICAgNTAuMTkzMzIxXSBbICAgICBDMTJdICA/IF9fcGZ4X2lwX2dlbmVyaWNf
Z2V0ZnJhZysweDEwLzB4MTAKWyAgIDUwLjE5MzYzN10gWyAgICAgQzEyXSAgX19zeXNfc2VuZHRv
KzB4MWNhLzB4MWUwClsgICA1MC4xOTM4NzRdIFsgICAgIEMxMl0gIF9feDY0X3N5c19zZW5kdG8r
MHgyNC8weDMwClsgICA1MC4xOTQxMTJdIFsgICAgIEMxMl0gIGRvX3N5c2NhbGxfNjQrMHhjZC8w
eDE1ZjAKWyAgIDUwLjE5NDM0Ml0gWyAgICAgQzEyXSAgPyBrc3lzX3dyaXRlKzB4NzMvMHhmMApb
ICAgNTAuMTk0NTY3XSBbICAgICBDMTJdICA/IGRvX3N5c2NhbGxfNjQrMHgxMGEvMHgxNWYwClsg
ICA1MC4xOTQ4MDRdIFsgICAgIEMxMl0gID8ga3N5c193cml0ZSsweDczLzB4ZjAKWyAgIDUwLjE5
NTAyMV0gWyAgICAgQzEyXSAgPyBkb19zeXNjYWxsXzY0KzB4MTBhLzB4MTVmMApbICAgNTAuMTk1
MjU1XSBbICAgICBDMTJdICA/IF9faGFuZGxlX21tX2ZhdWx0KzB4OTQ2LzB4ZjUwClsgICA1MC4x
OTU1MDJdIFsgICAgIEMxMl0gID8gX3Jhd19zcGluX3VubG9ja19pcnFyZXN0b3JlKzB4ZS8weDQw
ClsgICA1MC4xOTU3NzNdIFsgICAgIEMxMl0gID8gX193YWtlX3VwKzB4NDQvMHg2MApbICAgNTAu
MTk1OTg4XSBbICAgICBDMTJdICA/IGNvdW50X21lbWNnX2V2ZW50cysweGViLzB4MjIwClsgICA1
MC4xOTYyMzVdIFsgICAgIEMxMl0gID8gaGFuZGxlX21tX2ZhdWx0KzB4MWUxLzB4MmYwClsgICA1
MC4xOTY0NzBdIFsgICAgIEMxMl0gID8gZG9fdXNlcl9hZGRyX2ZhdWx0KzB4MmI0LzB4N2IwClsg
ICA1MC4xOTY3MThdIFsgICAgIEMxMl0gID8gaXJxZW50cnlfZXhpdCsweDc4LzB4NjgwClsgICA1
MC4xOTY5NDRdIFsgICAgIEMxMl0gID8gZXhjX3BhZ2VfZmF1bHQrMHg4Mi8weDFkMApbICAgNTAu
MTk3MTcyXSBbICAgICBDMTJdICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUrMHg3Ni8w
eDdlClsgICA1MC4xOTc0NDddIFsgICAgIEMxMl0gUklQOiAwMDMzOjB4N2Y1YzY1MmYwY2IyClsg
ICA1MC4xOTc3MzVdIFsgICAgIEMxMl0gQ29kZTogMTggNDEgOGIgOTMgMDggMDMgMDAgMDAgNTkg
NWUgNDggODMgZjggZmMgNzUgMWEgODMgZTIgMzkgODMgZmEgMDggNzUgMTIgZTggMmIgZmYgZmYg
ZmYgMGYgMWYgMDAgNDkgODkgY2EgNDggOGIgNDQgMjQgMjAgMGYgMDUgPDQ4PiA4MyBjNCAxOCBj
MyA2NiAwZiAxZiA4NCAwMCAwMCAwMCAwMCAwMCA0OCA4MyBlYyAxMCBmZiA3NCAyNCAxOApbICAg
NTAuMTk4NjM4XSBbICAgICBDMTJdIFJTUDogMDAyYjowMDAwN2ZmZmEwZmFjZDAwIEVGTEFHUzog
MDAwMDAyMDIgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwMmMKWyAgIDUwLjE5OTAyNV0gWyAgICAg
QzEyXSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgUkJYOiAwMDAwMDAwMDAwMDAwMDAwIFJDWDogMDAw
MDdmNWM2NTJmMGNiMgpbICAgNTAuMTk5Mzg4XSBbICAgICBDMTJdIFJEWDogMDAwMDAwMDAwMDAw
MDAwMSBSU0k6IDAwMDA1NjNlOWU4MGYzY2YgUkRJOiAwMDAwMDAwMDAwMDAwMDA1ClsgICA1MC4x
OTk3NTRdIFsgICAgIEMxMl0gUkJQOiAwMDAwN2ZmZmEwZmFjZjIwIFIwODogMDAwMDdmZmZhMGZh
Y2RhMCBSMDk6IDAwMDAwMDAwMDAwMDAwMTAKWyAgIDUwLjIwMDExNl0gWyAgICAgQzEyXSBSMTA6
IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMjAyIFIxMjogMDAwMDAwMDAwMDAw
MDAwMQpbICAgNTAuMjAwNDc5XSBbICAgICBDMTJdIFIxMzogMDAwMDdmNWM2NTQ5YTAwMCBSMTQ6
IDAwMDA3ZmZmYTBmYWQwNDggUjE1OiAwMDAwNTYzZTllODEwZGQ4ClsgICA1MC4yMDA4NTBdIFsg
ICAgIEMxMl0gIDwvVEFTSz4KWyAgIDUwLjIwMTAyNV0gWyAgICAgQzEyXSBNb2R1bGVzIGxpbmtl
ZCBpbjogZG1fbW9kIG5mbmV0bGluayBjZmc4MDIxMSByZmtpbGwgcHBkZXYgaW50ZWxfcmFwbF9t
c3IgaW50ZWxfcmFwbF9jb21tb24gaW50ZWxfdW5jb3JlX2ZyZXF1ZW5jeV9jb21tb24gaW50ZWxf
cG1jX2NvcmUgbmxzX2FzY2lpIHBtdF90ZWxlbWV0cnkgcG10X2Rpc2NvdmVyeSBubHNfY3A0Mzcg
cG10X2NsYXNzIHZmYXQgaW50ZWxfcG1jX3NzcmFtX3RlbGVtZXRyeSBmYXQgaW50ZWxfdnNlYyBi
aW5mbXRfbWlzYyBrdm1faW50ZWwga3ZtIGlycWJ5cGFzcyByYXBsIHNuZF9oZGFfY29kZWNfZ2Vu
ZXJpYyBzbmRfaGRhX2ludGVsIHNuZF9oZGFfY29kZWMgc25kX2hkYV9jb3JlIHNuZF9pbnRlbF9k
c3BjZmcgc25kX2ludGVsX3Nkd19hY3BpIHNuZF9od2RlcCBzbmRfcGNtIGJvY2hzIHNuZF90aW1l
ciBkcm1fY2xpZW50X2xpYiBzbmQgdmdhMTZmYiBwYXJwb3J0X3BjIGRybV9zaG1lbV9oZWxwZXIg
aTJjX3BpaXg0IHNvdW5kY29yZSB2Z2FzdGF0ZSBwYXJwb3J0IGUxMDAwIHNnIGkyY19zbWJ1cyBk
cm1fa21zX2hlbHBlciBwY3Nwa3Igam95ZGV2IGJ1dHRvbiBldmRldiBkcm0gZWZpX3BzdG9yZSBj
b25maWdmcyB2c29ja19sb29wYmFjayB2bXdfdnNvY2tfdmlydGlvX3RyYW5zcG9ydF9jb21tb24g
dm13X3Zzb2NrX3ZtY2lfdHJhbnNwb3J0IHZzb2NrIHZtd192bWNpIGV4dDQgY3JjMTYgbWJjYWNo
ZSBqYmQyIGNyYzMyY19jcnlwdG9hcGkgc3JfbW9kIHNkX21vZCBjZHJvbSBhdGFfZ2VuZXJpYyBh
dGFfcGlpeCBsaWJhdGEgcHNtb3VzZSBzY3NpX21vZCBmbG9wcHkgZ2hhc2hfY2xtdWxuaV9pbnRl
bCBzY3NpX2NvbW1vbiBzZXJpb19yYXcgcWVtdV9md19jZmcgYXV0b2ZzNCBhZXNuaV9pbnRlbApb
ICAgNTAuMjA0NTg2XSBbICAgICBDMTJdIENSMjogMDAwMDYzYzE4NjQ4NDgxMAo=

--_005_MR1P264MB331494502C9D13D8A9EAFB99B7E82MR1P264MB3314FRAP_--
