Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270490;
	b=04ouFTcv/Gu0dBy+I/8vKvc6vgCOG1qkBcC8PIt7JzT6S0cJCJ+pwYQmr9j1iWvPWbjA
	 7XYlc17FvBZbaJyBBFNVfHNflKeM37ZZxyKn6QyBW4aq2kNe9MQM/7t3VUIJX7KoTX+bn
	 Hw9J5CeVjxDee1Nj9snJ04fCJEVUki5ixuiiWeveubh21PO/GBco68ZKoI92eIKQjRBsV
	 BnY2pB8VsLBeQTXEKLJdnQ6kt4NXq++u4xdpJIg99Ynp7ZMFxnme7Y6cbJxjPL9uWe2wN
	 YnjQVyfN9mZ1h8klp1Ahh+q038Pf/gpdr1/11mmsOyg/9EGT4nDRlWiknP22rEg6LJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=fIpecmZf9mL9FGbD2qU/iAEfSFeQ0B7blLCNJGpK2H8=;
	b=Fw88liJgQN9F8Ly7ahF9Yg3U4l5nYIfiuDzsoIqzWDYftR0M/yo5VKGyA2uHwu6517fk
	 +suC+/sjx3LGx22RGVAAqnZWgmoFqYamWzXjfr4fHqJ6WUFC4gH+oCge1bp0Ngs3negTJ
	 DvbL6GijPiKeUCW1YwA0sA2jh/lXZkN6csaG33zg9SkhOfMN0ycPAjNhXqJEQVuO8Nim9
	 2kpC3/GaLQnrc5rEJA0HSj7g4xYqPGGFa7K1x95fwsJ9T9dzCdPrTadF+IdC3Y6zld9C7
	 mfLpNC5uVxvgTbQtE9xG1pOkvF4cYVoUkJOpPk1QaJf6+3Rpss95aNTLzHZ4zoQ9a4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=joxc4HKP;
	arc=none smtp.remote-ip=74.125.225.137
Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA4D606A330
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AA4D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=joxc4HKP
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-4ad5d6045d4so7198915e9.0
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270488; x=1794875288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fIpecmZf9mL9FGbD2qU/iAEfSFeQ0B7blLCNJGpK2H8=;
        b=joxc4HKPcZ6EacwyXKll/E5qgY8ASTCxtGeWXZo87AytbNNqCV4yK2mcqyTSK5Jyui
         M7y+3Yt9BvMu6aMKD+Bla/mnTMRkekwRQNPz5zefILmESsAxAkAiUteNxUzvIYJKS31k
         G8vb4ciagFzDLFoqC/YJxOs/yh07oTCLoszwUY9LU8TZKgy84NfTe9skKD6KHHw036zr
         6esUwjDykG1Vg6sZ9Nv398prVTV4WHWBivcS1dT8t+4yxMfr44jxsrnj2bb8Vneb6CQ0
         uIIEv1kXhbrxLI69J8HACd1dryCjAqoUOyQBc7wXN6ppf+E07RpxWb41pwXjSXqEm/AH
         AHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270488; x=1794875288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fIpecmZf9mL9FGbD2qU/iAEfSFeQ0B7blLCNJGpK2H8=;
        b=XAlqrXNV8oLnHsphbLa6jk400pUSRnAeX4zvEukM542QrFcdk0Lv9e1Aux9aNu5Ekr
         H9m2WTVBIADQOojbrl2S/ty0JOD0PfRa1JJlFu9mLN/c/3AYjjrgTBQi891XXiNNCCei
         kgPwCNApQjeR2K7SOQJcGiZ1PirBIfEt+06LBRTY6m0S7xLLhMbxVnlerQMWCpS38Rur
         S0raCOqwa+fa/TssBfrhaGT6UkwvKa1jlwgvpsAA8UPd+sgDvQJLaQgxiFY2eYweYLC1
         iAPxt8nQOO2bw30OB4twEo88UdUIrjFWLsyiHcSbXVQr8Da/oE7jNiRmKwIK2ESjrN52
         VbuQ==
X-Gm-Message-State: APuU4Z+BlkG/vzafj5qsnIqcdIc5uQ1Q/Tji30tokDgTXp3qcf3rDxu2
	S8KEF0bDIl8m/Q0I9IBtF4UwudrholIHpTcCHabNKyGsIz57zt5R1DQsPtuSCfe0
