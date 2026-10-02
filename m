Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DD7484885
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938350; cv=none; b=N3CO0/7TW9s4j8rsYKZ6vJ6p79vBla3BxbP9z9E5ZclkYYNgm1u2M3mujr4wFTtTJecAij3378FqpY6dID2QNSSEIJue9gXUQsced4Zf24V8IlSwegMYWTNrjHNkZukaMD0yQKmNJveX99/78Q7oXraqAKYwju4loctkmUIoJXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938350; c=relaxed/simple;
	bh=tfoJGY7pKZXuqdWp75+K+QOwKR0XLQkEk8HIejgmIQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RFbYj8bNF0FwOA0MufoVSsvv9M3vTfn2Wt551uCtVpEnu7ia1ar9/fEpQkaRchGqae2m4PzXKAWovddrQN1D1qLYe/lqQ4PCa8gRCswd760MpCcjJYf38Fxoq/1MCQ09k6ejAeyDWnuQMPoVC+VJMSOCaWSKbOY+qK4rLDfvqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=p4Y3HkFb; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="p4Y3HkFb"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso47171045e9.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 03:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790938346; x=1791543146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D+naoGPp3j7LFCqxBys58/sTU3xJi22TPpniORv4l4A=;
        b=p4Y3HkFbCWmGGUduWKjr5y5Ni/iz8H9SkrWWheev8FZjH2pAI0Aq4NOvMt1T0GXtNm
         mZRAH649pXrNXE2jqn4KsUL2v+BuwpFvRF91QL0zzui7jeRxO32b+0wyVxRJsz4ucPZI
         coXSy1SeZUv6junsrGg/MQXiJ35v9EfwgQWhaDnVVH2xbFPK3wwhq3ZniLc/SyzS9wpU
         VBCDk8Rzvem1drB75oGQ6v8p4Xy+SHQCtSJGFuKq0+tUM+9TY8FdnqGbw7ttrrjrK6av
         Ya6hGFpDBnqJKtD48JvUzRY4lXFauvO3GlUfEpvq5356/nh3q51ETUhDcx/lQqIFnXOe
         UsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938346; x=1791543146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D+naoGPp3j7LFCqxBys58/sTU3xJi22TPpniORv4l4A=;
        b=RZCN7XwZBOnwcAs9zIqXPD0ykBroLb5WUT9yd9ewiQhW1Azwq5Xgs3M/8QvcSV1bHV
         XqM4fXFOgeJ7+Yu3B0nQPI1iAvYkyjh6cUpo1028z0PGZlsXSc45ETwdlap3GZ84IfKq
         Eae7JtMVOkfKHoP6vnxz0EdWFv4IehdXcja7YEcuHA3ogzl8ucj5KwzDfE7L4wNV3jYG
         pPqha7VA1RdwsVNaFpYoEaMu0oPT3hko5I+R7u4XpeRFLU/V/xA5ImonVtBbbhTdwhUP
         dYm1dnYUojx/K2MT5E0ZL7GN8wgCOZ+1Q1Xw3CfEG7CTEWPO2MXz7ilubLFqBLVQe8m/
         h6KQ==
X-Gm-Message-State: AFuF++n7WGxxZ+CuklYGYfpaMCv0XfAqeFDjeiZh2yiby/jtubHGODNW
	HYQJjUUDCFErnHu+5/UXuSJy4pTkb9k+b3EpS0zazXzkP/I8MItYr/2VRqMPExXZoPNjhTwVb3J
	yn+9bvCk=
X-Gm-Gg: AYBFou13FaP2IckOm6gKBDcP9kYL1F+yS2vmCoMHRtuudBEvk6JL1HTuTVXFShhrBCh
	bK3s+pDqLcTcxwSSwbaoL3vVJ4gG2NS4bs89/NwTHVkshbZ6abBj40YCDXfJNHAeOgeQQH4QtSF
	1gq2XwxMeT1xXKXUmQ3Kd5xNMjNqT3/W2C++9NVtvARdgOqYJ0cWED1vW5ckoReEqQjf8cEBJU4
	bsf1VeLf74d+OmGSCJoXA5eHe3Q+PUqq0isuTC+5BHj3mOXDIr+ZzmOkdpG89OlVPWvV10fdxbd
	QVSc+olWgHUtRiqkFyO2fx2Z9m0btzJc4tTzw2bfXHPab5ybs8dbfw32i/S2lnDtOklsKsCmdaD
	R15LInawBRPOp/q1s/Hh2uDI+7Txvsthn7Btykq099NQYewvoLeylpgHCO7uQjuWgQLdfqn6V7v
	2inc6BxumvxZLJvrYdh/ciwgHiRBp0DkkaAbtO8V+m9YgfMilhKiHR3RbelA==
