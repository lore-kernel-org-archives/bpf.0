Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.85
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795183319;
	b=XtNg5NcOmpxIyXzTMWNi002Rqv+ffJSj0O9yMyPWWiOj7LptCXogEBZpNeOVwpvg9nRR
	 B3xNM36yLki9ddNOJN26WoijwmrDGITAjeJKWvtoMo+qrKd7c/1sCtD5Tiu5xM9FdLxod
	 XL1k9meuCPP74EOOZRlria8VgCK4bV2clMrkO1wOLNOSLiI7aMtPUObThE86GoQB+/wU1
	 /h8dKDVkO5vX2OGy7caFE53MqRIQXwmpvZ162UFbr3LGJBgdKxyTTlkVCcw8MtGLUzKUI
	 BZK803DNzgSl4tW474NF+TC3bIYydaLyWurbkoO5VO0EKChl9Oq+Hn9m9a9yAi4p7eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795183319;
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
	bh=Rk22wXWzqWAW0ej2ZN82aCHUmvycdzZMQp+96abdkls=;
	b=IaTYI0MZvgiB+tMT+cdpxFvPGf6HpSG6lvQREMvLAx7NfWgvH7w2OaCn5on6x6XClrrU
	 MNzfd/R57vHiJzMNhgv4dqVNIMa6EwOoMkcK0ZRvROT775I5Hwyij+wK9ESNTPmuo+yyy
	 pMEJ0zor20T4Yp07fXXBQtJ23AKp12I5yJ4XjbKFAQfP29jkezNaKnp/UFdFt7Adp3gc7
	 GbxpVaBWnIriDQ7dqyaqqumHK+t+GJD1DP7nZCvk8ILr1kOAmXbvHNr5QaCEjdtOjPoPV
	 wNpAzp48hf7iq9+IDqia0SqCOOMkU6kx1YNusOmW41EHDXBuqJ6oSk6P5UmabFclfRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=yacoub.de;
	spf=pass smtp.mailfrom=yacoub.de;
	dkim=pass header.d=yacoub.de header.i=@yacoub.de header.a=rsa-sha256 header.s=selector1 header.b="d7/5mr38";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.85
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021085.outbound.protection.outlook.com [52.101.70.85])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C70E606A332;
	Fri, 20 Nov 2026 14:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C70E606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yacoub.de header.i=@yacoub.de header.a=rsa-sha256 header.s=selector1 header.b=d7/5mr38
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkzNo5aBklLu7sI9s4DMaQvEZZidaPHHxNC2Bl6hFfCAcSMklrhYtxuhwRFxpee+M7fFsbLmI9Nk7u7SP4Oxz+Cdi52fJOvipOdpEnITcy4DQRk9hz37boXmmVvLRVqf88YhouF8PVDKUPK2cpvs5W3Lx32000sUWWiM0+QqNliHQYpG+dyuhX7LmTRGnapA5mGAJ3wkCYaoGVYYT/xNMW9ayOaXLXxBYKUTkb+vxORevEJvCi9n3IvN5rdeG4q1Xm8U2HzFsN9o1lfZCNb5ZQyfOz4CMINmSgWNtrf/kqoUrU/Sq2HwjpFdN7MEbKO2XsoHpuizWeKz4TeTwAUZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rk22wXWzqWAW0ej2ZN82aCHUmvycdzZMQp+96abdkls=;
 b=hdJqbqBNWfWV6U4milrGCi77BVC2D0Wpot631Ikdyz28302RdfO7J7O9qJP/VfpSc/5xKkmFQak5b8n/1AiRm5RzPjXxle8hNsB/3C+ifkXHrcuxcjOyILub2AUxFMxrHRvvH3tfigjpl+zK10oEP6RdQhiJI6smJBg9muJO8PtPfe3JdYi7n2aa37qOSqqR7X8n2dFmUsGQrwx8dVaH+0mLNkUpVo/OY47kz8qyokJ/vYj+oX4pIWM4JShsM/lX8U9JJoCBrZ5FtNC78YwcEpRqIbzQlhZaXf1QUrWTGKgR7FsBN+KvIl/MCTF2z18how4Gij3gvIdfThOuipUvCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rk22wXWzqWAW0ej2ZN82aCHUmvycdzZMQp+96abdkls=;
 b=d7/5mr38YUa2V1745grUaq33iqBfmaSuvhMrvLRJ4JPnbPhSMCd0esrbp8CjNM649E4lgVtLq1zGbo0d9qbZgaxIniAXAdHVM5zS8Rtzq/N3rtsSjMvwrIPPcAsR+SJkajJrWzpUkLdXo9pQ/7le+mDtXOktPeNJEUWdziHKjoYuyhkdis3lcKw05Y3X7AYtss1rd4Rg9UtxoXlTbLSOEqJRJvi9WU+k/iIIzV8d4I8WJTtZl1HYKgZG0heIMUtZUkRJrAvaVHNv9d+v0zV8A5nrvC9wD0sqZZwiDdZlr/C9417fjznh2kB46QgeI+mqYS6WcPwDphMCz+yZNsEjDw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by PA1PR04MB10501.eurprd04.prod.outlook.com (2603:10a6:102:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Fri, 20 Nov
 2026 14:01:53 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%3]) with mapi id 15.21.0639.011; Fri, 20 Nov 2026
 14:01:53 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2] bpf, arm32: build constants inline instead of using a literal pool
