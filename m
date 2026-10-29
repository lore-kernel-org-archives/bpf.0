Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309217;
	b=2/Bo9mzSOLE054CI7PVU6FTuywFlrfZJXhiFQbn/B5KotnSFvgdoAEVHyBV28caHsSVZ
	 cbYdXN8+qExBbZIilwppCASoYULw295VpKBdff0Dot3wLEsgVt50/nKNqaG4aU6e6vVaz
	 /DWhxGxzHohsDdceR4F4ghsZhIM4UycxQCgN+MGFIhGxPjiW8ODbWiyaq8ZhHOtmLWPSK
	 HM5nVds9ZoJimeMAi6o2L6eGRyGnXGVsFuGiOlkglntYitLpQ/r6asH50DlhHQX14i9Hx
	 OO91HL2pNEQKbIVnytGZU1mOAINFOe473SXBCxy/swA8N6HqsjfNn7L7zo9ORE+aS0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309217;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Im/DUAFHfTcolk1PWOGWY3EMUCY+eKD3uAfuaPZ9s4s=;
	b=BwMEzJkFlegZmM/zHYBrh4n0j5VKblBmmgvq2gXsr5Tf4e/HoegJk2/p05hDOH71Sd1D
	 whtkdB+rhzIYnhvP7ZCt0oXNHvysLoh2+cfUEm8j6ABoEShXiDW6Ex+poFV8NfermKh5F
	 imd+6YKBjc8KE3PO2bRT2L0zEQ+34bJVbQXKA9DPOkHYc1rx2GbD17US7e29rjss3/fnB
	 b0729fABEY7EAIt8lKB3/L8rbCEzYveAECZBdV08W6CWuWZ353+jAkdyH+TK/5qVSjlPl
	 rcxmeOQWlagA+sp/oXYCyg99ikfTJm70cEotaxZLbdb1J2ZUiNtWUUwdVOMKLewFrHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0bqQRVZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCC5606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0bqQRVZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D50B1F01816;
	Thu, 29 Oct 2026 21:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309217;
	bh=Im/DUAFHfTcolk1PWOGWY3EMUCY+eKD3uAfuaPZ9s4s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B0bqQRVZ0IeP7QT7D/+M7E/W66kd49bgd0jEoGVkPlryPNJHhymV1MgIMBE/NaP8I
	 Irko53Oh5U7wwN5/pz41ArdLKYx7YfXgL7IvuEwrE7KllwyByUsW1xT/0h5peOhNF0
	 8DP8B55aD83hng51I9KQl0VUFmHnjXcs4Q824PY0v1JxUPZ/sjCri1REHF21jr3pZc
	 QXWej6n5GLaLGV5swOpBe+VJPvXzWHm1ykpIrjgnPuVoFIiccgO2Hl1+7aw+9ik1xy
	 FUYGtcLmPNDDmOamyUrhYnDVZcARWU+mcJ0DZ2rN5yb6Mem/VquIe7km2Xv4+f3EVC
	 /tKoXJcUM49OQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	linux-mm@kvack.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Federico Di Pierro <nierro92@gmail.com>
Subject: [PATCH bpf-next 6/8] selftests/bpf: Test user memory page exec
Date: Thu, 29 Oct 2026 22:25:49 +0100
Message-ID: <20261029212551.56964-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029212551.56964-1-jolsa@kernel.org>
References: <20261029212551.56964-1-jolsa@kernel.org>
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

Use bpf_copy_to_user from a uprobe to write architecture-specific
instructions into user memory, then execute them on x86-64 and arm64.

Test execution from a mapping created with read and execute permissions,
and from individual pages made executable with mprotect.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/user_mem.c       | 75 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/user_mem.c  | 22 ++++++
 2 files changed, 97 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/user_mem.c b/tools/testing/selftests/bpf/prog_tests/user_mem.c
index f301a1843706..7fa827298d24 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_mem.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_mem.c
@@ -11,6 +11,7 @@
 enum {
 	USER_MEM_MMAP = 1,
 	USER_MEM_UNMAP,
+	USER_MEM_COPY_INSNS,
 };
 
 static noinline void user_mem_trigger(void)
@@ -92,6 +93,76 @@ static void test_mapping(struct user_mem *skel)
 		munmap((void *)addr, len);
 }
 
