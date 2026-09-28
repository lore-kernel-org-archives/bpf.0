Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C078F3C3F76
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790621635; cv=none; b=kmrJdKJyQvfnPzWer31sNhGJWeC73NFzyRbOgpNYq/sH06p0qaNeoPrAqwd+zVe2YtAKAFzlATIXsIPe6zV4cf236yJz8+lnKkhBks1E8ilCnKD685DxUrD5F9FPaHvzyBqD+c5nt2ft4oB8ahuZfsbNjFrWA1fxad7r0zySuRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790621635; c=relaxed/simple;
	bh=/XR2MDzbomyBgKri1RSD/LbSSuWbvWNLPfMzsiO1Joc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lad4/s2odlQQ8ZUGSKVuTtR9eUw1pEoXfqF0Z6MxPLMqWNrAbtBmk3lkwVGMslHMg8QCE2H+3gLsB9GpjsC+NAax7Q2nTqF7FCkesiSc1Wi9DXzsA3nlMqc5UVo8yF9zKOgAYRqpWn04RBihSzjxliMkYuKKqDZuJu8UBWUglMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3gl6zsN; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3gl6zsN"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-8144632e066so1846622a34.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790621629; x=1791226429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wOnSY9gkXXToVrUnyNDKuuTK65JjrekELxAB+Bg1ZCU=;
        b=O3gl6zsNmS9itFW45w0gF/H7EGjBytJzN4iQNw3kCT+yUjPx3b7QH/S4UuSbgVFSYh
         /MKhtA9tdtdI/n0kOur5MKUGX+wpNvvUF8J7R4Ce1i4EQKMnuKJN0B2sw6vsPcImtXUW
         GF4hpuEq3QtJrOSuggYqeZOj++ZUnqE8H0ktNb2W1MUUkYD1IGaYXqhNK5VDOX+vnRHj
         ujBqXqNlYhyonkVmjVVc1YTKj5vcjXuAic9u8T2dXZ1UrWOrbtAZiojq8mSdEAPF4shy
         tnNlTxZchK/MfxBxycs0OysxBEkrQdBvTFMiC7IpRvA1jk/vVC7Xa2C9DVmsjIg5VpKR
         UxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790621629; x=1791226429;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wOnSY9gkXXToVrUnyNDKuuTK65JjrekELxAB+Bg1ZCU=;
        b=ZlH79vG8LhqBoH7P7fbnwld3xGmqiWjewETuPJSdUr8zbcOKpPOSFLgulRECMdnl5q
         8hTbrHCWykVf8Ejwn66Jg+3+z5yQoqWEaObqAn+LqkQW7UxTSd0SsUcjPTlFKMqm5g1U
         GsEBE7fZpMSTDmnSV//gvbfYzEt5gnjCgpE1OhnyRfXWl/N0+k+MFwJZIyZvWlaeFPQY
         UT+JaygJRbxjpg1XfHHnStFGKwJwAWWtXWRjVxwoBFyZbIsCOKgOAs+JFC6X2fDsgvgl
         t7DciiKlLU/ZIynPMU8TIZMTSMHjWLOCnAWOYdVGuh7xCQN2NUr6m0DOBPyk/2frx/bp
         WHLg==
X-Gm-Message-State: AFuF++ksPreMpPjrurw/d1A9V73DCmwQb8WD5hyIl6f+U9JhHmGpzgI4
	1yE2xbHpUO+pP9Ljy5oWKZm1J+PVLscIsOoCQdxOH0QyHLNPpxHsKfNN6DUJvQ==
