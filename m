Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972F9455186
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788597271; cv=none; b=SOhbCxJJlkUiS8QfW3qv846BrYNWIbw7arsoUKRz8M+7NXA8XpuXexsHot/VnvpIW9xO7AtvY5rRGBh0BcEfxfzGek+Jgh0Tp7e/2qOTJksExpsNu+dg5VCAQbyQ0ZhBlOsKXiK1pVPRnk3wTwq7p7SnJDJtvfKuo7Re63CJu9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788597271; c=relaxed/simple;
	bh=6bnWaGYBPIlPAJF4wCUhV0SkVqiCekIf4B3sWUrKHic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvT8r811n0bA9BUAbtYcrjV+C7keI8S3AVHnNfxu9JFtzs197LsCZyFI3S/2tMbclykqzYbS+rSywA0/7RDW620U9pm0jBtkwAuu0/L+DVyNdjEQp5KlLq8EOZogiAbq5/7s27PI8ArPXGyaWz6s/AIBKH9RWcC+PFthikeKpoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSPxfJ+y; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSPxfJ+y"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b92ccb8e0so4956225e9.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 01:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788597266; x=1789202066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rd+Ay2xU3OpPm2PLYk+HfnkJqfAjwOwJmvSvxhVRUBQ=;
        b=WSPxfJ+yBmivHHc8IhtTzMt9quUffeWlZUqB8g6gWX9Efn9Vcw/C8NG03xThQRykQy
         rog26fHiX2xpX9uINeWi2aqR83WZbZeMTCG9jQxCAoblc5UWHXk6U/lv8PeC2VC5VxqT
         QWilLF5DHfApIC7vuR0JnV1zrKX4RgWOb8OWO+OnEFyJDS/JcoDc6fehi0p0jfs+xVVO
         850Grdol65QTehvCuJXWowWqUURAAORwETNNxSVsnsX1J1rH9bwFchKJpEqefUoOxG98
         Fbrn5FDYWHZstEFC7Ilp2DEe39f/1asE7bo08Q1fkBLVNpx/4Dcp3sq1a8IowDBIYQ55
         oWIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788597266; x=1789202066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rd+Ay2xU3OpPm2PLYk+HfnkJqfAjwOwJmvSvxhVRUBQ=;
        b=Eb1IfvU8OKk/8S/JX66eUligSpforUSh/9tNp/ANfckgeRwirkQHFhbTEwRy1nZ0Fu
         7NNaxZgPdhm3YjUHsBAbe6c4wNRRJbrmxwQ+2HOsb0h+O66KdG+vARV3QMbKWyQBBmNS
         hHsGV+Uq8ALTsDQHGuEn3meZEvNKXddHyx7h7BUvlUcMpLQYoZNceJ02EDqFal+FadRx
         4OCXANzqfde5euK/NRDTMoYGZVF31ece08N9FwmFIDmpAONVYkZjTknl5+fax+XtLZF2
         6i1xgU+Sc9BrnA6uRM2LPrfvS/AGEDEUavOb0kHPPWpAISKCglQojU9FmsovdtEdP8gh
         gQeA==
X-Gm-Message-State: AFuF++lYxvGMGk+pv5+wqvr+Z4Q+Ct4iebQX7bexMJ50o4FrbEW5kyUB
	SHHId8BXLlljqKcyz5bkaDqr6l1nHhPo50+cC/jIcKWJeRqtzcWO5pcWr0LjZuyF
X-Gm-Gg: AYBFou39NZqIi30xzJjLn8WGZb8ARMuGqiHzxOqSw7qOQ8SFXIKZeZgp0D6S2tPKfc7
	celu3kiwsY1iTct3tOU4y1pjTGMg4efMWpB6w2dvjWCXOBg81XJl1OCxZSOwfh24rCfZqRJG4R8
	B1ajy9gQ//e84mYpMZLyGjep/lGUU+ypH3ZtdW8c08gImseUK4sfCc3xtMAFGp4aFywRETfa4d7
	KgKADXJctwHkmRdAo5Iq4HLOFfvTOJDCfF3HF+qE5/2xOkwdxLbQc3jhP5cRRrbZYVTBdtYYelf
	UDLLFyFKEwyGKByM2NQ0piakUXZCpqMvYngfrkSdO8cpKhvFL4Qh+VlIyBbtoi1f0d4b/K6t7Y0
	dDcjUt9rxn3P6/PvFXF8WF39TF6kO+nvko7Qq6dCx2G0q5vvAtDU5PzwN0xc/MwidBH0iSu6jSN
	HRsHCkVMd+sGbW+f7s3th1QUS4LgLiEB/L10GhF/dwQyWdWr4yGgTePkpo9n31svD1E6jV1aUGf
	hZjVcQ72V7qs1VsUQ5XBpYRgZyCYUWnj2QU6oKwvD/vJgXFWWECv1maRbvu307UV2v8YYtwS58l
	4mZkfCWB5j/efqElF4Hn8iH48uY=
