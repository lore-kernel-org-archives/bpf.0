Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795473165;
	b=gxSVmgt3RG4LHq/T2kS1uH+zL8Utmx9UiHIaASGfRJMsKkeN2fvVE3VzPvcdn+htjLuq
	 NNmu7ij3B2kiNaWBvj6vzvD2fFhYmiadltaWV7fVV+EHVB6+3KuLfCc7DOdx0U6aEAjY6
	 y5OZjgAfx+/WaDTO40dmjRQBuho7bJexiaKdP+3j6ctMszZHuaX/khLZa8Zv5oGU2LHm/
	 3fUiLEO55vRdZDcUvucI0dz1w7jPUK96wSWtlVFNYz1yzLzph5f6YUjfvIW77i26QWfY3
	 z33poRmizmKPHF3551jcumuEL2hWGsckVaK0iqrgGuDue4sRu8ksqO2xnXWYjPstFog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795473165;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XAy7Zo7/gYAQlR5f74poZIVKiqvqpkw7L7pOGhlViSU=;
	b=wFLmRj2MMc1n8sIlnORzWOkg0bLXbiq13P0fRN2/9CoZAZXwVQsj2ZDe//9MhSW9QqHX
	 VeFDWtPhCBhAP8qINf6EtFQF4kGXBkDLxgOvQdR51Geuc473mtDwWo67K0oS1BhN85Nfy
	 fylM8BX6e3fKJ6p7FqgRzDOOfctXMrS7Tnib8SIE5MQgHBYvZ1v7OQyo70b9Cxi5wzNco
	 Irfw4hVzwsSDVcLM0p0o/SQnC+tNJhKhSBNLJC/gQC2u8vNMnSpcAQToh7+tXe8sH5A17
	 p+Bt2uVogK0F5ANLwHcPbTSuwD7tgG4Vx4SNLNSRMdPy8V0D3n74lFAATYhdYb7cvxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2otCAzf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CCB606A31E
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 22:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b2otCAzf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BC91F000D2;
	Mon, 23 Nov 2026 22:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795473165;
	bh=XAy7Zo7/gYAQlR5f74poZIVKiqvqpkw7L7pOGhlViSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b2otCAzf+bwoByzTIL97WSNSKMvo89WDLV0o2ZKmX+4F+RfYSq6vAd3A7Fs6JLAH+
	 bkQVr6T8updhygrhHRgB3EicBTyeFJT1M35IkmcTUyo4LEDBmBLtshZjDwdb78lJ5q
	 mYKwCb1kxasIxl1MXWanqnT7iJ5JOcSVZxMjRrCNKkw5oYix0wFq7K3eU/GMNZrnJn
	 dovKFTcO4lqmBFlR03ugH5sMpsIg2cbOyYYibxECSK2zElLlANaL8sB1vqn7DjRz5Z
	 9xWk0j5VYESJkkU2uGIvMqiDL82NsQL+bsUN7SrKUByv/NMhWHyYYc4/DJW1DVF/By
	 PG1dPJzTYuGTA==
From: Alan Maguire <almagui@kernel.org>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	Alan Maguire <almagui@kernel.org>
Subject: [PATCH bpf-next 3/7] selftests/bpf: Test CO-RE relocation of tracing program arguments
Date: Mon, 23 Nov 2026 22:32:23 +0000
Message-ID: <20261123223227.745345-4-almagui@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123223227.745345-1-almagui@kernel.org>
References: <20261123223227.745345-1-almagui@kernel.org>
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

Exercise __bpf_func_args structs with:

- fentry/fexit on bpf_fentry_test3() with members in a different order
  than the parameters, a member with no matching parameter (both with
  and without a ___flavor suffix), a member whose type is incompatible
  with the matching parameter, a ___flavor alias, and a __bpf_func_ret
  member that only exists for fexit;
- fexit on a bpf_testmod function taking a 16-byte struct by value,
  which occupies two context slots and shifts the following arguments;
- tp_btf on a bpf_testmod tracepoint, where parameter names come from
  __probestub_bpf_testmod_test_read(), including pointer members whose
  pointed-to type differs from the parameter's (no match), is a
  forward declaration of the same struct (match), or is void (match);
- fmod_ret on bpf_modify_return_test(), with members out of order, a
  missing member and the return value slot (holding the return value of
  previous fmod_ret programs);
- fentry on bpf_fentry_test3() with a typedef'd anonymous struct, whose
  relocations have the typedef rather than the struct as their root type.

