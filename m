Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874288;
	b=M4gdWU30TkntpqZTEZoVU0yeyL7LtN6SwM2l6SfroWMOEcyaL3psns3qct2gQfhPok/Y
	 nDxfWc/U93+cwy5VU+wVB8jbnR060yHdNUiqu7n/4Y1CemX6BwzLSwIIgVmFy9l6TQQ3a
	 W+O+LfXh0McmVVGC1ZiZI4jAvx/m3v3IU0AGG/OLgZSKjJ2aKcx7cMRkliQ7AujP1cP6B
	 AcaesMv6eoemopSW6SWD1qdMMErJI5CR4A53c9NYCk9EnOxCKvBZYD0jRp+m7EcKPpbfR
	 0Ojj962cpMevZwPK7N9LCH+UTyuhfN3tqT03WfVHSnClhvG4NBiSjwL/Igl+AoCp4uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874288;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zmdWsLeDOwil7ZrDTJNt3Mwh5fQ18CiuyFvC+u7BoL0=;
	b=PV14WpcPx6hHoZepClYazRXYygj4Vq3MOo2cHwrXTQF9Fv5vw6xrw8LBKAA8R8aWUgUp
	 SNikrS90BBy30JderQW0Jwk4DNq8Io4ZG2hjXcwiGKen+RtGR7wOKdYL37eAXbV4aFn9A
	 sYnCu0U7uaVLqZ0/sroks+kErarwYcyB/IkI8HG/2qM9GHACbCMDrubFlZ5E+kPDE4Teu
	 u7vY1rpuEYbezaGiVpksn3RbzO22Ho3GRBdzUjg74q2HV0ylLWFOHUyk4k4Wc+FOPOUWX
	 Z5OYs1+J4akx60RhHN7CFR83ZsO3+7AiGtSL2uJz4yGU/lSTmDVD0ibRQBsu1bSw4SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TiGCrbcz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E2606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TiGCrbcz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EFC1F000C1;
	Thu,  5 Nov 2026 10:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874287;
	bh=zmdWsLeDOwil7ZrDTJNt3Mwh5fQ18CiuyFvC+u7BoL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TiGCrbczGsGJs34yk5Ncj74By2pa+sJUxXs/vcpT3y76BnbA63mfaeNnerAwBcTNJ
	 QJoJYdsWnAoyZ5ponPmjQ22qrep+ZyZeYT+06ZcUiHP6IoSqVi+z1ggL3AzYFXG/9v
	 A7FNsBm7DQLmgJ2Pb29Iq1fFgzYRfx3eAXiERZ60P0QV4YPJbtjWTTPKnSV3WiEVj6
	 LYzIEb3lOtxw0Y+xt6NSo6ZzaK0F2u+EnaDVyrAnj4RoaIZkhYXGUs6fnRhAeO4BV4
	 0rdLAVUpBqhUl2aHcOMAstmbc8ULGUDCE+gUjfOSOODK+rwKvia5jAZdv7B9S9/bGT
	 YJERp95yTRayw==
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
Subject: [PATCHv3 bpf-next 6/8] selftests/bpf: Test user memory page exec
Date: Thu,  5 Nov 2026 11:23:40 +0100
Message-ID: <20261105102343.311331-7-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105102343.311331-1-jolsa@kernel.org>
References: <20261105102343.311331-1-jolsa@kernel.org>
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
index eadf668f7056..e1748ffb1edf 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_mem.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_mem.c
@@ -10,6 +10,7 @@
 enum {
 	USER_MEM_MMAP = 1,
 	USER_MEM_UNMAP,
+	USER_MEM_COPY_INSNS,
 };
 
 static noinline void user_mem_trigger(void)
@@ -91,6 +92,76 @@ static void test_mapping(struct user_mem *skel)
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
@@ -105,6 +176,10 @@ void test_user_mem(void)
 
 	if (test__start_subtest("mapping"))
 		test_mapping(skel);
+	if (test__start_subtest("execute_user_page"))
+		test_execute_user_page(skel);
+	if (test__start_subtest("partial_exec"))
+		test_partial_exec(skel);
 
 out:
 	user_mem__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/user_mem.c b/tools/testing/selftests/bpf/progs/user_mem.c
index e3b0689f5f2a..3bbd5d2f02d6 100644
--- a/tools/testing/selftests/bpf/progs/user_mem.c
+++ b/tools/testing/selftests/bpf/progs/user_mem.c
@@ -10,10 +10,13 @@ char _license[] SEC("license") = "GPL";
 
 extern unsigned long bpf_user_anon_mmap(unsigned long len, unsigned long prot) __ksym;
 extern int bpf_user_munmap(unsigned long addr, unsigned long len) __ksym;
+extern int bpf_copy_to_user(void *unsafe_ptr__ign, const void *src,
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
2.43.0

