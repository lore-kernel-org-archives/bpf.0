Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270506;
	b=Fg1wg3KaWxDfiHmntKUw2hI6u43Fg2kxQedOda0vY6w35dTYMThJrwEo1loIoqn3Iei0
	 Cwi4yTJMzgcEsCje/MODEyTiWeKGkgGAieGVleUCSmxCh3fezk2ITWgYx8OiWaXVNIdXx
	 MCZnTJgzot6lEvlnqw82iX25WE01suWVzhpCJuVFr9RPUzQ/aacee94nGC/2XD8JfaYAf
	 pDoZgVR665jV8BOHDQ9Bu3gvrX1EvkWi29oMG+PWTcAkBkbrOQLR2Y3m1zxPQikvNFNXf
	 zAAOuPQrMEV4DmeORNSKVEU0viOGeK1N9whWXZite+TK/oUKpgWkqRwzo4VWS4c7rqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=FkWCmSHYek+k2N3lqZiLvp+gqdq6t1ALFR2bb2QfZzQ=;
	b=wKsURqSk7mAOPCbs/VKVN3N3LumOwOxwDKPwQ+TszRNUp2BKsmZql0HIe+9R9BOpARcY
	 /pER8BAvvc1B7nSXo5ii64SJlzjCAAsYKd9UbNfEDz8XcJywlLshthgA146GE+G+dYBMz
	 5VqkSommw8IofKtSct9Tys+CU46k87w0IvzasAKF78pY3LFY2302EyvorIbk14QMBTcLC
	 dWGYs9gzQbySSxy/K2Klt645gt6fmUn5Svq5+TzgWsyhM4SCCxX6IKuLfiQ3Ar67ZZCeq
	 arcJ/AOmZ9WPOrqKD0BKUGarZlrNL6yP4pT/aUErub36rN79wxW4jGNn+rzIGVjpruw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iGhWP0UR;
	arc=none smtp.remote-ip=74.125.225.130
Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E69606A321
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 00:28:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89E69606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iGhWP0UR
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4a217e6274cso5044825e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 16:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270504; x=1794875304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FkWCmSHYek+k2N3lqZiLvp+gqdq6t1ALFR2bb2QfZzQ=;
        b=iGhWP0URI99LHCq+z+EmpcHxHE+4w921VOJMKHveszsmDKlg4nhGnJB2g/FHwcydLg
         O3fL2Xl0/FFj5pIpl1aQioathJiZL5GR1vd5jdGvPe6olQbca+m43C3MLOXkW0Ro/4YL
         FEKHQ44U03u8CuIJgcoKoagBij8Y0zl3g4yi1ofWckQU5DSTm0bWUuC+lrJDwnqVvb6h
         zIiO4vTSyvw61nb3tTIMGoeqhwe+MyeWeR36Wf7rRrRhSUK+rwr9WM7jZ8dS2KlLKzYD
         AZhJheGFGhV4i8yuDBFZUw0lBlP5M3eyyGR4NJ9L8BKlooS/t6g6NIpelyonMvipcEAe
         ppDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270504; x=1794875304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FkWCmSHYek+k2N3lqZiLvp+gqdq6t1ALFR2bb2QfZzQ=;
        b=WPE2xaMJB9CzPGDSCeH8mQ0Pwv4++e4UNpIw7aIvZ2+vqsx2YuEncv20PWr+cirzMS
         IZNWuArrHI3/dIeX1i8mLyTm8xI1awQwXRnQ2qLySVLZkjZ44QWZ38iPz8VWXng/3Nvu
         E6cJjrHOXu3prGZQaoAOIV+m9S7NrzuT1sdkyWVbGv8V/cQ8aJUriq4Jgf2UeeWUsTHK
         G6j2pREnEhZc9ETIePpWETPJJGFKi5DSJVcB4+xTwTifUr5jmVWL6+G9oQ99rlmu+T+4
         B937q84uHQOiFdnejoNZWkWhBJNNBL3jzmRoeIYC0jW2bdExfx+9QSc5m2rVfT4Xid6O
         o9Zg==
