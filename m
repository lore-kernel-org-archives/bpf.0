Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF701DE8AE
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 03:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790219498; cv=none; b=YInISAyb9zA2E7jJ0IZSKKU2Gwlo+M05k9y+xEmmk769h4TiI+NBHULKOOSsXcPcISjqb3Qq/ofHqbRN0sfDifJMiGtIFwml3zwlCSAJWK1FpQswmpKxPzetnfcOzUK+JHR/KSyabOBwXgEvWS6LBcQ82U7Ic1wakGL3ASZ6oI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790219498; c=relaxed/simple;
	bh=QtiPVy3ZxzB8tfED9ykU/+mKkm1qHQvgO2mOXE2iDyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmaIHe+dN5+5vNLYO5qgRh42i3fprdZMEEN+uRDUueBOgZaNkDKiCSDXxjAkSafKIRN0n/xWHb4eZ8gqnjtXSMC7o+/ggNdbpDuQw4obfLe2hDgpmL9876oR7NpC3rPkyb4l+Ii7sZPn9KTZnFxYBR73Cq/DhBlbDYzz1KdKylw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sn6PeRD6; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sn6PeRD6"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so1138822a91.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 20:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790219496; x=1790824296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j/5OWKoI5QnawRBsCfcN8LyX7jbjw2HJbPB/iwhIESo=;
        b=sn6PeRD6wLtI8LAhKwAyZpYBQ9emXtdv7SJbnnJ1Kxb5Mu4AEM01vCWxCfqZAV6VrT
         zCBl//tiudo9YZywMeVL8RQQFcwvzyPjKMsw0bXRMexAotmEKgaaNXQbXsTB5cMAFpDX
         8oTGi0X8Rlqh1yR3RcrkkxZaP+YpB+i9ONYp3PvgR+tYV+v1Y38HvMjRgSod2m3x8w8A
         N4/86Xl6kZF4VHjeyfpJuDuGZpubKRFPSucrRdvYcMF11pJ50Y/yGlu5H/O/+1bGZHpe
         Iy7xgzJjuHbiAOe5HWmZJqj5pkpPTzpim/rYCri4Asyi7rzUXCooFV37RXJju0HQQ38+
         0jGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790219496; x=1790824296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j/5OWKoI5QnawRBsCfcN8LyX7jbjw2HJbPB/iwhIESo=;
        b=sIYfE3/qC7d7XlJRXAI28WZvM0NVOmqdkd1v1USPS3Nz27qS1kaOpHntVqEeR9XrRx
         x2ITi55NxaCT8NlAvsUh99RzdvqLprZwJjyNYbuGjsSFeFzr7XIMJ60ZORw0IOXfO7Sx
         +PvEdF6E3jGUN2SQOFFvzL9Dbc39EUZon6xVjm8Tk3gKQOmCOwbdvyMdnyZj2JdGs9Aw
         VcCOyIZ1juXaO6xeDoyMu0uKQt0b/FCcvBeKnImU1K6asb3OhWyat1BQFXm/BRMz3/JL
         LbpFRKjMM03eUA5cAmnGoZNdzzzs5HgtdEjp2AZpLnDABKc8PYaEFfBUCFEn+UMC2g3c
         wZ7A==
X-Gm-Message-State: AFuF++m8axCCwUACbBIYDZwetx6wgGs7nBC/kNrRuLFxGGf5SvHdUpOH
	vawg6QJRXKtmkflg4rSdFQXRAYWBpF/7hMBHVCSdiAS6wu8N2ngnf8Xbykw/XQ==
