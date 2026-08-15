Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F5D3B47F5
	for <bpf@vger.kernel.org>; Sat, 15 Aug 2026 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786776404; cv=none; b=A0KP8faPisas5Zn2BVEHh+RUydVyOtDqhU7oRWAY2aggJ3lTC9ZnYkWDcSAOtHvmZBmGuktTXi+T+zFw8g/ieiTGhvtmUuRJHWSol+BKwBsSUSkrgQ/SKLpbfTTNdiiVovlmzCq6WoxxBtn7RwlT1Qt8S4eDEB1iJrtfshiRCh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786776404; c=relaxed/simple;
	bh=2qELXIoU9lXKGno5vwoFlCd1BjmN5Mb+jYS6b8DsJU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evQCUiYT37BSmXTwFJE56xVSyl9viKM/IADbq5RBbuP+F6dBFCIwYiA3ljrqRumCBtCiL2NP1qI28oa6ivComUv4yBw+ax/J3q+fTpwrImiDBRV8VoMWPsljBXiOWmboQIJ9SiI6BrXk3Z0fS+5O7QgMaQIy/wklUo6PQFYlCb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cM+XOeOm; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cM+XOeOm"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-4955674321eso3449545e9.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 23:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786776392; x=1787381192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LzWVWxb/0eg9q6BnwJP28btwNlr72EUilj3ObPEPakg=;
        b=cM+XOeOmk9AcX7ZqGpAIqCt1je0fu1dWZxYhAU2IT6Z85YL1QcHxl9vYZWEIezrRQM
         JtIHRgqwE+udJH4vsNmKtxSLqH3Dkg1Zpxt5Qey+jt9I7ZyMgMXZeokLtC5jv7gotewH
         XJ903Kg8h8t1CeFfFi65b3RylCGr07M+dvq9H06vyc3LgaTWGwVaRMmPg09a1NU9lLW5
         C+dRnkgGd4rnvTNkhUNmiV31ax/r9H3KInPMGsOIjAcWbIlO6/LkWaf1XZ8LtiQ14sNl
         t75shWT/xypincFI6DQG6GWDwEu09qrtlWGzetleR5cJOy17/I8OTqbkC1qlFW5J6uNj
         lE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786776392; x=1787381192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LzWVWxb/0eg9q6BnwJP28btwNlr72EUilj3ObPEPakg=;
        b=BwtefWQI04MEJKEnmRKEd2H8lja9vjl8VlfazQl5Y9nSK87Jn1WtsUUqPqE9TXc9c5
         YlxlpuzTI3RKc8DrRCvJBV2hBVgo+scfcJZwz0O+GuBg51ZphtDGLi8m/oUl4Bg9nOxo
         dfnhd1tRdyZtbxCrMHTlyPLK96+u1+V6DvUNFEwJcqBvIy7FZ2Rq7wj8PxzMIVlaZ6dA
         4sRcFBIBIlBEGgHo/ZOAGwBlS0k+yjDA4xQR4huk6mp0xPb4Hu/ny0DNe1Z1T/PkbgVw
         9VWNxMKzBeEmhFyrjWGWSDt0VVU49Txkdxxce38mLSwY+90o4q0Mu2JP444/jEG5w06M
         KnxQ==
X-Gm-Message-State: AOJu0YywBj17DHQFJlibUtjZWXln5JdHr3fAad8wHR6vTPhWj44FZ/f/
	6TTmNlHBBmVm1XNXK+sQTZ63md2RSZPeHJH5GNcwTl4rMF9ftAhJmB4n4eQcR16g
X-Gm-Gg: AR+sD10ydCyzRNkGeqATxK2qaWOI2WKaHNTkcgQ9v4dvi7h823ONFZv0T1gxkmGlciE
	ZE6iBuMaKVaD5r6RSJjqo2zbGE2LbkXvVMT2S6M2wmMi6AK5PV7JivgBwP7CqKm6yiwz25UK8Y3
	IAuiOJcCsa8ZcqjcH/K3beN58xZJrPTPad+iFZQ61/lHsmBiBIExYnFrp6CPZ+DdRa2KrrHWLzb
	5pNqKq+TLl4yAhW0I1ZXU76azrM9xxAN6gUDzle62T+VnER+nRyF0XnyZxlX6o7NHV5nVeeHKwT
	uWfc4NBhOcAiWUkl3Ms0Dj2NDg9kkamLCua/Ec5BW0NxFoOdDsuAWb/7B9BPfvGanXoQDKIRyHj
	tz13M+/qUz+JqfrrxLqsXjc58t25V+7YhCoOZoi3gtDUdUDCQzYtCCdNONJhvLp9oQJ8xroImfy
	fg/HfW6Z6UF9O2qDEBcjxYYNZdsSAJp/pWN+pR0R1Avd+7jqgrU9QQd0O1r/Tg5cQf1UDNbd7Dg
	vImacBjl8MpBQPzKmXArVXzUhp9MT1qicXroA3ZlpG8ZKts1+k2jiLdqvQSlTVWK+GCRxKQkSh0
	7KXu/6OzRWfaFbH2wW56m1q1rdw=