X-Gm-Message-State: APuU4Z9GLOeRvLil4SzfH2T3iqWHcumaHod9QSi4mStHrlvi4GJSMiL0
	mh+RlA239vhCHwma0w7FdPX8lL0f0mMoKPMi2NfJs0UbLCa28lQqXe84uI0uunfb
X-Gm-Gg: AYBFou3yCI40eCrNkT5rRmh4SiwHkxhgPCbA1DMMXAUUZJcST1k9ue0qKOCclDLgYuK
	UNER4QLIzEWLj8pDui/fibPIkPh7r/TLB95vhSMVQ9I/BQ7nM7kdSaNIENaqllubkYn81U9Lu9g
	0xfBy8Bd0GaUgshMS9NCBSSoxljfXKkHiY9NacqXO54iWgfrOyvR5ODGC7GITJpKOnYsxc/PxGc
	UpYXKSIbbYWS+6wBj65NDmq/sTJT7jAAUX8T2UI1gJWQ8VGGge3zMA7bsUuZPpSRYW6IUb+686/
	d6Igu9m96v48fnoyIzKz2fBb/J7ffc3WOIm2MYGIRFsSMX50iyjL9bPNBuV8xPgQBiJWEpbhhY8
	1T7+Byb2YkmaN7m4TUjPq4HUIRI7NuAmDUnwh1A1H9zEkuqdop62THjIgu1AfWR/kBxEGnPHy74
	nF/k4+6Q/l/TKiwLHdT7WZc3Lvco89Fnc6BEdlpjjwj4xy/74NghS274H9mY0h5h9CYlXlEZPpl
	68RiPaOBkl01XD7rgLGw+RMYIU7rhNanGGWWCTAPL9R2/7vtitT6DSY3JY/pI51KJzNOtFQoa08
	MRs1CPcdAQfINsd7Xjl4RkzeFj6cpkOO1+iD9HO1O7f3dtdmcR7necmn6CqOw5z9iytVOiRvclc
	k3M9H7ZqSYHT6wTNCRUroQTZSOBrYbaXzic9TNjzYzh5ygjQJrTKzRN0FrqZdEF5LAAZa
X-Received: by 2002:a05:600d:82d3:b0:4a3:59c2:b41e with SMTP id 5b1f17b1804b1-4ba023064f4mr14196825e9.4.1794270503819;
        Mon, 09 Nov 2026 16:28:23 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02387ad9sm26377255e9.5.2026.11.09.16.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:28:22 -0800 (PST)
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
Subject: [PATCH bpf-next v1 20/20] selftests/bpf: Test bpf_kthread_attach_cgroup()
Date: Tue, 10 Nov 2026 01:27:42 +0100
Message-ID: <ddfc2cdff980669823aa44380dee237e36b648cf.1794269507.git.memxor@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10346; i=memxor@gmail.com; h=from:subject:message-id; bh=TaBBkpRJ5mOfFgUZ84DbwzhDRAzyydaHgaW2TzyReBo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetTopds7FV/WZ0p/2Qlf5XqJHGwnWpacTNu+kEhgW0cz 51ObQ3vKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQWPWD4Z8j8Vyv/f9ufpsk3 PYq3/5qcufUeD8vE6LQJQTN/58Vt+snIcGGf66fKeIX3J9feOe62/VH66qXCnHffn5tZqllz2n4 qFwcA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Move a thread into a cgroup before its start and into another while it
runs, and check through bpf_get_current_cgroup_id() in its body that
each move took effect by its next iteration. The thread populates the
cgroup it is in, which cgroup.events reports, and the cgroup it left is
empty again; after the stop the second cgroup empties too, once the
thread's exit has left it, which the test waits for since kthread_stop()
returns before cgroup_exit() runs. The test's work directory has
controllers enabled for its children, so a move into it is refused with
-EBUSY, the constraint cgroup.procs enforces; the check needs a domain
controller enabled there, since threaded controllers alone leave the
parent able to hold processes, and is skipped otherwise. Nonzero flags
and a task that is no BPF kthread are refused as by the other control
kfuncs.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../testing/selftests/bpf/bpf_experimental.h  |  2 +
 .../selftests/bpf/prog_tests/bpf_kthread.c    | 88 +++++++++++++++++++
 .../testing/selftests/bpf/progs/bpf_kthread.c | 43 ++++++++-
 3 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testing/selftests/bpf/bpf_experimental.h
