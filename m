Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19010021.outbound.protection.outlook.com [52.103.32.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA238280A5B
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 18:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772475070; cv=fail; b=RVD6Ej830agf0BxL4K9gHHXX8Z07SCR9byDAr3MGZtWA7XlQC99KkVwbq8Ds9dfjRNsIVt5sLErK4QXZi6vEv8dQKk5pMoB2h+BOga8B9jvlb+0DZ+TOENBvpg7at39HnH69xWxZbF1+bwqdso71P0Pwr14ImLbD5o0++AKug3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772475070; c=relaxed/simple;
	bh=dc1YqSBYbNEW0x1VbcaA6ZqdXExO7EakmnMXUajOIRI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=R0MW/q18o/66vHhfltne5JbfFKiT/v6P8v2l1L2ErU5X0MhxJ+lmJ9P55a1VzoykyLdKmtkCnpyfB1aW2irMmiSPxooEyeQHYZ5SM5p3eNyY13jSNKTkCg5wCod1uk5tl9JRytE4Sh61cXVIVHRpG6gO5ACsuaveporHMqSaqGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=r8S9nW6O; arc=fail smtp.client-ip=52.103.32.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="r8S9nW6O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C/eHulSE7rUqYT6Lfzg/JgW4NTfYnAAKbe6UCZo9mLCOF6owF4FIQWKTakf3jWosA6sjNdTCgeuRh5SF67yrgYiG9A6iCSU5c+m/9ZGMmGIbhNJDTWSuxx9BtHNyipRePGw7NZm7unYqP0uujhZbYoTh7h55dI+8oM6GZBry+/N3cV7CDfrO8yhXDqsrFD7ajOdhOo67pH6LcdZSLmO28ItkcJ94X91wVpw0KIfNwEJBbtEoDiv0aRjAoXoFFs2yhwkG7b8ZiIR1ifcdSb6z187hd9hoKUymR9+X3N8rGz8alKefDdZhdfRuN1BTzTY8UrcpuUZ+lnGUjRE2f9Eppw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vb9Vu77zqCSFV0zK3eMkfmVQI9k7RJz6S+OSuHCEYaE=;
 b=TvrD19f2vGgS6igG5TCWYuV9LI8vzNpuSSxkB/Tmzth9dGCt9itwnjv+k9ff2vVvcBGH+VVemt5segTJU7zo8UjOA6IA0Eki5daLiu7qrqwTa6YxOC6z9ZmUZ2kb+ptjfKWFWVVUAfZZkhhRGJ5qEDtwPjqkPAKAYq1xQBTm7NMH+NWPg/OBMBF5XLKQWDY75WEz+vHTm4XWxhSxIPBt7EfYeBLzE5HWXyP8fw/Sl1FSiPXgkbvVn5bkWhCPmz7VwC5zNjP/ExyLt6SRRQiaitFnKSTlGu4ITqATsXeUbRqHsK4lgqwGdJyMJ8XMRLe04CM7AhM56Tex/JNUsqfUug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb9Vu77zqCSFV0zK3eMkfmVQI9k7RJz6S+OSuHCEYaE=;
 b=r8S9nW6OQLAtcfjO8ShxkblYkmYnQzs0kyPjCl4tA9gxmVqULpgwKYH8qNxUzmIg0jaSB836ml0NZSydgunOZ06Dt/01u5kCRhXsPCLjyIJIaPIM9bzvIO+Chxzxt0MTiWEjvkRehAlH/eEpCpjEnaTjoHG7kQJK7iwbja1iGl9sedD/dcG7Mv1kUmbe4gTeWYTJt1RSlmzC81LWDDPjPgt0e9iklb0lUnX+jTxXus1PvCk4fLFa68NADIQiHoze0MWVkgmfqTnzfF0N9Jj32j1tq2jGhcY5VUoglYPDRNnQeBGSAYze13hA7nW0H3WJK0URXCpw3NJk3AuDxRS+1Q==
Received: from AMBPR06MB10868.eurprd06.prod.outlook.com
 (2603:10a6:20b:728::18) by DU4PR06MB10334.eurprd06.prod.outlook.com
 (2603:10a6:10:620::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 18:11:07 +0000
Received: from AMBPR06MB10868.eurprd06.prod.outlook.com
 ([fe80::3e76:44ae:b3f8:39a1]) by AMBPR06MB10868.eurprd06.prod.outlook.com
 ([fe80::3e76:44ae:b3f8:39a1%5]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 18:11:07 +0000
From: Guillaume Laporte <glapt.pro@outlook.com>
To: "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: PROBLEM: verifier.c - invalid scalar IDs after byte swaps
Thread-Topic: PROBLEM: verifier.c - invalid scalar IDs after byte swaps
Thread-Index: AQHcqm6P/Q12mUf4MkaMUV+LAqDVaA==
Date: Mon, 2 Mar 2026 18:11:07 +0000
Message-ID:
 <AMBPR06MB108683CFEB1CB8D9E02FC95ECF17EA@AMBPR06MB10868.eurprd06.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AMBPR06MB10868:EE_|DU4PR06MB10334:EE_
x-ms-office365-filtering-correlation-id: 14930f02-08f1-4fab-3c25-08de78871343
x-ms-exchange-slblob-mailprops:
 7qh87CJt6y2KqegnoS4V+KljWAyhwvUzB+wdvNa03RG8Nt6Z7x6Mf57BoRJbQZwJHpxjci1eUkqC1IW02v8sPL0YxZffWSD9J3VAQisEOimb2mwqB0rUyq7Bq5DHx/JTVVxZTkQgvTWdyqjBAajek9F/yDNHVqhowcWw0FpnYN+qDrE7OeAtOhu1g3yW6l2WBNwvUSTba5b9PuoQUVqM58umhI45WOuXyhmWPLqyQn4Q4G9OdKmERcTAZEx1z6GlXwUwQaBW1Jqn6IeqAbb9NYu6tY4MwVDaypxzDWtE3RndW5MfZ+LceJHasp7xW12QedqleuTOCl21wUMPDhsgf3FIRZVbjGhDqy4AyNXhvfQcop1M0edzmSb3nce7kH//qWhu/VRLa83Tp1PmcV9MpYbxe+Cglu7RWp9Zx1xL0QxXVcRXElx8pOFmK522qHQ2ufFUW9XLja1IMV7KhYLL/dlvZlpnyME8E0+T6LiFWIYufmOH4Glqi15kNkJPfkFBlocnLwTWeB6CDwy4U0XU0g83SRDDcbxzp7DtR84z4sQC3RcvwQSbaJ3rRiHiajAHoXWW2YIgl/axAy0mHwmLfqtmZNsaQHsuETOeSu3OC7ZKpc2bKdRmHM+k48vqp8paQQt/w/p3pJxpQMlWxE62rkSDGTXzj6aDiAGi62E/b1aHmtFaXM/WahId0DZa0IymRc45QNIrDKdHheg15fo203+edaj7n4pM035sAsXMQH8Op7oT0Q8cRzeECqReHjIn
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|20031999003|39105399006|55001999003|15030799006|31061999003|19110799012|41001999006|15080799012|8060799015|8062599012|40105399003|440099028|3412199025|102099032|3430499032;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?xFKtzu8sJPhFhhlzjZEsaeELIFu7+wKnjFnzOnj/JRSId+qCavK1eaZPBV?=
 =?iso-8859-1?Q?BxZIhP0E7GjwHGZZUlBzO5LpA+l2fjTsmNmyG3JZiFt+YrXl/mlWVjkX0J?=
 =?iso-8859-1?Q?UjJ4QkTsiEqjkTfi3Fp4DU9uYm0iVu+vVNgxiwLxXL+WuenSzenIo/KoXa?=
 =?iso-8859-1?Q?JNRCtsOIYmlhtgAx4MMU4t5nBBjeNM57FpXWVIMD3en3/HxKAkJZtkHyNA?=
 =?iso-8859-1?Q?dFmCqiOTNRmV23+KYJCPprjmf1Wg0kj+goooj7pQ50920sgQxdmtz6TezV?=
 =?iso-8859-1?Q?dlRq7zcHfywKCs3r2QSXzXRtqImXHwq+oHbcolLjQ5ddk6KRjLC5Trvt8e?=
 =?iso-8859-1?Q?ufOVEfcXMXyw4d+7cezs7nAu/w1h/DfgXkuUJH3dNXqiBc/U50BC8FBMcR?=
 =?iso-8859-1?Q?ec++dvFo2CwCnSIViKtObgBTXnv1oyocjn0vJLgkw65VF8WaL8DaXraHqo?=
 =?iso-8859-1?Q?yasZ9WxkBavj5zhwoDwfvfQn0WHJ1by1heFMPFjI/Ko2qTPVpzzPJzaUJy?=
 =?iso-8859-1?Q?yIhzCUGMfM4YVMEx/lYhNrS+SQiMAK1PCZ7rQGH8d+gpO9cvJnXOyklVyO?=
 =?iso-8859-1?Q?RPCRPh406B9dTDf0+YyP8TLOfMSLALYf5teU3Ajez8iVVKhy+ywGWbLT9b?=
 =?iso-8859-1?Q?ukMu340hGEC5fIAzxfscilddQBf/TIcxzCqTTehPPDcXsWCLgm7hiPgjBm?=
 =?iso-8859-1?Q?Ocif1Pa/uguOh929NBTn5rbioY1UCMr1TIqPISbYhF5a9ZN1adDiEomv95?=
 =?iso-8859-1?Q?toKr1YXjKX1ZJIW6ltuFhOCJULvSV1pPo0mFpACm7qjkkPL+qY2To1PoHx?=
 =?iso-8859-1?Q?XsAMaNPX6f7GIF4XGJ7PjOl89fD57JmjpEucZ4WTCM+EKrihkHG36DIxh5?=
 =?iso-8859-1?Q?sf234xYGijB4LLfb/pyRTMcQNnBGyAK7aApbcz/p+SlE8LsUV9OHuR5gL4?=
 =?iso-8859-1?Q?vhct0F3mKHh4q02dRg6ZzOFnI5dgWqWsvdOnGiZzFIUR/BhA/M5bcHuJb6?=
 =?iso-8859-1?Q?nj+vHrdVNbBT1pHjTJlXt/pPPg5LTWKleQ2Rt5SQ7i1s59yufXLiOMMK6O?=
 =?iso-8859-1?Q?1ambxXZJxSBxnmREzKX2/PU=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?0C8NGUWJ73WQNI1aZXSDWl0EpFPRQ5p29fIyv5u7AJ1UG2aDstUTLM50J+?=
 =?iso-8859-1?Q?2kGi14iNR0jVbWqP1XMgVZzTrg5ASgfHlNi6cOkghPDiWjYabhsmWdjVEx?=
 =?iso-8859-1?Q?NvTF6tv3amd5KEogRo1aP38mqnOADZ2qUlFZWwMac3yDCGsWSmNPqsdJtA?=
 =?iso-8859-1?Q?Ax+4bPLqO6pnNUFaU3O2iMpiATEjduHh1sY5ncl2noGz3yS8vVLmBlcWDW?=
 =?iso-8859-1?Q?i6QHypS1VMDofvUDFY3kMnFlokia/uG8WIw5Kt3BiCVET9+Ez4UQrsqJ6p?=
 =?iso-8859-1?Q?ZZNzyasAcrcJ4gVijY/JuxcZ0NjiG8ISqWnzoOYaWjxJQ6+/23mYPAJ0lY?=
 =?iso-8859-1?Q?5gQZRv/eqCw6ECke7wN04JfXDkQuCJmrI0pZTrGL6/uVTd74SdWu7FQlgM?=
 =?iso-8859-1?Q?V12+wVUo8wuBMmmlTfXOC9cB6YN9YOF4W7ESkhlsZYXUG4uSbUaaSeNlqv?=
 =?iso-8859-1?Q?lSdCrXoS6//yRMmJW4n2w+VvtfDa/bxtJyYbInbygr0DAKQaC541vmQbbe?=
 =?iso-8859-1?Q?UnVzaoBFkEPfacm07qV3U1dBZsDkIe4ogJ2/0oRv3YurhophkyOjpcktLo?=
 =?iso-8859-1?Q?SIi652vC/wPEtWEA1VIUz2Q/mos4t5U4AszW19Ah6PwZU8IWhT1pz8UFtS?=
 =?iso-8859-1?Q?+o+Q80Hc8o4UuV+BVLRhNcJmDraECCBDI9Tsay5nlDkdBjGicwq90LuCvs?=
 =?iso-8859-1?Q?3cFE7xYy9WXyVIOW3Np2VfOrhJxG6kgmNPY8wy4JGyk/6nEh1YMHZP7mno?=
 =?iso-8859-1?Q?h2MbycUyj8clUsTuDBpKt2CTKrQwiXLeEIO/Drat0SHDdcKFbe4t97Zyta?=
 =?iso-8859-1?Q?YJyPE2XkTLl+fl7LOyuqTP1Px7P+ya6PXKjU/mhA7+LmTYxuea92RQgrB/?=
 =?iso-8859-1?Q?bNXSjK3fwwa3jndqGuatcMmNEM1+cvgAdPXSK10ZtPUgWtEVC4J++bAgQz?=
 =?iso-8859-1?Q?5MVLPOi+xWizfwg2kgQOnQAhXIfuIgS6x8K81lCHL2JMKRY+u788U5sClg?=
 =?iso-8859-1?Q?QmlfhNDPzcgpUngMV414s/74UgSNMAb5Lx+DyTZuRz8RUe6VM6i78D8rL/?=
 =?iso-8859-1?Q?LnHOchU1Uq/Ipm8pYLKABW2Y0C0SYiJo99JTPIgBQVPbuXRJFmyiN0pvWy?=
 =?iso-8859-1?Q?y5C8oPG4rwc2qshBYS41fltALjXmtrrjhQj2ziu6+0LtNj8fjhDqcvF7Zn?=
 =?iso-8859-1?Q?QsBeRHpbggHqlzDi2adrdmGPk3ai7xNtNOV2yInHqfBvJgSxF10qjpp+fG?=
 =?iso-8859-1?Q?evbjjzaFXugSApNwMaOGYpBd4UvpmOO2pUEUMZ1bYkZE3T/5fcbnrKX4Tc?=
 =?iso-8859-1?Q?z6iV5MuyWU5RC9RHibYxnHjLxNtQtdQi/BK+s+zlDcMrEKMZtBJZZ3xbxS?=
 =?iso-8859-1?Q?Yo0J+ojaIHOPNn5HS8k8ik6p7Rx+lmNCSPFbniqfhjCSaTE7mSCpI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AMBPR06MB10868.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 14930f02-08f1-4fab-3c25-08de78871343
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 18:11:07.2197
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB10334

Hi BPF maintainers,=0A=
=0A=
I believe there is a verifier bug that manifests when a program performs a=
=0A=
byte-swap (BPF_ALU | BPF_END | BPF_TO_BE) on a value that was previously co=
pied=0A=
elsewhere. In such a scenario, the verifier can incorrectly assume the two=
=0A=
values are the same (share the same ID), and can then narrow the value of t=
he=0A=
untouched copy in a way that does not make sense after the byte-swap.=0A=
=0A=
I can reliably reproduce the issue starting with commit 9d21199 "bpf: Add=
=0A=
bitwise tracking for BPF_END", so only the 7.0 release candidates seem to b=
e=0A=
affected; not kernel 6.19.=0A=
=0A=
Below is a minimal reproducer program that demonstrates the issue:=0A=
=0A=
struct bpf_insn prog[] =3D {=0A=
    /* call bpf_ktime_get_ns */=0A=
    { .code =3D BPF_JMP | BPF_CALL,=0A=
      .imm =3D BPF_FUNC_ktime_get_ns },=0A=
=0A=
    /* r1 =3D r0 */=0A=
    { .code =3D BPF_ALU64 | BPF_MOV | BPF_X,=0A=
      .dst_reg =3D BPF_REG_1, .src_reg =3D BPF_REG_0 },=0A=
=0A=
    /* r0 =3D be16 r0 <- the bug is triggered here */=0A=
    { .code =3D BPF_ALU | BPF_END | BPF_TO_BE,=0A=
      .dst_reg =3D BPF_REG_0, .imm =3D 16 },=0A=
=0A=
    /* if r0 !=3D 0x1 goto pc+0 */=0A=
    { .code =3D BPF_JMP | BPF_JNE | BPF_K,=0A=
      .dst_reg =3D BPF_REG_0, .imm =3D 1, .off =3D 0 },=0A=
=0A=
    /* exit */=0A=
    { .code =3D BPF_JMP | BPF_EXIT,=0A=
      .imm =3D 0 },=0A=
};=0A=
=0A=
When I load this program (as a BPF_PROG_TYPE_SOCKET_FILTER), the verifier=
=0A=
appears to keep the original scalar ID for the destination register, which =
can=0A=
lead to incorrect verification (R1 is assumed to be 0x1 when its actual val=
ue is=0A=
0x100). Here is the relevant part of the associated verifier log:=0A=
=0A=
0: R1=3Dctx() R10=3Dfp0=0A=
0: (85) call bpf_ktime_get_ns#5       ; R0=3Dscalar()=0A=
1: (bf) r1 =3D r0                       ; R0=3Dscalar(id=3D1) R1=3Dscalar(i=
d=3D1)=0A=
2: (dc) r0 =3D be16 r0                  ; R0=3Dscalar(id=3D1,smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D0xffff,var_off=3D(0x0; 0xffff))=0A=
3: (55) if r0 !=3D 0x1 goto pc+0        ; R0=3D1 R1=3D1=0A=
4: (95) exit=0A=
=0A=
from 3 to 4: R0=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dum=
ax32=3D0xffff,var_off=3D(0x0; 0xffff)) R1=3Dscalar(id=3D1,smin=3Dsmin32=3D0=
,smax=3Dumax=3Dsmax32=3Dumax32=3D0xffff,var_off=3D(0x0; 0xffff)) R10=3Dfp0=
=0A=
4: R0=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D0xf=
fff,var_off=3D(0x0; 0xffff)) R1=3Dscalar(id=3D1,smin=3Dsmin32=3D0,smax=3Dum=
ax=3Dsmax32=3Dumax32=3D0xffff,var_off=3D(0x0; 0xffff)) R10=3Dfp0=0A=
4: (95) exit=0A=
=0A=
Thank you for your time and for your work on the BPF subsystem. =0A=
=0A=
Best regards, =0A=
=0A=
Guillaume Laporte=
