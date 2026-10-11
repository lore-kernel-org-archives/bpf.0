Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A6536F909
	for <bpf@vger.kernel.org>; Sun, 11 Oct 2026 06:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699715; cv=none; b=jLCkkpJ1euxx7V8dugtwmfesR409siznTb3hFlVgpPe7RewuAF5BL2nIHfwYvcvmao55yqTaLkfDuun43YoEKjMVmkwTkUrJVpyUjotQgumfnogYCGKva6bGOI//MO0d4ddIV/GMTRucZ0ZMNYgqrADZP76tSZ5kVj0C0+KoLbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699715; c=relaxed/simple;
	bh=Y4UFY7/dEXDNZJmqNRWVf0eRxU6x/XWtmZ9E9G8UEQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URA0s5/0Li4hI6HNZXU2AKJQ3iE41jqpsUE6rWTex8kpabDlsc1O+R6RbpPFRutko842mXKyFBe2RcWp35758opMCbBZH89rYavFmJTgW0TfNuSdXitCd8Zd0kioDaB4l68FJ8ni31zH5TkaQAabQvuofnohBDgaOQVjPmb2cMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBQqxzQb; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBQqxzQb"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-873a4edb243so544264b3a.0
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 23:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791699713; x=1792304513; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UyvzylznRnaEDiPMyAOULsUwq6HAPC1EnG+P3CIAw5M=;
        b=IBQqxzQbmKEeU6QY/HLP4iiSI2EaM9n9vq2Ua3urkgIQjsbIvkutpGuDN7ZicgeRlp
         oSf4f2u2Tg83TZr9ILz4GlagZziv3kOVSC9LO3mTJgc3EY5CMzHueHCWnXc74mYeMbOt
         50El7+wLMOa8hfze6tV+gpu9MBUmgKMTPvRDUx83INn9b/4AJs9+Q4FIxG5wcToctQ4e
         dYMk67lqRI72BvMLGp6rraHpxPbU1BF3mFmryZjmWqNTdBbtbGV7XPIkR8mpW1I5OaFw
         B4kfPgLCPNMkgSNsYPHxVyePud4t9PC84WjC3GEi3SxX6zKyuyv4ZVaLgdlbzwVhng21
         faJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791699713; x=1792304513;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UyvzylznRnaEDiPMyAOULsUwq6HAPC1EnG+P3CIAw5M=;
        b=J1sXLg2U9zP1kZi4r537MNG6+2HqYgdGz9tEcKdfVq3gH/h8CM4uioaprmJJ217UZx
         YtjMY1BYB5tmZDRix1IO8nvHDJudtsO9zXD7tT2sp79KQEZes46jYyBO4dNpl854zdwv
         +YzcTYZ9EkFtzKHqHHvmpuHQ55i9PZVpi5O8UoeG674vSH2OT1c6KEpEPArZTjuVyvvK
         2YHMkvwBq2aCfUK9EIcKlS4QGxa9xMRBjb4v0Rur03SiXyEQjRHhJUwgSBRWZGmRtw3U
         jEfm27CHTrCeff4/5T47QUusI5pLWZFZ67hS0dP872KS+Gm4HyfPX0vuSrhjJTJHO/CR
         jITw==
X-Gm-Message-State: AFq9FYIyPBzYwHNzPsdQ8ZCFDpcG0mOSTiP6WVSehLAoFCleD/2A2sea
	csgErBpclZAvZNOkT1q7rlK06iFNFNjXS5Z0M6V2qpuOgunA9IFwy1HEx/tDnw==
