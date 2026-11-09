Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794248176;
	b=Q4JIcBJBXq2JCN8DMl4teuHEBFlAFUef2/usxxh72ZccTmM3iMrtmxdaOMN/wkV1zlF6
	 bNn/Rvb1kJJJdPj30GX+Xc55r3ev/AtP8tI5GTI8+txZyKgNlZMkIsuTiz6eKl9/HalBh
	 vspnsaWT3JqwSzhTTDMChTVRyE/zF3tvxaxS9tX5wWNW6U0CU+In99/PPr6VrXJsRslKO
	 DR2wrppEjvg+jVt8Kd+yXBaZGR2s+y9WjJn7S+mkrXZ+w/CxO49lvlRHfjfBZnrhc797g
	 aPMbTa2oLuU19D1cCpeP+NQb3Afar85hoszvrOs++TyEse7w7C7bcVnVFl4dYh7mdxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794248176;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aCyWtXH47WYH7wlRDu3pzw8MJkqG4khw2sQPgAC56fQ=;
	b=rUpoCZ3vosGf3k2hKTWuLcnSXl1PoH03/KzNAL8SreojGtPlWjHocGp7oUdN4aJ/Grod
	 dtakkHiPVQkkl8fiqr65za9QeMNKkLzyfZwZg3107o6eZv1+rKqSR56OqJQ7ggTyJqE7A
	 nDFgRJhmAmJ5QTlhD58+Cw5K86xup2GzeS0sw2u+mTw7So/dLMicK5JPNe6oHt7tYJ6/u
	 jO5i3PzwyS7bxztBbNNyHs7S/sovLp6WKH+w2FmG4ZRu2BUmhp0yv8TU0XKuF6BMiGC5K
	 17rj5EXNYQOYe2v7MRbR/TniAvdReVphwipW+8mLLX0VCoYVugdnfYJSD9InLMbGQOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=YCltrYS+;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BA3606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 18:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69BA3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=YCltrYS+
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a594d313a3so656316b3a.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 10:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1794248175; x=1794852975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aCyWtXH47WYH7wlRDu3pzw8MJkqG4khw2sQPgAC56fQ=;
        b=YCltrYS+mJGzcTkOO1fp94GqTFyPsQSf/JUeD02+c1brXGKVA7pnGcyxjyuAp2KTX9
         ZcQQrqPjaesJFVCARqCenGo7VJfTCbDo/U+nkIP4D/Ogc7zJmOWnDEa8GKAasMGYxyM3
         7EVxzxSnM98mtsa2Nh/zOKia3smUeiDlrhEv+XuCFFnC8hF6f+235tn8B9P86YS/cxAE
         t3wl/tchYEz7GPywVQHgDAvsCjHlg8fJHL8oOEBUITLjDsn7Gtjq6as0Jwg3DAwea/Bw
         w3fP3eAeXkqzFd/bTpOUpvOKRSzDZUp6lm4UWo9/T1sHrggPyyrDryJOm5RxwlRcBIeL
         65Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794248175; x=1794852975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aCyWtXH47WYH7wlRDu3pzw8MJkqG4khw2sQPgAC56fQ=;
        b=NFWkXuMM8Voj5cNgduOW4GlsLokj3U3pmGXa2TiX+vO3f9rmOc2wUKgHxs4ullpD+6
         uXjwmCPeTSNJ9Z1BM/pwL06d5cryL5KRJ6M2jSOvHp8HEYVn+DNIxTtCvMfNcwH3HVhb
         qz1CC5TxcGzdqTvvaKOr11JKiRs9WxmZdefacY/iNjEmFpinQDx871VWQK29UbbNf/Me
         uEZ2p8LzAkG3jCsADBic3AZJlGCUF9CP0/oixUC1iMiQGdLEcseY6TbbKM5kUgL89RLV
         wLrkxW/n5QFF8VrBO7Q14jyh0X0CbeetLNjC4VlI+ZIX8AeKTbTaSjx2OfVbyAxasaK7
         lMuA==
X-Gm-Message-State: APuU4Z8NspymJ44Ans6RbeX/irmvYHKPnuKf/dk+BivEDYtrFDXdvI7i
	qfUgSDgllMPd8RgvZhz3AayTwJJOu9q/ukfxsNuHH3jqDwPUKWOFclcl45BQxHx69srElHaPPa3
	8gTmFKHw=
