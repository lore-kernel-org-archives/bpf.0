Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F843ACA79
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 07:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785570422; cv=none; b=E4gjdf95oK9MUAUWJllfkr1ro4MTAVK4ch5WhDAv9n7+U5p9ftOMhBulud/brvnYAMdWf8RzBNDSBU1mQLKUFlH09w3kYNa/+HX00wb+zgp97tSoTqSutsb6oz21lCJ2TeQvkKqVifaOz8T8vTZz1pgql7IH4Vt5s9HNpCuicy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785570422; c=relaxed/simple;
	bh=7RVWYxVxYSVMe8U+FrB2hO/KkvM4vFoCbobSO6rbIEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uI/KbjMhfdyVbivUKg2flkHA5N+MiMxM5Xp5R7eKC/e/osihgdkts/VGnA59nH4lKIUTR5NMjs8qiOapIoPH1f4ecS8UWaRv7KcpzJAAhRoM5Rj7zDK9hYOOWPelLZSj2JwpWQqlgGUtP7uVfhvSpl7bxCYi4YU12nc+BzWwY+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sbzR92bS; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbzR92bS"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so1378764b3a.0
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2026 00:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785570420; x=1786175220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LmcLccpWXAFZfsWfMwg2rIr24mtPltQz0Zm5YQCdkuc=;
        b=sbzR92bSZP6JNEiNvL+4iHpE5ukzbXhr2Hl7ckEowiZqXDEDJ2oCci9eobfcAmV0D2
         B/sdp4n5+G7u8yU94jrLozO2tEJkblFffND8URJkIxM3TDdi5OMYem/Bmi9JbgXmc2Fl
         MMn6M7VwlqcUwoJ+Q4u8qmGP4eRXA78Ju37dZ1poniMK+AnuPCemmPbdWjXkpdR2iRaF
         ++iTlmgAPMT5eLZyH3sDueqQ08eW94hfrmnodNXgbYk6hiMcKoPPdR5TekORy+GYqmcd
         CbS0dlsv6HkdlVYFOFDCN4V0n5LRqIbyxP451wJKU9yyJxHhXJn65LhmIQCl0oy6I9F5
         qbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785570420; x=1786175220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LmcLccpWXAFZfsWfMwg2rIr24mtPltQz0Zm5YQCdkuc=;
        b=HZBal7ynacVJyox9NnqiIvasurQzxd91SigCJd2NuodFG7mK1El+spEarwgziQev8g
         QQv1S3hYFLqlT+TiCcIq0nF4OuxE8KjR2Lo0xVLEosowiorcRhUPrlTdF/4aJzV9rkZI
         8j7ehMhMcdfhhxbPgYEXCiaOkCNSArMyKK3BT4uRJLkL/1Vi/MdxVVnnNPp85o2+avdP
         KCR2K3Lu4F4vElonW7zJttYbQ+e5mwJxC5ofLijcr3+OjKboYizN6kJwCSoxtmbu/Vca
         I1glZ1M9aBG6o/KJ2uZb8csj0qN0cshr1m2Lb4itylJlgikh/7yaqVjsBdx9qC5ZKGSf
         u+9g==
X-Gm-Message-State: AOJu0Yxyr5Ism2EC/4/a1GJRKdRpSah9aGHWRi437OiM7F3MgNLHruMI
	5L18F5kne9k393z9ls1Ytu+Rr6wzKRBDIoN38YxzbgxVYyPVyaMKGn2zMNVW8g==
X-Gm-Gg: AR+sD12vVzIolUo7DQqI2929sTJt9pIsRvvsR0HDpNub2jlR0cl4IT1tXqzW/lhwcpP
	8Fi7EOcL8tPR6Ap8bhrBN5lxLpu1d8Kry99jgsJv9Egf6Wx5ihELyjgR98amfs8mBjQZix3/EqY
	f9/r3yFpo+lI4T8I3q47sTlvVPKHAyU3Pzq+vNcELlmqXIzA2tlAKvL5gzPL6pzXes7ASjCLomy
	gl0HwKNCGpyOriTzxBbnR5Kg+/6zCC84wFF+dT5ZYN1p6BLwqWv0wnJkl1p1CLM+OOy6JyVULRt
	ygeS3eQlQUZD6Di2Cc/mYQcAEAb+DnA21S+s0noCEUNB5Z0EEALwtewiUvUTVJ3+tdBweB+EWuT
	TwFz42XIhUAwzpXgpbdAvhYeqP9UK71dEwllOv5l1E1EpUfRezN9oUMPv3bqbeUadc5nUfGNRw6
	sHujwd/0MsM2nqVEyOT7tCPYfO0NzXNCwOEdlc4YVgbVOlEZwtSQ==
X-Received: by 2002:a05:6a00:22ce:b0:848:401c:98e with SMTP id d2e1a72fcca58-84ee482b583mr1985122b3a.15.1785570420065;
        Sat, 01 Aug 2026 00:47:00 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe7da67sm1435577b3a.25.2026.08.01.00.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 00:46:59 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 15/18] bpf: Classify kfunc pointer arguments from BTF, resolve type against the register
