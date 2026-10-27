Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793120624;
	b=5k1eOwNoHOq4yM5gM3zODscIT9jDTIMFE86UlMIumatBCGQXmaJ2+MTG9pVdALy9JlHF
	 bESZ9cwPs/Kk7+5NKJzAjsmBAmsGbzahafvSHwiDZCmeLfUMGHUDq89vBoEfYWn6pZsuJ
	 Tt1f+sSNTtIVubLe9YTAhuqqVOUOCD/AOJAxagj5XudNVrpnXp9A0B/B47Q63qNWVy54F
	 qqzCMvA5AFvzOpVCuAYYpBx87iyE1aXWgrpmoXT7mfH36WgGbQB0TZO9lQHxs5ZpRQ1R9
	 p4+6UYHRR54fRyjUuzgmhgsU4+p0tH31w2dL9PsgCTBA3MsyRPP1ZGasjR9Ir3kvkJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120624;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=I+4TWt3vbQopB9oFiB1okcMtFhQmtW51JO2Lmql0cF4=;
	b=vOSckgT8PuJyYXSNuP2BokPYJ/GdC3A4Do8i8DEQ8J6QFqz+z1C9VITN8LQnScBMivbl
	 6JwQiDCXjU8dLBJqvR4LGqxwkb4Hwt9ABGRDYCKjMYFTQItEgFya0AZxzq1GW+iBDlXYX
	 8avEvMREpR8XBU+2L2OQTkRBnGsKJa8X6KzgvYaRhkJ+V7q9IWUUxd+M0VBhXn+uKlg1g
	 eao3vDSnK5II0W0nMCnoIgerHAKj9gJDWljyfh1JtW6rrQfsLaH6k/ENTCq1J820WQfMg
	 sN7k3qEv4yxvc++5Bkg3/UhfUrO+tAT9JkR1h/hZt4wDeKWdogUoBDc53PrtG5y5GPw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xqm9kSrl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D2606A31A;
	Tue, 27 Oct 2026 17:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xqm9kSrl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793120623;
	b=ZfMJOgjmisG83/JzUGQxNWKx522YJFcIpYgbuL5NB+K4E8cclU3DFwOvP+oguILt0wTA
	 j0y0s1P74aEyD+GhRnpap6XF93vozymmbzTLZku+vOHr+bC3FFD1k6GO3NZrHrBRAynrN
	 4/XJXmJWT6285/ITUWTb+T6kvGiGOx4KAaCTTi/TFBG+mwR2ThgkcPXkr8ziGEDEmS0QH
	 tFdwO/LpyrmvFry2yEGmI2t1NP3tGNyjpL9jlG6Oq8mYFxzGzqXWDG9SGWAh6OdXU1iKX
	 KOCo63/+T7TnGXGXMpcWXhPabAIu+SZjJdMHEfXEbDWF3J+9aSNPiQok0ayAvTycJig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793120623;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=I+4TWt3vbQopB9oFiB1okcMtFhQmtW51JO2Lmql0cF4=;
	b=PD7UHMWoJkFrwY3gq/coKY9nv0Uki8nHQv7EZoNhAUJlspL9soEyHp6+2+w+6VhscU+j
	 FxWiuQc5RWp7Fy8SapgFoG9G5HN8h+mKa6T0kq394CMazkuZpdy34MO6xCoZ/LV4/Egrk
	 cYP2ly8SU0ppWW0HIPpT0JB+BpzPkQYEJ1myJ/9xQ6C54LXGlL1zDWZByGnh4ZSDfoTl1
	 x8Sm9ov+BdwBD+F7IEBDGbv4/I8UAPe0SZ8E1IVYVXaUnwu5OZgg2KQz1n/PHTGNlSyhO
	 of8T5UXDEkroSQfqzoGj+6xAkmquSN3cHDKX7zlIIykt1qWLyISA1qWgbqx5D1CRsVA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5DC211F01825;
	Tue, 27 Oct 2026 17:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793120623;
	bh=I+4TWt3vbQopB9oFiB1okcMtFhQmtW51JO2Lmql0cF4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Xqm9kSrl89ONSXiHWlY1WY8sgbVip6Z8bqw1UsXyQZIAbuckNKtllodT6/JzMP6iA
	 e06lAu0FidpkxlY7O541OhdIfoH/OsXgpjxaypnggIqDKdXLRgZYT+Vow7JhyOnsNc
	 yeLAd1uKq9CZaSetlS6IwBR7nOfDJZCc1fREuqwOmUB6N8JNOHd5yI56ZnFPPKi5Rq
	 2deMa3FwfFFX64Azkkp4JZMrP13nSyhrAPLN/MvA6kfHb13LFWT8bFwEX3/T5XQK04
	 TkigmmzOJ3NYGS7ethIf6am5OxOA5ksBzPiR/V9jb1BQoGjS0oaJibniVzSsPimdq2
	 rDREE+Q60hZJg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AF34F4519A;
	Tue, 27 Oct 2026 17:03:42 +0000 (UTC)
