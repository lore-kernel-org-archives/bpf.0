Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795584783;
	b=jQvsYJ/uNjdJul2x3RvByaUYtHcFeGqBI5pH3DG9e1Ujyc0DzkrVBixc8bJkjf1LQIXY
	 Wq/EqaO9jiqcEuLxrKQeCw2fTWv+VwMlWbEukfBNL5xls7U7TWyd//M5K5b08vnheF6zM
	 q9ByBgWTOQAaCB9zrR4BbH53nZcw+a6IhM7zql/me7ypdCUXmk5QY/MFaCNEqYcAaQ4Os
	 7dn281KdqSPSacXdmqORgMdRKyuEKspPt4UfB5WA91qM1rKtTjBhGalEWgZmuAOq838ai
	 DynzMYsmkyHR3RUDKJYGVXSxStkBfuAQ10RNcKQr/WEvb8MccR3Rz03IXPwOcRKrxIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584783;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=aVIX86ll+4Tfj10fL1PflDS3+aCT3WJ8x3PmDnOxVuY=;
	b=H0c78zz9yYZ59ToKx0kaH7dVyA6+1WxfLHFdm6UKSfofcSzD+1HqMNo4KWMmLoHnc1mQ
	 /w1O4Tpi4xMv/hbE2pnzXa3He14iOjLtqOZShRoTjsO8whN7ul50FuvkSTb8cw4QHfvfP
	 4wujXYYPcMO7Qd8AZUblSTt4WY/6bm7c0jfQFExiXhJ6ARTqrghId8Ex1l7Q6XHK0IC3o
	 oJm9/x7vEBK1Rt6bi5avvjnY/1zwZWiJwcQfN6X0zFmoKaLhUs4iOxLymh1mEUPfQQ09K
	 izDzoDY/L8C/px91kdXkqOS7ICPbFOzqDIzDbNuNYRkV2MBK/Qmy0S5Q1jTBvZFFCmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="HWB7IMJ/";
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489D7606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 05:33:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 489D7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HWB7IMJ/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=aV
	IX86ll+4Tfj10fL1PflDS3+aCT3WJ8x3PmDnOxVuY=; b=HWB7IMJ/5QvaL30n5I
	YUMDZBLxHP/iAf7y+Cb+YBUeBauYcoIvsyQmhI/YnaLtstEV5o+nkytRxMg34VFP
	nU3Ef6eEqIdBRDGf5ZP+cm4HmlCDBm8PD3dGBK7LLNfIBaWQwHoVdd16ubFRL51T
	jz5CTiAG9MxlxNJcV9muwGo2M=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnL6jCcgZrriN8JQ--.11907S3;
	Wed, 25 Nov 2026 13:31:50 +0800 (CST)
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
Subject: [PATCH bpf-next v5 1/6] bpf: Mark task work FREED before detaching it
Date: Wed, 25 Nov 2026 13:31:27 +0800
Message-ID: <20261125053132.444234-2-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125053132.444234-1-luyun_611@163.com>
References: <20261125053132.444234-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wDnL6jCcgZrriN8JQ--.11907S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy3uF1rXF43XFW3GFyxGrg_yoW8KFyxpr
	W3KayUCr4UXFZayw12van2vFy5uws3tw43CFykKry29r15Xr92qr1kK342gFWDJrWkJr4Y
	vr4Yqr4Iv3WDuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UmjgxUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wYq+GsGcsaT3QAA3o

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

Mark FREED before clearing the slot. Every canceller may compare-exchange
the slot with the context it observed; the first FREED transition owns
the map-owned context reference and performs the cancellation or
cleanup. A canceller that observes FREED may detach the old context and
return; a failed compare-exchange means another canceller detached it,
and a replacement context manages its own reference.

Reading the slot no longer acquires exclusive ownership of C. Protect
that access with regular RCU while another canceller can release C, and
preserve unlink-to-slot ordering with a full barrier, including when the
slot is NULL.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 kernel/bpf/helpers.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 937a0d7..8cae3dc 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -5174,11 +5174,22 @@ void bpf_task_work_cancel_and_free(void *val)
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
 
+	/* Prevent entry to RUNNING before clearing the slot. */
 	state = xchg(&ctx->state, BPF_TW_FREED);
+	/* Every canceller may detach the context it observed. */
+	(void)cmpxchg(&twk->ctx, ctx, NULL);
+	/* Only the first FREED transition owns the map's ref. */
+	if (state == BPF_TW_FREED)
+		return;
+
 	if (state == BPF_TW_SCHEDULED) {
 		/* run in irq_work to avoid locks in NMI */
 		init_irq_work(&ctx->irq_work, bpf_task_work_cancel_scheduled);
-- 
2.43.0

