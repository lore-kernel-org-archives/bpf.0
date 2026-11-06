Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959133;
	b=2KgGf4Y0TAjEh2XHMePvW+d+ep7zu6NchxiWia/oJoBUDTAboB9taSUuBqPntf4T+86B
	 vy6BTiclwihwHJUIY1+9zaHD5Tc4sFUEb1can67iSh3RHqTrqEyZYcomK7VBYnXAreOVQ
	 mlve3qoDIK4nXpA6i2lnJE9KcqdHvWUZnX8Dqb6yP5bYZ0U0kvU4fHtauZlRXRfK+BkyJ
	 84hOHFR3CjgkTwQp8I7bywE4AtlvWBKJhQhpC4RqrafehKU+RF/pscd85zrvGFuFmaZFa
	 +twqx7Xl3cZEau78YfE9J3E5tU7VlFJHsRnuwbmpWMfxfF6L3ReWKBrPOaLUVwn223A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959133;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=6Ay470eL2/AXawWgqsm4txlwPnU1pzWIV9/jfolEaa0=;
	b=Q+UXW3ZekJmRl7vPEjKXnlK+VM0bd4kZKE9PwpywfWaoU2qKe/BUictcf56ITR7Fg8Ur
	 eEdZccG5U1rfBQV0pWrAWKPSpWf4ycfE1PrxSQS933NBe5ZNcvLjD04yvOtn8mGRM2HOO
	 nhV92i+T1nPUdP8YOf+6DbxaMGN4lASz6y6Kk8gXD8AC+Bhw9E0pMIwqHLalVwZf3LS7G
	 aUMnmhzgSZN7pTG0BsCUYGnlFtWpeKC8AI8I5OyyWgmqPFeEJQKpr2kU/zu7M8CEPIAzJ
	 Sk0xr2Ea11qYikL1ZO9fKZkz2WfVfi8EM+94m1oBkXI18lA+nra0jwbfiKmMsXHOeUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=oLoWVWiO;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000CD606A330
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 09:58:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 000CD606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=oLoWVWiO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=6A
	y470eL2/AXawWgqsm4txlwPnU1pzWIV9/jfolEaa0=; b=oLoWVWiO5Ab9bvo4ou
	Du3mQ9VwSuNLbT2dxIF7TUrItOZPiLfD2b1GsU+3MpkY01yw1T4p4RrLlqlHGA7Z
	clNqeXjKPUkWqabzOfOfJPMf3rY7Zgx9fAY7ctZoJCC7YdmLDgN9BxydRfRYVWPV
	Zt5pN6q6sEb0GqrroKll15fow=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3JjikpO1qsU61Fg--.28308S3;
	Fri, 06 Nov 2026 17:57:59 +0800 (CST)
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
Subject: [PATCH bpf-next v2 1/8] bpf: Mark task work FREED before detaching it
Date: Fri,  6 Nov 2026 17:57:40 +0800
Message-ID: <20261106095747.471718-2-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106095747.471718-1-luyun_611@163.com>
References: <20261106095747.471718-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wA3JjikpO1qsU61Fg--.28308S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy3uF1UKF45XrWDKry5XFb_yoW8Kw18pr
	Z8K3yjyr48XFZ2vF12vws2v345uws3ta15CFyv9Fy0vrn8XrZ2qr1kK34agF4DJrZ5Jr4Y
	vr4jvr4xZa1UuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UL4SwUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7AdoN2rtpKfCVgAA3k

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
cancellation. It does not itself free the element, but deletion fails to
prevent the old context from starting a callback.

Mark FREED before conditionally clearing the slot. A callback that has
not already entered RUNNING can no longer start once C is detached, and
the compare-and-exchange does not remove a replacement context.

Unlike xchg(), reading the slot does not acquire exclusive ownership of
C. Hold regular RCU while competing cancellers can detach C and drop its
reference. Preserve the old xchg()'s unlink-to-slot ordering with a full
barrier, including when the slot is NULL. Only the first FREED transition
drops or transfers the map-owned reference; later cancellers may help
detach C without disposing of that reference again.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 kernel/bpf/helpers.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 6788489a2608..281fedabf7b0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -5089,11 +5089,20 @@ void bpf_task_work_cancel_and_free(void *val)
 	struct bpf_task_work_ctx *ctx;
 	enum bpf_task_work_state state;
 
-	ctx = xchg(&twk->ctx, NULL);
+	/* Another canceller can release the map-owned context reference. */
+	guard(rcu)();
+	/* Preserve unlink-to-slot ordering, including the NULL case. */
+	smp_mb();
+	ctx = READ_ONCE(twk->ctx);
 	if (!ctx)
 		return;
 
+	/* Stop callbacks before making the context invisible to deletion. */
 	state = xchg(&ctx->state, BPF_TW_FREED);
+	(void)cmpxchg(&twk->ctx, ctx, NULL);
+	/* Only the first FREED transition owns the map's reference. */
+	if (state == BPF_TW_FREED)
+		return;
 	if (state == BPF_TW_SCHEDULED) {
 		/* run in irq_work to avoid locks in NMI */
 		init_irq_work(&ctx->irq_work, bpf_task_work_cancel_scheduled);
-- 
2.43.0

