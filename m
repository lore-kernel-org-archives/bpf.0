Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF373385B6
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046354; cv=none; b=XCotVEtwZ+M4aTqzPtPVF8qCnNj1Or+y9rdKxZUTv+sp8kYkExnpY5BV3NUqraiOWNKt05MRSUudhbpNeMt6kuBBzn2+loFueQTeMLU/GLjMH/x8OTnoDgXlkbYlbT58v5XBBztWzwr4keEOPyoKy2ztHDThsXqmsdINJkp0Vwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046354; c=relaxed/simple;
	bh=yvKm5ucP9GNL8R+HeH+DXMggyrCHoJ2IB17v6IF/Mh4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X7LEWKVL2MDKPpB8E4I7Ui1Ly+HhtfPEdUUat87udtrlS6Jmv7942mjVQpk5gm9oHtgZvWjhsXpuQFntzEF0BDBBJHp+9i1D1TUYXe7um2joE0TikTQxwt+FNJT/R32g2DK2IAS2NogCsevipuA3kzjJ/wuac91mtvpUdmFZ+lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJbbU1OE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJbbU1OE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19FDC19425;
	Fri, 24 Apr 2026 15:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777046353;
	bh=yvKm5ucP9GNL8R+HeH+DXMggyrCHoJ2IB17v6IF/Mh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WJbbU1OEjEKjgE1GxKhT+BuKWOzo1YFEP6/MzHpZB/Jv2IpKU+MJ0CTfTbFKt7YeQ
	 uFrh4fscqyE09I1aFl854BDDD38OtOY7gi5uJQ6gDmOlrmWBbhyVswrJyU7cZFSxfM
	 iHJM9yrxIwwsAsJts8XTGoenRGTaC2OmO197fOw/kltc+MTolFQ5vZYLtY/yHD2F/y
	 CsmWn2ISLR5R5QFSZLDeHilF94weiTfhAG/Vr5kYCpK7tMvgTYU6Eihl1EQ14H8m2Y
	 kVAC1uuAjUhV8piLK6Wzzc3Hddwh3UUjqYIH3oV6nAHgeffGvXKjKrKDFg1s+b3KEg
	 eOFF76dAnummQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: Fix wrong rsge offset in
 bpf_msg_push_data()
Reply-To: sashiko@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260423155807.1245644-2-bestswngs@gmail.com>
References: <20260423155807.1245644-2-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 15:59:12 +0000
Message-Id: <20260424155913.A19FDC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 4 potential issue(s):
- [Critical] When appending data to a full or nearly full sk_msg, bpf_msg_p=
ush_data() reads the length of the wrong scatterlist element, leading to a =
buffer overflow or ring corruption.
- [Critical] Missing bounds check on the 'len' parameter causes an integer =
overflow and a massive Out-Of-Bounds write.
- [Critical] Scatterlist shifts fail to update the msg->sg.copy bitmap, all=
owing unauthorized modification of shared pages.
- [High] Uninitialized kernel memory allocation in bpf_msg_push_data() lead=
s to an Information Leak.
--

commit 15a0d48ce1bdcc5941167a3e0c2a258bb5038277
Author: Weiming Shi <bestswngs@gmail.com>

bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()

When bpf_msg_push_data() splits a scatterlist element into head and
tail, the tail's page offset is advanced by start instead of
start - offset. This overshoot points to the wrong location within
the page or beyond its boundary.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 5fa9189eb772b2..a7a9ea4cb2f9a4 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2860,7 +2860,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
> =20
>  		psge->length =3D start - offset;
>  		rsge.length -=3D psge->length;
> -		rsge.offset +=3D start;
> +		rsge.offset +=3D start - offset;
> =20
>  		sk_msg_iter_var_next(i);
>  		sg_unmark_end(psge);

This isn't a bug introduced by this patch, but looking at the earlier part
of bpf_msg_push_data(), is the len parameter bounds-checked?

net/core/filter.c:bpf_msg_push_data() {
...
	if (!space || (space =3D=3D 1 && start !=3D offset))
		copy =3D msg->sg.data[i].length;

	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
			   get_order(copy + len));
...
		if (back) {
			from +=3D front;
			to =3D raw + front + len;

			memcpy(to, from, back);
		}
...
}

If a large value is provided for len (e.g., 0xFFFFFFFF), could copy + len
overflow 32-bit arithmetic, resulting in a very small allocation?

Later, when calculating to =3D raw + front + len, does the zero-extended len
advance the destination pointer out-of-bounds, causing a massive memory
corruption during memcpy()?

Additionally, bpf_msg_push_data() uses alloc_pages() without the
__GFP_ZERO flag. After copying the split element's front and back parts,
do the middle len bytes remain uninitialized?

Could this allow uninitialized kernel heap data to be added to the sk_msg
and leaked over the network when the message is transmitted?

Also, when appending data (start =3D=3D msg->sg.size), the search loop term=
inates
with i =3D=3D msg->sg.end. If space <=3D 1, the code executes
copy =3D msg->sg.data[i].length.

Does this read from an unused slot?

If the slot has a garbage length from a previous pop or shift, could copy
take that value, causing alloc_pages() to allocate a smaller size and
leading to a kernel heap buffer overflow during the subsequent
memcpy(raw, from, front)?

And if the garbage length is 0, could it skip the if (copy) block and
increment msg->sg.end without space, corrupting the scatterlist ring array?

Finally, when scatterlist elements are shifted in bpf_msg_pop_data():

net/core/filter.c:sk_msg_shift_left() {
...
	do {
		prev =3D i;
		sk_msg_iter_var_next(i);
		msg->sg.data[prev] =3D msg->sg.data[i];
	} while (i !=3D msg->sg.end);
...
}

Should the msg->sg.copy bitmap also be shifted?

If a shared page (where the copy bit is 1) is shifted into a slot where
the bit is 0, will it be falsely identified as a private page?

Could a subsequent bpf_msg_pull_data() then pass the
!test_bit(i, msg->sg.copy) check and return a direct writable pointer to
the shared page, enabling unauthorized modification of read-only memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423155807.1245=
644-2-bestswngs@gmail.com?part=3D1
