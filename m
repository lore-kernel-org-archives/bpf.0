Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027173AE193;
	Sat,  6 Jun 2026 12:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749814; cv=none; b=a9FxUiZKsYGtNq5cOJqvVBZPGvUllAdUFBRYgybRkyD+shnWlp13pd8eIBjxKdkZ5rjxEK1jhwIfRgmHArGmmghps/iWARhxSQ6Ui/iFlzf7QyjVYlD3GRGYpR7kfvwDE1kje968a2jLQpRCXWjTVmrW2dMQkv3Nn9PRWmRM/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749814; c=relaxed/simple;
	bh=/FZxkgwxMzOf/LpA1ed1p2efpv0Q7W0k9eEp6sYCBCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=likgOS4OWnZc8sczOyxn4cNo4indJhevK8K1U2euDLv7tUM/DERNjlwFVa0aAkO/KoxSUjoDlZ3+Yneim+Ewg9Vu8eQ5aHQTj8Nn64NBf/zujk/RUk4bLAz6iMa05jEIlvuNnFXfqm1k/TFRoLXp8q3br5LVReLsI3DuvZ6l6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9VxsA0S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9VxsA0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74141F00893;
	Sat,  6 Jun 2026 12:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749812;
	bh=65Oa8kp+3i6dXp/Y1WRxWx3ly7TQ0f3OipmQe45W/X0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a9VxsA0S3+FymYrSeXXMnVw9HzwtlqwugXAhKmMGPt2gt3Q3+BAf0ldrWxLMyUJye
	 tVJ3nTkLiw5O/x92bbXAhAM0sgcLiypOanb3XaydiHc4qPpEFRCGcMfdgs+W9lPmvO
	 qUK1jHaiFEvxRR4wNk+4vyDGMbluXXNQSqFGzBRRKHbTMkD3ZGgSSJuNg6WOGQSfkY
	 KV7cNsSxx15ZpsKKPUHNoM2RfgGOwSc6OQWZz+McCEE04f8h3hwlv4YhuCLySZPAgr
	 EXex++t+Vs72u7rY0Dnnm3rSwXiwkrG11tgS6/o+FG3WtjSac8RrzGTfALS/LK7XWB
	 EWocZGqywDbKQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [PATCHv8 bpf-next 21/29] selftests/bpf: Add tracing multi skel/pattern/ids attach tests
Date: Sat,  6 Jun 2026 14:39:46 +0200
Message-ID: <20260606123955.345967-22-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260606123955.345967-1-jolsa@kernel.org>
References: <20260606123955.345967-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding tests for tracing_multi link attachment via all possible
libbpf apis - skeleton, function pattern and btf ids.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/Makefile          |   3 +-
 .../selftests/bpf/prog_tests/tracing_multi.c  | 258 ++++++++++++++++++
 .../bpf/progs/tracing_multi_attach.c          |  39 +++
 .../selftests/bpf/progs/tracing_multi_check.c | 151 ++++++++++
 4 files changed, 450 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_attach.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_check.c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 42d9cf848b25..fd885beee0fd 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -512,7 +512,7 @@ SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
 LINKED_SKELS := test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h 			\
 		test_subskeleton.skel.h test_subskeleton_lib.skel.h	\
-		test_usdt.skel.h
+		test_usdt.skel.h tracing_multi.skel.h
 
 LSKELS := fexit_sleep.c trace_printk.c trace_vprintk.c map_ptr_kern.c 	\
 	core_kern.c core_kern_overflow.c test_ringbuf.c			\
@@ -538,6 +538,7 @@ test_usdt.skel.h-deps := test_usdt.bpf.o test_usdt_multispec.bpf.o
 xsk_xdp_progs.skel.h-deps := xsk_xdp_progs.bpf.o
 xdp_hw_metadata.skel.h-deps := xdp_hw_metadata.bpf.o
 xdp_features.skel.h-deps := xdp_features.bpf.o
