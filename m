Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2DD402420
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773345936; cv=none; b=hXg5QLwwN6VwD5ObTA/4D1LDeFawwQ0FL2ndi+yZX2mm9jYOL9V9eS4R5U4grv4501iH7kLi1Z6FrBjOVzjMIoQoKdjSSpBmKuCM5YuXQczb2hx2NEvEQjQ+XQm4dkuhKPekwIWCBrGWdcV7br8TKhACDd5aklbyncnW88IE1ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773345936; c=relaxed/simple;
	bh=SbCMd9J/5aAG20UA/dwSxvRfJB1OkV8K+RI5T2DbYZo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=SZXQWo8/IClYeO7SZHe1AYCoKN3cN5XCIGA/3fvJqQJjzuxOctHokBSY3+u9fiaxYl0/tT2wrUgGftfpSUIAUBszQbvVa6L4jl6lthqNhlQdgLzqE+Kti2X7j3adHNJFH4BCYtJ/QL+OVfbzTTacoMEI9iv4714zzA4mizmAM90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5cMx4rn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5cMx4rn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C8AC2BC86;
	Thu, 12 Mar 2026 20:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773345936;
	bh=SbCMd9J/5aAG20UA/dwSxvRfJB1OkV8K+RI5T2DbYZo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=S5cMx4rnkosn0RlD8S62hAz9mWlk5lZPJ64e1wb2/gJDolDnura/VEKvxruaZge2v
	 KtRQuwrJrukS0ou6oc4RP0rn59c24iVb+Ox0XS1IJhMtYr7HgiYHh2ec+PyltOsDAp
	 Mhmvy7OMhCuvStdaI4xcI23LPGOqK+C+V/5yqWGbETQhdDxTO04ehxaHUqSb4xz1yz
	 0kdql8NlY64wqr0MnFl7zLZa8JFZvlh0RJbPHHeDtgLBgSSPEYXB+5qwENJcQfhdun
	 hlRATod6w1sRkOb+xJe5l2zck9AksOstFuibaIRL/2tjyYtDakH5jv1PQmqwHJQHsh
	 uivUln/R7Uc/Q==
Content-Type: multipart/mixed; boundary="===============1875425474761963885=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4641dd98f7a3a4f162c24c53e0b246ec5017d79b67cdf93486db2583039f24b2@mail.kernel.org>
In-Reply-To: <20260312193546.192786-1-ihor.solodrai@linux.dev>
References: <20260312193546.192786-1-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Support struct btf_struct_meta via KF_IMPLICIT_ARGS
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com
Cc: alexis.lothore@bootlin.com,bpf@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 12 Mar 2026 20:05:36 +0000 (UTC)

--===============1875425474761963885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index cb6d242bd093..e5c8fb6596e7 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> +__bpf_kfunc void *bpf_percpu_obj_new(u64 local_type_id__k, struct btf_struct_meta *meta)
> +{
> +	u64 size = local_type_id__k;
> +
> +	/* The verifier has ensured that meta__ign must be NULL */
> +	return bpf_mem_alloc(&bpf_global_percpu_ma, size);
> +}

The parameter here is named "meta", not "meta__ign". Should this
comment say "meta" instead?

[ ... ]

> +__bpf_kfunc void bpf_percpu_obj_drop(void *p__alloc, struct btf_struct_meta *meta)
> +{
> +	/* The verifier has ensured that meta__ign must be NULL */
> +	bpf_mem_free_rcu(&bpf_global_percpu_ma, p__alloc);
> +}

Same here -- the comment references "meta__ign" but the parameter is
"meta".

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 4fbacd2149cd..2e4f1e9b1d37 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -13575,12 +13658,12 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
>  			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
> -				if (meta->func_id != special_kfunc_list[KF_bpf_obj_drop_impl]) {
> +				if (!is_bpf_obj_drop_kfunc(meta->func_id)) {
>  					verbose(env, "arg#%d expected for bpf_obj_drop_impl()\n", i);
>  					return -EINVAL;
>  				}
>  			} else if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU)) {
> -				if (meta->func_id != special_kfunc_list[KF_bpf_percpu_obj_drop_impl]) {
> +				if (!is_bpf_percpu_obj_drop_kfunc(meta->func_id)) {
>  					verbose(env, "arg#%d expected for bpf_percpu_obj_drop_impl()\n", i);
>  					return -EINVAL;
>  				}

The conditions now match both bpf_obj_drop and bpf_obj_drop_impl (and
their percpu variants), but the error messages still reference only
the _impl names. Would it make sense to update these to say
"bpf_obj_drop" and "bpf_percpu_obj_drop" respectively, so that a
developer calling the new variants sees the right function name in
the error?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23020502189
--===============1875425474761963885==--
