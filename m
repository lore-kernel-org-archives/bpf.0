Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793502337;
	b=UWGMmh2gs+Ey3bPZdaya+lFJ69X5/SAlruOM49q0Cno6zpNjt2+ixh28HcJQKk6WM9OP
	 T12RsOErqJSMJKhTTfdTGehgWnvm3oqr+go7woV/egtRoSISxNZl8MSdkqQUuOipbiFu4
	 5jlFZsNhu1qnzFQ4rwweP/sNef2cyhlW/5YG7lvkZr4lecKBkzJy/7oRLobmDU0AOOrDn
	 SQhYkcTvRr1myOpAgsGqzTVBB/vIkwkePQMLCjm4ypD1vSlRimN5YYff5Pfn7l9LXCFvz
	 hwa3gPpli08a087XyuUo1sP0XfQziaJRaDDyGyE8c/CLFZArxBNNCKbXg8Zl3+A3XIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793502337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aHsNLHl4aybtuO1BBotS5onWTGNNFy5/yD5WWybDJ6s=;
	b=JaHn9ygn5lxZxXbcUTFAaW5To/theHuOqK8lPQbeGE42vRJCFYG6E9fRQE7suqci/w6G
	 NfR6PLkjwmY3m7cRoMkRGYQYtjmmdEkf/afLKuxXToHYYY4iR+PUGidVb2HdV0+95nDOE
	 ksDLt0x1v3R0oghNU3JvHg1FoLujYRb1Pzan54WND8lJAREX1w7l6MUfeg2xWup5U00gU
	 3T1OUhZwMgh96oEv+c1hb1dzOHvtH72Ga6w9OOFyOUmv5Ze+mhIhEhUZgNPrkN2g6CDr0
	 sY8kueQWT6aKuSnRsY37kvRZl9LmqGOHWV/F+dlY4+gSxkDONR+GuHHnqCpf330qwgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="pN9h4s/G";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B566606A324
	for <bpf@vger.kernel.org>; Sun,  1 Nov 2026 03:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B566606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pN9h4s/G
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so1440707a91.0
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 20:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793502337; x=1794107137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aHsNLHl4aybtuO1BBotS5onWTGNNFy5/yD5WWybDJ6s=;
        b=pN9h4s/G3GPrG31g6McOmdK6ztGYUN+w0jd8GcIQCJNvvp9kfMfIAT1Grruqm87noZ
         7u9Br1xqdjZ3swft2CP24BAtx795dNZNZRg1Sn2YvG24mISqqReGWr1rHQoq7amZbY5y
         CFDryvwu9k0GMVSWbNrVmhQX53aYg1E6yYpyZZtX6uOgDzn8K/4KUMjz4xRribtYswfP
         kHeuoX9Qd89n6oFGwUPxtqYv2NnuH1cnJCVMKoBa+5fFwIE8vxaPw9nnOzX9ElVfy5ql
         9QKRnb3enHEd7hor72p7gV01Qz91VjZ27J4QSEclffYHvGAuteXQ+pULefHYIMh0CoZD
         4T6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793502337; x=1794107137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aHsNLHl4aybtuO1BBotS5onWTGNNFy5/yD5WWybDJ6s=;
        b=Sy0YM1g3GS6Uu8m+TNWc3ZZN7V/r5n+cqHsCO3/w0Yxwjb4KjiIiW6iRAijVQaWqcC
         lj1oA0IxiqJ74fphOMElXadeywa/PrhCVtjDCrhSIj8dvmSs038a8RfwqIz//3rlCNzV
         Tvph57QrtEnGlK6KiJ82Y8WGyO9bipIv197Rx32lp+PYGgrCmW4qsEQL76fEBQ+bW9/n
         xo33B2ETJ/cinqbS2QrZ65u2f69XY4Y0lWiplBpo6lO8jGAbbsc01jnBxg/zCVKAYUMy
         gCCUEDofxetOIFImGFqPVNyhu1ztquBs5Rki8OU26y2f4VkVVrFEvtJxh9uPjUntRFlF
         27Pg==
X-Gm-Message-State: APuU4Z/w/sige+yifcXKnGh+cj4B6BS90Bs9Y9Brd/QnM8yIulumfvFl
	2VkU5VuaQat2ugfCzBnu26XMsleOLa3sd1EG255GVbLZZsDfgJxivABMuCTmyw==
