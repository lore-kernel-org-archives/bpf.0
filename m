Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8333262F
	for <bpf@vger.kernel.org>; Fri, 29 May 2026 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780042416; cv=none; b=ik0zUspg4+YCSjCBQstmyK0tua5VHOb72HaGYdBc07Fdf323MKBE8qbXGnteJ85M9kr/sNLdlxnJr+NDkhjE70iRv5/+zCzPfiAkV9rNUZEkrtmPHwOup4FO/P9Ce91hC8Bucw9d95v6jZZRdy2j9CCh4tgA+yuT5EcQ1rKhkaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780042416; c=relaxed/simple;
	bh=MGr1x5OqCs2UldfenVxbXMTSNwkTIbJIB0X5IHXr+U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIsOJv4SChhxOe+aaEZhiyDFG9Oopvrktj/0v6NAd+tk1YJSq1m18+Eq8vRJB9icqbwrqy2r6dnjHJkGWCJl/ux/iK6t+J98XamqejK1qv2yBpsowhsHz+Y9Mm1sZuL52JCL7Th0BMZXOeYF5UJCeUJXYaMumWIHwoq3JNb+3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iIV3Z7AD; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iIV3Z7AD"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2be1dd4af34so122804285ad.1
        for <bpf@vger.kernel.org>; Fri, 29 May 2026 01:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780042414; x=1780647214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/BNBfIehe0OfmIYJrKDlQlIbzA5NDFu7hJ/cJ0o/Y8=;
        b=iIV3Z7ADBtyhqn4hff9Wv5P9HbWKO+B5cod61SAnvKVYdQyENwi3PndSCeEtqeTOvN
         zwSRLZftZwA84f/U/Jed+yyomySE1l59Z5PCgagN1Nujb9ilXy4Lr+RupUMMXU3hHLYh
         Q4Mp1/CWRdSbPzZwOqlufHUnL1FsGm5W+twkmw+0MMDsbP1J+a/4rEB77EiUWvGkP9H7
         Mi9jI06DaYzikt7/hifozAlPXhKGk0aUz+y728rjNtLgY4hRhxyGEInpT/KvJMiAYQvB
         rf0zwMZ6e9QDWZqch+POvv60rRz2++mXXqBh6nGnJ97WsEzbu7QzZcAy/I2dyux2ZHzI
         4RrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780042414; x=1780647214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l/BNBfIehe0OfmIYJrKDlQlIbzA5NDFu7hJ/cJ0o/Y8=;
        b=EHjY8nm5ZFz2sG7dro7EA+g/nXCzFeoRlb5DhjnrB5bZv4/d5EOT5cxpsGjM6s6tIn
         ZCWBrcWU6RUGWLkKIrI/GdwbBnTwVGytRATkDr67Iqud+4rUrNk3BbK1e4m/PLU+ocvu
         Np+qlD6ezXNWkqiZfPGPcm/5H/yL55WobEeZjS0rn7vLtfYPxy7ocOQrlmGDVqVPq/RC
         HM31i55wt8w+cjzE464BXq9G6B4AskjjEglZLaQA2cG87tq39txAiPA63TT3MsjaEHH5
         f8foMa0d/qIuBDq2rgWBWD7FEp9OHvzRTcPViY+J6kr+oWNDLAyVI40+HVMwZGlotyBb
         ilgQ==
X-Gm-Message-State: AOJu0YypB34raFQDJePkZzv5HJw5rivI3/4/myg5vQXYapecpVDg2e5n
	heDS3LGazdsj8SqSiRLQIt2ABqB1SvvPOOr+nQrbPJ1tzcmaUsAl7KOUITyrBAnM
X-Gm-Gg: Acq92OFKRxxMfqVNhADKcPelXUVJHyt5UlesdAbAVqU8AP8Ms4F32YEzbVVdTuuYeE1
	uy6JAlHtkn5XQwGcEtzzM+h/7s78m+iktyEsb1xgcBqcV2tNFHj4l7rd/2ia6oHN6t2rpvQrnae
	czdYm7uhuWwIbohMIqEQ0iDfzrR/5b1vnY+IYkb3v8J0RXuOnhg5M9sl/ets5cCf7yptOr46ute
	eDwZnj747Jh9bsV8XH8qgOQM24YPboao7Oe5BL9san3wjc5tdv0lEUJCFCv0foQ4rHZ1ZbvW/Oo
	e2nSur29aWYjgpLChNambcVJyQg7nRDaX0BkrlQqG0DE+VloC5c+u4fMYKUx1S2wMVwAsUIFDnO
	n6RQJb0k+uBQRUpn0/iKQRzfiwWxlNLqpsBsq/UYjeQMDFT02Qn5Dt/EuzKGn7+sMCdbVkCcxO4
	3NrgHYu1SyyXxzxBCOlTVvu2TdgguImGdpe2t0Zi74fBByXrRymlw=
X-Received: by 2002:a17:902:d50a:b0:2bc:db02:d1ed with SMTP id d9443c01a7336-2bf20ce46f5mr25789235ad.38.1780042414167;
        Fri, 29 May 2026 01:13:34 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf239e6f57sm10806715ad.13.2026.05.29.01.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 01:13:33 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	zhuyifei@google.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 1/2] bpf: fork state when comparing sign crossing ranges with zero
