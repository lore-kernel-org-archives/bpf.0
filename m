Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021086.outbound.protection.outlook.com [40.107.160.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CA143C7AE
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.160.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785316050; cv=fail; b=aRtVnQtUM5tDLLEsPChuLC9TRZ/bo207eOjBlzFJWBRLrKiWu3P4Z1kmiJQEBM6pmpGEFIu7puPuP+vef30oLnkcxpmxFoP9Uyegb615yw33/slfuGgsFFX14DXZ02wpG1SM7ykL1rOC/jNUOQmbqOJDomNpsE2Z7l4zhTxYTUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785316050; c=relaxed/simple;
	bh=9BsfG/kUsGqSnW/yFKse2rVAWfTyI/lBA5OfsJDzMFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=adTecF/zk96aoV352QQyU77mhphCHQx47PhDsOAx/TnliZ/LMR3ARDZR+vf18XAtj5t91K5qwpHeTtWXMyfhC/semdIs01R3Xf/up/cB3v5fVVIejKmhUwApzLN3l66NFctacKWrD28yJ8c8+PIZlm50OEUqSLBFOdo3LxTHxUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=harfanglab.fr; spf=pass smtp.mailfrom=harfanglab.fr; dkim=pass (1024-bit key) header.d=harfanglab.fr header.i=@harfanglab.fr header.b=Lk/WFNPT; arc=fail smtp.client-ip=40.107.160.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=harfanglab.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=harfanglab.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=harfanglab.fr header.i=@harfanglab.fr header.b="Lk/WFNPT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eG98YTqTcswGvrKLJFaWwUGAm1Xcd4lAKM4EoaYYkEMQexRfvSR8aPJ0AuALeUax+c607pchaz495s+TkDe7M2U+WqWxvfMS5xewb1hk4OsLYUDjHprUItlMMoqhHOIG2YfiCy9Y39+8zCPWkS7bONTLuueWCkwRPNc+FN0OMezuQFxO80VKSQZ+DcrmlBAGmNs1pyu/0tHqAdnIj+gFikrNcPa1GxzDpV2BMp8vooNQdmcwZQApvSCDGCdzWMNOWOo/MdHBv9OTWsOJodqsBlTObq+sca9BNK+BPYlxWl9cl4oqHKO432D72QLgkOVjYcAGrLzHsQkxLhYyX+kK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9BsfG/kUsGqSnW/yFKse2rVAWfTyI/lBA5OfsJDzMFE=;
 b=N8PLQAjQ3/S9FfIkcnWCwYEYKQUYIHSVwBwkv4+qoldBVtTs8lQR2y+/eE9UDMUJ2DUg2P/aJettE4TZJiCjb9LfYenRyqa9PLvxHT5fgOcBV7E0Q/4DI0WOPU9gub2D+N17srp8ggggmTMNJDQnVIXQvjx4jdV07vpgth7rFNg35sU94QY2705NBus6UxC0SzlnEMi2yCugWrDpm/iKNV+nnttYAePIYHdsunYmHyzKBbglQGcbnPAiHSd/EI+F+kIhq5hLWsILUdB9rnF8EFBR0Shqv5dixFI9bdxT9sZq4BkDzB5i1FfNuFqSXq368qsJQx2W170nYA2fYNnYsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=harfanglab.fr; dmarc=pass action=none
 header.from=harfanglab.fr; dkim=pass header.d=harfanglab.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=harfanglab.fr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BsfG/kUsGqSnW/yFKse2rVAWfTyI/lBA5OfsJDzMFE=;
 b=Lk/WFNPTDIL6RPEu886wpzsGwL+unR4y7IrGHMIt6PaytlXLFt9lLutXLAz/RAbW7n4AmQ/M9tv+cT9iSpZy9Ez0MpMnOeN9pcs8B53nooIniH2iLkd9gZFNIX/3nrVhIGnAn2Z0i+3RZHDlZlyIQkZNFZlUxMN4i5/bGcpz4F8=
Received: from MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:28::14)
 by MR0P264MB5529.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 09:07:22 +0000
Received: from MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7d89:c984:624d:9689]) by MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM
 ([fe80::7d89:c984:624d:9689%6]) with mapi id 15.21.0270.012; Wed, 29 Jul 2026
 09:07:22 +0000
From: Vincent Thiberville <vincent@harfanglab.fr>
To: Leon Hwang <leon.hwang@linux.dev>, "ast@kernel.org" <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi
	<memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: PROBLEM: BPF interpreter fallback after JIT compilation of
 BPF_ADDR_PERCPU leads to kernel panic
Thread-Topic: PROBLEM: BPF interpreter fallback after JIT compilation of
 BPF_ADDR_PERCPU leads to kernel panic
Thread-Index:
 AQHdB8yzqGrNWEhQ9U+ot25Rw6XY5rZWVYcAgACsKdaAAPcQgIAYISD5gAD6DoCAE05CFQ==
