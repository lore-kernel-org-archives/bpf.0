Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1364310774;
	Tue,  3 Feb 2026 09:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770111618; cv=none; b=JNnOuXOoFpAWQA1msK7GiDVdWQQOepwsgiJliDDNivyeHpoRIozqkPV3u0sNJzY0E1F2eFhwRJIX3SJqppVuEF0RPwHfg0oFyb50MrBZt4RKk5Eg9dMToufOeqTNomZ8Rsm66NJ/pup/9wcPBBM1bAFRpS/Id43ep1yZqfWQoWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770111618; c=relaxed/simple;
	bh=hxNGABGqsbw3cPP/2PNCCD3aFG/uf6auRQuF4WpE8R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eO7q6w+QnweWkTyP9Miy7WRocm0gcTJRSZqYlIg3/kBCWl+qHVQnv2As6GXDV7FP/AsMrODhq3WV1ZVLWc9DRRJR0D72sNahWxApajoBIWN6+D/6XQUZOBQlVVGBAzL+fIN8zbd5pkJB4Qw7pSczIxlcjmVPXIGtx4gTFO7Noqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVUS3jbW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVUS3jbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD87C116D0;
	Tue,  3 Feb 2026 09:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770111618;
	bh=hxNGABGqsbw3cPP/2PNCCD3aFG/uf6auRQuF4WpE8R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVUS3jbWmaFAPlcc3rcFSD04oKyEPXX9+o5MXI8XRkcRK0l/zI3DEYFiiEyy4oPEN
	 TMC+/4Pw9DJQ86+bdgHGGWLnloFlaBEV5ghPq7OdtfxLE3PM9G6xneeZb7ePLZdGOO
	 TUjtVdB9nGm7R+jgHpk6tzPaKXMDCgDDa3FlZe1a8+ix+9gZkT4qSpLjfZLK6NpbUS
	 MvxfH3Fw8cZ8WkCzoY6q9+rauQn7B1g4gJ6BCXmJJadQy/5+Zlx3DbRPCd4G9i5nP6
	 cgXF4fegFY3jfutZW/ZNZA0S0Xxbt++9cvogGJIINLcdj3FEB8A7BSULtZ/rA8BiEX
	 bSMgF9kgZXUow==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: [RFC bpf-next 11/12] selftests/bpf: Add fentry intersected tracing multi func test
Date: Tue,  3 Feb 2026 10:38:18 +0100
Message-ID: <20260203093819.2105105-12-jolsa@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203093819.2105105-1-jolsa@kernel.org>
References: <20260203093819.2105105-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding test for attachment of 2 multi tracing links attached
to intersecting functions and making sure both programs are
called properly with proper arguments.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/tracing_multi.c  | 129 ++++++++++++++++++
 .../bpf/progs/tracing_multi_fentry.c          |  16 +++
 2 files changed, 145 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
index 6d45147f0730..3ccf0d4ed1af 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_multi.c
@@ -3,8 +3,12 @@
 #include <test_progs.h>
 
 #ifdef __x86_64__
+#include <bpf/btf.h>
+#include <linux/btf.h>
+#include <search.h>
 #include "tracing_multi_fentry_test.skel.h"
 #include "trace_helpers.h"
+#include "bpf/libbpf_internal.h"
 
 static void multi_fentry_test(void)
 {
@@ -30,10 +34,135 @@ static void multi_fentry_test(void)
 	tracing_multi_fentry_test__destroy(skel);
 }
 
