Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160944;
	b=H8D7kjm/VpL+1XMG5S+MSwuZoMoZ/2t+heAviNdsPXUacADMW3EZbU8kMO/3AEqRs1Zt
	 v1LYYKAgTUTyfVp6kIQC75r9g7XQ9L00sW2VIY+Z8P1Fgoxj7mQfsSeMrcV+WM517fy3i
	 qvMWy9+amVlXOm6jVdDkY7tkWy4F+/K3b3q3P6DtXz8xS05/IS4UTLY16JfdAiCi8cAhR
	 ehWk0Of1zUuM6ZmptrcKUKMFYgzeoqqFz3z8UptdUk7osvWM3q+Vys45mGejuiCOMNKOg
	 RPW9HTZsAyk0Abadc0VqyaBNHfmAGULjn5cUSC/ouy2hP99UxMprpgxF8qdAY+FTUcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=URHo0jRYJ9cAV1FMPOV4xjhsgIGUh76ecjRhJpzXKHE=;
	b=Hd2NVd5uJhSdkgxZ55C400fiI1eW/0VO11fBVqeH8sjYsrPUYD+Y62UL4V9AYjFUxdll
	 VgVRACFty6sIw2uIgRtwrxw1o9eDFLR+ZOE/JBct9iWVPqwbUwNPSCwibRiSm7KUq9us0
	 7eTqsgQRwOw0Y9HpexjdXMktguh3HZUcNijIuTXg8eEeumTA0dLabTBhaFv+drlAOpxrY
	 LYy8O76JLGwOOIFAjkPBqfedCIIfVcfR4FPoLcfh5kND2JkVjorX43RTETUwkpgSXza7k
	 GKHeVSkEd0m8PyhDgkVdywT8TFpfwLu+gq4ktr4uwHVz6FADNRxKw/gXR15pKYsOejg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JfhyLwGX;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41957606A320
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41957606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JfhyLwGX
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so353264b3a.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160943; x=1795765743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=URHo0jRYJ9cAV1FMPOV4xjhsgIGUh76ecjRhJpzXKHE=;
        b=JfhyLwGXTqV74CoP+WoqD4XdBZI7LAhIR0z14py0WTtb/qhkBW4SNvvIbvGC4UQag9
         QMGoMDtpfExnXPoCClH3rJVi0OkZ+QQeFmtDVDkK5C3cdg2cyDfTvQ8OhiwA/IkAZtjf
         fb6uwAimtDT6kjxliAAfyqqHVA8UBoaqsbyqIVqCO/qYsPP/XGTWJk0VA7/8bSn076JJ
         qYwO9+Yl9Nd0HmJrOUFcvGVdkoxMzBQGIRUseySqzZXjL7r40DkrRtHNXBeldSd/QWGU
         lf0B081TB1PBy5XJDGaFEuiWW//AYoTeS8E4D5gjndXevgW+tLhaC/MoSQk6QO3nKHwX
         NxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160943; x=1795765743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=URHo0jRYJ9cAV1FMPOV4xjhsgIGUh76ecjRhJpzXKHE=;
        b=zIxY37quoI7M76FbU3+moQ3n9bxW4tEUeorEMV3datZUasP9fNRcswQgLH2IuNcQ3W
         IzJQvozafQM1yfFTPgWX3n2MCn1BtQqsuo4oGyT6/7O9pmbCOoc704ciKX5pDeoJYapt
         oKSrEwJXRgMGXDA8+SabPbj58ozkzL25Z7BEWbEXTEh7hUO5eZA5WXVA9uXiLnY/pbBa
         JyImsjhKY6MhxLzwbWlKqfQGr4ZI3DPGgxKr7SR/ds9AKhYYgg0mp3RC3pO2UAKzgPuT
         dtxyS5Hp8yZQ5sp01bF3RQOz5rRjRQfVM1dm5h6pG+SFSB+bk9MtLNnAgQp44bzdjBHc
         gEUg==
X-Gm-Message-State: APuU4Z963pKaEj0Ez6sckSHg2+XPyiUqCZSXEZuNTkSFfmTPiWdfx7iO
	xibiiiMw5XAhVY8zgTG9vfbjlilEOyI83fMDyhc81+zxgPLU14+D7T7TRPFHrg==
