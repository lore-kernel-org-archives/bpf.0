Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959130;
	b=JKY5o5oZSl5hYZwWkNwZkCkzLZF9CYdzkLVLYUUY0/N4Wv8RBWulT5b3U/EY1o2qFn2E
	 nU9nXBwUCL/DEewz6tCAlWucqItu8uglw26o8voqBmkIjoj0By7zNHNOHHIGx2E+1w5KG
	 CzBfDm2P4iEjIN85xhEqHC8GMVxK65mcJR1hTIi/XF32TzZ+VtZjfxTl4Q9GYJE83bq/7
	 sj9DtkkUAgr/GKIeq9952SN44LqZoelHiB9JIEMuWgpSryRqpvBT+unxdRP+1cN3D8bM+
	 WHOjBDi+7BooFwsmqPJVnmUuuGPylUWxsyJxL5gu588rTpxkzJhl9LJx2KPwqmK3Slw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959130;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=9D2PJfHd7HUB+58+37DodNM0hDmWw0RWUYouCkjIccc=;
	b=bz+IP+4TAwxkluRiFIek6jn9GsKgysd5/A0pWLXGGEyDb8qDi68NuOkOdEmi4aKqm1v1
	 YIbcyIn3MUxcoMScHj7g0oNyeb6QaHdKl116K2sJkRsFGpSaH2N6s1T2iSldEAFFxUkOd
	 RamOK/V0+UpnH5nDnc0wxt2koN4wANVCQ1M0Pm9yDwG0gTKli8a8k3rYpjcWflBgF4YHK
	 WhDF213KI/+F8JZqyGv9lOEyeaBu+0t/m/Ca/8eqFjc6Sq+bH7193zW2Zubvb5axr9TPs
	 cradvhrcCtwutHzgPJi8m1XP1i6mw0LeNxGq59Qi5PGS4AwY31l0EtaJzwl16COPhXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TzT3FoFl;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEA6606A32C
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 09:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAEA6606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=TzT3FoFl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=9D
	2PJfHd7HUB+58+37DodNM0hDmWw0RWUYouCkjIccc=; b=TzT3FoFlahLM9SIIh3
	ojxgF3zJPtOeU+fQ3/6yigCbl8GqHDoB2C+/nU4/5Nb8Z/7qvijgLHixhqtXxGyf
	ZayeMBjoTvka8hwevnuPnya99SOEZRZkHE8sPlcagM19WonoSFmZ16oecSEo1JT1
	ewZkuVpUILotqHHDCXfHYrrxk=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3JjikpO1qsU61Fg--.28308S4;
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
Subject: [PATCH bpf-next v2 2/8] bpf: Check task work value membership before scheduling
Date: Fri,  6 Nov 2026 17:57:41 +0800
Message-ID: <20261106095747.471718-3-luyun_611@163.com>
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
X-CM-TRANSID:_____wA3JjikpO1qsU61Fg--.28308S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Ww17GF1DXrykJr47tw1rtFb_yoW7Zr15pF
	Z8KryYkr4DXa9rtw4avw4xCryrCrsYqay5GFn5Kr90vrs0qrn2vFy8KFyjqry5Cr1vyF12
	vr4qga93ua1kAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzoGQUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6whpOGrtpKjAIAAA3Z

From: Yun Lu <luyun@kylinos.cn>

Cancellation clears the task-work slot, but a BPF program can still hold
the deleted element's value pointer in its read-side section. Scheduling
through that pointer can publish a new context. Its reference keeps the
context alive, not the element referenced by ctx->map_val:

  1. A BPF program looks up E and retains its value pointer.
  2. Another task deletes E, cancels its task work and clears the slot.
  3. The original reader publishes a new context C, schedules task work
     and leaves its trace read-side section.
  4. C enters RUNNING outside the grace period's waiting set for E,
     before the final destructor marks C FREED.
  5. The destructor frees E without waiting for C. The callback then
     accesses E through C->map_val.

