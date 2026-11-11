Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794401855;
	b=nFfjM7h6pnPpocJW8KGKS6djIjBgdX+mGZO+/KNOxYb8DKIHp5RxNHb1kmgZgb8qAzOg
	 kD3xDsU5Dyo7dQgRDkMj6ZtABvjsXUk2WK9yJzvqkDbv2KCZjUJuFKw8Ak+3UBo2qByXf
	 c6xqHiGqa2Ens2WuvFg0Opg8OCletprXzvL9/B8oIbnq8+SOEX2LfxDketn9OlMzCFS4+
	 yrVunsHGDmTvsnJ/1FAX8uyx+cdyom0go2tDzMjy84/oiED80opp3zjvRrYcJSMgv2/lz
	 k/Iruqmmj0eMI9E3lcUNK8MU/XNSuJtf4kVCzzLAnWCOcbu6EXFG/mUt2+K8rcmxc5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794401855;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding;
	bh=gN1El3wcrpzhEdJvGKJ56YDJ/R8rYv/FYXbaXKckbwg=;
	b=HJNGt6QISEnhotCabDQUBKqeMhWExdR2yeSVj2EZkCq/Pr1ecfr50VYDf8LPa7WO9ePB
	 CeFX08QT+V+DJH0xfucN3fFuZS7nNquL/9ggA3s+cUjYc+SDL2OE1FUGrjnfRw4iUaqGq
	 3W2A/Z2QYvJhHzPIF6muXiPm/f+G6Jn3bvFxxZRVPTBrvDhIHkzpcHj/UDxmPRFOBJFb5
	 7FELh2l58MGp53SGqByHxmCJ9GAClq+a/YBO6ZqzbasETJbRkLf2OGbaI3KuIxudcjpma
	 cillqNebVGsY8Zsaes5bXhTYABEswiKOcCBRXNaWFF1A4gKVJLUpAgbdi6WI5eDyw/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tNXD0KUg;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E511606A32D
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E511606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tNXD0KUg
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-4b886ebe069so10203985e9.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 04:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794401854; x=1795006654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gN1El3wcrpzhEdJvGKJ56YDJ/R8rYv/FYXbaXKckbwg=;
        b=tNXD0KUgUi53wkwTqYtDW9OohvegTdAZQ+QusyIWsMYs4sKLSuuJfvFzMnExNGj4GM
         7F02I8CQWMm32UvIO+rHMasriD3eCg76mojRpmbj5dC02i00R4CpqRtzekVAp5QxDMpA
         E0uWYLOgNozX1MYXEAy5w03wbBE6+H8Vu8RT50qPMY236vDa4xxr+IrPFjvcJv2v6ktB
         LgN4x0EEe7yWqzkNYGt5r5cEMWom2DTnHU+mzWFQ1kIgxxvKDKX3lPI52T6DegYNR2FQ
         e2OHkSddo0hHQKpnzk2XjSke0UGeQqO8XPLW9RSLiij2MnBnQC0plK3frpUh+0DfnN4f
         zkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794401854; x=1795006654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gN1El3wcrpzhEdJvGKJ56YDJ/R8rYv/FYXbaXKckbwg=;
        b=PJB8GIkhuTrzzFuuONLBbJVK7KFNXOgRYNtXRtQJMlGrX2w1xkPHicMcIMFZYtJdnk
         S99bG6YIWpf8AY3KL5xU0/v8NEBzXUIHWQV+H54+XUg00o1uTudwLvk6nFraBj/Zya7z
         jFKDAHOpTQJ8z8GA4pAq0ZOI/1LkPv+QqQixYqjdk0rsxAJ+R2CnVIhuugUI6Xj99uXu
         eDhacpcREb3tRXeYXrjaurZ0TbuOn0v0kG5DuDBRarbcdBKob3nZSTfIjvDribC/veed
         FA+NWO0Gc3Z/lHV5YLdG+DIX3HpNJjGG2F9vuxfjr8uHDzqyms6XQMv8/eAOY+oHMHDA
         TN2A==
X-Gm-Message-State: APuU4Z/MEMIACi/MUyDlyVvzcWGRDceen0JfORjy/j6GYoM+CtquAket
	/LEx8g6mOCQZC/+SqTJ6/dkT805wdPdL+LVXJ4WI8E8+PQVnghaXp4vmYihHoINZLV4=
