Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795360670;
	b=rTCVqYMFyYiWulNrvbEkTopjRTrR8QwnOtpJnEiMzXHT8PmsZa7kyzo5b1u0LlgfMT0Y
	 EOIWq338wppjKVPGzJT3HcYxqdrlOCObSADTCYLJueIoxp3wmEpsBx7sl5XvB1pAvr2SV
	 53sQ3mdcgj2cxsEn6DmMIh3I/JEFCl8SZ87w5yfO0cZ+KPgFi+23TlCGKCmOOMBrWpWcj
	 +G3j5vi4dg6pKpHRy97PPwn+ZUyb+Qus+7rQZCceUwq5N2ZEL7ZIIllylEtOuZrPAKuXh
	 hvFRnyi34WMRMFZzL47qt7O/0UmXA2uuGHvJ76dW5U83aAzhHYX7PPv93hJvzIxKWRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795360670;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=gIIbVkTXPuo9374QlWA8aMkGpR0GRxfRcvXlcVd/Gk8=;
	b=GB6WX0VoDgZvh2LcI1R4J6j0jG0TmIUHQP+elGnFsPoXxhZ8O4vaxFEQFQeUxeg4Qmev
	 I5ZHjEipmqPHwI28+LN6YkRfNeidUmgOVjHLRJpJL78LhtbCypOd/uN+myeczMNqQhCoN
	 j/X0SPCcYXCOKFwPUIGbdOlan/+4cigwvs91McojdzXLtCidZfK936YMw6fj8h18og1RR
	 q8U5q0msf3fZd/qWyDymHHEEzEdFrwz+dRUIM0aXqwAVWpuPmIpfCmGV4O9TEKxk4FjnO
	 L9ghLvtwSLB44LI3S4nmsnWcECu4fr60AWI8pbJrDblNFI6Xwel25d7L85jSXCP8txQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqKoDkku;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1348D606A330;
	Sun, 22 Nov 2026 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gqKoDkku
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447811F000CA;
	Sun, 22 Nov 2026 15:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795360669;
	bh=gIIbVkTXPuo9374QlWA8aMkGpR0GRxfRcvXlcVd/Gk8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gqKoDkkuGHuGAZIVjdL2Kd/UApNG3xKQ48GRQsT+Y1h2nRX3QP3mH0Qv34EAy5Rv5
	 3U0GKu4nXtSdR0wmtxfDlEpoJBBYJZSexaKzPu6uhs/D3pSJ+h01bh/EVP/DOCP/eq
	 QnMR4hEUM99MMpCbmeeiJ5z6S43rXnZBUuriIGCHMcs9DaLrLUpvgE6WCtf6YAl0t3
	 1N8qDbynsDXbUEBLNF8T9wrOnqIvKCea2FTUu66UAK96cRJHD7ElLHtpiRgArWb0Qu
	 MptbYXKIzMX8ZffidWUwIgjSZbvqyOEPhsN32JFooNiO2KvFOY4epNRR1RpWUdiT3c
	 vtYdIs8eZR5VQ==
Content-Type: multipart/mixed; boundary="===============4519172269265903290=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <9b699575619446beb43aac4209af0de5b6a87be1613b734ce3f009c36a551bae@mail.kernel.org>
In-Reply-To: <20261122143815.330528-2-abhishekkhade69@gmail.com>
References: <20261122143815.330528-2-abhishekkhade69@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Add bpf_memmem and bpf_dynptr_memmem kfuncs
From: bot+bpf-ci@kernel.org
To: abhishekkhade69@gmail.com,bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,abhishekkhade69@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun, 22 Nov 2026 15:17:48 +0000 (UTC)

--===============4519172269265903290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add bpf_memmem and bpf_dynptr_memmem kfuncs

TL;DR: bpf_dynptr_memmem() may return -EINVAL for skb/xdp packets with
non-linear (frag) data, so packet searches can fail even when the needle is
present; the error is also ambiguous.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> +__bpf_kfunc long bpf_dynptr_memmem(const struct bpf_dynptr *haystack,
> +				   const void *needle, u32 needle__sz,
> +				   u64 flags)
> +{

[ ... ]

> +	size = __bpf_dynptr_size(ptr);
> +	if (size > BPF_MEMMEM_MAX_LEN)
> +		return -E2BIG;
> +	if (size == 0 || needle__sz > size)
> +		return -EINVAL;
> +
> +	data = __bpf_dynptr_data(ptr, size);
> +	if (!data)
> +		return -EINVAL;

Can this return -EINVAL for the packet inspection cases the commit message
describes?

__bpf_dynptr_data(ptr, size) is bpf_dynptr_slice(p, 0, NULL, size) with no
bounce buffer.  For BPF_DYNPTR_TYPE_SKB that ends up in
skb_pointer_if_linear(), which returns NULL whenever size > skb_headlen(skb).

For BPF_DYNPTR_TYPE_XDP, bpf_xdp_pointer() returns NULL or an ERR_PTR when
the range crosses into frags or is larger than 0xffff.  For
BPF_DYNPTR_TYPE_FILE, bpf_file_fetch_bytes() returns -EINVAL for a NULL
buffer, so it always fails.

A TC program calling bpf_dynptr_from_skb(skb, 0, &d) gets a dynptr covering
skb->len, and received skbs commonly keep most of their payload in page
frags.  For a typical packet larger than the linear head, such as a TLS
ClientHello, the call fails even though the needle is present.

The neighbouring dynptr kfuncs handle non-linear data explicitly.
bpf_dynptr_memset() falls back to __bpf_dynptr_write() in chunks, and
bpf_dynptr_copy() falls back to __bpf_dynptr_read()/__bpf_dynptr_write().

The kernel-doc lists "non-linear buffer" under -EINVAL, but that code is
shared with invalid flags and invalid parameters (including needle__sz >
size).  A program cannot tell "call bpf_skb_pull_data() and retry" from a
real argument error, nor from a packet that is simply shorter than the
needle, which arguably should be -ENOENT (bpf_strnstr() returns -ENOENT in
that case).

Should bpf_dynptr_memmem() search non-linear skb/xdp data, for example by
scanning slices with a needle_sz - 1 overlap, or at least return a distinct
error for the non-linear case?  Should the commit message say that TC packet
payloads usually have to be linearized first?

> +
> +	match = __bpf_memmem(data, size, needle, needle__sz);
> +	if (!match)
> +		return -ENOENT;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45034767598
--===============4519172269265903290==--