X-Gm-Gg: AYBFou0JtUjOLEe8xnbBa79F/+ycMGFUSnttGcBbYmsbjOOuNJBKvP058miFeDDBdA5
	iAtluSxLVErlFv/HIDvFXHAmhQQvmvE0LK8/5y8tSjsGYVsd2azdgs/MKKY4wzADDoGGY+JflCl
	ump22MP6jJPCIfrC6Ko76cj0C3Cc6bjcm7RvueyYRfa8y3E3SwF80ghUHnguan/TLq/+c4cY08f
	c7Brp3TXqykuimiWoN08FSmXX+7mqRO8RiNW9d85AqA4zPce7Okvgb67jukdVtxs9+byk+P3pVJ
	OGvddOroJ1cNAxcRb09UgHnOxHbXh5b59hZ6SnEU6pcQ0bx3crAb0CwqTdFDDpkoVsUFY1Du/+s
	/NA1KduNOqsigVCjCnbV04E8Qxv8qItk0qTacpd6r0FiVGswqOynYK/S1HukdrefhMjk37gxlpK
	GFE8OJXnRtA3jSQC/667Fjpj86zDMAfhy9jsQDEtMPiLM1gdWjUfNPhqjSbs+ozD9aMIv+oWvPc
	6DGGxIFQupj12axQRSzIjX7H3bgdETNOfQCAFhbYtHPyPyizgcQ9BJT9X5hnXXXgzAi2FX+hE91
	tsDvz5eXQheE8bCztc2Z9Ro7NlVmQ/M3HPvrD4gzvtdJrZ68/2gwa7g3umhkKGZ/g9WxFRnoeo+
	90JhUbjRrgc5zbwi7onVfAOR4q+Az
X-Received: by 2002:a05:6a21:4d91:b0:3e8:b7fd:6288 with SMTP id adf61e73a8af0-3eed4abf08dmr4677404637.41.1794248174501;
        Mon, 09 Nov 2026 10:16:14 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdd8d67e52esm56465a12.10.2026.11.09.10.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 10:16:13 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v3] bpf: Use dedicated workqueue for freeing BPF programs
Date: Mon,  9 Nov 2026 18:16:10 +0000
Message-ID: <20261109181610.7027-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
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

BPF program freeing currently runs from the system workqueue. With BPF
program pack allocations, freeing the last program in a pack can take
pack_mutex and call into execmem/vmalloc code to change page permissions.
That path may queue a vmalloc purge helper to the same CPU and wait for it
to finish.

If enough other BPF program free workers are already active on that CPU,
they can all block on pack_mutex and consume the system workqueue active
slots. The worker holding pack_mutex then waits for the vmalloc purge work,
but that purge work cannot run because the queue is full of pack_mutex
waiters:

[   24.646667] INFO: task kworker/0:4:1291 blocked for more than 10 seconds.
[   24.646669]       Not tainted 7.3.0-00001-gdeaa120a9b25-dirty #11
[   24.646670] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[   24.646671] task:kworker/0:4     state:D stack:0     pid:1291  tgid:1291  ppid:2      task_flags:0x4208060 flags:0x00080000
[   24.646675] Workqueue: events bpf_prog_free_deferred
[   24.646678] Call Trace:
[   24.646680]  <TASK>
[   24.646686]  __schedule+0x5bc/0x1430
[   24.646702]  schedule+0x3f/0x100
[   24.646706]  schedule_timeout+0x106/0x110
[   24.646711]  ? srso_alias_return_thunk+0x5/0xfbef5
[   24.646713]  ? mark_held_locks+0x49/0x80
[   24.646720]  ? srso_alias_return_thunk+0x5/0xfbef5
[   24.646723]  ? lockdep_hardirqs_on_prepare+0xdc/0x190
[   24.646726]  ? srso_alias_return_thunk+0x5/0xfbef5
[   24.646732]  __wait_for_common+0xc1/0x1d0
[   24.646735]  ? __pfx_schedule_timeout+0x10/0x10
[   24.646748]  ? __flush_work+0x1f8/0x550
[   24.646751]  __flush_work+0x309/0x550
[   24.646759]  ? __pfx_wq_barrier_func+0x10/0x10
[   24.646783]  __purge_vmap_area_lazy+0x3e4/0x440
[   24.646796]  _vm_unmap_aliases+0x2d5/0x330
[   24.646810]  change_page_attr_set_clr+0xb9/0x580
[   24.646817]  ? srso_alias_return_thunk+0x5/0xfbef5
[   24.646833]  set_memory_nx+0x3b/0x50
[   24.646838]  __execmem_cache_free+0x35/0xb0
[   24.646848]  execmem_free+0x98/0x160
[   24.646864]  bpf_prog_pack_free+0x152/0x190
[   24.646871]  bpf_jit_binary_pack_free+0x17/0x90
[   24.646876]  bpf_jit_free+0x5e/0x130
[   24.646882]  process_one_work+0x289/0x790
[   24.646886]  ? srso_alias_return_thunk+0x5/0xfbef5
[   24.646888]  ? srso_alias_return_thunk+0x5/0xfbef5
[   24.646902]  worker_thread+0x1b3/0x370
[   24.646908]  ? __pfx_worker_thread+0x10/0x10
[   24.646911]  kthread+0xf7/0x130
[   24.646914]  ? __pfx_kthread+0x10/0x10
[   24.646920]  ret_from_fork+0x293/0x300
[   24.646923]  ? __pfx_kthread+0x10/0x10
[   24.646927]  ret_from_fork_asm+0x1a/0x30
[   24.646947]  </TASK>

