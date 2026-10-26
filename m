Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986806;
	b=mhRk3nZygS9mUx5FBeRqr0giQcmx2/IThGjAR69zcpxck4XoYGLxPvQiUD1PctcP7xGj
	 rMZ/YwWeBhQVYbK9c2UZ/y0RpdC7WuPo0dvKqWx+t7BBUIllqujGSy2yUzJw0wcD/pxv4
	 4USopNdj6SqiThcKk4yLxgM2uTtVRsP+18exst/HWmA4R9NtZcWufj6uZLxM+AtjFoHnK
	 RUeyTSImNnwIvB4wS32GSDwoskQHUAcbbOy6TuTWiqksPIXprGlM/YcDU1nEoOUQUlAe9
	 Ru+50XdDuseQXtRxtKrq3ui2K+e/FAgU6InTLYFbQ/Yiv3DttAKXqHhlvF5lRwdj1Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986806;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=btqKNhS8T2/5/KBA/4BtdwosZWSqIunQEU3E6IcYmFY=;
	b=Py2KS0Cl9mkUkrPmK3Z4y2xbBB4GbBO0+Oc9dw0/n27qe6tOIOHqKYIDHqZcTLSW/DWy
	 UDhXOQD7dPjqzjBB1xLrrF2cG+AOR2mRKQSXbpoOoY0GWOrbgHplaskjRu9nFM8qKUeN/
	 5PxZ0GDoYkMXDv2KGvgLxGdOwyoLPWgxsl1eTrq3C9ttPs+YogJ1poxSXN5BLtF6imoU/
	 uUkw7yhi2bL+NxfCBSVL0pI6kbfm1dW9qmyR/4ihYXS1w3U1OWEqM8T7/yJK+uqpgHSVk
	 XraeqB0DPb199RhwvGa8MwyFbUDC7PGsXHzbmkLNk5dmNG5hcPRYOwFE/PwKIjiU6mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1zG6dol;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323C4606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X1zG6dol
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34B41F01825;
	Mon, 26 Oct 2026 03:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986806;
	bh=btqKNhS8T2/5/KBA/4BtdwosZWSqIunQEU3E6IcYmFY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=X1zG6dol7oaQWmL9iwY4zTYlYnqNr5A6ZsodbC44WVYwKCRIZE+bVO2+ebvnUMkQG
	 Qoq6SEjNPxEcxlq2yLNKUqRkgzqeSHnSyggv2VDtzRShOrBjr/Nag7OFPfXkpVc/q6
	 WkUfSIesfTncsbBXJ9DOqjzrzuYw3VjMAVid0aU3nKjU0b2uRVUaegsnrJKxnILCIw
	 jVfZ00QKPqWgPLj9QduOXg0Yi11IWqcOPYqfL8gpHvDXvddVy4U9gzXuaRGct9MLfD
	 W3VZK45oZTyHKNkmAKCF+FCL31CtO68GKP4u48Tjb+z3xmHD9nCdv7E6MT/09SbQt6
	 iFXjIyP7fdPQg==
Content-Type: multipart/mixed; boundary="===============7748978955032573617=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <4a603950f9a236bc0adefc6df257d4b9ae8b0f949d9ff0a934f774a609783e35@mail.kernel.org>
In-Reply-To: <20261026025943.404450-42-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-42-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 41/81] selftests/bpf: Test range of a packet pointer after a number is added
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:25 +0000 (UTC)

--===============7748978955032573617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test range of a packet pointer after a number is added

TL;DR: Test issue: the new packet-pointer selftests lack
__flag(BPF_F_ANY_ALIGNMENT), so on kernels without efficient unaligned access
(e.g. riscv64) they may be rejected for misaligned access, and the __msg()
checks may not match.

> diff --git a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
> index 139ff019d87d..aa4abe22655f 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_direct_packet_access.c

[ ... ]

> @@ -1098,4 +1098,379 @@ l0_%=:	r0 = 0;						\
>  	: __clobber_all);
>  }
>  
> +/* 54 bytes are checked. What is added is 38 at most, so there are 16 left. */
> +SEC("tc")
> +__description("direct packet access: a number in a range is added to a checked pointer")
> +__success __retval(0)
> +__naked void pkt_add_range_keeps_range(void)
> +{
> +	asm volatile ("					\
> +	r2 = *(u32*)(r1 + %[__sk_buff_data]);		\
> +	r3 = *(u32*)(r1 + %[__sk_buff_data_end]);	\
> +	r4 = *(u32*)(r1 + %[__sk_buff_mark]);		\
> +	r5 = r2;					\
> +	r5 += 54;					\
> +	if r5 > r3 goto l0_%=;				\
> +	if r4 > 38 goto l0_%=;				\
> +	r2 += r4;					\
> +	r0 = *(u64*)(r2 + 0);				\
> +	r0 = *(u64*)(r2 + 8);				\

Without __flag(BPF_F_ANY_ALIGNMENT), can this test be loaded on kernels
that don't have CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS, such as riscv64 with
its default config?

bpf_check() sets strict alignment in that case:

    env->strict_alignment = !!(attr->prog_flags & BPF_F_STRICT_ALIGNMENT);
    if (!IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
            env->strict_alignment = true;
    if (attr->prog_flags & BPF_F_ANY_ALIGNMENT)
            env->strict_alignment = false;

check_mem_access() calls check_ptr_alignment() before check_packet_access(),
and check_pkt_ptr_alignment() adds NET_IP_ALIGN (2), var_off and the
instruction offset before checking the alignment against the access size:

    reg_off = tnum_add(reg->var_off, tnum_const(ip_align + off));
    if (!tnum_is_aligned(reg_off, size)) {
            ...
            "misaligned packet access off %d+%s+%d size %d\n",

Here r2 = pkt + r4, and r4 is only bounded by "if r4 > 38 goto", so var_off
is (0x0; 0x3f) and the 8-byte loads at r2 + 0 and r2 + 8 are not 8-aligned.
Wouldn't the verifier reject this __success test with:

    misaligned packet access off 2+(0x0; 0x3f)+0 size 8

[ ... ]

> +SEC("tc")
> +__description("direct packet access: a number in a range is added, load past range")
> +__failure __msg("invalid access to packet, off=47 size=8, R2(id={{[0-9]+}},off=47,r=54)")
> +__naked void pkt_add_range_load_past_range(void)
[ ... ]
> +	r0 = *(u64*)(r2 + 9);				\

The same applies to this test, and to pkt_add_range_twice and
pkt_add_negative_drops_range, which also do 8-byte loads at unaligned
offsets from a pointer with a variable offset (r2 + 9, r2 + 5, r2 + 6 and
r2 + 0 with r4 in [-4, 4]).

Those three are __failure tests, so on such kernels would they be rejected at
the alignment check instead?  The expected message, for example:

    invalid access to packet, off=47 size=8, R2(id={{[0-9]+}},off=47,r=54)

would then never appear in the log, and the __msg() would not match.

Other tests in this file that do multi-byte packet loads at a variable or
unaligned offset, such as the "x += pkt_ptr" tests test20 to test24 and
"checked pointer minus non-negative unknown keeps range", set
__flag(BPF_F_ANY_ALIGNMENT).  Should these four tests set it as well?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============7748978955032573617==--
