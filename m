Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792983699;
	b=1IIJynLmgZ60Pjjc0e6YKPAFWHK6GSvyvYvdfyI7GmrMnG0IHQRnz0gMEPPSErQHRhQF
	 0/JagtFLqK8wjyqOcaiwYNvq1GJ0Rbpcp2QihyVYFEFsl+28ULddf0LnXOEb7bH6BSRpD
	 ca0mcBo+Ocb/e1ci6TWl+Wvc9xfq2vj5jFeWKYn7+667rAbBMygUrXk9mxkeyY2eaE6da
	 dRANBUsinBiizue1QPJ06QfZi9xRDuSUTb0CRVJzgAiDS/VvTws6w0I1hQ2cRatmUIe+8
	 0qxLKnuawzMyCmDQ4HAJlApN9DF3ITd6Pw0u5puCO1rgWqGRE8GMy+H/TMWTdIYt6Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792983699;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NOt3dzm2ZiqSXGU4Rr9MDb/KLnI/AQh3xuhKiQtDTn8=;
	b=V+th38tdbErtkgUXz/rqnIQm3AYSRRxjJDmm6TK7aS9O1xBCCPv3JNmF1AvJhl5kkxFu
	 pBXOHwLh6+uAy2ZrrhtGrdIgiF4GiaiHOLMgXPoSKYY9EZQ4u8BlLUxV3LXqAjVtKgKvL
	 q/FfqGXiY1ci4OxCr+J0InHd6GOx6Y6pgE3zF20YEs5fO9JmoSNR+Sy7bDYcP5inxVI/E
	 wMTRGo6uNPPacy1wThX91uLEFbDwVyNGKfgnonmc/uyJ5vLGO06Z6MD/EeWGEC+Fna0e6
	 0Acvesgu6KkwLQBp20ENitFEqhoc6UAYxFynQKOys3YBc9zPBhcfFyOb4vmWraoty1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OzQe9FuJ;
	arc=none smtp.remote-ip=209.85.214.174
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD8E606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBD8E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OzQe9FuJ
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2e9eb579c0eso13387515ad.3
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 20:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792983698; x=1793588498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NOt3dzm2ZiqSXGU4Rr9MDb/KLnI/AQh3xuhKiQtDTn8=;
        b=OzQe9FuJR/aF7gDysybRy8TauVjWTThbSmZwxMaDjfM0RG/vgDTJ/o6qvIKvRA0Fs5
         RxNck+q4okOGTcdqOCnEinHrOlq9gn/yDOMxtK6sEWKmr8JdZJxg2ErkFibYDYPCC0U+
         JGq7H0b6tyvgJWtI1L+No0gG7bbzZgGpElXTQQ+A+fFNYmqyTJHlYDbLC1EyaYyMB1JW
         zAuM6FDJZmiFRE5V/fYiz030xoNc23NPl5zeyt8vEsw0joEu0qx52PigohfrndAbBHVm
         auIwbs1GowREw+P/qL6xlXEEg0MfeSjl/xzVMslaOwIFtn6IdX7KrDSkTRnqfiszD74P
         QECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792983698; x=1793588498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NOt3dzm2ZiqSXGU4Rr9MDb/KLnI/AQh3xuhKiQtDTn8=;
        b=K+yexJ31fMjGxfONSGlVPSe4fENb+ImHkbjsRf/XQL0po36JgNdNdi+GOXIzKMjXpN
         l+2KDl/GE5RPlDq8BWj4HXEr7/rsz0FTcNac2JrkBGSsaCM6kZTY42Su0u369KIQYsUB
         RXe+IuJHJrgsLZbY2KR6SVBNy60SMMH5tARheNb/HH/JTEV4SX6htK+TOFcAVNG7qcRO
         8L1GvGKruCw165yp+/VKNfbGoTm6+dBokDB3ANxMm6ZnRyZUzj1lt7XvD9S9uYAyo+Qi
         gc7HgLHkmpbbTJQ3ZyrsOFAb8TaqiVLVhadwTyslTSa9krEqUowtNbNxwZqoJ3WNI+Cy
         AE5w==
