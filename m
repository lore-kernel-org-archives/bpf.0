Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793127821;
	b=rC2wx/jnGg1ooVEt4A4uHAmhqoQg2MAQZidv4AKCsPO6GWN68zgHAL6WHvWKdrUruYYD
	 4K5hNQ/arptEF+jpFZgb5wgRs6ob4fuXVUH52fm0gbD1Lbw9FEAyAseco3YmXoOhUEJYt
	 VMk5Si/ryl35D4sRhcdeZDjS5JTkqAATms16cNRAs7e8uvbU29XHQ2r3NWoh8VX4IXicv
	 P6XmDHkAdrgdfyhjvcs4x5SaQQBobYZdERGnGnyutfjatV1FI/fhbolC5qBnzKCVbwAWO
	 6tGRfNfwh/T2Ns7UeIluzUubCNNh5DM3FSwRL9P4Eud2kxJ0E2NXqXjpcksGiIjT7BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793127821;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BCHRJTCXHyje/pB0KNRRSXRquenbojGNgU5z6rACWps=;
	b=1CbjpWH9GUT4GefTLcH+syu2OGELLhDzaVKaRkl0Sj0EghP2XqNnM+KuXjUKnWCBrgMQ
	 wzr/UTRzrM48OvWj3ybDY6COie2CmYe+saoYRRKloecq40c6ggVMbK5xl1r3Lc3vZgTv0
	 hEY1WnAxigIfuC5951CajP2RJ2UGxdfTIyg8BkfCNXhqSmZxOKQoLL24IRvv+fZTVrh7W
	 6rstoHNTQQoL7mh50ZMEOeEkl9jVA0kNlTvdXndWcBqCY5gn4EYLpHQh8lq/vojsCda+K
	 UPkTOFUTGE5C6sHQrQBYdp7hz5cxPbpT+BZQ0iv0g6/3p1g4Sh/45ljWtW7IctiJJmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="y/l3X8Bb";
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A31606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 19:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19A31606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y/l3X8Bb
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so136002a91.3
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 12:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793127820; x=1793732620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BCHRJTCXHyje/pB0KNRRSXRquenbojGNgU5z6rACWps=;
        b=y/l3X8Bbtj3g5xxWWj/GFkQJ7qEOIqGjH16oJVW8K2+tb3LjPsXOTyvTPj1FpN/n2+
         dwkWe89Ir0ELVrchX8+qFSByc2IWXf1AXluFuHyHoCIgQkpTepVhvzN6z0/TqPDIGZZ3
         U7PeSjyNcyIM3Yrz5Uk3tHs9HUV3BpoS9nK+fD6lkCTAab94enoLmXLryZ8ddZBLdz7e
         bmisW0zrN/3RMWhZ6EOyvMdjakrHqQTb+2Ytfp1XgLCFgV/4leWhVxQ0bYgdaGVps4ro
         neSPGrepSfsz0e6eHUKvQXKQGr6BNFUb0kgwBulWugU1nwhuoLpg99nAj5+iRLxMeVEp
         P5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793127820; x=1793732620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BCHRJTCXHyje/pB0KNRRSXRquenbojGNgU5z6rACWps=;
        b=BwcaffKlrHpt1SBoyA6xX/C3vbccJhasYDWSI5+M2hxiBA1hQxuK6Dfx+0eROnozng
         bxzwXj8fA7ylCa/WNucpMc1nmIWTz2hHl63EP5EO8Oldhv0FNdjhMljKywxQvwb+rOqW
         5gX3wly3XZfEnytMVvRHJsvkHsr87Ok18UWqYblqOTIxeH3xg0gIZI005fNH6vO+4dl9
         4FRPMN/wtC9cx9n1ri+k2lU4XpbKP2f6F+6GBX8Ay4yhemxaeQTG0oveQkFnnIBB5DAq
         Ijg31FmCtQpeQcctDWSV+mo5oPw7Mh9qkzifCqNBlp39kXwugBIIe8rRVbOow42qxSDG
         Mn3Q==
X-Gm-Message-State: AFq9FYLaeOqQL1/0tAvB1xo0SOjWne4OEp9cP41IDAcZ/UunsCsLVE+J
	XtQOi8rXPXZS3lNQi+DaCIWSkXkSXitzOgr2Drbh4gqVQkodBVB4WGcP6FG0Tg==
X-Gm-Gg: AYBFou1glXwAKkX2KcG75BU0rzv8sE2oyPYSeIkhvEdRMb0X2kjrJ9EHEhGX3ZZJxZO
	Kfd9NNqgjTnI090F9f5BQfMq1Yg/X25y7i71zeEeIlRZZwa/6xYkz731ksZsOcReBEMUB40vpIn
	V/rnTpThIfT54YvcElw/xgiLz37NfQfpwIzxzNSov/Gq8XBgCSJ0uk+t5OzPYVFsWaZsrh2Bfye
	hc83wlcoxYhvGE0RlRkqcU3kJyRiNgLbVwCsvISfcNreY15/+LmiRS207ERaYvnfWsuq9UXrJ8o
	T5WPh3OJLNym+yWgbUzl8aej0t9wqMFTqzThpSvOnbJ5gKY40hOflqmRIF/c9kJ7mMC4lxWrO0X
	okfDMZmG1GMsvjJWUgy/ohp8nNUM1Xt2ZBdoHGGD9QjwlNqT2lXx0oHK5qD6OmgeleiEHVnKYnG
	FnyvQwWw+1IgrLzaogtaShvk0qj5m1dPjEeILZIGhKU5T4OfdcAPfDuNW39xXNNskjV0gVRpgNN
	6k+5TwkYAh1Rc3/8tLOc1J3Qec6TV9PkyiCJCuAG9bmokOjslOKapimwtSa+Q9b466+T/pfl5ap
	n2kN7Em9XJGzSaZwiNX7Gp7szFHpuVJR3j/fBR8Dpcclj8kSwTH+Pc2udDUYPv2lwGP/MiCzEQQ
	7wkzbwPI1kqLw59IohHJFXXyR