X-Gm-Gg: AYBFou3P6XaGU7N1R9btEmwt63sjV4rf6bTW7HAEDD5uqi9okeGj/ctFF1L+YTtkJfF
	1S20SVytRKIbv+LdZYl1tALfaOUMl3WYTKPP0oYRKIWLzMQ0ec9rsJaezLq6qefZyOqJub6LIG5
	MSN/cmkM0xDqgAJGJwwUR9zbHChmwKJyxoJjQF49cjBXeNw0XXDwjfi5tt1zYMoS9mc3mf4M+KF
	FfnNomDavuc0VJWjkG+MTRsl9lcSWQlzsMh2pBbgS1CtHK1KRwXkHUaOdPZfMLhmExe59MhYFit
	I9U4RAwR9SVMD+nT5jaPvcm49u0T41XjWJ/RWV6WUygnMez9IfNBKXPJNaUl+YX3GSAl+1frjUI
	nL+yYWwBdnouuZ2WynArLG8wy9RuoULtsPYshFRzKI//1KLiTjrAwnCjcLABmkHLDMY5Doxp96Y
	3TChXwg0FYr6zt+124KoqtSpGBeqhup46GOaQgXkgknzoXPEjQrK5ssX04zlfr5OfqUvsuEQkP2
	pV61/ybCPjyQ5F0URlrTl20TOw1QcXsS17xXJagDQm1jMF0/oZA3GG9ydv52VaFUR3TJ3VzeslE
	15EzNVnp4Jx8KFivqfUFNt4TO2L8jbcrw2KdhEQzcfx7NFzKPzj7qibXk6aCLIGzcy5gAdONDwn
	h7vOgBsSwnnBgnN6K7xHBQf+yxSUsw2uCupKQILHgofqna/47EzZkeSMuR8339rD5UCZo
X-Received: by 2002:a05:600c:3544:b0:4a1:db17:c7e6 with SMTP id 5b1f17b1804b1-4ba02305402mr13234725e9.2.1794270488346;
        Mon, 09 Nov 2026 16:28:08 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585c4fdsm1805409f8f.10.2026.11.09.16.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:28:07 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 12/20] bpf: Add bpf_kthread_bind() to pin a BPF kthread to a CPU
Date: Tue, 10 Nov 2026 01:27:34 +0100
Message-ID: <beaad5b1ef2a6ad23c531fd2cbb0d5ecc229143c.1794269507.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6287; i=memxor@gmail.com; h=from:subject:message-id; bh=Dv6NDeIWw441WQ8nvfwWCru+6o+KpdZHM/zGr+YeuSc=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTontqV1PH09ypytucH2UzNWesSlihfMl3ipXPtK/+y 4xvcZ7rKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQ2+TP8M5mSk3n6J3fi5Quc 6YXXrurM22XeKrbgv5qM+nH93i9VKxkZNly74fZGU2zK84M335rY53/Kk3gx/9TxqTWfPd/fnFl twwcA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A BPF kthread that services a per-CPU resource, such as a NAPI instance
whose interrupt lands on a fixed CPU, wants to run where that resource
lives. The program can read the thread's PID from its task and leave the
placement to user space, but a program that creates threads as its load
demands should not need a round trip through user space to place each
one.

Add bpf_kthread_bind(), which restricts the thread to one CPU through
set_cpus_allowed_ptr(). A thread that has not been started wakes on that
CPU; one that has moves there at its next park or return, when it
enables migration, and the call waits for that. The wait runs with
migration enabled, for the reason given with the stop: a bind made while
pinned could be the far side of a wait for the caller's own
migrate_enable(), a bind or a stop issued by the thread being bound, and
the two would wait on each other forever. It also lets a thread bind
itself, which the scheduler refuses with a warning for a
migration-disabled task whose target is not the CPU it is on.

Unlike kthread_bind() it leaves the affinity changeable from user space
and subject to cpusets, like that of any other task, with one difference
from a user's own affinity: the bind is not remembered as a user mask,
so a cpuset.cpus write on the thread's cgroup resets the thread to the
whole cpuset, as the CPU going offline does, where a user task's mask
would be re-applied. The scheduler moves the thread, or places it
elsewhere at its next wakeup. A change of the housekeeping CPUs resets
the affinity too, as it does for every kernel thread that is not bound
for good. A program that needs the binding re-applies it. The binding
sticks whenever it is applied: the generic kthread prologue applies the
default affinity of the thread's node when the thread first runs, which
is why bpf_kthread_create() runs every thread through that prologue
before it returns.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/kthread.c  | 48 +++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/verifier.c |  5 ++++-
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/kthread.c b/kernel/bpf/kthread.c
index d8f63461d756..444fff4bd102 100644
--- a/kernel/bpf/kthread.c
+++ b/kernel/bpf/kthread.c
@@ -4,6 +4,7 @@
 #include <linux/bpf.h>
 #include <linux/btf.h>
 #include <linux/btf_ids.h>
