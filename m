Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D87D360720
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770184313; cv=none; b=UJ+SIthYMDNqyVtCF5kOe3OnSPDjT2YDw9ZVJliGOvf3+7HBOc9mJ0+VQ8eVlsGomf2sLYetB7zU3MuvFB4wt8H/T2HMHZCQbAU+ETOp1my+/uPHmmUYqAi+NxBJ9kdbEeGXQKBlo3u5HaaCk8vZ9HLyDyUzrYX3PLUl7DVZe1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770184313; c=relaxed/simple;
	bh=EHbKQIVTqeIGKON9OiE4YL4MYDfTp8GxMi8M6dRx8yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4mWccS8dCTewU3FNFcs4PVLrgu6boOCxMyT2SwUJLuBCAtGFd+xJXaCCSYzoVYxIJmfR+9zCjYqfhnJyjE4YHfCNbgApK2WoXyZxhvwLwSvEQrylgj+kKnDPQmGYROjNhQ6xD6v47ZLTz17VdSutIbbkqS3Pgf8cSmXHGjNVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PhMONOud; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhMONOud"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a7b23dd036so31338665ad.3
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 21:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770184312; x=1770789112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neOpCYQFngkvhjSRp8EQNNDXnkfKVHtTaKJiutiskcU=;
        b=PhMONOudWBWLYKUO+BZmxttaM50ccZAribJrY9TuLAqC4m5VEq3HCTLMkVNBiA5jOY
         GksC5I+G5S4C8B2sFWD5VgVGul9KJas3e9mqhSxwcVs2FxdL33+yV/XBXzXeObnwQ2J1
         AHtLMiuS8Pec9ZXKDoIWSsceeW2gXR8oE1kOIDd53zuPJspcD9uaEB7fVRkfXqfVh1xk
         HC+F9115XaCnmzaNSPxym91eCf07Yhw76kdaIIBCOnhTdrYBnuQUDfAGsyFZnFtojt8L
         hg/pYv+K6OWma18QW/CCdcjue7POnx2dM5Bd7Jk1uq+tlc1Djx7t9/+vFdmGR55TyrQM
         RaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770184312; x=1770789112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=neOpCYQFngkvhjSRp8EQNNDXnkfKVHtTaKJiutiskcU=;
        b=W3JSbb+5ScjNspU3OHja2Sl4TxsjT0BoRFqH0CclHhI7ce6egwBZyc+MICM6Zj2sFA
         7JUOKI8kDEh0CtURU8Fm6N5xEkfvP4iiLlGJ0y/jmRdUHrB83EhypYIB4DYKiwD+lZKV
         wCESL9g/ymQWjGvQhdkP1GuAB1N+9Af6WtO0K/OVvMqAMlVUINnHKGCtNevxBPsFYO5l
         PzAicCeRUfRoXOYaTlN8rv/gCd13YSel+FjZAVu2Xgiuh9RWkD6V9EzPFAftHd8wMuqn
         UCI5XElhjcLwjNkhuu/aOgN+T/VO+lPVivLyc7zDxxEixzcPfYKGz4TD5auflLNilxIx
         zCMw==
X-Gm-Message-State: AOJu0YyBxMdDV851WcbR9J6AAEf8rm6RdxfIyv6bXzs2F3jCtvYUjZDW
	5HNLIZR8tnxKrc8nTxnotrMsuv86Hvx6GIQwoU0R40QuTtbKgL3XOuM6N1GTNQ==
X-Gm-Gg: AZuq6aKjZIapViT4HQNVstHsLxCNMaOzYAO5mhJb4AyXSaJtCoSub39Xq5/b62jSs8c
	IOAszxPinNHU/lElhOiG4/Swy3As7EIUt7u7sRodCrd/qxGxzWqBMU9M9vSv5jA9pDUjDJNp8QE
	W/YA+ACL7NNxMVIpoKEr9+ffS9P8+b5rGogKAZ6kaW+mTUSOFQMbfABf3Gv8Vh25PkaSk11xpcX
	d1qPGwXRY5nmyfkn9mjwxRUariKiSPbH3roLcqD7UnAJUzw3dkPuThp7LzWQkjHGiyCmNaioLsI
	eAhdKWYhVXjLkrBt80MxVYZ0QZNbgOF+QJcrgIlD/q891we2iTTq/A8+3kmqYnklBqPDlbM6maJ
	iY7hOgoUfYvOU/0TL+YXd1rikloZP0E9OHUL5rmj2VzsUd1TO86PG9N9fNoG0QzHx7A/x6gZQOy
	bS/o45n4ZsP+jjjGPecUtnblHIiaayH/0wUI/YpEi5fWlgi+UbDCACR16VNJzPuHjlzViy9UTBv
	fQ1jBUlaANetUbTBuG+qKdMZWkP272XpUkVzf84f/2I0AaW7Q==
