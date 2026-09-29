Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB0F8C1F
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 03:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790651141; cv=none; b=WGh1rtzGH8ICTL3EIFSB3c0C4SJAELGVc683pPLZWnsjdKanf1XS39VbfFCO6hd0ndSt3F7PCYp+qIsPWVdjyXZg/vdCUjcX0WjNfjKJebLBuRlMI8trv4nb5LTbCzzIaSlVnPUr+fe5dk3xYGH8sf4BfZ4zCQ4vsXFF+daMiMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790651141; c=relaxed/simple;
	bh=w8DOuZZGd2nm/gkt6BoLViQEfnm/YPVtC9gklxjn1mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HHl3Ysw6Vswa8OtH+LovvJyEcs1NYP/rtdiupx/BijtVUP5l59uWeRT9wxyk4I3C9eM5SrXiyPYOPwSDXyAaVEBoWfwxFrkEYvmbTrS7ioglElZXsHHYQjQ1tsNsu6lSxp9djdWUIp17sJwDu1InmzWnH0WfR5s7L9CFE9Yarcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=ZVKh1sZY; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="ZVKh1sZY"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144f47a9b57so3280198c88.2
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 20:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1790651130; x=1791255930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xj/nT+s+vfeEgAANroYRGDSiPbdpYtnqapJFVXVuFHg=;
        b=ZVKh1sZY41Ki2YuxgAD9wQzogZIwnkeFyrQSAKJ2TfNBCvVCRu1Zb5VpmeLhJOWuvv
         Zmvt2dPHqnjBhjGwbcF5mob+V16UN0Ro5qW8xxfy0gVWUi4vDfA6l6sxF8aUKTkiZp3B
         vdFtsPto1z/Pkr7xWR/u6RLYMaqOVB1/xZHt4ct/dtsfoLkLbXdzu1Z0ezlIQg64QjBd
         xbpMP7isMvIiIuJdCbvM4B2/t6Ytixa5kzNzASfY1klyjLM4HTZQPg/5ZPKqZdycg492
         fqlF5gqrJXxHjx4Kd/vKzAynCSJT28ImkBdZltoUdcJCYm0PG9NVgDheYOYPM1bP9hO6
         xYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790651130; x=1791255930;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xj/nT+s+vfeEgAANroYRGDSiPbdpYtnqapJFVXVuFHg=;
        b=Lol/6sFZHbeUNP6K438WOP3BgRvA57t8OuA3B1M/u3Bnex2ZbcI+bCD0LF1nJtWu8g
         YF0HfjIFzED/0bI9WdEJHUBSZhZdfMSBvEuyB/pIxc4swFEdPPmpCzoU09hNJQ6xVyJU
         T7/Wvh9osB583jYPN1b/KMTFoyn3JnBD/7KILg6+3NfK5xkFTvWDT21lo5G+PdftuuYb
         ofKMwfH7tnaUdXtufQFbK4o0inW3F1+pI/rZU//9cEVNMkVnxhp+aR4EQGwVrxhAi1p4
         8q/wAexIwt0wMU6wk1Ltlx+C5hg+CZfiQaQdkjWi8MMSacwBGPf3WKQm/2/UAyOLI7ae
         8KZQ==
X-Forwarded-Encrypted: i=1; AKwUvBzRxj2m5bqwM3/R6y01OOPC7VuHS47tA+iGRrgRDb1INp8vlgv5H7jw4t2DW4Kh743BFXY=@vger.kernel.org
X-Gm-Message-State: AFuF++n3/e8lwobGGqPRq4O5E80TBnE4dKeWlOmXdyWgvhX7GWqDw40E
	JASJn6vkZemxycAXLhejTBSC+mj71LRyVBNd3zGt1xR3rGe0lFEe7bitEdr/xi5itUk=
