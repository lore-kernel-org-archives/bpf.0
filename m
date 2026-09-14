Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62577345ED7
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391971; cv=none; b=LVn1PW5/5i9JB5kTroUHa1i+pYby9gYePTuz5KQTJns/q4xyM3sIPrQeiBW5dFj4a4j63zIoTaIR8pKHOVcqf+tvUgukTkqQTSBDfeTtMGJr06ZZGh9XBwQgg9rzaccRyo8XZRAQt6wetGXAQ4M0f8NFPlpwAg0I4pB/bYankwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391971; c=relaxed/simple;
	bh=YVg48XAaYO9r5lkTIQQmg8oc22Crn99kdUqHLKOc0Vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWX34k33pyApDjYfQ0CrbK5sYLD5ng2ES/gfHI55oF5OPY89q5ZFwUuU9kDaO9a6VV2T1QlZgdm/JQEeUyAAF+l4J0Bk17hPAfSmoNgrGpHKhQbLrG/Y40uu13XKM49+W39futlw5oKS82WFvuJm0ODCGSjlmwYLNBa1nX2w0vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l+CAwgYN; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+CAwgYN"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e667e3c45so7248285e9.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789391967; x=1789996767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r5Shq9p57OTnh+sQR/FmffKLijVpHbwBm0u7L6r8DBk=;
        b=l+CAwgYNImU/s/ofWY4QCYTnxCZlr1+B/olJhtK78XSFlz1MS4Guhqb4K2DeNIf+Po
         GlcU4cTNJzu3P9Rp1Ioj/ez6VgqLx64DC4DXv2v4vrBvFaytqtDXsWnkN+QpWTStKmNv
         MMqjLjfBvd4cZS9B9TkBbqEhVbsP0Np14OA47i2vIqCpIk1hIf+LrTsUNMAiBXIEWGIA
         ngrZlVs6ZdUzNb5ogXGuZ6Pmfobh2Zxef8tLihvyEZFUEAHSv9FHkL1/bwa9gWsgiLD9
         WoxWZQjnJwO67Ki0HFEplN49xhzR1I1zHLpVVlhFwTWXYe0gzfeW2nnyidrgEeRSHMTQ
         lisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391967; x=1789996767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r5Shq9p57OTnh+sQR/FmffKLijVpHbwBm0u7L6r8DBk=;
        b=lVrAm2ffOdxnX3TAwVHjqKNL8auxj4+ve2hJJyfV2cFrxY0zcn3qgDxjA5tngD5P1u
         YD1HQDNJ7YjCDlEHyZgzK+/cpPD7x9bTyumRKJU6+aLQZc99woVQ6Baj+Pc8RfnlB596
         B4xKRzgNW0HEfFIjnci/FLgPHLiApJ7YDwBtZYLovGjP5V9rzImLzrDiqa1M+s7Tu3yw
         GWnUEFb2sJNYdXBGam4jwQoqJBBzXReyGqZ/CgLfDWePSt131y9vw7IKlo5xa69Q5a78
         xgrAlvcu6FQBPrNZrVioV8RqOmfUMYobfswwYa3M/oxrsvtPH1JDvyRZsjxCiWT6cp7p
         o0xg==
X-Gm-Message-State: AFuF++nrbTJ06G+Umq3W2wq39VPJDDJpqwT5d0zE19skyuzUpzqXnW95
	hV1WrWtg2CIVpe8FZRs/YLbEsWZy7yXMwYkmvK0jMT9UvVNDv13FezL0BeKcorIp
X-Gm-Gg: AYBFou11J4amoiwKYHfqDy3k09hRCPz7AMXidO/TQlhX+Te/kKyj+P5U1NfJMhQWPkj
	kuNlfk7AelCX6P8AGzTOBOpdlnCOI2P2Cv+IFAcAFugEIshSrg0SQvQxx/wvPd2rc1HpmcLVI51
	XAOJN7NBC6FeIqojCfjvrEMxnHRvHBYogwPxQm5n7qS757PFCJfqHu/tuZslLWNjfyh40iSX3EC
	lGPJOVkQRe7t69L0E03BLBnA5TJmtKZo5xQmr6YBZmebFU2PrE+scooZH98CzcNEsu5CB0TtluO
	FjlO9SurqMgTC3Y/IZhCGtr0BtkxSdpNvdOY3pdXuV4nwhYNPhE3u+4xmyz84oecC3A3V09vkQO
	M26JqbrF3EcjfpqNaU4fQ9PRAWaqbIvjxHFudu69zCnSllo3dFZYO6/ArFm4Cd/IzWQbcQwnodn
	zGHxSPWUQnMHT7qR1xv2AM1TxgHo3lB6+7tnzOkWJ3cF3gfEezqJOXXAkAiTNaV+DDZpKZDmMDx
	GNFKSralHsa+J1nIpwl+ueOj66L9LLBjmpudavIYC/OsikAZWmqDWdH2mZn5IT7Uz+D5z7qedYR
	uwiPFCZekRTov0thVZM0+TKHQE9CRK5bhddQzQ==
X-Received: by 2002:a05:600c:474e:b0:49c:ff9f:f6b6 with SMTP id 5b1f17b1804b1-49e7a63768emr32815285e9.6.1789391967493;
        Mon, 14 Sep 2026 06:19:27 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e71adc2ecsm189530565e9.4.2026.09.14.06.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:19:27 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 2/2] selftests/bpf: Test global subprog callback contexts
Date: Mon, 14 Sep 2026 15:19:21 +0200
Message-ID: <20260914131923.2544250-3-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914131923.2544250-1-memxor@gmail.com>
References: <20260914131923.2544250-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4337; i=memxor@gmail.com; h=from:subject; bh=YVg48XAaYO9r5lkTIQQmg8oc22Crn99kdUqHLKOc0Vo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv5Fx+OgoP/Nxj/4gjR7Kvr45y2Tl/UcIKq/i6DSK5j6 6Y9sF7aUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIkk32T4pxe/VZ31kr3n+2bT gk9ZB019Dlzav9U1x+XFksZPZ696KTD80xc0SPZbNI+n5ewrO9Efri+9xNUfaLIIcju9u6+cMEe SCQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Exercise global subprogram verification from workqueue callbacks, which
can run in a sleepable context even when the containing program is not
sleepable. An unprotected callback must not let the global subprogram use
implicit RCU protection inherited from the program.

Add a negative case which loads an RCU-protected task kptr in a global
subprogram reached from a workqueue callback. It fails on an unfixed
kernel because the program is incorrectly accepted. Also cover a
workqueue callback protected by an explicit RCU read-side critical
section, where the same global subprogram remains valid.

Call the same harmless global subprogram directly from the main program
and from an unprotected callback. Mark it __weak __noinline so both calls
survive optimization, and check that its instruction statistics account
for both verification contexts. This also verifies that global calls
from callbacks are not rejected wholesale. Workqueue callbacks return
zero explicitly after the global call, as required by their contract.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../bpf/progs/verifier_async_cb_context.c     | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
index e0926767bbd3..1b653bfb63eb 100644
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
@@ -164,6 +169,7 @@ int syscall_btf_find_prog(void *ctx)
 
 struct wq_elem {
 	struct bpf_wq w;
+	struct task_struct __kptr *task;
 };
 
 struct {
@@ -217,6 +223,106 @@ int wq_sleepable_prog(void *ctx)
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
+__weak __noinline int wq_global_no_rcu(void)
+{
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
+__success __log_level(4)
+__msg("subprog {{[0-9]+}} (wq_global_no_rcu) global insns_self 4 insns_total 4 stack 0")
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
-- 
2.53.0

