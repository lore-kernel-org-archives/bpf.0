Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA012517A5;
	Wed,  1 Jul 2026 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782913548; cv=none; b=lAByh2Y6CquFN5d8CfK/T3mcDQcWb2PmUQPrijqXT9CrYg2Hxo5VZgVDyDQbb7M6qa6BH83Zrrst5ISRHhaoJPx3efR4fQJv0Tw9SRLoBeVO8TBMeEy+PYuhRaMK+P8rz2Dq5hbjTq+rSctGyuU+gTx706u4qNXpDxBkQW/yVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782913548; c=relaxed/simple;
	bh=mkoNX3J7h3IDArvSasPNiCdjlinWeVoSrHtyGDRdnHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SpxxyxZEgig8AmR1EV7MOBGSq2TCZIQ+57sSHwY6wK3QsA2w6X7GAUZE/MSjjAwcJ8MizzDzpYIyKQMQXr2hWwIzzpbWGOeyitE4XVo/lAoEmgOOBq3k8Qb/ykSOXz4/B8PoTAZ+NsclZG2OYMt1SbOHh3gExLp/2VZeCS/5Bb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBS97JLq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBS97JLq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1C11F000E9;
	Wed,  1 Jul 2026 13:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782913545;
	bh=S8DSeVuQyNC8Hz4SUNnccTet849D/qvRsM1nL5ddSGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dBS97JLqwZH+rA3QAEBzQIR4VbJTpAKQFqf+FyTRa5i7YYIcqtXRj3MOXy8RR5LAI
	 FbbmPlS3XCgARSMuwMEC1KS9iYYPJx0a2FhgbS4U+3E4+4e2tGVm6tI1FzRy+Og5o0
	 lKy3ipctk94FiCLWU8rhDdN62GlRHgZ3Il34N388xR89ZwFWwEzHw9JOj5VpBM2nie
	 Fkz1S/o5Ya5hNwN78BMQucUrz56bTK9i4B4zKGIFxX7vYx9kGumhwnnsdHaehsWK3I
	 dRiWodI0dS5H5y3YcWvB3k1dBWgboMgKudef/xJQL3xwN58eF2Wxt9XvZm7AW232xr
	 fuudovnneoh6Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [RFC PATCH 2/4] tracing/probes: Compile all fetchargs into a single BPF program per event
Date: Wed,  1 Jul 2026 22:45:41 +0900
Message-ID: <178291354144.1566898.14374948740441958770.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178291352217.1566898.14481561093843379745.stgit@devnote2>
References: <178291352217.1566898.14481561093843379745.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Compile all fetch arguments of a trace probe event into a single BPF
program instead of separate programs per argument to reduce prologue
and dispatching overhead.

BPF-compatible arguments (such as register, immediate, dereferences,
and raw stores) are compiled, including registers mapping for x86_64,
arm64, and s390. If any argument requires non-BPF operations (such as
dynamic strings), we fallback to the interpreter loop for all arguments.

Also, correctly initialize prog->len to prevent invalid opcode execution in
the BPF interpreter.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c      |  249 ++++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_probe.h      |   15 ++
 kernel/trace/trace_probe_tmpl.h |   13 ++
 3 files changed, 273 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 18c212122344..0deb53c22ae3 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2003,11 +2003,208 @@ static char *generate_probe_arg_name(const char *arg, int idx)
 	return name;
 }
 