X-Gm-Gg: AYBFou2QGHzgdD7Isr8AdntVQwU5gb6l8pwSfE2Qanp7d1SrL5ApI34iRl5GkRI0kK+
	Yr66q39IgSMgCVFU5maHvVjGdP3suoFim6FgIMtt83+ulkJrq12w+vvsUiLezYuuaAl0jfC0nPO
	hNUbjzrMPrdzqTZTUj+AcXZcSObDrbhSTvV52I/5vkcgcOX8XjEcvxTV24Y9JCOPrKQx50xGOp+
	RHVkyQK20LTr5MDOogWQf6zqpEsXb1+0/EsM3l2jjIXKcCcowJk+DMJf7gvPlvC3n57Y0AfBDze
	BLqPim/3VtyUZPvwiaPSh7KDl8gRe2F4j58aDhJezDSXLE4E6ZlfRn5Jjx7rWfMeADRCmZqzWwg
	xgtFymLoGwRxsEUTZulEUfAAwyxXH3KjaFqusipN8yR2mNzp1sY/wqLsbms3P3sV58XQkVFptmX
	5jZB5H/ivFD4Q4ne9OqNvBgzW/8zTztNXvVRsdB06yDxk0bpMl1yxg5nwvslZ8GMe97TKp0rmiY
	cf/sCpZjn8Ma5Xx1l9AVGnOsMQgz1rq15ZYi6ngVS9YElmH+ohTXZOgTa3CUKGyqnHIyzq4+wnn
	TmOJQtEiW1IRRA+qFdO//csjqFM9HJGkcOYSC5db1vC5seTfWJqQQ/V7SDg0omwk3Tua66rd0k8
	asn2vYIUPIVnBryxBovIHfx77jhGffiwdp1abIKzXGa94l2UsSdJVbW7+CWtf15kSCjm5GVWYBw
	==
X-Received: by 2002:a17:90b:5808:b0:3ac:aa8d:19de with SMTP id 98e67ed59e1d1-3ae895743ebmr5591696a91.3.1793502336457;
        Sat, 31 Oct 2026 20:05:36 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e2a703esm13689575a91.0.2026.10.31.20.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 20:05:36 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 04/14] selftests/bpf: Test addr_space_cast of pointers that are not in arena
Date: Sun,  1 Nov 2026 03:05:00 +0000
Message-ID: <20261101030511.1578690-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
References: <20261101030511.1578690-1-alexei.starovoitov@gmail.com>
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