X-Received: by 2002:a05:600c:154b:b0:4a0:1f90:5951 with SMTP id 5b1f17b1804b1-4a027577cd0mr39148185e9.27.1790938346183;
        Fri, 02 Oct 2026 03:52:26 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c092:600::1:5543])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027da120bsm77866625e9.0.2026.10.02.03.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:52:25 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [RESEND PATCH bpf-next v6 5/7] bpf: Directly store kfunc desc index in instruction off field
Date: Fri,  2 Oct 2026 10:52:16 +0000
Message-ID: <20261002105218.6171-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002105218.6171-1-emil@etsalapatis.com>
References: <20261002105218.6171-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the verifier sort the kfunc desc table twice: Once during
kfunc collection by function ID, useful during verification, and
once by immediate address, useful during JIT bytecode lowering
time. The latter sort can be removed by storing in the instruction
the kfunc desc array index the desc is in and using that instead.
Modify the JITs to follow the same convention.

This change simplifies the subsequent patch that adds per-call site
function specialization.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf.h          |  4 +--
 include/linux/bpf_verifier.h |  7 ++--
 kernel/bpf/fixups.c          | 70 +++++-------------------------------
 kernel/bpf/verifier.c        | 25 ++++++++++---
 4 files changed, 33 insertions(+), 73 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 670eb9f3f20a..eed7f8f1e417 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3301,7 +3301,7 @@ const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn);
 int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
-		       u16 btf_fd_idx, u8 **func_addr);
+		       u16 desc_idx, u8 **func_addr);
 
 struct bpf_core_ctx {
 	struct bpf_verifier_log *log;
@@ -3644,7 +3644,7 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 
 static inline int
 bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
-		   u16 btf_fd_idx, u8 **func_addr)
+		   u16 desc_idx, u8 **func_addr)
 {
 	return -ENOTSUPP;
 }
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c775bd757706..5cbae5d05fe7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1784,12 +1784,12 @@ enum bpf_reg_arg_type {
 };
 
 #define MAX_KFUNC_DESCS 256
+static_assert(MAX_KFUNC_DESCS <= S16_MAX + 1);
 
 struct bpf_kfunc_desc {
 	struct btf_func_model func_model;
 	struct bpf_func_proto proto;
 	u32 func_id;
-	s32 imm;
 	u16 offset;
 	unsigned long addr;
 };