X-Gm-Message-State: AFq9FYIQksP2xWyqODurMo8Kz8ZfEqqftjF4EwMAuzDnCpKn58yCBPUG
	ZsrfLK6Zo8Ecdl2ucxD1YOcF/j/cnRDnNOdEV5nMc3LYx9lxfRt+CCWngyDW2A==
X-Gm-Gg: AYBFou3mrfTbkkK+2NT6K9vdrtTP8xpT/wzz9PeJCz8ioJI+uJQJXHf0Db83W/sfMgY
	vsyHz5w/8FStn47ZXFu2mmFUVU9yfamPSypny5H2KdVIzwLlMR1CYE3hPiIuI23WVqmhJaEioWj
	GxBvU+GrrEAErdmmVsYHI98AlwrZInfTI0OD1hn2TZzN3jILllPcul1r+Qt/kG1eKlTzio5SJER
	yCcYPBg6gEmOyvrcc99qMG5wHustEvx5pTbuGDCqyfiTPaLDwqICdpGTGq3+sfcKNPRQigrgHQ6
	Hf1B0zV2fjfxqaz+cowagZ8rP4Pz22cEJ11vEyQYKfn4+5r9eoCRno7XwyWPAs1ZEK30K5aV+SE
	YJFu8KTmScXxOElXx3EUWopwNofHz95/WAXjo98wlMzQSLYZyERj+kRWW/ul7mja2zbDHV781du
	hIMrSe2NwSe3CCLUahknCiffZE37uQHgh0F7g2+bBjuDwHuavHGRMBBNSTHKp5pwxdo5pY80E0G
	6XqkfWIsb5pw0fRVhAw36R24lUvfVxHlvqXcG8f1iZKNdLtUS+f0GdJhba5LxVi6o9EzFalDo24
	VRnk5sSidoRO2kLCtz8jtTVi54JveYxSoWtUvIItdkI/YSHXgvJA6HdlVRgThTr4CufpmTHZI20
	jtmLZhP8Y/Bqtu1K7q724ybAt
X-Received: by 2002:a17:902:f60a:b0:2e9:5eee:e085 with SMTP id d9443c01a7336-2ea9c6c82c3mr40083795ad.19.1792983698151;
        Sun, 25 Oct 2026 20:01:38 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b14c1e6sm10928085ad.32.2026.10.25.20.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 20:01:37 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 19/81] selftests/bpf: Test addr_space_cast of pointers that are not in arena
Date: Mon, 26 Oct 2026 02:58:40 +0000
Message-ID: <20261026025943.404450-20-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com>
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

The verifier does not check an access through a pointer to arena. Thus a
kernel pointer must keep its type after the cast to address space 0. See
"bpf: Treat addr_space_cast of a pointer that is not in arena as a move".

  test                         what the prog does or shows           result
  ---------------------------  ------------------------------------  ------
  map_value                    the cast is 'r6 = r0'                 loads
  map_value_same_reg           the cast of r0 to r0 is removed       loads
  map_value_bounds             access beyond the map value           reject
  map_value_or_null            access without a NULL check           reject
  map_value_null_check_of_src  NULL check of r0 applies to r6        loads
  ctx                          r6 is ctx                             loads
  btf_id                       r6 is trusted_ptr_task_struct         loads
  ref_released                 releases a reference through r1       loads
  ref_leaked                   does not release a reference          reject
  stack                        r6 is fp-8                            loads
  spill_through_cast           spills ctx through r6, fills it       loads
  callee_writes                callee writes the caller's stack      loads
  callee_reads                 callee reads the caller's stack       loads
  number                       r6 is arena, the cast is 'w6 = w6'    loads
  number_and_pointer           one cast gets a number and ctx        reject
  pointer_and_number           the same, the paths are exchanged     reject
  cast_user                    cast of ctx to as(1) gives a scalar   loads

The progs that return the content of a map value or of a stack slot also
run. The result shows that they read the object and not arena. callee_reads
needs the change in arg_track_xfer().

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_arena_cast.c | 456 ++++++++++++++++++
 2 files changed, 458 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_cast.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 6a494c381266..643d67782619 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -12,6 +12,7 @@
 #include "verifier_align.skel.h"
 #include "verifier_and.skel.h"
 #include "verifier_arena.skel.h"
