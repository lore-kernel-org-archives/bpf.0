Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625950;
	b=RvltJnUQhjK/14tOCosBWMzEWD9k7lpFleq7RJzX1n9JXpJMQnu+07eHhqNG/WpJpyQR
	 RGSiUkb5YE+se0yfgsXKW5wYOWzW6TElekJLLegf7YZ1OttbQpHDg9trekhwgyuf1O9pZ
	 pemSB9BT48y+GTf2bdM+Pq47f0ixt4C8/TnMocTNBDl1I7rIFfLNHcN3eR4efhfsAu9fB
	 /Oj7x1kYkw6EWZ1Wa0iTLWQk514luyzun62yGFpFcuJutNQQxIM9n5tuMH02gO8hDpBfU
	 sH9PNDprEZU+HD5f/b1QOW4287alLNOvEBID9FirZh0wD5rJnV9eqG0OSfb69WqXOEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625950;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=q1NiGzQ/XX2GvperFsG+EENkpGB4WXQw4U/XujQMt/0=;
	b=j0OJAuUmRX2bz1tmXuBbNh1OJykdaBlS1wzzWv6+2PYp7CBU3nPwxxL+J0ZgbpNW3cOq
	 os/T8pOsIF2ggwpbZtcpiQylGca5J5r9KYEP1AjzfPQsB1JkFUIx9HnOQVqnzj2uRXrXo
	 SDKlupskrpmPx+iDprJ6LSmENPU5JfADHLrwgsza19idMaUKPA5/6rBbXBsMnh4QTNTf2
	 9HyVUZZ7g1Eb07qUEuAGygiexnW0S6lIezbNJuaJ3ez8hj6InjTDsOwJLIImOVhOLfIEt
	 1+XwBLKjXtMCsLwvy/3KdLI2C6poB2JCJUNIcOSb8SJ0qTfw4mRHt9o+FZvZcEumVbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZnD5/FrI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D73606A31E
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnD5/FrI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320131F000D3;
	Wed, 25 Nov 2026 16:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795625949;
	bh=q1NiGzQ/XX2GvperFsG+EENkpGB4WXQw4U/XujQMt/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZnD5/FrIX0yeFeRLQ6hwH6W0+wOwzGYule9WVx6Kazivez1i+tmAsvCMcE3E3uyaw
	 yRY6wRhZo5rK9AKMRXD3UXVZ2Hx2qThBVPN3amojs53yljI+yj9IHwKCDhctSVpCd2
	 wsAgybt1i42Ak/kLlV/8xOaCQvtDar8ZRoebBayamYJRjy/Uk7MyEVGTC8ebhqHaRo
	 kQmOTPjm7h5xYk+MNgWLM3/ZiOQmxPJMfHU7V1QSiGxDPY1NNpPOtu9HoUH8evBugR
	 Nfp7vZnMT2/5iwXgFd+6PxP3ehXwJbLj6r2rtHb6hSUccTFfnsCuoUkS6JfrI+zrjb
	 jO5md0LPLlUpQ==
From: Alan Maguire <almagui@kernel.org>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: andrey.grodzovsky@crowdstrike.com,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	mason@kernel.org,
	bpf@vger.kernel.org,
	Alan Maguire <almagui@kernel.org>
Subject: [PATCH v2 bpf-next 4/5] selftests/bpf: Test CO-RE relocation of tracing program arguments
Date: Wed, 25 Nov 2026 16:58:44 +0000
Message-ID: <20261125165845.45806-5-almagui@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125165845.45806-1-almagui@kernel.org>
References: <20261125165845.45806-1-almagui@kernel.org>
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

Test struct bpf_func_args___<flavor> with both libbpf and light
skeletons, i.e. with relocations applied by libbpf and by the kernel,
across program types:

- fentry: arguments of bpf_fentry_test3() in a different order, an
  argument that doesn't exist, __ret, which isn't in the context of
  fentry programs, a field variant, reading another argument of the
  same size when one doesn't exist, and a u64 argument read as a __u32,
  as loads of unsigned integers are resized;
