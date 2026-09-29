Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC1F501293
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682050; cv=none; b=mKgfsnpr6qtlpaaxao8exBJwtd1aBhmhuDSHEOuaY2whzR0FGkJ9BJmPHWrs/LMnkhKqwWP1rwcbLkXuHE5CvjqRXeaR4J9hbwGfH0MLWrZr19D6ub9cMkGgqQspQ7UDdS0oDMCt3ITAXiEvx9VMOW/XIL/rtw5MIi9yThE4QIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682050; c=relaxed/simple;
	bh=POGUJd2jhXuiDa1zp0LFsoIoA1ove4WyFGFg73LjOVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a2LlAXmrsu36CdOS3EgedGYAonRVMaaOL8/UOzSlSXDriiwQqOO2NihfqZ+Cf0oMtGAOe9D3JXp/4HMjwnnsyJmCJNfANX4xeA6SdcMnTia3/TmAOQ7AHkWhW7v/enqFGFx5GmiG0aB6Wh+emJg1txGXTdfp4l0DCJmyMsrVxUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH5IryQE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH5IryQE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA461F000FF;
	Tue, 29 Sep 2026 11:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790682048;
	bh=hPFmbemxWqB2wBkl76wYh3JiDGijqOQhM8kglqdwdTg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PH5IryQEv6Hi/EPHwhZoDKzGOw//sFTroreeqSGE3E1kKMguRNIIheZTAtL8+0I61
	 FWOyRWyeolBHKgd0u+ywIaT5+V9vouH2QMuqKHDxoOtiaG1QpgX7gR7fPvNRMlOu0t
	 mnirVF/9JbeWc3pMWvdl4BNOAxfoTQ4DcFdLTHg6HnTytJIqSQ17q/2jS9SRP/geHX
	 4ZY8JwDfQ77IcW5ZZtokHQmtKi5txwJZWMQCghsuLUYEdHTWXELjjxb4WQKzFNhvJ8
	 uixEdt0opK+LJwZPCG/icbWnCpN5W2aPy35FMjpkeUzd5rnSLT2ebHiBxR9IS9i9Ug
	 gUzzHczgchM1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 02/15] bpf: Add bpf_skb_fclone_orig() kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-2-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
 <20260928-bpf-meta-gated-tracepoints-v1-2-844dbf3e1edf@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:40:47 +0000
Message-Id: <20260929114048.2DA461F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: UAF/Leak via trusted logically freed skb in bpf_skb_fclone_or=
ig()
- [Low] bpf: kernel-doc parameter mismatch for bpf_skb_fclone_orig
--

commit cbb8066a0a59ac3028e52e52059cc238816dbe14
Author: Jakub Sitnicki <jakub@cloudflare.com>

bpf: Add bpf_skb_fclone_orig() kfunc

This patch introduces a new kfunc bpf_skb_fclone_orig() to allow BPF
programs to retrieve the fast-clone original of a TCP write-queue skb.
This enables associating metadata with the original skb that will show
up during retransmissions.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 33c1ee3b966b0..fdfc1016030a2 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12469,6 +12469,30 @@ __bpf_kfunc bool bpf_skb_is_traced(struct sk_buf=
f *skb)
>  	return skb->traced;
>  }
> =20
> +/**
> + * bpf_skb_fclone_orig() - Return the fast-clone original of an skb
> + * @skb_: socket buffer allocated from the fclone cache

[Severity: Low]
This isn't a bug, but there is a kernel-doc parameter mismatch here.
The documentation refers to @skb_, but the function signature below uses
skb. Could this trigger a warning during W=3D1 builds?

> + *
> + * TCP write-queue skbs are allocated from the fclone cache, the packet
> + * transmitted on the wire is a fast clone. A prog can only associate
> + * metadata with an skb by keying on its address. On retransmission TCP
> + * reuses the write-queue original, a different address with no packet
> + * hook, so the retransmit carries no metadata. A prog can use this kfunc
> + * to retrieve the address of the write-queue original and populate the
> + * metadata stash for it, so the metadata shows up on skb retransmits.
> + *
> + * Return:
> + * * orig skb address  - skb is a fast clone
> + * * %NULL             - skb is not a fast clone
> + */
> +__bpf_kfunc struct sk_buff *bpf_skb_fclone_orig(struct sk_buff *skb)
> +{
> +	if (skb->fclone =3D=3D SKB_FCLONE_CLONE)
> +		return &container_of(skb, struct sk_buff_fclones, skb2)->skb1;
> +
> +	return NULL;
> +}
> +
>  #endif /* CONFIG_SKB_GATED_TRACEPOINTS */

[ ... ]

> @@ -12856,6 +12880,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_skb_meta)
>  BTF_KFUNCS_START(bpf_kfunc_check_set_skb_tracepoints)
>  BTF_ID_FLAGS(func, bpf_trace_skb)
>  BTF_ID_FLAGS(func, bpf_skb_is_traced)
> +BTF_ID_FLAGS(func, bpf_skb_fclone_orig, KF_RET_NULL)

[Severity: High]
Can this allow a BPF program to modify a logically dead skb, leading to a
memory leak or use-after-free?

If TCP receives an ACK and logically frees the original skb (skb1), its
users count drops to 0. If a qdisc or driver later drops the fast clone
(skb2) and triggers a tracepoint, calling bpf_skb_fclone_orig() returns a
pointer to the dead skb1.

Since the kfunc is registered here without KF_ACQUIRE or KF_RCU, does the
verifier treat the returned pointer as implicitly PTR_TRUSTED?

If a BPF program passes this returned skb to bpf_dynptr_from_skb() and
calls bpf_dynptr_write(), pskb_expand_head() could allocate a new head
buffer for the dead skb1, permanently leaking it.

>  BTF_KFUNCS_END(bpf_kfunc_check_set_skb_tracepoints)
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-bpf-meta-g=
ated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com?part=3D2
