Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795377375;
	b=N9s2cqw8Y3cejmkCVxvMGBB5Da6sJQ8C4g2iluEzq8zia7Mrrz+DliougtTKOzLWglf+
	 41z9+gZf507wsjDhQ+9zoxhk36/DRL5M0Ppv8Zxhq53EUR7FZMrrH3TkVE5YgBNe4qTXs
	 UkdKlQchS/tLZTsdKdGrZsMYV48MQag0/20GdUURyH9/lKgf7aKM54unFwWX0g8I1Nhm+
	 7EEYWivy3NzdyE0dWFl8Zq9PivY2BQ1IVHys2lBAKjuroBVe6neur1d41ImR4qePkI7mT
	 uBuuNvtTRsSPEGMbXTufTTus5ASieerSKyxoj+mnTN8tM/Wj5Mr/W8T5Z5gZJfnLINg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377375;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=gr8rnH7+84Z/ktW+fpDVmnd0hCnKvsVzoR7c2W3u1VQ=;
	b=S/+f3dAblR1vUBgl9ziRSrKxj2WBrpwP6SHVXqx5/VIvMbjLk1ChckAKdycEOmF4zcMj
	 xE9B7PdCQyoEJ6ug9TMGSoXzVOqFIp+z9xM9TV8hxX+8ED0oC+MxTnlACexAXLoYiHVcu
	 NSlARAGWm2fpaXaa+fAZXrjNAT6jb6nT7A1aI2WCqA8V+z5tTpXebte8vT/iqvMXpBBDv
	 7f9xw2gLO/HLjAUlzdr3TZPKfUkN4QI90hzLgBqJ+S3kLj8+kebiw2OHYN27xzFNZDUzk
	 oE+dXVyGTx4v5Ae6j/zvK62Oa5IUKaZ0SLxJhNvwNeSIt/qmcQBpQWpghZbhkQmM0WA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=yacoub.de;
	spf=pass smtp.mailfrom=yacoub.de;
	dkim=pass header.d=yacoub.de header.i=@yacoub.de header.a=rsa-sha256 header.s=selector1 header.b=OaLUkh2L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.108
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023108.outbound.protection.outlook.com [52.101.72.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F7E606A31D;
	Sun, 22 Nov 2026 19:56:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15F7E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yacoub.de header.i=@yacoub.de header.a=rsa-sha256 header.s=selector1 header.b=OaLUkh2L
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQGuhUCt4f4aBJWei6u1LFFuzEQc0zOhiks16vklOEewuypFUo/WKxOgMP2ndXRSa84A6NsZnfgxUhnllANbQ01Yhg8kJCa+y5ZYXofBHgPKGIFqdj3Vf4+Gl+vCQBndSCtAvqtHgFkAXdvcIiun+RgCiVPJzIKHmSw3nQ5tcvUsCEfcZe6y9sZMdGhKPcv0DhSgdKD8ETiw6ylqfkCKHXm6tBDm1uCAwv5ygblI7kzExQnWmEmVS4Wwa1zYBwGz6IbPy8sIiyIjROfpg9+n8kpQMA8ul5o0tJh0UH+LFwGQRGrBbeLsXP40LhCMp2E5AT7y4y9m4HmnQLbF9ofL1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gr8rnH7+84Z/ktW+fpDVmnd0hCnKvsVzoR7c2W3u1VQ=;
 b=vtZWTFN/fewnhjPEsVwcQluuPo2FUKQtIFdm7j90ZoduW1Lj+yixdVrRd6urrqqq5pTc7ZIAszIMWB0QXidHladQaECdDEF0D9RlGkbKTNM1gWAhEbhbjFHSUYdjS5IffbGs3dxDRdrffXDCxSH40RdPqKx2WWLdPqclgzcED1B7oFo5Il7n/Lw2+Pifw4bHj32O2y166ByVnFHwCpSnzwSxOwm4VL5Sz/Tdc9IJMgjM+hD0KgbZCz09cjF4hzoBVwAqxnKB0XqQfSs3JHBG1M0tNKczK5yMuO+E/6tcYjnrntYh1Ug8oL24/UkrwPGYY9ViX8R1Lnpa7wFHIGCf6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gr8rnH7+84Z/ktW+fpDVmnd0hCnKvsVzoR7c2W3u1VQ=;
 b=OaLUkh2LZ/dJE/crmEQxfVZwmkcS+PZY0cX2CMx8KMRON7BO1l5ayCqvVy7DicvWR6lDuK6nD6ORelvcZr1YRXHEH+Qupq5MrB0FuBxlJC+ltJpi6ClVxO3WyOo9UWqm1pyUFEXUtHi1Vui+HJXevvpkYDYKFtxb0Yp0lnDWIRsaklYHzgxHXM4HbbwNmqqxb+V+86wzBUbXNwrqLRCifSZgi/XodW+nz4yTkG7IYal/42nbtSspRYk2pTzocBJfqlvTHq0WepQj/p04K1wW+ul7/26mVy24/tL2kzRzeAKP9ze0Qfo8Q+zW/9dBgWNI8/ABL7qlkh41RQ9e4hXkgA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by GVXPR04MB9925.eurprd04.prod.outlook.com (2603:10a6:150:112::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Sun, 22 Nov
 2026 19:56:07 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%3]) with mapi id 15.21.0639.012; Sun, 22 Nov 2026
 19:56:07 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Nicolas Schichan <nschichan@freebox.fr>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3] bpf, arm32: build constants inline instead of using a literal pool
