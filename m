Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BE72877FC
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773992538; cv=none; b=Xukq9OL7su+0rWMMWti+D0roLrskvxBzOS6M9tAOfEy5+6Q9Tha32Cwkhz1pQd5VwtNjFRC7IlKfoWfXuhOvLQFUxxTkyZ7A9n6OKErVjD6xLWPP8SUtZ4dfcCPuEG8+muUg5OE+By1eRbu6CovuuBw/rfRvp56jZNajq7XKpyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773992538; c=relaxed/simple;
	bh=OCqRcb4XIXUBLZLuV5fyBsphm3ok6wrlMcQJwxqrW3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FEe4oQ05Pfeg9Kzx9uwgFrB8iamEpU1hYEzWVNDiCFIINos9fGnwPTKwVJtiCR6GITEZcSFqkB/Ycg/ZzlIlOkLayt5GgA+eWuCIh75AYRlh3MANwaBUimx9DdfjBcjSRi/jtWY03oBEpPN+5Gps49nNDKcDRPEgdf7a8xsQF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k16f879M; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k16f879M"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64c9a398bc7so1456908d50.2
        for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 00:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773992534; x=1774597334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sr19Mde5+TgWGY0vDrOq8Vr1Quzf+LXI2RuLTiq2yIE=;
        b=k16f879MTykzcaWIAILHoCffQwV9YWpd+9GgSsavj4hEGwrAuwqjTBYydm/37k0oPy
         Vf7IuxljdItqaLFmH595Z1UnnhOp+RD5M81YKSdJgYe3MrorEvMWDxr63xZISu9TPUb/
         O9JZ9B+qmnZjUE+MwVS8MdL9tszR2a+6b639D83rcY5WHDGVRPpQ0Ot+PGfi9hllf31n
         0EuveYQaqMDrKhZC2cXuYYrxYJH5MBiDjbjK5LxwEtqK9P3y1RApM3kSTuJUaMVz66B+
         gL8fFEu7OxNvASO7BDXR4LUVPMwJQXEoJOCZQxfq/awuYtAikNXW5oKM9jctgvjan0hN
         5B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773992534; x=1774597334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sr19Mde5+TgWGY0vDrOq8Vr1Quzf+LXI2RuLTiq2yIE=;
        b=LGtqRCchLU7CJ+aDyluYCysnu5xufqdTz5jaMJbHw8GegiquM19loUhV2lmnV/n5P4
         EhlPewb4qd94/WzLFJBNZUS7GanAmXGbrPPqrEXdEKMOa8juFfbuKn4wRBfpfySeePUS
         U50qhLHaPnPWzqGgAt7U/NImRCH/Yx1lAAKD+cqA7az/rZeUwT9iQAwIo9gFuiOACw6e
         1gUFWOF2zBBAKsmiZoTN4Xm3M3RnJTZ2+hbOnn52vEWEqtkVtqycdKCywKyFUCDQGvUP
         jcTW32LY+hmusSch2Af9trLFuPSlcMv8if5NyXAC47Vm1LDpkE9wn51JRAJwEPdp/Zo5
         DSJg==
X-Gm-Message-State: AOJu0YyHxOSEXoSLNtPLeCy6w0W1ZnrBUMK5rVQ95Gjn2JuFbokSk+6j
	3f7KA6UKr2+npTT2RBlFnu4w5gchZXLZr0GMoFQwuywPT2kGBlscyOY9pBO7VmKOXM3ZjQ==
X-Gm-Gg: ATEYQzyCldqpWFcJ656LxIWx2n6pofnZnc+BfNSkzoNEi0yH/0ifozvxeWpA8KxF6O2
	dZUSDd8P1HDmbBnH3J41Adu6zaZrHoM4/uN5xNq7OKhtp/BuJ1VdcVF0XOW7N0Mus21GfuNvVuC
	Rm3ZS4y7JEo2SVhFXqMD4wqR24fYc0mZnn7GYToeGnjYkRfDxcUmZEpWJX0JKT3MfE1rSMFMqXP
	YqOCAzB40QsVITGzrlBkEqcK8j45D1zbw0gd9AIQwfBRpmZc55Cu/5zFESOZ9ceUF8xX6zQ+IVW
	tAhgLBDsqMidVOMtNNY5RwODaTIUaPtyYv3WLouSnglTsMPVLBFLitrb63/ISvViRklrp/oxJdY
	UBM+rX6CdtQnMyAtiIw2L04ofh4QY1bALA/6CCZXd8Auw8kHoUexfx6jFS/OWjI02TG0GoLrcl1
	wmtELkzW42p7viqYd96K7Mb4WEs2gpQBfhdP+ngh54temoteO8C6JLzwXwhiF+w8i445KjPmw70
	V+jO+cI3lwVAuIzGb9Lzqs=
