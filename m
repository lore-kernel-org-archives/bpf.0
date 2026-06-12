Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE223EA96F
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270827; cv=none; b=XeAJDxYBLCixxu/NUdkRDVvgD8rN/adBjxwfNZGcA1+IiL3GRgDfE/VNk3uAQsFRmGPEblIzBQHwFQMk85pCtTlT3xEGQeyLE9TgB5g7lwGsgTARrIHWwsbtgyut3GMYdx67/rA26Q7WrCmOJ1gDyxtIybE41dfbUhuWBbuU8ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270827; c=relaxed/simple;
	bh=x7nreBbyzWJJeotAtKdjiAxmjBIKsn9fwyNjz5YWEvk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rq/Je2MsJ6RDPHwKu+UJ+XKpemw/jyVltZ0qql2nPEC1XPP/MfTQSD0cYQqagW98fKIXkcfTaDb4eLTtXcFryR/Kf0qbB5erEDXHC05Qs+LHU29ClqLsseScymRH82fpaNRGLNyST8KknTqfpcNKvZbma22sMvymd2KuV/l2GiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qsf6IOsm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qsf6IOsm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4234B1F00A3A;
	Fri, 12 Jun 2026 13:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781270826;
	bh=dNo/vHMb4zRkuNDrzMr+RziZIkxkHGa8olxeL1FLMq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qsf6IOsm4omz1vY0158onv9WXdKOhzW2Wv+r7C9equ+e9HdDIvvZB7N8OafR7TFdm
	 ZAK9ypfkjTz9VEI+u/yF5ScPTt2VpvA88/kcO6vRBImwDVhPdu19KXKRLSF4t32RBo
	 dD5wYVcn6c37C7+czx4KtaJpwUpCoAbit8MFZml9xl30LOZK8tYLH7D1tQtE+dNM4J
	 fppUMyfR56iYRrb7g2uZI9fkZ09gyB/GZZ4DjsJIuz+WRSAk2KGkpXfsrjM+Ilh0NZ
	 7vD7DPdf7bmQwHHXtD8/MAtJZgabyb3NsJ+/RbTdCuKeRsOq1IhrEiI6F/CdBqXrGt
	 2fnXJ/nYyMjHg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 2/7] bpf, sockmap: Fix wrong rsge offset in
 bpf_msg_push_data()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260612130919.299124-3-jiayuan.chen@linux.dev>
References: <20260612130919.299124-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 13:27:05 +0000
Message-Id: <20260612132706.4234B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] bpf_msg_push_data() reads a stale length from an unused scatte=
rlist slot, leading to ring buffer corruption and heap buffer overflow.
--

commit ef70ae10ad1afdbbdad4040b6aeb609d2f14aad4
Author: Weiming Shi <bestswngs@gmail.com>

    bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
   =20
    When bpf_msg_push_data() splits a scatterlist element into head and
    tail, the tail's page offset is advanced by `start` (absolute message
    byte offset) instead of `start - offset` (byte position within the
    element). This makes rsge.offset overshoot by `offset` bytes, pointing
    to the wrong location within the page or beyond its boundary. Consumers
    of the corrupted entry either silently read wrong data or trigger an
    out-of-bounds access.
   =20
    [ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3c8f1cedb217f..3e555f276ba80 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
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

[Severity: Critical]
This is a pre-existing issue, but I have a question about how we handle
scatterlist elements when appending data in bpf_msg_push_data().

When appending data to the end of a message (where start =3D=3D msg->sg.siz=
e),
the search loop exits with i =3D=3D msg->sg.end. If the ring buffer is full=
 or
near full (space <=3D 1), the fallback path initializes copy:

	if (!space || (space =3D=3D 1 && start !=3D offset))
		copy =3D msg->sg.data[i].length;

Could this read a stale length from an unused scatterlist slot since i poin=
ts
to msg->sg.end?

If copy > 0, we then allocate a page using this stale copy value:

	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
			   get_order(copy + len));

And later, fetch the actual last element and copy data into it:

	if (copy) {
		...
		if (i =3D=3D msg->sg.end)
			sk_msg_iter_var_prev(i);
		psge =3D sk_msg_elem(msg, i);
		front =3D start - offset;
		...
		if (front)
			memcpy(raw, from, front);

If the page order determined by the stale copy value is smaller than what
psge->length requires, can this result in an out-of-bounds write and
corrupt adjacent kernel memory?

Additionally, if the stale length is 0, the allocation succeeds but the copy
path is bypassed. The code later does:

	/* Slot(s) to place newly allocated data */
	sk_msg_iter_next(msg, end);

If the ring was full (space =3D=3D 0), does advancing msg->sg.end wrap it to
equal start, incorrectly signaling an empty ring buffer and leaking all
existing fragments?

Note: An uninitialized memory leak here was fixed by a subsequent patch
"bpf, sockmap: zero-initialize pages allocated in bpf_msg_push_data", but
these corruption and overflow paths appear to remain unaddressed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612130919.2991=
24-1-jiayuan.chen@linux.dev?part=3D2