Date: Fri, 20 Nov 2026 15:01:47 +0100
Message-ID: <20261120140147.166934-1-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111121621.665533-1-ramin.moussavi@yacoub.de>
References: <20261111121621.665533-1-ramin.moussavi@yacoub.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0399.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::8) To MRWPR04MB12069.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|PA1PR04MB10501:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a454122-7052-4235-dbfe-08df470ed4b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|5023799004|10067099003|11063799006|261102123227099003|56012099006|261026121527099003|261022115727099003|261022105027099003|261026140227099003|261021121427099003|261021123027099003|261022075727099003|261028144727099003|261009223027099003|18002099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	g3SSHo3LJBmypF0UjL5Pnu5WtaqnoN99Tow/wbrwwdbCcF84DIVPnGUBFv0Otf5ItyQzC8v1UoJXxsALz1OZYlxAJh6drqXyLasWxSg2iEHe+c6Uikrgrx5xa5yHoscmaBkyAKBwkD132G6wD3WxCQ7KZhOqg5J87sILvNcyZmyUgafIKfUiyH9Ei0CUURBnabbtrqJQiwc1IIOlK0CNSg86pZ3+/6IfUS1BJDSqAwhvBUiZbAhns4dOAfJqmDznevpO0Qz2vzmU+4tlU6GkiF8oC1Jmhk1lc9eFVIU3pdWwqvOw2MOYpAFDZxPXHhoBlU5SlQuig+tDG6g+4djrCRgaRFauW24o+tDxzgclz/eh6vxg+2FDrehpSD1RblJwrfZiG68y9O8NVO4jJCqHFPKM4JxjQMNf3TKh77uX+GZgyyar1aTVzjKS13DEAfuKT5+61vJlE/3UU53v/JLpQbPaXKE/YGoMKq7APzzBiDYkGoW5ctlGWQgy7QfiVpv4AGZovtqfwZM6+t3wbvQDHda8FSYWEc3Bnu7GOXrs8TicdUVvK1ulT8hRG5riG3wrXovxJf3JT79SAkCaBCNPq6aymgP2XWad4BBS/eEu5+c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(5023799004)(10067099003)(11063799006)(261102123227099003)(56012099006)(261026121527099003)(261022115727099003)(261022105027099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022075727099003)(261028144727099003)(261009223027099003)(18002099003)(6133799003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FYin6se9P+BGoO4CCUh/glNwnBtl2GGRilSn0NRuPJUue3CjS1kelrOGbWy7?=
 =?us-ascii?Q?LdNujYJ92QG0VsDkFsBe6u6hq1Jd6J7ico8DCsNzwXctDiyAUSwpRmo1ra58?=
 =?us-ascii?Q?eWwycSGkgeKPeFSEzITCbr9AjLSfslqPX/mHyRNEysWOgYsVnT+woBH/9RfL?=
 =?us-ascii?Q?YDm4TJeoBMl2bjOT/srw/NUdaUTGaHh8l7H2oLeISOtsSvxMjun3s7rJPnce?=
 =?us-ascii?Q?105T6jHhqLSjCHy4tUI6ULh0oiYCPUPrLXvApiiKRU+P7Jv5qEETzbYvdPH6?=
 =?us-ascii?Q?dm2e3cD4U4ONOQ6qXxf5g6JiUCBagRiO10G7GD1P+jBTzX7v94tbqjfeJgHq?=
 =?us-ascii?Q?FQ490Z2GdWq0BtFSt0fSCntZ5AUKkEspGQPJf+AqCXpGJrgnfrrCUF14nTht?=
 =?us-ascii?Q?6pILPz7hZvciIvNZFQjQ2/Gy1EiXYSB+6i2lZNcicBCAL+8ANdOFT7gnhBw5?=
 =?us-ascii?Q?UQoeD7e4h/uYejXVZO+W1Q57j3SvJITefj+zsrMEPBHWU6ZcQ3YJ4x4wFP+0?=
 =?us-ascii?Q?OVpjXerBaVukfvrLH/ksoUnQQrJHaw8fpVkxBWRbP0hPQYRJ0RsQjRubcQWm?=
 =?us-ascii?Q?vmBbVHLwLU3H3ExQP8eSejnh31lE02VKb3EhEQcq+67vq0yDYKllIWqk4gQC?=
 =?us-ascii?Q?4rlTMSt5/G6m8LytoqOZpnsGSwXjshAk+CUgwiCZOlDnTSgWdL2wg9sDcJ47?=
 =?us-ascii?Q?5N8qVEl/EeZzYROXKgqQ7V0QQxsAE5AlTLr2yrVvKh+34/Jlg+dsRpWfrdyy?=
 =?us-ascii?Q?4AWony1yer0weHNza+txShNmAAJ/13Ft2Ue0JaRJaHMjbjNWlJqIimqN0QuG?=
 =?us-ascii?Q?GUvlz7JvnexLb+SGOLxtM30Xwz7vfAAOfT/OIvr3SGrEMHwMnMj2kWNFAQLP?=
 =?us-ascii?Q?aDaPHwWP1AIBTdlToYKTRZ/fPPcrsAUVOXQeRi4A1KpZ4ak78PCK4Vttbsaz?=
 =?us-ascii?Q?g3GgRr9z0RZvv/A9ghkIkSMJxgKGKttbPuXs6kT34E+3FwXP13Fuk9K2hzrE?=
 =?us-ascii?Q?jwhiuCqK0pbogzmZcqwjTPI0YNbAy+U/dJeeH004jUAXDOYe5YGo+qvnMNEe?=
 =?us-ascii?Q?wWp8FnuPYbx46kgg5vD9vrd4mFrKIFKA1u+4mVmhErnR3ht5LyiMD1WL1ByM?=
 =?us-ascii?Q?MeFZxXmbmZ4V1/9KEky/HEGq8Xb5U5YLvXE0zqq4bGwLBNuQDrBvAOyrQKVq?=
 =?us-ascii?Q?flJyhX42MH8PCjvKWKora1EwVwW1LU6O0/+vaXqVd0zsSd0Z2J0l1Gn14ceB?=
 =?us-ascii?Q?ps1a7BLxThKGZ/AcmFCLz/ZAciM9AcWk7nNXW8UgQsPsCm4BJXDNPqYA7AUI?=
 =?us-ascii?Q?THQPYbI2ztaqXSyo4FHvHQhX3pmh7HgXcBJFCziglJ8IIjAG8eOxs1iLvX3Z?=
 =?us-ascii?Q?gvxrXuXJslzbqGgml5FpepLuWN0wH+lwX8cqlhvGzKpcsTDfXp/HDN/tp+sZ?=
 =?us-ascii?Q?zZMCOl8LuvaWvZJB6GtmoiW0LKrcs5OE5RW0ZlqyyQroTV3eYCbv9q8IkHYN?=
 =?us-ascii?Q?JKP2cQJu3WtupcW48GnspAdXnCTvhrsGRS9qFN6jtqSP7BfFBB2cZ1DS+nOB?=
 =?us-ascii?Q?w4TEZjiNK9h93TFwXsXm7/U8dpLZKUgFYVumU7wBDSeiwB23UeJrlzH8OVxo?=
 =?us-ascii?Q?mDz2OUUmzgzlXlJx2MHanyV+j6oXpkuly2kXePsn2Vg451WZkKS6aZv2QhfD?=
 =?us-ascii?Q?PuQkwdDZXMdqqFKMoxOCGsTIqBXL2L8lwFHS2f3h52+bq/00eIOPnpm4C2tR?=
 =?us-ascii?Q?9GThO8XcTjOzH1Ub8dI2ztZAJkVh3P0=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a454122-7052-4235-dbfe-08df470ed4b5
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 14:01:53.5236
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: teaJFLafmxd57/DXyP3FyB01fAPnbwg7LagMthOcxlZJHDyb+VNBsXlREFD+41toQousZcTFGHqpmdtXZ0bSmWa70QtTWn1cVPhzHqFkVIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10501

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
translated, and FLAG_IMM_OVERFLOW with ctx->flags, which held nothing
else, ctx->imms, ctx->imm_count and ctx->epilogue_bytes go away with it.

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
v2:
- rebased onto bpf-next, which now has commit 0af298e62e5c ("treewide:
  refresh kmalloc_obj() conversions") touching the ctx.imms allocation
  this patch removes
- drop the then unused ctx->flags as well (Sashiko review)
- multi-line comment in emit_mov_i_no8m() in the usual style (Sashiko)

v1: https://lore.kernel.org/all/20261111121621.665533-1-ramin.moussavi@yacoub.de/

 arch/arm/net/bpf_jit_32.c | 116 +++++++++-----------------------------
 arch/arm/net/bpf_jit_32.h |   3 +
 2 files changed, 30 insertions(+), 89 deletions(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index aa240e3de6e7..58d066adea32 100644
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
@@ -469,7 +410,31 @@ static inline int bpf2a32_offset(int bpf_to, int bpf_from,
 static inline void emit_mov_i_no8m(const u8 rd, u32 val, struct jit_ctx *ctx)
 {
 #if __LINUX_ARM_ARCH__ < 7
-	emit(ARM_LDR_I(rd, ARM_PC, imm_offset(val, ctx)), ctx);
+	/*
+	 * A single MVN if the inverted value is an imm8m, else one
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

