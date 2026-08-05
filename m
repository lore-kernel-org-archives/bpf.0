Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A1A3290B9
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 23:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785973286; cv=none; b=LbwlcQ/qbFIxv19wAy9s+PgH0fKHRJ7hVub+exhEPZGTJKEftSm7Q6POHJy31zLXFsEP9PqdZQE9wuK/ySvj1wTwXeLGl0RMePLKHkQjSY9DL2xL1GYx2/RxDo5wDwJPBiVrNzQqM9QbaQBxkOjnoP75/XPNWzupIeDBh0mg41A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785973286; c=relaxed/simple;
	bh=0HIFjNj3WvDLI+qF3qGMrEqbjvY4v+Hk55pFnEvxbXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkKO/cBxviUFh/75dNQun4rPusVoPlCP5ofJOFgzfcZljjP0KhD0N0jyIimzHMRCI+A6KPG+q7KAhmEfywFVdaVSBeRi++VUxVrcE3Vz0QCiznO6wAI0MoWA9AHIWpcXXk64Yn3FCODcHBhbRTNRASK3xvZgzHlYaCnPTQZqF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OtITSrAB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OtITSrAB"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8487b7b3fc8so1894512b3a.3
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 16:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785973285; x=1786578085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+f/k8qtt0ZFB1CzqVd8xTjpkHoof7WX447w+MCMY+1Y=;
        b=OtITSrABUmJvAlBdExQMCRwj9pDn3T9YenWof39QIN06fxG9rHJblQSYrjwEHlIQ0Q
         SofklQLbdJdBbPo6v0PGHlZOHE2Fmy9vDt1oF9jjmLXIViE1dOWtm5sJXCO9YWzaWgKz
         qMl1cxrp+fpUvSx/0U95XYTzic2+E84R2hRoBdQXr2tkZhRXnXYdCV9BCMw/yFTeaycW
         38KdzITqTFpuHpe3/ZdtGCg7pQEavUN9xkQTr2Xar33oEQRiqvDQNGlgfbK24icoov48
         4srnwEqnYuav/Q35Dz6xcKK4Wib6h8Dga7L0kYEeApXAGk6nifMyqZVv6IR91nzhLWDT
         A77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785973285; x=1786578085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+f/k8qtt0ZFB1CzqVd8xTjpkHoof7WX447w+MCMY+1Y=;
        b=lhnDgwvxppW2/TzD1HIjPi7sPL32a8FB2gWHg9tP0pJS3MzqMCFCeFpX18Do1H/xTl
         v454ebgjVltiGZRtavl2o3X/bb5miCJ0y7XKBTL62EaZmMtWba5LxtdFkVq5ngwEdZZv
         cqRae/y5H3sEd5cMYoW0YFyERUP+97vcWaSYWxF/AanIxrf1ejoL9gHhF3qr+yVsW/Bv
         WGI4dlwmrDvvSj+fWr0sb3vNbHg3O4vHbPmKn/NeGB6s+0NskYH4EyOOT1A8vpCjcAXq
         A+R/Wha57ZrVA5aUnDc6M0r10ckWGPTSLcMpsORleHUWuZgvaqZt/a6dM+qggGer2SXM
         wUqA==
X-Gm-Message-State: AOJu0Yy9ilPvPwkOfOOArgzd3+q0wfvJEQV2lRi6UmTQb16bJBQSBZmQ
	ECqX3SD9Mh5QNTNE7aBIyiY5buM4q72QK0pgNcrBjom9Lg8mScL3JUxagYuGdQ==
X-Gm-Gg: AR+sD12JcTCBehVqDRzTuQKwR+cXUeBQmC37ejFpFCGijHp0ddV8Gt/vsQv0egZ0/wx
	FSGrPfn22iUmP1OHqtuYriXKdvFaLcBwq0n65jD2i3mrZDvlOV5smPpPk/9QIYy+30QlkHp1UAM
	SjnE/ezflmrNUu008QMI4Loq2pjrLd+4f2ZgdiVFibVdkOTwuWZ4bFJbE7ip2Ob5qPEkLMMTbzW
	jUmluzZbWLnEkVmKA8y//aVOz9rlTaYZsD/Y5uh8tZp+YQ9+TNkJ9WPT7DDp11WlJvEK2RBm1Hc
	DZfc+TlHbLz31x+t5W1dl7ZWtdiuqTdMSZgHCTpVO2uSHoyZwU6IYTxbzA4THXVKIxrFkBNTx8v
	pf3FfSR7WoCk7BP4YRDBLrFEv6FLbmMDsSa8Tkkr2FdieiQ+3b3e66BTsUVe48elIFXb74VI5NT
	jUCh/T4y0GpRaOWiADIXAUETcrZy9mBWRbsp0xWuhe5466QwMJYN64jrpXbsZGLMALX2pbvNypF
	YvNXXiC/OEaWqOwhbTVCrVaBrM=