X-Gm-Gg: AYBFou0QQtf0NvtOGn89M18/zupiad5iON4qtna+l1q/mQNi1Lsv4wtd7huJB6lws9r
	XhUPvRfh7ax/DXpCeBZ1/DuB4gqSUfKCi0Yo0MMq9RxVDBMeV4ltCn1sb0/03xv3f0dyK+qWulQ
	6s14b5UObbjuSk/TqVBE7kxU/dE5rjTeQfJbmyL4/VgxgVneCOKEodZcXsQXA3YDn+CeDtTlW0F
	9RFG4Zknmk1ri6HpXKwqfxnjhgMceqXvqHGuXfGV/4RoS3kkTfdC4P6woYsFclTDekrmSQaRByB
	z4ZwNNtfcYUhDzvBRWiPGOb3IdLy2nHqrUrBcamSyng2CAPY0/N4NOK0M0C7cIjx5Zpltma5xWg
	gZFOhBe2/Ey0HsU/u/n7O05pQs+zKiIXFRmqEr0b6PhYDvPe3Nh5bCY3GMA3hrmPCeagY2JmQ32
	N+/httK+haunlnzo/8cE8ECtbumKXvJw/LdloovGymK80jiBNQ/u3mAtAsDGM17yY5omW2ycSsM
	e8x+Qc5rz0n6JAVCy8Xkz/Aceg4jdbxiMj6sBBr/1tXvlR1CgB6PyuynaZw+TMB9Xg00KUz3T2U
	wSif+neGHqBHMCavrfwry5Sck0zKC21Z9XwAvRj5y7So
X-Received: by 2002:a17:90b:4c0d:b0:36d:9e0b:3801 with SMTP id 98e67ed59e1d1-3a0985baa7dmr942713a91.8.1790219495635;
        Wed, 23 Sep 2026 20:11:35 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a097663fd0sm1990746a91.9.2026.09.23.20.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 20:11:34 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 15/17] selftests/bpf: Add tests for callx
Date: Thu, 24 Sep 2026 03:10:40 +0000
Message-ID: <20260924031042.1690890-16-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
References: <20260924031042.1690890-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add verifier_callx tests:
- calls via r0, callee saved regs, pointer passed as argument, returned
  from subprog, spilled/filled, different callees on different paths.
  These are executed to test JIT.
- invalid operands: scalar, other pointers, modified and variable
  PTR_TO_FUNC, global functions, reserved fields, JMP32.
- callx under lock.
- bounded and unbounded recursion via callx.
- stack depth of call chains through callx, including address taken
  several frames above callx.
- tail calls in the callee and the caller of callx.
- stack liveness: caller slots read by callee stay alive.
- no const propagation across callx.
- precision backtracking through callx.
- address of a function that is never called, with and without callx.
- function pointers in C.

callx needs JIT. Add RUN_JITED() to skip the tests when it's off.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/verifier.c       |   10 +
 .../selftests/bpf/progs/verifier_callx.c      | 1039 +++++++++++++++++
 2 files changed, 1049 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_callx.c

diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 8b4be06bb181..bc96a752b1ae 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -28,6 +28,7 @@
 #include "verifier_btf_ctx_access.skel.h"
 #include "verifier_btf_unreliable_prog.skel.h"
 #include "verifier_call_large_imm.skel.h"
+#include "verifier_callx.skel.h"
 #include "verifier_cfg.skel.h"
 #include "verifier_cgroup_inv_retcode.skel.h"
 #include "verifier_cgroup_skb.skel.h"
@@ -173,6 +174,14 @@ static void run_tests_aux(const char *skel_name,
 
 #define RUN(skel) run_tests_aux(#skel, skel##__elf_bytes, NULL)
 
+/* for tests of what the interpreter doesn't support */
+#define RUN_JITED(skel) do {		\
+	if (is_jit_enabled())		\
+		RUN(skel);		\
+	else				\
+		test__skip();		\
+} while (0)
+
 void test_arena_kfunc(void)                   { RUN_TESTS(arena_kfunc); }
 
 void test_arena_kfunc_jit(void)               { RUN_TESTS(arena_kfunc_jit); }
@@ -199,6 +208,7 @@ void test_verifier_bswap(void)                { RUN(verifier_bswap); }
 void test_verifier_btf_ctx_access(void)       { RUN(verifier_btf_ctx_access); }
 void test_verifier_btf_unreliable_prog(void)  { RUN(verifier_btf_unreliable_prog); }
 void test_verifier_call_large_imm(void)       { RUN(verifier_call_large_imm); }
