Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E47C459ACC
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920113; cv=none; b=ASCSb65Q28NZ6l4vWfP44KUv+OrGfcU6C4Exiy+J23T6A+mjOD8Zddo5IRRqqK0tUC7MMT/spYNwwZ+2VcfTRpQOQM/C7zXM8GqXKkekmEWVUrQOgUCH1oagibebGF3u+FJUDLkG8DAFMePBXZCEQvqMhdEaN2QZNCd7EGOH66k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920113; c=relaxed/simple;
	bh=KvUmOpPL1ZCJCfOSWwjiu3/TTlMNp64aUovDxY8SmIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nH1FGcZ/YzxXxVyCnVFL+M/13Xs69PcjRBCF2aFTrOi68lKWMKwu6xWDmrIKmAjVEV6QbTI9Cn7eCt5/Sq5etxf4mKXM4sECvtAjcd48EaV4nxxDKWMwB9GpOUnJtC90z9ac2WdMX8nvbAzkyNecyhLNjrNhoi0IlGVwrVWHhBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4imFqsd; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4imFqsd"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e347638adso715580a91.0
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920111; x=1785524911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1A0ozh0DAcbepCm2p62gPcpFRGlRiSdQuJgZ2/5NHNg=;
        b=R4imFqsdLijfR+KxfSsi3uc581/sycOReV18HEx7Qm2Ml8c4hsje5zkwbjJulJ48P7
         2eGVWCVq8K3kV/+wZSBIpgFmOKMDqC7muVz2om0Kv0+/ouraQYEUk2+ZEwfFH5c7YK/i
         GaDfnKHeNA2FqRNf3icEcVaavYl2I2W3K/iLpqeZ9x4A/QH1mXa5kaJeU3F/XozW3ZjP
         Uz/I2HNV8vILuY2E+NlhjlSBjlICVM5ofoevqf3ibByCtaHBeVWcMT8qSSYgTKB60fkt
         fcGsdf2F3mrYzb/J+YVNgUM8mPQiv5TFEYoiznk5hoggLVXHMbshrxi6M/P6C2glFb6N
         vAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920111; x=1785524911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1A0ozh0DAcbepCm2p62gPcpFRGlRiSdQuJgZ2/5NHNg=;
        b=s5+M5eUPLZWovTytA5DZmBNMUh+GRhd7zJY8so+u5OLm7dWZxbY6bEqhm7ddOuSg9p
         kqskryu9Tzj69g+WwCEo54IqgauzlwpA358HstV2slIcVrCRXQYqZd4OjU6Dve4J5UQW
         Pa2RX0BJoS1xskzGL+77FXjAH0VXkk0BTIwWCitEcwtLrTUJzinB+dVjd8YoH2t2Tk/d
         CjeU+YJWLQRwsJ8OFZgnWlARkAEZt2VAuKpBEfMGAYC/s8P5pD4iy3Si6g2/zFGhKH8H
         Y3MmahRzLPxh+LA8PLvZ2ORt74FZ3MNgMPC6dC+ygzNUAQfpnMY8PrnGX8+jBSIFLEoO
         LBYw==
X-Gm-Message-State: AOJu0Yxto5VApkhiV4DWNnUGRPYdydVqTPQA1L2GhFYliiddEuUIkSLw
	UulJD7VjuJMOL8PgF5hERtvuB1+611KfuDEaqDBidn0BXhh9SeizIRCfxTen0w==
X-Gm-Gg: AR+sD12gsDOG/2QK9DodMp0OCyyOR38RDMdBCM2gjMLF548mKsBb4KI4PrA7fq8eRS1
	narFD796l5qRQso7Z5Y/7s+/zXUoDgB5m56TLfQlTp4ul6admmMrdMtqH3JikfORjufu8xcvAp2
	oiEQw9uAOkg3VttAxeJLSZLSw3tRviRyRqNv9KUW9pmhXlZ8smxBlXpwGrX0OtKk0GGEu6cLMP/
	0J+eaC38r8LM7M8YOHR1dkPukT1hZ48zPjbayTfs4qymfD9idvqSmMIaM11ZPy2ccGgoA8oYPDw
	bxEpP7XXFACFRVI2fnNd3B4tw97FxE5bQSbxumkLt9pBdhaReKw9ZT1LKhOThqO1Hj7ITrRYT4Y
	fjcQCtfBccw4XXiWr1Hz1bzJuPqUrZUSrfe6h6XJq2LZSvIHL1kimdNt8dkl5HG99vlQH