X-Received: by 2002:a05:690e:e17:b0:64d:6600:64a1 with SMTP id 956f58d0204a3-64eaa69ea5amr1917577d50.16.1773992534373;
        Fri, 20 Mar 2026 00:42:14 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabef7822sm947443d50.21.2026.03.20.00.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 00:42:14 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	shuah@kernel.org,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	paul.chaignon@gmail.com,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH v3] selftests/bpf: move trampoline_count to dedicated bpf_testmod target
Date: Fri, 20 Mar 2026 15:41:50 +0800
Message-ID: <20260320074150.628094-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

trampoline_count fills all trampoline attachment slots for a single
target function and verifies that one extra attach fails with -E2BIG.

It currently targets bpf_modify_return_test, which is also used by
other selftests such as modify_return, get_func_ip_test, and
get_func_args_test. When such tests run in parallel, they can contend
for the same per-function trampoline quota and cause unexpected attach
failures. This issue is currently masked by harness serialization.

Move trampoline_count to a dedicated bpf_testmod target and register it
for fmod_ret attachment. Also route the final trigger through
trigger_module_test_read, so the execution path exercises the  same
dedicated target.

This keeps the test semantics unchanged while isolating it from other
selftests, so it no longer needs to run in serial mode. Remove the
TODO comment as well.

Tested:
  ./test_progs -t trampoline_count -vv
  ./test_progs -t modify_return -vv
  ./test_progs -t get_func_ip_test -vv
  ./test_progs -t get_func_args_test -vv
  ./test_progs -j$(nproc) -t trampoline_count -vv
  ./test_progs -j$(nproc) -t
    trampoline_count,modify_return,get_func_ip_test,get_func_args_test,\
kprobe_multi_test -vv
  20 runs of:
    ./test_progs -j$(nproc) -t
    trampoline_count,modify_return,get_func_ip_test,get_func_args_test,\
kprobe_multi_test

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
Link:https://lore.kernel.org/bpf/abicUI4YQ5KkQ_Ro@mail.gmail.com/T/#m6253b7fe96fe1a4df65b274c95aac786598a9857

v3:
- route the final trigger through trigger_module_test_read() and make
  bpf_testmod_test_read() call the dedicated trampoline_count target,
  as suggested by Jiri

v2:
- rewrite the subject to describe the change
- resend with the correct patch content

 .../bpf/prog_tests/trampoline_count.c         | 17 ++++----------
 .../bpf/progs/test_trampoline_count.c         |  6 ++---
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 23 +++++++++++++++++++
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
index 6cd7349d4a2b..dd2e5c84a4b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
+++ b/tools/testing/selftests/bpf/prog_tests/trampoline_count.c
@@ -30,16 +30,14 @@ static struct bpf_program *load_prog(char *file, char *name, struct inst *inst)
 	return prog;
 }
 
