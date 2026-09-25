Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450934477E7
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368793; cv=none; b=Vfa2Z6rENZfjbm/hY40H4lddyc3TE9iDm/5rs5lcRSqUHcmgelAxN3KrZqoBHhUH688wGqt8mPi0DHcP8rMg8aFAZnG0DxcSC8PeJESu1wxhmr2QjqEdIqNm5+2Y56e/hbJjXLJlJgKWtq0tv5OtddsPgb2coLIzHuVGxGDQx5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368793; c=relaxed/simple;
	bh=KdECoup6vYbef2XN56JKbp4nlL2IvLIVaNIYkco4QFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbqeyRhfAmPdSS096kH5547ZkvIO29zLQh4U6JVTyCI45WlXT7JkMwPlKNuzPkWMPS5mqI9OASuC30sp+d8otLk4GXpNNymauqXAucUApfiPGbQz1Vtg7l+pJzPRY50vouymTnDx9kkUSKjsMSd2zsH2+re1OWToUixUYkU7Jqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=awCsvZVT; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="awCsvZVT"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd66bb4so636861a91.1
        for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 13:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790368790; x=1790973590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J6ph3MbFe9q/THpaCmYJQ6SJsHKh26f66//49xd33SE=;
        b=awCsvZVTd1k6u8G8WW0vkkWN/58PMu/o19MZsMg++9DvKRT9h8uYY1k91Pvu5FXVK0
         I+9ID5QH3jKYw6WstZ5TK+N9i1jZydtRvHktCPDoch5qmECu8Uc/e8XdvlcTa2j08D5K
         1t2tERhuLG9p6N6mRod/f7aUfhxz3E1fFTQv+BX2syu63KryaeDVAIkbZIdlfuJ3i2fZ
         mMdJe1OIjh5ZDOEuu/BCMaTGejM/gxTuZ8Tm6X1OOwn8sMIet++McdUgjzB98/UrpLzN
         0fv9K4exUjqMNHcTlTg+ykqTB+Jcl+MHzCUjXDtNRBNqEhSyK0EpPYgKt3PW83d3OfQm
         u7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790368790; x=1790973590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=J6ph3MbFe9q/THpaCmYJQ6SJsHKh26f66//49xd33SE=;
        b=tBxT4yVBuVuSjRMzqLaJ8ZeMBwgIpxBHSCbzW4RpJx+UjbH+J7KbVfbm/YEvufxpOG
         ED5zndEpLV8dD5rjTll0x3vdeTtFAnaoUPHc/qw9H/4Jle3fuTLNeceZ0E0Qf1SXxrWu
         l8KrF7r+mmkcXOjv4icAZ9Tf9cG1nmruDPovuTXsVLOioQJAH7NqYZg1Vrs6F1JjWiNV
         M4aOCvtqdnmbPPeAUl85G5vfIIcgjh4Ag9z50WZ/yUncz3TcfwhlCOLHownOFRktSUiQ
         Hw9so9EtQD/+O886w+mew0ITBZqH1ZyezXGULUw74BTmWENn/CZOVWL3R7X8VfDWJD8j
         3yDQ==
X-Gm-Message-State: AFuF++nJ74ZxIlFZCxfTNv9bFWq5w+w1QOjTWivyXRkTMbP2HZAollmu
	X4OYhbzWlJZ2iXzgnOikrUesse6RDfqtA+xUiUv8xsrXsdPqS4IMJA3ZCGXLSDHRiop4/muwJd4
	3eSRtXE4=
X-Gm-Gg: AYBFou0K1B43W9XyqOJw89GJJuIBD9ekrl9FnGPRYXsvCrZEp5WWoR1Td94QWpu5G0/
	CNvN6H5KIHNZ9YrbjiBu8gIVHzrxbTBiLTAcNWw22F3KlNQYIsLT0oJ7VWWTIw1fsQBX5XrXvsn
	18qdhal6m08eT9xZkkFn+BBR7HKU+gWE9weKPS7rFcaOvsquWmfT0dGHGw8gvZgO3r/tJhPMGUt
	zwYd/nivjCy7AvxfwI9tqRAt3eb76WYxohonnP1WQa/807+axS8u9lQMxXcl5w5pq87mB8i3H4y
	0bDggWrYEPUtaGtpMw2zCwwZfvZjIoXfl9L4dXzEEm/OP9a+vRS2llugh3uDFKet6JKBrnDyiL2
	tBhiRRQ+zDyCyQRS4mD2GSN6ho/aHEEXIEScat6/gAvvALZHeZC/cipqtkP/RhW8/6jZ4Wa3iiG
	34PvfqfvduhcOsll0PezTuIeYXIhebogMxAFX/tubiv/39vaSST0HbIqvVaHnB6irfmI2MjRQh9
	mQF2emP3U8wYenK5hygcfv9LrqtscqrdsXxE+S6Xg==
X-Received: by 2002:a17:90b:55c3:b0:39e:3559:12df with SMTP id 98e67ed59e1d1-3a098b98d43mr6030677a91.1.1790368790393;
        Fri, 25 Sep 2026 13:39:50 -0700 (PDT)
Received: from alpine05.ht.home (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9481e17sm5955125a91.8.2026.09.25.13.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:39:49 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf v3 6/7] bpf: Support call-site kfunc specialization for far calls
Date: Fri, 25 Sep 2026 20:39:38 +0000
Message-ID: <20260925203939.4105-7-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925203939.4105-1-emil@etsalapatis.com>
References: <20260925203939.4105-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Far-call JITs keep the kfunc BTF ID in the call immediate,
so it cannot distinguish multiple specialized targets for
the same kfunc and BTF object.

