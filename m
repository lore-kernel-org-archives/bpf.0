Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C35495ADB
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 23:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790379348; cv=none; b=kv/OL4Hs7xQxU+0mkBbdgq48cpAopbU8aejsiT/LW29LgERTPMRlhMw2C1hChycHmdp4nUCJo1zdrgFIFW5hP3sIir7dspFJCzlKBFdNrAPC0m7m88Pf2/nEzjYevYcz/yzoOpgJtiLLWy5GovkYNfZ42cv5X++Ear6ki4s8tpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790379348; c=relaxed/simple;
	bh=4HNOpfkznFTZISq49X1fB5X1I8sIJrIeLi6pHb6m58s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GEvCp+9n/HBtqGYbFTUiQZV/BYQt/T4PDAsy5HIYZbnXHxfBV+VIPW0Cx1qpbLJJ3iiAet+INlSCRGT32gdjVEY2kPTxjf9ERcV8xseLLFdMPqDj4eyzVxavzdJ9tujAZ+8lWwEfn7oUb8K9H/PFJrFTawUGFFcM04rUzL+rkEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=idcN9jpx; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="idcN9jpx"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0c52f9a45so720324a91.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 16:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790379346; x=1790984146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FC5j8pxd8PQhO+NsZOC4n0fpLdHKkrEnehmiqvElPm8=;
        b=idcN9jpxy5zX7cUK/4CL2J2+oLBzcQryErPk7sjZuC3s+s/TyJ6FcBrlhrCpHs5xKk
         Jux3JAs4PFc0U5AakkeQDnw6rWndYO22dPuWKd3hnw2SgsaUZwEX8w1skk92DHTfqzRM
         hLEUoJNSIC1bILj7J2G9FZK1Zi7vKa/XllzVgHU/M20mCavj3cUgMY5eE0ubt+rc/X24
         hu7rqNsjn0luLuTHfH9mVsHKS54sHYKkSEDBM2gmo0dmqix1xwk/dUshdL4XiKM/YgHI
         /AU98HbKfKbOZmMOqZjrHazMDAnEJ/cJLLDsTA5OV2LUVHYHfAkzkL7jyVK11zG/Izuf
         bUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790379346; x=1790984146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FC5j8pxd8PQhO+NsZOC4n0fpLdHKkrEnehmiqvElPm8=;
        b=RWCGi3kvlvJWDHQgS2e1HfrfuRLGHeIA36PgXTF59bbgDvguZh/PRmjRJBt/KpjydV
         /aaM4YUqAk29t402mPwzp4vTKSvwKU61DxfHCdhDwK/qrJnX+0VfyXuDJWoz5Kh5xpv9
         XrNlMTGzmFKGZQqeiSakWOm9OkqSq0jC4fA4Dz+4pm6jOpJDe2BfZ5rHd6I3FpBt8jsj
         NwsSMh+jCd8jrBw3gITIjzxMheBcekIHQRxcIM1yOQCF4OSwXAFs5GYDc945gpjGXTfD
         E6ID4ojV/8acHh1e9P+Pcp6EafwwuU44VZayhJRl6XKXaQKub0YHDhuQEzHlhops+il/
         W+1w==
X-Gm-Message-State: AFuF++m22cEpe8qUJsopWcYX7mYnPx2ATqwyTbnilqjCv3cdjrdcIAv3
	FuZD5Xd9BAZ9bk3fvMyDRxVIqYj8XOJwpTMPEycqE31peDDKimTdYXks/2N/4w2g/FnEdiJHIpv
	xV5Qeg9E=