+#ifdef CONFIG_BPF_SYSCALL
+#include <linux/filter.h>
+#include <linux/uaccess.h>
+
+static int regs_get_kernel_argument_offset(unsigned int n)
+{
+#ifdef CONFIG_X86_64
+	static const int argument_offsets[] = {
+		offsetof(struct pt_regs, di),
+		offsetof(struct pt_regs, si),
+		offsetof(struct pt_regs, dx),
+		offsetof(struct pt_regs, cx),
+		offsetof(struct pt_regs, r8),
+		offsetof(struct pt_regs, r9),
+	};
+	if (n < ARRAY_SIZE(argument_offsets))
+		return argument_offsets[n];
+#elif defined(CONFIG_ARM64)
+	if (n < 8)
+		return offsetof(struct pt_regs, regs[n]);
+#elif defined(CONFIG_S390)
+	if (n < 5)
+		return offsetof(struct pt_regs, gprs[2 + n]);
+#endif
+	return -1;
+}
+
+static bool trace_probe_can_compile_bpf(struct trace_probe *tp)
+{
+	int i;
+
+	if (tp->nr_args == 0)
+		return false;
+
+	for (i = 0; i < tp->nr_args; i++) {
+		struct probe_arg *parg = &tp->args[i];
+		struct fetch_insn *code = parg->code;
+
+		while (code->op != FETCH_OP_END) {
+			switch (code->op) {
+			case FETCH_OP_REG:
+			case FETCH_OP_IMM:
+			case FETCH_OP_DEREF:
+			case FETCH_OP_ST_RAW:
+			case FETCH_OP_ST_MEM:
+				break;
+			case FETCH_OP_ARG:
+				if (regs_get_kernel_argument_offset(code->param) < 0)
+					return false;
+				break;
+			default:
+				return false;
+			}
+			code++;
+		}
+	}
+	return true;
+}
+
+static void trace_probe_compile_bpf(struct trace_probe *tp)
+{
+	struct bpf_insn *insns;
+	int i = 0;
+	struct bpf_prog *prog;
+	int err, idx;
+
+	if (!trace_probe_can_compile_bpf(tp))
+		return;
+
+	insns = kmalloc_array(512, sizeof(struct bpf_insn), GFP_KERNEL);
+	if (!insns)
+		return;
+
+	/* Prologue: R6 = ctx */
+	insns[i++] = BPF_MOV64_REG(BPF_REG_6, BPF_REG_1);
+	/* R7 = ctx->rec */
+	insns[i++] = BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_6,
+				 offsetof(struct fetch_bpf_ctx, rec));
+	/* R8 = ctx->data */
+	insns[i++] = BPF_LDX_MEM(BPF_DW, BPF_REG_8, BPF_REG_6,
+				 offsetof(struct fetch_bpf_ctx, data));
+	/* R9 = total size (0) */
+	insns[i++] = BPF_MOV64_IMM(BPF_REG_9, 0);
+
+	for (idx = 0; idx < tp->nr_args; idx++) {
+		struct probe_arg *parg = &tp->args[idx];
+		struct fetch_insn *code = parg->code;
+
+		while (code->op != FETCH_OP_END && i < 500) {
+			switch (code->op) {
+			case FETCH_OP_REG:
+				/* R0 = *(unsigned long *)(R7 + code->param) */
+				insns[i++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, code->param);
+				break;
+			case FETCH_OP_ARG: {
+				int offset = regs_get_kernel_argument_offset(code->param);
+				/* R0 = *(unsigned long *)(R7 + offset) */
+				insns[i++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_7, offset);
+				break;
+			}
+			case FETCH_OP_IMM:
+				insns[i++] = BPF_LD_IMM64(BPF_REG_0, code->immediate);
+				break;
+			case FETCH_OP_DEREF:
+				/* Add offset: R3 = R0 + code->offset (src) */
+				insns[i++] = BPF_MOV64_REG(BPF_REG_2, BPF_REG_0);
+				if (code->offset)
+					insns[i++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_2,
+								   code->offset);
+				/* R1 = dst (R10 - 8 on stack) */
+				insns[i++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_10);
+				insns[i++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8);
+				/* R3 = size */
+				insns[i++] = BPF_MOV64_IMM(BPF_REG_3, sizeof(unsigned long));
+				/* Call copy_from_kernel_nofault(dst, src, size) */
+				insns[i++] = BPF_EMIT_CALL(copy_from_kernel_nofault);
+				/* if (R0 < 0) return R0; */
+				insns[i++] = BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 1);
+				insns[i++] = BPF_EXIT_INSN();
+				/* R0 = *(unsigned long *)(R10 - 8) */
+				insns[i++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_10, -8);
+				break;
+			case FETCH_OP_ST_RAW:
+				/* Store R0 into R8 (data) + parg->offset based on size */
+				switch (code->size) {
+				case 1:
+					insns[i++] = BPF_STX_MEM(BPF_B, BPF_REG_8, BPF_REG_0,
+								 parg->offset);
+					break;
+				case 2:
+					insns[i++] = BPF_STX_MEM(BPF_H, BPF_REG_8, BPF_REG_0,
+								 parg->offset);
+					break;
+				case 4:
+					insns[i++] = BPF_STX_MEM(BPF_W, BPF_REG_8, BPF_REG_0,
+								 parg->offset);
+					break;
+				case 8:
+					insns[i++] = BPF_STX_MEM(BPF_DW, BPF_REG_8, BPF_REG_0,
+								  parg->offset);
+					break;
+				}
+				break;
+			case FETCH_OP_ST_MEM:
+				/* Add offset: R2 = R0 + code->offset (src) */
+				insns[i++] = BPF_MOV64_REG(BPF_REG_2, BPF_REG_0);
+				if (code->offset)
+					insns[i++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_2,
+								   code->offset);
+				/* R1 = dst (R8 + parg->offset) */
+				insns[i++] = BPF_MOV64_REG(BPF_REG_1, BPF_REG_8);
+				if (parg->offset)
+					insns[i++] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_1,
+								   parg->offset);
+				/* R3 = size */
+				insns[i++] = BPF_MOV64_IMM(BPF_REG_3, code->size);
+				/* Call copy_from_kernel_nofault(dst, src, size) */
+				insns[i++] = BPF_EMIT_CALL(copy_from_kernel_nofault);
+				/* if (R0 < 0) return R0; */
+				insns[i++] = BPF_JMP_IMM(BPF_JSGE, BPF_REG_0, 0, 1);
+				insns[i++] = BPF_EXIT_INSN();
+				break;
+			default:
+				goto out;
+			}
+			code++;
+		}
+	}
+
+	if (i >= 500)
+		goto out;
+
+	/* Epilogue: return R9 (0) */
+	insns[i++] = BPF_MOV64_REG(BPF_REG_0, BPF_REG_9);
+	insns[i++] = BPF_EXIT_INSN();
+
+	prog = bpf_prog_alloc(bpf_prog_size(i), 0);
+	if (!prog)
+		goto out;
+
+	prog->len = i;
+	memcpy(prog->insnsi, insns, prog->len * sizeof(struct bpf_insn));
+	prog->type = BPF_PROG_TYPE_KPROBE;
+
+	prog = bpf_prog_select_runtime(prog, &err);
+	if (IS_ERR(prog))
+		goto out;
+	tp->prog = prog;
+
+out:
+	kfree(insns);
+}
+#endif
+
+/* Parse an argument */
+/* The caller must pass a null-terminated argument string */
 int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, const char *arg,
 			       struct traceprobe_parse_context *ctx)
 {
 	struct probe_arg *parg = &tp->args[i];
 	const char *body;
+	int ret;
 
 	ctx->tp = tp;
 	body = strchr(arg, '=');
@@ -2038,7 +2235,11 @@ int traceprobe_parse_probe_arg(struct trace_probe *tp, int i, const char *arg,
 	}
 	ctx->offset = body - arg;
 	/* Parse fetch argument */
-	return traceprobe_parse_probe_arg_body(body, &tp->size, parg, ctx);
+	ret = traceprobe_parse_probe_arg_body(body, &tp->size, parg, ctx);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 void traceprobe_free_probe_arg(struct probe_arg *arg)
@@ -2443,6 +2644,13 @@ void trace_probe_cleanup(struct trace_probe *tp)
 	for (i = 0; i < tp->nr_args; i++)
 		traceprobe_free_probe_arg(&tp->args[i]);
 
+#ifdef CONFIG_BPF_SYSCALL
+	if (tp->prog) {
+		bpf_prog_put(tp->prog);
+		tp->prog = NULL;
+	}
+#endif
+
 	if (tp->entry_arg) {
 		kfree(tp->entry_arg);
 		tp->entry_arg = NULL;
@@ -2531,15 +2739,32 @@ int trace_probe_register_event_call(struct trace_probe *tp)
 				  trace_probe_name(tp)))
 		return -EEXIST;
 
