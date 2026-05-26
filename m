Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC27B3D7D78
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779787827; cv=none; b=lJcqDqOQVVHoYIRlP+kAFm2LOwbKakjILdPM19zXH7//S8oSV6xrSl3lqDB7ni+oXMulIKU/NVcgUx5RwnLQyQmQUJ/zf7N5xD5j/wZMNRQ7NXpD+DFHwU+LYbqZMopHxkuNS+3VKROd/YpeqifNEBX5/1bZKUdLRGO7pc2PB9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779787827; c=relaxed/simple;
	bh=00LfnSRhQPc8NwCIz1Zo0P0wM1qahPv0VdmWV7pRIcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L9lov7oFS/lauCPmAzEYz+hTR4v9GOQmr6eU+AQs89zVFfHihyRbZKrtnPjw7VZvr5EIGff/ftOu0XLMkbWRqEv0ao1oTwvME+0AQpzS/P07r56WlbYkOjBkAx/ZKz/j/44dSSmq7SXwdUygo5uZJXmnuWFSnY2aXUUhXrf7Vpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keOuYM9w; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keOuYM9w"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-837b39eb078so7159240b3a.2
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 02:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779787824; x=1780392624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npGqVhP8n9x6x471sGBoVF4CI1h8RVxBdHiIBPxf/24=;
        b=keOuYM9woliK78xwfXq0fNyNmLOFHEcQZX/t7vSl9SnbRFQhJmdqYeLN1DGqwFb0qD
         1YKpkrwnq9EFJzfvzfAXM4oDkThEr4raIAwvr+vUzwofnfkpYkDg9FMG/BkqEeCNAkSH
         hBFYmt3SqfyxyNm+R7FMH/TAtmZJC0U6JHJpJFF9NUkMH6GPjddTW+25TuTIBPmXEUzt
         A/br2+QCN5Q8Ztxy1DmQoZnvi3N89z4OWYwmNWuhWlOUqXredesFFTKyHQBI0HhHKs2U
         IPpRBaUp6syrOTFpKiELsE69NGiQLyxR6j8982WNVOn3+ZG0NzyKoEXX3HlFWITmkx84
         BLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779787824; x=1780392624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=npGqVhP8n9x6x471sGBoVF4CI1h8RVxBdHiIBPxf/24=;
        b=OodCE2QZT0p2T4T6y1CukkejHiQHomubBN0cYFiN95BuX6yD471I3kmzcQFbpYqIb7
         90ImYwdr/VX3M45e8GZMsXEbbZc14AvJytqV45soSRYLI9dDVleTn9eBx12WDwZEc4GB
         kQCQf6+rsrhYqAMvcTc3ZPnOU9uGdjUM4Bp8h2t/zoxaEn4uKTs7F0OCCdFzNAz/oT8v
         DAcqlmA67jIo5K+g0sar8q/jnOcB2JCQEH6fVDzBe9ibvmlcspBi1gXxhfUaYIDIaOsl
         x+igDsjRMxBHch1BFnLYR0u0hSHoY4Rp9vpOnj65057fibrHvJyvTCPQdEuMp4nfQ4g9
         JWdg==
X-Gm-Message-State: AOJu0YwrC22QDHJXOCvC8xojZ+4hetZ0QJnpJhDaP65+vfJ42Tbz4aW8
	1b8OiWGnG9Ibsldc/qgn7unR6TTk8ov7SpvL3+GuZd8AJSk1v44bQgiRmEx+Mmhp2I8=
