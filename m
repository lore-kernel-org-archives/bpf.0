Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792612763;
	b=ByuU4n/09TT8sgKuA2uqr84/kdG6EJlQhd7Oh51zkK8dKNXCm0Uo0hZD26nxtX8UrtbF
	 hyisdCvyEPPANgZjJooKwK/03TYplA7yQ4cOiRrQleYeHiNPT7qd7CCmi8QeM6j61FGcz
	 82qe9HUllVIDC3//PVqmC1aiozIZVAEbAdzRE0qJ3udAeIDvq+nZFUEnvQpp2bRARaIbf
	 TPBOPIijISkDtAlI8Dkxih8EvjSgyLhoQ68w+FJFKIwyTriXrWJhwis0S8yEwOWkgH+hQ
	 CgLuquet7qxoOgzIi4M6UiHJBE21OLM6gHvWu/sFwlLH1oKiyeDhaNNEDUickqtnSKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792612763;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cSq82ODWtlPwv9NWbfrCiBYmC+9lp/ZNZSCghuo9jNY=;
	b=PNTLLOMGegEcHIXrluZTIx8WRwdta6bC16/XMw5DFEEj0VzcL6jk5RTG5bJJZbLiufEW
	 Nme+Yu/mNc0VTCL6zax+i4i7Wy3OsXE/YIhG5TGcHrgJfk7K4/s0jUOaq230EAdKAVDAK
	 YyHVElOjZlQAYG2htfwUAqJNS8wswmm2CQzUT7BogLbml5sx6AIh5+WEQZ7CYKzRbeRqT
	 Z2c16q8RWmpO5i2NO82KVvcdipKdFYsR0i+HVzV1soT/cfvzc/o4oG5h3/Gv+MEBF32Ne
	 XlSxPakWjOWdsrzbS6vKKKTpQET4lGu9k7qEvsZdnQC0He+5K4FiCkYtbNIgU2kbYVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtpnDB24;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D48D606A319;
	Wed, 21 Oct 2026 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RtpnDB24
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A251F000C4;
	Wed, 21 Oct 2026 19:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792612763;
	bh=cSq82ODWtlPwv9NWbfrCiBYmC+9lp/ZNZSCghuo9jNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RtpnDB24temjgYrxtXmGajbdikbJba8pa5HNRYEKjRtbDe5lpXlmEhjDT/sS3jk0c
	 N17fbdBEJm7xxqIX1BJ6QjaCK/nVjh7+zJFpBqv1UAh+PnccxAJD7GxP19BlJUQi7T
	 iw0ooAN/3UZZjFG0/62O06pQtO7pe321v+x1Ul9CyG0+pMvlETHdhK4bpSEpXxf4+a
	 Z7UC8aK/dJ/N8Ixct4rSj0YDBGrDiI0PGZKYmDUd2njpWBiGh5lcTNPt+hplEsDwMw
	 b91NILcHytqOJ2Zc9lAWTRc7l0ekywd/kI8KRKR8QOJRnft4lBDZxZDERNMAuiinkM
	 9mQq6kFMK8cVg==
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
Subject: [RFC bpf-next 7/9] selftests/bpf: Add uprobe user page exec test
Date: Wed, 21 Oct 2026 21:57:56 +0200
Message-ID: <20261021195759.119421-8-jolsa@kernel.org>
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

Test executable permissions for whole and partial user-page
allocations and execution of code written into a user page.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/user_page.c      | 62 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/user_page.c | 18 ++++++
 2 files changed, 80 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/user_page.c b/tools/testing/selftests/bpf/prog_tests/user_page.c
index ff51e7c598a9..1b5dff2c8ff6 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_page.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_page.c
@@ -9,6 +9,8 @@
 
 enum {
 	USER_PAGE_ALLOC = 1,
+	USER_PAGE_EXEC = 2,
+	USER_PAGE_EXEC_ONLY = 3,
 };
 
 static noinline void user_page_trigger(void)
@@ -128,6 +130,62 @@ static void test_read_implies_exec(struct user_page *skel)
 		  "restore_personality");
 }
 