X-Gm-Gg: AYBFou0lqgLHCzOhcOxP33T2QE34j680q920JmjkEk0PS6vJVJQhDLAif4iDyM00oDf
	8+mZLY6uXTbii7csNrWP4iegqhmDVXcWObR8kR5EVDWJAneBEci71aPfhr0ycFN+AlmwbHpcKGm
	xbevHmd4tKxDp8JA6eYkfyLG+AWjej0rfb9DAWY0DYs/yI+AViyNvaMgEvQjYujz3JxszBU1oSY
	6s9ZVow2QCN8B5z/OMLAw/2NTu8LhJMBC3d/7TBffn/Ycmj3//fP9w5EEQUj78JEiJ4AmVp87J7
	mfCe4AQt2xpUibuIX06C71KXjfruDAKDY3qvVHHpsKURvYYsJmbIHhxwZGxUxat+iEFrAQPUjV8
	Wb2+JnXA1JsUNxf8pGDV3F7WSmFngCucjtz6inGlHFZeTwLjktrWx+elpN9OfQU4H184eqcXAD/
	neDsRB2obee5HeeV0FC42AwWlQYEeQzyg7Wvvfpi+E4xRPTgBYkLWthMKxSayX7Y+HtsNgQjiXY
	8uBcDcIq/rf/mDhw0Zx7uKnL/cQmBSZtB6E0Z4EwIWPz45MHIvlscYd2Iawj9fEClRLz6A=
X-Received: by 2002:a05:701b:2506:b0:141:4c37:a20a with SMTP id a92af1059eb24-146cdeb8d0fmr11289108c88.9.1790651130029;
        Mon, 28 Sep 2026 20:05:30 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:3481:cbb6:f339:9e4e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-146bb6551d9sm20275279c88.9.2026.09.28.20.05.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 20:05:29 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	netdev@vger.kernel.org,
	sdf@google.com,
	toke@redhat.com
Subject: [PATCH 6.6.y] bpf: Defer work in bpf_timer_cancel_and_free
Date: Mon, 28 Sep 2026 23:05:23 -0400
Message-ID: <20260929030524.86560-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kumar Kartikeya Dwivedi <memxor@gmail.com>

[ Upstream commit a6fcd19d7eac1335eb76bc16b6a66b7f574d1d69 ]

Currently, the same case as previous patch (two timer callbacks trying
to cancel each other) can be invoked through bpf_map_update_elem as
well, or more precisely, freeing map elements containing timers. Since
this relies on hrtimer_cancel as well, it is prone to the same deadlock
situation as the previous patch.

It would be sufficient to use hrtimer_try_to_cancel to fix this problem,
as the timer cannot be enqueued after async_cancel_and_free. Once
async_cancel_and_free has been done, the timer must be reinitialized
before it can be armed again. The callback running in parallel trying to
arm the timer will fail, and freeing bpf_hrtimer without waiting is
sufficient (given kfree_rcu), and bpf_timer_cb will return
HRTIMER_NORESTART, preventing the timer from being rearmed again.

However, there exists a UAF scenario where the callback arms the timer
before entering this function, such that if cancellation fails (due to
timer callback invoking this routine, or the target timer callback
running concurrently). In such a case, if the timer expiration is
significantly far in the future, the RCU grace period expiration
happening before it will free the bpf_hrtimer state and along with it
the struct hrtimer, that is enqueued.

Hence, it is clear cancellation needs to occur after
async_cancel_and_free, and yet it cannot be done inline due to deadlock
issues. We thus modify bpf_timer_cancel_and_free to defer work to the
global workqueue, adding a work_struct alongside rcu_head (both used at
_different_ points of time, so can share space).

Update existing code comments to reflect the new state of affairs.

[ Backport to 6.6.y: mapped deferred deletion to the older bpf_async_cb
  layout while retaining the work and RCU lifetime ordering. ]

Fixes: b00628b1c7d5 ("bpf: Introduce bpf timers.")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Link: https://lore.kernel.org/r/20240709185440.1104957-3-memxor@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi Greg, Sasha, and bpf maintainers,

I am working through the small CVE backports still missing from 6.6.y.
This one addresses CVE-2024-41045. It defers timer destruction so callbacks
cannot deadlock or leave an enqueued timer freed.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.
The target-specific adjustment is recorded in the bracketed note above.

Could you please queue it for 6.6.y?

CVE: CVE-2024-41045
Upstream: a6fcd19d7eac1335eb76bc16b6a66b7f574d1d69

AI assistance: An LLM helped identify, adapt, and validate this backport; I
reviewed the resulting code and validation evidence.

Thanks,
Artem Dinaburg

 kernel/bpf/helpers.c | 58 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 419e49946cbdb6..1fa140915b0c03 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1104,7 +1104,10 @@ struct bpf_async_cb {
 	struct bpf_prog *prog;
 	void __rcu *callback_fn;
 	void *value;
-	struct rcu_head rcu;
+	union {
+		struct rcu_head rcu;
+		struct work_struct delete_work;
+	};
 	u64 flags;
 };
 
