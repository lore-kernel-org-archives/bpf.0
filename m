Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E2E3B8BD4;
	Tue,  2 Jun 2026 09:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780393193; cv=none; b=EIMFyiYKOQOw7yZfwCz7YrUUFtsouNGk4xZGtIGOjf7XP3z1fFW3H+M/AcPs8x6siJh9hlZ1Pl/3sWMQp0402RXIW8l+ZyUYIAtDQKPl3ESqMmwDD3QKUwP9F6M679qgVvalLiv07SpaMAJHQV4uFJxDP7FgcrrfAsbwxGpB2/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780393193; c=relaxed/simple;
	bh=edVLgVmiaHqnpzWvBhzvZRM1IogRfHDIKAyvwV/KKiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKgporPDi4N/gvbW/x0A6Kn7pm442wvbc2zzxZM3qJTCCbbf47oSZS87hCi8LKy6SqLi4t7S9vnFidK/x5s8BfbdyVhShNu4U36dKyEhJu81IQ7zTX/QQUZ2LksDmHdArZff6il9sK06MGvCB9RoZOUf1gnXm5XAE7JsO2iE95E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZRz7QOXg; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZRz7QOXg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version:
	Content-Type; bh=6j/kZExoSXaTa8NmNcl7v1yzwz0gy66CBKo4sZBt5/s=;
	b=ZRz7QOXgb40fmfJOGfBK4t59vtLk9QmVYXlSLjYELq37o4cOhBEBKfrjkgiLKf
	efKzQ8bHGbqeW6IZNc7JpAis81T9HxpnqD5BbFRieVZerCZlJOhIy8zA3lc+jlRc
	ErQtx7u6J3lphVCkEtm7ThOe6qb+ZTLEVZOAqiCVJq63k=
Received: from nec8-i7 (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCnYo6mpB5qDzU6AA--.7425S4;
	Tue, 02 Jun 2026 17:38:52 +0800 (CST)
From: chenyuan_fl@163.com
To: eddyz87@gmail.com,
	yonghong.song@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bot+bpf-ci@kernel.org,
	bpf@vger.kernel.org,
	chenyuan@kylinos.cn,
	chenyuan_fl@163.com,
	clm@meta.com,
	daniel@iogearbox.net,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org
Subject: [PATCH bpf v4 2/2] selftests/bpf: Add regression test for kfunc implicit arg injection
Date: Tue,  2 Jun 2026 17:38:33 +0800
Message-ID: <20260602093836.2632714-3-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602093836.2632714-1-chenyuan_fl@163.com>
References: <535798105630b24033f33f532051b93dc853bc0d.camel@gmail.com>
 <20260602093836.2632714-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCnYo6mpB5qDzU6AA--.7425S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3Wr43AF4xCrWkGF4kKFy8Zrb_yoW3Jr4rpa
	97Xr1jkrs7Ja13XF18JF42qF4rKrsIq34UGFWrG34rZrs7Xw1vqF1xKr4jq3s0krWrur1f
	Z340gFZ8uw48ZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR1rWrUUUUU=
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/xtbDAQ12NGoepK3efgAA3T

From: Yuan Chen <chenyuan@kylinos.cn>

The preceding patch fixes a silent fallthrough in check_kfunc_args()
that could cause the verifier to skip bpf_prog_aux injection for
KF_IMPLICIT_ARGS kfuncs when module BTF is inconsistent with vmlinux
(e.g. pahole 1.30 breaking distilled base dedup).

Add a positive regression test that verifies the injection path works
correctly under normal conditions (pahole 1.31+).  The test contaminates
BPF R2 with a magic value 0xDEAD via inline assembly before calling a
KF_IMPLICIT_ARGS kfunc associated with a struct_ops map.  The kfunc
validates that the kernel overwrote R2 with the real bpf_prog_aux
pointer rather than leaving the stale value.

The specific pahole 1.30 BTF mismatch scenario cannot be tested with
CI (which uses pahole 1.31), but this test ensures the injection
mechanism remains correct and does not regress.

Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
---
 .../bpf/prog_tests/test_struct_ops_assoc.c    |  6 +++
 .../selftests/bpf/progs/struct_ops_assoc.c    | 40 +++++++++++++++++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  9 +++++
 .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
 4 files changed, 56 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
index 461ded722351..192fd3166f38 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_struct_ops_assoc.c
@@ -35,6 +35,10 @@ static void test_st_ops_assoc(void)
 					    skel->maps.st_ops_map_b, NULL);
 	ASSERT_OK(err, "bpf_program__assoc_struct_ops(sys_enter_prog_b, st_ops_map_b)");
 
+	err = bpf_program__assoc_struct_ops(skel->progs.sys_enter_prog_test_aux_inject,
+					skel->maps.st_ops_map_a, NULL);
+	ASSERT_OK(err, "bpf_program__assoc_struct_ops(sys_enter_prog_test_aux_inject, st_ops_map_a)");
+
 	/* sys_enter_prog_a already associated with map_a */
 	err = bpf_program__assoc_struct_ops(skel->progs.sys_enter_prog_a,
 					    skel->maps.st_ops_map_b, NULL);