X-Gm-Gg: AYBFou3KFZLUQTWHxtJTQC3dRvhZW2Wd72f1ugmTUgFeKQBe7oDyxMhMvyHIEHBiMGA
	oowWUlnKVWvsS0eA1pQ/d4G2b6jFD0aU0qjuNLBLbfRfZGWKRbOBpfDe3aQpu9GAm94FoVmZ5hL
	bNuTf0cYF3A+tSENBDUAweypnIVTbfcqMtBwS4AqNN5Yx73sKSvPlKSyjkDR378HFHDUgYNZKk3
	R3r+r/svftr2HgklhffoxrYSytt9JFx/3ctKfkPs/0YCS5xooVfbpGKjNwMNcn57TZ/DZBTuKXp
	PZ2iHiO9mppC4zqee6Ln2qeixWPxePfLmxmP1PxU6XDI3F/2rQ4+Jd3ZaG4PRZrWkYLgyuzWzJ9
	2n6GwP/2nmi6pr8hs7bpX7SFllZu1/WGmmDUN7Ve0yW++ZC8Z623I0DR/G9L8apWo4HfrEoncIc
	F3W+Us36dkCCqGT28ekDNi9KKqkha8itbR8Cbja88MRXSFvn5T7/YwwbDiwhyRgDCOMHGyVG/kb
	7ADx+lo8dioP2I=
X-Received: by 2002:a05:6a00:3d9b:b0:88b:fd8d:b4c8 with SMTP id d2e1a72fcca58-8997491dfb7mr1552000b3a.8.1791699713521;
        Sat, 10 Oct 2026 23:21:53 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c31071absm2854341b3a.15.2026.10.10.23.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 23:21:53 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/9] bpf: static subprogram arguments liveness should use BTF type info
Date: Sat, 10 Oct 2026 23:21:35 -0700
Message-ID: <20261010-scev-minimal-v3-followups-v1-1-6000e95ef993@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
References: <20261010-scev-minimal-v3-followups-v1-0-6000e95ef993@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

When computing liveness marks for arguments of static subprograms
bpf_compute_live_registers() should mark all arguments in the
subprogram's BTF type as live.

This over-approximates the program behaviour but avoids gaps in
unreliable BTF detection:
- Suppose subprogram has arguments A, B, C.
- As a result of compiler optimizations, only arguments A and C are
  used and passed at call sites.
- As it is now, bpf_compute_live_registers() would detect that and
  mark the register r2 as dead at call sites.
- Dead registers are ignored during states pruning, meaning that a
  cached state from a path that initializes r2 can prune a path that
  leaves it uninitialized.
- This would bypass btf_check_func_arg_match() call and thus would not
  set bpf_func_info_aux->unreliable mark for the subprogram.

Revert the expectation in the test case [1] back to it's original
value, subprogram `subprog()` is considered reliable again.

[1] "exceptions/non-throwing extension -> non-throwing subprog"

Fixes: 147400e9c27c ("bpf: Compute parameters liveness in bpf_compute_live_registers()")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/btf.c                                   |  8 ++++---
 kernel/bpf/liveness.c                              | 15 +++++++------
 kernel/bpf/verifier.c                              | 26 ++++++++++++++++------
 .../testing/selftests/bpf/prog_tests/exceptions.c  |  2 +-
 4 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f4d119f3d5ef..5f4e211b1bdb 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8634,7 +8634,6 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	}
 	args = (const struct btf_param *)(t + 1);
 	nargs = btf_type_vlen(t);
-	sub->arg_slot_cnt = nargs;
 	if (nargs > MAX_BPF_FUNC_ARGS) {
 		bpf_log(log, "kernel supports at most %d parameters, function %s has %d\n",
 			MAX_BPF_FUNC_ARGS, tname, nargs);
@@ -8829,10 +8828,13 @@ int btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 		return -EINVAL;
 	}
 
-	err = btf_check_arg_slots(log, tname, is_global, slots_used, sub);
+	if (verifier_bug_if(slots_used != sub->arg_slot_cnt, env,
+			    "func#%d argument slot count mismatch: %u != %u",
+			    subprog, slots_used, sub->arg_slot_cnt))
+		return -EFAULT;
+	err = btf_check_arg_slots(log, tname, is_global, sub->arg_slot_cnt, sub);
 	if (err)
 		return err;
-	sub->arg_slot_cnt = slots_used;
 
 	sub->args_cached = true;
 
diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
index e657e6d95408..024790097f96 100644
--- a/kernel/bpf/liveness.c
+++ b/kernel/bpf/liveness.c
@@ -2623,14 +2623,15 @@ static void compute_insn_live_regs(struct bpf_verifier_env *env,
 			if (bpf_get_call_summary(env, insn, &cs)) {
 				use = GENMASK(min_t(u8, cs.arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS), 1);
 			} else if (bpf_pseudo_call(insn)) {
-				/* a static callee's reads are added in bpf_compute_live_registers() */
+				/*
+				 * Use BTF signatures as a starting point.
+				 * See special case for static subprograms
+				 * in the bpf_compute_live_registers()'s main loop.
+				 */
 				subprog = callee_subprog(env, insn);
-				if (bpf_subprog_is_global(env, subprog)) {
-					reg_args = min_t(u8, env->subprog_info[subprog].arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS);
-					use = GENMASK(reg_args, 1);
-				} else {
-					use = 0;
-				}
+				reg_args = min_t(u8, env->subprog_info[subprog].arg_slot_cnt,
+						 MAX_BPF_FUNC_REG_ARGS);
+				use = GENMASK(reg_args, 1);
 			}
 			def = mask_widen(def);
 			use = mask_widen(use);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2f190abe3448..fc1937b37dcf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14834,15 +14834,27 @@ static bool try_btf_prepare_func_args(struct bpf_verifier_env *env, int subprog)
 	return !err;
 }
 
-/* Prepare argument metadata for liveness; the main program is handled separately. */
+/* Initialize env->subprog_info[].arg_slot_cnt */
 static void prepare_subprog_args(struct bpf_verifier_env *env)
 {
+	struct bpf_prog_aux *aux = env->prog->aux;
+	const struct btf_type *t;
 	int i;
 
-	for (i = 1; i < env->subprog_cnt; i++) {
-		if (!try_btf_prepare_func_args(env, i) && bpf_subprog_is_global(env, i))
-			/* Keep all argument registers live if the prototype is unavailable. */
-			env->subprog_info[i].arg_slot_cnt = MAX_BPF_FUNC_REG_ARGS;
+	for (i = 0; i < env->subprog_cnt; i++) {
+		/*
+		 * Keep all argument registers live if the prototype is unavailable.
+		 * No need to include stack args, as those are not supported for
+		 * subprograms w/o BTF.
+		 */
+		env->subprog_info[i].arg_slot_cnt = MAX_BPF_FUNC_REG_ARGS;
+		if (!aux->func_info)
+			continue;
+		/* BTF validation guarantees FUNC -> FUNC_PROTO. */
+		t = btf_type_by_id(aux->btf, aux->func_info[i].type_id);
+		t = btf_type_by_id(aux->btf, t->type);
+		env->subprog_info[i].arg_slot_cnt = min_t(u32, btf_proto_slots(aux->btf, t),
+							  MAX_BPF_FUNC_ARGS);
 	}
 }
 
@@ -23396,6 +23408,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
+	prepare_subprog_args(env);
+
 	ret = check_subprogs(env);
 	if (ret < 0)
 		goto skip_full_check;
@@ -23458,8 +23472,6 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
 	if (ret < 0)
 		goto skip_full_check;
 
-	prepare_subprog_args(env);
-
 	ret = bpf_compute_idoms(env);
 	if (ret < 0)
 		goto skip_full_check;
diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
index cea01d638f6f..3705db18c1bb 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -322,7 +322,7 @@ static void test_exceptions_success(void)
 				       bpf_program__fd(skel->progs.exception_throw_subprog),
 				       "subprog"), "set_attach_target"))
 				goto done;
-		}), "Cannot replace static functions", 0);
+		}), "subprog() is not a global function", 0);
 
 	if (test__start_subtest("non-throwing extension -> throwing subprog"))
 		/* non-throwing extension -> throwing subprog : BAD (!global) */

-- 
2.53.0
