Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1946A364059
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783531021; cv=none; b=j6hytNvSkxR6+J6VZl6QDQtbf8Pz9dU6q3OXA10sJrcjUpgTw4lS/eVIlnuM2jb6pioyk33wnl2WgFpZZMKTf5bsMAq5H6PyEzFWnvTue+VSwvUhOVz3CjD9kOEwl5bWcobObhOz5mOeM/EBqKS4JvIh9g+Z9T6h86QO6BnJdIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783531021; c=relaxed/simple;
	bh=MdqnTckS9z3WCIvq1hafAbu82nAhp8qhfKuTLY8+5jY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V/O3RE7ncMoTrgd+zkBtA6Mf2APP2r30DXUifqkYWznNhMYAvDyl/FQ8yFsWOZwLdZ+16yooSR+gQFpPFqA6GxcLaK4mWnspgQrCCOA0TCLcVVNiHZ+YlcrVPRRc1w2Uhh3eA0WRNID1O4iyRYAgV/7w68NxaxW5u/3YwL/jEXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxRM4cA8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxRM4cA8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8695B1F000E9;
	Wed,  8 Jul 2026 17:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783531019;
	bh=dVZ3nqeHBGyLU8ZnE5SZ7De1yjRjgbm+sHC3yPHWntQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YxRM4cA8Iohx/lqU1ZPjIK0da9FfZhPbZRs1lPYExXcFkT2+Vc9h6FOiHrh/J0855
	 8j/MtUoeU4dAbCEnYm1stUJIzZybDyAymafXRoZnE+iB3zMucGwqvAHm4NOlkuUp7Q
	 McP3XhFk5XannSFWCNa/HOKWF+/K9SlsIJ8sqFWdqt/x/NUd5H4yi6skMAqSWbCHCO
	 TihPapkmg9L+Lat5r6g3g+4fJ5hAHMW7/pxKvPQZOnR+manEVu8VRf+ibe17CXkO9X
	 8lkpKCyKZ+TO+9ivN0Mpkgbawyzj3dW6Z01U7mrbcKFZDcZDUMug9P9E73QplmSP+9
	 cGJYOvbQFSFGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/2] bpf, sockmap: Account for receive queue in
 FIONREAD without a verdict program
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mattia Meleleo" <mattia.meleleo@coralogix.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708-fionread-no-verdict-v3-1-b4ee31b3af53@coralogix.com>
References: <20260708-fionread-no-verdict-v3-0-b4ee31b3af53@coralogix.com>
 <20260708-fionread-no-verdict-v3-1-b4ee31b3af53@coralogix.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 17:16:59 +0000
Message-Id: <20260708171659.8695B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] FIONREAD (SIOCINQ) double-counts available bytes when a verdict pr=
ogram is detached, exposes negative values, and under-reports bytes when a =
verdict program is active.

Pre-existing issues:
- [High] udp_bpf_ioctl() suffers from the exact same bug that this patch fi=
xes for tcp_bpf_ioctl(). Without a verdict program, data stays in sk_receiv=
e_queue and UDP FIONREAD returns 0.
- [High] Data race and sequence number corruption in psock->ingress_bytes d=
uring SK_REDIRECT.
--

--- Patch [1]: [PATCH bpf v3 1/2] bpf, sockmap: Account for receive queue i=
n FIONREAD without a verdict program ---
commit fc144ea49f61a51adcd404a526d68065c61d0452
Author: Mattia Meleleo <mattia.meleleo@coralogix.com>

bpf, sockmap: Account for receive queue in FIONREAD without a verdict progr=
am

This commit modifies tcp_bpf_ioctl() to add the output of tcp_inq() to the
reported FIONREAD value when no stream or skb verdict program is attached.
This correctly accounts for data resting in sk_receive_queue that has not
been diverted to the ingress_msg list.

> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index cc0bd73f36b6d..8e905b50deadb 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
[ ... ]
> @@ -344,7 +345,21 @@ static int tcp_bpf_ioctl(struct sock *sk, int cmd, i=
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
> +	if (!READ_ONCE(psock->progs.stream_verdict) &&
> +	    !READ_ONCE(psock->progs.skb_verdict))
> +		*karg +=3D tcp_inq(sk);

[Severity: High]
Does this conditional logic double-count available bytes or under-report th=
em
in some situations?

If a stream verdict program is attached, data is queued (which delays
tp->copied_seq), and then the program is detached. The unread bytes sit in
both msg_tot_len (ingress_msg) and are also reflected in tcp_inq(sk) because
copied_seq was held back. Adding them together here would double-count the
available data.

Conversely, when a verdict program is active, tcp_inq(sk) is ignored. Could
this fail to account for unparsed data in sk_receive_queue, leading to an
under-reported value?

> +	sk_psock_put(sk, psock);
>  	unlock_sock_fast(sk, slow);
> =20
>  	return 0;

[Severity: High]
This isn't a bug introduced by this patch, but udp_bpf_ioctl() in
net/ipv4/udp_bpf.c appears to suffer from the exact same bug that this patch
fixes for tcp_bpf_ioctl().

net/ipv4/udp_bpf.c:udp_bpf_ioctl() {
    ...
    *karg =3D sk_msg_first_len(sk);
    ...
}

Without a verdict program, data stays in sk_receive_queue, and UDP FIONREAD
constantly returns 0. Could a similar fallback to the native receive queue =
be
applied there to prevent user-space applications from hanging or dropping
packets when relying on ioctl(FIONREAD)?

[Severity: High]
This is a pre-existing issue, but is there a data race and sequence number
corruption in psock->ingress_bytes during SK_REDIRECT?

In sk_psock_skb_ingress_enqueue(), psock->ingress_bytes is incremented with=
out
locks:

net/core/skmsg.c:sk_psock_skb_ingress_enqueue() {
    ...
    psock->ingress_bytes +=3D len;
    ...
}

Concurrently, tcp_bpf_strp_read_sock() locklessly resets psock->ingress_byt=
es
to 0 and uses it to adjust tp->copied_seq:

net/ipv4/tcp_bpf.c:tcp_bpf_strp_read_sock() {
    ...
    psock->ingress_bytes =3D 0;
    ...
    tp->copied_seq =3D psock->copied_seq - psock->ingress_bytes;
    ...
}

If another socket redirects data to this socket, the target socket's
psock->ingress_bytes is incremented by the workqueue or softirq. Does the r=
ace
with tcp_bpf_strp_read_sock() cause redirected bytes to be incorrectly
subtracted from the target socket's tp->copied_seq, artificially holding ba=
ck
the ACK sequence and corrupting the TCP state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-fionread-n=
o-verdict-v3-0-b4ee31b3af53@coralogix.com?part=3D1
