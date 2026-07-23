Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D13537FD
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 05:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783311; cv=none; b=SeW+5O/5Pzpaq7OjZ9Bnzy2I6Pevem0Bf3Hy/No2kRkZbSuIsnMbHPGKga3H5xiTBs5FJUhpJHJptmfDrgBlrwMD5rvYaJPGHdz9HOrasSnQAZh0y3CP6bYIJWsHqiyUG3aNR3fEDfTTetrSatnqjV1LaIHMHIxOojWOeZXLyJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783311; c=relaxed/simple;
	bh=iWb6ik8fhZZwkdnti/01Jn8AxwsMIJLxrm6tgl7qGo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tp5OcjC57Jw/mSnIswDiR2AcUZDfS/BttwqQyOVkAJRxkQc864UqnFNGPa3iy6KUHJQyLe2YvhXhcQ8hqOV4ZpQT0d4EHziNTjJ+2E2xEEdnYCYakk8OhQsh7OYJfGckdm+bMhe+z3xtJymIE4Tib1IZPKdOrGBCMMQVUFYUjTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BQoB2oF/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQoB2oF/"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8484f229529so101339b3a.2
        for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 22:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784783309; x=1785388109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pTxLP8C3CAeeG4k0qlaUDPo3ob+y7daBikwNPfA/4Kc=;
        b=BQoB2oF/RAsL6cXorN04s518g4iYhTWQXkx82nE+dMclr6/bExPtJkP306pEFEVnLH
         pKorDDX7Ny9wHHY4X2O3JOF2VdeleNWICkTjJrw1ZTt6Lueacl7HDfEDDhXEaJL293QT
         +Yjb5jy6LghqhIe0AThfgDDwnKtYPZHt0BH/pxT2CoaX6Rk6oULR2UGa0q+64qi1FBmv
         ez6q2RcbbEuyDBXxzVgDskfphfBaSinm/uUh6fr18DTdHwhTqcqpiirkq3kRweJ0496J
         Hejd79ZHdQKU22VYJHIRq0FHM0PTYuW10RziL9aGvpUuW3DnSrmUdrB5PEEIhnVJaknd
         DHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783309; x=1785388109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pTxLP8C3CAeeG4k0qlaUDPo3ob+y7daBikwNPfA/4Kc=;
        b=XLfbRYJbiOewpZjeooXFTyJ7UhKBZY0hJOvfxhgLJq8USbmBsL9MkI9N2Z+WPWzZvo
         IfZTK12lRV2TRzz+SJBwEnBWcRECkyBF1qETdQsfUrBgaGm/BqmjxsKQMhY0fz4iYr23
         1ZlwB37z46seRU9wyvEFmM4fWniqYU+C/oMvln26nPDAywb1nid+qOfz8NYxi+H0IiOq
         RpPL5DTReIrJRsgBoR2BPO1NeXSSmVlkyRx1OZ78e7nNLuDtk7OAERpIGrDqJerokZ/6
         QW23pJE7PhqnCkz4MLQBaNxYALbv0Hs4nNFZz9/y62ribh3UztoG+O4xVSGqPy3V8TQZ
         j4rQ==
X-Gm-Message-State: AOJu0YwOetuABbCGEYIOK3osJ/2H5e6C1RjAMgrHa/EEsfs3uuS8PjRU
	DY1VZnUySvytoiD4PRPVxbfKVjl682Bl5lxgKQFcOXo5Z+3S1aJNRxlbMWCnSg==
X-Gm-Gg: AR+sD11IppFbg2cI6dKa1C7OwUIDsEo18un6vYTj5f82pPX+Oa/wb+4sJJAHV/W59Xy
	kHicw5tvj21156d9tUZcpJ+eblhY1MHs9TbaEk1FwYRVU1xFUD5Es2EgiqnEwHcN/RxWYfNiZOa
	n5IN5V36GTkn6nSgpa8h+KELXYsbpbtI9ktb7s0z4IlaDhYb5oTBG6Grq75ej3XpaolevbKinNx
	i2YM35qgNq+tv33Bx9tVRHAUtmENZ1u+9JlZp0K0GuSV5JG3oAt4y5em5X3LSBnwz/Y2N5eyb6h
	B37czBIjUzcLnU+8Iou+ZhCJqya3n+riOyefvo5JOreUG8vdgIu25GDe9oWTweOwz8ZXy37vn+/
	ZMFbJurlYmWiLS7HIpu2zvIQYr4KB2DRbv/j6kPokCcxber4SSrZXt9dAKGSIc4qFNZRp
X-Received: by 2002:aa7:88c9:0:b0:848:2e53:3f63 with SMTP id d2e1a72fcca58-84e2b892637mr2001511b3a.21.1784783308680;
        Wed, 22 Jul 2026 22:08:28 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17600a72sm2373993b3a.58.2026.07.22.22.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 22:08:28 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 15/18] bpf: Classify kfunc pointer arguments from BTF, resolve type against the register
Date: Wed, 22 Jul 2026 22:08:03 -0700
Message-ID: <20260723050806.1158442-16-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723050806.1158442-1-ameryhung@gmail.com>
References: <20260723050806.1158442-1-ameryhung@gmail.com>
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
index 65de60301861..aa3313aeafdb 100644
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
@@ -11348,11 +11361,10 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
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
 
@@ -11417,16 +11429,6 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
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
 
@@ -11435,10 +11437,14 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
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
@@ -12138,8 +12144,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		if (is_kfunc_arg_nullable(meta->btf, &args[i]) && bpf_register_is_null(reg))
 			continue;
 
-		kf_arg_type = get_kfunc_ptr_arg_type(env, regs, meta, t, ref_t, ref_tname,
-						     args, i, nargs, argno, reg);
+		kf_arg_type = get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname,
+						     args, i, nargs, argno);
 		if (kf_arg_type < 0)
 			return kf_arg_type;
 
@@ -12152,19 +12158,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
@@ -12383,20 +12376,46 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
+
+				if (!is_trusted_reg(env, reg)) {
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