Date: Fri, 29 May 2026 01:13:19 -0700
Message-ID: <20260529-cnum-split-at-zero-v1-1-986c03752226@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529-cnum-split-at-zero-v1-0-986c03752226@gmail.com>
References: <20260529-cnum-split-at-zero-v1-0-986c03752226@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

YiFei Zhu reported the verifier regression after switch to cnum based
scalar representation. When the following sequence of instructions is
processed:

    1: ... rX setup with [negative, positive] bounds ...
    2: if rX == 0 goto ...
    3: if rX > C  goto ...
    4: ... code relying on rX being in range [1, C] ...

The comparison at (2) is processed by cnum{32,64}_intersect(), which
can't punch a hole in [negative, positive] range and over approximates
by leaving rX range unchanged, leading to a deduction of range [0, C]
at (4). The pre-cnum signed/unsigned ranges based representation could
always deduct from 'rX != 0' that umin bound is 1.

This patch introduces a workaround: when'if rX ==/!= 0 goto ...' is
processed and rX has [negative, positive] range, fork the verifier
state and use current and forked states to split rX representation
in negative and non-negative parts.

The fork is placed before the branch is evaluated, so that the forked
state re-enters check_cond_jmp_op() and gets mark_ptr_or_null_regs(),
sync_linked_regs(), precision tracking processing w/o additional code
changes.

Reported-by: YiFei Zhu <zhuyifei@google.com>
Closes: https://lore.kernel.org/bpf/96c4a1aa4333d10b882a9b5093d2d982f9f106e3.camel@gmail.com/T/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c8d980fdd709..7998e8da5e55 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15965,6 +15965,73 @@ static void sync_linked_regs(struct bpf_verifier_env *env, struct bpf_verifier_s
 	}
 }
 
+/*
+ * This is a workaround for a specific pattern:
+ *
+ *   1: ... rX setup with [negative, positive] bounds ...
+ *   2: if rX == 0 goto ...
+ *   3: if rX > C  goto ...
+ *   4: ... code relying on rX being in range [1, C] ...
+ *
+ * The comparison at (2) is processed by cnum{32,64}_intersect(),
+ * which can't punch a hole in [negative, positive] range and
+ * over approximates by leaving rX range unchanged,
+ * leading to a deduction of range [0, C] at (4).
+ *
+ * The workaround is to fork verifier state when:
+ * - 'if rX ==/!= 0 goto ...' is processed
+ * - rX has [negative, positive] range
+ * The current and forked states are used to split rX representation
+ * in negative and non-negative parts.
+ */
+static int maybe_fork_cmp_with_zero(struct bpf_verifier_env *env,
+				    struct bpf_insn *insn,
+				    struct bpf_reg_state *src_reg,
+				    struct bpf_reg_state *dst_reg)
+{
+	struct bpf_verifier_state *fork, *cur = env->cur_state;
+	struct bpf_reg_state *fork_dst_reg;
+	bool is_jmp32 = BPF_CLASS(insn->code) == BPF_JMP32;
+	u8 opcode = BPF_OP(insn->code);
+	bool swapped = false;
+	u32 fork_dst_regno;
+
+	if (opcode != BPF_JEQ && opcode != BPF_JNE)
+		return 0;
+
+	if (!is_reg_const(src_reg, is_jmp32)) {
+		swap(src_reg, dst_reg);
+		swapped = true;
+	}
+
+	if (!is_reg_const(src_reg, is_jmp32) || reg_const_value(src_reg, is_jmp32) != 0)
+		return 0;
+
+	bool cross_sign32 = is_jmp32 &&
+		dst_reg->r32.size < S32_MAX &&
+		cnum32_smin(dst_reg->r32) < 0 && cnum32_smax(dst_reg->r32) > 0;
+	bool cross_sign64 = !is_jmp32 &&
+		dst_reg->r64.size < S64_MAX &&
+		cnum64_smin(dst_reg->r64) < 0 && cnum64_smax(dst_reg->r64) > 0;
+	if (!cross_sign32 && !cross_sign64)
+		return 0;
+
+	fork = push_stack(env, env->insn_idx, env->insn_idx, cur->speculative);
+	if (!fork)
+		return -ENOMEM;
+
+	fork_dst_regno = swapped ? insn->src_reg : insn->dst_reg;
+	fork_dst_reg = &fork->frame[fork->curframe]->regs[fork_dst_regno];
+	if (is_jmp32) {
+		cnum32_intersect_with_srange(&dst_reg->r32, S32_MIN, -1);
+		cnum32_intersect_with_srange(&fork_dst_reg->r32, 0, S32_MAX);
+	} else {
+		cnum64_intersect_with_srange(&dst_reg->r64, S64_MIN, -1);
+		cnum64_intersect_with_srange(&fork_dst_reg->r64, 0, S64_MAX);
+	}
+	return 0;
+}
+
 static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			     struct bpf_insn *insn, int *insn_idx)
 {
@@ -16038,6 +16105,10 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
 			insn_flags |= INSN_F_DST_REG_STACK;
 	}
 
+	err = maybe_fork_cmp_with_zero(env, insn, src_reg, dst_reg);
+	if (err)
+		return err;
+
 	if (insn_flags) {
 		err = bpf_push_jmp_history(env, this_branch, insn_flags, 0, 0, 0);
 		if (err)

-- 
2.53.0
