Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3B62E7F3A
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 00:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209190; cv=none; b=ZW8XyzIn6pugFJ6u12wz1SsOWk1M7C7hlJYSX810nvQzRERHN16q9pCuHRNndksj2uiivuxhKuawfKzgxwSUCIMGkE53vkK8CLA60RthmY+Tx4qCiQKuvMTJCBnMIS1pwxmDHvqKF68wv0L7ViFZF59POtB4dtxUIM4/JMkrYLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209190; c=relaxed/simple;
	bh=2L/mmxKNtubNCRAYESB2LDPlIZIDyrXJrXXaL3dA+rY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MtYkT+pjPYJ2sbqWMvl7Y80PkKzeS0KUfeu3YTPmhlfVXP8zrKtyNBLnUhWZW9hAvoKs1qlz6NK3OWK0eihRn6Vaha7lRa/g//LPJ2tGi5N2N9zSojj5Iu09HklKkZfNES3xZK3HlnVVxBNTKQKMZbU5+/cQSiboO0fPGKFkl6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzxLHq21; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzxLHq21"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467471F000FF;
	Thu, 24 Sep 2026 00:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209188;
	bh=oOIBVcSPDEQGyyluTGxXb+gdsP0eqbSc1w+zGshxOnc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DzxLHq21ulth2YYmYq3S9bfapUznVe3wPODLz0R2y8W26FWjlX/toEBVcxwNGVDEQ
	 ypN28S1xYJqe4GcAgQXzLUWtXqeoRBsXfm7Jg0ZeGSVUjnXqQBy0jtE3kDQlvGuvBG
	 vbqfHmtACBYWrDsbmnjVsWeEEXJOyAK+Fv/dYge/K63fOZGPIcRLwaShNPPXRJ04+2
	 lfUonfXEeZLpYGoguGhHLOJMmFmxOi7XK63XmNBvNhXXFvISrhpp2mo7Bk7JDoTIWw
	 7wXTkxHhxFe/Q4AO4isvByo+T/KXbcAHHvz4IULqmp+RtuHNAEj1xkZEWR3vea/byj
	 q6/B5v1ZUgVEg==
Content-Type: multipart/mixed; boundary="===============2556123522319047021=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6809a2d8349335eef268bd694ecee286d637ece1f73749f14ad51609e284e3a8@mail.kernel.org>
In-Reply-To: <20260922011323.1298619-4-alexei.starovoitov@gmail.com>
References: <20260922011323.1298619-4-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 03/17] bpf: Don't fold loads from insn_array maps into constants
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 00:19:47 +0000 (UTC)

--===============2556123522319047021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Don't fold loads from insn_array maps into constants
>
> bpf_compute_const_regs() constant-folds loads from frozen read-only maps
> via bpf_map_direct_read(). insn_array maps are frozen and read-only too,
> but their values are addresses of jitted insns that are not known during
> verification. bpf_map_direct_read() returns zero, the register loaded
> from the first two elements of a jump table becomes const 0 and
> bpf_prune_dead_branches() may rewrite a conditional jump on it.
> check_map_mem_read() in the main pass marks such register as PTR_TO_INSN.
> Treat it as unknown in const_fold as well.
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Does the commit message accurately describe the bug being fixed?

The message says bpf_map_direct_read() returns zero for insn_array maps,
causing const_fold to fold the load into const 0. However,
bpf_map_direct_read() in kernel/bpf/verifier.c already rejects this map
type before calling map_direct_value_addr:

int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val,
                        bool is_ldsx)
{
    ...
    if (map->map_type == BPF_MAP_TYPE_INSN_ARRAY ||
        map->map_type == BPF_MAP_TYPE_PERCPU_ARRAY)
        return -EINVAL;
    ...
}

In const_reg_xfer() the BPF_LDX case already ends with:

if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr ||
    off < 0 || off + size > map->value_size ||
    bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
    *dst = unknown;
    break;
}

Before this patch, a load from an insn_array map already produced
*dst = unknown through the non-zero return of bpf_map_direct_read().
The new check only short-circuits earlier into the same outcome.

The register was never const 0, and bpf_prune_dead_branches() could not
rewrite a jump based on it. Is this patch intended as a bug fix, or as a
clarity/defence-in-depth change?

Additionally, Eduard Zingerman noted in the v1 review that this patch
"does deserve fixes tag, though." You responded that "This check is already
part of bpf_map_direct_read(). Will drop this patch." However, the patch
was not dropped and no Fixes tag was added. Should this patch be dropped as
originally planned, or if it's being kept for other reasons, should the
commit message be reworded to reflect that this is a clarity change rather
than a bug fix?

> diff --git a/kernel/bpf/const_fold.c b/kernel/bpf/const_fold.c
> index 7f1b30059cc8..982125026eaf 100644
> --- a/kernel/bpf/const_fold.c
> +++ b/kernel/bpf/const_fold.c
> @@ -181,7 +181,12 @@ static void const_reg_xfer(struct bpf_verifier_env *env, struct const_arg_info *
>  		int off = src->val + insn->off;
>  		u64 val = 0;
>
> +		/*
> +		 * Values of insn_array map are addresses of jitted instructions,
> +		 * which are not known until the program is jitted.
> +		 */
>  		if (!bpf_map_is_rdonly(map) || !map->ops->map_direct_value_addr ||
> +		    map->map_type == BPF_MAP_TYPE_INSN_ARRAY ||
>  		    off < 0 || off + size > map->value_size ||
>  		    bpf_map_direct_read(map, off, size, &val, is_ldsx)) {
>  			*dst = unknown;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35935998342
--===============2556123522319047021==--