+static int compare(const void *pa, const void *pb)
+{
+	return strcmp((char *) pa, (char *) pb);
+}
+
+static __u32 *get_ids(const char *funcs[], int funcs_cnt)
+{
+	size_t cap = 0, cnt = 0;
+	__u32 nr, type_id;
+	void *root = NULL;
+	__u32 *ids = NULL;
+	struct btf *btf;
+	int i, err = -1;
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
+		return NULL;
+
+	for (i = 0; i < funcs_cnt; i++)
+		tsearch(funcs[i], &root, compare);
+
+	nr = btf__type_cnt(btf);
+	for (type_id = 1; type_id < nr; type_id++) {
+		const struct btf_type *type;
+		const char *str;
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
+		if (!tfind(str, &root, compare))
+			continue;
+
+		err = libbpf_ensure_mem((void **) &ids, &cap, sizeof(*ids), cnt + 1);
+		if (err)
+			break;
+
+		ids[cnt++] = type_id;
+	}
+
+	if (err)
+		free(ids);
+	btf__free(btf);
+	return ids;
+}
+
+static void multi_fentry_intersected_test(void)
+{
+	struct tracing_multi_fentry_test *skel = NULL;
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	LIBBPF_OPTS(bpf_test_run_opts, topts);
+	const char *funcs_1[] = {
+		"bpf_fentry_test1",
+		"bpf_fentry_test2",
+		"bpf_fentry_test3",
+		"bpf_fentry_test4",
+		"bpf_fentry_test5",
+	};
+	const char *funcs_2[] = {
+		"bpf_fentry_test4",
+		"bpf_fentry_test5",
+		"bpf_fentry_test6",
+		"bpf_fentry_test7",
+		"bpf_fentry_test8",
+	};
+	__u32 *ids_1 = NULL, *ids_2 = NULL;
+	size_t cnt_1 = ARRAY_SIZE(funcs_1);
+	size_t cnt_2 = ARRAY_SIZE(funcs_2);
+	struct bpf_link *link_1 = NULL;
+	struct bpf_link *link_2 = NULL;
+	int err, prog_fd;
+
+	skel = tracing_multi_fentry_test__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "fentry_multi_skel_load"))
+		goto cleanup;
+
+	ids_1 = get_ids(funcs_1, cnt_1);
+	if (!ASSERT_OK_PTR(ids_1, "get_ids"))
+		goto cleanup;
+	ids_2 = get_ids(funcs_2, cnt_2);
+	if (!ASSERT_OK_PTR(ids_2, "get_ids"))
+		goto cleanup;
+
+	opts.btf_ids = ids_1;
+	opts.cnt = cnt_1;
+
+	link_1 = bpf_program__attach_tracing_multi(skel->progs.test_1, NULL, &opts);
+	if (!ASSERT_OK_PTR(link_1, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	opts.btf_ids = ids_2;
+	opts.cnt = cnt_2;
+
+	link_2 = bpf_program__attach_tracing_multi(skel->progs.test_2, NULL, &opts);
+	if (!ASSERT_OK_PTR(link_2, "bpf_program__attach_tracing_multi"))
+		goto cleanup;
+
+	prog_fd = bpf_program__fd(skel->progs.test);
+	err = bpf_prog_test_run_opts(prog_fd, &topts);
+	ASSERT_OK(err, "test_run");
+
+	ASSERT_EQ(skel->bss->test_result_2, 5, "test_result");
+	ASSERT_EQ(skel->bss->test_result_3, 5, "test_result");
+
+cleanup:
+	free(ids_1);
+	free(ids_2);
+	bpf_link__destroy(link_1);
+	bpf_link__destroy(link_2);
+	tracing_multi_fentry_test__destroy(skel);
+}
+
 void __test_tracing_multi_test(void)
 {
 	if (test__start_subtest("fentry/simple"))
 		multi_fentry_test();
+	if (test__start_subtest("fentry/intersected"))
+		multi_fentry_intersected_test();
 }
 #else
 void __test_tracing_multi_test(void)
diff --git a/tools/testing/selftests/bpf/progs/tracing_multi_fentry.c b/tools/testing/selftests/bpf/progs/tracing_multi_fentry.c
index 628734596114..47857209bf9f 100644
--- a/tools/testing/selftests/bpf/progs/tracing_multi_fentry.c
+++ b/tools/testing/selftests/bpf/progs/tracing_multi_fentry.c
@@ -6,6 +6,8 @@
 char _license[] SEC("license") = "GPL";
 
 __u64 test_result_1 = 0;
+__u64 test_result_2 = 0;
+__u64 test_result_3 = 0;
 
 __hidden extern void multi_arg_check(__u64 *ctx, __u64 *test_result);
 
@@ -15,3 +17,17 @@ int BPF_PROG(test, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f)
 	multi_arg_check(ctx, &test_result_1);
 	return 0;
 }
+
+SEC("fentry.multi")
+int BPF_PROG(test_1, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f)
+{
+	multi_arg_check(ctx, &test_result_2);
+	return 0;
+}
+
+SEC("fentry.multi")
+int BPF_PROG(test_2, __u64 a, __u64 b, __u64 c, __u64 d, __u64 e, __u64 f)
+{
+	multi_arg_check(ctx, &test_result_3);
+	return 0;
+}
-- 
2.52.0