- fexit: an argument and __ret, through a typedef'd anonymous struct;
- fmod_ret: arguments of bpf_modify_return_test2() in a different order,
  __ret, and an int argument declared as a long, read with
  BPF_CORE_READ_BITFIELD(), as plain loads of signed integers of another
  size are poisoned;
- tp_btf: an argument of sys_enter, at its offset without void *__data,
  and bpf_core_type_matches() telling apart a matching and a mismatching
  pointer argument type, with the matching struct's flavor starting with
  and containing triple underscores, and a struct variant, reading an
  argument through whichever of two structs matches;
- LSM: dereferencing the struct file * argument of file_open, and __ret.

In the variants, the access that doesn't apply is poisoned, in a branch
the verifier finds dead.
For the field variant, clang turns the two loads into one, from the
context plus an offset set in each branch.

As test_progs runs tests in parallel, the programs only record what
they see in the test's process. fmod_ret uses bpf_modify_return_test2()
rather than bpf_modify_return_test(), as another test's fmod_ret program
returns non-zero for every process there, which skips the following
fmod_ret programs.

Also check that an unguarded access to a missing argument fails to load
(with libbpf only, as light skeletons can't enable a program that is not
loaded by default).

And check, with libbpf, that preparing an object with a manually loaded
program whose attach target doesn't exist succeeds, while loading that
program fails, and that the type, attach type and attach target of a
program using the struct can't be changed once the object is prepared.

bpf_core_type_matches() compares the names of integer types too, and
clang's "long" is "long int" in kernel BTF, so the structs checked with
it only have pointer members.

Assisted-by: LLM
Signed-off-by: Alan Maguire <almagui@kernel.org>
---
 tools/testing/selftests/bpf/Makefile.skel     |   2 +-
 .../selftests/bpf/prog_tests/func_args_core.c | 129 +++++++++++++
 .../selftests/bpf/progs/func_args_core.c      | 178 ++++++++++++++++++
 3 files changed, 308 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/func_args_core.c
 create mode 100644 tools/testing/selftests/bpf/progs/func_args_core.c

diff --git a/tools/testing/selftests/bpf/Makefile.skel b/tools/testing/selftests/bpf/Makefile.skel
index 45e4ce5dca4d..69808d962fc7 100644
--- a/tools/testing/selftests/bpf/Makefile.skel
+++ b/tools/testing/selftests/bpf/Makefile.skel
@@ -40,7 +40,7 @@ LSKELS_SIGNED := fentry_test.c fexit_test.c atomics.c
 
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA := test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.c \
-	kfunc_call_test_subprog.c test_global_percpu_data.c
+	kfunc_call_test_subprog.c test_global_percpu_data.c func_args_core.c
 SKEL_BLACKLIST += $(LSKELS) $(LSKELS_SIGNED)
 
 test_static_linked.skel.h-deps := test_static_linked1.bpf.o test_static_linked2.bpf.o
