Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795259739;
	b=UzWEillKGyCABmv7EyonrEPn9hh2valMbfSNEirXF+9dkD0KnghtP8c5o9ZIkebPNBbl
	 KeVh54HXlEjwRqHoymwZdkAY/b6p6X9mCuij7xJb3dkOndds+m1Lg52GiBeOFRIeGh1fB
	 dATzLczpG9vaz2tJKqjbaNLfPbsC62Oix67HleW6s8spzTcPeMNz3ttR6GukjBTx63IoP
	 UdjSR+m+jwWvJWd2SOzjy3LYx1bFS+nn+wsNSTnxwmtW3HluIZNU8U8Z27gLGAKUirYhu
	 +8lApuLEWuB5c1kMC/sMEK4KQYpT/U/2rJcj0klj37+Y0d0FjxkOx1AJ5O6r/1KHmMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795259739;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BxL2TsLoBPUgOLYVFlhIU+JjecDHpEYIjR9i0YBsUpg=;
	b=eiNsA+ZFv9LhExNE9/v88BFOde02tOBTzzAA4OKd7+iNWx6iCUYT0EW1JYQ1Kpu5/JAp
	 VyZ88MGK5Lr5bXY6Jp+Leq4x190lGasJYZ/50yPvc+RrCbyuTWwxk5JLreoBCE2Vza1pj
	 8ZwpZIxVfsvsveyGF4w0aP2YO59XaH6oiMo3W8/Q5FKJcWKBXaEN7k2Shp29MbzjmQdvt
	 seX14wjItQaKGJjOJVDeAV1VQa19E9i3TzML+WICvKfvyz+gv5+utA1LuCIKjONKpDgVA
	 5LnCRn0UJt3I4IMTqkwjwMTY7fIN5PhQkXbKw9yoDCDxVmP6WPJs86fc972xOnrRJ3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+TljlXj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC6C606A320
	for <bpf@vger.kernel.org>; Sat, 21 Nov 2026 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+TljlXj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC761F000C4;
	Sat, 21 Nov 2026 11:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795259739;
	bh=BxL2TsLoBPUgOLYVFlhIU+JjecDHpEYIjR9i0YBsUpg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=H+TljlXjvmJHnIGSH6D16Wr9O71LoRixtkJKjmizReYeEc4pZRws1pDdJ8B9LSaIk
	 /yZ7JMdkDEiSDg38i1CXaHXNt2jRdulSBEW4JAs615kNmg6nMxvwFRusSwupOiHJCL
	 mIrbjP+ZS22bewjGHMQHEu/54FlCWhvVhAa9CVEw+xAJ/ltdlrkBQsPwYOjVAeRVcO
	 D4Vk9J8U1q8jRnWsSRaRQxDVDAdhHRd7rmHmLNlRXN4pXS+jZDOn1L4a8tVvrkyQ5o
	 HwyV07X6Toz3/pBj1P2U/B6ukSdXMRYogQURJz0Zw5Qc991djjb4XjMYEg/95XYuYy
	 gQspnAOnDXJWw==
Message-ID: <sashiko-outbox-226975@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 09/11] bpf, sockmap: Fix apply_bytes when a redirect
 sends only a part
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, bpf@vger.kernel.org
In-Reply-To: <20261121103222.88209-10-jiayuan.chen@linux.dev>
References: <20261121103222.88209-1-jiayuan.chen@linux.dev>
 <20261121103222.88209-10-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 11:15:38 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bpf, sockmap: partial ingress redirect re-corks and drops
  verdict
--

commit 0323f7103abecfb3f1dce63a498066c469f02365
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf, sockmap: Fix apply_bytes when a redirect sends only a part

When a redirect in tcp_bpf_send_verdict() sends fewer than tosend bytes,
this commit restores the unsent portion to psock->apply_bytes and preserves
the __SK_REDIRECT verdict and target socket on psock.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index da9caccfede79..25f222b569ec8 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
[ ... ]
> @@ -566,6 +563,21 @@ static int tcp_bpf_send_verdict(struct sock *sk, str=
uct sk_psock *psock,
>  			msg =3D NULL;
>  			ret =3D 0;
>  		}
> +		/*
> +		 * Bytes that were not sent and come back, in msg or in the
> +		 * next sendmsg(), are still covered by the verdict.
> +		 */
> +		if (apply && sent < tosend && !cork) {
> +			psock->apply_bytes +=3D tosend - sent;
> +			if (eval =3D=3D __SK_REDIRECT) {
> +				psock->eval =3D eval;
> +				psock->sk_redir =3D sk_redir;
> +				eval =3D __SK_NONE;
> +			}
> +		}
> +		if (eval =3D=3D __SK_REDIRECT)
> +			sock_put(sk_redir);
> +		sock_put(sk_redir);

[Severity: Medium]
Can a partial ingress redirect of a message with msg->cork_bytes set end up
re-corking the unsent remainder and dropping the preserved __SK_REDIRECT
verdict?

If an sk_msg verdict program uses both bpf_msg_cork_bytes() and
bpf_msg_apply_bytes() (or flushes an existing psock->cork), and
bpf_tcp_ingress() transfers at least one scatterlist element before running
out of receive buffer space on a later element, bpf_tcp_ingress() returns 0
with 0 < sent < tosend and msg->sg.size > 0.  When msg was psock->cork, the
preceding check:

net/ipv4/tcp_bpf.c:tcp_bpf_send_verdict() {
    ...
		if (cork && msg->sg.size && !psock->cork) {
			psock->cork =3D msg;
			cork =3D false;
		}
    ...
}

puts msg back into psock->cork and clears cork, so the new block restores
psock->apply_bytes and psock->eval =3D __SK_REDIRECT, and execution jumps to
more_data.

At more_data, sk_psock_msg_verdict() is skipped because psock->eval is no
longer __SK_NONE, but msg->cork_bytes still holds the original cork thresho=
ld
while msg->sg.size has shrunk by sent:

net/ipv4/tcp_bpf.c:tcp_bpf_send_verdict() {
more_data:
	if (psock->eval =3D=3D __SK_NONE) {
    ...
	}

	if (msg->cork_bytes &&
	    msg->cork_bytes > msg->sg.size && !enospc) {
		psock->cork_bytes =3D msg->cork_bytes - msg->sg.size;
    ...
		sk_msg_reset_curr(msg);
		memcpy(psock->cork, msg, sizeof(*msg));
		return 0;
	}
}

Because msg->cork_bytes > msg->sg.size is now true, this re-corks the unsent
tail (and calls memcpy(psock->cork, msg, sizeof(*msg)) with psock->cork =3D=
=3D msg
when msg was already psock->cork).  On the next sendmsg(), once the new
psock->cork_bytes count is satisfied, tcp_bpf_sendmsg() resets
psock->eval =3D __SK_NONE, losing the preserved __SK_REDIRECT verdict and
re-running the BPF program in the middle of the message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121103222.8820=
9-1-jiayuan.chen@linux.dev?part=3D9