X-Received: by 2002:a17:90b:3e48:b0:3ac:9a03:20bf with SMTP id 98e67ed59e1d1-3adeafd64cdmr10296048a91.55.1793127819973;
        Tue, 27 Oct 2026 12:03:39 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae55a010dbsm180944a91.0.2026.10.27.12.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 12:03:39 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH v2 bpf 04/19] selftests/bpf: Remove tests for arena access through numbers
Date: Tue, 27 Oct 2026 19:02:59 +0000
Message-ID: <20261027190314.1440199-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
References: <20261027190314.1440199-1-alexei.starovoitov@gmail.com>
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

From: Alexei Starovoitov <ast@kernel.org>

With BPF_F_ARENA_SCALAR the verifier accepts a load or a store through a
scalar as an access to arena. The next patch removes the flag. Remove its
tests.

Keep one test. Without the flag the verifier must reject such a load, also
in a prog that has an arena. Move this test to verifier_arena.c.

The removed tests were the only tests of a special path in the x86 JIT for
the fetching AND/OR/XOR atomics. Only the flag used that path.
arena_atomics tests the usual path.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../bpf/prog_tests/arena_scalar_blinded.c     |   21 -
 .../selftests/bpf/prog_tests/verifier.c       |    2 -
 .../selftests/bpf/progs/arena_noarena.c       |   15 -
 .../selftests/bpf/progs/verifier_arena.c      |   15 +
 .../bpf/progs/verifier_arena_scalar.c         | 1155 -----------------
 tools/testing/selftests/bpf/test_loader.c     |    2 -
 6 files changed, 15 insertions(+), 1195 deletions(-)
 delete mode 100644 tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c
 delete mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_scalar.c

diff --git a/tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c b/tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c
deleted file mode 100644
index 2ac2e9a652fe..000000000000
--- a/tools/testing/selftests/bpf/prog_tests/arena_scalar_blinded.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <test_progs.h>
-#include "sysctl_helpers.h"
-#include "verifier_arena_scalar.skel.h"
-
-/* The same tests with constants of the programs blinded */
-void serial_test_arena_scalar_blinded(void)
-{
-	const char *harden = "/proc/sys/net/core/bpf_jit_harden";
-	char old[16] = {};
-
-	if (!is_jit_enabled()) {
-		test__skip();
-		return;
-	}
-	if (sysctl_set_or_fail(harden, old, "2"))
-		return;
-	RUN_TESTS(verifier_arena_scalar);
-	sysctl_set_or_fail(harden, NULL, old);
-}
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 04740ba37e91..6a494c381266 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -13,7 +13,6 @@
 #include "verifier_and.skel.h"
 #include "verifier_arena.skel.h"
 #include "verifier_arena_large.skel.h"
-#include "verifier_arena_scalar.skel.h"
 #include "verifier_arena_globals1.skel.h"
 #include "verifier_arena_globals2.skel.h"
 #include "verifier_array_access.skel.h"
@@ -207,7 +206,6 @@ void test_verifier_align(void)                { RUN(verifier_align); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
 void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
-void test_verifier_arena_scalar(void)         { RUN(verifier_arena_scalar); }
 void test_verifier_arena_globals1(void)       { RUN(verifier_arena_globals1); }
 void test_verifier_arena_globals2(void)       { RUN(verifier_arena_globals2); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
diff --git a/tools/testing/selftests/bpf/progs/arena_noarena.c b/tools/testing/selftests/bpf/progs/arena_noarena.c
index edbd40cd5be8..1f46e5aa403b 100644
--- a/tools/testing/selftests/bpf/progs/arena_noarena.c
+++ b/tools/testing/selftests/bpf/progs/arena_noarena.c
@@ -21,19 +21,4 @@ int arena_arg_no_arena(void *ctx)
 	return 0;
 }
 
-SEC("syscall")
-__flag(BPF_F_ARENA_SCALAR)
-__arch_x86_64
-__arch_arm64
-__description("arena_scalar: no arena, no access through a number")
-__failure __msg("R6 invalid mem access 'scalar'")
-__naked void no_arena(void)
-{
-	asm volatile ("					\
-	r6 = 0x100000000000 ll;				\
-	r0 = *(u64 *)(r6 + 0);				\
-	exit;						\
-"	::: __clobber_all);
-}
-
 char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena.c b/tools/testing/selftests/bpf/progs/verifier_arena.c
index 1ce9c4b78481..b17a6dfc100d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena.c
@@ -610,6 +610,21 @@ int mixed_arena_scalar_alu64_arena_first(void *ctx)
 	return 0;
 }
 
