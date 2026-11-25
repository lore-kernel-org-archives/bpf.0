Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=131.188.11.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795627563;
	b=x4C/kpiWsNkPvCBf2jt1s7geXXUEtpKXrPKKJW3z5wP2yhmIyWsBFFAMaAHDevrNbV+B
	 B6OKxI9d9la8GYRuzISy103f7G03WUSc4z9NSHIaGIGOyw/pAy+ih8f4RzgVMD2kvG2dA
	 ZDXB2lGcYC2641UdZOAa6EfRexPaTV9vEhLxv8Yw7MFyAIRLgD44jEPH1p4FB55skxOqQ
	 PiOlrXYf5W3vFlUfFHdWN/3KgnnFXmdJZnwfLDWcvb0Tfqg/Nrk/mBlBLlSyNcYw1L8sr
	 Fbu1JvKz1vpIePIyuyAMsrfZC973KkBZqyaESpsUoEcKKwppjBA3kh/+fxqR5Ep/JrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795627563;
	h=DMARC-Filter:DKIM-Signature:Received:X-Virus-Scanned:X-RRZE-Flag:
	 X-RRZE-Submit-IP:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7bqVY2Ko99LHinsxz7OiER/U69CTPh5CCd08W4Uyqjg=;
	b=hUl1aPaKadINf6afnuqdXpQt8AJ8IxBdcVum3VOUItBw/5pboGERMOERsBimp5p+MZh4
	 Y/zZOMITHJwA2DoxTdXfSLejqyQ4khrUgo4a+xzWsT7WXNM9QXO7EI+MIFTIkkKh2Mvap
	 8AwtFS59IBcQkOZa14U/2NdG5/2eXCI9YvyTdU2hZS369wSMlZkYtRvbjEIFBCLNu15MX
	 1ghGqA2nX3zY1GrY4sl6i/fXJxYVoudurbvor8gEwFhPWU6L9qmSZs4ZLTdngMIXyeAcr
	 6kLvYsmrFPFWMbCiulgh3nS4Ci0A095o/3Bcb3w/FezTAjYOpgw3MKPQvwjuTaOvKVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fau.de;
	spf=pass smtp.mailfrom=fau.de;
	dkim=pass header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=MaZR55iw;
	arc=none smtp.remote-ip=131.188.11.21
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0161B606A327;
	Wed, 25 Nov 2026 17:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0161B606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=MaZR55iw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1795627561; bh=7bqVY2Ko99LHinsxz7OiER/U69CTPh5CCd08W4Uyqjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
	 Subject;
	b=MaZR55iwBtQgQKT403zHfF0N9PQmzL7MyETmIPNfQE+rdXEwPp8Z03f85LiFdrH6d
	 j/ZILVvXcgPx47CiNZOqUtma1pCLnyzySJPhyoYx7B0bTlQyoRdmU/JIzv/9+fLDph
	 WGoGXLSysy8NO3IE/f6fvhzdO9J4kZW6Uova6BR2nRM/y13ZcmtKTlFhliSRaLkvHJ
	 boqQnMD1hGNgmLQLjx5N+K4NVb0WqKDkEO3IDIyhy3XhE4WUQSjfad5oHtCSiUPNxG
	 iqocqcuGapVbAjO09VaX3iX4Q3eHt1kuhHxIXKB1ceDeffFkEO9Esqm3Vncdzex8Uq
	 1+a13Fwyl/Xcg==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4jZRRF0h5KzPkpF;
	Wed, 25 Nov 2026 18:26:01 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck4.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:620:618:5b8:2:80b3:0:59e