+static void test_execute_user_page(struct user_page *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	long addr = -1;
+
+#ifndef __x86_64__
+	test__skip();
+	return;
+#endif
+
+	if (!alloc_user_pages(skel, 1, &addr))
+		return;
+
+	skel->bss->exec_addr = addr;
+	skel->bss->action = USER_PAGE_EXEC;
+	user_page_trigger();
+	if (!ASSERT_EQ(skel->bss->write_ret, 0, "exec_write_ret") ||
+	    !ASSERT_EQ(skel->bss->exec_ret, 0, "exec_ret"))
+		goto out;
+
+	ASSERT_EQ(((int (*)(void))addr)(), 42, "execute_user_page");
+
+out:
+	if (addr >= 0)
+		munmap((void *)addr, page_size);
+}
+
+static void test_partial_exec(struct user_page *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	long addr = -1;
+
+	if (!alloc_user_pages(skel, 3, &addr))
+		return;
+
+	skel->bss->exec_addr = addr + page_size;
+	skel->bss->action = USER_PAGE_EXEC_ONLY;
+	user_page_trigger();
+	if (!ASSERT_OK(skel->bss->exec_ret, "middle_page_exec_ret") ||
+	    !check_user_page_vma((void *)(addr + 0 * page_size), page_size, "rw-p") ||
+	    !check_user_page_vma((void *)(addr + 1 * page_size), page_size, "r-xp") ||
+	    !check_user_page_vma((void *)(addr + 2 * page_size), page_size, "rw-p"))
+		goto out;
+
+	skel->bss->exec_addr = addr + 2 * page_size;
+	user_page_trigger();
+	if (!ASSERT_OK(skel->bss->exec_ret, "last_page_exec_ret"))
+		goto out;
+
+	check_user_page_vma((void *)(addr + 2 * page_size), page_size, "r-xp");
+
+out:
+	if (addr >= 0)
+		munmap((void *)addr, page_size * 3);
+}
+
 void test_user_page(void)
 {
 	struct user_page *skel;
@@ -146,6 +204,10 @@ void test_user_page(void)
 		test_reallocate_after_unmap(skel);
 	if (test__start_subtest("read_implies_exec"))
 		test_read_implies_exec(skel);
+	if (test__start_subtest("execute_user_page"))
+		test_execute_user_page(skel);
+	if (test__start_subtest("partial_exec"))
+		test_partial_exec(skel);
 
 out:
 	user_page__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/user_page.c b/tools/testing/selftests/bpf/progs/user_page.c
index 6dd9417463df..38f6fcb89bc6 100644
--- a/tools/testing/selftests/bpf/progs/user_page.c
+++ b/tools/testing/selftests/bpf/progs/user_page.c
@@ -9,11 +9,20 @@
 char _license[] SEC("license") = "GPL";
 
 #define USER_PAGE_ALLOC 1
+#define USER_PAGE_EXEC 2
+#define USER_PAGE_EXEC_ONLY 3
 
 int monitored_pid;
 int action;
 long user_addr;
+long exec_addr;
 unsigned long nr_pages;
+int write_ret;
+int exec_ret;
+static const unsigned char insns[] = {
+	0xf3, 0x0f, 0x1e, 0xfa, /* endbr64 */
+	0xb8, 42, 0, 0, 0, 0xc3, /* mov $42, %eax; ret */
+};
 
 SEC("uprobe.s//proc/self/exe:user_page_trigger")
 int user_page_test(struct pt_regs *ctx)
@@ -25,6 +34,15 @@ int user_page_test(struct pt_regs *ctx)
 	case USER_PAGE_ALLOC:
 		user_addr = bpf_user_page_alloc(nr_pages);
 		break;
+	case USER_PAGE_EXEC:
+		write_ret = bpf_probe_write_user_faultable((void *)exec_addr,
+							   insns, sizeof(insns));
+		exec_ret = write_ret ? write_ret :
+			bpf_user_page_exec(exec_addr);
+		break;
+	case USER_PAGE_EXEC_ONLY:
+		exec_ret = bpf_user_page_exec(exec_addr);
+		break;
 	}
 
 	return 0;
-- 
2.54.0

