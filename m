Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48447358D37
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 20:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782507496; cv=none; b=KELYvquO4Ys8OUXSUsKeG2UNC9eWkymCJ6td7AKigdH6GChbWSB2UU4kLHk/JFPhW1qYn4aJZLdDyIuPlcfx0kJz6n3pMd6S8/L+YD6+yejqg+p/4DKdyJ2abHVP7e/oVTxODNKWvZsFk9pQjXIeBZChe/TtdbKmrZ4F56s3IxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782507496; c=relaxed/simple;
	bh=eGlIOvyOwsPT9ky7yEH1lxibJsm5786Neki8Aye4Lrk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AQdJH1FFymJuBUKGkPibaYbfkNisPRE+Ft2oYZDc/NWEM0qkkSCFf+8xYU69ES8WnUk/3t04g0H/mvoY4kGtW1BLbmDq4rc4JbB+d5Zn1lXkPG+9LUca818+k+Av2WiTklHqe1PBj8DlVRoMQyFJqSWPpzJzHfdrkJnIwbcrUFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk+Oz7Pj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk+Oz7Pj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC3C1F000E9;
	Fri, 26 Jun 2026 20:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782507494;
	bh=X7eOjtFq1sbha/XpmxQHeOJAZ/GJH7SgRqA9FDgp3mM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kk+Oz7PjsAbGDhlagrt972KpfPjLtH1P2SfvEVbgNv8+hxEJXzC2RYsl4mJQ2jVda
	 UZR/Vhs0be3lKGg8+9Yr5zw75gl1kZRcIIOMF/6YGuHqbtR/g0DLSWRwT+gk9Rakhw
	 9IpIfG7FYTbMpimgdNJrjXo7FvRdHU36H4ERty8CRMAqNLk2KbnFvm9zcYNg8DGkd7
	 mfXffepWZCqm6HS5Hn5npFKgV5x7EGbcNAPzmdPpkfOv5RaCowRFeXwlDuJtIwocyT
	 PVOw14BOPrK+y9RcL4xGaqEDD275YQEN/OkdRwTGo30cbg3qnXEVZXBB1sIzuE4HcU
	 nkjCZVYnfGhNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 1/4] bpf, sockmap: Reject unhashed UDP sockets on
 sockmap update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Luczaj" <mhal@rbox.co>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
References: <20260626-sockmap-lookup-udp-leak-v2-0-7e7e201c951a@rbox.co>
 <20260626-sockmap-lookup-udp-leak-v2-1-7e7e201c951a@rbox.co>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 20:58:14 +0000
Message-Id: <20260626205814.BAC3C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Incomplete fix: Memory ordering race allows unbound UDP sockets to=
 be inserted into sockmap, bypassing the sk_hashed() check.

Pre-existing issues:
- [High] The patch addresses a memory leak caused by UDP sockets dynamicall=
y acquiring the SOCK_RCU_FREE flag while held by a BPF program, but leaves =
TCP sockets vulnerable to the exact same state-transition leak.
--

commit f2013e408c7b5bf3e40a884d6c22c888b4372b0b
Author: Michal Luczaj <mhal@rbox.co>

bpf, sockmap: Reject unhashed UDP sockets on sockmap update

This commit rejects unhashed UDP sockets during sockmap updates to prevent
a memory leak. The leak occurred because unbound UDP sockets are refcounted,
but become non-refcounted (SOCK_RCU_FREE) when bound, which skips the
refcount decrement in bpf_sk_release().

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
This is a pre-existing issue, but does this leave TCP sockets susceptible to
the exact same state-transition leak?

If a TCP socket is held by a BPF program in TCP_ESTABLISHED state and then
transitions to TCP_LISTEN, inet_hash() unconditionally sets SOCK_RCU_FREE:

net/ipv4/inet_hashtables.c:inet_hash() {
    ...
    sock_set_flag(sk, SOCK_RCU_FREE);
    ...
}

This dynamic state change would cause bpf_sk_release() to evaluate
sk_is_refcounted(sk) as false and skip the refcount decrement, leading to
a memory leak similar to the UDP case.

> +	if (sk_is_udp(sk))
> +		return sk_hashed(sk);

[Severity: High]
Could a memory ordering regression here allow unbound UDP sockets to still
bypass this check?

In udp_v4_get_port(), the flag and hash are set:

net/ipv4/udp.c:udp_v4_get_port() {
    ...
    sock_set_flag(sk, SOCK_RCU_FREE);
    sk_add_node_rcu(sk, &hslot->head);
    ...
}

Because these stores lack a memory barrier between them, could sk_hashed(sk)
return true on another CPU while SOCK_RCU_FREE is not yet visible, allowing
the leak to still trigger?

>  	if (sk_is_stream_unix(sk))
>  		return (1 << READ_ONCE(sk->sk_state)) & TCPF_ESTABLISHED;
>  	if (sk_is_vsock(sk) &&

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-sockmap-lo=
okup-udp-leak-v2-0-7e7e201c951a@rbox.co?part=3D1
