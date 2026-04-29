Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0118A37FF42
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 02:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777429619; cv=none; b=NCj+QgPpWVY+PrztnDsWQh1EJiX5AmZkbb+XGnpB7bYHCbE0pBAasSC2V2YusSXQ84t+Pmj3a6WHcEVNLQy5y92F800nEQrsefVQq/p1q7ZiyqvkhoTnU30gEgyMMA6Da3UI96cEcAYFZsKJ0u0FJVZJYdE5UnxGTURKngbp16I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777429619; c=relaxed/simple;
	bh=9+aglqEiyH9/bhiwsL/cO8knYtPmcyeODrTV+S88yXg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qdVRWBgYzMr/oK2WjslZqoAvtODQBH3z7+y29bLNJ9iYfAITT9HX8/2kverW+Lxyo9KT8vaoppjChXhO8ypLnvvw/Hd+OVCNa0ZqumN8vShfxvUyUPJGHOAiuA4yXTIZEtvCd6ULLd1CbyhP3kI383wE6HjfFOu7MsHkGQGsssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+598qN0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+598qN0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC1BC2BCB7;
	Wed, 29 Apr 2026 02:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777429618;
	bh=9+aglqEiyH9/bhiwsL/cO8knYtPmcyeODrTV+S88yXg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=o+598qN0V0xXWLY0WrIghucVPA4r5pv2AD8hBxQYnDNwdsZiUUWqa6XVYddiwsgjV
	 LoBa2dDi9oP7Jdgt+d81udZh7OklEhnS3chmdKxJuyqp+EEtZY8TYUq5NHJT6te5pB
	 kSt9G5dBIOdubqs2fs+NyAL1/vNqFZqdYDDVg351ufxSnjYAeo3suPeuRekBoA+7Md
	 1XJNWTQ/FKqEsPu/FJyARW9YatytcXyRBArP7n6usLAHrH403X+1AkfZ9C74KxKUzM
	 cOQIBNfcg6qgveDMU0tLVPJ7xWJMFOOfGTPuiAxyhgEUyWwa2ZZB0ZVbRG1xPpVSwX
	 q+/+Qx6nHJzCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Print breakdown of insns processed
 by subprogs
Reply-To: sashiko@lists.linux.dev
To: "Paul Chaignon" <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777398528.git.paul.chaignon@gmail.com>
References: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777398528.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Apr 2026 02:26:57 +0000
Message-Id: <20260429022658.5AC1BC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Out-of-bounds array read of `env->prog->aux->func_info_aux` in `bp=
f_subprog_is_global` during `print_verification_stats`.
--

commit ef2118bdc82dd49b98dca03db90f551c13fc5d86
Author: Paul Chaignon <paul.chaignon@gmail.com>

bpf: Print breakdown of insns processed by subprogs

When using global functions, the verifier performs function-by-function
verification, and only the sum of instructions processed is reported.
This patch implements a breakdown of instructions processed per global
function under BPF_LOG_STATS, as is done for stack depths.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -18288,6 +18295,13 @@ static void print_verification_stats(struct bpf_=
verifier_env *env)
>  				verbose(env, "+");
>  		}
>  		verbose(env, "\n");
> +		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed=
);
> +		for (i =3D 1; i < env->subprog_cnt; i++) {
> +			if (!bpf_subprog_is_global(env, i))

Does this code cause an out-of-bounds read of the func_info_aux array?

If a default exception callback is injected during verification,
add_hidden_subprog() increments env->subprog_cnt but does not resize the
func_info_aux array.

When print_verification_stats() later iterates up to the new env->subprog_c=
nt
and calls bpf_subprog_is_global(env, i):

kernel/bpf/verifier.c:bpf_subprog_is_global() {
	struct bpf_func_info_aux *aux =3D env->prog->aux->func_info_aux;

	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
}

Could this read past the end of the aux array when i reaches the index of
the newly added hidden subprogram?

> +				continue;
> +			verbose(env, "+%d", env->subprog_info[i].insn_processed);
> +		}
> +		verbose(env, "\n");
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5c3514dbc879f22ba3f=
9eff8a2c730e13bd0572c.1777398528.git.paul.chaignon@gmail.com?part=3D1
