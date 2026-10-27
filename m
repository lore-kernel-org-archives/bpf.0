Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.38.64.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793081617;
	b=cwrehq/A7o7oDOcM197q8JgP1wuf28p2vDLevGtaqn/9/0x05I2vg7guGGbNRewOeEj9
	 On8ZP2u4Qon0aVDqAgAqxj/LEAt4N/YEsm9IZtxa5SHDK+bMBN1FeTZrAAmIqBE+KROAP
	 KEVYtSx9kean92R6XpP8bUTx4C+DXlNczhxytF9vSkq1zWDIQzb6jfRO3YIEDYg5kkTFz
	 q56sxxELKuY/T4eDGVRHg7MjZzML8at43mb+NoFC3OQk3R5a1OCwbP+I2zvFiqsyz4o72
	 DlmsoUiZNjTo/apVV/IYD3f/qnHQp8h39LDDVseqcvIJBGT1RdEOodk8aJZl1w3I2Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793081617;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=LbsOkEj4K1qWPc0RiMIedsRWJ5b80C4Brq6g1y8kFyE=;
	b=KaHRmYH7d8NUQKMnamfa5G/CRzwBWmFxCH7zLyf48lG7cFmacoJNBFeo0UhHvM282SkW
	 MgVpwmqjfs6g0QTsNY5tCqWpUh7okBfaxdBOTzBLe77CbQWSxdy7q2S7WB0oeWWSJzvgJ
	 fxZuuiaZF2NmV7idy2djEkx3EPLzDXqImFOjraFgwvLz1USTgGiNs6uPUnUq6TDn0CCYa
	 Ddvs8imzDSMb9R5GHEDEaNmlwZXrfCR3TevqAr7JSGEaFX4kPOGLj0U0Kwz0g6Q4F5n3y
	 tH8hkP+ZKq3CR9UHHKE47NEJecTu0ODsQZhtdRMVRU0A3HjCbH0h2zJRXXsGPzz05Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.ustc.edu.cn;
	spf=pass smtp.mailfrom=mail.ustc.edu.cn;
	dkim=pass header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=Q722e6B5;
	arc=none smtp.remote-ip=202.38.64.46
Received: from ustc.edu.cn (smtp.ustc.edu.cn [202.38.64.46])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C9B606A31A
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 06:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51C9B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.ustc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.ustc.edu.cn header.i=@mail.ustc.edu.cn header.a=rsa-sha256 header.s=dkim header.b=Q722e6B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mail.ustc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=LbsOkEj4K1qWPc0RiMIedsRWJ5b80C4Brq
	6g1y8kFyE=; b=Q722e6B56BA+KgLaQTnQrFIjMOPOzn1xQaSVDrPE66+NzUKvBG
	2F5n9VpCNNL9YvUWZDYQVKpgcv6/F1Z8PXAtIfaEashmpPpG2ydeo1afiJfCgLpT
	H4Wvbvm0ieTDfGNQDTts8Hf3lgX3tATuW86j5FhldpKMzyeV2Nb1032q0=
Received: from localhost (unknown [222.195.81.103])
	by mailimap2024 (Coremail) with SMTP id 3pYKCgBHuS0JQeBqm+BOAA--.1215S2;
	Tue, 27 Oct 2026 14:13:29 +0800 (CST)
From: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf 2/2] selftests/bpf: Exercise stack argument precision on state reuse
Date: Tue, 27 Oct 2026 14:13:03 +0800
Message-ID: <20261027061303.1754535-3-xyx2021@mail.ustc.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027061303.1754535-1-xyx2021@mail.ustc.edu.cn>
References: <20261027061303.1754535-1-xyx2021@mail.ustc.edu.cn>
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
X-CM-TRANSID:3pYKCgBHuS0JQeBqm+BOAA--.1215S2
X-Coremail-Antispam: 1UD129KBjvJXoW3KrW3Wr4DJr1Dur4rWr1DGFg_yoWkGF43pa
	4fWF1Duw4xJa15A397tFWxAa13KFs5AFsrJas3Kr13AF4xtw13W3W8tay3ta13JryrXr1S
	vr15Aa97GayUJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r47MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU5Cg4PUUUUU==
X-CM-SenderInfo: h010jiysr6zt1loo32lwfovvfxof0/

Add load-only verifier regressions for state reuse with the sixth and
seventh arguments, including joins inside callees and nested frames.
An in-bounds offset and a discarded offset provide acceptance controls;
an ordinary register argument provides a rejection control.

Exercise conservative precision fallback separately with bounded
pointer subtraction, and require log evidence that both argument slots
are marked precise, including when they reside in the caller frame.

Build instructions and BTF directly so these tests run even when Clang
does not yet support emitting stack arguments.