X-Received: by 2002:a5d:5303:0:b0:47f:8802:c182 with SMTP id ffacd0b85a97d-481607a3329mr12780995f8f.29.1786776391804;
        Fri, 14 Aug 2026 23:46:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c6115sm13959047f8f.32.2026.08.14.23.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 23:46:31 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v5 13/14] bpf: Report Program Structure CFG errors
Date: Sat, 15 Aug 2026 08:46:08 +0200
Message-ID: <20260815064612.378577-14-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815064612.378577-1-memxor@gmail.com>
References: <20260815064612.378577-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9512; i=memxor@gmail.com; h=from:subject; bh=2qELXIoU9lXKGno5vwoFlCd1BjmN5Mb+jYS6b8DsJU4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauBy09zQdj9rJziffcaUlnWfgg2WLPOPXKi43HBKRzG/ UdtFnB1lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCLp2Qx/+HacFOmX+7yK8ddM Bg93piOZPIXrO5TF/ulLzlBbZsPez8gwod73WZxXmv3ceyc8dv6d+G9lmgVL1KFzn+ttbApelde yAwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected whole-program and subprogram CFG validation failures with
Program Structure reports. These errors are structural rather than
path-dependent, so the reports focus on source and instruction context
instead of causal history.

Cover direct and indirect jumps outside the program or current subprogram,
unprivileged backedges, missing and out-of-range jump tables, targets in the
second half of an ldimm64, unreachable instructions, subprogram fallthrough,
and recursive bpf2bpf call graph edges.

Format long jump-range reasons directly in diagnostics.c, and keep the
fallthrough suggestion aligned with the verifier check by suggesting exit or
explicit jumps.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/cfg.c         | 35 +++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.c | 19 +++++++++++++++++++
 kernel/bpf/diagnostics.h |  3 +++
 kernel/bpf/verifier.c    | 16 ++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 818f7afac83a..0f13c13f4133 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -5,6 +5,8 @@
 #include <linux/filter.h>
 #include <linux/sort.h>
 
+#include "diagnostics.h"
+
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
 /* non-recursive DFS pseudo code
@@ -112,6 +114,10 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 	if (w < 0 || w >= env->prog->len) {
 		verbose_linfo(env, t, "%d: ", t);
 		verbose(env, "jump out of range from insn %d to %d\n", t, w);
+		bpf_diag_program_structure(
+			env, t, "jump out of range", "Keep branch targets inside the program.",
+			"Instruction %d jumps to instruction %d, but the program only contains instructions 0 through %d.",
+			t, w, env->prog->len - 1);
 		return -EINVAL;
 	}
 
@@ -135,6 +141,11 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 		verbose_linfo(env, t, "%d: ", t);
 		verbose_linfo(env, w, "%d: ", w);
 		verbose(env, "back-edge from insn %d to %d\n", t, w);
+		bpf_diag_program_structure(
+			env, t, "back-edge is not allowed",
+			"Load with privileges that allow this back-edge, or rewrite the control flow so it does not branch backward.",
+			"Instruction %d branches back to instruction %d. This program is being rejected without the privilege needed for this back-edge.",
+			t, w);
 		return -EINVAL;
 	} else if (insn_state[w] == EXPLORED) {
 		/* forward- or cross-edge */