index e41d326a0017..49d7a45f9707 100644
--- a/tools/testing/selftests/bpf/bpf_experimental.h
+++ b/tools/testing/selftests/bpf/bpf_experimental.h
@@ -358,6 +358,8 @@ extern struct task_struct *bpf_kthread_create(int (callback_fn)(__u64 arg), __u6
 					      __u64 flags) __weak __ksym;
 extern int bpf_kthread_start(struct task_struct *task, __u64 flags) __weak __ksym;
 extern int bpf_kthread_bind(struct task_struct *task, __u32 cpu, __u64 flags) __weak __ksym;
+extern int bpf_kthread_attach_cgroup(struct task_struct *task, struct cgroup *cgrp,
+				     __u64 flags) __weak __ksym;
 extern int bpf_kthread_stop(struct task_struct *task, __u64 flags) __weak __ksym;
 extern bool bpf_kthread_should_stop(void) __weak __ksym;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_kthread.c b/tools/testing/selftests/bpf/prog_tests/bpf_kthread.c
index e32a975c7a0d..fabd6b9e5242 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_kthread.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_kthread.c
@@ -3,6 +3,7 @@
 
 #include <test_progs.h>
 #include <sched.h>
+#include "cgroup_helpers.h"
 #include "bpf_kthread.skel.h"
 #include "verifier_bpf_kthread.skel.h"
 
@@ -13,6 +14,7 @@ struct kthread_args {
 	__u32 body;
 	__u32 bind;
 	__u32 cpu;
+	__u64 cgroup_id;
 };
 
 enum body {
@@ -67,6 +69,16 @@ static int bind_thread(struct bpf_kthread *skel, __u32 idx, __u32 cpu)
 	return retval;
 }
 
+static int attach_cgroup(struct bpf_kthread *skel, __u32 idx, __u64 cgroup_id)
+{
+	struct kthread_args args = { .idx = idx, .cgroup_id = cgroup_id };
+	int retval;
+
+	if (!ASSERT_OK(run_prog(skel->progs.attach_cgroup, &args, &retval), "attach_cgroup"))
+		return -EFAULT;
+	return retval;
+}
+
 /* Returns what the program returned, which for stop_thread is what the stop returned. */
 static int control_thread(struct bpf_program *prog, __u32 idx)
 {
@@ -383,6 +395,7 @@ static void test_misuse(void)
 		ASSERT_EQ(retval, 0, "foreign ret");
 		ASSERT_EQ(skel->bss->foreign_start_ret, -ESRCH, "foreign start ret");
 		ASSERT_EQ(skel->bss->foreign_stop_ret, -ESRCH, "foreign stop ret");
+		ASSERT_EQ(skel->bss->foreign_attach_ret, -ESRCH, "foreign attach ret");
 	}
 	if (ASSERT_OK(run_prog(skel->progs.misuse, NULL, &retval), "misuse"))
 		ASSERT_EQ(retval, 0, "misuse ret");
@@ -520,6 +533,79 @@ static void test_self_bind(void)
 	bpf_kthread__destroy(skel);
 }
 
