Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8502813D886
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780343451; cv=none; b=CdoXuayQWyP5dPsEq/juvZEdt0u1Rm268w2RBVXRuUdzxffNTZq03GjHwuOvx4DlhnltDVu1a4nd91CMCQCc/c+XTxVt+aGKxz12f8JJoj7sSQIDAcYmXEX7g37d3FJt/mr+MaOtxcdyDuHrwJ8kTTzoxE++woJc7XtqEm9dkGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780343451; c=relaxed/simple;
	bh=f/ewhjMwm2hIao1KAEdzFH5LROA28ARwURFT+vsDrpY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EMOGHu/YI1Hqk94xSXho51NOfZ22AAPlIqHvDOFQTJ2rjbwUDoUiGzfV6f6pR6dgo/qgaOBO5AtiCXCmxUMyysFcFL1qDvumG7f0uVpLZSkoUISsltGOX3Ta70eP/H1RAESkCjKfub9rm/O8lR0c41p+sOvMu/GCyhnsVc4yvtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=GVHhbOn5; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="GVHhbOn5"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-132d1b2519eso15666438c88.0
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780343449; x=1780948249; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0LSFJgKtr452ZfbFSfm0cpbFppmQIZm1Kgul++1qzw=;
        b=GVHhbOn5Zun8cjTTHV0DrWShHrHEtB5MCQGLeE5Sws8OLmNMEUHFSVmFwDxtvpCWyv
         dWpWGFMnDIPm9T+0vHU2zVV9dPkiRjf5O7CW3FB30UxgIfUyscC0c+Nve/x5MpQB6xOL
         xlrvxm+yQSAldOCmPbBCuFx2QRXs64aCWW5bjQWf5DrU4nxnte+CoPe1j+6aX+OXs0Ch
         3OlziJXOYUwz/99/+MWwgJyQfCsPN5Uc7PS79V+Z2z4SwqWr0VfWnj6kG0VddvPUuqtB
         LODKKPU+b8GUZNVm7UC7sbIRpTgXtPBLMTIfB5SraYQk19/C7blcFzRNzz7YB8mHKfW7
         0MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780343449; x=1780948249;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h0LSFJgKtr452ZfbFSfm0cpbFppmQIZm1Kgul++1qzw=;
        b=m5Qf4J17fasS6PDThwwnFYj5La2rJGlVS/cGCx15nq3CgGFKzHpgPzYTp3vLU0Orfn
         MWlLCvl9WiLXj6tXrsKzi3J4u0+vYGqA8gvYOa0YEPqroFFDbJGhNY8crx5azHSU7Hnj
         vgOz1hWAvJ9yjPZgF8fAVIFCGtUMe87T5Hyoqx+2chCDMtAgxiiwb6ojgsa0nS5C0cmI
         FVDMC4a4rPzgFP8nCCrjS3ugGzCSn4+rZFVIVop9/MiK3ueSG3PmLRAFBajDYeZEpzIq
         9ZpKaLoGPr7oe92weTidb3UZjaNi0OgAaYmVYmk9eCxwo8Gl6clJ/K05FLVGL68P9Q7c
         is6w==
X-Forwarded-Encrypted: i=1; AFNElJ/3iAbFZfnNA+XqzErx/jU/tdfp5eKTU50ZazKsv15I5IfkxW8j3eTbflsBkCTmNgSAQ1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRIH96eUnCcy03Ozb5IJ3lbKuoC4zm5jld5c1BvNQaeiZXKb8e
	ZcOD8oUKvX3tGGCEZF7BVRAENG0UHx2kkUJVtQ1q7BKSHsuitehdEyHS5ZQLjMkss/Q=
X-Gm-Gg: Acq92OE8Jm5wyBMDnseVfiTVmKbaY4VCCABJf6kplzMWTAKqQWCxdDyghXz+6Rq1UIV
	4dD4fWczvyPcq7NH+nbZ8YUV1qrvuSyr6FOVEKJQwzPDhRWxpZCP5ncuwzqOcptqEpCkIOvACod
	ift2pYg16qV6qKX66pH1SgjR3+D0ai1qQn9l+l8sr7emrv0nbxRoy68UOnSSLVydZNi3kO4HjFu
	9vO8hM9cVjuK8MQL3ArxN+Xr/xrWGss6I04a7rLW0LUVjDrAh7kx9QUtuGDj5FDbTHoJafjpA9E
	z8AXowiPiLKZECmSKes2rPmNu8eq8purylHrrKuajIs+HuLLsHAy0hy8hSA0ObZBwkjhokhKTBz
	AF4FNwWDWOa/tQYrQNh5tHwTzlbs0Wr4w7L8lqMq5qsOMBya8LjBc6Lutdv9x7si8bpQXbP418K
	1jXhwb7WULYtTyHKI=
