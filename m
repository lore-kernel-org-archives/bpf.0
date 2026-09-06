Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF62937418C
	for <bpf@vger.kernel.org>; Sun,  6 Sep 2026 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788681694; cv=none; b=h6rU6vnEGFGU0u78xt28q+ssKMW3jYsE6NKllphXJuuP1Q5696ZgxWTHGpG93KKH5BLRvqo10JeNOOlT+eihGfckqSiCE9VJIAPO6CisnwRMnNT5VPB/ZM9fBuaNxOgIFxJsdmhw8iRpeEny+c96FodoH5UdB0vhr6bSaKpGRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788681694; c=relaxed/simple;
	bh=H/Az3sZaD5QrZzPIrcD5Zdc0VElcr7yT7S9BnIPUuXw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zjxw1yJ7e4pgD/9cBZX7z+6WlOyeSgkmf0yUFcd7BppsZFNLPysd9ii0ZfDySd7I+0MsuU0pzsJkz6hdkEk/EsaZzbdVg52frC9KvgHK0pr9k7SNW0rIdq5lxgIgajv3h9l1XdckBEWDgzBsnj589Xtwes8Ng1+jFHHBgVE5usw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0i35QBG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0i35QBG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470B01F00A3A;
	Sun,  6 Sep 2026 08:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788681692;
	bh=KxX1+qI4/rUIGX3BvjnFW1YJDtGDIHZgVoCGRU6UVmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d0i35QBGRz0mx0meIQ1s2D1wkRU0A3oPeD2N/bo7RfTP/vxGBPlA/xitZ52tUe3mt
	 pCy9wvMNwQR9LojurjKis52XGaseVtaHf3RWtUXaM5oD/Aol6KFFV/kBrAnKC63r3F
	 4gGLemIXhAd858RQwI1AEmg6+h9TzzFGY9HHwvIbwKBi3agkFtrjGtMtwry0QM9O1N
	 8sCQVOVjSPj6zvqNLYBFkOXVLLwon3cSGBgKU60CuCIEIIhv75W3yPtzhuNspBYEhm
	 S+hJjOHYphutbgZG18+kFvRMpoQjItiM5BWzHP3oln3Q5csg9NymcLDZIpcBcwLYBu
	 uQtQ0qah5mSYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/3] tcp: Skip cond_resched() in
 inet_csk_listen_stop() under BPF context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260906074135.185212-3-jiayuan.chen@linux.dev>
References: <20260906074135.185212-1-jiayuan.chen@linux.dev>
 <20260906074135.185212-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 08:01:31 +0000
Message-Id: <20260906080132.470B01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Unconditionally skipping `cond_resched()` in `inet_csk_listen_st=
op()` during BPF execution forces unbounded accept queue processing to run =
atomically, causing CPU soft lockups and RCU stalls.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the TCP BPF iter=
ator acquires `lock_sock()` on unaccepted child sockets, causing destructiv=
e data races if the parent listener is closed concurrently.
--

commit ab882b1f2e506040f7bcef30415806e9b24c59a4
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

tcp: Skip cond_resched() in inet_csk_listen_stop() under BPF context

This commit skips cond_resched() in inet_csk_listen_stop() when called unde=
r a
BPF context. This prevents a "sleeping function called from invalid context"
bug when an iterator BPF program calls bpf_sock_destroy() on a listener
socket.

> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_s=
ock.c
> index 6257459bcee24..6a30f11384547 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c

[Severity: High]
This isn't a bug introduced by this patch, but does the TCP BPF iterator
acquire lock_sock() on unaccepted child sockets, causing destructive data
races if the parent listener is closed concurrently?

If a TCP BPF iterator is running in bpf_iter_tcp_seq_show() and visits a
child socket in the ehash table that has not yet been accepted by userspace:

net/ipv4/tcp_ipv4.c:bpf_iter_tcp_seq_show() {
    ...
    if (sk_fullsock(sk))
        lock_sock(sk);
    ...
}

And concurrently, the parent listener is closed, invoking
inet_csk_listen_stop():

net/ipv4/inet_connection_sock.c:inet_csk_listen_stop() {
    ...
    bh_lock_sock(child);
    WARN_ON(sock_owned_by_user(child));
    ...
}

inet_csk_listen_stop() only takes the spinlock (bh_lock_sock()), triggers
the WARN_ON, and completely ignores the mutex, destructively modifying the
socket while the BPF program actively uses it.

> @@ -1520,7 +1520,8 @@ void inet_csk_listen_stop(struct sock *sk)
>  		local_bh_enable();
>  		sock_put(child);
> =20
> -		cond_resched();
> +		if (!has_current_bpf_ctx())
> +			cond_resched();

[Severity: Medium]
Can unconditionally skipping cond_resched() here force unbounded accept que=
ue
processing to run atomically?

Because the loop dismantles the accept queue (which can contain up to
somaxconn sockets), executing it entirely within a non-preemptible RCU
read-side section could cause CPU soft lockups and RCU stalls.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906074135.1852=
12-1-jiayuan.chen@linux.dev?part=3D2
