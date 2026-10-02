Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4450547DD6E
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 10:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790938351; cv=none; b=g48Z20QdjbTsQZ0fv86MS4XHrcaw31Twvj+Na81Z08PhtokhmCyfk3DOt/RVfmfp04WW6ahH7N8EhDwezGsVwf1lAcTmTp+5ZHdVCc1R5Tl85vc28NTUdtFhZ7B+fsn/UojjoQsQeoQ42s8Q890T7aj8Dz8bVtzVv8gnRcgegXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790938351; c=relaxed/simple;
	bh=ayEN9Uo2k0UrsTs7qmpXkmOmo/+HTt8mVhCHMsLiKpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtzzVsErWi7jW/CHVDY7xqUe7Hs546X5AXmQeARqhXaCGrX5QT/WpInkMCz67CQLLSB933PWGinMtAdIFejvLP3aNvoc8ihM85qbk+s6ajTPFk80JngAqECaKQpJMyE/5n87Drjnwp1x5zeppKAa71zVGceM6sthP1NBpKpFrPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=y5EZ/jTv; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="y5EZ/jTv"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffe281cb1so40226355e9.1
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790938347; x=1791543147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SA+FsOjvHo8j82ATuHLyAGEkH4Bz3b0TSFaSYkpkQBA=;
        b=y5EZ/jTvDHGGBWUrwjZAQzZ2BlvGCEGBe9zpcKpJi1ZQJyFc14MpVriH4p0YS/QWLh
         DXuv2FceZ4E+wBdbNk+9tPtgPEoJGcOf0wWCt+5K6E2XoJRec1BMN6YdUyZEPgXeCt6b
         uuTbAfF4ptCsgGiPwNAKW9VlRc7BGua/mBtM3+kVtdlXh6mvgGwXoMPCxywq6QUImdMR
         oBTTZWLSZEk3cAXH0epZ/5C0jGFvGp588LYa3L2HvUEkEdNJb+8oPQDMupQq/q7dGbVj
         rVhhnl5x66ZLRIhd8VdyPvSX6Ri2L69gSbRFEMo+p2myebgfEOKFTXY0zvOO9+jQpM5N
         le0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790938347; x=1791543147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SA+FsOjvHo8j82ATuHLyAGEkH4Bz3b0TSFaSYkpkQBA=;
        b=FHYWpEUp+e0W7rR6v35W7mRR88BF8o0o1jl3pB9m1ZPWAC93W5AqlRfAKyq9dhIVU2
         JNM9QZsLXhF909f5FVsaofG4V/1ThF4AK9gWf3/M8+BrydjJ+d57kxaHy3BUZDRe7N1D
         1SXAUlVhZUHm7ihqzi8gxUgDsG3OsPLlk89Rmovv/ExqfK7omecBmzDrVwVG6FD8g5Pt
         sDur8nSavGoG4ItbmwkDKmjP0s0HAiaBaOHzYMjuYsSXIi6UGgOd5BTEiVdiI84mFEzg
         jsEb8fJPz9+vW2GVWEDr8h8dTXiS3jmSm14o9IhkzgiLmpvOx67C+JB4qItLtcvHIQ2T
         wadQ==
X-Gm-Message-State: AFuF++lCT+u4yLOR5tBKRUsCHTwyLp/+URYvSpkXECKSyNqFTwECyUBT
	5CwDGh2ei6/8FblWnlZe9dLyfuZRyaJpv6WaNJSttV02lkz/MEwmaMTtnkVnI3Ef2Cs6VOCOE0U
	hvA7iH1o=
X-Gm-Gg: AYBFou3AWXF+JlsUW6nAsYQmP/nJhYJ5NriTQ2cX10q1YwDYbB2NA5E/0iGh20lCrlL
	trwYS8RSIszG/YlShTh9VNK4thisVb1wTy5QB7CbgMHOfNxkDwjnCl7rqSEmB7O7QK/Z3/3RqEM
	UU+bN+/LKqeDTs4OL3jY4EWwW7GJmX1hiZxmo9A5FuYbtu5lAXNfaqtusPnmnsUyu/zxYnyHhwL
	U2dp6ocJBpvB7wjfHeZoPWJB5wPN4UvK8tIngbzMPGJ1Xg/sUvb5aznNA6mWZ5ITZvSrK7rp+is
	s5rZzHnnUeD4ZM6cWhlDU6hoCDVTGcONCssh1mRfcUIIJynns2zz3MEkLfNJr8o2DEl94bb+dia
	pafErPGtrjMSCT+Ekk13dKfs7F03cbpcXZMXSi2NrjQM0esOrut9bMcMNchrVA6M9PX5RU23Qde
	DjBDyVyLv8XJnq2g9RfXAQKGdf/zDWs0u6Tu6ur/1MsiiWLj4GjrWNs9X0JA==
