Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845637D131
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773876601; cv=none; b=Q8kx0zZbjkHdFHjyf0Y0zdVFlyqwBChsnBnD0OQX8I1WyEj8OQJmDnL0hq5+ROL5ufFJ1T3DL3yIsTFSODvHvJpnV2bEUTdWzCFa0V3wnKtA1A0yAGglABms/NKUixkefhxAkUKrHYKjnjHbBzp7S9CQKSu3Nmpuz9Tz7SI23hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773876601; c=relaxed/simple;
	bh=a3mdlRLM1/KxTpd/24HQrGXTTgWxW0cXMBzgoxkGiZo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=bG3STjOYMCQ61eVvBZotzKK07eqmJjkdWchnOGnyvIbc+TK74NS4u0KYo1lQ02FNx6rGEINtTKlRTFixppUCv79PJbL0XqhYJs7wNoWjFYAmFsRBvWn7N633UNZdn9ARZpAXaXzdyv/eS6Nm7hVfoc7lEKnlDEQPMeJfmwRFYKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nm6raISZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nm6raISZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978AFC19421;
	Wed, 18 Mar 2026 23:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773876601;
	bh=a3mdlRLM1/KxTpd/24HQrGXTTgWxW0cXMBzgoxkGiZo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=nm6raISZHjmS0ITaB8NWW/EV8rVsZV8XHW0JFXgAGqqPtNFJkj4g+MSRF6a3KHHSI
	 fi/cT9P2H9pJftOlDhLU+IW+7CPSKlndz36x/ruyUdiS1XxO4xRnZJr2bPTtr9zfZ1
	 ZRoIUffQ1iapMFTBbZV4G9RzN61IsIImA6z00auS4qLphJvpYQGudt2hdi2tCPB1jT
	 cl7SP2atd5xacLgRPb/80qBOUizq9WZGPhOIyHqJDevDDKtrbNTyj+HLrNl2ZoiQRq
	 0Cc38oGrJ7EPnSMnjVhvrPUJ9IJlD23/PLcJc0fnMwLT6N1ETbEsNDt5TJ9fPxTmjJ
	 WXgecsi+gm0tw==
Content-Type: multipart/mixed; boundary="===============7191794096785814728=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e144dcb6758dce4342c5ed5f28337b85335c2f5b93a63416569e216795decd7a@mail.kernel.org>
In-Reply-To: <20260318223544.1789748-1-ihor.solodrai@linux.dev>
References: <20260318223544.1789748-1-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support struct btf_struct_meta via KF_IMPLICIT_ARGS
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com
Cc: bpf@vger.kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 18 Mar 2026 23:30:00 +0000 (UTC)

--===============7191794096785814728==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> BPF programs must pass a dummy NULL value when caling these kfuncs.

Typo: "caling" should be "calling".

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

The parameter here is named "meta", not "meta__ign". Should the
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
> index 01c18f4268de..8dd6b3a50dae 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> 		case KF_ARG_PTR_TO_ALLOC_BTF_ID:
> 			if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
> -				if (meta->func_id != special_kfunc_list[KF_bpf_obj_drop_impl]) {
> +				if (!is_bpf_obj_drop_kfunc(meta->func_id)) {
> 					verbose(env, "arg#%d expected for bpf_obj_drop_impl()\n", i);
> 					return -EINVAL;
> 				}
> 			} else if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC | MEM_PERCPU)) {
> -				if (meta->func_id != special_kfunc_list[KF_bpf_percpu_obj_drop_impl]) {
> +				if (!is_bpf_percpu_obj_drop_kfunc(meta->func_id)) {
> 					verbose(env, "arg#%d expected for bpf_percpu_obj_drop_impl()\n", i);
> 					return -EINVAL;
> 				}

The conditions now match both bpf_obj_drop and bpf_obj_drop_impl (and
their percpu variants), but the error messages still reference only
the _impl names. Would it make sense to update these to say
"bpf_obj_drop" and "bpf_percpu_obj_drop" respectively, so that a
developer calling the new variants sees the right function name in
the error?

Andrii Nakryiko also had two unaddressed review comments on this
patch:

https://lore.kernel.org/bpf/CAEf4BzbhBqrPxAtw2xE2aeO8nVaHggV2TVNrMrTJVQTg05X0tQ@mail.gmail.com/

1) Whether the special-casing in the verifier could be generalized
   by inspecting which implicit argument type is involved, rather than
   adding per-function helpers like is_bpf_obj_new_kfunc() etc.

2) Whether a typedef like bpf_implicit_offset_t should be added for
   the u64 offset argument, so resolve_btfids can identify it as an
   implicit arg by type rather than relying on positional ordering.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23271098456
--===============7191794096785814728==--