Received: from luis-tp.epfl.ch (unknown [IPv6:2001:620:618:5b8:2:80b3:0:59e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX19dXUJDzYUT2O5yCwvtj0Bvthn1xg3zTf0=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4jZRR51S75zPkxb;
	Wed, 25 Nov 2026 18:25:53 +0100 (CET)
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
Subject: [PATCH bpf 3/4] bpf: Emit nospec after every insn with nospec_result
Date: Wed, 25 Nov 2026 18:12:51 +0100
Message-ID: <793677d276c8e0315ab4a9fb70178cd040d9bc97.1795625597.git.luis.gerhorst@fau.de>
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

check_stack_write_fixed_off() sets nospec_result of the insn that writes
to the stack if the store must not be bypassed speculatively. Besides a
BPF_MEM store, the insn can be a BPF_ATOMIC insn or a call: a helper or
kfunc that initializes a dynptr, an iterator or the flags of
bpf_local_irq_save() on the stack. But bpf_convert_ctx_accesses() emits
the nospec only after BPF_MEM stores.

This has two consequences for the other insns:

- Spectre v4: If the store is bypassed, what reads the slot behind the
  insn gets the old content of the slot: a load in the program, or a
  helper that is passed the slot as a dynptr.

- Spectre v1: do_check() ends a speculative path at an insn with
  nospec_result, because a nospec follows that insn. Without the
  nospec, the insns behind it are not verified for that path.

Emit the nospec after every insn with nospec_result, whatever the insn
is. Do this in a pass of its own, bpf_emit_nospec(), which runs before
bpf_convert_ctx_accesses(), and move the nospec in front of an insn
there too. The conversion of an insn no longer depends on nospec_result:
bpf_convert_ctx_accesses() used to skip an insn after it emitted the
nospec for it.

Both are inserted with bpf_insert_insns(), so that the insn keeps its
aux data for bpf_convert_ctx_accesses() and bpf_do_misc_fixups().

The pass is skipped if both Spectre v1 and v4 mitigations are bypassed,
because neither nospec nor nospec_result is set then. It only runs for
programs that are loaded without CAP_PERFMON: there it took at most
8.4 ms in our measurements, for a program of the maximum size of 1M
insns without any nospec, which is 0.4% of the 2.1 s that the program
takes to verify.

An insn that is only reached speculatively is rewritten to 'goto -1' by
sanitize_dead_code() and keeps nospec_result. It gets a nospec behind
it now, like it already gets one in front of it for nospec.

Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
Assisted-by: Claude:claude-mythos-5-2
Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
---
 include/linux/bpf_verifier.h |  1 +
 kernel/bpf/fixups.c          | 91 ++++++++++++++++++++++--------------
 kernel/bpf/verifier.c        |  3 ++
 3 files changed, 59 insertions(+), 36 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 2f9fa9d889a4..7dd71cef3f3a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -2029,6 +2029,7 @@ void bpf_opt_hard_wire_dead_code_branches(struct bpf_verifier_env *env);
 int bpf_opt_remove_dead_code(struct bpf_verifier_env *env);
 int bpf_opt_remove_nops(struct bpf_verifier_env *env);
 int bpf_opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env, const union bpf_attr *attr);
+int bpf_emit_nospec(struct bpf_verifier_env *env);
 int bpf_convert_ctx_accesses(struct bpf_verifier_env *env);
 int bpf_jit_subprogs(struct bpf_verifier_env *env);
 int bpf_fixup_call_args(struct bpf_verifier_env *env);
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 485feffe0536..d5faaf3233c8 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -940,7 +940,6 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 	const struct bpf_verifier_ops *ops = env->ops;
 	int i, cnt, size, ctx_field_size, ret, delta = 0, epilogue_cnt = 0;
 	const int insn_cnt = env->prog->len;
-	const struct bpf_insn nospec = BPF_ST_NOSPEC();
 	struct bpf_insn *epilogue_buf = env->epilogue_buf;
 	struct bpf_insn *insn_buf = env->insn_buf;
 	struct bpf_insn *insn;
@@ -1022,25 +1021,6 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 		enum bpf_reg_type ptr_type;
 		u8 mode;
 
-		if (env->insn_aux_data[i + delta].nospec) {
-			WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_state);
-
-			new_prog = bpf_insert_insns(env, i + delta, &nospec, 1,
-						    BPF_INSERT_BEFORE);
-			if (IS_ERR(new_prog))
-				return PTR_ERR(new_prog);
-
-			delta    += 1;
-			env->prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			/* This can not be easily merged with the
-			 * nospec_result-case, because an insn may require a
-			 * nospec before and after itself. Therefore also do not
-			 * 'continue' here but potentially apply further
-			 * patching to insn.
-			 */
-		}
-
 		if (insn->code == (BPF_LDX | BPF_MEM | BPF_B) ||
 		    insn->code == (BPF_LDX | BPF_MEM | BPF_H) ||
 		    insn->code == (BPF_LDX | BPF_MEM | BPF_W) ||
@@ -1104,22 +1084,6 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			continue;
 		}
 
