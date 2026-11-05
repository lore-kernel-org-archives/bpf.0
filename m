Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904257;
	b=c73rZqvWmHjj4aAx/ssYIdgZyWWey7eGJf1tLe0HhO1GZxr+qJEwsg6jamiA6D7ZxzVN
	 ei23JktCgQ+Y2JlERsIViuohQSPr37uP5sCodRuNspR7RRA+As7xagvi7J1bk1Mq95Amo
	 kUJNOPpyo+4wt6v3gJA1+x+Id1ht05nlFwIxcqtjrD/URygRuBHBHAo1dQx28EXG2eZwm
	 sntE5JZRDtfOUl9FCAZL0Dkxh3y81+6Cw5g5+XVUoBRfOaxkXW5ro9O58zid0gGHuRJEd
	 UXGg40LHxyF8ji96/ZotlSUnDJ9wKKGTE/CLaAEgBPcI61sXj3Na0Hh15GU4qnT4iag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fwgIaEnu4lR5bjgjsS9uV/+CSZcK02UoezLydhXsVrM=;
	b=VBRDRo3yvAJcSEeeR7UiDj8hgEhb5XvwhGoymarDJpI+Pkb/38DgNN7xcJqsXeDeCLlk
	 hYQcZAPD1tAkXG+SIO9QuyoNWRxI8/yLuE2AtUj5ZmsDtMTxybEVXIiIfr+c0f7hyG1kA
	 We2wWGp4Thpx5/98DNldNER9eHLvTR1m3toW1+aiZyQBcXXJosWgWRo2FY068yHwDmhJ4
	 oJ4pxsldi89PEzJDJUv6dH99lKc7aoAX4NhIMgDMfyxgGhaC7mGgEq2qXLGtIdzjRHK9P
	 jHw2fsY/SuDTFhTSCTSzF2+oAuJkroRX7LyyI7G/mm7EE1m/yVs/KYPiGByBnIqZ5jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=etsalapatis.com;
	spf=pass smtp.mailfrom=etsalapatis.com;
	dkim=pass header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=fldYahco;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6F606A328
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 18:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0F6F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=etsalapatis.com header.i=@etsalapatis.com header.a=rsa-sha256 header.s=google header.b=fldYahco
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso1260503a91.2
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 10:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis.com; s=google; t=1793904256; x=1794509056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fwgIaEnu4lR5bjgjsS9uV/+CSZcK02UoezLydhXsVrM=;
        b=fldYahcopYbxcr+vhq/mCM3U1otmrhHOxmInN3Wt2VeVNza467s556iRSMQjIHTc0G
         ZZBmfa8KqZm8DNCBR5wYtgqLHM4hmEi9QfD2xUeHYbAsWrOpvSe1yf+7W5u/cWoSnyhl
         z++no6FYBm9W1HaKi3KF2IcJ68zRLNv9OqMZblWsqBad3yXj3SkEEFEWn30BHDlrtaJx
         x3KX9JNsVXIcvw44HK7klRaXhow8xIC6KY501Qfqq42AXGaAkmZk9/NsMt+r9zIU11eW
         vJgwkSgzHZIS0fH2ArT5eGKT+8PYljNwuMlmEu/VW2lqqE1VpELOYDXtco2pJoRfgIQA
         Luvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904256; x=1794509056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fwgIaEnu4lR5bjgjsS9uV/+CSZcK02UoezLydhXsVrM=;
        b=X6n4Qbd1k4qawoFWT3HKU6Izp/EpHDW2FzEs4kBHrgR3mkFjHMR96TiyIzc2cZneL6
         97n2N7fU3URGHKVbESlOXMv8l1yF/lmzZr3WfzV8GN0KeF8M/Qj7M1L7Zwxnq0MWXQ6U
         dSLeOZtUMDGOSwfxvhWROElbVF9K85pL/LFivNYaCohyONZGiKSw2FCDoSB75wTJLhc7
         vGEQ1vYRuvRLXyuXZnVuoZTi0VvUI0EtDdtuSHS3GAPmn7HIPI7zNu48H4YfQXoMKV+1
         HX5CEelT7BMDkO8kXjhwEWO0kPFB5T3UH479FnG4XRCypC78EMKqMwVCGSaexVWA1zU3
         iMKQ==