-/* TODO: use different target function to run in concurrent mode */
-void serial_test_trampoline_count(void)
+void test_trampoline_count(void)
 {
 	char *file = "test_trampoline_count.bpf.o";
 	char *const progs[] = { "fentry_test", "fmod_ret_test", "fexit_test" };
-	int bpf_max_tramp_links, err, i, prog_fd;
+	int bpf_max_tramp_links, i;
 	struct bpf_program *prog;
 	struct bpf_link *link;
 	struct inst *inst;
-	LIBBPF_OPTS(bpf_test_run_opts, opts);
 
 	bpf_max_tramp_links = get_bpf_max_tramp_links();
 	if (!ASSERT_GE(bpf_max_tramp_links, 1, "bpf_max_tramp_links"))
@@ -80,17 +78,10 @@ void serial_test_trampoline_count(void)
 		goto cleanup;
 
 	/* and finally execute the probe */
-	prog_fd = bpf_program__fd(prog);
-	if (!ASSERT_GE(prog_fd, 0, "bpf_program__fd"))
+	if (!ASSERT_OK(trigger_module_test_read(256),
+		       "trigger_module_test_read"))
 		goto cleanup;
 
-	err = bpf_prog_test_run_opts(prog_fd, &opts);
-	if (!ASSERT_OK(err, "bpf_prog_test_run_opts"))
-		goto cleanup;
-
-	ASSERT_EQ(opts.retval & 0xffff, 33, "bpf_modify_return_test.result");
-	ASSERT_EQ(opts.retval >> 16, 2, "bpf_modify_return_test.side_effect");
-
 cleanup:
 	for (; i >= 0; i--) {
 		bpf_link__destroy(inst[i].link);
diff --git a/tools/testing/selftests/bpf/progs/test_trampoline_count.c b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
index 7765720da7d5..14ad2f53cf33 100644
--- a/tools/testing/selftests/bpf/progs/test_trampoline_count.c
+++ b/tools/testing/selftests/bpf/progs/test_trampoline_count.c
@@ -3,19 +3,19 @@
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
-SEC("fentry/bpf_modify_return_test")
+SEC("fentry/bpf_testmod_trampoline_count_test")
 int BPF_PROG(fentry_test, int a, int *b)
 {
 	return 0;
 }
 
-SEC("fmod_ret/bpf_modify_return_test")
+SEC("fmod_ret/bpf_testmod_trampoline_count_test")
 int BPF_PROG(fmod_ret_test, int a, int *b, int ret)
 {
 	return 0;
 }
 
-SEC("fexit/bpf_modify_return_test")
+SEC("fexit/bpf_testmod_trampoline_count_test")
 int BPF_PROG(fexit_test, int a, int *b, int ret)
 {
 	return 0;
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
index e62c6b78657f..47583577e021 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -470,6 +470,8 @@ noinline void bpf_testmod_stacktrace_test_1(void)
 
 int bpf_testmod_fentry_ok;
 
+noinline int bpf_testmod_trampoline_count_test(int a, int *b);
+
 noinline ssize_t
 bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 		      const struct bin_attribute *bin_attr,
@@ -548,6 +550,10 @@ bpf_testmod_test_read(struct file *file, struct kobject *kobj,
 			21, 22, 23, 24, 25, 26) != 231)
 		goto out;
 
+	i = 2;
+	if (bpf_testmod_trampoline_count_test(1, &i) != 4 || i != 3)
+		goto out;
+
 	bpf_testmod_stacktrace_test_1();
 
 	bpf_testmod_fentry_ok = 1;
@@ -581,6 +587,12 @@ noinline int bpf_fentry_shadow_test(int a)
 }
 EXPORT_SYMBOL_GPL(bpf_fentry_shadow_test);
 
+noinline int bpf_testmod_trampoline_count_test(int a, int *b)
+{
+	*b += 1;
+	return a + *b;
+}
+
 __bpf_hook_end();
 
 static struct bin_attribute bin_attr_bpf_testmod_file __ro_after_init = {
@@ -1843,6 +1855,16 @@ struct bpf_struct_ops testmod_multi_st_ops = {
 
 extern int bpf_fentry_test1(int a);
 
+BTF_KFUNCS_START(bpf_testmod_trampoline_count_ids)
+BTF_ID_FLAGS(func, bpf_testmod_trampoline_count_test)
+BTF_KFUNCS_END(bpf_testmod_trampoline_count_ids)
+
+static const struct
+btf_kfunc_id_set bpf_testmod_trampoline_count_fmodret_set = {
+	.owner = THIS_MODULE,
+	.set = &bpf_testmod_trampoline_count_ids,
+};
+
 static int bpf_testmod_init(void)
 {
 	const struct btf_id_dtor_kfunc bpf_testmod_dtors[] = {
@@ -1859,6 +1881,7 @@ static int bpf_testmod_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_testmod_kfunc_set);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_testmod_kfunc_set);
+	ret = ret ?: register_btf_fmodret_id_set(&bpf_testmod_trampoline_count_fmodret_set);
 	ret = ret ?: register_bpf_struct_ops(&bpf_bpf_testmod_ops, bpf_testmod_ops);
 	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops2, bpf_testmod_ops2);
 	ret = ret ?: register_bpf_struct_ops(&bpf_testmod_ops3, bpf_testmod_ops3);

base-commit: 8a30aeb0d1b4e4aaf7f7bae72f20f2ae75385ccb
-- 
2.43.0

