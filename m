Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1126175A83
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 01:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781142971; cv=none; b=qUCLBw1w7WWU9h1zWwk/iXS1Mw94U4TQpwhvH3M3FcBUDVru1w4K5LiAl+xvyBHpWjcmm221bxlgndhBqAB/QOrBUI6J0Chb0T5NLYtb6FF+4GUG2ZsCaP9R8NICaypwYR5Lvq6P+7qN4ihKUqtKH53MjW6gqXPGi+KMHd2x3Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781142971; c=relaxed/simple;
	bh=FtwHRhr89jS/PdI7BAPrgp2zPKyMFOJU2nJYJuEzXOw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tw1oXW0E3eVYSmRS8D22K/eym7gjAufVETVGMlasCUwfbMWKP0uJZCKPHR9ZFpcoqRpFWawFZWXwMHfPKuxYpw3ugVXxDOJAWGPJvRlfcrRHJuu/Y2gYOCNZuTP2ds52hCGpTU0JtgSRsbZmP/r2w64HyBWGQwVzW93RqRshelg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtmkGTEg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtmkGTEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BEF1F00893;
	Thu, 11 Jun 2026 01:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781142970;
	bh=PaX5JL6MC6XEmjH9Ol80liAJ9UL/sxxih6DHXfHEZOQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MtmkGTEgxbqebX4aBVfwEgzNwn/jPe3uaIt4dciFyJ1yFb0G6dosA/tUCjDmOJ3lt
	 I+MVyRSiSzjv96Srvmc8Kqc5rw7OCXm6fvbP3igWOtl7o9w7gdhJYCMYBccHGhj9oC
	 NAn//SKURVPEoWxFgEwJr+Ips3iHbOzbk0LGD0RC9L+PRssan/PKTE2azRM5e8/oZ2
	 VDKF9vXHj3JK1835XZdwFMuQpqPVNTQstoPNCndPdqKTXSJZE6abK17G2PrAgA3f71
	 Wt8rISy3uzJHzKquYSO8+YSmTXDoVMRozdJti9I1wMM95NqjeAauU+XAgytMXSy1U/
	 JhK9jJaqiuNJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/4] bpf, sockmap: Fix wrong rsge offset in
 bpf_msg_push_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611013547.247039-3-jiayuan.chen@linux.dev>
References: <20260611013547.247039-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 01:56:09 +0000
Message-Id: <20260611015610.64BEF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `bpf_msg_push_data` incorrectly reads the length of an uniniti=
alized ring buffer slot when appending data to a full `sk_msg`, leading to =
ring buffer destruction and an infinite loop/crash during message free.
- [High] bpf_msg_push_data allocates uninitialized memory causing a kernel =
info leak.
--

commit d70a24eef21929f8e8a694f6c0b71f98f2d76089
Author: Weiming Shi <bestswngs@gmail.com>

bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()

When bpf_msg_push_data() splits a scatterlist element into head and
tail, the tail's page offset is advanced by start (absolute message
byte offset) instead of start - offset (byte position within the
element). This makes rsge.offset overshoot by offset bytes, pointing
to the wrong location within the page or beyond its boundary. Consumers
of the corrupted entry either silently read wrong data or trigger an
out-of-bounds access.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3c8f1cedb217f..3e555f276ba80 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2828,8 +2828,6 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
>  	if (!space || (space =3D=3D 1 && start !=3D offset))
>  		copy =3D msg->sg.data[i].length;

[Severity: Critical]
This is a pre-existing issue, but does this incorrectly read the length of =
an
uninitialized ring buffer slot when appending data to a full sk_msg?

When bpf_msg_push_data() is called to append data exactly at the end of a
full sk_msg (where space =3D=3D 0), the scatterlist search loop finishes wi=
th
i =3D=3D msg->sg.end. It then seems to read copy =3D msg->sg.data[i].length,
accessing an uninitialized length from the unused slot at msg->sg.end.

If this garbage copy value is > 0, the function allocates an oversized page
and sets the new scatterlist element's length to len + copy, but
msg->sg.size is only incremented by len. Could this cause msg->sg.size to
underflow during __sk_msg_free(), leading to an infinite loop and double
free?

If the garbage copy value is 0, the code later executes
sk_msg_iter_next(msg, end). Doesn't this increment msg->sg.end and wrap it
to msg->sg.start, destroying the ring buffer state and leading to
memory leaks or corruption?

> =20
>  	if (unlikely(copy + len < copy))
>  		return -EINVAL;
> =20
>  	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
>  			   get_order(copy + len));

[Severity: High]
This isn't a bug introduced by this patch, but could this allocation be mis=
sing
the __GFP_ZERO flag?

When bpf_msg_push_data() inserts new space into a socket message, it
copies existing data to the front and back of the new page, but appears to
leave the newly inserted len bytes uninitialized.

In the non-copy path, the entire page is added to the scatterlist
uninitialized. Could this uninitialized kernel memory be exposed to the
sk_msg scatterlist and transmitted to the network or read by userspace via
tcp_bpf_push(), causing a kernel information leak?

It appears a later patch in the series (6cfebe959c2ffe911ff763388e942ea998f=
90682)
claims to fix this in its commit message, but it mistakenly patches
bpf_msg_pull_data() instead of bpf_msg_push_data(), leaving this issue
unfixed.

>  	if (unlikely(!page))
>  		return -ENOMEM;

[ ... ]

> @@ -2872,7 +2872,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
> =20
>  		psge->length =3D start - offset;
>  		rsge.length -=3D psge->length;
> -		rsge.offset +=3D start;
> +		rsge.offset +=3D start - offset;
> =20
>  		sk_msg_iter_var_next(i);
>  		sg_unmark_end(psge);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611013547.2470=
39-1-jiayuan.chen@linux.dev?part=3D2
