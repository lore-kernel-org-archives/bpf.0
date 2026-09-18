Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE1830CD9E
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789711133; cv=none; b=Vxtshv2usmII7QLe90NxhpG5iCfjxEtl+B298aywvl1bUITnmiFuKm2rDl7Ew6UrccE69IPo/IfkGItaE4xK5cqfw7X3WlRQzSs1cHWH0E344/WBfaml8mMe9EEpTOqohyYL5bjiLfm6HcZus0uINeruA18NP/o5vBkyDWjhg6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789711133; c=relaxed/simple;
	bh=rShJN6xbi+oBN30PnHM26xf2nKmLdLAf54UCO3dNgVo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pORtBc0WTN+RR6YV7ZlfeJSOBZxTqoV9CFsqbPhlW644xoM4kZeJjxjjCUzvhrdjDzB9eUHazUSLHERVg+AcSHCuBdx7x/q7PEnp+W2+FEoNRv/KjrQyV5XvO3rabB0PZlbUVmFCSwYJGnvhZQc0BBHO+YDGecnlKYmR6MzC9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED+JsUzM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED+JsUzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6B41F00893;
	Fri, 18 Sep 2026 05:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789711130;
	bh=DZWn6V4MlC73tG997FOqBMWV0y2yRKon4d2hOIiQVjg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ED+JsUzMBx2hS6QaM1pKtPD/fzzjxdZj4j4OkrYPU0Yx1thA3FgleG7OZU5nBJpa7
	 uyUM7TWwDcRad2gRwhEy5PafKn1wYmPjKB+IYCJBspkW7PZGqBnsm9RB3VFGONpZxt
	 zdAVedTbNanKu1w5XeEqFr+kR1bYWpRKhujQ6Pd7zCwgVXoav5FNw2Ms5QQBb9V+4V
	 jxqfLOfP3B22Ft99pqBfLtZiFhWEb09WqQuEOeLmPGQjuiiRH4m3v7dhyKlIy7b81u
	 ZI1o2diecp/sNGgZ18SLIZcAsYYK7XDrWiYMTT2nztiPXX7Rk2Qo06+7DD3VvIb4oy
	 h8lxVxudLu47w==
Content-Type: multipart/mixed; boundary="===============4784248139770594142=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eb5c029a500542566d71ececa22da94f0e301c49c95880bfec3fcc5f46c36ea4@mail.kernel.org>
In-Reply-To: <20260918044248.3289362-1-yonghong.song@linux.dev>
References: <20260918044248.3289362-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v2 10/20] bpf: Dispatch exception cleanup pads from bpf_throw()
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 05:58:49 +0000 (UTC)

--===============4784248139770594142==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> index b2bf831242b85..521086d084a35 100644
> --- a/kernel/bpf/exception.c
> +++ b/kernel/bpf/exception.c

[ ... ]

> +static int cmp_u32(const void *a, const void *b)
> +{
> +	u32 x = *(const u32 *)a, y = *(const u32 *)b;
> +
> +	return x < y ? -1 : x > y;
> +}

[ ... ]

> +/* Is @idx in the sorted array @at of @n instruction indices? */
> +static bool insn_idx_in(const u32 *at, u32 n, u32 idx)
> +{
> +	u32 l = 0, r = n;
> +
> +	while (l < r) {
> +		u32 m = l + (r - l) / 2;
> +
> +		if (idx < at[m])
> +			r = m;
> +		else if (idx > at[m])
> +			l = m + 1;
> +		else
> +			return true;
> +	}
> +	return false;
> +}

This isn't a bug, but could insn_idx_in() just use bsearch() from
<linux/bsearch.h>, reusing the cmp_u32() already defined above for the
sort()? kernel/bpf/fixups.c in this series uses bsearch() for similar
lookups.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index f120ae66dbbcb..134aafa6a6c9b 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c

[ ... ]

> @@ -1113,6 +1120,116 @@ static void bpf_restore_subprog_starts(struct bpf_verifier_env *env, u32 *orig_s
>  	env->subprog_info[env->subprog_cnt].start = env->prog->len;
>  }
>
> +static int cleanup_info_for_subprog(struct bpf_verifier_env *env, struct bpf_prog *sub,
> +				    u32 start, u32 end)
> +{
> +	struct bpf_cleanup_info *recs;
> +	u32 i, cnt = 0;
> +	int err;
> +
> +	if (!env->cleanup_info_cnt)
> +		return 0;
> +
> +	err = bpf_cleanup_alloc_info(sub->aux);
> +	if (err)
> +		return err;
> +
> +	err = cleanup_throw_sites_for_subprog(env, sub, start, end);
> +	if (err)
> +		return err;
> +
> +	err = cleanup_pad_body_for_subprog(env, sub, start, end);
> +	if (err)
> +		return err;
> +
> +	for (i = start; i < end; i++)
> +		if (env->insn_aux_data[i].cleanup_pad)
> +			cnt++;
> +	if (!cnt)
> +		return 0;
> +
> +	recs = kvmalloc_array(cnt, sizeof(*recs), GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
> +	if (!recs)
> +		return -ENOMEM;
> +
> +	for (i = start, cnt = 0; i < end; i++) {
> +		u32 pad = env->insn_aux_data[i].cleanup_pad;
> +
> +		if (!pad)
> +			continue;
> +		pad--;
> +		if (verifier_bug_if(pad < start || pad >= end, env,
> +				    "insn %u is covered by a landing pad at %u outside its subprog [%u, %u)",
> +				    i, pad, start, end)) {
> +			kvfree(recs);
> +			return -EFAULT;
> +		}
> +		recs[cnt].begin_off = i - start;
> +		recs[cnt].end_off = i - start + 1;
> +		recs[cnt].landing_pad_off = pad - start;
> +		cnt++;
> +	}
> +	return bpf_cleanup_attach_info(sub->aux, recs, cnt);
> +}

[ ... ]

>  static int jit_subprogs(struct bpf_verifier_env *env)
>  {
>  	struct bpf_prog *prog = env->prog, **func, *tmp;

[ ... ]

> @@ -1250,6 +1367,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
>  		func[i]->aux->token = prog->aux->token;
>  		if (!i)
>  			func[i]->aux->exception_boundary = env->seen_exception;
> +		err = cleanup_info_for_subprog(env, func[i], subprog_start,
> +					       env->subprog_info[i + 1].start);

This isn't a bug, but would passing subprog_end (already computed a few
lines above from env->subprog_info[i + 1].start) be clearer here? It
keeps the cleanup table's end bound explicitly tied to the same value
jit_subprogs() uses for func[i]->len.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35308528711
--===============4784248139770594142==--
