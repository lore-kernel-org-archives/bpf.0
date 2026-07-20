Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F2C40B375
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784564225; cv=none; b=A8ZLgqld35i6NJBcZ2G6jwzjSPaUOKVKHe16Ddxm2YUF1tlGCyF53fjaR27LzcBUrHoVqb3foLBA718HQLQJ0gAQZA/3vQWbQNBsdW2+UwbWnVwJabFFCGOIMVptIEWY+2pPQYUd+E5poY1lHGiuEyPcM0AtwctWJykGkupkJp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784564225; c=relaxed/simple;
	bh=edLGNt4G4ZS6qfuxngTbuaHtYMD8R/TKwhzCfNFh5rY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BayIudsXeOa9VLwaq9zhxZpOYr6cVai5ql04++tYL5m0io6fd/kpoHIXi17NMjspRNJSBlCLV5faIhs2ZsbG1I+oF9ix27lFid3kgXEOxLUxx2mH3ySaULbSVruyBW8fX7PhrjKrDnfZpfY6p3p4tKeil5o9UoUTPuILMoaZ5zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+AfUf+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+AfUf+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E934F1F00A3A;
	Mon, 20 Jul 2026 16:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784564223;
	bh=tE3xyi6LyYX/nBQJNsOeYVuffcr8U8Ggz18uzsGaHNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E+AfUf+f+/5Dq4K1G2dqOGPB6fKExmrhO+UHkEkt4E713zS4Km3b7D2+kyewPjn6X
	 aSzpCq26rlQUTqD7hroFCGDqr9o2NOb5NWRYfaIc49Wp/OPUVYcfPKP/IkcDCHXv7f
	 l6POAVl4s2vNnugPHIZ5qMKUCUeixaj2ZIvu+jg4HY/sxog5uBfPJ4f3tRXffEAhZ3
	 kjYcvyBj/2VrXrgR67qcFsRqBW/kefNl9HvMavJdaE7wIEHy2r7Qv6kYnp9LrPk2bH
	 /x7ItSymN9QuPkOpc8343NrNLiRF1MO7nQsTpmXvobK5whO/YVFRBEeRh1YUCfAc/g
	 mnLd8tEVC9YOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf, sockmap: Fix cork use-after-free in
 tcp_bpf_sendmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengfeng Ye" <nicoyip.dev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 16:17:02 +0000
Message-Id: <20260720161702.E934F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of stack-allocated `tmp` scatterlist pages when aborti=
ng via `goto out_err`.
- [High] Lost error code from `sk_msg_memcopy_from_iter` causes sendmsg to =
incorrectly return 0 instead of propagating -EFAULT.
- [High] Silent data loss on `__SK_REDIRECT` failure for corked messages du=
e to masked error.
- [Medium] Overlapping `memcpy()` when corking an already-corked message.
--

--- Patch [1]: [PATCH] bpf, sockmap: Fix cork use-after-free in tcp_bpf_sen=
dmsg() ---
commit ef0d38759a207a519b5d12273a55446155a7d5f4
Author: Chengfeng Ye <nicoyip.dev@gmail.com>

bpf, sockmap: Fix cork use-after-free in tcp_bpf_sendmsg()

tcp_bpf_sendmsg() keeps msg_tx across sk_stream_wait_memory(), which drops
and reacquires the socket lock. This commit fixes a use-after-free where a
stale cork could be mistaken for the local temporary message and freed agai=
n.
It tests for tmp directly instead of comparing with psock->cork.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6d..b9f0366333653 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -589,7 +589,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct ms=
ghdr *msg, size_t size)
>  wait_for_memory:
>  		err =3D sk_stream_wait_memory(sk, &timeo);
>  		if (err) {
> -			if (msg_tx && msg_tx !=3D psock->cork)
> +			if (msg_tx =3D=3D &tmp)
>  				sk_msg_free(sk, msg_tx);

[Severity: High]
This isn't a bug introduced by this patch, but can this leak page references
or memory for the stack-allocated tmp?

If kzalloc_obj() for psock->cork fails in tcp_bpf_send_verdict(), returning
-ENOMEM but leaving psock->cork_bytes > 0, and userspace retries sendmsg(),
msg_tx defaults to the stack-allocated &tmp.

Data is copied into tmp, allocating pages. The code then hits:
if (psock->cork_bytes && !enospc)
    goto out_err;

And the out_err block returns without freeing tmp. Unprivileged userspace
could repeatedly trigger this state after a single induced -ENOMEM, leaking
pages on subsequent small sendmsg() calls.

>  			goto out_err;

[Severity: High]
This is a pre-existing issue, but does this goto out_err drop the
error code from sk_msg_memcopy_from_iter()?

Earlier in tcp_bpf_sendmsg():
ret =3D sk_msg_memcopy_from_iter(sk, &msg->msg_iter, msg_tx, copy);
if (ret < 0) {
    sk_msg_trim(sk, msg_tx, osize);
    goto out_err;
}

The out_err block returns err (which is initialized to 0), rather than ret.
If a local user passes a bad pointer, it will get a 0 return value instead
of -EFAULT, which usually causes userspace blocking socket writes to spin
endlessly.

>  		}

[Severity: Medium]
This isn't a bug introduced by this patch, but does tcp_bpf_send_verdict()
trigger an overlapping memory copy?

If a BPF program evaluates an already-corked message and assigns a new
cork_bytes threshold that exceeds the current size, tcp_bpf_send_verdict()
executes:

memcpy(psock->cork, msg, sizeof(*msg));

If msg is identical to psock->cork, this results in an overlapping memory
copy onto itself. This can violate the C standard and trigger UBSAN panics.

[Severity: High]
This is a pre-existing issue, but does tcp_bpf_send_verdict() silently
drop data on __SK_REDIRECT failure for corked messages?

If a redirected message is corked and tcp_bpf_sendmsg_redir() fails, the
code frees the message:

if (cork) {
    sk_msg_free(sk, msg);
    kfree(msg);
    msg =3D NULL;
    ret =3D 0;
}

This intentionally skips subtracting the freed bytes from *copied and
overwrites ret =3D 0. This causes tcp_bpf_sendmsg() to assume success,
continue processing the user's buffer, and return a positive byte count
to userspace despite dropping the corked data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719161630.2901=
208-1-nicoyip.dev@gmail.com?part=3D1
