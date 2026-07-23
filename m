Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A2044E642
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821766; cv=none; b=tr7LUiKjHWdJGDYgVA7Ez0P+ld4Zcs1u1+EkGQp/iUeARMD0NayWkwqrsIayP77Uxy602HuPqgC2yYFJtfIEHD+lrmqNgX58tY2XC+bTM9GpTNA2ucifaZRgjaLPLIvAat5EVVu4LOrQzeBLIw2wlNqnDUBuMZJLW2hJW4UzH/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821766; c=relaxed/simple;
	bh=AvwXa7bItvG7fUzzJa3c5bfKOIMLSob8RpVRiCpJEvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KJ5bIKXWUAU/r6FY98jiAJrq0NwNjISJNTKW2hrWTg3iJL51VPdcmcfYfSFhXuQLD3Qr5MG80J4vKH7DyUyvle1om96Wcvbx9eTD+4BSAyw1SN4a8rQDevOJSqBKbE/uVACH0zHhpmEV3y2XYZS1l8n/NPjHbFCS+VDK4SOYzIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1321F00A3A;
	Thu, 23 Jul 2026 15:49:20 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] bpf, sockmap: Fix cork ownership in
 tcp_bpf_sendmsg()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengfeng Ye" <nicoyip.dev@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260723153450.3224353-1-nicoyip.dev@gmail.com>
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
 <20260723153450.3224353-1-nicoyip.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 15:49:03 +0000
Message-Id: <20260723154920.DE1321F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Unconditionally freeing the stack-allocated temporary message =
(`&tmp`) on the common exit path causes a Use-After-Free of corked pages.
- [High] Setting `*copied =3D 0` on failed redirects of a corked message wi=
pes out the success count of independent messages sent earlier in the same =
syscall.
--

--- Patch [1]: [PATCH v2] bpf, sockmap: Fix cork ownership in tcp_bpf_sendm=
sg() ---
commit e8fa0f17c7ce1143b0d6775fd8a3f303b4e73ff2
Author: Chengfeng Ye <nicoyip.dev@gmail.com>

bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()

tcp_bpf_sendmsg() keeps msg_tx across sk_stream_wait_memory(), which drops
and reacquires the socket lock. This commit makes temporary ownership expli=
cit
by freeing only &tmp at the common exit, resets cork_bytes when allocating
the persistent cork fails, propagates iterator errors, and clears the copied
count when corked data is discarded.

Link: https://lore.kernel.org/netdev/20260719161630.2901208-1-nicoyip.dev@g=
mail.com/ [v1]

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6d..ce06bc1cff2b6 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c

[ ... ]

> @@ -480,14 +482,15 @@ static int tcp_bpf_send_verdict(struct sock *sk, st=
ruct sk_psock *psock,
>  		if (unlikely(ret < 0)) {
>  			int free =3D sk_msg_free(sk, msg);
> =20
> -			if (!cork)
> +			if (cork)
> +				*copied =3D 0;
> +			else
>  				*copied -=3D free;

[Severity: High]
Does setting *copied to 0 here erase the accumulated byte count of any
independent messages that were successfully transmitted earlier in the same
sendmsg syscall?

In tcp_bpf_sendmsg(), the copied variable tracks the total bytes successful=
ly
sent across multiple iterations of the while loop. Because copied is zeroed
when a corked message fails redirect, tcp_bpf_sendmsg() returns the error
code instead of the number of bytes successfully sent prior to the failure.

Will this cause userspace to assume the entire buffer failed to send and re=
try
sending the first parts, leading to silent data duplication on the network?

>  		}
>  		if (cork) {
>  			sk_msg_free(sk, msg);

[ ... ]

> @@ -588,13 +592,12 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct =
msghdr *msg, size_t size)
>  		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
>  wait_for_memory:
>  		err =3D sk_stream_wait_memory(sk, &timeo);
> -		if (err) {
> -			if (msg_tx && msg_tx !=3D psock->cork)
> -				sk_msg_free(sk, msg_tx);
> +		if (err)
>  			goto out_err;
> -		}
>  	}
>  out_err:
> +	if (msg_tx =3D=3D &tmp)
> +		sk_msg_free(sk, msg_tx);

[Severity: Critical]
Does unconditionally freeing the stack-allocated temporary message (&tmp) h=
ere
cause a use-after-free of corked pages?

When a new cork is initiated on the final iteration of tcp_bpf_sendmsg(),
msg_tx points to the local stack variable tmp. tcp_bpf_send_verdict()
decides to cork it, allocates psock->cork, and performs a shallow copy of
tmp via memcpy(). It returns 0 without clearing tmp.sg.size or tmp.sg.data.

When the while loop finishes, execution falls through to out_err. Because
msg_tx is still &tmp and its state was never cleared after the shallow copy,
sk_msg_free() iterates over the scatterlist and frees all elements.

Doesn't this leave psock->cork holding dangling pointers to these freed pag=
es,
meaning a subsequent send or socket close will trigger a use-after-free?

>  	if (err < 0)
>  		err =3D sk_stream_error(sk, msg->msg_flags, err);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723153450.3224=
353-1-nicoyip.dev@gmail.com?part=3D1
