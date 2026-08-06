Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E15748F84C
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047054; cv=none; b=t1JkqWLMp9QSbf89CUIBnVfiESGoewYgGeDFDcsWUW1/KhZD7+QvWwRvEEg72yrmAC6IVezXH1jQ6d8fd7cSg2lRULf32ngXIBhDcJkxzxE3DRarLC6xlPGIudd0QHLMSfko9GYBq3O4o61cGGGBXKwAx4ShwI3/+zfUuNgciZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047054; c=relaxed/simple;
	bh=SjJrcT/aXfIZJyNEJ27wOPPOuyJH+Le6xPxwba2DWGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lc8VtYbhDUVWUud6hOR1FgnVVWmhHfJjbisGntHanktC4oHRjTB++5wcDPEucNVIYmLwBdG9r/GMigMnXPqbOZicmHfXIV88fbTcmXNXcyWf6UwP8c3aAlPVsftTVffieL6NaQf63gCaWwYfOaCHaWLPbZvpgTcz+5LZSPlQe7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=c0gOX1fZ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="c0gOX1fZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=GzKN26sUxBThnxA3ezleCXbRcgIMtgeGtzUfwav8fdM=; b=c0gOX1fZwKKlu2OEBO4E3FB+RE
	7TD4YXDWQH0/USepLs68xBx9pOZaAhwP4br13FVwrE9GdDCKoIa4toeIdLTwATW6Z1ZQzupArHyC6
	VWT+z0s8LWM53wITOhHQsU/t8C1I/Q1OWY+2wQ7pi29/FaN/rz4f4l693pWWrhrvTq4k4LF9cxjO0
	YSLurPUY9dgG6XDjfFgLXh8cg4HNUYD0Zt/BSjEB1XiqCj8ma1vPULSIf4jGFM6yDAoNqWRxiBJvV
	47u0pQVhRaS+dwprXfKofnHH6ccofSEVCRSryOnahdQa2x1BvXDEdOrDvz9kVbWeaARtqtvXqPybq
	rrrhfCGQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1ws4QU-000DHR-2b;
	Thu, 06 Aug 2026 22:10:50 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 5/6] selftests/bpf: Add arena fault test for load-acquire
Date: Thu,  6 Aug 2026 22:10:46 +0200
Message-ID: <20260806201047.333389-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806201047.333389-1-daniel@iogearbox.net>
References: <20260806201047.333389-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28084/Thu Aug  6 08:24:46 2026)

Add stream_arena_load_acquire_fault, which performs a load-acquire from an
unmapped arena address, next to the existing read and write fault tests.

The test covers both halves of the JIT bug that treated a load-acquire as
a store when populating its exception table entry:

  - the fault has to be reported as a READ, and at the address held by
    the source register, which __stderr() and test_address() check, and
  - the destination register has to be cleared by the fault handler,
    which the program checks by poisoning it before the load-acquire
    and returning it, so __retval(0) fails if it is left untouched

Note, load-acquire is open coded since linux/filter.h cannot be included
alongside vmlinux.h.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t stream_arena_fault_address
  [...]
  #462/1   stream_arena_fault_address/read_fault:OK
  #462/2   stream_arena_fault_address/write_fault:OK
  #462/3   stream_arena_fault_address/load_acquire_fault:OK
  #462     stream_arena_fault_address:OK
  Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 v1->v2:
   - Fix encoding via load_acquire_insn for s390

 .../testing/selftests/bpf/prog_tests/stream.c |  2 +
 tools/testing/selftests/bpf/progs/stream.c    | 44 +++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index c3cce5c292bd..15dd3ae2a84b 100644
--- a/tools/testing/selftests/bpf/prog_tests/stream.c
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -103,6 +103,8 @@ void test_stream_arena_fault_address(void)
 		test_address(skel->progs.stream_arena_read_fault, &skel->bss->fault_addr);
 	if (test__start_subtest("write_fault"))
 		test_address(skel->progs.stream_arena_write_fault, &skel->bss->fault_addr);
+	if (test__start_subtest("load_acquire_fault"))
+		test_address(skel->progs.stream_arena_load_acquire_fault, &skel->bss->fault_addr);
 
 	stream__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index 8d8e53d37266..cf5533e11f39 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -185,6 +185,50 @@ int stream_arena_read_fault(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__stderr("ERROR: Arena READ access at unmapped address 0x{{.*}}")
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
+int stream_arena_load_acquire_fault(void *ctx)
+{
+	static const struct bpf_insn load_acquire_insn = {
+		.code	 = 0xc3,	/* BPF_STX | BPF_ATOMIC | BPF_W */
+		.dst_reg = 0,		/* BPF_REG_0 */
+		.src_reg = 1,		/* BPF_REG_1 */
+		.off	 = 0x7fff,
+		.imm	 = 0x100,	/* BPF_LOAD_ACQ */
+	};
+	struct bpf_arena *ptr = (void *)&arena;
+	u64 user_vm_start, val;
+
+	/*
+	 * Prevent GCC bounds warning: casting &arena to struct bpf_arena *
+	 * triggers bounds checking since the map definition is smaller than
+	 * struct bpf_arena. barrier_var() makes the pointer opaque to GCC,
+	 * preventing the bounds analysis.
+	 */
+	barrier_var(ptr);
+	user_vm_start = ptr->user_vm_start;
+	fault_addr = user_vm_start + 0x7fff;
+	bpf_addr_space_cast(user_vm_start, 0, 1);
+	asm volatile (
+		"r1 = %[user_vm_start];"
+		"r0 = 1;"
+		".8byte %[load_acquire_insn];" /* r0 = load_acquire((u32 *)(r1 + 0x7fff)) */
+		"%[val] = r0;"
+		: [val] "=r" (val)
+		: [user_vm_start] "r" (user_vm_start),
+		  __imm_insn(load_acquire_insn, load_acquire_insn)
+		: "r0", "r1"
+	);
+	return val;
+}
+
 static __noinline void subprog(void)
 {
 	int __arena *addr = (int __arena *)0xdeadbeef;
-- 
2.43.0

