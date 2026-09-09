Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFD33CBE84
	for <bpf@vger.kernel.org>; Wed,  9 Sep 2026 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788982693; cv=none; b=LzyJtj8JaQsU4SjGN9n7kfpjIJrNXEa2QU//0FCMnV6GT6kbMP8zhbmXmkMAROAg7VfjfgfntDNoaK3bDlrvA5XRQi1zQ/RE7K02ySYwsCPAyLB/h/0M85n2ocyVi8dtRotUioQEl98Sk4i3b1HBs1mYSmg3FikjeQs3TCaoeX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788982693; c=relaxed/simple;
	bh=bRYuGW2zUXXwDnDiHOCFcw1PiQe9SH8nYMOt5euiY8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gJp82274lxEMH2neNKIubOKif++TELC3SFv8ovFCZ784ifEX03u+WMhuWDnn8U0Bm228Fu6WO9Qk516esDpGHsuXRK8hx6omZgnpz1/f/f5+nKybTyzpLDS9jeFePTC51QiAVZeiqYsAdt68lnGVwVwHyNptK8kyIzITmhOJJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJqFnATu; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJqFnATu"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aae3147so1729704d50.1
        for <bpf@vger.kernel.org>; Wed, 09 Sep 2026 12:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788982690; x=1789587490; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Vzz2Syeb86gTKcafHfzV5LcScc4P7BtAEH15H3VzJw=;
        b=LJqFnATu1xNe+Z4kHbQEF3uYZXvNH+t/60SDggXQQeNEfoxBbuqFzbPhAML5XYKTOW
         SCMjh6akZPcTygcXrR9bhEFNOo3yZoa4k25ObELtmH0+M/uvRVxzTnIBDeh2PFuG54dy
         0a2gJMK2gC1BdxUEyLXHjOsMBw7XDCYoYMZUrmvDyy2AMCYgZ8vgoXwZsschOUQ6JvVk
         TUv36lRYih/3qz09tGDhqsWHJmm48vM89vIwdoqDOmFIyN+zfHDaObuBpwfsyY+taGUN
         XGD4533dV6PJWHGQGjTNqGFLDQjCYI0meevmZ7Sg2dLrJ8/gqROsWcKwrdsoKYNOydDo
         sfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788982690; x=1789587490;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Vzz2Syeb86gTKcafHfzV5LcScc4P7BtAEH15H3VzJw=;
        b=dpO5w84ZKMi6Blht3ulPZYS101hRCWNV7c97GCwUrKtOxKUqisqPxQ/MAfmH/xRTj4
         9AQyfbtyR85tveTRibtAyrXBdPuu61bby2KF18PvxZqlnG2kID+5d0NxoZeHTKF618n3
         gIPepzV4xSvVnmVh22ZXxNEgfdQBWrftb1Hac6/LYfJeCmOBuJHO2TMk6IVyK02cTa2I
         +0VWaOn7/Qbr2SxGREzZcpdjWqaGZa9WVOmQ5W91x0+YTxzhXSs4GSGEjWEeAetsu/iG
         gRdE0zMZvADCR/8r8HlrhXlGJNXV9GPEVWIvxVYGrlzTdu66o4TGymF/F/qS0jLZovia
         dCeA==
X-Forwarded-Encrypted: i=1; AKwUvBw0KFyOfP3Frol/RG0ZG/8+uonldx8Vy+k92JpbyGp/d+SBaAK9x8YFQ6ohGrq9prPKBHQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mJF8tH5g01WUVHzoKF0PzbnKcqVEke7eBOEl25xPr8dB55kkdx
	FN02vxBkwLbC0eg/Jik/av+2iUCJzbeW+NL7GYauwOMyo1RJVwQZufXs
