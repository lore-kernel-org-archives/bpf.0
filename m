Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795393639;
	b=ESZx9liDHvVcBN5OCVaVfQNqlcevxlmZQql1CALvGxoHufnFD9zFd8rx8QpcYZQwLbN8
	 8UUUWr62KaBXXdeBAMtjP5KX9FB7zIB8Ee7MW2T5yciFilJgTQz/DtLOF3rN/pzY1zwSK
	 TwT/OSs/j0LZ7qeHJN7tM9t5Qs/2uDboJ8/x2zU2NzTN5CDGrDbVJFMb9/zdkScaDIHbR
	 gDmDXB7dU2foq9HXgMt32FvgkbaJKDAv07zo9JIKcxqeiz0ngxIQQSxoVyoJyIY/i8Hyf
	 8G7H/iDXRQB0H9fjqj/22EqFW5Bp3WHSH6z4sM3wunSLmIjqcpEXu7Z9atOZsPBrMjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795393639;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=wlYfh2xtbimyN8kyMMVybX5oVF0p1B6sZ5VOviODosU=;
	b=27MYVAIUvTxKovqwxsnIFSaNWl4FlmmgJwVTlhINLZrbSAE+PdypFxzpd0K+MKDLuf2w
	 Vbx1xSDDw/Jeu4kcx50GysRQF+55Xh+lIVAyaiosRmMC5BJ8PjtnV43e8Q2qBWmzxyfkA
	 jCdcjeyyIby777ERKatPa/D+7SOsItfvr3I9PayA+N+6VhlUJXw6bcctaC8oSM9r44Rzx
	 4He5AqtuTJICb1uP2CSpq+fo5vpl0X0MeRcXlKyVh7PGGqQIjP2OshJpL/iSjSLj4RNTg
	 0lcDfUyfCaBw/26iqAwyRAgaYfk8jGO0HiHTCemRQjR3Xr8ww2viYGBvVnaDR6Am6bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ghJ2KJrb;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E302606A31A
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 00:27:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E302606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ghJ2KJrb
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2f04bea9a93so22153285ad.3
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 16:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795393638; x=1795998438; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wlYfh2xtbimyN8kyMMVybX5oVF0p1B6sZ5VOviODosU=;
        b=ghJ2KJrbjjhy2Q4dw/P6p9XqSBnPBE3BS07E6n0mhO3zDi/92pFcaHcdjqrO7ooHAl
         eVGOU9ujw6IN6pM+B6tUP3NKJRp9QwB6xr8WIT6H36tUMznKxrO7enPSnbFzZWLxWQzK
         cNuKBG0j2mzgt6jN/Kn+7U1BCOlgtCyEngXeBoIgYYo636yvtqn8w0FWlXncJLXmpuPU
         HYzXSEv7RgyqAU9nhq/WZylendhEEk4luAog0bj8ODlR2J+4Y8JkMCpj1hlc5oCUyvSF
         ERhaetRpH2gi8JNf9LMvdmMyhrg6TQIsakLLbFPEz4fn0xX7LzNLShc+pVAryROVdqTk
         y+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795393638; x=1795998438;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wlYfh2xtbimyN8kyMMVybX5oVF0p1B6sZ5VOviODosU=;
        b=EE0GNlor/cL6PRlDVtu0R1A+YjbZb3dIdxXzuyKi8w1TEzbaq7RTRt9+G95tAZiuTO
         M3np4NusorLEnJOLomvy1rgI+SaFldRB1FKkj3xfl6ptva5pxdwGD7F7jJHPxBSwMmhP
         I6zLOiJVvt1MmMuMVjxPSwPVu1TB45jwQe9z9HPsrvHAvAsU601Pl3/1gSdlkPpSbkNp
         05/7PtfCz5M1/tkqDcUwU55MYN76q1fgPfxMH2EqigW7WtbTJNA7O2RBpmEtAXm+9RqE
         gvd5SL+V4eoEWVXvGuCbDZj117ez3+kd8ZYr1M0jQmXaSQkz9KBP/YpTxbU8E33ktHGD
         Ob1A==
