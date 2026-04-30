Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD4E37BE73
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 22:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777588292; cv=none; b=sgPp+cg/TF6vR9cwz1rLuPSNH/ONmSg7ATxJYooOnB1dUhALg9yeDLdGGF1CJEMyV14eo3zLo7KGHoqezsKNKCRzwwwWntcd0DURFTk8SY5kTLvlLHcrhvTXKowZa4iuYfHgurk4kFOinokql8deqqOYqXt4JM/4Do3tzEBRwSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777588292; c=relaxed/simple;
	bh=Ap9beHesaSn4v8zlLqcFKsQvDoBe28vVgaKzcWhIOL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=prIB1LD0Jxl5cLH/z8KFbWTbJfIvEz1Kc8bTRcEs11uF2jwA+1G/VElvAqbuIdg/M6jxIxCSDrlLkD/CBV1GbiiaAXUUrkk4LnaAP//IyrhcDudzar+PP4v/I7T1cA0qY5jYZLqyBFQnh4Z6wMieAdKRPAMEJGnt2a7MHxa3cBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1fFz+CC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1fFz+CC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0047FC2BCB4;
	Thu, 30 Apr 2026 22:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777588292;
	bh=Ap9beHesaSn4v8zlLqcFKsQvDoBe28vVgaKzcWhIOL0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=D1fFz+CCFKPHWgU8cnxnnjWD8aXBBQCPsVT7v41n/I0CTY+0UXq579gjihqVK1LJm
	 AL3klU5Com+EIwE3CEhlcC+VeDBD1AEQIHbPrkzvV7OfHsUNqrn0p3BUUIXxQNnu6r
	 ctZbAl69S+MViOnF66PrQT3OjMwrhky+oSHx0a1QHsqelYqYEzUzDVgaD7aQYgCy0z
	 sCLCYEAYscT5B8qWDrmi635OhN+hXR1RjzC7CSyECHa6BPdgRnJYfZLuQINUEIKCzs
	 YcQljN72W/2dTV1b+FuyOw60kgB7xMa5cEpLWWyM2zNkziwCKDlyRge+C4KPxoWC/b
	 7NDNTdK2vs84w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 4/7] net: tls: fix off-by-one in sg_chain entry
 count for wrapped sk_msg ring
Reply-To: sashiko@lists.linux.dev
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429222944.2139041-5-kuba@kernel.org>
References: <20260429222944.2139041-5-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 22:31:31 +0000
Message-Id: <20260430223132.0047FC2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] In TLS 1.3, a wrapped scatterlist with `end =3D=3D 0` creates =
a chain-to-chain pointer structure that the scatterlist API cannot traverse=
, leading to invalid `struct page` dereferences in the crypto engine.
--

commit ea91dff65607bff05b2c2e5b43839119ab72f451
Author: Jakub Kicinski <kuba@kernel.org>

net: tls: fix off-by-one in sg_chain entry count for wrapped sk_msg ring

This commit fixes the entry count passed to sg_chain when chaining a
wrapped sk_msg ring. It replaces MAX_SKB_FRAGS with NR_MSG_FRAG_IDS to
ensure the chaining pointer lands in the correct reserved slot.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index bf8f022e1895..2c6a3c4a9fcc 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
[ ... ]
>  	if (prot->version =3D=3D TLS_1_3_VERSION) {
>  		/* Add content type to end of message.  No padding added */
>  		sg_set_buf(&rec->sg_content_type, &rec->content_type, 1);
>  		sg_mark_end(&rec->sg_content_type);
>  		sg_chain(msg_pl->sg.data, msg_pl->sg.end + 1,
>  			 &rec->sg_content_type);
>  	} else {
>  		sg_mark_end(sk_msg_elem(msg_pl, i));
>  	}
> =20
>  	if (msg_pl->sg.end < msg_pl->sg.start) {
>  		sg_chain(&msg_pl->sg.data[msg_pl->sg.start],
> -			 MAX_SKB_FRAGS - msg_pl->sg.start + 1,
> +			 NR_MSG_FRAG_IDS - msg_pl->sg.start + 1,
>  			 msg_pl->sg.data);
>  	}

If the wrapped message perfectly fills the end of the array such that
msg_pl->sg.end is 0, does the TLS 1.3 block create a chain pointer at
msg_pl->sg.data[0]?

Because the ring wrapped, the second sg_chain call links the tail of the
array to msg_pl->sg.data, which starts at index 0.

This would create a chain where the wrap link points directly to another ch=
ain
link. The scatterlist API sg_next iterator does not recursively resolve
consecutive chain links.

When stepping past the end of the ring, sg_next would follow the wrap chain,
land on msg_pl->sg.data[0], and return that chain element directly to the
caller.

If the crypto engine then calls sg_page on this returned element, could it
interpret the chain pointer as a struct page address and panic?

While this patch fixes the ring modulus so it no longer corrupts valid payl=
oad
data, does the underlying double-chain issue still exist for TLS 1.3 records
that wrap exactly at msg_pl->sg.end =3D=3D 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429222944.2139=
041-1-kuba@kernel.org?part=3D4
