Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE8B21CA03
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 06:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097660; cv=none; b=kEFWfXqEXlxvuE/xmutRtYYfKtD0ihEzfYo7SOKH6oxTHRLwubMq3EbUg2e0REknm68B8nBGpgehgTY5RCT1pcD4/PCHOdaToB3D8c7hLh39DX+grvvTTxFCz2FKcc1o0rxD7Q5fxvaCz80LIJILGjqz5igKJSEHpoekEZxmx38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097660; c=relaxed/simple;
	bh=tpZxPrkfoob0KTB78YzA9A8C1AKYs6Exko++z76rCCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HDrCvRXKKisPMmmfwQJmFmx/xeZvXRJjmGZPTIC0P9bo4EllpzSJpTkT26LCYI6/fOLyst89Oos38DLTCxDBRki7p2YnrpCgwkhoZqt69oYQskk1BkucvOKtEWELfJpVQfnkAeUniqkjJ+8Dt2nthSmTbLAK4i6bHx3IkMXugZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6WO2nDu; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6WO2nDu"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so762886a34.3
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2026 23:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784097657; x=1784702457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D9vk0/cH/rGfYOIrzjfkvlX/SP/v6hEuISpipunwKO0=;
        b=H6WO2nDuHICq5vzgUgMTuy6KSYq5ssA+OfOwyaJNsNWEDzq9XWsCMALmwiBS8GtS7C
         /1hydKMaii7XlYu6QluPs8KtMU8D2NrPD3dIiuC2A8SrMU9xsiCI3yPQ5yxg7CMPP/Rd
         e7zt8FqE62S9uneAx1Q9YZ371J8jUTlUAnNOttpLoj/7ahzKQ53t+YrUkX7D+u9SdVUU
         EsDDpQxu+4jv626y1zmrQs5MoKUqhRB7ozMubwuToGZ1PsmtW680tx8HQp1nlAS6NkTO
         TMRdwq6AKJC37lal11Dm0QYz0LejDFcgOXZf3hX5slK+sPiBpn2L5ruze3dtCyEzWBEN
         rtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784097657; x=1784702457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D9vk0/cH/rGfYOIrzjfkvlX/SP/v6hEuISpipunwKO0=;
        b=J/Uag/BN+HUheljPCEMaXUmSWLbT6BNCCXkvZvdsx4jcElKZlUOC9h1hYLTEp0qYYF
         5feJ9H88wN97ps7m8ose5d//tT0WLRr76/YuJRTpEnB0MDEsXaab7JFpl7rxHb+69oF/
         qdKKArkldsfqgalrPwKBzhqE1fOV4ZIcns3lfZ15VVKleLTv49QYd2NrEtZ9BVjkJOAr
         upMpvGCEdC9051dO0ENP6ZH/jTl2dG/t67i93SOKbaVKZ0ywqG+8332lg3IJiJamKoxq
         96pkkJDC04T9hsmj/mXggcjo9VDw8E4Vy+jWBMhBPS+V364HaRojscSPjob0Ve+fIEzJ
         Qg0g==
X-Gm-Message-State: AOJu0YxnpFUcqgaaFI8NIojbHgsQMVbBMHWS2iY98lWS8lEreV1O44SP
	ko1spzt4PsBdOH5C5GgYK1uAUuIexBF+ps+HKS7S2sCxmrWBOvQaJiWZ3yi7lw==
X-Gm-Gg: AfdE7cnDXr8r5VaoEvzacRD5MrRvPm2byXI2HdW6LzcHhCtxNW7UIHVJb4Jjaftvuvc
	K5li2vcBs3Q9srb5AeKnln0yZZdEUWqqbHOyhPLnyWsPJBhnuGgWsZFDez6r0LPnCHTRjz9S65/
	4zY/y/Af+7aLUpgjyp1slzYkOxUwil2z817rKT/GhXWkaHP4XPqptgftzZ7MB/+5Qv1oXi7OOmS
	SKEMUc/QWCh/qI2ZraOBAuPd8PSmzMQo+vuP2CsohyF/3lJQ3vUn1SK3r5CPrSXl5VFmjWMaMmK
	jOznI8HTREuRMi3nhv9N+GwvAdYCesr+W97zz39GFamxTz4XaJL/tZspVbis9P+pmqvis2A+ihB
	9heeUShwEIcy1x6yvBwzZATXg8XVRh+qVkCHXnAOjicszrC23ZRLxCy3uHFxiZrvMiQissxjJwD
	lXOFhwzfyduMOy
X-Received: by 2002:a05:6830:6ae6:b0:7e6:e385:4c1e with SMTP id 46e09a7af769-7ec096027c1mr9505365a34.4.1784097657560;
        Tue, 14 Jul 2026 23:40:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcb262f50sm16339831a34.15.2026.07.14.23.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 23:40:57 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 4/7] bpf: Unify helper and kfunc allocation-size argument handling
