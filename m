Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C923183F
	for <bpf@vger.kernel.org>; Tue,  7 Jul 2026 04:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783400020; cv=none; b=qHDDcbOR0ndE+G5Seq1af/auhcQ6/pT9ppTbWsVvAUFNXeAuGY/hnY7Hp99/IgdKB97IcyeWHp4vPwBuqdcCkB0yttx2iFJr8APTZimGupus8ifU0+g2gQcIjdGpeVzXpzSIdR5thf5B9rR8MEuILtAaQTtgdotOIHhb9+OHlxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783400020; c=relaxed/simple;
	bh=ctoFh4OqlX33U2KYSB6QGsqIH5/82LT4VUt/fpYCL7g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ocv1UsnrIQGkEINSNGRsiIThjU/wsxMGWBhwaZhmz/YzLVtgKSI/O1hkdWirgB7E0Cgj4Ky7DIF1DcOR+6HcmNcQrfGa8sPEmumbF/o5tjZgr7v1WCjHR8cEnouIAfBRipO81+a/RtohCPvUZikVcvhPxiOmZ82cBM118x7NiMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMfQ1cY4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMfQ1cY4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30C41F00A3A;
	Tue,  7 Jul 2026 04:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783400018;
	bh=lEQdRkOdPqXirRlW1jgTp898xIqmgfaKnVQYmpmc8AI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UMfQ1cY4XxPJUsWfNQEJVJlW8UBfAXtFeckCsQRX5dskg06dKBBuJ+eVt7q4qtgDb
	 WZuby1fnhjDUfTVACRQFSZ8se1w7jefQn3CPoWEcYFnBAowjc0ILa7c4R86u0jAhOI
	 kzWguBW5ZODSHWoNAFWxahFMZYVMxrPMNQhqXwn85ZcELM8GfHOyZx7Cfhz3R4X1fk
	 hU/ElmUd5YK1pE9s3fvg2oby7XBt0/MJwxEUsYEh1S+59CxbU7Sfab0DGbIgdg6duw
	 u2tHgv38hYz9bUEv1Db9m/Ymqxzx0q4oyMyGwHlmIx/tKaCmTuWcBgOSktOFsx03t5
	 N5cB4StNxH9wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v4 2/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260707-sockmap-lookup-udp-leak-v4-2-f878346f27ab@rbox.co>
References: <20260707-sockmap-lookup-udp-leak-v4-0-f878346f27ab@rbox.co>
 <20260707-sockmap-lookup-udp-leak-v4-2-f878346f27ab@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 04:53:38 +0000
Message-Id: <20260707045338.B30C41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch prevents a refcount leak for UDP sockets by rejecting un=
hashed sockets, but an identical reference count leak can be triggered for =
TCP sockets because `sk_is_refcounted()` relies on the mutable `SOCK_RCU_FR=
EE` flag.
--

--- Patch [2]: [PATCH bpf v4 2/4] bpf, sockmap: Reject unhashed UDP sockets=
 on sockmap update ---
commit efe688dfced966a49066087e860ab73696a8f75a
Author: Michal Luczaj <mhal@rbox.co>
Date:   Tue Jul 7 04:23:57 2026 +0000

bpf, sockmap: Reject unhashed UDP sockets on sockmap update

This patch addresses a socket reference count leak by preventing unhashed U=
DP
sockets from being updated in sockmaps. It removes the ability for BPF prog=
rams
to increment a refcount on an unbound socket that subsequently gets bound a=
nd
skips the refcount decrement upon release.

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -542,6 +542,8 @@ static bool sock_map_sk_state_allowed(const struct so=
ck *sk)
>  {
>  	if (sk_is_tcp(sk))
>  		return (1 << sk->sk_state) & (TCPF_ESTABLISHED | TCPF_LISTEN);

[Severity: High]
This is a pre-existing issue, but can the exact same reference count leak
happen for TCP sockets because sk_is_refcounted() relies on the mutable
SOCK_RCU_FREE flag?

If a user creates a TCP socket, connects it (entering TCP_ESTABLISHED), and
adds it to a sockmap, a BPF program can call bpf_map_lookup_elem() on the
sockmap. This increments the socket's refcount because SOCK_RCU_FREE is not
set on established sockets.

If a user thread concurrently calls connect(AF_UNSPEC) to disconnect the
socket (moving it to TCP_CLOSE and removing it from the map), and then calls
listen() on the same socket, inet_hash() unconditionally sets the
SOCK_RCU_FREE flag.

When the BPF program subsequently calls bpf_sk_release(sk):

net/core/filter.c:bpf_sk_release() {
    ...
    if (sk && sk_is_refcounted(sk))
        sock_gen_put(sk);
    ...
}

sk_is_refcounted(sk) will now return false because SOCK_RCU_FREE is set,
causing bpf_sk_release() to skip the decrement and permanently leak the
acquired reference.=20

Could this sequence be abused to cause memory exhaustion, and is there a way
to safely track the acquired references without relying on a flag that might
change mid-flight?

> +	if (sk_is_udp(sk))
> +		return sk_hashed(sk);
>  	if (sk_is_stream_unix(sk))
>  		return (1 << READ_ONCE(sk->sk_state)) & TCPF_ESTABLISHED;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-sockmap-lo=
okup-udp-leak-v4-0-f878346f27ab@rbox.co?part=3D2