X-Forwarded-Encrypted: i=1; AL+hErFnxyObcu7LVLA5jcjo61KmjQMMUaTRys6ouSogHiV++hnz7VG/fldaNXNj8wIT7OLjz4w=@vger.kernel.org
X-Gm-Message-State: APuU4Z85l228vf9ms4sAwFMo1wqeWTYMy+w11lHNgcnv+ScXpK2lNXnL
	R1Oap+WZW9XXLrDJprvHwGE/AjsDQzIbSqiitrSqNsgo+1+1Ga9hAx81
X-Gm-Gg: AZFdTZfxql2XM86/mQ5UEVO6j2QA9RrAxVo6jYDScA8i+Y+MhDLEBfKqKkI/3Spm1+f
	MQtAnn/HVeOCqQoUEygwtJ0I/9URMQZy+N/BHXRYyh4sa6x4r/myVu86l7clNXvA1VYGFjJ4Wfx
	xnwtvmY6Zt478IC8t9EnVyOR2qzn7YDU4kLDwfGvdql9vcqHW9LsqE0PcgZ9zMf3Bqc3yBRSCgq
	ASoVV6l7TxvxoXrWMHieERFSYsA/bN7LWrs53UaQm87c0g82oNUDCXDtsz7XPyNZPdYnRn1iT1q
	e6T44QhI7BA0jHk4cd6WP68Hyv/69f0WYK+kjnkq61eramBCTe+iTzZKu007Tk5RLDIO5oRVOmu
	o3Y2ufffCyaVOHhREEsgWK88qF+N8t3D+Xm7ijKJAsFU8PmoJJp58UwpS3znvNiinsIO6GfFOht
	VxZtOp9WXf5vDdnHyPVUlqsFyGr/8XHlxIuHMRCpmvIt1y7H/g8jkJnn5i3QBYj2MDcJFKco718
	m/f/C01poTVWz8tmBMpDzZYiXLAb3mcudcsT4RUgvbIq5/b1+DFSkntCDqpissYsCL5oD/cZPXe
	jVRK8fzzLxSOICNGb++8A7uiNLBLOPC7xllToFg8IAeH1BpOSOL5Zc4N1a0ordPhavCthqVjIg4
	J7m8QZEmugDiGCBGKvPOuADrZcEIjjixfGw==
X-Received: by 2002:a17:903:2a86:b0:2f0:4168:fb28 with SMTP id d9443c01a7336-2f04168fde0mr105274495ad.27.1795393638345;
        Sun, 22 Nov 2026 16:27:18 -0800 (PST)