The analysis of live stack slots can take a number for a pointer to the
stack: a slot held such a pointer, and a helper or a short store overwrote
it. The cast of this number gives a pointer to arena. A store through it
must not count as a write to the stack:

  test                             what the prog does or shows       result
  -------------------------------  --------------------------------  ------
  stale_spill_store                the store hides a write to the    reject
                                   counter of a loop
  stale_spill_store_r10            the same, the stale value is r10  reject
  stale_spill_live_slot            a slot is read after the store    loads
  stale_spill_live_slot_of_caller  the same, a slot of the caller    loads
  store_over_spilled_r10           a pointer to a map value is       reject
                                   stored over r10 through the cast
  r10_stored_to_arena              r10 is stored to arena            reject
  callee_writes_in_loop            the loop stays counted when the   loads
                                   callee writes through the cast

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_arena_cast.c | 762 ++++++++++++++++++
 2 files changed, 764 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_cast.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 386ad81051a9..a1180076bdf0 100644
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
@@ -206,6 +207,7 @@ void test_verifier_aggregate_ret(void)        { RUN_TESTS(verifier_aggregate_ret
 void test_verifier_align(void)                { RUN(verifier_align); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
+void test_verifier_arena_cast(void)           { RUN(verifier_arena_cast); }
 void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
 void test_verifier_arena_globals1(void)       { RUN(verifier_arena_globals1); }
 void test_verifier_arena_globals2(void)       { RUN(verifier_arena_globals2); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_cast.c b/tools/testing/selftests/bpf/progs/verifier_arena_cast.c
new file mode 100644
index 000000000000..799c61aa3746
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_cast.c
@@ -0,0 +1,762 @@
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
+/* static analysis of the stack follows the pointer through the cast */
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
+/*
+ * r7 = a number that static analysis of the stack takes for fp + off: fp-16 holds fp + off,
+ * a helper overwrites fp-16, and the analysis doesn't follow what helpers write.
+ */
+#define STALE_SPILL_R7(off)				\
+	"r1 = r10;"					\
+	"r1 += " #off ";"				\
+	"*(u64 *)(r10 - 16) = r1;"			\
+	"r1 = r10;"					\
+	"r1 += -16;"					\
+	"r2 = 8;"					\
+	"call %[bpf_get_current_comm];"			\
+	"r7 = *(u64 *)(r10 - 16);"
+
+#define SPILL_FP24_TO_FP8				\
+	"r1 = r10;"					\
+	"r1 += -24;"					\
+	"*(u64 *)(r10 - 8) = r1;"
+
+/*
+ * fp-24 counts 0, 1, ... 7 and it's the offset in the map value in r9. fp-8 holds &fp[-24],
+ * and the store through r8 changes the offset. When the analysis loses the pointer in fp-8,
+ * it doesn't see that store, and the verifier takes 0 ... 7 for all values of fp-24.
+ */
+#define LOOP_WRITES_FP24_THROUGH_FP8			\
+	"r8 = *(u64 *)(r10 - 8);"			\
+	"r1 = 0;"					\
+	"*(u64 *)(r10 - 24) = r1;"			\
+	"r6 = 0;"					\
+"1:"							\
+	"r1 = *(u64 *)(r10 - 24);"			\
+	"r2 = r9;"					\
+	"r2 += r1;"					\
+	"r0 = *(u8 *)(r2 + 0);"				\
+	"r1 += 1;"					\
+	"*(u64 *)(r10 - 24) = r1;"			\
+	"r3 = 4096;"					\
+	"*(u64 *)(r8 + 0) = r3;"			\
+	"r6 += 1;"					\
+	"if r6 < 8 goto 1b;"
+
+SEC("syscall")
+__description("arena cast: a store to arena doesn't replace what is spilled to the stack")
+__failure __msg("invalid access to map value, value_size=8 off=4096 size=1")
+__naked void stale_spill_store(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	UPDATE_AND_LOOKUP
+	"if r0 == 0 goto 2f;"
+	"r9 = r0;"
+	STALE_SPILL_R7(-8)
+	".8byte %[cast_r7_r7];"
+	SPILL_FP24_TO_FP8
+	/* to arena, not to fp-8 */
+	"r0 = 0;"
+	"*(u64 *)(r7 + 0) = r0;"
+	LOOP_WRITES_FP24_THROUGH_FP8
+"2:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_addr(hash),
+	  __imm(bpf_map_update_elem),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_get_current_comm),
+	  __imm_insn(cast_r7_r7, CAST_KERN(BPF_REG_7, BPF_REG_7))
+	: __clobber_all);
+}
+
+/* fp+0 is what the analysis adds to fp-N to say "or not a pointer to stack" */
+SEC("syscall")
+__description("arena cast: a store to arena doesn't replace what is spilled, stale r10")
+__failure __msg("invalid access to map value, value_size=8 off=4096 size=1")
+__naked void stale_spill_store_r10(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	UPDATE_AND_LOOKUP
+	"if r0 == 0 goto 2f;"
+	"r9 = r0;"
+	STALE_SPILL_R7(0)
+	".8byte %[cast_r7_r7];"
+	SPILL_FP24_TO_FP8
+	"r0 = 0;"
+	"*(u64 *)(r7 - 8) = r0;"
+	LOOP_WRITES_FP24_THROUGH_FP8
+"2:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_addr(hash),
+	  __imm(bpf_map_update_elem),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_get_current_comm),
+	  __imm_insn(cast_r7_r7, CAST_KERN(BPF_REG_7, BPF_REG_7))
+	: __clobber_all);
+}
+
+/* compilers use a slot for two variables: a pointer to a local, then the buffer of a helper */
+SEC("syscall")
+__description("arena cast: a stack slot is live over a store to arena")
+__success
+__naked void stale_spill_live_slot(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	UPDATE_AND_LOOKUP
+	"if r0 == 0 goto 3f;"
+	"r9 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	STALE_SPILL_R7(-8)
+	".8byte %[cast_r7_r7];"
+	"r1 = 0;"
+	"if r6 == 0 goto 1f;"
+	"r1 = 7;"
+"1:"
+	"*(u64 *)(r10 - 8) = r1;"
+	/* a place where what is not live is forgotten */
+	"if r6 == 1 goto +0;"
+	"r1 = 0;"
+	"*(u64 *)(r7 + 0) = r1;"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r9 += r1;"
+	"r0 = *(u8 *)(r9 + 0);"
+"3:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_addr(hash),
+	  __imm(bpf_map_update_elem),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_get_current_comm),
+	  __imm(bpf_get_prandom_u32),
+	  __imm_insn(cast_r7_r7, CAST_KERN(BPF_REG_7, BPF_REG_7))
+	: __clobber_all);
+}
+
+/* r1 is a number, r2 is &fp[-8] of the caller */
+static __naked __noinline __used long writes_arena_reads_stack(long a, long *p)
+{
+	asm volatile (
+	".8byte %[cast_r1_r1];"
+	"r0 = 0;"
+	"*(u64 *)(r1 + 0) = r0;"
+	"r0 = *(u64 *)(r2 + 0);"
+	"exit;"
+	:
+	: __imm_insn(cast_r1_r1, CAST_KERN(BPF_REG_1, BPF_REG_1))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena cast: a stack slot of the caller is live over a store to arena in the callee")
+__success
+__naked void stale_spill_live_slot_of_caller(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	UPDATE_AND_LOOKUP
+	"if r0 == 0 goto 3f;"
+	"r9 = r0;"
+	"call %[bpf_get_prandom_u32];"
+	"r6 = r0;"
+	STALE_SPILL_R7(-8)
+	"r1 = 0;"
+	"if r6 == 0 goto 1f;"
+	"r1 = 7;"
+"1:"
+	"*(u64 *)(r10 - 8) = r1;"
+	"r1 = r7;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call writes_arena_reads_stack;"
+	"r9 += r0;"
+	"r0 = *(u8 *)(r9 + 0);"
+"3:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_addr(hash),
+	  __imm(bpf_map_update_elem),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_get_current_comm),
+	  __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * A store through the result of the cast is a store to an unknown slot: each slot keeps what
+ * it had, or it has the new value. Static analysis must not make "it's fp+0" from
+ * "it's fp+0, or it's not a pointer to stack".
+ */
+SEC("syscall")
+__description("arena cast: a pointer to map value is stored over r10 through the cast")
+__failure __msg("invalid access to map value, value_size=8 off=4096 size=1")
+__naked void store_over_spilled_r10(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	UPDATE_AND_LOOKUP
+	"if r0 == 0 goto 2f;"
+	"r9 = r0;"
+	"*(u64 *)(r10 - 16) = r10;"
+	"r7 = r10;"
+	"r7 += -16;"
+	".8byte %[cast_r7_r7];"
+	"r1 = r9;"
+	"r1 += 8;"
+	"*(u64 *)(r7 + 0) = r1;"
+	/* it's the map value, not r10 */
+	"r7 = *(u64 *)(r10 - 16);"
+	SPILL_FP24_TO_FP8
+	"r0 = 0;"
+	"*(u64 *)(r7 - 8) = r0;"
+	LOOP_WRITES_FP24_THROUGH_FP8
+"2:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_addr(hash),
+	  __imm(bpf_map_update_elem),
+	  __imm(bpf_map_lookup_elem),
+	  __imm_insn(cast_r7_r7, CAST_KERN(BPF_REG_7, BPF_REG_7))
+	: __clobber_all);
+}
+
+SEC("syscall")
+__description("arena cast: r10 is stored to arena, a pointer to map value is in the stack")
+__failure __msg("invalid access to map value, value_size=8 off=4096 size=1")
+__naked void r10_stored_to_arena(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	UPDATE_AND_LOOKUP
+	"if r0 == 0 goto 2f;"
+	"r9 = r0;"
+	STALE_SPILL_R7(-8)
+	".8byte %[cast_r7_r7];"
+	"r1 = r9;"
+	"r1 += 8;"
+	"*(u64 *)(r10 - 32) = r1;"
+	/* to arena, not to fp-32 */
+	"*(u64 *)(r7 + 0) = r10;"
+	"r7 = *(u64 *)(r10 - 32);"
+	SPILL_FP24_TO_FP8
+	"r0 = 0;"
+	"*(u64 *)(r7 - 8) = r0;"
+	LOOP_WRITES_FP24_THROUGH_FP8
+"2:"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_addr(arena),
+	  __imm_addr(hash),
+	  __imm(bpf_map_update_elem),
+	  __imm(bpf_map_lookup_elem),
+	  __imm(bpf_get_current_comm),
+	  __imm_insn(cast_r7_r7, CAST_KERN(BPF_REG_7, BPF_REG_7))
+	: __clobber_all);
+}
+
+static __naked __noinline __used long fills_through_cast(long *p, long v)
+{
+	asm volatile (
+	".8byte %[cast_r1_r1];"
+	"*(u64 *)(r1 + 0) = r2;"
+	"r0 = 0;"
+	"exit;"
+	:
+	: __imm_insn(cast_r1_r1, CAST_KERN(BPF_REG_1, BPF_REG_1))
+	: __clobber_all);
+}
+
+/* the callee writes to fp-16 only, the verifier still can count the loop */
+SEC("syscall")
+__description("arena cast: the callee writes to a local, the counter of the loop is in the stack")
+__success
+__naked void callee_writes_in_loop(void)
+{
+	asm volatile (
+	"r1 = %[arena] ll;"
+	"r1 = 0;"
+	"*(u64 *)(r10 - 8) = r1;"
+"1:"
+	"r1 = r10;"
+	"r1 += -16;"
+	"r2 = *(u64 *)(r10 - 8);"
+	"call fills_through_cast;"
+	"r1 = *(u64 *)(r10 - 8);"
+	"r1 += 1;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"if r1 < 1000000 goto 1b;"
+	"r0 = 0;"
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

