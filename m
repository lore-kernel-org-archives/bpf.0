Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E994302F6
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 23:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577636; cv=none; b=b/q8coFAj3NxD4ulD+wpdSUOuOikQzEljUbrrFgC4249qVmoFGijbDWeD3SJ6qv2Y5xdoxLac/mYIYWP4ByN9JC2ByqUWv+WWMYmK8yBBfbTrSFHdoxE+2zrcVfIUa6rTP3X3W6rMsXC+nFr8k17brlemeqhIAFI0YDhDlqn3AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577636; c=relaxed/simple;
	bh=gkL2IJnhmadwkgWfJpmzZuPF25HtAJ7EGseZr/0BCeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2WqB3NlQWWVUe2U+Uqo5a7IJQgVya3io4lfUnfJdrnNIs0dOo0i2fy3m4qqaUwUA+6Xq/VXmYdjDvKZAl9vgfI74YMz4upWjPXNNNgayT61gmW3QXjysZihU/nptA3NbbAf1DzIg0accF6I1VsYFG7y6MNS8dN7vFP5b1aBisk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAPeGb8j; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAPeGb8j"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-46cbf263216so635468f8f.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 16:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786577631; x=1787182431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QBaolEGm/zqOizzQdf3W8WPEnLuaBMZVSb8JZtQGBDg=;
        b=RAPeGb8jRtidm+aXEdrRm8hbrGWCXOIXIntjU+XoxHhJUwvjclvxE+IYBV49b4wjEB
         podKCFUALuz4or9Xp1UadkV/Xto6wEh4HgW8usXSQR9TXKII5TG+WGx3/Qr2cmvnN9x+
         qTizlCvy5tDbmFLceVZegvw+KHaBInBFylzZ0MtzyHbScakAIdXigfWjDru1I5frrT/b
         N9HsSYaDCrRY8msGFjbJsGbVbIg1XWrtXwptMB+f4cC9fM5p8/HchPf+VT06k6a2TrrF
         sgBkvkLa2GVa+yS3M4+ak0JYfEeIzAYdLTqSI+NV2932Km2F9utHwxYc7I5V14qLvkl6
         I8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577631; x=1787182431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QBaolEGm/zqOizzQdf3W8WPEnLuaBMZVSb8JZtQGBDg=;
        b=KdiMPGaHzHJn17Dhv0injEVrXVRl1RaPjFzUM2Y+9Q+Quo4XiTM/eoCLiW5/rhfdDP
         xYldYwHRzikoGWMKRW2iZlzbosqSBWfS7lR7CX8S5sKza1lWqEoC61U+XmUqs49rsG2G
         rbUUA8HD6facOpUuZ8+o4uvImraTaGRaevttWLEYwsd0U9fyrgSSrrN7IPDh0fX2o1wv
         E8lQkpuDQ8cmWIbkeBAIRaRT5DXqD+3DCR4R0ZutsSES3kDYi2hQP741rJ2smdk0snk7
         s5nIEyKDetOSurz2l8oELT96TKyYZkvFNvJbdhTL7WyfF94Vlgs0LU7ApAnpbtTW68/G
         vpOw==
X-Gm-Message-State: AOJu0Yx8Nu3v0MXJbUIZDdx4LZCaap4xvm1V2TUW/gOEvq/GQ4yJCYnF
	aiiwuwDOV30LSoyke/bIhnlisoeFwfo7jQoeUqS1uYGSsDbSteRqNnfVulu643ZB
X-Gm-Gg: AR+sD13O4x3J3aGqRqtoGUrkIasz1OoP4B4zebXaIn/H5+iULAa4A/r3cIwR1r7hXfS
	9/eylYtZhiM94Pf1MepASeDg8YBXZmWD3Puk092QR+YaVdqutZenxyz2LCd6pFVdfsak269qkB3
	WB7KAU9XR67vieQYh+Hrfp2nE7Jh9QPiWp3yV1lb97IfyGiVGY26/jAig4o3EdcTHarr59U0uqi
	tRVOoj0/SHXpAXBO629KEHqmce45h3VrhtNFJADmzAafD60LfaM6YvvpWluCBaxOj57A8cy0xxx
	NPwEiQz2QB7BQpxjDzfMvpe/CymJdslgcBopBV1BQV6J4TlDswLfQA5ONcTlfR4wIuCobC4a2z6
	Hjr6dsoeSz4mljvylhhDGfV/xPUhKbmZZc1poM3Af3PaBO+UHMuAD0I0Vt8iefe8s9hWMkRp/xA
	fvGP5+mj/91lF/YSrAKGk0b2l4yDvxMkOi5k6U+1LK/sr90lD61TTe9bqQfSxEWIjSJQnkagzFJ
	Cjfza7FVmzzOr+eVtDn7ujeS0MdeGwbze+r5b4z8E09S4yopHbZLQTpLyYFJbSZmjYRcAAQwOu/
	VzLo5K83cFw2iuJYQ+AN/HoNidPZnpk5