X-Gm-Gg: AYBFou2Kdta7SAjPfV+RGrjUt9MH5Pc/ncnlshnrqhVfjb4qTtzbc0YgIjqWLpQoxYD
	Y1MIxlhpHnwgchGJizYUwIkwwonxJc+hP1LsfTCSWOVeFP+IaUZ35bfrScoRVz6PbJuXO27vS1D
	uk1SP6RCIqdQ/Xjia4/ZbBPe4GjTHzBCvV1rhQgCL444yQvHPV59wlAXhV7U+GZ/2+t4uJQeCCP
	GQ7vB+L2W/Z6v5lVAqnGHAgQSeqUtIvU4K0PX2Y518yQmAsegA77QA2+mH32JhNLo29f3dOpOX0
	lxC3w03ULohsh+agyInF6zksCgrglBUAJLNGn5JEACjieDJW6grOe7osTDrwsyfU5K65vbS2028
	7n6dBsv4hj8PdrtFHywojtsfBodmwTbn0Df+H9wyQ7vrddlrUOp7Fvrjwm1vJbZA9NF2ZTrgNKC
	lyvvmwO8HoNx5p9aGZURHgRu+VjZPaN5Ki/0hBSR7mwKRjVsTLwu0h2dzbxpV/wEJkYyiRBV4=
X-Received: by 2002:a05:6820:200e:b0:6d8:bba5:6574 with SMTP id 006d021491bc7-6d8bba56c34mr3970815eaf.76.1790621628768;
        Mon, 28 Sep 2026 11:53:48 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-81d58f1748fsm2730077a34.23.2026.09.28.11.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:53:48 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 09/11] bpf: Check global subprog BTF-ID arguments in the common path
Date: Mon, 28 Sep 2026 11:53:32 -0700
Message-ID: <20260928185334.1004200-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260928185334.1004200-1-ameryhung@gmail.com>
References: <20260928185334.1004200-1-ameryhung@gmail.com>
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
index 0d554e95fdb5..8aa1336453a4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9501,7 +9501,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 	case ARG_PTR_TO_BTF_ID_SOCK_COMMON:
 	{
 		const u32 *arg_btf_id = fn->arg_btf_id[arg];
-		const struct btf *arg_btf = meta->btf ?: btf_vmlinux;
+		const struct btf *arg_btf = is_kfunc(meta) ? meta->btf : btf_vmlinux;
 
 		if (!meta->btf) {
 			const struct bpf_reg_types *compatible;
@@ -9529,8 +9529,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 			}
 		}
 
-		if (meta->btf && (!is_trusted_reg(env, reg) ||
-				  bpf_type_has_unsafe_modifiers(reg->type))) {
+		if (is_kfunc(meta) && (!is_trusted_reg(env, reg) ||
+				       bpf_type_has_unsafe_modifiers(reg->type))) {
 			if (!(arg_type & MEM_RCU)) {
 				const char *actual_type, *arg_name, *expected_type;
 
@@ -10806,6 +10806,8 @@ static void gen_subprog_arg_proto(const struct bpf_subprog_info *sub, const stru
 			arg_type = ARG_IGNORE;
 		} else if (base_type(arg_type) == ARG_PTR_TO_ARENA) {
 			arg_type |= PTR_MAYBE_NULL;
+		} else if (base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
+			proto->arg_btf_id[arg] = &sub->args[slot].btf_id;
 		}
 		proto->arg_type[arg] = arg_type;
 		t = btf_type_skip_modifiers(btf, args[arg].type, NULL);
@@ -10872,7 +10874,8 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
 
 		if (arg_type == ARG_SCALAR || arg_type == ARG_IGNORE ||
 		    arg_type == ARG_PTR_TO_CTX || arg_type == ARG_PTR_TO_DYNPTR ||
-		    base_type(arg_type) == ARG_PTR_TO_ARENA) {
+		    base_type(arg_type) == ARG_PTR_TO_ARENA ||
+		    base_type(arg_type) == ARG_PTR_TO_BTF_ID) {
 			ret = check_func_arg(env, arg, slot, 0, &meta, env->insn_idx);
 			if (ret)
 				return ret;
@@ -10900,24 +10903,6 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env, int subprog,
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
@@ -13063,7 +13048,7 @@ static int resolve_func_arg_type(struct bpf_verifier_env *env,
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

