Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC83383339
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 21:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782768163; cv=none; b=MCXZ8/j2+kYXMIxKyFh+TPaY4PODouynun/vq/NmiJ+rnkWTi0CAA30epz+y+DdkTSYzrxvS5r/dE64i+8Gl/MzJQnmIB/JBcHnEcC2jSH1vD4gTSEeK6Ylc6QRkqtyNltV5p4ST2y0Ie1Xq0nOsQt95yR4gBk1wCoq29SfOBes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782768163; c=relaxed/simple;
	bh=0otD3Oqmy4j99sefEygOz0a6SWAEc7Sm0+L9rBajsrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdyNXfK7gyTDN2anYXBScC3rFEvar5SiJ3UXxef3ACG4OvKc2eRVOTZK8LXU9aJhaylckvjttL8mn8vgPnpc4SWxzTuh6F9L6HeuHSOe+oFrtuwv2t1DkQLovg8TKri+vOu2UwV/Jzd9pT2rLWqwUAoypxrRfmMA4yOMplDy4Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFXTECwR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFXTECwR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C1C1F000E9;
	Mon, 29 Jun 2026 21:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782768161;
	bh=TVh9TSlAzdDYvuhvwG2FW0z/Weh5SVAwlhAKy2yrsoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QFXTECwRVqoBf/bIrGINmAJQsDj2+o/666mVeovoRQ6jaahZC6xv+rOdBbp4GVh3K
	 9th6BMJbpXaLLx8VTrx7Nz/d8nIaNxVtwBqEIGGhiBZ+wun9y9EFUGTt3K0bHN/WRj
	 D2VhqDRJBRtPHVkjf2mI1h7SBvAuLJgO805/QmsI2wfD/EXTZCcULUdN0BK3kj/iqg
	 FFINNZDb/uJfYFZplBC3TpA7ipTMhU31qjA0pYXh2bZIKn+tzW4lb5m9/RwHHSrIzx
	 TMZq3bAZbeDC9TFmg2T1VuOREdaptYA4CuNyUuWb8QXhLTgVcliM6PK0JKcz8LesSa
	 IZbBAyW9j7g9A==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCHv4 bpf-next 2/3] selftests/bpf: Add tracing_multi link info tests
Date: Mon, 29 Jun 2026 23:22:07 +0200
Message-ID: <20260629212208.895962-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629212208.895962-1-jolsa@kernel.org>
References: <20260629212208.895962-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adding tracing_multi link info tests that follow the kprobe_multi
and uprobe_multi tests logic.

Assisted-by: Codex:GPT-5
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/fill_link_info.c | 242 ++++++++++++++++++
 .../selftests/bpf/progs/test_fill_link_info.c |   6 +
 2 files changed, 248 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index f589eefbf9fb..0918321c8e63 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -4,6 +4,7 @@
 #include <string.h>
 #include <linux/bpf.h>
 #include <linux/limits.h>
+#include <bpf/btf.h>
 #include <test_progs.h>
 #include "trace_helpers.h"
 #include "test_fill_link_info.skel.h"
@@ -24,6 +25,22 @@ static __u64 kmulti_cookies[] = { 3, 1, 2 };
 #define KPROBE_FUNC "bpf_fentry_test1"
 static __u64 kprobe_addr;
 
+static const char * const tmulti_syms[] = {
+	"bpf_fentry_test2",
+	"bpf_fentry_test1",
+	"bpf_fentry_test3",
+};
+
+static __u64 tmulti_cookies[] = { 30, 10, 20 };
+#define TRACING_MULTI_CNT ARRAY_SIZE(tmulti_syms)
+
+struct tmulti_target {
+	const char *name;
+	__u64 addr;
+	__u64 cookie;
+	__u32 id;
+};
+
 #define UPROBE_FILE "/proc/self/exe"
 static ssize_t uprobe_offset;
 /* uprobe attach point */
@@ -396,6 +413,224 @@ static void test_kprobe_multi_fill_link_info(struct test_fill_link_info *skel,
 	bpf_link__destroy(link);
 }
 
