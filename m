Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421863;
	b=KRUWKBxlKr8QLgFXmO9t5zRtvK2TKgsYasgjSC/WIHhoyb9+fFu7+OOjY2kwwSc/8e/7
	 J/Oo2+oqzTxbj7x01WRm0L9dkyA478qBLdZ81Efd5kXAH54g7fdZStzDqTBfpxPnFL4nr
	 AxLorsgEClgwG2tbT2cxgm7U16gftyWrz7Y/uiwRH3mcJGVyHwDgPieiZeA4Ebb1SurQb
	 9f676ObgsHSuBcNn3UM8PK0OMCmKWd7VBkKOftMAH0oZUqnpjRP9qxAqzCp5ZRUxpmwq/
	 uQv/76Hssv9zAp6iLURK3wAlp3KVNVW+EDbvFP2b6vF/EL8HfHENsm+a6ONevChPhTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421863;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S91HlseoKLlB3tt74lQ0JB+Tg3mHUrQyeQ+NM4I9HJo=;
	b=5VRDBalbm1qkgmWG8PRcyKy8bfhxiuWc18nO6bZSS1ZASzN4CB3n/KtVQgA5wvAO5TAG
	 UGl+YJo1dSJht0EUI2j2+PjDUYPRspsnMVCWGFIywhBOFdThoBl4bvML83XTOswZeRtOU
	 1T7APX/IMOyo+kA9TDBa88KYGZxW89dXc7jtlo4LjbEjl8JIrrBF+9k+rJi13DIRa1kT7
	 yPQ4Dk0QhHEhx4Udir0LLZ5h62ZJNq0qMHIld9/lobnNOxfizEPBI5HhF3JeCdUc7Qiwi
	 6ap0nifrubqTiXgu86lv673LD4QPQ1WS7yrH6SweT0PQu95l0QNz7W1VKBFuyeWmCtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTD9onrx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864A1606A330
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oTD9onrx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEB01F000D2;
	Mon, 23 Nov 2026 08:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795421862;
	bh=S91HlseoKLlB3tt74lQ0JB+Tg3mHUrQyeQ+NM4I9HJo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oTD9onrxDck9tcI4/5WslVLOKxFr2Ighnvs/ZhxiyUy30gK6t8ILCX4m2H64Oq5z3
	 pWEjhR354F8FIG/FJROKoHFoWjuXLI844MKhEqLQQS2B7QcP7o5T00pQCl0arYFItB
	 EA+T1+o4t1aT1eyPjlKse6+pLa2Db98kq05boU5X4yHL2emoP/tcC3QZa+qve2qn9D
	 xc9X4pJkuFGZbx5J+5a35VKQQOED4eca1EDAI7MxjVDFcxtegOCVPO82M/h4NUcEpu
	 LnCgjCSWn8dMiksZLisQ4ac4qnd4gT0JBk9CkSNDRu/FZhfJBf2k6iy50cnsO/NT1f
	 qwLK3tSMs6mLg==
Message-ID: <sashiko-outbox-228894@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: reuseport: honour SO_LOCK_FILTER in
 SO_DETACH_REUSEPORT_BPF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suyuan Wang" <shyckless@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261122-reuseport-lock-filter-v1-1-a3e5324c8d55@gmail.com>
References: <20261122-reuseport-lock-filter-v1-1-a3e5324c8d55@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 08:17:41 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] net: null pointer dereference in reuseport_attach_prog()
  [1]
--

commit da8d8e1657f8b3054e3eb3aca8885a9515a8a782
Author: Suyuan Wang <stevewong@hust.edu.cn>

net: reuseport: honour SO_LOCK_FILTER in SO_DETACH_REUSEPORT_BPF

This commit checks SOCK_FILTER_LOCKED in reuseport_detach_prog() and returns
-EPERM so an unprivileged holder of a filter-locked socket cannot remove the
reuseport BPF program via SO_DETACH_REUSEPORT_BPF.

> diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
> index b9e5648fa4c51..cdff61161a70a 100644
> --- a/net/core/sock_reuseport.c
> +++ b/net/core/sock_reuseport.c
> @@ -727,6 +727,9 @@ int reuseport_detach_prog(struct sock *sk)
>  	struct sock_reuseport *reuse;
>  	struct bpf_prog *old_prog;
> =20
> +	if (sock_flag(sk, SOCK_FILTER_LOCKED))
> +		return -EPERM;
> +
>  	old_prog =3D NULL;
>  	spin_lock_bh(&reuseport_lock);
>  	reuse =3D rcu_dereference_protected(sk->sk_reuseport_cb,

[Severity: Critical]
This problem wasn't introduced by this patch, but can reuseport_attach_prog=
()
right above hit a NULL pointer dereference on reuse->prog [1]?

Unlike reuseport_detach_prog(), which re-checks reuse after acquiring
reuseport_lock, reuseport_attach_prog() checks sk->sk_reuseport_cb outside
the lock on a hashed socket and then dereferences reuse->prog without
re-checking reuse:

net/core/sock_reuseport.c:reuseport_attach_prog() {
	...
	} else if (!rcu_access_pointer(sk->sk_reuseport_cb)) {
		/* The socket wasn't bound with SO_REUSEPORT */
		return -EINVAL;
	}

	spin_lock_bh(&reuseport_lock);
	reuse =3D rcu_dereference_protected(sk->sk_reuseport_cb,
					  lockdep_is_held(&reuseport_lock));
	old_prog =3D rcu_dereference_protected(reuse->prog,
					     lockdep_is_held(&reuseport_lock));
	...
}

If the socket is closed but still hashed and a concurrent reuseport_grow()
evicts it from the reuseport group before reuseport_lock is taken,
sk->sk_reuseport_cb is cleared to NULL:

CPU0                              CPU1
                                  reuseport_attach_prog()
                                    rcu_access_pointer(sk->sk_reuseport_cb)
reuseport_grow()
  rcu_assign_pointer(
    sk->sk_reuseport_cb, NULL)
                                    spin_lock_bh(&reuseport_lock)
                                    reuse =3D rcu_dereference_protected(...)
                                    reuse->prog  <-- NULL pointer dereferen=
ce

[1] https://sashiko.dev/#/bug/linux-08c15fbe-8ad8-46d6-a3d8-bd898520f1ab

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-reuseport-=
lock-filter-v1-1-a3e5324c8d55@gmail.com?part=3D1
