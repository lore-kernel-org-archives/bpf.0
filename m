Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692842;
	b=LteBJMm3vsLj0DeuT5dd+ETQBctdgqMQeC304KOHDUzPD4OoqogPbp1lPWrgRxsUALkz
	 ykZEq0QbGwdgyQHha4tmp7hOfmiCbsKKQex4STTXTpfHsZnrfbl+h/cS6Qd04k8fvbgeS
	 drnuo9iFksnKFHBmt7pP0lirzwFAjWayntXywDmx078mHOI5AZKF6Vdk6L94hyFTpgNv9
	 cb3aQIvvf0zaENqKx4MyBupagDoarqpsU0c165vrFUhDL9aDIkGeFwAN2ujyobs5749lZ
	 p93UuYmPNv5TUpAv1X7XaAk1+af9ZxEFf/ZF3avYeHypQXdP5oxQMKlrrtBJVpchxKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692842;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DYVUfZuQMkuBt7AZL5iA2lw2horQigkF228UMKVfekA=;
	b=W2E0t8yr00OxN+vwWWEX2DUrRuP+TJyoXGxaKVkpr9Ds0aytx+uzTrOZfP9CDpiv6jFc
	 Y5A8swuikZPZzIFCHuwRU5b/yUQkqE49oGOUBoJvs+jkKM+Nnwg5qSI75py5rCOQEs9+V
	 AKKybml8Om04E0j7BX789aQ2qbGAFxpIl3YNgMBTj4UZ+ACyz6jvC2JKALio2uJWXXaIS
	 NvbwZ+naLfhvbRoZwoisFPQhC7IbISKIjJAZVgWsK77RPGOwH/D2aK+frCTGXVyuNaFa9
	 +Dn7pPQ8caFrZ+N2P+Uj5Q1oCfC3dZI05H0BZmiUdrNntqWggVKAweN9WboNA9SqAUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nOH2eOWE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D703606A329
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 08:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nOH2eOWE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4481F00919;
	Tue,  3 Nov 2026 08:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692842;
	bh=DYVUfZuQMkuBt7AZL5iA2lw2horQigkF228UMKVfekA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nOH2eOWEJb31W/047O+kYr+GGqBZ1qW3294IN4JqJS4cWBvOV6ZZnx5+gp+RC3oS3
	 VMYqLYfAVVwo64imXmWkg9CLqMLuBDzioehxD05Y0zQ/IGFGWGivGwESQIVwE3DNws
	 4TiXdolzQW07x0rRnIVyCYrJqHh/yiM4mR2AMdirs5Jl4CumUBOzJMvlWT6zYZVWoH
	 YWbfAB23gUng9lGd3p6dNVGqaUkOq1vB0HdlU9rXimkgqmBPivvKngEzqACyT7QTS7
	 ATwE1f//kNKIgEoxvtLpgt4GqYhMo2bnH3K82OCtRrS18PQda/KplaHelr/Z6ty7BK
	 1RhYv3LiTgUyA==
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
Subject: [PATCHv2 bpf-next 8/8] selftests/bpf: Test user memory kfunc errors
Date: Tue,  3 Nov 2026 08:59:15 +0100
Message-ID: <20261103075916.100050-9-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103075916.100050-1-jolsa@kernel.org>
References: <20261103075916.100050-1-jolsa@kernel.org>
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
without CAP_SYS_ADMIN cannot call bpf_user_anon_mmap.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/user_mem.c       | 57 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/user_mem.c  | 29 ++++++++++
 2 files changed, 86 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/user_mem.c b/tools/testing/selftests/bpf/prog_tests/user_mem.c
index c87620e39abb..120900bc1869 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_mem.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_mem.c
@@ -263,10 +263,59 @@ static void test_partial_copy_fault(struct user_mem *skel)
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
+static void test_invalid_prot(struct user_mem *skel)
+{
+	skel->bss->map_len = sysconf(_SC_PAGESIZE);
+	skel->bss->map_prot = 0x80000000;
+	skel->bss->action = USER_MEM_MMAP;
+	user_mem_trigger();
+
+	ASSERT_EQ(skel->bss->user_addr, -EINVAL, "invalid_prot");
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
@@ -287,6 +336,14 @@ void test_user_mem(void)
 		test_copy_to_readonly_mapping(skel);
 	if (test__start_subtest("partial_copy_fault"))
 		test_partial_copy_fault(skel);
+	if (test__start_subtest("failed_unmap"))
+		test_failed_unmap(skel);
+	if (test__start_subtest("invalid_copy"))
+		test_invalid_copy(skel);
+	if (test__start_subtest("invalid_prot"))
+		test_invalid_prot(skel);
+	if (test__start_subtest("zero_length_mapping"))
+		test_zero_length_mapping(skel);
 
 out:
 	user_mem__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/user_mem.c b/tools/testing/selftests/bpf/progs/user_mem.c
index a5dd347a02b4..5a0e6a6dcccf 100644
--- a/tools/testing/selftests/bpf/progs/user_mem.c
+++ b/tools/testing/selftests/bpf/progs/user_mem.c
@@ -80,3 +80,32 @@ int user_mem_test(struct pt_regs *ctx)
 
 	return 0;
 }
+
+SEC("?uprobe//proc/self/exe:user_mem_trigger")
+__failure
+__msg("program must be sleepable to call sleepable kfunc bpf_user_anon_mmap")
+__msg("cannot be used in non-sleepable program")
+int user_mem_nonsleepable(struct pt_regs *ctx)
+{
+	bpf_user_anon_mmap(4096, 1);
+	return 0;
+}
+
+SEC("?kprobe")
+__failure
+__msg("program must be sleepable to call sleepable kfunc bpf_user_anon_mmap")
+__msg("cannot be used in non-sleepable program")
+int user_mem_kprobe(struct pt_regs *ctx)
+{
+	bpf_user_anon_mmap(4096, 1);
+	return 0;
+}
+
+SEC("?uprobe.s//proc/self/exe:user_mem_trigger")
+__failure_unpriv __caps_unpriv(CAP_BPF | CAP_PERFMON)
+__msg_unpriv("calling kernel function bpf_user_anon_mmap is not allowed")
+int user_mem_no_sysadmin(struct pt_regs *ctx)
+{
+	bpf_user_anon_mmap(4096, 1);
+	return 0;
+}
-- 
2.43.0