+/* Whether cgroup.events of the cgroup reports it populated, polling until it says @populated. */
+static bool wait_populated(const char *path, bool populated)
+{
+	const char *want = populated ? "populated 1" : "populated 0";
+	char buf[256];
+	int i;
+
+	for (i = 0; i < 2000; i++) {
+		if (!read_cgroup_file(path, "cgroup.events", buf, sizeof(buf)) && strstr(buf, want))
+			return true;
+		usleep(1000);
+	}
+	return false;
+}
+
+/*
+ * A thread moved into a cgroup, parked or running, runs there from its next
+ * iteration on and populates the cgroup until it exits. The test's work
+ * directory has controllers enabled for its children, so it cannot take the
+ * thread itself.
+ */
+static void test_attach_cgroup(void)
+{
+	struct bpf_kthread *skel = NULL;
+	int fd1 = -1, fd2 = -1;
+	char subtree[256] = {};
+	__u64 cg1, cg2;
+	__u32 loops;
+
+	if (!ASSERT_OK(setup_cgroup_environment(), "setup_cgroup_environment"))
+		return;
+	fd1 = create_and_get_cgroup("/kthread1");
+	fd2 = create_and_get_cgroup("/kthread2");
+	if (!ASSERT_GE(fd1, 0, "create kthread1") || !ASSERT_GE(fd2, 0, "create kthread2"))
+		goto out;
+	cg1 = get_cgroup_id("/kthread1");
+	cg2 = get_cgroup_id("/kthread2");
+	skel = bpf_kthread__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		goto out;
+	if (create_thread(skel, 0, false, BODY_WORKER))
+		goto out;
+	/* Only a domain controller in the children makes the parent refuse processes. */
+	if (!read_cgroup_file("", "cgroup.subtree_control", subtree, sizeof(subtree)) &&
+	    (strstr(subtree, "memory") || strstr(subtree, "io")))
+		ASSERT_EQ(attach_cgroup(skel, 0, get_cgroup_id("")), -EBUSY,
+			  "attach to inner cgroup");
+	ASSERT_EQ(attach_cgroup(skel, 0, cg1), 0, "attach parked ret");
+	ASSERT_EQ(start_thread(skel, 0), 0, "start ret");
+	if (!ASSERT_TRUE(wait_past(&skel->bss->loops[0], 0), "ran"))
+		goto out;
+	ASSERT_EQ(skel->bss->cgids[0], cg1, "cgroup after start");
+	ASSERT_TRUE(wait_populated("/kthread1", true), "kthread1 populated");
+
+	ASSERT_EQ(attach_cgroup(skel, 0, cg2), 0, "attach running ret");
+	loops = skel->bss->loops[0];
+	ASSERT_GE(wake_thread(skel, 0), 0, "wake ret");
+	if (ASSERT_TRUE(wait_past(&skel->bss->loops[0], loops), "looped"))
+		ASSERT_EQ(skel->bss->cgids[0], cg2, "cgroup after move");
+	ASSERT_TRUE(wait_populated("/kthread1", false), "kthread1 empty");
+	ASSERT_TRUE(wait_populated("/kthread2", true), "kthread2 populated");
+
+	ASSERT_EQ(stop_thread(skel, 0), 0, "stop ret");
+	ASSERT_TRUE(wait_populated("/kthread2", false), "kthread2 empty");
+out:
+	bpf_kthread__destroy(skel);
+	if (fd1 >= 0)
+		close(fd1);
+	if (fd2 >= 0)
+		close(fd2);
+	cleanup_cgroup_environment();
+}
+
 void test_bpf_kthread(void)
 {
 	RUN_TESTS(verifier_bpf_kthread);
@@ -550,4 +636,6 @@ void test_bpf_kthread(void)
 		test_bind();
 	if (test__start_subtest("self_bind"))
 		test_self_bind();
+	if (test__start_subtest("attach_cgroup"))
+		test_attach_cgroup();
 }
