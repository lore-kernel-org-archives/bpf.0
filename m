Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9C73812D3
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 12:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762703; cv=none; b=qLxeTYD3JyLNmypl/DkoMffeMaFafdrQsXWE/WbWBgrjZStPIT+ggRriwChefscZ4kVyEXeXRV6iW+QhrZZIK2HwfnbDTNqoAe846/ISkvaxvtJThkKDT0POIXp9X7aDTBniYyMMTLa7z9DizKAnmvZwXn6JRQ80e8+tW7jpICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762703; c=relaxed/simple;
	bh=inD9yKX5Vx4mE6TvB/1cLEWXe0/9U0WufzWDw84EPnc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bXc1Who3oGiMLYc/ojxD7NITbAx1f2kwt8oqRhAjhSLWMwSg7TgtEpkP8OzYUnc5Q701F4QloUMPY0QhN0TSOGSyehidZSMoSnEXNpM4GG+Y0a7yTXwGFqwy0KPHmXy8hgGezu0Bg2T/zaP9rNllIiH7Kl1mUWhYi3Pf+MEsdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD2y9PNv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD2y9PNv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2ABC2BCB3;
	Thu, 14 May 2026 12:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778762702;
	bh=inD9yKX5Vx4mE6TvB/1cLEWXe0/9U0WufzWDw84EPnc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=FD2y9PNv5CX0eF1LC1aTqoQDgItkQtejJ7BHX0yaiEdYC81JDZf4w8eX47v8/INBO
	 z8hpVoWParMVMVEigoe7W0myIZNtMoyqvlav2mX9xnH/D0oDc1StkcXrht2BbogkMM
	 LKEv5ls4yScSQIk6YBpM6FTiTUmpUmGk9JLH6lpTPaNnvYdLchXm+j+bqECNpZLJ15
	 Kfy0AXsFccqP6ERItsi5TTR/ntkSQs90mPBSo1agJbPas6NvPt1wHCzIhuPGFNwgBy
	 9vdbSsQ98cq3hHuP+q3bqrNQEsTlSBOyeKuit8D5n5O86rs+RfttJl5J6GJBW9ZQNA
	 5M3o/gcKs5e0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 3/6] af_iucv: convert to getsockopt_iter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513-getsock_four-v1-3-fe7f0e756fac@debian.org>
References: <20260513-getsock_four-v1-3-fe7f0e756fac@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 12:45:01 +0000
Message-Id: <20260514124502.5C2ABC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unlocked access to `iucv->hs_dev` in the `SO_MSGSIZE` case can lea=
d to a NULL pointer dereference or use-after-free.
--

commit f3b71ba02ea8266fcb82046dd3417eeb5b94f2d5
Author: Breno Leitao <leitao@debian.org>

af_iucv: convert to getsockopt_iter

This commit converts the IUCV socket getsockopt implementation to use the
getsockopt_iter callback with sockopt_t. It replaces direct user copy
functions with copy_to_iter.

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
>  	struct sock *sk =3D sock->sk;

[ ... ]

> @@ -1574,9 +1573,8 @@ static int iucv_sock_getsockopt(struct socket *sock=
, int level, int optname,

While reviewing this conversion, I noticed a pre-existing issue in this
function. Does the SO_MSGSIZE case need socket lock protection when accessi=
ng
iucv->hs_dev?

In iucv_sock_getsockopt():

        case SO_MSGSIZE:
                if (sk->sk_state =3D=3D IUCV_OPEN)
                        return -EBADFD;
                val =3D (iucv->hs_dev) ? iucv->hs_dev->mtu -
                                sizeof(struct af_iucv_trans_hdr) - ETH_HLEN=
 :
                                0x7fffffff;
                break;

If iucv->hs_dev is cleared concurrently by another thread holding the lock
(such as during iucv_sock_close), could the compiler emit two separate
memory loads for hs_dev since READ_ONCE() isn't used?

If the pointer is set to NULL between the check and the dereference for mtu,
could this result in a NULL pointer dereference, or a use-after-free if the
socket held the final reference to the net_device being unregistered?

> -	if (put_user(len, optlen))
> -		return -EFAULT;
> -	if (copy_to_user(optval, &val, len))
> +	opt->optlen =3D len;
> +	if (copy_to_iter(&val, len, &opt->iter_out) !=3D len)
>  		return -EFAULT;
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513-getsock_fo=
ur-v1-0-fe7f0e756fac@debian.org?part=3D3