@@ -315,6 +326,11 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
 
 	if (!jt) {
 		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
+		bpf_diag_program_structure(
+			env, subprog_start, "missing jump table",
+			"Make sure subprograms containing gotox instructions are accompanied by jump tables referencing these subprograms.",
+			"No jump table was found for the subprogram that starts at instruction %u.",
+			subprog_start);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -342,6 +358,11 @@ create_jt(int t, struct bpf_verifier_env *env)
 		if (jt->items[i] < subprog_start || jt->items[i] >= subprog_end) {
 			verbose(env, "jump table for insn %d points outside of the subprog [%u,%u]\n",
 					t, subprog_start, subprog_end);
+			bpf_diag_program_structure(
+				env, t, "jump table target out of range",
+				"Keep every jump-table target inside the same subprogram.",
+				"The jump table for instruction %d points outside subprogram range [%u,%u).",
+				t, subprog_start, subprog_end);
 			kvfree(jt);
 			return ERR_PTR(-EINVAL);
 		}
@@ -373,6 +394,11 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
 		w = jt->items[i];
 		if (w < 0 || w >= env->prog->len) {
 			verbose(env, "indirect jump out of range from insn %d to %d\n", t, w);
+			bpf_diag_program_structure(
+				env, t, "indirect jump out of range",
+				"Keep indirect jump targets inside the program.",
+				"Instruction %d can jump indirectly to instruction %d, but the program only contains instructions 0 through %d.",
+				t, w, env->prog->len - 1);
 			return -EINVAL;
 		}
 
@@ -623,12 +649,21 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 
 		if (insn_state[i] != EXPLORED) {
 			verbose(env, "unreachable insn %d\n", i);
+			bpf_diag_program_structure(
+				env, i, "unreachable instruction",
+				"Remove the unreachable instruction or add valid control flow that reaches it.",
+				"Instruction %d is not reachable from the program entry point.", i);
 			ret = -EINVAL;
 			goto err_free;
 		}
 		if (bpf_is_ldimm64(insn)) {
 			if (insn_state[i + 1] != 0) {
 				verbose(env, "jump into the middle of ldimm64 insn %d\n", i);
+				bpf_diag_program_structure(
+					env, i, "jump into ldimm64 immediate",
+					"Target the first instruction of the ldimm64 pair, or restructure the jump target.",
+					"Control flow reaches the second half of the ldimm64 instruction pair that starts at instruction %d.",
+					i);
 				ret = -EINVAL;
 				goto err_free;
 			}
diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index c69160f656e9..9fc1f8cf7312 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -21,6 +21,7 @@
 #define RESOURCE_LIFETIME_SAFETY "Resource Lifetime Safety"
 #define CALL_TYPE_SAFETY "Call Type Safety"
 #define EXECUTION_CONTEXT_SAFETY "Execution Context Safety"
+#define PROGRAM_STRUCTURE "Program Structure"
 
 #define BPF_DIAG_TEXT_WIDTH 100
 #define BPF_DIAG_TEXT_INDENT "  "
@@ -1192,6 +1193,24 @@ void bpf_diag_ctx_underflow(struct bpf_verifier_env *env, u32 insn_idx,
 	diag_suggestion(env, "%s", suggestion);
 }
 
+void bpf_diag_program_structure(struct bpf_verifier_env *env, u32 insn_idx,
+				const char *problem, const char *suggestion,
+				const char *reason_fmt, ...)
+{
+	va_list args;
+
+	bpf_diag_header(env, PROGRAM_STRUCTURE, problem);
+	diag_section(env, "Reason");
+
+	va_start(args, reason_fmt);
+	diag_vprint_indented(env, reason_fmt, args);
+	va_end(args);
+
+	diag_section(env, "At");
+	bpf_diag_source(env, insn_idx, "error", "%s", problem);
+
+	diag_suggestion(env, "%s", suggestion);
+}
 void bpf_diag_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx, int regno,
 			    const char *reg_name, const struct bpf_reg_state *reg,
 			    enum bpf_diag_invalid_deref_kind kind, s64 offset)
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index 95bc654e5b3e..ab082d2d6e37 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -89,6 +89,9 @@ void bpf_diag_ctx_required(struct bpf_verifier_env *env, u32 insn_idx, const cha
 void bpf_diag_ctx_underflow(struct bpf_verifier_env *env, u32 insn_idx,
 			    const char *operation, enum bpf_diag_context_kind ctx_kind,
 			    const char *suggestion);
+void bpf_diag_program_structure(struct bpf_verifier_env *env, u32 insn_idx,
+				const char *problem, const char *suggestion,
+				const char *reason_fmt, ...) __printf(5, 6);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_mod_begin(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
 			const struct bpf_reg_state *origin, enum bpf_diag_mod_reason reason);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a81a7ed18d76..64c5c31ed230 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3020,6 +3020,12 @@ static int check_subprogs(struct bpf_verifier_env *env)
 		off = i + bpf_jmp_offset(&insn[i]) + 1;
 		if (off < subprog_start || off >= subprog_end) {
 			verbose(env, "jump out of range from insn %d to %d\n", i, off);
+			bpf_diag_program_structure(
+				env, i, "jump out of range",
+				"Keep branch targets within the same subprogram, or use an explicit subprogram call.",
+				"Instruction %d jumps to instruction %d, but subprogram %d only contains instructions %d through %d. "
+				"A branch target must stay inside the same subprogram.",
+				i, off, cur_subprog, subprog_start, subprog_end - 1);
 			return -EINVAL;
 		}
 next:
@@ -3032,6 +3038,11 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			    code != (BPF_JMP32 | BPF_JA) &&
 			    code != (BPF_JMP | BPF_JA)) {
 				verbose(env, "last insn is not an exit or jmp\n");
+				bpf_diag_program_structure(
+					env, i, "subprogram can fall through",
+					"End each subprogram with an exit or an explicit jump that keeps control flow inside the subprogram.",
+					"Subprogram %d reaches its last instruction %d without an exit or jump, so control could continue into the next subprogram.",
+					cur_subprog, i);
 				return -EINVAL;
 			}
 			subprog_start = subprog_end;
@@ -3104,6 +3115,11 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 					verbose(env, "recursive call from %s() to %s()\n",
 						bpf_subprog_name(env, cur),
 						bpf_subprog_name(env, callee));
+					bpf_diag_program_structure(
+						env, idx, "recursive subprogram call",
+						"Rewrite the recursion as an explicit bounded loop, or split the logic so subprogram calls do not form a cycle.",
+						"This bpf2bpf call would make the subprogram call graph recursive. "
+						"The verifier requires a finite, acyclic call graph so it can bound stack depth and analysis.");
 					ret = -EINVAL;
 					goto out;
 				}
-- 
2.53.0

