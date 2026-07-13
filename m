Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C703431E6D
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957172; cv=none; b=cB0ysmSYcgCepf1V+3nrpvpytZwvGfQK9+cq7QXvRmgfomy0oi3YO4LJHO6bLWeYDWXoDDjag6doQK1v7W1X0sHH6EKWBAbLGkf7v03cheLATbVR4ZqoxMO+udfe39VNMsUBLpt5pHptvA69RFK94nvw8zPgdiCThBpYIy+oSis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957172; c=relaxed/simple;
	bh=d355m5fUPG85gJ5L29ZwbV1tZP33ksTIwmChRH9OLJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1xsUGUQ09iuNpxabvY/BFAKy+oZtIwRplsTnwcDdeG0WR5VUPR1AY2KgBUKav6vR+2JvxncKEu3vNGadzQ/ZW4NUIehJYBnx5hwBEpuDvSBPQt460pwlqsVLTZpqRwK0dwTnqor95w3Qn2vkuGAUdlD758oJAGc3FQyhNKgGhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mutOqp/N; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mutOqp/N"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-47301772842so1798459f8f.0
        for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 08:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783957169; x=1784561969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4jeSK203ZaFxCazvnYe+W9jric1EDdx+LJQMmm4pnTs=;
        b=mutOqp/NEFGPznLpPZB1FcSqHiOgVtwdnCz7AVj8yn3gAoGU8E+I2LwsROUNkUsUP7
         12hYkvFBjbHMxZYZBgvomiGZdIeRzRsR/zWJEmNCTEKoa1Wm5QWiFP/N1du0gaAmEXhp
         njbGamqirNskFKqSPymZZTWu7leebqXMlTOYGljylHppB4DQqeIAXhI/MKvRjh+rjo1C
         l0rD89Y6lMfky+Tx7LvYaCS3bdqvpb/qcfXra7tnSXj4k38pLoI7US8mK5b6PimJ9gcY
         IEOzf8LkP0VzKZ5SuY1ckh2kme54rzaalOjj36WtTIBw5bhXUDT4fIHVyJ8QqrfrXwpJ
         WTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783957169; x=1784561969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4jeSK203ZaFxCazvnYe+W9jric1EDdx+LJQMmm4pnTs=;
        b=Pv5PAuQDqTmDuSpXlSj+eqW7i9z8cfll9anzKBvrU55C+Iiwx05QFQrwglukhiHJ4o
         CppaOKcxw7isrLtQgNSIEOQsJd15LbXZK5idwqRcb2ihzl+rXTm203/xA3X4klYVRBHN
         ysLmbCkvJkHbBA/wmksuibVCGnaTEIXjuON2cDZkgMRRE3KJQSVhklxpeHR+rBpCS++U
         sF/FEvteUJjrjo5vv3FcFM96eCISWBnudBnaMh6HgzfJ0JsPDBBw97BWAW+InFB/EMWb
         vfNLWVqQH7aCovZbtP4Y1TGpWbuaBc1Gy/yExDL3R5iaoRsekw5cAMD70T8Q5y360jVy
         SvHw==
X-Gm-Message-State: AOJu0YzSdVcCIh/GuXif9FmHU4UpwZaxa9yRW3e9VGcKQxpAe70itnQH
	KPyy6VYAK6PMv/KydnB/WOgIiO+0hQDdWbyNbhFF93Hv1tnz85Z7pJVyFNdKkMB3
X-Gm-Gg: AfdE7ck4h2sdSRPtBsciXLhmji7/88rFzNpd40YH0JwHwq493ROBI5KyYcwTds4cS8l
	s6zCrcXUVRMO/x+P6OyNDJMvOHUvLGUv7AKHwCyAlxqj0f8k9bkdtrSNEFSBrGZxAMB7ONMorbo
	tW/NROhqE19KjBg9uX/n+5ThKxIm1qPQQcAWJQYKe6KfX7v/+6IDZ1nZP9T/VAn1Ro7+Gb3CPeJ
	uvLa93JvGOCGpgryJ+oohmfUhcW2LUiw2NlA01pDkq/ctMY7vfATQ24uNfsyyfnkm23/YnUuspw
	8tBRU/R6gHMAsXMvIHNxq2tQj3jzEKwjiyl+XI/ll0iUVOqtYVOix/YyMCnn5fyKawPA1dETltH
	zQ8JuvNJDSNO1gwIR24fzTvvUtfEC17HPdnq+bdXpd8GLos53VNKi6WtoBiWtvVRE775n4UfeyW
	A76qLb+JK1prHOX/wjtAtXDO5joiLJTWitaV1LGmnt9H7BbRJkhLaJViHm933vUO9FFuSy2tGSK
	ghoFjJc5aStQibcTSvNKDtWyMRighiDEIZNF6BoN52y1H5dykguqN2ldJec848A+w==