X-Gm-Gg: AYBFou1THy5kzlVcq8RKIS9gL7b2uOe5eGL+NpxQh5tdWtdQpzh9AgijJAdK50Hu3Ti
	38PJWyVc4MqDEvnKQzTtdvhzvqV+zQahvHbEAQWxLXV2zNIMbqu0fVa4Skyy0t+Ffh9VHPiV9b9
	gGOL68/mpfHFPBeTxxDV5DjKV17l333yh2TWNbp+OhxMuKWYVAfsJwf9TpWJhv1xt5cDIOxVX4K
	7NNGALWPv6LXghsdvfNvM8oh+iHMHSdjh0SqbdHKOckpchX76ncYAfC9ATfYBYQsdtycOi+VbSr
	TnryW9rwTpKjjVMpZifUoauqNaMlC3x4L5rJxXFc7FG3j3ev9MQB5X5Q19pXgO2VZxoRII8oQd0
	XTHrNTTcGELRyCxvqKhewXZ7ovEeynRf5yF+MRbvwvybp0UgXvVPfs8+vesUzO6fu+9UWP/lrei
	WcCc/ytAsb3eoBAAj1lbExtRJQ0ISABUbaOz3rgZQ6qY0bu/o108OMiLQRuWwaVlG62HVjL5DS6
	oA3bcS/WzMXp4lcwxPLbNEjMm6DfXSBaFYv7nXEvw8J/KxdPxxivA1fC9OC1mH/YKWMo1UElz9b
	5AyFwSOm7+uduQkVDhp0T+GY4oT3zA+QKvb88S3a3ucLLePlDqT2fxNKvFjtNYTace9keDQXFCL
	CRwsNqmqRKdKEVwU9h7TbH7E5nuMGZJ2Hnmi5V4gvn/ycXnYoIOV+yDcdFfZnfVz05udS
X-Received: by 2002:a05:600c:4f84:b0:4ac:da92:2bd4 with SMTP id 5b1f17b1804b1-4ba0931d9eamr40035915e9.1.1794401853389;
        Wed, 11 Nov 2026 04:57:33 -0800 (PST)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0204784esm176553385e9.10.2026.11.11.04.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:57:32 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 01/29] bpf: Record where JITs save callee-saved registers
Date: Wed, 11 Nov 2026 13:56:59 +0100
Message-ID: <113211473688142e3ef1df6780d35a460a0e7b23.1794399387.git.memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6824; i=memxor@gmail.com; h=from:subject:message-id; bh=2xc8Q4NmzqD1okgKGw4aCwebGKJ2P0+pCL10iflpiqQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIetLzOyy163K9/6xLlTknSOqaSCbquxtuy/vre3deYy82 ZdFZ3p1lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLSmQz//bcXLLN0XWCz6KWA eukLvYp5G9Wn9Vnt/XP/VfeHM/9UPRj+ad5S3qm420vtgLio8sWHSY78FTzxhtJt87+6/fh8b1o xKwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Currently bpf_throw() discards the frames between the throw site and the
main program without running their epilogues. The main program restores
the callee-saved registers that these frames clobbered: its prologue
saves all of them, and the exception callback pops them.

To restore the registers from the discarded frames instead, the unwinder
must know where each JITed function saved the R6-R9 of its caller.
Walking outwards from the throw site, a register is either:

 - still in the physical register, if no inner frame saved it; or
 - in the prologue save area of the nearest inner frame that saved it.

Add callee_reg_off[4] to struct bpf_prog_aux. Each element is the offset
of a saved register from the native frame pointer that
arch_bpf_stack_walk() reports for the frame, or 0 if the register is not
saved. The x86-64 and arm64 JITs fill it in. Nothing uses it yet.

On x86-64 the frame holds, below rbp from high to low addresses:

 - the program stack of round_up(stack_depth, 8) bytes, or nothing with a
   private stack;
 - the tail call count and its pointer, when tail_call_reachable;
 - r12, when the program is an exception boundary or uses an arena;
 - rbx, r13, r14 and r15 in push order, each only if it is pushed. An
   exception boundary pushes all four.

On arm64:

 - the frame record is at x29, and the tail call count pair is right
   below it;
 - the callee-saved registers follow as 16 byte pairs, in the order that
   find_used_callee_regs() lists them, with the first register of a pair
   at the lower address. The i-th pushed register is therefore at
   -32 - 16 * (i / 2) + 8 * (i % 2);
 - an exception boundary pushes x19-x28 in order, so R6-R9 take the first
   four slots.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 arch/arm64/net/bpf_jit_comp.c | 37 +++++++++++++++++++++++++++++++++++
 arch/x86/net/bpf_jit_comp.c   | 33 +++++++++++++++++++++++++++++++
 include/linux/bpf.h           |  6 ++++++
 3 files changed, 76 insertions(+)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index b8d765d6ab07..83a858c6d472 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -854,6 +854,42 @@ static void find_used_callee_regs(struct jit_ctx *ctx)
 	ctx->nr_used_callee_reg = i;
 }
 