X-Received: by 2002:a05:600c:3588:b0:49c:fc6e:a3d7 with SMTP id 5b1f17b1804b1-49cfc6ea7d5mr81038725e9.22.1788597266367;
        Sat, 05 Sep 2026 01:34:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cc7sm134596995e9.4.2026.09.05.01.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 01:34:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 4/7] bpf: Reject fall-through across subprogram boundaries
Date: Sat,  5 Sep 2026 10:34:12 +0200
Message-ID: <20260905083418.3723623-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905083418.3723623-1-memxor@gmail.com>
References: <20260905083418.3723623-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2862; i=memxor@gmail.com; h=from:subject; bh=6bnWaGYBPIlPAJF4wCUhV0SkVqiCekIf4B3sWUrKHic=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv2pQLxrdXnQ622LvbR7lIVs+DIy9+X/2nTvFsvqsV+d OozHfbvKGVhEONikBVTZCn5v4/J+ETl70DbZdwwc1iZQIYwcHEKwEQsdzIy3J0o6Mge1uoaOlMu O159hWZdDq96lH+f45kdNzt3xi+9x8jweLKrcEqijr7Ulsitr9mZl9zR2l47OX5X/POb1hO53eq YAA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

check_subprogs() verifies that each subprogram ends in an exit or an
unconditional jump, preventing control flow from falling through into
the next subprogram. However, this check runs before CO-RE relocations
are applied.

When a relocation cannot be resolved, bpf_core_patch_insn() poisons its
target by replacing it with an invalid BPF_CALL. A relocation targeting
the terminal instruction of a non-final subprogram can therefore create
a fall-through edge into the next subprogram after the invariant was
checked.

The per-subprogram DFS in bpf_compute_postorder() then visits the next
subprogram twice and writes past its prog->len-sized postorder array.
Stack liveness analysis relies on the same containment and can access its
per-subprogram arrays out of bounds as well.

Reject fall-through edges whose endpoints belong to different
subprograms in push_insn(). This reestablishes the invariant on the final
instruction stream at the common CFG edge insertion point. Cross-subprog
pseudo-call edges remain valid because they are represented as branch
edges.

Fixes: efcda22aa541 ("bpf: compute instructions postorder per subprogram")
Reported-by: Nicholas Carlini <npc@anthropic.com>
Suggested-by: Nicholas Carlini <npc@anthropic.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/cfg.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 842c7d1eabcc..e3c904328ede 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -102,6 +102,7 @@ enum {
  */
 static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 {
+	struct bpf_subprog_info *subprog;
 	int *insn_stack = env->cfg.insn_stack;
 	int *insn_state = env->cfg.insn_state;
 
@@ -121,6 +122,26 @@ static int push_insn(int t, int w, int e, struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
+	/*
+	 * check_subprogs() prevents control flow from falling through a
+	 * subprogram boundary, but runs before CO-RE relocations can rewrite an
+	 * instruction. Reestablish the invariant on the final instruction stream
+	 * before constructing the CFG used by later per-subprogram passes.
+	 */
+	if (e == FALLTHROUGH) {
+		subprog = bpf_find_containing_subprog(env, t);
+		if (w < subprog->start || w >= (subprog + 1)->start) {
+			verbose_linfo(env, t, "%d: ", t);
+			verbose(env, "fall-through out of subprog from insn %d to %d\n", t, w);
+			bpf_diag_program_structure(
+				env, t, "fall-through leaves subprogram",
+				"Keep fall-through control flow inside the current subprogram.",
+				"Instruction %d falls through to instruction %d outside its subprogram.",
+				t, w);
+			return -EINVAL;
+		}
+	}
+
 	if (e == BRANCH) {
 		/* mark branch target for state pruning */
 		mark_prune_point(env, w);
-- 
2.53.0