X-Gm-Gg: AZFdTZdNvnCY/fb3oKDxt57bcvgR1T6iT3O83WICSq4zfN2OQlo1vy3EaQBk68dH8MA
	GJyyLaXroSwYNfSYW30P3MAD32u/spokax+AxROn3q+Fs7SxOZIXDaq7YJXgJxjSLQ7VW66E+cd
	tcwXD/kj8mUzdRb9N31NFoeaOxIn3du4WMC/kaf7MpQ/xMT+KGvpuDhnIKQteglloAac1TOBDLj
	F0VexbIe0Nh65NP+qOYIaas/ittj/mV43tY0I0QeUYJ4RIh7tQLDEn1/ESdyVC9aILheXFPhwMi
	FzRK3ImZohMSRi/3penA5ABQ28+7bj06taBJUEESSgwr5FzqlUFolqHz7iCzZW4B16DDwoa2mVs
	1D4cxHjUXnNQNzwbTCcf4c0DXffrwFXbeBfeUi1siXqesdo0JNWMlYsQlON4TLt8HXXOpdBikCV
	F74pUBu/1ky0R8LkBj/zTjLcMz3nN0QIWZAyWSlDWY2+rd2guvlt5rQoMct0WGzlo6KANp9RpLi
	vl9g8ccneMcult2gdCLGMMjnFhWUowsMTwa3HEIMtEi1Ts+pH883bVTkTC/SIXxqPgKBisWaYfu
	wKSqfAQiWnWKYhWcYPO3ux4cApH0VH+wpa1PKOirI8dXRysA5a/DfKoUmlh7KZdXUGtm0S6qje+
	sID7LuVhFAACz62BGafJ9yFDNyBXNEEptlCDAfDi5qBI7jlHNm91cLQB2MG68aM8zDhytaiGqGg
	==
X-Received: by 2002:a05:6a00:1794:b0:8b6:2333:54a3 with SMTP id d2e1a72fcca58-8c7de584caamr2545888b3a.39.1795160943018;
        Thu, 19 Nov 2026 23:49:03 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c219sm1122701b3a.18.2026.11.19.23.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:49:02 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 46/49] selftests/bpf: Test barriers and far pointers
Date: Fri, 20 Nov 2026 07:42:18 +0000
Message-ID: <20261120074430.2704488-47-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
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

verifier_barrier.c: check the place of the barrier for each kind of
edge: inlined bpf_loop(), exit of a callback, may_goto, recursion, a
call that never returns, far jumps.
Check what a speculative state must not decide for other states.
Check that a far pointer gives no compare, no access and no constant
offset. Check the log of a dropped path, of a leak and of a speculative
state.

far_map_value.c: a load through a far pointer to a read-only map value
is not folded to a constant.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/prog_tests/far_map_value.c  |  38 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_barrier.c    | 849 ++++++++++++++++++
 3 files changed, 889 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/far_map_value.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_barrier.c

diff --git a/tools/testing/selftests/bpf/prog_tests/far_map_value.c b/tools/testing/selftests/bpf/prog_tests/far_map_value.c
new file mode 100644
index 00000000000..f2fb2aaaa26
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/far_map_value.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+
+#define FAR_OFF		(1 << 29)	/* BPF_MAX_VAR_OFF */
+
+/* See far_rodata in verifier_barrier.c. Here ld_imm64 makes the far pointer. */
+void serial_test_far_map_value(void)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, opts, .map_flags = BPF_F_RDONLY_PROG);
+	struct bpf_insn insns[] = {
+		BPF_LD_MAP_VALUE(BPF_REG_1, 0, FAR_OFF),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -16),
+		BPF_LDX_MEM(BPF_B, BPF_REG_2, BPF_REG_1, 0),
+		BPF_MOV64_IMM(BPF_REG_3, 2),
+		BPF_ALU64_IMM(BPF_MUL, BPF_REG_3, 2),
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_JMP_REG(BPF_JNE, BPF_REG_2, BPF_REG_3, 1),
+		BPF_MOV64_REG(BPF_REG_0, BPF_REG_2),
+		BPF_EXIT_INSN(),
+	};
+	int map_fd, prog_fd;
+
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, FAR_OFF + 8, 1, &opts);
+	if (map_fd == -ENOMEM) {
+		test__skip();
+		return;
+	}
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+	ASSERT_OK(bpf_map_freeze(map_fd), "map_freeze");
+	insns[0].imm = map_fd;
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_SOCKET_FILTER, NULL, "GPL", insns,
+				ARRAY_SIZE(insns), NULL);
+	if (ASSERT_GE(prog_fd, 0, "prog_load"))
+		close(prog_fd);
+	close(map_fd);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/testing/selftests/bpf/prog_tests/verifier.c
index 67151c55b03..ab15e69a622 100644
--- a/tools/testing/selftests/bpf/prog_tests/verifier.c
+++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
@@ -21,6 +21,7 @@
 #include "verifier_arena_globals2.skel.h"
 #include "verifier_array_access.skel.h"
 #include "verifier_async_cb_context.skel.h"
+#include "verifier_barrier.skel.h"
 #include "verifier_basic_stack.skel.h"
 #include "verifier_bitfield_write.skel.h"
 #include "verifier_bounds.skel.h"
