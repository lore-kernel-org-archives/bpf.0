Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309237;
	b=iV9M1M0st3mAOuGn/lp9FXD6WvkTOFugAIPZYQ8/bhPGHEnwBGehGLXrJTUAIT43LQN7
	 r20vC6/BBwTowpha4vcj0OFeu5uK0HkziKtHcN5X4+Krj9we/9kQhs/TUMrQUKU6E7jbR
	 GPNiD94GTbwnpv4dvpfDum8PR6IIaLDzqLDENOdVNf7xl4m6VjZdgbWzEDD9mo4rTf2GM
	 Kf9IZvhwLrX2f6gKCN1wd/zSt5NphYvuVlOh966YaYqwDlk7jr+j0SY8No0JXtBjOcGBF
	 sHkgrofU8qTjz/u2ETSY0R9S0rgybB4XKUu3ARKdV2gigFO2h7OQjmxhpxzdE9u6GHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309237;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0ojy+UhwC3CeZ0n5OWvhNQedtQf6s/LFGjHqzO8hqIs=;
	b=tJFBlkSN72gDkhYDf+pbGmdM9GgnV7G19+g947As2qF5PlDbIIxMyh46uzVOdsmmKKVo
	 SPDzuaQXBD75l6hEVYi2EX6BVnQBhYOuNJqx2IeCGdqctjD2IQUrJWjBxJKXbjjHJ4039
	 HD8PmWzbBvMizSnsvg0rmadTcSdFN3gW50UIjpPQlKhs7diWh4DpoCMQJXtR6CSjxfurV
	 f0l+7Bv91S0/0ggA2kOFwa/r7L8hW2uT4MQ67cFIbZNALwLDIGqyVo07Cq7pMpf1enHmu
	 Z2QFTE95ypwPi1vyDJfuSyOH32HFjjNwNugvpXkgolFScuwA3q4D6O7p2l0D6ezx1Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EVelXOyj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A74E606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EVelXOyj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9DB1F01816;
	Thu, 29 Oct 2026 21:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793309237;
	bh=0ojy+UhwC3CeZ0n5OWvhNQedtQf6s/LFGjHqzO8hqIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EVelXOyjABrLv4ULU0RJ3o0XRfVChKl+o20IbGRwJiJwWfg5d3X8Eab6sbLaNktl1
	 9rUkQa5x+qrwknfzJSgz/j3GID5HWSloiERPoPxeDAhHhkX+djEkKRtx9xuK9twBvK
	 jLyQXeaOwTtCXK0W2lIl6jnJfqHC+R37Cnc6A3+zwpw/7BLUZ6HKLQ1fsbFMBE1DJ3
	 A2+TLqAs2clx8Djo1RvgjNbdDhG1lI7nUjPgO8lGVPKIdrHjGkhrR+Z3Q6GzptkU6x
	 nC4Y97Tp6gXkR/bqfwmTsDcnuJ6WgGWlb1vXdSgwuBP5aNTJIofrX/jt7k0WnSBotF
	 /kwOMPRd0vsTw==
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
Subject: [PATCH bpf-next 8/8] selftests/bpf: Test user memory kfunc errors
Date: Thu, 29 Oct 2026 22:25:51 +0100
Message-ID: <20261029212551.56964-9-jolsa@kernel.org>
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

Test invalid copy arguments, zero-length mapping operations, partial copy
faults, and copying to read-only mappings. Verify that a failed unmap
leaves the mapping intact, and that non-sleepable programs and programs
without CAP_SYS_ADMIN cannot call bpf_user_mmap.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/user_mem.c       | 45 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/user_mem.c  | 29 ++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/user_mem.c b/tools/testing/selftests/bpf/prog_tests/user_mem.c
index c87620e39abb..f3a35f8e005a 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_mem.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_mem.c
@@ -263,10 +263,49 @@ static void test_partial_copy_fault(struct user_mem *skel)
 		munmap((void *)addr, second_page_unmapped ? page_size : page_size * 2);
 }
 
