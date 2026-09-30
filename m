Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954273F54CB
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796706; cv=none; b=MX5vfyRqSDVh3Wtq1gneeF0VPLCozs4zNo2acp4dU+43/xdIDBpCla8wqTZBWcwT6GEhhgvij1eyxBPk9ip8oxr8j8DzPDNDWPkcAhir/tsvoCx2EENX66nV6LEe3/Rmz/hj8QhoFcEyCatJgCnG73pCAA2oS8Z0zsPVbhc/Tv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796706; c=relaxed/simple;
	bh=sC1nhaGsBDnzOien5qNc1S2EapJtmp1uiaPtQ9kHvqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d8QLoQc5/efQ5enMo5De82NPd9bPOXB9VUdePwIU0pf9hn51ho+0tQ1szfrIm5UapF+ix30ja5vveXUWRCEf8SMss3VtqJ5HX1Vgw+tUwXNNu9N3IxyBAk8g0yh2IjFvCmUX5NHj9/DF2YzYU4N7wEUrudwWgi747geGP5GF2bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XLItTxII; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XLItTxII"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a4e9fbcc60so311242a91.3
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796704; x=1791401504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shxqdTvIcFu/PQy7+22sA2v5seAgOeIJarCpdTr1kQc=;
        b=XLItTxIIwcSfnz6EfT3cp6svJrHK3R7ES8rpxu+46KiGGvAmsgdJri+rqChFr8PC88
         2BXZ2lAUndjQxG9yvozp/I9I+xOaLCwqA1bnCN6rq5jSES9vnopZ9pr8/QLYUEnoHzUu
         UEjm/fjTuvmc75LGc2pQqcLOU6akXKfeAEsaBdftxJqSlbzSZ+OhzC8sfFX6HUcfVz/2
         hixQS07/L4NI3Qj/02oHMW/0DWzv58AEhk0bX3QfayTbXgXR7cup4ep9MXYN7jwj+31C
         P1LynQoNRtnewlJT+pkaIyYbRGHBfrWXObPEdpDR4S27R6FILka5986w5qN7ULozuak0
         qnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796704; x=1791401504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=shxqdTvIcFu/PQy7+22sA2v5seAgOeIJarCpdTr1kQc=;
        b=PHPtnCRPxNZQip6pymsXblY0hqssHTC7LV9Wf/Adp/7gQXzoMLfjUSdsuGhXHLDA52
         7U2rNjgrwLAjOEEop2k5cPrX4hxsHA3J8ioAVDrplepRo7r5WI4VoWsN7+OAb00a3lt5
         vXgwI6Asp7p72FzawcxbpKgy2LQ11pYGYyhikLxHu0L/bH78MOUYxnyjIhwpxB9FIaed
         WHpMzhT5q93VC/WlgtGlox657fRwPith1kt+C77RdkjaFMusAqM93qwIm02Yd3d7OQ2u
         cwYOg/I56OOdBtb0ggvZNt24ZnE7GYhn1sAG0A2ud35suqTyg3elkm7jULtn+EH9wztB
         It0w==
X-Gm-Message-State: AFq9FYJWJs35fKTTHg9WElAvWScf9Wm67rOO8cG+7m8WF0J5xG8hHy+g
	ugCsbWIjb0IzF8RxE2PL9V9x/gz2dHTjWorasLSQiJ8+rsKikKGClTJbaZukmPeW
X-Gm-Gg: AYBFou1wpz7JhD1HmGaTaHstuI3cq/wsG/xT3ZEWSqvV0NULTz4h0cIpDnIRLgvbh9H
	6oiaSyIcTeUX5LHC2WayPNKDCfUrBsQOjcO6aKZiPh5SE6L7MdYDALJlIqITNStvZUy7TSIEjFu
	xZuffQf9ZjyHxq+ZDhdITdclUA7kb6gK9doRMi7ZL+AwnoOYBGc5HcNik2Pd9gW7D6i4+/tmP7g
	n82RyKtjszvPRa87IzJCem+5FbuV42Dq6XShiI07uI/t7dsqjN2Cizd9jCpb+rPPN6xXuDsZ+aN
	Gy9zSSKIktOt8gTmAPDyfD0eIz7FY5+aubYIDa3MFgawnL+WQebDlJ5eG6hlJ+JyjteTuQA8SyZ
	jJnSXU4RKZyll7WS81ovUTOo+Lh9d+yLF6XnPvWoGeYYOXE/zZYha4tKx3KD4jpHzKF9FRi2Mfy
	C2UljF5SlILQ5s8FtTV0dZ7//i1RJLQ37cUyJviJQMOlJIbkiOMfy0ts/3ztZ4b4WGZbaozvxm5
	28wfINvYymC8wj471lcxvNsx16VPWzkavdJenp+r9xZ1EC1Ddh9p23gfAApV0dlT9kFBK+mth/i
	e+lHP1bdsmDxVYuLyleHDjGtr/cgIbF7PbGftJf5UwBBjXx5/asvqg==
