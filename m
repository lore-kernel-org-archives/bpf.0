Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030130FF36
	for <bpf@vger.kernel.org>; Sat, 29 Aug 2026 02:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787969715; cv=none; b=RvoE84ZVO95PBbOz3OEiZFCIVbRWFzAzX1VCHcTGm0MveopDdYDZkQHfCDMULebxRDgasVlpo3DxaUH8ldSmfELKLWk5yDVt/sjyuoLSVF5fmA7ektTnEtEMYwjb7Sr9xsMOSwu4T7jAVxo30MuEOyqDQNT5pqbW+ag2YEGcMug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787969715; c=relaxed/simple;
	bh=Loo3CtDxFMYtH/qbGWkzALcdrsMpZ15pzBiHIF5nO3U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lvE4Rm9ocuptrqCVQK4/3svf9adV0B4wS4js0b0k0tiULNjjXkjzxV/UL8+/CESB3GoEP+yC5uLhViSk/hcyzxxY+Zx+ZcR3xe//kD1SzyZBrIXbot8KHEnMQd4n4h+hqxRRX808MT5W5X2jePVjk7+WfUrmQ+m3mYQKvfi/r+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkcRUysX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkcRUysX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3491F000E9;
	Sat, 29 Aug 2026 02:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787969713;
	bh=XQFUpDfz35CdMzmwlnVru2hLMQWB7x7IMOaLNKysG0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IkcRUysX5QAtnX6g3v+1fm8hr1cFwStox/gH5eiq4efa/bsLegmg6+y6hWTeVM+ee
	 8b8sFQ9hKB2ssBYfCVNnx0tDAJbIMrGGGlhLH89jaiE5+PaBx5otHJH24KiNQIYzLR
	 shkqgfF2q1Hv6sjrcPImCF7WhaNvha9tSOYfMGkRT12Li2vZVV5K4PYDa3TAoXInDu
	 nuDDG0f2ka0vdTyQ1UXGKQjHor9ycucJIFCg9sMU0XKqVzcd+1wsgpqOg2jAM6S5vv
	 iloVU0S+9x++hwMc/VAdSZhQ+99VRy2/hQU7ViRC+AOB6Pm8ftwpD+uiFuFr+QF91k
	 CvjK9aaByJDyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf, sockmap: Fix self-redirect copied_seq
 double-counting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Geliang Tang" <geliang@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <b840c35fdfdf36e9fddedfa645b12699bc51aa34.1787968065.git.tanggeliang@kylinos.cn>
References: <b840c35fdfdf36e9fddedfa645b12699bc51aa34.1787968065.git.tanggeliang@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 02:15:12 +0000
Message-Id: <20260829021513.5F3491F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditionally skipping tcp_eat_skb() for all self-redirects leak=
s sequence accounting (copied_seq) for egress redirects, synchronous redire=
ct errors, and psock detach drops.
--

commit 8f3d3d5b6b4f4a55b1a1c00df40c2762471ef372
Author: Geliang Tang <geliang@kernel.org>

bpf, sockmap: Fix self-redirect copied_seq double-counting

This commit attempts to fix a double-counting issue in copied_seq when a
BPF stream_verdict program redirects an skb back to the same socket with
BPF_F_INGRESS. It does so by skipping tcp_eat_skb() for self-redirects.

> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 2521b643fa05d..5fa7b9639eefe 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -1039,10 +1039,14 @@ static int sk_psock_verdict_apply(struct sk_psock=
 *psock, struct sk_buff *skb,
[ ... ]
> -	case __SK_REDIRECT:
> -		tcp_eat_skb(psock->sk, skb);
> +	case __SK_REDIRECT: {
> +		struct sock *dst =3D skb_bpf_redirect_fetch(skb);
> +
> +		if (dst !=3D psock->sk)
> +			tcp_eat_skb(psock->sk, skb);
>  		err =3D sk_psock_skb_redirect(psock, skb);
>  		break;
> +	}
>  	case __SK_DROP:

[Severity: High]
Does conditionally skipping tcp_eat_skb() here leak sequence accounting
(copied_seq) if the self-redirect encounters an error or is an egress
redirect?

If a BPF program returns SK_REDIRECT to its own socket, tcp_eat_skb() is
bypassed. However, if this is an egress redirect (without BPF_F_INGRESS),
the packet is sent out via skb_send_sock() instead of being read by
tcp_bpf_recvmsg_parser().

Similarly, if sk_psock_skb_redirect() fails synchronously (for example, if
!sk_psock_test_state(psock_other, SK_PSOCK_TX_ENABLED)) and calls
sock_drop(), the packet is also lost.

In both cases, the packet is permanently removed from the ingress path
without advancing copied_seq. Could this cause a permanent sequence
desynchronization that stalls the receive window and triggers a kernel
warning in tcp_recvmsg_locked()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/b840c35fdfdf36e9fdd=
edfa645b12699bc51aa34.1787968065.git.tanggeliang@kylinos.cn?part=3D1
