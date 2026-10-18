Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5A523395D
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792288102; cv=none; b=APINk0g8tBUmviCTuM80EHWtuITukbkSFgdVSq+YQqyiYJ7gHHlyaKLjU8dLOGrRA6gsyH/pM0cxbKkNBDL1kZ7Dupz/9MMKwVoc+s6c3FPi6n/rz0g1tsc65RHrTjmGSInM6IHKQyonOXFjn/qHZ+BwQhcMqTB5vwXjQAwly0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792288102; c=relaxed/simple;
	bh=TZnlImL1jN8rkNbNKThUcLWXxeIy8vofb1LTOd8Jh7A=;
	h=Message-ID:From:Subject:To:In-Reply-To:References:Content-Type:
	 Date; b=Pl2tqzXDDPFPdB31JHE1J7ML3St0M/z1070LF27XbD9tzQgsq7Hxf2MA1n9QD2IbMsuKlQ+giZ1cZPCo+rV1Lv2dB7M3iTfJuQz+kSSezII0dV/taj301T5UOXOd1NgVR/DYn5jeExenjQyCGYQyRQ9GBK4HXudtJJD94pkKNUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dahOQWXv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dahOQWXv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26AB1F000C4;
	Sun, 18 Oct 2026 01:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792288100;
	bh=bLD08TFGMCF3mDjOv4/aI+/2GsoE/EG9uFRpMpODtg8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dahOQWXvZNDok2Nr+9/7IRKlPy4LnGmhxgrnKpUWDk9dHA8vI4Mky68Pt8LkuniTT
	 aZGBWcxqFQHvGvt/YlvD15SBBYzhgBf9xJVS+W4dXmZ9E+dweKSUiwfVtkMmRwdWT8
	 M2dJox1yO7KIqLr+s9RJjYfHKcrqRYSVA+nTtyLtCtGoW1oLhzWuDROoMRgJnVUyz6
	 NnJ8wsjCtkJJxrc0TMsCMHIJj8WXsRdzd2ir0MBkAW7b4YpdmZZ04wTBf0//GXX9YE
	 bD0mZ3UQ9gVj1EQeWX4YYpsaMuLVGDRo+Wo+1P4mc7Wb1gESK0w0DxuxM7QW4iqGIp
	 IC3eIYakMzorg==
Message-ID: <sashiko-outbox-175875@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: Refuse the prologue for an extension if
 callers keep packet pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261018012753.1724147-1-alexei.starovoitov@gmail.com>
References: <20261018012753.1724147-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 01:48:20 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: bypass of called_with_pkt_ptrs check in bpf_check_ext_pro=
logue()
--

commit 83bf0cef185c53983f34422c2173a9a0850a623f
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Refuse the prologue for an extension if callers keep packet pointers

This commit tracks whether global subprograms that do not change packet data
are called while packet pointers or packet dynptr slices are held. It
refuses loading or attaching an extension program with a prologue to such a
function unless the target program already has a prologue of its own.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 63fff641d9858..c31287d2231c0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -22209,6 +22230,30 @@ static int check_unreliable_func_args(struct bpf=
_verifier_log *log, struct btf *
>  	return -EINVAL;
>  }
> =20
> +/*
> + * The prologue of an extension gives a cloned skb a new head, unless the
> + * prologue of the target program has done that. The callers of the func=
tion
> + * that it replaces must not hold on to the old head.
> + */
> +int bpf_check_ext_prologue(struct bpf_verifier_log *log,
> +			   const struct bpf_prog *tgt_prog, u32 btf_id)
> +{
> +	const struct bpf_prog_aux *aux =3D tgt_prog->aux;
> +	int i;
> +
> +	if (aux->has_prologue)
> +		return 0;
> +
> +	for (i =3D 0; i < aux->func_info_cnt; i++)
> +		if (aux->func_info[i].type_id =3D=3D btf_id &&
> +		    !aux->func_info_aux[i].called_with_pkt_ptrs)
> +			return 0;

[Severity: Critical]
Can this loop in bpf_check_ext_prologue() bypass the called_with_pkt_ptrs
check if two subprograms in aux->func_info[] share the same type_id?

During program load, prepare_btf_func() and check_btf_func() in
kernel/bpf/check_btf.c verify that each krecord[i].type_id references a
BTF_KIND_FUNC, but do not require type_id to be unique across subprograms:

kernel/bpf/check_btf.c:prepare_btf_func() {
	...
		/* check type_id */
		type =3D btf_type_by_id(btf, krecord[i].type_id);
		if (!type || !btf_type_is_func(type)) {
			verbose(env, "invalid type id %d in func info",
				krecord[i].type_id);
			goto err_free;
		}
	...
}

When resolving the attach target in bpf_check_attach_target(), the loop
stops at the first subprogram matching btf_id and attaches the extension
trampoline to tgt_prog->aux->func[subprog]->bpf_func:

kernel/bpf/verifier.c:bpf_check_attach_target() {
	...
		for (i =3D 0; i < aux->func_info_cnt; i++)
			if (aux->func_info[i].type_id =3D=3D btf_id) {
				subprog =3D i;
				break;
			}
	...
}

However, in bpf_check_ext_prologue(), if the first subprogram matching
btf_id has called_with_pkt_ptrs set to true, the loop does not break and
continues scanning aux->func_info[]. If a subsequent subprogram shares the
same btf_id and has called_with_pkt_ptrs set to false,
bpf_check_ext_prologue() returns 0 even though the extension replaces the
first matching subprogram, allowing bpf_unclone_prologue() to reallocate
skb->head while callers of that first subprogram still hold packet pointers.

Should bpf_check_ext_prologue() stop at the first entry matching btf_id (or
take the resolved subprog index directly)?

> +
> +	bpf_log(log,
> +		"Extension writing packet data cannot replace a function whose callers=
 keep packet pointers\n");
> +	return -EINVAL;
> +}

[ ... ]

>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261018012753.1724=
147-1-alexei.starovoitov@gmail.com?part=3D1
