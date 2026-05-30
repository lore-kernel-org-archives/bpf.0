Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0772874F8
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101907; cv=none; b=sJVvCaEhI0k0FzudcVDPM5+4W8jmgGlm4Gullp/PczjbWS02k4Ub86ge5yuSuBai4C+PIl1SDdb5uYjmWld/e80lQHC+dWigsmnuZOQHto4vVfy+K8FEOCZveZnUpFQk0yFoF6yEZeTIpUVZ90kAg/5MgoK9A62dexuGnZaWk7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101907; c=relaxed/simple;
	bh=Ud8TUl2f4+CSnlYHFTozYNtJQ1ITQ43Bo//P/60rsVo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oe8YqKA5m8eI7p56yoMbhkA0iUhrmd3WxMc7qg3UQiuRbK2lP52Zz+cagYe+vWbA2zZeblbXKScX6ThB4I3gtCS9K8yl98KX++lkxFJzqvsuMrY01y20AUlTqu76dESXUKZc3mDXsCvqHCWypA8kEOW40biQAHF6JyBsMOMT/Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8Ddgr53; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8Ddgr53"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563371F00893;
	Sat, 30 May 2026 00:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101906;
	bh=48CV2JUMNMt3kmGJhBZRem2shyEv+B/NpH3l79eGs44=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b8Ddgr53jDoqTjuWLIh9nj5yO9x3s8FDefJn0qayNi16LwRDORsEw3/Dp9AeqMlSj
	 zolYYgTYkLKg8CKF5iq+ot9eOoWCtVmVG4rB1aK+GKtDiFXpWbDAuBiy4UkCoo4zIC
	 qraOmK4rmDggTwENBeFxc6b1ZTAVAMdm6jZU4PA+4Q1bbnJ/UhLgjJ3dBBu9GfAE4G
	 F2XJmlanWFCy28Q7pQCixnvt1RTr3PRRuOOozKIFmJkuRuuu8anC2Om+Jo+VnClhOn
	 kFVnwiomVYDcN90iliqzHqVi2gxy0RhG93k9CRrwkZ9eyGAECwaDxsEUcvMwzIc/jd
	 w76OVuMQqjq6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 1/6] af_iucv: convert to getsockopt_iter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520-getsock_four-v3-1-b8c0b16b7780@debian.org>
References: <20260520-getsock_four-v3-1-b8c0b16b7780@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:45:06 +0000
Message-Id: <20260530004506.563371F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `SO_MSGSIZE` case accesses `sk->sk_state` and `iucv->hs_dev` l=
ocklessly, creating a TOCTOU race condition that can lead to a Use-After-Fr=
ee or NULL pointer dereference.
- [High] Concurrent freeing of `iucv->path` in softirq context causes a Use=
-After-Free or NULL pointer dereference in `SO_MSGLIMIT` getsockopt.
--

commit d750d707b0b3fe311f910c753df00e12fdb56b85
Author: Breno Leitao <leitao@debian.org>

af_iucv: convert to getsockopt_iter

Convert IUCV socket's getsockopt implementation to use the new
getsockopt_iter callback with sockopt_t.

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 72dfccd4e3d58..7a5ce93a83d9c 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
[ ... ]
> @@ -1535,7 +1536,7 @@ static int iucv_sock_setsockopt(struct socket *sock=
, int level, int optname,
>  }
> =20
>  static int iucv_sock_getsockopt(struct socket *sock, int level, int optn=
ame,
> -				char __user *optval, int __user *optlen)
> +				sockopt_t *opt)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but does the SO_MSGSIZE case
access sk->sk_state and iucv->hs_dev locklessly?

If another thread concurrently closes the socket, iucv_sock_close(sk) takes
lock_sock(sk), drops the device reference with dev_put(iucv->hs_dev), and
clears iucv->hs_dev.

If the getsockopt thread checks iucv->hs_dev !=3D NULL but gets preempted
before dereferencing iucv->hs_dev->mtu, could this lead to a NULL pointer
dereference or use-after-free when the other thread executes
iucv_sock_close(sk)?

[Severity: High]
This is a pre-existing issue, but could there be a use-after-free or
NULL pointer dereference when accessing iucv->path in the SO_MSGLIMIT case?

While getsockopt() holds lock_sock(sk), which sets sk->sk_lock.owned =3D 1
and re-enables softirqs, an IUCV path severed interrupt could fire and run
iucv_callback_connrej() in softirq context.

If iucv_callback_connrej() calls bh_lock_sock(sk) and directly calls
iucv_sever_path(sk, 1) without checking sock_owned_by_user(sk), it will
free the path structure.

When the softirq returns and getsockopt() resumes, could it dereference the
freed iucv->path->msglim pointer?

>  	struct sock *sk =3D sock->sk;
>  	struct iucv_sock *iucv =3D iucv_sk(sk);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520-getsock_fo=
ur-v3-0-b8c0b16b7780@debian.org?part=3D1