X-Received: by 2002:a05:7300:4312:b0:304:819f:502b with SMTP id 5a478bee46e88-304fa55d9acmr6416384eec.9.1780343448261;
        Mon, 01 Jun 2026 12:50:48 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::ceef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed53f002sm10022671eec.18.2026.06.01.12.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 12:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jun 2026 15:50:45 -0400
Message-Id: <DIXZ2VPVZP94.ACM1OJMPGF4V@etsalapatis.com>
Cc: <andrii@kernel.org>, <daniel@iogearbox.net>, <martin.lau@linux.dev>,
 <kernel-team@fb.com>, <yonghong.song@linux.dev>
Subject: Re: [PATCH RFC bpf-next v3 4/6] bpf: report hot simulated
 callchains when 1M instructions limit is met
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260527-better-1m-reporting-v3-0-b3ede0588a75@gmail.com>
 <20260527-better-1m-reporting-v3-4-b3ede0588a75@gmail.com>
In-Reply-To: <20260527-better-1m-reporting-v3-4-b3ede0588a75@gmail.com>

On Wed May 27, 2026 at 3:29 AM EDT, Eduard Zingerman wrote:
> When the verifier exceeds the 1M instruction budget, the current error
> output shows a random execution trace that happens to be active when
> the limit is hit, which is not very helpful for debugging.
>
> To rectify this, employ a profiler-inspired technique:
> collect and count "callchain" stack traces that the verifier visits
> during program validation and report the top 3 hot traces. Sample
> callchains at instructions marked as force checkpoints and loop header
> entries.
>
> When 1M instructions is met, print a report containing:
> - callchains verifier visited most often;
> - disassembly of the subprograms referenced from the printed
>   callchains.
>
> Here is an example of the report:
>
>   budget_nested_call_loop():
>     ; asm volatile ("                                     \ @ verifier_bu=
dget_report.c:44
>     0: (b7) r0 =3D 0
>     1: (85) call pc+1
>     2: (95) exit
>
>   budget_nested_call_loop__inner():
>     ; asm volatile ("                                     \ @ verifier_bu=
dget_report.c:54
>     3: (b7) r0 =3D 0
>     4: (07) r0 +=3D 1
>     5: (05) goto pc-2
>
>   #1 most visited simulated stacktrace (visited 499999 times):
>     budget_nested_call_loop/1 (.../verifier_budget_report.c:44)
>     budget_nested_call_loop__inner/4 (.../verifier_budget_report.c:54)
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Minor suggestion: Can we make the N of top-N a #define for clarity and=20
to make it easy to change during hacking?

> ---
>  include/linux/bpf_verifier.h |  14 ++++
>  kernel/bpf/verifier.c        | 155 +++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 169 insertions(+)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index d0a1fb135cbf..347a155d8e21 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -9,6 +9,8 @@
>  #include <linux/filter.h> /* for MAX_BPF_STACK */
>  #include <linux/tnum.h>
>  #include <linux/cnum.h>
> +#include <linux/hashtable.h>
> +#include <linux/jhash.h>
> =20
>  /* Maximum variable offset umax_value permitted when resolving memory ac=
cesses.
>   * In practice this is far bigger than any realistic pointer offset; thi=
s limit
> @@ -660,6 +662,17 @@ struct bpf_loop {
>  	bool irreducible;
>  };
> =20
> +struct bpf_callchain {
> +	u32 insn_idx[MAX_CALL_FRAMES];
> +	u32 curframe;
> +};
> +
> +struct bpf_callchain_entry {
> +	struct hlist_node node;
> +	struct bpf_callchain cc;
> +	u64 count;
> +};
> +
>  struct bpf_insn_aux_data {
>  	union {
>  		enum bpf_reg_type ptr_type;	/* pointer type for load/store insns */
> @@ -1043,6 +1056,7 @@ struct bpf_verifier_env {
>  	u32 scc_cnt;
>  	struct bpf_iarray *succ;
>  	struct bpf_iarray *gotox_tmp_buf;
> +	DECLARE_HASHTABLE(callchain_htab, 8);
>  };
> =20
>  static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_=
env *env, int subprog)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2b3584712ad2..54b7ad65b7fc 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17247,6 +17247,152 @@ static int check_indirect_jump(struct bpf_verif=
ier_env *env, struct bpf_insn *in
>  	return INSN_IDX_UPDATED;
>  }
> =20
> +static void compute_callchain(struct bpf_verifier_state *st, struct bpf_=
callchain *cc)
> +{
> +	int i;
> +
> +	cc->curframe =3D st->curframe;
> +	for (i =3D 0; i <=3D st->curframe; i++)
> +		cc->insn_idx[i] =3D bpf_frame_insn_idx(st, i);
> +}
> +
> +static int update_callchain_profile(struct bpf_verifier_env *env, struct=
 bpf_verifier_state *st)
> +{
> +	struct bpf_callchain_entry *entry;
> +	struct bpf_callchain cc =3D {};
> +	u32 hash;
> +
> +	compute_callchain(st, &cc);
> +	hash =3D jhash2(cc.insn_idx, cc.curframe + 1, cc.curframe + 1);
> +	hash_for_each_possible(env->callchain_htab, entry, node, hash) {
> +		if (entry->cc.curframe =3D=3D cc.curframe &&
> +		    !memcmp(entry->cc.insn_idx, cc.insn_idx, (cc.curframe + 1) * sizeo=
f(u32))) {
> +			entry->count++;
> +			return 0;
> +		}
> +	}
> +	entry =3D kzalloc(sizeof(*entry), GFP_KERNEL_ACCOUNT);
> +	if (!entry)
> +		return -ENOMEM;
> +	entry->cc =3D cc;
> +	entry->count =3D 1;
> +	hash_add(env->callchain_htab, &entry->node, hash);
> +	return 0;
> +}
> +
> +static void free_callchain_profile(struct bpf_verifier_env *env)
> +{
> +	struct bpf_callchain_entry *entry;
> +	struct hlist_node *tmp;
> +	int bkt;
> +
> +	hash_for_each_safe(env->callchain_htab, bkt, tmp, entry, node) {
> +		hash_del(&entry->node);
> +		kfree(entry);
> +	}
> +}
> +
> +static void print_callchain_entry(struct bpf_verifier_env *env,
> +				  struct bpf_callchain_entry *entry, int idx)
> +{
> +	struct bpf_callchain *cc =3D &entry->cc;
> +	const struct bpf_line_info *linfo;
> +	struct bpf_subprog_info *sub;
> +	int i, insn_idx;
> +
> +	verbose(env, "#%d most visited simulated stacktrace (visited %llu times=
):\n",
> +		idx, entry->count);
> +	for (i =3D 0; i <=3D cc->curframe; i++) {
> +		insn_idx =3D cc->insn_idx[i];
> +		sub =3D bpf_find_containing_subprog(env, insn_idx);
> +		linfo =3D bpf_find_linfo(env->prog, insn_idx);
> +		if (sub->name)
> +			verbose(env, "  %s/%d", sub->name, insn_idx);
> +		else
> +			verbose(env, "  subprog#%td/%d", sub - env->subprog_info, insn_idx);
> +		if (linfo)
> +			verbose(env, " (%s:%u)",
> +				btf_name_by_offset(env->prog->aux->btf, linfo->file_name_off),
> +				BPF_LINE_INFO_LINE_NUM(linfo->line_col));
> +		verbose(env, "\n");
> +	}
> +}
> +
> +static void disasm_subprog(struct bpf_verifier_env *env, struct bpf_subp=
rog_info *sub)
> +{
> +	u32 i, end =3D (sub + 1)->start;
> +
> +	if (sub->name)
> +		verbose(env, "%s():\n", sub->name);
> +	else
> +		verbose(env, "subprog#%td:\n", sub - env->subprog_info);
> +	env->prev_linfo =3D NULL;
> +	for (i =3D sub->start; i < end; i++) {
> +		verbose_linfo(env, i, "  ; ");
> +		verbose(env, "  %d: ", i);
> +		bpf_verbose_insn(env, &env->prog->insnsi[i]);
> +		if (bpf_is_ldimm64(&env->prog->insnsi[i]))
> +			i++;
> +	}
> +}
> +
> +/*
> + * Print several most visited simulated stack traces,
> + * and a disasembly of related subprograms.
> + */
> +static void print_hotspots(struct bpf_verifier_env *env)
> +{
> +	DECLARE_BITMAP(printed_subs, BPF_MAX_SUBPROGS + 2) =3D {};
> +	struct bpf_callchain_entry *top[3] =3D {};
> +	struct bpf_callchain_entry *entry;
> +	struct bpf_subprog_info *sub;
> +	int i, j, bkt, nr_top =3D 0;
> +
> +	if (!(env->log.level & BPF_LOG_LEVEL))
> +		return;
> +
> +	/* Collect the hottest callchains */
> +	hash_for_each(env->callchain_htab, bkt, entry, node) {
> +		for (i =3D 0; i < 3; i++) {
> +			if (!top[i] || entry->count > top[i]->count) {
> +				memmove(&top[i + 1], &top[i], (2 - i) * sizeof(top[0]));
> +				top[i] =3D entry;
> +				break;
> +			}
> +		}
> +	}
> +
> +	for (i =3D 0; i < 3 && top[i]; i++)
> +		nr_top++;
> +
> +	if (!nr_top)
> +		return;
> +
> +	if (!(env->log.level & BPF_LOG_LEVEL2))
> +		bpf_vlog_reset(&env->log, 0);
> +
> +	/* Identify callchain subprograms and print disasm of those */
> +	for (i =3D 0; i < nr_top; i++) {
> +		struct bpf_callchain *cc =3D &top[i]->cc;
> +
> +		for (j =3D 0; j <=3D cc->curframe; j++) {
> +			sub =3D bpf_find_containing_subprog(env, cc->insn_idx[j]);
> +			__set_bit(sub - env->subprog_info, printed_subs);
> +		}
> +	}
> +
> +	for_each_set_bit(i, printed_subs, env->subprog_cnt) {
> +		disasm_subprog(env, &env->subprog_info[i]);
> +		verbose(env, "\n");
> +	}
> +
> +	/* Print the hot callchains */
> +	for (i =3D 0; i < nr_top; i++) {
> +		print_callchain_entry(env, top[i], i + 1);
> +		verbose(env, "\n");
> +	}
> +}
> +
>  static int do_check_insn(struct bpf_verifier_env *env, bool *do_print_st=
ate)
>  {
>  	int err;
> @@ -17381,6 +17527,7 @@ static int do_check(struct bpf_verifier_env *env)
>  		insn_aux =3D &env->insn_aux_data[env->insn_idx];
> =20
>  		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
> +			print_hotspots(env);
>  			verbose(env,
>  				"BPF program is too large. Processed %d insn\n",
>  				env->insn_processed);
> @@ -17390,6 +17537,12 @@ static int do_check(struct bpf_verifier_env *env=
)
>  		state->last_insn_idx =3D env->prev_insn_idx;
>  		state->insn_idx =3D env->insn_idx;
> =20
> +		if (bpf_is_force_checkpoint(env, env->insn_idx) || insn_aux->loop) {
> +			err =3D update_callchain_profile(env, state);
> +			if (err)
> +				return err;
> +		}
> +
>  		if (bpf_is_prune_point(env, env->insn_idx)) {
>  			err =3D bpf_is_state_visited(env, env->insn_idx);
>  			if (err < 0)
> @@ -19673,6 +19826,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr,
>  		return -ENOMEM;
> =20
>  	env->bt.env =3D env;
> +	hash_init(env->callchain_htab);
> =20
>  	len =3D (*prog)->len;
>  	env->insn_aux_data =3D
> @@ -19945,6 +20099,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_a=
ttr *attr, bpfptr_t uattr,
>  	bpf_clear_insn_aux_data(env, 0, env->prog->len);
>  	vfree(env->insn_aux_data);
>  err_free_env:
> +	free_callchain_profile(env);
>  	bpf_stack_liveness_free(env);
>  	kvfree(env->cfg.insn_postorder);
>  	kvfree(env->scc_info);

