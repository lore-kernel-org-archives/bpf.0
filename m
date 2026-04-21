Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2435972
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 19:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776798189; cv=none; b=WbYCuRA1bqesdZ+LRAdyAOQP1vHT6yuLZuc9rcweqwHP60BgAxmsfxxWM03M8TBEOsaYJllkqHmIPp/GDUsDoHhaEOxDeA1Wtwn7jpWegFLwx6g+Ht4Oe3mVhUTKZOsLOwdTI89+dPqyb/0eNo6CDsvoCHef9C5siRzt5KEl7i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776798189; c=relaxed/simple;
	bh=Nrkhe8S7dqRhrunkbA2Vb/R9quyEaV9FLxaSDCxCgik=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Pwh+g5/GKl3Z2PH8PUx7x/8sORo7N+5xObWD28dhuC0N2DOu9/Nr7P0sQlWQ+josBRTQPr0Y6+DlLqlvh80cake1PXtiTtKcox861ToxoIrFkLLnekkaocD1CHE2TrgDCqJXyB4dbI+b2wnZVJNU2XDNb6aF/K4i+ttHkmuFpHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egBwByyG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egBwByyG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AD6C2BCB0;
	Tue, 21 Apr 2026 19:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776798189;
	bh=Nrkhe8S7dqRhrunkbA2Vb/R9quyEaV9FLxaSDCxCgik=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=egBwByyG/SmwfInZ0xNt4LVqSJO87A0WYww88hoZ/lKoVOVef8aK349fF9ijqIB6J
	 FfAsVZrxMDYKAxK9YVtX8WNHuh9E/W4RcwxnqgGirqrbFRNaTpm7bA+uDMYDMyrkUm
	 lBM0106QdKDBLf8YfsxcSSU5/XYv+ASN4rhbKPa65eINmaRD+FAprTDS02N5V3m3Gm
	 9HVdcGDRZVXP1h4FQTbeBHdJaoXErcV41ZkI2JUjbzyetDzh11aUBsckoSSijBqKto
	 cFXa4hPF3wF8vQFeKZfY/HwV5RIbT8cDXoYtRJxpWJWwC8ZiBA8Q/MPIXhNclQ/wjQ
	 38eKupqZt4UWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10.y] bpf, sockmap: Fix an infinite loop error when
 len is 0 in tcp_bpf_recvmsg_parser()
Reply-To: sashiko@lists.linux.dev
To: "Vasiliy Kovalev" <kovalev@altlinux.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260421132839.38703-1-kovalev@altlinux.org>
References: <20260421132839.38703-1-kovalev@altlinux.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 19:03:07 +0000
Message-Id: <20260421190309.22AD6C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Unconditional early return for `len =3D=3D 0` in `tcp_bpf_recvmsg(=
)` breaks UAPI semantics by masking socket errors, returning 0 instead of `=
-EAGAIN` for non-blocking sockets, and bypassing state checks.
--

commit 17cc1ee5a157715faa482ac2a4f167f9022cb333
Author: Liu Jian <liujian56@huawei.com>

bpf, sockmap: Fix an infinite loop error when len is 0 in tcp_bpf_recvmsg_p=
arser()

This commit addresses a soft lockup issue where a 0-length recvmsg causes
an infinite loop in tcp_bpf_recvmsg_parser(). It fixes the issue by returni=
ng
0 early when the length is 0.

Link: https://lore.kernel.org/bpf/20230303080946.1146638-1-liujian56@huawei=
.com

> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -277,6 +277,9 @@ static int tcp_bpf_recvmsg(struct sock *sk, struct ms=
ghdr *msg, size_t len,
>  	if (unlikely(flags & MSG_ERRQUEUE))
>  		return inet_recv_error(sk, msg, len, addr_len);
> =20
> +	if (!len)
> +		return 0;

Does this unconditional early return bypass necessary socket state checks?

In the standard Linux TCP implementation, a 0-length receive is not an
immediate no-op. For instance, if the socket is non-blocking and empty,
tcp_recvmsg() normally returns -EAGAIN. If the socket has a pending error,
it returns that error, and if the socket is in TCP_LISTEN, it returns
-ENOTCONN.

By unconditionally returning 0 here, a non-blocking recv(0) on an empty
socket will return 0 instead of -EAGAIN. Since a 0 return value typically
indicates EOF (connection closed) to userspace applications, could this
cause applications to incorrectly assume the connection was closed and
drop it?

Would it be safer to delegate 0-length reads to the standard TCP
implementation by returning tcp_recvmsg() here instead, ensuring that
the existing UAPI error semantics are preserved?

> +
>  	psock =3D sk_psock_get(sk);
>  	if (unlikely(!psock))
>  		return tcp_recvmsg(sk, msg, len, nonblock, flags, addr_len);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260421132839.3870=
3-1-kovalev@altlinux.org?part=3D1
