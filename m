Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BCA3C1D7B
	for <bpf@vger.kernel.org>; Wed, 16 Sep 2026 05:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535327; cv=none; b=kwhdB1dbVUpsMpPBYzJ2iqwYgcEXEQW5HPK1ZUsjhOtpZV5u3a2IqaBBibl8FVGFvjweAE1TdB4x7BuPTf3TFb1EOZaw0ZrPt1ZBnG4qttEUOw6p/oiSjHWphYzu4TWoFZQUAxman9ntAxXMrXtFLeRWRyaS9EG88I17FoorTs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535327; c=relaxed/simple;
	bh=UWuadJR/St+ElhZmIXwKWiuRHV6uiw9yCNnbDlcP9Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bg2RdyeHxtjqhghTtt/rfCLJpTw+/kTduC8m1G+dO0iw4clGrnosLaJ6eX48Pu4HulgGxrq4P/dJgq/OvG7mcMOEPFjpiZnn+0irLQu+3RLCVru6yXWD/DGfHCrk55sOrsCTxYfnGFtnKzIdFk/J0Xk4ha9/Ihc4pHfWTdsnKz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ANZ3d1Kt; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ANZ3d1Kt"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccd78e6eso137373a91.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1789535325; x=1790140125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bCaqHX1MkDeQ6twZa/w7cDr3kkCbgUYB+cXdRyDbQR4=;
        b=ANZ3d1KtvKxwjA+QQ008dGm8tXZxuG+1HiaHZRUKiuU9a5SCbK7CDUWfCTtkZ1c7Wr
         EKwQwuKx1mGbAAYH4++sgwAa9lKzotelaRCmHsdK811FCSM29p6V/MalrkP8xHOeGLqS
         Xv2AhJ7gsv0cDUBKyExsAncSndOH0M/QKsQz4Md8v1R7Pq5tepgXKoEk6Cachi9/BVv1
         dyngCRPek8iPRcd4lNwHntEih1nFtKj7F/GEm3UgdSGBq1j+56kUCmQpMpWDoAFRvuj2
         swfVj5VPalCwhBHyk2gLrcc1XOHgs2Khplstkf6VJZFqY0XzoUhrFMs6hKMRbYRe/mC/
         ADLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789535325; x=1790140125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bCaqHX1MkDeQ6twZa/w7cDr3kkCbgUYB+cXdRyDbQR4=;
        b=L5R8Tfmgv3crVt0dPtfpRCutLc0XsXZ/GTGvl2oylF/gus6KNKHhF1fXBvSmb1nbRd
         sT5H9tA6z5vozvTaj2v4HXs+RSu3FnQeiItxN6KxNmX48RbK1l7i4kJJ48KH0y8eQGVY
         kYsQ+9Zu7r/8ALGokAgiGSXMJBnNu0P/kO1KrArBUhPqOzTnsAtLeztJ0Sd2lisb5hR2
         ccgy+G84dalmIKdG/23Iv7BaE/gGFVxlbggVLCPrJaAtnnDB9fD1y9MUhamPkzvS0HjC
         5HFPtOB444qWbsNaq0DfFhz/D15ZrGam7hmjaB058Lbbk6WuqVgPcTGjr1Klg8K2PJ81
         ocHA==
X-Gm-Message-State: AFuF++kiK3ivJKWqxIZa1/oeYGCGlQQemWabnZ5ozckYeEyymhGofVIj
	OmfbaGgWcDGK1rTa0YFQCBnLt/BfJdbM2SAfK8o4kvKdM6Uyt4Nkt0ZY66CdhVl7DqzQc5ZCk7n
	d5dFp
X-Gm-Gg: AYBFou0FSYD49ER+yVECz4tr3Am8KoTLLwaz5XGRGJAs9ahE/T/hwh2bmzmnz0hO2PA
	psQNJQSOeC4WGmK0yCv/l3Vw/iBzRrTsoqLjd8YNlM+uUX/mcLAvKclrZ4oS6elMpr0vkW6O0v7
	uIqXZJlE/wRzpAbrAygCUo2Mr0ZsozaO+vwPKB3gcAI4OM4b36DcLHulRs4bk+oe8G1HUh7Jejt
	WYPHkos+SCGjfhhaXwISTgnc2T5xsuiRA/TAO6PppjllpcElRfp4tGj+zjxdDhg1zFlJ/YdC3IM
	rbFAT6HYFUOEawOB/FvRUMDUZiICfRWkM6Op0wa8HAdgU8mL9orp3f0FshylILmEQvyr0vwbNMx
	P4P/+RW+f763Y7VmJV/IRkwuxKWVK0EQILTU39EN5lzN05/d25i0GNfjlOASy7gZqMaVnFmk+Gg
	AdaVG5z0C/BcinfLo3Zb+Hl73hy4FR1pxtOoULc7KloIN4/tS90O4nhdsq2WoLpjWBH3H2Ephz4
	JpfdUPqDplIYNkR98unbq6F2m4Bhb40ES35Cg==
