Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB0A3E1680
	for <bpf@vger.kernel.org>; Mon, 13 Jul 2026 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957243; cv=none; b=t5kLsDLsKVYNNHapABz+YGWodQrVodYx4A0IdbHW6QS3dK9G3Nal2Jt6qwPDdk2Kn/leBdOeFlj94uWi08coXPemyEq4ZDG7zf7xrewp0ah0VNmkZC0ZDD72mTuECb3lZkLckB7zdKiAhowtoPho0XF6arqZj2CDEkyjfXRIauo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957243; c=relaxed/simple;
	bh=HxWQqAWEXGvBemAMe9Iz9nZLvBvWd3r/qm/dPlfaRL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxMpH8nVJ4TagTb559RUFA7uzaSop7sIum4M7GfH5930b3CrpCz6CKLzOjJB/DpBJ7Z8vuBxLkYbpvPorhCdzezTb5kG/0hZQIY8YNSfUqncyxvznbLso1yFpch8CIIG7T0wqf35YZ9EpMBBpypzOc4sd/h5ZRM+jUhOctTUnoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=USlJqVxj; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="USlJqVxj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783957240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XaqYoSTHegTYHmfZKuxLnj0GEL9ZknWZa8BMGTCX7YE=;
	b=USlJqVxj/85XE2ioXOiZsF+9CKJbFaRzrdJQX9RRs5Q+dmj1MB/1zXkG+If883GuRk2jOA
	Cdbuxy8ft7yFnfcEVFdewZOXElF3n/o4kjFqfhhKwr1G/gVtF0zcCfytO5K/kUl6z6zmvd
	zw22S6tTxwnGOZqRscfFc7EzBgdmgfw=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next v9 1/9] bpf: Drop duplicate blank lines in verifier
Date: Mon, 13 Jul 2026 23:40:16 +0800
Message-ID: <20260713154024.30851-2-leon.hwang@linux.dev>
In-Reply-To: <20260713154024.30851-1-leon.hwang@linux.dev>
References: <20260713154024.30851-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

There are many adjacent blank lines in the verifier that have accumulated
over time.

Drop them for cleanup.

No functional changes intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 03e2202cca13..b5666a75a273 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -655,7 +655,6 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg,
 			      enum bpf_dynptr_type type,
 			      bool first_slot, int id, int parent_id);
 
-
 static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *sreg1,
 				   struct bpf_reg_state *sreg2,
@@ -1692,7 +1691,6 @@ static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_sta
 	return true;
 }
 
-
 void bpf_free_backedges(struct bpf_scc_visit *visit)
 {
 	struct bpf_scc_backedge *backedge, *next;
@@ -2312,7 +2310,6 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	return &elem->st;
 }
 
-
 static int cmp_subprogs(const void *a, const void *b)
 {
 	return ((struct bpf_subprog_info *)a)->start -
@@ -4065,7 +4062,6 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	return err;
 }
 
-
 /* check_stack_write dispatches to check_stack_write_fixed_off or
  * check_stack_write_var_off.
  *
@@ -4861,7 +4857,6 @@ static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
 		valid = false;
 	}
 
-
 	if (valid) {
 		env->insn_aux_data[insn_idx].ctx_field_size =
 			info.ctx_field_size;
@@ -6702,7 +6697,6 @@ static int check_stack_range_initialized(
 	if (err)
 		return err;
 
-
 	if (tnum_is_const(reg->var_off)) {
 		min_off = max_off = reg->var_off.value + off;
 	} else {
@@ -7416,7 +7410,6 @@ static bool is_iter_new_kfunc(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_ITER_NEW;
 }
 
-
 static bool is_iter_destroy_kfunc(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_ITER_DESTROY;
@@ -11562,7 +11555,6 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 	return 0;
 }
 
-
 static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct btf_record *rec = reg_btf_record(reg);
@@ -16465,7 +16457,6 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	return 0;
 }
 
-
 static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
@@ -18407,8 +18398,6 @@ static void release_insn_arrays(struct bpf_verifier_env *env)
 		bpf_insn_array_release(env->insn_array_maps[i]);
 }
 
-
-
 /* The verifier does more data flow analysis than llvm and will not
  * explore branches that are dead at run time. Malicious programs can
  * have dead code too. Therefore replace all dead at-run-time code
@@ -18436,8 +18425,6 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
 	}
 }
 
-
-
 static void free_states(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state_list *sl;
@@ -18719,7 +18706,6 @@ static int do_check_main(struct bpf_verifier_env *env)
 	return ret;
 }
 
-
 static void print_verification_stats(struct bpf_verifier_env *env)
 {
 	/* Skip over hidden subprogs which are not verified. */
-- 
2.55.0