-		if (type == BPF_WRITE &&
-		    env->insn_aux_data[i + delta].nospec_result) {
-			/* nospec_result is only used to mitigate Spectre v4 and
-			 * to limit verification-time for Spectre v1.
-			 */
-			new_prog = bpf_insert_insns(env, i + delta, &nospec, 1,
-						    BPF_INSERT_AFTER);
-			if (IS_ERR(new_prog))
-				return PTR_ERR(new_prog);
-
-			delta    += 1;
-			env->prog = new_prog;
-			insn      = new_prog->insnsi + i + delta;
-			continue;
-		}
-
 		ptr_type = env->insn_aux_data[i + delta].ptr_type;
 		switch ((int)ptr_type) {
 		case PTR_TO_CTX:
@@ -1862,6 +1826,61 @@ static int may_goto_expand_timed(struct bpf_insn *insn_buf, int off,
 	return cnt;
 }
 
+/*
+ * Emit the speculation barriers that do_check() asked for:
+ *
+ * - nospec: a nospec in front of the insn. It is set if the insn failed a
+ *   check on a speculative path.
+ *
+ * - nospec_result: a nospec behind the insn. It is only used to mitigate
+ *   Spectre v4 and to limit verification-time for Spectre v1. It is set for a
+ *   store to the stack, whatever the insn that stores is: BPF_ST, BPF_STX
+ *   including BPF_ATOMIC, or a call of a helper or kfunc.
+ *
+ * An insn may require both. The insn keeps its aux data, so this has to run
+ * before the passes that rewrite the insn itself: what they emit for the insn
+ * stays between the two nospec.
+ */
+int bpf_emit_nospec(struct bpf_verifier_env *env)
+{
+	const struct bpf_insn nospec = BPF_ST_NOSPEC();
+	struct bpf_prog *new_prog;
+	int i;
+
+	/* Neither of the two is set without the mitigations. */
+	if (env->bypass_spec_v1 && env->bypass_spec_v4)
+		return 0;
+
+	if (bpf_prog_is_offloaded(env->prog->aux))
+		return 0;
+
+	for (i = 0; i < env->prog->len; i++) {
+		if (env->insn_aux_data[i].nospec) {
+			WARN_ON_ONCE(env->insn_aux_data[i].alu_state);
+
+			new_prog = bpf_insert_insns(env, i, &nospec, 1, BPF_INSERT_BEFORE);
+			if (IS_ERR(new_prog))
+				return PTR_ERR(new_prog);
+
+			env->prog = new_prog;
+			/* the insn and its aux data are behind the nospec now */
+			i++;
+		}
+
+		if (env->insn_aux_data[i].nospec_result) {
+			new_prog = bpf_insert_insns(env, i, &nospec, 1, BPF_INSERT_AFTER);
+			if (IS_ERR(new_prog))
+				return PTR_ERR(new_prog);
+
+			env->prog = new_prog;
+			/* skip the nospec */
+			i++;
+		}
+	}
+
+	return 0;
+}
+
 /* Do various post-verification rewrites in a single program pass.
  * These rewrites simplify JIT and interpreter implementations.
  */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 13c53df386bc..aa73c3326d39 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24220,6 +24220,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 			sanitize_dead_code(env);
 	}
 
+	if (ret == 0)
+		ret = bpf_emit_nospec(env);
+
 	if (ret == 0)
 		/* program is valid, convert *(u32*)(ctx + off) accesses */
 		ret = bpf_convert_ctx_accesses(env);
-- 
2.56.1