X-Received: by 2002:a17:90b:3b43:b0:3a0:c276:1ec0 with SMTP id 98e67ed59e1d1-3a4d1654d49mr2142287a91.28.1790796703188;
        Wed, 30 Sep 2026 12:31:43 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f75a35d8sm113099a91.2.2026.09.30.12.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:31:42 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 04/14] selftests/bpf: Add tests for arena access through numbers
Date: Wed, 30 Sep 2026 19:31:17 +0000
Message-ID: <20260930193127.2181684-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add tests for load and store through the address that
bpf_arena_alloc_pages() returned, without cast_kern:
- all sizes, sign extending load, atomics, load-acquire, store-release.
- no register is changed by the access, whatever the upper half of
  the address is, and 64-bit math on the address stays 64-bit.
- a number that is not an address of arena, address of the stack
  included, reads zeroes and writes nowhere at both ends of the range
  of insn offset.
- insn that sees a number on one path and PTR_TO_ARENA on another,
  followed by access through PTR_TO_ARENA.
- store in a callback of bpf_loop().
- NULL that a helper returned and a number that is less than a page
  are addresses of arena too.
- xchg that loads into the register that holds the address.
- rejected: prog without arena, prog without BPF_F_ARENA_SCALAR, pointer
  to stack at the same insn, xchg that loads into the register that
  holds a pointer to stack, numbers passed to helpers.

The tests are for x86 and arm64, other JITs don't take the flag.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/arena_scalar_blinded.c     |  21 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_arena_scalar.c         | 912 ++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     |   2 +
 4 files changed, 937 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_scalar.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c b/tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c