Received: from localhost ([153.61.198.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c2091sm42574395ad.20.2026.11.22.16.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 16:27:17 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 00:27:17 +0000
Message-Id: <DN25XEMY8JO1.249FAY7XQUC31@gmail.com>
Cc: <yatsenko@meta.com>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 0/6] bpf: Fix async callback use-after-free
 on map deletion
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yun Lu" <luyun_611@163.com>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <jolsa@kernel.org>, <emil@etsalapatis.com>, <ihor.solodrai@linux.dev>
In-Reply-To: <20261119033051.196177-1-luyun_611@163.com>
References: <20261119033051.196177-1-luyun_611@163.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 18, 2026 at 07:30 PM Yun Lu <luyun_611@163.com> wrote:
> - Reject zero usercnt in the shared setter (Sashiko), order the check
>   after lookup with a full barrier, and add a wq regression for reuse.

bpf_task_work_acquire_ctx() has the same two reads without a barrier.
On arm64 the 2nd load can pass the 1st:

  bpf_map_value_is_linked()       finds the element inserted again
  atomic64_read(&map->usercnt)    returns the old nonzero count

The uref walk missed the element, so nothing cancels this task work.
Task work is allowed in inner maps and ctx->prog doesn't hold them.
The callback can run on a freed map, like the timer in Mani's fix:
https://lore.kernel.org/bpf/20261027-bpf-timer-freed-map-v1-1-30402b0ee99b@columbia.edu/

> - Use the existing map lookup and move the wq/timer check to the shared
>   setter (Alexei).

That lookup was my suggestion, sorry. bpf-ci was right on v2.
It changes the eviction order in LRU maps:

  bpf_timer_set_callback(&val->timer, cb)
    bpf_map_value_is_linked(map, val)
      htab_lru_map_lookup_elem(map, key)
        __htab_lru_map_lookup_elem(map, key, true)
          bpf_lru_node_set_ref()

A timer callback gets val without a lookup.
It can call the setter in each period, like timer_cb2() in timer_mim.c.
Then an idle element looks hot and elements in use get evicted.
See commit 50b045a8c0cc ("bpf, lru: avoid messing with eviction
heuristics upon syscall lookup").

> - Give slot detachment to the first invalidator and reuse the existing
>   task-work, wq and timer selftests.

Now the 2nd canceller returns with a dead cb in the slot:

  CPU 0: update from syscall   CPU 1: prog, same array element
  xchg(&cb->map, NULL) wins
  preempted
                               bpf_map_update_elem()
                                 xchg(&cb->map, NULL) loses, return
                               bpf_timer_init()          -EBUSY
                               bpf_timer_set_callback()  -ENOENT
  WRITE_ONCE(async->cb, NULL)

Today xchg(&async->cb, NULL) empties the slot first and init returns 0.
Task work gets -EBUSY in the same window.
You replied that cmpxchg() races with the pending WRITE_ONCE():
https://lore.kernel.org/bpf/84286263-5111-4358-8b90-9e9d86d846cb@163.com/
It doesn't when both cancellers use cmpxchg(), like in v2.
guard(rcu) keeps cb alive, so its address can't come back.

All three on top of the series, helpers.c compiles but I didn't run it:

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 029f60b..6696539 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1155,8 +1155,12 @@ static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
 static bool bpf_map_value_is_linked(struct bpf_map *map, void *value)
 {
 	u32 idx;
+	void *key = map_key_from_value(map, value, &idx);
 
-	return map->ops->map_lookup_elem(map, map_key_from_value(map, value, &idx)) == value;
+	/* It's not a use of the element. Don't set the ref bit of LRU node. */
+	if (map->ops->map_lookup_elem_sys_only)
+		return map->ops->map_lookup_elem_sys_only(map, key) == value;
+	return map->ops->map_lookup_elem(map, key) == value;
 }
 
 enum bpf_async_type {
@@ -1774,13 +1778,15 @@ static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
 	guard(rcu)();
 	/* Order unlink before reading async->cb, including an empty slot. */
 	smp_mb();
-	/* Acquire any invalidation published before the slot was cleared. */
-	cb = smp_load_acquire(&async->cb);
-	/* Only the first invalidator detaches cb and drops the map's reference. */
-	if (!cb || !xchg(&cb->map, NULL))
+	cb = READ_ONCE(async->cb);
+	if (!cb)
 		return;
 
-	WRITE_ONCE(async->cb, NULL);
+	/* Callbacks that run after this see NULL and return. */
+	WRITE_ONCE(cb->map, NULL);
+	/* The one who detaches cb drops the map's reference. */
+	if (cmpxchg(&async->cb, cb, NULL) != cb)
+		return;
 
 	bpf_async_update_prog_callback(cb, NULL, NULL);
 	/*
@@ -4918,6 +4924,9 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
 		return ERR_PTR(-ENOENT);
 	}
 
+	/* Order the lookup before the read of usercnt. See __bpf_async_set_callback(). */
+	smp_mb();
+
 	/*
 	 * If no process or bpffs is holding a reference to the map, no new callbacks should be
 	 * scheduled. This does not address any race or correctness issue, but rather is a policy
@@ -5245,10 +5254,10 @@ void bpf_task_work_cancel_and_free(void *val)
 
 	/* Prevent entry to RUNNING before clearing the slot. */
 	state = xchg(&ctx->state, BPF_TW_FREED);
-	/* Only the first FREED transition detaches ctx and owns the map's ref. */
+	(void)cmpxchg(&twk->ctx, ctx, NULL);
+	/* Only the first FREED transition owns the map's ref. */
 	if (state == BPF_TW_FREED)
 		return;
-	WRITE_ONCE(twk->ctx, NULL);
 
 	if (state == BPF_TW_SCHEDULED) {
 		/* run in irq_work to avoid locks in NMI */

pw-bot: cr
