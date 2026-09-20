Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA53A8745
	for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915170; cv=none; b=sAhXZVoTFZb6l9Yo5oUUz0vLVV0RuxZNQFGAfGP9DmPLBKuio1nR74ESV6MNSfN/VAW+WFDAllY3lAJHzhZG10FvgllJigdFUW9kbSzitQlPRYN2IZq7F6DUKgKlhzJqeEiyJxo2k622538CHWA1K08uyNtYnMLttn9JlTOB2oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915170; c=relaxed/simple;
	bh=xT02hPZQ5qw/WqNw/gG6/D1uEnPrNw0BQOF3ES744kA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zch3GhcawApnmZztEiEWsCR74h6d3aCS0QtoCMhmQLtBiElROxUKDHyyj1258V7864HskTxzshC7fqGWOQwQCdGLe4NUh4LJnUcm0Iu+1a5h5Pco5mzUWz27GIzb2d/Q1tIfXq3dXjrkHvgc2rXG9dpP6L11bFUH0CdazYS3Q60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hmam6evt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hmam6evt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957781F000FF;
	Sun, 20 Sep 2026 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789915166;
	bh=zSnI6ujFMs4cEfv2uiG0H8x3TJXxAC1JoTqqGO0RIFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hmam6evt/Ar9qIRn0pB3wCVr6V27k5B85OJl0ZOgKSYgTZkDkkykn9eDDjnOYCIMz
	 G44XYu+Mbpen9xTeGuZ5v8CJTrWexf0dHSzSUs6qjfTTZ6Ea0XE04N0YzgG+Y4PYQG
	 /kSqQ784Lv4ZCaZlQAWzOM5QMjBuOKg6VGhCtwdizCt2Tbd80UrlskrEKLvScpNQFC
	 vXTravj4+Dw5wBz4t4W5Ke7CRCFiXI2Gn1E/nEyLZp2MQa3/HqwdvuPtKwJF6/6U61
	 Um0WzLxVHQeQRdfU4MxI/fMLK6JZRrac73rOy0WFvtmE74Enkn11mmqxoUAajSvDwu
	 C/tCfYGAUlVsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net-next 3/9] tcp: record a start time in the tx
 path for SK_BPF_CB_TIMESTAMPING_V2
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260919143732.11772-4-kerneljasonxing@gmail.com>
References: <20260919143732.11772-1-kerneljasonxing@gmail.com>
 <20260919143732.11772-4-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 14:39:26 +0000
Message-Id: <20260920143926.957781F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tcp: concurrent sendmsg corrupts per-syscall sk_start_time
--

commit c712b000347bc5edb0a47ae0ad843a63f0d66b24
Author: Jason Xing <kerneljasonxing@gmail.com>

tcp: record a start time in the tx path for SK_BPF_CB_TIMESTAMPING_V2

This commit adds a new sk_start_time field to struct sock to record the
syscall start time for SK_BPF_CB_TIMESTAMPING_V2. The time is recorded on
entry to tcp_sendmsg_locked() for later propagation into skbs.

> diff --git a/include/net/sock.h b/include/net/sock.h
> index 60ea55dc18854..30e7894c15b43 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
[ ... ]
> @@ -552,6 +553,7 @@ struct sock {
>  #if BITS_PER_LONG=3D=3D32
>  	seqlock_t		sk_stamp_seq;
>  #endif
> +	ktime_t			sk_start_time;

[Severity: Medium]
Is struct sock the appropriate place to store a per-syscall state?

Since this field is in a shared structure, it could be vulnerable to being
overwritten by concurrent calls. Could this time be passed down via a local
execution context like struct sockcm_cookie instead?

>  	int			sk_disconnects;
> =20
>  	union {
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 3ac4856852794..f07abd53ed27f 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -1132,6 +1132,10 @@ int tcp_sendmsg_locked(struct sock *sk, struct msg=
hdr *msg, size_t size)
> =20
>  	flags =3D msg->msg_flags;
> =20
> +	if (static_branch_unlikely(&bpfts_v2_needed_key) &&
> +	    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_TIMESTAMPING_V2))
> +		sk->sk_start_time =3D ktime_get_real();
> +

[Severity: Medium]
Can concurrent sendmsg() calls corrupt this per-syscall start time?

If the current sendmsg() blocks later in tcp_sendmsg_locked() (for example,
while waiting for memory in sk_stream_wait_memory() or for a connection in
sk_stream_wait_connect()), the socket lock is temporarily released.

If another thread executes a concurrent sendmsg() on the same socket, it
will acquire the lock and overwrite sk->sk_start_time here. When the first
thread resumes execution, won't any new SKBs it allocates incorrectly
inherit the second thread's start time?

>  	sockc =3D (struct sockcm_cookie){ .tsflags =3D READ_ONCE(sk->sk_tsflags=
) };
>  	if (msg->msg_controllen) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919143732.1177=
2-1-kerneljasonxing@gmail.com?part=3D3
