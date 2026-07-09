Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA1449991
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 18:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623330; cv=none; b=qmD8n+dMQwamxq6HmqHfPeUgdyViN+BLEEZz4o8fN1sxq0yD6t1BtAZa4JAWtNn3ZWl1nK4HlD3peOG0BzbxlwpBy7E+Kl7M0ajTXB/z0UTXlb0o1+wnArpzYSpyRUZ3/1FQHfCWGoFUCRYFOtyRVMhCwlHcXasL1ujtgZ7LDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623330; c=relaxed/simple;
	bh=aMTYAUn7llZZIPNmb6iRnHHXE8mHMkvDlMwRwb/LBjA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E4KkswzcLM350WoBgg0M33o7NYuM+eR2bwe085XehHzQoh/K6pmv9Jh2djpVYvexiakQGCMlPfTZMimG6DHzP3kl2e4G3WFetIvIutVLIfq42mbdjkYi3n8nz20gJWWkbpzkFBll+I8l6xbJPrY5+9zRcxZ4tBTihUjngInEG7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFwJTNYa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFwJTNYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DAB1F000E9;
	Thu,  9 Jul 2026 18:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783623327;
	bh=ZYClI+GMwP/CIfuZcEQcGNjXdJDj4Oz7ZY7r9fwlzV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oFwJTNYaAYI2y0ABojPqRiiBT5ywM3eV65WzNxI6yCJUaIw+s4exsmZAY6Lh1OsAM
	 m3yPDfxwMpOOEwjNp9ySPk2Obv96qdEbJigdhQgD6kvpgIt4uxVfvBfyl07qH1z0sI
	 i/UnvgWPIv6qaIjBlWgAijTaThq6X1jS/rHuGyFgcS5qp2XVNoz/9mDf4Cs/+delvI
	 oY1GIsNt7lHV0g0/b8moTVlgZhtmKTpgtRDGijyvdHP+PetlP6nxdFkoR6IhzCaHPw
	 Z54D5aM0EGk8GaH4w9gxi5r0AP5FB9z2pPtspYBCcTzwaSgW0+Yq8feHsnl7ivlS5e
	 b0RxMIz7OUavQ==
From: sashiko-bot@kernel.org
Subject: Re: [BUG] bpf, sockmap: spurious wakeup by tcp_msg_wait_data()
 causing unexpected EAGAIN in recvfrom()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nnamdi Onyeyiri" <nnamdio@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <ak_rR-Skd8Mvn4mH@localhost.localdomain>
References: <ak_rR-Skd8Mvn4mH@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:55:26 +0000
Message-Id: <20260709185526.E4DAB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Critical] The patch introduces an unkillable infinite kernel loop (DoS) =
in `tcp_bpf_recvmsg` when a blocking socket without a receive timeout recei=
ves a signal.

Pre-existing issues:
- [High] A race condition during stream parsing causes blocking sockets to =
prematurely return `-EAGAIN` when data is present.
- [High] The patch fails to fix spurious wakeups for sockets with finite re=
ceive timeouts (SO_RCVTIMEO), leaving them susceptible to premature -EAGAIN=
 returns.
--

--- Patch [1]: [BUG] bpf, sockmap: spurious wakeup by tcp_msg_wait_data() c=
ausing unexpected EAGAIN in recvfrom() ---
commit 39fdd170f1532151400920cba0bc08398cb63cb8
Author: Nnamdi Onyeyiri <nnamdio@gmail.com>

bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup

This patch attempts to resolve unexpected EAGAIN errors on blocking
ipv4 tcp sockets added to a sockmap by looping on spurious wakeups.
It adds checks in tcp_bpf_recvmsg and tcp_bpf_recvmsg_parser to
jump back to msg_bytes_ready when no data is found and there is no
receive timeout configured.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6d..38fd391ffdb31 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -317,6 +317,8 @@ static int tcp_bpf_recvmsg_parser(struct sock *sk,
>  		}
>  		if (data && !sk_psock_queue_empty(psock))
>  			goto msg_bytes_ready;

[Severity: High]
This is a pre-existing issue, but does this logic incorrectly assume that if
data is present, the parsed data is already in the psock?

If data arrives in sk_receive_queue and triggers a wakeup, but the
thread re-acquires lock_sock before the stream parser can execute and
populate psock->ingress_msg, we bypass the retry and erroneously return
-EAGAIN.

> +		if (!data && timeo =3D=3D MAX_SCHEDULE_TIMEOUT)
> +			goto msg_bytes_ready;

[Severity: High]
This is a pre-existing issue, but does this skip the fix for sockets
configured with finite timeouts (SO_RCVTIMEO)?

By explicitly checking for MAX_SCHEDULE_TIMEOUT, finite timeouts will
still randomly fail with -EAGAIN on spurious wakeups.

Additionally, because tcp_msg_wait_data() takes timeo by value, the
remaining time calculated by sk_wait_event() is discarded. If this loop
were enabled for finite timeouts, it would reset the timeout on every
iteration.

[ ... ]

> @@ -390,6 +392,8 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>  			sk_psock_put(sk, psock);
>  			return tcp_recvmsg(sk, msg, len, flags);
>  		}
> +		if (!data && timeo =3D=3D MAX_SCHEDULE_TIMEOUT)
> +			goto msg_bytes_ready;

[Severity: Critical]
Could this new unconditional branch cause an infinite kernel loop if the
process receives a signal?

Unlike tcp_bpf_recvmsg_parser(), tcp_bpf_recvmsg() lacks a
signal_pending(current) check inside its loop. If a blocking socket
without a timeout receives a signal, sk_wait_event() returns immediately
without sleeping.=20

The new check then jumps back to msg_bytes_ready, causing the kernel=20
to spin indefinitely without delivering the signal, resulting in a=20
denial of service.

>  		copied =3D -EAGAIN;
>  	}
>  	ret =3D copied;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/ak_rR-Skd8Mvn4mH@lo=
calhost.localdomain?part=3D1