X-Received: by 2002:a05:6000:260a:b0:481:57f7:6015 with SMTP id ffacd0b85a97d-48159cbe165mr2397533f8f.6.1786577631025;
        Wed, 12 Aug 2026 16:33:51 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815a561296sm1564246f8f.4.2026.08.12.16.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 16:33:50 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 13/16] bpf: Report Program Structure CFG errors
Date: Thu, 13 Aug 2026 01:33:16 +0200
Message-ID: <20260812233326.3575958-14-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812233326.3575958-1-memxor@gmail.com>
References: <20260812233326.3575958-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9219; i=memxor@gmail.com; h=from:subject; bh=gkL2IJnhmadwkgWfJpmzZuPF25HtAJ7EGseZr/0BCeM=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIauWQVdd4m+9XIiaXt9h5gevGLeUFJyq/f3q3GHVJUW2D MFrXhh1lLIwiHExyIopspT838dkfKLyd6DtMm6YOaxMIEMYuDgFYCJvJzH8M3Prlfv59kJyurfO QvX7eZf2r9DQenT26l2GIwtTc7rPbGH4H66wkufZq03f7i+1vrxV77iFO4v1JrUYuwl3FbgX/Vf rYgMA
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
 kernel/bpf/cfg.c         | 35 +++++++++++++++++++++++++++++++++++
 kernel/bpf/diagnostics.c | 19 +++++++++++++++++++
 kernel/bpf/diagnostics.h |  3 +++
 kernel/bpf/verifier.c    | 16 ++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index db3416a7c904..6ce0c6153907 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -5,6 +5,8 @@
 #include <linux/filter.h>
 #include <linux/sort.h>
 
+#include "diagnostics.h"
+
 #define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##args)
 
 /* non-recursive DFS pseudo code
@@ -113,6 +115,10 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 	if (w < 0 || w >= env->prog->len) {
 		verbose_linfo(env, t, "%d: ", t);
 		verbose(env, "jump out of range from insn %d to %d\n", t, w);
+		bpf_diag_program_structure(
+			env, t, "jump out of range", "Keep branch targets inside the program.",
+			"Instruction %d jumps to instruction %d, but the program only contains instructions 0 through %d.",
+			t, w, env->prog->len - 1);
 		return -EINVAL;
 	}
 
@@ -136,6 +142,11 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
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
@@ -316,6 +327,11 @@ static struct bpf_iarray *jt_from_subprog(struct bpf_verifier_env *env,
 
 	if (!jt) {
 		verbose(env, "no jump tables found for subprog starting at %u\n", subprog_start);
+		bpf_diag_program_structure(
+			env, subprog_start, "missing jump table",
+			"Make sure subprograms containing gotox instructions are accompanied by jump tables referencing these subprograms.",
+			"No jump table was found for the subprogram that starts at instruction %u.",
+			subprog_start);
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -343,6 +359,11 @@ create_jt(int t, struct bpf_verifier_env *env)
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
@@ -374,6 +395,11 @@ static int visit_gotox_insn(int t, struct bpf_verifier_env *env)
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
 
@@ -624,12 +650,21 @@ int bpf_check_cfg(struct bpf_verifier_env *env)
 
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
index 01bcc9b6b980..539d9b0abae4 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -1138,6 +1138,25 @@ void bpf_diag_ctx_restricted(struct bpf_verifier_env *env, u32 insn_idx, const c
 {
 	diag_ctx_forbidden(env, insn_idx, operation, ctx_kind, context, constraint, suggestion);
 }
+
+void bpf_diag_program_structure(struct bpf_verifier_env *env, u32 insn_idx,
+				       const char *problem, const char *suggestion,
+				       const char *reason_fmt, ...)
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
index 9479a42d105a..3ae2b9f37741 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -154,6 +154,9 @@ void bpf_diag_ctx(struct bpf_verifier_env *env, enum bpf_diag_ctx_report report,
 void bpf_diag_ctx_restricted(struct bpf_verifier_env *env, u32 insn_idx, const char *operation,
 			     enum bpf_diag_context_kind ctx_kind, const char *context,
 			     const char *constraint, const char *suggestion);
+void bpf_diag_program_structure(struct bpf_verifier_env *env, u32 insn_idx,
+				       const char *problem, const char *suggestion,
+				       const char *reason_fmt, ...) __printf(5, 6);
 void bpf_diag_record_branch(struct bpf_verifier_env *env, u32 insn_idx, bool cond_true);
 void bpf_diag_mod_begin(struct bpf_verifier_env *env, const struct bpf_reg_state *reg,
 			const struct bpf_reg_state *origin, enum bpf_diag_mod_reason reason);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 71893c36ecce..91693b4232d4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3000,6 +3000,12 @@ static int check_subprogs(struct bpf_verifier_env *env)
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
@@ -3012,6 +3018,11 @@ static int check_subprogs(struct bpf_verifier_env *env)
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
@@ -3084,6 +3095,11 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
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

