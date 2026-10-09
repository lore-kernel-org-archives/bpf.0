Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0CE4BEE53
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542930; cv=none; b=EmFjoxFs5DXil/mrYvuILp8VLJ7ZuMu7Ft9hcE4HHm1PvicoxmzL42zFMjgCxlUUmxVmKfHTtyNLik2n42vEk3Oi1uxX5fdLJyL480UH4l2kasPu/w4u/x7CgKiEyM11HNyPwary80UjF/qdwxeQVLbsggh+Kf9IqY3x31IJecs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542930; c=relaxed/simple;
	bh=N/SD4swNzeqwiiGGCeSovSQb2i8AXKNngxdjuTG+hJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nB6lgfDVUoD79xIldr5wPGR1Xz8SBt2llv1SJlj+SB0Wc+ufa7KoFB/bSHQcrO4qGq8MBe9utmuJEePV3FLUNfS09dN7wg4nJuY6fb1kprUyCvJHVR+Us9usBLp5ysRYQ8jPbqTqG9RltQ2+8SRoQ/bJ/RJB2N8wnLTg8813lAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUFQM8Rz; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUFQM8Rz"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab3260b35dso453915a91.1
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791542916; x=1792147716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WZzhHW44DlJZlafoaIVcPdei6JXhqxwsTAgaeT1BBps=;
        b=jUFQM8RzDX6r0KrEX1QEfc6dBGIkesVqEEehys8SfFoUmkdpS+KfIxAdU6h5LceDTN
         +Qk3Ugt6IZ8MhLD17ymM1bLpA2EJBffOJ0eFuEIQ7qQ5JQRVEErbb5nHRSpVf0NjDg0G
         AtvcVP7NV920gWiEl9KtnkX8qeq0u/ZH1PhD8xiwCeC27G66L7T616B07982GhvHa/S5
         jHSOEgpW5L4gT42jalEMXTRvL9c8oppU5TIwWCsbQVzruk0IC+7VgEZCN+KDyRJqKllS
         IAPzGHATiNdN0urkI0cMr0LcQDMp+YOeZQCa9JuonxfJlHrYzHAVlkkW8uyR1VztgBhE
         RjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542916; x=1792147716;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WZzhHW44DlJZlafoaIVcPdei6JXhqxwsTAgaeT1BBps=;
        b=TANJNv893n/BHDFW1TUTVNHivSB9h7ezbb4sDvr2ZiW6LhCg+vOpZmKKMvy6AL8xpY
         bxJrfi147xD1RSEGLKHvpSixPWDbpG1HWL1ymG3e8PWAmDflE3c5TFqMwxmVhUvpe4Z+
         jZdb629OSZuB73WtCWuELrlVoNoJKupT0x8f/eATaacU9KVHl/6pr0vYdEyx7eMizfkU
         CuzCwL6UdMxyjFavQGCnStQsfmxGQkrDk35nScUByZDjltPR7L7s/1AYBR1u3OMMnOI0
         SnDI/sOH/SlA+WfuJKoZibVLj3IoIOG2IBsP2W8tqn5xsiwslDC34hUSb4AHeFY3OUHt
         W24g==
X-Gm-Message-State: AFq9FYIO2Q8aVYB45Tfcys24ckVJTV3DwdaFTGcsq0TOVA6rIUhMurPT
	CL3b9IID7QInGTWSQee8m02AC6oXSbyjQRJ/m8T2k6vUL1EfPj+fi63npTX7pXG/
X-Gm-Gg: AYBFou3fDASp7R8JsbE5jIyA9JsmJPNujS/4TG9iMVbVVdLytuM5oDufQWvJ6pkYmhe
	ipdMugdYNB1NIHSyGSXpl1++lt+XAykBZmsROZ4WzMxwfGm0PKZ2f8SXb3dFwBA6/r7HFpCqvcf
	FACrOsLzrnxk7eB28SMnstROVyNixungdTYZgMLnro15m3ZSDAiwjYzxmPcwL4ZpT2QNCiat1gw
	izUBI+2JXtSFMT7yJkoUOhYnKxWkiXa2mhKhzvRN341IBbf+Bp6GzMH+hZxlR1v+1Ulg9Bwsf6i
	RMwynWIjt/jj1aW81kWWPmPYHUEI5gBF6i+vYUWyUT8tVxfE9vquMRZimsKm+JEnRYwgLh/ewT9
	Xf6UxFaJPFwUg/RnkeMp8yz8UwN3vKAu+gl9CK7pQijUA0dmG7oXb+fAnDczZLxsxiYdyM9gmS3
	IxvmGkCjxbNKE0+quAF+NfWqxPan4xJzhv61FPmjnePNeAD6AiDCwX/33dg35q+XazjWhkjI1Ub
	1lSi2Ikb/xvWwA=
X-Received: by 2002:a17:90b:4a90:b0:3a0:345a:3646 with SMTP id 98e67ed59e1d1-3ab3a903353mr1565926a91.45.1791542915633;
        Fri, 09 Oct 2026 03:48:35 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed053csm3050107a91.4.2026.10.09.03.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:48:35 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v3 22/51] bpf: move the live-register and SCC printout to a standalone function
Date: Fri,  9 Oct 2026 03:47:40 -0700
Message-ID: <20261009-scev-minimal-rebase-v3-22-bcba9bc53ac9@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
References: <20261009-scev-minimal-rebase-v3-0-bcba9bc53ac9@gmail.com>
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
index 8d8428ccc505..e657e6d95408 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2664,8 +2664,7 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
 	struct bpf_insn *insns = env->prog->insnsi;
 	struct insn_live_regs *state;
 	int insn_cnt = env->prog->len;
-	u64 pos, insn_pos;
-	int err = 0, i, j, subprog, start, end;
+	int err = 0, i, subprog, start, end;
 	bool changed, ret_reg_pair;
 
 	/* Use the following algorithm:
@@ -2754,31 +2753,6 @@ int bpf_compute_live_registers(struct bpf_verifier_env *env)
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
index 91f114947b8b..9260ee290072 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22863,6 +22863,40 @@ static bool bpf_prog_reenters_datapath(const struct bpf_prog *prog)
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
@@ -23073,6 +23107,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	if (env->log.level & BPF_LOG_LEVEL2)
+		log_program(env);
+
 	ret = mark_fastcall_patterns(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 3abe08cc6595..6e8f50618580 100644
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