diff --git a/tools/testing/selftests/bpf/progs/bpf_kthread.c b/tools/testing/selftests/bpf/progs/bpf_kthread.c
index 99ec48339158..3eac7366514f 100644
--- a/tools/testing/selftests/bpf/progs/bpf_kthread.c
+++ b/tools/testing/selftests/bpf/progs/bpf_kthread.c
@@ -30,6 +30,7 @@ struct kthread_args {
 	__u32 body;		/* create: which callback, see enum body */
 	__u32 bind;		/* create: bind the thread to cpu before starting it */
 	__u32 cpu;		/* create and bind: the CPU */
+	__u64 cgroup_id;	/* attach_cgroup: the cgroup to move the thread into */
 };
 
 enum body {
@@ -46,11 +47,13 @@ __u32 tids[NR_THREADS];		/* the thread's PID, per slot */
 char comms[NR_THREADS][16];	/* the comm the thread read for itself, per slot */
 __u32 cpus[NR_THREADS];		/* the CPU the thread last ran on, per slot */
 __u32 loops[NR_THREADS];	/* iterations of the body's loop, per slot */
+__u64 cgids[NR_THREADS];	/* the cgroup the thread last ran in, per slot */
 __u32 exit_now[NR_THREADS];	/* set by the test: the callback returns idx + 1 */
 int self_stop_ret;		/* bpf_kthread_stop() on the calling thread */
 int spawn_ret;			/* bpf_kthread_start() by the spawner */
 int foreign_start_ret;		/* bpf_kthread_start() on a task that is no BPF kthread */
 int foreign_stop_ret;		/* bpf_kthread_stop() on the same */
+int foreign_attach_ret;		/* bpf_kthread_attach_cgroup() on the same */
 __u32 ring_size;		/* set by the test: threads in the ring */
 __u32 ring_ready;		/* ring threads about to stop their successor */
 int ring_stop_ret[NR_THREADS];	/* what stopping the successor returned, per slot */
@@ -82,6 +85,7 @@ static int worker(__u64 arg)
 
 	bpf_repeat(LOOP_BOUND) {
 		cpus[idx] = bpf_get_smp_processor_id();
+		cgids[idx] = bpf_get_current_cgroup_id();
 		__sync_fetch_and_add(&loops[idx], 1);
 		if (bpf_kthread_should_stop())
 			return 0;
@@ -311,6 +315,40 @@ int bind_thread(struct kthread_args *args)
 	return ret;
 }
 
+/* Move the thread of slot idx into the cgroup args->cgroup_id, running or not. */
+SEC("syscall")
+int attach_cgroup(struct kthread_args *args)
+{
+	struct task_struct *task;
+	struct cgroup *cgrp;
+	int ret = -ENOENT;
+
+	task = take(args->idx);
+	if (!task)
+		return -ESRCH;
+	cgrp = bpf_cgroup_from_id(args->cgroup_id);
+	if (cgrp) {
+		ret = bpf_kthread_attach_cgroup(task, cgrp, 0);
+		bpf_cgroup_release(cgrp);
+	}
+	publish(args->idx, task);
+	return ret;
+}
+
+/* bpf_kthread_attach_cgroup() on the root cgroup with @flags. */
+static int attach_root_cgroup(struct task_struct *task, __u64 flags)
+{
+	struct cgroup *cgrp;
+	int ret;
+
+	cgrp = bpf_cgroup_from_id(1);
+	if (!cgrp)
+		return -ENOENT;
+	ret = bpf_kthread_attach_cgroup(task, cgrp, flags);
+	bpf_cgroup_release(cgrp);
+	return ret;
+}
+
 /* Stop the thread of slot idx and empty the slot; returns what the stop returned. */
 SEC("syscall")
 int stop_thread(struct kthread_args *args)
@@ -337,6 +375,7 @@ int control_foreign_task(void *ctx)
 		return -ESRCH;
 	foreign_start_ret = bpf_kthread_start(task, 0);
 	foreign_stop_ret = bpf_kthread_stop(task, 0);
+	foreign_attach_ret = attach_root_cgroup(task, 0);
 	bpf_task_release(task);
 	return 0;
 }
@@ -366,8 +405,10 @@ int misuse(void *ctx)
 		ret = 4;
 	else if (bpf_kthread_stop(task, 1) != -EINVAL)
 		ret = 5;
+	else if (attach_root_cgroup(task, 1) != -EINVAL)
+		ret = 6;
 	else
-		ret = bpf_kthread_stop(task, 0) == -EINTR ? 0 : 6;
+		ret = bpf_kthread_stop(task, 0) == -EINTR ? 0 : 7;
 	bpf_task_release(task);
 	return ret;
 }
-- 
2.53.0

