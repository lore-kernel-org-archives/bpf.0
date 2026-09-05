Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E05374730
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 22:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788645686; cv=none; b=hieb3PhgTm+8TXH8CoalKY9Sv5owd8CmLEvmja+38sqAOVuaLlRSpDVj3gGR+YYOtLRmAk+Yo5eHoyagzkNwHNAajrpNz8BRmha7mMBP2zm/BJlTb6Uw79+f2cCGl3ZSDz+MdVpa7apuCMOMYjM8Yv0ZdkhCr45gejEkbNV0qg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788645686; c=relaxed/simple;
	bh=x1eXwG1SpAYuGjvv2BHwDXaMDyzKv3IOWYEmAq7Zd4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s62o69lWjMdOk+EZHkK6p+BPCR5GojphTB4ZJrE2g7a3miJMwlOxY38xZwMNa/13Gpele3VFLtIUNpHjh0SCjRqN+d5iLECYGJRNkj7EHbP/uZ6Ag66vAEUvrMoZMWwXoo1lu229ss1jiO+x5eYGznjkkHMGMt8LqVGRGHDuKSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMnTF2qD; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMnTF2qD"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f4f3683fbcso2612058a34.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 15:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788645684; x=1789250484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UVqElZ4qtjCwioHxsmTjTY05QXyaIum43yfNEIN1HhQ=;
        b=LMnTF2qD43dvRW7ZTtq2rCo/JMJG818VcIGPkpB0g7vZ4SR0NUMkmaOb+3/1Z94+Wj
         kDe+zn2M0e8hg+AOKhFbMMOa5gg6Xn3hBLPIPQLiuQUN5lze9zSIw1LgKbMWcb5oiSi7
         yqPX5gzTLTdPcnF7xepHHtf+zyEBt6ZTCYs7GeAdDzzl2TVkKcUT4+wsnB2a1R+Dd8+b
         o+EtufgkhUckLUR37q/B07/ibK9xuHtQe/T2Gr4YG6R6SgHaBDr8WKx0pd+wZ+QvOZSm
         kNnJZwaacRx9YVT7wNQS2W0LKd222HVHwcewG/XJD4ojAYb3P+Qf+kBq8/tnhvivD2Bu
         Phcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788645684; x=1789250484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UVqElZ4qtjCwioHxsmTjTY05QXyaIum43yfNEIN1HhQ=;
        b=KYteX3WBe5xIQShGansSL0umosrmslfATiah9YyAdLsT84I29XrZ9itojQaaqvLUTY
         wo6x2SS9vYqsCV5dI4Q+gzwnPQ42DoFrUro871XltTvZTWqZtjzeZ7j/xlKPQ2o6Wxb3
         2AMK13KKwYoCJOVujO+984eW15AN4/UM7skWl+cHHCvu3cr6sFqo4Igdu6ypPX5Z0utl
         aFtE4gACusULI63UP6PS9/TJgJfODo/P0GBiioGofqbrzK39NFB2G4kGZ9PBIEW6E5yo
         z7NJMXmP9fEwzfblZaTZikuYCecetT+t/oIMbnomiE8fwZqx92VWk249VBb/YsTiO9Rm
         fjMg==
X-Gm-Message-State: AFuF++lLrFT9jU1M/WtgC7YBAoRxACueXQS7SJgnib1pCiRdJ0wuiuAd
	c1SBWtGjlKNWDXeEvqxUyPIy0V1emVbF9o3l29ipaQKkcDRxw2CITFrvGi2YAg==
X-Gm-Gg: AYBFou1zAaHPlYiutB351n+h19x62N8sgV0/TrHAuOlK3J7Ue1Y6DJnPk92SHc0fMDo
	GU2re1sz0NblKV74o1YuR6f37iGXarCunu/bU6oo9weBiChR50GT7a3wshAydpgQ3UjUZ20ZIYW
	sBIsC/Ieul/QZ+KqT71iVea9wHQEzzCuefWOH64jgQvQKMCmRaoA2K6PYvEdkq7GxB75gx5qlXY
	/KJo2zhomsoSPWVARGzzWd96hP7bWCCTXLumVfbebi0YQaOvO4acKpUn16H+MmGY/HuYB6k5vg0
	lyHTHB8NJRV3iL4LyKehcSCqNH/Dxfbi1f9kt9rQlDAnPYCpAthFJH8YMK+FMtUleeVMEFib7iG
	t4EXjQvnfNFUZ/Cqk+vz41mifmUj00o7+FdweCvI5BNxrj4AqVCKV+0YkOyQ4B44Ac8iVtaVnWT
	NzgftHM7ZtRoWTaEY6yNQvwQXsLCZSvizfG05P9qfNThvjXqNQMLE=
X-Received: by 2002:a05:6830:6f27:b0:7f9:5a3:c247 with SMTP id 46e09a7af769-7f905a3c3f0mr7088214a34.30.1788645683658;
        Sat, 05 Sep 2026 15:01:23 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fcc45d7852sm1273812a34.20.2026.09.05.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 15:01:23 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 03/22] bpf: Only compare func_id against BPF_FUNC_* for helper calls
Date: Sat,  5 Sep 2026 15:00:58 -0700
Message-ID: <20260905220117.922028-4-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260905220117.922028-1-ameryhung@gmail.com>
References: <20260905220117.922028-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Helpers are identified by enum bpf_func_id, while kfuncs are identified
by a BTF ID. Both values are stored in bpf_call_arg_meta::func_id, and
a kfunc BTF ID can have the same numeric value as a BPF_FUNC_* constant.