X-Received: by 2002:a17:902:d4c6:b0:2a7:7e00:6a96 with SMTP id d9443c01a7336-2a933e51016mr14904375ad.25.1770184312330;
        Tue, 03 Feb 2026 21:51:52 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d1694c8sm1188799b3a.8.2026.02.03.21.51.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 21:51:51 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH v3 bpf-next 1/4] bpf: Tighten conditions when timer/wq can be called synchronously
Date: Tue,  3 Feb 2026 21:51:44 -0800
Message-ID: <20260204055147.54960-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260204055147.54960-1-alexei.starovoitov@gmail.com>
References: <20260204055147.54960-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Though hrtimer_start/cancel() inlines all of the smaller helpers in
hrtimer.c and only call timerqueue_add/del() from lib/timerqueue.c where
everything is not traceable and not kprobe-able (because all files in
lib/ are not traceable), there are tracepoints within hrtimer that are
called with locks held. Therefore prevent the deadlock by tightening
conditions when timer/wq can be called synchronously.
hrtimer/wq are using raw_spin_lock_irqsave(), so irqs_disabled() is enough.

Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/helpers.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index d4aedac14a60..0517e9a8fc7c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1430,8 +1430,6 @@ static int bpf_async_update_prog_callback(struct bpf_async_cb *cb,
 static int bpf_async_schedule_op(struct bpf_async_cb *cb, enum bpf_async_op op,
 				 u64 nsec, u32 timer_mode)
 {
-	WARN_ON_ONCE(!in_hardirq());
-
 	struct bpf_async_cmd *cmd = kmalloc_nolock(sizeof(*cmd), 0, NUMA_NO_NODE);
 
 	if (!cmd) {
@@ -1473,6 +1471,11 @@ static const struct bpf_func_proto bpf_timer_set_callback_proto = {
 	.arg2_type	= ARG_PTR_TO_FUNC,
 };
 
+static bool defer_timer_wq_op(void)
+{
+	return in_hardirq() || irqs_disabled();
+}
+
 BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, async, u64, nsecs, u64, flags)
 {
 	struct bpf_hrtimer *t;
@@ -1500,7 +1503,7 @@ BPF_CALL_3(bpf_timer_start, struct bpf_async_kern *, async, u64, nsecs, u64, fla
 	if (!refcount_inc_not_zero(&t->cb.refcnt))
 		return -ENOENT;
 
-	if (!in_hardirq()) {
+	if (!defer_timer_wq_op()) {
 		hrtimer_start(&t->timer, ns_to_ktime(nsecs), mode);
 		bpf_async_refcount_put(&t->cb);
 		return 0;
@@ -1524,7 +1527,7 @@ BPF_CALL_1(bpf_timer_cancel, struct bpf_async_kern *, async)
 	bool inc = false;
 	int ret = 0;
 
-	if (in_hardirq())
+	if (defer_timer_wq_op())
 		return -EOPNOTSUPP;
 
 	t = READ_ONCE(async->timer);
@@ -1650,7 +1653,7 @@ static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
 	 * refcnt. Either synchronously or asynchronously in irq_work.
 	 */
 
-	if (!in_hardirq()) {
+	if (!defer_timer_wq_op()) {
 		bpf_async_process_op(cb, BPF_ASYNC_CANCEL, 0, 0);
 	} else {
 		(void)bpf_async_schedule_op(cb, BPF_ASYNC_CANCEL, 0, 0);
@@ -3161,7 +3164,7 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
 	if (!refcount_inc_not_zero(&w->cb.refcnt))
 		return -ENOENT;
 
-	if (!in_hardirq()) {
+	if (!defer_timer_wq_op()) {
 		schedule_work(&w->work);
 		bpf_async_refcount_put(&w->cb);
 		return 0;
@@ -4461,7 +4464,7 @@ __bpf_kfunc int bpf_timer_cancel_async(struct bpf_timer *timer)
 	if (!refcount_inc_not_zero(&cb->refcnt))
 		return -ENOENT;
 
-	if (!in_hardirq()) {
+	if (!defer_timer_wq_op()) {
 		struct bpf_hrtimer *t = container_of(cb, struct bpf_hrtimer, cb);
 
 		ret = hrtimer_try_to_cancel(&t->timer);
-- 
2.47.3

