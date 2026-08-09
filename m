Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB3D23EAAA
	for <bpf@vger.kernel.org>; Sun,  9 Aug 2026 15:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786289590; cv=none; b=OLgFEP9QK8KwE2nOoiw+BoCIFtbzjMXZLahf2uLu/at9zDMxti+JDCwJ9vPW4ACvGkCPVzimIG+P1PLKjH1HuFGkd/Bw2xW0gWYaIPV++hHyX1sd0HL0nzLvJOkeYA2KG7x3GBZex5L52biyoa6v5RvvJZhr7sSHxa3T4iDK8O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786289590; c=relaxed/simple;
	bh=b7cUC1TG/v5rvKuePm8Di7IUwYpR+SghxE59TPGv57w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=vFetM6f5qsiFFKJVgyY3kG2FXTX78cR0h5vUc9DBuCRjnSYYbI1gpDLoQxEnnnHXAoM6rU6K1oLcoOFDEqonL9RHAMexP7xKE2XemBfEk6HF3DN2LZznZ8gMZQ8Ur2UpWy2mIzWAvyakTLHR9gMDAN5yvEuj8mb1sLjuDWK0vbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJD1uKh1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJD1uKh1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5331D1F000E9;
	Sun,  9 Aug 2026 15:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786289588;
	bh=Slo4xXfoMWS/up38yfRFEuLrKPXOXw7BTNL7n0HjZx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iJD1uKh1MMUiVUTwLjKVkubKcsieSO5lCZyn+QuCgr21lzFKD+z/fUTguxNdnRgre
	 zZJbpVSBNVd1ml8hh9PT4aX+Mt0wAfWUg9Mqu0LsHg5oskiNcyCMCFEWYb+W95BdoB
	 /nQyrRANsecxBWiC8RQY7W0gGOrywym1ytCgm3fgU2aQntowK0ymqO5kU1Aqevg2Pk
	 Janckm//KTLECMS49mjRRFbjbrwDLj0jUVzZfe5sfieXHpb8AXKj7eerSkFlspjX/5
	 8oypUFOeDPu/6+jwNDvD6yrr7dG8ayQofeL2epigOADDWgx0WdWNo/MBZH8vaMdfMf
	 9eIF/lxysMFkw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 04/13] bpf: Add tracing_multi link support for
 bpf progs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260809150111.45000-5-leon.hwang@linux.dev>
References: <20260809150111.45000-1-leon.hwang@linux.dev>
 <20260809150111.45000-5-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 15:33:07 +0000
Message-Id: <20260809153308.5331D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] A text poke failure during the detachment of a `tracing_multi` lin=
k from BPF programs causes a Use-After-Free of the trampoline executable im=
age and a double free.
- [Medium] Trampoline flags are not rolled back when `__bpf_trampoline_link=
_prog` fails during `bpf_trampoline_multi_attach`, permanently corrupting t=
he state of the shared trampoline.
--

--- Patch [4]: [PATCH bpf-next 04/13] bpf: Add tracing_multi link support f=
or bpf progs ---
commit b93dc01dd11e0331789988b67d9503ac3b565c51
Author: Leon Hwang <leon.hwang@linux.dev>

    bpf: Add tracing_multi link support for bpf progs
   =20
    Similar to the tracing_multi link support for kernel functions, add
    support for bpf progs by reusing the 'ids' fields as BTF ids, and adding
    fds array to indicate the target bpf prog. Then, for each pair of fd+id,
    they will be the attach targets of tracing_multi link.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index eddd259d37760..fc51ea2428bee 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -1572,12 +1572,23 @@ static int update_fentry_multi(struct bpf_trampol=
ine *tr, u32 orig_flags,
>  			       struct bpf_tramp_image *im, struct ftrace_hash *hash,
>  			       struct bpf_tracing_multi_data *data)
>  {
> -	unsigned long addr =3D (unsigned long)(im ? im->image : tr->cur_image->=
image);
> +	if (tr->func.ftrace_managed) {
> +		unsigned long addr =3D (unsigned long)(im ? im->image : tr->cur_image-=
>image);
> =20
> -	if (bpf_trampoline_use_jmp(tr->flags))
> -		addr =3D ftrace_jmp_set(addr);
> +		if (bpf_trampoline_use_jmp(tr->flags))
> +			addr =3D ftrace_jmp_set(addr);
> +
> +		ftrace_hash_add(hash, data->entry, tr->ip, addr);
> +	} else {
> +		void *old_addr =3D tr->cur_image ? tr->cur_image->image : NULL;
> +		void *new_addr =3D im ? im->image : NULL;
> +		int ret;
> +
> +		ret =3D bpf_trampoline_update_fentry(tr, orig_flags, old_addr, new_add=
r);
> +		if (ret)
> +			return ret;

[Severity: High]
If bpf_trampoline_update_fentry() fails here, we return the error and bypass
updating tr->cur_image. In bpf_trampoline_multi_detach(), if
__bpf_trampoline_unlink_prog() fails, it logs a warning but continues and
unconditionally calls bpf_trampoline_multi_attach_free().=20

Since tr->cur_image wasn't updated, does bpf_trampoline_multi_attach_free()
end up freeing the currently active executable image, leading to a
use-after-free and a double free on the next attach/detach?

> +	}
> =20
> -	ftrace_hash_add(hash, data->entry, tr->ip, addr);
>  	tr->cur_image =3D im;
>  	return 0;
>  }

[ ... ]

> @@ -1691,6 +1715,9 @@ int bpf_trampoline_multi_attach(struct bpf_prog *pr=
og, u32 *ids,
>  	for_each_mnode(mnode, link) {
>  		bpf_trampoline_multi_attach_init(mnode->trampoline);
> =20
> +		if (progs && progs[i]->aux->tail_call_reachable)
> +			mnode->trampoline->flags |=3D BPF_TRAMP_F_TAIL_CALL_CTX;
> +

[Severity: Medium]
If __bpf_trampoline_link_prog() fails below, the error handler sets
rollback_cnt =3D i and skips rolling back the current node i.

Does this leave the BPF_TRAMP_F_TAIL_CALL_CTX flag permanently set on the
trampoline?

>  		data->entry =3D &mnode->entry;
>  		err =3D __bpf_trampoline_link_prog(&mnode->node, mnode->trampoline, NU=
LL,
>  						 &trampoline_multi_ops, data);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809150111.4500=
0-1-leon.hwang@linux.dev?part=3D4