+#include <linux/cpumask.h>
 #include <linux/kthread.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/sched.h>
@@ -350,6 +351,52 @@ __bpf_kfunc int bpf_kthread_start(struct task_struct *task, u64 flags)
 	return 0;
 }
 
+/**
+ * bpf_kthread_bind - Restrict a BPF kthread to one CPU
+ * @task: a thread created by bpf_kthread_create()
+ * @cpu: the CPU the thread is to run on
+ * @flags: must be 0
+ *
+ * Sets the thread's affinity to @cpu. A thread that has not been started wakes
+ * on @cpu; one that has moves there at its next park or return, since its
+ * callback runs with migration disabled, and the call waits for that with
+ * migration enabled, so the caller may return on another CPU and a thread may
+ * bind itself. Unlike kthread_bind(), this leaves the affinity changeable from
+ * user space and subject to cpusets, like that of any other task. The binding
+ * is lost when @cpu goes offline or when the cpuset of the thread's cgroup
+ * changes its CPUs: the thread is moved, or placed elsewhere at its next
+ * wakeup, and its affinity reset to the cpuset's CPUs, as a user task's is
+ * after an offline. It is also lost when the housekeeping CPUs change, which
+ * resets the affinity of every kernel thread that is not bound for good. A
+ * program that needs the binding re-applies it.
+ *
+ * Return: 0 on success, -EINVAL if @flags is not 0 or @cpu is not a possible
+ * CPU or is offline, -ESRCH if @task is not a BPF kthread or has been stopped.
+ */
+__bpf_kfunc int bpf_kthread_bind(struct task_struct *task, u32 cpu, u64 flags)
+{
+	unsigned long irqflags;
+	bool found;
+	int ret;
+
+	if (flags)
+		return -EINVAL;
+	if (cpu >= nr_cpu_ids || !cpu_possible(cpu))
+		return -EINVAL;
+
+	raw_spin_lock_irqsave(&bpf_kthreads_lock, irqflags);
+	found = !!bpf_kthread_find(task);
+	raw_spin_unlock_irqrestore(&bpf_kthreads_lock, irqflags);
+	if (!found)
+		return -ESRCH;
+
+	/* A running thread moves at its next park: see the comment at the top. */
+	migrate_enable();
+	ret = set_cpus_allowed_ptr(task, cpumask_of(cpu));
+	migrate_disable();
+	return ret;
+}
+
 /**
  * bpf_kthread_stop - Stop a BPF kthread and wait for it to exit
  * @task: a thread created by bpf_kthread_create()
@@ -452,6 +499,7 @@ __bpf_kfunc_end_defs();
 BTF_KFUNCS_START(bpf_kthread_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_kthread_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE | KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kthread_start, KF_RCU)
+BTF_ID_FLAGS(func, bpf_kthread_bind, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kthread_stop, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_kthread_should_stop)
 BTF_KFUNCS_END(bpf_kthread_kfunc_ids)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ee409ac5be77..54fc44dd8fcc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14366,6 +14366,7 @@ enum special_kfunc_type {
 	KF_bpf_call_rcu_tasks_trace,
 	KF_bpf_kthread_create,
 	KF_bpf_kthread_stop,
+	KF_bpf_kthread_bind,
 	KF_bpf_arena_alloc_pages,
 	KF_bpf_arena_free_pages,
 	KF_bpf_session_is_return,
@@ -14461,6 +14462,7 @@ BTF_ID(func, bpf_call_rcu)
 BTF_ID(func, bpf_call_rcu_tasks_trace)
 BTF_ID(func, bpf_kthread_create)
 BTF_ID(func, bpf_kthread_stop)
+BTF_ID(func, bpf_kthread_bind)
 #if defined(CONFIG_MMU) && defined(CONFIG_64BIT)
 BTF_ID(func, bpf_arena_alloc_pages)
 BTF_ID(func, bpf_arena_free_pages)
@@ -14507,7 +14509,8 @@ static bool is_migrating_kfunc(u32 btf_id)
 {
 	return btf_id == special_kfunc_list[KF_bpf_task_park] ||
 	       btf_id == special_kfunc_list[KF_bpf_kthread_create] ||
-	       btf_id == special_kfunc_list[KF_bpf_kthread_stop];
+	       btf_id == special_kfunc_list[KF_bpf_kthread_stop] ||
+	       btf_id == special_kfunc_list[KF_bpf_kthread_bind];
 }
 
 static bool is_bpf_obj_new_kfunc(u32 func_id)
-- 
2.53.0

