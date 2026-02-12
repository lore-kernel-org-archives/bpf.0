Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5328F3446C7
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 21:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770932085; cv=none; b=cTLyqqpIZu1yujXo1SMxifnS1OYbLF9x//wrJNfdogzeZWV8QjWD7Ygyl2bz8A5FJfdvXp3DQt92TN6t8JepQ3vCURrq3BdjCL6SsxQkuwH9gEBqCvdx4pz07n7Dg96itTXCwuLRwvanO16U3MTfsM9JW/Ad3A7ebVnMZx86Zog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770932085; c=relaxed/simple;
	bh=YPUOtHGO1PhfEYFePm2C2e7A86eUkzUfIRnP7agPDck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HCGRdIzc8zhX+FOff6l7BhYDfb8iwjRQ5++IeF0ySylUS9qEw5hDbcVWK7b/ntXMZS5+r1eXwbNkxpL57Aawy0VgX9gUMSr/Jq7rJ07wph2YLaXaJuE7K7YapGOwL1TaW/CU1SvmzG6o24pEuHnPyljMLJ/KTkgOzFktjyytGqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cw00V0t8; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cw00V0t8"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-823210d1d8eso160120b3a.1
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 13:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770932083; x=1771536883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+VP7TKXwIhl8uMuiNzin81cPp6VUZ9DaTjemZJ9oRk=;
        b=cw00V0t8iwJhPTx7kpVhUh7UwKjLwn6q7X725lVAt8qIxcGBGrmCiyENP3Zb8iq5S2
         hweX7OTZRzSjPS3Jyn5jQHtyNlCOzSqEivZy3RVA6O15shzQgZVxa76PT66msRejpI43
         p6h5AZswy88PgVu4Gn4Ci2Y7X6+ayIYgWNruooceOImTqBgqKsP+GMr317T+h6fkL7EX
         F7tdTiuWAgF2lYaJOllVqEu0ZMDpv7BvpFrfXh+lqhX8Ua2FGOiQCp72EPgGFpaDN+g6
         WRrohd4cYZ29lgBxrIovF5Shl3Wme51gOZc9ux9oErRWIJwW1D8fK0lj3c0M389U1NxS
         +0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770932083; x=1771536883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P+VP7TKXwIhl8uMuiNzin81cPp6VUZ9DaTjemZJ9oRk=;
        b=baPaf57UP+ZqrGbunzxWVYuUiIyXl1UfeGc8dydwfq8wHAH9T0zNsQM/+xOaEg1aEt
         rGzl2kNPncdMkbznvtT77xU22JJzOemoeXPjuahTprWw+sVi6ByScZVSJo7GlrP5dcOe
         gC1CjHiibS5oGhxrta1CkYcUx6Cv7lx1jD3d11d4jP3GWFEPVctpTsgAyFcbURA84S1B
         2WhtoVo3AOvVGCzzmlQi2ADM2Nah10frq9RGlaRMczW0OnF2oN1X2wlAj82ZXV6W95D6
         plp0lryZkq9XwR4vhMKNVXcNZtcimk9ahuvjIk0+cMp2MqGEPxH/B6b/gRFteqh5R/VB
         cR8A==
X-Gm-Message-State: AOJu0YyTbG7hDWOfQtBiO32IB7nBcEZmbyjNvJho9CtCB3BBstTKXqbT
	UphMKYjK8hJn2Pkpg/7JmHY8O+GM2RcQMGnamUhKoWHjTQL7EMG0LBG1N19iKRyT
X-Gm-Gg: AZuq6aKr5liknQJso85LWPZ+PZ6rJkafmXwvOaKLLDq7XOQXOvyS7qFpJyLhlR/2PQg
	yLr9iqjoDyFYNX7ZVEEOfcE6GQaGd+1LO6S6fIKi7skHzdPkCPBE2emBtdSRUDzFAkKb2MY+YCj
	CT5t7Pi72G7NVe4CvFzWe23ZKT9urk90XSIfQjL4axeQFgfgA3JgVRaJI/WmoKw9kJYpMVT4i/Z
	pZMQmkduquxvB8cCgAyCiZeWGQCSjXr/OJ9frutiXclEIEG4qQxRFUGKVnRYy914s4CTFNc/f+H
	KlslRzf1fmQ7wa6hawTygyWzj6LfiHQZh0S84VNdGMb0/I/NguL2sYTt2kHpKYbEOyJo3Zqs2G6
	aer8VyNOZfDRu8R/5CriTU1YQgU4cT7AoV8KJMSZEyRtSUnJwbsyelgoYOyWLlrPgf2gRaJykEh
	cmYnxD4sGr10oTVtrtKV2v2lqNrOweHUk0Xwy+7k8KNNEjs0ji
