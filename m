Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC54F3934
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 21:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790370795; cv=none; b=X3tWIoxPqKdJO47+wLWeFMMJuI3+cADoO0ml7KXa9RBKBYesvc4NBxgIaKQsvPlcSQHCs2ppvRVsPuEATcAPyMHIF7OP2DLlATLjRv39OFXzgmvCiDZgqfXe7LsDRI+P2/S9JyY8DqfvLOKJxlZUBb2m0qODhOXtQCgpns+vUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790370795; c=relaxed/simple;
	bh=xIXsxIzEXvYM4AcA9ZYwsww4LrojaMYOiP8jLU8zHn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WK/T5wCY9XGXN7dmf6S6mv8J+mU91biC16xGefWqhz5XarEjPZb1Q1294CkuCfVMMLvym01IFrSqoKu3bUhi1qystzLjsQQxTR6dSxm6n+gQhgMMllJ5MGbv6VavRSD+U1zNvkgIHUusbfWXVzCXZ6v7IKB9Gb8skBWHtbPO+v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPQp5Vab; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPQp5Vab"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-7f4f0cfb29cso706678a34.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 14:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790370792; x=1790975592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o72FpJvOU7QXrfrkzZkMVkU3uzPWyWi1xbO17mwY7mM=;
        b=OPQp5Vab+/VwcwRw9LxZXY+MXYkrxIh+EjOqiqQL/3i1HMkWWt4mLM0e47kW1CGbxN
         JfC1W/D2rgHQztyOltaE/DQYIde7QTOL0ruZLwNgDeR4S18oVtsZWL8R5gwjmmdR4yyH
         G6KB/A7fs8+y1hFdp84hkpM4v/ZF3p2QlE9J4NjQLbSANpTpkKCrxsWwvqtCG6n8TpMH
         QHmReQWmwZSaU5r68o8+Mz1SeKjJbOkhlu5kVl8F+FJvqMwsLy8tRHUeTCRsBSX5ckGi
         CQZPeGk/GuoBUWb4hdzxcQb1cxkey9hrVgyKJNf7J0AkLMXm5GBafaKB8yn2LTrvyHq/
         nCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790370792; x=1790975592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=o72FpJvOU7QXrfrkzZkMVkU3uzPWyWi1xbO17mwY7mM=;
        b=rylFaH+paPiipyP148pg3SwCfP7EuRKJnvRBP9eyS6x95LcIhYjrXQ4yQW9G9nLBw2
         qY11LursgK4EfTU5Ll+70HtrDSS/uZ0L1N7gXOvuD8LO8Jv3SWBHyvZ7Xf/eRpQ3PlKz
         ack6etpQTRu51AczNrm84qfGEuFql7a+0+zGHAcWqUpkwxeOevVLDPFijumtxc036bj+
         EVrydPlBmiReC5mUm+Nc8jMN0Xn+ROUFvjnb2PXn3yEQehWU42CTjR0ZwjFRXn6AuHod
         i/qDOpO6L7LH12iYFC3DNq3sCqO22WOKC2e1kWsdPn2E1tnW7uFxFQuTCvt9n9a2FOfB
         2YOw==
X-Gm-Message-State: AFuF++mfE8sMo4uK9z62HJNPxA8Vi1plIP/tUPGL1WNFi2a3Qf3M4bHe
	of724UR/mueAoB4671bkdRa1wUl+i453Ht+kKvJg7sBuII+M6i6ifcNCtOqhEA==
X-Gm-Gg: AYBFou0LzozQb/swlYGuktmlDCsNMq53YiMaTcp/XRN2eavHj66XkRlPKLE/N4In/9L
	MjTpJ10Ky431EDH3G/dz3WOIDTKz5QZqyrfd2wDB26JzbNPNYXu2qQ6ewvJ3sT9Snu7NDrjMuoT
	3I1kwicDqyOGIKBwRlLjZxlsKkRJYcnW2LBHl2iqKbGyv0nboUsbSoXFC2ASG14TfBY+7ficjp2
	qsNs8zmI43td3iFsagJunBzZAs1xoAaFA+7ouQQ308UERFaAViyvFC6ndGPOM3zQACVZMc4L3kZ
	wCzF1FWUA+y4KLPK97F6QarLCW8t4fuFq7+jY2oMvR1pla9fm70xCerM5z5AtUqnxoXSKr6o8gB
	X0lgU0ZEJaUIM5ITDI/Z0k7jpfUv/H6hi1ITuq2O69ma2QOifw9oa1IWPF3/ybllpNu2hW2FXIJ
	1VX/DESVoBFHAA6Zga21nxELUSj3KAxKLbl5FaJhNVXsuLt2zS8P1H4a9NE+/8usopz+XEWHHx
X-Received: by 2002:a05:6830:4c03:b0:7f4:eaba:faf4 with SMTP id 46e09a7af769-81781489ca0mr9029629a34.11.1790370792371;
        Fri, 25 Sep 2026 14:13:12 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:14::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-818e33f6714sm3370742a34.0.2026.09.25.14.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 14:13:10 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 09/12] bpf: Check global subprog BTF-ID arguments in the common path
