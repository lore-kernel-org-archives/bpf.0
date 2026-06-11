Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046EC3AC0C0
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 12:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182454; cv=none; b=Rdq/687DBfWsnBPkRdawe1RejmqUQb6o8PSiDSJybkHSDiqsilUxTjGobKEqA3lIVH8TVYG+y5NXcllYnHgbAO/1a8e3aqmv+8Dn+5tJIrJ4lJDLD54n6ZbMoTzt2np2CDB+kC9xALfo+74VN99tPX0TMvkCSEA8CmuZmVWcetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182454; c=relaxed/simple;
	bh=qy2bmGf6dq8kht4xSi5Q+4DcHvPABXRB+7qgmntn9ek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=F6JogCtF8dZ3zlPUmZ1hV66dDxu9+EToxQk/XsYUB534Ki0zt0Y6LDfozS9x1057iOpnYISdmXumG5h4pmpZkgo7B/hhe/dXnr8QcxdehAoEIRmcjEm1mwUJAkmGZwLcTnj7zBCpnshgTFJ5hz8+TU4cFOXrBWtax04/O3CdS/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LneOc1Ti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LneOc1Ti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 669491F00893;
	Thu, 11 Jun 2026 12:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781182450;
	bh=jERi/YbqTRVDMBsgqi97AJV6iX5WGS+du3XbLZtsXYI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LneOc1Ti+zUqkQPpUhDys/8yeH/xqeJ7UHlNeHkJxe++6jt2K13S78QRivBgqhu8w
	 IOaanOipMoJC3m5mFpGR00qCpyJyf+zOPHvDUkSnHL2G4631JWHA0BzLdVGoKkGbQO
	 DsR9fY+FxFSJkGqp5GVHsqKZdDy1MRNCBiadaOjth4iHu1mu88JEeIciZZjoGbXw8v
	 O0w+sImLgYhgdK9Qfa0QUtBh8MmU2xm+B3KQrI2klW8OGy40apYkg+SqYACyFiNsxf
	 ZBen7S4hdPCzaLaR4VScF2acJTJ2qO9JxUF1nX62g6twY4wJG8ufWKDd2PlAJCj+xo
	 /GPVBedNwKmeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/7] bpf, sockmap: Fix wrong rsge offset in
 bpf_msg_push_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611123538.156005-3-jiayuan.chen@linux.dev>
References: <20260611123538.156005-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 12:54:09 +0000
Message-Id: <20260611125410.669491F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] bpf_msg_push_data() reads a stale scatterlist length from an u=
nused ring buffer slot when appending to the end of a message, leading to s=
evere memory corruption, buffer overflows, and ring corruption.
--

commit db7f1ec823fbb81c9afb65284fd3f58d01a87a71
Author: Weiming Shi <bestswngs@gmail.com>

bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()

This commit fixes an issue in bpf_msg_push_data() where splitting a scatter=
list
element incorrectly advanced the tail's page offset by the absolute message
byte offset (start) instead of the byte position within the element
(start - offset). This caused rsge.offset to overshoot, leading to
out-of-bounds accesses.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3c8f1cedb217f..3e555f276ba80 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2872,7 +2872,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,

[Severity: Critical]
This is a pre-existing issue, but does bpf_msg_push_data() read a stale
length from an unused ring buffer slot when appending to the end of a messa=
ge?

When appending data to the end of the sk_msg ring (where
start =3D=3D msg->sg.size), the loop iterating over the scatterlist evaluat=
es
all valid elements and terminates with i =3D=3D msg->sg.end:

net/core/filter.c:bpf_msg_push_data() {
    ...
	do {
		offset +=3D l;
		l =3D sk_msg_elem(msg, i)->length;

		if (start < offset + l)
			break;
		sk_msg_iter_var_next(i);
	} while (i !=3D msg->sg.end);
    ...
}

After this loop, the code evaluates the space and reads the copy length:

    if (!space || (space =3D=3D 1 && start !=3D offset))
		copy =3D msg->sg.data[i].length;

Because start !=3D offset evaluates to true when appending, this reads
msg->sg.data[msg->sg.end].length. This slot is outside the valid ring
bounds and contains a stale, garbage length from prior operations.

This garbage copy value can lead to severe memory corruption and buffer
overflows. For example, if copy is non-zero, it allocates a buffer based
on copy + len. Later, it copies front bytes into the new allocation using
memcpy:

	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
			   get_order(copy + len));
    ...
		if (front)
			memcpy(raw, from, front);

Since front is the size of the actual last element, and the stale copy
value can be small, front can easily exceed the allocated page size,
causing memcpy to overflow the allocated page.

Additionally, if the stale copy value happens to be 0 on a completely full
ring, the code skips the allocation, executes sk_msg_iter_next(msg, end)
unconditionally, and wraps msg->sg.end to equal msg->sg.start, permanently
leaking all message pages.

Could this garbage read lead to memory corruption, buffer overflows, and
ring corruption?

> =20
>  		psge->length =3D start - offset;
>  		rsge.length -=3D psge->length;
> -		rsge.offset +=3D start;
> +		rsge.offset +=3D start - offset;
> =20
>  		sk_msg_iter_var_next(i);
>  		sg_unmark_end(psge);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611123538.1560=
05-1-jiayuan.chen@linux.dev?part=3D2
