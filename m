Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF89439346
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121135; cv=none; b=NhsW/sNwhaN0Hsshy9LI2BYp1/S2kpfJ++AXUgY2SwvMSpVcaLMQEEXtOcDnQS5FMD+vPuC1IzqqeMPnZJGY3Lmnw0JF57rHwlx0im7bZnd3zxliCx1vKX10l3/EQuseiR3kA79UkAzn43shQRYiYVISscvFoe/QI+rtBrb84Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121135; c=relaxed/simple;
	bh=8L8ut9f6mWZWcfZaEJeKOnA2OQhV+ro//nLZ+ws4cDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X/ivnDNbDNKs9X5yS1WDeopI6bsXzHWa/AXONMCP1VR/YlzSJOpYPpVRSYTYzsO6ePWS26HiMsvDUJT4K8QAUWkyRWavOh9yt/uTIOCpMhqVnxuMt+tKjja4+9pE1LoeK8B5f56DdjGAKoxs4sYA+15i5/JKC/pUa7N6s/P3IMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a28Zdfpg; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a28Zdfpg"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so185451a12.0
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121133; x=1791725933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wb6FI/CINCxZ+pJEVTCdoFeQPL1zDZRkoW4Hy0vdpaQ=;
        b=a28ZdfpgHQjylGOt2MA2qOUkyWUqIDNwkf2R/ga/8aXAOAHsSISkRjXqYMdDUsF3a3
         vkO4J8XjgQkzFAFuUKDq0Vm/d/I2LpfjKqPKPHKDx2gp3KYJD7Lverz7jvFZpG6Cs4Py
         Tblg/r2rKRaoLFZJRKVIAPZBPaYjJjbQ3w5EwqnIOPZNpBO+CdKPyRGfJ/OGKZ03pXUH
         3NBSvHwNqajN2ZMnuOaPAODbDxxzwhuvPgPGQ1nmmeQBuU9QmqUhLpWOz0cRZ8U3M9wL
         3/UQ82RxRgYljSLkzW/mxVkRmBAOD0lFfyf4kRUloAsYylvuM7FpTzSqdr61lXh3pc4N
         ZmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121133; x=1791725933;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wb6FI/CINCxZ+pJEVTCdoFeQPL1zDZRkoW4Hy0vdpaQ=;
        b=t+N7u3UmVgWEsWXZqehwsuoX9TSX5Myr6mjx043u4xFAZUzsC9WEpv5leItq3zfvgc
         uH6BfmB4Ka+A3HPujUEWCM59XDoir4JNhwmGggfcmXQFjQUMev2O8o0aQTCQd9w4XkH0
         fb2xh3WC3IfGOz+zITdMpCPI/lVN3KhwI6HcZa4Xz//tg0ODmgZV4XnVQQl/knD26XyJ
         RypOowYDZP7KsX9wXEiFzu0EikVuewCbTfSIdaXwLxMoUM3D0G8d9yfCu+CVZfb0pNJ0
         eev+P/nM4hYz0DPr/ZhFuMwdsgVG0HxeU4hc/Zun2QwNUI4XoEfGQ6oX8C86ZKmq4vyk
         gYTg==
X-Gm-Message-State: AFuF++nIq2mmTlLK7YS2hK8TreqVxFy8O/Jbo34IStu5VdBPuH+hf3lF
	Fnk1ZHI1hlHH4rHriVElYPI6FVia3oBVNhbSoQrqNlBqniMcLHE3rNTPtKjN4w==
X-Gm-Gg: AYBFou0G6DnWi9lB2FserrYeecMmCJVBAXuhmR0QqrzateQ8byzvtIGin7gzx3MH3Rd
	nxgt53BZ2IVa0QDokJGNsiSHBj5HUKJGrJUnarOj+V/+jV2x2fNpnlVf9todNxiKuu879L1M1ch
	5S3ULkeGF6ZAW0VWGcnWLMcRcNulgAxPHuWEDMxXuU8VvqO7uTb0ji4+wDPAwG9+vXbwgcCJKOT
	8X3pSmUkea7Zh27Tewgd/EsmAE4zf13VlWmOkfYubvGxvoRtvkrFxryU90qnp2vvcObO0Z6tlIb
	yVMYKZUub48y/q2z2vX2NVT8SeDWZODo3oQvKDKm1DkQeGZemNxNhxgW7ucaSh06GFkD/mELrRE
	K+L/HsCSskcTDI4R7Bokfx24o4HSqrZofKqqxodoHZm0zhQJ206wJ1GFKeaAZmQYMZ3yYff80Gt
	hNqZ4p1VK2hEFPV6HX/EO/yEtZf1sr3ke9YXKC2362FEFDesVPey1rpQNw0pcObBkwZFRIX+a7t
	ukQtwljzxCrh5o=
