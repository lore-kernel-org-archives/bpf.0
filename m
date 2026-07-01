Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A79368947
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 23:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782950153; cv=none; b=kTgf+M9hy3x4LNpz52k2+496AeAzUc73/OUujX72TG9504t/TSzwOHra2fB3w0yL+g3sc6VNnmVDytuoD0XGK0n4R1+VwdpWO9EgQeIgyi6kI86511VICYAyjnB1ktIErO2luf5jqjlQjqRKc2BvE9A98472MsjiqI8WkPV/Q7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782950153; c=relaxed/simple;
	bh=EE+Du8BN9epf1OrhycmNEifS4haGju34LfqHUMvQj4w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=soYQ43+xBvF7NGL9ihDoWXP2HaoiR75HZm9BYj7mD2ZTku7TP4mByEoLB4G7op7uX8JbWQ/iSmnBcF3NMep5osnBr2j7XVz1KWxEfct4ZB8e9KFCeticknJtvLbkzWenYOFDPWSduImXyTffxTKbf1vAVJdhBQbxTgLkhsaXdcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHOZS9FY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHOZS9FY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0AA1F00A3F;
	Wed,  1 Jul 2026 23:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782950152;
	bh=DWgxEJyxHV67zlHGk9Nnu9TssuukHj2IPjRbEZNy/BM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FHOZS9FYuoSBdnVYcmQqy7KqKSCWZOJV08OgLHDL3p2Benplz9TEXYL0uieyoQaSs
	 Y2u3aQfYsPbu3bhkWyEv7D5CydFKgaAICwwmzxGkx1CpAggj3FfoZXDRJ4iFGxbOIP
	 UMx57Dlb+0kKTxRcFzahyrtoZFinIf7jnwwx7Em7qx6IxCE13gOK9939iqj97Z5rNt
	 NWEHag0QQGqUKpsF5cSNo+4qNyNrv4vq/XNf6NDVBMEuUiZwe56ZmmQUEVEaf9h2tI
	 oviA96CQBnQIpIT6mWxby/wj45LT82p4h8A3ovJa2HcntzlNdqQFJnDI+edZH0jAS1
	 LqGQApXaulg/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 2/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260702-sockmap-lookup-udp-leak-v3-2-ff8de8782468@rbox.co>
References: <20260702-sockmap-lookup-udp-leak-v3-0-ff8de8782468@rbox.co>
 <20260702-sockmap-lookup-udp-leak-v3-2-ff8de8782468@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 23:55:50 +0000
Message-Id: <20260701235552.2B0AA1F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The refcount leak fixed for UDP sockets by this patch still exists=
 for TCP sockets (and via bpf_sk_lookup_tcp) because bpf_sk_release relies =
on the mutable SOCK_RCU_FREE flag.
--

commit 120f1940dc9e4cc498f383925d488cf77882caea
Author: Michal Luczaj <mhal@rbox.co>

bpf, sockmap: Reject unhashed UDP sockets on sockmap update

This commit rejects unhashed UDP sockets during sockmap updates to prevent
a memory leak when a socket transitions from unbound to bound. This transit=
ion
causes bpf_sk_release() to skip the refcount decrement due to the SOCK_RCU_=
FREE
flag being set.

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index c60ba6d292f9a..9efbd8ca7db83 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -542,6 +542,8 @@ static bool sock_map_sk_state_allowed(const struct so=
ck *sk)
>  {
>  	if (sk_is_tcp(sk))
>  		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);

[Severity: High]
This isn't a bug introduced by this patch, but does the same refcount leak
still exist for TCP sockets?

A BPF program can acquire a reference to a TCP socket in the TCP_ESTABLISHED
state (e.g., via bpf_sk_lookup_tcp or bpf_map_lookup_elem on a sockmap) bec=
ause
TCP_ESTABLISHED sockets do not have the SOCK_RCU_FREE flag set.

If a user-space thread concurrently calls connect(AF_UNSPEC) to transition =
the
socket to TCP_CLOSE, followed by listen(), inet_hash() will dynamically set=
 the
SOCK_RCU_FREE flag on the socket.

When the BPF program finishes and calls bpf_sk_release():

net/core/filter.c:bpf_sk_release() {
	if (sk && sk_is_refcounted(sk))
		sock_gen_put(sk);
	return 0;
}

Because the flag was just set, sk_is_refcounted(sk) will dynamically evalua=
te
to false, skipping sock_gen_put(sk) and permanently leaking the acquired
reference.

> +	if (sk_is_udp(sk))
> +		return sk_hashed(sk);
>  	if (sk_is_stream_unix(sk))
>  		return (1 << READ_ONCE(sk->sk_state)) & TCPF_ESTABLISHED;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-sockmap-lo=
okup-udp-leak-v3-0-ff8de8782468@rbox.co?part=3D2
