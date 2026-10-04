Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B41448392
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791123876; cv=none; b=dWmOwW5IIt7Kiw0K6tanRvoQHvaKpa8fUGrIgbLZPa7Wv2FIazC04BChvKXLCE2/YzpL0e+rvEVeSY8tuGss29hnCq4uJ3HNo/PW4VCz5epxfxkz9E0Y3WI+xHyAI1owGCq9fEBRkqF3Qelrq50JNb9jxo6+GPey8kWIREV10dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791123876; c=relaxed/simple;
	bh=UP/4/dJllVL7KBvr336lmrMMzyNSbD8kBO7rGmZgc4U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=F+AokmD0VTMovduERuSqPXIhgZGP8PwfgqP+j8UEsW9aFOdjLlSwVbk+WIwo68KQs8j98YdNKoXZ/FrqLccpiEq/xS0XcRxmNQSVcnyEKKevuCsS5ravKAArDbmlEoqRRKuwoVLUWXSrZ1EuuO3U5Lb5FYU+DAVoNE9oVu/2b6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJfYxT1T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJfYxT1T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B02711F000FF;
	Sun,  4 Oct 2026 14:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791123875;
	bh=9sBXe3S6H2vNCbrJKjve4fSHoJmtgur02/Ddqsc9Km4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=JJfYxT1TLJSwxsqZf2ogQpLlcCJXN7zgXqgXsb31NiymRQvZoXiQBnjfLwaW/FCzj
	 R7QRGTsCXDqUjLomaQSSk+/yg5DcvXVpBIvq5yM8Vy/1+TTQXVIDCucgpDzbfI9nm0
	 Iwa7N2Ybkc1EGPmS6hw3aX6FSLbRSS/HS84v/5h8CzlI3kmB/ECHWColj0x3S0d6vo
	 N7nUxVfgalOLB0plv2kipBTlzP+lboTkQzsm4koJhjNW8X1DnPE85Op0DD3etA3hBW
	 f4p81e1SAlgYkdxgt1b+SbtKWcpoBxuI8WL+hV0t5n3h+WQ2AK8QjHUiSD4YzcpcJF
	 p828qT55pvzQA==
Content-Type: multipart/mixed; boundary="===============2582980787160194644=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6478041e6e7b752f8fce9c2c8396740d27a913409093072e0e827ba73c967baf@mail.kernel.org>
In-Reply-To: <20261004-scev-minimal-rebase-v2-26-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-26-f6254e29fdf2@gmail.com>
Subject: Re: [PATCH bpf-next v2 26/43] bpf: add bpf_same_memory_origin()
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  4 Oct 2026 14:24:33 +0000 (UTC)

--===============2582980787160194644==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: add bpf_same_memory_origin()

TL;DR: bpf_same_memory_origin() may wrongly treat pointers into different
elements of an inner array map (BPF_F_INNER_MAP, template max_entries == 1) as
the same object, so SCEV loop bounds could be wrong and the verifier may
accept out-of-bounds accesses.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 28c16e35b1f3..9e1c08caa0db 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -17153,6 +17153,51 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
>  	return 0;
>  }
>
> +/*
> + * Many checks done by this function are quite conservative.
> + * This is because main verification pass does not maintain
> + * enough information to track object identities for some
> + * of the interesting types, e.g. PTR_TO_MEM.
> + */
> +bool bpf_same_memory_origin(const struct bpf_reg_state *reg_a,
> +			    const struct bpf_reg_state *reg_b)
> +{

[ ... ]

> +	switch (base_type(reg_a->type)) {

[ ... ]

> +	case PTR_TO_MAP_VALUE:
> +		if (reg_a->map_ptr != reg_b->map_ptr || reg_a->map_uid != reg_b->map_uid)
> +			return false;
> +		if (reg_a->id && reg_a->id == reg_b->id)
> +			return true;
> +		/* A plain single-element array has one stable value address. */
> +		if (reg_a->map_ptr->map_type == BPF_MAP_TYPE_ARRAY &&
> +		    reg_a->map_ptr->max_entries == 1)
> +			return true;

Can this shortcut return true for two pointers into different elements of
the same map when map_ptr is an inner map template?

bpf_map_meta_alloc() copies max_entries from the template inner map into
inner_map_meta, and array_map_meta_equal() does not compare max_entries
when BPF_F_INNER_MAP is set:

    return meta0->map_flags & BPF_F_INNER_MAP ? true :
           meta0->max_entries == meta1->max_entries;

So an ARRAY_OF_MAPS whose template is an array map with BPF_F_INNER_MAP
and max_entries == 1 can hold a runtime inner array with many more
entries.  The verifier already special-cases this elsewhere:
can_elide_value_nullness() returns false for BPF_F_INNER_MAP, and
array_map_gen_lookup() refuses to inline it.

Consider this program:

    /* map_ptr = inner_map_meta, map_uid = U */
    inner = bpf_map_lookup_elem(&outer, &zero);
    /* id = A, map_uid = U */
    p = bpf_map_lookup_elem(inner, &k0);
    /* id = B, map_uid = U */
    e = bpf_map_lookup_elem(inner, &k1);
    if (!p || !e)
        return 0;
    e += 64;
    i = 0;
    do { use(arr[i]); i++; p += 8; } while (p < e);

Here p and e share map_ptr and map_uid.  Their ids differ, so the id
check fails, and the code falls through to the map_type == BPF_MAP_TYPE_ARRAY
&& max_entries == 1 test on the template and returns true.  At runtime,
p and e point at elements k0 and k1, which are (k1 - k0) * elem_size bytes
apart.

Later in this series, fd7009a2fd2e ("bpf: use SCEV to widen bounded
loops") has scev_value_compatible() call this function before
compute_max_iters() turns (bound - initial) / step into
iters->max_header_count.  linear_bounds() and bpf_clamp_scev_regs() then
use that count to widen and clamp induction variables.

In the example above the verifier would bound i to about [0, 8], but at
runtime the loop runs about (k1 - k0) * elem_size / 8 times.  Can arr[i]
then read or write past the end of arr even though the verifier accepted
the access?

Comparing two pointers is allowed when env->allow_ptr_leaks is set, so a
program with CAP_BPF + CAP_PERFMON (or a BPF token) can reach this.

The opening comment says the checks are conservative, but this branch is
not.  Should the shortcut also require:

    !(reg_a->map_ptr->map_flags & BPF_F_INNER_MAP)

the same exclusion can_elide_value_nullness() uses?  No later commit in
2ac7d08257d4..2c96fb13421f changes this check.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37207249098
--===============2582980787160194644==--
