Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755468;
	b=Xc58RbFWco+MNV3p2+9o6mT+S41Z1XsYhIJomUJE0BDdS8vdXwg/x/1bKRyF/fmVGNpd
	 I725l/xpVpI9ZluA4OwdP4NvQf1bAjOUW1mYaEBtT6DYz0NbUAOaDWhBxQ+6anjuZy8Yo
	 4mCa0wY3msdW1l1g0MOqi73ZltHb3wFOyRwlNDLv1XsHGZsB2IA4YImdrVx6BfMLVZDiN
	 KzM4AQFEyCgtl+CKHbCp4r7D/Qhd3STsV7V63DeUhLdVrfWLqMuUkhrVi1gTl+M63cq07
	 48E6LHYIe18ibxxRsExQJIc3q7ep7RiPrlo4jwmSxmj4WoWwoh1qSjsrUkUNaScNEpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755468;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OLTx2wP7v1tWIhTAmcbRC4iWr9zsed6Hqa1WjWjcCyo=;
	b=dg5r+U/kXQI2PjvTim7nLHRwHDbHzSF1qYhnUbzNYvBTS3qC6ZbVSQH5Vj3dmjfTC2xX
	 0C3mtc9LSmBsqPuhjtNrMOLT7DH51OUaA6UwBmZ6o0E1lohaXyqWohCc+XBCKne+R3ygm
	 9ZxF+QW+hptYyzLkawJwzy/ofKOZNjx16nnsNnJiSNYcY6r567Xgg6B4mZI+KfAYVDAok
	 HGueAN+4pOxw61lu8SrFrNTuXN0x/MJEWEr6xxx2Eu2IrOjzEB2A83oK0AB4/nbsAeYER
	 KLDtXdMjNv184shqm5h8SWKoLjrGTADNWbSWHABpsnTH6nU4u/DPCBP3KeeapmXmV4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RwCXEHBy;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C895606A31B
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 01:24:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C895606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RwCXEHBy
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-886e61fa30fso109388b3a.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 17:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793755467; x=1794360267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OLTx2wP7v1tWIhTAmcbRC4iWr9zsed6Hqa1WjWjcCyo=;
        b=RwCXEHBySrSbT0NmKgQQvsxwzjo9/GJ8TL6Fn5XsZKmtMJ7/hKsUsgcEMRJMXaBugN
         ryBZ+RAn1l6XsQ+jfaY0mrOGdPpoOErp283N2Es5jG1iz2AHxiiu0I5SU2ec8qUfs5tZ
         3qoBJimleyvWdQWBw/GfepzsyskNM6944JehJiVr6tMv2W2gf4DMM4KkJ26TpSNP1byU
         rEYMDf1RdMOvEUCaBlkLXXfS5rqmda4cWXyH+j/DoUOlg1dS56m+cK10HY3iZ9+iwaFd
         9TejsqBQCd8Fic5bF7F9YJ18Z76nRg55onI3M0Uzg6+cU8sU3ON6AtO5hdsp7lxCK/GV
         JgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793755467; x=1794360267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OLTx2wP7v1tWIhTAmcbRC4iWr9zsed6Hqa1WjWjcCyo=;
        b=phkLS6lZSMKQOd33TCzW5ddsqbBfp4IeGr2WqLlEcxaryQ89blJ/frXZ+qOyHosadN
         kvZ+buoVtN7uTgDPXfCpyHG15m9mjEzjKe5h/xvV39MemZaCFHJTOiyNG9/LwSvOpAyy
         MbnEnCbe9Zwl8LucynrdfrfLrWsCDBuC86BGNztN3o9yHPUJw9SqjGgn4QyBTZ6zHxGr
         wo9VFXbwihohtNJ7NnUKxqGgMjk0MFy8O/0NT+gWsUkYUOAYXTpRJRaP7uiAAwygPCFy
         bT/BEW8J1JKTv4JVAsUdNFr2GJpCty5+HVA2v2OwTXD/hCmzUygDqkJpF3jGLn7GJHel
         msaA==
X-Gm-Message-State: APuU4Z/7t2aXgqfRF7a5hxKEtPm7H+sloWjhGPoT5JiQfub/RbRX4oxC
	zKWHt4IJoy+fpjBI7C8NZUbkHfN0qidUiLI9tXOBfBu3HYOhtr75e/bRiO/XJg==
