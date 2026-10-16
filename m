Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AC0547041
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792110507; cv=none; b=DnwzLBlbHpg+W511Xs5ANPokgOgsA5M+ZLs5G74MTcdRG6+kDgNjuAuxekv+HVicha19NwKyoh1rhG0fNwdR3SRNiaASwyNy4QUTIUO5nZ65ARZDvXBFm7EMCwOklUxvZh/qCz5plp8fgsmLgUABETrfEcXg9OsDGSruxE5umTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792110507; c=relaxed/simple;
	bh=AD4BFlbCtrPntArVuZQURygDgsoA9ieKXSeSMZckTmc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=O0utvaO7OPLIh04ZNtRfEPvY9b9CJ4YSanrEW/JXfb16lsH+EJDS747GuHE2ovTUr9hPY28AynFnw6/Z9wAb5UcIHH/eafWXyKlHijIG7rNkVvKl9HcJi4gc/gvyH0WSMIOLo9cIXcLftLsNRmVG7GAL68smIfEz7fmGNaoAjp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+0TKtBB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+0TKtBB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC44F1F000C4;
	Fri, 16 Oct 2026 00:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792110506;
	bh=eRNg0tudoZ3scdP5gOZDGb9gvt5Q3LEtTUfZh2U0IHY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=W+0TKtBBa28kVuxRkcgx8nm1q9yjqTSChWs+KWgmAjMxTKZlwrd7rMerQ2y9pjAFz
	 ANpHF1FfrMsxuuMYwY+X3nNRx6vITeXHvruAAQqcSUS8GfMNPjg3TP+UyjrK/iGvYE
	 /os/6iyGuVB4WAft8HYAmkke5iDeAgf3Owroq46eNoK1xJylbXp6uiUjhz3N1ce6mu
	 cB+WNEb94fUB+i/BZyjk4IpJGqMfhuHyekyCcK7SfQVFeQliOx0k3+lkLWpZ+Us+iB
	 rvOyWPNabLyoJsSK5ICBxwdExY3CJjKwHdLKvOv31KwXJJ9ziL87/wH70b/rFosOUN
	 qyEeBQ/hxygLA==
Content-Type: multipart/mixed; boundary="===============4721331022513430803=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d25f43e8ed0415c42c3ad88540f2ad67deaf0683c581da28dfc3f6d68a922b10@mail.kernel.org>
In-Reply-To: <20261015234125.3152346-2-memxor@gmail.com>
References: <20261015234125.3152346-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 01/15] bpf: Compute the program digest before resolving the fd_array
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: kpsingh@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 16 Oct 2026 00:28:24 +0000 (UTC)

--===============4721331022513430803==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Compute the program digest before resolving the fd_array

TL;DR: Computing the digest before CO-RE relocations may let a loader with
CAP_BPF and the map fd get a different program bound to an exclusive map,
since kernel-applied relocations can change insns after the digest check.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ec136cf377c1..f143b1b18b5c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -23307,11 +23303,15 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr,
>  		ret = -EINVAL;
>  		goto err_prep;
>  	}
> -	if (env->signature) {
> -		ret = bpf_prog_calc_tag(env->prog);
> -		if (ret < 0)
> -			goto err_prep;
> -	}
> +	/*
> +	 * The digest covers the insns as submitted and is needed before the
> +	 * fd_array is resolved: an exclusive map bound through it is checked
> +	 * against the digest of the program, and a signature is verified over
> +	 * the insns and the maps the array binds.
> +	 */
> +	ret = bpf_prog_calc_tag(env->prog);
> +	if (ret < 0)
> +		goto err_prep;
>  
>  	ret = process_fd_array(env, attr, uattr);
>  	if (ret)

Does computing the digest here let bpf_check_core_relo() change a program
after its exclusive maps have been bound to the digest?

Before this patch, check_and_resolve_insns() computed the digest after the
kernel had applied CO-RE relocations.  For a map referenced by an insn
(BPF_PSEUDO_MAP_FD or a legacy fd_array reference),
check_map_prog_compatibility() therefore compared:

    if (map->excl_prog_sha &&
        memcmp(map->excl_prog_sha, prog->digest, SHA256_DIGEST_SIZE))

against the insns that actually get verified and run.  The same ordering
existed at baefdbdf6812, where check_btf_info() and its check_core_relo()
ran before resolve_pseudo_ldimm64() and its bpf_prog_calc_tag().

With this change the comparison is against the hash of the submitted insns.
After that point, bpf_check_core_relo() -> bpf_core_apply() ->
bpf_core_patch_insn() can still rewrite insn->imm of ALU/ALU64 BPF_K insns,
insn->off and the access size of LDX/ST/STX, and the imm64 of plain
ld_imm64 insns.  The relocation records (attr->core_relos) and the local BTF
(prog_btf_fd) are not part of the digest, and the validate check only
requires the original value to match what the caller's own local BTF says.

Could a loader with CAP_BPF and the map fd submit the exclusive program's
exact insns, get the same digest, and then add relocations that change store
offsets or immediates?  The result would be a different program bound to the
exclusive map.  Before this patch that was refused with -EACCES for
insn-referenced maps, because the post-CO-RE digest no longer matched.  The
newly fixed continuous fd_array path for unsigned programs has the same
window.

The commit message says the digest now covers "the insns as submitted for
every program, before the CO-RE relocations the kernel applies", but it does
not discuss that kernel-side relocations can now change a program after its
exclusive maps have been bound.

The comparison with signed programs also looks only partly accurate.  In the
old code check_and_resolve_insns() recomputed the digest unconditionally, so
a signed program's final digest and tag also covered the post-CO-RE insns.

Is this acceptable for unsigned exclusive maps?  Alternatives would be to
reject core_relos when an exclusive map is bound, or to re-check exclusivity
against a post-CO-RE digest.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38826834739
--===============4721331022513430803==--