@@ -1188,6 +1191,22 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 	return HRTIMER_NORESTART;
 }
 
+static void bpf_timer_delete_work(struct work_struct *work)
+{
+	struct bpf_hrtimer *t = container_of(work, struct bpf_hrtimer,
+					     cb.delete_work);
+
+	/* Cancel the timer and wait for callback to complete if it was running.
+	 * If hrtimer_cancel() can be safely called it's safe to call
+	 * kfree_rcu(t) right after for both preallocated and non-preallocated
+	 * maps. The timer->timer = NULL was already done and no code path can see
+	 * address 't' anymore. A timer armed before bpf_timer_cancel_and_free()
+	 * will have been cancelled.
+	 */
+	hrtimer_cancel(&t->timer);
+	kfree_rcu(t, cb.rcu);
+}
+
 static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u64 flags,
 			    enum bpf_async_type type)
 {
@@ -1230,6 +1249,7 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		t = (struct bpf_hrtimer *)cb;
 
 		atomic_set(&t->cancelling, 0);
+		INIT_WORK(&t->cb.delete_work, bpf_timer_delete_work);
 		hrtimer_init(&t->timer, clockid, HRTIMER_MODE_REL_SOFT);
 		t->timer.function = bpf_timer_cb;
 		cb->value = (void *)async - map->record->timer_off;
@@ -1484,14 +1504,8 @@ void bpf_timer_cancel_and_free(void *val)
 	__bpf_spin_unlock_irqrestore(&timer->lock);
 	if (!t)
 		return;
-	/* Cancel the timer and wait for callback to complete if it was running.
-	 * If hrtimer_cancel() can be safely called it's safe to call kfree(t)
-	 * right after for both preallocated and non-preallocated maps.
-	 * The timer->timer = NULL was already done and no code path can
-	 * see address 't' anymore.
-	 *
-	 * Check that bpf_map_delete/update_elem() wasn't called from timer
-	 * callback_fn. In such case don't call hrtimer_cancel() (since it will
+	/* We check that bpf_map_delete/update_elem() was called from timer
+	 * callback_fn. In such case we don't call hrtimer_cancel() (since it
 	 * deadlock) and don't call hrtimer_try_to_cancel() (since it will just
 	 * return -1). Though callback_fn is still running on this cpu it's
 	 * safe to do kfree(t) because bpf_timer_cb() read everything it needed
@@ -1499,10 +1513,30 @@ void bpf_timer_cancel_and_free(void *val)
 	 * since timer->timer = NULL was already done. The timer will be
 	 * effectively cancelled because bpf_timer_cb() will return
 	 * HRTIMER_NORESTART.
+	 *
+	 * However, it is possible the timer callback_fn calling us armed the
+	 * timer _before_ calling us, such that failing to cancel it here will
+	 * cause it to possibly use struct hrtimer after freeing bpf_hrtimer.
+	 * Therefore, we _need_ to cancel any outstanding timers before we do
+	 * kfree_rcu, even though no more timers can be armed.
+	 *
+	 * Moreover, we need to schedule work even if timer does not belong to
+	 * the calling callback_fn, as on two different CPUs, we can end up in a
+	 * situation where both sides run in parallel, try to cancel one
+	 * another, and we end up waiting on both sides in hrtimer_cancel
+	 * without making forward progress, since timer1 depends on timer2
+	 * callback to finish, and vice versa.
+	 *
+	 *  CPU 1 (timer1_cb)			CPU 2 (timer2_cb)
+	 *  bpf_timer_cancel_and_free(timer2)	bpf_timer_cancel_and_free(timer1)
+	 *
+	 * To avoid these issues, punt to workqueue context when we are in a
+	 * timer callback.
 	 */
-	if (this_cpu_read(hrtimer_running) != t)
-		hrtimer_cancel(&t->timer);
-	kfree_rcu(t, cb.rcu);
+	if (this_cpu_read(hrtimer_running))
+		queue_work(system_unbound_wq, &t->cb.delete_work);
+	else
+		bpf_timer_delete_work(&t->cb.delete_work);
 }
 
 BPF_CALL_2(bpf_kptr_xchg, void *, map_value, void *, ptr)
-- 
2.39.5