+#ifdef CONFIG_BPF_SYSCALL
+	trace_probe_compile_bpf(tp);
+#endif
+
 	ret = register_trace_event(&call->event);
-	if (!ret)
-		return -ENODEV;
+	if (!ret) {
+		ret = -ENODEV;
+		goto err_free_bpf;
+	}
 
 	ret = trace_add_event_call(call);
-	if (ret)
+	if (ret) {
 		unregister_trace_event(&call->event);
+		goto err_free_bpf;
+	}
 
 	return ret;
+
+err_free_bpf:
+#ifdef CONFIG_BPF_SYSCALL
+	if (tp->prog) {
+		bpf_prog_put(tp->prog);
+		tp->prog = NULL;
+	}
+#endif
+	return ret;
 }
 
 int trace_probe_add_file(struct trace_probe *tp, struct trace_event_file *file)
@@ -2768,5 +2993,21 @@ void trace_probe_dump_args(struct seq_file *m, struct trace_probe *tp)
 
 	for (i = 0; i < tp->nr_args; i++)
 		trace_probe_dump_arg(m, &tp->args[i]);
+
+#ifdef CONFIG_BPF_SYSCALL
+	if (tp->prog) {
+		seq_printf(m, "#  [BPF%s]:", tp->prog->jited ? "-JIT" : "");
+		for (i = 0; i < tp->prog->len; i++) {
+			struct bpf_insn *insn = &tp->prog->insnsi[i];
+
+			seq_printf(m, " %02x %02x %04x %08x", insn->code,
+				   insn->dst_reg | (insn->src_reg << 4),
+				   insn->off, insn->imm);
+			if (i < tp->prog->len - 1)
+				seq_putc(m, ',');
+		}
+		seq_putc(m, '\n');
+	}
+#endif
 }
 #endif /* CONFIG_PROBE_EVENTS_DUMP_FETCHARG */
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index e6268a8dc378..10589414451c 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -274,6 +274,9 @@ struct trace_probe {
 	ssize_t				size;	/* trace entry size */
 	unsigned int			nr_args;
 	struct probe_entry_arg		*entry_arg;	/* This is only for return probe */
+#ifdef CONFIG_BPF_SYSCALL
+	struct bpf_prog			*prog;
+#endif
 	struct probe_arg		args[];
 };
 
