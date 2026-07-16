Received: from MRZP264CU002.outbound.protection.outlook.com (mail-francesouthazon11020107.outbound.protection.outlook.com [52.101.165.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231FC2ED84A
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.165.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201273; cv=fail; b=ZFEAontTl6pqFvFin9J7wCDPwP0v/Iui98EoDpTEpiiyHSEwIM6X1ZvTFzfmomhzW+gjup/2SoiYRAgYSXyzd9N8gQyLnjr/gWzMK0KlMc9KoTJEhpMac6lYVDgvSSd9n8THTLZK9IdiyhVhOy0W6iDdCtSSGk1k2KmocnmXb3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201273; c=relaxed/simple;
	bh=iAidOtlqUDTjOcvInlMyXu0bUcJGJzjfYL5v+p54Gks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TrjVC6KMZ7S1Qgmzop4WHdH92QrN0PBWMgFPxnulr6QfZhH3LAQUZLLZUlV7Il/WMHYQPVjoFl2RBlBDZQmpvbDLTQjVlNX3qgzajd1V7kgioF7cGGeHgLDbMBnBOG8xFZou1oX7NoT/bO2g31Tc9+cC3I5cY8BhzGLeD6rqUt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=harfanglab.fr; spf=pass smtp.mailfrom=harfanglab.fr; dkim=pass (1024-bit key) header.d=harfanglab.fr header.i=@harfanglab.fr header.b=mTmRvCcw; arc=fail smtp.client-ip=52.101.165.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=harfanglab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harfanglab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harfanglab.fr header.i=@harfanglab.fr header.b="mTmRvCcw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWL2JBdAzd7JJpkzpxyncKk9flA3Rmv3dw9TZDZVovaLkG1gJBvpMSsiZGoUJX5UTQJuhufxL82iuPGy8LDOAjESp00dfn9b2i1WaLbRLTW8fb97ee+mbKp/3voN1Ee85XTPC8cOgqWX28rnuqNt4hUMVuzbAueA71BkYRAcYh5CXwxoIyUEFl3J1fBxW+EqHDZbCoP4CIFzww7WIRdnL3TBEtx0wNFnl1ViTTqFguMU2TlEAAxOPOlZ1h/kpuGV9va8wri5hrZBLaL9fy06D1/Le4MCQ9+QWdUO0qfn7CNhNow5kZpdr7ctVxUgVePLIeDRJg52HaFU0/lyKx4wzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iAidOtlqUDTjOcvInlMyXu0bUcJGJzjfYL5v+p54Gks=;
 b=sIDFOjp3V8qn9rUBavpo/4yQ5M/+Puk8EW13Xi4dmaE7G+yhuLWc4q5wh8N/70XMqmdydhj41vYQrql9dmqYYEdhhUm8O0UmggrRK3/x01qDVcHYLsYka1gAH6SUk9jEjdDs9YtmJyCYVfiVqHnSKWBGB0nlmQ8ph6cA4ApgPXECY+VKJfsUQXiqzGJHQJGkNugg3FirJvCjMQGGhhDBJK0dSrXOEwm3pL7F1Udd2Nlnd5jS0uXjqIvnRRCyHAMeSxhTsS9nq5p2nsigouV8hny4ru/Xh0oE1dnCdgFcz1ktGSK5//pihhsdmrCjATknZ+o7aS/KWgJTHvTdUrAAKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=harfanglab.fr; dmarc=pass action=none
 header.from=harfanglab.fr; dkim=pass header.d=harfanglab.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harfanglab.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAidOtlqUDTjOcvInlMyXu0bUcJGJzjfYL5v+p54Gks=;
 b=mTmRvCcw349J815oiJYmV37/FO3492CqhYUTJKU9xnY1cI+h3pbVtrgO+xTc+HfMGa4V2VS/NUPhDRzCUrMH/n+8eOrYJTMuvCmLw3LCocjaIeT68ymG3n/seY9AIRxdrLFMPtxcS8k1ZSkmaQQmlxsoULCuwfz0Cr+7Zgqf7O8=
Received: from MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:28::14)
 by PARP264MB6867.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:55b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Thu, 16 Jul
 2026 11:27:47 +0000
Received: from MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7d89:c984:624d:9689]) by MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7d89:c984:624d:9689%6]) with mapi id 15.21.0223.011; Thu, 16 Jul 2026
 11:27:47 +0000
From: Vincent Thiberville <vincent@harfanglab.fr>
To: Leon Hwang <leon.hwang@linux.dev>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: PROBLEM: BPF interpreter fallback after JIT compilation of
 BPF_ADDR_PERCPU leads to kernel panic
Thread-Topic: PROBLEM: BPF interpreter fallback after JIT compilation of
 BPF_ADDR_PERCPU leads to kernel panic
