Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5E35A3AE
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 04:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777954473; cv=none; b=P1wD2JwvFRkbN5BGKWK/ps0yRP7XBuIV0/Z08r5bThzzauTNm6awU5AeWRdyqtK1LmpCuD7Cgz9jMQK+RyNF0vI73L3j2hauE7IKdJw3wZX2Mm6Qxzim5ig+78UpNNcTQpjd1hecmSFKaqcsyPQCMxNxgfLzoRxqQ5hBJZUs09I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777954473; c=relaxed/simple;
	bh=wxVMjxc93tWm6+g6rMGUL40dFUnAaEYw/Ar6v4MV4HA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fa4wFEIA8mZNqa9wkUthSTN2vPaAo+b/NjtxmYVjpHk6sStZ6IOGjANlKdW0/NBjn5AfxDbMIBTsB6dJjby6qS+hDJ08syceT2JsoxEanwr7QGcUZNTQml0poseiSbyrW5NLxWW9shkdohFHwZd77Nbn+5pF+YIFBP5gQSQfNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpwJCDro; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpwJCDro"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD566C2BCB4;
	Tue,  5 May 2026 04:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777954472;
	bh=wxVMjxc93tWm6+g6rMGUL40dFUnAaEYw/Ar6v4MV4HA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=GpwJCDroICIhLQRV4o1aq3b9V0seOURbiorGAd6Jo3yC4ITZIo50vOh15tPkY1Hvs
	 pBLf0ryQ8b2lql4awSXqodcg7knZu98MasO1GMLGv88bavnxDSHsnaRIjdFWX+jitQ
	 ifzrENN2Qf0BwUoXotysPaKV5Bi94AR4VgkxzOIMXW2f1Z+47AOwZ0HbAy3NfUcnjI
	 LhbUUk3sV0gmJWfN3RVgd27qRhUlCfQezpt0AlaGdbchle4QM0Md5Unq1g2crgo1AF
	 y3pzK9gkSznJZaWuYdHM1zhC+BELnPNuY3Ofc6EQBds3qA663HwDxZ6Q3LoI7aZqId
	 ui2Ixd2YPv1NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf 1/6] bpf: tcp: Fix type confusion in
 bpf_tcp_sock().
Reply-To: sashiko@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260504210610.180150-2-kuniyu@google.com>
References: <20260504210610.180150-2-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 May 2026 04:14:32 +0000
Message-Id: <20260505041432.BD566C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The OpenVPN (ovpn) driver contains a critical type confusion v=
ulnerability due to insufficient socket type checking, leading to out-of-bo=
unds slab writes.
--

commit 3e93f247feecc891b15b8d713331586af9371dfd
Author: Kuniyuki Iwashima <kuniyu@google.com>

bpf: tcp: Fix type confusion in bpf_tcp_sock().

This commit fixes an out-of-bounds slab access bug in BPF by using sk_is_tc=
p()
instead of just checking sk_protocol for IPPROTO_TCP. This prevents raw soc=
kets
created with IPPROTO_TCP from bypassing the type check.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index bc96c18df4e03..cd88633f8dc14 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7475,7 +7475,7 @@ u32 bpf_tcp_sock_convert_ctx_access(enum bpf_access=
_type type,
> =20
>  BPF_CALL_1(bpf_tcp_sock, struct sock *, sk)
>  {
> -	if (sk_fullsock(sk) && sk->sk_protocol =3D=3D IPPROTO_TCP)
> +	if (sk_fullsock(sk) && sk_is_tcp(sk))

This correctly prevents a type confusion where a raw socket can bypass the
protocol check. Does the OpenVPN (ovpn) driver need a similar fix for this
exact same pattern?

In drivers/net/ovpn/netlink.c, the driver accepts an arbitrary socket file
descriptor from userspace and determines the socket type using only sk_prot=
ocol
without verifying sk_type.

If a user creates a raw socket via socket(AF_INET, SOCK_RAW, IPPROTO_UDP) a=
nd
passes it to the OpenVPN netlink interface, it seems it would pass the prot=
ocol
check and call ovpn_udp_socket_attach().

This eventually passes the socket to setup_udp_tunnel_sock(), which casts t=
he
socket to udp_sk(sk) and overwrites multiple fields (such as encap_type,
encap_rcv, and gro_receive).

Since struct udp_sock is larger than struct raw_sock, could this result in =
an
out-of-bounds slab write?

Similarly, passing a raw TCP socket appears to cause ovpn_tcp_socket_attach=
()
to replace sk->sk_prot with ovpn_tcp_prot. This might mean subsequent TCP
socket operations will operate out-of-bounds on the raw_sock object.

Should ovpn be updated to validate sk_type =3D=3D SOCK_DGRAM or SOCK_STREAM=
 in a
similar manner to this fix?

>  		return (unsigned long)sk;
> =20
>  	return (unsigned long)NULL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260504210610.1801=
50-1-kuniyu@google.com?part=3D1
