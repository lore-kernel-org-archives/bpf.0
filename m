Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692832;
	b=KzxgE7U2d/nFsLmQt8P05H3uuXNBnVqPfj4BaOdcLf7n2A9YvnETQGWYiLTyfrE0qa44
	 frwq0R7MRERwpNA24+mmPQ1J4ire2FfzsAyJjdF6bMYdvGZdtsnEifq1dmfcoqDwLM3Rv
	 IFX8e+KMTe4eLaTurcrp7scZcNHLsJvFMm3g/mT4uiwkkKpyOM3njLA48gEDEmeMMDrvD
	 MSIAo0FhX+JcPmwaZ979km9G8rA1RbOGatuLOAKWKcvy8t0lrgUVXKEq3ECspjB/CTCzi
	 rlHL/Es898yittSuLCfll5LMj8zRTlY/BiIJdXfsT76wMIldPx1Dr6ATzI7LZ4goUyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692832;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=acfNxavyOUjUywz61ozXkej8203ZY4SRCfP5uOVUHGs=;
	b=Rg66r2QTyac2q7gy0YJkwggMR1EpdwQgRZvL9B9pe3FsRHwdxBsR49wyAdTDSyHV5UYG
	 h/2MX7JvFm3wUngVBerdgCC8o5ALn632FKsCqNQovKwjF8A5KsVZ5HPlKFCtGvp0Y5aNQ
	 dXMAoNrg8XpGYmaUBKB/eh+OOvvfktTH1mvSPYSj+z6Urzi0gGHap2qob8odV2EOC2jh6
	 3XjwFgfGs1DbkoYlQRO9LMyaG7/m/EJeNNLZnCtevB2Qnker8vOQzPbznU1Qcfp55ubvD
	 BGj58HYYUuC3PW9yRAwUP2s8f5WWEfv6UGXSQQK8FiArYX97p4aP6ZwZXFZAi5urDeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RM0LlK7H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E71606A32C
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 08:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RM0LlK7H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC4CE1F00A02;
	Tue,  3 Nov 2026 08:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793692832;
	bh=acfNxavyOUjUywz61ozXkej8203ZY4SRCfP5uOVUHGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RM0LlK7HR1+Uk9vcexLxxKAkdKcDo5PEM+nxT9wExTy3Zb4SQSsVSvOvKtLgnSbNR
	 a5ER6ZOklKN/8Jt4wYYX4O1xF0sMe4jcCwM9pjQCnYgcYkc+OJTeZfmMvstJbj0y+w
	 QiHq80q1gyDTiRQ8cazHHPgsgoGHXpFCJB+lpER5RN1j683h756e8sBc+q6n6Umet6
	 o70BkJKJsMZvplA29vwYjEnJbCCaaF6KfhlzryILNfhlNhZo3VgLfvpcVgLUxBQEml
	 0C/sw/3M9f0xFJwDxg3fdxvrWLEcd2Jlms1W6+ZPv+X4zQMFfbKRHhs5rWOWYgErv0
	 LSvDVc73qurRA==
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
Subject: [PATCHv2 bpf-next 7/8] selftests/bpf: Test bpf_copy_to_user kfunc
Date: Tue,  3 Nov 2026 08:59:14 +0100
Message-ID: <20261103075916.100050-8-jolsa@kernel.org>
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

Test that bpf_copy_to_user can fault in a paged-out page and write to a
read-only mapping. Also verify that a partial copy crossing into an unmapped
page returns -EFAULT while leaving the copied byte in place.

Assisted-by: Codex:GPT-6
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../selftests/bpf/prog_tests/user_mem.c       | 106 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/user_mem.c  |  17 +++
 2 files changed, 123 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/user_mem.c b/tools/testing/selftests/bpf/prog_tests/user_mem.c
index 7fa827298d24..c87620e39abb 100644
--- a/tools/testing/selftests/bpf/prog_tests/user_mem.c
+++ b/tools/testing/selftests/bpf/prog_tests/user_mem.c
@@ -12,8 +12,11 @@ enum {
 	USER_MEM_MMAP = 1,
 	USER_MEM_UNMAP,
 	USER_MEM_COPY_INSNS,
+	USER_MEM_COPY,
 };
 
+static const char data[] = "fault-enabled BPF write";
+
 static noinline void user_mem_trigger(void)
 {
 	asm volatile ("" ::: "memory");
@@ -102,6 +105,18 @@ static bool user_mem_copy_insns(struct user_mem *skel, unsigned long addr)
 	return ASSERT_OK(skel->bss->ret, "user_write");
 }
 
+static int user_mem_copy(struct user_mem *skel, unsigned long addr,
+			u32 size, u64 flags)
+{
+	skel->bss->user_addr = addr;
+	skel->bss->copy_size = size;
+	skel->bss->copy_flags = flags;
+	skel->bss->action = USER_MEM_COPY;
+	user_mem_trigger();
+
+	return skel->bss->ret;
+}
+
 static void test_execute_user_page(struct user_mem *skel)
 {
 	long page_size = sysconf(_SC_PAGESIZE);
@@ -163,6 +178,91 @@ static void test_partial_exec(struct user_mem *skel)
 		munmap((void *)addr, page_size * 3);
 }
 
