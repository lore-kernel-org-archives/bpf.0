Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805782D877B
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 23:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783638172; cv=none; b=cOQkdOJAMKfiBLj1jk4qv98oJo1fd+vQ6O3a5gAVZ9jGzwf61Uej6tjKMjFGms7/2UTGP29liECt8/ooitBMXqZvKpxAEaasdVX06ZqYr9aixJfyqZ/rA9s04+gbiWxlcdNDSwx/lerqcFRV6aGdRHuicicOTh5zy8FypoxNwxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783638172; c=relaxed/simple;
	bh=8Tb7K3myMxxeZxAVa5J6j69J7aDLttvkUccM/nqQYZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=btBrXXlvMctL4nWlvYOEiSlLaasOkrpGY6ieDQDlgOef0IdCAP8lRLpGzffZD6YGA2ouinwRiHQ+n1O/G0QRIcAMOpA4uxRmU3KY+JulE0vzTgY0npCdND0lnJsn1prnJbsqi8P9fkKR7ge6uKt7wU4TQ00uDBds8wMx1wLbFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yeg6omUB; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yeg6omUB"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a31c05e1f7so114293eaf.0
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 16:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783638169; x=1784242969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TE+o2IPKwmKIjOc18BnjnX1bFbIIJlgoOZ0FJQmekfo=;
        b=Yeg6omUB7jSrqJIcjDUlzunk2UL3Z/bYNk+mNSZBHB8ClUX33ZsELE5PDL8aVxhAb7
         8TTlcizsYxyYrV/rCmSTTb7JCm3L54CwabfnxlfiXbRYtSLbiNkRrLKtsD7AuxogLBFD
         25oqBqPXcD759YimWSx4jpA6VArBTK5SgCXHrOUKstw+HYNcHSCqXe50zZY7kliOD3Ap
         dRf6KLBAa29Tk63MmcZTzYcFSslH/iUIzL8beP+qaq4/F+1m35nUCN3VlkM6IwLjYqUi
         TSCBeA1n1L4dMJnyfY4Hj+R5v9E/CDkC3+4wLpHIKLRdNq5e8erVc+dxL5grNEbRCR7A
         +O4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783638169; x=1784242969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TE+o2IPKwmKIjOc18BnjnX1bFbIIJlgoOZ0FJQmekfo=;
        b=gZouMbp7PyKtYtKoFpdzqwgRXKDUBH8CBDM1eOi6j7fwJDcw87Zs9AM6LbP83L9lS9
         B79a8ooYaN2pV1g6nC/dJ7CKdY4K00XDDNaaC+bRG2L+orSbw0LlczL5XVA/1vynkKGw
         voRhyrr1A57/CTAXUpiuPRQ9T4QqiTq7+uxMqAwqS9HXiggxlc7jHXjRK3JWSXmlug5V
         ItBboxRb6nEIPRi2Ifbb5Ucx37CemuBOX4gKE8uM0OPbqRfQuc3uuoGog+dmgpsTwXBn
         Wd2exRH4u8h+r0Y7O4HG3IAqMyzwQg/ajYPPG+Tpk4+hqTwn1+LN0Enlv/anE6CJKYP9
         mfmw==
X-Gm-Message-State: AOJu0Ywk6UIYf225fFd84yaAWWH02Qly2t/tkpz+BVsv5YuxC167y/q9
	QXllD7UgYKP0w4ajZmWgqCVXzrYRaEfAk0f03+cqyCbSNar1n4I11mxERrZhRw==
X-Gm-Gg: AfdE7cmn0rXGzuMwHgp0THnN3VjTsix5TAV0VGlTCrLHo3rTeG96Ii2lA7yWqztVODs
	OrxU0InE/atAezCQqqFcgoYNte4EIHwia8lUabPjUMY+oCHkyzJRArL1EVjY4EI5/Za0YZRPIw0
	yqvFY0ED9mSsNvL1yW0U2kYGpw0GHpoImNrleT/BQTIlyabxyK1AxbObIGb/gLBzdS8JibA77Ak
	qVEvB+TrUe/4FGEuB/s1PTXqGYhHNeZWfh4ooA3g8UTUlRoxEFbzVG8ROjZfoTmT557P2AAv/4p
	Kg3BN2cBv98qgmAVhiyQB2G3ryRisFVHx50GzghmNRrXrXJYKsiTq++w5soPEsqc4Gt5rwG11eX
	PdMk9WCExmL829ZipGOEXgfGhsGd+1C5dNDD6Pukaq+HPXNV20MOzh3xivKEY6CQIXYaawwdknu
	aNXF4=
