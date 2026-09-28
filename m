Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4189B37F323
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619273; cv=none; b=imqyhFVu8qex0KW7b9FtAyEDolK3LXMPFOl8GJb0wCSwKvhbfHdybZB974oga+1GuUidnBmdhhgrk1ghv7mnCfKQp3woAsFoFsWriwf/VL3vbnfNvkuPQTwS0L2K4/8MZ163fmPGL4bSrxeZFfsidq8Wn5+RicbOUj2Dzuf5gvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619273; c=relaxed/simple;
	bh=krVgwBKxGenAQlr4qB1VI5gWs7dZ1PMM0cxQMpOHUkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMtVBsHis/nufK4YUBZueHRFxyYgf/vj64YEOtngj822WPidWK8kPWqOJzHULKZG6MLq/fn7TwYPkv5OQNzCQ0SFLD6LcFXeyz2M5USD2hyZshNaxamec9I+amFpPavVs38J2jIRznogG47YsdESbE328N4K59I/wom9hDYMBfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j2rkq59h; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2rkq59h"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-81b15bca7e0so1479229a34.2
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790619271; x=1791224071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4O4Ep3G+eq6+z+cs+1+chopeITYkiVdbu8drbsnUApE=;
        b=j2rkq59hqR4QUV89gb68I5/teJyalqiBcCIMZYv8X6Lq2lLk0tG9/f/J+aPXwECUiN
         ngT8Diuckax4YulbJ39hkbEp+mu5LZD+tKigDokp1ND419Qds6306InY5Q8zflZyUNvX
         5GCUERvqocb0nam/uhNeXyzN+yYDOSqDEaJf3MqC1yBe23cs1oyj93oSyOrsCHb1VX+y
         oLB7pgVYT/0+Yw7VHSj+adYP/2zZrQfavveSeg5+P3/dZwdFBf38aqm7EIkO8VQLlbV/
         TfW/x+wSVE7vrgtlfYnaobsANGZZF2RNUtwXlabfwmZrxvz/AsKWMquvrQYpCx1mdeVO
         uG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619271; x=1791224071;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4O4Ep3G+eq6+z+cs+1+chopeITYkiVdbu8drbsnUApE=;
        b=uxgGLnIx0h0FEmH8Cg5hY2RMBdHMMCZyYMhtbsDKx4S39YXk068rnro36G0+vBZ62N
         qs7rlPgQ0KF9Sp5aNqoXmUojfCNfcmmNhG39TN7esDW/dUih/t6nsuierQboN8WWNFw3
         qMgSq3b6OCn73eoSuAg2Ks2SspYbavu6q94yyzXgHFTJ5B/ckkpEDmJDiADtUct3acTp
         weqCRnhkfHPueIKM7Eu9HYdSnxmAI2H8dkVP5x//TlkvZPt6wHTpikve+UF33kT4xUnw
         jqk5LQcyujF/jL7UkMY/RsiTewhC/AMmyrfomoVybVv4wN9aw3PGC/yeFSXuP3NseD5N
         MOiw==
X-Gm-Message-State: AFuF++kiLxyI3PbBXvG/pAeSRyXOqTQD3t2uNPdUfadMRzcUVQ0GBhO0
	chTiWQdYL+U0axcP5nViDmRLkAiV42q0iOfEvrzkDVLpxY4MJ/FVO+jrCrVyhg==
X-Gm-Gg: AYBFou2CacWi4pD+G+m1Vb18QmIPLtCMTIDC7rlC+pe8IdQZ9WAAZz27h2S+oC23gcQ
	rINI3viqMryjfddaZCPwWFC8TaXL7KRfbYJpJhLwvQEydO8XrNIUxGPbP4+XCdhTjTMQpJhYv3d
	Gsmqm+GvRw3/slBugkWr9mImc6tngvsKhvb6Q/jclkQrQ/mhQpu1EnHBBWxlVOnIXEqUnB+wnCI
	vE8MT47zqLhNm1sNO51ySTItimkeFigBZq+mQeUU3XuA3ylvF427f4/jDHHPpgZi9dGinWD7Qsf
	nwFhxbM2ckY4+7AR4zLaJfoS9Hlj0+KBOuSgOTX2H1s3Yw2wr7+Lqh8QkzReDtiSqUZT4l/ntsm
	B8vNagr61Lf49nstmiZlQ/DlfmIJpfRf179nbrWX/3lDIrUJ2EJk6n/yuleBGAQ/uMONbWfsJ9P
	t63+NnwoxC5MuL0aLpJ71+0K+v0SJEAGUUA3IfpeioODOw6Iml9eZG5qhxTXj0
X-Received: by 2002:a9d:645a:0:b0:81a:cc8a:ff8a with SMTP id 46e09a7af769-81acc8b39ddmr4518502a34.21.1790619271074;
        Mon, 28 Sep 2026 11:14:31 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81d583f8a58sm2365374a34.10.2026.09.28.11.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:14:29 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 09/11] bpf: Check global subprog BTF-ID arguments in the common path
Date: Mon, 28 Sep 2026 11:14:11 -0700
Message-ID: <20260928181414.644158-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928181414.644158-1-ameryhung@gmail.com>
References: <20260928181414.644158-1-ameryhung@gmail.com>
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
index fb0e2649bab3..a39b23864878 100644
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

