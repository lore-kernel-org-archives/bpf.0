Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794431391;
	b=bnBxt9/sDngoDNcekYxuaGSBUPXqN53LeU2tpRTn0IxoXFgzKE9rIX9AZcAsINKIqbQa
	 mz5fioagM5qZ3KjKUt6PSAaP1w5bcJP8vdKrtIzL+cX8ClB2jtNar1lB9M8IuFhVP06a/
	 rEbFdJOLPd4JhO+1q3ZtQ0imcK7R5tLbh+kQsu4pHjhM/JE2grnWB9E4CtpqHvq0K77da
	 sPTquK0lLs/ik6tANBSa9AsZpmKzGYOwKHHKOjbOQlAuXFFq2x09Xjd7+gKBa1eIf2NLY
	 ccEefDFc9o43tz1Q55FfsfoYIX6CoQKvpAJz6jHiquGq6x8JFfdmpM6y9IT/7ucTrZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431391;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=xCXqGImurCG0aPG84ngg2Z5K+yFamaSwcMReIKJpi5Y=;
	b=j5gZTyPX1E+B3IMV8Z6j9wDgwPSGAFvvDaOzDkr1Bl7USuY1qP4pHtAZZ3qyQTYkg51Y
	 p+iQ2EO/JJgmS4DOyDuAvzz35BPnwRrQRg8ShfIuay9A/xxEpeXwl4GPzWT3koKjMxATi
	 tgSpUC6stk5U8mjhzASmqQZLk7+WTjb5lCXx2TeoOBEF6lb96u/tUt7J4cvgtcurZYSqI
	 bMJNTui+mHgrIK3U9cVYvq0Itn//1l+YicriPS3aCUbaLiFDsgGSiXxANXv8URZUn4EtJ
	 cIuZGsM0NGfpBryibiColQ/iK14d3GDdzNNOW+6rTnMX2249KCvhbbE53C2PwraE5yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StiKQMtb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC27606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StiKQMtb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932F51F00A05;
	Wed, 11 Nov 2026 21:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794431391;
	bh=xCXqGImurCG0aPG84ngg2Z5K+yFamaSwcMReIKJpi5Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=StiKQMtbR6KYC1e548dWEUdF9vIgoSt6bmvqlroSPc9ibLQOVOTVVJOMXdk6eBHkn
	 yUtZ6ZT/uRpnXMwLlNxyygkjKQs5k5AjClM3lX3txIacQZpZ+dKxxTHT+llSTbbsH+
	 11JgOTdzkgkg72qPtSBQ+EaxWVZRf9bY2S61LI+UN+/PGVvzZ7pdBvjgUDreVrQaog
	 obKXs0uKYmJjOAPYG8WMfuQld2KsSttmZGH/M5RZUvrqyATSORjifcznPcxkOBNvrq
	 AMAadaMgk5Pbvit6tguVzuQV5QLjErFClFU4xuMt+k8x2T3mq24U3EOiPa7iuLcsCQ
	 a6n5BN5Ic87og==
Content-Type: multipart/mixed; boundary="===============0054540124902301400=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <defc06bd4199083e8d749ec4188f0784c7941690d0194855888056bff2027deb@mail.kernel.org>
In-Reply-To: <20261111164950.2674588-3-alexei.starovoitov@gmail.com>
References: <20261111164950.2674588-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 2/6] bpf: Add struct scalar
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 21:09:50 +0000 (UTC)

--===============0054540124902301400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add struct scalar

TL;DR: On 32-bit kernels, sizeof(raw) may cover only half the bpf_reg_state
union, so regsafe() could wrongly prune PTR_TO_MEM states (verifier accepting
unsafe programs) and __mark_reg_known() may leave fields uncleared.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> +/* The type and what goes with it: the object that a pointer points to */
> +static inline bool reg_fixed_part_equal(const struct bpf_reg_state *ra,
> +					const struct bpf_reg_state *rb)
> +{
> +	return ra->type == rb->type && !memcmp(&ra->raw, &rb->raw, sizeof(ra->raw));
> +}

Is sizeof(ra->raw) the size of the whole union here?  raw is

    struct {
        unsigned long raw1;
        unsigned long raw2;
    } raw;

which is 16 bytes on 64-bit but only 8 bytes on a 32-bit kernel.  The union
is still 16 bytes there because of the PTR_TO_MEM member:

    struct {
        u32 mem_size;
        struct bpf_stack_range buf;   /* u32 frameno; s32 off; u32 size; */
    };

The old code did memcmp(ra, rb, offsetof(struct bpf_reg_state, var_off)),
which compared the whole union on every ABI.  On 32-bit the new code
compares only mem_size and buf.frameno, and no longer compares buf.off and
buf.size.

buf is the stack buffer that a bpf_dynptr_slice() or
bpf_dynptr_slice_rdwr() result may alias, and invalidate_stack_slices()
relies on it.  Can regsafe() now treat these two states as equivalent on
32-bit?

    if r6 == 0 goto A
      r3 = r10 - 32; call bpf_dynptr_slice_rdwr; goto J
    A: r3 = r10 - 64; call bpf_dynptr_slice_rdwr
    J: if r0 == 0 goto out
       *(u64 *)(r10 - 64) = <pointer>
       *(u64 *)(r0 + 0) = <scalar>
       r1 = *(u64 *)(r10 - 64); use r1 as pointer

The fp-32 path is explored first and is safe.  The fp-64 path is then
pruned at J because type, mem_size, frameno, ranges and ids all match, even
though its slice may alias the spilled pointer.

join_reg() (PTR_TO_MEM case) and bpf_reg_union_compatible() have the same
gap, since the join keeps ra's buf and drops rb's.

[ ... ]

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c

[ ... ]

> @@ -242,7 +242,7 @@ static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rold,
>  		/* If the new min/max/var_off satisfy the old ones and
>  		 * everything else matches, we are OK.
>  		 */
> -		return memcmp(rold, rcur, offsetof(struct bpf_reg_state, var_off)) == 0 &&
> +		return reg_fixed_part_equal(rold, rcur) &&
>  		       range_within(rold, rcur) &&
>  		       tnum_in(rold->var_off, rcur->var_off) &&
>  		       check_ids(rold->id, rcur->id, idmap) &&

Can this prune a state that the old code would not have pruned on 32-bit?
This is where PTR_TO_MEM lands, and with reg_fixed_part_equal() comparing
only half of the union, a state whose slice buffer is at a different stack
offset or has a different size is accepted.  The "No functional change"
statement in the commit message does not seem to hold for 32-bit kernels
(x86_32 supports kfunc calls in its JIT, and BPF_SYSCALL does not depend on
64BIT).

Would making raw cover the union on all ABIs (for example two u64 members,
or naming the union and using sizeof() of it), plus a static_assert that
raw covers the union, restore the old behaviour?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -2002,9 +2002,8 @@ static void ___mark_reg_known(struct bpf_reg_state *reg, u64 imm)
>   */
>  static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
>  {
> -	/* Clear off and union(map_ptr, range) */
> -	memset(((u8 *)reg) + sizeof(reg->type), 0,
> -	       offsetof(struct bpf_reg_state, var_off) - sizeof(reg->type));
> +	/* Clear union(map_ptr, range) */
> +	memset(&reg->raw, 0, sizeof(reg->raw));
>  	reg->id = 0;

The same sizeof(reg->raw) assumption is here.  On 32-bit this clears only 8
of the 16 union bytes, so buf.off and buf.size are left untouched.  Is that
intended?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43092816183
--===============0054540124902301400==--
