Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795584765;
	b=saKMCIxBt/Yk5uoDHxmds6aJCsFZekMBoV8fqWIQ3zopjRIpylXB5Bz19f/LoXxURKSM
	 WBsIs9ouFhreLhHgfYx9ayACM3QYcRArNnu70uqam+T2BWSeJmFlaeo/I+Ce1bmpYZ8eM
	 pzKpEvnKcQS+iZ+FVxtu1r8T4PR93l4Slal5fIdpX9eMrf/oRSAbf+UlC5QH9Wx0UCqOk
	 h5OouYRnZT67WXkaaTfQeD0k6ULBoBuvhVeYFNSP2VCyhh1tHNTMfwJNLRcLng7KKfxn7
	 xUudF1SmdSjhqrmkoMs7WRAey/3OQsYF4VJI3C7oGwWJVL9eN8bwwsP24cDMIF4oe/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795584765;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=km0PCvJI2JjhRG+erbN8INOd4M4JkqNG50Gtw+C3zuE=;
	b=0W+gxReKw13NpXABKGoM19+vYNFYm79i2+d9j0J+Vl7otYVhBQRwfob31gmhAMvHeUOa
	 HjCAFL2tz2bSqP74Av6LTrpdmNFbU2XPnBLhpBcXRR1n/lLT4oRRVxUGJHrPjAMuRe/Xc
	 VHiAXO4cOdOiooLdc1gd9CjNyeHnxPa9A7zwu/phv+fCR7VPHFWKDconJEsO5muGn+mu2
	 u/Dyk3Dk1gAriKbEas4V6kvWQ9Wbkod6BjsDzJ5WJSIYB/SUCyOCFh1us4Jfce0PwFIG/
	 3igFlq2cbh2HbXCJH5ryQf1NitCeh+TI/fuvlyOwLMt4HX7Iqu50RoklFz3ZiiWf5Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Zv5TTaUl;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4497A606A327
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 05:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4497A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=Zv5TTaUl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=km
	0PCvJI2JjhRG+erbN8INOd4M4JkqNG50Gtw+C3zuE=; b=Zv5TTaUl1iIMsOC2hD
	l/nSmjRiliMNg4q2UStoqQUNhzlwy4lrArc5CPnkhTC95iRjwlJxCTLkaiDpVqLD
	IMORsOXbSTsHoYhIbQg7yqAJzUf013Rltks3fix6oiq6zV6OCBKiu//QgrLDNXlf
	WJdm4qwSrF7Q2afUHBSCmUb+A=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnL6jCcgZrriN8JQ--.11907S4;
	Wed, 25 Nov 2026 13:31:51 +0800 (CST)
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
Subject: [PATCH bpf-next v5 2/6] bpf: Check task work value membership before scheduling
Date: Wed, 25 Nov 2026 13:31:28 +0800
Message-ID: <20261125053132.444234-3-luyun_611@163.com>
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
X-CM-TRANSID:_____wDnL6jCcgZrriN8JQ--.11907S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3XryDuF43tF18Kw43tFy8AFb_yoWxJF48pF
	ZxWr1ayr4DWa9Fqw4avw4xCr15Gwsaqay3GF95KryYkrZ0grn2vry8tF1Utry5Cr1rZF42
	vr4qqa93ua1kJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jrl19UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7Acq+GsGcsekGgAA3f

From: Yun Lu <luyun@kylinos.cn>

Cancellation clears the task-work slot, but a BPF program can retain the
deleted element's value pointer and publish a new context through it.
The context reference keeps C alive, not the element at C->map_val:

  1. A BPF program looks up E and retains its value pointer.
  2. Another task deletes E, cancels its task work and clears the slot.
  3. The original reader publishes C, queues task work and leaves its
     trace read-side section.
  4. C enters RUNNING outside the grace period's waiting set for E,
     before the final destructor marks C FREED.
  5. The destructor frees E while the callback can still access it.

A controlled reproducer on the unmodified kernel reported:

  BUG: KASAN: slab-use-after-free in array_map_update_elem+0x4b8/0x7f0
  Read of size 8 at addr ffff88800e61be98 by task uaf_repro/91
  Call Trace:
   __asan_memcpy+0x23/0x60
   array_map_update_elem+0x4b8/0x7f0
   bpf_prog_976f3fa6d36fbef6_cb_probe_step+0xaf/0xe5
   bpf_prog_ac7215eae4609044_process_work_cb+0x12c/0x234
   bpf_task_work_callback+0x351/0x970
   task_work_run+0x116/0x200

  Freed by task 9:
   kfree+0x1b8/0x550
   free_all.isra.0+0x5b/0x110
   __free_rcu+0x87/0x1b0
   srcu_invoke_callbacks+0x360/0x5c0

