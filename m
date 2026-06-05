Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BB440DFDC
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 06:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641272; cv=none; b=c6hO0Kb0k17VtUioQTU/NXIo0nWCp4dCYvmgE+CbkxQic6Y+cBnb5uGGGQHx6zp5MM+nmimQ/cvSgHj20L9FfQJYrcySkUBC+y8+J3opoczCftAcM1LMUd9dL6K31OddgO1DOZWY4wV9OO23z/UsYDjekJy1FB2Mmjf+GdLNM9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641272; c=relaxed/simple;
	bh=V6c+sVCm2Egb5i5J7DuwMD0HV51J/besCMECORehO90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hel8NA8Xg5ESmuz0lP5pHRkxl98ZIyGWZ2pHRS0yaSEN6qI/w84n9sH1atb8eaQYmCl0df9rH7SGLNFMu08Mj011N2eiRSEsoAL4jMege69DqV+58UEU+dQu2U2hxHyh4+JlZG5SPHnh9zm4dvkMXcpYxG4ygYg5+GvjoTROBaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pv8jMXA2; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pv8jMXA2"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso12935815e9.1
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780641269; x=1781246069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4Z6KHSdrhSPlwGut9LlNu1H1AqjHi8WTEL50C85MK0=;
        b=pv8jMXA2t5doYp0PdSMYPeE8uuhb3eFCuspVYgoWP9JP0ZY29eAvel3wTpGn7bHDHv
         i3I5mRCLMrxUOA4o+LJf5YZV4w8m4irN/gZQIlNE2c+5/gfc+0Cu18VPMqcsbSEMC3rt
         sEls+NdhnrBDYUKzy6v0RwF+iZINv6MunhARyTdzCA4XrqXzyfJuXpXvIKXZ5N/OUwKc
         yzTYptqgqxL/s2ur8AIkvlBedXcHbFw9q/wdIDe6ThsIq5ygcZydQlm60tRUT0BNtfWr
         94G0mnBXlAxnYJ/NOPyXn7oiFqMvzBt/PKa95TAYv0u4BcIAUOHMBHxOAvypPy6d+I2U
         qE0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780641269; x=1781246069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/4Z6KHSdrhSPlwGut9LlNu1H1AqjHi8WTEL50C85MK0=;
        b=tA7Ou+5ofFgGr75abi7G90+ButsPjea+bqq22l8aLPDOdyV/zti+HbWv9N0eFPsSA4
         TZ3QCQTXrJH5Pm4RisPw/CqHm2t8qJLkr/tZPAnTJdAytrIx/10ceOI3smXj/wiswvKK
         ApvR2nyCwWhFheiX0s2W9TDB+2kZKWWgHKiegrHMbk/SnwFqzhFPygXkJwu7shF6EIYW
         qpA7M1RWzok4VGs0O3I1c+0hr0Uy0i6lACVx0N5W4eepxNdzFsiD7VEYIqReB6fmQP5d
         emu0gNySYLkAdk+q/Eg77ZTb3A6Yipx5Vga7cgy2r8d7419bfHPHFgGgMhgjoI1isZKI
         YtVg==
X-Gm-Message-State: AOJu0YwUTxAHYmzIbdWObTJJJ5peCA7tsf3Mz0L+CqVzMHJJKtUoioAI
	Bsc730z4c+KTKTudSSRBs+jMFkFukcrnEWcizZAYmSb7CKvv1+ZEsVly5+fXWuGW
X-Gm-Gg: Acq92OGs+veIuCq9Ezvs4iU0U4+uBG/FmTCbWotOn07GzWXs3LM030PphzkTJnEN08q
	hQeKzIRcxyOalNUR+gxh7uaZPSee/sGLtcI6+P273hgrpoeubtehCBiNlHdjUUOgxzVrEVqXBRS
	MfOszOOo009l+bcw5h2dTpO9xI5cAs9QVcD5zmWqmgbJCHOjw1nycpqDMMl5PLMPHFyjp0Am4ez
	9LBRN9e/XBT9CHB0FNEda8aRiaKpGnviehUV9mmV2KM33btDs1U2Qq7uFpphNyAlxvTqRTqcDmD
	/eiDJiK8umySvk9GxLIj5597F5+jl3Vx2xUz3WFiHDPhwlN5hV3cYiCtLy8NpaxBIgAPwH4nFdb
	hasHAcUOVgH06AOip2e7PAcC+HUn8HFyqoM/2amnZ0WbrMxZE/+xY2oh4WNjzr2UIMJtgORGQ5H
	528u7tGW8FxW1XqSL7yc92W/yZCdrIFvgFVrX6pYJrVs10swkNiM2JOvZ8jmio+6AKamrsgtiI8
	RCjVzRt1cHVq6r7ODW6qPVTmDOz9fWlDeY8IzSvGdwXuElv7rcY6EgWUTs2OIdkQo4sEoUxNxKB
X-Received: by 2002:a05:600c:37c8:b0:490:b642:ce31 with SMTP id 5b1f17b1804b1-490c2598567mr30445015e9.2.1780641268841;
        Thu, 04 Jun 2026 23:34:28 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm133128905e9.14.2026.06.04.23.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 23:34:28 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 13/17] bpf: Report Program Structure CFG errors