X-Received: by 2002:a17:90b:4f:b0:38e:7d40:faea with SMTP id 98e67ed59e1d1-38ec65662b7mr8107450a91.21.1784920110543;
        Fri, 24 Jul 2026 12:08:30 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:46::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03ad03ffsm2012205a91.5.2026.07.24.12.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:08:30 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 15/18] bpf: Classify kfunc pointer arguments from BTF, resolve type against the register
Date: Fri, 24 Jul 2026 12:08:09 -0700
Message-ID: <20260724190813.1458271-16-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260724190813.1458271-1-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_kfunc_ptr_arg_type() decided part of a kfunc pointer argument's type
from the caller's register: a PTR_TO_BTF_ID (or reg2btf_ids) register made
the argument KF_ARG_PTR_TO_BTF_ID, otherwise it fell through to a memory
buffer. Folding register state into argument classification prevents
describing a kfunc's arguments from its BTF alone, which is a prerequisite
for generating a helper-like prototype and eventually sharing the argument
checking (check_func_arg()) between helpers and kfuncs.

Classify pointer arguments from BTF only, and resolve them against the
register in check_kfunc_args():

 - A pointer to a struct that is not paired with a __sz/__szk size
   argument is classified KF_ARG_PTR_TO_BTF_ID and then checked against
   the register. A register carrying a BTF ID (PTR_TO_BTF_ID or a
   reg2btf_ids type) must be referenced or trusted and is matched against
   the expected type. The only relaxation is when the struct is composed
   of scalars, the register may be verified as a fixed-size memory buffer
   sized from the BTF type; anything else is rejected.

 - A pointer paired with a size argument is always a memory buffer and is
   never classified as BTF_ID, so the __sz/__szk case no longer detours
   through BTF_ID.

The referenced-or-trusted check thus moves into the KF_ARG_PTR_TO_BTF_ID
resolution, alongside the type match.

get_kfunc_ptr_arg_type() no longer needs the register, so drop its regs
and reg parameters; it is now a pure function of the kfunc's BTF.

When a register cannot satisfy a BTF_ID argument, report the register type
passed and, when the expected struct has a reg2btf_ids mapping, the
register type that would be accepted, instead of a confusing "socket".
Update the affected selftest messages accordingly.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 107 +++++++++++-------
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |   2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |   2 +-
 .../selftests/bpf/progs/verifier_vfs_reject.c |   6 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   6 +-
 5 files changed, 71 insertions(+), 52 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2326b12a1531..76a84574b23e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4924,6 +4924,19 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 	[CONST_PTR_TO_MAP] = btf_bpf_map_id,
 };
 
+static enum bpf_reg_type lookup_reg2btf_ids(const struct btf_type *ref_t)
+{
+	enum bpf_reg_type type;
+
+	for (type = 0; type < __BPF_REG_TYPE_MAX; type++) {
+		if (reg2btf_ids[type] &&
+		    btf_type_by_id(btf_vmlinux, *reg2btf_ids[type]) == ref_t)
+			return type;
+	}
+
+	return NOT_INIT;
+}
+
 static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
 {
 	/* A referenced register is always trusted. */
@@ -11342,11 +11355,10 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 }
 
 static int
-get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
-		       struct bpf_reg_state *regs, struct bpf_call_arg_meta *meta,
+get_kfunc_ptr_arg_type(struct bpf_verifier_env *env, struct bpf_call_arg_meta *meta,
 		       const struct btf_type *t, const struct btf_type *ref_t,
 		       const char *ref_tname, const struct btf_param *args,
-		       int arg, int nargs, argno_t argno, struct bpf_reg_state *reg)
+		       int arg, int nargs, argno_t argno)
 {
 	bool arg_mem_size = false;
 
@@ -11411,16 +11423,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	if (is_kfunc_arg_res_spin_lock(meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_RES_SPIN_LOCK;
 
-	if ((base_type(reg->type) == PTR_TO_BTF_ID || reg2btf_ids[base_type(reg->type)])) {
-		if (!btf_type_is_struct(ref_t)) {
-			verbose(env, "kernel function %s %s pointer type %s %s is not supported\n",
-				meta->func_name, reg_arg_name(env, argno),
-				btf_type_str(ref_t), ref_tname);
-			return -EINVAL;
-		}
-		return KF_ARG_PTR_TO_BTF_ID;
-	}
-
 	if (is_kfunc_arg_callback(env, meta->btf, &args[arg]))
 		return KF_ARG_PTR_TO_CALLBACK;
 
@@ -11429,10 +11431,14 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1])))
 		arg_mem_size = true;
 