X-Received: by 2002:a05:6000:40cb:b0:47b:5f25:7c59 with SMTP id ffacd0b85a97d-47f2dcf8d32mr11489983f8f.38.1783957168753;
        Mon, 13 Jul 2026 08:39:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e029sm284608f8f.3.2026.07.13.08.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 08:39:28 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 13/17] bpf: Report Program Structure CFG errors
Date: Mon, 13 Jul 2026 17:39:02 +0200
Message-ID: <20260713153910.2556007-14-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713153910.2556007-1-memxor@gmail.com>
References: <20260713153910.2556007-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9944; i=memxor@gmail.com; h=from:subject; bh=d355m5fUPG85gJ5L29ZwbV1tZP33ksTIwmChRH9OLJI=; b=kA0DAAoWRy03e2NUL4MByyZiAGpVBCHIuWyFmRfvNRz3MEnbCVOkzSE3g6BBQbHxdyWx5V+mt oh1BAAWCgAdFiEEdP++AjPIeftRPaYLRy03e2NUL4MFAmpVBCEACgkQRy03e2NUL4N8/wD/YCYk vlGnMvOl94L1N8OpRkvFtaAvKjgSdnFX3HkdA80BANGjej+2aSCjuLWjY6etF4qxT/NE3Gcvw2t iGg2JgPgI
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

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/cfg.c         | 55 ++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.c | 19 ++++++++++++++
 kernel/bpf/diagnostics.h |  3 +++
 kernel/bpf/verifier.c    | 32 +++++++++++++++++++++++
 4 files changed, 109 insertions(+)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 26d37066465f..376f6b6d469c 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -5,6 +5,8 @@
 #include <linux/filter.h>
 #include <linux/sort.h>
 
+#include "diagnostics.h"
+
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
 /* non-recursive DFS pseudo code
@@ -113,6 +115,12 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 	if (w < 0 || w >= env->prog->len) {
 		verbose_linfo(env, t, "%d: ", t);
 		verbose(env, "jump out of range from insn %d to %d\n", t, w);
+		bpf_diag_report_program_structure(env, t, "jump out of range",
+						  "Keep branch targets inside the program.",
+						  "Instruction %d jumps to instruction %d, but the "
+						  "program only contains instructions 0 through "
+						  "%d.",
+						  t, w, env->prog->len - 1);
 		return -EINVAL;
 	}
 
@@ -136,6 +144,15 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 		verbose_linfo(env, t, "%d: ", t);
 		verbose_linfo(env, w, "%d: ", w);
 		verbose(env, "back-edge from insn %d to %d\n", t, w);
+		bpf_diag_report_program_structure(env, t, "back-edge is not allowed",
+						  "Load with privileges that allow this back-edge, "
+						  "or rewrite "
+						  "the control flow so it does not branch "
+						  "backward.",
+						  "Instruction %d branches back to instruction %d. "
+						  "This program is being rejected without the "
+						  "privilege needed for this back-edge.",
+						  t, w);
 		return -EINVAL;
 	} else if (insn_state[w] == EXPLORED) {
 		/* forward- or cross-edge */
@@ -316,6 +333,14 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
 
 	if (!jt) {
 		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
+		bpf_diag_report_program_structure(env, subprog_start, "missing jump table",
+						  "Make sure subprograms containing gotox "
+						  "instructions are "
+						  "accompanied by jump tables referencing these "
+						  "subprograms.",
+						  "No jump table was found for the subprogram that "
+						  "starts at instruction %u.",
+						  subprog_start);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -343,6 +368,13 @@ create_jt(int t, struct bpf_verifier_env *env)
 		if (jt->items[i] < subprog_start || jt->items[i] >= subprog_end) {
 			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]\n",
 					t, subprog_start, subprog_end);
+			bpf_diag_report_program_structure(env, t, "jump table target out of range",
+							  "Keep every jump-table target inside the "
+							  "same subprogram.",
+							  "The jump table for instruction %d "
+							  "points outside subprogram range "
+							  "[%u,%u).",
+							  t, subprog_start, subprog_end);
 			kvfree(jt);
 			return ERR_PTR(-EINVAL);
 		}
@@ -374,6 +406,13 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
 		w = jt->items[i];
 		if (w < 0 || w >= env->prog->len) {
 			verbose(env, "indirect jump out of range from insn %d to %d\n", t, w);
+			bpf_diag_report_program_structure(env, t, "indirect jump out of range",
+							  "Keep indirect jump targets inside the "
+							  "program.",
+							  "Instruction %d can jump indirectly to "
+							  "instruction %d, but the program only "
+							  "contains instructions 0 through %d.",
+							  t, w, env->prog->len - 1);
 			return -EINVAL;
 		}
 