diff --git a/tools/testing/selftests/bpf/prog_tests/func_args_core.c b/tools/testing/selftests/bpf/prog_tests/func_args_core.c
new file mode 100644
index 000000000000..60caf2756a75
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/func_args_core.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "func_args_core.skel.h"
+#include "func_args_core.lskel.h"
+
+/*
+ * Run the programs of a func_args_core skeleton (libbpf or light) and check
+ * what they saw through struct bpf_func_args___xyz.
+ */
+static void check_func_args(struct func_args_core__bss *bss, int fentry_fd, int fmod_ret_fd)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int fd;
+
+	bss->pid = getpid();
+	bss->tp_nr = __NR_getppid;
+	/* calls bpf_fentry_test3(4, 5, 6) */
+	ASSERT_OK(bpf_prog_test_run_opts(fentry_fd, &topts), "fentry_run");
+	/* calls bpf_modify_return_test2(1, &b, 3, 4, 5, 6, 7) */
+	ASSERT_OK(bpf_prog_test_run_opts(fmod_ret_fd, &topts), "fmod_ret_run");
+	syscall(__NR_getppid);
+	fd = open("/dev/null", O_RDONLY);
+	if (fd >= 0)
+		close(fd);
+
+	ASSERT_EQ(bss->fentry_a, 4, "fentry_a");
+	ASSERT_EQ(bss->fentry_b, 5, "fentry_b");
+	ASSERT_EQ(bss->fentry_c, 6, "fentry_c");
+	ASSERT_EQ(bss->fentry_nope, 0, "fentry_nope_exists");
+	ASSERT_EQ(bss->fentry_ret, 0, "fentry_ret_exists");
+	ASSERT_EQ(bss->fentry_alt, 6, "fentry_field_variant");
+	ASSERT_EQ(bss->fentry_c32, 6, "fentry_unsigned_resized");
+	ASSERT_EQ(bss->fexit_c, 6, "fexit_c");
+	ASSERT_EQ(bss->fexit_ret, 15, "fexit_ret");
+	ASSERT_EQ(bss->fmod_ret_c, 3, "fmod_ret_c");
+	ASSERT_EQ(bss->fmod_ret_d, 4, "fmod_ret_signed_resized");
+	ASSERT_EQ(bss->fmod_ret_f, 6, "fmod_ret_f");
+	ASSERT_EQ(bss->fmod_ret_g, 7, "fmod_ret_g");
+	ASSERT_EQ(bss->fmod_ret_ret, 1, "fmod_ret_ret_exists");
+	ASSERT_GE(bss->tp_hits, 1, "tp_btf_id");
+	ASSERT_EQ(bss->tp_match, 1, "tp_btf_type_matches");
+	ASSERT_EQ(bss->tp_mismatch, 0, "tp_btf_type_mismatch");
+	ASSERT_EQ(bss->tp_variant, 1, "tp_btf_struct_variant");
+	ASSERT_EQ(bss->lsm_inode, 1, "lsm_file");
+	ASSERT_EQ(bss->lsm_ret, 1, "lsm_ret");
+}
+
+static void test_libbpf(void)
+{
+	struct func_args_core *skel;
+
+	skel = func_args_core__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	if (ASSERT_OK(func_args_core__attach(skel), "attach"))
+		check_func_args(skel->bss, bpf_program__fd(skel->progs.fentry),
+				bpf_program__fd(skel->progs.fmod_ret));
+	func_args_core__destroy(skel);
+}
+
+static void test_lskel(void)
+{
+	struct func_args_core_lskel *skel;
+
+	skel = func_args_core_lskel__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+	/* not __attach(), which would also attach the unloaded "missing" prog */
+	if (!ASSERT_GT(func_args_core_lskel__fentry__attach(skel), 0, "attach_fentry") ||
+	    !ASSERT_GT(func_args_core_lskel__fexit__attach(skel), 0, "attach_fexit") ||
+	    !ASSERT_GT(func_args_core_lskel__fmod_ret__attach(skel), 0, "attach_fmod_ret") ||
+	    !ASSERT_GT(func_args_core_lskel__tp_btf__attach(skel), 0, "attach_tp_btf") ||
+	    !ASSERT_GT(func_args_core_lskel__lsm__attach(skel), 0, "attach_lsm"))
+		goto out;
+	/* the same .bss as for the libbpf skeleton, under another name */
+	check_func_args((struct func_args_core__bss *)skel->bss,
+			skel->progs.fentry.prog_fd, skel->progs.fmod_ret.prog_fd);
+out:
+	func_args_core_lskel__destroy(skel);
+}
+
+static void test_missing(void)
+{
+	struct func_args_core *skel;
+
+	skel = func_args_core__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	bpf_program__set_autoload(skel->progs.missing, true);
+	ASSERT_ERR(func_args_core__load(skel), "load");
+	func_args_core__destroy(skel);
+}
+
+static void test_prepare(void)
+{
+	struct bpf_program *fentry;
+	struct func_args_core *skel;
+
+	skel = func_args_core__open();
+	if (!ASSERT_OK_PTR(skel, "open"))
+		return;
+	fentry = skel->progs.fentry;
+	bpf_program__set_load_strategy(skel->progs.no_target, BPF_PROG_LOAD_STRATEGY_MANUAL);
+	if (!ASSERT_OK(bpf_object__prepare(skel->obj), "prepare"))
+		goto out;
+	ASSERT_ERR(bpf_program__load(skel->progs.no_target), "load_no_target");
+
+	/* the relocations depend on the attach target, which is now fixed */
+	ASSERT_EQ(bpf_program__set_attach_target(fentry, 0, "bpf_fentry_test2"), -EBUSY,
+		  "set_attach_target");
+	ASSERT_EQ(bpf_program__set_expected_attach_type(fentry, BPF_TRACE_FEXIT), -EBUSY,
+		  "set_expected_attach_type");
+	ASSERT_EQ(bpf_program__set_type(fentry, BPF_PROG_TYPE_LSM), -EBUSY, "set_type");
+	ASSERT_OK(func_args_core__load(skel), "load");
+out:
+	func_args_core__destroy(skel);
+}
+
+void test_func_args_core(void)
+{
+	if (test__start_subtest("libbpf"))
+		test_libbpf();
+	if (test__start_subtest("lskel"))
+		test_lskel();
+	if (test__start_subtest("missing"))
+		test_missing();
+	if (test__start_subtest("prepare"))
+		test_prepare();
+}
diff --git a/tools/testing/selftests/bpf/progs/func_args_core.c b/tools/testing/selftests/bpf/progs/func_args_core.c
new file mode 100644
index 000000000000..1281d0f47103
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/func_args_core.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_core_read.h>
+
+char _license[] SEC("license") = "GPL";
+
+int pid;
+__u64 fentry_a, fentry_b, fentry_c, fentry_nope, fentry_ret, fentry_alt, fentry_c32;
+__u64 fexit_c, fexit_ret;
+__u64 fmod_ret_c, fmod_ret_d, fmod_ret_f, fmod_ret_g, fmod_ret_ret;
+long tp_nr;
+__u64 tp_hits, tp_match, tp_mismatch, tp_variant;
+__u64 lsm_inode, lsm_ret;
+
+/* bpf_fentry_test3(char a, int b, u64 c): reordered, plus a missing one */
+struct bpf_func_args___test3 {
+	__u64 c;
+	int b;
+	char a;
+	long nope;
+	int __ret;
+} __attribute__((preserve_access_index));
+
+/* u64 c as a __u32: loads of unsigned integers are resized to the argument */
+struct bpf_func_args___test3_u32 {
+	__u32 c;
+} __attribute__((preserve_access_index));
+
+SEC("fentry/bpf_fentry_test3")
+int fentry(struct bpf_func_args___test3 *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != pid)
+		return 0;
+	fentry_a = ctx->a;
+	fentry_b = ctx->b;
+	fentry_c = ctx->c;
+	fentry_nope = bpf_core_field_exists(ctx->nope);
+	/* the return value is not in the context of fentry */
+	fentry_ret = bpf_core_field_exists(ctx->__ret);
+	/*
+	 * A field variant, as for an argument renamed on another kernel: the
+	 * access to the missing one is poisoned. Clang turns the two loads of
+	 * the same size into one, from ctx plus the offset each branch sets,
+	 * which the verifier allows from Linux 7.1.
+	 */
+	if (bpf_core_field_exists(ctx->nope))
+		fentry_alt = ctx->nope;
+	else
+		fentry_alt = ctx->c;
+	fentry_c32 = ((struct bpf_func_args___test3_u32 *)ctx)->c;
+	return 0;
+}
+
+/* a typedef'd anonymous struct, named after its typedef */
+typedef struct {
+	__u64 c;
+	int __ret;
+} __attribute__((preserve_access_index)) bpf_func_args___test3_t;
+
+SEC("fexit/bpf_fentry_test3")
+int fexit(bpf_func_args___test3_t *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != pid)
+		return 0;
+	fexit_c = ctx->c;
+	fexit_ret = ctx->__ret;
+	return 0;
+}
+
+/*
+ * bpf_modify_return_test2(int a, int *b, short c, int d, void *e, char f,
+ * int g). Unlike for bpf_modify_return_test(), other tests' fmod_ret programs
+ * on it only return non-zero for their own process, which would skip this one.
+ */
+struct bpf_func_args___modify2 {
+	int __ret;
+	int g;
+	char f;
+	short c;
+	/* int, as long as on a kernel where it would be wider */
+	long d;
+} __attribute__((preserve_access_index));
+
+SEC("fmod_ret/bpf_modify_return_test2")
+int fmod_ret(struct bpf_func_args___modify2 *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != pid)
+		return 0;
+	fmod_ret_c = ctx->c;
+	/* a plain load of a signed integer of another size would be poisoned */
+	fmod_ret_d = BPF_CORE_READ_BITFIELD(ctx, d);
+	fmod_ret_f = ctx->f;
+	fmod_ret_g = ctx->g;
+	fmod_ret_ret = bpf_core_field_exists(ctx->__ret);
+	return 0;
+}
+
+/* sys_enter(struct pt_regs *regs, long id), without void *__data */
+struct bpf_func_args___sys_enter {
+	long id;
+	struct pt_regs *regs;
+} __attribute__((preserve_access_index));
+
+/*
+ * Flavors with just the argument whose type is checked, as for an argument
+ * pointing to another type on another kernel. bpf_core_type_matches() also
+ * compares the names of integer types, and clang's "long" is "long int" in
+ * kernel BTF, so only check pointers here.
+ * The flavor starts with and contains triple underscores, which only
+ * matches as the candidate is named after the struct.
+ */
+struct bpf_func_args____sys_enter___good {
+	struct pt_regs *regs;
+} __attribute__((preserve_access_index));
+
+struct bpf_func_args___sys_enter_bad {
+	struct file *regs;
+} __attribute__((preserve_access_index));
+
+/* a struct variant, as for another kernel where the argument is renamed */
+struct bpf_func_args___sys_enter_old {
+	struct pt_regs *uregs;
+} __attribute__((preserve_access_index));
+
+SEC("tp_btf/sys_enter")
+int tp_btf(struct bpf_func_args___sys_enter *ctx)
+{
+	struct pt_regs *regs;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != pid)
+		return 0;
+	/* other syscalls of this process trigger it too */
+	if (ctx->id == tp_nr)
+		tp_hits++;
+	tp_match = bpf_core_type_matches(struct bpf_func_args____sys_enter___good);
+	tp_mismatch = bpf_core_type_matches(struct bpf_func_args___sys_enter_bad);
+	/* a struct variant: the access through the one not matching is poisoned */
+	if (bpf_core_type_matches(struct bpf_func_args____sys_enter___good))
+		regs = ((struct bpf_func_args____sys_enter___good *)ctx)->regs;
+	else
+		regs = ((struct bpf_func_args___sys_enter_old *)ctx)->uregs;
+	tp_variant = regs && regs == ctx->regs;
+	return 0;
+}
+
+/* file_open(struct file *file) */
+struct bpf_func_args___file_open {
+	struct file *file;
+	int __ret;
+} __attribute__((preserve_access_index));
+
+SEC("lsm/file_open")
+int lsm(struct bpf_func_args___file_open *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != pid)
+		return 0;
+	lsm_inode = !!ctx->file->f_inode;
+	lsm_ret = ctx->__ret + 1;
+	return 0;
+}
+
+/* an unguarded access to a missing argument fails to load */
+SEC("?fentry/bpf_fentry_test3")
+int missing(struct bpf_func_args___test3 *ctx)
+{
+	fentry_nope = ctx->nope;
+	return 0;
+}
+
+/* a missing attach target fails the load of the program, not the prepare */
+SEC("?fentry/bpf_fentry_test_nonexistent")
+int no_target(struct bpf_func_args___test3 *ctx)
+{
+	if (bpf_core_field_exists(ctx->a))
+		fentry_a = ctx->a;
+	return 0;
+}
-- 
2.56.0

