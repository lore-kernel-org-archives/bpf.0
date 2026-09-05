Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F332E06D2
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569519; cv=none; b=Titl2d9n7KE9qVlktBwSMoi7CiLQ5sNELf5uq1fUSM/izQXG2EiQPk1dj1IK6Y07Zk8zVg9rn5j3iuE/quPHsU1FB5i05sdZDrMRxIZPZX74zuIVrW0Cko4B0hZMTNv5WHIec6nRDu+gKygZNGWMZb8zrCJHV9+06f3mYQ1yus8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569519; c=relaxed/simple;
	bh=jZeTdsZr6xE/0YJ58BdZxGXTnurSheTmfuXfX5H/DBY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pzvDD38bA+/dYG0XGNLYYFmTUyFAAUt+He9ushMePvEQWsj9cGKt7Js55tcLrpKB8E9In42WLTFSo2O8ofy0Zbvp5smoI9aR5uJsoYoqgdlKdcEks9DM80pDdKXGh10RWUJEyGt2WVcHhHgHIN93TO0LJMkzA7yENzcwF/yzr8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nq90lj5R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nq90lj5R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D1F1F00A3F;
	Sat,  5 Sep 2026 00:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788569514;
	bh=nezWNp++ULoZEPWlN2x8KlTR8xpAAALSxHB1SvZiJSQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nq90lj5RfYTjmZ9SavTIFvRKXetV/PtsYsgi7j4UPBeqxkvhaYxhZpBx8hC8mGlN6
	 ZoqhiCnLQ9avcGhMNgLnzHAVmTnPc0BDZjX5/2oz///6ncctsxcIonB45P//iikdPJ
	 RsMlGzWd/7vBd2I4ZThxItmiTGEGTM99xFMba4rw0+fvyA3ULAz8A/7sbEH6UAwvQ3
	 Y4VbC0w4uJfNKPqhMjbBwBSWegQ0fgHPB5liROVup80XFqZ98jck8fcw8NVQUDtcM0
	 zznI11R1wPlQ5uIKrTiP3IAPbAQejPvKrwMLxJYVfU7fDahTl5JvyAa9twL8I4mz4u
	 Voq22tJMt3cNg==
Content-Type: multipart/mixed; boundary="===============0200056657275839651=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a747b38f404f8a6f902014bfec3438f17c6efeb67ff8516ab9a2926cde8e6731@mail.kernel.org>
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-3-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-3-0f5a360ff15d@gmail.com>
Subject: Re: [PATCH bpf 03/10] bpf: mark a NULL memory argument of a call precise
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 00:51:53 +0000 (UTC)

--===============0200056657275839651==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b107f551a62d..7926e131b1cb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4246,6 +4246,15 @@ static int mark_stack_arg_precision(struct bpf_verifier_env *env, int arg_idx)
>  	return mark_chain_precision_batch(env, env->cur_state);
>  }
>
> +static int mark_arg_precision(struct bpf_verifier_env *env, argno_t argno)
> +{
> +	int regno = reg_from_argno(argno);
> +
> +	if (regno >= 0)
> +		return mark_chain_precision(env, regno);
> +	return mark_stack_arg_precision(env, arg_idx_from_argno(argno));
> +}
> +

This isn't a bug, but since ee91facbfbf9 converts check_mem_size_reg()
to mark_arg_precision(), would it make sense to convert process_const_arg()
and process_const_alloc_mem_size() in the same cleanup?

Both still carry the open-coded pattern (if (regno >= 0)
mark_chain_precision(env, regno) else mark_stack_arg_precision(env,
arg_idx_from_argno(argno))), and both already compute regno =
reg_from_argno(argno) solely for that block.

>  static int check_outgoing_stack_args(struct bpf_verifier_env *env, struct bpf_func_state *caller,
>  				     int nargs, const char *callee_name, const struct btf *btf,
>  				     const struct btf_param *args)

[ ... ]

> @@ -7175,7 +7184,7 @@ static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg
>  	int size, err = 0;
>
>  	if (bpf_register_is_null(reg))
> -		return 0;
> +		return mark_arg_precision(env, argno);
>  	if (known_memory)
>  		*known_memory = true;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33932783420
--===============0200056657275839651==--