X-Received: by 2002:a05:6820:1c84:b0:69d:f7bf:c53f with SMTP id 006d021491bc7-6a36da4c037mr6549584eaf.39.1783638169211;
        Thu, 09 Jul 2026 16:02:49 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcafda2ffsm5141833a34.12.2026.07.09.16.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 16:02:48 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 3/4] bpf: Unify helper and kfunc allocation-size argument handling
Date: Thu,  9 Jul 2026 16:02:40 -0700
Message-ID: <20260709230242.2003459-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260709230242.2003459-1-ameryhung@gmail.com>
References: <20260709230242.2003459-1-ameryhung@gmail.com>
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

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/bpf_verifier.h                  |  9 +-
 kernel/bpf/verifier.c                         | 87 ++++++++++---------
 .../selftests/bpf/prog_tests/kfunc_call.c     |  2 +-
 3 files changed, 55 insertions(+), 43 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 056b99d26cca..3ed788ec6afc 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1473,6 +1473,12 @@ struct arg_raw_mem_desc {
 	int size;
 };
 
+/* Size of PTR_TO_MEM returned, taken from a constant allocation-size argument */
+struct arg_alloc_mem_desc {
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
@@ -1520,7 +1525,7 @@ struct bpf_kfunc_call_arg_meta {
 	struct bpf_dynptr_desc dynptr;
 	struct ref_obj_desc ref_obj;
 	struct arg_raw_mem_desc arg_raw_mem;
-	u64 mem_size;
+	struct arg_alloc_mem_desc arg_alloc_mem;
 };
 
 int bpf_get_helper_proto(struct bpf_verifier_env *env, int func_id,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e2a3ed67d2eb..fcd9715eff01 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -257,9 +257,9 @@ struct bpf_call_arg_meta {
 	struct bpf_dynptr_desc dynptr;
 	struct ref_obj_desc ref_obj;
 	struct arg_raw_mem_desc arg_raw_mem;
+	struct arg_alloc_mem_desc arg_alloc_mem;
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
+					int regno, argno_t argno,
+					struct arg_alloc_mem_desc *arg_alloc_mem)
+{
+	int err;
+
+	if (arg_alloc_mem->found) {
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
+	arg_alloc_mem->size = reg->var_off.value;
+	arg_alloc_mem->found = true;
+
+	return 0;
+}
+
 static int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state *mem_reg,
 				    struct bpf_reg_state *size_reg, argno_t mem_argno, argno_t size_argno)
 {
@@ -8474,13 +8508,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
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
+		err = process_const_alloc_mem_size(env, reg, regno, argno, &meta->arg_alloc_mem);
 		if (err)
 			return err;
 		break;
@@ -10512,7 +10540,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	case RET_PTR_TO_MEM:
 		mark_reg_known_zero(env, regs, BPF_REG_0);
 		regs[BPF_REG_0].type = PTR_TO_MEM | ret_flag;
-		regs[BPF_REG_0].mem_size = meta.mem_size;
+		regs[BPF_REG_0].mem_size = meta.arg_alloc_mem.size;
 		break;
 	case RET_PTR_TO_MEM_OR_BTF_ID:
 	{
@@ -12062,28 +12090,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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
+				ret = process_const_alloc_mem_size(env, reg, regno, argno, &meta->arg_alloc_mem);
+				if (ret < 0)
 					return ret;
 			}
 			continue;
@@ -13062,11 +13070,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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
@@ -13199,15 +13202,19 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			/* kfunc returning 'void *' is equivalent to returning scalar */
 			mark_reg_unknown(env, regs, BPF_REG_0);
 		} else if (!__btf_type_is_struct(ptr_type)) {
-			if (!meta.r0_size) {
+			if (!meta.arg_alloc_mem.found) {
 				__u32 sz;
 
 				if (!IS_ERR(btf_resolve_size(desc_btf, ptr_type, &sz))) {
-					meta.r0_size = sz;
+					meta.arg_alloc_mem.found = true;
+					meta.arg_alloc_mem.size = sz;
 					meta.r0_rdonly = true;
 				}
+
+				if (meta.func_id == special_kfunc_list[KF_bpf_session_cookie])
+					meta.r0_rdonly = false;
 			}
-			if (!meta.r0_size) {
+			if (!meta.arg_alloc_mem.found) {
 				ptr_type_name = btf_name_by_offset(desc_btf,
 								   ptr_type->name_off);
 				verbose(env,
@@ -13220,7 +13227,7 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 
 			mark_reg_known_zero(env, regs, BPF_REG_0);
 			regs[BPF_REG_0].type = PTR_TO_MEM;
-			regs[BPF_REG_0].mem_size = meta.r0_size;
+			regs[BPF_REG_0].mem_size = meta.arg_alloc_mem.size;
 
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