+static int tmulti_target_cmp(const void *a, const void *b)
+{
+	const struct tmulti_target *ta = a;
+	const struct tmulti_target *tb = b;
+
+	return (ta->id > tb->id) - (ta->id < tb->id);
+}
+
+static int setup_tmulti_targets(const struct bpf_program *prog,
+				struct tmulti_target *targets,
+				__u32 *btf_obj_id)
+{
+	struct bpf_prog_info prog_info;
+	__u32 len = sizeof(prog_info);
+	struct btf *btf;
+	int err, i;
+	__s32 id;
+
+	btf = btf__load_vmlinux_btf();
+	if (!ASSERT_OK_PTR(btf, "btf__load_vmlinux_btf"))
+		return -1;
+
+	for (i = 0; i < TRACING_MULTI_CNT; i++) {
+		id = btf__find_by_name_kind(btf, tmulti_syms[i], BTF_KIND_FUNC);
+		if (!ASSERT_GT(id, 0, "btf__find_by_name_kind"))
+			goto error;
+
+		targets[i].name = tmulti_syms[i];
+		targets[i].addr = ksym_get_addr(tmulti_syms[i]);
+		targets[i].cookie = tmulti_cookies[i];
+		targets[i].id = id;
+	}
+
+	memset(&prog_info, 0, len);
+	err = bpf_prog_get_info_by_fd(bpf_program__fd(prog), &prog_info, &len);
+	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd"))
+		goto error;
+	if (!ASSERT_GT(prog_info.attach_btf_obj_id, 0, "attach_btf_obj_id"))
+		goto error;
+	*btf_obj_id = prog_info.attach_btf_obj_id;
+
+	/*
+	 * The kernel tracing multi attach sorts ids. We sort as well,
+	 * so we can easily compare ids and cookies later.
+	 */
+	qsort(targets, TRACING_MULTI_CNT, sizeof(targets[0]), tmulti_target_cmp);
+	btf__free(btf);
+	return 0;
+
+error:
+	btf__free(btf);
+	return -1;
+}
+
+static int verify_tracing_multi_link_info(int fd, const struct bpf_program *prog,
+					  const struct tmulti_target *targets,
+					  __u32 btf_obj_id, bool has_cookies)
+{
+	enum bpf_attach_type attach_type = bpf_program__expected_attach_type(prog);
+	__u64 addrs[TRACING_MULTI_CNT], cookies[TRACING_MULTI_CNT];
+	__u32 ids[TRACING_MULTI_CNT];
+	struct bpf_link_info info;
+	__u32 len = sizeof(info);
+	int err, i;
+
+	memset(&info, 0, sizeof(info));
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	if (!ASSERT_OK(err, "bpf_link_get_info_by_fd"))
+		return -1;
+
+	if (!ASSERT_EQ(info.type, BPF_LINK_TYPE_TRACING_MULTI, "info.type"))
+		return -1;
+
+	ASSERT_EQ(info.tracing_multi.attach_type, attach_type, "info.tracing_multi.attach_type");
+	ASSERT_EQ(info.tracing_multi.count, TRACING_MULTI_CNT, "info.tracing_multi.count");
+
+	memset(ids, 0, sizeof(ids));
+	memset(cookies, 0, sizeof(cookies));
+	memset(addrs, 0, sizeof(addrs));
+
+	info.tracing_multi.ids = ptr_to_u64(ids);
+	info.tracing_multi.addrs = ptr_to_u64(addrs);
+	info.tracing_multi.cookies = has_cookies ? ptr_to_u64(cookies) : 0;
+	info.tracing_multi.count = TRACING_MULTI_CNT;
+
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	if (!ASSERT_OK(err, "bpf_link_get_info_by_fd"))
+		return -1;
+
+	if (!ASSERT_EQ(info.type, BPF_LINK_TYPE_TRACING_MULTI, "info.type"))
+		return -1;
+
+	ASSERT_EQ(info.tracing_multi.attach_type, attach_type, "info.tracing_multi.attach_type");
+	ASSERT_EQ(info.tracing_multi.count, TRACING_MULTI_CNT, "info.tracing_multi.count");
+	ASSERT_EQ(info.tracing_multi.btf_obj_id, btf_obj_id, "tracing_multi.btf_obj_id");
+
+	for (i = 0; i < TRACING_MULTI_CNT; i++) {
+		ASSERT_EQ(ids[i], targets[i].id, "tracing_multi.ids");
+		ASSERT_EQ(cookies[i], has_cookies ? targets[i].cookie : 0, "tracing_multi.cookies");
+
+		if (targets[i].addr) {
+			struct ksym *ksym;
+
+			if (!ASSERT_NEQ(addrs[i], 0, "tracing_multi.addrs"))
+				return -1;
+			ksym = ksym_search(addrs[i]);
+			if (!ASSERT_OK_PTR(ksym, "ksym_search"))
+				return -1;
+			ASSERT_STREQ(ksym->name, targets[i].name, "tracing_multi.addr_name");
+		} else {
+			ASSERT_EQ(addrs[i], 0, "tracing_multi.addrs");
+		}
+	}
+
+	return 0;
+}
+
+static void verify_tracing_multi_invalid_user_buffer(int fd, const struct tmulti_target *targets)
+{
+	__u32 ids[TRACING_MULTI_CNT] = {};
+	struct bpf_link_info info;
+	__u32 len = sizeof(info);
+	int err, i;
+
+	/* Wrong info setup (ids != NULL and cnt == 0) -> EINVAL */
+	memset(&info, 0, sizeof(info));
+	info.tracing_multi.ids = ptr_to_u64(ids);
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EINVAL, "tracing_multi.invalid_count");
+
+	/* Smaller than actual count provided -> ENOSPC */
+	memset(ids, 0, sizeof(ids));
+	memset(&info, 0, sizeof(info));
+	info.tracing_multi.ids = ptr_to_u64(ids);
+	info.tracing_multi.count = TRACING_MULTI_CNT - 1;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -ENOSPC, "tracing_multi.small_count");
+	for (i = 0; i < TRACING_MULTI_CNT - 1; i++)
+		ASSERT_EQ(ids[i], targets[i].id, "tracing_multi.partial_ids");
+	/* check that the last entry is not populated */
+	ASSERT_EQ(ids[i], 0, "tracing_multi.partial_ids");
+
+	/* Bigger than actual count provided -> OK */
+	memset(ids, 0, sizeof(ids));
+	memset(&info, 0, sizeof(info));
+	info.tracing_multi.ids = ptr_to_u64(ids);
+	info.tracing_multi.count = TRACING_MULTI_CNT + 1;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_OK(err, "tracing_multi.big_count");
+	for (i = 0; i < TRACING_MULTI_CNT; i++)
+		ASSERT_EQ(ids[i], targets[i].id, "tracing_multi.ids");
+
+	/* Invalid ids pointer -> EFAULT */
+	memset(&info, 0, sizeof(info));
+	info.tracing_multi.ids = 0x1;
+	info.tracing_multi.count = TRACING_MULTI_CNT;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EFAULT, "tracing_multi.bad_btf_ids");
+
+	/* Invalid cookies pointer -> EFAULT */
+	memset(&info, 0, sizeof(info));
+	info.tracing_multi.cookies = 0x1;
+	info.tracing_multi.count = TRACING_MULTI_CNT;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EFAULT, "tracing_multi.bad_cookies");
+
+	/* Invalid addrs pointer -> EFAULT */
+	memset(&info, 0, sizeof(info));
+	info.tracing_multi.addrs = 0x1;
+	info.tracing_multi.count = TRACING_MULTI_CNT;
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	ASSERT_EQ(err, -EFAULT, "tracing_multi.bad_addrs");
+}
+
+static void test_tracing_multi_fill_link_info(struct test_fill_link_info *skel,
+					      bool has_cookies, bool invalid)
+{
+	LIBBPF_OPTS(bpf_tracing_multi_opts, opts);
+	struct tmulti_target targets[TRACING_MULTI_CNT];
+	__u32 ids[TRACING_MULTI_CNT], btf_obj_id;
+	__u64 cookies[TRACING_MULTI_CNT];
+	struct bpf_link *link;
+	int link_fd, err, i;
+
+#ifndef __x86_64__
+	test__skip();
+	return;
+#endif
+
+	if (setup_tmulti_targets(skel->progs.tmulti_run, targets, &btf_obj_id))
+		return;
+
+	for (i = 0; i < TRACING_MULTI_CNT; i++) {
+		ids[i] = targets[i].id;
+		cookies[i] = targets[i].cookie;
+	}
+
+	opts.ids = ids;
+	opts.cnt = TRACING_MULTI_CNT;
+	if (has_cookies)
+		opts.cookies = cookies;
+
+	link = bpf_program__attach_tracing_multi(skel->progs.tmulti_run, NULL, &opts);
+	if (!ASSERT_OK_PTR(link, "bpf_program__attach_tracing_multi"))
+		return;
+
+	link_fd = bpf_link__fd(link);
+	if (invalid) {
+		verify_tracing_multi_invalid_user_buffer(link_fd, targets);
+	} else {
+		err = verify_tracing_multi_link_info(link_fd, skel->progs.tmulti_run,
+						     targets, btf_obj_id, has_cookies);
+		ASSERT_OK(err, "verify_tracing_multi_link_info");
+	}
+
+	bpf_link__destroy(link);
+}
+
 #define SEC(name) __attribute__((section(name), used))
 
 static short uprobe_link_info_sema_1 SEC(".probes");
@@ -640,6 +875,13 @@ void test_fill_link_info(void)
 	if (test__start_subtest("kprobe_multi_invalid_ubuff"))
 		test_kprobe_multi_fill_link_info(skel, true, true, true);
 
+	if (test__start_subtest("tracing_multi_link_info")) {
+		test_tracing_multi_fill_link_info(skel, false, false);
+		test_tracing_multi_fill_link_info(skel, true, false);
+	}
+	if (test__start_subtest("tracing_multi_invalid_ubuff"))
+		test_tracing_multi_fill_link_info(skel, true, true);
+
 	if (test__start_subtest("uprobe_multi_link_info"))
 		test_uprobe_multi_fill_link_info(skel, false, false);
 	if (test__start_subtest("uretprobe_multi_link_info"))
diff --git a/tools/testing/selftests/bpf/progs/test_fill_link_info.c b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
index 137bd6292163..c85081538e93 100644
--- a/tools/testing/selftests/bpf/progs/test_fill_link_info.c
+++ b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
@@ -58,4 +58,10 @@ int BPF_PROG(umulti_run)
 	return 0;
 }
 
+SEC("fentry.multi")
+int BPF_PROG(tmulti_run)
+{
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.54.0

