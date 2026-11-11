Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365086;
	b=PUV5ojb+GoUO0ZwQ5IcbXDWZ+LV7pVkFrRF3MVlIKJ48osK06jJpErbVo7FzyeGq2RQb
	 uecktO1of8JqV3x2QIpgkpNN8G1ckA5muZlSlSujHQ9opyuqm2GdtHxyrcAcC2U5gVqLV
	 ihQkt3/X2+l//QvmKtmB3q0H0TWwsFpUT+myoGnLGLChyMWyVfCLeBYwpOjy12fgu/vo3
	 ars+/jso5rKvttE72fmxskImyijad/kSMFgqP0QuB9qmCb1OU4BYs8wehbgh2rb+e612w
	 fwbAKqJDYKtxUAoe3P/FgYQLdD+WsAEPZZMAUtF9c0H44Q055R5GP2z6aL0urzS9pfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365086;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=o1Zupg0C/vtuMuangz4WqN01bqC46l3g05DbKVABnMk=;
	b=l+5cP9g8DCUA1gBzY6WTR3XKdMGITQOPcjaamQFlshHVtlEIesep5Q+Xq97Ew1wvSkuV
	 +7KzVBYm7sg05p7tdrHLE7nQC/wVh6k4HfsKJ13mDgZk2pE8/rVHInjgRAXhRXBhVKyAr
	 r6UaU/Ovn32HRZsWJ0BbYZZy8HvALKccCJU1tNDOPoZi3GqLNkBb8QkqrDZIibueN9mlQ
	 sdGrwNfr2vwHY4ADNDTUII9UsIy7CB92PBm7ysLEIMyimS03aK00QdtENhGV2namauHdH
	 f++TAu2Qqgo1yyNR2ZWLxqLKeMcJrkewz4B32WOjl5JA6rdBkCmI9zkt5Y8Kemq2X2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=B6K42RyG;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D795606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 02:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D795606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=B6K42RyG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=o1
	Zupg0C/vtuMuangz4WqN01bqC46l3g05DbKVABnMk=; b=B6K42RyGT71IttzpQx
	9sbVHbzncPUtCw9yRdbAqkMqhC1f4VDuy7zipVWNrYadAeGMXESYt5jzgCqdoiPV
	LxoP46kXl0b6RxMeA0zhw8eWMdv2xkXkeWB49AbTC7rXXUFMVJj2/wApVcYnPIAT
	WtUZL0dIKOMCG9M6L51FRB3qY=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBXCgpq1vNqdIGjEw--.26036S3;
	Wed, 11 Nov 2026 10:43:56 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 1/6] bpf: Mark task work FREED before detaching it
Date: Wed, 11 Nov 2026 10:43:28 +0800
Message-ID: <20261111024333.228633-2-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111024333.228633-1-luyun_611@163.com>
References: <20261111024333.228633-1-luyun_611@163.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgBXCgpq1vNqdIGjEw--.26036S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy3uF1rXF18WrW7WFW8tFb_yoW8tryUpr
	Z8Kayjkrs8XFZ2y3ZFvws2vFy5uws3twsxGFyv9ryavr45XrsFqr1kKFyagFWDtrZ5JF4Y
	vr4YgrWIvw4UuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UlNtsUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wxoN2rz1mxYegAA35

From: Yun Lu <luyun@kylinos.cn>

bpf_task_work_cancel_and_free() clears the value's context slot before
marking the context FREED. A concurrent deletion can observe the empty
slot and return while the detached context can still enter RUNNING:

  uref cleanup                 delete                  target task
  xchg(slot, NULL) gets C
                               unlink E
                               cancel sees NULL
                               return
                                                       C -> RUNNING
  xchg(C->state, FREED)

A preallocated HASH uref walk racing with deletion allows this missed
cancellation. This deletion does not itself free the element.

Mark FREED before clearing the slot. Only the first FREED transition
clears the slot and drops or transfers its map-owned context reference.
Until that canceller clears the slot, no replacement can be published,
so a plain slot store cannot overwrite a new context.

Reading the slot no longer acquires exclusive ownership of C. Protect
that access with regular RCU while another canceller can release C, and
preserve unlink-to-slot ordering with a full barrier, including when the
slot is NULL.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Signed-off-by: Yun Lu <luyun@kylinos.cn>

---
 kernel/bpf/helpers.c |  12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 937a0d7d6839..4b252ca61166 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -5174,11 +5174,21 @@ void bpf_task_work_cancel_and_free(void *val)
 	struct bpf_task_work_ctx *ctx;
 	enum bpf_task_work_state state;
 
-	ctx = xchg(&twk->ctx, NULL);
+	/* Another canceller can release the map-owned context reference. */
+	guard(rcu)();
+	/* Order a preceding unlink before observing an empty slot. */
+	smp_mb();
+	ctx = READ_ONCE(twk->ctx);
 	if (!ctx)
 		return;
 
+	/* Stop callbacks before making the context invisible to deletion. */
 	state = xchg(&ctx->state, BPF_TW_FREED);
+	/* Only the first FREED transition detaches ctx and owns the map's ref. */
+	if (state == BPF_TW_FREED)
+		return;
+	WRITE_ONCE(twk->ctx, NULL);
+
 	if (state == BPF_TW_SCHEDULED) {
 		/* run in irq_work to avoid locks in NMI */
 		init_irq_work(&ctx->irq_work, bpf_task_work_cancel_scheduled);
-- 
2.43.0