A controlled reproducer on the unmodified kernel at commit 7c3188f84b54
("selftests/bpf: Time tc_edt from its first packet with data") reported:

  BUG: KASAN: slab-use-after-free in array_map_update_elem+0x4b8/0x7f0
  Read of size 8 at addr ffff88800e61be98 by task uaf_repro/91
  Call Trace:
   __asan_memcpy+0x23/0x60
   array_map_update_elem+0x4b8/0x7f0
   bpf_prog_976f3fa6d36fbef6_cb_probe_step+0xaf/0xe5
   bpf_prog_ac7215eae4609044_process_work_cb+0x12c/0x234
   bpf_task_work_callback+0x351/0x970
   task_work_run+0x116/0x200

  Allocated by task 90:
   alloc_bulk+0x238/0x360
   bpf_mem_alloc_init+0x2fd/0x930
   rhtab_map_alloc+0x352/0x430

  Freed by task 9:
   kfree+0x1b8/0x550
   free_all.isra.0+0x5b/0x110
   __free_rcu+0x87/0x1b0
   srcu_invoke_callbacks+0x360/0x5c0

After publishing C and claiming PENDING, look up the key and require the
returned pointer to match the retained value. This is before irq_work is
queued: either lookup rejects the removed value or deletion finds the
published context and marks it FREED. Take regular RCU around the lookup
because sleepable callers hold only a trace read-side section.

On rejection, conditionally roll PENDING back to STANDBY so a concurrent
FREED is preserved, and drop this attempt's callback reference. The idle
context remains available for normal cancellation and reclamation.

Check membership before the usercnt policy, so a removed value returns
-ENOENT when this check is reached even if usercnt is zero. Compare value
addresses as well as keys: replacement must reject the old value, while
reinsertion at the same address is the current member. Live in-place
updates retain their existing behavior.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 kernel/bpf/helpers.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 281fedabf7b0..a2c199aed893 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1148,6 +1148,18 @@ static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
 	return (void *)value - round_up(map->key_size, 8);
 }
 
+/* Does lookup still return this value under its key? */
+static bool bpf_map_value_is_linked(struct bpf_map *map, void *value)
+{
+	u32 idx;
+	void *key;
+
+	/* Sleepable callers need regular RCU for the map lookup itself. */
+	guard(rcu)();
+	key = map_key_from_value(map, value, &idx);
+	return map->ops->map_lookup_elem(map, key) == value;
+}
+
 enum bpf_async_type {
 	BPF_ASYNC_TYPE_TIMER = 0,
 	BPF_ASYNC_TYPE_WQ,
@@ -4774,6 +4786,16 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
 		return ERR_PTR(-EBUSY);
 	}
 
+	/*
+	 * ctx is published and PENDING, with no irq_work queued. Either
+	 * lookup rejects the value or deletion finds ctx.
+	 */
+	if (!bpf_map_value_is_linked(map, (void *)tw - map->record->task_work_off)) {
+		(void)cmpxchg(&ctx->state, BPF_TW_PENDING, BPF_TW_STANDBY);
+		bpf_task_work_ctx_put(ctx);
+		return ERR_PTR(-ENOENT);
+	}
+
 	/*
 	 * If no process or bpffs is holding a reference to the map, no new callbacks should be
 	 * scheduled. This does not address any race or correctness issue, but rather is a policy
@@ -4842,7 +4864,12 @@ release_prog:
  * @callback: pointer to BPF subprogram to call
  * @aux: pointer to bpf_prog_aux of the caller BPF program, implicitly set by the verifier
  *
- * Return: 0 if task work has been scheduled successfully, negative error code otherwise
+ * A value reinserted at the same address is the current member. Success
+ * queues irq_work but does not guarantee callback delivery.
+ *
+ * Return: 0 if the scheduling irq_work was queued; -ENOENT if the membership
+ * lookup does not return this value; -EBUSY for a busy context or no user
+ * references; another negative error code on failure.
  */
 __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
 					      void *map__const_map, bpf_task_work_callback_t callback,
@@ -4860,7 +4887,7 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct b
  * @callback: pointer to BPF subprogram to call
  * @aux: pointer to bpf_prog_aux of the caller BPF program, implicitly set by the verifier
  *
- * Return: 0 if task work has been scheduled successfully, negative error code otherwise
+ * Return: As for bpf_task_work_schedule_signal().
  */
 __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct bpf_task_work *tw,
 					      void *map__const_map, bpf_task_work_callback_t callback,
-- 
2.43.0