@@ -52,6 +56,7 @@ static void test_st_ops_assoc(void)
 
 	ASSERT_EQ(skel->bss->test_err_a, 0, "skel->bss->test_err_a");
 	ASSERT_EQ(skel->bss->test_err_b, 0, "skel->bss->test_err_b");
+	ASSERT_EQ(skel->bss->test_err_inject, 0, "skel->bss->test_err_inject");
 
 	/* run syscall_prog that calls .test_1 and checks return */
 	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.syscall_prog_a), NULL);
@@ -62,6 +67,7 @@ static void test_st_ops_assoc(void)
 
 	ASSERT_EQ(skel->bss->test_err_a, 0, "skel->bss->test_err_a");
 	ASSERT_EQ(skel->bss->test_err_b, 0, "skel->bss->test_err_b");
+	ASSERT_EQ(skel->bss->test_err_inject, 0, "skel->bss->test_err_inject");
 
 out:
 	struct_ops_assoc__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
index 68842e3f936b..ed0084453d56 100644
--- a/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
+++ b/tools/testing/selftests/bpf/progs/struct_ops_assoc.c
@@ -103,3 +103,43 @@ SEC(".struct_ops.link")
 struct bpf_testmod_multi_st_ops st_ops_map_b = {
 	.test_1 = (void *)test_1_b,
 };
+
+/* Test for aux injection with stale register contamination.
+ *
+ * This test verifies that the kernel correctly injects the implicit
+ * bpf_prog_aux pointer for kfuncs with KF_IMPLICIT_ARGS.  The program
+ * uses inline assembly to contaminate R2 with a known magic value
+ * before calling the kfunc:
+ *
+ *   asm volatile("r2 = %[magic]" :: [magic] "ri"(0xDEAD) : "r2");
+ *
+ * The kernel must inject env->prog->aux into R2, overriding the magic
+ * value.  The kfunc compares the received aux pointer against 0xDEAD:
+ *
+ *   - aux == 0xDEAD  → kernel failed to inject → kfunc returns -EINVAL
+ *   - aux != 0xDEAD  → kernel correctly injected → kfunc returns marker
+ *
+ * 0xDEAD is chosen with bit 31 clear to avoid BPF ALU64 sign-extension
+ * when used as a 32-bit immediate.
+ */
+int test_err_inject;
+
+SEC("tp_btf/sys_enter")
+int BPF_PROG(sys_enter_prog_test_aux_inject, struct pt_regs *regs, long id)
+{
+	struct task_struct *task;
+	int marker = 0x5A5A;
+	int ret;
+
+	task = bpf_get_current_task_btf();
+	if (!test_pid || task->pid != test_pid)
+		return 0;
+
+	asm volatile("r2 = %[magic]" :: [magic] "ri"(0xDEAD) : "r2");
+
+	ret = bpf_kfunc_aux_inject_stale(marker);
+	if (ret != marker)
+		test_err_inject++;
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index 0be918fe3021..8e979f0fa56d 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1315,6 +1315,7 @@ __bpf_kfunc int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args, st
 
 __bpf_kfunc int bpf_kfunc_implicit_arg(int a, struct bpf_prog_aux *aux);
 __bpf_kfunc int bpf_kfunc_implicit_arg_legacy(int a, int b, struct bpf_prog_aux *aux);
+__bpf_kfunc int bpf_kfunc_aux_inject_stale(int marker, struct bpf_prog_aux *aux);
 __bpf_kfunc int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, struct bpf_prog_aux *aux);
 
 /* hook targets */
@@ -1399,6 +1400,7 @@ BTF_ID_FLAGS(func, bpf_kfunc_multi_st_ops_test_1_assoc, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_implicit_arg_legacy_impl)
+BTF_ID_FLAGS(func, bpf_kfunc_aux_inject_stale, KF_IMPLICIT_ARGS)
 BTF_ID_FLAGS(func, bpf_kfunc_trigger_ctx_check)
 BTF_KFUNCS_END(bpf_testmod_check_kfunc_ids)
 
@@ -1916,6 +1918,13 @@ int bpf_kfunc_implicit_arg_legacy_impl(int a, int b, struct bpf_prog_aux *aux)
 	return bpf_kfunc_implicit_arg_legacy(a, b, aux);
 }
 
+int bpf_kfunc_aux_inject_stale(int marker, struct bpf_prog_aux *aux)
+{
+	if ((unsigned long)aux == 0xDEAD)
+		return -EINVAL;
+	return marker;
+}
+
 static int multi_st_ops_reg(void *kdata, struct bpf_link *link)
 {
 	struct bpf_testmod_multi_st_ops *st_ops =
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 2edc36b66de9..c18791e96b21 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -192,6 +192,7 @@ int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size) __ksym;
 #ifndef __KERNEL__
 extern int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __weak __ksym;
 extern int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args) __weak __ksym;
+extern int bpf_kfunc_aux_inject_stale(int marker) __weak __ksym;
 #endif
 
 struct prog_test_member *bpf_kfunc_get_default_trusted_ptr_test(void) __ksym;
-- 
2.54.0

