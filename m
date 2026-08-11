Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097EE2931E4
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786454167; cv=none; b=EQL4bOHE/0afpFxFo20gXJSVC+/b8+WDp8IrnkTyZNetX9dk9if+YX5YtdEfIMAwu/51CvIXgVMqO8CDRSau7EgixcNfNja8Xv1buNCBKDDYZB9R5TrK0nCmH97CjWRADkeiHlta0+w77oBTinnP1UnIPL7z7zJqy+5NPc44Fh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786454167; c=relaxed/simple;
	bh=a71ZBGwy+TbkqQIIjiAzhU17/PRCXv4yzao17rX9lO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNaVhzrlzhoJu5Dhsv44/GPz6RR2+QqsQ4OCd4KRwu/rJGHGE7ls4ERayHTfcT92uRNeYwxiEH/l0YHU3qD+fYjLtRzVY7U20v+GXcwi5Dn8Rs8bLJ10mxvg6JMNBKgqz4Jb0NEIkNUNACyA0kmqy6SRHxT/T4bIjXw+3XTxSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=A5kUK+we; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="A5kUK+we"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=zHfOqkdrExCJh3P4y9DJT+M+Z1w9a15kK9Tdbp7Sjg8=; b=A5kUK+we568BeDOoLc2iIlDFGv
	w4H/pEFf5NCcPLuRkJ6BsEwhAojk98sxjvO+MloYH0mOMqvu7Ou1Sk5fdO6HzmPj8EQSsFTv2E1do
	rKL+s8/rWO5FpriQ5vTUZNr3kx3GPuvSX5r6qYFYENX/5/4VTXrzuULgnKf2hjmUm9X5arsTSMFff
	lW9FdrKGjU0HCCya8OeLhABlk9AsCy091aALdEYC8Z3SUDgl9rwuB3YKtYZA5wY4DxscTkkwm3nLx
	yTLljujkRFNfkaBzb/uFnATbkLfclwX5TFDhmpkteu9G7hzUfsge9epHC5t4/Wd9FcSg/1Pc39mZk
	t9DDqFVg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wtmKq-0009V1-13;
	Tue, 11 Aug 2026 15:16:04 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 6/6] selftests/bpf: Add arena fault tests for atomics with fetch
Date: Tue, 11 Aug 2026 15:16:00 +0200
Message-ID: <20260811131600.506721-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811131600.506721-1-daniel@iogearbox.net>
References: <20260811131600.506721-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28089/Tue Aug 11 08:25:05 2026)

Add stream_arena_xchg_fault and stream_arena_cmpxchg_fault next to the
existing read, write and load-acquire fault tests, covering the two
places a read-modify-write can deposit the old value: src_reg for a
BPF_XCHG and r0 for a BPF_CMPXCHG. Both cover both halves of the JIT
bug that left the fetch destination alone when a RMW on an arena pointer
faulted:

  - the fault has to be reported as a WRITE, and at the address held by
    the destination register, which __stderr() and test_address() check
  - the register receiving the fetched value has to be cleared by the
    fault handler, which the programs check by poisoning it before the
    atomic and returning it, so __retval(0) fails if it is left untouched

The __stderr() annotation can only wildcard the faulting address since
the arena base is not known until runtime, hence the two test_address()
subtests on top, which pin it to the address held by dst_reg rather than
src_reg.

Note, the atomics are open coded since linux/filter.h cannot be included
alongside vmlinux.h.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t stream
  [...]
  #464/1   stream_arena_fault_address/read_fault:OK
  #464/2   stream_arena_fault_address/write_fault:OK
  #464/3   stream_arena_fault_address/load_acquire_fault:OK
  #464/4   stream_arena_fault_address/xchg_fault:OK
  #464/5   stream_arena_fault_address/cmpxchg_fault:OK
  #464     stream_arena_fault_address:OK
  [...]
  #466/5   stream_success/stream_arena_write_fault:OK
  #466/6   stream_success/stream_arena_read_fault:OK
  #466/7   stream_success/stream_arena_load_acquire_fault:OK
  #466/8   stream_success/stream_arena_xchg_fault:OK
  #466/9   stream_success/stream_arena_cmpxchg_fault:OK
  [...]
  Summary: 4/22 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 v1 -> v2:
   - Updated commit msg wrt test_address structuring

 .../testing/selftests/bpf/prog_tests/stream.c |   4 +
 tools/testing/selftests/bpf/progs/stream.c    | 101 ++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
