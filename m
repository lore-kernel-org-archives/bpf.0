Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E8C3ADBA4
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255291; cv=none; b=AG8If1vpDGSxa0isiiXQkHnmZg4Di8BgrCMyjwrnUsW5LKkaa7M/Crk4YwUQJ4DpsWio+ktiZ083TkcX60pqrJtq2U5uSTLPiswp2bTf/vGYk4pxpcfV77JJzd/wnv/srfi8Up89DB16AYEO+UH0bwylLcnVzxbzwAvbLUtj7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255291; c=relaxed/simple;
	bh=zxMcO3KW7mfTMH72pmnJujlVJ0F8nZ4lfhOvYg80FAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PtRSljSL2RGcfnI6p7jfXxwXo6a39ekaaAOJWVVeqHMVLpSrbGAbDNSF/IDBOBR4fucOScGiJsHyyXBhWUtTc0NCj79Z+WWJ3CzmVlxyT5Lr4PzsXMfws+iwR8OfBM1oLLM74XYcFGJyZOgPMl4coW3mamv27HIhEIbq6CjMwDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAxZjLAl; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAxZjLAl"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so862638a91.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 09:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255289; x=1792860089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BHgWxTVtHSyaO9uDsTzhWmrIO/F/owCnu99e0CLIMwk=;
        b=HAxZjLAlJJ9nAahR+FSCwvc59k0XIaOguf8xyJM4/uvrrELSKMNUp2laEwNT1tr5Gk
         A1gpsZNOKIW03CHlE/Uj0cUu7c02wuU0D0QS26pNO7r8oBSlQlZZJ+U7cfyQiBhGGn8k
         rKuQNndIDa5i1EunX13mdbVpcfxcTFOhfpHpSba7zyD9vetH+9r07fMt2pRUTGyYL8xh
         p9031GL6Ks55rENJ1mJs8VpH+O+wnAzffoJf6mV/VOv8+cU8Zdm68TevZhmVar51PQ01
         6QKVLmqspfvLx4z1xDEbbz9SSWW73rk+XMnOf8qg/hYswC5p5C0DQ5/GGDWIIMV+144l
         wYNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255289; x=1792860089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BHgWxTVtHSyaO9uDsTzhWmrIO/F/owCnu99e0CLIMwk=;
        b=ou6F02i20E9ouAFGMwczjgXT+5B/zKsqBuPDhwfQUFNlk5NGj+koshW8wmayVH3Fc6
         QWsrJimtvWjPwUytCQFKbI+Fj35Ig9GlmAQvGWdmAwEJ8t8LRw/5uSWfqdDQ5MLA4F3X
         YD5E1sUZjQ9Ihf5ollVeBAmtadJF3q2RaVt0CNQHFwqRl9z7ixaaDIgOBVFKH3CrbZpt
         EpvWsTgFe/fPKTqiUCXaIgzT/ZUABxswyOXv7WKxnCWpqMDItNAOHjf6Ahtiyv2nIk3R
         U8XWS+DeI759sudEuHsVJ0DocjXVhbzCVOUpRmIsWWr49BN3jIw4c1YuYTwqxhYTtxkV
         NwQA==
X-Gm-Message-State: AFq9FYJ6AwHIkDoG5BxhMD1xVdAuzp81CC8MGJJwf0GLXKOrsr4LtR/b
	gi4Mu8t1oRW2qEbHtZiDqFDsZOT6HOEMruKI5JEJw3YIMuu6rcOnorqmgMHSlA==
X-Gm-Gg: AYBFou3EIxi4Ze3fhy/COivU/B3jhlY28tSOf3x8tLeRK6WhBtH3QsZQYfdJjIi54j1
	6Nk03JNDGLyBNvI882U8i+0bneNX6E3XgGy2EmLpzXE5ylCIbVl9ILBn1wvA5f/fWoKuKu+DoPK
	1bVTf5b3Kvq2ANSx8rIpr3LjbysMflgygIKyeaKCmmGcEGO/mAaectuWZHC6jWD0xqEG+xj126z
	JTiYYw0B5d4a5KX5RZc4kRA1g2HGG/lY5D0NpQvWuC7CDHNo2XtcvW2iu61hQ6YeDx/x5sbuZzb
	Fw3tDhK2M7m9g6Clu63tFAvpXSYPgNGVai9u4hMmoUPENcq2xyNvmQWHsC8jFPxwUtBFU6Ke1VR
	/1h80MeRDriwhaTP93ke+9awgMUKN43VaTNAFFYl7X6oR8NwDDJNRGgzNavwXjIbS0h4Xv+zGBi
	Qd9js7Ga4xpk/R7SPxIDCbEYiJfTFwNJTA2uqgzgCpiyytq2jyCssw8HaxjDYxeCwM88a1pD503
	nXLoUJu2nSfvWkZAeHeLXjfyfEdc7VAjeT/EVQZnaLWlK+O0OSOlVgSfrafJZBc5WxFykb7IxWY
	6SmuCj/sfK+Hc1ZGwmHC/+g0ZEpC4H7NvjWTujU0x3xB
X-Received: by 2002:a17:90b:43:b0:3ac:3588:b548 with SMTP id 98e67ed59e1d1-3aceeb96c4amr2743133a91.13.1792255289042;
        Sat, 17 Oct 2026 09:41:29 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac947d2706sm13828550a91.16.2026.10.17.09.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:41:28 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 36/43] bpf: Drop packet pointers behind kfuncs writing an skb
Date: Sat, 17 Oct 2026 16:37:38 +0000
Message-ID: <20261017163745.3341787-37-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

