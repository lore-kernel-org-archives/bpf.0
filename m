Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6460329E55
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788579626; cv=none; b=J/MWIvTRwyQfTBv+gCzc9GrT4KUH/JRG3m7ATiEsXZCjPepQa9vTOUW5P3fbBnKUtHgIBdXquos0q1E4tJ+gOS8PgHlc/QBadjFZTetJzHhCNXPVYmTHxsMfDpNWaUgxbJawGdu3fU5gnXUakB2keGOg25LGI+GHCGMm0zaK5KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788579626; c=relaxed/simple;
	bh=vJYJ87USojFC8YW0vrNr4ZssyAair+ly68ML5KluB60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRnJ3XHb1TkucN60tLyP3QvMNLWDzP+iPD6QrOeuD2RHbOEI/EtKEx1reefI/0kmtu7sI1SwPksCS7YV8L2kEO9ZULDSqpEu54y0/FX/cwkJytPLadZdkGzHCWhGUU5dVGvfZYTZ4e0aywPTCyViNj2nbQxaAlpw5yaGzXXeXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TsvgsaAU; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TsvgsaAU"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-4843147998cso310613f8f.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 20:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788579623; x=1789184423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=um+fjr5gvmSP6eSB4H/XfcDPO6+qgH9Jtlkv2Ndg9vo=;
        b=TsvgsaAUrxDpSKXrZ695GxypfhsK3lFyZK2pqnl6M/O73+xeDIpeyN23zdEz+bEIpe
         Sp2JVmh0DuzRyj1KlGruXSagmRfSeQD1aiDh0N79u5F69jq49aZD2kq6KC3D9/VXYehR
         7gwUKdILKq9svIYgMM+AB97K8fptwqzysYBaHeXqDwOIr0F3Nh+ls+B/5V+Iv445+7T4
         97woGtztCtZJ9sTwfNz7eBhb7MYb6/H3rYBGyOMDg5vbhqVuLT+VYnIxdDAKEpgxeZ4W
         yU5KNGK7VFX4fCggqk4Ql4qI/UNqqOE301X3NNWJ6EzysP8jDAMxnNHs65K53eAbhMSN
         9ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788579623; x=1789184423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=um+fjr5gvmSP6eSB4H/XfcDPO6+qgH9Jtlkv2Ndg9vo=;
        b=XwIC+yjjgsaxGR00by4X1C7zofHiMrD6cCfzz9s8r0/wzRe6AzefZb1w4Vk9sFhcbL
         EmFDAkxy7sNUzaZsGzuyXc1AbPl7b8vJuhe4uBaIoUjZGY35HPiO/ejXu+LhQUiFmvrS
         dXLcBprNIYJCKVEJTnzbp4XOmoY4TsicqFQ2jW/2MsTi/80/agFtVDeSS0aY85ARU9cF
         iL3RFbCY3j6M238+VE6WCbTFXxyiqeryVkWHk7uxEq+1ase5bu54F4su+o21AlftAUnB
         WrR3pEp3JmvEP/SMIhsAZI7PV2MC/elPLBIzkhcRC1jt75SzPubtoQNIwggA29uMrRkI
         xJfg==
X-Gm-Message-State: AFuF++mAWVAJLOFf4UHKHBkPSAvMuQrPOaxGkO0RaexWan17d1aeUg4a
	PFCGpbFEjtPXSRqPIK45fRzE7BjZX/unfEByy+Cd5Tr6//0AWIk8Pa4w+9KazuBG
X-Gm-Gg: AYBFou1/3ChP5I6wh/0QQu93hsTIQPMh7q0OZyIVWo4g/EjNgY01aCka/tX/JYGGc2V
	Mb3UtWGdRLCRomIAxjvn1ZjpanXoQ53eYKBfyzOTJDhuFA2UZCtmg4bedMMVb7hFCmZm7K0kZhe
	9maZlyZO4MA2/nILmLolUUJjfgOHrffpvVar+xaet2xEAdFecVhj6hSlX0uVgC5tXIZ8/H8otrk
	geEZDE8kD870mgYH9WG+28YiQkAXAVo7irT4Cwdqgt95LAJ+4FUSXGCFX58370xvuPsZ3e0Dfsz
	MeRxKKxmr4+jnVyNFdMiNYcV8oTXNlvMs0QZrcS6ZqL+btuh/DCdnc1mdbqTjR+C9yjIQ1y1CIa
	MRU/ZAYNMUmVz2iShLWIewYMrqSuBV/ZhG6SVy0oc0UCGgnR3VK6h58SR1FELOZKU8TzFoknKFi
	LD4m3aSrArwYGzuorpfPFxCr67OoJbM2ddXQQjyVCfUi7y0hvWc9g5JqAhhv63v0bH54HS/81sn
	wv9rrr80GSt7WQKNBHzJRwulT2jAuwNlUe9/SZrfed+xQF569Qoi3YvGSurJQFCUURfR/7XB7WB
	bFApQbCihIyHWJRtNJD6ZTNAusc=
X-Received: by 2002:a05:6000:2f86:b0:482:dfaa:dfa9 with SMTP id ffacd0b85a97d-485891e72fbmr10672329f8f.7.1788579622842;
        Fri, 04 Sep 2026 20:40:22 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d2693e8sm7496712f8f.3.2026.09.04.20.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 20:40:22 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Test global subprog callback contexts
Date: Sat,  5 Sep 2026 05:40:16 +0200
Message-ID: <20260905034018.2095649-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905034018.2095649-1-memxor@gmail.com>
References: <20260905034018.2095649-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4756; i=memxor@gmail.com; h=from:subject; bh=vJYJ87USojFC8YW0vrNr4ZssyAair+ly68ML5KluB60=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWt238dVvDGiQS+mZB5xuXJkPruvHPdj64+TZrUturXA4 bz5+9f9HaUsDGJcDLJiiiwl//cxGZ+o/B1ou4wbZg4rE8gQBi5OAZiI3lyG/0l9WVqTFXQ/PMwu yT5nW+eS+Ko18ZPK68rreStnBv6/LsTIMG3xTWaOnTwMO70KMu6wTC9Z3sq2VuXOShlVv3dFWue XcAAA
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

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/verifier_async_cb_context.c     | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
index 6bf95550a024..9ce7359913f8 100644
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
@@ -119,6 +125,105 @@ int wq_sleepable_prog(void *ctx)
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
+	return wq_global_acquire();
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
+	int ret;
+
+	bpf_rcu_read_lock();
+	ret = wq_global_acquire();
+	bpf_rcu_read_unlock();
+	return ret;
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
+	return 0;
+}
+
+static int wq_global_no_rcu_cb(void *map, int *key, void *value)
+{
+	return wq_global_no_rcu();
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
@@ -179,3 +284,29 @@ int task_work_sleepable_prog(void *ctx)
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