Later patches extend check_reg_type() and check_func_arg() to kfuncs.
A bare func_id comparison in those common paths could then mistake a
kfunc for a helper.

Introduce is_helper_call(), which first excludes kfunc metadata through
meta->btf, and use it for every BPF_FUNC_* comparison. This keeps
helper-specific behavior out of the shared path from the start.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 30e1f7a7553e..9a39e46c0745 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8131,6 +8131,16 @@ static bool arg_type_is_dynptr(enum bpf_arg_type type)
 	return base_type(type) == ARG_PTR_TO_DYNPTR;
 }
 
+/*
+ * A kfunc is named by a BTF ID, which can take the same numeric value as an
+ * enum bpf_func_id. Only test meta->func_id against a BPF_FUNC_* once the call
+ * is known to be to a helper; meta->btf is set only for a kfunc.
+ */
+static bool is_helper_call(const struct bpf_call_arg_meta *meta, enum bpf_func_id func_id)
+{
+	return !meta->btf && meta->func_id == func_id;
+}
+
 static int resolve_map_arg_type(struct bpf_verifier_env *env,
 				 const struct bpf_call_arg_meta *meta,
 				 enum bpf_arg_type *arg_type)
@@ -8152,7 +8162,7 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 		}
 		break;
 	case BPF_MAP_TYPE_BLOOM_FILTER:
-		if (meta->func_id == BPF_FUNC_map_peek_elem)
+		if (is_helper_call(meta, BPF_FUNC_map_peek_elem))
 			*arg_type = ARG_PTR_TO_MAP_VALUE;
 		break;
 	default:
@@ -8367,7 +8377,8 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		type &= ~DYNPTR_TYPE_FLAG_MASK;
 
 	/* Local kptr types are allowed as the source argument of bpf_kptr_xchg */
-	if (meta->func_id == BPF_FUNC_kptr_xchg && type_is_alloc(type) && reg_from_argno(argno) == BPF_REG_2) {
+	if (is_helper_call(meta, BPF_FUNC_kptr_xchg) && type_is_alloc(type) &&
+	    reg_from_argno(argno) == BPF_REG_2) {
 		type &= ~MEM_ALLOC;
 		type &= ~MEM_PERCPU;
 	}
@@ -8421,7 +8432,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 		 * allows bpf_sk_release to work for multiple socket types.
 		 */
 		bool strict_type_match = arg_type_is_release(arg_type) &&
-					 meta->func_id != BPF_FUNC_sk_release;
+					 !is_helper_call(meta, BPF_FUNC_sk_release);
 
 		if (type_may_be_null(reg->type) &&
 		    (!type_may_be_null(arg_type) || arg_type_is_release(arg_type))) {
@@ -8442,7 +8453,7 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 			arg_btf_id = compatible->btf_id;
 		}
 
-		if (meta->func_id == BPF_FUNC_kptr_xchg) {
+		if (is_helper_call(meta, BPF_FUNC_kptr_xchg)) {
 			if (map_kptr_match_type(env, meta->kptr_field, reg, reg_from_argno(argno)))
 				return -EACCES;
 		} else {
@@ -8473,13 +8484,14 @@ static int check_reg_type(struct bpf_verifier_env *env, struct bpf_reg_state *re
 	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
 	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF | MEM_RCU:
-		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock &&
-		    meta->func_id != BPF_FUNC_kptr_xchg) {
+		if (!is_helper_call(meta, BPF_FUNC_spin_lock) &&
+		    !is_helper_call(meta, BPF_FUNC_spin_unlock) &&
+		    !is_helper_call(meta, BPF_FUNC_kptr_xchg)) {
 			verifier_bug(env, "unimplemented handling of MEM_ALLOC");
 			return -EFAULT;
 		}
 		/* Check if local kptr in src arg matches kptr in dst arg */
-		if (meta->func_id == BPF_FUNC_kptr_xchg) {
+		if (is_helper_call(meta, BPF_FUNC_kptr_xchg)) {
 			int regno = reg_from_argno(argno);
 
 			if (regno == BPF_REG_2 &&
@@ -8896,7 +8908,7 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 		 * Disable raw mode for bpf_map_peek_elem() on a bloom filter. The helper reads
 		 * the value buffer as an input rather than filling it.
 		 */
-		if (meta->func_id == BPF_FUNC_map_peek_elem &&
+		if (is_helper_call(meta, BPF_FUNC_map_peek_elem) &&
 		    meta->map.ptr->map_type == BPF_MAP_TYPE_BLOOM_FILTER)
 			meta->arg_raw_mem.regno = 0;
 
@@ -8918,11 +8930,11 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
 			verbose(env, "can't spin_{lock,unlock} in rbtree cb\n");
 			return -EACCES;
 		}
-		if (meta->func_id == BPF_FUNC_spin_lock) {
+		if (is_helper_call(meta, BPF_FUNC_spin_lock)) {
 			err = process_spin_lock(env, reg, argno, PROCESS_SPIN_LOCK);
 			if (err)
 				return err;
-		} else if (meta->func_id == BPF_FUNC_spin_unlock) {
+		} else if (is_helper_call(meta, BPF_FUNC_spin_unlock)) {
 			err = process_spin_lock(env, reg, argno, 0);
 			if (err)
 				return err;
-- 
2.52.0

