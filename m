Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172ED37C109
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 23:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792278643; cv=none; b=oiHBNi+E6tH/49JRQ1ouu4Xzevlkek7rVZNK7ujRSInUxc5xpQklqsIgjttjycepcnc+NxLyQa6+PSwxmgJibGYJIewmo/znY7532IFVSLUnxzQ8SEU/R3tteZSFG3jspF+XgMBIEGgMNEsgLKf/K1CbgP2QBNC7FLlk+z2wur0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792278643; c=relaxed/simple;
	bh=zxMcO3KW7mfTMH72pmnJujlVJ0F8nZ4lfhOvYg80FAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgwijDmZeBW+Kxh8/4/SkUYr2JmKI6MOQ8+vvEucVeRIjHRpGu6+qe9BEB5b4rEd7XEadmxZU/J+AekYblzupoxGUYCRh50TrSEGQG0vqVAWrTF4gZQ4CxLMG2DV0J2E/UZ5iBk1p3mquqHKEavb10ghwvzPjLpHgnqzK2UB48k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFz14+Lt; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFz14+Lt"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3a4b9732d5aso929662a91.3
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 16:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792278641; x=1792883441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BHgWxTVtHSyaO9uDsTzhWmrIO/F/owCnu99e0CLIMwk=;
        b=jFz14+LtBKs4G3CC1EOFhLgxS5H11C6xOqgMtqKKjJdXK0ZodfpNLcikjEzCDEB37L
         d4j1B76cPVP3QIQhXo5UyKtAOI3Yo+0JRcOZFs6uYkP3c2rz8regWjqdMhx6CYHXfPR8
         Tmyex/2CxULQLi1vRBGvqNTDC/oTg+8x2WiViaITUvEfWtbZc4ryOBrPefWS3dZ8Duuh
         +QSFs4/0GKsJSQ7I9AHsPBr2OTO0HlPFo4esSU1mwZSlIt2p/F1CGN6FCQHvwYxN63kp
         zHaSXYoVFyW5TOk7/I0wBl353/9UF6TQMN7ywpdJd/IvRW8DRxJ84AHs+BGlGXzcZ7si
         FgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792278641; x=1792883441;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BHgWxTVtHSyaO9uDsTzhWmrIO/F/owCnu99e0CLIMwk=;
        b=RqBNFr2ZU0Ybtn3ED4b9Q8KuPtOwlU8TICoCNiZOoH4rlKH2hndWPET2foMoIwFFpE
         mwXRi39nFuSVu1ISRCpnxITXp70pjHIUUH2Osyw2vs/apcKrqysNrwti3Q3GLE4Nv3v5
         eptttY9sZGomTbMyDfbZWW3bhX7zumTrhUzPi0cTHrSByn+Qxm/khAZ0F2sWmPt7KSdK
         9XjE8Kp6D/8kQfwldXuA+6/gYqynnuogsxoWOSATGIyG9XgUd2aM6TbQ4vm4T/WIvtsB
         PtB7LJm7mouSfgg5lHfMyGCX6KfTm831PgjkhVOY3LstNPMygPbn3ZHfDll/O/LOQiPL
         FGBA==
X-Gm-Message-State: AFq9FYIQc1OXrKIFiouqwOyNhZjTl1fnLyrn/Nfj+KLcFZhII7IKn+pd
	N8lxTc+truKfl90Uv9lVmRVwhOOLLUZSkIu1ei68VIjRw6pb2EXQACCda7EpMQ==
X-Gm-Gg: AYBFou1nZN5x3MD7F8aGxOOP/c02XqsQ3frhatc+CLQHT65mtIBpVHbChN/Nr+WKO3E
	0aXHLLqb2Hlg6/TkwTx3UAEFQmnI6MGnTcBHM3d9zsQWQxvYDVJTNZEcsN0u+x0OuuCPCw8YN+1
	HU4IlAR6q+fg8iRYahzDp/DUb2p4H2V9GdtrJHbLg7bYrSlin+HB9v3P6+EHsMArwqv3bzPXFDl
	W2J2m5yq4+FsMoOQWI4go+tQgGxdFzAX9Y3RPcC8dcOY1+1I3rJveEzZvB7OXsiQjtHWpotlzoi
	uFjchPZbr2+WQlTCQXX4AQl79Rka20ZcHNIzlD4z8beywVAeQNp06+38uxVaZrpI6jyUxO4oQzr
	Wh67lFAZwfYUIoJxrDjiXkwm+HEGxo4i9yflseGUDkGfCP3iO1x+9d/iDoSsfzg4QqCxTSI+UfV
	dvyQZCbqJXsco49MDdtRQR7r9T+ZOgA6Ao2VHct8pfs1NxUEgV8Q6nlVV4O26RmSxzwNSCT0KcB
	WEYIrWOuGUwE7+YPJp5ll5sturkBMVu74eX+FmQvbI6LBeMRR9Km7CCkxj2cI40YKvUWwzOG9uE
	Op5iG3YC4A7mpxTX/MhpAiqOR/n/xUTmHZWrjkS7gdg=
X-Received: by 2002:a17:90b:4a0e:b0:3a4:b0f3:6597 with SMTP id 98e67ed59e1d1-3aced88dc1fmr3955905a91.0.1792278641381;
        Sat, 17 Oct 2026 16:10:41 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94748c6csm14833344a91.10.2026.10.17.16.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 16:10:41 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v3 08/16] bpf: Drop packet pointers behind kfuncs writing an skb
Date: Sat, 17 Oct 2026 23:09:42 +0000
Message-ID: <20261017230950.802052-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
References: <20261017230950.802052-1-alexei.starovoitov@gmail.com>
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