Date: Sat,  1 Aug 2026 00:46:30 -0700
Message-ID: <20260801074633.1595644-16-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260801074633.1595644-1-ameryhung@gmail.com>
References: <20260801074633.1595644-1-ameryhung@gmail.com>
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

The new design now accepts one previously rejected case: passing
PTR_TO_BTF_ID to a pointer to scalar w/o a following __sz/__szk. The
argument will be classified as KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE. The
PTR_TO_BTF_ID register will go through check_mem_reg() ->
check_helper_mem_access() -> check_ptr_to_btf_access(), and by default only
read is allowed.

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
 kernel/bpf/verifier.c                         | 130 ++++++++++--------
 .../selftests/bpf/progs/cgrp_kfunc_failure.c  |   2 +-
 .../selftests/bpf/progs/task_kfunc_failure.c  |   2 +-
 .../selftests/bpf/progs/verifier_vfs_reject.c |   6 +-
 tools/testing/selftests/bpf/verifier/calls.c  |   6 +-
 5 files changed, 84 insertions(+), 62 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b2aa0101adc4..ac117edc118c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -4926,6 +4926,18 @@ static u32 *reg2btf_ids[__BPF_REG_TYPE_MAX] = {
 	[CONST_PTR_TO_MAP] = btf_bpf_map_id,
 };
 
+static enum bpf_reg_type lookup_reg2btf_ids(u32 ref_id)
+{
+	enum bpf_reg_type type;
+
+	for (type = 0; type < __BPF_REG_TYPE_MAX; type++) {
+		if (reg2btf_ids[type] && *reg2btf_ids[type] == ref_id)
+			return type;
+	}
+
+	return NOT_INIT;
+}
+
 static bool is_trusted_reg(struct bpf_verifier_env *env, const struct bpf_reg_state *reg)
 {
 	/* A referenced register is always trusted. */
@@ -11336,14 +11348,11 @@ bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
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
-	bool arg_mem_size = false;
-
 	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
 	    meta->func_id == special_kfunc_list[KF_bpf_session_is_return] ||
 	    meta->func_id == special_kfunc_list[KF_bpf_session_cookie])
@@ -11405,37 +11414,37 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
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
 
 	if (arg + 1 < nargs &&
 	    (is_kfunc_arg_mem_size(meta->btf, &args[arg + 1]) ||
-	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1])))
-		arg_mem_size = true;
+	     is_kfunc_arg_const_mem_size(meta->btf, &args[arg + 1]))) {
+		if (!btf_type_is_void(ref_t) && !btf_type_is_scalar(ref_t) &&
+		    !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
+			verbose(env, "%s pointer type %s %s must point to void, scalar, or struct with scalar\n",
+				reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
+			return -EINVAL;
+		}
+		return KF_ARG_PTR_TO_MEM;
+	}
 
-	/* This is the catch all argument type of register types supported by
-	 * check_helper_mem_access. However, we only allow when argument type is
-	 * pointer to scalar, or struct composed (recursively) of scalars. When
-	 * arg_mem_size is true, the pointer can be void *.
+	/* A pointer to a struct without a size argument is classified as KF_ARG_PTR_TO_BTF_ID */
+	if (btf_type_is_struct(ref_t))
+		return KF_ARG_PTR_TO_BTF_ID;
+
+	/*
+	 * Otherwise this is a fixed-size memory buffer supported by
+	 * check_helper_mem_access(): a pointer to a scalar or a struct of
+	 * scalars. The access size is derived from the pointed-to BTF type.
 	 */
-	if (!btf_type_is_scalar(ref_t) && !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0) &&
-	    (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
-		verbose(env, "%s pointer type %s %s must point to %sscalar, or struct with scalar\n",
-			reg_arg_name(env, argno),
-			btf_type_str(ref_t), ref_tname, arg_mem_size ? "void, " : "");
+	if (!btf_type_is_scalar(ref_t) &&
+	    !__btf_type_is_scalar_struct(env, meta->btf, ref_t, 0)) {
+		verbose(env, "%s pointer type %s %s must point to scalar, or struct with scalar\n",
+			reg_arg_name(env, argno), btf_type_str(ref_t), ref_tname);
 		return -EINVAL;
 	}
-	return arg_mem_size ? KF_ARG_PTR_TO_MEM : KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
+	return KF_ARG_PTR_TO_MEM | MEM_FIXED_SIZE;
 }
 
 static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
@@ -12126,8 +12135,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 		if (is_kfunc_arg_nullable(meta->btf, &args[i]) && bpf_register_is_null(reg))
 			continue;
 
-		kf_arg_type = get_kfunc_ptr_arg_type(env, regs, meta, t, ref_t, ref_tname,
-						     args, i, nargs, argno, reg);
+		kf_arg_type = get_kfunc_ptr_arg_type(env, meta, t, ref_t, ref_tname,
+						     args, i, nargs, argno);
 		if (kf_arg_type < 0)
 			return kf_arg_type;
 
@@ -12140,19 +12149,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
@@ -12372,20 +12368,46 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
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
+				enum bpf_reg_type reg2btf_type = lookup_reg2btf_ids(ref_id);
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