Date: Tue, 14 Jul 2026 23:40:44 -0700
Message-ID: <20260715064047.1793790-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715064047.1793790-1-ameryhung@gmail.com>
References: <20260715064047.1793790-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The constant "size of the PTR_TO_MEM returned in R0" argument is handled by
both helpers (ARG_CONST_ALLOC_SIZE_OR_ZERO) and kfuncs (__rdonly_buf_size /
__rdwr_buf_size), each with its own meta field (meta->mem_size,
meta->r0_size) and duplicated validation. Add struct arg_alloc_mem_desc
and a shared process_const_alloc_mem_size(), and replace both fields with
meta->arg_alloc_mem.

The desc records presence with a 'found' flag instead of using a non-zero
size as the sentinel. This also fixes a pre-existing bug on the kfunc
return path: "no size argument" was tested as r0_size == 0, so an explicit
__rdonly_buf_size/__rdwr_buf_size of 0 was treated as absent and fell
through to btf_resolve_size(), giving R0 the size of the pointed-to return
type instead of 0. With 'found', an explicit zero size is honored and
btf_resolve_size() is used only when no size argument was passed.

The size is stored in a u32, matching regs[R0].mem_size. The U32_MAX
check now apply to both helper and kfunc through
process_const_alloc_mem_size().

Fold bpf_session_cookie return size assignment into current kfunc return
size resolution path.

Note that verifier saves kfunc return size through r0_size instead of
mem_size. The later has no active readers so remove it.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h                  |  9 +-
 kernel/bpf/verifier.c                         | 87 ++++++++++---------
 .../selftests/bpf/prog_tests/kfunc_call.c     |  2 +-
 3 files changed, 55 insertions(+), 43 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index d3592f5b8621..e3eda72cbf67 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1473,6 +1473,12 @@ struct arg_raw_mem_desc {
 	int size;
 };
 