@@ -1797,9 +1797,8 @@ struct bpf_kfunc_desc {
 struct bpf_kfunc_desc_tab {
 	u32 nr_descs;
 	/* Sorted by func_id (BTF ID) and offset (fd_array offset) during
-	 * verification. JITs do lookups by bpf_insn, where func_id may not be
-	 * available, therefore at the end of verification do_misc_fixups()
-	 * sorts this by imm and offset.
+	 * verification. JITs use the descriptor index stored in the finalized
+	 * call's off field.
 	 *
 	 * Grown one entry at a time by bpf_add_kfunc_call().
 	 */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 37cf130ebb57..cb7219ff68bd 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -5,8 +5,6 @@
 #include <linux/bpf_verifier.h>
 #include <linux/filter.h>
 #include <linux/vmalloc.h>
-#include <linux/bsearch.h>
-#include <linux/sort.h>
 #include <linux/perf_event.h>
 #include <linux/sched/signal.h>
 #include <net/xdp.h>
@@ -117,73 +115,26 @@ int bpf_insn_def32(struct bpf_prog *prog, struct bpf_insn *insn)
 	return dst_reg;
 }
 
-static int kfunc_desc_cmp_by_imm_off(const void *a, const void *b)
-{
-	const struct bpf_kfunc_desc *d0 = a;
-	const struct bpf_kfunc_desc *d1 = b;
-
-	if (d0->imm != d1->imm)
-		return d0->imm < d1->imm ? -1 : 1;
-	if (d0->offset != d1->offset)
-		return d0->offset < d1->offset ? -1 : 1;
-	return 0;
-}
-
 const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn)
 {
-	const struct bpf_kfunc_desc desc = {
-		.imm = insn->imm,
-		.offset = insn->off,
-	};
 	const struct bpf_kfunc_desc *res;
 	struct bpf_kfunc_desc_tab *tab;
 
 	tab = prog->aux->kfunc_tab;
-	res = bsearch(&desc, tab->descs, tab->nr_descs,
-		      sizeof(tab->descs[0]), kfunc_desc_cmp_by_imm_off);
-
-	return res ? &res->func_model : NULL;
-}
-
-static int set_kfunc_desc_imm(struct bpf_verifier_env *env, struct bpf_kfunc_desc *desc)
-{
-	unsigned long call_imm;
+	if (insn->off < 0 || insn->off >= tab->nr_descs)
+		return NULL;
 
+	res = &tab->descs[insn->off];
 	if (bpf_jit_supports_far_kfunc_call()) {
-		call_imm = desc->func_id;
-	} else {
-		call_imm = BPF_CALL_IMM(desc->addr);
-		/* Check whether the relative offset overflows desc->imm */
-		if ((unsigned long)(s32)call_imm != call_imm) {
-			verbose(env, "address of kernel func_id %u is out of range\n",
-				desc->func_id);
-			return -EINVAL;
-		}
-	}
-	desc->imm = call_imm;
-	return 0;
-}
-
-static int sort_kfunc_descs_by_imm_off(struct bpf_verifier_env *env)
-{
-	struct bpf_kfunc_desc_tab *tab;
-	int i, err;
-
-	tab = env->prog->aux->kfunc_tab;
-	if (!tab)
-		return 0;
-
-	for (i = 0; i < tab->nr_descs; i++) {
-		err = set_kfunc_desc_imm(env, &tab->descs[i]);
-		if (err)
-			return err;
+		if (res->func_id != insn->imm)
+			return NULL;
+	} else if ((s32)BPF_CALL_IMM(res->addr) != insn->imm) {
+		return NULL;
 	}
 
-	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
-	     kfunc_desc_cmp_by_imm_off, NULL);
-	return 0;
+	return &res->func_model;
 }
 
 static int add_kfunc_in_insns(struct bpf_verifier_env *env,
@@ -2720,10 +2671,6 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		}
 	}
 
-	ret = sort_kfunc_descs_by_imm_off(env);
-	if (ret)
-		return ret;
-
 	return 0;
 }
 
@@ -2897,4 +2844,3 @@ int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env)
 
 	return 0;
 }
-
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03dbc0e00398..8183a8f22ed5 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2584,12 +2584,16 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
 }
 
 int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
-		       u16 btf_fd_idx, u8 **func_addr)
+		       u16 desc_idx, u8 **func_addr)
 {
+	struct bpf_kfunc_desc_tab *tab;
 	const struct bpf_kfunc_desc *desc;
 
-	desc = find_kfunc_desc(prog, func_id, btf_fd_idx);
-	if (!desc)
+	tab = prog->aux->kfunc_tab;
+	if (desc_idx >= tab->nr_descs)
+		return -EFAULT;
+	desc = &tab->descs[desc_idx];
+	if (desc->func_id != func_id)
 		return -EFAULT;
 
 	*func_addr = (u8 *)desc->addr;
@@ -22079,6 +22083,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
 	struct bpf_kfunc_desc *desc;
+	unsigned long call_imm;
+	u16 desc_idx;
 	int err;
 
 	if (!insn->imm) {
@@ -22098,13 +22104,22 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     insn->imm);
 		return -EFAULT;
 	}
+	desc_idx = desc - env->prog->aux->kfunc_tab->descs;
 
 	err = specialize_kfunc(env, desc, insn_idx);
 	if (err)
 		return err;
 
-	if (!bpf_jit_supports_far_kfunc_call())
-		insn->imm = BPF_CALL_IMM(desc->addr);
+	if (!bpf_jit_supports_far_kfunc_call()) {
+		call_imm = BPF_CALL_IMM(desc->addr);
+		if ((unsigned long)(s32)call_imm != call_imm) {
+			verbose(env, "address of kernel func_id %u is out of range\n",
+				desc->func_id);
+			return -EINVAL;
+		}
+		insn->imm = call_imm;
+	}
+	insn->off = desc_idx;
 
 	if (is_bpf_obj_new_kfunc(desc->func_id) || is_bpf_percpu_obj_new_kfunc(desc->func_id)) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
-- 
2.52.0