X-Gm-Gg: AYBFou0dcfnHNwTp3KD0XoqlxoFwGnHHZMTgCrHVgeR7RWMAACd4+nSpQP8ZAltYNiY
	0pNUeuV7Mp2OMBT3rikVI9Z4jXoC8prhHqhYmRx7P/kijN68q08fjPszTATIU6mZkqzibFzSyTP
	1MUUmT56aMVSDOv1CwxDtJ8dOe6D/M9bzPV77s6vtGNKy2W4ZGjRtDv3zy7mIn1J1FPXHOlwmGP
	u4Bsqy/edTSDTm7m98/7lpV4rJtZ5PhL2phz98KwLNXNg5VUTBMf/ZXFji0BpLZyqKObm8//Arp
	GzKU6UpGWprbWLG4HOqQ9MFS2aD2befWDUlrxvyzCq92C4B/eIwMBbIu5Rhh0YrJ5mW5VojYnav
	uJL1SaAnmBE0T24RAPt/w+1A3YjER9gWkNCTFTdVK1cwJETkCjzfZ1b9aptNXvCj/611kAvOcfK
	rNFffG7T/imzZeeT8Vhxx08mkt/u5PTbRKD4sIxAxPHsNuuNEagTV/oN2WWgUUGr+B3o5zN5SOW
	P/OJuq2gY/iXe2Q4Wiyz3xze3QByzyT
X-Received: by 2002:a05:690e:4806:b0:66f:7728:b3ce with SMTP id 956f58d0204a3-671036ef4b8mr2163028d50.30.1788982690169;
        Wed, 09 Sep 2026 12:38:10 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:bae:bfc2:7e96:e5c8])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-871493155d3sm115277577b3.16.2026.09.09.12.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 12:38:09 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	matt@bobrowski.net,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: casey@schaufler-ca.com,
	gnoack@google.com,
	jack@suse.cz,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	jolsa@kernel.org,
	m@maowtm.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v3 09/15] selftests/bpf: Add tests for the LSM policy object kfuncs
Date: Wed,  9 Sep 2026 15:37:12 -0400
Message-ID: <20260909193719.518517-10-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909193719.518517-1-utilityemal77@gmail.com>
References: <20260909193719.518517-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Test the properties of the policy object interface that hold
independently of any LSM implementing the hooks.

The failure programs pin down the verifier-side contract: the kfuncs
are rejected in tracing programs, the fd kfunc in LSM programs, the
apply kfunc in syscall programs, on non-bprm LSM hooks and in
non-sleepable programs, leaked references fail verification, and a
kptr loaded outside an RCU read-side section cannot be acquired.

The syscall program checks the runtime contract of
bpf_lsm_policy_from_fd(): a bad fd, a fd that is no LSM's policy
object, and a nonzero value of the reserved flags all resolve to
NULL.

Exercising the kfuncs against an LSM actually providing policy
objects is left to that LSM's own tests.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    v2->v3:
        - No change.

 .../bpf/prog_tests/lsm_policy_kfuncs.c        |  54 ++++++
 .../selftests/bpf/progs/lsm_policy_kfuncs.c   |  52 ++++++
 .../bpf/progs/lsm_policy_kfuncs_failure.c     | 154 ++++++++++++++++++
 3 files changed, 260 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_policy_kfuncs.c
 create mode 100644 tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c

diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c b/tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c
new file mode 100644
index 000000000000..9f4ffb5f47be
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/lsm_policy_kfuncs.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright © 2026 Justin Suess <utilityemal77@gmail.com> */
+
+#include <test_progs.h>
+#include <stdlib.h>
+#include <unistd.h>
+
+#include "lsm_policy_kfuncs.skel.h"
+#include "lsm_policy_kfuncs_failure.skel.h"
+
+/*
+ * Runtime contract of bpf_lsm_policy_from_fd(), independent of any
+ * LSM implementing the policy object hooks: a bad fd, a fd that is no
+ * LSM's policy object, and a nonzero value of the reserved flags all
+ * resolve to NULL.
+ */
+static void test_from_fd_null(void)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct lsm_policy_kfuncs *skel;
+	char tmp_path[] = "/tmp/lsm_policy_kfuncs_XXXXXX";
+	int tmp_fd, err;
+
+	tmp_fd = mkstemp(tmp_path);
+	if (!ASSERT_GE(tmp_fd, 0, "mkstemp"))
+		return;
+
+	skel = lsm_policy_kfuncs__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		goto out_close;
+	skel->bss->plain_fd = tmp_fd;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.check_from_fd),
+				     &opts);
+	if (!ASSERT_OK(err, "check_from_fd_run") ||
+	    !ASSERT_OK(opts.retval, "check_from_fd_retval"))
+		goto out_destroy;
+
+	ASSERT_TRUE(skel->bss->got_null_for_bad_fd, "bad_fd_null");
+	ASSERT_TRUE(skel->bss->got_null_for_plain_fd, "plain_fd_null");
+	ASSERT_TRUE(skel->bss->got_null_for_bad_flags, "bad_flags_null");
+out_destroy:
+	lsm_policy_kfuncs__destroy(skel);
+out_close:
+	close(tmp_fd);
+	unlink(tmp_path);
+}
+
+void test_lsm_policy_kfuncs(void)
+{
+	if (test__start_subtest("from_fd_null"))
+		test_from_fd_null();
+	RUN_TESTS(lsm_policy_kfuncs_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs.c b/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs.c
new file mode 100644
index 000000000000..f084ccfcde91
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright © 2026 Justin Suess <utilityemal77@gmail.com> */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+
+char _license[] SEC("license") = "GPL";
+
+extern struct lsm_policy_object *
+bpf_lsm_policy_from_fd(int fd, u32 flags) __ksym;
+extern void bpf_lsm_policy_release(struct lsm_policy_object *object) __ksym;
+
+int plain_fd;
+bool got_null_for_bad_fd;
+bool got_null_for_plain_fd;
+bool got_null_for_bad_flags;
+
+/*
+ * Runs in the test runner's context through BPF_PROG_RUN, where
+ * @plain_fd is meaningful.
+ */
+SEC("syscall")
+int check_from_fd(void *ctx)
+{
+	struct lsm_policy_object *object;
+
+	/* A fd not open in this task's fd table must resolve to NULL. */
+	object = bpf_lsm_policy_from_fd(-1, 0);
+	if (!object)
+		got_null_for_bad_fd = true;
+	else
+		bpf_lsm_policy_release(object);
+
+	/*
+	 * A valid fd that is not any LSM's policy object must be
+	 * declined by every LSM and resolve to NULL.
+	 */
+	object = bpf_lsm_policy_from_fd(plain_fd, 0);
+	if (!object)
+		got_null_for_plain_fd = true;
+	else
+		bpf_lsm_policy_release(object);
+
+	/* The flags are reserved: any nonzero value must resolve to NULL. */
+	object = bpf_lsm_policy_from_fd(plain_fd, 1);
+	if (!object)
+		got_null_for_bad_flags = true;
+	else
+		bpf_lsm_policy_release(object);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c b/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c
new file mode 100644
index 000000000000..04080838aefd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/lsm_policy_kfuncs_failure.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright © 2026 Justin Suess <utilityemal77@gmail.com> */
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+extern struct lsm_policy_object *
+bpf_lsm_policy_acquire(struct lsm_policy_object *object) __ksym;
+extern int bpf_lsm_policy_apply_bprm(struct lsm_policy_object *object,
+				     struct linux_binprm *bprm,
+				     u32 flags) __ksym;
+extern struct lsm_policy_object *
+bpf_lsm_policy_from_fd(int fd, u32 flags) __ksym;
+extern void bpf_lsm_policy_release(struct lsm_policy_object *object) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+struct policy_slot {
+	struct lsm_policy_object __kptr *object;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct policy_slot);
+} policy_map SEC(".maps");
+
+/*
+ * The LSM policy kfuncs are limited to LSM and syscall programs by
+ * the BPF-side kfunc filter: a tracing program calling one must fail
+ * verification.
+ */
+SEC("tp_btf/task_newtask")
+__failure __msg("calling kernel function bpf_lsm_policy_from_fd is not allowed")
+int BPF_PROG(tracing_prog, struct task_struct *task, u64 clone_flags)
+{
+	struct lsm_policy_object *object;
+
+	object = bpf_lsm_policy_from_fd(-1, 0);
+	if (object)
+		bpf_lsm_policy_release(object);
+	return 0;
+}
+
+/*
+ * The fd kfunc is exclusive to syscall programs: it must be rejected
+ * in an LSM program, even on an allowed hook.
+ */
+SEC("lsm.s/bprm_creds_for_exec")
+__failure __msg("calling kernel function bpf_lsm_policy_from_fd is not allowed")
+int BPF_PROG(lsm_get, struct linux_binprm *bprm)
+{
+	struct lsm_policy_object *object;
+
+	object = bpf_lsm_policy_from_fd(-1, 0);
+	if (object)
+		bpf_lsm_policy_release(object);
+	return 0;
+}
+
+/*
+ * The enforcement kfunc is exclusive to the sleepable bprm LSM
+ * hooks: it must be rejected in a syscall program.
+ */
+SEC("syscall")
+__failure __msg("calling kernel function bpf_lsm_policy_apply_bprm is not allowed")
+int syscall_restrict(void *ctx)
+{
+	return bpf_lsm_policy_apply_bprm(NULL, NULL, 0);
+}
+
+/*
+ * Any LSM attach point other than the sleepable bprm hooks must be
+ * rejected for the enforcement kfunc.
+ */
+SEC("lsm.s/file_open")
+__failure __msg("calling kernel function bpf_lsm_policy_apply_bprm is not allowed")
+int BPF_PROG(wrong_hook, struct file *file)
+{
+	return bpf_lsm_policy_apply_bprm(NULL, NULL, 0);
+}
+
+/*
+ * The enforcement kfunc may sleep: a non-sleepable program on an
+ * allowed hook must be rejected.
+ */
+SEC("lsm/bprm_creds_for_exec")
+__failure
+__msg("program must be sleepable to call sleepable kfunc bpf_lsm_policy_apply_bprm")
+int BPF_PROG(nonsleepable_prog, struct linux_binprm *bprm)
+{
+	return bpf_lsm_policy_apply_bprm(NULL, bprm, 0);
+}
+
+/* An acquired policy object reference must be released before returning. */
+SEC("syscall")
+__failure __msg("Unreleased reference")
+int leak_policy(void *ctx)
+{
+	bpf_lsm_policy_from_fd(-1, 0);
+	return 0;
+}
+
+/*
+ * A kptr loaded outside an RCU read-side critical section is
+ * untrusted: the acquire kfunc must reject it.
+ */
+SEC("lsm.s/file_open")
+__failure __msg("must be a rcu pointer")
+int BPF_PROG(acquire_untrusted, struct file *file)
+{
+	struct lsm_policy_object *object;
+	struct policy_slot *slot;
+	int key = 0;
+
+	slot = bpf_map_lookup_elem(&policy_map, &key);
+	if (!slot)
+		return 0;
+
+	object = slot->object;
+	if (!object)
+		return 0;
+
+	object = bpf_lsm_policy_acquire(object);
+	if (object)
+		bpf_lsm_policy_release(object);
+	return 0;
+}
+
+/* A reference acquired from a shared policy object must be released too. */
+SEC("lsm.s/file_open")
+__failure __msg("Unreleased reference")
+int BPF_PROG(leak_shared_policy, struct file *file)
+{
+	struct lsm_policy_object *object;
+	struct policy_slot *slot;
+	int key = 0;
+
+	slot = bpf_map_lookup_elem(&policy_map, &key);
+	if (!slot)
+		return 0;
+
+	bpf_rcu_read_lock();
+	object = slot->object;
+	if (object)
+		object = bpf_lsm_policy_acquire(object);
+	bpf_rcu_read_unlock();
+	return 0;
+}
-- 
2.55.0

