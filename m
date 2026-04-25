Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BD864
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777085119; cv=none; b=kEx7OWme65dGXyzk4kNtcO8DkIE/SVmZsmiTlz/4fNtkh/azQDGOb6OUZ6oK8t6vXxJVGoQJdz7Ksj9egCWpi2yl0UaY1m1xb/ImqL8uB0YbFj4POMa43nCFo2Kx0NFQI8Z6Za8+4HUbBmnzwrTaq4QjifSYYclGE8Z08v8zVUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777085119; c=relaxed/simple;
	bh=X/J0X5QF4dw73WN9ARIyEwFCHpeiXJv9ttiF33wSe78=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sGtAJ5PW0a0WDwnn0btJhomM63R9k+aJcV+5RWn0TyA3UsVQUkdcZ3aeSRk8SUFjCiKJNtLqYJNiVdevK6yBxPOwwkU61W9zv4bDueOjEOMV8FcYE/mxyaOMTb6qYwtK6+y3ZCi4uwy+blhB/PIxRkB8Q0vRba7szQyDfnvufnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsMWNpLk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsMWNpLk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB59C19425;
	Sat, 25 Apr 2026 02:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777085118;
	bh=X/J0X5QF4dw73WN9ARIyEwFCHpeiXJv9ttiF33wSe78=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JsMWNpLkg25TpdIuhLQJ4tnCxPMaAlKlQ4xBNdgbuarC9yL1rEl6INY0oR61l+0PN
	 BW1M4JuTItyiy6b78hZKAScFv5lYKVMeb6DOCXaRi7n9xWJi5OJrePo2bB2MwJ9drF
	 /S/e3XtuDPbj6JCbl0OYx1TEnthZfNhFK6GEZN34A0iLK7ROB3yn0mhD4D1jgQV/VM
	 m9UFJR7ZQUR+yI3YJmSMtQKr7SLqo4qIvzr9IOMvZvwVlz+yY2XNEkqYx2o09hE8Ci
	 eExR/JPtSHGRR4VtBpH7zN8BFFpAiIQuJpAzRwVF9GLu6tEXrCOzKDZws1Ne081z8g
	 PagSl9Xz4SpnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 2/4] udp: Remove disconnected sockets from
 the 4-tuple hash
Reply-To: sashiko@lists.linux.dev
To: "Jordan Rife" <jrife@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260330215707.2374657-3-jrife@google.com>
References: <20260330215707.2374657-3-jrife@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 02:45:17 +0000
Message-Id: <20260425024518.9DB59C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Calling `udp_unhash4()` from process context with softirqs enabled=
 creates a deadlock vulnerability and lockdep warnings.
- [High] Concurrent executions of `udp_unhash4()` lead to double-decrements=
 of hash bucket counters due to a TOCTOU race.
--

commit e6257404c34b723d1c990d6c54298b3c3edfb986
Author: Jordan Rife <jrife@google.com>

udp: Remove disconnected sockets from the 4-tuple hash

This commit updates udp_disconnect() and udp_abort() to always remove a
disconnected socket from the 4-tuple hash. This is done by calling the newly
introduced udp_disconnect_unhash4() function on disconnect or abort.

> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> index 91918ff60728f..e3f7689513d9b 100644
> --- a/net/ipv4/udp.c
> +++ b/net/ipv4/udp.c
> @@ -2235,10 +2235,20 @@ int __udp_disconnect(struct sock *sk, int flags)
>  }
>  EXPORT_SYMBOL(__udp_disconnect);
> =20
> +static int udp_disconnect_unhash4(struct sock *sk, int flags)
> +{
> +	struct udp_table *udptable =3D udp_get_table_prot(sk);
> +
> +	udp_unhash4(udptable, sk);

Is it safe to call udp_unhash4() here with softirqs enabled?

Looking at udp_unhash4(), it acquires hslot4->lock and hslot2->lock using
spin_lock(). Because lock_sock() in udp_disconnect() doesn't disable bottom
halves, an interrupt could occur while hslot4->lock is held.

If a softirq executes a BPF program that calls bpf_sock_destroy() on a
socket in the same bucket, it triggers udp_abort(). As udp_abort() skips
lock_sock(sk) when in BPF context, it will call udp_unhash4() and attempt
to acquire hslot4->lock again, resulting in a deadlock.

Also, could this lead to double-decrements of hash bucket counters?

Inside udp_unhash4(), the if (udp_hashed4(sk)) check is evaluated outside
of any spinlocks. If another path unhashes the socket concurrently (such as
udp_abort() from a BPF context bypassing lock_sock(sk)), both threads can
evaluate udp_hashed4(sk) as true.

Both threads will then serialize on spin_lock(&hslot4->lock). While
hlist_nulls_del_init_rcu() handles already-unhashed nodes, both threads
will unconditionally execute hslot4->count-- and udp_hash4_dec(hslot2),
leading to corrupted hash table counts.

> +	__udp_disconnect(sk, flags);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260330215707.2374=
657-1-jrife@google.com?part=3D2
