Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DEE19EED3
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 01:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792287560; cv=none; b=dbvEVAE7Z9ojigtYm3+4sfvWcH5KxRx3XIUb8Iokjhc5b5Ngvtvn1xsG/UcmTau48dNe+CGUzcgAmhoLeqgJ9DsMZGfmTms65vVO2sv0mqXSPURsKYTzElU5uIdDH8wOmeViysl8TGZq4c4C9NAP/8a71oBXMl7tglZedPIqUDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792287560; c=relaxed/simple;
	bh=HvMFGtkZnp6qh1GWz/McszZVSQ93Isux8/T4lHj3NXw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=BJY+j9QNltVHIxcibavvp1xA9/8bYv5a5egcHnQO1KNdVufbkSGN+d47iqjnb3kI/zWTcUtkkPZfBu3DDUXTMPHy39fDww6QfBKhvdNQ0NxA4ipl93dGzZwmvW+MyAB0axOG05AEzFrRtWmzuqdPevsfGuFs0n8v6hw+aE8KMUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPU6Tekk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPU6Tekk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE7E1F000C4;
	Sun, 18 Oct 2026 01:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792287559;
	bh=+k4GwLfhLwmuNl3Hop7FK5vsxKuq9Xn8i3YlcoJrydo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EPU6TekkiIC+VPwhff0rAAFaybrrFEGz99s1Goj1DjujJOTUYnJhocxsFCNz7nL2k
	 CxdRNt/pSUTuOG9iJXOVbADM3LTDb2ebuiwlhMUE1OwKEAUwYxvvjP5f0NtzI8ucs1
	 f4ScwjyhAamu6bRZFOIIS/Wh0jByA3ZtVyuBDQPXriHhZ2jGt0xxQHvtH4C5vmiw0k
	 YYSsw6+d/O2XyRrAoP+e1024XP/yJ8/I/RDCOYUT/qrupm8u7aprojzuDnjgclpohG
	 InwdT7yb6YDdu5b/WhVpUEe0+6u0QzwWerKdWknTrARiiKGU41e46IlJV/lGO+hU/g
	 5C9TUmAphn8ZA==
Message-ID: <sashiko-outbox-175874@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: free the policies if a socket's clone fails
 late
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261017013912.396296-1-alexei.starovoitov@gmail.com>
References: <20261017013912.396296-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 01:39:18 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: xfrm policy leak in sk_clone() when xfrm_sk_clone_policy() =
fails
--

commit a4aae636f8ebbd9f602d754c2bcb096a55363b3d
Author: Josef Bacik <josef@toxicpanda.com>

net: free the policies if a socket's clone fails late

This commit calls xfrm_sk_free_policy() in sk_clone() when
bpf_sk_storage_clone() fails so that cloned IPsec socket policies are not
leaked when freeing the new socket.

> diff --git a/net/core/sock.c b/net/core/sock.c
> index 1302c1e848b2a..cdbd49ff71b0a 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2578,8 +2578,10 @@ struct sock *sk_clone(const struct sock *sk, const=
 gfp_t priority,
>  		goto free;
>  	}
> =20
> -	if (bpf_sk_storage_clone(sk, newsk))
> +	if (bpf_sk_storage_clone(sk, newsk)) {
> +		xfrm_sk_free_policy(newsk);
>  		goto free;
> +	}
> =20
>  	/* Clear sk_user_data if parent had the pointer tagged
>  	 * as not suitable for copying when cloning.

[Severity: Medium]
Can newsk->sk_policy[0] still leak if xfrm_sk_clone_policy() fails on the
second policy?

In net/core/sock.c:sk_clone(), just above this block:

	if (unlikely(!is_charged || xfrm_sk_clone_policy(newsk, sk))) {
		if (!is_charged)
			RCU_INIT_POINTER(newsk->sk_filter, NULL);

		goto free;
	}

When is_charged is true and the parent socket has both sk_policy[0] and
sk_policy[1] installed, xfrm_sk_clone_policy() clears newsk->sk_policy[0..1]
and calls __xfrm_sk_clone_policy():

net/xfrm/xfrm_policy.c:__xfrm_sk_clone_policy() {
	for (i =3D 0; i < 2; i++) {
		p =3D rcu_dereference(osk->sk_policy[i]);
		if (p) {
			np =3D clone_policy(p, i);
			if (unlikely(!np)) {
				ret =3D -ENOMEM;
				break;
			}
			rcu_assign_pointer(sk->sk_policy[i], np);
		}
	}
}

If clone_policy(p, 0) succeeds (allocating the policy, linking it into
net->xfrm.policy_all, and incrementing net->xfrm.policy_count[XFRM_POLICY_M=
AX])
and clone_policy(p, 1) then fails, __xfrm_sk_clone_policy() returns -ENOMEM
with newsk->sk_policy[0] still populated.

Because sk_clone() jumps directly to free without calling
xfrm_sk_free_policy(newsk) on that path, wouldn't newsk->sk_policy[0] still
be leaked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261017013912.3962=
96-1-alexei.starovoitov@gmail.com?part=3D1