X-Received: by 2002:a05:6a21:6185:b0:3d0:8cbb:8c2d with SMTP id adf61e73a8af0-3e0bcaabfdbmr7303334637.4.1791121132732;
        Sun, 04 Oct 2026 06:38:52 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:38:52 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v2 17/43] bpf: move the live-register and SCC printout to a standalone function
Date: Sun,  4 Oct 2026 06:37:59 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-17-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Tests for multiple analyses performed by the verifier need the
verifier log to contain analysis results alongside the program
disassembly. This patch moves the log-level-2 program dump from
bpf_compute_live_registers() to a standalone function called from
bpf_check(), in order to provide a common logging function for such
analyses (and thus avoid printing program disassembly multiple times).

Rename the dump header from "Live regs before insn:" to
"Program dump (scc? insn#: live_regs_before):" and print available
source-line information before the corresponding instructions.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c                              | 28 +---------------
 kernel/bpf/verifier.c                              | 37 ++++++++++++++++++++++
 .../selftests/bpf/progs/verifier_live_stack.c      |  2 +-
 3 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index ce74e3f16eef..d5cee598f4c5 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2624,8 +2624,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	struct bpf_insn *insns = env->prog->insnsi;
 	struct insn_live_regs *state;
 	int insn_cnt = env->prog->len;
-	u64 pos, insn_pos;
-	int err = 0, i, j, subprog, start, end;
+	int err = 0, i, subprog, start, end;
 	bool changed, ret_reg_pair;
 
 	/* Use the following algorithm:
@@ -2704,31 +2703,6 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 		insn_aux[i].zext_dst = def32 >= 0 && (mask_hi(out) & BIT(def32));
 	}
 
-	if (env->log.level & BPF_LOG_LEVEL2) {
-		verbose(env, "Live regs before insn:\n");
-		for (i = 0; i < insn_cnt; ++i) {
-			if (env->insn_aux_data[i].scc)
-				verbose(env, "%3d ", env->insn_aux_data[i].scc);
-			else
-				verbose(env, "    ");
-			verbose(env, "%3d: ", i);
-			for (j = BPF_REG_0; j < BPF_REG_10; ++j)
-				if (insn_aux[i].live_regs_before & BIT(j))
-					verbose(env, "%d", j);
-				else
-					verbose(env, ".");
-			verbose(env, " ");
-			pos = env->log.end_pos;
-			bpf_verbose_insn(env, &insns[i]);
-			insn_pos = env->log.end_pos;
-			if (insn_aux[i].zext_dst)
-				verbose(env, "%*c; zext", bpf_vlog_alignment(insn_pos - pos), ' ');
-			verbose(env, "\n");
-			if (bpf_is_ldimm64(&insns[i]))
-				i++;
-		}
-	}
-
 out:
 	kvfree(state);
 	return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3298e2192239..c5a3b0f75742 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22736,6 +22736,40 @@ static bool bpf_prog_reenters_datapath(const struct bpf_prog *prog)
 	return false;
 }
 
+/* Various log level 2 information about the program */
+static void log_program(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *insn_aux = env->insn_aux_data;
+	struct bpf_insn *insns = env->prog->insnsi;
+	u32 insn_cnt = env->prog->len;
+	u64 pos, insn_pos;
+	u32 i, j;
+
+	verbose(env, "Program dump (scc? insn#: live_regs_before):\n");
+	for (i = 0; i < insn_cnt; ++i) {
+		verbose_linfo(env, i, "    ; ");
+		if (env->insn_aux_data[i].scc)
+			verbose(env, "%3d ", env->insn_aux_data[i].scc);
+		else
+			verbose(env, "    ");
+		verbose(env, "%3d: ", i);
+		for (j = BPF_REG_0; j < BPF_REG_10; ++j)
+			if (insn_aux[i].live_regs_before & BIT(j))
+				verbose(env, "%d", j);
+			else
+				verbose(env, ".");
+		verbose(env, " ");
+		pos = env->log.end_pos;
+		bpf_verbose_insn(env, &insns[i]);
+		insn_pos = env->log.end_pos;
+		if (insn_aux[i].zext_dst)
+			verbose(env, "%*c; zext", bpf_vlog_alignment(insn_pos - pos), ' ');
+		verbose(env, "\n");
+		if (bpf_is_ldimm64(&insns[i]))
+			i++;
+	}
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	      struct bpf_log_attr *attr_log)
 {
@@ -22944,6 +22978,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	if (env->log.level & BPF_LOG_LEVEL2)
+		log_program(env);
+
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 3ba21430bb75..0e6f25a09b5d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -66,7 +66,7 @@ __msg("stack use/def subprog#0 must_write_not_same_slot (d0,cs0):")
  * but the write conservatively marks the whole frame as may_def.
  */
 __msg("6: (7b) *(u64 *)(r2 +0) = r0         ; may_def: fp0-8..-{{(512|2048)}}")
-__msg("Live regs before insn:")
+__msg("Program dump")
 __naked void must_write_not_same_slot(void)
 {
 	asm volatile (

-- 
2.53.0
