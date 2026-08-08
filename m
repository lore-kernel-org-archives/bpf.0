Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41E34F474
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786171525; cv=none; b=lE/46rPeJoNXGsZCHgs12VIv0UVrROfePkXggCA5FQKj7clFLuBnMkeVhhnYU9zaK6TJyzsyeW/5ySWuQrv9pnCR7oNkRgaRnuPPtKIch9sLUXX/xaSu/9RhJ5Id5T0ZrHsZb4XSogHSMj0K4Jhu0dXAtYEAXNOqo15P8t8Vtsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786171525; c=relaxed/simple;
	bh=5Zddank30OzIFT2Exzifo24ki2bPHA1w+twDXxdlyZw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W/g+4F4+mc++/Wmx1Vyy5WEv3zuVOUS7cyDeA3DQQfbbdse8TB4/I3HawTe5hcLhp9BXJZUFH9HxYQl4ap5ESk6iHe9YE+bDW64/Jn+Ig5U9mLUKLTtl6AZQ6pweQPFBXhW931aDUuTwR0Kp85lvQjP7laOSeFWgj7bnTajGg3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn7Txd4f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn7Txd4f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3E71F000E9;
	Sat,  8 Aug 2026 06:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786171524;
	bh=yAXDpb2xa6FyGNNbrO28C5npaKR5NmZsjMC++d6OyFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bn7Txd4f9/oGNlcChXmsTvnjAWtvcZzJ9yQ+NA5uYU+jUrUMQf+x31mhUB11838uR
	 bvuhWSqf7U2umgJPP2+8jpKa7W1ni6+H8uRVnvLPfORwU4GEmBmPxjMOBboHkysbUM
	 9SSplBjEmMSBQfxFXtXqjNMLlGGES0Zq0iWcXHqZIhpe2CJwkuDuo+wL8bkpL9p9Nx
	 SI5u7UhbI0dwzTrKjUZkljJQEbZU8K/1pBjOswthswjYxl+/G7OI90BsGybpkLmG1l
	 9LJMoGi/9hyDPOaZVaBeAa00ti9AbTS9HlYLxhfxWeLsu7JrotCVFGI6ComUWv1rNR
	 lISH0LAmbFMvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 3/6] bpf: Show more useful info in stack
 depth stats
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260808062601.1070988-4-memxor@gmail.com>
References: <20260808062601.1070988-1-memxor@gmail.com>
 <20260808062601.1070988-4-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 06:45:23 +0000
Message-Id: <20260808064523.DE3E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The array `func_info_aux` is not updated when a subprogram is remo=
ved during dead code elimination, leading to desynchronized indices and mis=
matched linkage/properties output. This problem wasn't introduced by this p=
atch, but it exposes a severe preexisting bug where subprogram metadata bec=
omes misaligned.
--

--- Patch [3]: [PATCH bpf-next v7 3/6] bpf: Show more useful info in stack =
depth stats ---
commit f4f742e1d07651cd7baebbdb7ebb72f0898a6722
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Show more useful info in stack depth stats

This patch updates how stack depth statistics are reported in the verifier.
It keeps the combined maximum stack depth on its own line and introduces a
uniform record for each subprogram, classifying them as main, global, or
static. It also prints self and inclusive instruction counts along with sta=
ck
depth.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9b76851dcf54b..eca30096501ff 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -18832,15 +18832,20 @@ static void print_verification_stats(struct bpf=
_verifier_env *env)
>  	if (env->log.level & BPF_LOG_STATS) {
>  		verbose(env, "verification time %lld usec\n",
>  			div_u64(env->verification_time, 1000));
> -		verbose(env, "stack depth %d", env->subprog_info[0].stack_depth);
> -		for (i =3D 1; i < subprog_cnt; i++)
> -			verbose(env, "+%d", env->subprog_info[i].stack_depth);
> -		verbose(env, " max %d\n", env->max_stack_depth);
> -		verbose(env, "insns processed %d", env->subprog_info[0].insns_total);
> -		for (i =3D 1; i < subprog_cnt; i++)
> -			if (bpf_subprog_is_global(env, i))
> -				verbose(env, "+%d", env->subprog_info[i].insns_total);
> -		verbose(env, "\n");
> +		verbose(env, "stack depth max %d\n", env->max_stack_depth);
> +		for (i =3D 0; i < subprog_cnt; i++) {
> +			const char *name =3D env->subprog_info[i].name;
> +			const char *kind;
> +
> +			if (!name || !name[0])
> +				name =3D "<unknown>";
> +			kind =3D i =3D=3D 0 ? "main" :
> +			       bpf_subprog_is_global(env, i) ? "global" : "static";

[Severity: High]
This isn't a bug introduced by this patch, but this use of
bpf_subprog_is_global() exposes a pre-existing issue where subprogram
metadata becomes misaligned.

If a subprogram is removed during dead code elimination,
adjust_subprog_starts_after_remove() shifts func_info but fails to shift
func_info_aux:

kernel/bpf/fixups.c:adjust_subprog_starts_after_remove() {
		if (aux->func_info) {
			move =3D aux->func_info_cnt - j;

			memmove(aux->func_info + i,
				aux->func_info + j,
				sizeof(*aux->func_info) * move);
			aux->func_info_cnt -=3D j - i;
			/* func_info->insn_off is set after all code rewrites,
			 * in adjust_btf_func() - no need to adjust
			 */
		}
}

This causes func_info_aux to become permanently desynchronized with the
actual subprogram sequence.

Because bpf_subprog_is_global() relies on aux[subprog].linkage from this
un-shifted array:

kernel/bpf/verifier.c:bpf_subprog_is_global() {
	struct bpf_func_info_aux *aux =3D env->prog->aux->func_info_aux;

	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
}

Could this lead to mismatched linkage and properties output here?

More importantly, could this also allow bpf_check_attach_target() to
misread the unreliable flag and permit a freplace extension to attach to
heavily optimized static functions?

kernel/bpf/verifier.c:bpf_check_attach_target() {
    ...
		conservative =3D aux->func_info_aux[subprog].unreliable;
    ...
}

> +			verbose(env, "subprog %d (%s) %s insns_self %d insns_total %d stack %=
d\n",
> +				i, name, kind, env->subprog_info[i].insns_self,
> +				env->subprog_info[i].insns_total,
> +				env->subprog_info[i].stack_depth);
> +		}
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808062601.1070=
988-1-memxor@gmail.com?part=3D3