Also exercise BPF_PROG_CORE() on the same targets: reordered arguments,
a missing argument reading as zero with bpf_func_arg_exists() reporting
it as absent, an argument whose type is incompatible with the matching
parameter, which also reads as zero and is reported as absent, the
return value on fexit (and its absence on fentry), a tp_btf program,
and an fsession program on bpf_fentry_test3(), which calls
bpf_session_is_return() on the ctx and checks that the return value
exists on both entry and exit, reading 0 and 15 respectively.

Argument structs use __bpf_func_args_marker, so that they also work when
built with GCC, except for the one used by the fentry/fexit programs on
bpf_fentry_test3(), which only has the struct-level tag when built with
clang, to also cover that form.

Build the object both as a skeleton and a light skeleton, so that both
libbpf's and the kernel's CO-RE relocation are covered.

Skip the test on big-endian targets: the programs read signed int
arguments and return values with zero-extending loads (directly and via
BPF_PROG_CORE()), which can't be relocated there, as the verifier only
allows loads of whole context slots, so they would fail to load.

Signed-off-by: Alan Maguire <almagui@kernel.org>
Assisted-by: LLM
---
 tools/testing/selftests/bpf/Makefile.skel     |   2 +-
 .../selftests/bpf/prog_tests/func_args_core.c | 130 ++++++++++
 .../selftests/bpf/progs/func_args_core.c      | 228 ++++++++++++++++++
 3 files changed, 359 insertions(+), 1 deletion(-)
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
index 000000000000..1516ad13eaa2
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/func_args_core.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include "func_args_core.skel.h"
+#include "func_args_core.lskel.h"
+
+/* runs bpf_fentry_test1..N() (via a fentry prog), bpf_modify_return_test()
+ * (via a fmod_ret prog) and bpf_testmod's test read
+ */
+static void trigger(int fentry_prog_fd, int fmod_ret_prog_fd)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+
+	ASSERT_OK(bpf_prog_test_run_opts(fentry_prog_fd, &topts), "test_run");
+	ASSERT_OK(bpf_prog_test_run_opts(fmod_ret_prog_fd, &topts), "test_run_fmod_ret");
+	ASSERT_OK(trigger_module_test_read(256), "trigger_read");
+}
+
+/* the skeleton and light skeleton have identically named bss/data members */
+#define check_results(skel) ({							\
+	ASSERT_EQ(skel->bss->t3_a, 4, "t3_a");					\
+	ASSERT_EQ(skel->bss->t3_b, 5, "t3_b");					\
+	ASSERT_EQ(skel->bss->t3_c, 6, "t3_c");					\
+	ASSERT_EQ(skel->bss->t3_b_alias, 5, "t3_b_alias");			\
+	ASSERT_EQ(skel->data->t3_missing_exists, 0, "t3_missing_exists");	\
+	ASSERT_EQ(skel->data->t3_bad_type_exists, 0, "t3_bad_type_exists");	\
+	ASSERT_EQ(skel->data->t3_missing_flavor_exists, 0, "t3_missing_flavor_exists"); \
+	ASSERT_EQ(skel->data->t3_fentry_ret_exists, 0, "t3_fentry_ret_exists"); \
+	ASSERT_EQ(skel->data->t3_ret_exists, 1, "t3_ret_exists");		\
+	ASSERT_EQ(skel->bss->t3_ret, 15, "t3_ret");				\
+										\
+	ASSERT_EQ(skel->bss->fm_calls, 1, "fm_calls");				\
+	ASSERT_EQ(skel->bss->fm_a, 1, "fm_a");					\
+	ASSERT_TRUE(skel->bss->fm_b_set, "fm_b_set");				\
+	ASSERT_EQ(skel->data->fm_ret, 0, "fm_ret");				\
+	ASSERT_EQ(skel->data->fm_ret_exists, 1, "fm_ret_exists");		\
+	ASSERT_EQ(skel->data->fm_missing_exists, 0, "fm_missing_exists");	\
+										\
+	ASSERT_EQ(skel->data->fs_ret_exists, 1, "fs_ret_exists");		\
+	ASSERT_EQ(skel->bss->fs_entry_calls, 1, "fs_entry_calls");		\
+	ASSERT_EQ(skel->bss->fs_exit_calls, 1, "fs_exit_calls");		\
+	ASSERT_EQ(skel->bss->fs_entry_c, 6, "fs_entry_c");			\
+	ASSERT_EQ(skel->bss->fs_exit_c, 6, "fs_exit_c");			\
+	ASSERT_EQ(skel->data->fs_entry_ret, 0, "fs_entry_ret");		\
+	ASSERT_EQ(skel->data->fs_exit_ret, 15, "fs_exit_ret");			\
+										\
+	ASSERT_EQ(skel->bss->m3_a, 4, "m3_a");					\
+	ASSERT_EQ(skel->bss->m3_b, 5, "m3_b");					\
+	ASSERT_EQ(skel->bss->m3_c, 6, "m3_c");					\
+	ASSERT_EQ(skel->data->m3_missing, 0, "m3_missing");			\
+	ASSERT_EQ(skel->data->m3_missing_exists, 0, "m3_missing_exists");	\
+	ASSERT_EQ(skel->bss->m3_ret, 15, "m3_ret");				\
+	ASSERT_EQ(skel->data->m3_ret_exists, 1, "m3_ret_exists");		\
+										\
+	ASSERT_EQ(skel->bss->mf_b, 5, "mf_b");					\
+	ASSERT_EQ(skel->data->mf_ret, 0, "mf_ret");				\
+	ASSERT_EQ(skel->data->mf_ret_exists, 0, "mf_ret_exists");		\
+	ASSERT_EQ(skel->data->mf_a, 0, "mf_a");					\
+	ASSERT_EQ(skel->data->mf_a_exists, 0, "mf_a_exists");			\
+										\
+	ASSERT_EQ(skel->bss->td_c, 6, "td_c");					\
+	ASSERT_EQ(skel->data->td_missing_exists, 0, "td_missing_exists");	\
+										\
+	ASSERT_EQ(skel->bss->s1_a_a, 2, "s1_a_a");				\
+	ASSERT_EQ(skel->bss->s1_a_b, 3, "s1_a_b");				\
+	ASSERT_EQ(skel->bss->s1_b, 1, "s1_b");					\
+	ASSERT_EQ(skel->bss->s1_c, 4, "s1_c");					\
+	ASSERT_EQ(skel->bss->s1_ret, 10, "s1_ret");				\
+										\
+	ASSERT_EQ(skel->bss->tp_pid, getpid(), "tp_pid");			\
+	ASSERT_EQ(skel->bss->tp_len, 256, "tp_len");				\
+	ASSERT_EQ(skel->data->tp_bad_ptr_exists, 0, "tp_bad_ptr_exists");	\
+	ASSERT_EQ(skel->data->tp_fwd_exists, 1, "tp_fwd_exists");		\
+	ASSERT_EQ(skel->data->tp_void_exists, 1, "tp_void_exists");		\
+	ASSERT_EQ(skel->data->tp_void_same, 1, "tp_void_same");		\
+	ASSERT_EQ(skel->bss->mtp_pid, getpid(), "mtp_pid");			\
+})
+
+/* CO-RE relocations applied by libbpf */
+static void test_skel(void)
+{
+	struct func_args_core *skel;
+
+	skel = func_args_core__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
+		return;
+	if (!ASSERT_OK(func_args_core__attach(skel), "skel_attach"))
+		goto cleanup;
+
+	trigger(bpf_program__fd(skel->progs.fentry3),
+		bpf_program__fd(skel->progs.fmod_ret_test));
+	check_results(skel);
+cleanup:
+	func_args_core__destroy(skel);
+}
+
+/* CO-RE relocations applied by the kernel */
+static void test_lskel(void)
+{
+	struct func_args_core_lskel *skel;
+
+	skel = func_args_core_lskel__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "lskel_open_and_load"))
+		return;
+	if (!ASSERT_OK(func_args_core_lskel__attach(skel), "lskel_attach"))
+		goto cleanup;
+
+	trigger(skel->progs.fentry3.prog_fd, skel->progs.fmod_ret_test.prog_fd);
+	check_results(skel);
+cleanup:
+	func_args_core_lskel__destroy(skel);
+}
+
+void test_func_args_core(void)
+{
+#if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+	/* On big-endian targets, the verifier only allows loads of whole
+	 * context slots, and loads of signed arguments smaller than 8 bytes
+	 * can only be widened to their slot if they are sign-extending. The
+	 * programs read signed int arguments and return values with
+	 * zero-extending loads (directly and via BPF_PROG_CORE()), which
+	 * are poisoned there, so they would fail to load.
+	 */
+	test__skip();
+	return;
+#endif
+	if (test__start_subtest("skel"))
+		test_skel();
+	if (test__start_subtest("lskel"))
+		test_lskel();
+}
diff --git a/tools/testing/selftests/bpf/progs/func_args_core.c b/tools/testing/selftests/bpf/progs/func_args_core.c
new file mode 100644
index 000000000000..4656a6c642d1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/func_args_core.c
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+#include "../test_kmods/bpf_testmod.h"
+
+char _license[] SEC("license") = "GPL";
+
+/* int bpf_fentry_test3(char a, int b, u64 c), called as (4, 5, 6) */
+struct fentry_test3_args {
+#ifndef __clang__
+	/* GCC doesn't support BTF decl tags on types, see __bpf_func_args;
+	 * with clang, this struct relies on the struct-level tag only
+	 */
+	__bpf_func_args_marker;
+#endif
+	/* deliberately in a different order to the target */
+	__u64 c;
+	int b;
+	char a;
+	/* no such parameter */
+	long missing;
+	/* flavor of a parameter that doesn't exist */
+	long missing___v2;
+	/* parameter exists, but the type isn't compatible */
+	struct task_struct *a___bad_type;
+	/* flavor of an existing parameter */
+	int b___alias;
+	int ret __bpf_func_ret;
+} __bpf_func_args;
+
+__u64 t3_a, t3_b, t3_c, t3_b_alias, t3_ret;
+int t3_missing_exists = -1, t3_bad_type_exists = -1, t3_missing_flavor_exists = -1;
+int t3_fentry_ret_exists = -1, t3_ret_exists = -1;
+
+SEC("fentry/bpf_fentry_test3")
+int fentry3(struct fentry_test3_args *args)
+{
+	t3_a = args->a;
+	t3_b = args->b;
+	t3_c = args->c;
+	t3_b_alias = args->b___alias;
+	t3_missing_exists = bpf_core_field_exists(args->missing);
+	t3_bad_type_exists = bpf_core_field_exists(args->a___bad_type);
+	t3_missing_flavor_exists = bpf_core_field_exists(args->missing___v2);
+	/* the return value isn't available on entry */
+	t3_fentry_ret_exists = bpf_core_field_exists(args->ret);
+	return 0;
+}
+
+SEC("fexit/bpf_fentry_test3")
+int fexit3(struct fentry_test3_args *args)
+{
+	t3_ret_exists = bpf_core_field_exists(args->ret);
+	t3_ret = args->ret;
+	return 0;
+}
+
+/* typedef'd anonymous struct, for which relocations have the typedef rather
+ * than the (tagged) struct as their root type
+ */
+typedef struct {
+	__bpf_func_args_marker;
+	__u64 c;
+	long missing;
+} __bpf_func_args fentry_test3_td_args_t;
+
+__u64 td_c;
+int td_missing_exists = -1;
+
+SEC("fentry/bpf_fentry_test3")
+int fentry3_typedef(fentry_test3_td_args_t *args)
+{
+	td_c = args->c;
+	td_missing_exists = bpf_core_field_exists(args->missing);
+	return 0;
+}
+
+/* int bpf_modify_return_test(int a, int *b), called as (1, &b) */
+struct modify_return_args {
+	__bpf_func_args_marker;
+	int *b;
+	int a;
+	long missing;
+	int ret __bpf_func_ret;
+} __bpf_func_args;
+
+int fm_a, fm_calls, fm_ret = -1, fm_ret_exists = -1, fm_missing_exists = -1;
+bool fm_b_set;
+
+SEC("fmod_ret/bpf_modify_return_test")
+int fmod_ret_test(struct modify_return_args *args)
+{
+	fm_calls++;
+	fm_a = args->a;
+	fm_b_set = args->b != NULL;
+	fm_ret = args->ret;
+	fm_ret_exists = bpf_core_field_exists(args->ret);
+	fm_missing_exists = bpf_core_field_exists(args->missing);
+	/* don't override the return value */
+	return 0;
+}
+
+/* fsession on bpf_fentry_test3(char a, int b, u64 c), called as (4, 5, 6) */
+__u64 fs_entry_c, fs_exit_c;
+int fs_entry_ret = -1, fs_exit_ret = -1, fs_ret_exists = -1;
+int fs_entry_calls, fs_exit_calls;
+
+SEC("fsession/bpf_fentry_test3")
+int BPF_PROG_CORE(fsession3, __u64, c, __bpf_func_ret int, ret)
+{
+	fs_ret_exists = bpf_func_arg_exists(ret);
+	if (!bpf_session_is_return(ctx)) {
+		fs_entry_calls++;
+		fs_entry_c = c;
+		fs_entry_ret = ret;
+	} else {
+		fs_exit_calls++;
+		fs_exit_c = c;
+		fs_exit_ret = ret;
+	}
+	return 0;
+}
+
+/* int bpf_testmod_test_struct_arg_1(struct bpf_testmod_struct_arg_2 a,
+ *				     int b, int c), called as ({2, 3}, 1, 4);
+ * 'a' is passed by value and occupies two context slots.
+ */
+struct bpf_testmod_struct_arg_2 {
+	long a;
+	long b;
+};
+
+struct struct_arg_1_args {
+	__bpf_func_args_marker;
+	int c;
+	int b;
+	struct bpf_testmod_struct_arg_2 a;
+	int ret __bpf_func_ret;
+} __bpf_func_args;
+
+long s1_a_a, s1_a_b, s1_b, s1_c, s1_ret;
+
+SEC("fexit/bpf_testmod_test_struct_arg_1")
+int fexit_struct_arg(struct struct_arg_1_args *args)
+{
+	s1_a_a = args->a.a;
+	s1_a_b = args->a.b;
+	s1_b = args->b;
+	s1_c = args->c;
+	s1_ret = args->ret;
+	return 0;
+}
+
+/* TP_PROTO(struct task_struct *task, struct bpf_testmod_test_read_ctx *ctx) */
+struct task_struct___fwd;
+
+struct test_read_args {
+	__bpf_func_args_marker;
+	struct bpf_testmod_test_read_ctx *ctx;
+	struct task_struct *task;
+	/* pointer to a different type than the parameter's: no match */
+	struct file *task___bad_ptr;
+	/* forward-declared pointee with the same essential name: match */
+	struct task_struct___fwd *task___fwd;
+	/* void pointers match any pointer */
+	void *ctx___void;
+} __bpf_func_args;
+
+int tp_pid, tp_len;
+int tp_bad_ptr_exists = -1, tp_fwd_exists = -1, tp_void_exists = -1, tp_void_same = -1;
+
+SEC("tp_btf/bpf_testmod_test_read")
+int tp_read(struct test_read_args *args)
+{
+	tp_pid = args->task->pid;
+	tp_len = args->ctx->len;
+	tp_bad_ptr_exists = bpf_core_field_exists(args->task___bad_ptr);
+	tp_fwd_exists = bpf_core_field_exists(args->task___fwd);
+	tp_void_exists = bpf_core_field_exists(args->ctx___void);
+	tp_void_same = args->ctx___void == (void *)args->ctx;
+	return 0;
+}
+
+/* BPF_PROG_CORE() versions, with the arguments struct declared implicitly */
+__u64 m3_a, m3_b, m3_c, m3_missing = -1, m3_ret;
+int m3_missing_exists = -1, m3_ret_exists = -1;
+
+SEC("fexit/bpf_fentry_test3")
+int BPF_PROG_CORE(fexit3_macro, __u64, c, int, b, char, a, long, missing,
+		  __bpf_func_ret int, ret)
+{
+	m3_a = a;
+	m3_b = b;
+	m3_c = c;
+	m3_missing = missing;
+	m3_missing_exists = bpf_func_arg_exists(missing);
+	m3_ret = ret;
+	m3_ret_exists = bpf_func_arg_exists(ret);
+	return 0;
+}
+
+__u64 mf_b, mf_ret = -1, mf_a = -1;
+int mf_ret_exists = -1, mf_a_exists = -1;
+
+SEC("fentry/bpf_fentry_test3")
+int BPF_PROG_CORE(fentry3_macro, int, b, __bpf_func_ret int, ret,
+		  struct task_struct *, a)
+{
+	mf_b = b;
+	/* 'a' is a char, so a pointer isn't compatible: it reads as zero */
+	mf_a = (__u64)a;
+	mf_a_exists = bpf_func_arg_exists(a);
+	/* no return value on entry, so it reads as zero */
+	mf_ret = ret;
+	mf_ret_exists = bpf_func_arg_exists(ret);
+	return 0;
+}
+
+int mtp_pid;
+
+SEC("tp_btf/bpf_testmod_test_read")
+int BPF_PROG_CORE(tp_read_macro, struct task_struct *, task)
+{
+	mtp_pid = task->pid;
+	return 0;
+}
-- 
2.56.0

