Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AFF8F4A
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776734038; cv=none; b=dACAILN8/JXMAMReJifb3Inkx2u8nelvlGA69T513QdaWquEkwVP9mHo8hmJnJodLlbFS3qjlyTiMxKFUVKX/jyW8DwhJEcMZ4mQ7U9yDQJtoInTW/U16eyv0GF+QIKvUAlWuaKbup0qMAXDvXo1qNWTyFD/1UUEZ6MEp9vKd1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776734038; c=relaxed/simple;
	bh=M9tEa/WBK7/AbdJ+xxgFEuWsKfbKesTBGeYVvCpGs/M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S+srBFaYEydbAgH/imN9Lsw4LuaZR2ANWyuVLbP8nTTTjP5VRUScczByKftlmRSmn8MX3QRrjgmCrzqEtk7+ZxTWR3vJvx8U4Cup00NTNsWawvHXlaE2RteHo8SdJCiRElORRKFNf/OV08zSyyj9mDgH6JFllE5/L/KiK0RJX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOLu6jhA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOLu6jhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70974C19425;
	Tue, 21 Apr 2026 01:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776734037;
	bh=M9tEa/WBK7/AbdJ+xxgFEuWsKfbKesTBGeYVvCpGs/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eOLu6jhA3YEaXuQv3KEss6iEJKEgXV+LgrzSTMItqAAzc/sNL8gxYPZu+qXdbKWjL
	 OrUGKeIU1fIiPBmzy0woq8mREc2sq+fPTwQzygt078QfBpTt6sC2I5WQQysu28pWfo
	 aHMwAMq253x2IfYs07zI/0McYYpAH+OgndwCabrKejJ8q99RBX5+RiOz8fZE9H8bz4
	 x+9kz8j2bXrpgbwANbGGRWTKEiuLLqjLa8uE0hEWZDuQljq2zCZ2i0mcFpelmNVoYg
	 22yQtQZLpvcK9C+0lMZmLLxBtd3bJsC34p44+OTsKtrsJ7C7PR0XtggsFVzmdEejNp
	 1l3MtpXknNOFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf] sockmap: Fix sk_psock_drop() race vs
 sock_map_{unhash,close,destroy}().
Reply-To: sashiko@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260420194846.1089595-1-kuniyu@google.com>
References: <20260420194846.1089595-1-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Apr 2026 01:13:56 +0000
Message-Id: <20260421011357.70974C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The newly introduced unbounded `goto retry;` loops in `sock_map_un=
hash()`, `sock_map_destroy()`, and `sock_map_close()` can cause a hard lock=
up (deadlock) due to softirq preemption or priority inversion.
--

commit 08b24da207c576eef44ad9d88356dbd6600ab733
Author: Kuniyuki Iwashima <kuniyu@google.com>
sockmap: Fix sk_psock_drop() race vs sock_map_{unhash,close,destroy}().

This commit fixes a race condition where sk_psock_drop() might not have
finished restoring sk->sk_prot even if sk_psock_get() fails to bump the
refcount. It adds a retry loop to sock_map_unhash(), sock_map_destroy(),
and sock_map_close() when sk_psock_get() returns NULL but the protocol
hooks haven't been restored yet.

Closes: https://lore.kernel.org/bpf/69cec5ef.050a0220.2dbe29.0009.GAE@googl=
e.com/

> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index 02a68be3002a2..99e3789492a09 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
[ ... ]
> @@ -1652,20 +1657,25 @@ void sock_map_destroy(struct sock *sk)
>  	void (*saved_destroy)(struct sock *sk);
>  	struct sk_psock *psock;
> =20
> +retry:
>  	rcu_read_lock();
>  	psock =3D sk_psock_get(sk);
>  	if (unlikely(!psock)) {
>  		rcu_read_unlock();
>  		saved_destroy =3D READ_ONCE(sk->sk_prot)->destroy;
> +		if (unlikely(saved_destroy =3D=3D sock_map_destroy))
> +			goto retry;

Can this unbounded retry loop cause a hard lockup due to softirq preemption
or priority inversion?

If sk_psock_put() is called from process context with bottom-halves enabled
(such as from sock_map_close() after release_sock()), an interrupt could
preempt the thread immediately after refcount_dec_and_test(&psock->refcnt)
drops to 0 but before sk_psock_drop() disables BH.

If a network interrupt fires on the same CPU, NET_RX_SOFTIRQ may process a
packet (such as an RST) that triggers socket destruction via:
tcp_done() -> inet_csk_destroy_sock() -> sk->sk_prot->destroy()

Since sk_psock_drop() has not yet restored the protocol, sk->sk_prot->destr=
oy
is still sock_map_destroy().

When sock_map_destroy() calls sk_psock_get(), it returns NULL because the
refcount is exactly 0. The code then falls into the !psock branch, sees that
sk->sk_prot->destroy is still sock_map_destroy(), and jumps to retry.

Because the softirq spins infinitely in this tight loop and never yields the
CPU, the preempted process context can never execute sk_psock_drop(),
resulting in a permanent hard lockup.

A similar priority inversion deadlock could also occur on PREEMPT_RT if the
thread calling sk_psock_drop() is preempted by a higher-priority task.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260420194846.1089=
595-1-kuniyu@google.com?part=3D1
