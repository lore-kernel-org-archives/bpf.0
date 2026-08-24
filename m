Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4F226AC5
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787566721; cv=none; b=jsgSzrHZDlQtNBMs1c5cX6MoDhnKRTi95wpTi3ta5u/RlROFqFoNns7cklQEseiQF+a3QOti4Efy4d3KiJ3/JdSB7qphhkjpCHF4QpkjaNk4dfqcvzVwqO3cVJN69u33UlisQw1bFb/+cNPkm9HtmiGLdNGSd5vdwBHoXGmxe5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787566721; c=relaxed/simple;
	bh=d6b1rMGUCbE3s4E0pi0Q+y69gWn0YE6TReGcLhJojFA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lHDh/P8HQAng3Ns2OvJx555fuj6FDFjBG/HTahdC486g/3eIX/JUEg3fwH6lrza311NJO22nXD32J0cVpgRQfhCPKEovTC+N+TnENwHTaT+iN4kRAfsc9p8uFHqTmCslDRd6EwDLgrVlWDGn7Getli56HDXWCmGqXhvh4bEv2ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt/JUX7o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt/JUX7o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEA931F000E9;
	Mon, 24 Aug 2026 10:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787566719;
	bh=zieC7/FHpF73cmyDaA2mfFhCUDjMbGZ22VEz8eiANMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mt/JUX7oIgHk7CII1EshmN7ezkF9Uiym8dGz8iTtpkh6xjui6+nLIBwGyJUL45qG8
	 3lnZ/eg4wj6zQSmOWzd430faVawj+jKZPyEoNC03a1apWfAXCdTbrBl9Y9O3+79ZkA
	 bjJb8oJXmEvAjeuhk+wG8zgH9s0IyKK3+Kyf4FZnR1fI+ZgPs9OM1mo2kE/CZdSPjY
	 MH0Ht+F9W6WYOweCgRbdgGQwJW60LoQWZjU4FTP/R6l4cdvueaCMBMdDpMosyndJmd
	 JtEtm91oQ/nq35ekogx5NkmKchi8vZkRRFZNREb7Pr1aqXPlTUgghhzGCcbZUee08r
	 /m25U1TiQPX8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/1] net: Don't deliver IPv6 packets to IPv4 sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shihuang Liu" <shlomojune6@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260823101809.26802-1-shlomojune6@gmail.com>
References: <20260823101809.26802-1-shlomojune6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 10:18:39 +0000
Message-Id: <20260824101839.AEA931F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing `sk_family` validation in `inet_steal_sock()` allows t=
ype confusion with `AF_UNIX` sockets, leading to arbitrary code execution.
- [Critical] Missing `sk_protocol` validation in `inet_steal_sock()` and `i=
net6_steal_sock()` allows cross-protocol type confusion between TCP and UDP=
 sockets.
--

--- Patch [1]: [PATCH net 1/1] net: Don't deliver IPv6 packets to IPv4 sock=
ets ---
commit dbdb2f67dbf7c27de3851c77618430e20ab40c0b
Author: Shihuang Liu <shlomojune6@gmail.com>

net: Don't deliver IPv6 packets to IPv4 sockets

bpf_sk_assign() allows a TC ingress program to attach an arbitrary
hashed socket to an skb, without checking that the socket family
matches the packet's network layer. As a result, an IPv6 UDP packet
can be assigned to an AF_INET UDP socket: udpv6_rcv() steals the
socket via inet6_steal_sock(), which also lacks a family check, and
queues the IPv6 skb on the AF_INET socket.

> diff --git a/include/net/inet6_hashtables.h b/include/net/inet6_hashtable=
s.h
> index 2cc5d416bbb5a..b39e59efac8d7 100644
> --- a/include/net/inet6_hashtables.h
> +++ b/include/net/inet6_hashtables.h
> @@ -115,6 +115,12 @@ struct sock *inet6_steal_sock(struct net *net, struc=
t sk_buff *skb, int doff,
>  	if (!sk)
>  		return NULL;
> =20
> +	if (unlikely(sk->sk_family !=3D AF_INET6)) {
> +		if (*refcounted)
> +			sock_gen_put(sk);
> +		return NULL;
> +	}
> +

[Severity: Critical]
This is a pre-existing issue, but missing sk_family validation in
inet_steal_sock() allows type confusion with AF_UNIX sockets.

Since inet_steal_sock() completely lacks the sk_family !=3D AF_INET check t=
hat
was added here for IPv6, bpf_sk_assign() can attach an AF_UNIX socket to an
IPv4 packet. Because sk_protocol for an AF_UNIX socket is 0, it is returned
to the IPv4 UDP receive path.

Could this allow an attacker to dereference the IP options payload as a file
pointer list in unix_detach_fds(), leading to arbitrary code execution?

net/unix/af_unix.c:__unix_dgram_recvmsg() {
    ...
    if (!(flags & MSG_PEEK)) {
        if (UNIXCB(skb).fp)
            unix_detach_fds(&scm, skb);
    ...
}

Should we add an if (unlikely(sk->sk_family !=3D AF_INET)) check to
inet_steal_sock() in include/net/inet_hashtables.h to prevent this?

>  	if (!prefetched || !sk_fullsock(sk))
>  		return sk;
> =20

[Severity: Critical]
This is a pre-existing issue, but missing sk_protocol validation in
inet6_steal_sock() and inet_steal_sock() allows cross-protocol type confusi=
on
between TCP and UDP sockets.

Because bpf_sk_assign() does not verify that a selected socket's protocol
matches the packet's transport protocol, inet6_steal_sock() and
inet_steal_sock() can return a TCP socket to the UDP receive path or vice
versa.

Could this lead to out-of-bounds heap corruption? For example, if a UDP
socket is assigned to a TCP packet, wouldn't tcp_v4_rcv() write to fields
like tp->segs_in which reside far past the end of the smaller udp_sock
allocation?

net/ipv4/tcp_ipv4.c:tcp_v4_rcv() {
    ...
    tcp_segs_in(tcp_sk(sk), skb);
    ...
}

Similarly, if a TCP socket is assigned to a UDP packet, attacker-controllab=
le
fields in tcp_sock overlap with sensitive function pointers in udp_sock,
potentially allowing control-flow hijacking.

Would it be safer to ensure that sk->sk_protocol matches the packet being
processed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823101809.2680=
2-1-shlomojune6@gmail.com?part=3D1