index 15dd3ae2a84b..e4e9374309e2 100644
--- a/tools/testing/selftests/bpf/prog_tests/stream.c
+++ b/tools/testing/selftests/bpf/prog_tests/stream.c
@@ -105,6 +105,10 @@ void test_stream_arena_fault_address(void)
 		test_address(skel->progs.stream_arena_write_fault, &skel->bss->fault_addr);
 	if (test__start_subtest("load_acquire_fault"))
 		test_address(skel->progs.stream_arena_load_acquire_fault, &skel->bss->fault_addr);
+	if (test__start_subtest("xchg_fault"))
+		test_address(skel->progs.stream_arena_xchg_fault, &skel->bss->fault_addr);
+	if (test__start_subtest("cmpxchg_fault"))
+		test_address(skel->progs.stream_arena_cmpxchg_fault, &skel->bss->fault_addr);
 
 	stream__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
index cf5533e11f39..00a37933e411 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -229,6 +229,107 @@ int stream_arena_load_acquire_fault(void *ctx)
 	return val;
 }
 
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__stderr("ERROR: Arena WRITE access at unmapped address 0x{{.*}}")
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
+int stream_arena_xchg_fault(void *ctx)
+{
+	static const struct bpf_insn xchg_insn = {
+		.code	 = 0xc3,	/* BPF_STX | BPF_ATOMIC | BPF_W */
+		.dst_reg = 1,		/* BPF_REG_1 */
+		.src_reg = 2,		/* BPF_REG_2 */
+		.off	 = 0x7fff,
+		.imm	 = 0xe1,	/* BPF_XCHG */
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
+	/*
+	 * A read-modify-write carrying BPF_FETCH writes to memory, so the fault
+	 * has to be reported as a WRITE from the dst_reg address, but it also
+	 * reads the old value into src_reg, so the exception handler has to
+	 * clear src_reg. Poison it up front, the returned value must be 0.
+	 */
+	asm volatile (
+		"r1 = %[user_vm_start];"
+		"r2 = 1;"
+		".8byte %[xchg_insn];" /* r2 = xchg((u32 *)(r1 + 0x7fff), r2) */
+		"%[val] = r2;"
+		: [val] "=r" (val)
+		: [user_vm_start] "r" (user_vm_start),
+		  __imm_insn(xchg_insn, xchg_insn)
+		: "r1", "r2"
+	);
+	return val;
+}
+
+SEC("syscall")
+__arch_x86_64
+__arch_arm64
+__success __retval(0)
+__stderr("ERROR: Arena WRITE access at unmapped address 0x{{.*}}")
+__stderr("CPU: {{[0-9]+}} UID: 0 PID: {{[0-9]+}} Comm: {{.*}}")
+__stderr("Call trace:\n"
+"{{([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
+"|[ \t]+[^\n]+\n)*}}")
+int stream_arena_cmpxchg_fault(void *ctx)
+{
+	static const struct bpf_insn cmpxchg_insn = {
+		.code	 = 0xc3,	/* BPF_STX | BPF_ATOMIC | BPF_W */
+		.dst_reg = 1,		/* BPF_REG_1 */
+		.src_reg = 2,		/* BPF_REG_2 */
+		.off	 = 0x7fff,
+		.imm	 = 0xf1,	/* BPF_CMPXCHG */
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
+	/*
+	 * Same as the exchange above, except that a BPF_CMPXCHG reads the old
+	 * value into r0 rather than into src_reg, so r0 is the register the
+	 * exception handler has to clear. It doubles as the compare value, but
+	 * the comparison never happens since the access faults first.
+	 */
+	asm volatile (
+		"r1 = %[user_vm_start];"
+		"r0 = 1;"
+		"r2 = 2;"
+		".8byte %[cmpxchg_insn];" /* r0 = cmpxchg((u32 *)(r1 + 0x7fff), r0, r2) */
+		"%[val] = r0;"
+		: [val] "=r" (val)
+		: [user_vm_start] "r" (user_vm_start),
+		  __imm_insn(cmpxchg_insn, cmpxchg_insn)
+		: "r0", "r1", "r2"
+	);
+	return val;
+}
+
 static __noinline void subprog(void)
 {
 	int __arena *addr = (int __arena *)0xdeadbeef;
-- 
2.43.0

