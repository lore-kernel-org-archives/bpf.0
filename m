Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5BA3D1CB2
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789946; cv=none; b=JSXlC+K585Z1ij0GYo8jkPPee9GRrc0zjEjX+UQsLEi83+onHxUwGnDMcjRO3oWFGZT2n1+YfHSKqCo0v6hJLxJII3tro576uZ4s6zIfAgEy7q+EPnePToUL+Sr1T9T22UQFkA7XzvOkatJneqvXb/gng99spFeXxLYjIIzxmCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789946; c=relaxed/simple;
	bh=benyx472flPqNvAVhS9wPHHgw7gw1r4W0RYNK+ewiX4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Sq63zgVzxJt+kCHvDnoeiJ6bfH4qiVrxAnlRZnTaQ3x7RKSsKIMELWIVfMk5Hl55qgo24rkkoqrmm1uBjEcysve/F5K38N3BatcCMJYhHekyxjdYv+yfAtGKkObHLGOfywLhyVaXawf0e/MMsA9gGbEoYHMi+3r23i7JgKW0MPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BFyYRTih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BFyYRTih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1BC1F000E9;
	Tue, 26 May 2026 10:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779789944;
	bh=hVei5D/DfvMo6kZRHijsxpcooA++lqDr+6kmxRHV7Lg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=BFyYRTihP1fNqv/lX9NXuivKtL7uFcvoxDdsS+wi7B+eBiKFvjfD7WL92WL+d7vuu
	 zN8PtDseD6sHMoBQrjIxIzEuMOYOQIcf/4TNUc8irC63dvW8ye/PKQQRVXbizAgpH3
	 a/fIUKV98h9Y7QvKXQIgllwv+Owj9XXPfrD7mOpDDmNRk3ZJUy5gbrlwAzK9SZF/7T
	 BoBIS7WhR1nnhvekw+vakBFNn2QW8LiTTvauTn6ayR/DFzsADL8ukWRRrWESeNvoj6
	 Rgm63DfztXn4vaMmOjs/zQqVqR0jfGBpKU9ThOz4bAZUpUUhAU4SpzilrOQZAkC37V
	 FgFzGHzlG3e8w==
Content-Type: multipart/mixed; boundary="===============1852973020380619788=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f2a61e399ccf5c0974341ec757dbb88c69f61840907aa0bd162564589ad2279b@mail.kernel.org>
In-Reply-To: <20260526-better-1m-reporting-v1-4-51e4f2c59780@gmail.com>
References: <20260526-better-1m-reporting-v1-4-51e4f2c59780@gmail.com>
Subject: Re: [PATCH RFC bpf-next 4/6] bpf: report hot simulated callchains when 1M instructions limit is met
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 10:05:44 +0000 (UTC)

--===============1852973020380619788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

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
>
>  /* Maximum variable offset umax_value permitted when resolving memory accesses.
>   * In practice this is far bigger than any realistic pointer offset; this limit
> @@ -660,6 +662,17 @@ struct bpf_loop {
>  	bool irreducible;
>  };
>
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
>
>  static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2b3584712ad2..8eb8f1ce17c7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17247,6 +17247,152 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
>  	return INSN_IDX_UPDATED;
>  }
>
> +static void compute_callchain(struct bpf_verifier_state *st, struct bpf_callchain *cc)
> +{
> +	int i;
> +
> +	cc->curframe = st->curframe;
> +	for (i = 0; i <= st->curframe; i++)
> +		cc->insn_idx[i] = bpf_frame_insn_idx(st, i);
> +}
> +
> +static int update_callchain_profile(struct bpf_verifier_env *env, struct bpf_verifier_state *st)
> +{
> +	struct bpf_callchain_entry *entry;
> +	struct bpf_callchain cc;
> +	u32 hash;
> +
> +	compute_callchain(st, &cc);
> +	hash = jhash2(cc.insn_idx, cc.curframe + 1, cc.curframe + 1);
> +	hash_for_each_possible(env->callchain_htab, entry, node, hash) {
> +		if (entry->cc.curframe == cc.curframe &&
> +		    !memcmp(entry->cc.insn_idx, cc.insn_idx, (cc.curframe + 1) * sizeof(u32))) {
> +			entry->count++;
> +			return 0;
> +		}
> +	}
> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);

Should this allocation use GFP_KERNEL_ACCOUNT instead?  Looking across
kernel/bpf/verifier.c, every other transient verifier allocation uses
GFP_KERNEL_ACCOUNT (see kzalloc_obj, kvzalloc_obj, krealloc, and
kvcalloc throughout the file).

The callchain hash entries have the same lifecycle as other verifier
data: attached to env->callchain_htab and freed at the end of
bpf_check().

Programs approaching the 1M instruction limit can generate many distinct
callchains sampled at force checkpoints and loop headers, so the
allocations could be substantial for memcg tracking.

> +	if (!entry)
> +		return -ENOMEM;
> +	entry->cc = cc;
> +	entry->count = 1;
> +	hash_add(env->callchain_htab, &entry->node, hash);
> +	return 0;
> +}

[ ... ]

> @@ -19673,6 +19826,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  		return -ENOMEM;
>
>  	env->bt.env = env;
> +	hash_init(env->callchain_htab);
>
>  	len = (*prog)->len;
>  	env->insn_aux_data =
> @@ -19945,6 +20099,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  	bpf_clear_insn_aux_data(env, 0, env->prog->len);
>  	vfree(env->insn_aux_data);
>  err_free_env:
> +	free_callchain_profile(env);
>  	bpf_stack_liveness_free(env);
>  	kvfree(env->cfg.insn_postorder);
>  	kvfree(env->scc_info);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26444655429
--===============1852973020380619788==--