X-Gm-Message-State: APuU4Z/Jk6INpEKPT18LzJV9+KnHUk4/t0CVh7VLe6eEoVXYCYIth2UF
	5Dk5eH3cGWUkVKyXMaUNSLrQE+T13Pf65jr4M2fiw6XCc3tMlMqnE7phoYJjbHAAxtClG2U0lAP
	WfOkyr1g=
X-Gm-Gg: AYBFou0vcBsopJW2sCFoZaUfD+/wuPgQlwAKVNYpxfWEiCAYcxDm4gP9//CnD98aDOc
	/1u292yay5bpYgltLszcRAr/HkKRqVOw5R1AcH92rMxIG9GWoSeal1vLJQalhv4PZSBVhWxag0W
	LtjFNx32KjgtRppHtRlGlm0lHE2LfelZuZ1f8TBLXr3Jx4MualyS5KGfRvtQFzyTz5Z2u0hubme
	Oew832igoTUAUBn/N4tDzSSycvUhjM9XnkBSVbpRz1BY5rFQm9FtjgIWJYZvDOdkF0mFf5FexyN
	+PjRSexJalmg1DKRmqC6+xYZ1MmsE5wXDWCsAIB6ctuvxMwxYX2dvU96F70YUCu+GIHiJLqy2xk
	RjfuW8EIjbuF5Espzo2rw2BX2PwMXvML+eRXFS3mthyW3chv3SO6YbF8D+rtzAkIe4cSoXmfHDh
	x78NDYs13cJvaFbwo4HgSpnn3qA3kbYS+Php0vMbteqbplwdNMJmY91VnEffSCwqufNQ+8cfMbj
	66Wdf9LuUpBqFtTA0bqLfQrG9d1K/c7jrc2ehD9QbHQiG1czea1zYKDN37aBBe8xHMIeYZreYNM
	t/RnbdnYbmJHcV2ob4j0BXlzMJKM9L2/r9Ih5LYmS+X0l2VLxis1JlSIPMqFSj+ZoDM=
X-Received: by 2002:a17:90b:288c:b0:3b0:a385:5aaf with SMTP id 98e67ed59e1d1-3b0a3855c03mr4733060a91.39.1793904255675;
        Thu, 05 Nov 2026 10:44:15 -0800 (PST)
Received: from alpine05.ht.home (107-190-31-93.cpe.teksavvy.com. [107.190.31.93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b3280378sm4749545a91.12.2026.11.05.10.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:44:15 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v2] bpf: Use dedicated workqueue for freeing BPF programs
Date: Thu,  5 Nov 2026 18:44:11 +0000
Message-ID: <20261105184411.29248-1-emil@etsalapatis.com>
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
 kernel/bpf/core.c       | 21 +++++++++++++++++++--
 kernel/bpf/trampoline.c |  4 +++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 831f73f82599..5c0003fa3e29 100644
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
+	bpf_prog_free_wq = alloc_workqueue("bpf_prog_free", WQ_UNBOUND, 1);
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
@@ -3211,7 +3223,12 @@ void bpf_prog_free(struct bpf_prog *fp)
 		bpf_prog_put(aux->dst_prog);
 	bpf_token_put(aux->token);
 	INIT_WORK(&aux->work, bpf_prog_free_deferred);
-	schedule_work(&aux->work);
+	/*
+	 * A pack_mutex holder may wait for vmalloc work on system_percpu_wq.
+	 * Keep program frees off that queue so mutex waiters cannot exhaust
+	 * the active slots needed by the vmalloc work.
+	 */
+	queue_work(bpf_prog_free_wq, &aux->work);
 }
 
 /* RNG for unprivileged user space with separated state from prandom_u32(). */
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 21d460866dfe..4eab33d1ad33 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -577,6 +577,8 @@ static void __bpf_tramp_image_put_deferred(struct work_struct *work)
 	bpf_trampoline_put(tr);
 }
 
+extern struct workqueue_struct *bpf_prog_free_wq __ro_after_init;
+
 /* callback, fexit step 3 or fentry step 2 */
 static void __bpf_tramp_image_put_rcu(struct rcu_head *rcu)
 {
@@ -584,7 +586,7 @@ static void __bpf_tramp_image_put_rcu(struct rcu_head *rcu)
 
 	im = container_of(rcu, struct bpf_tramp_image, rcu);
 	INIT_WORK(&im->work, __bpf_tramp_image_put_deferred);
-	schedule_work(&im->work);
+	queue_work(bpf_prog_free_wq, &im->work);
 }
 
 /* callback, fexit step 2. Called after percpu_ref_kill confirms. */
-- 
2.54.0