X-Gm-Gg: Acq92OFekAUekOmGabvle6y4flkPsewsF3wCBdGbeq9GAIX+LggETwt5V8xluv4PiCP
	QdSOuyP79Yo8l8FHpkOiwLd673G1JYvNpHzPiZOqoRhS05wIVjBKFkAPaIKr1Km3nq0ABBWyVRI
	ZnD9jDcX6obCzX+xgATKh/jXyKr4Lsczzub4RPcA8t9ntHjvR9xD9rcyfQJ1pS8MZUevBTjLPBs
	YqHWyNA/8KmX5NFvj09pR2iFZWloK/HCH/ZK0ovjx5If7nCSomVbUn5tgcs3RIenPF6BKeMpj0a
	mh6Smx05psGL74UWXgEYt9dMsl5E44Oz8Hvs6WVnT5v1z53g0NTB14j2tcl33ZwOuiwjccC0kGC
	N0NoTEnTw4wIU2LHLv4qf8kq1WXekJw2aRcZW4dyTv+HvMmUn50P+ece9sf/wVxKP8xnvefRJ5b
	bTJVRYMustDV88Dq/cvs1GvTF2Rhy/kv+KFKTh4UM+
X-Received: by 2002:a05:6a00:7588:b0:841:6414:44d7 with SMTP id d2e1a72fcca58-84164147c57mr13709750b3a.45.1779787823821;
        Tue, 26 May 2026 02:30:23 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ff3e00sm13729505b3a.54.2026.05.26.02.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:30:23 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH RFC bpf-next 1/6] bpf: move live registers and scc printout to a standalone function
Date: Tue, 26 May 2026 02:30:02 -0700
Message-ID: <20260526-better-1m-reporting-v1-1-51e4f2c59780@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526-better-1m-reporting-v1-0-51e4f2c59780@gmail.com>
References: <20260526-better-1m-reporting-v1-0-51e4f2c59780@gmail.com>
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
disassembly. This patch moves log level 2 program dump from
bpf_compute_live_registers() to a standalone function called from
bpf_check(), in order to provide a common logging function for such
analyses (and thus avoid printing program disassembly multiple times).

This is a preparatory refactoring, subsequent commit extends this log
with loop hierarchy.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c                              | 22 +--------------
 kernel/bpf/verifier.c                              | 31 ++++++++++++++++++++++
 .../selftests/bpf/progs/verifier_live_stack.c      |  2 +-
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 0aadfbae0acc..16d030fdd83a 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2209,7 +2209,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	struct bpf_insn *insns = env->prog->insnsi;
 	struct insn_live_regs *state;
 	int insn_cnt = env->prog->len;
-	int err = 0, i, j;
+	int err = 0, i;
 	bool changed;
 
 	/* Use the following algorithm:
@@ -2270,26 +2270,6 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	for (i = 0; i < insn_cnt; ++i)
 		insn_aux[i].live_regs_before = state[i].in;
 
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
-			bpf_verbose_insn(env, &insns[i]);
-			if (bpf_is_ldimm64(&insns[i]))
-				i++;
-		}
-	}
-
 out:
 	kvfree(state);
 	return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c8d980fdd709..3d569e36128c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -19619,6 +19619,34 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	return 0;
 }
 
+/* Various log level 2 information about the program */
+static void log_program(struct bpf_verifier_env *env)
+{
+	struct bpf_insn_aux_data *insn_aux = env->insn_aux_data;
+	struct bpf_insn *insns = env->prog->insnsi;
+	u32 insn_cnt = env->prog->len;
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
+		bpf_verbose_insn(env, &insns[i]);
+		if (bpf_is_ldimm64(&insns[i]))
+			i++;
+	}
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	      struct bpf_log_attr *attr_log)
 {
@@ -19771,6 +19799,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	if (env->log.level & BPF_LOG_LEVEL2)
+		log_program(env);
+
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 401152b2b64f..923572df4bbf 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -64,7 +64,7 @@ SEC("socket")
 __log_level(2)
 __msg("stack use/def subprog#0 must_write_not_same_slot (d0,cs0):")
 __msg("6: (7b) *(u64 *)(r2 +0) = r0{{$}}")
-__msg("Live regs before insn:")
+__msg("Program dump")
 __naked void must_write_not_same_slot(void)
 {
 	asm volatile (

-- 
2.53.0