+static void test_zero_length_mapping(struct user_mem *skel)
+{
+	skel->bss->map_len = 0;
+	skel->bss->map_prot = PROT_READ | PROT_WRITE;
+	skel->bss->action = USER_MEM_MMAP;
+	user_mem_trigger();
+
+	ASSERT_EQ(skel->bss->user_addr, (unsigned long)-EINVAL, "zero_length_mapping");
+}
+
+static void test_failed_unmap(struct user_mem *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	unsigned long addr = ~0UL;
+
+	if (!user_mem_mmap(skel, page_size, PROT_READ | PROT_WRITE, &addr))
+		return;
+
+	skel->bss->user_addr = addr;
+	skel->bss->map_len = 0;
+	skel->bss->action = USER_MEM_UNMAP;
+	user_mem_trigger();
+
+	if (ASSERT_EQ(skel->bss->ret, -EINVAL, "zero_length_unmap"))
+		check_user_mem_vma((void *)addr, page_size, "rw-p");
+
+	munmap((void *)addr, page_size);
+}
+
+static void test_invalid_copy(struct user_mem *skel)
+{
+	ASSERT_EQ(user_mem_copy(skel, 1, sizeof(data), 0), -EFAULT, "bad_copy");
+	ASSERT_EQ(user_mem_copy(skel, 1, sizeof(data), 1), -EINVAL, "bad_copy_flags");
+	ASSERT_EQ(user_mem_copy(skel, 1, 0, 0), 0, "zero_length_copy");
+	ASSERT_EQ(user_mem_copy(skel, 1, 0, 1), -EINVAL, "zero_length_copy_bad_flags");
+}
+
 void test_user_mem(void)
 {
 	struct user_mem *skel;
 
+	RUN_TESTS(user_mem);
+
 	skel = user_mem__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "open_and_load"))
 		return;
@@ -287,6 +326,12 @@ void test_user_mem(void)
 		test_copy_to_readonly_mapping(skel);
 	if (test__start_subtest("partial_copy_fault"))
 		test_partial_copy_fault(skel);
+	if (test__start_subtest("failed_unmap"))
+		test_failed_unmap(skel);
+	if (test__start_subtest("invalid_copy"))
+		test_invalid_copy(skel);
+	if (test__start_subtest("zero_length_mapping"))
+		test_zero_length_mapping(skel);
 
 out:
 	user_mem__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/user_mem.c b/tools/testing/selftests/bpf/progs/user_mem.c
index 6ebfdc54edad..1ff5be6e3e62 100644
--- a/tools/testing/selftests/bpf/progs/user_mem.c
+++ b/tools/testing/selftests/bpf/progs/user_mem.c
@@ -80,3 +80,32 @@ int user_mem_test(struct pt_regs *ctx)
 
 	return 0;
 }
+
+SEC("?uprobe//proc/self/exe:user_mem_trigger")
+__failure
+__msg("program must be sleepable to call sleepable kfunc bpf_user_mmap")
+__msg("cannot be used in non-sleepable program")
+int user_mem_nonsleepable(struct pt_regs *ctx)
+{
+	bpf_user_mmap(4096, 1);
+	return 0;
+}
+
+SEC("?kprobe")
+__failure
+__msg("program must be sleepable to call sleepable kfunc bpf_user_mmap")
+__msg("cannot be used in non-sleepable program")
+int user_mem_kprobe(struct pt_regs *ctx)
+{
+	bpf_user_mmap(4096, 1);
+	return 0;
+}
+
+SEC("?uprobe.s//proc/self/exe:user_mem_trigger")
+__failure_unpriv __caps_unpriv(CAP_BPF | CAP_PERFMON)
+__msg_unpriv("calling kernel function bpf_user_mmap is not allowed")
+int user_mem_no_sysadmin(struct pt_regs *ctx)
+{
+	bpf_user_mmap(4096, 1);
+	return 0;
+}
-- 
2.54.0