From: Mani Tofigh via B4 Relay <devnull+mt4022.columbia.edu@kernel.org>
Date: Tue, 27 Oct 2026 13:03:42 -0400
Subject: [PATCH bpf] bpf: Fix bpf_timer callback running on a freed map
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-bpf-timer-freed-map-v1-1-30402b0ee99b@columbia.edu>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQrCMBBFr1Jm7YAJWIpXEReZ5kdHaA2TWoTSu
 zvq4i/eh/c2ajBFo3O3kWHVps/ZIRw6Gu9pvoE1O1M8xj74WGrhRScYFwMyT6lykiFLjv0gp0B
 uVkPR9696IRfo+j/bSx4Yl2+P9v0DHgf9vXwAAAA=
X-Change-ID: 20261026-bpf-timer-freed-map-ab8dbd268b51
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Mykyta Yatsenko <yatsenko@meta.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, tz2294@columbia.edu, 
 Mani Tofigh <mt4022@columbia.edu>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793120622; l=5226;
 i=mt4022@columbia.edu; s=20261026; h=from:subject:message-id;
 bh=wo8d1ZBRaCNTXAwLX98FIAW/3WUJoTeClaIWCGiqQ2c=;
 b=ztFexz4W1rs2a4NFbB057zVVJ9HMYN7CC2z2XAn6jD2hwbTbqCc+xrIdKK/suBfzQodRdZX2l
 hA0HzicDOzeBoUMjNbBZ5HGd00qfCwj75PYWldefBNJk4gP3wpMc18J
X-Developer-Key: i=mt4022@columbia.edu; a=ed25519;
 pk=gljCMQDuxyKPmd5y37CRpEJGSPXDV1MyAnHBhCgXl0I=
X-Endpoint-Received: by B4 Relay for mt4022@columbia.edu/20261026 with
 auth_id=1322
X-Original-From: Mani Tofigh <mt4022@columbia.edu>
Reply-To: mt4022@columbia.edu
Content-Transfer-Encoding: 7bit

From: Mani Tofigh <mt4022@columbia.edu>

A bpf_timer in an inner map can fire after the map has been freed, and
bpf_timer_cb() then reads the freed map:

  [   50.709520] BUG: KASAN: slab-use-after-free in bpf_timer_cb+0x249/0x290
  [   50.709540] Read of size 4 at addr ff11000003bc1030 by task bpftimer/72
  ...
  [   50.710783] Freed by task 12:
  ...
  [   50.710826]  bpf_map_free+0x1a2/0x380