new file mode 100644
index 000000000000..2ac2e9a652fe
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "sysctl_helpers.h"
+#include "verifier_arena_scalar.skel.h"
+
+/* The same tests with constants of the programs blinded */
+void serial_test_arena_scalar_blinded(void)
+{
+	const char *harden = "/proc/sys/net/core/bpf_jit_harden";
+	char old[16] = {};
+
+	if (!is_jit_enabled()) {
+		test__skip();
+		return;
+	}
+	if (sysctl_set_or_fail(harden, old, "2"))
+		return;
+	RUN_TESTS(verifier_arena_scalar);
+	sysctl_set_or_fail(harden, NULL, old);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8a6d341b754a..460ad10ddc02 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -12,6 +12,7 @@
 #include "verifier_and.skel.h"
 #include "verifier_arena.skel.h"
 #include "verifier_arena_large.skel.h"
+#include "verifier_arena_scalar.skel.h"
 #include "verifier_arena_globals1.skel.h"
 #include "verifier_arena_globals2.skel.h"
 #include "verifier_array_access.skel.h"
@@ -198,6 +199,7 @@ void test_verifier_align(void)                { RUN(verifier_align); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
 void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
+void test_verifier_arena_scalar(void)         { RUN(verifier_arena_scalar); }
 void test_verifier_arena_globals1(void)       { RUN(verifier_arena_globals1); }
 void test_verifier_arena_globals2(void)       { RUN(verifier_arena_globals2); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c b/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
new file mode 100644
index 000000000000..bebc37f501b7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
@@ -0,0 +1,912 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+void *bpf_arena_alloc_pages(void *map, void *addr, __u32 page_cnt, int node_id,
+			    __u64 flags) __ksym;
+
+#ifdef __TARGET_ARCH_arm64
+#define ARENA_VM_START (1ull << 32)
+#else
+#define ARENA_VM_START (1ull << 44)
+#endif
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARENA);
+	__uint(map_flags, BPF_F_MMAPABLE);
+	__uint(max_entries, 4);
+	__ulong(map_extra, ARENA_VM_START);
+} arena SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, long long);
+} hash SEC(".maps");
+
+/* JITs that take BPF_F_ARENA_SCALAR */
+#define __arena_scalar __flag(BPF_F_ARENA_SCALAR) __arch_x86_64 __arch_arm64
+
+/* BTF FUNC records are not generated for kfuncs referenced from inline assembly */
+void __kfunc_btf_root(void)
+{
+	bpf_arena_alloc_pages(0, 0, 0, 0, 0);
+}
+
+/* Tests start with r6 = address of a new page as the user space sees it, a number */
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: load and store of every size")
+__success __retval(0)
+__load_if_JITed()
+__naked void ld_st_sizes(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	r7 = r6;					\
+	r1 = 0x1122334455667788 ll;			\
+	*(u64 *)(r6 + 0) = r1;				\
+	*(u32 *)(r6 + 8) = r1;				\
+	*(u16 *)(r6 + 12) = r1;				\
+	*(u8 *)(r6 + 14) = r1;				\
+	*(u64 *)(r6 + 16) = 0x1234;			\
+	*(u32 *)(r6 + 24) = 0x5678;			\
+	*(u16 *)(r6 + 28) = 0x9a;			\
+	*(u8 *)(r6 + 30) = 0xbc;			\
+	r0 = 1;						\
+	r2 = *(u64 *)(r6 + 0);				\
+	if r2 != r1 goto 9f;				\
+	r0 = 2;						\
+	r2 = *(u32 *)(r6 + 8);				\
+	if r2 != 0x55667788 goto 9f;			\
+	r0 = 3;						\
+	r2 = *(u16 *)(r6 + 12);				\
+	if r2 != 0x7788 goto 9f;			\
+	r0 = 4;						\
+	r2 = *(u8 *)(r6 + 14);				\
+	if r2 != 0x88 goto 9f;				\
+	r0 = 5;						\
+	r2 = *(u64 *)(r6 + 16);				\
+	if r2 != 0x1234 goto 9f;			\
+	r0 = 6;						\
+	r2 = *(u32 *)(r6 + 24);				\
+	if r2 != 0x5678 goto 9f;			\
+	r0 = 7;						\
+	r2 = *(u16 *)(r6 + 28);				\
+	if r2 != 0x9a goto 9f;				\
+	r0 = 8;						\
+	r2 = *(u8 *)(r6 + 30);				\
+	if r2 != 0xbc goto 9f;				\
+	/* the address is what it was */		\
+	r0 = 9;						\
+	if r6 != r7 goto 9f;				\
+	r0 = 10;					\
+	r7 >>= 32;					\
+	if r7 == 0 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: load into the register that holds the address")
+__success __retval(0)
+__load_if_JITed()
+__naked void ld_into_base(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	r1 = 77;					\
+	*(u64 *)(r6 + 0) = r1;				\
+	r6 = *(u64 *)(r6 + 0);				\
+	r0 = 1;						\
+	if r6 != 77 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: sign extending load")
+__success __retval(0)
+__load_if_JITed()
+__naked void ldsx(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	r7 = r6;					\
+	*(u64 *)(r6 + 0) = 0x80;			\
+	.8byte %[ldsx_insn]; /* r2 = *(s8 *)(r6 + 0) */	\
+	r0 = 1;						\
+	if r2 != -128 goto 9f;				\
+	r0 = 2;						\
+	if r6 != r7 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages),
+	  __imm_insn(ldsx_insn, BPF_RAW_INSN(BPF_LDX | BPF_MEMSX | BPF_B,
+					     BPF_REG_2, BPF_REG_6, 0, 0))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: address loaded from arena")
+__success __retval(0)
+__load_if_JITed()
+__naked void ptr_chase(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	/* page[0] = &page[64]; page[64] = 5; */	\
+	r1 = r6;					\
+	r1 += 64;					\
+	*(u64 *)(r6 + 0) = r1;				\
+	*(u64 *)(r1 + 0) = 5;				\
+	r2 = *(u64 *)(r6 + 0);				\
+	r0 = 1;						\
+	if r2 != r1 goto 9f;				\
+	r3 = *(u64 *)(r2 + 0);				\
+	r0 = 2;						\
+	if r3 != 5 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: atomics")
+__success __retval(0)
+__load_if_JITed()
+__naked void atomics(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	r7 = r6;					\
+	*(u64 *)(r6 + 8) = 1;				\
+	r1 = 2;						\
+	lock *(u64 *)(r6 + 8) += r1;			\
+	r1 = 4;						\
+	.8byte %[fetch_add_insn]; /* r1 = atomic_fetch_add((u64 *)(r6 + 8), r1) */ \
+	r0 = 1;						\
+	if r1 != 3 goto 9f;				\
+	r1 = 8;						\
+	.8byte %[xchg_insn]; /* r1 = xchg_64(r6 + 8, r1) */ \
+	r0 = 2;						\
+	if r1 != 7 goto 9f;				\
+	r0 = 8;						\
+	r1 = 16;					\
+	.8byte %[cmpxchg_insn]; /* r0 = cmpxchg_64(r6 + 8, r0, r1) */ \
+	r2 = r0;					\
+	r0 = 3;						\
+	if r2 != 8 goto 9f;				\
+	r2 = *(u64 *)(r6 + 8);				\
+	r0 = 4;						\
+	if r2 != 16 goto 9f;				\
+	r0 = 5;						\
+	if r6 != r7 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages),
+	  __imm_insn(fetch_add_insn, BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH,
+						   BPF_REG_6, BPF_REG_1, 8)),
+	  __imm_insn(xchg_insn, BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_6, BPF_REG_1, 8)),
+	  __imm_insn(cmpxchg_insn, BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_6, BPF_REG_1, 8))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: cmpxchg through r0")
+__success __retval(0)
+__load_if_JITed()
+__naked void cmpxchg_r0(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	/* The address is in r0. The value at the address is not equal to it. */ \
+	*(u64 *)(r6 + 0) = 3;				\
+	r0 = r6;					\
+	r1 = 5;						\
+	.8byte %[cmpxchg_insn]; /* r0 = cmpxchg_64(r0 + 0, r0, r1) */ \
+	r2 = r0;					\
+	r0 = 1;						\
+	if r2 != 3 goto 9f;				\
+	r2 = *(u64 *)(r6 + 0);				\
+	r0 = 2;						\
+	if r2 != 3 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages),
+	  __imm_insn(cmpxchg_insn, BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_0, BPF_REG_1, 0))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: xchg into the register that holds the address")
+__success __retval(0)
+__load_if_JITed()
+__naked void xchg_into_base(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	*(u64 *)(r6 + 0) = 3;				\
+	r1 = r6;					\
+	.8byte %[xchg_insn]; /* r1 = xchg_64(r1 + 0, r1) */ \
+	r0 = 1;						\
+	if r1 != 3 goto 9f;				\
+	r2 = *(u64 *)(r6 + 0);				\
+	r0 = 2;						\
+	if r2 != r6 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages),
+	  __imm_insn(xchg_insn, BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_1, 0))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: xchg into the register that holds a pointer to stack")
+__failure __msg("misaligned access off (0x0; 0xffffffffffffffff)+0 size 8")
+__naked void xchg_into_stack_ptr(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r1 = 0;						\
+	*(u64 *)(r10 - 8) = r1;				\
+	r1 = r10;					\
+	r1 += -8;					\
+	.8byte %[xchg_insn]; /* r1 = xchg_64(r1 + 0, r1) */ \
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm_insn(xchg_insn, BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_1, 0))
+	: __clobber_all);
+}
+
+#ifdef CAN_USE_LOAD_ACQ_STORE_REL
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: load-acquire and store-release")
+__success __retval(0)
+__load_if_JITed()
+__naked void load_acq_store_rel(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	r7 = r6;					\
+	r1 = 0x1234;					\
+	.8byte %[store_release_insn]; /* store_release((u64 *)(r6 + 8), r1) */ \
+	.8byte %[load_acquire_insn]; /* r2 = load_acquire((u64 *)(r6 + 8)) */ \
+	r0 = 1;						\
+	if r2 != 0x1234 goto 9f;			\
+	.8byte %[load_acquire8_insn]; /* w2 = load_acquire((u8 *)(r6 + 8)) */ \
+	r0 = 2;						\
+	if r2 != 0x34 goto 9f;				\
+	r0 = 3;						\
+	if r6 != r7 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages),
+	  __imm_insn(store_release_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_STORE_REL, BPF_REG_6, BPF_REG_1, 8)),
+	  __imm_insn(load_acquire_insn,
+		     BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_6, 8)),
+	  __imm_insn(load_acquire8_insn,
+		     BPF_ATOMIC_OP(BPF_B, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_6, 8))
+	: __clobber_all);
+}
+
+#endif /* CAN_USE_LOAD_ACQ_STORE_REL */
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: number that is not an address in arena")
+__success __retval(0)
+__load_if_JITed()
+__naked void not_in_arena(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	/* nothing is allocated: all loads read 0, stores are dropped */ \
+	r6 = 0xdeadbeef00000000 ll;			\
+	r0 = 1;						\
+	r2 = *(u64 *)(r6 + 0);				\
+	if r2 != 0 goto 9f;				\
+	r0 = 2;						\
+	r2 = *(u8 *)(r6 - 32768);			\
+	if r2 != 0 goto 9f;				\
+	r6 = 0x12345678ffffffff ll;			\
+	r0 = 3;						\
+	r2 = *(u64 *)(r6 + 32760);			\
+	if r2 != 0 goto 9f;				\
+	*(u64 *)(r6 + 32760) = 1;			\
+	*(u8 *)(r6 + 32767) = r2;			\
+	r1 = 1;						\
+	lock *(u64 *)(r6 + 32760) += r1;		\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: store through the address of the stack as a number")
+__success __retval(0)
+__load_if_JITed()
+__naked void stack_addr_as_number(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	*(u64 *)(r10 - 8) = 5;				\
+	r6 = r10;					\
+	r6 |= 0;					\
+	/* r6 is a number now. The store goes to arena, not to the stack. */ \
+	*(u64 *)(r6 - 8) = 7;				\
+	r1 = 9;						\
+	*(u64 *)(r6 - 8) = r1;				\
+	lock *(u64 *)(r6 - 8) += r1;			\
+	r2 = *(u64 *)(r10 - 8);				\
+	r0 = 1;						\
+	if r2 != 5 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: 64-bit math on the address stays 64-bit")
+__success __retval(0)
+__load_if_JITed()
+__naked void alu64_after_access(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	r2 = *(u64 *)(r6 + 0);				\
+	r7 = r6;					\
+	r7 += 8;					\
+	r7 -= r6;					\
+	r0 = 1;						\
+	if r7 != 8 goto 9f;				\
+	r7 = r6;					\
+	r7 >>= 32;					\
+	r0 = 2;						\
+	if r7 == 0 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: st of an immediate changes no register")
+__success __retval(0)
+__load_if_JITed()
+__naked void st_keeps_regs(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	r0 = r6;					\
+	r1 = 0x1111;					\
+	r2 = 0x2222;					\
+	*(u64 *)(r0 + 0) = 5;				\
+	r3 = r0;					\
+	r0 = 1;						\
+	if r3 != r6 goto 9f;				\
+	r0 = 2;						\
+	if r1 != 0x1111 goto 9f;			\
+	r0 = 3;						\
+	if r2 != 0x2222 goto 9f;			\
+	r0 = 0x3333;					\
+	r1 = r6;					\
+	*(u32 *)(r1 + 8) = -7;				\
+	r3 = r0;					\
+	r0 = 4;						\
+	if r3 != 0x3333 goto 9f;			\
+	r0 = 5;						\
+	if r1 != r6 goto 9f;				\
+	r0 = 6;						\
+	r3 = *(u64 *)(r6 + 0);				\
+	if r3 != 5 goto 9f;				\
+	r0 = 7;						\
+	r3 = *(u64 *)(r6 + 8);				\
+	r4 = 0xfffffff9 ll;				\
+	if r3 != r4 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: access through a number with garbage in the upper half")
+__success __retval(0)
+__load_if_JITed()
+__naked void st_value_garbage(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	r1 = 0xdeadbeef00001000 ll;			\
+	*(u64 *)(r6 + 2048) = r1;			\
+	r7 = *(u64 *)(r6 + 2048);			\
+	r8 = *(u64 *)(r6 + 2048);			\
+	r1 = 3;						\
+	*(u64 *)(r8 + 0) = 1;				\
+	r0 = 1;						\
+	if r8 != r7 goto 9f;				\
+	*(u8 *)(r8 + 1) = 1;				\
+	r0 = 2;						\
+	if r8 != r7 goto 9f;				\
+	*(u32 *)(r8 + 4) = r1;				\
+	r0 = 3;						\
+	if r8 != r7 goto 9f;				\
+	r2 = *(u16 *)(r8 + 2);				\
+	r0 = 4;						\
+	if r8 != r7 goto 9f;				\
+	r0 = 5;						\
+	if r1 != 3 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: access through a number without the upper half")
+__success __retval(0)
+__load_if_JITed()
+__naked void st_value_small(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	r1 = 0x1000 ll;					\
+	*(u64 *)(r6 + 2048) = r1;			\
+	r7 = *(u64 *)(r6 + 2048);			\
+	r8 = *(u64 *)(r6 + 2048);			\
+	r1 = 3;						\
+	*(u64 *)(r8 + 0) = 1;				\
+	r0 = 1;						\
+	if r8 != r7 goto 9f;				\
+	*(u8 *)(r8 + 1) = 1;				\
+	r0 = 2;						\
+	if r8 != r7 goto 9f;				\
+	*(u32 *)(r8 + 4) = r1;				\
+	r0 = 3;						\
+	if r8 != r7 goto 9f;				\
+	r2 = *(u16 *)(r8 + 2);				\
+	r0 = 4;						\
+	if r8 != r7 goto 9f;				\
+	r0 = 5;						\
+	if r1 != 3 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: atomics through a number that is not an address in arena")
+__success __retval(0)
+__load_if_JITed()
+__naked void atomic_value(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	r1 = 0xdeadbeef00001000 ll;			\
+	*(u64 *)(r6 + 2048) = r1;			\
+	r7 = *(u64 *)(r6 + 2048);			\
+	r8 = *(u64 *)(r6 + 2048);			\
+	r1 = 3;						\
+	lock *(u64 *)(r8 + 0) += r1;			\
+	r0 = 1;						\
+	if r8 != r7 goto 9f;				\
+	.8byte %[fetch_add_insn];			\
+	r0 = 2;						\
+	if r8 != r7 goto 9f;				\
+	.8byte %[xchg_insn];				\
+	r0 = 3;						\
+	if r8 != r7 goto 9f;				\
+	r0 = 0;						\
+	.8byte %[cmpxchg_insn];				\
+	r0 = 4;						\
+	if r8 != r7 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages),
+	  __imm_insn(fetch_add_insn, BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH,
+						   BPF_REG_8, BPF_REG_1, 0)),
+	  __imm_insn(xchg_insn, BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_8, BPF_REG_1, 0)),
+	  __imm_insn(cmpxchg_insn, BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_8, BPF_REG_1, 0))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: number and pointer to arena at the same insn")
+__success __retval(0)
+__load_if_JITed()
+__naked void mixed_number_arena(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	*(u64 *)(r6 + 8) = 0x1234;			\
+	/* a number that the verifier does not know, 0 at run time */ \
+	r7 = *(u64 *)(r6 + 16);				\
+	r8 = r6;					\
+	if r7 != 0 goto 1f;				\
+	.8byte %[cast_kern_insn];			\
+1:	*(u8 *)(r8 + 0) = 1;				\
+	*(u8 *)(r8 + 1) = r7;				\
+	r2 = *(u8 *)(r8 + 1);				\
+	lock *(u64 *)(r8 + 24) += r7;			\
+	r0 = 0;						\
+	if r7 != 0 goto 9f;				\
+	/* pointer to arena only: JIT adds all 64 bits of r8 to the base */ \
+	r0 = 2;						\
+	r2 = *(u64 *)(r8 + 8);				\
+	if r2 != 0x1234 goto 9f;			\
+	r0 = 3;						\
+	r2 = *(u8 *)(r6 + 0);				\
+	if r2 != 1 goto 9f;				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages),
+	  __imm_insn(cast_kern_insn, BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_X,
+						  BPF_REG_8, BPF_REG_8, 1, 1))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena_scalar: no flag, no access through a number")
+__failure __msg("R6 invalid mem access 'scalar'")
+__naked void no_flag(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r6 = 0x100000000000 ll;				\
+	r0 = *(u64 *)(r6 + 0);				\
+	exit;						\
+"	:
+	: __imm_addr(arena)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: no arena, no access through a number")
+__failure __msg("R6 invalid mem access 'scalar'")
+__naked void no_arena(void)
+{
+	asm volatile ("					\
+	r6 = 0x100000000000 ll;				\
+	r0 = *(u64 *)(r6 + 0);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: pointer that is NULL is an address in arena")
+__success __retval(0)
+__load_if_JITed()
+__naked void null_ptr(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r1 = 0;						\
+	*(u32 *)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[hash] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r1 = r0;					\
+	r0 = 1;						\
+	if r1 != 0 goto 9f;				\
+	/* nothing is allocated: the load reads 0 */	\
+	r0 = *(u64 *)(r1 + 0);				\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm_addr(hash),
+	  __imm(bpf_map_lookup_elem)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: pointer that is NULL with an offset is an address in arena")
+__success __retval(0)
+__load_if_JITed()
+__naked void null_ptr_off(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r1 = 0;						\
+	*(u32 *)(r10 - 4) = r1;				\
+	r2 = r10;					\
+	r2 += -4;					\
+	r1 = %[hash] ll;				\
+	call %[bpf_map_lookup_elem];			\
+	r1 = r0;					\
+	r0 = 1;						\
+	if r1 != 0 goto 9f;				\
+	r1 += 8;					\
+	*(u64 *)(r1 + 0) = 5;				\
+	r0 = *(u64 *)(r1 + 0);				\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm_addr(hash),
+	  __imm(bpf_map_lookup_elem)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: number that is less than a page is an address in arena")
+__success __retval(0)
+__load_if_JITed()
+__naked void small_number(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	call %[bpf_get_prandom_u32];			\
+	r1 = r0;					\
+	r1 &= 0xfff;					\
+	r0 = *(u64 *)(r1 + 0);				\
+	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: number is not a pointer for a helper")
+__failure __msg("R2 type=scalar expected=")
+__naked void helper_arg(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	r1 = %[hash] ll;				\
+	r2 = r6;					\
+	call %[bpf_map_lookup_elem];			\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm_addr(hash),
+	  __imm(bpf_arena_alloc_pages),
+	  __imm(bpf_map_lookup_elem)
+	: __clobber_all);
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: number and pointer to stack at the same insn")
+__failure __msg("same insn cannot be used with different pointers")
+__load_if_JITed()
+__naked void mixed_number_stack(void)
+{
+	asm volatile ("					\
+	r1 = %[arena] ll;				\
+	r2 = 0;						\
+	r3 = 1;						\
+	r4 = -1;					\
+	r5 = 0;						\
+	call %[bpf_arena_alloc_pages];			\
+	r6 = r0;					\
+	r0 = 100;					\
+	if r6 == 0 goto 9f;				\
+	*(u64 *)(r10 - 8) = 0;				\
+	call %[bpf_get_prandom_u32];			\
+	if w0 != 0 goto 1f;				\
+	r6 = r10;					\
+	r6 += -8;					\
+1:	r0 = *(u64 *)(r6 + 0);				\
+	r0 = 0;						\
+9:	exit;						\
+"	:
+	: __imm_addr(arena),
+	  __imm(bpf_arena_alloc_pages),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+static int st_cb(__u64 idx, void *ctx)
+{
+	volatile long *p = *(volatile long **)ctx;
+
+	p[idx] = 7;
+	return 0;
+}
+
+SEC("syscall")
+__arena_scalar
+__description("arena_scalar: store through a number in a callback")
+__success __retval(0)
+__load_if_JITed()
+int st_in_callback(void *unused)
+{
+	volatile long *p = bpf_arena_alloc_pages(&arena, NULL, 1, -1, 0);
+
+	if (!p)
+		return 100;
+	bpf_loop(4, st_cb, &p, 0);
+	return p[0] + p[3] + p[4] - 14;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 25eeb1c1248b..a89890cd56d8 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -580,6 +580,8 @@ static int parse_test_spec(struct test_loader *tester,
 				update_flags(&spec->prog_flags, BPF_F_XDP_HAS_FRAGS, clear);
 			} else if (strcmp(val, "BPF_F_TEST_REG_INVARIANTS") == 0) {
 				update_flags(&spec->prog_flags, BPF_F_TEST_REG_INVARIANTS, clear);
+			} else if (strcmp(val, "BPF_F_ARENA_SCALAR") == 0) {
+				update_flags(&spec->prog_flags, BPF_F_ARENA_SCALAR, clear);
 			} else /* assume numeric value */ {
 				err = parse_int(val, &flags, "test prog flags");
 				if (err)
-- 
2.55.0