X-Received: by 2002:a05:6a21:4916:b0:35d:d477:a7d6 with SMTP id adf61e73a8af0-39467113b9fmr158618637.13.1770932083291;
        Thu, 12 Feb 2026 13:34:43 -0800 (PST)
Received: from honey-badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29979b13sm58728405ad.61.2026.02.12.13.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 13:34:42 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	kuba@kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 3/4] nfp: bpf: remove references to bpf_reg_state->off for pointers
Date: Thu, 12 Feb 2026 13:34:23 -0800
Message-ID: <20260212-ptrs-off-migration-v2-3-00820e4d3438@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260212-ptrs-off-migration-v2-0-00820e4d3438@gmail.com>
References: <20260212-ptrs-off-migration-v2-0-00820e4d3438@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Previous commit changed BPF verifier to track pointer offsets entirely
in bpf_reg_state->var_off. This commit removes references to
bpf_reg_state->off in netronome code.
- In most of the places `.off` field is used as a part of a sum:
  `reg->off + reg->var_off.value`. In such code the `reg->off` addend
  is removed.
- Function jit.c:cross_mem_access() uses `.off` but ignores `.var_off`
  to compute memory access offset. Here access to `.off` is replaced
  with access to `.var_off.value`. verifier.c:nfp_bpf_check_ptr()
  rejects programs for which !tnum_is_const(reg->var_off),
  so the above change will read a valid constant.
  Not sure why `.var_off` was ignored in this function previously.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 drivers/net/ethernet/netronome/nfp/bpf/jit.c      | 18 ++++++++----------
 drivers/net/ethernet/netronome/nfp/bpf/verifier.c | 12 ++++++------
 2 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/bpf/jit.c b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
index 3a02eef58cc6d977fcd130e0b69947deff468d3f..c9ab55abfd4c5d72e63f3f5b089915298a06c121 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/jit.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/jit.c
@@ -1731,7 +1731,7 @@ map_call_stack_common(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta)
 
 	/* We only have to reload LM0 if the key is not at start of stack */
 	lm_off = nfp_prog->stack_frame_depth;
-	lm_off += meta->arg2.reg.var_off.value + meta->arg2.reg.off;
+	lm_off += meta->arg2.reg.var_off.value;
 	load_lm_ptr = meta->arg2.var_off || lm_off;
 
 	/* Set LM0 to start of key */
@@ -2874,8 +2874,7 @@ mem_ldx(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
 	}
 
 	if (meta->ptr.type == PTR_TO_STACK)
-		return mem_ldx_stack(nfp_prog, meta, size,
-				     meta->ptr.off + meta->ptr.var_off.value);
+		return mem_ldx_stack(nfp_prog, meta, size, meta->ptr.var_off.value);
 
 	if (meta->ptr.type == PTR_TO_MAP_VALUE)
 		return mem_ldx_emem(nfp_prog, meta, size);
@@ -2985,8 +2984,7 @@ mem_stx(struct nfp_prog *nfp_prog, struct nfp_insn_meta *meta,
 		return mem_stx_data(nfp_prog, meta, size);
 
 	if (meta->ptr.type == PTR_TO_STACK)
-		return mem_stx_stack(nfp_prog, meta, size,
-				     meta->ptr.off + meta->ptr.var_off.value);
+		return mem_stx_stack(nfp_prog, meta, size, meta->ptr.var_off.value);
 
 	return -EOPNOTSUPP;
 }