bpf_dynptr_write() to the dynptr of an skb ends in
__bpf_skb_store_bytes(), which makes the range writable first. That pulls
data into the head or unclones it, and either can reallocate the head. So
check_helper_call() invalidates all packet pointers and all slices of the
skb behind the helper.

Several kfuncs take the same road: bpf_dynptr_copy() and
bpf_dynptr_memset(), if they get no writable slice of the destination
because it is not linear, and bpf_probe_read_{user,kernel}[_str]_dynptr()
and bpf_copy_from_user[_task][_str]_dynptr() likewise. The verifier does
not know. A program can keep a packet pointer or a slice across such a
call and read and write the old head, which has been freed.

Treat a kfunc of that kind as bpf_dynptr_write() is treated, by the type
of the dynptr it writes to, which is the first argument of all of them.
Where a global function is only scanned for what it may do, the type is
not known yet. There any call of these kfuncs counts, as a tail call does.

Fixes: daec295a7094 ("bpf/helpers: Introduce bpf_dynptr_copy kfunc")
Fixes: a498ee7576de ("bpf: Implement dynptr copy kfuncs")
Fixes: 5fc5d8fded57 ("bpf: Add bpf_dynptr_memset() kfunc")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/verifier.c        | 44 ++++++++++++++++++++++++++++++++----
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index e420d211f423..7a72bb06fe56 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1803,6 +1803,8 @@ struct bpf_call_arg_meta {
 	u32 kfunc_flags;
 	const char *func_name;
 	struct arg_constant_desc arg_constant;
+	/* The type of the dynptr that the kfunc writes through */
+	enum bpf_dynptr_type dynptr_write_type;
 
 	/* arg_{btf,btf_id,owning_ref} are used by kfunc-specific handling,
 	 * generally to pass info about user-defined local kptr types to later
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d738ce6e7428..597302cf7086 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1002,6 +1002,11 @@ static enum bpf_dynptr_type dynptr_reg_type(struct bpf_verifier_env *env, struct
 	return bpf_stack_slot(state, spi)->spilled_ptr.dynptr.type;
 }
 
+static bool dynptr_write_changes_pkt_data(enum bpf_dynptr_type type)
+{
+	return type == BPF_DYNPTR_TYPE_SKB || type == BPF_DYNPTR_TYPE_SKB_META;
+}
+
 static bool is_dynptr_type_expected(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
 				    enum bpf_arg_type arg_type)
 {
@@ -8976,6 +8981,7 @@ static bool is_kfunc_arg_scalar_with_name(const struct btf *btf,
 static bool is_bpf_cast_to_kern_ctx_kfunc(const struct bpf_call_arg_meta *meta);
 static bool is_bpf_dynptr_clone_kfunc(const struct bpf_call_arg_meta *meta);
 static bool is_bpf_iter_css_task_new_kfunc(const struct bpf_call_arg_meta *meta);
+static bool is_kfunc_dynptr_write(struct bpf_call_arg_meta *meta);
 static bool is_bpf_obj_drop_kfunc(u32 func_id);
 static bool is_bpf_percpu_obj_drop_kfunc(u32 func_id);
 static bool is_bpf_rbtree_add_kfunc(u32 func_id);
@@ -10040,6 +10046,8 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
 		err = process_dynptr_func(env, reg, argno, insn_idx, arg_type, meta);
 		if (err)
 			return err;
+		if (!arg && is_kfunc_dynptr_write(meta))
+			meta->dynptr_write_type = meta->dynptr.type;
 		break;
 	}
 	case ARG_PTR_TO_ITER:
@@ -12654,8 +12662,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		if (dynptr_type == BPF_DYNPTR_TYPE_INVALID)
 			return -EFAULT;
 
-		if (dynptr_type == BPF_DYNPTR_TYPE_SKB ||
-		    dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
+		if (dynptr_write_changes_pkt_data(dynptr_type))
 			/* this will trigger clear_all_pkt_pointers(), which will
 			 * invalidate all dynptr slices associated with the skb
 			 */
@@ -13704,9 +13711,36 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_call_arg_meta *meta)
 	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_preempt_enable]);
 }
 
+/* These write to what their first argument, a dynptr, points to */
+BTF_SET_START(dynptr_write_kfuncs)
+BTF_ID(func, bpf_dynptr_copy)
+BTF_ID(func, bpf_dynptr_memset)
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
+BTF_SET_END(dynptr_write_kfuncs)
+
+static bool is_kfunc_dynptr_write(struct bpf_call_arg_meta *meta)
+{
+	return meta->btf == btf_vmlinux &&
+	       btf_id_set_contains(&dynptr_write_kfuncs, meta->func_id);
+}
+
+/*
+ * A write through the dynptr of an skb may reallocate its head. Before the
+ * arguments are checked nobody knows what kind of dynptr it is.
+ */
 bool bpf_is_kfunc_pkt_changing(struct bpf_call_arg_meta *meta)
 {
-	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]);
+	return is_kfunc_call(meta, special_kfunc_list[KF_bpf_xdp_pull_data]) ||
+	       is_kfunc_dynptr_write(meta);
 }
 
 static u32 kfunc_abi_slots(const struct btf_func_model *fm)
@@ -15644,7 +15678,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
-	if (bpf_is_kfunc_pkt_changing(&meta))
+	if (is_kfunc_dynptr_write(&meta) ?
+	    dynptr_write_changes_pkt_data(meta.dynptr_write_type) :
+	    bpf_is_kfunc_pkt_changing(&meta))
 		clear_all_pkt_pointers(env);
 
 	proto_slots = kfunc_abi_slots(&desc->func_model);
-- 
2.55.0

