Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=131.188.11.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627751;
	b=LB/srVO64/6+3XTxg+snIO8twmaHxxB6VKhnkQauf8MDV6/pTobjww7At66FqjXn39dE
	 adYI9john0UU+PYwN6wNS6tkewMdwud0UJzJVA+hSpa3CyHpCVrncYcU3IxC/84nTuIwB
	 t2wM87m7gd+BwmDDLarFpTn15XeHRH7rWEmeAhZbds03sBZ4QEi4a97XZmoqERZwe0/l2
	 yCBEBgPlsuLULSUxH/GjfvYTmIMr2oFCRESmuVSrThAO2RHZ53cEZVspxrgoxTbUpp4Qu
	 +1sqMi3vHVcAAkX2Gp0msLpcFghFOlJTHC3ks6LVOmjgL57hPOUnhGput9zsS1HCZcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627751;
	h=DMARC-Filter:DKIM-Signature:Received:X-Virus-Scanned:X-RRZE-Flag:
	 X-RRZE-Submit-IP:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kk4HSfep6lD7JbkZrDPTxgrBwIlCPCupQVQtAuMl/dQ=;
	b=5UBfzWC6BUxNifl2OytnaIrFySmkcsnBRSYVVlVXS0ZtlufSbwLJLerPu2NSr9xBpYsA
	 H/71HxDD4yGHtI2DMrk0HhgIgbvWXZ1TYXmy/Z2/kcp8tTwdiDL/UZywwKLQ+Ox1o7o22
	 ypvuDmWzNp2o+BpTivRVhZ1RiCVLMzY8DrwtRnaA3z4xeOHZdb1AtGYZDkPmxx5iWegrn
	 APt07PINjdNzmX2MCh+SuRDclkELi7vWjoz4rGwMa0WXIPB6LqfRf3X/Ls2r3tYP1YnVm
	 r5aQzinyuwfJrw5Q+p75l5jDY5gqVdgvOrWwVVuYm6pOlbmGsO2MMIDtr8eLy2aY3Yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fau.de;
	spf=pass smtp.mailfrom=fau.de;
	dkim=pass header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=lLpuowNO;
	arc=none smtp.remote-ip=131.188.11.21
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D8606A31E;
	Wed, 25 Nov 2026 17:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 970D8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=lLpuowNO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1795627749; bh=kk4HSfep6lD7JbkZrDPTxgrBwIlCPCupQVQtAuMl/dQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=lLpuowNO8sqSxDnLqUsbXyPemn9qNAM5d1WoenUiwYbXHRuL/8sRJGdk5IDYitiTz
	 XvcUZPrbZvbPR+46r4EpvqPyIcuU0KcAz1cQsQYuuSB3HDOtk31CdOt7prI3vb1EyC
	 Wu2v4US5jzCG03/S8e+eT55HZ079Bnykd9O6CmHnXEaz6ghAbKRlBsPyy6J6uD4VwJ
	 Csg8jivuSI5UQK6MwWEsunhyMbROaL0sk+2+vHBEIFNrloBWM3IDEGuOptKPOVU9qA
	 yNXPgifwTWsQdDkTssCD3z5PBd3DZZuB44SPr8D44JKzvfD8dMwJvNW7p7nPmHZo/C
	 pkLzvDhVoAo/Q==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4jZRVr6lH5zPkpl;
	Wed, 25 Nov 2026 18:29:08 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:620:618:5b8:2:80b3:0:59e
