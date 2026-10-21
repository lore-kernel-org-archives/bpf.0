Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612753;
	b=5QDMeBrcL152U95g4jvTRgzlwVbqQ4uB1rhCJdFJYTwMiaVUzWdkfVGHeeZKhHQeZWFa
	 qq1uQH1gmGEpq45ozJwwi7i8GnzEDJ0agfyxKydw6xg7A5mX2mKqacA4wd1TXS1lQhkFo
	 rXbMLb8E2VJYPReCGoBgGGBuz4qmALZHSg41+z7ADv4Mbm0+bxVLLjEnrZxmruORjM/Zv
	 9ii6cNMv2ucR3QXka28208Wt+upVsPSIUuD8UbYzf/iLqsdQIWe77jYYpXpaxEzf5pBfo
	 u35g/Jh9PLd+/ld5r+J+RapufG9EvEStV1ScvYW2luiP9H1TPtVwpFw7BjuXNvD7prw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612753;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KsD1+5qDV4QT7mV8iObkp0UpjNunR2mAhMdpCp7lNXs=;
	b=tjyetRARjEd8HdA+nfAf2ZAJpY+oCFH8XEa7q5xtAzOuPDVto1mmALXAnq3t7XpTqgZk
	 08cAJIAHzjOhH9ENNsuqQR5L/9BhOB5NpfmIEP4AxnJYJUuKH6z1TMojOjGgzu5n92wRG
	 SScObxVAmYAJOT6uxiTtmGrE2O4sNqUrcoHVtXCqKDnaKEMOgW+qTcMmNKqTUEqLXAHtW
	 7Tdu85MxelHaHofK2pEaQX/ggsjE7It+L6fBqDCKrJq+LtdQ/ObHy4lkzTXvIsCK8nVV4
	 7wLRPqAtESZcUORRCKsD8Nw071MuHTpqTwdt9FWfgNd4hcU7Dij/htvI1W9QeCxHmsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqmoVkDO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04762606A31A;
	Wed, 21 Oct 2026 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nqmoVkDO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D5F1F000C1;
	Wed, 21 Oct 2026 19:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792612752;
	bh=KsD1+5qDV4QT7mV8iObkp0UpjNunR2mAhMdpCp7lNXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nqmoVkDOOnG02x+NPAWgyBnquKdWN0g6r3nu8oQY0BFBy4nzd7ZlUldFbwc4Liztn
	 nl+OW9EsEmG/m96pR+Vp++uoolszVmRz6ZW+YgsY+AAvV8Iurw9HMiRDQMttOVSgsO
	 88gFxLl7hScsLTF/nPToKVrVbDCZO0cgE+qNx3OO/MNX3pskiRRLmPEdVsjyYJk41I
	 zC+rIGQ53WZDEb+fO/qRUNWuG87PY1UhuiWZAQsq8DYP6mTYcC8fGRAOQDVbHzYRqZ
	 1K0Q0vSxtu89bJLxNi/Cy352Y4Apkrc9xNYmFRIZWS4YUtwjYzF7WuGl/Sj4yvqLej
	 HGHzOqMpFF5ew==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: [RFC bpf-next 6/9] selftests/bpf: Add user page allocation test
Date: Wed, 21 Oct 2026 21:57:55 +0200
Message-ID: <20261021195759.119421-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021195759.119421-1-jolsa@kernel.org>
References: <20261021195759.119421-1-jolsa@kernel.org>
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

Check that consecutive allocations remain separate VMAs and
that user page can be allocated again after unmapping.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/user_page.c      | 152 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/user_page.c |  31 ++++
 2 files changed, 183 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/user_page.c
 create mode 100644 tools/testing/selftests/bpf/progs/user_page.c