X-Gm-Gg: AYBFou3qt3D5M7Nz0M+OT4oIJePTkF314wHMaIfhynItpZOmRKpPq+yaAoU81ku2z4g
	GYdS1/XxyD0OKTuxjz4XdL0+kJBLVqLK4KmXwXjiXCAEKXi6qWevNI41T35+D6n7pdMR7UzP4tw
	I8XGLJECD3gZYHKQVam/6UEa+cY7WHfPMB4fYVKHUur+RJR8KVjbiDcQ37CrzGxGyFQRfVzwXGg
	+U3D2IyGbxUQOJTntXKLqdmYF00rnYd6S7GaMwWmeBwkCfwvJqhNuYm7/BMNtZ4uAiqN54DNFOW
	1vawbdX5mT9zFdGzPB2Ahs4EdJoFdDKJhGqzcXxnrfLsNn8xYbW4WPaSMiAz2yJQDqHNDlfVThK
	d02xd93Bt91jA1NLygf0M1T96z5Nm3cWe/6u9l5jbNjAnh7giQThyVgoNMkHrRZ8oGrPq4pUnQ1
	pH/Qvr5WDKyQS4a38YTuP67gTU4QDyRk+r6MhXEYflUoH62VdonNHMJnH/aBlBI/f4KCLQ7xQnN
	EGbc7YntG9BVaSoF38WCTRcHpc7LiK+8YZfcJWn1g==
X-Received: by 2002:a17:90b:1c83:b0:3a0:cde8:1dd6 with SMTP id 98e67ed59e1d1-3a0cde82a7amr1137849a91.6.1790379346180;
        Fri, 25 Sep 2026 16:35:46 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0bec30aaasm5790436a91.15.2026.09.25.16.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 16:35:45 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v4 5/7] bpf: Support call-site kfunc specialization for near calls
Date: Fri, 25 Sep 2026 23:35:36 +0000
Message-ID: <20260925233538.5708-6-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925233538.5708-1-emil@etsalapatis.com>
References: <20260925233538.5708-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

specialize_kfunc() currently updates the canonical kfunc descriptor
in place. It is not currently possible to swtich different
specializations of a kfunc per call site in the same program.
In fact, specializations are order-dependent: Once a function is
specialized, all subsequent call sites are specialized even if they
wouldn't trigger specialization themselves. This is especially an
issue for bpf_arena_alloc_pages() that is specialized into its
non-sleepable for all call sites after a single non-sleepable one.

Allow per-call site kfunc specialization for JITs that use near calls.
Implement this by keeping two versions of the kfunc table, one with just
the initial kfuncs and one with all valid specializations for the
program. We currently assume 2 concurrent specializations for each
kfunc. This is a conservative estimate, since most of them do not
specialize at all.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_verifier.h | 13 ++++---
 kernel/bpf/verifier.c        | 67 +++++++++++++++++++++++++++++++++---
 2 files changed, 71 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 92f528c45605..e36936936418 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1714,6 +1714,8 @@ enum bpf_reg_arg_type {
 };
 
 #define MAX_KFUNC_DESCS 256
