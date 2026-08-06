Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021130.outbound.protection.outlook.com [52.101.70.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F54A310652;
	Thu,  6 Aug 2026 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021371; cv=fail; b=B4lK1HMN6MMWBVKBAudeSGMvKPKJ094yewqh+r0HqjI8XfJXKCLiKZFUXj8vbK/6STYw0lqDYiwU2OcJyjAUSsIjptCHhPYzVDX/8qRmTeLjVK+++JdMAotWAgFpPIaVy9AKSCy257gwe1SApmcMnbMYevuY43Hb6ECNTvuIdLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021371; c=relaxed/simple;
	bh=BI5bUCWRuZLHGwTrXP+GDAMBYMGXw4fnVR7wbMGKRQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=blNilpz30cYvWKSLYwPFI2WHKKIXesphL+po+7XusDmrbRGxuQq73OLehF6pFiDeGmQMMCIaPaF2FoBTAhQap+iO4uH32nGhj2ePtiUHIkfLQX98p5nrBZI8eqKJJoW11iA3+jD0JLGM+MsrZW6/+yE0uk5FoaOxyfIrO4xcmVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=btesa.com; spf=pass smtp.mailfrom=btesa.com; dkim=pass (2048-bit key) header.d=btesa.com header.i=@btesa.com header.b=m/UyC5lj; arc=fail smtp.client-ip=52.101.70.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=btesa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=btesa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=btesa.com header.i=@btesa.com header.b="m/UyC5lj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b1v/A68J0Cu8VM2TL31YY2NTL4b/kJSIl8JKA+auMnm56nu+IQi1fdkVrvaC7ulbttaWfkU9N5VBiCw3lZuXL/RH2aBi0f/guLlL8ZussBrmjY8isFsuokBJxYgLqzMmhZEgfTX4KKVaf8B8rAiIAY13YbOGnOfQbip03w7iahemgWKkSqeiNnwVSf0EEpyt8bSyMbitPkNeGUT3ss/dp9mAzQ6U0hJGgnAUAPcl17ovDusthst7o0mkdOr0sQy3CFSsmsJIWn+oLxnOZrVIaIL6HNTOGOZ1WqYkGoD8WQPibMsYxlVbU4V5m8RrqLy8A5CEQ3WBPjZcO392P4gRgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOEnJ1ergAi1IEB80/SZlZvwSvINtlJGnscMwrTyiFU=;
 b=C74ONrQ1RJIgNCOp09/Yop10uxJXFlEwq/1Jb6KSSy0LSsan1QEkVkNYfJjxb/jyueo6dD0OMzVR5zTQ2lTBwOixKGi7lO2/FfSZlxV5ALPie7Ru4SNPDsCLZX9piiiqYWyVc9i1pzWtANO5GVhKGEDC7ZorLYnYDYiB/LnqsK/chQH/Nb5OqCi8+ZqcFcXsPPudsTfWN+cIebrsLrYJgvaEGbvAcoXH/Ll0YUwB4q/vZDdxbyvvM74y5EVWgurSbru4AzKS+6n7MIqhAweADAdxxNJ50oRbuddQ6PKMJ03fIgg37WrJ3Nl+IMfixcRakat8ieHJaqAkwmuoDnI5tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=btesa.com; dmarc=pass action=none header.from=btesa.com;
 dkim=pass header.d=btesa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btesa.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOEnJ1ergAi1IEB80/SZlZvwSvINtlJGnscMwrTyiFU=;
 b=m/UyC5ljMg//3ie36mbedAtamC6AbWg/7p7ALDf2w8wHyAQXPR9ZWFP/jqYqTqV+GNhbzuXW35ZlmHsE2QulGqZfRbeRMHfIVQJUvOnBsEbAqd+OU9Ut3XlKCExtn0/IXb1b2aU2FyJ29c4mOtwtkYemZnmuKIG0GlPipcGFALKiBNi4T3MtEc6ciAWVcOR7UvfjtTywQgWSJ2sVnZrFx4L/gUeYcg6cciliodPfH/g8DS5j2zCWcLAdm6Fp53/BA0LknLIIrcmNPlubIhDEl8Jf+KjsBYp//p3ZIsW7ZbvT7XzMCca2P3kSzMjrCTLT5ETpEpiJQcuUoujW/bHIQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=btesa.com;
Received: from DB7PR07MB5386.eurprd07.prod.outlook.com (2603:10a6:10:76::25)
 by DB9PR07MB9739.eurprd07.prod.outlook.com (2603:10a6:10:4c0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.6; Thu, 6 Aug 2026
 13:02:42 +0000
Received: from DB7PR07MB5386.eurprd07.prod.outlook.com
 ([fe80::dde5:3c49:278f:7c2b]) by DB7PR07MB5386.eurprd07.prod.outlook.com
 ([fe80::dde5:3c49:278f:7c2b%5]) with mapi id 15.21.0292.012; Thu, 6 Aug 2026
 13:02:42 +0000
From: =?UTF-8?q?Israel=20T=C3=A9llez=20Garc=C3=ADa?= <i.tellez@btesa.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Israel=20T=C3=A9llez=20Garc=C3=ADa?= <i.tellez@btesa.com>
Subject: [PATCH bpf] bpf: Fix pending_pos walk on 32-bit ring position wrap
Date: Thu,  6 Aug 2026 15:02:14 +0200
Message-ID: <20260806130214.66028-1-i.tellez@btesa.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA3P292CA0009.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::10) To DB7PR07MB5386.eurprd07.prod.outlook.com
 (2603:10a6:10:76::25)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR07MB5386:EE_|DB9PR07MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 9253e9f8-0871-42a6-51af-08def3bb0018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|52116014|7416014|376014|5023799004|56012099006|3023799007|10067099003|6133799003|38350700014|18002099003;
X-Microsoft-Antispam-Message-Info:
	MxTmsTQUN06N94GblRGNU/z7HZfdndjYk+luaAz07D2JqdASg+nlgaXCUMt9mSoWhk053BvYF5wlL7cZtLvzwJAJ/yUpWBEZ+8WMYwU8fuRnStYQHUAAgyeRH414zCnjP3pbddknBeSK/f0MjE/ssu7fnOBu3bvM+nVJw90KCZxEfsIqVyJlhsPcPXke7W2/3KeDpP6DYOy5zxdUJEBa1uUDO5XbwAsTiSzxdHlngj+SCXIgo19D61c+CuCIXhC2io+I6Ok2LCHbkSEOeJNUoCwRfWQ2dRzr3IqzB+aBJwdHDHKcp+LtnY+aHrlMgweGDKWUSW0Upi03HqvZPdazh+U98HkE9qt4XO0a989GMKgwZIteH/W7yGMu+PAtxisdKKw4MkQIGIb3L5E81vHc/Jd1NWWan9P226rn5jeST9Lu+ezR/v7aaXLCXVCVd6CsVaavX5T9lFSpUnYQbDzlacFaN36zCc6wHKusun40S6h4qeEuqssGPSKa241JZ3AUeGwyH/eRPkw2ZGWpuMk4G+dmpfqYn4YdldfZZcRuGOJqp3eExDthGHiCvF1b3TkKolEDRHU40K3iSCDjAn9QnGXDITQ38NAM3iQxz6K4EM1Ki1ZKR+ts8d2gWSZvHSWWLLtwm+wxiMArev5qt6+GASrobN2IWy/OcJbczsar24H7n3RJuhQsG8ro4WacB04UTA2IeKOPfjY07DtGVgQvkbtEIyOPVR82DXhvspE+dJw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR07MB5386.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(52116014)(7416014)(376014)(5023799004)(56012099006)(3023799007)(10067099003)(6133799003)(38350700014)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUhtOVpxLzFEUlZHdXdBREl4VW1QRUJKZVE4ZFVGcFNFc2lPUThkQ0NpL1JH?=
 =?utf-8?B?SzJqN3ZFaExLRTYvb1haQTA5dGxlY1lnSlF5TEVxSEIwZGx0WUN1Tmk1ZWNN?=
 =?utf-8?B?RXY2SU4wRERKV0plWVdENTRNZms1MU9oZGQ5VE15blhSWksrUUpaWU5KYlVV?=
 =?utf-8?B?bjJVSTVBZXN2c0lQWWNaUmxCT1RkckJ2WXBKeUlBSWtEYmtCck9sUHFLMjV0?=
 =?utf-8?B?QzZQTFJjeVJoeHRrdXRpOTRpRzVxaVhhMmxkZkdXYWNvTFJBMXAxZm4zNk94?=
 =?utf-8?B?enRTelM2Qm55OW0wU2dUTW5uaDQ3SlgvUFV6NGVYaXdtcHJHMXZ5MXpIMy82?=
 =?utf-8?B?UGk4UitKd285QWIyYmNwS2JMR3NCREJ2YkxaK1FXRnpuRC82WWYxanNLcVJX?=
 =?utf-8?B?S0xoRCtGY3dVbHJ3RVFCamsvTWMrMVJJS3JGTHQrQStkVVdXOXRkazBKZnlp?=
 =?utf-8?B?cG9aQkVnVmZxRGRodVNPMUtrMlJTZUtQZXVSNE1EZDllRUFUYXlsbk14azVL?=
 =?utf-8?B?cEhsT2JmZXpuaTlMSE1UUVJPdnpaL3h1TkNkdzFVM3lOOCttUE03cEhpUExN?=
 =?utf-8?B?U0dwendKM1dHZ2ZFMUM0L0U0aFI3WFVhd0R2WmRpanZMOUIrclpIbjBXRlZD?=
 =?utf-8?B?aUc3OVQzZWw4aGczMjJmTnRmNmZTZ1VidHNzN1BVa1dxV25kSTh2bENJYVhN?=
 =?utf-8?B?a0tpSVlMUFJwZ1c1KzNWOUp4WnBEYStkZkJNSmcreVcwK1lNL09nUzdINWtU?=
 =?utf-8?B?dVkwdkdWTHRPaTQreXhzYnA1TDIzOFF2Rk9HVGh4SzRUcDVjMzUwbVZPd0hu?=
 =?utf-8?B?bFA4dklIekFNR2JGMDJJM1VWVE9Jd1phV2M1Y1IvWktpcys4ZEhBY3BJZGRw?=
 =?utf-8?B?ZXZHVCtwQmpNd1kweTI3ZGYxMG0vM3F6N1JnajBranB0TFBJeG5ZQTM0dlJj?=
 =?utf-8?B?MHJyeHJlMlVKT2VZVWdQcTNNblZCMFNHaWNweFJzUk5vUGZCdHlxN1ZuODNo?=
 =?utf-8?B?eHl1bHo3TXk3dWJpamtHWGo4L2ZoKzJoTXVVUm9qY2F6cGZ2bWJEbHY4OVdJ?=
 =?utf-8?B?R0FEMmhNOVZZMlorOGozeGdNeklxNXRNY25yT1hTcFJLbXVxTWlmTy91a3pw?=
 =?utf-8?B?MVBUdXlEdUhXOVdsY2hSSlZrMDZKZklpM1Z3QmNUNVNab2hFMW5nLzNBbVFX?=
 =?utf-8?B?ZGlwdXB0clhBSEVJcG5yV0hneUtJeEFGeW8vS2tZQnVMVVc2RTVuZUJXWVZU?=
 =?utf-8?B?MVk4bzU3bEhNTFFBQi8wWWVBSUsxMExyTWVzMzRnamZVWkJ0SEI3a252UFU0?=
 =?utf-8?B?ZGpvelNqNDloTjZRb2krSUc4UFk5YXM3eTN0YkFjUCtsY0ZmTHg3bVRzK0Zn?=
 =?utf-8?B?OHBZV21jck8zdWlKR0lmKys3YXlaZTJWVzhlR0FJZTVZenFCTDdEMXdOUnhi?=
 =?utf-8?B?K1RpbEpOTlRnSnE5bXBJY0RnSW4yMU1EdUhPVXo4bDIyMCt5N3RkcGRnTi9Q?=
 =?utf-8?B?N1F5M29rVUQwZW1lWU1iek4rd3JJSlU1KzJmdGM0ei9RMS9MMndJd2hZQVVY?=
 =?utf-8?B?aTNzUzlNb1lnWFp4ZUlVNmZsQ3loYkZRZ0hUdDRGVE52MjIxZFA1VlFwS01V?=
 =?utf-8?B?SmZTYzFObDlZdFU2clpYTStJV3ZzT2MxWVRKbFBUSERHK3lZT3hYcUlXc20v?=
 =?utf-8?B?dEx4NWVNNUlJazQzZVFHaTdjcmhzWFhDc3lvTm95STB0d2s1bll2SzVBTnZW?=
 =?utf-8?B?Z2hSRyswaElhcDhGblFBaFNIaFNnQmV4K09zUGpic21Ed1FHWm9KKytCbkto?=
 =?utf-8?B?anpINU9wWW5ncnZIQUhlSnJyT1Znb2pXQ1RFcnZCZ3hMUnBqRG1rbVkvNFZz?=
 =?utf-8?B?NGZkdzJMbXlUY3lTWmVna0gyRFdYdWRGQjArOVVKWUU5QVRoNWtsUDVuZHVv?=
 =?utf-8?B?VlhyMmFSVjZyRXFpc2ZVWHc0dmdMbjdqY0pXMnR5YytYSXZxdmNkenhhTEFJ?=
 =?utf-8?B?SEdrWVppRnd1dWRWYzdqYnNxcG83VXkwUEN0RjdWckFCb2htVmpjWnJhQTNG?=
 =?utf-8?B?MW00R3R6YmlFV1QzMVBDbGlGL2hLN3VHTDgvV0NEZW03VFd2NWwvQWJLUGF1?=
 =?utf-8?B?M3h4OWloMEVQYVdDTmlsT0pVSStYTmFSYy9vWDhxMG9GYWxRZ0NGMHZGTEtK?=
 =?utf-8?B?UkhmQ1lnbStZNU8wbkJpUS9UbGNuQmZqU3JsQ3FGVjJHNzhPbWw0UTlBK25l?=
 =?utf-8?B?K3VwNkpxRTZFYVZmK3FWMWNtNUp1MGVLeE1WTnNpM0J1RmN2L3hpRHk2RXE5?=
 =?utf-8?B?QWFtbWw4TkZuN0d1MmVzNFJVS2hZanNUUTBDOXJQMzVxbHpvZ05ydz09?=
X-OriginatorOrg: btesa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9253e9f8-0871-42a6-51af-08def3bb0018
X-MS-Exchange-CrossTenant-AuthSource: DB7PR07MB5386.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 13:02:42.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f51efa09-da77-4b78-95dd-fde75cdb9c62
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ln8YLDkvqbQ7BWWcmBgr3hwNZdktZ+9CRlBpchZp73gqfBI6+4DtL0d7M6vZj4zlLs3bR3OaRYc7ls3v3Rr33g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9739

The reservation path caches the position of the oldest not-yet-committed
record in rb->pending_pos and advances it past already committed records
on every reservation:

	while (pend_pos < prod_pos) {

consumer_pos, producer_pos and pending_pos are unsigned long, i.e.
32-bit on 32-bit architectures, and Documentation/bpf/ringbuf.rst states
that these counters may wrap around there. Every other comparison in the
file is written as a difference, so modular arithmetic keeps them
correct across the wrap. This one is an ordering comparison, and it is
not wrap-safe.

Once producer_pos wraps past 2^32, prod_pos is small while pend_pos
still holds its pre-wrap value, so the loop condition is false and
pending_pos is never advanced again. Reservations keep succeeding for a
while, because bpf_ringbuf_has_space() uses differences, but
new_prod_pos - pend_pos grows as the producer advances, and once it
exceeds rb->mask every subsequent __bpf_ringbuf_reserve() call fails:
the kernel believes a pending record spans the whole buffer. The ring
never recovers, bpf_ringbuf_output() drops every event from then on, and
nothing is logged.

Observed on four armv7 devices (i.MX7 Dual, 6.6.52) running a
tracepoint-based collector with a 512 KiB ring and 160-byte records.
Every one of them stopped delivering after exactly 26846821 records and
4295491360 bytes had passed through the ring, at event rates between 441
and 862 records/s, that is after 8 h to 17 h of uptime: the trigger is
the byte count, not time or load. That figure is 2^32 plus 524064 bytes,
and the excess is one ring's worth of grace period, as expected while
new_prod_pos - pend_pos is still below rb->mask. The last reservation
that fits is the largest record boundary X with X + 160 <= 524287, and
since 2^32 mod 160 = 96 the boundaries after the wrap sit at
X = 64 (mod 160), giving X = 524064. Userspace kept consuming normally
until the producer stopped, then read zero records for good. With this
patch applied, one of the four devices took 10 GiB through the same ring
with no stall, while the three unpatched ones kept wedging at the same
byte count.

64-bit hosts are unaffected in practice: their counters would need
16 EiB to wrap.

Compare the two positions as a signed difference, which is wrap-safe
here: the real distance between pend_pos and prod_pos is bounded by the
ring size, far below the point where the sign would become ambiguous.

Fixes: cfa1a2329a69 ("bpf: Fix overrunning reservations in ringbuf")
Signed-off-by: Israel Téllez García <i.tellez@btesa.com>
---
 kernel/bpf/ringbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 35ae64ade36b..2c08a98370d5 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -482,7 +482,7 @@ static void *__bpf_ringbuf_reserve(struct bpf_ringbuf *rb, u64 size)
 	prod_pos = rb->producer_pos;
 	new_prod_pos = prod_pos + len;
 
-	while (pend_pos < prod_pos) {
+	while ((long)(prod_pos - pend_pos) > 0) {
 		hdr = (void *)rb->data + (pend_pos & rb->mask);
 		hdr_len = READ_ONCE(hdr->len);
 		if (hdr_len & BPF_RINGBUF_BUSY_BIT)
-- 
2.43.0