X-Received: by 2002:a17:90b:4985:b0:39e:252b:86c5 with SMTP id 98e67ed59e1d1-39e252b8838mr304624a91.1.1789535325423;
        Tue, 15 Sep 2026 22:08:45 -0700 (PDT)
Received: from alpine05.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm2363363a91.11.2026.09.15.22.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 22:08:45 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <nicholas@carlini.com>
Subject: [PATCH bpf 10/11] bpf: Track skb memory invalidation by packet-backed dynptrs
Date: Wed, 16 Sep 2026 05:08:28 +0000
Message-ID: <20260916050830.8774-11-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260916050830.8774-1-emil@etsalapatis.com>
References: <20260916050830.8774-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A dynptr can be backed by skb memory, and kfuncs that
write but also read the underlying area may reallocate
the backing memory in the process of pulling the skb.
However, the verifier does not track these calls as
possibly invalidating packet pointers, and does not
do so after their call site.

Expand the verifier to track dynptr kfuncs for packet
invalidation.

Fixes: 5fc5d8fded57 ("bpf: Add bpf_dynptr_memset() kfunc")
Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
Fixes: daec295a7094 ("bpf/helpers: Introduce bpf_dynptr_copy kfunc")
Reported-by: Nicholas Carlini <nicholas@carlini.com>
Suggested-by: Nicholas Carlini <nicholas@carlini.com>
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/cfg.c             | 10 +++++--
 kernel/bpf/verifier.c        | 51 ++++++++++++++++++++++++++++++++++--
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 76aa724de..64cfeda5b 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1585,6 +1585,7 @@ struct bpf_call_arg_meta {
 
 	/* Only set by kfunc */
 	bool r0_rdonly;
+	bool dynptr_may_clobber_pkt_ptr;
 	u32 kfunc_flags;
 	const struct btf_type *func_proto;
 	const char *func_name;
@@ -1639,6 +1640,7 @@ static inline bool bpf_is_kfunc_sleepable(struct bpf_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_SLEEPABLE;
 }
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta);
+bool bpf_is_kfunc_maybe_pkt_changing(struct bpf_call_arg_meta *meta);
 struct bpf_iarray *bpf_iarray_realloc(struct bpf_iarray *old, size_t n_elem);
 int bpf_copy_insn_array_uniq(struct bpf_map *map, u32 start, u32 end, u32 *off);
 bool bpf_insn_is_cond_jump(u8 code);
diff --git a/kernel/bpf/cfg.c b/kernel/bpf/cfg.c
index 842c7d1ea..cb499d19d 100644
--- a/kernel/bpf/cfg.c
+++ b/kernel/bpf/cfg.c
@@ -73,6 +73,12 @@ static void mark_subprog_might_throw(struct bpf_verifier_env *env, int off)
 	subprog->might_throw = true;
 }
 
