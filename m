Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365088;
	b=HM0q/AvctdzJpivfRFqkU2yH9MSuLmASvVjrW0n3FATF42AHyoed0gGJgiFN+r7ZZyNi
	 DOUFbY6Nbia3T+zm6O+ioKSgZ1U/Ja+38lsnbr6DmfAr8NZaz2W3zBaii4OIFS/vDHkjg
	 BGwn+nkI4HqJZoQoujlY4eM2zKn8ygQ2+UioXmP5EOjbsMBo50ptgNPTgg8BM1mWboKDS
	 KGyQOgrAgArXjocd/R7bBtIpL4zfNqEMgRWiG+uQWhOlhKN8Z/yf1mMJJmbtS4bMc+7dC
	 dX8d81cZMkcPjpYiikk/5F3a9VYyr/1h0VpRkl2WL3jjKgsbHJ+dekBEkijODb+TTQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365088;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=DaiV8lPTfrX2ATocIQKkOEQNMf858jkd9fhtQnUqggA=;
	b=Jm/yzAdRM3/PKanu2caDR0gZnMTd/gSTiU5LCWHEzdB/oxUDcaRgB9uVkoVeUYUaRC50
	 3iqDQmJKaiqWN7yP1NwTmX20PfqVHkrSolvcw16rWYzKSzhrvNfRTY4DbjQPfepQ5cUwE
	 ShpMQ1DE+o/AoU9VzAv3H+JS2up+4zVitnQDqZZiPUzhm9UA25RdND4LeVng33wFjjZNu
	 fSIzCmMnYE5owq3oMnQlpZjj+XEDG8NxWepkbLbm8UHwnqFSXX+xLUrp4olJuzz3Tq07Q
	 tfjy424l9VBx4vGnb+vQ3UGQuG2yfWWDgwGgAMOUZSXhlNvc3/ouSKAPIxz4f/cozFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FlWjqjW2;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B0D606A339
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 02:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36B0D606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FlWjqjW2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Da
	iV8lPTfrX2ATocIQKkOEQNMf858jkd9fhtQnUqggA=; b=FlWjqjW2SiGxftcMdm
	qVmsXulmlHB/AK9eooEwf3CUAQWmuwSHxNo5VLRB1AJLtkdBwp9O3vRr+pxC4Tkx
	x28llekTbc7/w1tFetJX4BYXGb3Xg227/Ygpk1E3i4ZiJY7av1e4kJPHAT7y10HW
	Keg5Ig7rr8fC89aJxvqdxPrT0=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgBXCgpq1vNqdIGjEw--.26036S4;
	Wed, 11 Nov 2026 10:43:56 +0800 (CST)
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
Subject: [PATCH bpf-next v3 2/6] bpf: Check task work value membership before scheduling
Date: Wed, 11 Nov 2026 10:43:29 +0800
Message-ID: <20261111024333.228633-3-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111024333.228633-1-luyun_611@163.com>
References: <20261111024333.228633-1-luyun_611@163.com>
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
X-CM-TRANSID:PSgvCgBXCgpq1vNqdIGjEw--.26036S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3XryDuF43trWDCr1UJFy5urg_yoW7Cr4UpF
	Z0gryxAr4DWa9Fqw1avw4xC34rGwsYqay3Gr95KryayrZ0qrn2vry8ta4Utry5Crn5XF1a
	vr4qga9xua1kJFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jwR6wUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7AxoN2rz1mxjWwAA3k

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

After publishing C and claiming PENDING, look up its key and require the
returned pointer to match the retained value. Before irq_work is queued,
either lookup rejects the removed value or deletion finds C and marks it
FREED.

Return -ENOENT on mismatch. Conditionally roll PENDING back to STANDBY to
preserve a concurrent FREED, and drop this attempt's callback reference.
Leave the idle context for normal cancellation and reclamation.

Fixes: 38aa7003e369 ("bpf: task work scheduling kfuncs")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Yun Lu <luyun@kylinos.cn>

---
 kernel/bpf/helpers.c |  38 ++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4b252ca61166..a08b2af56ee6 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1151,6 +1151,14 @@ static void *map_key_from_value(struct bpf_map *map, void *value, u32 *arr_idx)
 	return (void *)value - round_up(map->key_size, 8);
 }
 
+/* Is the element that holds this value still in the map? */
+static bool bpf_map_value_is_linked(struct bpf_map *map, void *value)
+{
+	u32 idx;
+
+	return map->ops->map_lookup_elem(map, map_key_from_value(map, value, &idx)) == value;
+}
+
 enum bpf_async_type {
 	BPF_ASYNC_TYPE_TIMER = 0,
 	BPF_ASYNC_TYPE_WQ,
@@ -4859,6 +4867,19 @@ static struct bpf_task_work_ctx *bpf_task_work_acquire_ctx(struct bpf_task_work
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
 	/*
 	 * If no process or bpffs is holding a reference to the map, no new callbacks should be
 	 * scheduled. This does not address any race or correctness issue, but rather is a policy
@@ -4927,7 +4948,16 @@ release_prog:
  * @callback: pointer to BPF subprogram to call
  * @aux: pointer to bpf_prog_aux of the caller BPF program, implicitly set by the verifier
  *
- * Return: 0 if task work has been scheduled successfully, negative error code otherwise
+ * When the membership check is reached, scheduling is rejected with -ENOENT
+ * if the current map lookup does not return this value; a value inserted
+ * again at the same address is the current identity. Earlier errors keep
+ * their own codes. A live value with no user reference or a busy context is
+ * rejected with -EBUSY. Return 0 only means the scheduling irq_work was
+ * queued; it does not guarantee that the callback will run.
+ *
+ * Return: 0 if the scheduling irq_work was queued, -ENOENT if the value is
+ * no longer the current map value at the membership check, -EBUSY for a busy
+ * context or zero usercnt, or another negative error code on failure.
  */
 __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
 					      void *map__const_map, bpf_task_work_callback_t callback,
@@ -4945,7 +4975,11 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct b
  * @callback: pointer to BPF subprogram to call
  * @aux: pointer to bpf_prog_aux of the caller BPF program, implicitly set by the verifier
  *
- * Return: 0 if task work has been scheduled successfully, negative error code otherwise
+ * See bpf_task_work_schedule_signal() for return semantics.
+ *
+ * Return: 0 if the scheduling irq_work was queued, -ENOENT for a removed
+ * value, -EBUSY for a busy context or zero usercnt, or another negative
+ * error code on failure.
  */
 __bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct bpf_task_work *tw,
 					      void *map__const_map, bpf_task_work_callback_t callback,
-- 
2.43.0