+#include "verifier_arena_cast.skel.h"
 #include "verifier_arena_large.skel.h"
 #include "verifier_arena_globals1.skel.h"
 #include "verifier_arena_globals2.skel.h"
@@ -205,6 +206,7 @@ void test_verifier_aggregate_ret(void)        { RUN_TESTS(verifier_aggregate_ret
 void test_verifier_align(void)                { RUN(verifier_align); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
+void test_verifier_arena_cast(void)           { RUN(verifier_arena_cast); }
 void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
 void test_verifier_arena_globals1(void)       { RUN(verifier_arena_globals1); }
 void test_verifier_arena_globals2(void)       { RUN(verifier_arena_globals2); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_cast.c b/tools/testing/selftests/bpf/progs/verifier_arena_cast.c
new file mode 100644
index 000000000000..3208f1009534
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_cast.c
@@ -0,0 +1,456 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+struct task_struct {};
+struct task_struct *bpf_task_acquire(struct task_struct *p) __ksym;
+void bpf_task_release(struct task_struct *p) __ksym;
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
+/* BTF FUNC records are not generated for kfuncs referenced from inline assembly */
+void __kfunc_btf_root(void)
+{
+	bpf_task_release(bpf_task_acquire(0));
+}
+
+/* dst = addr_space_cast(src, 0, 1) */
+#define CAST_KERN(dst, src) \
+	BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_X, dst, src, BPF_ADDR_SPACE_CAST, 1)
+/* dst = addr_space_cast(src, 1, 0) */
+#define CAST_USER(dst, src) \
+	BPF_RAW_INSN(BPF_ALU64 | BPF_MOV | BPF_X, dst, src, BPF_ADDR_SPACE_CAST, 1 << 16)
+
+/* r0 = the element of the hash map or NULL. There is one after the update. */
+#define UPDATE_AND_LOOKUP				\
+	"r1 = 0;"					\
+	"*(u32 *)(r10 - 4) = r1;"			\
+	"r1 = 7;"					\
+	"*(u64 *)(r10 - 16) = r1;"			\
+	"r1 = %[hash] ll;"				\
+	"r2 = r10;"					\
+	"r2 += -4;"					\
+	"r3 = r10;"					\
+	"r3 += -16;"					\
+	"r4 = 0;"					\
+	"call %[bpf_map_update_elem];"			\
+	"r1 = %[hash] ll;"				\
+	"r2 = r10;"					\
+	"r2 += -4;"					\
+	"call %[bpf_map_lookup_elem];"
+
+SEC("syscall")
+__description("arena cast: a pointer to map value, it's a move")
+__success __retval(7)
+__xlated("r6 = r0")
+__xlated("r0 = *(u64 *)(r6 +0)")
+__naked void map_value(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	UPDATE_AND_LOOKUP
+	"if r0 == 0 goto 1f;"
+	".8byte %[cast_r6_r0];"
+	"r0 = *(u64 *)(r6 + 0);"
+"1:"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_addr(hash),
+	  __imm(bpf_map_update_elem),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_insn(cast_r6_r0, CAST_KERN(BPF_REG_6, BPF_REG_0))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena cast: a pointer to map value into the same register, it's removed")
+__success __retval(7)
+__xlated("r7 = r0")
+__xlated("r0 = *(u64 *)(r0 +0)")
+__xlated("exit")
+__naked void map_value_same_reg(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	UPDATE_AND_LOOKUP
+	"if r0 == 0 goto 1f;"
+	"r7 = r0;"
+	".8byte %[cast_r0_r0];"
+	"r0 = *(u64 *)(r0 + 0);"
+"1:"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_addr(hash),
+	  __imm(bpf_map_update_elem),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_insn(cast_r0_r0, CAST_KERN(BPF_REG_0, BPF_REG_0))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena cast: bounds of map value are checked after the cast")
+__failure __msg("invalid access to map value, value_size=8 off=8 size=8")
+__naked void map_value_bounds(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	UPDATE_AND_LOOKUP
+	"if r0 == 0 goto 1f;"
+	".8byte %[cast_r6_r0];"
+	"r0 = *(u64 *)(r6 + 8);"
+"1:"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_addr(hash),
+	  __imm(bpf_map_update_elem),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_insn(cast_r6_r0, CAST_KERN(BPF_REG_6, BPF_REG_0))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena cast: a pointer that may be NULL has to be checked after the cast")
+__failure __msg("R6 invalid mem access 'map_value_or_null'")
+__naked void map_value_or_null(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	UPDATE_AND_LOOKUP
+	".8byte %[cast_r6_r0];"
+	"r0 = *(u64 *)(r6 + 0);"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_addr(hash),
+	  __imm(bpf_map_update_elem),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_insn(cast_r6_r0, CAST_KERN(BPF_REG_6, BPF_REG_0))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena cast: NULL check of the pointer is for its copy too")
+__success __retval(7)
+__naked void map_value_null_check_of_src(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	UPDATE_AND_LOOKUP
+	".8byte %[cast_r6_r0];"
+	"if r0 == 0 goto 1f;"
+	"r0 = *(u64 *)(r6 + 0);"
+"1:"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_addr(hash),
+	  __imm(bpf_map_update_elem),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_insn(cast_r6_r0, CAST_KERN(BPF_REG_6, BPF_REG_0))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("arena cast: a pointer to ctx")
+__success __log_level(2)
+__msg("R6=ctx()")
+__naked void ctx(void)
+{
+	asm volatile (
+	"r2 = %[arena] ll;"
+	".8byte %[cast_r6_r1];"
+	"r0 = *(u32 *)(r6 + %[len]);"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_const(len, offsetof(struct __sk_buff, len)),
+	  __imm_insn(cast_r6_r1, CAST_KERN(BPF_REG_6, BPF_REG_1))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena cast: a pointer to task_struct")
+__success __log_level(2)
+__msg("R6=trusted_ptr_task_struct()")
+__naked void btf_id(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	"call %[bpf_get_current_task_btf];"
+	".8byte %[cast_r6_r0];"
+	"r0 = *(u32 *)(r6 + 0);"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm(bpf_get_current_task_btf),
+	  __imm_insn(cast_r6_r0, CAST_KERN(BPF_REG_6, BPF_REG_0))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena cast: a reference is released through the copy")
+__success __retval(0)
+__naked void ref_released(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	"call %[bpf_get_current_task_btf];"
+	"r1 = r0;"
+	"call %[bpf_task_acquire];"
+	"if r0 == 0 goto 1f;"
+	".8byte %[cast_r1_r0];"
+	"call %[bpf_task_release];"
+"1:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm(bpf_get_current_task_btf),
+	  __imm(bpf_task_acquire),
+	  __imm(bpf_task_release),
+	  __imm_insn(cast_r1_r0, CAST_KERN(BPF_REG_1, BPF_REG_0))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena cast: a reference doesn't go away")
+__failure __msg("Unreleased reference")
+__naked void ref_leaked(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	"call %[bpf_get_current_task_btf];"
+	"r1 = r0;"
+	"call %[bpf_task_acquire];"
+	"if r0 == 0 goto 1f;"
+	".8byte %[cast_r0_r0];"
+"1:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm(bpf_get_current_task_btf),
+	  __imm(bpf_task_acquire),
+	  __imm_insn(cast_r0_r0, CAST_KERN(BPF_REG_0, BPF_REG_0))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena cast: a number")
+__success __log_level(2)
+__msg("R6=arena")
+__xlated("w6 = w6")
+__naked void number(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	"r6 = %[addr] ll;"
+	".8byte %[cast_r6_r6];"
+	"r0 = *(u64 *)(r6 + 0);"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_const(addr, ARENA_VM_START),
+	  __imm_insn(cast_r6_r6, CAST_KERN(BPF_REG_6, BPF_REG_6))
+	: __clobber_all);
+}
+
+/* static analysis of the stack doesn't follow the pointer through the cast */
+SEC("syscall")
+__description("arena cast: a pointer to stack")
+__success __retval(7) __log_level(2)
+__msg("R6=fp-8")
+__naked void stack(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	"r6 = r10;"
+	"r6 += -8;"
+	".8byte %[cast_r6_r6];"
+	"r0 = 7;"
+	"*(u64 *)(r6 + 0) = r0;"
+	"r0 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_insn(cast_r6_r6, CAST_KERN(BPF_REG_6, BPF_REG_6))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena cast: a pointer is spilled through the cast of a pointer to stack")
+__success
+__naked void spill_through_cast(void)
+{
+	asm volatile (
+	"r2 = %[arena] ll;"
+	"r6 = r10;"
+	"r6 += -8;"
+	".8byte %[cast_r6_r6];"
+	"*(u64 *)(r6 + 0) = r1;"
+	"r2 = *(u64 *)(r10 - 8);"
+	/* it's ctx */
+	"r0 = *(u32 *)(r2 + 0);"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_insn(cast_r6_r6, CAST_KERN(BPF_REG_6, BPF_REG_6))
+	: __clobber_all);
+}
+
+static __naked __noinline __used long writes_through_cast(long p)
+{
+	asm volatile (
+	".8byte %[cast_r1_r1];"
+	"r0 = 7;"
+	"*(u64 *)(r1 + 0) = r0;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(cast_r1_r1, CAST_KERN(BPF_REG_1, BPF_REG_1))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena cast: the callee writes to the stack of the caller")
+__success __retval(7)
+__naked void callee_writes(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	"r0 = 0;"
+	"*(u64 *)(r10 - 8) = r0;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call writes_through_cast;"
+	"r0 = *(u64 *)(r10 - 8);"
+	"exit;"
+	:
+	: __imm_addr(arena)
+	: __clobber_all);
+}
+
+static __naked __noinline __used long reads_through_cast(long p)
+{
+	asm volatile (
+	"r6 = r1;"
+	/* a place where what is not live is forgotten */
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 0 goto +0;"
+	".8byte %[cast_r6_r6];"
+	"r0 = *(u64 *)(r6 + 0);"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32),
+	  __imm_insn(cast_r6_r6, CAST_KERN(BPF_REG_6, BPF_REG_6))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena cast: the callee reads the stack of the caller")
+__success __retval(5)
+__naked void callee_reads(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	"r0 = 5;"
+	"*(u64 *)(r10 - 8) = r0;"
+	"r1 = r10;"
+	"r1 += -8;"
+	"call reads_through_cast;"
+	"exit;"
+	:
+	: __imm_addr(arena)
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("arena cast: a number and a pointer at the same insn")
+__failure __msg("same addr_space_cast insn cannot be used with a number and with a pointer")
+__naked void number_and_pointer(void)
+{
+	asm volatile (
+	"r2 = %[arena] ll;"
+	"r6 = r1;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 0 goto 1f;"
+	"r6 = 4096;"
+"1:"
+	".8byte %[cast_r6_r6];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm(bpf_get_prandom_u32),
+	  __imm_insn(cast_r6_r6, CAST_KERN(BPF_REG_6, BPF_REG_6))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("arena cast: a pointer and a number at the same insn")
+__failure __msg("same addr_space_cast insn cannot be used with a number and with a pointer")
+__naked void pointer_and_number(void)
+{
+	asm volatile (
+	"r2 = %[arena] ll;"
+	"r6 = 4096;"
+	"r7 = r1;"
+	"call %[bpf_get_prandom_u32];"
+	"if r0 == 0 goto 1f;"
+	"r6 = r7;"
+"1:"
+	".8byte %[cast_r6_r6];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm(bpf_get_prandom_u32),
+	  __imm_insn(cast_r6_r6, CAST_KERN(BPF_REG_6, BPF_REG_6))
+	: __clobber_all);
+}
+
+SEC("tc")
+__description("arena cast: the cast to as(1) of a pointer is a number")
+__success __log_level(2)
+__msg("R6=scalar()")
+__naked void cast_user(void)
+{
+	asm volatile (
+	"r2 = %[arena] ll;"
+	".8byte %[cast_r6_r1];"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_insn(cast_r6_r1, CAST_USER(BPF_REG_6, BPF_REG_1))
+	: __clobber_all);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