Date: Fri, 25 Sep 2026 14:12:53 -0700
Message-ID: <20260925211256.1834061-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260925211256.1834061-1-ameryhung@gmail.com>
References: <20260925211256.1834061-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Route global ARG_PTR_TO_BTF_ID arguments through check_func_arg(). Use
vmlinux BTF for their type match and retain the global-subprogram rules
instead of applying kfunc-only trusted-pointer validation or runtime type
resolution.

The common nullability check now rejects non-nullable global BTF-ID
arguments before register-type matching. Update the corresponding
verifier log expectations.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c                         | 31 +++++--------------
 .../bpf/progs/verifier_global_ptr_args.c      |  4 +--
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4a5c682ee73c..73a1c4877427 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9512,7 +9512,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	case ARG_PTR_TO_BTF_ID_SOCK_COMMON:
 	{
 		const u32 *arg_btf_id = fn->arg_btf_id[arg];
-		const struct btf *arg_btf = meta->btf ?: btf_vmlinux;
+		const struct btf *arg_btf = is_kfunc(meta) ? meta->btf : btf_vmlinux;
 
 		if (!meta->btf) {
 			const struct bpf_reg_types *compatible;
@@ -9540,8 +9540,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 			}
 		}
 
-		if (meta->btf && (!is_trusted_reg(env, reg) ||
-				  bpf_type_has_unsafe_modifiers(reg->type))) {
+		if (is_kfunc(meta) && (!is_trusted_reg(env, reg) ||
+				       bpf_type_has_unsafe_modifiers(reg->type))) {
 			if (!(arg_type & MEM_RCU)) {
 				const char *actual_type, *arg_name, *expected_type;
 
@@ -10817,6 +10817,8 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 			arg_type = ARG_IGNORE;
 		} else if (base_type(arg_type) == ARG_PTR_TO_ARENA) {
 			arg_type |= PTR_MAYBE_NULL;
+		} else if (base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
+			proto->arg_btf_id[arg] = &sub->args[slot].btf_id;
 		}
 		proto->arg_type[arg] = arg_type;
 		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
@@ -10883,7 +10885,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 
 		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE ||
 		    arg_type == ARG_PTR_TO_CTX || arg_type == ARG_PTR_TO_DYNPTR ||
-		    base_type(arg_type) == ARG_PTR_TO_ARENA) {
+		    base_type(arg_type) == ARG_PTR_TO_ARENA ||
+		    base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
 			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
 			if (ret)
 				return ret;
@@ -10911,24 +10914,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-		} else if (base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
-			int err;
-
-			if (bpf_register_is_null(reg) && type_may_be_null(arg_type)) {
-				err = mark_arg_precision(env, argno);
-				if (err)
-					return err;
-				continue;
-			}
-
-			err = check_reg_type(env, reg, argno, arg_type, &meta);
-			err = err ?: check_func_arg_reg_off(env, reg, argno, arg_type);
-			if (!err && base_type(reg->type) == PTR_TO_BTF_ID)
-				err = process_arg_ptr_to_btf_id(env, reg, argno, arg_type,
-								btf_vmlinux, sub->args[slot].btf_id,
-								&meta, env->insn_idx);
-			if (err)
-				return err;
 		} else {
 			verifier_bug(env, "unrecognized %s type %d",
 				     reg_arg_name(env, argno), arg_type);
@@ -13073,7 +13058,7 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
 	if (base_type(*arg_type) != ARG_PTR_TO_BTF_ID)
 		return 0;
 
-	if (!meta->btf || arg_type_is_release(*arg_type) ||
+	if (!is_kfunc(meta) || arg_type_is_release(*arg_type) ||
 	    base_type(reg->type) == PTR_TO_BTF_ID ||
 	    reg2btf_ids[base_type(reg->type)])
 		return 0;
diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index 10019af5eb74..f639e2767e35 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -87,7 +87,7 @@ __weak int subprog_trusted_task_nonnull(struct task_struct *task __arg_trusted)
 
 SEC("?kprobe")
 __failure __log_level(2)
-__msg("R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_")
+__msg("Possibly NULL pointer passed to trusted R1")
 __msg("Caller passes invalid args into func#1 ('subprog_trusted_task_nonnull')")
 int trusted_task_arg_nonnull_fail1(void *ctx)
 {
@@ -96,7 +96,7 @@ int trusted_task_arg_nonnull_fail1(void *ctx)
 
 SEC("?tp_btf/task_newtask")
 __failure __log_level(2)
-__msg("R1 type=trusted_ptr_or_null_ expected=ptr_, trusted_ptr_, rcu_ptr_")
+__msg("Possibly NULL pointer passed to trusted R1")
 __msg("Caller passes invalid args into func#1 ('subprog_trusted_task_nonnull')")
 int trusted_task_arg_nonnull_fail2(void *ctx)
 {
-- 
2.52.0

