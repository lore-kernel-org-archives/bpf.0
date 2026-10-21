Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612784;
	b=r6TBVtG1KQql5W9miZJwDE2CJiCKhLDLJ82NkG7doj7w6IO6vDwFla9O/TRhWKtjgFHb
	 QkhvbkzZovi3yLYsgVNqpoFUj2GTU9OLBn+urNjBqQ2uW3xrHQUT6b2xH8AzUBxloyZrQ
	 uifapRK1Rf+wo9qzdrzlViGEXBjWlazFjUcsRRrbj7MFEStkJCmH7h9Vu04OoUXkrSrJ1
	 Q08f7tvPsR/e+D4pA9y1BOKf0Qn4dkF0tQuPqvvJmUnPf0IDDImoAGKWg9hy/ax9uXCj+
	 Wm809dIoqL0NsiL6etAyEfnHJo13HY/AEV0vBVeL5eRjj5TUB1TQH2FmjEYBOn6GILw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612784;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fiJLJWbXoWyY6A/386yIPXP7rjQV8aKUb+bgkajzRr4=;
	b=2RVzvT/yq+8ewU2rIJV6FKrtZuFqHwqLMaXUqxOWi21FMeIHmXppqZqakMvqKSdyxoaq
	 jnk8w4OTzLrJPdSABiKWcsxqHjpWVAmKN9zq56jgYT75YROqFe+UyZTAQ1flUITSHIdKZ
	 T9dBlIVDJjTEXIXqC4fyPGLuP6pX5sXmaOpnPNd0T67eQT9nYJk9lDz4IanpVeMs5l/cq
	 1YjlN4k6/mBWjmcwfTolYTPi0uwyn2OhtC9nop1+jrecNa6bMQxryOKoxSGlFgicU0wTy
	 rgJh2oKe4wsrnu9WiPWQKB+o4x/mFWq7I21F4d7jzM8tNOZyEGvOC7EpT6O4xT4xRDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYG6kLv4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D1606A319;
	Wed, 21 Oct 2026 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BYG6kLv4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48071F000C1;
	Wed, 21 Oct 2026 19:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792612783;
	bh=fiJLJWbXoWyY6A/386yIPXP7rjQV8aKUb+bgkajzRr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BYG6kLv4j2Puk+9eO0FeXpoWN0S5OYiv4Z2dAOAp300aRxiMh1caa0v9DwJ8TXxUX
	 FlMSDK0CpLysgrhQ11psU0siBYFKixWQ/FdFqM6WQxzUl2nw6gDZJyxECIXY5lSun+
	 MZzhdFcoRvE0UcLF7rcEbR+axF3cQNo7+qvQmH5a2KCIyBoqq1f/YPy3RepCAJ4xL1
	 ZYLoTkqMQdSKWSnYLptlu24+5OlBYFkYXAAmykYFnnCgfniV2YLitNVOvAvzcgag/a
	 HliuwSFSCmiUkJkqdKXIP5xHceZ5jibgq39fQKTjUCWpVjyzzxU0eps+7XG38X4KAi
	 FF6Def+IAnCWQ==
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
Subject: [RFC bpf-next 9/9] selftests/bpf: Add user page failures test
Date: Wed, 21 Oct 2026 21:57:58 +0200
Message-ID: <20261021195759.119421-10-jolsa@kernel.org>
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

Cover expected failures for invalid allocation sizes, misaligned or
unrelated exec requests, replacement of sealed mappings, repeated
execution, bad writes and attempts to restore write permission.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/user_page.c      | 141 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/user_page.c |   5 +
 2 files changed, 146 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/user_page.c b/tools/testing/selftests/bpf/prog_tests/user_page.c
index 74ce52d726ec..107349aace94 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_page.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_page.c
@@ -12,6 +12,7 @@ enum {
 	USER_PAGE_EXEC = 2,
 	USER_PAGE_EXEC_ONLY = 3,
 	USER_PAGE_WRITE = 4,
+	USER_PAGE_BAD_WRITE = 5,
 };
 
 static noinline void user_page_trigger(void)
@@ -209,6 +210,144 @@ static void test_faultable_write(struct user_page *skel)
 		munmap((void *)addr, page_size);
 }
 
