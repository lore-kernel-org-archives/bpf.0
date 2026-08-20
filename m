Received: from mta0.migadu.com (out-49.mta0.migadu.com [91.218.175.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1BC1429D
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 00:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787184413; cv=none; b=ZtZGLqiq2urvPUGfLuXkTbFgbC6B0GlRD/SOjTy+NGAZVa3UyvoEslSY/LoHorPq/uhCfrcVcRu6mgikMLhsAqH9cKvX4wRWf7aSIxb5R8TcKKbnMZXC8EZPqINdD5UhUND5p8ghAlqgQSJwOP8Qk0ZPGd/zlRU752yfknMcLa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787184413; c=relaxed/simple;
	bh=ifCoXQy50ltvF/jEkbmNyiIDKiWmEWdLhRTcLQgVB+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/WXaZz6RNIbg2DEbP/RB397bidO4NU7BAwV5GQrJuaQaCaFJPICnLCe02l1QtDXUXFiGvWziY9KXyMqOrFSwL2kWcGkaVlPgd6I7J+m2zB1yjWvEDFFx36NJV9761g1ekbm79QQmSyAE5ZTAnBN3f6/uQI4T91oTdDLe5VCSd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vzxbqxMS; arc=none smtp.client-ip=91.218.175.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vzxbqxMS"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ifCoXQy50ltvF/jEkbmNyiIDKiWmEWdLhRTcLQgVB+o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787184408; v=1; x=1787789208;
 b=vzxbqxMSTir0ZjvtvHNwQ2+YRCtANgH120Pw/oSjtjhCZb8+6y5IvRDoFH5nDJs0an8fBYSB
 d0IOn7zIDN0NeZCS3CUrzoF+TxoMJrmbJkAR2UL5KYrkZNwTfFZWJL63eNyb5Pwy8zN8NOdlViW
 RfAWtCvB3sne6BKB0jq58uM8=
X-Envelope-To: bpf@vger.kernel.org
Received: from isolodrai-fedora-MJ0FVMD1.thefacebook.com (2620:10d:c090:500::5:942a)
	by mta11.migadu.com with ESMTPS id d4a3c71138d44b5b;
	Thu, 20 Aug 2026 00:06:48 +0000
X-Mizu-Trace-ID: d4a3c71138d44b5b
X-Migadu-Flow: FLOW_OUT
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next v1 2/4] selftests/bpf: Add tests for bpftool btf dump format c
Date: Wed, 19 Aug 2026 17:06:25 -0700
Message-ID: <20260820000627.3826188-3-ihor.solodrai@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
References: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"bpftool btf dump format c" generates the vmlinux.h that BPF programs
are built against, and it has no test coverage at all. The only
in-tree consumers are build systems, and none of them diff the result.

Building against the header only catches what a compiler rejects.
Missing macros, a missing preserve_access_index pragma and the wrong
padding width all compile.

Add a test for those three, over both sort orderings.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 .../bpf/prog_tests/bpftool_btf_dump.c         | 151 ++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c

diff --git a/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
new file mode 100644
index 000000000000..53bb7065b3ca
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/bpftool_btf_dump.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpftool_helpers.h>
+#include <bpf/btf.h>
+#include <unistd.h>
+
+#define DUMP_BUF_SZ	(16 * 1024)
+
+static int btf_to_tmpfile(struct btf *btf, char *path, size_t path_sz)
+{
+	const void *raw;
+	ssize_t written;
+	__u32 sz;
+	int fd;
+
+	raw = btf__raw_data(btf, &sz);
+	if (!ASSERT_OK_PTR(raw, "raw_data"))
+		return -1;
+
+	snprintf(path, path_sz, "/tmp/bpftool_btf_dump.XXXXXX");
+	fd = mkstemp(path);
+	if (!ASSERT_OK_FD(fd, "mkstemp"))
+		return -1;
+
+	written = write(fd, raw, sz);
+	close(fd);
+	if (!ASSERT_EQ(written, sz, "write_btf")) {
+		unlink(path);
+		return -1;
+	}
+	return 0;
+}
+
+static char *dump_c(const char *path, bool sorted)
+{
+	char args[MAX_BPFTOOL_CMD_LEN];
+	char *buf;
+	int err;
+
+	buf = malloc(DUMP_BUF_SZ);
+	if (!ASSERT_OK_PTR(buf, "alloc"))
+		return NULL;
+
+	snprintf(args, sizeof(args), "btf dump file %s format c%s",
+		 path, sorted ? "" : " unsorted");
+	err = get_bpftool_command_output(args, buf, DUMP_BUF_SZ);
+	if (!ASSERT_OK(err, "dump")) {
+		free(buf);
+		return NULL;
+	}
+	return buf;
+}
+
+/*
+ * struct holey { int c; <32 bit hole> int tail; };
+ *
+ * One record with a hole, and a 4-byte long to pad it with. How records
+ * themselves are rendered is already covered by the build, so the fixture does
+ * not need to be more elaborate than that.
+ */
+static struct btf *mk_btf(void)
+{
+	struct btf *btf;
+	int id, err;
+
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "new_empty"))
+		return NULL;
+
+	id = btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	if (!ASSERT_EQ(id, 1, "int"))
+		goto err_out;
+
+	id = btf__add_int(btf, "long int", 4, BTF_INT_SIGNED);
+	if (!ASSERT_GT(id, 0, "long"))
+		goto err_out;
+
+	id = btf__add_struct(btf, "holey", 16);
+	if (!ASSERT_GT(id, 0, "struct_holey"))
+		goto err_out;
+
+	err = btf__add_field(btf, "c", 1, 0, 0);
+	if (!ASSERT_OK(err, "holey_c"))
+		goto err_out;
+
+	err = btf__add_field(btf, "tail", 1, 96, 0);
+	if (!ASSERT_OK(err, "holey_tail"))
+		goto err_out;
+
+	btf__set_pointer_size(btf, 4);
+
+	return btf;
+err_out:
+	btf__free(btf);
+	return NULL;
+}
+
+/*
+ * Check only what the selftests build cannot:
+ *   - bpf_helpers.h defines __ksym and __weak as well, and no program uses
+ *     __bpf_fastcall, so losing the macro block changes nothing;
+ *   - building without the preserve_access_index pragma is a supported mode
+ *     (BPF_NO_PRESERVE_ACCESS_INDEX), so losing it only costs CO-RE;
+ *   - the padding width comes from the BTF's pointer size, and a native build
+ *     never runs the host bpftool over a differently sized target's BTF.
+ */
+static void test_dump(const char *path, bool sorted)
+{
+	char *buf;
+
+	buf = dump_c(path, sorted);
+	if (!buf)
+		return;
+
+	ASSERT_HAS_SUBSTR(buf, "#define __ksym __attribute__((section(\".ksyms\")))",
+			  "ksym");
+	ASSERT_HAS_SUBSTR(buf, "#define __weak __attribute__((weak))", "weak");
+	ASSERT_HAS_SUBSTR(buf, "#define __bpf_fastcall __attribute__((bpf_fastcall))",
+			  "bpf_fastcall");
+
+	ASSERT_HAS_SUBSTR(buf, "#ifndef BPF_NO_PRESERVE_ACCESS_INDEX", "pai_guard");
+	ASSERT_HAS_SUBSTR(buf,
+			  "#pragma clang attribute push (__attribute__((preserve_access_index)), apply_to = record)",
+			  "pai_push");
+	ASSERT_HAS_SUBSTR(buf, "#pragma clang attribute pop", "pai_pop");
+
+	ASSERT_HAS_SUBSTR(buf, "long: 32;", "target_ptr_size");
+
+	free(buf);
+}
+
+void test_bpftool_btf_dump(void)
+{
+	char path[PATH_MAX];
+	struct btf *btf;
+
+	btf = mk_btf();
+	if (!btf)
+		return;
+	if (btf_to_tmpfile(btf, path, sizeof(path)))
+		goto out;
+
+	if (test__start_subtest("c_sorted"))
+		test_dump(path, true);
+	if (test__start_subtest("c_unsorted"))
+		test_dump(path, false);
+
+	unlink(path);
+out:
+	btf__free(btf);
+}
-- 
2.55.0

