Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795059112;
	b=KzXrB91dt3CXBJe2x7keFFHTEsTC1Ur3RK9n8tJw0V6NnUMevrdWCSnVoN31fZnz1eZ8
	 vCh11vOQTgVqEk70aTntDYfyJTvbj1st29AKq5iFdGXgyt0K9iAaCxt5zXU4Vk6fKlgs0
	 1i9D+XWVk02nDqrvFIc54HhdMVpvFhseG+6XB6EaKhQHOifD47Ej9olZam3sj5Wj7VUMs
	 qLKO17fKUuAEp4SustaCGnzBcIwgkRXZNfYznMZaESTQgyMi1XLQZN56PTCyqnthEAy2m
	 kPOfjMHgDyGusK0T5JpVIVvr/z2Jwr5SbO+LYlgY0OxKKlfzIM4ka+89VNEH2xCuyWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795059112;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=rjel6/lEJoQu8KrafnH5y+VHs4euFK2Sj7xBNNKiAEU=;
	b=uYrIWEMp8j1FGO8n2YBZ6/T7yLiDaEUu8hTMANOiEv36as/tokfEDoi6/irOTWX2ROK3
	 +TFKcQJBWEKcMZJdQdTq0joPnt9UOS5rRoZK1BRyUQLPMTQLUtyJ/xg1RQfGkJ2DC7D8C
	 UIBEAtIC0y47RrdG9M/hGkKsyxZpOSRgdVq3HNnfQ5QtCzfn2mxVVPP3w/5kdfTo0OKEM
	 lZMGv19zkcqrHr2rIw2EaVST/SQLdap/STp7eWg5VsQKCAnrWaW+pMjy8oJ0rVyodbde6
	 17nvjWOly7cuZtzV4BQXYNoRg9t9P6oDl6mP8ckNExEFh0R3LzCd2ovMNWJj2kSxcWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AbdGnE6A;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E7B60A2601
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 03:31:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36E7B60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=AbdGnE6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rj
	el6/lEJoQu8KrafnH5y+VHs4euFK2Sj7xBNNKiAEU=; b=AbdGnE6As96uQzpV/T
	V69EwAAUcIN8AHvG5+nBu3YJxKSnoPaHE3h4VjytMJL9C77GXr856s1LP1Mi0sAH
	b6x84pbBzOxMuQectd9EsSKTZWxMlL/lIw/vo+duJSTW38yDzJaQHrb31UxVQk4D
	pKG0SF6icOW1Qt0uiwv+7jJc4=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3Xzx1bf5qM8OwJA--.54798S3;
	Thu, 19 Nov 2026 11:31:04 +0800 (CST)
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
Subject: [PATCH bpf-next v4 1/6] bpf: Mark task work FREED before detaching it
Date: Thu, 19 Nov 2026 11:30:46 +0800
Message-ID: <20261119033051.196177-2-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119033051.196177-1-luyun_611@163.com>
References: <20261119033051.196177-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wD3Xzx1bf5qM8OwJA--.54798S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFy3uF1rXF18WrW7WFW8tFb_yoW8tr1Dpr
	Z8KayjyF45XFZFy3ZFvws2v345uws3tw43GFyvgFyavr43XrsFgr1kKFyagFWDJrWkJF4Y
	vr4YgrWIvw4UuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Upq2_UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7BjTomr+bXgi6wAA3N

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
 kernel/bpf/helpers.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 937a0d7d6839..b5674be41dab 100644
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
 
+	/* Prevent entry to RUNNING before clearing the slot. */
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

