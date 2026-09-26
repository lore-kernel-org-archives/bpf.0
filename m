Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7946AA96
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790432464; cv=none; b=eUVD+Liu49yGe+EOlIxo5e6cNbgPXFa+No9G/zR0dh0ytaqtziWyNuoagGAFSKjelyRju8YI+jMmO25w+lwP11b8Gli6k8CU8Z9sv32L/51g7P1O0e7O2/FhaH75F3v8j6YgQEosC4zoK19t3S6yBLZZD4T+tdCsiuiKxlL1SSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790432464; c=relaxed/simple;
	bh=nYLpeFnUGb/Mb2euR6CUsqaSNpw44zxYsVakbC8Bb08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VZ8HygCuziIQvqij64bzezeShYVUBrD2gu+BR1uRB9ekJcvrQzftduM+27gfPTVarOSc1b+uDf4gHGgtLLXSnEhPF9e5vZE41LaCXbuxGpaHmusg2BgnX9aiKrMs5LzU38B5CqTX7UKIFy+p/UpYtxSXO95N6TzWW14js+5H4/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xy9Q167k; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy9Q167k"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0df0bb2d6so303585a91.3
        for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 07:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790432462; x=1791037262; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gPXCjYrURaOu4fDTj10bUeDOvwRn/XafSyJluoHsksI=;
        b=Xy9Q167kFgfQOPBNLndqdo94yiVS380qbGUpa7B0+ApTGlssXQgInTgVzVLbF0SSaQ
         JqxtQ69QBgB3a8Lb+F/apMsUMpYouaZi7V2pA0YgERSry8riqBXqWo0vA/SDt6XjPU2y
         kvdFD2GEisgFIUUe3pm1tFY0jBcoBEAkfVuhpbR1HXWnYZ16iGlTdeERZefJ5UpU9Fg7
         80/f5DmiPvIrqpheiKLihixWdqr6t9xRWzSvgsrcuMqdvebB5bcy2vvC5QeLf8NWZHFC
         di0uCf908OLKm/oQZjxV8GniOUFLUEta+Noapi9ZDWdrflqErB077/ULqgUwIU9guBr+
         Dv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790432462; x=1791037262;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gPXCjYrURaOu4fDTj10bUeDOvwRn/XafSyJluoHsksI=;
        b=sx90tABoCLUUD9bn5n8SNRcbCSKdegjrccJPPrxGi0SRIS/4c0t2lfnr5WcXTFGfVd
         uxkFIv2JIKCjj5vFREst8ZEKR+VZ3RBR+2ZxQdrPA+YxCPI5IQ30te823E3cgNqjdW3T
         jdgA50EucUkuxp5yccMkr9dy53lv4zpbLttuIPl8u+iJ4J014E/ph9PZnvzgduzzwdJ6
         WPtyMqmHB4wouvtvaZX5wXmhXm5ULEB+pzISxcEhohnjjK7PfBzgGV3s0iljckhOyKhz
         Ul8dhUwK+PgVinQrgPsAEa0iiC/kRS4/UOIa6VHodaEObShy9YCSmXDSQuXc9svCiEKr
         MX1w==
X-Gm-Message-State: AFq9FYLVkRjpR+bUNjDMarlsjY/d/Lz5pi/Js/wESQ3Spae3A2LvD61+
	tMSyUEF6Cdb2+k3EKKzqre6e7X8BR2lkXs1mZsMA1OujRcMa9cYlCn1oLp8kZVL9wzw=
X-Gm-Gg: AYBFou0nmPy1pDHwTJMFLIcFA4vxaPNarDPrz3WsS6WZKkfs80t/frBn4Kh1fPDS/bB
	fLQCb3BcYR+zr/NBSrQu6JqXg6Zs5Er6SjHoO7ZX8BAooS3nGHjUdpIqdm6/ey7jOPWhfr32NSM
	b3p5PIdEpIGRr0feipZNQ8hXdYupNCx9GKyqMvDWOHgHAivzp+tSMIm6NhL0K0Lkz0tnAj4Zhab
	ZCFw0SqHOzcasHe4wYzmswVgJxaUPRGh/lanA9SSKvlumLox/7nnqUetM8mejKWx3kcJXTFksb5
	eXxNVONKmj6sZeoUwuvi+FYgIq0H0RuCyOi2U6ImpyHjnkf2yB6dodxa6dfxeER8ZGeGB8O1eQ+
	SocMXRmsxueVuXD9UfFr4/o7HHJLf9lwfUcGhXmceUeaL2d0ymD8PMQQa74m2ao5HwSNYIULuwk
	/xvvowvT7zujS7+AP/Yk+y5S28DwQcsYRQBSO6CGLdKv8kFKuN7uKC9NEpmWTK1QT2oRqF8nTOM
	3RuGEy43qBTSTkJVhxGum5ADlE6gxsj0SxN/5MZOg==
X-Received: by 2002:a17:90a:4c85:b0:3a0:aa65:2bb6 with SMTP id 98e67ed59e1d1-3a0aa65315bmr3624470a91.29.1790432462076;
        Sat, 26 Sep 2026 07:21:02 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c2e986easm10949613a91.1.2026.09.26.07.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 07:21:01 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 17/36] bpf: move the live-register and SCC printout to a standalone function
Date: Sat, 26 Sep 2026 07:20:15 -0700
Message-ID: <20260926-scev-minimal-rebase-v1-17-c8e5ab5ba79f@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
References: <20260926-scev-minimal-rebase-v1-0-c8e5ab5ba79f@gmail.com>
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

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/liveness.c                              | 28 +---------------
 kernel/bpf/verifier.c                              | 37 ++++++++++++++++++++++
 .../selftests/bpf/progs/verifier_live_stack.c      |  2 +-
 3 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index 6b2f1bdbef7f..cba3a6c021b4 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2631,8 +2631,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	struct bpf_insn *insns = env->prog->insnsi;
 	struct insn_live_regs *state;
 	int insn_cnt = env->prog->len;
-	u64 pos, insn_pos;
-	int err = 0, i, j, subprog, start, end;
+	int err = 0, i, subprog, start, end;
 	bool changed, ret_reg_pair;
 
 	/* Use the following algorithm:
@@ -2711,31 +2710,6 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
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
index 40ed20693936..474caf8696fd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22580,6 +22580,40 @@ static bool bpf_prog_reenters_datapath(const struct bpf_prog *prog)
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
@@ -22785,6 +22819,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	if (env->log.level & BPF_LOG_LEVEL2)
+		log_program(env);
+
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 7e2e165a7145..6b295b30936d 100644
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
2.55.0
