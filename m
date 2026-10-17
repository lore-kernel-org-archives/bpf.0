Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985F382866
	for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 01:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792200813; cv=none; b=VU1NeVS7vaSmESRTckS7VDiKRvdpzPIPZ0WDMqyzbily/mBYxAAXV+bpn+XfRgQwbXyqtUmGZRyXFVRBcyNaXNRwy0WPtLIeSXA8/5BVriEqZ57W5uzzeuaBHoFSZmkjVQFlifaTjjkVt8pemAKfN74HX8JCzrww6FSHaZxQBw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792200813; c=relaxed/simple;
	bh=6Y8Eh+WDB4xFZVgGHovjyjQOQI+8jNO1tiUZ/m4d5M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fz4VIx5HPX6gpJXQ50sFYpYCLb8dmCJmq88HbolPq7Gq9npRNlL/eQ7USkS8VQdTQChi4Y3tY7RmDbE+yzJoromJ6oSA/rIJMnlvRF35t5CXaoocjbxtjjWbpKIki6OzsskqaTELkYzpyyc1koYShpFe/9/iZRh3m6OgO1xLTm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ix3CJWza; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix3CJWza"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e49fbf92aaso2322295ad.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 18:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792200812; x=1792805612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qWIA6mhufrwNZHdWh6rU2gHphcgQne78CoVsFy9HRYM=;
        b=ix3CJWzaIzydjzzZYwek1E8+qvz7MZYsE9lRf82ZDTufMctA4ZN7EajAg2EjKs2+6p
         1htQ34f9NosTWs23LbfeCZrUsl1u52E2EyfSsZ/m+foKf3jYmTimwxX/VIjwDS4GLg7C
         jpFs35hJqXx3VkkrypKiseUq51fHk6aZ051rBWuV1ktkbmBFQlCW3dWTKpGLl3n879Hq
         pcchViKOTuuyk25gUwRHncDNSRJ3sHIOU99P+4/ISQrQgCOIIqm73vgFkD1PGjySTXE6
         GBOy9N6k/QTdlHXiULZk8UmfxompUAgRUrFI/GLYhkxBWLiKJyQ0/oltVPhjp8rilB/K
         dLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792200812; x=1792805612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qWIA6mhufrwNZHdWh6rU2gHphcgQne78CoVsFy9HRYM=;
        b=m50AxbWSf1/cY1aINWF1MrG12Fp+Nt4LsokGOM9sWNshuLeXmZncZQyHUcInn7rNzs
         //B6YwVtlebDLNFeo0hE6A62N3pVyqnciZG9NEIJMZQYf7ayNWt+OlzfjghZa/oGyWbi
         KzKLXUTHyXm3OhWl6TDf+QP9Ou1bIFJSHasLyHVan4HWxVCxT/HyPn7365Tv052OuX3A
         fabfu+khxxp33/3Zvanqn4vFsJ4G0x2wtjePZa4v9OX/rw1b7mEzG4BmcVxtVGVrR/9j
         5ipFSoALf2R9hHbRenyzz9zxl3yBXkWXi8kEuiGa2Hr8fmRLiZeEQoxeG6M0gaV7UA9B
         aeQA==
X-Gm-Message-State: AFq9FYJlbqZDHH+heZFww53DgaxuejUASgK8tT58drCsMEIfRS7SPVfj
	S79+LCGwu4VWCewh+koiDIaI5UGGV3zq4h4qrfsnXoc//WlPuQ8uNy5uLNgQbBLq
X-Gm-Gg: AYBFou1/5OEnY4lYpnoTtbWsrnVfTZBlZ3EvOuEHbDOry0/qghdZxfWnuDM8RocMhGO
	5pWHnfk2ghGT5vVEhPfmmV6S/oUxIgN8h6NvZt4/xH1ojHwO/gvHQ7i/WqKUBXIOG93EEn9Lwx/
	FdsrGmb+WO85rIjfRiUNs0HCsZjmVsNH+df/a7M0qzZjjIPTFtaPubw+0Dp8VDUlS32p8lMZR27
	mdaguLyI5YvCmh0eyjFYaDZGKMkExvcinb6aUMm6jfm54VaF9Gyj5YJwefmQ0MM0/eek+XdTqXn
	LlYAi+g3+rgq/Fc0hevJ0ejWEB8y9WSuz+yHeqeXghVE+k30kgaGYVgI+bpbmziXIubStb66aIt
	8mo2oAn0HOyjZ41Pg6SbxXBNwaysVBrK/WLYrLTMd6G+z09Wf4OuADIi+kR5jh474qWVbw5jrPX
	P/y/oz1pc2FuWTFk7fFfOeVXgDZnHEcW0bIsWX8E3xs1GnPhhnFc/OekAVW2S87DDCwLUFEMXBQ
	iSxU3WXqe3wLmaPdGK5M8ZN0mgIIWDuHda+Waz/nTcZgRfEoN4nFBxt31BHMKwkfQqJq1XAaxiA
	ewHRILgiEoDHImsn3mkm5ouXo54sX6nyVbSZTVNToxUI
X-Received: by 2002:a17:902:ce04:b0:2e9:4e83:1969 with SMTP id d9443c01a7336-2e9a6d363f9mr12611585ad.34.1792200811859;
        Fri, 16 Oct 2026 18:33:31 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804e80sm17699805ad.23.2026.10.16.18.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:33:31 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next 33/38] bpf: Drop packet pointers behind kfuncs writing an skb
Date: Sat, 17 Oct 2026 01:24:46 +0000
Message-ID: <20261017012451.364800-25-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
References: <20261017012058.355787-1-alexei.starovoitov@gmail.com>
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
index 816948df8fff..1ca03f8cfd83 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -1801,6 +1801,8 @@ struct bpf_call_arg_meta {
 	u32 kfunc_flags;
 	const char *func_name;
 	struct arg_constant_desc arg_constant;
+	/* The type of the dynptr that the kfunc writes through */
+	enum bpf_dynptr_type dynptr_write_type;
 
 	/* arg_{btf,btf_id,owning_ref} are used by kfunc-specific handling,
 	 * generally to pass info about user-defined local kptr types to later
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6ee9b5c6fe47..e002728abd04 100644
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
@@ -12635,8 +12643,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 		if (dynptr_type == BPF_DYNPTR_TYPE_INVALID)
 			return -EFAULT;
 
-		if (dynptr_type == BPF_DYNPTR_TYPE_SKB ||
-		    dynptr_type == BPF_DYNPTR_TYPE_SKB_META)
+		if (dynptr_write_changes_pkt_data(dynptr_type))
 			/* this will trigger clear_all_pkt_pointers(), which will
 			 * invalidate all dynptr slices associated with the skb
 			 */
@@ -13685,9 +13692,36 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_call_arg_meta *meta)
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
@@ -15625,7 +15659,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
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

