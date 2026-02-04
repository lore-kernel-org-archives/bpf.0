Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A51D1632E7
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770174571; cv=none; b=lGLYUL/rgX0ZJAV0rSGlXHuuq23LzKIrI5//TVUcgcZa5KaEfWIqU0cyId4GtLf6PQoviz5rszMsjN6NKPHp7AHmrwQoiAWUTj5FYZiHgfR8wXcNpYd5AqKJLyH8azG0o51DVAQqib/ea9TN4zNvvc23dmXi4OquVl4225wzQVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770174571; c=relaxed/simple;
	bh=EHbKQIVTqeIGKON9OiE4YL4MYDfTp8GxMi8M6dRx8yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pGtHutWImamO14sEu3uYNooYP84t3z+w3lhTrEfjjpJO7wopP3BDT8OWoWFDxxR9kH/kNs3Ks6NVaZqCqiLj3eJZt/FMekggK0oD1faDLNmt6IbUo9jHSyHD4/K92O9z7C8cUCULlHG1DQzt5/UNQdyYCb28FZhWNsk6QaSDJf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNgNs3/a; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNgNs3/a"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c708702dfso3433854a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 19:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770174569; x=1770779369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=neOpCYQFngkvhjSRp8EQNNDXnkfKVHtTaKJiutiskcU=;
        b=WNgNs3/avDKWmeRlaJSB+ipZjEyFIPj45vZ7wJ8OKqiQp2OgBvNDH6dNwZ32NE6uAm
         ZKEoSFH/FVVgXdb3bWBBJYjgLWSCkl/KcgIRjJhOtsFsTWLdE/gr0rnfxtwNqvIWrh2E
         eREZKVOttkW7z4ZTIb1aQIUlfL7pcOyoQAmQf6xeNiuSKCzD97RkpJbHzt/P4rzXBXrx
         DNl7smvYy8INUd6tG3LwSCe+T1iujkc8t6D5JjDEZFlYxhA36eMPhvesYAhWOxHUjloU
         hEOOuyRTfloeIWQizU+R3vocJ82XrhHN3R4hHRjHf4GqPsoOiHKMH0/knY/mDO7vOp0g
         l7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770174569; x=1770779369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neOpCYQFngkvhjSRp8EQNNDXnkfKVHtTaKJiutiskcU=;
        b=FXZHE7Mhl20Se4/YNAmHXpuwbHBwxNJrvGWdeTYGQltjlkB1k7rabVwOGhzaq7gk/t
         92ghC6dEHjNquFbvFl6u1mgob9S2ifeFQ/Ao4B8DCyvDYu1mogauBFhbQBvmh3J5D9iC
         CmE6qy93/LSfxnB/hHUj1gjRZxEplk7yuuijHEzIXfGiz3cbjEhrYOOke/TVNg5byw6U
         gTAFVHoxj26LfkbRAgg6W5kkYn5GHWhw8Mp5FH19ZkSpaEbvKFb0XT8aSVDEKnhaLJaH
         OLC9Krz4rO8UWgw2sytkBjepPFlTsibG4oJ4BwDv3NmfQaqNaZ7oD+Wlqepik07xQWvK
         zosw==
X-Gm-Message-State: AOJu0YwGpZLBcsyJ3meKPl5LMkMWsvpziDOzDSsx1bgm68gZm3aGnj5Q
	jRNZ4CYIAXyyc6rKRWFM8nhZumDX5cdNnuW4hsyp/imQm5kUFeXylwCDHfV6RA==
X-Gm-Gg: AZuq6aLfvcmOfExqyYfeKF38PJBHoFaY/JKKVnVas0A2yzCrMnNfGLmlW43Q1TpVCIs
	6qV9OEGfwYrKvgXy9w5ToBz986esrJ4EKXT5mlor+TsBmuZIQZEuE+rELxXDaruUkWD+Uj+6NLi
	aOJwhKxJs7Q3d++rqmlfhJDuaqFu4OUykR29GgAOwArnnzBkczUPucZ3velYehXbwoOwb10rrjE
	Ro1EDi5J/s51bcq4rpIjbqW54iktZZNnUU2aF7O2XrnHRBBc0cEPeyp56DzKQCM7qxzagLCxVua
	PaLOAZGnMsknL/uixs6yem3Td59609/IEJ0Y4JnyIVTgR7DNlsVpDF2GYTyGTpARWmROVLuRysN
	3pP4m6LXNTiZw2zJX9FLNAl8xXuAz9U2xJ6kLV72kORt2lKkhqk1/9dHh9Uo2t5/REL4geOUc7Y
	FOuIxtaBjjupoDcT492P+xXzNRq5BH+pQL+F+9mHNtJVsz2RklXdDfn2kBfUuHAsUTeoJX0xuTr
	KlDLhTJCo/PwluQNJHF7UPZGTn1d1KHwXyXP8sUbcsjmHXnmA==
X-Received: by 2002:a17:90b:3d84:b0:34c:27ad:71e7 with SMTP id 98e67ed59e1d1-354871f826bmr1235202a91.35.1770174569598;
        Tue, 03 Feb 2026 19:09:29 -0800 (PST)
Received: from localhost.localdomain ([2601:600:837f:c6b0:18cf:ab6c:cac0:3007])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354862ef8a3sm879223a91.12.2026.02.03.19.09.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 19:09:29 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	mykyta.yatsenko5@gmail.com
Subject: [PATCH bpf-next 1/2] bpf: Tighten conditions when timer/wq can be called synchronously
Date: Tue,  3 Feb 2026 19:09:26 -0800
Message-ID: <20260204030927.171-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
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

