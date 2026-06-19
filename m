Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB5F3CFF50
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781902802; cv=none; b=FMniGJe/w/hyT5DYiI2mNHD92xo3oZhhIOPr8fk5at8U92EG1Wf5KGe4IeJA5Mi+FOsMmmPmIvNt4roABmZAeCCTPLHQj5IHA9GVeLV59Sao/97kzTcOoMZ3CeoPhjn2jmLRp3lUcsLjxl6qj4BpRzDZJfY3KK4bBGdZT9ymOyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781902802; c=relaxed/simple;
	bh=r36pksIoDp3ENAbRDBjfjDampdEL+0CblPbGWJa2Cus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kALuH/Qwq7TKgDDaOf/1JkZqsReh47KgtQBzze5thrbpoViDHFuPGMXHkhjNktLie/ubAgfzczvw0V4TbCuBkM2ddG9U57mkYRY8m+7DCPPwivSPJEF5wXIPF1xsRRfxPWx2/ruiH15peIV1VueWnvuziy9ednJB+Ks1VvLeuOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjFgJMKK; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjFgJMKK"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-4629d80fa08so2411401f8f.3
        for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 13:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781902789; x=1782507589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flm8qMMgFgbomtHC8TQeBz1ZG4Munmu6pOlhtW7lS3E=;
        b=AjFgJMKKXDAo3oE+ZIbfRt0pCqh55BfVfQIp0mXftEfU6PKCjfn1mHMCZquXjUa9A/
         OumbttlxzUOJOukn0GOMsUe2mKHzs/q+vMwa0SkJsR+jnxCfaGB3h+xIqTraAh0nk+Ga
         8guqSAvzSt4UXReYF0mFHfjQmCgQekDuy8q/N+Rv0HEv2DhVd2z3Q2VjOUcMrWyIh6H1
         Hs/xUKoJAdZv3kw+fpwOevxJDIL45ReTLTa4eTVfcJ9hPEfx6aScnq3D2AUVuZMTOF1w
         CLQ7X7dfrlBMMwnN0Mp/PD6yfRMP9TxqouKm1OSrbHsWVB/GTGB2xQRQu5ixei25zzbU
         pcxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781902789; x=1782507589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=flm8qMMgFgbomtHC8TQeBz1ZG4Munmu6pOlhtW7lS3E=;
        b=RR5/N7v+DMHbGdJjMS1taZck4frO2Qz6U9xJ1Q63YBqU6l32bYP49x8DhOrVbWHTj1
         GhuYkQB2YeB9nfH2yIdUsd8aJLl8euG8GimpO/pXHTHGAuu0tcjEoKjTobfJB69e2ZpL
         IadFo2bARmZGpOLztXxqYG2OMdSiBBUS27BbzInCl1HXKLpT6tPtfEtxEDOnyejhVeuV
         a6PvZAEJoKcm9J+GwJOCGHXZdvYEjKAPIW74lfvEr/abQeIbwTy/mSe0jSm2R24lRKQT
         jKyQIB8RYQaBxgq77EmjwuEtMUuopbS0kPU/6CtAEEScAYLyRmeDzLqGIioIWlsYv4om
         zIRA==
X-Gm-Message-State: AOJu0YyCsdQkiUOIpPlYKun/qmnbpivhJdaYhfXMPW/UgRG9y+eUkZcv
	v0ENG+oVRKaVKRBabaoFToiypS3MLvg+sSQVAqvUpXj086N6ROJBQW2RXUNhFExk
X-Gm-Gg: AfdE7ckAyW4d+n7iT696Xhp/Q5ZN5WJHqyRIGvCtnWerLbJh0Ue8E4mi6VulGyYa7F6
	hOSNJpXSBEbBKZ5n3aAomPzK+PkbIrbFMDtkIpapDJ0PBEytChIXY6bwCQpm8h1L/DVUT/W1BVL
	9D8T13TQEaAqSfYmMcCGhfrx5C7DeA9fWWlzvQYBCBxKDS+xEvPHMAPXyLymh89ZOrtGd0HU7bh
	f1Z+KIl5CfuUWsq5TIobY/QHEs2I14cqyo5hKu/P0XCKKAaLjbxK68hOFNXuAbR/GgfDMhI6bmj
	AvFXxVpEXzLTPTLKjnAdPLm3PsDo4KhvegLTWPbFZ44dB+ExeNroCsXh+s3MhdsJA5i5qhmPGCO
	o8qYz8o4r1LjNJ+fNU+XTUmV1SeRSmnhZxLBo+qR3gs8fMwOvUXvxTdAd3vGqKEMnIk0WcXPC82
	FAYVerkH9kk3dPwWYYRhIRPb+rUI4fekSJFQAHOGgB5+Xp8feug2QK1t7RcObEs83iUmwZEjIKy
	kwUC5shkLIkzsLqcoI3he4NHqnHnzINMtQ/V2+7KEZMIISzV2jeAvs=