@@ -299,6 +302,7 @@ static inline void trace_probe_set_flag(struct trace_probe *tp,
 	smp_store_release(&tp->event->flags, tp->event->flags | flag);
 }
 
+
 static inline void trace_probe_clear_flag(struct trace_probe *tp,
 					  unsigned int flag)
 {
@@ -631,3 +635,14 @@ struct uprobe_dispatch_data {
 	struct trace_uprobe	*tu;
 	unsigned long		bp_addr;
 };
+
+#ifdef CONFIG_BPF_SYSCALL
+#include <linux/filter.h>
+
+struct fetch_bpf_ctx {
+	void *rec;
+	void *edata;
+	void *data;
+	void *base;
+};
+#endif
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index 8db12f758fda..6ca2dfe59a0f 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -273,6 +273,19 @@ store_trace_args(void *data, struct trace_probe *tp, void *rec, void *edata,
 	u32 *dl;	/* Data location */
 	int ret, i;
 
+#ifdef CONFIG_BPF_SYSCALL
+	if (tp->prog) {
+		struct fetch_bpf_ctx ctx = {
+			.rec = rec,
+			.edata = edata,
+			.data = data,
+			.base = base,
+		};
+		bpf_prog_run(tp->prog, &ctx);
+		return;
+	}
+#endif
+
 	for (i = 0; i < tp->nr_args; i++) {
 		arg = tp->args + i;
 		dl = data + arg->offset;

