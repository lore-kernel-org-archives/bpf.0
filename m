Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E942823E33D
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 07:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787814281; cv=none; b=MhwtV9twnFuQNKsLreGvjmDpVDK0qc5WDqPitMMLYJqeS8KVPG7p1H36Zm1b3KhJNRFxEikODbB0ZzEU8dl/Yc+w1r3VNzNE05SndRYCSPjIZWBQOCidBTRY2jbyJVBltFP2rKYsMPMKG8/kpV6QuNcUX7a13TI76/M4BH9OTto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787814281; c=relaxed/simple;
	bh=0GPg9IBkxcEYDa9UbXwQ2SzNfQcngDPHAdrWjqiw9Hg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=W7SrNZHRZRK3oKS12nkn8UwOxUNtGR1Xy1oeeru9gB0yCiwtlHUpLR/594NlSUHN1s9OqLuZgNQp+eePsOuHjgM1DXV2nulp/CNVmo8pOt8ois45PqIHMaLcy6gYifz7IR9i836/fQB1fgTHNr7K6Qa4/6ssex5W1m1PPjK5AH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYs7Lxtk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYs7Lxtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8441F000E9;
	Thu, 27 Aug 2026 07:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787814279;
	bh=1o/6UwRkJ0IebUCT/4JEig2RbVDleh8hDw6Jipj2Zag=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hYs7LxtkbMpKDiX5YOW5dbDd9O+8Jabm4eHt5Bg5I09yzwelS3k1+KvxTBk3TF3a4
	 kpq3X/luLJpo7vHfO6//CMd/Blo5NCGMwJZLATRIkuJII1rAxecXCRvAE1uhL/A9rx
	 S347VQtj6mqhAG/x5M5fjVVnWfnxNo68HL9QA/bBkzbedEdrFhQvP4uXoU9egBAyQN
	 9mQp4orwJHv/CTop8ZsWiEZRKbR885BeJqAelgMyQtd/40ASkK+NtYwRyQblyz5TYk
	 6Urgi1OPovPnrFUZoiM/niZlgSKBRbVxOu3QgHR6Go0WRRdgIba/TrLENRf6zA8oX6
	 vPPVsNdwwg5+Q==
Content-Type: multipart/mixed; boundary="===============7147415291769762490=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2c5f70a3b993229bd5edbd754adc21195dd802515a2320523ce443859f03bef7@mail.kernel.org>
In-Reply-To: <20260827061125.2516013-1-yonghong.song@linux.dev>
References: <20260827061125.2516013-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next v3 02/11] bpf: Drop the recursion depth argument of btf_type_is_scalar_struct()
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 27 Aug 2026 07:04:39 +0000 (UTC)

--===============7147415291769762490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 05b126fd8e09fdf16e522924b7a453dc9050c44b
> Author: Yonghong Song <yonghong.song@linux.dev>
> Date:   Wed Aug 26 23:11:25 2026 -0700
>
>     bpf: Drop the recursion depth argument of btf_type_is_scalar_struct()
>
>     btf_type_is_scalar_struct() recurses into nested struct members and
>     carries the nesting depth in a @rec argument, so every caller has to
>     spell out the 0 that starts the walk.
>
>     Move the recursion into a static helper that keeps @rec and leave
>     btf_type_is_scalar_struct() as a thin wrapper over it, so callers only
>     name the type they are asking about.
>
>     No functional change.

This isn't a bug, but would it help to say the split is in preparation
for giving the walk extra state, rather than presenting it as call-site
tidying?

Looking at the next patch in the series, 'bpf: Let the by-value struct
walk take the kinds of member it accepts', a @member_kinds parameter is
added to exactly this walk helper, which looks like the load-bearing
reason for introducing the wrapper now. As written, a reviewer reading
this patch alone sees only a cosmetic change and has no way to tell it
is groundwork.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 004b06785521c..3eb61edc8c5e1 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -1489,7 +1489,7 @@ struct bpf_iarray *bpf_insn_successors(struct bpf_verifier_env *env, u32 idx);
>  void bpf_fmt_stack_mask(char *buf, ssize_t buf_sz, u64 stack_mask);
>  bool bpf_subprog_is_global(const struct bpf_verifier_env *env, int subprog);
>  bool btf_type_is_scalar_struct(struct bpf_verifier_env *env, const struct btf *btf,
> -			       const struct btf_type *t, int rec);
> +			       const struct btf_type *t);
>
>  int bpf_find_subprog(struct bpf_verifier_env *env, int off);
>  bool bpf_is_throw_kfunc(struct bpf_insn *insn);

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5d8162e13c208..bc3053e81500f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11647,9 +11647,8 @@ static bool is_kfunc_arg_implicit(const struct bpf_call_arg_meta *meta, u32 arg_
>  }
>
>  /* Returns true if struct is composed of scalars, 4 levels of nesting allowed */
> -bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
> -			       const struct btf *btf,
> -			       const struct btf_type *t, int rec)
> +static bool btf_scalar_struct_walk(struct bpf_verifier_env *env, const struct btf *btf,
> +				   const struct btf_type *t, int rec)
>  {
>  	const struct btf_type *member_type;
>  	const struct btf_member *member;
> @@ -11667,7 +11666,7 @@ bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>  				verbose(env, "max struct nesting depth exceeded\n");
>  				return false;
>  			}
> -			if (!btf_type_is_scalar_struct(env, btf, member_type, rec + 1))
> +			if (!btf_scalar_struct_walk(env, btf, member_type, rec + 1))
>  				return false;
>  			continue;
>  		}
> @@ -11686,6 +11685,13 @@ bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
>  	return true;
>  }
>
> +bool btf_type_is_scalar_struct(struct bpf_verifier_env *env,
> +			       const struct btf *btf,
> +			       const struct btf_type *t)
> +{
> +	return btf_scalar_struct_walk(env, btf, t, 0);
> +}

This isn't a bug, but since the following patch renames both of these,
could this patch introduce the final names directly so the call sites
and the header prototype are only touched once?

Both names introduced here are renamed one commit later in the same
series: btf_scalar_struct_walk() becomes btf_struct_member_walk() and
btf_type_is_scalar_struct() becomes btf_struct_is_composed_of() in
'bpf: Let the by-value struct walk take the kinds of member it accepts',
which also re-touches the include/linux/bpf_verifier.h prototype and
all six call sites a second time.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33045482525
--===============7147415291769762490==--
