Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF21356A38
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 06:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781158926; cv=none; b=C0Nv3GnepbKqnTyk/JvkJ9B0TRDEoxCmhnhv4K5Dkh+BCYEB0aysjG3Dq86ikr3AAHN6BrXTu52JCPh41mb8RJTY6KanD6Lycopu7bUPuuav+Y8gud1H1jmNq2cc6ENOVfYNsfsKhN4rb02ExHkBlX/blcFX/1FVBKY0k/WPNTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781158926; c=relaxed/simple;
	bh=NKXWTwpEMHlK04Y+2vYChx2QJlezAiFtE3vu5EHbouw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jm3ZixF5yPKeG4LEhBEZGlcBKlqv4aFxtek6ZepC4Ks+yB3WpsaA+3lrsSrMwEA0DwIkP4eX+qVm5nL9PdjIf9w6bXYpor/GTiuEvLHOP8dS9GjgCNQKoBeqZOURZp86ctETPcmy/KNczxvfXTBIE837C56eASF8EmxpuLVaxYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfdr5zpw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfdr5zpw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334FA1F00898;
	Thu, 11 Jun 2026 06:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781158925;
	bh=w1LTw6H1WWyBCEtTKur/mL6cB0saZWCCtsM6WSMD3To=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nfdr5zpw/aRRPtf5U6uxfhVMw/2IY6g7t3jZ9nmNmtjwWuU+B2Y8JXP9zGkcJ6p8J
	 rMDflVTZXeNETS7aSjyM6vKmI/hSt8qjv9MZZDc6WURR138yQbecxbjMmzUVWt3NSE
	 ZSexONBKy1UyN09hQhrBijFqwpTVi4J3/fUDARb5tKlgx1b7fI3WR4VWBxULWwZXuF
	 u2WYPcuG0PFnerUPRs9oY2uCsGLGnXu9+b1JfAe3EmOgZ7H/VBD6Ner1dZXV2+m5J0
	 DseqoL1/GVF55uWV18fz3gVv1Ogjad7WuFstJU5BHKovQjPuZDhs+2a2RJGFrUct57
	 1V3WjQVgHp91A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net: skmsg: preserve sg.copy across SG
 transforms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiming Qian" <yimingqian591@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260610062137.49075-1-yimingqian591@gmail.com>
References: <20260610062137.49075-1-yimingqian591@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 06:22:04 +0000
Message-Id: <20260611062205.334FA1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized kernel memory is inserted into the socket buffer in =
`bpf_msg_push_data()`, leading to an info leak.
--

commit 7ed2bff662b24eab5d89d14d0b0a5178d47b9247
Author: Yiming Qian <yimingqian591@gmail.com>
Subject: net: skmsg: preserve sg.copy across SG transforms

Keep sg.copy synchronized with sg.data[] whenever entries are transferred,
shifted, split, or copied into a new sk_msg. Clear the bit when an entry is
replaced by a newly allocated private page or freed.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 80439767e0eea..40037413dd4ec 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -2837,30 +2841,30 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, ms=
g, u32, start,
>  		copy =3D msg->sg.data[i].length;
> =20
>  	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
>  			   get_order(copy + len));

[Severity: High]
This is a pre-existing issue, but does this allocation lack __GFP_ZERO?

When bpf_msg_push_data() dynamically expands an sk_msg, a new memory
page is allocated here. Without the __GFP_ZERO flag, this page may
contain uninitialized memory.

>  	if (unlikely(!page))
>  		return -ENOMEM;
> =20
>  	if (copy) {
>  		int front, back;
> =20
>  		raw =3D page_address(page);
> =20
>  		if (i =3D=3D msg->sg.end)
>  			sk_msg_iter_var_prev(i);
>  		psge =3D sk_msg_elem(msg, i);
>  		front =3D start - offset;
>  		back =3D psge->length - front;
>  		from =3D sg_virt(psge);
> =20
>  		if (front)
>  			memcpy(raw, from, front);
> =20
>  		if (back) {
>  			from +=3D front;
>  			to =3D raw + front + len;
> =20
>  			memcpy(to, from, back);
>  		}

[Severity: High]
This is a pre-existing issue, but does this copy logic leave the newly
inserted len bytes completely untouched?

Since the BPF verifier doesn't enforce that dynamically pushed data is
actually written to by the BPF program, these uninitialized bytes can
remain in the buffer.

Because sk_msg structures can be sent over the network or received by
userspace via recvmsg(), can this lead to an information leak of
sensitive kernel memory?

Could this be prevented by zeroing the page initially, similar to how it
is handled in bpf_skb_generic_push() for bpf_skb_adjust_room()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610062137.4907=
5-1-yimingqian591@gmail.com?part=3D1