AI assistance was used in preparing this patch.

Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
---
 .../prog_tests/stack_arg_precision_reuse.c    | 300 ++++++++++++++++++
 1 file changed, 300 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/stack_arg_precision_reuse.c

diff --git a/tools/testing/selftests/bpf/prog_tests/stack_arg_precision_reuse.c b/tools/testing/selftests/bpf/prog_tests/stack_arg_precision_reuse.c
new file mode 100644
index 0000000000000000000000000000000000000000..4497d959247d75bb38668b6c0358d756908183ea
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stack_arg_precision_reuse.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <test_progs.h>
+#include <bpf/btf.h>
+
+#define BPF_REG_PARAMS 11
+
+/* Construct BTF and instructions directly so these tests also run with
+ * compilers which cannot emit stack arguments yet.
+ */
+struct test_program {
+	struct bpf_insn insns[128];
+	struct bpf_func_info funcs[3];
+	struct btf *btf;
+	int insn_cnt;
+	int func_cnt;
+};
+
+static char log_buf[1024 * 1024];
+
+static int emit(struct test_program *p, struct bpf_insn insn)
+{
+	int idx = p->insn_cnt++;
+
+	p->insns[idx] = insn;
+	return idx;
+}
+
+static void jump_to(struct test_program *p, int from, int to)
+{
+	p->insns[from].off = to - from - 1;
+}
+
+static bool add_func(struct test_program *p, int nargs)
+{
+	char name[16];
+	int proto, id, i;
+
+	proto = btf__add_func_proto(p->btf, 1);
+	if (!ASSERT_GT(proto, 0, "func_proto"))
+		return false;
+	for (i = 0; i < nargs; i++) {
+		snprintf(name, sizeof(name), "arg%d", i + 1);
+		id = btf__add_func_param(p->btf, name, i == 0 ? 2 : 1);
+		if (!ASSERT_OK(id, "func_param"))
+			return false;
+	}
+	snprintf(name, sizeof(name), "func%d", p->func_cnt);
+	id = btf__add_func(p->btf, name,
+			   p->func_cnt ? BTF_FUNC_STATIC : BTF_FUNC_GLOBAL, proto);
+	if (!ASSERT_GT(id, 0, "func"))
+		return false;
+	p->funcs[p->func_cnt++] = (struct bpf_func_info) {
+		.insn_off = p->insn_cnt,
+		.type_id = id,
+	};
+	return true;
+}
+
+static bool init_program(struct test_program *p)
+{
+	p->btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(p->btf, "btf_new"))
+		return false;
+	if (!ASSERT_EQ(btf__add_int(p->btf, "u64", 8, 0), 1, "btf_int") ||
+	    !ASSERT_EQ(btf__add_ptr(p->btf, 0), 2, "btf_ptr"))
+		return false;
+	return add_func(p, 1);
+}
+
+static void lookup_map(struct test_program *p, int map_fd)
+{
+	struct bpf_insn insns[] = {
+		BPF_ST_MEM(BPF_W, BPF_REG_10, -8, 0),
+		BPF_LD_MAP_FD(BPF_REG_1, map_fd),
+		BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
+		BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
+		BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
+		BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
+		BPF_EXIT_INSN(),
+		BPF_MOV64_REG(BPF_REG_7, BPF_REG_0),
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(insns); i++)
+		emit(p, insns[i]);
+}
+
+struct reuse_test {
+	const char *name;
+	int slot;
+	int offset;
+	bool discard;
+	bool callee_join;
+	bool nested;
+};
+
+static bool build_reuse(struct test_program *p, int map_fd,
+			const struct reuse_test *test)
+{
+	int branch, path1, path2, path3, call, i;
+	int off = -(test->slot + 1) * 8;
+
+	if (test->nested) {
+		emit(p, BPF_CALL_REL(1));
+		emit(p, BPF_EXIT_INSN());
+		if (!add_func(p, 1))
+			return false;
+	}
+	lookup_map(p, map_fd);
+	emit(p, BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32));
+	/* Keep the unused earlier argument initialized when testing arg7. */
+	for (i = 0; i < test->slot; i++)
+		emit(p, BPF_ST_MEM(BPF_DW, BPF_REG_PARAMS, -(i + 1) * 8, 0));
+	branch = emit(p, BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 0));
+	emit(p, BPF_MOV64_IMM(BPF_REG_6, 0));
+	if (test->slot >= 0)
+		emit(p, BPF_ST_MEM(BPF_DW, BPF_REG_PARAMS, off, 0));
+	if (test->callee_join)
+		emit(p, BPF_MOV64_IMM(BPF_REG_8, 1));
+	path1 = emit(p, BPF_JMP_A(0));
+	jump_to(p, branch, p->insn_cnt);
+	if (test->callee_join)
+		emit(p, BPF_MOV64_IMM(BPF_REG_8, 0));
+	branch = emit(p, BPF_JMP_IMM(BPF_JEQ, BPF_REG_0, 1, 0));
+	emit(p, BPF_MOV64_IMM(BPF_REG_6, 0));
+	path2 = emit(p, BPF_JMP_A(0));
+	jump_to(p, branch, p->insn_cnt);
+	emit(p, BPF_MOV64_IMM(BPF_REG_6, test->offset));
+	path3 = emit(p, BPF_JMP_A(0));
+	/* M: paths 2 and 3 meet with their offsets still in r6. Path 2
+	 * must acquire precision here when it reuses path 1's state at P.
+	 */
+	jump_to(p, path2, p->insn_cnt);
+	jump_to(p, path3, p->insn_cnt);
+	if (test->slot >= 0) {
+		emit(p, BPF_STX_MEM(BPF_DW, BPF_REG_PARAMS, BPF_REG_6, off));
+		emit(p, BPF_MOV64_IMM(BPF_REG_6, 0));
+	}
+	branch = emit(p, BPF_JMP_A(0));
+	/* P: the precise offset is now in the outgoing argument slot. */
+	jump_to(p, path1, p->insn_cnt);
+	jump_to(p, branch, p->insn_cnt);
+	emit(p, BPF_MOV64_REG(BPF_REG_1, BPF_REG_7));
+	for (i = 2; i <= 5; i++) {
+		if (i == 2 && (test->slot < 0 || test->callee_join))
+			emit(p, BPF_MOV64_REG(i, test->slot < 0 ? BPF_REG_6 : BPF_REG_8));
+		else
+			emit(p, BPF_MOV64_IMM(i, 0));
+	}
+	call = emit(p, BPF_CALL_REL(0));
+	emit(p, BPF_EXIT_INSN());
+	p->insns[call].imm = p->insn_cnt - call - 1;
+	if (!add_func(p, test->slot < 0 ? 2 : 6 + test->slot))
+		return false;
+	/* Different precise r2 values prevent reuse before the callee.
+	 * They converge here while the offset is still in the caller's slot.
+	 */
+	if (test->callee_join) {
+		emit(p, BPF_JMP_IMM(BPF_JEQ, BPF_REG_2, 0, 2));
+		emit(p, BPF_MOV64_IMM(BPF_REG_2, 0));
+		emit(p, BPF_JMP_A(0));
+	}
+	if (test->slot < 0)
+		emit(p, BPF_MOV64_REG(BPF_REG_6, BPF_REG_2));
+	else
+		emit(p, BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_PARAMS, -off));
+	if (test->discard)
+		emit(p, BPF_ALU64_IMM(BPF_AND, BPF_REG_6, 0));
+	emit(p, BPF_ALU64_REG(BPF_ADD, BPF_REG_1, BPF_REG_6));
+	emit(p, BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, 0));
+	emit(p, BPF_EXIT_INSN());
+	return true;
+}
+
+static bool build_fallback(struct test_program *p, int map_fd, bool callee)
+{
+	lookup_map(p, map_fd);
+	emit(p, BPF_EMIT_CALL(BPF_FUNC_get_prandom_u32));
+	emit(p, BPF_STX_MEM(BPF_DW, BPF_REG_PARAMS, BPF_REG_0, -8));
+	emit(p, BPF_STX_MEM(BPF_DW, BPF_REG_PARAMS, BPF_REG_0, -16));
+	emit(p, BPF_JMP_A(0));
+	if (callee) {
+		emit(p, BPF_MOV64_REG(BPF_REG_1, BPF_REG_7));
+		emit(p, BPF_MOV64_IMM(BPF_REG_2, 0));
+		emit(p, BPF_MOV64_IMM(BPF_REG_3, 0));
+		emit(p, BPF_MOV64_IMM(BPF_REG_4, 0));
+		emit(p, BPF_MOV64_IMM(BPF_REG_5, 0));
+		emit(p, BPF_CALL_REL(1));
+		emit(p, BPF_EXIT_INSN());
+		if (!add_func(p, 7))
+			return false;
+		emit(p, BPF_MOV64_REG(BPF_REG_7, BPF_REG_1));
+	}
+	/* Subtraction turns r1 into a scalar. Precision backtracking across
+	 * the store through its old pointer value needs conservative fallback.
+	 * The resulting offset is bounded, so this program is always safe.
+	 */
+	emit(p, BPF_MOV64_REG(BPF_REG_1, BPF_REG_7));
+	emit(p, BPF_ST_MEM(BPF_W, BPF_REG_1, 0, 0));
+	emit(p, BPF_ALU64_REG(BPF_SUB, BPF_REG_1, BPF_REG_7));
+	emit(p, BPF_ALU64_IMM(BPF_AND, BPF_REG_1, 7));
+	emit(p, BPF_ALU64_REG(BPF_ADD, BPF_REG_7, BPF_REG_1));
+	emit(p, BPF_LDX_MEM(BPF_B, BPF_REG_0, BPF_REG_7, 0));
+	if (!callee) {
+		/* Consume the outgoing slots after exercising fallback. */
+		emit(p, BPF_MOV64_REG(BPF_REG_1, BPF_REG_7));
+		emit(p, BPF_MOV64_IMM(BPF_REG_2, 0));
+		emit(p, BPF_MOV64_IMM(BPF_REG_3, 0));
+		emit(p, BPF_MOV64_IMM(BPF_REG_4, 0));
+		emit(p, BPF_MOV64_IMM(BPF_REG_5, 0));
+		emit(p, BPF_CALL_REL(1));
+		emit(p, BPF_EXIT_INSN());
+		if (!add_func(p, 7))
+			return false;
+		emit(p, BPF_MOV64_IMM(BPF_REG_0, 0));
+	}
+	emit(p, BPF_EXIT_INSN());
+	return true;
+}
+
+static void check_program(struct test_program *p, bool reject, bool fallback)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, opts,
+		.prog_flags = BPF_F_TEST_STATE_FREQ,
+		.log_buf = log_buf,
+		.log_size = sizeof(log_buf),
+		.log_level = 2,
+		.func_info = p->funcs,
+		.func_info_cnt = p->func_cnt,
+		.func_info_rec_size = sizeof(p->funcs[0]),
+	);
+	int fd;
+
+	if (!ASSERT_OK(btf__load_into_kernel(p->btf), "load_btf"))
+		return;
+	opts.prog_btf_fd = btf__fd(p->btf);
+	log_buf[0] = '\0';
+	fd = bpf_prog_load(BPF_PROG_TYPE_SCHED_CLS, "stack_precision", "GPL",
+			   p->insns, p->insn_cnt, &opts);
+	if (env.verbosity > VERBOSE_NONE)
+		printf("%s\n", log_buf);
+	if (reject) {
+		ASSERT_LT(fd, 0, "reject_unsafe_offset");
+		ASSERT_HAS_SUBSTR(log_buf, "invalid access to map value", "bounds_error");
+	} else {
+		ASSERT_GE(fd, 0, "accept_safe_program");
+	}
+	if (fallback) {
+		ASSERT_HAS_SUBSTR(log_buf, "falling back to forcing all scalars precise",
+				  "fallback_reached");
+		ASSERT_HAS_SUBSTR(log_buf, "force_precise: frame0: forcing r11-8 to be precise",
+				  "fallback_arg6");
+		ASSERT_HAS_SUBSTR(log_buf, "force_precise: frame0: forcing r11-16 to be precise",
+				  "fallback_arg7");
+	}
+	if (fd >= 0)
+		close(fd);
+}
+
+void test_stack_arg_precision_reuse(void)
+{
+	const struct reuse_test tests[] = {
+		{ .name = "arg6", .slot = 0, .offset = 32 },
+		{ .name = "arg7", .slot = 1, .offset = 32 },
+		{ .name = "caller_frame", .slot = 0, .offset = 32, .callee_join = true },
+		{ .name = "nested_caller_frame", .slot = 1, .offset = 32,
+		  .callee_join = true, .nested = true },
+		{ .name = "in_bounds", .slot = 1, .offset = 8 },
+		{ .name = "discarded", .slot = 0, .offset = 32, .discard = true },
+		{ .name = "register_control", .slot = -1, .offset = 32 },
+	};
+	struct test_program p;
+	int map_fd, i;
+
+	/* Stack argument JIT support currently exists on x86-64 and arm64. */
+#if !defined(__x86_64__) && !defined(__aarch64__)
+	test__skip();
+	return;
+#endif
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, NULL, 4, 16, 1, NULL);
+	if (!ASSERT_GE(map_fd, 0, "map_create"))
+		return;
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (!test__start_subtest(tests[i].name))
+			continue;
+		memset(&p, 0, sizeof(p));
+		if (init_program(&p) && build_reuse(&p, map_fd, &tests[i]))
+			check_program(&p, tests[i].offset > 8 && !tests[i].discard, false);
+		btf__free(p.btf);
+	}
+	for (i = 0; i < 2; i++) {
+		if (!test__start_subtest(i ? "fallback_caller_frame" : "fallback"))
+			continue;
+		memset(&p, 0, sizeof(p));
+		if (init_program(&p) && build_fallback(&p, map_fd, i))
+			check_program(&p, false, true);
+		btf__free(p.btf);
+	}
+	close(map_fd);
+}
-- 
2.43.0

