Received: from mail-wr2-f1.google.com (mail-wr2-f1.google.com [74.125.225.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071F839020C
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785713403; cv=none; b=OKbPotgPUZ1Em+U74AEsLdJWZMWyfmUJtzdnBJkbOo78Q1YS3omBRt7LpmIH5Ejn3SOhjzcZPT3RoXC0GhZeBqsb7vz9lbFXgFXGduvsAtr4CEB9QVWwbHATjZXiONi8gUm+rQH8kXsgRhrMdbdTw9b9o2ihCMJ/Y21pjUM6HnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785713403; c=relaxed/simple;
	bh=x5lKFfvdF480SWOzJUIRkM/Ff/SmxozioCEOu5Cixds=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=bBjzOvJrRkhhvOcZmc4vSjuupqoHCadksUn46+L6EeIuc3kPHXC39YTx5Lp5ElvAUKd6WJUgIeTowTQ6qzPWIkAp3z4WXKQWghhsI2eh5FA72DzjqvDN2KdO32xA6Ms49Bpr1JDlegd9MZQ0iI8ubLKedGGCwcZZnGCWfbctr+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pwhue7PO; arc=none smtp.client-ip=74.125.225.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pwhue7PO"
Received: by mail-wr2-f1.google.com with SMTP id ffacd0b85a97d-47fd1b2021fso962508f8f.1
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 16:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785713400; x=1786318200; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qloiq+gAZjkY4WR0kgpXILM6cA5GObA2GquhuAHRPJQ=;
        b=pwhue7POWJQnTf1xP7UiwBLugGpmO+FA4+jBgjjdHdA90txRIx85szAYes8bawR0gf
         TZwgNKRVPKdLoyLAF/jM9kgJ9uwxBhD4+FqsykTgJGPAtM5Q2cOetjFV/TNgyRqUdBnT
         pvzDvI3h7zfhZj/4uszuPpoLyy8lKf7c0I9DW+awetj7cUw//xZN+UGaoWanFz2R9cUp
         RJGtUbkQ89H3yBh84WiHEvXTdCcd4rRRUGwK/LQsVMLpFNMMp7f53dxL/qd4EPdez8N/
         461oiQhVluLiCzA9+X0ErUcmCRtArSVjL/tgYld49UrYM0mKPgA6w/wIkl6VJu7fT5cN
         UQrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785713400; x=1786318200;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qloiq+gAZjkY4WR0kgpXILM6cA5GObA2GquhuAHRPJQ=;
        b=HfNBv+QkK3iDAKGQmIcBnok0q6Y2y8yF13C47rchGDknqV9VEdE4S1/24NDBS1M6lS
         DbodvSVCjdvucE2ogdfRxW3qGskbDCQmQkPdRErwqkyatwqmfPWDuCsaKbNeOHlmuSj3
         muvYFRo/C92bplpXEpuaBYZU3xuxa9/J/ujQWEDz41aN+1qfO9B0G+NuUlD+dlsg+NWd
         HJfy6aFNykbDi7godK36euSifi1RLceD1bZl2PPpdVp+D+EhymYZINg4SPEd/9K0tBWh
         Nb+4bblLMIocJGaSRWW/LccqeQtMooAwmtOKiDYNuqYJoCopoFnJ6YNcDOhyp56TB0c6
         e5Uw==
X-Forwarded-Encrypted: i=1; AHgh+RrOg5JjeYGVkycP8+je66Vg2rHv8J/xpy3ZQnVMwzR8PLdn8nlTmRbVyq2NNM9cMcIatSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHOMarCG0k+y9002Nv/6ynaPbbvBFKJy/D0XCitNYJG4vLa1eq
	WqRrO7h3kevUWiGee1UvmDbNin2BSDMHh+f/GEhu389JWDy7W5LvTNW9h9bEDkJq
X-Gm-Gg: AR+sD13DGcRIKUly0Gg48x/q8BHWy4cZepBI/ChIhlADM+N7u0XOYk+PLxJSvrSs2tv
	TJCyR5fZqW+fprP7mR5/7pDRuEAEcpToPoFIluNEIbo283w8M6oZt6/dAXUAfJaYksDDyjjC7xo
	sW5t5p20wxIPfoIYH3IckPGjR6JliPxbf7/55kZGise0A/5IqTIIrybSGDkG8KHoMBMsFP7g0wd
	BfrxZ8NZF5U+OEIkehopzYJgooJerIOW8Vj1FSQ5HCZQMHhJ1ogC1KX3LSCTNc8OcZGi/gPSAro
	ACuSjd8oVRP7gK4uoMZ+aVOxYQ6CmmpLggsJPae3S8ZbqzkDT6lcbzkXd1yWiolrIAYkQWYAP9G
	lg+JzhzQGrPbBAw1bSDECSpaJs7h6NJCoZKI0+V9jiiidUE2dyABb2fYDFeSIGmGJ1oEBxt5xVk
	n6gs/jbBRZ0aRhyn39kfRp/ahAyWQ7yxGh9J4QonUEnrczeSZcKMGdZda1NRzv38eeuALGcj5t3
	coqSi7FBkF819guDYn453Rt77244rZU+MDcF0GbGTs/0l2JIisdoGQYGsVfojuppyVPO4ewQ3kl
	7q2cpPtxTZ+wXSjZODSSswylhQU=
X-Received: by 2002:adf:e781:0:b0:47f:4ac9:98bc with SMTP id ffacd0b85a97d-47fd72c68aamr14387804f8f.24.1785713400050;
        Sun, 02 Aug 2026 16:30:00 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e296csm25035908f8f.12.2026.08.02.16.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 16:29:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 01:29:59 +0200
Message-Id: <DKEUKIOKSY28.2XVQVGCKLI40C@gmail.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>, <martin.lau@linux.dev>, <davem@davemloft.net>,
 <greg@kroah.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Reject untrusted pointers in
 refcount_acquire
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ning Ding" <dingning04@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260726235030.1152542-1-dingning04@gmail.com>
 <20260726235030.1152542-3-dingning04@gmail.com>
In-Reply-To: <20260726235030.1152542-3-dingning04@gmail.com>

On Mon Jul 27, 2026 at 1:50 AM CEST, Ning Ding wrote:
> After bpf_rcu_read_unlock(), a refcounted map kptr is marked
> PTR_UNTRUSTED because it is no longer protected by RCU. The
> refcounted-kptr argument check ignores PTR_UNTRUSTED and still allows
> bpf_refcount_acquire() on that pointer.
>
> However, if another thread removes the object and drops its last referenc=
e, the
> stale address can later be reused for another refcounted object. A
> CAP_BPF-only reproducer observed bpf_refcount_acquire() returning
> non-NULL through such a stale pointer.
>
> Reject PTR_UNTRUSTED refcounted-kptr arguments and add a regression
> test.
>
> Fixes: 7c50b1cb76ac ("bpf: Add bpf_refcount_acquire kfunc")
> Reported-by: sashiko-bot@kernel.org
> Link: https://lore.kernel.org/r/20260726021304.97ED91F000E9@smtp.kernel.o=
rg
> Assisted-by: Codex:gpt-5
> Signed-off-by: Ning Ding <dingning04@gmail.com>
> ---

Same comment as the new set; split kernel commits and selftest commits into
separate ones. As for the fix, I think it would make more sense if
type_is_ptr_alloc_obj() was fixed to PTR_UNTRUSTED by definition, instead o=
f
having to add extra checks on top.

pw-bot: cr

>  kernel/bpf/verifier.c                         |  5 ++++
>  .../bpf/progs/refcounted_kptr_fail.c          | 27 +++++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1e7343b625de..63b1d997fe80 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12414,6 +12414,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  			meta->subprogno =3D reg->subprogno;
>  			break;
>  		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
> +			if (reg->type & PTR_UNTRUSTED) {
> +				verbose(env, "%s is an untrusted refcounted kptr\n",
> +					reg_arg_name(env, argno));
> +				return -EACCES;
> +			}
>  			if (!type_is_ptr_alloc_obj(reg->type)) {
>  				verbose(env, "%s is neither owning or non-owning ref\n",
>  					reg_arg_name(env, argno));
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/t=
ools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> index acd3e81a3916..80b92d7ec9ca 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> @@ -127,6 +127,33 @@ long refcount_acquire_rcu_map_kptr_unchecked_drop(vo=
id *ctx)
>  	return 0;
>  }
>
> +SEC("?tc")
> +__failure __msg("is an untrusted refcounted kptr")
> +long refcount_acquire_after_rcu_unlock(void *ctx)
> +{
> +	struct map_value_refcount_only *mapval;
> +	struct node_refcount_only *n, *m;
> +	int idx =3D 0;
> +
> +	mapval =3D bpf_map_lookup_elem(&stashed_refcount_only, &idx);
> +	if (!mapval)
> +		return 1;
> +
> +	bpf_rcu_read_lock();
> +	n =3D mapval->node;
> +	if (!n) {
> +		bpf_rcu_read_unlock();
> +		return 2;
> +	}
> +	bpf_rcu_read_unlock();
> +
> +	m =3D bpf_refcount_acquire(n);
> +	if (m)
> +		bpf_obj_drop(m);
> +
> +	return 0;
> +}
> +
>  SEC("?tc")
>  __failure __msg("Unreleased reference id=3D3 alloc_insn=3D{{[0-9]+}}")
>  long rbtree_refcounted_node_ref_escapes_owning_input(void *ctx)