+static bool bpf_helper_maybe_changes_pkt_data(enum bpf_func_id func_id)
+{
+	return bpf_helper_changes_pkt_data(func_id) ||
+	       func_id == BPF_FUNC_dynptr_write;
+}
+
 /* 't' is an index of a call-site.
  * 'w' is a callee entry point.
  * Eventually this function would be called when env->cfg.insn_state[w] == EXPLORED.
@@ -510,7 +516,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && fp->might_sleep)
 				mark_subprog_might_sleep(env, t);
-			if (bpf_helper_changes_pkt_data(insn->imm))
+			if (bpf_helper_maybe_changes_pkt_data(insn->imm))
 				mark_subprog_changes_pkt_data(env, t);
 			if (insn->imm == BPF_FUNC_tail_call) {
 				ret = visit_abnormal_return_insn(env, t);
@@ -543,7 +549,7 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && bpf_is_kfunc_sleepable(&meta))
 				mark_subprog_might_sleep(env, t);
-			if (ret == 0 && bpf_is_kfunc_pkt_changing(&meta))
+			if (ret == 0 && bpf_is_kfunc_maybe_pkt_changing(&meta))
 				mark_subprog_changes_pkt_data(env, t);
 			if (ret == 0 && bpf_is_throw_kfunc(insn))
 				mark_subprog_might_throw(env, t);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 357ed7c30..bcd4bd2dc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8260,6 +8260,7 @@ static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 					  const char *name);
 static bool is_bpf_cast_to_kern_ctx_kfunc(const struct bpf_call_arg_meta *meta);
 static bool is_bpf_dynptr_clone_kfunc(const struct bpf_call_arg_meta *meta);
+static bool is_kfunc_dynptr_may_clobber_pkt_ptr(struct bpf_call_arg_meta *meta);
 static bool is_bpf_iter_css_task_new_kfunc(const struct bpf_call_arg_meta *meta);
 static bool is_bpf_obj_drop_kfunc(u32 func_id);
 static bool is_bpf_percpu_obj_drop_kfunc(u32 func_id);
@@ -9294,6 +9295,15 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		err = process_dynptr_func(env, reg, argno, insn_idx, arg_type, meta);
 		if (err)
 			return err;
+		/*
+		 * These kfuncs only clobber packet pointers when their
+		 * destination dynptr, argument 0, is backed by skb packet data.
+		 */
+		if (arg == 0 && is_kfunc_dynptr_may_clobber_pkt_ptr(meta) &&
+		    (meta->dynptr.type_unknown ||
+		     meta->dynptr.type == BPF_DYNPTR_TYPE_SKB ||
+		     meta->dynptr.type == BPF_DYNPTR_TYPE_SKB_META))
+			meta->dynptr_may_clobber_pkt_ptr = true;
 		break;
 	}
 	case ARG_PTR_TO_ITER:
@@ -11720,7 +11730,8 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		if (dynptr_type == BPF_DYNPTR_TYPE_INVALID)
 			return -EFAULT;
 
-		if (dynptr_type == BPF_DYNPTR_TYPE_SKB ||
+		if (meta.dynptr.type_unknown ||
+		    dynptr_type == BPF_DYNPTR_TYPE_SKB ||
 		    dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
 			/* this will trigger clear_all_pkt_pointers(), which will
 			 * invalidate all dynptr slices associated with the skb
@@ -12742,9 +12753,45 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_call_arg_meta *meta)
 	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_preempt_enable]);
 }
 
+/*
+ * Dynptr kfuncs that may clobber packet pointers when called with an skb or
+ * skb_meta backed destination dynptr by pulling the packet.
+ */
+BTF_SET_START(dynptr_may_clobber_pkt_ptr_kfuncs)
+BTF_ID(func, bpf_dynptr_memset)
+BTF_ID(func, bpf_dynptr_copy)
+#ifdef CONFIG_BPF_EVENTS
+BTF_ID(func, bpf_probe_read_user_dynptr)
+BTF_ID(func, bpf_probe_read_kernel_dynptr)
+BTF_ID(func, bpf_probe_read_user_str_dynptr)
+BTF_ID(func, bpf_probe_read_kernel_str_dynptr)
+BTF_ID(func, bpf_copy_from_user_dynptr)
+BTF_ID(func, bpf_copy_from_user_str_dynptr)
+BTF_ID(func, bpf_copy_from_user_task_dynptr)
+BTF_ID(func, bpf_copy_from_user_task_str_dynptr)
+#endif
+BTF_SET_END(dynptr_may_clobber_pkt_ptr_kfuncs)
+
+static bool is_kfunc_dynptr_may_clobber_pkt_ptr(struct bpf_call_arg_meta *meta)
+{
+	return meta->btf && btf_id_set_contains(&dynptr_may_clobber_pkt_ptr_kfuncs,
+						meta->func_id);
+}
+
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 {
-	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]);
+	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]) ||
+	       meta->dynptr_may_clobber_pkt_ptr;
+}
+
+/*
+ * More conservative version of the above used in check_cfg(),
+ * where no register state exists and the dynptr type is unknown.
+ */
+bool bpf_is_kfunc_maybe_pkt_changing(struct bpf_call_arg_meta *meta)
+{
+	return bpf_is_kfunc_pkt_changing(meta) ||
+	       is_kfunc_dynptr_may_clobber_pkt_ptr(meta);
 }
 
 static u32 kfunc_abi_slots(const struct btf_func_model *fm)
-- 
2.54.0

