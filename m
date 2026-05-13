Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3DC2FE071
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 23:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716034; cv=none; b=Nnp6QzxQ8UnQ9nKEMiYCzP3jaOT+Hu+WQTFDkWA7oHQGYYxYPVntgk6LpNlaDke6DYsbbzwvXHazA6bW3UkqQXKdH5Bw5xjjUEZtXOICCcD82iFEW//+04RmTCUv31DHiQ40B8KS7rAURAgvBdAiyajNSKq4ogAmY4IuB/y3sZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716034; c=relaxed/simple;
	bh=/KoL5Qt6DLipUu4452HdjS9XnZFtti55yYo9zqvPye0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QiKQQJly51ogBR1Hp6bv7yjYscLrFePN7bdmYDT50GiX+rzDqDAJsWpDGb0uTiKpypLDsUb13bYdemfXIOSOAKtLxamsOmpNUXsaW2xulkGShsAo5LI5RBsL/Bl353cg0xgAcYottqOpCuKVjBw0YRWnjeNelzzE2n8B/gG5rhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBRA7oZQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBRA7oZQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82658C19425;
	Wed, 13 May 2026 23:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778716033;
	bh=/KoL5Qt6DLipUu4452HdjS9XnZFtti55yYo9zqvPye0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=SBRA7oZQyo1FHQY4j5VKvdbCVUbyXbTWtNu30KCtIx1xFMwyfqM5uNawESseaKvxK
	 prt5RNYAxJJ1fKtzpfdRpe/CuXmzA60APOfXfVae4wrsUV3Xh8zI7H4iyQxALGHphr
	 ypTBUdIV8mPvFitaW2+fyee5V4FLhVUt57QieTl+49RJMaah8C919KgZdVLGbcbcXJ
	 4a3tEpe73UwF/GGLqzhwdEuhNx+xQyAipW1mk5L2gA1/fJ8CbfZpJd46POEwa7J0ux
	 w/Vjhpl0+QA61j/gqBCacYK0PHgiEk89YkhFX0peSolVBDssxD538gt1rzpbJkAhVU
	 cLFPnNIliw7Eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Report maximum combined stack depth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Chaignon" <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <05f82d1180b68e856bb0cc03a5cd86305f5b7669.1778604369.git.paul.chaignon@gmail.com>
References: <05f82d1180b68e856bb0cc03a5cd86305f5b7669.1778604369.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 23:47:13 +0000
Message-Id: <20260513234713.82658C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Incorrect max stack depth statistics for programs using adaptive=
 private stacks
- [Low] Misleading max stack depth reported on verification failure
--

commit 26f9ea7ef0d72a21cea912b2cbf8938c9d23389b
Author: Paul Chaignon <paul.chaignon@gmail.com>

bpf: Report maximum combined stack depth

This patch modifies the BPF verifier to report the maximum combined stack
depth in its logs alongside the per-subprogram stack depths. It introduces
a new max_stack_depth field to track the worst-case stack usage during
callgraph analysis.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5045,6 +5045,8 @@ static int check_max_stack_depth_subprog(struct bpf=
_verifier_env *env, int idx,
>  		}
>  	} else {
>  		depth +=3D subprog_depth;
> +		if (depth > env->max_stack_depth)
> +			env->max_stack_depth =3D depth;
>  		if (depth > MAX_BPF_STACK) {
>  			total =3D 0;
>  			for (tmp =3D idx; tmp >=3D 0; tmp =3D dinfo[tmp].caller)

[ ... ]

> @@ -5185,6 +5187,8 @@ static int check_max_stack_depth(struct bpf_verifie=
r_env *env)
>  	if (priv_stack_mode =3D=3D PRIV_STACK_UNKNOWN)
>  		priv_stack_mode =3D bpf_enable_priv_stack(env->prog);
> =20
> +	env->max_stack_depth =3D env->subprog_info[0].stack_depth;
> +
>  	/* All async_cb subprogs use normal kernel stack. If a particular
>  	 * subprog appears in both main prog and async_cb subtree, that

If a BPF program uses an adaptive private stack, the else block in
check_max_stack_depth_subprog() isn't executed. Since env->max_stack_depth
is unconditionally initialized here to the main subprogram's stack depth,
could this result in incorrect reporting for private stacks?

For example, if the main program uses 16 bytes and calls a subprogram
using 500 bytes on a private stack, could this cause the verifier to
incorrectly log a maximum stack depth of 16 (e.g., stack depth 16+500
max 16)?

[ ... ]

> @@ -18289,7 +18293,7 @@ static void print_verification_stats(struct bpf_v=
erifier_env *env)
>  		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
>  		for (i =3D 1; i < subprog_cnt; i++)
>  			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> -		verbose(env, "\n");
> +		verbose(env, " max %d\n", env->max_stack_depth);
>  		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed=
);
>  		for (i =3D 1; i < subprog_cnt; i++)
>  			if (bpf_subprog_is_global(env, i))

If verification fails early in the process (for instance, during
do_check_main()), check_max_stack_depth() might be bypassed entirely.
Because env->max_stack_depth is zero-initialized by default, would this
result in misleading log output like stack depth 32+256 max 0 when the
stats are printed for the failed run?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/05f82d1180b68e856bb=
0cc03a5cd86305f5b7669.1778604369.git.paul.chaignon@gmail.com?part=3D1