+void test_verifier_callx(void)                { RUN_JITED(verifier_callx); }
 void test_verifier_cfg(void)                  { RUN(verifier_cfg); }
 void test_verifier_cgroup_inv_retcode(void)   { RUN(verifier_cgroup_inv_retcode); }
 void test_verifier_cgroup_skb(void)           { RUN(verifier_cgroup_skb); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_callx.c b/tools/testing/selftests/bpf/progs/verifier_callx.c
new file mode 100644
index 000000000000..238fc75ad154
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_callx.c
@@ -0,0 +1,1039 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Tests for callx: indirect calls of bpf subprogs */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+#include "../../../include/linux/filter.h"
+
+#if defined(__TARGET_ARCH_x86) || defined(__TARGET_ARCH_arm64)
+
+#define CALLX_INSN(DST, SRC, OFF, IMM) \
+	BPF_RAW_INSN(BPF_JMP | BPF_CALL | BPF_X, DST, SRC, OFF, IMM)
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, long long);
+} map_array SEC(".maps");
+
+struct val_with_lock {
+	struct bpf_spin_lock lock;
+	int cnt;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct val_with_lock);
+} map_lock SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__uint(key_size, sizeof(int));
+	__uint(value_size, sizeof(int));
+} map_prog SEC(".maps");
+
+__naked __noinline __used
+static unsigned long add1(void)
+{
+	asm volatile (
+		"r0 = r1;"
+		"r0 += 1;"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long add2(void)
+{
+	asm volatile (
+		"r0 = r1;"
+		"r0 += 2;"
+		"exit;"
+	);
+}
+
+/* apply(fn, x) { return fn(x); } */
+__naked __noinline __used
+static unsigned long apply(void)
+{
+	asm volatile (
+		"r3 = r1;"
+		"r1 = r2;"
+		"callx r3;"
+		"exit;"
+	);
+}
+
+SEC("socket")
+__success __retval(6)
+__naked void callx_basic(void)
+{
+	asm volatile (
+		"r1 = 5;"
+		"r2 = %[add1] ll;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm_addr(add1)
+		: __clobber_all);
+}
+
+/* callx is printed by the verifier log and xlated dump */
+SEC("socket")
+__success __log_level(2)
+__msg("(8d) callx r2")
+__xlated("callx r2")
+__naked void callx_disasm(void)
+{
+	asm volatile (
+		"r1 = 5;"
+		"r2 = %[add1] ll;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm_addr(add1)
+		: __clobber_all);
+}
+
+/* different callees are called by the same callx on different paths */
+SEC("socket")
+__success __retval(11)
+__naked void callx_two_callees(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r6 = r0;"
+		"r6 &= 1;"
+		"r2 = %[add1] ll;"
+		"if r6 == 0 goto +2;"
+		"r2 = %[add2] ll;"
+		"r1 = 10;"
+		"callx r2;"
+		/* add1(10) - 0 or add2(10) - 1 */
+		"r0 -= r6;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm_addr(add1),
+		  __imm_addr(add2)
+		: __clobber_all);
+}
+
+/* pointer to a function is passed as an argument */
+SEC("socket")
+__success __retval(45)
+__naked void callx_fn_as_arg(void)
+{
+	asm volatile (
+		"r1 = %[add2] ll;"
+		"r2 = 40;"
+		"call apply;"
+		"r6 = r0;"
+		"r1 = %[add1] ll;"
+		"r2 = 2;"
+		"call apply;"
+		"r0 += r6;"
+		"exit;"
+		:
+		: __imm_addr(add1),
+		  __imm_addr(add2)
+		: __clobber_all);
+}
+
+__naked __noinline __used
+static unsigned long get_add1(void)
+{
+	asm volatile (
+		"r0 = %[add1] ll;"
+		"exit;"
+		:
+		: __imm_addr(add1)
+		: __clobber_all);
+}
+
+/* pointer to a function is returned from a subprog and called via r0 */
+SEC("socket")
+__success __retval(2)
+__naked void callx_r0(void)
+{
+	asm volatile (
+		"call get_add1;"
+		"r1 = 1;"
+		"callx r0;"
+		"exit;"
+		::: __clobber_all);
+}
+
+/* pointer to a function survives spill/fill */
+SEC("socket")
+__success __retval(9)
+__naked void callx_spill_fill(void)
+{
+	asm volatile (
+		"r2 = %[add2] ll;"
+		"*(u64 *)(r10 - 8) = r2;"
+		"call %[bpf_get_prandom_u32];"
+		"r1 = 7;"
+		"r9 = *(u64 *)(r10 - 8);"
+		"callx r9;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm_addr(add2)
+		: __clobber_all);
+}
+
+__naked __noinline __used
+static unsigned long clobber_callee_saved(void)
+{
+	asm volatile (
+		"r6 = 100;"
+		"r7 = 100;"
+		"r8 = 100;"
+		"r9 = 100;"
+		"r0 = r1;"
+		"exit;"
+	);
+}
+
+/* r6-r9 are preserved across callx */
+SEC("socket")
+__success __retval(11)
+__naked void callx_callee_saved_regs(void)
+{
+	asm volatile (
+		"r6 = 1;"
+		"r7 = 2;"
+		"r8 = 3;"
+		"r9 = 4;"
+		"r1 = 1;"
+		"r2 = %[clobber_callee_saved] ll;"
+		"callx r2;"
+		"r0 += r6;"
+		"r0 += r7;"
+		"r0 += r8;"
+		"r0 += r9;"
+		"exit;"
+		:
+		: __imm_addr(clobber_callee_saved)
+		: __clobber_all);
+}
+
+/* r1-r5 are scratched by callx */
+SEC("socket")
+__failure __msg("R1 !read_ok")
+__naked void callx_scratches_args(void)
+{
+	asm volatile (
+		"r1 = 5;"
+		"r2 = %[add1] ll;"
+		"callx r2;"
+		"r0 = r1;"
+		"exit;"
+		:
+		: __imm_addr(add1)
+		: __clobber_all);
+}
+
+/* return value of the callee is tracked */
+SEC("socket")
+__success __log_level(2)
+__msg("to caller at 4:")
+__msg("R0=6")
+__naked void callx_retval_is_tracked(void)
+{
+	asm volatile (
+		"r1 = 5;"
+		"r2 = %[add1] ll;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm_addr(add1)
+		: __clobber_all);
+}
+
+__naked __noinline __used
+static unsigned long write42(void)
+{
+	asm volatile (
+		"r2 = 42;"
+		"*(u64 *)(r1 + 0) = r2;"
+		"r0 = 0;"
+		"exit;"
+	);
+}
+
+/* callee writes into the stack of the caller */
+SEC("socket")
+__success __retval(42)
+__naked void callx_callee_writes_caller_stack(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = %[write42] ll;"
+		"callx r2;"
+		"r0 = *(u64 *)(r10 - 8);"
+		"exit;"
+		:
+		: __imm_addr(write42)
+		: __clobber_all);
+}
+
+SEC("socket")
+__failure __msg("R1 has type scalar, expected func")
+__naked void callx_scalar(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"callx r1;"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("socket")
+__failure __msg("R2 !read_ok")
+__naked void callx_uninit_reg(void)
+{
+	asm volatile (
+		"callx r2;"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("socket")
+__failure __msg("R10 has type fp, expected func")
+__naked void callx_fp(void)
+{
+	asm volatile (
+		"callx r10;"
+		"exit;"
+		::: __clobber_all);
+}
+
+SEC("socket")
+__failure __msg("R1 has type map_value, expected func")
+__naked void callx_map_value(void)
+{
+	asm volatile (
+		"r1 = %[map_array] ll;"
+		"r2 = r10;"
+		"r2 += -4;"
+		"r3 = 0;"
+		"*(u32 *)(r2 + 0) = r3;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto 1f;"
+		"r1 = r0;"
+		"callx r1;"
+	"1:"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm_addr(map_array)
+		: __clobber_all);
+}
+
+/* the address of a subprog can't be modified before the call */
+SEC("socket")
+__failure __msg("dereference of modified func ptr R2 off=8 disallowed")
+__naked void callx_modified_ptr(void)
+{
+	asm volatile (
+		"r1 = 5;"
+		"r2 = %[add1] ll;"
+		"r2 += 8;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm_addr(add1)
+		: __clobber_all);
+}
+
+SEC("socket")
+__failure __msg("variable func access var_off=")
+__naked void callx_variable_ptr(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r0 &= 8;"
+		"r2 = %[add1] ll;"
+		"r2 += r0;"
+		"r1 = 5;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm_addr(add1)
+		: __clobber_all);
+}
+
+__noinline __used
+int global_add3(int x)
+{
+	return x + 3;
+}
+
+/* only static subprogs can be called via callx */
+SEC("socket")
+__failure __msg("callback function not static")
+__naked void callx_global_func(void)
+{
+	asm volatile (
+		"r1 = 5;"
+		"r2 = %[global_add3] ll;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm_addr(global_add3)
+		: __clobber_all);
+}
+
+#define DEFINE_CALLX_RESERVED_FIELDS_PROG(NAME, SRC_REG, OFF, IMM)		\
+	SEC("socket")								\
+	__failure __msg("BPF_CALL|BPF_X uses reserved fields")			\
+	__naked void callx_reserved_field_ ## NAME(void)			\
+	{									\
+		asm volatile (							\
+			"r1 = 5;"						\
+			"r2 = %[add1] ll;"					\
+			".8byte %[callx_r2];"					\
+			"exit;"							\
+			:							\
+			: __imm_addr(add1),					\
+			  __imm_insn(callx_r2, CALLX_INSN(BPF_REG_2, (SRC_REG), (OFF), (IMM))) \
+			: __clobber_all);					\
+	}
+
+DEFINE_CALLX_RESERVED_FIELDS_PROG(src_reg, BPF_REG_1, 0, 0)
+DEFINE_CALLX_RESERVED_FIELDS_PROG(off, BPF_REG_0, 1, 0)
+DEFINE_CALLX_RESERVED_FIELDS_PROG(imm, BPF_REG_0, 0, 1)
+
+SEC("socket")
+__failure __msg("unknown opcode 8e")
+__naked void callx_jmp32(void)
+{
+	asm volatile (
+		"r1 = 5;"
+		"r2 = %[add1] ll;"
+		".8byte %[callx32_r2];"
+		"exit;"
+		:
+		: __imm_addr(add1),
+		  __imm_insn(callx32_r2,
+			     BPF_RAW_INSN(BPF_JMP32 | BPF_CALL | BPF_X, BPF_REG_2, 0, 0, 0))
+		: __clobber_all);
+}
+
+/* similar to calls of static subprogs callx is allowed under a lock */
+SEC("tc")
+__success __retval(3)
+__naked void callx_under_lock(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"*(u32 *)(r10 - 4) = r1;"
+		"r2 = r10;"
+		"r2 += -4;"
+		"r1 = %[map_lock] ll;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 != 0 goto 1f;"
+		"exit;"
+	"1:"
+		"r6 = r0;"
+		"r1 = r6;"
+		"call %[bpf_spin_lock];"
+		"r1 = 1;"
+		"r2 = %[add2] ll;"
+		"callx r2;"
+		"r7 = r0;"
+		"r1 = r6;"
+		"call %[bpf_spin_unlock];"
+		"r0 = r7;"
+		"exit;"
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm(bpf_spin_lock),
+		  __imm(bpf_spin_unlock),
+		  __imm_addr(map_lock),
+		  __imm_addr(add2)
+		: __clobber_all);
+}
+
+/* helpers are still not allowed under a lock in the callee */
+__naked __noinline __used
+static unsigned long call_helper(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32)
+		: __clobber_all);
+}
+
+SEC("tc")
+__failure __msg("function calls are not allowed while holding a lock")
+__naked void callx_helper_under_lock(void)
+{
+	asm volatile (
+		"r1 = 0;"
+		"*(u32 *)(r10 - 4) = r1;"
+		"r2 = r10;"
+		"r2 += -4;"
+		"r1 = %[map_lock] ll;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 != 0 goto 1f;"
+		"exit;"
+	"1:"
+		"r6 = r0;"
+		"r1 = r6;"
+		"call %[bpf_spin_lock];"
+		"r2 = %[call_helper] ll;"
+		"callx r2;"
+		"r1 = r6;"
+		"call %[bpf_spin_unlock];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm(bpf_spin_lock),
+		  __imm(bpf_spin_unlock),
+		  __imm_addr(map_lock),
+		  __imm_addr(call_helper)
+		: __clobber_all);
+}
+
+/* self(fn) { return fn(fn); } */
+__naked __noinline __used
+static unsigned long self(void)
+{
+	asm volatile (
+		"callx r1;"
+		"exit;"
+	);
+}
+
+/* unbounded recursion is caught by the main verification pass */
+SEC("socket")
+__failure __msg("frames is too deep")
+__naked void callx_unbounded_recursion(void)
+{
+	asm volatile (
+		"r1 = %[self] ll;"
+		"call self;"
+		"exit;"
+		:
+		: __imm_addr(self)
+		: __clobber_all);
+}
+
+/* countdown(fn, n) { return n ? fn(fn, n - 1) : 0; } */
+__naked __noinline __used
+static unsigned long countdown(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"if r2 == 0 goto 1f;"
+		"r2 += -1;"
+		"callx r1;"
+	"1:"
+		"exit;"
+	);
+}
+
+/*
+ * The depth of the recursion is known to the main verification pass,
+ * but recursive calls are not allowed regardless.
+ */
+SEC("socket")
+__failure __msg("recursive call from countdown() to countdown()")
+__naked void callx_bounded_recursion(void)
+{
+	asm volatile (
+		"r1 = %[countdown] ll;"
+		"r2 = 2;"
+		"call countdown;"
+		"exit;"
+		:
+		: __imm_addr(countdown)
+		: __clobber_all);
+}
+
+/* ping(fn1, fn2, n) { return n ? fn2(fn2, fn1, n - 1) : 0; } */
+__naked __noinline __used
+static unsigned long ping(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"if r3 == 0 goto 1f;"
+		"r3 += -1;"
+		"r4 = r1;"
+		"r1 = r2;"
+		"r2 = r4;"
+		"callx r1;"
+	"1:"
+		"exit;"
+	);
+}
+
+__naked __noinline __used
+static unsigned long pong(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"if r3 == 0 goto 1f;"
+		"r3 += -1;"
+		"r4 = r1;"
+		"r1 = r2;"
+		"r2 = r4;"
+		"callx r1;"
+	"1:"
+		"exit;"
+	);
+}
+
+SEC("socket")
+__failure __msg("recursive call from")
+__naked void callx_mutual_recursion(void)
+{
+	asm volatile (
+		"r1 = %[ping] ll;"
+		"r2 = %[pong] ll;"
+		"r3 = 3;"
+		"call ping;"
+		"exit;"
+		:
+		: __imm_addr(ping),
+		  __imm_addr(pong)
+		: __clobber_all);
+}
+
+__naked __noinline __used
+static unsigned long use_stack_304(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 304) = r0;"
+		"exit;"
+	);
+}
+
+/* stack of the callee of callx is accounted */
+SEC("socket")
+__failure __msg("combined stack size of 2 calls is")
+__naked void callx_stack_depth(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 304) = r0;"
+		"r2 = %[use_stack_304] ll;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm_addr(use_stack_304)
+		: __clobber_all);
+}
+
+/* apply_stack_304(fn) { char buf[304]; return fn(); } */
+__naked __noinline __used
+static unsigned long apply_stack_304(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 304) = r0;"
+		"callx r1;"
+		"exit;"
+	);
+}
+
+/*
+ * The address of use_stack_304() is taken by the main prog that doesn't
+ * use stack, but it is called from apply_stack_304().
+ */
+SEC("socket")
+__failure __msg("combined stack size of 3 calls is")
+__naked void callx_stack_depth_nested(void)
+{
+	asm volatile (
+		"r1 = %[use_stack_304] ll;"
+		"call apply_stack_304;"
+		"exit;"
+		:
+		: __imm_addr(use_stack_304)
+		: __clobber_all);
+}
+
+SEC("socket")
+__success __retval(0)
+__naked void callx_stack_depth_ok(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"*(u64 *)(r10 - 200) = r0;"
+		"r2 = %[use_stack_304] ll;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm_addr(use_stack_304)
+		: __clobber_all);
+}
+
+__naked __noinline __used
+static unsigned long do_tail_call(void)
+{
+	asm volatile (
+		"r2 = %[map_prog] ll;"
+		"r3 = 0;"
+		"call %[bpf_tail_call];"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_tail_call),
+		  __imm_addr(map_prog)
+		: __clobber_all);
+}
+
+SEC("socket")
+__failure __msg("tail_calls are not allowed in functions called via callx")
+__naked void callx_tail_call_in_callee(void)
+{
+	asm volatile (
+		"r2 = %[do_tail_call] ll;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm_addr(do_tail_call)
+		: __clobber_all);
+}
+
+/* tail call in the caller of callx is fine */
+SEC("socket")
+__success __retval(3)
+__naked void callx_tail_call_in_caller(void)
+{
+	asm volatile (
+		"r6 = r1;"
+		"r1 = 2;"
+		"r2 = %[add1] ll;"
+		"callx r2;"
+		"r7 = r0;"
+		"r1 = r6;"
+		"r2 = %[map_prog] ll;"
+		"r3 = 0;"
+		"call %[bpf_tail_call];"
+		"r0 = r7;"
+		"exit;"
+		:
+		: __imm(bpf_tail_call),
+		  __imm_addr(map_prog),
+		  __imm_addr(add1)
+		: __clobber_all);
+}
+
+/* read_idx(p) { return ((char *)map_value)[*p]; } */
+__naked __noinline __used
+static unsigned long read_idx(void)
+{
+	asm volatile (
+		"r6 = *(u64 *)(r1 + 0);"
+		"r1 = 0;"
+		"*(u32 *)(r10 - 4) = r1;"
+		"r2 = r10;"
+		"r2 += -4;"
+		"r1 = %[map_array] ll;"
+		"call %[bpf_map_lookup_elem];"
+		"if r0 == 0 goto 1f;"
+		"r0 += r6;"
+		"r0 = *(u8 *)(r0 + 0);"
+	"1:"
+		"exit;"
+		:
+		: __imm(bpf_map_lookup_elem),
+		  __imm_addr(map_array)
+		: __clobber_all);
+}
+
+/*
+ * Stack slots of the caller that might be read by the callee of callx
+ * have to be considered alive at the checkpoints before callx and
+ * inside of the callee. Otherwise the state with fp-8 == 1000 is pruned
+ * and out of bounds access in read_idx() goes unnoticed.
+ */
+SEC("socket")
+__failure __msg("invalid access to map value, value_size=8 off=1000 size=1")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void callx_callee_reads_caller_stack(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r1 = 1000;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"if r0 == 0 goto 1f;"
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+	"1:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = %[read_idx] ll;"
+		"callx r2;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm_addr(read_idx)
+		: __clobber_all);
+}
+
+/* in bounds access in read_idx() is fine */
+SEC("socket")
+__success __retval(0)
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void callx_callee_reads_caller_stack_ok(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r1 = 7;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"if r0 == 0 goto 1f;"
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+	"1:"
+		"r1 = r10;"
+		"r1 += -8;"
+		"r2 = %[read_idx] ll;"
+		"callx r2;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm_addr(read_idx)
+		: __clobber_all);
+}
+
+/* same as above, but the pointer to the stack is passed through one more frame */
+SEC("socket")
+__failure __msg("invalid access to map value, value_size=8 off=1000 size=1")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void callx_callee_reads_caller_stack_nested(void)
+{
+	asm volatile (
+		"call %[bpf_get_prandom_u32];"
+		"r1 = 1000;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"if r0 == 0 goto 1f;"
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+	"1:"
+		"r1 = %[read_idx] ll;"
+		"r2 = r10;"
+		"r2 += -8;"
+		"call apply;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm(bpf_get_prandom_u32),
+		  __imm_addr(read_idx)
+		: __clobber_all);
+}
+
+/* registers that are constant before callx are not constant after it */
+SEC("socket")
+__success __retval(1)
+__naked void callx_clobbers_const_regs(void)
+{
+	asm volatile (
+		"r0 = 0;"
+		"r1 = 0;"
+		"r2 = %[add1] ll;"
+		"callx r2;"
+		/* dead branch pruning must not assume that r0 is still 0 */
+		"if r0 == 0 goto 1f;"
+		"r0 = 1;"
+		"exit;"
+	"1:"
+		"r0 = 2;"
+		"exit;"
+		:
+		: __imm_addr(add1)
+		: __clobber_all);
+}
+
+/* scalar argument passed through callx is tracked precisely */
+__naked __noinline __used
+static unsigned long identity(void)
+{
+	asm volatile (
+		"r0 = r1;"
+		"exit;"
+	);
+}
+
+long long vals[] SEC(".data.vals") = {1, 2, 3, 4};
+
+SEC("socket")
+__success __log_level(2)
+__msg("mark_precise: frame0: regs=r0 stack= before 12: (95) exit")
+__msg("mark_precise: frame1: regs=r0 stack= before 11: (bf) r0 = r1")
+__msg("mark_precise: frame1: regs=r1 stack= before 4: (8d) callx r2")
+__msg("mark_precise: frame0: regs=r1 stack= before 3: (bf) r1 = r6")
+__msg("mark_precise: frame0: regs=r6 stack= before 2: (b7) r6 = 3")
+__retval(4)
+__naked void callx_precision(void)
+{
+	asm volatile (
+		"r2 = %[identity] ll;"
+		"r6 = 3;"
+		"r1 = r6;"
+		"callx r2;"
+		"r0 *= 8;"
+		"r1 = %[vals] ll;"
+		"r1 += r0;"
+		"r0 = *(u64 *)(r1 + 0);"
+		"exit;"
+		:
+		: __imm_addr(identity),
+		  __imm_addr(vals)
+		: __clobber_all);
+}
+
+/*
+ * The address of a function that is never called is valid. The function is
+ * the last one in the program.
+ */
+SEC("socket")
+__success __retval(6)
+__naked void callx_addr_of_dead_func(void)
+{
+	asm volatile (
+		"r6 = %[add1] ll;"
+		"r7 = %[add2] ll;"
+		"r1 = 5;"
+		"callx r6;"
+		"if r7 != r6 goto +1;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(add1), __imm_addr(add2)
+		: __clobber_all);
+}
+
+/* and when it's followed by another function */
+SEC("socket")
+__success __retval(7)
+__naked void callx_addr_of_dead_func_first(void)
+{
+	asm volatile (
+		"r7 = %[add1] ll;"
+		"r6 = %[add2] ll;"
+		"r1 = 5;"
+		"callx r6;"
+		"if r7 != r6 goto +1;"
+		"r0 = 0;"
+		"exit;"
+		:
+		: __imm_addr(add1), __imm_addr(add2)
+		: __clobber_all);
+}
+
+/* the same without callx */
+SEC("socket")
+__success __retval(6)
+__naked void call_addr_of_dead_func(void)
+{
+	asm volatile (
+		"r1 = 5;"
+		"call add1;"
+		"r7 = %[add2] ll;"
+		"exit;"
+		:
+		: __imm_addr(add2)
+		: __clobber_all);
+}
+
+/* function pointers in C */
+
+typedef int (*op_fn)(int);
+
+static __noinline int mul3(int x)
+{
+	return x * 3;
+}
+
+static __noinline int sub7(int x)
+{
+	return x - 7;
+}
+
+static __noinline int apply_op(op_fn op, int x)
+{
+	return op(x);
+}
+
+SEC("socket")
+__success __retval(36)
+int callx_c_fn_as_arg(void *ctx)
+{
+	/* (5 * 3) + (28 - 7) */
+	return apply_op(mul3, 5) + apply_op(sub7, 28);
+}
+
+SEC("socket")
+__success __retval(30)
+int callx_c_select(void *ctx)
+{
+	__u32 rnd = bpf_get_prandom_u32() & 1;
+	op_fn op = rnd ? mul3 : sub7;
+	int x = rnd ? 10 : 37;
+
+	/* 10 * 3 or 37 - 7 */
+	return op(x);
+}
+
+struct ops {
+	op_fn first;
+	op_fn second;
+	int bias;
+};
+
+static __noinline int run_ops(const struct ops *ops, int x)
+{
+	return ops->second(ops->first(x)) + ops->bias;
+}
+
+SEC("socket")
+__success __retval(100)
+int callx_c_ops_on_stack(void *ctx)
+{
+	struct ops a, b;
+
+	/* avoid an initializer with function pointers in .rodata */
+	a.first = mul3;
+	a.second = sub7;
+	a.bias = 10;
+	b.first = sub7;
+	b.second = mul3;
+	b.bias = 1;
+
+	/* ((7 * 3) - 7 + 10) + ((32 - 7) * 3 + 1) */
+	return run_ops(&a, 7) + run_ops(&b, 32);
+}
+
+#else
+
+SEC("socket")
+__success
+int dummy(void *ctx)
+{
+	return 0;
+}
+
+#endif
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