+static void test_invalid_allocation_size(struct user_page *skel)
+{
+	skel->bss->action = USER_PAGE_ALLOC;
+	skel->bss->nr_pages = 0;
+	user_page_trigger();
+	if (!ASSERT_EQ(skel->bss->user_addr, -EINVAL, "zero_pages_ret"))
+		return;
+
+	skel->bss->nr_pages = ~0UL;
+	user_page_trigger();
+	ASSERT_EQ(skel->bss->user_addr, -EINVAL, "overflow_pages_ret");
+}
+
+static void test_misaligned_exec(struct user_page *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	long addr = -1;
+
+	if (!alloc_user_pages(skel, 1, &addr))
+		return;
+
+	skel->bss->exec_addr = addr + 1;
+	skel->bss->action = USER_PAGE_EXEC_ONLY;
+	user_page_trigger();
+	ASSERT_EQ(skel->bss->exec_ret, -EINVAL, "misaligned_exec_ret");
+
+	if (addr >= 0)
+		munmap((void *)addr, page_size);
+}
+
+static void test_reject_replacement(struct user_page *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	long addr = -1;
+	void *ret;
+
+	if (!alloc_user_pages(skel, 1, &addr))
+		return;
+
+	ret = mmap((void *)addr, page_size, PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+	if (!ASSERT_EQ(ret, (void *)addr, "replace_mmap"))
+		goto out;
+
+	skel->bss->exec_addr = addr;
+	skel->bss->action = USER_PAGE_EXEC_ONLY;
+	user_page_trigger();
+	ASSERT_EQ(skel->bss->exec_ret, -EINVAL, "replacement_not_bpf");
+
+out:
+	if (addr >= 0)
+		munmap((void *)addr, page_size);
+}
+
+static void test_bad_write(struct user_page *skel)
+{
+	skel->bss->action = USER_PAGE_BAD_WRITE;
+	user_page_trigger();
+	ASSERT_EQ(skel->bss->write_ret, -EFAULT, "bad_write_ret");
+}
+
+static void test_unrelated_mapping_exec_rejected(struct user_page *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	void *unrelated;
+
+	unrelated = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (!ASSERT_NEQ(unrelated, MAP_FAILED, "unrelated_mmap"))
+		return;
+
+	skel->bss->exec_addr = (long)unrelated;
+	skel->bss->action = USER_PAGE_EXEC_ONLY;
+	user_page_trigger();
+	ASSERT_EQ(skel->bss->exec_ret, -EINVAL, "bad_exec_ret");
+
+	munmap(unrelated, page_size);
+}
+
+static void test_repeat_exec_rejected(struct user_page *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	long addr = -1;
+
+	if (!alloc_user_pages(skel, 1, &addr))
+		return;
+
+	skel->bss->exec_addr = addr;
+	skel->bss->action = USER_PAGE_EXEC_ONLY;
+	user_page_trigger();
+	if (!ASSERT_OK(skel->bss->exec_ret, "first_exec_ret"))
+		goto out;
+	user_page_trigger();
+
+	ASSERT_EQ(skel->bss->exec_ret, -EINVAL, "repeat_exec_ret");
+
+out:
+	if (addr >= 0)
+		munmap((void *)addr, page_size);
+}
+
+static void test_exec_write_protection(struct user_page *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	long addr = -1;
+
+	if (!alloc_user_pages(skel, 1, &addr))
+		return;
+
+	skel->bss->exec_addr = addr;
+	skel->bss->action = USER_PAGE_EXEC_ONLY;
+	user_page_trigger();
+	if (!ASSERT_OK(skel->bss->exec_ret, "exec_ret"))
+		goto out;
+
+	errno = 0;
+	if (!ASSERT_EQ(mprotect((void *)addr, page_size,
+				PROT_READ | PROT_WRITE), -1, "restore_write"))
+		goto out;
+
+	ASSERT_EQ(errno, EACCES, "restore_write_errno");
+
+out:
+	if (addr >= 0)
+		munmap((void *)addr, page_size);
+}
+
+static void test_fails(struct user_page *skel)
+{
+	test_invalid_allocation_size(skel);
+	test_misaligned_exec(skel);
+	test_reject_replacement(skel);
+	test_bad_write(skel);
+	test_unrelated_mapping_exec_rejected(skel);
+	test_repeat_exec_rejected(skel);
+	test_exec_write_protection(skel);
+}
+
 void test_user_page(void)
 {
 	struct user_page *skel;
@@ -233,6 +372,8 @@ void test_user_page(void)
 		test_partial_exec(skel);
 	if (test__start_subtest("faultable_write"))
 		test_faultable_write(skel);
+	if (test__start_subtest("fails"))
+		test_fails(skel);
 
 out:
 	user_page__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/user_page.c b/tools/testing/selftests/bpf/progs/user_page.c
index a855b0b46350..530a0be3737b 100644
--- a/tools/testing/selftests/bpf/progs/user_page.c
+++ b/tools/testing/selftests/bpf/progs/user_page.c
@@ -12,6 +12,7 @@ char _license[] SEC("license") = "GPL";
 #define USER_PAGE_EXEC 2
 #define USER_PAGE_EXEC_ONLY 3
 #define USER_PAGE_WRITE 4
+#define USER_PAGE_BAD_WRITE 5
 
 int monitored_pid;
 int action;
@@ -50,6 +51,10 @@ int user_page_test(struct pt_regs *ctx)
 		write_ret = bpf_probe_write_user_faultable((void *)user_addr, data,
 							   sizeof(data));
 		break;
+	case USER_PAGE_BAD_WRITE:
+		write_ret = bpf_probe_write_user_faultable((void *)1, data,
+							    sizeof(data));
+		break;
 	}
 
 	return 0;
-- 
2.54.0

