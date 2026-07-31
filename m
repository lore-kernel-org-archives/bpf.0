Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30401259498
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 22:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785536100; cv=none; b=EWCfrUrLbin1GyYyaEH6YLyhGzRK6xVFinlskIBFuoxBmGQnOA3QnkW9vEewMyBinwv76rWPvU3Y2o3HZ5scv2F7FpgMj8rlux6WCZXTE0gNzqGluqukWK4+GN0lMBfViTXKUlIexyL1gLsPvUemFu43MmYzVe0VdKTjPUX/G/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785536100; c=relaxed/simple;
	bh=sLxHu5o1o93beH1Wi5jdXNKFqoXbuUy67L7CEf2p0BY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=q2VJg+LSqaXipcim2HISQ/zABry6cHs4uuyJk4z3vRHnCW71WiJUTlgrm8ROEVoGz7/1Rzyu0RFqMtByHqQp3fsCCmVU1JL5k+68VbTgJxTSsG+KJVSkoEeIAS8K+grIvLMxgTld+NApXJBCTNsDiqpECOnqPDN+ejf76qq7JlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+h/yRA8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+h/yRA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A241F00AC4;
	Fri, 31 Jul 2026 22:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785536098;
	bh=/46je+Kvd9q60p82R71EZdf2xWUJdPgxP/7qJDJ1i+o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=X+h/yRA83exzP2q0RpyrdI1HIOwZnn5WOHxc4LErqbr2G+9mzkH8ZmmvAcOW3M95/
	 uR9NkSELJjlstw7q4mFKnYD0OOh19Uel2lXLdYmT1peOxhGTvSksgZ/Cx2toTh43hb
	 05PwGFUJzS1urMjdAwZWqNEoJ/Am8rHAMAgEk71MDmS8wU2e6r5Wq7BvV05lRpjX6o
	 PXt8vEEDU9uQMIjHOH/jMFDJvJrtVy6vZs0drF8MVUKUR6D7PrQ6OXo50OnAQ0FkOj
	 kxb2+pM4yBELf1LtK6OlFch0byRTn+4axYFBGCzygosJdGs2T1rLcsw6NgBZuBGstF
	 hbjEWLi28FxVw==
Content-Type: multipart/mixed; boundary="===============4125898667089426061=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <94c58ce6291cb55387b002e164f06f9888a516a70e55b8faab480350487c1134@mail.kernel.org>
In-Reply-To: <20260731204917.3845309-1-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260731204917.3845309-1-Jeremy.Jean@oss.cyber.gouv.fr>
Subject: Re: [PATCH bpf] bpf: harden bloom filter allocation sizing on 32-bit kernels
From: bot+bpf-ci@kernel.org
To: Jeremy.Jean@oss.cyber.gouv.fr,bpf@vger.kernel.org
Cc: Jeremy.Jean@oss.cyber.gouv.fr,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 31 Jul 2026 22:14:58 +0000 (UTC)

--===============4125898667089426061==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
> index b73336c976b7..8e6532fa4182 100644
> --- a/kernel/bpf/bloom_filter.c
> +++ b/kernel/bpf/bloom_filter.c
> @@ -94,9 +94,10 @@ static int bloom_map_alloc_check(union bpf_attr *attr)
>
>  static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
>  {
> -	u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
> +	u32 bitset_mask, nr_hash_funcs, nr_bits;
>  	int numa_node = bpf_map_attr_numa_node(attr);
>  	struct bpf_bloom_filter *bloom;
> +	u64 bitset_bytes, alloc_size;
>
>  	if (attr->key_size != 0 || attr->value_size == 0 ||
>  	    attr->max_entries == 0 ||
> @@ -127,23 +128,21 @@ static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
>  	if (check_mul_overflow(attr->max_entries, nr_hash_funcs, &nr_bits) ||
>  	    check_mul_overflow(nr_bits / 5, (u32)7, &nr_bits) ||
>  	    nr_bits > (1UL << 31)) {
> -		/* The bit array size is 2^32 bits but to avoid overflowing the
> -		 * u32, we use U32_MAX, which will round up to the equivalent
> -		 * number of bytes
> -		 */
> -		bitset_bytes = BITS_TO_BYTES(U32_MAX);
>  		bitset_mask = U32_MAX;
>  	} else {
>  		if (nr_bits <= BITS_PER_LONG)
>  			nr_bits = BITS_PER_LONG;
>  		else
>  			nr_bits = roundup_pow_of_two(nr_bits);
> -		bitset_bytes = BITS_TO_BYTES(nr_bits);
>  		bitset_mask = nr_bits - 1;
>  	}
>
> +	bitset_bytes = BITS_TO_BYTES((u64)bitset_mask + 1);
>  	bitset_bytes = roundup(bitset_bytes, sizeof(unsigned long));
> +	if (check_add_overflow((u64)sizeof(*bloom), bitset_bytes, &alloc_size))
> +		return ERR_PTR(-E2BIG);
> +

Can this overflow check ever trigger? Once bitset_bytes is computed in
u64, bitset_mask is at most U32_MAX, so:

    bitset_bytes = BITS_TO_BYTES(0x100000000) = 0x20000000

and roundup(0x20000000, sizeof(unsigned long)) is 0x20000000 (already
word-aligned), i.e. 512 MiB. The sizeof(struct bpf_bloom_filter) addend
is a few hundred bytes. The sum is around 2^29 against a u64 range of
2^64-1, leaving roughly 1.8e19 of headroom, so __builtin_add_overflow()
on the two u64 operands cannot report overflow on any path or arch.

The else branch is even smaller: nr_bits is capped at 2^31 by the
`nr_bits > (1UL << 31)` test above, giving at most 0x10000000 bytes.

If the intent is a real size cap, the check needs to compare bitset_bytes
or alloc_size against a concrete limit. If the intent is only to make the
sizing arithmetic overflow-proof, the u64 change already accomplishes that
on its own and the overflow check can be dropped.

In the commit message:

>     bloom_map_alloc() can under-allocate bloom filter storage on 32-bit
>     kernels when the bitset size reaches the U32_MAX fallback case.
>
>     BITS_TO_BYTES(U32_MAX) is evaluated with 32-bit arithmetic and wraps to 0,
>     while bitset_mask remains U32_MAX. As a result, later bloom filter updates
>     can write beyond the allocated object.
>
>     I reached local privilege escalation using only this bug from a binary with
>     CAP_BPF.
>
>     Compute the bitset size from bitset_mask in u64 and check the final
>     allocation size before calling bpf_map_area_alloc().
                                                         ^^^^

Does the second half of this sentence match what the patch does? The
patch checks whether a u64 addition overflows, which cannot happen given
bitset_bytes is bounded at 0x20000000. No bound on alloc_size is
introduced, so nothing new is rejected for being too large.

The first half of the sentence is accurate and is the entire fix:
computing bitset_bytes from bitset_mask in u64 is what removes the ILP32
truncation.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30666682414
--===============4125898667089426061==--
