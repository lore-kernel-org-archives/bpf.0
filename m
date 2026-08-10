Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894BF34D90C
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786369433; cv=none; b=TchR5t6tOhyUt04jzkWXAJ2F62BqRcCXHFY+UGYOGjfnSgP4e93D5RrtgyU4rGT/EOqoPw8I0NXaJrcDWKgvXGRtHlbejT6lh0q+6mNCyz1x5Gql9z0B0ldbUIvq1t63rntZuyre+849s2kqJHRUBD110HwhrMbJDGcWnvkMvGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786369433; c=relaxed/simple;
	bh=Cu2mJiSRI2YUpLk6TGnjqKtuSH9kY+sd9V0DeX3TRJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/ERyxPW05P/W5hwgwzK1VHnESgetBvOaBjF8OqejvA5Hlv2Tl/nxU5aexP+ioguPa07ecr3TCBIB9csfAzN7z5Hr27x6UD2piux+69polWvpWelqMaNB3wevLAZfQ9/LWZIWtbDEcxZB5VIyFn8SRBlvGOAND9fgAJ/RcS7kMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MxH2YMHD; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MxH2YMHD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RCWb7fw29cyr0CvJhqCp7RBNBOp79wAIe2sR4hnOXTE=; b=MxH2YMHD5jdHM1nLvsGyX+WmHu
	ypHLAPtsv5hMa/wd4thEe8QQFA66ny6e47zvlQMqZR2nWGjgAhG8dJzbFNqfecJZ1X7HXMLkM4yXo
	VwvMXQk4JBNUG9Vwsu93kVk5N/Kj1P2GdZU9rEmuHPZnXZjdvo+Bd8RkRt1bWk3BMKR3P9T9uRkKb
	NoET8TAmSp399VvddWW69UmCKMctG3YgumLbtwDZrSCwSn4T5Sp1EDElLmGMYpmo3SJX9qwhNw9s3
	ymzHOkjOqjHv01Q7LswH1Nm/OGCY9D07EjiwHIID5bf9BU25WGMuKqkd0n2tpEbMt2yb7U1A4PHX7
	Djw84RyA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wtQI9-000531-2l;
	Mon, 10 Aug 2026 15:43:49 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 6/6] selftests/bpf: Add arena fault tests for atomics with fetch
Date: Mon, 10 Aug 2026 15:43:46 +0200
Message-ID: <20260810134346.466004-6-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810134346.466004-1-daniel@iogearbox.net>
References: <20260810134346.466004-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28088/Mon Aug 10 08:24:15 2026)

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
---
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