Move deferred freeing of BPF programs, program images, and trampoline
images to a dedicated workqueue to avoid this deadlock.

Fixes: 72210662c5a2 ("mm: vmalloc: offload free_vmap_area_lock lock")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

---
v2 -> v3 (https://lore.kernel.org/bpf/20261105184411.29248-1-emil@etsalapatis.com/):

- Use WQ_PERCPU with max_active=1 to allow one active free per CPU,
  limiting contention without serializing frees across a NUMA node.
- Generalize the program-free comment. (Andrii)
- Move the workqueue declaration to include/linux/bpf.h. (Andrii)

v1 -> v2 (https://lore.kernel.org/bpf/20261102073439.6822-1-emil@etsalapatis.com/):

- Rebase onto the current bpf tree and move RCU-delayed program-image
  freeing to the dedicated workqueue after the upstream symbol-lifetime
  change. (Alexei, Andrii)
- Move deferred trampoline-image freeing to the same workqueue.
  (Alexei, Andrii)
- Set `max_active` to 1 to limit workers waiting on `pack_mutex`. (Alexei)
- Correct the `Fixes:` tag to 72210662c5a2 ("mm: vmalloc: offload
  free_vmap_area_lock lock"). (Alexei)
- Drop the standalone stress selftest and send a single patch. (Andrii)
---
 include/linux/bpf.h     |  1 +
 kernel/bpf/core.c       | 20 ++++++++++++++++++--
 kernel/bpf/trampoline.c |  2 +-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index fdbf638300fc..1dd9db16f324 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -70,6 +70,7 @@ extern spinlock_t btf_idr_lock;
 extern struct kobject *btf_kobj;
 extern struct bpf_mem_alloc bpf_global_ma, bpf_global_percpu_ma;
 extern bool bpf_global_ma_set;
+extern struct workqueue_struct *bpf_prog_free_wq __ro_after_init;
 
 typedef u64 (*bpf_callback_t)(u64, u64, u64, u64, u64);
 typedef int (*bpf_iter_init_seq_priv_t)(void *private_data,
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 831f73f82599..fc8b133c15f9 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -24,6 +24,7 @@
 #include <linux/skbuff.h>
 #include <linux/static_call.h>
 #include <linux/vmalloc.h>
+#include <linux/workqueue.h>
 #include <linux/prandom.h>
 #include <linux/bpf.h>
 #include <linux/btf.h>
@@ -3143,6 +3144,17 @@ static void bpf_free_used_btfs(struct bpf_prog_aux *aux)
 	kfree(aux->used_btfs);
 }
 
+struct workqueue_struct *bpf_prog_free_wq __ro_after_init;
+
+static int __init bpf_prog_free_wq_init(void)
+{
+	bpf_prog_free_wq = alloc_workqueue("bpf_prog_free", WQ_PERCPU, 1);
+	if (!bpf_prog_free_wq)
+		panic("Failed to allocate BPF program free workqueue\n");
+	return 0;
+}
+early_initcall(bpf_prog_free_wq_init);
+
 static void bpf_prog_free_images(struct work_struct *work)
 {
 	struct bpf_prog_aux *aux;
@@ -3198,7 +3210,7 @@ static void bpf_prog_free_deferred(struct work_struct *work)
 	/* The symbols are looked up under rcu_read_lock() */
 	INIT_RCU_WORK(&aux->rwork, bpf_prog_free_images);
 	if (ksyms)
-		queue_rcu_work(system_percpu_wq, &aux->rwork);
+		queue_rcu_work(bpf_prog_free_wq, &aux->rwork);
 	else
 		bpf_prog_free_images(&aux->rwork.work);
 }
@@ -3211,7 +3223,11 @@ void bpf_prog_free(struct bpf_prog *fp)
 		bpf_prog_put(aux->dst_prog);
 	bpf_token_put(aux->token);
 	INIT_WORK(&aux->work, bpf_prog_free_deferred);
-	schedule_work(&aux->work);
+	/*
+	 * Free BPF programs on a dedicated workqueue to avoid blocking or slowing
+	 * down the system workqueue.
+	 */
+	queue_work(bpf_prog_free_wq, &aux->work);
 }
 
 /* RNG for unprivileged user space with separated state from prandom_u32(). */
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 21d460866dfe..b0052c7565d8 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -584,7 +584,7 @@ static void __bpf_tramp_image_put_rcu(struct rcu_head *rcu)
 
 	im = container_of(rcu, struct bpf_tramp_image, rcu);
 	INIT_WORK(&im->work, __bpf_tramp_image_put_deferred);
-	schedule_work(&im->work);
+	queue_work(bpf_prog_free_wq, &im->work);
 }
 
 /* callback, fexit step 2. Called after percpu_ref_kill confirms. */
-- 
2.52.0

