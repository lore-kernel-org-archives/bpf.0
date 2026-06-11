Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F5D25B0B8
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781142475; cv=none; b=OUrgnG28qwoC0jpQ5iw4i+i/7rMAkVe+/ccAk+3xEi7hmzQzvJ9NGrxVLZrxTbbzJknOZT9JzOEELu03k2qRTwKWT8MKgDO52lij8gdggVRKH/XCemDVnGQoUPXG8EdlVf3UNxUd4He01znuM+bq4c0hVamIOUeASZ39wUJKC0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781142475; c=relaxed/simple;
	bh=nn9ZXuVZ/hjKeC9/ukr3huIKLhu2eJGl680E7ROphz4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VyD3Sy3JCywPGxSfidUj7lA2UYcuFqAolWAWLwoOGsws6vXqcx/lkLTkvkHocCpeYATJMJ05V+ZcDzXZnkvGAwEYqDuJJMT4YdizPGqfZjdZbGtXOXLVX+4lGxSz7kKlsiJ+qXi7WCsoojLAfaV+8nymP+4021+tBOsfsDHyB+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bL+yRBis; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bL+yRBis"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5E11F00898;
	Thu, 11 Jun 2026 01:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781142474;
	bh=BDY6iaxu2+7C+CP9H0QvJQxV/LQ6FmC+ptq9gqXsFtc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bL+yRBisrB3kbE7djNfciUFfwbaLFrJ/veLtW5HfU41EWfKIZgojw7yRWMP41yJNp
	 FKfGeIXNRRz29AsWIr+wDsHORiDEHmKQj7dOcHt29AuqCa7hnymQWtr0454PfnaL9r
	 AadJuqoOauT4YwWP0sGvepZvgtMZn7Etvi5ihRhDYYVgblGiUdSqbV611/d442BnlH
	 nuwOSVW5iG4KpNNJ7mhKvEZepQ4Sj8BhK+sYAqONF9DLgrASRafswLYTM2HRrcHJ0A
	 la4g8kd+HcWNfLHRpLrjnscBcC5d/dz6DC9SI7rjFyAYg82SBt+30xeuDjM6Q5XItZ
	 3nk7u/veoZkfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 4/4] bpf, sockmap: keep sk_msg copy state in sync
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611013547.247039-5-jiayuan.chen@linux.dev>
References: <20260611013547.247039-5-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 01:47:53 +0000
Message-Id: <20260611014753.EC5E11F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uninitialized memory disclosure in bpf_msg_push_data() due to miss=
ing __GFP_ZERO.
--

commit 4e239ebdfdc9495774d38523350637e9a010cf74
Author: Zhang Cen <rollkingzzc@gmail.com>

bpf, sockmap: keep sk_msg copy state in sync

This commit fixes an issue where modifying helpers like bpf_msg_push_data()
rewrite the scatterlist ring but leave the copy bitmap unsynchronized. It
keeps the msg->sg.copy bitmap synchronized with scatterlist entry moves to
prevent data corruption.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 982d59cf659f5..95961b4e66a6d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
[ ... ]
> @@ -2918,13 +2973,18 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, ms=
g, u32, start,
>  	/* Place newly allocated data buffer */
>  	sk_mem_charge(msg->sk, len);
>  	msg->sg.size +=3D len;
> -	__clear_bit(new, msg->sg.copy);
> +	sk_msg_clear_elem_copy(msg, new);
>  	sg_set_page(&msg->sg.data[new], page, len + copy, 0);

[Severity: High]
This is a pre-existing issue, but does this allocation lack initialization?

When the page is allocated earlier in bpf_msg_push_data() via alloc_pages()
without the __GFP_ZERO flag:

    page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
                       get_order(copy + len));

The newly inserted payload space of size len is not zeroed. Then it is
added to the scatterlist here via sg_set_page().

Could this lead to an uninitialized memory disclosure over the network?
If copy is 0, the entire page might be left uninitialized. If copy is
greater than 0, the gap of len bytes between the copied front and back
portions might be uninitialized.

Because the BPF verifier cannot enforce that a BPF program initializes this
newly inserted space before the packet is sent, could the kernel transmit
uninitialized page memory?

>  	if (rsge.length) {
>  		get_page(sg_page(&rsge));
>  		sk_msg_iter_var_next(new);
>  		msg->sg.data[new] =3D rsge;
> +		if (rsge_copy)
> +			sk_msg_set_elem_copy(msg, new);
> +		else
> +			sk_msg_clear_elem_copy(msg, new);
>  	}
> +	sk_msg_clear_elem_copy(msg, msg->sg.end);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611013547.2470=
39-1-jiayuan.chen@linux.dev?part=3D4