When user space closes the map, its timers are cancelled and their
callbacks are cleared.  Since commit 1bfbc267ec91 ("bpf: Enable
bpf_timer and bpf_wq in any context"), bpf_timer_set_callback() and
bpf_timer_start() run without a lock, so a program that found the timer
just before the close can still use it afterwards:

  Task A                  Task B                  Task C
  ------                  ------                  ------
  bpf_timer_start()
    finds the timer
                          bpf_timer_set_callback()
                            finds the timer
                                                  close(map_fd)
                                                    clears the callback
                                                    cancels the timer
                            sets the callback
    arms the timer
                                                  deletes the map from
                                                  the outer map
                                                    map is freed
  the timer fires
    bpf_timer_cb() reads the freed map

The timer is cancelled once more when it is finally freed, but that
happens well after the inner map is freed, so a timer started this way
can still fire on the freed map.

Clear the timer's map pointer in bpf_async_cancel_and_free() before the
map can be freed, and make the bpf_timer and bpf_wq callbacks return
early when it is NULL.  The map is not freed until callbacks that are
already running have finished, so a callback either sees the map while
it is still valid or sees NULL.

The reproducer below calls the two helpers in a loop on two CPUs while a
third CPU keeps creating an inner map with a timer, closing it and
removing it from the outer map.  This bug was identified and confirmed
with the help of a deterministic hypervisor currently under development,
but the non-deterministic C reproducer can typically trigger it in the
1-50s time range.  With the fix, nothing is triggered after 600 seconds.

Fixes: 1bfbc267ec91 ("bpf: Enable bpf_timer and bpf_wq in any context")
Signed-off-by: Mani Tofigh <mt4022@columbia.edu>
---
This is a different use-after-free from the one fixed by "bpf:
Dissociate struct_ops progs before the grace period of the map" in
Qiliang Yuan's v6 struct_ops series [1].  There, a timer callback
returns into the freed trampoline of a struct_ops map.  Here, the
callback reads the freed map that holds the timer.

[1] https://lore.kernel.org/all/20261022-selftests-bpf-struct-ops-assoc-timer-v6-2-2c0f18e82582@gmail.com/

Reproducer: https://github.com/manitofigh/files/blob/main/linux-repros/bpftimer.c
---
 kernel/bpf/helpers.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 648abe1ba63a..58e357302850 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1221,7 +1221,7 @@ static void bpf_async_refcount_put(struct bpf_async_cb *cb);
 static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 {
 	struct bpf_hrtimer *t = container_of(hrtimer, struct bpf_hrtimer, timer);
-	struct bpf_map *map = t->cb.map;
+	struct bpf_map *map = READ_ONCE(t->cb.map);
 	void *value = t->cb.value;
 	bpf_callback_t callback_fn;
 	void *key;
@@ -1229,7 +1229,7 @@ static enum hrtimer_restart bpf_timer_cb(struct hrtimer *hrtimer)
 
 	BTF_TYPE_EMIT(struct bpf_timer);
 	callback_fn = rcu_dereference_check(t->cb.callback_fn, rcu_read_lock_bh_held());
-	if (!callback_fn)
+	if (!callback_fn || !map)
 		goto out;
 
 	/* bpf_timer_cb() runs in hrtimer_run_softirq. It doesn't migrate and
@@ -1254,7 +1254,7 @@ static void bpf_wq_work(struct work_struct *work)
 {
 	struct bpf_work *w = container_of(work, struct bpf_work, work);
 	struct bpf_async_cb *cb = &w->cb;
-	struct bpf_map *map = cb->map;
+	struct bpf_map *map;
 	bpf_callback_t callback_fn;
 	void *value = cb->value;
 	void *key;
@@ -1265,8 +1265,9 @@ static void bpf_wq_work(struct work_struct *work)
 	/* keeps the program that callback_fn belongs to */
 	rcu_read_lock_trace();
 
+	map = READ_ONCE(cb->map);
 	callback_fn = READ_ONCE(cb->callback_fn);
-	if (!callback_fn)
+	if (!callback_fn || !map)
 		goto out;
 
 	key = map_key_from_value(map, value, &idx);
@@ -1733,6 +1734,8 @@ static void bpf_async_cancel_and_free(struct bpf_async_kern *async)
 	if (!cb)
 		return;
 
+	/* Callbacks that run after this see NULL and return. */
+	WRITE_ONCE(cb->map, NULL);
 	bpf_async_update_prog_callback(cb, NULL, NULL);
 	/*
 	 * No refcount_inc_not_zero(&cb->refcnt) here. Dropping the last

---
base-commit: 195a3519ff27bff5575e05b5086e38ee92715776
change-id: 20261026-bpf-timer-freed-map-ab8dbd268b51

Best regards,
--  
Mani Tofigh <mt4022@columbia.edu>


