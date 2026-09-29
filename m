Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972335519AE
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707177; cv=none; b=j7NpRknfXi6dhqPjR5PvzsQK1BLuKo2MDlwsZTx6CBMuXZlCn5vE2fwwt64KQO20ZA287LTO9hThy16yfvYXws1aw/3iVD6jmedr9EF8iCrfZshhk6RCH/qbADerZk3LlZO3AStmOvCMqTP8YQTOzk4Qw3QxAeCsaQRFcc/Sh7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707177; c=relaxed/simple;
	bh=tfoJGY7pKZXuqdWp75+K+QOwKR0XLQkEk8HIejgmIQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSJF4+FWmDnJphhhihzzHarJkINLQ0gbMmsmmsFxMMPMeMCsafVOUUBMlFr+MTDjDbQVoczuArvpMX/39m3bD0vRb+/um+Zbdusml+IpcMimPiUiDPbNDsCcnUVLI/4fddNX92wiUa5eaDDTYkCuy/J6oZx5Leo6voMUBwYBNwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=kuLdZ9cl; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="kuLdZ9cl"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a49573b8bdso1044749a91.2
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790707175; x=1791311975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D+naoGPp3j7LFCqxBys58/sTU3xJi22TPpniORv4l4A=;
        b=kuLdZ9clo3aOJIhr3jqt7t1H3gJTNY/9qH1xHhPj8LejDTjdsMbMW7Wne0Isdq5SBM
         Auuf0uOhuDcswSQZJ71divNF0oYG9DYwcC1ya0NAtl5vJcC/zWzAeHl2Y4f/+XNMY0Ge
         gS5Hg0ClUI+bW3AOB8rprE0RPf9gGoVYb/VvrkAjMOX4IZ0F6W9EXFrPI893pONMeyxk
         ttAtI6+tw9Yqw2l+HiOX5jDciIZjDgSaQNKy1dLOAqWAIV5XdSgUlnIp8mWPhIqVahzJ
         Stb99bjVpfZsYblO/UNicqIe3UceU5CX0C/CndRimYKPgdXdwEX8ikR8cXoPz7IBDbzd
         3uTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790707175; x=1791311975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D+naoGPp3j7LFCqxBys58/sTU3xJi22TPpniORv4l4A=;
        b=DnbDgzH3N4zDYIfwdPXXgpw55Fwl/kGgcA0MdC3uC1ejr2Kp6yrOU1ITLiWYYaBvyZ
         vVKYW296fNvfz4v/XTgmvvaCoJSDFxZtFDzW8pzwXq59ftR8ZIvBVcpYZ9Mbe0mn8fcp
         FcMBWe0fDAXLomy77fPFQi73mlcjNJKYjM7LTd9V/ubnm9YNAXmj20Fhu/RT2lWDfyoh
         4znkFZOq7GXtt4+mNDykxO5X2YVHwQPg9qnuz5HLUX09H7l+L6hDfBQiI0jiJDPRLIv0
         4Ftt6cEpMCs3UYa8ZT0eSwApLu/JuD7GXhRT361OOkhZurE//TRq0fMMmbDbqYOP5wRH
         IcUw==
X-Gm-Message-State: AFq9FYI5jyXH2IO/nXTu2yc/0kThljtA7WmH5pwOWheUsrvLTVXeUU5J
	QXiP5x6QJlgSAcDPNWLpA0s9QIUSE8LT3bdrNhKEr1bJ7/UJSqOx2JG/u+INJewtS8PmZPC3QHl
	xVc+4DD8=
X-Gm-Gg: AYBFou2nh+l9jUB00a9fP2vEfQaSnYSctmQyI49CImR+XKajIUh3ApJSxGr/AG7upbF
	MyK5Mlr0M8LrQGCnRAGfUyTZexjK2+4f7urXXqW7Cz0xuC2o/bI19MeiJSuHFJ/b1tsXdrTEvah
	rPVZzJp68fctxiLIDAWhD1eJEbASGSxJH4dh91Hzl8FNPiOmbjuJb7Fsscnyu37UkVsbraiqZSo
	XvxJiCcYkIRgXh5/AoawmdZmzNMOOd84B7HQzO5eMtGfpIoQWLqykcYsHpm1clOYdk458Vu10uF
	rVaC6Nr9p/VqMd7VA69/nsrklgYfKTN3GZBvw4mAMPwLpg9UUduvUkVs5MH7Vc1v1J/jKr/8Dwa
	3/16y0uchnz0F/XOxu/5C0zeWtHt8idxlOw7CL7EmRjCrXAukGlGLFZuBATH8RSsprrMhhHA6RE
	kbnalu0+ruxexAodjcw/yuNDDED1KERkrkDySpQ425+yI4E7tcAak8yZcZZzkHLyP1ee8j9FMWJ
	MuxOFCHMrZnqqj7hYFWNq/c1h/KnxqR6kVKxF1dGw==
X-Received: by 2002:a17:90b:538b:b0:3a0:345a:3646 with SMTP id 98e67ed59e1d1-3a4bfe98dcamr206144a91.45.1790707174697;
        Tue, 29 Sep 2026 11:39:34 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49858bf27sm6796494a91.4.2026.09.29.11.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 11:39:34 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v6 5/7] bpf: Directly store kfunc desc index in instruction off field
Date: Tue, 29 Sep 2026 18:39:26 +0000
Message-ID: <20260929183928.4896-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260929183928.4896-1-emil@etsalapatis.com>
References: <20260929183928.4896-1-emil@etsalapatis.com>
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