diff --git a/tools/testing/selftests/bpf/prog_tests/user_page.c b/tools/testing/selftests/bpf/prog_tests/user_page.c
new file mode 100644
index 000000000000..ff51e7c598a9
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/user_page.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include <sys/mman.h>
+#include <sys/personality.h>
+#include <unistd.h>
+
+#include "user_page.skel.h"
+
+enum {
+	USER_PAGE_ALLOC = 1,
+};
+
+static noinline void user_page_trigger(void)
+{
+	asm volatile ("");
+}
+
+static bool check_user_page_vma(void *addr, long size, const char *perms)
+{
+	unsigned long start, end;
+	bool found = false;
+	char vma_perms[5];
+	char line[512];
+	FILE *maps;
+
+	maps = fopen("/proc/self/maps", "r");
+	if (!ASSERT_OK_PTR(maps, "open_maps"))
+		return false;
+
+	while (fgets(line, sizeof(line), maps)) {
+		if (sscanf(line, "%lx-%lx %4s", &start, &end, vma_perms) != 3 ||
+		    (unsigned long)addr < start || (unsigned long)addr >= end)
+			continue;
+		found = ASSERT_EQ(start, (unsigned long)addr, "vma_start") &&
+			ASSERT_EQ(end - start, size, "vma_size") &&
+			(!perms || ASSERT_STREQ(vma_perms, perms, "vma_perms"));
+		break;
+	}
+	fclose(maps);
+	return ASSERT_TRUE(found, "user_page_vma");
+}
+
+static bool alloc_user_pages(struct user_page *skel, unsigned long nr_pages,
+			     long *addr)
+{
+	skel->bss->nr_pages = nr_pages;
+	skel->bss->action = USER_PAGE_ALLOC;
+	user_page_trigger();
+	if (!ASSERT_GE(skel->bss->user_addr, 0, "user_addr"))
+		return false;
+
+	*addr = skel->bss->user_addr;
+	return true;
+}
+
+static void test_allocations(struct user_page *skel)
+{
+	void *pages[2] = { MAP_FAILED, MAP_FAILED };
+	long page_size = sysconf(_SC_PAGESIZE);
+	const unsigned long nr_pages = 3;
+	long addr;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pages); i++) {
+		if (!alloc_user_pages(skel, nr_pages, &addr))
+			goto out;
+		pages[i] = (void *)addr;
+	}
+
+	/* Back-to-back allocations must remain individual VMAs. */
+	for (i = 0; i < ARRAY_SIZE(pages); i++) {
+		if (!check_user_page_vma(pages[i], page_size * nr_pages, NULL))
+			break;
+	}
+
+out:
+	for (i = 0; i < ARRAY_SIZE(pages); i++)
+		if (pages[i] != MAP_FAILED)
+			munmap(pages[i], page_size * nr_pages);
+}
+
+static void test_reallocate_after_unmap(struct user_page *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	long addr = -1;
+
+	if (!alloc_user_pages(skel, 1, &addr))
+		goto out;
+
+	if (!ASSERT_OK(munmap((void *)addr, page_size), "munmap"))
+		goto out;
+
+	addr = -1;
+	alloc_user_pages(skel, 1, &addr);
+
+out:
+	if (addr >= 0)
+		munmap((void *)addr, page_size);
+}
+
+static void test_read_implies_exec(struct user_page *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	long addr = -1;
+	int old_personality, set_personality;
+
+	old_personality = personality(0xffffffffUL);
+	if (!ASSERT_NEQ(old_personality, -1, "get_personality"))
+		return;
+
+	set_personality = old_personality | READ_IMPLIES_EXEC;
+	if (!ASSERT_NEQ(personality(set_personality), -1, "set_personality"))
+		return;
+
+	skel->bss->action = USER_PAGE_ALLOC;
+	skel->bss->nr_pages = 1;
+	user_page_trigger();
+	if (!ASSERT_GE(skel->bss->user_addr, 0, "read_implies_exec_alloc_ret"))
+		goto out;
+	addr = skel->bss->user_addr;
+	check_user_page_vma((void *)addr, page_size, "rw-p");
+
+out:
+	if (addr >= 0)
+		munmap((void *)addr, page_size);
+	ASSERT_EQ(personality(old_personality), set_personality,
+		  "restore_personality");
+}
+
+void test_user_page(void)
+{
+	struct user_page *skel;
+
+	skel = user_page__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	skel->bss->monitored_pid = getpid();
+	if (!ASSERT_OK(user_page__attach(skel), "attach"))
+		goto out;
+
+	if (test__start_subtest("allocations"))
+		test_allocations(skel);
+	if (test__start_subtest("reallocate_after_unmap"))
+		test_reallocate_after_unmap(skel);
+	if (test__start_subtest("read_implies_exec"))
+		test_read_implies_exec(skel);
+
+out:
+	user_page__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/user_page.c b/tools/testing/selftests/bpf/progs/user_page.c
new file mode 100644
index 000000000000..6dd9417463df
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/user_page.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+#define USER_PAGE_ALLOC 1
+
+int monitored_pid;
+int action;
+long user_addr;
+unsigned long nr_pages;
+
+SEC("uprobe.s//proc/self/exe:user_page_trigger")
+int user_page_test(struct pt_regs *ctx)
+{
+	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
+		return 0;
+
+	switch (action) {
+	case USER_PAGE_ALLOC:
+		user_addr = bpf_user_page_alloc(nr_pages);
+		break;
+	}
+
+	return 0;
+}
-- 
2.54.0

