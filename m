Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5F92EEE75
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 16:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441860; cv=none; b=IlyfTWuC5XTxkOZicwnMTUmpN0MuM66JGkG+H4fX/7XiMgSw+VyB4olzVmhgkwHxduBIiPejyDm603dqYev5uPN1hdnODi/eU4x1zYOTskMwhMrZuxNFpiltWNG3hJ1egv14nNK2flXA7HC7sjvUjfuImZ3DikRnwBKUXQHlv+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441860; c=relaxed/simple;
	bh=76LJBpUK1dbQz5LHMk7UKS9lHwVMatxmLviWUIUdMV4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s5rrwtQtsSlsqdQuLBOOV5Av4qELo8aG3tV5m3MopLxvD06a0tN+oy1pay0s8iqP2L2CQXYb8/VODkbCAzpK+CmkG0AtKPWooJWTdt83g8c0kyEgNfQKw9Mc1xx9dMv0tx8DVsCRaYGOuKHJXZK+4lF1WSpgD6XCqtTWre7q62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTHfAds/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTHfAds/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635851F000E9;
	Tue,  7 Jul 2026 16:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783441859;
	bh=XjJa25IiBYfXxRcb2dTMfIkpDDLZxVSRY39oy9+gZ/I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WTHfAds/0fbzFi+f101Dkyc0LyUJYsHeOlpc40xvwW0jflOqGZ1pGQ4wdASprJZIe
	 p7aX+e7sXV1k+64u0/1pXzQHNdCMXwcD6057ooEWx+m2yOMFI6tXtfot2/z8/+vHh0
	 lEGq0akKoopkMo/49UPMcm1dxpERSWy06y6pxxhTFB+cSsbgjZOUoHgJQ/b+HLUG1x
	 r85UxoXaqx/gpBJvRC7zpvuG6arlxUAO92oCx0CjPmhnFsnV06512SH881skN7p8B1
	 DAVK7bQOcm/6P7Tc2C5oWR44zub4oBdazz/u0J+QVWWqMxkmAW6oVjwzV1QY2Xu3gD
	 BtmjR0Gt8Kk6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: Account for receive queue in FIONREAD
 without a verdict program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mattia Meleleo" <mattia.meleleo@coralogix.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>
References: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 16:30:58 +0000
Message-Id: <20260707163059.635851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Missing READ_ONCE() when accessing `psock->progs.stream_verdict`=
 and `psock->progs.skb_verdict` concurrently.

Pre-existing issues:
- [High] Missing equivalent FIONREAD fix for UDP sockets in udp_bpf_ioctl().
--

--- Patch [1]: [PATCH bpf] bpf, sockmap: Account for receive queue in FIONR=
EAD without a verdict program ---
commit 9131d0861f04fc0f5fba703ea6f2e057df4b0975
Author: Mattia Meleleo <mattia.meleleo@coralogix.com>

bpf, sockmap: Account for receive queue in FIONREAD without a verdict progr=
am

This commit fixes tcp_bpf_ioctl() to account for data in the sk_receive_que=
ue
(via tcp_inq()) when answering SIOCINQ for a psock without a verdict progra=
m.
Previously, it only counted bytes diverted to ingress_msg.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6d..a001b1fff578a 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -344,7 +345,20 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, i=
nt *karg)
>  		return -EINVAL;
> =20
>  	slow =3D lock_sock_fast(sk);
> -	*karg =3D sk_psock_msg_inq(sk);
> +	psock =3D sk_psock_get(sk);
> +	if (unlikely(!psock)) {
> +		unlock_sock_fast(sk, slow);
> +		return tcp_ioctl(sk, cmd, karg);
> +	}
> +	*karg =3D sk_psock_get_msg_len_nolock(psock);
> +	/* Without a verdict program, ingress data is never diverted to
> +	 * ingress_msg: it stays in sk_receive_queue and is read through
> +	 * the fallback to tcp_recvmsg(), so account for it like
> +	 * tcp_ioctl() does.
> +	 */
> +	if (!psock->progs.stream_verdict && !psock->progs.skb_verdict)

[Severity: Medium]
Are READ_ONCE() wrappers needed when accessing these verdict program pointe=
rs?

These pointers can be updated concurrently by other threads via xchg() (for
example, when sk_psock_stop_verdict() is called during map detachment under
sk_callback_lock).

Since tcp_bpf_ioctl() reads these pointers holding only lock_sock_fast(),
reading them without READ_ONCE() might constitute a data race and lead to
compiler optimization issues.

[Severity: High]
This isn't a bug introduced by this patch, but does udp_bpf_ioctl() in
net/ipv4/udp_bpf.c need an equivalent fix for UDP sockets?

Looking at udp_bpf_ioctl():

net/ipv4/udp_bpf.c:udp_bpf_ioctl() {
    ...
    if (cmd =3D=3D SIOCINQ) {
        slow =3D lock_sock_fast(sk);
        *karg =3D sk_msg_first_len(sk);
        unlock_sock_fast(sk, slow);
        return 0;
    }
    ...
}

It unconditionally answers SIOCINQ from sk_msg_first_len() and ignores
the standard socket receive queue where data resides when no verdict
program is attached.

FIONREAD returning 0 for a pending UDP datagram causes applications
to allocate insufficient buffer space. Since UDP datagrams are truncated
if the provided buffer is too small, could this lead to silent data loss?

> +		*karg +=3D tcp_inq(sk);
> +	sk_psock_put(sk, psock);
>  	unlock_sock_fast(sk, slow);
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-fionread-n=
o-verdict-v1-1-ce94a72357ec@coralogix.com?part=3D1