@@ -4153,9 +4151,9 @@ cross_mem_access(struct bpf_insn *ld, struct nfp_insn_meta *head_ld_meta,
 	/* Canonicalize the offsets. Turn all of them against the original
 	 * base register.
 	 */
-	head_ld_off = head_ld_meta->insn.off + head_ld_meta->ptr.off;
-	head_st_off = head_st_meta->insn.off + head_st_meta->ptr.off;
-	ld_off = ld->off + head_ld_meta->ptr.off;
+	head_ld_off = head_ld_meta->insn.off + head_ld_meta->ptr.var_off.value;
+	head_st_off = head_st_meta->insn.off + head_st_meta->ptr.var_off.value;
+	ld_off = ld->off + head_ld_meta->ptr.var_off.value;
 
 	/* Ascending order cross. */
 	if (ld_off > head_ld_off &&
@@ -4326,7 +4324,7 @@ static void nfp_bpf_opt_pkt_cache(struct nfp_prog *nfp_prog)
 		 * support this.
 		 */
 		if (meta->ptr.id == range_ptr_id &&
-		    meta->ptr.off == range_ptr_off) {
+		    meta->ptr.var_off.value == range_ptr_off) {
 			s16 new_start = range_start;
 			s16 end, off = insn->off;
 			s16 new_end = range_end;
@@ -4361,7 +4359,7 @@ static void nfp_bpf_opt_pkt_cache(struct nfp_prog *nfp_prog)
 		range_node = meta;
 		range_node->pkt_cache.do_init = true;
 		range_ptr_id = range_node->ptr.id;
-		range_ptr_off = range_node->ptr.off;
+		range_ptr_off = range_node->ptr.var_off.value;
 		range_start = insn->off;
 		range_end = insn->off + BPF_LDST_BYTES(insn);
 	}
diff --git a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c b/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
index 9d235c0ce46a8149370131d4e7b403ad3224b955..2893be0f9f18c7084fd75c1c09a8dff298689f0c 100644
--- a/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
+++ b/drivers/net/ethernet/netronome/nfp/bpf/verifier.c
@@ -98,7 +98,7 @@ static bool nfp_bpf_map_update_value_ok(struct bpf_verifier_env *env)
 
 	offmap = map_to_offmap(reg1->map_ptr);
 	nfp_map = offmap->dev_priv;
-	off = reg3->off + reg3->var_off.value;
+	off = reg3->var_off.value;
 
 	for (i = 0; i < offmap->map.value_size; i++) {
 		struct bpf_stack_state *stack_entry;
@@ -137,7 +137,7 @@ nfp_bpf_stack_arg_ok(const char *fname, struct bpf_verifier_env *env,
 		return false;
 	}
 
-	off = reg->var_off.value + reg->off;
+	off = reg->var_off.value;
 	if (-off % 4) {
 		pr_vlog(env, "%s: unaligned stack pointer %lld\n", fname, -off);
 		return false;
@@ -147,7 +147,7 @@ nfp_bpf_stack_arg_ok(const char *fname, struct bpf_verifier_env *env,
 	if (!old_arg)
 		return true;
 
-	old_off = old_arg->reg.var_off.value + old_arg->reg.off;
+	old_off = old_arg->reg.var_off.value;
 	old_arg->var_off |= off != old_off;
 
 	return true;
@@ -358,8 +358,8 @@ nfp_bpf_check_stack_access(struct nfp_prog *nfp_prog,
 	if (meta->ptr.type == NOT_INIT)
 		return 0;
 
-	old_off = meta->ptr.off + meta->ptr.var_off.value;
-	new_off = reg->off + reg->var_off.value;
+	old_off = meta->ptr.var_off.value;
+	new_off = reg->var_off.value;
 
 	meta->ptr_not_const |= old_off != new_off;
 
@@ -428,7 +428,7 @@ nfp_bpf_map_mark_used(struct bpf_verifier_env *env, struct nfp_insn_meta *meta,
 		return -EOPNOTSUPP;
 	}
 
-	off = reg->var_off.value + meta->insn.off + reg->off;
+	off = reg->var_off.value + meta->insn.off;
 	size = BPF_LDST_BYTES(&meta->insn);
 	offmap = map_to_offmap(reg->map_ptr);
 	nfp_map = offmap->dev_priv;

-- 
2.51.1