X-Received: by 2002:a5d:420d:0:b0:43f:e721:76b8 with SMTP id ffacd0b85a97d-46508afa8f6mr6624666f8f.37.1781902788546;
        Fri, 19 Jun 2026 13:59:48 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-466648c5de7sm1715555f8f.15.2026.06.19.13.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 13:59:48 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 13/17] bpf: Report Program Structure CFG errors
Date: Fri, 19 Jun 2026 22:59:26 +0200
Message-ID: <20260619205934.1312876-14-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619205934.1312876-1-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9254; i=memxor@gmail.com; h=from:subject; bh=r36pksIoDp3ENAbRDBjfjDampdEL+0CblPbGWJa2Cus=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIct0FWOmS+MGNpXDvu6MX/fJyajOupXktXtOY3WkFatJe 1LTkoMdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmIhXM8P/+OKXCXKV6V/MeX5/ 7W1ie9P79E3w+1inDwLREcUBF+2sGBlmW/stYfpQtub5mzdy1Tc2ulz8oqjrxi/e18Z45bP61Qk MAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected subprogram CFG validation failures with Program Structure
reports. These errors are structural rather than path-dependent, so the report
focuses on source and instruction context instead of causal history.

Cover jumps that leave the current subprogram, subprograms whose last
instruction can fall through into the next subprogram, and recursive bpf2bpf
call graph edges.

Format long jump-range reasons directly in diagnostics.c, and keep the
fallthrough suggestion aligned with the verifier check by suggesting exit or
explicit jumps.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/cfg.c         | 39 +++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.c | 21 +++++++++++++++++++++
 kernel/bpf/diagnostics.h |  5 +++++
 kernel/bpf/verifier.c    | 16 ++++++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 26d37066465f..032b3dc56f2e 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -5,6 +5,8 @@
 #include <linux/filter.h>
 #include <linux/sort.h>
 
+#include "diagnostics.h"
+
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
 /* non-recursive DFS pseudo code
@@ -113,6 +115,11 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 	if (w < 0 || w >= env->prog->len) {
 		verbose_linfo(env, t, "%d: ", t);
 		verbose(env, "jump out of range from insn %d to %d\n", t, w);
+		bpf_diag_report_program_structure(env, t,
+						  "jump out of range",
+						  "Keep branch targets inside the program.",
+						  "Instruction %d jumps to instruction %d, but the program only contains instructions 0 through %d.",
+						  t, w, env->prog->len - 1);
 		return -EINVAL;
 	}
 
@@ -136,6 +143,11 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 		verbose_linfo(env, t, "%d: ", t);
 		verbose_linfo(env, w, "%d: ", w);
 		verbose(env, "back-edge from insn %d to %d\n", t, w);
+		bpf_diag_report_program_structure(env, t,
+						  "back-edge is not allowed",
+						  "Rewrite the control flow as a verifier-supported bounded loop, or load with privileges that allow this back-edge.",
+						  "Instruction %d branches back to instruction %d. This program is being rejected without the privilege needed for this back-edge.",
+						  t, w);
 		return -EINVAL;
 	} else if (insn_state[w] == EXPLORED) {
 		/* forward- or cross-edge */
@@ -316,6 +328,11 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
 
 	if (!jt) {
 		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
+		bpf_diag_report_program_structure(env, subprog_start,
+						  "missing jump table",
+						  "Provide a jump table whose entries target this subprogram.",
+						  "No jump table was found for the subprogram that starts at instruction %u.",
+						  subprog_start);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -343,6 +360,12 @@ create_jt(int t, struct bpf_verifier_env *env)
 		if (jt->items[i] < subprog_start || jt->items[i] >= subprog_end) {
 			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]\n",
 					t, subprog_start, subprog_end);
+			bpf_diag_report_program_structure(env, t,
+							  "jump table target out of range",
+							  "Keep every jump-table target inside the same subprogram.",
+							  "The jump table for instruction %d points outside subprogram range [%u,%u).",
+							  t, subprog_start,
+							  subprog_end);
 			kvfree(jt);
 			return ERR_PTR(-EINVAL);
 		}
@@ -374,6 +397,12 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
 		w = jt->items[i];
 		if (w < 0 || w >= env->prog->len) {
 			verbose(env, "indirect jump out of range from insn %d to %d\n", t, w);
+			bpf_diag_report_program_structure(env, t,
+							  "indirect jump out of range",
+							  "Keep indirect jump targets inside the program.",
+							  "Instruction %d can jump indirectly to instruction %d, but the program only contains instructions 0 through %d.",
+							  t, w,
+							  env->prog->len - 1);
 			return -EINVAL;
 		}
 
