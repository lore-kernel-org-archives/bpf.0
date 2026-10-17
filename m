Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98893939A4;
	Sat, 17 Oct 2026 17:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792257432; cv=none; b=OTZ9V7VyXJqYTj2VLNUckWPikNC5v3Lz2nFaEUjAmHM71XqoWS2LJIn9EnoGdkuvZMhDc3H18eZALGcOoAlO9Yq0d3yJy3KJJ55p/j56DIFFmH4s0bGu/+3iRDFkFGkcDV16tKlpEKlSoXnRF053PVqaWuW6NcU1g5+9Z5vGmdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792257432; c=relaxed/simple;
	bh=+UMkhZlKP+53Zedn1FweZE7bdjUDdByfB+7t/dNu5a4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rsoNiRy26EOpohc1YzNETqKuB190kHv0QhZC7pSHEeVZzCSbzR6ef+oReqFfM3ubEoyzAMWH7f+gHI6FMMaNN9n3KgRUidkUeQP6NlPcwpUCBYIIIWnEqKaQLIexZO1BpSaHQFCXKpplvm/g7GLKZEFhNiM+0vKYu5J0hF/LjyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KGd6BB7s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KGd6BB7s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED2D1F000C4;
	Sat, 17 Oct 2026 17:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792257431;
	bh=EJNR5K+W76SOP8eD3TWI1W34xOeqGBMNv8XIRZynEyc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=KGd6BB7svaYa75s3jgt14JDbKXgwB7TR/bLrBxq+7/O3Msrr4MhfAkfO8o9S4vsVD
	 5zcZZD0rC4Uwv4biZ0lD/BcBkve296vEdua5PnTW6/NEoEdZAAqQhC2ZbuQW1wFjvL
	 H41eTc/kbA10yZGagmg/7B4cbOi9sb9auV2677KTansjsKSa3JR02dXuMJoRWRnu8k
	 FsPtb/FnfP7mjgztidbZ/JuDvdrO0d80K3+NtSGfUKL/8PQomuJbTveSbIyhLQziij
	 o2U8V7C3pq7LdzDMk1JcEI3ZAfyAh48mX/dIVWgJnA9hIEAnDNIFlPjPHatyIUQWPr
	 OnDfE7cwgwbrg==
Content-Type: multipart/mixed; boundary="===============2037395697687729854=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5ed879575ebbfbb3da9c8c6922ac0a3c13e01637c1d6a01d13c001bf15eff8cc@mail.kernel.org>
In-Reply-To: <20261017163745.3341787-44-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-44-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 43/43] bpf: Refuse packet slices for packet-changing helpers
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,netdev@vger.kernel.org,josef@toxicpanda.com,mason@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 17 Oct 2026 17:17:10 +0000 (UTC)

--===============2037395697687729854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Refuse packet slices for packet-changing helpers

TL;DR: Refusing slices for bpf_skb_store_bytes() may be unneeded after the
previous patch and would newly reject previously safe programs with -EACCES;
the commit message's freed-head claim may be stale.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -9693,6 +9693,16 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg, u32 slot, u32 p
>  	if (err)
>  		return err;
>
> +	/*
> +	 * A slice of a packet is packet data under another name. A helper which
> +	 * may reallocate the packet must not go on reading from the old one.
> +	 */
> +	if (is_helper(meta) && reg_is_dynptr_slice_pkt(reg) &&
> +	    bpf_helper_changes_pkt_data(meta->func_id)) {
> +		verbose(env, "function access to the packet is not allowed\n");
> +		return -EACCES;
> +	}
> +
>  	if (arg_type_is_raw_mem(arg_type))
>  		meta->arg_raw_mem.mask |= BIT(slot);
>

The commit message says of bpf_skb_store_bytes() that "the helper then reads
the old head, which has been freed".  Is that still true after the previous
patch in this series, 0bd8e7a834ac ("bpf: Follow the head if an skb is
written from a slice")?

That patch changed the helper to:

    BPF_CALL_5(bpf_skb_store_bytes, ...)
    {
        ...
        if (unlikely(bpf_try_make_writable_from(skb, offset + len, &from)))
            return -EFAULT;
        ...
        memmove(ptr, from, len);

and bpf_try_make_writable_from() moves 'from' to the new head when it points
into [skb->head, skb_end_pointer(skb)).  So bpf_skb_store_bytes() no longer
reads the old head after a reallocation.  Only bpf_lwt_push_encap(),
bpf_lwt_seg6_store_bytes() and bpf_lwt_seg6_action() still read their
hdr/from/param after skb_cow_head() or bpf_try_make_writable() without
following the head.

The result also looks inconsistent with the suggested alternative.  The
commit message recommends bpf_dynptr_write(), and the verifier still accepts
a slice as its source.  For an skb dynptr that ends up in the same code:

    case BPF_DYNPTR_TYPE_SKB:
        return __bpf_skb_store_bytes(dst->data, dst->offset + offset, src, len, flags);

A program in tc, sk_skb or lwt_xmit that does:

    p = bpf_dynptr_slice(&ptr, off, buf, n);
    bpf_skb_store_bytes(skb, off2, p, n, 0);

has been accepted since 2012c867c800 and is safe with the previous patch
applied.  With this patch it fails to load with -EACCES ("function access to
the packet is not allowed"), via check_helper_call() -> check_func_args() ->
check_func_arg() with is_helper(meta) true, reg typed
PTR_TO_MEM|DYNPTR_TYPE_SKB, and bpf_helper_changes_pkt_data(BPF_FUNC_skb_store_bytes)
returning true.

Should the refusal be limited to the helpers that still read the source
after reallocating the head (or should those helpers follow the head too),
so that bpf_skb_store_bytes() keeps accepting slices?  Either way, should the
commit message stop listing bpf_skb_store_bytes() as reading freed memory?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39051545464
--===============2037395697687729854==--