@@ -624,12 +663,28 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 
 		if (insn_state[i] != EXPLORED) {
 			verbose(env, "unreachable insn %d\n", i);
+			bpf_diag_report_program_structure(env, i, "unreachable instruction",
+							  "Remove the unreachable instruction or "
+							  "add valid control flow that reaches it.",
+							  "Instruction %d is not reachable from "
+							  "the program entry point.",
+							  i);
 			ret = -EINVAL;
 			goto err_free;
 		}
 		if (bpf_is_ldimm64(insn)) {
 			if (insn_state[i + 1] != 0) {
 				verbose(env, "jump into the middle of ldimm64 insn %d\n", i);
+				bpf_diag_report_program_structure(env, i,
+								  "jump into ldimm64 immediate",
+								  "Target the first instruction of "
+								  "the ldimm64 pair, or "
+								  "restructure the jump target.",
+								  "Control flow reaches the second "
+								  "half of the ldimm64 instruction "
+								  "pair that starts at instruction "
+								  "%d.",
+								  i);
 				ret = -EINVAL;
 				goto err_free;
 			}
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index c90be89d4707..5496e7a0235b 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1277,6 +1277,25 @@ void bpf_diag_ctx(struct bpf_verifier_env *env, enum bpf_diag_ctx_report report,
 		return;
 	}
 }
+
+void bpf_diag_report_program_structure(struct bpf_verifier_env *env, u32 insn_idx,
+				       const char *problem, const char *suggestion,
+				       const char *reason_fmt, ...)
+{
+	va_list args;
+
+	bpf_diag_report_header(env, CATEGORY_PROGRAM_STRUCTURE, problem);
+	diag_report_section(env, "Reason");
+
+	va_start(args, reason_fmt);
+	diag_vprint_indented(env, reason_fmt, args);
+	va_end(args);
+
+	diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, "error", "%s", problem);
+
+	diag_report_suggestion(env, "%s", suggestion);
+}
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 				   const char *reg_name, const struct bpf_reg_state *reg,
 				   enum bpf_diag_invalid_deref_kind kind, s64 offset)
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index f26432e84d9f..bb29f4235a68 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -168,6 +168,9 @@ void bpf_diag_report_call_type(struct bpf_verifier_env *env, u32 insn_idx, int a
 void bpf_diag_ctx(struct bpf_verifier_env *env, enum bpf_diag_ctx_report report, u32 insn_idx,
 		  const char *operation, enum bpf_diag_context_kind ctx_kind, const char *context,
 		  const char *suggestion);
+void bpf_diag_report_program_structure(struct bpf_verifier_env *env, u32 insn_idx,
+				       const char *problem, const char *suggestion,
+				       const char *reason_fmt, ...) __printf(5, 6);
 int bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_record_mod(struct bpf_verifier_env *env, u32 insn_idx,
 			 struct bpf_diag_mod_target target, enum bpf_diag_mod_reason reason,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e253fbc733a4..44e1907ac792 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3041,6 +3041,17 @@ static int check_subprogs(struct bpf_verifier_env *env)
 		off = i + bpf_jmp_offset(&insn[i]) + 1;
 		if (off < subprog_start || off >= subprog_end) {
 			verbose(env, "jump out of range from insn %d to %d\n", i, off);
+			bpf_diag_report_program_structure(env, i, "jump out of range",
+							  "Keep branch targets within the same "
+							  "subprogram, or use an explicit "
+							  "subprogram call.",
+							  "Instruction %d jumps to instruction %d, "
+							  "but subprogram %d only contains "
+							  "instructions %d through %d. A branch "
+							  "target must stay inside the same "
+							  "subprogram.",
+							  i, off, cur_subprog, subprog_start,
+							  subprog_end - 1);
 			return -EINVAL;
 		}
 next:
@@ -3053,6 +3064,18 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			    code != (BPF_JMP32 | BPF_JA) &&
 			    code != (BPF_JMP | BPF_JA)) {
 				verbose(env, "last insn is not an exit or jmp\n");
+				bpf_diag_report_program_structure(env, i,
+								  "subprogram can fall through",
+								  "End each subprogram with an "
+								  "exit or an explicit jump that "
+								  "keeps control flow inside the "
+								  "subprogram.",
+								  "Subprogram %d reaches its last "
+								  "instruction %d without an exit "
+								  "or jump, so control could "
+								  "continue into the next "
+								  "subprogram.",
+								  cur_subprog, i);
 				return -EINVAL;
 			}
 			subprog_start = subprog_end;
@@ -3125,6 +3148,15 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 					verbose(env, "recursive call from %s() to %s()\n",
 						bpf_verifier_subprog_name(env, cur),
 						bpf_verifier_subprog_name(env, callee));
+					bpf_diag_report_program_structure(
+						env, idx, "recursive subprogram call",
+						"Rewrite the recursion as an explicit bounded "
+						"loop, or split the logic so subprogram calls do "
+						"not form a cycle.",
+						"This bpf2bpf call would make the subprogram call "
+						"graph recursive. The verifier requires a finite, "
+						"acyclic call graph so it can bound stack depth "
+						"and analysis.");
 					ret = -EINVAL;
 					goto out;
 				}
-- 
2.53.0