@@ -624,12 +653,22 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 
 		if (insn_state[i] != EXPLORED) {
 			verbose(env, "unreachable insn %d\n", i);
+			bpf_diag_report_program_structure(env, i,
+							  "unreachable instruction",
+							  "Remove the unreachable instruction or add valid control flow that reaches it.",
+							  "Instruction %d is not reachable from the program entry point.",
+							  i);
 			ret = -EINVAL;
 			goto err_free;
 		}
 		if (bpf_is_ldimm64(insn)) {
 			if (insn_state[i + 1] != 0) {
 				verbose(env, "jump into the middle of ldimm64 insn %d\n", i);
+				bpf_diag_report_program_structure(env, i,
+								  "jump into ldimm64 immediate",
+								  "Target the first instruction of the ldimm64 pair, or restructure the jump target.",
+								  "Control flow reaches the second half of the ldimm64 instruction pair that starts at instruction %d.",
+								  i);
 				ret = -EINVAL;
 				goto err_free;
 			}
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 7c903e502973..d6893b2626c4 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1118,6 +1118,27 @@ void bpf_diag_report_context_underflow(struct bpf_verifier_env *env,
 	bpf_diag_report_suggestion(env, "%s", suggestion);
 }
 
+void bpf_diag_report_program_structure(struct bpf_verifier_env *env,
+				       u32 insn_idx, const char *problem,
+				       const char *suggestion,
+				       const char *reason_fmt, ...)
+{
+	va_list args;
+
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_PROGRAM_STRUCTURE,
+			       problem);
+	bpf_diag_report_section(env, "Reason");
+
+	va_start(args, reason_fmt);
+	bpf_diag_vprint_indented(env, reason_fmt, args);
+	va_end(args);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "%s", problem);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
 				   int regno, const char *reg_name,
 				   const char *type_name,
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 4611d94e7a18..b881ccaf6deb 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -216,6 +216,11 @@ void bpf_diag_report_context_underflow(struct bpf_verifier_env *env,
 				       u32 insn_idx, const char *operation,
 				       enum bpf_diag_context_kind ctx_kind,
 				       const char *suggestion);
+void bpf_diag_report_program_structure(struct bpf_verifier_env *env,
+				       u32 insn_idx, const char *problem,
+				       const char *suggestion,
+				       const char *reason_fmt, ...)
+		__printf(5, 6);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx,
 			    bool cond_true);
 void bpf_diag_record_reg_mod(struct bpf_verifier_env *env, u32 insn_idx,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3174e12bea9a..e923366c6fdb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2938,6 +2938,13 @@ static int check_subprogs(struct bpf_verifier_env *env)
 		off = i + bpf_jmp_offset(&insn[i]) + 1;
 		if (off < subprog_start || off >= subprog_end) {
 			verbose(env, "jump out of range from insn %d to %d\n", i, off);
+			bpf_diag_report_program_structure(env, i,
+							  "jump out of range",
+							  "Keep branch targets within the same subprogram, or use an explicit subprogram call.",
+							  "Instruction %d jumps to instruction %d, but subprogram %d only contains instructions %d through %d. A branch target must stay inside the same subprogram.",
+							  i, off, cur_subprog,
+							  subprog_start,
+							  subprog_end - 1);
 			return -EINVAL;
 		}
 next:
@@ -2950,6 +2957,11 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			    code != (BPF_JMP32 | BPF_JA) &&
 			    code != (BPF_JMP | BPF_JA)) {
 				verbose(env, "last insn is not an exit or jmp\n");
+				bpf_diag_report_program_structure(env, i,
+								  "subprogram can fall through",
+								  "End each subprogram with an exit or an explicit jump that keeps control flow inside the subprogram.",
+								  "Subprogram %d reaches its last instruction %d without an exit or jump, so control could continue into the next subprogram.",
+								  cur_subprog, i);
 				return -EINVAL;
 			}
 			subprog_start = subprog_end;
@@ -3022,6 +3034,10 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 					verbose(env, "recursive call from %s() to %s()\n",
 						subprog_name(env, cur),
 						subprog_name(env, callee));
+					bpf_diag_report_program_structure(env, idx,
+									  "recursive subprogram call",
+									  "Rewrite the recursion as an explicit bounded loop, or split the logic so subprogram calls do not form a cycle.",
+									  "This bpf2bpf call would make the subprogram call graph recursive. The verifier requires a finite, acyclic call graph so it can bound stack depth and analysis.");
 					ret = -EINVAL;
 					goto out;
 				}
-- 
2.53.0