Thread-Index: AQHdB8yzqGrNWEhQ9U+ot25Rw6XY5rZWVYcAgACsKdaAAPcQgIAYISD5
Date: Thu, 16 Jul 2026 11:27:46 +0000
Message-ID:
 <MR1P264MB331493FEEA2ACE6C2AEA5EB9B7C72@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
References:
 <MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
 <d255172d-d9e9-4116-9243-975cf4bdf3d0@linux.dev>
 <MR1P264MB33143D31DA8982ADB2E0D808B7F72@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
 <90c32de0-feac-4e63-9757-2a1d115be08c@linux.dev>
In-Reply-To: <90c32de0-feac-4e63-9757-2a1d115be08c@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=harfanglab.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB3314:EE_|PARP264MB6867:EE_
x-ms-office365-filtering-correlation-id: 59666c6a-f58a-4f4c-827c-08dee32d42fc
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|6133799003|38070700021|10067099003|56012099006|55112099003|18002099003|22082099003|11063799006|4143699003;
x-microsoft-antispam-message-info:
 jkvQLICG4ITZJDkVPWkATc7DyOdSn3CHrUJRbug67m7whphiuUbzhkyDaaMsomvsnUkOYAm7DKCQXRyBHIsag576RAA7KoA1pgiZasVYqofiiAbsp697uHjGllQEZNu9+iC64Zr+m9AoTLVIlx1eaj4fWagAB+tgVMqsvw+4SpvpTeNMSyHtyXukjBCgEo4uFjh2xniY02cywm6v83gei0P2rjhwTVKuvOrex+hvYr9eZ6CkNQueag4kokr+LtGuDmnuOh2yRWLrQdivFS1p2eGAy/svu9vWVTj9KKat9DKwrfb07FVtzYMHQ2rkprODJiMHNsbTUj2N0V1uZuspFsg2QlHKurfMlYVsLh+w/rt3nRWUakdvCrUF1lbBWi+rKl5EdagLL0TlqmELnPeQHFGdR3DD321eZghfpqzAlk62bgxPc6GRY+1dexhy5c40ir/7Qdy6qEQxTFI2eq0O+qNJvrJgfpe1jKoI0g/CE+0nge+Up/UpOBk/mmsIR6X4vps+eGzpoVICGpLOYpYFRb1aXHFRsIpQ2vh0LQ9aHKQbb2wlHCIY0X4gUwyhPCmS2FF1NNkDVhADeT8rT09DIl2LTI9lIji6MaNukhk1m3HXculrFshqIz4Q0W1cMkgvzPG+vr2D6MPMssYrDwqGWN+WX+oluzwdn2IAnDeNslGerDZeoT747/a8KA2pB2Zoa7Hfpdr6HQwzlz7BX6QboOCT1d2+Z57C2qb/AaC0YTw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(6133799003)(38070700021)(10067099003)(56012099006)(55112099003)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?40J+WU+2uo++Is8+URVOb4etV2KpaWK+onglsWrO0MG8eq61emljfsR0Ym?=
 =?iso-8859-1?Q?xVZr6HiJyAY8eZJ7WfLhFgpzF83aRZxm/wNwZswDGCv79G4wtmDWi/h41p?=
 =?iso-8859-1?Q?HShkQu08aVgqdZoaBIufjTw//wfUP89y0UsAphQFEjebrUlMQRD56ikwQ9?=
 =?iso-8859-1?Q?gAtmZwZH/JsazpigQyiiZzwQg/H3So2CwEe1gPtbvRShRR/WvZ32pqabB0?=
 =?iso-8859-1?Q?FDWvTRfZ+Zzvy4LZSJchIyMJptk34nZsxzaoCaZ1aGyf+4EyTSvePR07Sz?=
 =?iso-8859-1?Q?wKnSAwdMtN692/LVhAWRW5O9URZR687IBp7F1jMgeIRj0aM1FG3c1pKlAm?=
 =?iso-8859-1?Q?M07HrmbCoCn8Vib9VIMwxUlheNNTqc2IJtWqVHg5gcd54y0zNnpNxlXMxK?=
 =?iso-8859-1?Q?B+g8PESjRY9ZmB53W3ItNI3bMF/KGoUY2aFWm++s+Ev2+rHuJgsx5CEyhX?=
 =?iso-8859-1?Q?8ybULs5UXNloScQ4CCnIF8WGiQRkTwCnzEXblSOS2YBkf1g8sGJo7Pvma4?=
 =?iso-8859-1?Q?3nDa/Mg52QKlbg7N3gvdy0cZGwnS2EgKbyLAsmEhHp9Tn9aB4RQSz98J+a?=
 =?iso-8859-1?Q?GdKpKWuRhUOvQ6InLeHks5jiQ9lPEqiBI64gUAi0kusjBukLatdY8M9tUf?=
 =?iso-8859-1?Q?6+xxWrR7/bXFsZG2BOO4ma+oVGdoYEZMERyCnAkKNBj8l9KQh/aFSSoCsH?=
 =?iso-8859-1?Q?qJSLpi9g/Jrok6pQ9jERwkYin8LBuPzRzu8EPRU2X/vwuYdSEhMJl6gzMr?=
 =?iso-8859-1?Q?sdZd5XGut6032c7M0WgdRwbETBOW90lCNWMqrq72o5TKZcHwSrkRo6CauD?=
 =?iso-8859-1?Q?B4PUE1v68E75+VCHQawW+/Ha9zUWyt+x+5epXGsB3BKTtpmMl/GpgG2qGW?=
 =?iso-8859-1?Q?XlMJOC5eTGsz5t8m6/6HVHWWLzCeW7ZY8yVL3cXvG5fhUoMNl2oS5UgB4k?=
 =?iso-8859-1?Q?eXxH5/jaqMUWAU6+uWC0dBWkXt8tNfSRYWnTWSg1iCkpC9uyZfobZCGbbJ?=
 =?iso-8859-1?Q?eUNHyDW/z/g3a1m5K0w0Us/x4dNB3NgHTXgbGN7/jWa5SdW0bR9w7Bjxkn?=
 =?iso-8859-1?Q?Wqeq6mXfs/MWh0P7Hy7QlKjF+mkCxWSTbwt0PiRvMGMhEpaLPcozZIAYAt?=
 =?iso-8859-1?Q?kpy823ZlZd4qhH5JYRZcfXaFvoD5VskIPwGG+c14EPaJTM49pkRW3iyMEy?=
 =?iso-8859-1?Q?/KYnZLU4kXdDj94rVqlajhaJrQHPQcnaM/jzjCwiF87UiQjHOBPwjmur2k?=
 =?iso-8859-1?Q?kdej19M26M4EwMBL4PlzSy2FYitrbQ2eafU35TAsZVO7PIKesSJHw7GVj9?=
 =?iso-8859-1?Q?KaLmmYxTPwlSl2djqa1VzXU92k3Bh8QIx+iUjrHiw/Bgg+GErtPt6EG4yM?=
 =?iso-8859-1?Q?Wgc8toIIvkhRJVijReqIZ13GtEXrtmzUlMb2ho8RkzhoHhT61uN6CL6VAI?=
 =?iso-8859-1?Q?KH+zJe7M7OUCK4bzlGIZ0qnczne0fAn1Gt28WdcZ58Em7jJiG+4AwGqyGY?=
 =?iso-8859-1?Q?AIk2+bcuD4eBrdQ3+d6B2kpwPtvlgzCNIPtPoYPmuMbhOdoDXxze7zgmQ5?=
 =?iso-8859-1?Q?ZKbhU2lzUpNYTYDBvPUqMAERVcEgTFOTfI7eWTY7IAbhxbMMKmtsU9t3J8?=
 =?iso-8859-1?Q?ldk97/BqZriN/ezCuEcRzfF07HpukiEiUrUfvMs6zHxYKcHmy6YNH/GHo3?=
 =?iso-8859-1?Q?fUpbIyk+DZ+AEWklLFzNsjx9ldzJayYQnMabTAmGTLWMH59fzSvVi1iQsH?=
 =?iso-8859-1?Q?e75pQQx79/l+fy18Z10dTP7mbMGAvXXZyh3VW+OT101OcC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 59666c6a-f58a-4f4c-827c-08dee32d42fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2026 11:27:47.0013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e072cd9e-210a-496b-aa68-c0965404b8f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OoaznFplIKBqnANAeeJ49djLVl+E8QZNpUqhKnwVzbid1pRtFQMr3VSP2RVw8WoEflk0wKUcnaEwoxgjeBTZeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB6867

On 1/7/26 04:49, Leon Hwang wrote:=0A=
> By changing 'r0 =3D 0' to nop, I can reproduce the BUG with bpf-next code=
:=0A=
[...]=0A=
> With this diff, the internal BPF_ADDR_PERCPU insn is supported in the int=
erpreter.=0A=
=0A=
Thank you for the investigation and further details.=0A=
=0A=
Is a fix planned? This bug impacts stable versions of the kernel and is fai=
rly=0A=
easy to trigger notably on Debian 13. With some ebpf programs, simply=0A=
enabling `bpf_jit_harden` on Debian 13 means a guaranteed kernel panic.=0A=
=0A=
Thank you=0A=
Vincent Thiberville=0A=