Date: Wed, 29 Jul 2026 09:07:22 +0000
Message-ID:
 <MR1P264MB33149467BB801CBD0A3425FFB7CA2@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
References:
 <MR1P264MB331494502C9D13D8A9EAFB99B7E82@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
 <d255172d-d9e9-4116-9243-975cf4bdf3d0@linux.dev>
 <MR1P264MB33143D31DA8982ADB2E0D808B7F72@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
 <90c32de0-feac-4e63-9757-2a1d115be08c@linux.dev>
 <MR1P264MB331493FEEA2ACE6C2AEA5EB9B7C72@MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM>
 <b76ade17-44cb-4e60-97fc-41ba55258691@linux.dev>
In-Reply-To: <b76ade17-44cb-4e60-97fc-41ba55258691@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=harfanglab.fr;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB3314:EE_|MR0P264MB5529:EE_
x-ms-office365-filtering-correlation-id: e7f4e7ed-8abd-46e6-2490-08deed50ccba
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|55112099003|18002099003|22082099003|38070700021|56012099006|11063799006|4143699003|10067099003;
x-microsoft-antispam-message-info:
 Ylj/+Hsjv8uhpG5I4yYs00NgjjJZ+NIk+UQmXlQRl9pyo5T3TLP7bT55iU57UPo1M6iK4mLLhJ3zq+rPUXtMNugOZpDvaAASmFY0fdg6Y7ogFlLnvllkx6CUONIQXfA3NJ5FeftbdKiYpquDa0sUaTaCWLpa2deNMuhelXdHfwAZRlYGjiH4HRho3W6hgt5YlMM7TCyHxR/ZTXwGlgGXoVbaZnQa+BfTH/jmvZQYXMQsv+45jCZ3saMmyBo5taPO5n3YJL2vh2i1GJm6pmH0HkL8CVM6LsVX3jztBtuShnxpCuEP8B8hCBBecCTJ5AorllL/3cVY0xMzclM5gi3ftc+UKh0NJEUr5rxPk7Y+0HGLnHsRs2nA5Z8UlTkMKBARdQr5qLMr0G1lraCRbyKWjolzQKiMz3kPpklJIddeZ4dzcidzZWI26CW+59d1wHiUWl33TDugrDegseDy9Xje7WqPecXv1bco4UvHlwIKqV7T0Is+O80BJStSIxgG9RoUR4f2GAWneuxQB/8WoxSHAW6FgBOdGa1XZBOd1mWLDYdy3dBg4iIjBTNIWXnCJ824KEOv466K0kImCMlpdoLGdlKZwz2ylpaKCnBxC6GOU8TDpFZXPz2/F5FobKcX9dwX+Ya0V5An1zbBTL/hVTeDbofp/OjDcL7SbdHyS5Fq/7zydeHdlWyvmIswqhbA2bEaM3iRxkJY0xYbKnN2E31VghgnP6HkupG6dljDonKRM10=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB3314.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(55112099003)(18002099003)(22082099003)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?UiDu59ho1E0//yJ/zRZQkFNertK0L8e9gYI4qHnO7tpt9vLAzwGXBqOEMz?=
 =?iso-8859-1?Q?qir/zu4F3UZpthv/YlatBAeNzX/xXINdC0fVWTAyZnNbXVZGz9OSJ61SS0?=
 =?iso-8859-1?Q?ALPvxeGnujkOuEVvPgbowgn5WWhz6RG9kCWa18rvBLeaQLnt5K4yIH2PNa?=
 =?iso-8859-1?Q?JS2JpfmE76WJ+lzVarjO2a7FVxHpOcj965qxl4oKpuxsDVx023c/cwuOA1?=
 =?iso-8859-1?Q?Nq1DUpTe4qdff/5qEQEflLgRgD9I9lFGVaA3enBuC/u4zD5gr7OfSM5l6R?=
 =?iso-8859-1?Q?41PdV2JKl1/eI57rD0A/WFIdzWuel/D8InuLdmzsmPskffQYrtnJ9cKjKs?=
 =?iso-8859-1?Q?1cvT00/e9QsCirLGZC2lTZ4yaelSR+L8zAtOieVh/ImvjRhUe/FbfHS5bW?=
 =?iso-8859-1?Q?kQtvZctP6aV/npTuWitt64p42fKJsSxi8aL4qjE+GZciHP6+ieW0fTzsbf?=
 =?iso-8859-1?Q?ta/eWHUu3erlH6EyZExy/rTuJA8YuWJjR6KgmIK1S63FsRCK43mG7WZxfj?=
 =?iso-8859-1?Q?r58Rafgz1MAC5hTwOVnGzTyBwcX0KNWQH5kvQVd3hZKMQNd8nx/c/Y+887?=
 =?iso-8859-1?Q?IZBTjEoQaMOIu4VBNz4Gm30sGb3S3ya6NUD9KEkxi+3q6K9fWtQkptOu9h?=
 =?iso-8859-1?Q?pdsnpm4BLdHg6YuvKJYRmipUr0qoYht9i9sHv9FEeiSyGgv1YTmGDS7xcG?=
 =?iso-8859-1?Q?HrghPQKR4NBg755trV3S4/Pw0fot4kKyjyIURA501pE+h+q/bsIzpSlnBO?=
 =?iso-8859-1?Q?OzKvXxlTy6ZKyNk5Zykp4JHOtNzHCopdN2wo0XFMifHfyTnTE4f2g0Uexk?=
 =?iso-8859-1?Q?J2kAcsLESi3WJwKopVEZs32J+sb7EZhR4TXkPfRgtP1lOfYjcBlTzOF7d9?=
 =?iso-8859-1?Q?c6REjwN2p50VWBm5fs7jc9u7NFtBLTbvPeO2CsZsWzg4yy2SA8Xk/+hoK0?=
 =?iso-8859-1?Q?bpd6hH+qqjVQsQjLdngfuLgnSlpDHRWZ4A3DR+h3AyadpTghQ9IiDiKKSO?=
 =?iso-8859-1?Q?b2y6YJYbI9HKOrlMqOzEEKkg/eDG+Q0C4GsVXxuPXnkpHppEjW9mVD24lm?=
 =?iso-8859-1?Q?bTO6gfa0Qnc0Zi7kFOksYgmBcFrhZasv5Xib6dxDhBhfM548EB+J3HhCN4?=
 =?iso-8859-1?Q?7DGF3glOKqzjDromkxQ0ngaMOKILuQc4FieAkpCKr6TKHz9lAkDAZRCXWc?=
 =?iso-8859-1?Q?uKYVAPYoNVYf1kFXSTaOlvn8pq4L8+8sAbh2xHYHBx3dHQRT9FuF0LLyJ+?=
 =?iso-8859-1?Q?d5DbmGbe5WHkdxkQAD24AHrMKDbEujrynDERzxYEDlGMpUYsgkyI4umefT?=
 =?iso-8859-1?Q?DJ7O51Djs9Jmp2mSMivIXM7Kj6cxUw60PggCfC8vtvud26RJTJBGAoiowk?=
 =?iso-8859-1?Q?SOzx31rJL1E4NNtzaGw1sBi/jeZVi+Er2OQfHRYDuyif6Vaj86aJysrgO/?=
 =?iso-8859-1?Q?gpF7XW2qooYlqppnkl5Iha7pB63d/+4grOwrYO8Gjj1ce2zohDmVeFYIwo?=
 =?iso-8859-1?Q?udnMFMhuyT05+n7FkzwROR3If0yF1qkNL89O5UE1KocIqle4k9rETBdw0+?=
 =?iso-8859-1?Q?pmPi3wz1Fm5bjFLp5xp7/at0idtL7B1U2YkZaAW3LvSLOPk938Up8DwAkc?=
 =?iso-8859-1?Q?bn/CDrDCGeJ+3jAgaIY/RZMBKqFM6+s+Ox7r7B2BfsxTcRIqo+HwF/w1Aa?=
 =?iso-8859-1?Q?w37JbL90l7j7Y7frsiZ8aF77FLFMXlz7biZZfxeHtzTO0pMEJhogtk9AFq?=
 =?iso-8859-1?Q?ojoicubw4kjsyzcm4re5KAFhLEaCKp2zm+ZlbiKh/9qS+v?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7f4e7ed-8abd-46e6-2490-08deed50ccba
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 09:07:22.1032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e072cd9e-210a-496b-aa68-c0965404b8f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /LgXLZHp0OOiln67+i6APeBLooKW01j4us8+eqr6qpRWdPFblcOl0yw107Un9ozpINdILnnbTxUj///sN7CZKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR0P264MB5529

> On 17/7/26 04:49, Leon Hwang wrote:=0A=
> [...]=0A=
> The fix is on the way [1].=0A=
>=0A=
> Once the fix gets applied, it should be backported to kernel 6.12 with=0A=
> prerequisite patch [2].=0A=
>=0A=
> [1] https://lore.kernel.org/bpf/20260715141122.15783-4-leon.hwang@linux.d=
ev/=0A=
> [2]=0A=
> https://lore.kernel.org/bpf/20260708101806.18885-1-yangtiezhu@loongson.cn=
/=0A=
> =0A=
> Thanks,=0A=
> Leon=0A=
=0A=
Thank you. From what I can see, the first patch was merged in bpf-next but =
the second is not,=0A=
and there is no fix yet in the stable kernel. Is there an estimate on when =
this fix will be backported=0A=
to 6.12?=0A=
=0A=
Also, is there a need to fix it on supported versions such as 6.18 or 7.1?=
=0A=
=0A=
Thanks=0A=
Vincent=