+/*
+ * Offset from the frame pointer of the @idx-th register pushed by push_callee_regs(). The
+ * frame record sits at the frame pointer, the tail call count pair right below it, and
+ * then the pushed pairs, each 16 bytes with its first register at the lower address.
+ */
+static int callee_reg_slot_off(int idx)
+{
+	return -32 - 16 * (idx / 2) + 8 * (idx % 2);
+}
+
+/*
+ * Record where push_callee_regs() saved the caller's R6..R9, relative to the frame
+ * pointer that arch_bpf_stack_walk() reports for this frame, for the exception unwinder.
+ * An exception boundary pushes x19..x28 in order, so R6..R9 take the first four slots.
+ */
+static void record_callee_reg_off(struct jit_ctx *ctx)
+{
+	struct bpf_prog_aux *aux = ctx->prog->aux;
+	int i, j;
+
+	if (aux->exception_boundary) {
+		for (i = 0; i < 4; i++)
+			aux->callee_reg_off[i] = callee_reg_slot_off(i);
+		return;
+	}
+	for (i = 0; i < 4; i++) {
+		aux->callee_reg_off[i] = 0;
+		for (j = 0; j < ctx->nr_used_callee_reg; j++) {
+			if (ctx->used_callee_reg[j] != bpf2a64[BPF_REG_6 + i])
+				continue;
+			aux->callee_reg_off[i] = callee_reg_slot_off(j);
+			break;
+		}
+	}
+}
+
 /* Save callee-saved registers */
 static void push_callee_regs(struct jit_ctx *ctx)
 {
@@ -884,6 +920,7 @@ static void push_callee_regs(struct jit_ctx *ctx)
 			emit(A64_PUSH(reg1, A64_ZR, A64_SP), ctx);
 		}
 	}
+	record_callee_reg_off(ctx);
 }
 
 /* Restore callee-saved registers */
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 5bc744c42f7f..19fef39f1445 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -382,6 +382,24 @@ static void pop_callee_regs(u8 **pprog, bool *callee_regs_used)
 	*pprog = prog;
 }
 
+/*
+ * Record where push_callee_regs() saved the caller's R6..R9 relative to rbp, for the
+ * exception unwinder. @off is the offset of rsp from rbp right before the first push.
+ */
+static void record_callee_reg_off(struct bpf_prog *prog, s32 off, bool *callee_regs_used)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		if (!callee_regs_used[i]) {
+			prog->aux->callee_reg_off[i] = 0;
+			continue;
+		}
+		off -= 8;
+		prog->aux->callee_reg_off[i] = off;
+	}
+}
+
 /* add rsp, depth */
 static void emit_add_rsp(u8 **pprog, u32 depth)
 {
@@ -2402,6 +2420,7 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 	/* it has to be saved around calls of helpers and kfuncs */
 	bool arena_sp_save = arena_sp && calls_clobber_arena_sp(bpf_prog);
 	s32 arena_sp_off = 0;
+	s32 callee_regs_off;
 	int err;
 
 	stack_depth = bpf_prog->aux->stack_depth;
@@ -2472,6 +2491,20 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 		push_callee_regs(&prog, callee_regs_used);
 	}
 
+	/*
+	 * Record where the pushes above saved the caller's R6..R9, relative to the
+	 * rbp that arch_bpf_stack_walk() reports for this frame. Below rbp lie, from
+	 * high to low addresses: round_up(stack_depth, 8) bytes of program stack
+	 * (none with a private stack), the tail call count and its pointer (16 bytes)
+	 * when tail_call_reachable, r12 when exception_boundary or arena_vm_start,
+	 * and then rbx, r13, r14 and r15 in push order, each only when pushed.
+	 */
+	callee_regs_off = -(s32)round_up(stack_depth, 8) - (tail_call_reachable ? 16 : 0);
+	if (bpf_prog->aux->exception_boundary || arena_vm_start)
+		callee_regs_off -= 8;
+	record_callee_reg_off(bpf_prog, callee_regs_off,
+			      bpf_prog->aux->exception_boundary ? all_callee_regs_used : callee_regs_used);
+
 	/* Compute callee-saved register area size. */
 	callee_saved_size = 0;
 	if (bpf_prog->aux->exception_boundary || arena_vm_start)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 520fd72e21fd..da42dbd32fd4 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1997,6 +1997,12 @@ struct bpf_prog_aux {
 	u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
 	u16 stack_arg_sp_adjust;
 	u16 freplace_link_cnt; /* counts freplace links extending this prog */
+	/*
+	 * Offsets from the native frame pointer of this JITed program at which
+	 * its prologue saved the caller's R6..R9, or 0 when that register is not
+	 * saved. Filled by the JIT; consumed by the exception unwinder.
+	 */
+	s16 callee_reg_off[4];
 #ifdef CONFIG_SECURITY
 	void *security;
 #endif
-- 
2.53.0