After obtaining C and claiming PENDING, require a lookup by key to return
the same value before queueing irq_work. If deletion races with a
successful lookup, the published context is visible to cancellation.

Order the membership lookup before the usercnt read with a full barrier,
matching the shared setter. Otherwise a successful lookup of an element
reinserted after the uref walk can be followed by a stale nonzero usercnt.

Membership is pointer equality: a value reinserted at the same address
is treated as the current value. Prefer the optional
map_lookup_elem_sys_only op for this internal check so that probing an
LRU hash does not mark the element referenced and affect eviction.

Return -ENOENT on mismatch. Conditionally roll PENDING back to STANDBY to
preserve a concurrent FREED, and drop this attempt's callback reference.
Leave the idle context for normal cancellation and reclamation.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 kernel/bpf/helpers.c | 39 +++++++++++++++++++++++++++++++++++----
 1 file changed, 35 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8cae3dc..74e0961 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1151,6 +1151,18 @@ static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
 	return (void *)value - round_up(map->key_size, 8);
 }
 
+/* Is the element that holds this value still in the map? */
+static bool bpf_map_value_is_linked(struct bpf_map *map, void *value)
+{
+	u32 idx;
+	void *key = map_key_from_value(map, value, &idx);
+
+	/* It's not a use of the element. Don't set the ref bit of LRU node. */
+	if (map->ops->map_lookup_elem_sys_only)
+		return map->ops->map_lookup_elem_sys_only(map, key) == value;
+	return map->ops->map_lookup_elem(map, key) == value;
+}
+
 enum bpf_async_type {
 	BPF_ASYNC_TYPE_TIMER = 0,
 	BPF_ASYNC_TYPE_WQ,
@@ -4859,10 +4871,27 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
 		return ERR_PTR(-EBUSY);
 	}
 
+	/*
+	 * The prog can still hold a value of an element that was deleted from the map.
+	 * bpf_task_work_cancel_and_free() is done with it and nothing stops a new callback
+	 * when the element is freed. The ctx is published and PENDING at this point: either
+	 * the lookup doesn't find the element or bpf_task_work_cancel_and_free() finds the ctx.
+	 * An idle ctx stays in the element until the element is reused or freed.
+	 */
+	if (!bpf_map_value_is_linked(map, (void *)tw - map->record->task_work_off)) {
+		(void)cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_STANDBY);
+		bpf_task_work_ctx_put(ctx);
+		return ERR_PTR(-ENOENT);
+	}
+
+	/* Order the lookup before the read of usercnt. See __bpf_async_set_callback(). */
+	smp_mb();
+
 	/*
 	 * If no process or bpffs is holding a reference to the map, no new callbacks should be
-	 * scheduled. This does not address any race or correctness issue, but rather is a policy
-	 * choice: dropping user references should stop everything.
+	 * scheduled. The full barrier above ensures that when the membership lookup observes
+	 * an element linked after the last user reference was dropped, the usercnt read below
+	 * cannot return the old nonzero count. The uref walk may have missed this element.
 	 */
 	if (!atomic64_read(&map->usercnt)) {
 		/* drop ref we just got for task_work callback itself */
@@ -4927,7 +4956,9 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
  * @callback: pointer to BPF subprogram to call
  * @aux: pointer to bpf_prog_aux of the caller BPF program, implicitly set by the verifier
  *
- * Return: 0 if task work has been scheduled successfully, negative error code otherwise
+ * Return: 0 if the scheduling irq_work was queued, -ENOENT if the value is
+ * no longer the current map value at the membership check, -EBUSY for a busy
+ * context or zero usercnt, or another negative error code on failure.
  */
 __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
 					      void *map__const_map, bpf_task_work_callback_t callback,
@@ -4945,7 +4976,7 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct b
  * @callback: pointer to BPF subprogram to call
  * @aux: pointer to bpf_prog_aux of the caller BPF program, implicitly set by the verifier
  *
- * Return: 0 if task work has been scheduled successfully, negative error code otherwise
+ * Return: See bpf_task_work_schedule_signal().
  */
 __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct bpf_task_work *tw,
 					      void *map__const_map, bpf_task_work_callback_t callback,
-- 
2.43.0