+SEC("syscall")
+__description("arena: a number is not an address in arena")
+__failure __msg("R6 invalid mem access 'scalar'")
+__naked void access_through_number(void)
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
 SEC("syscall")
 __success __retval(0)
 int scalar_xor_arena_ptr(void *ctx)
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c b/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
deleted file mode 100644
index 6f0efd9202ca..000000000000
--- a/tools/testing/selftests/bpf/progs/verifier_arena_scalar.c
+++ /dev/null
@@ -1,1155 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <linux/bpf.h>
-#include <bpf/bpf_helpers.h>
-#include "../../../include/linux/filter.h"
-#include "bpf_misc.h"
-
-void *bpf_arena_alloc_pages(void *map, void *addr, __u32 page_cnt, int node_id,
-			    __u64 flags) __ksym;
-void bpf_arena_free_pages(void *map, void *ptr, __u32 page_cnt) __ksym;
-
-#ifdef __TARGET_ARCH_arm64
-#define ARENA_VM_START (1ull << 32)
-#else
-#define ARENA_VM_START (1ull << 44)
-#endif
-
-struct {
-	__uint(type, BPF_MAP_TYPE_ARENA);
-	__uint(map_flags, BPF_F_MMAPABLE);
-	__uint(max_entries, 4);
-	__ulong(map_extra, ARENA_VM_START);
-} arena SEC(".maps");
-
-struct {
-	__uint(type, BPF_MAP_TYPE_HASH);
-	__uint(max_entries, 1);
-	__type(key, int);
-	__type(value, long long);
-} hash SEC(".maps");
-
-/* JITs that take BPF_F_ARENA_SCALAR */
-#define __arena_scalar __flag(BPF_F_ARENA_SCALAR) __arch_x86_64 __arch_arm64
-
-/* BTF FUNC records are not generated for kfuncs referenced from inline assembly */
-void __kfunc_btf_root(void)
-{
-	bpf_arena_alloc_pages(0, 0, 0, 0, 0);
-	bpf_arena_free_pages(0, 0, 0);
-}
-
-/* Tests start with r6 = address of a new page as the user space sees it, a number */
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: load and store of every size")
-__success __retval(0)
-__load_if_JITed()
-__naked void ld_st_sizes(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	r7 = r6;					\
-	r1 = 0x1122334455667788 ll;			\
-	*(u64 *)(r6 + 0) = r1;				\
-	*(u32 *)(r6 + 8) = r1;				\
-	*(u16 *)(r6 + 12) = r1;				\
-	*(u8 *)(r6 + 14) = r1;				\
-	*(u64 *)(r6 + 16) = 0x1234;			\
-	*(u32 *)(r6 + 24) = 0x5678;			\
-	*(u16 *)(r6 + 28) = 0x9a;			\
-	*(u8 *)(r6 + 30) = 0xbc;			\
-	r0 = 1;						\
-	r2 = *(u64 *)(r6 + 0);				\
-	if r2 != r1 goto 9f;				\
-	r0 = 2;						\
-	r2 = *(u32 *)(r6 + 8);				\
-	if r2 != 0x55667788 goto 9f;			\
-	r0 = 3;						\
-	r2 = *(u16 *)(r6 + 12);				\
-	if r2 != 0x7788 goto 9f;			\
-	r0 = 4;						\
-	r2 = *(u8 *)(r6 + 14);				\
-	if r2 != 0x88 goto 9f;				\
-	r0 = 5;						\
-	r2 = *(u64 *)(r6 + 16);				\
-	if r2 != 0x1234 goto 9f;			\
-	r0 = 6;						\
-	r2 = *(u32 *)(r6 + 24);				\
-	if r2 != 0x5678 goto 9f;			\
-	r0 = 7;						\
-	r2 = *(u16 *)(r6 + 28);				\
-	if r2 != 0x9a goto 9f;				\
-	r0 = 8;						\
-	r2 = *(u8 *)(r6 + 30);				\
-	if r2 != 0xbc goto 9f;				\
-	/* the address is what it was */		\
-	r0 = 9;						\
-	if r6 != r7 goto 9f;				\
-	r0 = 10;					\
-	r7 >>= 32;					\
-	if r7 == 0 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: load into the register that holds the address")
-__success __retval(0)
-__load_if_JITed()
-__naked void ld_into_base(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	r1 = 77;					\
-	*(u64 *)(r6 + 0) = r1;				\
-	r6 = *(u64 *)(r6 + 0);				\
-	r0 = 1;						\
-	if r6 != 77 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: sign extending load")
-__success __retval(0)
-__load_if_JITed()
-__naked void ldsx(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	r7 = r6;					\
-	*(u64 *)(r6 + 0) = 0x80;			\
-	.8byte %[ldsx_insn]; /* r2 = *(s8 *)(r6 + 0) */	\
-	r0 = 1;						\
-	if r2 != -128 goto 9f;				\
-	r0 = 2;						\
-	if r6 != r7 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages),
-	  __imm_insn(ldsx_insn, BPF_RAW_INSN(BPF_LDX | BPF_MEMSX | BPF_B,
-					     BPF_REG_2, BPF_REG_6, 0, 0))
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: address loaded from arena")
-__success __retval(0)
-__load_if_JITed()
-__naked void ptr_chase(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	/* page[0] = &page[64]; page[64] = 5; */	\
-	r1 = r6;					\
-	r1 += 64;					\
-	*(u64 *)(r6 + 0) = r1;				\
-	*(u64 *)(r1 + 0) = 5;				\
-	r2 = *(u64 *)(r6 + 0);				\
-	r0 = 1;						\
-	if r2 != r1 goto 9f;				\
-	r3 = *(u64 *)(r2 + 0);				\
-	r0 = 2;						\
-	if r3 != 5 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: atomics")
-__success __retval(0)
-__load_if_JITed()
-__naked void atomics(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	r7 = r6;					\
-	*(u64 *)(r6 + 8) = 1;				\
-	r1 = 2;						\
-	lock *(u64 *)(r6 + 8) += r1;			\
-	r1 = 4;						\
-	.8byte %[fetch_add_insn]; /* r1 = atomic_fetch_add((u64 *)(r6 + 8), r1) */ \
-	r0 = 1;						\
-	if r1 != 3 goto 9f;				\
-	r1 = 8;						\
-	.8byte %[xchg_insn]; /* r1 = xchg_64(r6 + 8, r1) */ \
-	r0 = 2;						\
-	if r1 != 7 goto 9f;				\
-	r0 = 8;						\
-	r1 = 16;					\
-	.8byte %[cmpxchg_insn]; /* r0 = cmpxchg_64(r6 + 8, r0, r1) */ \
-	r2 = r0;					\
-	r0 = 3;						\
-	if r2 != 8 goto 9f;				\
-	r2 = *(u64 *)(r6 + 8);				\
-	r0 = 4;						\
-	if r2 != 16 goto 9f;				\
-	r0 = 5;						\
-	if r6 != r7 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages),
-	  __imm_insn(fetch_add_insn, BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH,
-						   BPF_REG_6, BPF_REG_1, 8)),
-	  __imm_insn(xchg_insn, BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_6, BPF_REG_1, 8)),
-	  __imm_insn(cmpxchg_insn, BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_6, BPF_REG_1, 8))
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: fetching and/or/xor")
-__success __retval(0)
-__load_if_JITed()
-__naked void fetch_and_or_xor(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	r7 = 0x11000000110 ll;				\
-	*(u64 *)(r6 + 8) = r7;				\
-	r0 = r6;					\
-	r0 ^= 0x55;					\
-	r1 = 0x1100000011 ll;				\
-	.8byte %[fetch_or_dw]; /* r1 = atomic_fetch_or((u64 *)(r6 + 8), r1) */ \
-	r2 = r6;					\
-	r2 ^= 0x55;					\
-	if r0 == r2 goto 1f;				\
-	r0 = 99;					\
-	goto 9f;					\
-1:	r0 = 1;						\
-	if r1 != r7 goto 9f;				\
-	r7 = 0x11100000111 ll;				\
-	r1 = 0x11000000111 ll;				\
-	.8byte %[fetch_and_dw]; /* r1 = atomic_fetch_and((u64 *)(r6 + 8), r1) */ \
-	r0 = 2;						\
-	if r1 != r7 goto 9f;				\
-	r7 = 0x11000000111 ll;				\
-	r1 = 0x101 ll;					\
-	.8byte %[fetch_xor_dw]; /* r1 = atomic_fetch_xor((u64 *)(r6 + 8), r1) */ \
-	r0 = 3;						\
-	if r1 != r7 goto 9f;				\
-	r7 = 0x11000000010 ll;				\
-	r2 = *(u64 *)(r6 + 8);				\
-	r0 = 4;						\
-	if r2 != r7 goto 9f;				\
-	*(u32 *)(r6 + 16) = 0x110;			\
-	r1 = 0xdead000000000011 ll;			\
-	.8byte %[fetch_or_w]; /* r1 = atomic_fetch_or((u32 *)(r6 + 16), r1) */ \
-	r0 = 5;						\
-	if r1 != 0x110 goto 9f;				\
-	r1 = 0xdead000000000101 ll;			\
-	.8byte %[fetch_and_w]; /* r1 = atomic_fetch_and((u32 *)(r6 + 16), r1) */ \
-	r0 = 6;						\
-	if r1 != 0x111 goto 9f;				\
-	r1 = 0xdead000000000011 ll;			\
-	.8byte %[fetch_xor_w]; /* r1 = atomic_fetch_xor((u32 *)(r6 + 16), r1) */ \
-	r0 = 7;						\
-	if r1 != 0x101 goto 9f;				\
-	r2 = *(u32 *)(r6 + 16);				\
-	r0 = 8;						\
-	if r2 != 0x110 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages),
-	  __imm_insn(fetch_or_dw, BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH,
-						BPF_REG_6, BPF_REG_1, 8)),
-	  __imm_insn(fetch_and_dw, BPF_ATOMIC_OP(BPF_DW, BPF_AND | BPF_FETCH,
-						 BPF_REG_6, BPF_REG_1, 8)),
-	  __imm_insn(fetch_xor_dw, BPF_ATOMIC_OP(BPF_DW, BPF_XOR | BPF_FETCH,
-						 BPF_REG_6, BPF_REG_1, 8)),
-	  __imm_insn(fetch_or_w, BPF_ATOMIC_OP(BPF_W, BPF_OR | BPF_FETCH,
-					       BPF_REG_6, BPF_REG_1, 16)),
-	  __imm_insn(fetch_and_w, BPF_ATOMIC_OP(BPF_W, BPF_AND | BPF_FETCH,
-						BPF_REG_6, BPF_REG_1, 16)),
-	  __imm_insn(fetch_xor_w, BPF_ATOMIC_OP(BPF_W, BPF_XOR | BPF_FETCH,
-						BPF_REG_6, BPF_REG_1, 16))
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: fetching and/or/xor with the operand in r0")
-__success __retval(0)
-__load_if_JITed()
-__naked void fetch_and_or_xor_r0(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	r7 = 0x11000000110 ll;				\
-	*(u64 *)(r6 + 8) = r7;				\
-	r0 = 0x1100000011 ll;				\
-	.8byte %[fetch_or_dw]; /* r0 = atomic_fetch_or((u64 *)(r6 + 8), r0) */ \
-	r2 = r0;					\
-	r0 = 1;						\
-	if r2 != r7 goto 9f;				\
-	r7 = 0x11100000111 ll;				\
-	r0 = 0x11000000111 ll;				\
-	.8byte %[fetch_and_dw]; /* r0 = atomic_fetch_and((u64 *)(r6 + 8), r0) */ \
-	r2 = r0;					\
-	r0 = 2;						\
-	if r2 != r7 goto 9f;				\
-	r7 = 0x11000000111 ll;				\
-	r0 = 0x101 ll;					\
-	.8byte %[fetch_xor_dw]; /* r0 = atomic_fetch_xor((u64 *)(r6 + 8), r0) */ \
-	r2 = r0;					\
-	r0 = 3;						\
-	if r2 != r7 goto 9f;				\
-	r7 = 0x11000000010 ll;				\
-	r2 = *(u64 *)(r6 + 8);				\
-	r0 = 4;						\
-	if r2 != r7 goto 9f;				\
-	*(u32 *)(r6 + 16) = 0x110;			\
-	r0 = 0xdead000000000011 ll;			\
-	.8byte %[fetch_or_w]; /* r0 = atomic_fetch_or((u32 *)(r6 + 16), r0) */ \
-	r2 = r0;					\
-	r0 = 5;						\
-	if r2 != 0x110 goto 9f;				\
-	r0 = 0xdead000000000101 ll;			\
-	.8byte %[fetch_and_w]; /* r0 = atomic_fetch_and((u32 *)(r6 + 16), r0) */ \
-	r2 = r0;					\
-	r0 = 6;						\
-	if r2 != 0x111 goto 9f;				\
-	r0 = 0xdead000000000011 ll;			\
-	.8byte %[fetch_xor_w]; /* r0 = atomic_fetch_xor((u32 *)(r6 + 16), r0) */ \
-	r2 = r0;					\
-	r0 = 7;						\
-	if r2 != 0x101 goto 9f;				\
-	r2 = *(u32 *)(r6 + 16);				\
-	r0 = 8;						\
-	if r2 != 0x110 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages),
-	  __imm_insn(fetch_or_dw, BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH,
-						BPF_REG_6, BPF_REG_0, 8)),
-	  __imm_insn(fetch_and_dw, BPF_ATOMIC_OP(BPF_DW, BPF_AND | BPF_FETCH,
-						 BPF_REG_6, BPF_REG_0, 8)),
-	  __imm_insn(fetch_xor_dw, BPF_ATOMIC_OP(BPF_DW, BPF_XOR | BPF_FETCH,
-						 BPF_REG_6, BPF_REG_0, 8)),
-	  __imm_insn(fetch_or_w, BPF_ATOMIC_OP(BPF_W, BPF_OR | BPF_FETCH,
-					       BPF_REG_6, BPF_REG_0, 16)),
-	  __imm_insn(fetch_and_w, BPF_ATOMIC_OP(BPF_W, BPF_AND | BPF_FETCH,
-						BPF_REG_6, BPF_REG_0, 16)),
-	  __imm_insn(fetch_xor_w, BPF_ATOMIC_OP(BPF_W, BPF_XOR | BPF_FETCH,
-						BPF_REG_6, BPF_REG_0, 16))
-	: __clobber_all);
-}
-
-/*
- * The page is gone, so the access faults. The fetched register has to come back
- * 0 and everything else has to be left alone, r0 included. Reading the address
- * again has to give 0 as well: had the fault been recovered by the arena mapping
- * its zeroed scratch page instead of by the JIT's exception table entry, the
- * access would have succeeded and left a 1 there.
- */
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: fetching or through a number to a freed page")
-__success __retval(0)
-__load_if_JITed()
-__naked void fetch_or_freed_page(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	*(u64 *)(r6 + 8) = 0x55;			\
-	r1 = %[arena] ll;				\
-	r2 = r6;					\
-	r3 = 1;						\
-	call %[bpf_arena_free_pages];			\
-	r0 = r6;					\
-	r0 ^= 0x55;					\
-	r1 = 1;						\
-	.8byte %[fetch_or_dw]; /* faults: r1 = atomic_fetch_or((u64 *)(r6 + 8), r1) */ \
-	r2 = r6;					\
-	r2 ^= 0x55;					\
-	if r0 == r2 goto 1f;				\
-	r0 = 1;						\
-	goto 9f;					\
-1:	r0 = 2;						\
-	if r1 != 0 goto 9f;				\
-	r3 = *(u64 *)(r6 + 8);				\
-	r0 = 3;						\
-	if r3 != 0 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages),
-	  __imm(bpf_arena_free_pages),
-	  __imm_insn(fetch_or_dw, BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH,
-						BPF_REG_6, BPF_REG_1, 8))
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: fetching or with the operand in r0 to a freed page")
-__success __retval(0)
-__load_if_JITed()
-__naked void fetch_or_r0_freed_page(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	*(u64 *)(r6 + 8) = 0x55;			\
-	r1 = %[arena] ll;				\
-	r2 = r6;					\
-	r3 = 1;						\
-	call %[bpf_arena_free_pages];			\
-	r0 = 1;						\
-	.8byte %[fetch_or_dw]; /* faults: r0 = atomic_fetch_or((u64 *)(r6 + 8), r0) */ \
-	r2 = r0;					\
-	r0 = 1;						\
-	if r2 != 0 goto 9f;				\
-	r3 = *(u64 *)(r6 + 8);				\
-	r0 = 2;						\
-	if r3 != 0 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages),
-	  __imm(bpf_arena_free_pages),
-	  __imm_insn(fetch_or_dw, BPF_ATOMIC_OP(BPF_DW, BPF_OR | BPF_FETCH,
-						BPF_REG_6, BPF_REG_0, 8))
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: cmpxchg through r0")
-__success __retval(0)
-__load_if_JITed()
-__naked void cmpxchg_r0(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	/* The address is in r0. The value at the address is not equal to it. */ \
-	*(u64 *)(r6 + 0) = 3;				\
-	r0 = r6;					\
-	r1 = 5;						\
-	.8byte %[cmpxchg_insn]; /* r0 = cmpxchg_64(r0 + 0, r0, r1) */ \
-	r2 = r0;					\
-	r0 = 1;						\
-	if r2 != 3 goto 9f;				\
-	r2 = *(u64 *)(r6 + 0);				\
-	r0 = 2;						\
-	if r2 != 3 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages),
-	  __imm_insn(cmpxchg_insn, BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_0, BPF_REG_1, 0))
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: xchg into the register that holds the address")
-__success __retval(0)
-__load_if_JITed()
-__naked void xchg_into_base(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	*(u64 *)(r6 + 0) = 3;				\
-	r1 = r6;					\
-	.8byte %[xchg_insn]; /* r1 = xchg_64(r1 + 0, r1) */ \
-	r0 = 1;						\
-	if r1 != 3 goto 9f;				\
-	r2 = *(u64 *)(r6 + 0);				\
-	r0 = 2;						\
-	if r2 != r6 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages),
-	  __imm_insn(xchg_insn, BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_1, 0))
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: xchg into the register that holds a pointer to stack")
-__failure __msg("misaligned access off (0x0; 0xffffffffffffffff)+0 size 8")
-__naked void xchg_into_stack_ptr(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r1 = 0;						\
-	*(u64 *)(r10 - 8) = r1;				\
-	r1 = r10;					\
-	r1 += -8;					\
-	.8byte %[xchg_insn]; /* r1 = xchg_64(r1 + 0, r1) */ \
-	r0 = 0;						\
-	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm_insn(xchg_insn, BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_1, 0))
-	: __clobber_all);
-}
-
-#ifdef CAN_USE_LOAD_ACQ_STORE_REL
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: load-acquire and store-release")
-__success __retval(0)
-__load_if_JITed()
-__naked void load_acq_store_rel(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	r7 = r6;					\
-	r1 = 0x1234;					\
-	.8byte %[store_release_insn]; /* store_release((u64 *)(r6 + 8), r1) */ \
-	.8byte %[load_acquire_insn]; /* r2 = load_acquire((u64 *)(r6 + 8)) */ \
-	r0 = 1;						\
-	if r2 != 0x1234 goto 9f;			\
-	.8byte %[load_acquire8_insn]; /* w2 = load_acquire((u8 *)(r6 + 8)) */ \
-	r0 = 2;						\
-	if r2 != 0x34 goto 9f;				\
-	r0 = 3;						\
-	if r6 != r7 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages),
-	  __imm_insn(store_release_insn,
-		     BPF_ATOMIC_OP(BPF_DW, BPF_STORE_REL, BPF_REG_6, BPF_REG_1, 8)),
-	  __imm_insn(load_acquire_insn,
-		     BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_6, 8)),
-	  __imm_insn(load_acquire8_insn,
-		     BPF_ATOMIC_OP(BPF_B, BPF_LOAD_ACQ, BPF_REG_2, BPF_REG_6, 8))
-	: __clobber_all);
-}
-
-#endif /* CAN_USE_LOAD_ACQ_STORE_REL */
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: number that is not an address in arena")
-__success __retval(0)
-__load_if_JITed()
-__naked void not_in_arena(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	/* nothing is allocated: all loads read 0, stores are dropped */ \
-	r6 = 0xdeadbeef00000000 ll;			\
-	r0 = 1;						\
-	r2 = *(u64 *)(r6 + 0);				\
-	if r2 != 0 goto 9f;				\
-	r0 = 2;						\
-	r2 = *(u8 *)(r6 - 32768);			\
-	if r2 != 0 goto 9f;				\
-	r6 = 0x12345678ffffffff ll;			\
-	r0 = 3;						\
-	r2 = *(u64 *)(r6 + 32760);			\
-	if r2 != 0 goto 9f;				\
-	*(u64 *)(r6 + 32760) = 1;			\
-	*(u8 *)(r6 + 32767) = r2;			\
-	r1 = 1;						\
-	lock *(u64 *)(r6 + 32760) += r1;		\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: store through the address of the stack as a number")
-__success __retval(0)
-__load_if_JITed()
-__naked void stack_addr_as_number(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	*(u64 *)(r10 - 8) = 5;				\
-	r6 = r10;					\
-	r6 |= 0;					\
-	/* r6 is a number now. The store goes to arena, not to the stack. */ \
-	*(u64 *)(r6 - 8) = 7;				\
-	r1 = 9;						\
-	*(u64 *)(r6 - 8) = r1;				\
-	lock *(u64 *)(r6 - 8) += r1;			\
-	r2 = *(u64 *)(r10 - 8);				\
-	r0 = 1;						\
-	if r2 != 5 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: 64-bit math on the address stays 64-bit")
-__success __retval(0)
-__load_if_JITed()
-__naked void alu64_after_access(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	r2 = *(u64 *)(r6 + 0);				\
-	r7 = r6;					\
-	r7 += 8;					\
-	r7 -= r6;					\
-	r0 = 1;						\
-	if r7 != 8 goto 9f;				\
-	r7 = r6;					\
-	r7 >>= 32;					\
-	r0 = 2;						\
-	if r7 == 0 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: st of an immediate changes no register")
-__success __retval(0)
-__load_if_JITed()
-__naked void st_keeps_regs(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	r0 = r6;					\
-	r1 = 0x1111;					\
-	r2 = 0x2222;					\
-	*(u64 *)(r0 + 0) = 5;				\
-	r3 = r0;					\
-	r0 = 1;						\
-	if r3 != r6 goto 9f;				\
-	r0 = 2;						\
-	if r1 != 0x1111 goto 9f;			\
-	r0 = 3;						\
-	if r2 != 0x2222 goto 9f;			\
-	r0 = 0x3333;					\
-	r1 = r6;					\
-	*(u32 *)(r1 + 8) = -7;				\
-	r3 = r0;					\
-	r0 = 4;						\
-	if r3 != 0x3333 goto 9f;			\
-	r0 = 5;						\
-	if r1 != r6 goto 9f;				\
-	r0 = 6;						\
-	r3 = *(u64 *)(r6 + 0);				\
-	if r3 != 5 goto 9f;				\
-	r0 = 7;						\
-	r3 = *(u64 *)(r6 + 8);				\
-	r4 = 0xfffffff9 ll;				\
-	if r3 != r4 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: access through a number with garbage in the upper half")
-__success __retval(0)
-__load_if_JITed()
-__naked void st_value_garbage(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	r1 = 0xdeadbeef00001000 ll;			\
-	*(u64 *)(r6 + 2048) = r1;			\
-	r7 = *(u64 *)(r6 + 2048);			\
-	r8 = *(u64 *)(r6 + 2048);			\
-	r1 = 3;						\
-	*(u64 *)(r8 + 0) = 1;				\
-	r0 = 1;						\
-	if r8 != r7 goto 9f;				\
-	*(u8 *)(r8 + 1) = 1;				\
-	r0 = 2;						\
-	if r8 != r7 goto 9f;				\
-	*(u32 *)(r8 + 4) = r1;				\
-	r0 = 3;						\
-	if r8 != r7 goto 9f;				\
-	r2 = *(u16 *)(r8 + 2);				\
-	r0 = 4;						\
-	if r8 != r7 goto 9f;				\
-	r0 = 5;						\
-	if r1 != 3 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: access through a number without the upper half")
-__success __retval(0)
-__load_if_JITed()
-__naked void st_value_small(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	r1 = 0x1000 ll;					\
-	*(u64 *)(r6 + 2048) = r1;			\
-	r7 = *(u64 *)(r6 + 2048);			\
-	r8 = *(u64 *)(r6 + 2048);			\
-	r1 = 3;						\
-	*(u64 *)(r8 + 0) = 1;				\
-	r0 = 1;						\
-	if r8 != r7 goto 9f;				\
-	*(u8 *)(r8 + 1) = 1;				\
-	r0 = 2;						\
-	if r8 != r7 goto 9f;				\
-	*(u32 *)(r8 + 4) = r1;				\
-	r0 = 3;						\
-	if r8 != r7 goto 9f;				\
-	r2 = *(u16 *)(r8 + 2);				\
-	r0 = 4;						\
-	if r8 != r7 goto 9f;				\
-	r0 = 5;						\
-	if r1 != 3 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: atomics through a number that is not an address in arena")
-__success __retval(0)
-__load_if_JITed()
-__naked void atomic_value(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	r1 = 0xdeadbeef00001000 ll;			\
-	*(u64 *)(r6 + 2048) = r1;			\
-	r7 = *(u64 *)(r6 + 2048);			\
-	r8 = *(u64 *)(r6 + 2048);			\
-	r1 = 3;						\
-	lock *(u64 *)(r8 + 0) += r1;			\
-	r0 = 1;						\
-	if r8 != r7 goto 9f;				\
-	.8byte %[fetch_add_insn];			\
-	r0 = 2;						\
-	if r8 != r7 goto 9f;				\
-	.8byte %[xchg_insn];				\
-	r0 = 3;						\
-	if r8 != r7 goto 9f;				\
-	r0 = 0;						\
-	.8byte %[cmpxchg_insn];				\
-	r0 = 4;						\
-	if r8 != r7 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages),
-	  __imm_insn(fetch_add_insn, BPF_ATOMIC_OP(BPF_DW, BPF_ADD | BPF_FETCH,
-						   BPF_REG_8, BPF_REG_1, 0)),
-	  __imm_insn(xchg_insn, BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_8, BPF_REG_1, 0)),
-	  __imm_insn(cmpxchg_insn, BPF_ATOMIC_OP(BPF_DW, BPF_CMPXCHG, BPF_REG_8, BPF_REG_1, 0))
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: number and pointer to arena at the same insn")
-__success __retval(0)
-__load_if_JITed()
-__naked void mixed_number_arena(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	*(u64 *)(r6 + 8) = 0x1234;			\
-	/* a number that the verifier does not know, 0 at run time */ \
-	r7 = *(u64 *)(r6 + 16);				\
-	r8 = r6;					\
-	if r7 != 0 goto 1f;				\
-	.8byte %[cast_kern_insn];			\
-1:	*(u8 *)(r8 + 0) = 1;				\
-	*(u8 *)(r8 + 1) = r7;				\
-	r2 = *(u8 *)(r8 + 1);				\
-	lock *(u64 *)(r8 + 24) += r7;			\
-	r0 = 0;						\
-	if r7 != 0 goto 9f;				\
-	/* pointer to arena only: JIT adds all 64 bits of r8 to the base */ \
-	r0 = 2;						\
-	r2 = *(u64 *)(r8 + 8);				\
-	if r2 != 0x1234 goto 9f;			\
-	r0 = 3;						\
-	r2 = *(u8 *)(r6 + 0);				\
-	if r2 != 1 goto 9f;				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages),
-	  __imm_insn(cast_kern_insn, BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_X,
-						  BPF_REG_8, BPF_REG_8, 1, 1))
-	: __clobber_all);
-}
-
-SEC("syscall")
-__description("arena_scalar: no flag, no access through a number")
-__failure __msg("R6 invalid mem access 'scalar'")
-__naked void no_flag(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r6 = 0x100000000000 ll;				\
-	r0 = *(u64 *)(r6 + 0);				\
-	exit;						\
-"	:
-	: __imm_addr(arena)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: pointer that is NULL is an address in arena")
-__success __retval(0)
-__load_if_JITed()
-__naked void null_ptr(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r1 = 0;						\
-	*(u32 *)(r10 - 4) = r1;				\
-	r2 = r10;					\
-	r2 += -4;					\
-	r1 = %[hash] ll;				\
-	call %[bpf_map_lookup_elem];			\
-	r1 = r0;					\
-	r0 = 1;						\
-	if r1 != 0 goto 9f;				\
-	/* nothing is allocated: the load reads 0 */	\
-	r0 = *(u64 *)(r1 + 0);				\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm_addr(hash),
-	  __imm(bpf_map_lookup_elem)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: pointer that is NULL with an offset is an address in arena")
-__success __retval(0)
-__load_if_JITed()
-__naked void null_ptr_off(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r1 = 0;						\
-	*(u32 *)(r10 - 4) = r1;				\
-	r2 = r10;					\
-	r2 += -4;					\
-	r1 = %[hash] ll;				\
-	call %[bpf_map_lookup_elem];			\
-	r1 = r0;					\
-	r0 = 1;						\
-	if r1 != 0 goto 9f;				\
-	r1 += 8;					\
-	*(u64 *)(r1 + 0) = 5;				\
-	r0 = *(u64 *)(r1 + 0);				\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm_addr(hash),
-	  __imm(bpf_map_lookup_elem)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: number that is less than a page is an address in arena")
-__success __retval(0)
-__load_if_JITed()
-__naked void small_number(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	call %[bpf_get_prandom_u32];			\
-	r1 = r0;					\
-	r1 &= 0xfff;					\
-	r0 = *(u64 *)(r1 + 0);				\
-	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_get_prandom_u32)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: number is not a pointer for a helper")
-__failure __msg("R2 type=scalar expected=")
-__naked void helper_arg(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	r1 = %[hash] ll;				\
-	r2 = r6;					\
-	call %[bpf_map_lookup_elem];			\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm_addr(hash),
-	  __imm(bpf_arena_alloc_pages),
-	  __imm(bpf_map_lookup_elem)
-	: __clobber_all);
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: number and pointer to stack at the same insn")
-__failure __msg("same insn cannot be used with different pointers")
-__load_if_JITed()
-__naked void mixed_number_stack(void)
-{
-	asm volatile ("					\
-	r1 = %[arena] ll;				\
-	r2 = 0;						\
-	r3 = 1;						\
-	r4 = -1;					\
-	r5 = 0;						\
-	call %[bpf_arena_alloc_pages];			\
-	r6 = r0;					\
-	r0 = 100;					\
-	if r6 == 0 goto 9f;				\
-	*(u64 *)(r10 - 8) = 0;				\
-	call %[bpf_get_prandom_u32];			\
-	if w0 != 0 goto 1f;				\
-	r6 = r10;					\
-	r6 += -8;					\
-1:	r0 = *(u64 *)(r6 + 0);				\
-	r0 = 0;						\
-9:	exit;						\
-"	:
-	: __imm_addr(arena),
-	  __imm(bpf_arena_alloc_pages),
-	  __imm(bpf_get_prandom_u32)
-	: __clobber_all);
-}
-
-static int st_cb(__u64 idx, void *ctx)
-{
-	volatile long *p = *(volatile long **)ctx;
-
-	p[idx] = 7;
-	return 0;
-}
-
-SEC("syscall")
-__arena_scalar
-__description("arena_scalar: store through a number in a callback")
-__success __retval(0)
-__load_if_JITed()
-int st_in_callback(void *unused)
-{
-	volatile long *p = bpf_arena_alloc_pages(&arena, NULL, 1, -1, 0);
-
-	if (!p)
-		return 100;
-	bpf_loop(4, st_cb, &p, 0);
-	return p[0] + p[3] + p[4] - 14;
-}
-
-char _license[] SEC("license") = "GPL";
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 824e5912ebcb..d24e4fedae46 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -590,8 +590,6 @@ static int parse_test_spec(struct test_loader *tester,
 				update_flags(&spec->prog_flags, BPF_F_XDP_HAS_FRAGS, clear);
 			} else if (strcmp(val, "BPF_F_TEST_REG_INVARIANTS") == 0) {
 				update_flags(&spec->prog_flags, BPF_F_TEST_REG_INVARIANTS, clear);
-			} else if (strcmp(val, "BPF_F_ARENA_SCALAR") == 0) {
-				update_flags(&spec->prog_flags, BPF_F_ARENA_SCALAR, clear);
 			} else /* assume numeric value */ {
 				err = parse_int(val, &flags, "test prog flags");
 				if (err)
-- 
2.55.0