Date: Sun, 22 Nov 2026 20:56:00 +0100
Message-ID: <20261122195600.2573516-1-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120140147.166934-1-ramin.moussavi@yacoub.de>
References: <20261120140147.166934-1-ramin.moussavi@yacoub.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::9) To MRWPR04MB12069.eurprd04.prod.outlook.com
 (2603:10a6:501:99::13)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|GVXPR04MB9925:EE_
X-MS-Office365-Filtering-Correlation-Id: 83efa1c0-ff28-45f4-abbe-08df48d2a586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|11063799006|5023799004|56012099006|261021123027099003|261021121427099003|261026121527099003|261022105027099003|261022113327099003|261009223027099003|261026140227099003|261022115727099003|261022075727099003|261028144727099003|261102123227099003|22082099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	FJUDIb+1CtvKsHTXucJpKP82KfRGTGDDIbx5R648j//BDba73hIpyi4k22R1ksPpQJMjZ9CtKxKu8n4qdzkD1CkchLzdVM4789IRAXmMrsiyRCcsTUMg+RG5GiCIv5WUkpDyZSe2ZHDU+dilMW5Q4zfg6cgwy4lQ1FKN5ltJ7nyBfwyN2NnhUix3V+TmxRh29I2idF5MSl6HfH3YevSP/vUHRv6p3AZKK2f8O8R2Go2kKfLPGnAwSlNhdXxoBiKPhHwgo1wyjhWSH4DTbIBBl52taKJQLok1sQRThUHdztmkhDamPs5rqI+LtX6dvbfZsPgLj7shNyteFRCrSzAzHZxLYC/G7dMUlEI8M8Mwz5LJ/koYzm0ke6bzm2knQfM6/Yw2N2PeJs+zimaPJDi6vSCMgb43YSEIGZcj9JHVJOtG0N0NqIlGZVuvImxq1sELZ/9EDl6RbD1u/iwcdMYyHcOGdsp2u6ZucRxzdyybWBYxsA2qattix8xK2eUb6w7Fehfz0XmZukClX6CAXq+158kNeV6ocrH9N4tR/mTDbhu7Ch2siRj6WU6EHWD6YL1CYsCoNIMWtZl5aa7FeO1DE73e6a4eVAGb0FU95ZnFs/Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(11063799006)(5023799004)(56012099006)(261021123027099003)(261021121427099003)(261026121527099003)(261022105027099003)(261022113327099003)(261009223027099003)(261026140227099003)(261022115727099003)(261022075727099003)(261028144727099003)(261102123227099003)(22082099003)(6133799003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bk1Vhqwgg/48bleeAY6F0M+UeKHHMT7CpQEc+055YlRUvJHwGisbmWNiWVN1?=
 =?us-ascii?Q?pDpx9lHVMxe1EDe2QqN5pf7mfEdEXup2BDJ3drXrUKaQ2X2tBw700eSQQSVv?=
 =?us-ascii?Q?PeN7aNxT6LxK8ahjfgSOD7xEXvJMSgcIARDBQehSiee4xV6nDSJlWvc1NZGh?=
 =?us-ascii?Q?QowiXB8OGjE3Ms/xU/wQ/Gst4x4S7A29hbXWqzXba31m4BPeG+hFxJFQxql1?=
 =?us-ascii?Q?DgUNaZlCAOvnnn5757hULUlEjere5RlOcMFgfKCqascLhc9/j/hJqoHUPQ+e?=
 =?us-ascii?Q?UwD61ZTfl0BQ3OtUCp6WtoQTvyVjiOebXQu7zh+7QGcI6+PRE/1BZmP+BUY2?=
 =?us-ascii?Q?x/ldCnpsc6C7p+6p/K0SLTB9qqHnblhMByKN4vZoCTg6RZ4beextNWQA0Ceo?=
 =?us-ascii?Q?0rp7t+vrDBrf5cusVIuTTILewRYqJS8F+hOgyTvAIQpX6O7MGqaBKx/vROWl?=
 =?us-ascii?Q?UPG3tE4PiBNjareLB3+LFgQaR/hDXTDG3ndVYhXi5sCagcDY0LDgdR1Q64Y+?=
 =?us-ascii?Q?OChsjUOgznif62O3eoOSc3Zc1pRbJPZ2jzac/DdP+frVjYP7BHG554uwf0PN?=
 =?us-ascii?Q?xuXQlQHuXWEo7qrHAsFQXN4KhpFQ5K4QZ28a1cwf1Y/Bi1Pz0UVrEn6bartT?=
 =?us-ascii?Q?RxSiwf/2Ve/NaVH4HHRpk82Sk/mVwDeWV9356x06mGtsiKUbO0/sP6osPJxd?=
 =?us-ascii?Q?C+JHXDgXo0kCu87A9BgLEdsDFOTxj/sG5CwyoQXeHPp9r/GVyavsQ4Hg0Xav?=
 =?us-ascii?Q?Xyk2k0S5Q/2yV9DqUi+ikqK41mFP4V15i2wPSkmrZE00CWaM8hYkVBQz4maS?=
 =?us-ascii?Q?Hx4G5iOEW2RN0zvF9ETkPaFIz34oIbpDXZI3XAN1ffzZd1yidMvrICS1bSlS?=
 =?us-ascii?Q?FIdhY3Kq+/BWZbqSI9wlHWRmYfcM3FkZKA1N0visr8QULLQWPlZtgIaBmeGs?=
 =?us-ascii?Q?0n/aLPY7B0qbbjJzo/Ur2l7bIGuFkGC7AABqUL450NjGIYJ+B7z8NjAGA3nk?=
 =?us-ascii?Q?5wXChn2VicwkVAVkxrTAl0qDeQRpb0q7kZ3wJoeWH6udcf2rhUTkvXABVe5/?=
 =?us-ascii?Q?spl8QH77NZA5PnOlLn2AP+PZRYa/hwisgLq458OJTDP1mQPREad95dCav3OR?=
 =?us-ascii?Q?yLv/vQP0PNYm/j2GZNSEWkRu08HNCFYpqleLLJ09HASf2vLc/SlN09vwJtw5?=
 =?us-ascii?Q?HxHwEhMPViMH4ZHTdB8uNowyvUS7LphSnThl2L+Kme/AYYNqGlzh4o3yWe7L?=
 =?us-ascii?Q?X2+4J7bU+M1taZpq6ZeviRuDIfuspj0T02BlpBCqnYV5LB2NnLX+Ghf6sbvM?=
 =?us-ascii?Q?w9GnVEajAXY5YvURNZ0cISOSNoZm9CK648mFC6B2Wtq9+Mr5pluaSlzn5ZsG?=
 =?us-ascii?Q?DabOXQDMHdr35jFt5LJzSqjg4h4KSPshXZ5W55gMJQszl25epoJ/XCo24dUb?=
 =?us-ascii?Q?MYRBcoEAheMycTGQGZDe2LtA7MIX+UpqfitxvwXXdj6Ncm2Wizp8AhoUe5jA?=
 =?us-ascii?Q?USB9DqW7UPP7jt672V3JiNBVTNh/ciNfudou1dKpABlhsC67VleD4NxNT2GR?=
 =?us-ascii?Q?pyX0eAlQzHuAcakSnXOCGLP8AusfsVi4A2LOAtBXfZnDGIMCeNUVHS+r/gZl?=
 =?us-ascii?Q?dMHVqMaaitH154cUzDUhQtBf3vGPJATCYVN7TbWmgn26jYnbVRAq0sF+sDp+?=
 =?us-ascii?Q?o9r4wG+weXqGgD6gBwIVkhUpMY7tvigsi2Dm6pFIKHdz5Mqxe+2HTBgjEjxB?=
 =?us-ascii?Q?4cWL4oQBgjX/Yeu9Uu5gZFFWo/t913w=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 83efa1c0-ff28-45f4-abbe-08df48d2a586
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2026 19:56:06.9287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBXZzZy+jPeF5U60pclTzR8kf/G41mi2bFQHH9DS0Ul9gP6naCkVjBCVHMxa1RtDY7TTX9TPAHlfVvOcsAHfO5it1dHvRM81PpPY4WsQU7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9925

