Received: from mail-wm2-f0.google.com (mail-wm2-f0.google.com [74.125.225.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D421347536
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 05:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788585152; cv=none; b=uCRu9j4I8jr1eQTUJl+DsvRhjxls1pnoiy6nWrq8hL7+Ofk9Ux9gIdIT7n6lxV/vrXS8RRpmPSK9lQzrfNoMEumxlSL6ycBgSGQ2jyE6/kMBsWyxV8FE+pKaOoLs2/Nv6ZM2ebqZ7STSyYvHLXOLuelKo+6Z+OcEqp9WR24X3go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788585152; c=relaxed/simple;
	bh=IwLeXNYrvn44dlBsST2rWK9mOAjTc3IElBXZDmMPjas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOi84rvk3hwraQwLPQltTH4XwxUa1IGoOXI1GKV5Vgep2aETm3JZTh7X/SEQBiQlYonRwDW/dzHQkpt1TXSKa54Tg+5CXVuVX/axzBRvoSTWxwNn+TayZdDtOvYDpQPSpH4KL/sw23Bh4f1Afk40L7rlEbIFA5KXjWdaiqTI6hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4jofV5/; arc=none smtp.client-ip=74.125.225.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4jofV5/"
Received: by mail-wm2-f0.google.com with SMTP id 5b1f17b1804b1-49ced856e8dso7631545e9.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 22:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788585149; x=1789189949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8T3MRdleFeZALY2yg6PIwPx4JtdQgxftAueJ4prxCSQ=;
        b=e4jofV5/gwNfLfcdJlnjM/9xbkaB1k0uiPu0zuyfuq1jCnOeT6zpuHt6gnUB+tZU7H
         Rz7+IzJ0NQprpFmpC00tVqjP+3COTOzzreF6PoYPZPIAAdtPAlvpLUhiyYwkGXtbuV+/
         WfnXsoknH8lsrlcsb4W1hzDGr2m3OHIgq/VhS2RuUXQx6X73i9iKXik6OmOrLA6CGUoJ
         maLdkv+wGMda8W+ZkgJUe5ox9L0+hxzU+iZD47ChTXLhrc1Jj8fb6uzWzVbrOUQr9+Hg
         KRKbra2MKPgzD4JGqTCBZW+ispqSAGGJr7QtJmVC9frPrzzl2VwTcoW6A/j1VDKoYdvn
         4Wew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788585149; x=1789189949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8T3MRdleFeZALY2yg6PIwPx4JtdQgxftAueJ4prxCSQ=;
        b=cwdlNEEt7Yz/pBkvuZLXZklNCjt1qH8G2OcHe/bO/qdW3tr7IGexVCbBJEpHTr1nnG
         6vtcx9QZzbaqDZi7V5ptz3xhFuYjNGN3YNJGYmpAPFKSsnsBeJm3xaFPZRVB8eSto3S7
         5+M2J9cEn/1iylWTWvTHqBzwOdbPugyaQUwVEa3BFKTFnzskyhaxx/KkQgYYGG5OTuzO
         +selHX0CNR9y2vOgVn0HYLYMQLQvbIew0/Tie0s+aPe1xIQszAqY5w0mfxIiXWTi2Cp0
         Y4EHgTbdIyc5bbfO1WNzHZHGc4NAY4Z6QiFiPh7JjKnj8/G/e0h2TMYk47pM4n5ZQtF3
         CDFw==
X-Gm-Message-State: AFuF++lvTy28+1sOxU9H/StOgkunssSreeB8sMX3UEurEEg9/GUJzfTz
	IN+wc2PKZbmc4wcDFOfnFt51mgBaoa/HaQ51kDlgVx5Xpd6prgjRBFSGacSGPl19
X-Gm-Gg: AYBFou3ptqmwMICOI2qTi+i+lmQdsbLPlY0E2QEvyJqUGNgaUT+mXFvE9kYCnNwR4n8
	8Q33nCeKjQvWJtHtIAWuqXJrPmIawY0ZEdgHjU3N42+aW8MMyDp9QIKp+LRoIFqRv2zXcgVWKwI
	LktJpLQ2pOryWP/gLTeuLs0qaTCTilmXSeQxywPnloX7+PqiNpbciQ/TKQwwOqmCrjLwA7u0qwh
	LnjVhpa3MJD+qJunzTZmADRqzbMHfS+Zxt9V+Y2JcBAr2pflUkdvmKdo64L6iNElDB0kbvRPQ9X
	K6WQFtN2VJdRHteTjA2m1HP8xTBYZMjW2JhR1dUtZF+YlABgtk5mJ76Ml25Q7cja+I8DKwI8GgO
	fVLqUHIUhtQAdUIsF6z1gKQp0B5eX1I7MlbbxBxiWgxMjuyRm8klNGmXFJoYfo7ltQWEFJtwzdy
	4O1eChWmd55ZrFWgdtkur2z0cOvqpaFJmB6n2JshDTUZZrLNEJafx76fPmL8Ni1YfHwkmCzxaIj
	xYBaxOFoFhAmOLd7vDPZTOWjM/fTme7LaJAt5COoDng5NCTl1cMATHukS8ZwaMwuqQY/7dop/On
	Q2OtBDxO2lMG+IBLDcoJyxc5NwbvhoeTuf0Cxw==
X-Received: by 2002:a05:600c:3485:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49cf825c119mr206011285e9.16.1788585148741;
        Fri, 04 Sep 2026 22:12:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf770fcf5sm117492735e9.6.2026.09.04.22.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 22:12:28 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Test global subprog callback contexts
Date: Sat,  5 Sep 2026 07:12:22 +0200
Message-ID: <20260905051224.2325381-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905051224.2325381-1-memxor@gmail.com>
References: <20260905051224.2325381-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5108; i=memxor@gmail.com; h=from:subject; bh=IwLeXNYrvn44dlBsST2rWK9mOAjTc3IElBXZDmMPjas=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv2kqUujlPtmy+t53vVtN0lVeVaTErdv6TvxwJniO151 3FE/WJrRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACYyRYuR4b9hw1+ntpJdxi2s Gaf/LGG/FN64PPlo5oH1HNG9P18ddmD4p27SfpZdYaXTIXt75V67ssl72YP4eysSzxW35x1teaP IAgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise global subprogram verification from workqueue and task-work
callbacks. Both callback types can run in a sleepable context even when the
containing program is not sleepable, so an unprotected callback must not let
the global subprogram use implicit RCU protection inherited from the program.

Add negative cases which load an RCU-protected task kptr in a global
subprogram reached from each callback type. The tests fail on an unfixed
kernel because the programs are incorrectly accepted.

Also cover a workqueue callback protected by an explicit RCU read-side
critical section. Finally, call the same harmless global subprogram directly
from the main program and from an unprotected callback. This requires both
non-sleepable and sleepable verification roots and proves that global calls
from callbacks are not rejected wholesale.

Keep the harmless global opaque to LLVM with barrier() so both call sites
remain in the generated BPF object and the positive case cannot pass
vacuously. Have workqueue callbacks return zero explicitly after calling a
global subprogram, as required by their callback contract, instead of relying
on interprocedural return-value optimization.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/verifier_async_cb_context.c     | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
index 6bf95550a024..987ca9dec6b7 100644
--- a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
+++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
@@ -9,6 +9,11 @@
 
 char _license[] SEC("license") = "GPL";
 
+struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
 /* Timer tests */
 
 struct timer_elem {
@@ -66,6 +71,7 @@ int timer_sleepable_prog(void *ctx)
 
 struct wq_elem {
 	struct bpf_wq w;
+	struct task_struct __kptr *task;
 };
 
 struct {
@@ -119,6 +125,106 @@ int wq_sleepable_prog(void *ctx)
 	return 0;
 }
 
+__noinline int wq_global_acquire(void)
+{
+	struct task_struct *task, *acquired;
+	struct wq_elem *val;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&wq_map, &key);
+	if (!val)
+		return 0;
+
+	task = val->task;
+	if (!task)
+		return 0;
+
+	acquired = bpf_task_acquire(task);
+	if (acquired)
+		bpf_task_release(acquired);
+	return 0;
+}
+
+static int wq_global_rcu_cb(void *map, int *key, void *value)
+{
+	wq_global_acquire();
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+__failure __msg("R1 must be a rcu pointer")
+int wq_global_rcu_prog(void *ctx)
+{
+	struct wq_elem *val;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&wq_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_wq_init(&val->w, &wq_map, 0);
+	bpf_wq_set_callback(&val->w, wq_global_rcu_cb, 0);
+	return 0;
+}
+
+static int wq_global_rcu_lock_cb(void *map, int *key, void *value)
+{
+	bpf_rcu_read_lock();
+	wq_global_acquire();
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+__success
+int wq_global_rcu_lock_prog(void *ctx)
+{
+	struct wq_elem *val;
+	int key = 0;
+
+	/* Verify the same global subprog in non-sleepable and protected contexts. */
+	wq_global_acquire();
+
+	val = bpf_map_lookup_elem(&wq_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_wq_init(&val->w, &wq_map, 0);
+	bpf_wq_set_callback(&val->w, wq_global_rcu_lock_cb, 0);
+	return 0;
+}
+
+__noinline int wq_global_no_rcu(void)
+{
+	barrier();
+	return 0;
+}
+
+static int wq_global_no_rcu_cb(void *map, int *key, void *value)
+{
+	wq_global_no_rcu();
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+__success
+int wq_global_no_rcu_prog(void *ctx)
+{
+	struct wq_elem *val;
+	int key = 0;
+
+	/* Verify the same global in non-sleepable and unprotected contexts. */
+	wq_global_no_rcu();
+
+	val = bpf_map_lookup_elem(&wq_map, &key);
+	if (!val)
+		return 0;
+
+	bpf_wq_init(&val->w, &wq_map, 0);
+	bpf_wq_set_callback(&val->w, wq_global_no_rcu_cb, 0);
+	return 0;
+}
+
 /* Task work tests */
 
 struct task_work_elem {
@@ -179,3 +285,29 @@ int task_work_sleepable_prog(void *ctx)
 	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb);
 	return 0;
 }
+
+static int task_work_global_rcu_cb(struct bpf_map *map, void *key, void *value)
+{
+	return wq_global_acquire();
+}
+
+SEC("fentry/bpf_fentry_test1")
+__failure __msg("R1 must be a rcu pointer")
+int task_work_global_rcu_prog(void *ctx)
+{
+	struct task_work_elem *val;
+	struct task_struct *task;
+	int key = 0;
+
+	val = bpf_map_lookup_elem(&task_work_map, &key);
+	if (!val)
+		return 0;
+
+	task = bpf_get_current_task_btf();
+	if (!task)
+		return 0;
+
+	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map,
+				      task_work_global_rcu_cb);
+	return 0;
+}
-- 
2.53.0