@@ -231,6 +232,7 @@ void test_verifier_arena_stack(void)          { RUN_TESTS(verifier_arena_stack);
 void test_verifier_arena_large(void)          { RUN(verifier_arena_large); }
 void test_verifier_arena_globals1(void)       { RUN(verifier_arena_globals1); }
 void test_verifier_arena_globals2(void)       { RUN(verifier_arena_globals2); }
+void test_verifier_barrier(void)              { RUN(verifier_barrier); }
 void test_verifier_basic_stack(void)          { RUN(verifier_basic_stack); }
 void test_verifier_bitfield_write(void)       { RUN(verifier_bitfield_write); }
 void test_verifier_bounds(void)               { RUN(verifier_bounds); }
diff --git a/tools/testing/selftests/bpf/progs/verifier_barrier.c b/tools/testing/selftests/bpf/progs/verifier_barrier.c
new file mode 100644
index 00000000000..7e68fc072e3
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/verifier_barrier.c
@@ -0,0 +1,849 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Where the barrier goes, and what a speculative state must not decide */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "bpf_misc.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, long);
+} array SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, int);
+} progs SEC(".maps");
+
+struct elem {
+	struct bpf_timer timer;
+	struct task_struct __kptr *task;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct elem);
+} timers SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} ring SEC(".maps");
+
+long data[8];
+
+void bpf_throw(u64 cookie) __ksym;
+void __bpf_trap(void) __ksym;
+void bpf_task_release(struct task_struct *task) __ksym;
+void bpf_rcu_read_lock(void) __ksym;
+void bpf_rcu_read_unlock(void) __ksym;
+
+#define OPS								\
+	__imm_addr(data), __imm_addr(array), __imm_addr(progs),		\
+	__imm(bpf_loop), __imm(bpf_for_each_map_elem),			\
+	__imm(bpf_get_prandom_u32), __imm(bpf_get_smp_processor_id),	\
+	__imm(bpf_tail_call), __imm_addr(timers),			\
+	__imm(bpf_map_lookup_elem), __imm(bpf_timer_set_callback),	\
+	__imm(bpf_kptr_xchg), __imm(bpf_ringbuf_reserve), __imm_addr(ring), \
+	__imm_const(skb_data, offsetof(struct __sk_buff, data)),	\
+	__imm_const(skb_data_end, offsetof(struct __sk_buff, data_end))
+
+#define ASM(...) asm volatile (__VA_ARGS__ :: OPS : __clobber_all)
+
+#define SPECULATES	__arch_x86_64 __arch_arm64 __caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+
+/* r6 = data, r7 = a number */
+#define START		"r6 = %[data] ll; r7 = *(u64 *)(r6 + 0);"
+/* only a speculative state goes to @label */
+#define NEVER(label)	"r5 = r7; r5 &= 1; if r5 > 1 goto " label ";"
+
+static __naked __used int nop_cb(void)
+{
+	asm volatile ("r0 = 0; exit;" ::: __clobber_all);
+}
+
+SEC("tc")
+__description("barrier: before the inlined bpf_loop()")
+__success SPECULATES __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("r3 = 0")
+__xlated_unpriv("nospec")
+__xlated_unpriv("if r1 <= 0x800000 goto")
+#endif
+__naked void inlined_loop(void)
+{
+	ASM(START
+	"r1 = 2;"
+	"r2 = nop_cb ll;"
+	"r3 = r7;"
+	"r4 = 0;"
+	NEVER("1f")
+	"r3 = 0;"
+"1:	call %[bpf_loop];"
+	"r0 = 0;"
+	"exit;");
+}
+
+/* A speculative state leaves a number in the slot of the caller */
+static __naked __used int store_cb(void)
+{
+	ASM(START
+	"*(u64 *)(r4 + 0) = r7;"
+	"if r7 == 3 goto 1f;"
+	"*(u64 *)(r4 + 8) = r7;"
+"1:"	NEVER("2f")
+	"*(u64 *)(r4 + 0) = r6;"
+"2:	r0 = 0;"
+	"exit;");
+}
+
+SEC("tc")
+__description("barrier: at the exit of a callback")
+__success SPECULATES __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("*(u64 *)(r4 +0) = r6")
+__xlated_unpriv("...")
+__xlated_unpriv("r0 = 0")
+__xlated_unpriv("nospec")
+__xlated_unpriv("exit")
+#endif
+__naked void exit_of_callback(void)
+{
+	ASM(START
+	"*(u64 *)(r10 - 16) = r6;"
+	"*(u64 *)(r10 - 8) = r7;"
+	"r1 = %[array] ll;"
+	"r2 = store_cb ll;"
+	"r3 = r10;"
+	"r3 += -16;"
+	"r4 = 0;"
+	"call %[bpf_for_each_map_elem];"
+	"r1 = *(u64 *)(r10 - 16);"
+	"r0 = *(u8 *)(r1 + 0);"
+	"r0 = 0;"
+	"exit;");
+}
+
+SEC("tc")
+__description("barrier: on the way out of a loop that is out of budget")
+__success SPECULATES __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("r0 = 1")
+__xlated_unpriv("exit")
+__xlated_unpriv("nospec")
+__xlated_unpriv("r0 = 0")
+__xlated_unpriv("exit")
+#endif
+__naked void unwind_exit(void)
+{
+	ASM(START
+"1:	r1 = *(u64 *)(r6 + 8);"
+	"if r1 != 0 goto 1b;"
+	"r0 = 1;"
+	"exit;");
+}
+
+SEC("tc")
+__description("barrier: before may_goto")
+__success SPECULATES __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("r1 = *(u64 *)(r6 +8)")
+__xlated_unpriv("nospec")
+__xlated_unpriv("...")
+__xlated_unpriv("if r1 > 0x7 goto")
+#endif
+__naked void in_front_of_guard(void)
+{
+	ASM(START
+"1:	r1 = r6;"
+	NEVER("2f")
+	"r1 = *(u64 *)(r6 + 8);"
+"2:	if r1 > 7 goto 1b;"
+	"r0 = 0;"
+	"exit;");
+}
+
+/* The code after the loop needs the result of the jump: may_goto has to leave the program */
+SEC("tc")
+__description("barrier: a speculative state does not select the way of may_goto")
+__success SPECULATES __success_unpriv
+__naked void way_of_guard(void)
+{
+	ASM(START
+	"call bpf_rcu_read_lock;"
+	NEVER("1f")
+	"call bpf_rcu_read_unlock;"
+"1:	r1 = *(u64 *)(r6 + 8);"
+	"if r1 > 7 goto 1b;"
+	"r1 <<= 3;"
+	"r6 += r1;"
+	"r0 = *(u64 *)(r6 + 0);"
+	"r0 = 0;"
+	"exit;");
+}
+
+static __naked __noinline __used int recurse(void)
+{
+	ASM(START
+	"r8 = r1;"
+	"if r8 == 0 goto 2f;"
+	"r9 = r7;"
+	"r9 &= 1;"
+	"if r9 == 0 goto 1f;"
+	"call bpf_rcu_read_lock;"
+"1:	r1 = r8;"
+	"r1 += -1;"
+	"call recurse;"
+	"if r9 == 0 goto 2f;"
+	"call bpf_rcu_read_unlock;"
+"2:	r0 = 0;"
+	"exit;");
+}
+
+SEC("tc")
+__description("barrier: a speculative state holds more in a recursion")
+__success SPECULATES __success_unpriv
+__naked void recursion(void)
+{
+	ASM(START
+	"call bpf_rcu_read_lock;"
+	NEVER("1f")
+	"call bpf_rcu_read_unlock;"
+"1:	r1 = 1;"
+	"call recurse;"
+	"r0 = 0;"
+	"exit;");
+}
+
+/* It releases what its caller holds */
+static __naked __noinline __used int recurse_in_frames(void)
+{
+	asm volatile (
+	"r6 = r1;"
+	"call bpf_rcu_read_unlock;"
+	"call bpf_rcu_read_lock;"
+	"if r6 == 0 goto 1f;"
+	"r1 = r6;"
+	"r1 += -1;"
+	"call recurse_in_frames;"
+"1:	r0 = 0;"
+	"exit;" ::: __clobber_all);
+}
+
+SEC("tc")
+__description("barrier: at the call of a recursion in the frames of the callers")
+__success SPECULATES __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("r1 += -1")
+__xlated_unpriv("nospec")
+__xlated_unpriv("call pc-")
+#endif
+__naked void recursion_in_frames(void)
+{
+	ASM("call bpf_rcu_read_lock;"
+	"r1 = 1;"
+	"call recurse_in_frames;"
+	"call bpf_rcu_read_unlock;"
+	"r0 = 0;"
+	"exit;");
+}
+
+#define CALLS_TWICE(name, next)						\
+	static __noinline long name(long n)				\
+	{								\
+		long a = next(n);					\
+									\
+		barrier_var(n);						\
+		return a + next(n);					\
+	}
+#define FOUR_LEVELS(name, next)						\
+	CALLS_TWICE(name##_a, next)					\
+	CALLS_TWICE(name##_b, name##_a)					\
+	CALLS_TWICE(name##_c, name##_b)					\
+	CALLS_TWICE(name, name##_c)
+
+static __noinline long level_0(long n)
+{
+	return n + data[1];
+}
+
+FOUR_LEVELS(level_4, level_0)
+FOUR_LEVELS(level_8, level_4)
+FOUR_LEVELS(level_12, level_8)
+FOUR_LEVELS(level_16, level_12)
+FOUR_LEVELS(level_20, level_16)
+FOUR_LEVELS(level_24, level_20)
+
+SEC("tc")
+__description("a speculative call has an instance like any other")
+__success SPECULATES __success_unpriv
+int calls_in_a_chain(void *ctx)
+{
+	long i = data[0] & 7;
+
+	barrier_var(i);
+	return data[i] + level_24(data[2]);
+}
+
+static __naked __noinline __used int unlock_never(void)
+{
+	ASM(START
+	NEVER("1f")
+	"goto 2f;"
+"1:	call bpf_rcu_read_unlock;"
+"2:	r0 = 0;"
+	"exit;");
+}
+
+SEC("tc")
+__description("barrier: after the call, the function released what its caller holds")
+__success SPECULATES __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("call pc+")
+__xlated_unpriv("nospec")
+__xlated_unpriv("r6 = 0")
+#endif
+__naked void behind_call(void)
+{
+	ASM("call bpf_rcu_read_lock;"
+	"call unlock_never;"
+	"r6 = 0;"
+	"call bpf_rcu_read_unlock;"
+	"r0 = 0;"
+	"exit;");
+}
+
+SEC("tc")
+__description("barrier: a speculative state goes into a loop that never exits")
+__success SPECULATES __success_unpriv
+__naked void never_exits(void)
+{
+	ASM(START
+	"r0 = 0;"
+	NEVER("1f")
+	"exit;"
+"1:	r0 += 1;"
+	"goto 1b;");
+}
+
+/* A speculative state has a number in r1. @insns write the stack, and no barrier follows. */
+#define WRITE_THEN_LOAD(insns)						\
+	ASM(START							\
+	"*(u64 *)(r10 - 8) = r7;"					\
+	"r1 = r7;"							\
+	NEVER("1f")							\
+	"r1 = r6;"							\
+"1:"	insns								\
+	"r0 = *(u8 *)(r1 + 0);"						\
+	"exit;")
+
+SEC("tc")
+__description("barrier: an atomic does not end a speculative path")
+__success SPECULATES __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("lock *(u64 *)(r10 -8) += r7")
+__xlated_unpriv("nospec")
+__xlated_unpriv("r0 = *(u8 *)(r1 +0)")
+#endif
+__naked void behind_atomic(void)
+{
+	WRITE_THEN_LOAD("lock *(u64 *)(r10 - 8) += r7;");
+}
+
+SEC("tc")
+__description("barrier: a spill that is removed does not end a speculative path")
+__success __arch_x86_64 __caps_unpriv(CAP_BPF | CAP_NET_ADMIN) __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("r0 = *(u32 *)(r0 +0)")
+__xlated_unpriv("nospec")
+__xlated_unpriv("r0 = *(u8 *)(r1 +0)")
+#endif
+__naked void behind_fastcall(void)
+{
+	WRITE_THEN_LOAD("*(u64 *)(r10 - 16) = r1;"
+			"call %[bpf_get_smp_processor_id];"
+			"r1 = *(u64 *)(r10 - 16);");
+}
+
+static __naked __noinline __used int throw_if_zero(void)
+{
+	ASM("if r1 != 0 goto 1f;"
+	"call bpf_throw;"
+"1:	r0 = 0;"
+	"exit;");
+}
+
+/* The code after the first call is dead. The load must not replace it. */
+SEC("tc")
+__description("barrier: after a call that never returns")
+__success SPECULATES __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("r1 = 0")
+__xlated_unpriv("call pc+")
+__xlated_unpriv("nospec")
+__xlated_unpriv("goto pc-2")
+#endif
+__naked void never_returns(void)
+{
+	ASM(START
+	"if r7 == 5 goto 1f;"
+	"r6 = r7;"
+	"r1 = 0;"
+	"call throw_if_zero;"
+	"r0 = *(u8 *)(r6 + 1);"
+	"exit;"
+"1:	r0 = *(u8 *)(r6 + 0);"
+	"r1 = 1;"
+	"call throw_if_zero;"
+	"r0 = 0;"
+	"exit;");
+}
+
+/* The add is rewritten to r3 += 4. A speculative state has the pointer in r2. */
+SEC("socket")
+__description("barrier: a speculative state does not fit the mask")
+__success __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("if r1 == 0x5 goto")
+__xlated_unpriv("nospec")
+__xlated_unpriv("r3 += r2")
+#endif
+__naked void other_mask(void)
+{
+	ASM(START
+	"r1 = 1;"
+	"r2 = 4;"
+	"r3 = r6;"
+	"if r7 < 9 goto 1f;"
+	"r1 = 5;"
+	"r2 = r6;"
+	"r3 = r7;"
+	"r3 &= 15;"
+"1:	if r1 == 5 goto 2f;"
+	"r3 += r2;"
+	"r0 = *(u8 *)(r3 + 0);"
+"2:	r0 = 0;"
+	"exit;");
+}
+
+static __naked __used int bad_timer_cb(void)
+{
+	asm volatile ("r0 = *(u64 *)(r0 + 0); exit;" ::: __clobber_all);
+}
+
+SEC("tc")
+__description("barrier: a speculative state sets no timer")
+__success SPECULATES __success_unpriv
+__naked void timer_never(void)
+{
+	ASM(START
+	"*(u64 *)(r10 - 8) = r7;"
+	"r1 = %[timers] ll;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 2f;"
+	NEVER("1f")
+	"goto 2f;"
+"1:	r1 = r0;"
+	"r2 = bad_timer_cb ll;"
+	"call %[bpf_timer_set_callback];"
+"2:	r0 = 0;"
+	"exit;");
+}
+
+SEC("tc")
+__description("a speculative state does not ask for a stack argument")
+__success SPECULATES __success_unpriv
+__naked void stack_arg_never(void)
+{
+	ASM(START
+	NEVER("1f")
+	"goto 2f;"
+"1:	.8byte 0xfff86b7b;" /* *(u64 *)(r11 - 8) = r6 */
+"2:	r0 = 0;"
+	"exit;");
+}
+
+SEC("tc")
+__description("a trap that no path gets to is no bug of the verifier")
+__success SPECULATES __success_unpriv
+__naked void trap_never(void)
+{
+	ASM(START
+	"r8 = 0;"
+	"r9 = 0;"
+	"if r7 == 0 goto 1f;"
+	"r8 = 1;"
+	"r9 = 5;"
+"1:	if r8 != 0 goto 2f;"
+	"if r9 != 0 goto 3f;"
+"2:	r0 = 0;"
+	"exit;"
+"3:	call __bpf_trap;"
+	"exit;");
+}
+
+#define COMPARE_WITH_END(size)						\
+	ASM(START							\
+	"r2 = *(u32 *)(r1 + %[skb_data]);"				\
+	"r3 = *(u32 *)(r1 + %[skb_data_end]);"				\
+	"r4 = *(" #size " *)(r6 + 8);"					\
+	"r2 += 14;"							\
+	"r2 += r4;"							\
+	"if r2 > r3 goto 1f;"						\
+	"*(u64 *)(r6 + 16) = r4;"					\
+"1:	r0 = 0;"							\
+	"exit;")
+
+SEC("tc")
+__description("no compare of a far pointer to the packet")
+__success __caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__failure_unpriv __msg_unpriv("R3 pointer comparison prohibited")
+__naked void compare_far(void)
+{
+	COMPARE_WITH_END(u32);
+}
+
+SEC("tc")
+__description("a pointer to the packet plus a header and a 16-bit length")
+__success __caps_unpriv(CAP_BPF | CAP_NET_ADMIN) __success_unpriv
+__naked void compare_near(void)
+{
+	COMPARE_WITH_END(u16);
+}
+
+/* Each trip adds a small value */
+SEC("tc")
+__description("no compare of a far pointer to the packet in a loop")
+__success __caps_unpriv(CAP_BPF | CAP_NET_ADMIN)
+__failure_unpriv __msg_unpriv("R3 pointer comparison prohibited")
+__naked void compare_far_loop(void)
+{
+	ASM(START
+	"r2 = *(u32 *)(r1 + %[skb_data]);"
+	"r3 = *(u32 *)(r1 + %[skb_data_end]);"
+	"r0 = 0;"
+"1:	r2 += 0x4000;"
+	"if r2 > r3 goto 2f;"
+	"r0 += 1;"
+	"if r0 < 8 goto 1b;"
+"2:	exit;");
+}
+
+/* The trip count shows that r6 is value + 2^32. It is not the offset of the kptr. */
+SEC("tc")
+__description("a trip count does not make a far offset a constant")
+__failure __msg("R1 doesn't have constant offset")
+__naked void far_by_trip_count(void)
+{
+	ASM("r7 = 0;"
+	"*(u64 *)(r10 - 8) = r7;"
+	"r1 = %[timers] ll;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call %[bpf_map_lookup_elem];"
+	"if r0 == 0 goto 2f;"
+	"r6 = r0;"
+	"r6 += 16;"
+"1:	r8 = r6;"
+	"r6 += 0x7fffffff;"
+	"r6 += 0x7fffffff;"
+	"r6 += 2;"
+	"if r7 == 1 goto 2f;"
+	"r1 = r6;"
+	"r2 = 0;"
+	"call %[bpf_kptr_xchg];"
+	"if r0 == 0 goto 3f;"
+	"r1 = r0;"
+	"call bpf_task_release;"
+"3:	r6 = r8;"
+	"r6 += 8;"
+	"r7 += 1;"
+	"goto 1b;"
+"2:	r0 = 0;"
+	"exit;");
+}
+
+/* The offset is 2^32. Its low 32 bits are 0. */
+SEC("raw_tp.w")
+__description("no access through a far pointer")
+__failure __msg("R6 invalid variable buffer offset")
+__naked void access_far(void)
+{
+	ASM("r6 = *(u64 *)(r1 + 0);"
+	"r6 += 0x7fffffff;"
+	"r6 += 0x7fffffff;"
+	"r6 += 2;"
+	"r0 = *(u8 *)(r6 + 0);"
+	"exit;");
+}
+
+#define MOVES_AWAY(step)						\
+	ASM(START							\
+	"r2 = r6;"							\
+"1:	r2 += " #step ";"						\
+	"r0 = *(u64 *)(r6 + 8);"					\
+	"if r0 != 0 goto 1b;"						\
+	"exit;")
+
+SEC("tc")
+__description("a pointer that is not used moves up without a bound")
+__success
+__naked void moves_up(void)
+{
+	MOVES_AWAY(1);
+}
+
+SEC("tc")
+__description("a pointer that is not used moves down without a bound")
+__success
+__naked void moves_down(void)
+{
+	MOVES_AWAY(-1);
+}
+
+/* r7, r8 = 0, 0 or 1, 5. The join makes the equation r8 = 5 * r7. What follows is dead. */
+#define DEAD_BY_EQUATION						\
+	"call %[bpf_get_prandom_u32];"					\
+	"r7 = 0;"							\
+	"r8 = 0;"							\
+	"if w0 & 1 goto 1f;"						\
+	"r7 = 1;"							\
+	"r8 = 5;"							\
+"1:	if r7 != 0 goto 9f;"						\
+	"if r8 == 0 goto 9f;"
+
+SEC("iter/bpf_map_elem")
+__description("fixups: a dead tail call is removed")
+__success
+__xlated("if r7 != 0x0 goto pc+0")
+__xlated("r0 = 0")
+__xlated("exit")
+__naked void tail_call_never(void)
+{
+	ASM("r6 = r1;"
+	DEAD_BY_EQUATION
+	"r1 = r6;"
+	"r2 = %[progs] ll;"
+	"r3 = 0;"
+	"call %[bpf_tail_call];"
+"9:	r0 = 0;"
+	"exit;");
+}
+
+__noinline int global_func(int x)
+{
+	return x + 1;
+}
+
+static __naked __noinline __used int calls_global(void)
+{
+	asm volatile ("r1 = 1; call global_func; exit;" ::: __clobber_all);
+}
+
+SEC("tc")
+__description("fixups: a dead load does not break the fastcall pattern")
+__success __arch_x86_64
+__xlated("r1 = 7")
+__xlated("r0 = {{.*}}")
+__xlated("r0 = &(void __percpu *)(r0)")
+__naked void one_by_one(void)
+{
+	ASM("r9 = *(u32 *)(r1 + %[skb_data]);"
+	"r6 = *(u32 *)(r1 + %[skb_data_end]);"
+	"call calls_global;"
+	"r1 = 7;"
+	"*(u64 *)(r10 - 8) = r1;"
+	"call %[bpf_get_smp_processor_id];"
+	"r1 = *(u64 *)(r10 - 8);"
+	"if r9 > r6 goto 9f;"
+	DEAD_BY_EQUATION
+	"r0 = *(u64 *)(r10 - 8);"
+"9:	r0 = 0;"
+	"exit;");
+}
+
+SEC("tc")
+__description("log: a path that is dropped is not in the log")
+__failure __log_level(4) __not_msg("off=-2") __msg("value_size=64 off=64")
+__naked void log_of_dropped_path(void)
+{
+	/* After 'r2 == r3' any number is 2 or more, but -32..31 stays as it is */
+	ASM(START
+	"r3 = *(u64 *)(r6 + 16);"
+	"if r3 < 2 goto 2f;"
+	"r2 = *(u64 *)(r6 + 8);"
+	"r2 &= 63;"
+	"r2 += -32;"
+	"r9 = 0;"
+	"if r7 < 5 goto 1f;"
+	"r2 = *(u64 *)(r6 + 8);"
+	"r9 = 64;"
+"1:	if r2 != r3 goto 2f;"
+	"if r2 > 40 goto 2f;"
+	"r4 = r6;"
+	"r4 += r2;"
+	"r0 = *(u8 *)(r4 - 2);"
+	"r6 += r9;"
+	"r0 = *(u64 *)(r6 + 0);"
+"2:	r0 = 0;"
+	"exit;");
+}
+
+SEC("tc")
+__description("log: the report of a leak starts at the acquire")
+__failure __msg("Unreleased reference") __msg("Causal path:")
+__not_msg("(15) if r0 == 0x0") __msg("acquired: owned resource")
+__naked void log_of_leak(void)
+{
+	ASM("r1 = %[ring] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"if r0 == 0 goto 1f;"
+	"r0 = 0;"
+"1:	exit;");
+}
+
+static __naked __noinline __used void reserve(void)
+{
+	ASM("r1 = %[ring] ll;"
+	"r2 = 8;"
+	"r3 = 0;"
+	"call %[bpf_ringbuf_reserve];"
+	"exit;");
+}
+
+SEC("tc")
+__description("log: one insn acquires twice, each report has its acquire and one id")
+__failure __msg("Unreleased reference id=4 ") __msg("acquired: owned resource (id=4)")
+__msg("branch: took the false branch")
+__msg("Unreleased reference id=12 ") __msg("acquired: owned resource (id=12)")
+__not_msg("branch: took the false branch")
+__naked void log_of_two_leaks(void)
+{
+	ASM("call reserve;"
+	"if r0 == 0 goto 1f;"
+	"call reserve;"
+"1:	r0 = 0;"
+	"exit;");
+}
+
+SEC("tc")
+__description("log: no report for a speculative state")
+__success SPECULATES __success_unpriv __log_level(2)
+#ifdef SPEC_V1
+__msg_unpriv("R7 invalid mem access 'scalar'")
+#endif
+__not_msg_unpriv("Verification failed")
+__naked void log_of_speculative_state(void)
+{
+	ASM(START
+	NEVER("1f")
+	"r0 = 0;"
+	"exit;"
+"1:	r0 = *(u64 *)(r7 + 0);"
+	"exit;");
+}
+
+static const volatile char bytes[4] = { 1, 2, 3, 4 };
+
+/* const_fold.c does not follow 'r3 *= 2'. If it has r2 = 3, then r2 == 4 is a verifier bug. */
+SEC("socket")
+__description("a far pointer to .rodata that comes back loads no constant")
+__success __retval(0) __xlated("r0 = r2")
+__naked void far_rodata(void)
+{
+	asm volatile (
+	"r1 = %[bytes] ll;"
+	"r1 += 0x20000001;"
+	"r1 += -0x1fffffff;"
+	"r2 = *(u8 *)(r1 + 0);"
+	"r3 = 2;"
+	"r3 *= 2;"
+	"r0 = 0;"
+	"if r2 != r3 goto 1f;"
+	"r0 = r2;"
+"1:"
+	"exit;"
+	:: __imm_addr(bytes) : __clobber_all);
+}
+
+/* The patches turn 8200 divisions into 32800 insns, too far for a 16-bit offset. */
+#define DIVS		"r2 = r7; r3 = r7; .rept 8200; r2 /= r3; .endr;"
+
+SEC("tc")
+__description("barrier: where a far jump lands")
+__success SPECULATES __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("8: gotol pc+32803")
+__xlated_unpriv("...")
+__xlated_unpriv("32812: nospec")
+#endif
+__naked void far_target(void)
+{
+	ASM(START
+	"r8 = r7;"
+	NEVER("1f")
+	"r8 = r6;"
+	DIVS
+"1:	r0 = *(u64 *)(r8 + 8);"
+	"r0 = 0;"
+	"exit;");
+}
+
+SEC("tc")
+__description("barrier: after a far jump")
+__success SPECULATES __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("8: gotol pc+32804")
+__xlated_unpriv("9: nospec")
+#endif
+__naked void far_fall(void)
+{
+	ASM(START
+	"r8 = r6;"
+	"if r7 == 5 goto 1f;"
+	"r8 = r7;"
+"1:	if r7 != 5 goto 2f;"
+	"r0 = *(u64 *)(r8 + 8);"
+	DIVS
+"2:	r0 = 0;"
+	"exit;");
+}
+
+SEC("tc")
+__description("barrier: on the far exit that is out of budget")
+__success __arch_x86_64 __caps_unpriv(CAP_BPF | CAP_NET_ADMIN) __success_unpriv
+#ifdef SPEC_V1
+__xlated_unpriv("16: gotol pc+32810")
+__xlated_unpriv("...")
+__xlated_unpriv("32827: nospec")
+#endif
+__naked void far_unwind_exit(void)
+{
+	ASM(START
+"1:	r1 = *(u64 *)(r6 + 8);"
+	"if r1 != 0 goto 1b;"
+	DIVS
+	"r0 = 1;"
+	"exit;");
+}
+
+/* the kfuncs have to be in BTF */
+void __kfunc_btf_root(void)
+{
+	bpf_rcu_read_lock();
+	bpf_rcu_read_unlock();
+	bpf_task_release(NULL);
+	__bpf_trap();
+	bpf_throw(0);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.55.0