Below __LINUX_ARM_ARCH__ 7, where MOVW/MOVT cannot be assumed,
emit_mov_i_no8m() put every constant that is not an imm8m into a literal
pool behind the epilogue and loaded it with LDR rX, [pc, #off].  That
offset field is 12 bits and the pool sits at the end of the image, so
from roughly 4 KB of JITed code on, the load no longer reaches it.

Commit 0b59d8806a31 ("ARM: net: delegate filter to kernel interpreter
when imm_offset() return value can't fit into 12bits.") handles that by
setting FLAG_IMM_OVERFLOW and dropping the whole program to the
interpreter, and already noted that multiple pools "would better be done
as a feature instead of fix".  That check does not catch every case: imm
is a u16 in imm_offset(), so

	imm = offset - (8 + ctx->idx * 4);
	if (imm & ~0xfff)

sees the truncated value.  Take a classic filter that starts with
'div #3', whose divisor helper is reached through such a load, and that
is long enough to push the pool out of reach: at a displacement of
0x10008, imm becomes 0x8 and the check passes.  The emitted
LDR ip, [pc, #8] then loads an instruction instead of the address of
jit_udiv32, and BLX ip jumps to whatever that instruction happens to be.

Build the constant in the register instead: a single MVN when the
inverted value is an imm8m, otherwise one MOV/ORR per non-zero byte of
val, or MVN/BIC per non-zero byte of ~val once the top half is all
ones.  A byte at a byte-aligned position is always an imm8m, so the
sequence always exists.  Inverting pays for small negative values: -264
is 0xfffffef8, which costs an instruction per 0xff byte, while ~val is
0x107 and takes MVN #0x7 plus BIC #0x100.

Without a pool, constant loads no longer put a ceiling on program size,
and FLAG_IMM_OVERFLOW with ctx->flags, which held nothing else,
ctx->imms, ctx->imm_count and ctx->epilogue_bytes go away with it.

It costs up to four instructions per hard constant instead of one.  The
pool was not much cheaper: imm_offset() counts duplicates on the sizing
pass, so every use already took 4 bytes of LDR plus 4 bytes of slot.

The 4 KB ceiling is low enough to be hit by the kernel itself.  An ARMv5
kernel fails to boot when CONFIG_BPF_JIT_ALWAYS_ON=y and
CONFIG_NET_PTP_CLASSIFY=y are set together: the first leaves no
interpreter to fall back to, the second makes sock_init() build the PTP
classifier, which needs 5124 bytes of ARM code.  bpf_prog_create() then
returns -ENOTSUPP and ptp_classifier_init() turns that into a BUG_ON.
Neither option is unusual - NET_PTP_CLASSIFY is selected by
PTP_1588_CLOCK, which defaults to ETHERNET, which defaults to y:

  kernel BUG at net/core/ptp_classifier.c:223!
  PC is at ptp_classifier_init+0x3c/0x70
   ptp_classifier_init from sock_init+0xac/0xf0

seccomp reaches the JIT the same way, so filters of that size are likely
rejected there as well; that was not measured.

This is not confined to ARMv5 and ARMv6 hardware.  __LINUX_ARM_ARCH__
is 6 whenever CPU_32v6 is set, even alongside CPU_32v7, because the v6
line wins in arch/arm/Makefile; imx_v6_v7_defconfig and omap2plus_defconfig
enable both.  With the JIT on, an i.MX6 runs this path.

Tested on versatile_defconfig (ARM926EJ-S) under qemu with both options
set: the kernel boots again, and SO_ATTACH_FILTER accepts cBPF filters
up to the 4096-instruction maximum.

Fixes: 0b59d8806a31 ("ARM: net: delegate filter to kernel interpreter when imm_offset() return value can't fit into 12bits.")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
---
v3:
- emit_mov_i_no8m(): take the MVN/BIC path for val >= 0xffff0000, so a
  small negative value costs two instructions instead of four, and drop
  the unreachable 'if (first)' fallback (Alexei)
- describe the u16 truncation in imm_offset() that lets the 12-bit check
  pass on a displacement it cannot encode, and add the Fixes tag for it
  (Alexei)
- correct the commit message: __LINUX_ARM_ARCH__ is 6 on a kernel built
  for both v6 and v7, so this path is not limited to ARMv5 hardware, and
  drop the arm64 comparison, which does not hold for small negative
  values (Alexei)
- Alexei's hunk was untested as posted: the emitted sequences are now
  decoded and simulated for all 2^32 values, and the filters below are
  attached and then run, not just attached

Tested under qemu with cBPF filters of 16, 64, 256, 1024, 2048, 4000 and
4096 instructions, each starting with a 'div #3' whose helper address is
one of these constants.  With CONFIG_BPF_JIT_ALWAYS_ON=y there is no
interpreter to fall back to, so an accepted filter means the JIT
translated it.  4096 is the classic cBPF maximum; eBPF programs loaded
through bpf() can be far larger and were not part of the test.

  versatilepb / ARM926EJ-S   ARMv5    versatile_defconfig    7/7
  raspi1ap / ARM1176         ARMv6K   bcm2835_defconfig      7/7
  virt / Cortex-A15          ARMv7    multi_v7+ARCH_MULTI_V6 7/7

That a v6+v7 kernel never emits MOVW/MOVT, even on the v7 part, is worth
fixing on its own; I will send that separately, since it is an
optimisation rather than part of this fix.

This patch was written and reviewed with LLM assistance.  The simulation
mentioned above came out of that review; it was written three times
independently, and the three agreed on every value.

v2: https://lore.kernel.org/all/20261120140147.166934-1-ramin.moussavi@yacoub.de/
- rebased onto bpf-next, which had taken 0af298e62e5c in the ctx.imms
  allocation this patch removes
- drop ctx->flags, which holds nothing once FLAG_IMM_OVERFLOW is gone
- comment style in emit_mov_i_no8m()
v1: https://lore.kernel.org/all/20261111121621.665533-1-ramin.moussavi@yacoub.de/

Applies cleanly to both bpf and bpf-next; arch/arm/net/bpf_jit_32.{c,h}
are identical in the two trees.
 arch/arm/net/bpf_jit_32.c | 119 ++++++++++----------------------------
 arch/arm/net/bpf_jit_32.h |   3 +
 2 files changed, 33 insertions(+), 89 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index aa240e3de6e70..16ae9c435c619 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -130,8 +130,6 @@ enum {
 #define TMP_REG_2	(MAX_BPF_JIT_REG + 1)	/* TEMP Register 2 */
 #define TCALL_CNT	(MAX_BPF_JIT_REG + 2)	/* Tail Call Count */
 
-#define FLAG_IMM_OVERFLOW	(1 << 0)
-
 /*
  * Map eBPF registers to ARM 32bit registers or stack scratch space.
  *
@@ -193,10 +191,6 @@ static const s8 bpf2a32[][2] = {
  * offsets		:	array of eBPF instruction offsets in
  *				JITed code.
  * target		:	final JITed code.
- * epilogue_bytes	:	no of bytes used in epilogue.
- * imm_count		:	no of immediate counts used for global
- *				variables.
- * imms			:	array of global variable addresses.
  */
 
 struct jit_ctx {
@@ -205,15 +199,9 @@ struct jit_ctx {
 	unsigned int prologue_bytes;
 	unsigned int epilogue_offset;
 	unsigned int cpu_architecture;
-	u32 flags;
 	u32 *offsets;
 	u32 *target;
 	u32 stack_size;
-#if __LINUX_ARM_ARCH__ < 7
-	u16 epilogue_bytes;
-	u16 imm_count;
-	u32 *imms;
-#endif
 };
 
 /*
@@ -404,53 +392,6 @@ static void jit_fill_hole(void *area, unsigned int size)
 #define _STACK_SIZE	(ctx->prog->aux->stack_depth + SCRATCH_SIZE)
 #define STACK_SIZE	ALIGN(_STACK_SIZE, STACK_ALIGNMENT)
 
-#if __LINUX_ARM_ARCH__ < 7
-
-static u16 imm_offset(u32 k, struct jit_ctx *ctx)
-{
-	unsigned int i = 0, offset;
-	u16 imm;
-
-	/* on the "fake" run we just count them (duplicates included) */
-	if (ctx->target == NULL) {
-		ctx->imm_count++;
-		return 0;
-	}
-
-	while ((i < ctx->imm_count) && ctx->imms[i]) {
-		if (ctx->imms[i] == k)
-			break;
-		i++;
-	}
-
-	if (ctx->imms[i] == 0)
-		ctx->imms[i] = k;
-
-	/* constants go just after the epilogue */
-	offset =  ctx->offsets[ctx->prog->len - 1] * 4;
-	offset += ctx->prologue_bytes;
-	offset += ctx->epilogue_bytes;
-	offset += i * 4;
-
-	ctx->target[offset / 4] = k;
-
-	/* PC in ARM mode == address of the instruction + 8 */
-	imm = offset - (8 + ctx->idx * 4);
-
-	if (imm & ~0xfff) {
-		/*
-		 * literal pool is too far, signal it into flags. we
-		 * can only detect it on the second pass unfortunately.
-		 */
-		ctx->flags |= FLAG_IMM_OVERFLOW;
-		return 0;
-	}
-
-	return imm;
-}
-
-#endif /* __LINUX_ARM_ARCH__ */
-
 static inline int bpf2a32_offset(int bpf_to, int bpf_from,
 				 const struct jit_ctx *ctx) {
 	int to, from;
@@ -469,7 +410,34 @@ static inline int bpf2a32_offset(int bpf_to, int bpf_from,
 static inline void emit_mov_i_no8m(const u8 rd, u32 val, struct jit_ctx *ctx)
 {
 #if __LINUX_ARM_ARCH__ < 7
-	emit(ARM_LDR_I(rd, ARM_PC, imm_offset(val, ctx)), ctx);
+	/*
+	 * A single MVN if the inverted value is an imm8m.  Else MOV + ORR set
+	 * the bytes of val, or MVN + BIC clear the bytes of ~val -- a byte is
+	 * always an imm8m.  Inverting pays once the top half is all ones, as
+	 * it is for a small negative value: those two bytes cost an insn each
+	 * the other way round.
+	 */
+	u32 op = ARM_MOV_I(rd, 0), next = ARM_ORR_I(rd, rd, 0);
+	int imm12 = imm8m(~val);
+	unsigned int shift;
+
+	if (imm12 >= 0) {
+		emit(ARM_MVN_I(rd, imm12), ctx);
+		return;
+	}
+	if (val >= 0xffff0000) {
+		op = ARM_MVN_I(rd, 0);
+		next = ARM_BIC_I(rd, rd, 0);
+		val = ~val;
+	}
+	for (shift = 0; shift < 32; shift += 8) {
+		u32 part = val & (0xffU << shift);
+
+		if (!part)
+			continue;
+		emit(op | imm8m(part), ctx);
+		op = next;
+	}
 #else
 	emit(ARM_MOVW(rd, val & 0xffff), ctx);
 	if (val > 0xffff)
@@ -2091,14 +2059,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
 		pr_err_once("unknown opcode %02x\n", code);
 		return -EINVAL;
 	}
-
-	if (ctx->flags & FLAG_IMM_OVERFLOW)
-		/*
-		 * this instruction generated an overflow when
-		 * trying to access the literal pool, so
-		 * delegate this filter to the kernel interpreter.
-		 */
-		return -1;
 	return 0;
 }
 
@@ -2192,21 +2152,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 
 	ctx.epilogue_offset = ctx.idx;
 
-#if __LINUX_ARM_ARCH__ < 7
-	tmp_idx = ctx.idx;
-	build_epilogue(&ctx);
-	ctx.epilogue_bytes = (ctx.idx - tmp_idx) * 4;
-
-	ctx.idx += ctx.imm_count;
-	if (ctx.imm_count) {
-		ctx.imms = kzalloc_objs(u32, ctx.imm_count);
-		if (ctx.imms == NULL)
-			goto out_off;
-	}
-#else
-	/* there's nothing about the epilogue on ARMv7 */
 	build_epilogue(&ctx);
-#endif
 	/* Now we can get the actual image size of the JITed arm code.
 	 * Currently, we are not considering the THUMB-2 instructions
 	 * for jit, although it can decrease the size of the image.
@@ -2224,7 +2170,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	 * we must fall back to the interpretation
 	 */
 	if (header == NULL)
-		goto out_imms;
+		goto out_off;
 
 	/* 2.) Actual pass to generate final JIT code */
 	ctx.target = (u32 *) image_ptr;
@@ -2254,11 +2200,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	prog->jited = 1;
 	prog->jited_len = image_size;
 
-out_imms:
-#if __LINUX_ARM_ARCH__ < 7
-	if (ctx.imm_count)
-		kfree(ctx.imms);
-#endif
 out_off:
 	kfree(ctx.offsets);
 
@@ -2267,6 +2208,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 out_free:
 	image_ptr = NULL;
 	bpf_jit_binary_free(header);
-	goto out_imms;
+	goto out_off;
 }
 
diff --git a/arch/arm/net/bpf_jit_32.h b/arch/arm/net/bpf_jit_32.h
index 438f0e1f91a00..76d83b486deda 100644
--- a/arch/arm/net/bpf_jit_32.h
+++ b/arch/arm/net/bpf_jit_32.h
@@ -104,6 +104,7 @@
 #define ARM_INST_MOV_I		0x03a00000
 #define ARM_INST_MOVW		0x03000000
 #define ARM_INST_MOVT		0x03400000
+#define ARM_INST_MVN_I		0x03e00000
 
 #define ARM_INST_MUL		0x00000090
 
@@ -231,6 +232,8 @@
 #define ARM_MOVT(rd, imm)	\
 	(ARM_INST_MOVT | ((imm) >> 12) << 16 | (rd) << 12 | ((imm) & 0x0fff))
 
+#define ARM_MVN_I(rd, imm)	_AL3_I(ARM_INST_MVN, rd, 0, imm)
+
 #define ARM_MUL(rd, rm, rn)	(ARM_INST_MUL | (rd) << 16 | (rm) << 8 | (rn))
 
 #define ARM_POP(regs)		(ARM_INST_POP | (regs))
-- 
2.53.0