X-Received: by 2002:a05:600c:c162:b0:4a0:1b77:db0 with SMTP id 5b1f17b1804b1-4a0276b86b5mr44963595e9.35.1790938347346;
        Fri, 02 Oct 2026 03:52:27 -0700 (PDT)
Received: from alpine05.lan ([2620:10d:c092:600::1:5543])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027da120bsm77866625e9.0.2026.10.02.03.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 03:52:26 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [RESEND PATCH bpf-next v6 6/7] bpf: Support per-call-site kfunc specialization
Date: Fri,  2 Oct 2026 10:52:17 +0000
Message-ID: <20261002105218.6171-7-emil@etsalapatis.com>
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

specialize_kfunc() currently updates the canonical kfunc descriptor in
place. Different call sites therefore cannot select different
specializations of the same kfunc, and the selected target depends on
verification order.

Keep canonical descriptors unchanged for verifier lookups. Specialize a
copy for each call site, then reuse or append an immutable target
descriptor and store its index in the finalized call instruction.

Allow space for one canonical and one specialized target per kfunc. This
is conservative because most kfuncs do not specialize. Adding specialized
kfunc versions does not require resorting the array because lookups are
only used for deduplication and func_model lookup. Deduplication for
specialized kfuncs is handled by the specialization process itself,
while all specializations of a function share the same proto and
func_model.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_verifier.h | 12 +++--
 kernel/bpf/verifier.c        | 88 +++++++++++++++++++++++++++++++++---
 2 files changed, 91 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 5cbae5d05fe7..7bdbda7764c7 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1784,7 +1784,9 @@ enum bpf_reg_arg_type {
 };
 
 #define MAX_KFUNC_DESCS 256
