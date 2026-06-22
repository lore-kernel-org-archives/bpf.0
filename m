Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B49B35028D
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 13:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134253; cv=none; b=jHxlU6hYAvzi865m6b08SvelOuG9fs/K5R/fXpRIfXJgrOx5DcqqX2G/hv3UA2DnoLIwT3hhEYUGohfR0wrGsZj38vIwtTzPDXUOFKLbO9n25cLqOb6ZhspusiHDJrMCUc2OQPRpypXfp9/Sq9hjoq1kW9c53skwGV3MT7kGaDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134253; c=relaxed/simple;
	bh=C6f+Wj2vmu6fvluiOMcK40f5HdLY9CoR3mXNXaONEwE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LkrvJ3+kKiPO3TCWCy8p4icwDZQskRQtEy0zIT9K0rVTOwO2rraNAtVOk2pPsjLJXuHI/Z7VrGb6/Eht89gsfFvhwcq9UQr2tCIXU2CrVDzsDg9sh5F8XwCdgtBnT3TuvEHkqQng8QIr4ji55w9fkpsdOXywl3HuUh3bMLGNp4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIWarfCv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIWarfCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E619F1F000E9;
	Mon, 22 Jun 2026 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782134252;
	bh=zuuUrwuMqAnqESk3CmKN6Ivfu+0Z+y1PPGkaw7fWf88=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CIWarfCv6NVKjCK8F61QgCmehrYIVw41HiYT+PGYxJLea0UZ/Pso8HzsVCjyZ+TYg
	 IqPk5f+1AJP0P5H1PKG++ytJ2dwSGlrVCMJnUxsdO2RC7IQEArpCB8H10x8FHgKg5j
	 Hp5kq4j35F7fzXR4DIChX3OECsLvFDGtv3uEYhhoJLqGjSrpLsdWhsax69rQnl6z0T
	 /qCFwzj35i/uFimJ/MVPVn58pshtMzDwhmeQSDSSerL4ncTqEnRorY4CxBEnTFcDoc
	 5gmwHiaTDRZj5EIWzGhUtITBTjGBjyXK9/9BvTHbCtHwLUk+4dy17Fca/e2BjCHeTA
	 xkgJh59K+MlOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf, unix: Guard sk_msg-dependent code behind
 CONFIG_NET_SOCK_MSG
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260622-bpf-sk_msg-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com>
References: <20260622-bpf-sk_msg-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Jun 2026 13:17:31 +0000
Message-Id: <20260622131731.E619F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Calling recvmsg() on a UNIX socket added to a BPF sockmap caus=
es a NULL pointer dereference when CONFIG_NET_SOCK_MSG is disabled.
--

commit 95825431b208bd3fb6f5fe58d504bdcb560273c9
Author: Jakub Sitnicki <jakub@cloudflare.com>

bpf, unix: Guard sk_msg-dependent code behind CONFIG_NET_SOCK_MSG

This commit conditionally compiles the assignment of recvmsg and=20
sock_is_readable in AF_UNIX BPF protocol rebuilding functions, guarding them
behind CONFIG_NET_SOCK_MSG.

> diff --git a/net/unix/unix_bpf.c b/net/unix/unix_bpf.c
> index f86ff19e9764d..5289a04b4993f 100644
> --- a/net/unix/unix_bpf.c
> +++ b/net/unix/unix_bpf.c

[ ... ]

> @@ -107,8 +109,10 @@ static void unix_dgram_bpf_rebuild_protos(struct pro=
to *prot, const struct proto
>  {
>  	*prot        =3D *base;
>  	prot->close  =3D sock_map_close;
> +#ifdef CONFIG_NET_SOCK_MSG
>  	prot->recvmsg =3D unix_bpf_recvmsg;
>  	prot->sock_is_readable =3D sk_msg_is_readable;
> +#endif
>  }

[Severity: Critical]
If CONFIG_NET_SOCK_MSG is disabled but CONFIG_BPF_SYSCALL is enabled,
doesn't this leave prot->recvmsg as NULL?

When a UNIX datagram socket is added to a sockmap, its protocol is updated =
to
the rebuilt BPF protocol. If a user then calls recvmsg(), unix_dgram_recvmsg
checks if the protocol has been overridden:

net/unix/af_unix.c:unix_dgram_recvmsg() {
	...
	if (prot !=3D &unix_dgram_proto)
		return prot->recvmsg(sk, msg, size, flags);
	...
}

Will this cause a NULL pointer dereference since prot->recvmsg is never
assigned for the rebuilt protocol when CONFIG_NET_SOCK_MSG is disabled?

> =20
>  static void unix_stream_bpf_rebuild_protos(struct proto *prot,
> @@ -116,8 +120,10 @@ static void unix_stream_bpf_rebuild_protos(struct pr=
oto *prot,
>  {
>  	*prot        =3D *base;
>  	prot->close  =3D sock_map_close;
> +#ifdef CONFIG_NET_SOCK_MSG
>  	prot->recvmsg =3D unix_bpf_recvmsg;
>  	prot->sock_is_readable =3D sk_msg_is_readable;
> +#endif

[Severity: Critical]
The same issue appears here for stream sockets. Does this also cause a NULL
pointer dereference during unix_stream_recvmsg since it behaves identically?

net/unix/af_unix.c:unix_stream_recvmsg() {
	...
	if (prot !=3D &unix_stream_proto)
		return prot->recvmsg(sk, msg, size, flags);
	...
}

>  	prot->unhash  =3D sock_map_unhash;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622-bpf-sk_msg=
-split-unix-v1-1-d7e0cb7bb03b@cloudflare.com?part=3D1