X-Received: by 2002:a05:6a00:1256:b0:848:5cf5:5040 with SMTP id d2e1a72fcca58-84f2dff7a2fmr10359226b3a.10.1785973284562;
        Wed, 05 Aug 2026 16:41:24 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f45bc5696sm139516b3a.53.2026.08.05.16.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 16:41:24 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	puranjay@kernel.org,
	paulmck@kernel.org,
	Ning Ding <dingning04@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Shuah Khan <shuah@kernel.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Test overlapping RCU protection
Date: Wed,  5 Aug 2026 16:39:34 -0700
Message-ID: <20260805233940.3966981-3-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805233940.3966981-1-dingning04@gmail.com>
References: <20260805233940.3966981-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add task kptr tests that keep RCU protection active after a spin or RCU
unlock when preemption or IRQs remain disabled.

Also test the reverse order with explicit RCU. Verify that task kptrs are
rejected after leaving the final preemption-disabled or IRQ-disabled
region.

Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 .../selftests/bpf/prog_tests/task_kfunc.c     |   6 +
 .../selftests/bpf/progs/task_kfunc_common.h   |   2 +
 .../selftests/bpf/progs/task_kfunc_failure.c  |  49 ++++++
 .../selftests/bpf/progs/task_kfunc_success.c  | 147 ++++++++++++++++++
 4 files changed, 204 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
index fbd7855712c1a..30d403028f984 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_kfunc.c
@@ -178,6 +178,12 @@ static const char * const success_tests[] = {
 	"task_kfunc_acquire_trusted_walked",
 	"task_kfunc_acquire_after_spin_unlock_non_sleepable",
 	"task_kfunc_acquire_after_spin_unlock_explicit_rcu",
+	"task_kfunc_acquire_after_spin_unlock_preempt_disabled",
+	"task_kfunc_acquire_after_spin_unlock_irq_disabled",
+	"task_kfunc_acquire_after_rcu_unlock_preempt_disabled",
+	"task_kfunc_acquire_after_rcu_unlock_irq_disabled",
+	"task_kfunc_acquire_after_preempt_enable_explicit_rcu",
+	"task_kfunc_acquire_after_irq_restore_explicit_rcu",
 	"test_task_kfunc_flavor_relo",
 	"test_task_kfunc_flavor_relo_not_found",
 };
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_common.h b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
index 052c9d0e3e2a8..a0c599b58c290 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_common.h
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_common.h
@@ -38,6 +38,8 @@ struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
 struct task_struct *bpf_task_from_vpid(s32 vpid) __ksym;
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
+void bpf_local_irq_save(unsigned long *flags) __weak __ksym;
+void bpf_local_irq_restore(unsigned long *flags) __weak __ksym;
 
 static inline struct __tasks_kfunc_map_value *tasks_kfunc_map_value_lookup(struct task_struct *p)
 {
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index c0e7216b34193..f96b0c13ed1a5 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -402,3 +402,52 @@ int BPF_PROG(task_kfunc_acquire_after_final_spin_unlock)
 		bpf_task_release(acquired);
 	return 0;
 }
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("R1 must be a rcu pointer")
+int BPF_PROG(task_kfunc_acquire_after_preempt_enable)
+{
+	struct task_kptr_lock_value *v;
+	struct task_struct *task, *acquired;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&task_kptr_lock_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_preempt_disable();
+	task = v->task;
+	bpf_preempt_enable();
+	if (!task)
+		return 0;
+
+	acquired = bpf_task_acquire(task);
+	if (acquired)
+		bpf_task_release(acquired);
+	return 0;
+}
+
+SEC("?fentry.s/" SYS_PREFIX "sys_getpgid")
+__failure __msg("R1 must be a rcu pointer")
+int BPF_PROG(task_kfunc_acquire_after_irq_restore)
+{
+	struct task_kptr_lock_value *v;
+	struct task_struct *task, *acquired;
+	unsigned long flags;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&task_kptr_lock_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_local_irq_save(&flags);
+	task = v->task;
+	bpf_local_irq_restore(&flags);
+	if (!task)
+		return 0;
+
+	acquired = bpf_task_acquire(task);
+	if (acquired)
+		bpf_task_release(acquired);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_success.c b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
index 2bab7634c9dfd..6545b124dee14 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_success.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_success.c
@@ -414,6 +414,153 @@ int BPF_PROG(task_kfunc_acquire_after_spin_unlock_explicit_rcu)
 	return 0;
 }
 
+SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
+int BPF_PROG(task_kfunc_acquire_after_spin_unlock_preempt_disabled)
+{
+	struct task_kptr_lock_value *v;
+	struct task_struct *task, *acquired;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&task_kptr_lock_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_preempt_disable();
+	bpf_spin_lock(&v->lock);
+	task = v->task;
+	bpf_spin_unlock(&v->lock);
+	if (task) {
+		acquired = bpf_task_acquire(task);
+		if (acquired)
+			bpf_task_release(acquired);
+	}
+	bpf_preempt_enable();
+	return 0;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
+int BPF_PROG(task_kfunc_acquire_after_spin_unlock_irq_disabled)
+{
+	struct task_kptr_lock_value *v;
+	struct task_struct *task, *acquired;
+	unsigned long flags;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&task_kptr_lock_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_local_irq_save(&flags);
+	bpf_spin_lock(&v->lock);
+	task = v->task;
+	bpf_spin_unlock(&v->lock);
+	if (task) {
+		acquired = bpf_task_acquire(task);
+		if (acquired)
+			bpf_task_release(acquired);
+	}
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
+int BPF_PROG(task_kfunc_acquire_after_rcu_unlock_preempt_disabled)
+{
+	struct task_kptr_lock_value *v;
+	struct task_struct *task, *acquired;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&task_kptr_lock_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_preempt_disable();
+	bpf_rcu_read_lock();
+	task = v->task;
+	bpf_rcu_read_unlock();
+	if (task) {
+		acquired = bpf_task_acquire(task);
+		if (acquired)
+			bpf_task_release(acquired);
+	}
+	bpf_preempt_enable();
+	return 0;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
+int BPF_PROG(task_kfunc_acquire_after_rcu_unlock_irq_disabled)
+{
+	struct task_kptr_lock_value *v;
+	struct task_struct *task, *acquired;
+	unsigned long flags;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&task_kptr_lock_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_local_irq_save(&flags);
+	bpf_rcu_read_lock();
+	task = v->task;
+	bpf_rcu_read_unlock();
+	if (task) {
+		acquired = bpf_task_acquire(task);
+		if (acquired)
+			bpf_task_release(acquired);
+	}
+	bpf_local_irq_restore(&flags);
+	return 0;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
+int BPF_PROG(task_kfunc_acquire_after_preempt_enable_explicit_rcu)
+{
+	struct task_kptr_lock_value *v;
+	struct task_struct *task, *acquired;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&task_kptr_lock_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_preempt_disable();
+	task = v->task;
+	bpf_rcu_read_lock();
+	bpf_preempt_enable();
+	if (task) {
+		acquired = bpf_task_acquire(task);
+		if (acquired)
+			bpf_task_release(acquired);
+	}
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
+SEC("fentry.s/" SYS_PREFIX "sys_getpgid")
+int BPF_PROG(task_kfunc_acquire_after_irq_restore_explicit_rcu)
+{
+	struct task_kptr_lock_value *v;
+	struct task_struct *task, *acquired;
+	unsigned long flags;
+	int key = 0;
+
+	v = bpf_map_lookup_elem(&task_kptr_lock_map, &key);
+	if (!v)
+		return 0;
+
+	bpf_local_irq_save(&flags);
+	task = v->task;
+	bpf_rcu_read_lock();
+	bpf_local_irq_restore(&flags);
+	if (task) {
+		acquired = bpf_task_acquire(task);
+		if (acquired)
+			bpf_task_release(acquired);
+	}
+	bpf_rcu_read_unlock();
+	return 0;
+}
+
 SEC("syscall")
 int test_task_from_vpid_current(const void *ctx)
 {
-- 
2.43.0

