Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99F44746BC
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027176; cv=none; b=NcS1gVnCDVXsOD1BfBTAvqgUNUD65+sIIGE3RxcOdLQW5A1W5c+wzaNm4vEJinRS9V40o/xtkX0J80EH1In7gyq3htJjrQDYyZzHZzxrI3QzmQxivFkOkNb7jwqA+5QiPSH+Shd38kzIIrrvvebjbb9fzRuCNp5IRlrNzawFSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027176; c=relaxed/simple;
	bh=wEi/A42RF1FvHA2QIx1814HQ9nZ8UaomTyArA0hQkL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8HhtLfnLCmb3VUWac1F5hfjKLGWNXHqxHQz25ITYuAYxGDzkdHQnkm/r1iuaOsiwyO3KcFDBhbaGpNyU6I0M12Biqxxpfu4euNY3r871PX7sTAhN+ya+zsQ5xZG+dy5+24Lq/wxLpNY7RXraEeq4R4+D5MENtOg9kfewuR8sdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Gdv+zG0q; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Gdv+zG0q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=2A8vqGWChjL9TmsqWR7UHyf2ZC1QxTCt3ASz+87lvwU=; b=Gdv+zG0q4WUosCgWWN6ZUYaP+8
	zvBHjiaTW9BNqJia4h0nmsPPp6DEb+0DDuPPROBoZ5EtjT7L5Ae6iCCDzRcfzhgERy4kw93/3kEmh
	q1cAIbbROS9EsT9v1N0r0ReayU/2ay0qdCkjk8X64HnFEprf125n2T9fSSLB7uP3OfP60JrPPMaz2
	fARnR6ZSUiqICOyG3b5mC+Y8NFkb/OklYq6qxzRFORTTO2J+hOpRO3M5sgHiKidAwWsweUgqVBK2A
	DnY17SkGrwxly5WO95wILDbwM7nAGC1Qqyt2VuxvJYJBOtel4oCVtNmkdoXDdTu/cKVIJQyow36xq
	fl07FYWQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wrzFn-0004sz-15;
	Thu, 06 Aug 2026 16:39:27 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: eddyz87@gmail.com,
	puranjay@kernel.org,
	info@starlabs.sg,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 5/6] selftests/bpf: Add arena fault test for load-acquire
Date: Thu,  6 Aug 2026 16:39:23 +0200
Message-ID: <20260806143924.319238-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260806143924.319238-1-daniel@iogearbox.net>
References: <20260806143924.319238-1-daniel@iogearbox.net>
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

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t stream_arena_fault_address
  [...]
  #462/1   stream_arena_fault_address/read_fault:OK
  #462/2   stream_arena_fault_address/write_fault:OK
  #462/3   stream_arena_fault_address/load_acquire_fault:OK
  #462     stream_arena_fault_address:OK
  Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../testing/selftests/bpf/prog_tests/stream.c |  2 +
 tools/testing/selftests/bpf/progs/stream.c    | 46 +++++++++++++++++++
 2 files changed, 48 insertions(+)

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
index 8d8e53d37266..82c855889180 100644
--- a/tools/testing/selftests/bpf/progs/stream.c
+++ b/tools/testing/selftests/bpf/progs/stream.c
@@ -185,6 +185,52 @@ int stream_arena_read_fault(void *ctx)
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
+	 * A load-acquire is of BPF_STX class, but reads from src_reg into
+	 * dst_reg. Poison dst_reg up front: the fault has to be reported
+	 * as a READ from the src_reg address, and the exception handler has
+	 * to clear dst_reg, so the returned value must be 0.
+	 *
+	 * The load-acquire is open coded as BPF_ATOMIC_OP(BPF_W, BPF_LOAD_ACQ,
+	 * BPF_REG_0, BPF_REG_1, 0x7fff) since <linux/filter.h> cannot be
+	 * included alongside vmlinux.h.
+	 */
+	asm volatile (
+		"r1 = %[user_vm_start];"
+		"r0 = 1;"
+		".8byte 0x000001007fff10c3;" /* r0 = load_acquire((u32 *)(r1 + 0x7fff)) */
+		"%[val] = r0;"
+		: [val] "=r" (val)
+		: [user_vm_start] "r" (user_vm_start)
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