Date: Fri,  5 Jun 2026 08:34:03 +0200
Message-ID: <20260605063412.974640-14-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605063412.974640-1-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4977; i=memxor@gmail.com; h=from:subject; bh=V6c+sVCm2Egb5i5J7DuwMD0HV51J/besCMECORehO90=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUspt3T5DEcLUyWDillJa+5ssbR93cB6bZPNx4v62g2nW Sc88/fvKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwESivjMy7O34lvFoqfea1fPd fs/h2iVgMjPUY3L58Xe9He6sn0XbpzP895X9kSl8M/KFxsmG8rMWM+Oqd1tuyZ4mkfrMyiEotHI LNwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Augment selected subprogram CFG validation failures with Program Structure
reports. These errors are structural rather than path-dependent, so the
report focuses on source and instruction context instead of causal history.

Cover jumps that leave the current subprogram and subprograms whose last
instruction can fall through into the next subprogram.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/diagnostics.c | 16 ++++++++++++++++
 kernel/bpf/diagnostics.h |  4 ++++
 kernel/bpf/verifier.c    | 22 ++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
index 2d8417f4efff..24096bb7ca87 100644
--- a/kernel/bpf/diagnostics.c
+++ b/kernel/bpf/diagnostics.c
@@ -904,6 +904,22 @@ void bpf_diag_report_context_underflow(struct bpf_verifier_env *env,
 
 	bpf_diag_report_suggestion(env, "%s", suggestion);
 }
+
+void bpf_diag_report_program_structure(struct bpf_verifier_env *env,
+				       u32 insn_idx, const char *problem,
+				       const char *reason,
+				       const char *suggestion)
+{
+	bpf_diag_report_header(env, BPF_DIAG_CATEGORY_PROGRAM_STRUCTURE,
+			       problem);
+	bpf_diag_report_reason(env, "%s", reason);
+
+	bpf_diag_report_section(env, "At");
+	bpf_diag_report_source(env, insn_idx, '!', "%s", problem);
+
+	bpf_diag_report_suggestion(env, "%s", suggestion);
+}
+
 void bpf_diag_report_invalid_deref(struct bpf_verifier_env *env, u32 insn_idx,
 				   int regno, const char *reg_name,
 				   const char *type_name,
diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
index e11abc30246d..6648a66d0614 100644
--- a/kernel/bpf/diagnostics.h
+++ b/kernel/bpf/diagnostics.h
@@ -199,6 +199,10 @@ void bpf_diag_report_context_underflow(struct bpf_verifier_env *env,
 				       u32 insn_idx, const char *operation,
 				       enum bpf_diag_context_kind ctx_kind,
 				       const char *suggestion);
+void bpf_diag_report_program_structure(struct bpf_verifier_env *env,
+				       u32 insn_idx, const char *problem,
+				       const char *reason,
+				       const char *suggestion);
 
 void bpf_diag_clear_history(struct bpf_verifier_state *state);
 void bpf_diag_copy_history(struct bpf_verifier_state *dst,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e30d79149cc7..325c162e3df0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2879,6 +2879,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
 	int i, subprog_start, subprog_end, off, cur_subprog = 0;
 	struct bpf_subprog_info *subprog = env->subprog_info;
 	struct bpf_insn *insn = env->prog->insnsi;
+	char reason[160];
 	int insn_cnt = env->prog->len;
 
 	/* now check that all jumps are within the same subprog */
@@ -2907,6 +2908,15 @@ static int check_subprogs(struct bpf_verifier_env *env)
 		off = i + bpf_jmp_offset(&insn[i]) + 1;
 		if (off < subprog_start || off >= subprog_end) {
 			verbose(env, "jump out of range from insn %d to %d\n", i, off);
+			scnprintf(reason, sizeof(reason),
+				  "Instruction %d jumps to instruction %d, but subprogram %d only contains instructions %d through %d. A branch target must stay inside "
+				  "the same subprogram",
+				  i, off, cur_subprog, subprog_start,
+				  subprog_end - 1);
+			bpf_diag_report_program_structure(env, i,
+							  "jump out of range",
+							  reason,
+							  "Keep branch targets within the same subprogram, or use an explicit subprogram call.");
 			return -EINVAL;
 		}
 next:
@@ -2919,6 +2929,13 @@ static int check_subprogs(struct bpf_verifier_env *env)
 			    code != (BPF_JMP32 | BPF_JA) &&
 			    code != (BPF_JMP | BPF_JA)) {
 				verbose(env, "last insn is not an exit or jmp\n");
+				scnprintf(reason, sizeof(reason),
+					  "Subprogram %d reaches its last instruction %d without an exit or jump, so control could continue into the next subprogram",
+					  cur_subprog, i);
+				bpf_diag_report_program_structure(env, i,
+								  "subprogram can fall through",
+								  reason,
+								  "End each subprogram with exit, throw, or an explicit jump that keeps control flow inside the subprogram.");
 				return -EINVAL;
 			}
 			subprog_start = subprog_end;
@@ -2991,6 +3008,11 @@ static int sort_subprogs_topo(struct bpf_verifier_env *env)
 					verbose(env, "recursive call from %s() to %s()\n",
 						subprog_name(env, cur),
 						subprog_name(env, callee));
+					bpf_diag_report_program_structure(env, idx,
+									  "recursive subprogram call",
+									  "This bpf2bpf call would make the subprogram call graph recursive. The verifier requires a finite, acyclic call graph so it can "
+									  "bound stack depth and analysis.",
+									  "Rewrite the recursion as an explicit bounded loop, or split the logic so subprogram calls do not form a cycle.");
 					ret = -EINVAL;
 					goto out;
 				}
-- 
2.53.0