+tracing_multi.skel.h-deps := tracing_multi_attach.bpf.o tracing_multi_check.bpf.o
 
 LINKED_BPF_OBJS := $(foreach skel,$(LINKED_SKELS),$($(skel)-deps))
 LINKED_BPF_SRCS := $(patsubst %.bpf.o,%.c,$(LINKED_BPF_OBJS))
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
new file mode 100644
index 000000000000..f333b2514b34
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <bpf/btf.h>
+#include <search.h>
+#include "bpf/libbpf_internal.h"
+#include "tracing_multi.skel.h"
+#include "trace_helpers.h"
+
+static const char * const bpf_fentry_test[] = {
+	"bpf_fentry_test1",
+	"bpf_fentry_test2",
+	"bpf_fentry_test3",
+	"bpf_fentry_test4",
+	"bpf_fentry_test5",
+	"bpf_fentry_test6",
+	"bpf_fentry_test7",
+	"bpf_fentry_test8",
+	"bpf_fentry_test9",
+	"bpf_fentry_test10",
+};
+
+#define FUNCS_CNT (ARRAY_SIZE(bpf_fentry_test))
+
+static int compare(const void *ppa, const void *ppb)
+{
+	const char *pa = *(const char **) ppa;
+	const char *pb = *(const char **) ppb;
+
+	return strcmp(pa, pb);
+}
+
+static void tdestroy_free_nop(void *ptr)
+{
+}
+
+static __u32 *get_ids(const char * const funcs[], int funcs_cnt, const char *mod)
+{
+	struct btf *btf, *vmlinux_btf = NULL;
+	__u32 nr, type_id, cnt = 0;
+	void *root = NULL;
+	__u32 *ids = NULL;
+	int i, err = 0;
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
+		return NULL;
+
+	if (mod) {
+		vmlinux_btf = btf;
+		btf = btf__load_module_btf(mod, vmlinux_btf);
+		if (!ASSERT_OK_PTR(btf, "btf__load_module_btf")) {
+			btf__free(vmlinux_btf);
+			return NULL;
+		}
+	}
+
+	ids = calloc(funcs_cnt, sizeof(ids[0]));
+	if (!ids)
+		goto out;
+
+	/*
+	 * We sort function names by name and search them
+	 * below for each function.
+	 */
+	for (i = 0; i < funcs_cnt; i++) {
+		if (!tsearch(&funcs[i], &root, compare)) {
+			ASSERT_FAIL("tsearch failed");
+			err = -1;
+			goto error;
+		}
+	}
+
+	nr = btf__type_cnt(btf);
+	for (type_id = 1; type_id < nr && cnt < funcs_cnt; type_id++) {
+		const struct btf_type *type;
+		const char *str, ***val;
+		unsigned int idx;
+
+		type = btf__type_by_id(btf, type_id);
+		if (!type) {
+			err = -1;
+			break;
+		}
+
+		if (BTF_INFO_KIND(type->info) != BTF_KIND_FUNC)
+			continue;
+
+		str = btf__name_by_offset(btf, type->name_off);
+		if (!str) {
+			err = -1;
+			break;
+		}
+
+		val = tfind(&str, &root, compare);
+		if (!val)
+			continue;
+
+		/*
+		 * We keep pointer for each function name so we can get the original
+		 * array index and have the resulting ids array matching the original
+		 * function array.
+		 *
+		 * Doing it this way allow us to easily test the cookies support,
+		 * because each cookie is attached to particular function/id.
+		 */
+		idx = *val - funcs;
+		ids[idx] = type_id;
+		cnt++;
+	}
+
+error:
+	if (err) {
+		free(ids);
+		ids = NULL;
+	}
+
+out:
+	tdestroy(root, tdestroy_free_nop);
+	btf__free(vmlinux_btf);
+	btf__free(btf);
+	return ids;
+}
+
+static void tracing_multi_test_run(struct tracing_multi *skel)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	int err, prog_fd;
+
+	prog_fd = bpf_program__fd(skel->progs.test_fentry);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+
+	/* extra +1 count for sleepable programs */
+	ASSERT_EQ(skel->bss->test_result_fentry, FUNCS_CNT + 1, "test_result_fentry");
+	ASSERT_EQ(skel->bss->test_result_fexit, FUNCS_CNT + 1, "test_result_fexit");
+}
+
+static void test_skel_api(void)
+{
+	struct tracing_multi *skel;
+	int err;
+
+	skel = tracing_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	err = tracing_multi__attach(skel);
+	if (!ASSERT_OK(err, "tracing_multi__attach"))
+		goto cleanup;
+
+	tracing_multi_test_run(skel);
+
+cleanup:
+	tracing_multi__destroy(skel);
+}
+
+static void test_link_api_pattern(void)
+{
+	struct tracing_multi *skel;
+
+	skel = tracing_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+					"bpf_fentry_test*", NULL);
+	if (!ASSERT_OK_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	skel->links.test_fexit = bpf_program__attach_tracing_multi(skel->progs.test_fexit,
+					"bpf_fentry_test*", NULL);
+	if (!ASSERT_OK_PTR(skel->links.test_fexit, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	skel->links.test_fentry_s = bpf_program__attach_tracing_multi(skel->progs.test_fentry_s,
+					"bpf_fentry_test1", NULL);
+	if (!ASSERT_OK_PTR(skel->links.test_fentry_s, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	skel->links.test_fexit_s = bpf_program__attach_tracing_multi(skel->progs.test_fexit_s,
+					"bpf_fentry_test1", NULL);
+	if (!ASSERT_OK_PTR(skel->links.test_fexit_s, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	tracing_multi_test_run(skel);
+
+cleanup:
+	tracing_multi__destroy(skel);
+}
+
+static void test_link_api_ids(void)
+{
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	struct tracing_multi *skel;
+	size_t cnt = FUNCS_CNT;
+	__u32 *ids;
+
+	skel = tracing_multi__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "tracing_multi__open_and_load"))
+		return;
+
+	skel->bss->pid = getpid();
+
+	ids = get_ids(bpf_fentry_test, cnt, NULL);
+	if (!ASSERT_OK_PTR(ids, "get_ids"))
+		goto cleanup;
+
+	opts.ids = ids;
+	opts.cnt = cnt;
+
+	skel->links.test_fentry = bpf_program__attach_tracing_multi(skel->progs.test_fentry,
+						NULL, &opts);
+	if (!ASSERT_OK_PTR(skel->links.test_fentry, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	skel->links.test_fexit = bpf_program__attach_tracing_multi(skel->progs.test_fexit,
+						NULL, &opts);
+	if (!ASSERT_OK_PTR(skel->links.test_fexit, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	/* Only bpf_fentry_test1 is allowed for sleepable programs. */
+	opts.cnt = 1;
+	skel->links.test_fentry_s = bpf_program__attach_tracing_multi(skel->progs.test_fentry_s,
+						NULL, &opts);
+	if (!ASSERT_OK_PTR(skel->links.test_fentry_s, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	skel->links.test_fexit_s = bpf_program__attach_tracing_multi(skel->progs.test_fexit_s,
+						NULL, &opts);
+	if (!ASSERT_OK_PTR(skel->links.test_fexit_s, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	tracing_multi_test_run(skel);
+
+cleanup:
+	tracing_multi__destroy(skel);
+	free(ids);
+}
+
+void test_tracing_multi_test(void)
+{
+#ifndef __x86_64__
+	test__skip();
+	return;
+#endif
+
+	if (test__start_subtest("skel_api"))
+		test_skel_api();
+	if (test__start_subtest("link_api_pattern"))
+		test_link_api_pattern();
+	if (test__start_subtest("link_api_ids"))
+		test_link_api_ids();
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_attach.c b/tools/testing/selftests/bpf/progs/tracing_multi_attach.c
new file mode 100644
index 000000000000..332d0a423a43
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_attach.c
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__hidden extern int tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return);
+
+__u64 test_result_fentry = 0;
+__u64 test_result_fexit = 0;
+
+SEC("fentry.multi/bpf_fentry_test*")
+int BPF_PROG(test_fentry)
+{
+	tracing_multi_arg_check(ctx, &test_result_fentry, false);
+	return 0;
+}
+
+SEC("fexit.multi/bpf_fentry_test*")
+int BPF_PROG(test_fexit)
+{
+	tracing_multi_arg_check(ctx, &test_result_fexit, true);
+	return 0;
+}
+
+SEC("fentry.multi.s/bpf_fentry_test1")
+int BPF_PROG(test_fentry_s)
+{
+	tracing_multi_arg_check(ctx, &test_result_fentry, false);
+	return 0;
+}
+
+SEC("fexit.multi.s/bpf_fentry_test1")
+int BPF_PROG(test_fexit_s)
+{
+	tracing_multi_arg_check(ctx, &test_result_fexit, true);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_check.c b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
new file mode 100644
index 000000000000..333a3a7bae8a
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_check.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+int pid = 0;
+
+/* bpf_fentry_test1 is exported as kfunc via vmlinux.h */
+extern const void bpf_fentry_test2 __ksym;
+extern const void bpf_fentry_test3 __ksym;
+extern const void bpf_fentry_test4 __ksym;
+extern const void bpf_fentry_test5 __ksym;
+extern const void bpf_fentry_test6 __ksym;
+extern const void bpf_fentry_test7 __ksym;
+extern const void bpf_fentry_test8 __ksym;
+extern const void bpf_fentry_test9 __ksym;
+extern const void bpf_fentry_test10 __ksym;
+
+int tracing_multi_arg_check(__u64 *ctx, __u64 *test_result, bool is_return)
+{
+	void *ip = (void *) bpf_get_func_ip(ctx);
+	__u64 value = 0, ret = 0;
+	long err = 0;
+
+	if (bpf_get_current_pid_tgid() >> 32 != pid)
+		return 1;
+
+	if (is_return)
+		err |= bpf_get_func_ret(ctx, &ret);
+
+	if (ip == &bpf_fentry_test1) {
+		int a;
+
+		err |= bpf_get_func_arg(ctx, 0, &value);
+		a = (int) value;
+
+		err |= is_return ? ret != 2 : 0;
+
+		*test_result += err == 0 && a == 1;
+	} else if (ip == &bpf_fentry_test2) {
+		__u64 b;
+		int a;
+
+		err |= bpf_get_func_arg(ctx, 0, &value);
+		a = (int) value;
+		err |= bpf_get_func_arg(ctx, 1, &value);
+		b = value;
+
+		err |= is_return ? ret != 5 : 0;
+
+		*test_result += err == 0 && a == 2 && b == 3;
+	} else if (ip == &bpf_fentry_test3) {
+		__u64 c;
+		char a;
+		int b;
+
+		err |= bpf_get_func_arg(ctx, 0, &value);
+		a = (char) value;
+		err |= bpf_get_func_arg(ctx, 1, &value);
+		b = (int) value;
+		err |= bpf_get_func_arg(ctx, 2, &value);
+		c = value;
+
+		err |= is_return ? ret != 15 : 0;
+
+		*test_result += err == 0 && a == 4 && b == 5 && c == 6;
+	} else if (ip == &bpf_fentry_test4) {
+		void *a;
+		char b;
+		int c;
+		__u64 d;
+
+		err |= bpf_get_func_arg(ctx, 0, &value);
+		a = (void *) value;
+		err |= bpf_get_func_arg(ctx, 1, &value);
+		b = (char) value;
+		err |= bpf_get_func_arg(ctx, 2, &value);
+		c = (int) value;
+		err |= bpf_get_func_arg(ctx, 3, &value);
+		d = value;
+
+		err |= is_return ? ret != 34 : 0;
+
+		*test_result += err == 0 && a == (void *) 7 && b == 8 && c == 9 && d == 10;
+	} else if (ip == &bpf_fentry_test5) {
+		__u64 a;
+		void *b;
+		short c;
+		int d;
+		__u64 e;
+
+		err |= bpf_get_func_arg(ctx, 0, &value);
+		a = value;
+		err |= bpf_get_func_arg(ctx, 1, &value);
+		b = (void *) value;
+		err |= bpf_get_func_arg(ctx, 2, &value);
+		c = (short) value;
+		err |= bpf_get_func_arg(ctx, 3, &value);
+		d = (int) value;
+		err |= bpf_get_func_arg(ctx, 4, &value);
+		e = value;
+
+		err |= is_return ? ret != 65 : 0;
+
+		*test_result += err == 0 && a == 11 && b == (void *) 12 && c == 13 && d == 14 && e == 15;
+	} else if (ip == &bpf_fentry_test6) {
+		__u64 a;
+		void *b;
+		short c;
+		int d;
+		void *e;
+		__u64 f;
+
+		err |= bpf_get_func_arg(ctx, 0, &value);
+		a = value;
+		err |= bpf_get_func_arg(ctx, 1, &value);
+		b = (void *) value;
+		err |= bpf_get_func_arg(ctx, 2, &value);
+		c = (short) value;
+		err |= bpf_get_func_arg(ctx, 3, &value);
+		d = (int) value;
+		err |= bpf_get_func_arg(ctx, 4, &value);
+		e = (void *) value;
+		err |= bpf_get_func_arg(ctx, 5, &value);
+		f = value;
+
+		err |= is_return ? ret != 111 : 0;
+
+		*test_result += err == 0 && a == 16 && b == (void *) 17 && c == 18 && d == 19 && e == (void *) 20 && f == 21;
+	} else if (ip == &bpf_fentry_test7) {
+		err |= is_return ? ret != 0 : 0;
+
+		*test_result += err == 0 ? 1 : 0;
+	} else if (ip == &bpf_fentry_test8) {
+		err |= is_return ? ret != 0 : 0;
+
+		*test_result += err == 0 ? 1 : 0;
+	} else if (ip == &bpf_fentry_test9) {
+		err |= is_return ? ret != 0 : 0;
+
+		*test_result += err == 0 ? 1 : 0;
+	} else if (ip == &bpf_fentry_test10) {
+		err |= is_return ? ret != 0 : 0;
+
+		*test_result += err == 0 ? 1 : 0;
+	}
+
+	return 0;
+}
-- 
2.54.0

