Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5243ACEF1
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139020; cv=none; b=WBhk2UB+x+A/2sxGnhp71QBdEzXRU8vVxyDvMLyJ5ElAaIOiRgviDOqMeUkrhpIkVIqU9vMjfPLqrCNrk6FRF9kNJGYN4BFlYIB/BYJ1del7oA0dp7TjNpc4sinL9tmKe9syzRzMWeMdTFpBQfBNXWrbiDPx+gsU2Dk21gg1bEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139020; c=relaxed/simple;
	bh=fjZudWesO1UlAp53hzZRyS8evEAa3LCYMqIqufGTmHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUkWJAvQVeP0oN9Xka398ynL6MNw2gqi2EmikFG1bNoRj97wyc6Aa5tjpfEEo2ZTJTMuWu+UqXbQGPuXW/2VAYF6u3fJt1gklkDpz4XQ6GKT/ME48IlrdcuxhBk32BjTwut54riVcnqpD3psWaWASc6olid8Yhxxj2X89LPFSFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iGYd0Gup; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iGYd0Gup"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782139016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E68CDBhjchU1RM2SbBPGlwnnz5USBgSAl5d6YNwvDtE=;
	b=iGYd0Gupushm0yTVKwvuAdUg8r8ex6U8KwseQ2zvQ6KsNTOgSPMkZcZytIznluxRd25yaU
	uzrK+XIQvCBHWoykrvBtyFVa6kxcrl80JVhIi+eKuZ4gILxEPdmIeQcl/AI/sS5qMuNViK
	pq/FzEs3/R5uwzC8bvUUPtPVCSQz5hM=
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
Subject: [PATCH bpf-next v7 01/11] bpf: Drop duplicate blank lines in verifier
Date: Mon, 22 Jun 2026 22:35:47 +0800
Message-ID: <20260622143557.22955-2-leon.hwang@linux.dev>
In-Reply-To: <20260622143557.22955-1-leon.hwang@linux.dev>
References: <20260622143557.22955-1-leon.hwang@linux.dev>
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
 kernel/bpf/verifier.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2abc79dbf281..721f883bf640 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -652,7 +652,6 @@ static void __mark_dynptr_reg(struct bpf_reg_state *reg,
 			      enum bpf_dynptr_type type,
 			      bool first_slot, int id, int parent_id);
 
-
 static void mark_dynptr_stack_regs(struct bpf_verifier_env *env,
 				   struct bpf_reg_state *sreg1,
 				   struct bpf_reg_state *sreg2,
@@ -1689,7 +1688,6 @@ static bool same_callsites(struct bpf_verifier_state *a, struct bpf_verifier_sta
 	return true;
 }
 
-
 void bpf_free_backedges(struct bpf_scc_visit *visit)
 {
 	struct bpf_scc_backedge *backedge, *next;
@@ -2309,7 +2307,6 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
 	return &elem->st;
 }
 
-
 static int cmp_subprogs(const void *a, const void *b)
 {
 	return ((struct bpf_subprog_info *)a)->start -
@@ -3331,7 +3328,6 @@ static bool is_spillable_regtype(enum bpf_reg_type type)
 	}
 }
 
-
 /* check if register is a constant scalar value */
 static bool is_reg_const(struct bpf_reg_state *reg, bool subreg32)
 {
@@ -3993,7 +3989,6 @@ static int check_stack_read(struct bpf_verifier_env *env,
 	return err;
 }
 
-
 /* check_stack_write dispatches to check_stack_write_fixed_off or
  * check_stack_write_var_off.
  *
@@ -4788,7 +4783,6 @@ static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
 		valid = false;
 	}
 
-
 	if (valid) {
 		env->insn_aux_data[insn_idx].ctx_field_size =
 			info.ctx_field_size;
@@ -6608,7 +6602,6 @@ static int check_stack_range_initialized(
 	if (err)
 		return err;
 
-
 	if (tnum_is_const(reg->var_off)) {
 		min_off = max_off = reg->var_off.value + off;
 	} else {
@@ -7322,7 +7315,6 @@ static bool is_iter_new_kfunc(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->kfunc_flags & KF_ITER_NEW;
 }
 
-
 static bool is_iter_destroy_kfunc(struct bpf_kfunc_call_arg_meta *meta)
 {
 	return meta->kfunc_flags & KF_ITER_DESTROY;
@@ -11465,7 +11457,6 @@ static int process_irq_flag(struct bpf_verifier_env *env, struct bpf_reg_state *
 	return 0;
 }
 
-
 static int ref_set_non_owning(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
 {
 	struct btf_record *rec = reg_btf_record(reg);
@@ -16357,7 +16348,6 @@ static int check_ld_abs(struct bpf_verifier_env *env, struct bpf_insn *insn)
 	return 0;
 }
 
-
 static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_range *range)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
@@ -18251,8 +18241,6 @@ static void release_insn_arrays(struct bpf_verifier_env *env)
 		bpf_insn_array_release(env->insn_array_maps[i]);
 }
 
-
-
 /* The verifier does more data flow analysis than llvm and will not
  * explore branches that are dead at run time. Malicious programs can
  * have dead code too. Therefore replace all dead at-run-time code
@@ -18280,8 +18268,6 @@ static void sanitize_dead_code(struct bpf_verifier_env *env)
 	}
 }
 
-
-
 static void free_states(struct bpf_verifier_env *env)
 {
 	struct bpf_verifier_state_list *sl;
@@ -18563,7 +18549,6 @@ static int do_check_main(struct bpf_verifier_env *env)
 	return ret;
 }
 
-
 static void print_verification_stats(struct bpf_verifier_env *env)
 {
 	/* Skip over hidden subprogs which are not verified. */
-- 
2.54.0