+/* Size of PTR_TO_MEM returned, taken from a constant allocation-size argument */
+struct ret_mem_desc {
+	u32 size;
+	bool found;
+};
+
 struct bpf_kfunc_call_arg_meta {
 	/* In parameters */
 	struct btf *btf;
@@ -1484,7 +1490,6 @@ struct bpf_kfunc_call_arg_meta {
 	u8 release_regno;
 	bool r0_rdonly;
 	u32 ret_btf_id;
-	u64 r0_size;
 	u32 subprogno;
 	struct {
 		u64 value;
@@ -1519,7 +1524,7 @@ struct bpf_kfunc_call_arg_meta {
 	struct bpf_map_desc map;
 	struct bpf_dynptr_desc dynptr;
 	struct ref_obj_desc ref_obj;
-	u64 mem_size;
+	struct ret_mem_desc ret_mem;
 };
 
 int bpf_get_helper_proto(struct bpf_verifier_env *env, int func_id,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 529ad0b4fcbd..463b49df4ff9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -257,9 +257,9 @@ struct bpf_call_arg_meta {
 	struct bpf_dynptr_desc dynptr;
 	struct ref_obj_desc ref_obj;
 	struct arg_raw_mem_desc arg_raw_mem;
+	struct ret_mem_desc ret_mem;
 	bool pkt_access;
 	u8 release_regno;
-	int mem_size;
 	u64 msize_max_value;
 	int func_id;
 	struct btf *btf;
@@ -6974,6 +6974,40 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
 	return err;
 }
 
+static int process_const_alloc_mem_size(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
+					argno_t argno, struct ret_mem_desc *ret_mem)
+{
+	int regno = reg_from_argno(argno);
+	int err;
+
+	if (ret_mem->found) {
+		verifier_bug(env, "only one allocation size argument permitted");
+		return -EFAULT;
+	}
+
+	if (!tnum_is_const(reg->var_off)) {
+		verbose(env, "%s is not a const\n", reg_arg_name(env, argno));
+		return -EINVAL;
+	}
+
+	if (reg->var_off.value > U32_MAX) {
+		verbose(env, "%s allocation size exceeds u32 max\n", reg_arg_name(env, argno));
+		return -EINVAL;
+	}
+
+	if (regno >= 0)
+		err = mark_chain_precision(env, regno);
+	else
+		err = mark_stack_arg_precision(env, arg_idx_from_argno(argno));
+	if (err)
+		return err;
+
+	ret_mem->size = reg->var_off.value;
+	ret_mem->found = true;
+
+	return 0;
+}
+
 static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *mem_reg,
 				    struct bpf_reg_state *size_reg, argno_t mem_argno, argno_t size_argno)
 {
@@ -8478,13 +8512,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			return err;
 		break;
 	case ARG_CONST_ALLOC_SIZE_OR_ZERO:
-		if (!tnum_is_const(reg->var_off)) {
-			verbose(env, "R%d is not a known constant'\n",
-				regno);
-			return -EACCES;
-		}
-		meta->mem_size = reg->var_off.value;
-		err = mark_chain_precision(env, regno);
+		err = process_const_alloc_mem_size(env, reg, argno, &meta->ret_mem);
 		if (err)
 			return err;
 		break;
@@ -10516,7 +10544,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	case RET_PTR_TO_MEM:
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
-		regs[BPF_REG_0].mem_size = meta.mem_size;
+		regs[BPF_REG_0].mem_size = meta.ret_mem.size;
 		break;
 	case RET_PTR_TO_MEM_OR_BTF_ID:
 	{
@@ -12066,28 +12094,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			}
 
 			if (is_ret_buf_sz) {
-				if (meta->r0_size) {
-					verbose(env, "2 or more rdonly/rdwr_buf_size parameters for kfunc");
-					return -EINVAL;
-				}
-
-				if (!tnum_is_const(reg->var_off)) {
-					verbose(env, "%s is not a const\n",
-						reg_arg_name(env, argno));
-					return -EINVAL;
-				}
-
-				meta->r0_size = reg->var_off.value;
-				if (meta->r0_size > U32_MAX) {
-					verbose(env, "%s rdonly/rdwr_buf_size exceeds u32 max\n",
-						reg_arg_name(env, argno));
-					return -EINVAL;
-				}
-				if (regno >= 0)
-					ret = mark_chain_precision(env, regno);
-				else
-					ret = mark_stack_arg_precision(env, i);
-				if (ret)
+				ret = process_const_alloc_mem_size(env, reg, argno, &meta->ret_mem);
+				if (ret < 0)
 					return ret;
 			}
 			continue;
@@ -13066,11 +13074,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie]) {
-		meta.r0_size = sizeof(u64);
-		meta.r0_rdonly = false;
-	}
-
 	if (is_bpf_wq_set_callback_kfunc(meta.func_id)) {
 		err = push_callback_call(env, insn, insn_idx, meta.subprogno,
 					 set_timer_callback_state);
@@ -13203,15 +13206,19 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			/* kfunc returning 'void *' is equivalent to returning scalar */
 			mark_reg_unknown(env, regs, BPF_REG_0);
 		} else if (!__btf_type_is_struct(ptr_type)) {
-			if (!meta.r0_size) {
+			if (!meta.ret_mem.found) {
 				__u32 sz;
 
 				if (!IS_ERR(btf_resolve_size(desc_btf, ptr_type, &sz))) {
-					meta.r0_size = sz;
+					meta.ret_mem.found = true;
+					meta.ret_mem.size = sz;
 					meta.r0_rdonly = true;
 				}
+
+				if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie])
+					meta.r0_rdonly = false;
 			}
-			if (!meta.r0_size) {
+			if (!meta.ret_mem.found) {
 				ptr_type_name = btf_name_by_offset(desc_btf,
 								   ptr_type->name_off);
 				verbose(env,
@@ -13224,7 +13231,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 			mark_reg_known_zero(env, regs, BPF_REG_0);
 			regs[BPF_REG_0].type = PTR_TO_MEM;
-			regs[BPF_REG_0].mem_size = meta.r0_size;
+			regs[BPF_REG_0].mem_size = meta.ret_mem.size;
 
 			if (meta.r0_rdonly)
 				regs[BPF_REG_0].type |= MEM_RDONLY;
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
index 67a30bf69509..c9fce95d220e 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
@@ -66,7 +66,7 @@ static struct kfunc_test_params kfunc_tests[] = {
 	TC_FAIL(kfunc_call_test_get_mem_fail_rdonly, 0, "R0 cannot write into rdonly_mem"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_use_after_free, 0, "invalid mem access 'scalar'"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_oob, 0, "min value is outside of the allowed memory range"),
-	TC_FAIL(kfunc_call_test_get_mem_fail_oversized, 0, "rdonly/rdwr_buf_size exceeds u32 max"),
+	TC_FAIL(kfunc_call_test_get_mem_fail_oversized, 0, "allocation size exceeds u32 max"),
 	TC_FAIL(kfunc_call_test_get_mem_fail_not_const, 0, "is not a const"),
 	TC_FAIL(kfunc_call_test_mem_acquire_fail, 0, "acquire kernel function does not return PTR_TO_BTF_ID"),
 	TC_FAIL(kfunc_call_test_pointer_arg_type_mismatch, 0, "R1 expected pointer to ctx, but got scalar"),
-- 
2.52.0