X-Gm-Gg: AYBFou2c/lz/taBVdeo+KjZTc1Mx1HFErIDzEa7n94W1rjSArZ3hxGy+veLhcx+OnXX
	u9pSE7IB8O1261oyYqd3JdPVhaaOS2zC4UaagibPawKR71b3gO6mlW8XVW8XL4YV8SpdHWPJT8v
	h4G3tlDvAky2jvtkcw+lxyfmPqchKE0Lv13ziQQVVJ2n6O6jZlSs+KxRqFYmIBDW5QT5NGkQ+2T
	n01jb2GL+fqxtWE9wlILB81BLhmIX/FXf12nj568xTbjEELeVQI0A7kk3An65F7ggBt9fa7abTf
	U7BkPF82oh4o1nWyWaLA8nNd0Otriu6ZEzfin1tYFNwooc+AlfkYbx98y0VMT3upSxrPYHIoawy
	IOEOX+IqfB1ErxsDvguvUSCQ6aO8VYuiw85MY6TyD1rT00YoG+J5mbYMPIFmmKBDj6+CzjaLUlH
	zwvwplCPPER8wjCPZf0XANGGjkqmjGV8LBBanmwe/mtpztG5YZi/YnPiaBOrz75QUXAXj5ZGN0E
	n/Hnj3u/RlmNM1LVtpKXbu5SZrgS8vp3t+vf/y2gHtd0a/FNaJXuFsr+owQNZnJ1uYxQ9EdHNbf
	5fsMmeWuHr8Gw0XnXvkg6NgkqZZ0Xf4xAO8ATYEuk0NdbXPmaZ3/Zmtrc+W3rTAYH7OWn7S0M5S
	LfYTT6MVaSecLQWF6iHCkqc2vK4TaAO+J0HXFD0o2CrwKimwv++ErqZkreZqCBmnF6/yBKJXJuQ
	==
X-Received: by 2002:a05:6a20:7484:b0:3d0:8cbb:8c2d with SMTP id adf61e73a8af0-3e92874f426mr13043174637.4.1793755467189;
        Tue, 03 Nov 2026 17:24:27 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb46440cc7sm351129a12.3.2026.11.03.17.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 17:24:26 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 04/14] selftests/bpf: Test addr_space_cast of pointers that are not in arena
Date: Wed,  4 Nov 2026 01:23:50 +0000
Message-ID: <20261104012401.1354861-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
References: <20261104012401.1354861-1-alexei.starovoitov@gmail.com>
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
  untrusted_btf_id             r6 is untrusted_ptr_task_struct       loads
  untrusted_mem                r6 is rdonly_untrusted_mem            loads
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
 .../selftests/bpf/progs/verifier_arena_cast.c | 800 ++++++++++++++++++
 2 files changed, 802 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_arena_cast.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 99f0551c8b59..3d0eda3b4da4 100644
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
@@ -207,6 +208,7 @@ void test_verifier_aggregate_ret(void)        { RUN_TESTS(verifier_aggregate_ret
 void test_verifier_align(void)                { RUN(verifier_align); }
 void test_verifier_and(void)                  { RUN(verifier_and); }
 void test_verifier_arena(void)                { RUN(verifier_arena); }
+void test_verifier_arena_cast(void)           { RUN(verifier_arena_cast); }
 void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
 void test_verifier_arena_globals1(void)       { RUN(verifier_arena_globals1); }
 void test_verifier_arena_globals2(void)       { RUN(verifier_arena_globals2); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_cast.c b/tools/testing/selftests/bpf/progs/verifier_arena_cast.c
new file mode 100644
index 000000000000..14a199318d0d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_cast.c
@@ -0,0 +1,800 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "../../../include/linux/filter.h"
+#include "bpf_misc.h"
+
+struct task_struct {
+	struct task_struct *group_leader;
+	void *stack;
+} __attribute__((preserve_access_index));
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
+/* r6 = addr_space_cast(p, 0, 1) */
+#define CAST_R6(p)							\
+	asm volatile (							\
+	"r1 = %[ptr];"							\
+	".8byte %[cast_r6_r1];"						\
+	"r1 = %[arena] ll;"						\
+	:								\
+	: [ptr]"r"(p),							\
+	  __imm_addr(arena),						\
+	  __imm_insn(cast_r6_r1, CAST_KERN(BPF_REG_6, BPF_REG_1))	\
+	: "r1", "r6")
+
+/* the prog can sleep: what it reads from task_struct outside of an RCU section is untrusted */
+SEC("syscall")
+__description("arena cast: an untrusted pointer to task_struct, it's a move")
+__success __log_level(2)
+__msg("R6=untrusted_ptr_task_struct()")
+__xlated("r6 = r1")
+int untrusted_btf_id(void *ctx)
+{
+	CAST_R6(bpf_get_current_task_btf()->group_leader);
+	return 0;
+}
+
+SEC("syscall")
+__description("arena cast: an untrusted pointer to kernel memory, it's a move")
+__success __log_level(2)
+__msg("R6=rdonly_untrusted_mem(sz=0)")
+__xlated("r6 = r1")
+int untrusted_mem(void *ctx)
+{
+	CAST_R6(bpf_get_current_task_btf()->stack);
+	return 0;
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
+ * A store through the result of the cast can miss the stack: the slot keeps what it had, or
+ * it has the new value. Static analysis must not make "it's fp+0" from
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

