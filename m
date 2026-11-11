Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.108
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794399398;
	b=j7MI1A5q+kHp625SW8XgMnV1+n8d4sPE8NDeZQRpj4AiL8F9aziNE5DszLuZzNaVJbg3
	 twDhRqHCn9+fSkMbozbomik0TSMoCK3aXVgMJhjbWdvC5FlWn9JtXWCHscIiA3oh79hEc
	 0rMSnNCaz2/GgUVb2Ywx7T882yKIKQymMPOMQcKLSns1JHwIc2e5QjIq3zF62jm9CKybm
	 PExfcEiUNbgqNJoQ8TcNJy8dkDbWEIXzPDmCyZBKdDsDw8gwTMVMxDCpw4ZiL7kyChgE0
	 AzGx55j/d9/LzO3oKtHBPhL8EcBPXiqWRUlo+noWginBY4dNinbPnD0LgKrSu9+4Pcg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399398;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9F8tAeS4/T0Jd0s/K8PABB/28uAZA3Wum4Nmw4sSBlQ=;
	b=f4OFsFbVOLOXrsFaQvsiY/7aVJy5H3tILWuX1h35FYbuWPwfUyeeIezTQz/DyWYeYaRU
	 Y8X1eo+2YCtVwHTUHOjFmuHnpbwoRki7kuH6qoYEmNoB5IkWw0Xs2bXvfW2KXx9pxbGgi
	 qeG/nzqroimSx74+yU4O7LP+ZjgOo8/bOhFlKWUTbwEWPlBs9bDKA0+Woqnl+bmorQNze
	 Z5QF83XzvFNHAhGfo4L0cDRLCgwC07euCL6ito9WFSOCXVbRNXKxohPfZLw2zJNyRqhqs
	 kdCdHosYGrp9VyCuT2OWGbuUPaTp7RQAm76K2dVLn/sfoEW5M6sVUzPXWIEl0RbR5lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=yacoub.de;
	spf=pass smtp.mailfrom=yacoub.de;
	dkim=pass header.d=yacoub.de header.i=@yacoub.de header.a=rsa-sha256 header.s=selector1 header.b="a/y8LYjc";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.108
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021108.outbound.protection.outlook.com [40.107.130.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F50606A32A;
	Wed, 11 Nov 2026 12:16:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7F50606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yacoub.de header.i=@yacoub.de header.a=rsa-sha256 header.s=selector1 header.b=a/y8LYjc
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEeQ5ateZQKlQTdfr9A4beZ9j6uKny8EzNZvcIuyELxavvwAZt+Sr0TR5sW2IVDbZQEGCCaRRFAiEDn3fgM33BpkOxDVtdBoEyT0MCpO0l4usqZWgulptjo8vHU7fYVJsVAlwg1893nF1/6EfuyVx73fvF5uH9f7Auh3GPYoGv4xP4N2rZbYe+oAW4Fc4mkoyPZlI1M4NNExHOmncHUtAL7sNGjjRVXpOtzhco40EwBZxPLjapf/jW/jIkYJbCQ4Gd/3qDcs2h3p1cYGNI8CR0lIIumnU74wqImjHuvb4D51yMsZJsbaOOrhLFIAPnOgDRyGoTVs0T6zGCMz9q7EFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F8tAeS4/T0Jd0s/K8PABB/28uAZA3Wum4Nmw4sSBlQ=;
 b=Dw2QLuP1wBCxUgZ/ZqakooDllQWMEbP9dKM7EhgzpApiaYN6yerhEANL3PtB8vbEZWCul8U8ist8eq0fhjpHjG3LUv6ylL4PboG/ho2rE8e7RquNbSOhBmeqxFk5cHvaa9CR6Kb1WSudiECl83HqmcuTk0I6BwenAx/BLL5neV2POGC8aUvlr758+mCB2fhpcG4B1gK5MO0ujW7xQmTRe3BaFhB3W8cNMR3fOzRGhQlIdxDpOqPWqaedFZ/qi/n5h21nQsayBCf0eUTMQf368ZZKoMlGYZ70a2A/WiWzQoa4AhZugDZjSX07ANknNx+q/DaGKdeDOXTbVrpYRCpQrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F8tAeS4/T0Jd0s/K8PABB/28uAZA3Wum4Nmw4sSBlQ=;
 b=a/y8LYjcgzTclNup9WM/yZay/MrV1l5t2dVkG4pdZIgXUyhwBq1Fyl2bk0ITL12OPYLFSz6mnSzC81MV9y68dj1awwmqNEDSieh5q/cx92meN3IKy/+crI0v7RXA+gFD6vBNGYUWBscGvlE/9Ws3PMIpKlP18L5nLnsltXwzhD8tJkG78FivF8wE9X/Yl5Z8++wyMxTHGQYWpBfzZy/7eutRzFBHRUlPFuP7pYo2s3JXZz6no8vh7h/2aGUs1P0/H9vPvMG4yQSOvVece1t5T6A7DF/qKVtKIx+Qu/hEpuWjcYFmS2qYGVGdQPmJeiYqHM3bp3UGsNNqkIY4jOfJeA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by VI0PR04MB12302.eurprd04.prod.outlook.com (2603:10a6:800:31c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 12:16:28 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%3]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 12:16:27 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf, arm32: build constants inline instead of using a literal pool
Date: Wed, 11 Nov 2026 13:16:21 +0100
Message-ID: <20261111121621.665533-1-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::20) To MRWPR04MB12069.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|VI0PR04MB12302:EE_
X-MS-Office365-Filtering-Correlation-Id: 097b5945-b921-4729-cf97-08df3fed9c81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|6133799003|3023799007|56012099006|261022115727099003|5023799004|261028144727099003|261026140227099003|261026121527099003|261022105027099003|261102123227099003|261021121427099003|261021123027099003|261022075727099003|11063799006|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	+3ymzO4mnI6AcBSISSCVpjoNrNWFDNOyviD13bYfvIJ2LTDFhP/NYNkoBdDWDTSg61gqMiltZCa2fmoaE4UrC4QdwzeFub6fTWEaXoKV7zvX2d/toE0OGYWOOR+dH70Fqg+pLQjNDQkJw7nP8aj2Q4xVPN8buBbUejzZDrck+r0JfBhivRao/hw1OwqnZ+9meN9mPLFylgInwl9WvM5fiQuRB/OeNVgU8ec05Pp+sYckEbrLOuZvMbvdeTx3Hv8U29ThSvQv1BgpAn8p8HeToe44FdSfMgxfrntj/atZ5LM/WcGq2HfccnTFyugpGYIHTQAk4W6ewQqxBLhK8XhGyv+9DMZffCbH3utsoImAy0pCdv6Lp3oAG49i6w+FNhVS5vH6KFbrGiOAAJWPO3W7oMZL3t3/MCsOASzwym3wRJZwMsJmI7NJwdMSxUkKB+kJ+K+jCQXe7RKkuZx2nG5bYZueO/RNdfb3S+R/EhUFRnxwmFwrUqvq2uKgB9UtFBVs60hpNdo7jvxlKHqoMV73PAnuCpSw6Bxn3flEatWg4CqP5ICTSV+BFjC4WWvyLXMIDI41iywIjPerdF1jQpzKfRuSvu6nThFIJiDm+Dp2/tkobrivKqHCelNTDSucGQCMjXviv5nffhhiFwfo1eRtshDb7wlDqdBVcHwHug2hjjc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(6133799003)(3023799007)(56012099006)(261022115727099003)(5023799004)(261028144727099003)(261026140227099003)(261026121527099003)(261022105027099003)(261102123227099003)(261021121427099003)(261021123027099003)(261022075727099003)(11063799006)(261009223027099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9dPcpbVfgjll/HeomsdMWg5itmC8T5n7uEMNfQv/FW9AWqgguws9uAPPEK/H?=
 =?us-ascii?Q?tFAC0UT7jP+UnRse7v3eodEUUvHQDGquypG3e2taB5eMX/lgQnMWDsnDeucR?=
 =?us-ascii?Q?V0OkQAHXmPpxdap2MExQvMRfKQKcdrVYoV9P2qF/xz3AIfWTjz1bQOlIOaIS?=
 =?us-ascii?Q?b56H3NVk4uSu05YIIuPx6W3zJRpAf/qAd3W/d4jg3E/gBLPfy680Ps6caXIn?=
 =?us-ascii?Q?Sc3a47wd41zmdl8BzP33SR8FMHnuPlYIdfXGnrBz8veLjRf3SXTd6IMBXlzF?=
 =?us-ascii?Q?I0jr8gfuz8YGT5ddU4TBS7d8jngE7yV/aU1FLZ3TKdRmjtlV/kqJfAD2Xbkj?=
 =?us-ascii?Q?mGwVxCe6DbuZ9Ml+8XzwSZbhU+Y7h+eO3baUn2vSDROaHrh55sa/A/3BF2WK?=
 =?us-ascii?Q?bi/wAIZjsDkNAb6WAjL1hhhY0gxkoZY6fdH3odiuH1M1vnavfsw+b5a7Rf8O?=
 =?us-ascii?Q?iwyfb7/3ltwn1P1w2zBQxce+J26tnAZhnqefdKeOGmTHh7Fpas8PuG0lfR8E?=
 =?us-ascii?Q?RWJGI7ncDkuE0G2hkrELZAk3b7kRYJcrzLuL5unhIwc3OJYb90Dv6OA0zH8c?=
 =?us-ascii?Q?TndiZain0ysoc+lSgWglrNJEKeanPeHF0ohCaIurGat1Gz9DBcQBx4gt4YnA?=
 =?us-ascii?Q?MoimimKjTahf2ZNlGWc4i3Od/CteJEGFuoC+RkXEROB+2tYqPX7hY8LrSqIZ?=
 =?us-ascii?Q?yL0uYgOYlUtqmQwV/68hCEvTkozUpVg5sj6CUH1Njqif3sImNWqCtiypo0F/?=
 =?us-ascii?Q?s5vcd1Lty/d89MbryGU5DOH2tymMoC0vE3P24IpQVTeEbE4yNyiFcUiUF4Ac?=
 =?us-ascii?Q?DOKdxgtlmdr00Fgyr0piQbUgQ0ujVcED5MZwFw8wpzXmmwGEYVMmm2bt7y4i?=
 =?us-ascii?Q?FMMhxjRb6Ic/BvG+TD5y7tL+zVcM/+Ar3IIJCEKP0c94rlCdfD0fD57TvH7Z?=
 =?us-ascii?Q?WwIRkGrQujShgm5nXDWMp5DbPbMdbrYtOP0QrOFX9HAB8Pm1pnLTu2IULD0e?=
 =?us-ascii?Q?EUvBUKCoA6NYoWNFwIaBnlob42g/YnCbWN7wIMAAUt39Wbk2tGFQ+uRd3KuM?=
 =?us-ascii?Q?aSDlLz6eef2GGeMLNhSKZyR+rD7gPrcwT3pI5wtqn/3RJkPV+IVm/vojJCbM?=
 =?us-ascii?Q?du9SRoqKrcGGTfxQQuyeQCz4KB6OBr5Qo5o+KBSwaMyp4IVXsYM62bX1dz38?=
 =?us-ascii?Q?cmACwjDyXKTdfzh+/BaCo8P5ilH0Cgb7I9+iiTt8B696tM9wLRCRdD/V5KY6?=
 =?us-ascii?Q?PBk7EWbDE98PGyHXhNNKwSNyvc0XIrkR0dfgYd3am7RUtNdP3mDgoc+46bzi?=
 =?us-ascii?Q?2VA9BRejSf2rJSpgtgO3oxyJIttWAyL0+fFUfbU+LJG+8qPqJ5AQ2BOe8AG+?=
 =?us-ascii?Q?C+30QtmvKXXnzBY6OvKAHNGI2gfD9DXZdLnyPEWSwa5FTKWj0ELK8keRqy2T?=
 =?us-ascii?Q?dMRdbzy+jb0AIs/YVMx/VtGjhPGgJXOQbbDOsHSusMEE6HqnBMdpdNZWavCI?=
 =?us-ascii?Q?ymSAmhddPK7tGuTiO75sP+uoxoO/CfQ0uQsil7X/8Ig56F04dWcMqJ+scvRC?=
 =?us-ascii?Q?MGMPosge6IzuNyRQwuMuAQlcuUJJg2kcgTOKFAk6QUqEz+E030ktaWJkgROE?=
 =?us-ascii?Q?HaQzBgSkqYF/UL2br2n16mp1kR4Dwhb/iJ2CMeFUkJ9JoG9A12BSWoM6tu8K?=
 =?us-ascii?Q?tkB6KVKRqd3tMgTPczQPyXfsHFKJiPZCn5TKIM4VR+FuAFeYo0dlc7jKRVgx?=
 =?us-ascii?Q?ETC2J0lNhb0wH1sbco1z+8QrFJ638kk=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 097b5945-b921-4729-cf97-08df3fed9c81
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 12:16:27.6715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gyha7jYGcPOoS1u6NTJpSWn64f9gNLLEBxoPeKE5xHGyLwec3waRPFRzdf0z+OyfAPqtIcOGVIBdMrIVe8cOsT35BM/sYwn5pWOwyKzY3dU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12302

ARMv5 and ARMv6 have no MOVW/MOVT, so emit_mov_i_no8m() put every
constant that is not an imm8m into a literal pool behind the epilogue and
loaded it with LDR rX, [pc, #off].  That offset field is 12 bits and the
pool sits at the end of the image, so from roughly 4 KB of JITed code on,
the load no longer reaches it.
Commit 0b59d8806a31 ("ARM: net: delegate filter to kernel interpreter
when imm_offset() return value can't fit into 12bits.") handles that by
setting FLAG_IMM_OVERFLOW and dropping the whole program to the
interpreter, and already noted that multiple pools "would better be done
as a feature instead of fix".

Build the constant in the register instead: a single MVN when the
inverted value is an imm8m, otherwise one MOV/ORR per non-zero byte,
since a byte at a byte-aligned position is always an imm8m.  The arm64
JIT does the same in emit_a64_mov_i64() with MOVZ/MOVN and MOVK.  Without
a pool there is no offset to overflow, so programs of any size are
translated, and FLAG_IMM_OVERFLOW, ctx->imms, ctx->imm_count and
ctx->epilogue_bytes go away with it.

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

ARMv7 and later are unaffected, the MOVW/MOVT path is unchanged.

Tested on versatile_defconfig (ARM926EJ-S) under qemu with
CONFIG_BPF_JIT_ALWAYS_ON=y: the kernel boots again and SO_ATTACH_FILTER
accepts classic filters up to BPF_MAXINSNS, all of which the JIT now
translates.  That is the classic limit of 4096 instructions; eBPF
programs loaded through bpf() can be far larger and were not part of the
test.  The emitted sequences were verified separately by executing them
for 6.2 million values.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
---
 arch/arm/net/bpf_jit_32.c | 114 +++++++++-----------------------------
 arch/arm/net/bpf_jit_32.h |   3 +
 2 files changed, 29 insertions(+), 88 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 9ede81afbc50..d3b5d7745068 100644
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
@@ -209,11 +203,6 @@ struct jit_ctx {
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
@@ -404,53 +393,6 @@ static void jit_fill_hole(void *area, unsigned int size)
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
@@ -469,7 +411,30 @@ static inline int bpf2a32_offset(int bpf_to, int bpf_from,
 static inline void emit_mov_i_no8m(const u8 rd, u32 val, struct jit_ctx *ctx)
 {
 #if __LINUX_ARM_ARCH__ < 7
-	emit(ARM_LDR_I(rd, ARM_PC, imm_offset(val, ctx)), ctx);
+	/* A single MVN if the inverted value is an imm8m, else one
+	 * MOV/ORR per non-zero byte -- a byte is always an imm8m.
+	 */
+	int imm12 = imm8m(~val);
+	unsigned int shift;
+	bool first = true;
+
+	if (imm12 >= 0) {
+		emit(ARM_MVN_I(rd, imm12), ctx);
+		return;
+	}
+	for (shift = 0; shift < 32; shift += 8) {
+		u32 part = val & (0xffU << shift);
+
+		if (!part)
+			continue;
+		if (first)
+			emit(ARM_MOV_I(rd, imm8m(part)), ctx);
+		else
+			emit(ARM_ORR_I(rd, rd, imm8m(part)), ctx);
+		first = false;
+	}
+	if (first)
+		emit(ARM_MOV_I(rd, 0), ctx);
 #else
 	emit(ARM_MOVW(rd, val & 0xffff), ctx);
 	if (val > 0xffff)
@@ -2091,14 +2056,6 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx)
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
 
@@ -2192,21 +2149,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 
 	ctx.epilogue_offset = ctx.idx;
 
-#if __LINUX_ARM_ARCH__ < 7
-	tmp_idx = ctx.idx;
 	build_epilogue(&ctx);
-	ctx.epilogue_bytes = (ctx.idx - tmp_idx) * 4;
-
-	ctx.idx += ctx.imm_count;
-	if (ctx.imm_count) {
-		ctx.imms = kcalloc(ctx.imm_count, sizeof(u32), GFP_KERNEL);
-		if (ctx.imms == NULL)
-			goto out_off;
-	}
-#else
-	/* there's nothing about the epilogue on ARMv7 */
-	build_epilogue(&ctx);
-#endif
 	/* Now we can get the actual image size of the JITed arm code.
 	 * Currently, we are not considering the THUMB-2 instructions
 	 * for jit, although it can decrease the size of the image.
@@ -2224,7 +2167,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	 * we must fall back to the interpretation
 	 */
 	if (header == NULL)
-		goto out_imms;
+		goto out_off;
 
 	/* 2.) Actual pass to generate final JIT code */
 	ctx.target = (u32 *) image_ptr;
@@ -2254,11 +2197,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	prog->jited = 1;
 	prog->jited_len = image_size;
 
-out_imms:
-#if __LINUX_ARM_ARCH__ < 7
-	if (ctx.imm_count)
-		kfree(ctx.imms);
-#endif
 out_off:
 	kfree(ctx.offsets);
 
@@ -2267,6 +2205,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 out_free:
 	image_ptr = NULL;
 	bpf_jit_binary_free(header);
-	goto out_imms;
+	goto out_off;
 }
 
diff --git a/arch/arm/net/bpf_jit_32.h b/arch/arm/net/bpf_jit_32.h
index 438f0e1f91a0..76d83b486ded 100644
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