Received: from luis-tp.epfl.ch (unknown [IPv6:2001:620:618:5b8:2:80b3:0:59e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX1+mXuB51AtwrTnI/EBm3xGZ6zuWk22nc0w=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4jZRVn4tKZzPkS4;
	Wed, 25 Nov 2026 18:29:05 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <ast@kernel.org>,
	bpf@vger.kernel.org
Cc: Luis Gerhorst <luis.gerhorst@fau.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Henriette Herzog <henriette.herzog@rub.de>,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf 4/4] selftests/bpf: Test nospec after stack writes of calls and atomics
Date: Wed, 25 Nov 2026 18:12:52 +0100
Message-ID: <254382ea54ff319c0dcf8c93642f5850b276b549.1795625597.git.luis.gerhorst@fau.de>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <cover.1795625597.git.luis.gerhorst@fau.de>
References: <20261125-nospec-result-reply-d60fdc6da8ef@fau.de> <cover.1795625597.git.luis.gerhorst@fau.de>
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

Check that a nospec follows an insn that writes to the stack if the insn
is not a BPF_MEM store:

- a call of bpf_ringbuf_reserve_dynptr(), which initializes a dynptr on
  the stack
- a BPF_ATOMIC insn

Also check that a program is rejected if it requires a nospec that does
not fit: in front of a jump with the smallest offset, or behind a store
that is between such a jump and its target. The programs are valid. They
are rejected because of a limit of insn patching that exists for every
insn the verifier inserts there: the jump can not be widened. The tests
document that the programs are not loaded without the nospec in this
case, not that they should be rejected. No test covered these error
paths so far.

Two more cases reach code that no test runs so far:

- a store that is only reached speculatively: do_check() ends the
  speculative path at it because a nospec follows, and the store is
  replaced as dead code
- a backward jump with a nospec in front of it, whose 16-bit offset
  bpf_adj_moved_insn() adjusts

The programs that need more than an unprivileged program may do are
loaded with CAP_BPF but without CAP_PERFMON, so that Spectre v1 and v4
are mitigated for them.

Assisted-by: Claude:claude-mythos-5-2
Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 .../selftests/bpf/progs/verifier_unpriv.c     | 201 ++++++++++++++++++
 1 file changed, 201 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_unpriv.c b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
index a54b5a58b945..12d5e9e66890 100644
--- a/tools/testing/selftests/bpf/progs/verifier_unpriv.c
+++ b/tools/testing/selftests/bpf/progs/verifier_unpriv.c
@@ -1035,6 +1035,71 @@ __naked void stack_write_nospec_slot_index(void)
 "	::: __clobber_all);
 }
 
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 4096);
+} map_ringbuf SEC(".maps");
+
+/* The helper initializes the dynptr on the stack. */
+SEC("socket")
+__description("unpriv: Spectre v4 nospec after stack write in helper")
+__success __success_unpriv
+__caps_unpriv(CAP_BPF)
+__retval(0)
+#ifdef SPEC_V4
+__xlated_unpriv("r4 = r10")
+__xlated_unpriv("r4 += -16")
+__xlated_unpriv("call")
+__xlated_unpriv("nospec")
+__xlated_unpriv("r1 = r10")
+#endif
+__naked void helper_stack_write_nospec_result(void)
+{
+	asm volatile ("					\
+	r1 = %[map_ringbuf] ll;				\
+	r2 = 8;						\
+	r3 = 0;						\
+	r4 = r10;					\
+	r4 += -16;					\
+	call %[bpf_ringbuf_reserve_dynptr];		\
+	r1 = r10;					\
+	r1 += -16;					\
+	r2 = 0;						\
+	call %[bpf_ringbuf_discard_dynptr];		\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ringbuf_reserve_dynptr),
+	  __imm(bpf_ringbuf_discard_dynptr),
+	  __imm_addr(map_ringbuf)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("unpriv: Spectre v4 nospec after atomic stack write")
+__success __success_unpriv
+__caps_unpriv(CAP_BPF)
+__retval(2)
+#ifdef SPEC_V4
+__xlated_unpriv("r1 = 1")
+__xlated_unpriv("*(u64 *)(r10 -8) = r1")
+__xlated_unpriv("nospec")
+__xlated_unpriv("lock *(u64 *)(r10 -8) += r1")
+__xlated_unpriv("nospec")
+__xlated_unpriv("r0 = *(u64 *)(r10 -8)")
+__xlated_unpriv("exit")
+#endif
+__naked void atomic_stack_write_nospec_result(void)
+{
+	asm volatile ("					\
+	r1 = 1;						\
+	*(u64 *)(r10 - 8) = r1;				\
+	lock *(u64 *)(r10 - 8) += r1;			\
+	r0 = *(u64 *)(r10 - 8);				\
+	exit;						\
+"	::: __clobber_all);
+}
+
 __noinline int nospec_global_func(int x)
 {
 	return x + 1;
@@ -1072,4 +1137,140 @@ __naked void nospec_backward_call(void)
 "	::: __clobber_all);
 }
 
+/*
+ * The jump is reached with a pointer in r6 on a speculative path only, so a
+ * nospec is required in front of it. Its offset is the smallest one that a
+ * jump can have, and the nospec is between the jump and its target: the offset
+ * can not be adjusted for the nospec.
+ *
+ * The program is valid, it is only rejected because the verifier can not widen
+ * a jump when it patches a program. Any insn that is inserted between such a
+ * jump and its target has the same effect. Without the nospec the program
+ * would not be safe, so it must not be loaded. If jumps can be widened one day,
+ * this program has to be accepted.
+ *
+ * The insns that are only executed speculatively are removed as dead code, so
+ * they must not be between the jump and its target.
+ */
+SEC("socket")
+__description("unpriv: nospec does not fit in front of a jump")
+__success __failure_unpriv
+__msg_unpriv("cannot be patched due to 16-bit range")
+__caps_unpriv(CAP_BPF)
+__retval(0)
+__naked void nospec_jump_out_of_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r6 = r0;					\
+	r7 = 0;						\
+	if r0 < 0x100 goto l1_%=;			\
+	/* executed only speculatively */		\
+	r6 = r10;					\
+	goto l1_%=;					\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	.rept 32765;					\
+	r1 = 0;						\
+	.endr;						\
+	if r7 != r6 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/*
+ * Like above, but for the nospec behind a store to the stack that is between
+ * the jump and its target.
+ */
+SEC("socket")
+__description("unpriv: nospec does not fit behind a store")
+__success __failure_unpriv
+__msg_unpriv("cannot be patched due to 16-bit range")
+__caps_unpriv(CAP_BPF)
+__retval(0)
+__naked void nospec_result_jump_out_of_range(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r6 = r0;					\
+	r7 = 0;						\
+	goto l1_%=;					\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	*(u64 *)(r10 - 8) = r7;				\
+	.rept 32764;					\
+	r1 = 0;						\
+	.endr;						\
+	if r7 != r6 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+/* The store is only reached speculatively and is replaced as dead code. */
+SEC("socket")
+__description("unpriv: Spectre v4 nospec after dead stack write")
+__success __success_unpriv
+__retval(0)
+#ifdef SPEC_V4
+__xlated_unpriv("if r0 == 0x0 goto pc+2")
+__xlated_unpriv("goto pc-1")
+__xlated_unpriv("nospec")
+__xlated_unpriv("exit")
+#endif
+__naked void dead_stack_write_nospec_result(void)
+{
+	asm volatile ("					\
+	w7 = 0;						\
+	w7 ^= w7;					\
+	w0 = w7;					\
+	if r0 == 0 goto l0_%=;				\
+	*(u64 *)(r10 - 8) = r0;				\
+l0_%=:	exit;						\
+"	::: __clobber_all);
+}
+
+/*
+ * The jump is reached with a pointer in r6 on a speculative path only. Its
+ * offset is adjusted for the nospec in front of it.
+ */
+SEC("socket")
+__description("unpriv: nospec in front of a backward jump")
+__success __success_unpriv
+__retval(0)
+#ifdef SPEC_V1
+__xlated_unpriv("nospec")
+__xlated_unpriv("if r7 != r6 goto pc-6")
+__xlated_unpriv("r0 = 0")
+__xlated_unpriv("exit")
+#endif
+__naked void nospec_backward_jump(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r0 &= 0xff;					\
+	r6 = r0;					\
+	r7 = 0;						\
+	if r0 < 0x100 goto l1_%=;			\
+	/* executed only speculatively */		\
+	r6 = r10;					\
+	goto l1_%=;					\
+l0_%=:	r0 = 0;						\
+	exit;						\
+l1_%=:	r1 = 0;						\
+	r1 = 0;						\
+	if r7 != r6 goto l0_%=;				\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.56.1