Store the finalized target descriptor index in the call offset.
Use that index for address and function-model lookup, and keep
the descriptor table in verification order so the indices remain
stable.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf.h          |  4 ++--
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/fixups.c          | 18 ++++++++++++++----
 kernel/bpf/verifier.c        | 35 ++++++++++++++++++++++-------------
 4 files changed, 40 insertions(+), 19 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 7df74e47ecb0..5a9580b1769d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3283,7 +3283,7 @@ const struct btf_func_model *
 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 			 const struct bpf_insn *insn);
 int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
-		       u16 btf_fd_idx, u8 **func_addr);
+		       u16 desc_idx, u8 **func_addr);
 
 struct bpf_core_ctx {
 	struct bpf_verifier_log *log;
@@ -3626,7 +3626,7 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 
 static inline int
 bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
-		   u16 btf_fd_idx, u8 **func_addr)
+		   u16 desc_idx, u8 **func_addr)
 {
 	return -ENOTSUPP;
 }
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e36936936418..da219eb0a9cb 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1734,6 +1734,8 @@ struct bpf_kfunc_desc_tab {
 	 * descriptors used for verifier lookups. Call specialization may append
 	 * immutable descriptors for additional targets. Near-call JITs look up
 	 * descriptors by imm and offset after do_misc_fixups() sorts the table.
+	 * Far-call JITs use the descriptor index stored in the finalized call's
+	 * off field, so their table remains in verification order.
 	 *
 	 * Grown one entry at a time by bpf_add_kfunc_call() and during
 	 * call specialization.
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 2add8001c3ec..b9f76eee5016 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -140,6 +140,13 @@ bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
 	struct bpf_kfunc_desc_tab *tab;
 
 	tab = prog->aux->kfunc_tab;
+	if (bpf_jit_supports_far_kfunc_call()) {
+		if (insn->off < 0 || insn->off >= tab->nr_descs)
+			return NULL;
+		res = &tab->descs[insn->off];
+		return res->func_id == insn->imm ? &res->func_model : NULL;
+	}
+
 	res = bsearch(&desc, tab->descs, tab->nr_descs,
 		      sizeof(tab->descs[0]), kfunc_desc_cmp_by_imm_off);
 
@@ -2517,11 +2524,14 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 		}
 	}
 
-	ret = sort_kfunc_descs_by_imm_off(env);
-	if (ret)
-		return ret;
+	/*
+	 * Do not change kfunc desc position into the table for far JIT.
+	 * because we use the indices in the instructions.
+	 */
+	if (bpf_jit_supports_far_kfunc_call())
+		return 0;
 
-	return 0;
+	return sort_kfunc_descs_by_imm_off(env);
 }
 
 static struct bpf_prog *inline_bpf_loop(struct bpf_verifier_env *env,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5e7c589991e9..12e33a568a3e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2575,12 +2575,16 @@ find_kfunc_desc(const struct bpf_prog *prog, u32 func_id, u16 offset)
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
@@ -21303,7 +21307,8 @@ static int specialize_kfunc(struct bpf_verifier_env *env, struct bpf_kfunc_desc
 }
 
 static int add_kfunc_desc_target(struct bpf_verifier_env *env,
-				 const struct bpf_kfunc_desc *target_desc)
+				 const struct bpf_kfunc_desc *target_desc,
+				 u16 *desc_idx)
 {
 	struct bpf_kfunc_desc desc = *target_desc;
 	struct bpf_kfunc_desc_tab *new_tab;
@@ -21316,8 +21321,10 @@ static int add_kfunc_desc_target(struct bpf_verifier_env *env,
 	for (i = 0; i < tab->nr_descs; i++) {
 		if (tab->descs[i].func_id == desc.func_id &&
 		    tab->descs[i].offset == desc.offset &&
-		    tab->descs[i].addr == desc.addr)
+		    tab->descs[i].addr == desc.addr) {
+			*desc_idx = i;
 			return 0;
+		}
 	}
 
 	if (tab->nr_descs == MAX_KFUNC_CALL_DESCS) {
@@ -21332,6 +21339,7 @@ static int add_kfunc_desc_target(struct bpf_verifier_env *env,
 	tab = new_tab;
 	prog_aux->kfunc_tab = tab;
 
+	*desc_idx = tab->nr_descs;
 	tab->descs[tab->nr_descs++] = desc;
 	return 0;
 }
@@ -21359,6 +21367,7 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	struct bpf_kfunc_desc desc_copy;
 	struct bpf_kfunc_desc *desc;
 	unsigned long call_imm;
+	u16 desc_idx;
 	bool near_call;
 	int err;
 
@@ -21381,10 +21390,8 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 	}
 
 	near_call = !bpf_jit_supports_far_kfunc_call();
-	if (near_call) {
-		desc_copy = *desc;
-		desc = &desc_copy;
-	}
+	desc_copy = *desc;
+	desc = &desc_copy;
 
 	err = specialize_kfunc(env, desc, insn_idx);
 	if (err)
@@ -21398,12 +21405,14 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			return -EINVAL;
 		}
 		insn->imm = call_imm;
-
-		err = add_kfunc_desc_target(env, desc);
-		if (err)
-			return err;
 	}
 
+	err = add_kfunc_desc_target(env, desc, &desc_idx);
+	if (err)
+		return err;
+	if (!near_call)
+		insn->off = desc_idx;
+
 	if (is_bpf_obj_new_kfunc(desc->func_id) || is_bpf_percpu_obj_new_kfunc(desc->func_id)) {
 		struct btf_struct_meta *kptr_struct_meta = env->insn_aux_data[insn_idx].kptr_struct_meta;
 		struct bpf_insn addr[2] = { BPF_LD_IMM64(BPF_REG_2, (long)kptr_struct_meta) };
-- 
2.52.0