+/* Each kfunc can have its canonical and one specialized call target. */
+#define MAX_KFUNC_CALL_DESCS (MAX_KFUNC_DESCS * 2)
 
 struct bpf_kfunc_desc {
 	struct btf_func_model func_model;
@@ -1726,12 +1728,15 @@ struct bpf_kfunc_desc {
 
 struct bpf_kfunc_desc_tab {
 	u32 nr_descs;
+	u32 nr_base_descs;
 	/* Sorted by func_id (BTF ID) and offset (fd_array offset) during
-	 * verification. JITs do lookups by bpf_insn, where func_id may not be
-	 * available, therefore at the end of verification do_misc_fixups()
-	 * sorts this by imm and offset.
+	 * verification. The first nr_base_descs entries are the canonical
+	 * descriptors used for verifier lookups. Call specialization may append
+	 * immutable descriptors for additional targets. Near-call JITs look up
+	 * descriptors by imm and offset after do_misc_fixups() sorts the table.
 	 *
-	 * Grown one entry at a time by bpf_add_kfunc_call().
+	 * Grown one entry at a time by bpf_add_kfunc_call() and during
+	 * call specialization.
 	 */
 	struct bpf_kfunc_desc descs[];
 };
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a7c9e2d8965d..5e7c589991e9 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2570,7 +2570,7 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
 	struct bpf_kfunc_desc_tab *tab;
 
 	tab = prog->aux->kfunc_tab;
-	return bsearch(&desc, tab->descs, tab->nr_descs,
+	return bsearch(&desc, tab->descs, tab->nr_base_descs,
 		       sizeof(tab->descs[0]), kfunc_desc_cmp_by_id_off);
 }
 
@@ -2920,10 +2920,12 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	if (find_kfunc_desc(env->prog, func_id, offset))
 		return 0;
 
-	if (tab->nr_descs == MAX_KFUNC_DESCS) {
+	if (tab->nr_base_descs == MAX_KFUNC_DESCS) {
 		verbose(env, "too many different kernel function calls\n");
 		return -E2BIG;
 	}
+	if (WARN_ON_ONCE(tab->nr_descs != tab->nr_base_descs))
+		return -EFAULT;
 
 	err = fetch_kfunc_meta(env, func_id, offset, &kfunc);
 	if (err)
@@ -2981,7 +2983,8 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, u32 func_id, u16 offset)
 	desc->addr = addr;
 	desc->func_model = func_model;
 	tab->nr_descs++;
-	sort(tab->descs, tab->nr_descs, sizeof(tab->descs[0]),
+	tab->nr_base_descs++;
+	sort(tab->descs, tab->nr_base_descs, sizeof(tab->descs[0]),
 	     kfunc_desc_cmp_by_id_off, NULL);
 	return 0;
 }
@@ -21299,6 +21302,40 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 	return 0;
 }
 
+static int add_kfunc_desc_target(struct bpf_verifier_env *env,
+				 const struct bpf_kfunc_desc *target_desc)
+{
+	struct bpf_kfunc_desc desc = *target_desc;
+	struct bpf_kfunc_desc_tab *new_tab;
+	struct bpf_kfunc_desc_tab *tab;
+	struct bpf_prog_aux *prog_aux;
+	u32 i;
+
+	prog_aux = env->prog->aux;
+	tab = prog_aux->kfunc_tab;
+	for (i = 0; i < tab->nr_descs; i++) {
+		if (tab->descs[i].func_id == desc.func_id &&
+		    tab->descs[i].offset == desc.offset &&
+		    tab->descs[i].addr == desc.addr)
+			return 0;
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
+	tab->descs[tab->nr_descs++] = desc;
+	return 0;
+}
+
 static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 					    u16 struct_meta_reg,
 					    u16 node_offset_reg,
@@ -21319,7 +21356,10 @@ static void __fixup_collection_insert_kfunc(struct bpf_insn_aux_data *insn_aux,
 int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
 {
+	struct bpf_kfunc_desc desc_copy;
 	struct bpf_kfunc_desc *desc;
+	unsigned long call_imm;
+	bool near_call;
 	int err;
 
 	if (!insn->imm) {
@@ -21340,12 +21380,29 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		return -EFAULT;
 	}
 
+	near_call = !bpf_jit_supports_far_kfunc_call();
+	if (near_call) {
+		desc_copy = *desc;
+		desc = &desc_copy;
+	}
+
 	err = specialize_kfunc(env, desc, insn_idx);
 	if (err)
 		return err;
 
-	if (!bpf_jit_supports_far_kfunc_call())
-		insn->imm = BPF_CALL_IMM(desc->addr);
+	if (near_call) {
+		call_imm = BPF_CALL_IMM(desc->addr);
+		if ((unsigned long)(s32)call_imm != call_imm) {
+			verbose(env, "address of kernel func_id %u is out of range\n",
+				desc->func_id);
+			return -EINVAL;
+		}
+		insn->imm = call_imm;
+
+		err = add_kfunc_desc_target(env, desc);
+		if (err)
+			return err;
+	}
 
 	if (is_bpf_obj_new_kfunc(desc->func_id) || is_bpf_percpu_obj_new_kfunc(desc->func_id)) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
-- 
2.52.0