-static_assert(MAX_KFUNC_DESCS <= S16_MAX + 1);
+/* Each kfunc can have its canonical and one specialized call target. */
+#define MAX_KFUNC_CALL_DESCS (MAX_KFUNC_DESCS * 2)
+static_assert(MAX_KFUNC_CALL_DESCS <= S16_MAX + 1);
 
 struct bpf_kfunc_desc {
 	struct btf_func_model func_model;
@@ -1796,11 +1798,15 @@ struct bpf_kfunc_desc {
 
 struct bpf_kfunc_desc_tab {
 	u32 nr_descs;
+	u32 nr_base_descs;
 	/* Sorted by func_id (BTF ID) and offset (fd_array offset) during
 	 * verification. JITs use the descriptor index stored in the finalized
-	 * call's off field.
+	 * call's off field. The first nr_base_descs entries are the canonical
+	 * descriptors used for verifier lookups. Call specialization may append
+	 * immutable descriptors for additional targets.
 	 *
-	 * Grown one entry at a time by bpf_add_kfunc_call().
+	 * Grown one entry at a time by bpf_add_kfunc_call() and during
+	 * call specialization.
 	 */
 	struct bpf_kfunc_desc descs[];
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8183a8f22ed5..3bddfff416ca 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2579,7 +2579,7 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
 	struct bpf_kfunc_desc_tab *tab;
 
 	tab = prog->aux->kfunc_tab;
-	return bsearch(&desc, tab->descs, tab->nr_descs,
+	return bsearch(&desc, tab->descs, tab->nr_base_descs,
 		       sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
 }
 
@@ -2933,10 +2933,15 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	if (find_kfunc_desc(env->prog, func_id, offset))
 		return 0;
 
-	if (tab->nr_descs == MAX_KFUNC_DESCS) {
+	if (tab->nr_base_descs == MAX_KFUNC_DESCS) {
 		verbose(env, "too many different kernel function calls\n");
 		return -E2BIG;
 	}
+	if (tab->nr_descs != tab->nr_base_descs) {
+		verifier_bug(env, "unexpected specialized func desc found (%d descs, %d base descs)",
+			     tab->nr_descs, tab->nr_base_descs);
+		return -EFAULT;
+	}
 
 	err = fetch_kfunc_meta(env, func_id, offset, &kfunc);
 	if (err)
@@ -2994,7 +2999,8 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	desc->addr = addr;
 	desc->func_model = func_model;
 	tab->nr_descs++;
-	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
+	tab->nr_base_descs++;
+	sort(tab->descs, tab->nr_base_descs, sizeof(tab->descs[0]),
 	     kfunc_desc_cmp_by_id_off, NULL);
 	return 0;
 }
@@ -22062,6 +22068,66 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	return 0;
 }
 
+static int add_kfunc_desc_target(struct bpf_verifier_env *env,
+				 const struct bpf_kfunc_desc *target_desc,
+				 u16 base_desc_idx, u16 *desc_idx)
+{
+	struct bpf_kfunc_desc desc = *target_desc;
+	struct bpf_kfunc_desc_tab *new_tab;
+	struct bpf_kfunc_desc_tab *tab;
+	struct bpf_prog_aux *prog_aux;
+	u32 i;
+
+	prog_aux = env->prog->aux;
+	tab = prog_aux->kfunc_tab;
+
+	if (base_desc_idx >= tab->nr_base_descs) {
+		verifier_bug(env, "kfunc desc_idx %d out of bounds (%d descriptors)",
+				base_desc_idx, tab->nr_base_descs);
+		return -EFAULT;
+	}
+	if (tab->descs[base_desc_idx].func_id != desc.func_id) {
+		verifier_bug(env, "kfunc desc %d has invalid id (expected %d, got %d)",
+				base_desc_idx, tab->descs[base_desc_idx].func_id, desc.func_id);
+		return -EFAULT;
+	}
+	if (tab->descs[base_desc_idx].offset != desc.offset) {
+		verifier_bug(env, "kfunc desc %d has invalid offset (expected %d, got %d)",
+				base_desc_idx, tab->descs[base_desc_idx].offset, desc.offset);
+		return -EFAULT;
+	}
+
+	if (tab->descs[base_desc_idx].addr == desc.addr) {
+		*desc_idx = base_desc_idx;
+		return 0;
+	}
+
+	for (i = tab->nr_base_descs; i < tab->nr_descs; i++) {
+		if (tab->descs[i].func_id == desc.func_id &&
+		    tab->descs[i].offset == desc.offset &&
+		    tab->descs[i].addr == desc.addr) {
+			*desc_idx = i;
+			return 0;
+		}
+	}
+
+	if (tab->nr_descs == MAX_KFUNC_CALL_DESCS) {
+		verbose(env, "too many different kernel function call targets\n");
+		return -E2BIG;
+	}
+
+	new_tab = krealloc(tab, struct_size(tab, descs, tab->nr_descs + 1),
+			   GFP_KERNEL_ACCOUNT);
+	if (!new_tab)
+		return -ENOMEM;
+	tab = new_tab;
+	prog_aux->kfunc_tab = tab;
+
+	*desc_idx = tab->nr_descs;
+	tab->descs[tab->nr_descs++] = desc;
+	return 0;
+}
+
 static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 					    u16 struct_meta_reg,
 					    u16 node_offset_reg,
@@ -22082,9 +22148,11 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
+	struct bpf_kfunc_desc desc_copy;
 	struct bpf_kfunc_desc *desc;
 	unsigned long call_imm;
-	u16 desc_idx;
+	u16 base_desc_idx, desc_idx;
+	bool near_call;
 	int err;
 
 	if (!insn->imm) {
@@ -22104,13 +22172,17 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			     insn->imm);
 		return -EFAULT;
 	}
-	desc_idx = desc - env->prog->aux->kfunc_tab->descs;
+	base_desc_idx = desc - env->prog->aux->kfunc_tab->descs;
+
+	near_call = !bpf_jit_supports_far_kfunc_call();
+	desc_copy = *desc;
+	desc = &desc_copy;
 
 	err = specialize_kfunc(env, desc, insn_idx);
 	if (err)
 		return err;
 
-	if (!bpf_jit_supports_far_kfunc_call()) {
+	if (near_call) {
 		call_imm = BPF_CALL_IMM(desc->addr);
 		if ((unsigned long)(s32)call_imm != call_imm) {
 			verbose(env, "address of kernel func_id %u is out of range\n",
@@ -22119,6 +22191,10 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 		insn->imm = call_imm;
 	}
+
+	err = add_kfunc_desc_target(env, desc, base_desc_idx, &desc_idx);
+	if (err)
+		return err;
 	insn->off = desc_idx;
 
 	if (is_bpf_obj_new_kfunc(desc->func_id) || is_bpf_percpu_obj_new_kfunc(desc->func_id)) {
-- 
2.52.0