-	/* This is the catch all argument type of register types supported by
-	 * check_helper_mem_access. However, we only allow when argument type is
-	 * pointer to scalar, or struct composed (recursively) of scalars. When
-	 * arg_mem_size is true, the pointer can be void *.
+	/* A pointer to a struct without a size argument is classified as KF_ARG_PTR_TO_BTF_ID */
+	if (btf_type_is_struct(ref_t) && !arg_mem_size)
+		return KF_ARG_PTR_TO_BTF_ID;
+
+	/*
+	 * Otherwise this is a memory buffer supported by check_helper_mem_access(): a pointer
+	 * to a scalar, or to void when paired with a size argument. The access size is derived
+	 * from the pointed-to BTF type unless a size argument follows.
 	 */
 	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0) &&
 	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
@@ -12132,8 +12138,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		if (is_kfunc_arg_nullable(meta->btf, &args[i]) && bpf_register_is_null(reg))
 			continue;
 
-		kf_arg_type = get_kfunc_ptr_arg_type(env, regs, meta, t, ref_t, ref_tname,
-						     args, i, nargs, argno, reg);
+		kf_arg_type = get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname,
+						     args, i, nargs, argno);
 		if (kf_arg_type < 0)
 			return kf_arg_type;
 
@@ -12146,19 +12152,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		switch (base_type(kf_arg_type)) {
 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
 		case KF_ARG_PTR_TO_BTF_ID:
-			if (!is_trusted_reg(env, reg)) {
-				if (!is_kfunc_rcu(meta)) {
-					verbose(env, "%s must be referenced or trusted\n",
-						reg_arg_name(env, argno));
-					return -EINVAL;
-				}
-				if (!is_rcu_reg(reg)) {
-					verbose(env, "%s must be a rcu pointer\n",
-						reg_arg_name(env, argno));
-					return -EINVAL;
-				}
-			}
-			fallthrough;
 		case KF_ARG_CONST_MAP_PTR:
 		case KF_ARG_PTR_TO_ITER:
 		case KF_ARG_PTR_TO_LIST_HEAD:
@@ -12377,20 +12370,46 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 			break;
 		case KF_ARG_PTR_TO_BTF_ID:
 			/* Only base_type is checked, further checks are done here */
-			if ((base_type(reg->type) != PTR_TO_BTF_ID ||
-			     (bpf_type_has_unsafe_modifiers(reg->type) && !is_rcu_reg(reg))) &&
-			    !reg2btf_ids[base_type(reg->type)]) {
-				verbose(env, "%s is %s ", reg_arg_name(env, argno),
-					reg_type_str(env, reg->type));
-				verbose(env, "expected %s or socket\n",
-					reg_type_str(env, base_type(reg->type) |
-							  (type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS)));
+			if (base_type(reg->type) == PTR_TO_BTF_ID ||
+			    reg2btf_ids[base_type(reg->type)]) {
+				if (!is_trusted_reg(env, reg) ||
+				    bpf_type_has_unsafe_modifiers(reg->type)) {
+					if (!is_kfunc_rcu(meta)) {
+						verbose(env, "%s must be referenced or trusted\n",
+							reg_arg_name(env, argno));
+						return -EINVAL;
+					}
+					if (!is_rcu_reg(reg)) {
+						verbose(env, "%s must be a rcu pointer\n",
+							reg_arg_name(env, argno));
+						return -EINVAL;
+					}
+				}
+
+				ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i, argno);
+				if (ret < 0)
+					return ret;
+				break;
+			}
+
+			if (!__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
+				enum bpf_reg_type reg2btf_type = lookup_reg2btf_ids(ref_t);
+
+				verbose(env, "%s is %s expected %s %s",
+					reg_arg_name(env, argno), reg_type_str(env, reg->type),
+					btf_type_str(ref_t), ref_tname);
+				if (reg2btf_type != NOT_INIT)
+					verbose(env, " or %s", reg_type_str(env, reg2btf_type));
+				verbose(env, "\n");
 				return -EINVAL;
 			}
-			ret = process_kf_arg_ptr_to_btf_id(env, reg, ref_t, ref_tname, ref_id, meta, i, argno);
-			if (ret < 0)
-				return ret;
-			break;
+
+			/*
+			 * If the register does not contain btf id but the argument type is a pointer to
+			 * scalar-only struct, allow verifying it as a fixed size memory.
+			 */
+			kf_arg_type = KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
+			fallthrough;
 		case KF_ARG_PTR_TO_MEM:
 			if (kf_arg_type & MEM_FIXED_SIZE) {
 				resolve_ret = btf_resolve_size(btf, ref_t, &type_size);
diff --git a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
index d0d65d6d450c..efe7bcae70f8 100644
--- a/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/cgrp_kfunc_failure.c
@@ -64,7 +64,7 @@ int BPF_PROG(cgrp_kfunc_acquire_no_null_check, struct cgroup *cgrp, const char *
 }
 
 SEC("tp_btf/cgroup_mkdir")
-__failure __msg("R1 pointer type STRUCT cgroup must point")
+__failure __msg("R1 is fp expected STRUCT cgroup")
 int BPF_PROG(cgrp_kfunc_acquire_fp, struct cgroup *cgrp, const char *path)
 {
 	struct cgroup *acquired, *stack_cgrp = (struct cgroup *)&path;
diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index 8942b5478129..5c99b1e6532b 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -50,7 +50,7 @@ int BPF_PROG(task_kfunc_acquire_untrusted, struct task_struct *task, u64 clone_f
 }
 
 SEC("tp_btf/task_newtask")
-__failure __msg("R1 pointer type STRUCT task_struct must point")
+__failure __msg("R1 is fp expected STRUCT task_struct")
 int BPF_PROG(task_kfunc_acquire_fp, struct task_struct *task, u64 clone_flags)
 {
 	struct task_struct *acquired, *stack_task = (struct task_struct *)&clone_flags;
diff --git a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
index 2870738d93f7..8f0c45421f89 100644
--- a/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
+++ b/tools/testing/selftests/bpf/progs/verifier_vfs_reject.c
@@ -28,7 +28,7 @@ int BPF_PROG(get_task_exe_file_kfunc_null)
 }
 
 SEC("lsm.s/inode_getxattr")
-__failure __msg("R1 pointer type STRUCT task_struct must point to scalar, or struct with scalar")
+__failure __msg("R1 is fp expected STRUCT task_struct")
 int BPF_PROG(get_task_exe_file_kfunc_fp)
 {
 	u64 x;
@@ -98,7 +98,7 @@ int BPF_PROG(path_d_path_kfunc_null)
 }
 
 SEC("lsm.s/task_alloc")
-__failure __msg("R1 must be referenced or trusted")
+__failure __msg("dereference of modified untrusted_ptr_")
 int BPF_PROG(path_d_path_kfunc_untrusted_from_argument, struct task_struct *task)
 {
 	struct path *root;
@@ -112,7 +112,7 @@ int BPF_PROG(path_d_path_kfunc_untrusted_from_argument, struct task_struct *task
 }
 
 SEC("lsm.s/file_open")
-__failure __msg("R1 must be referenced or trusted")
+__failure __msg("dereference of modified untrusted_ptr_")
 int BPF_PROG(path_d_path_kfunc_untrusted_from_current)
 {
 	struct path *pwd;
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index 302d712e0d7e..8cd626e04551 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -31,7 +31,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "R1 pointer type STRUCT prog_test_fail1 must point to scalar",
+	.errstr = "R1 is fp expected STRUCT prog_test_fail1",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_fail1", 2 },
 	},
@@ -46,7 +46,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "max struct nesting depth exceeded\nR1 pointer type STRUCT prog_test_fail2",
+	.errstr = "max struct nesting depth exceeded\nR1 is fp expected STRUCT prog_test_fail2",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_fail2", 2 },
 	},
@@ -61,7 +61,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "R1 pointer type STRUCT prog_test_fail3 must point to scalar",
+	.errstr = "R1 is fp expected STRUCT prog_test_fail3",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_fail3", 2 },
 	},
-- 
2.52.0