+static void test_faultable_write(struct user_mem *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	unsigned long addr = ~0UL;
+	unsigned char vec;
+	int i;
+
+	if (!user_mem_mmap(skel, page_size, PROT_READ | PROT_WRITE, &addr))
+		return;
+
+	/* Make sure there is a private resident page to page out. */
+	memset((void *)addr, 0, page_size);
+
+	/* Retry pageout until mincore confirms that the page is no longer resident. */
+	for (i = 0; i < 500; i++) {
+		if (madvise((void *)addr, page_size, MADV_PAGEOUT)) {
+			test__skip();
+			goto out;
+		}
+		if (!ASSERT_OK(mincore((void *)addr, page_size, &vec), "mincore"))
+			goto out;
+		if (!(vec & 1))
+			break;
+		usleep(100);
+	}
+	if (i == 500) {
+		test__skip();
+		goto out;
+	}
+
+	/* ..and do the copy to it. */
+	if (!ASSERT_OK(user_mem_copy(skel, addr, sizeof(data), 0), "user_write_data"))
+		goto out;
+
+	ASSERT_EQ(memcmp((void *)addr, data, sizeof(data)), 0, "written_data");
+
+out:
+	if (addr != ~0UL)
+		munmap((void *)addr, page_size);
+}
+
+static void test_copy_to_readonly_mapping(struct user_mem *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	unsigned long addr = ~0UL;
+
+	if (!user_mem_mmap(skel, page_size, PROT_READ, &addr))
+		return;
+
+	/* Assert we can copy to read-only mapping. */
+	if (!ASSERT_OK(user_mem_copy(skel, addr, sizeof(data), 0), "readonly_copy"))
+		goto out;
+
+	ASSERT_EQ(memcmp((void *)addr, data, sizeof(data)), 0, "readonly_copy_data");
+
+out:
+	if (addr != ~0UL)
+		munmap((void *)addr, page_size);
+}
+
+static void test_partial_copy_fault(struct user_mem *skel)
+{
+	long page_size = sysconf(_SC_PAGESIZE);
+	bool second_page_unmapped = false;
+	unsigned long addr = ~0UL;
+
+	if (!user_mem_mmap(skel, page_size * 2, PROT_READ | PROT_WRITE, &addr))
+		return;
+
+	if (!user_mem_munmap(skel, addr + page_size, page_size))
+		goto out;
+
+	second_page_unmapped = true;
+
+	ASSERT_EQ(user_mem_copy(skel, addr + page_size - 1, sizeof(data), 0),
+		  -EFAULT, "partial_copy");
+
+	/* The byte before the fault stays written. */
+	ASSERT_EQ(((char *)addr)[page_size - 1], 'f', "partial_copy_data");
+
+out:
+	if (addr != ~0UL)
+		munmap((void *)addr, second_page_unmapped ? page_size : page_size * 2);
+}
+
 void test_user_mem(void)
 {
 	struct user_mem *skel;
@@ -181,6 +281,12 @@ void test_user_mem(void)
 		test_execute_user_page(skel);
 	if (test__start_subtest("partial_exec"))
 		test_partial_exec(skel);
+	if (test__start_subtest("faultable_write"))
+		test_faultable_write(skel);
+	if (test__start_subtest("copy_to_readonly_mapping"))
+		test_copy_to_readonly_mapping(skel);
+	if (test__start_subtest("partial_copy_fault"))
+		test_partial_copy_fault(skel);
 
 out:
 	user_mem__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/user_mem.c b/tools/testing/selftests/bpf/progs/user_mem.c
index a62916ebc0b5..a5dd347a02b4 100644
--- a/tools/testing/selftests/bpf/progs/user_mem.c
+++ b/tools/testing/selftests/bpf/progs/user_mem.c
@@ -17,6 +17,7 @@ enum {
 	USER_MEM_MMAP = 1,
 	USER_MEM_UNMAP,
 	USER_MEM_COPY_INSNS,
+	USER_MEM_COPY,
 };
 
 int monitored_pid;
@@ -27,6 +28,9 @@ unsigned long user_addr;
 unsigned long map_len;
 unsigned long map_prot;
 
+u64 copy_flags;
+u32 copy_size;
+
 #if defined(__TARGET_ARCH_x86)
 static const unsigned char insns[] = {
 	0xf3, 0x0f, 0x1e, 0xfa, /* endbr64 */
@@ -43,9 +47,13 @@ static const unsigned char insns[] = {
 static const unsigned char insns[] = { 0 };
 #endif
 
+static const char data[] = "fault-enabled BPF write";
+
 SEC("uprobe.s//proc/self/exe:user_mem_trigger")
 int user_mem_test(struct pt_regs *ctx)
 {
+	u32 size;
+
 	if ((bpf_get_current_pid_tgid() >> 32) != monitored_pid)
 		return 0;
 
@@ -59,6 +67,15 @@ int user_mem_test(struct pt_regs *ctx)
 	case USER_MEM_COPY_INSNS:
 		ret = bpf_copy_to_user((void *)user_addr, insns, sizeof(insns), 0);
 		break;
+	case USER_MEM_COPY:
+		/* Bound the kfunc length using a local copy of copy_size. */
+		size = copy_size;
+		if (size > sizeof(data)) {
+			ret = -22; /* -EINVAL */
+			break;
+		}
+		ret = bpf_copy_to_user((void *)user_addr, data, size, copy_flags);
+		break;
 	}
 
 	return 0;
-- 
2.43.0