+static bool user_mem_copy_insns(struct user_mem *skel, unsigned long addr)
+{
+	skel->bss->user_addr = addr;
+	skel->bss->action = USER_MEM_COPY_INSNS;
+	user_mem_trigger();
+
+	return ASSERT_OK(skel->bss->ret, "user_write");
+}
+
+static void test_execute_user_page(struct user_mem *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	unsigned long addr = ~0UL;
+
+#if !defined(__x86_64__) && !defined(__aarch64__)
+	test__skip();
+	return;
+#endif
+
+	if (!user_mem_mmap(skel, page_size, PROT_READ | PROT_EXEC, &addr))
+		return;
+	if (!check_user_mem_vma((void *)addr, page_size, "r-xp"))
+		goto out;
+	if (!user_mem_copy_insns(skel, addr))
+		goto out;
+
+	/* Execute user page. */
+	ASSERT_EQ(((int (*)(void))addr)(), 42, "execute_user_page");
+
+out:
+	if (addr != ~0UL)
+		munmap((void *)addr, page_size);
+}
+
+static void test_partial_exec(struct user_mem *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	unsigned long addr = ~0UL;
+
+#if !defined(__x86_64__) && !defined(__aarch64__)
+	test__skip();
+	return;
+#endif
+
+	if (!user_mem_mmap(skel, page_size * 3, PROT_READ | PROT_WRITE, &addr))
+		return;
+
+	/* Copy instructions to middle page. */
+	if (!user_mem_copy_insns(skel, addr + page_size))
+		goto out;
+
+	/* Set +x to middle page. */
+	if (!ASSERT_OK(mprotect((void *)(addr + page_size), page_size,
+				PROT_READ | PROT_EXEC), "middle_page_mprotect"))
+		goto out;
+
+	if (!check_user_mem_vma((void *)addr, page_size, "rw-p") ||
+	    !check_user_mem_vma((void *)(addr + page_size), page_size, "r-xp") ||
+	    !check_user_mem_vma((void *)(addr + 2 * page_size), page_size, "rw-p"))
+		goto out;
+
+	/* Execute middle page. */
+	if (!ASSERT_EQ(((int (*)(void))(addr + page_size))(), 42, "execute_middle_page"))
+		goto out;
+
+out:
+	if (addr != ~0UL)
+		munmap((void *)addr, page_size * 3);
+}
+
 void test_user_mem(void)
 {
 	struct user_mem *skel;
@@ -106,6 +177,10 @@ void test_user_mem(void)
 
 	if (test__start_subtest("mapping"))
 		test_mapping(skel);
+	if (test__start_subtest("execute_user_page"))
+		test_execute_user_page(skel);
+	if (test__start_subtest("partial_exec"))
+		test_partial_exec(skel);
 
 out:
 	user_mem__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/user_mem.c b/tools/testing/selftests/bpf/progs/user_mem.c
index a6b4f922da49..b477132e3883 100644
--- a/tools/testing/selftests/bpf/progs/user_mem.c
+++ b/tools/testing/selftests/bpf/progs/user_mem.c
@@ -10,10 +10,13 @@ char _license[] SEC("license") = "GPL";
 
 extern unsigned long bpf_user_mmap(unsigned long len, unsigned long prot) __ksym;
 extern int bpf_user_munmap(unsigned long addr, unsigned long len) __ksym;
+extern int bpf_copy_to_user(void *unsafe_ptr__ign, const void *src__srcptr,
+			    u32 src__sz, u64 flags) __ksym;
 
 enum {
 	USER_MEM_MMAP = 1,
 	USER_MEM_UNMAP,
+	USER_MEM_COPY_INSNS,
 };
 
 int monitored_pid;
@@ -24,6 +27,22 @@ unsigned long user_addr;
 unsigned long map_len;
 unsigned long map_prot;
 
+#if defined(__TARGET_ARCH_x86)
+static const unsigned char insns[] = {
+	0xf3, 0x0f, 0x1e, 0xfa, /* endbr64 */
+	0xb8, 42, 0, 0, 0, 0xc3, /* mov $42, %eax; ret */
+};
+#elif defined(__TARGET_ARCH_arm64)
+static const unsigned char insns[] = {
+	0x5f, 0x24, 0x03, 0xd5, /* bti c */
+	0x40, 0x05, 0x80, 0x52, /* mov w0, #42 */
+	0xc0, 0x03, 0x5f, 0xd6, /* ret */
+};
+#else
+/* The execute tests are skipped on other architectures. */
+static const unsigned char insns[] = { 0 };
+#endif
+
 SEC("uprobe.s//proc/self/exe:user_mem_trigger")
 int user_mem_test(struct pt_regs *ctx)
 {
@@ -37,6 +56,9 @@ int user_mem_test(struct pt_regs *ctx)
 	case USER_MEM_UNMAP:
 		ret = bpf_user_munmap(user_addr, map_len);
 		break;
+	case USER_MEM_COPY_INSNS:
+		ret = bpf_copy_to_user((void *)user_addr, insns, sizeof(insns), 0);
+		break;
 	}
 
 	return 0;
-- 
2.54.0

