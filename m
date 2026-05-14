Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B323DD844
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778762701; cv=none; b=EvyKH6u4tZ1Y/ApDIH2BaUjLdN8oQPZX53B1GgA6G+niR9w/Qwz98aMYtdEmTO7YKcOiEEwI/Eh+w93TCEJ7jDdedAiMXwn4zAbyZfsUOdaA6Sb21+4rV+ZD95KDEW5nG9v3v43e8b81kNOYkodY0fGno4/T1DLkB4x5CqyyIPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778762701; c=relaxed/simple;
	bh=aNb7MA3WFYhEp0yi7jn2img/OcJuL/5Qw2e3JMpnmFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y48XmpWZMd3ndyFgaNFDtF7iRsQVPXyK99yLGrtVZzBBuKMWkSonJnn8BoWNRiUgWOeLmmBPIMFmIucfmNAZLfoExd6zbwgBjyC7XkGtYUvISm2HSKpnxfPolztUl/nTOhpn77nk4Yx4YGhFeWLTpw8Yz+kZz4yC6kVh+RKpzkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O3AMIr5Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O3AMIr5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43BC2C2BCB3;
	Thu, 14 May 2026 12:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778762701;
	bh=aNb7MA3WFYhEp0yi7jn2img/OcJuL/5Qw2e3JMpnmFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=O3AMIr5QE/+h6SZV5Lu+kmhZ3B9zfTROyxuEupTuqq3iy8SbTMahf6qYXJqgcXslg
	 ibxUIHH62RmGnWwJTact3tLQh9DjegqQdy3LYNsLoGyszokKNYeu/4YS/MwYm+vAJU
	 +sGIwN/9RLhMo+SVvn94pfGeJuRNClw1U9Ik7HeCd+Pem8KCf2Vc0KVZtvEmSOtOeS
	 0BjGHBDvSkMkEeqao3x8ArfMwH0fjH935z6ydUI8mg9UkPdmcDaOlhaOEKORvwkyxk
	 MOSPUqzKxsnXzvISTOx5vtbbziBctelKymiX5tUMZWO9i2zxTPamhFNLoCcsyx8x3X
	 wUvi1EcJ+KX2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/6] atm: convert to getsockopt_iter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260513-getsock_four-v1-1-fe7f0e756fac@debian.org>
References: <20260513-getsock_four-v1-1-fe7f0e756fac@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 12:45:00 +0000
Message-Id: <20260514124501.43BC2C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] getsockopt(..., SO_SETCLP, ...) unconditionally fails with -EFAULT=
 on 64-bit systems due to a size mismatch.
--

commit be3fd8a3e8c34e64e9da9ed374ea4925d11bbbe7
Author: Breno Leitao <leitao@debian.org>

atm: convert to getsockopt_iter

This commit converts the ATM SVC and PVC sockets, along with the shared
vcc_getsockopt() helper, to use the new getsockopt_iter callback with
sockopt_t.

> diff --git a/net/atm/common.c b/net/atm/common.c
> --- a/net/atm/common.c
> +++ b/net/atm/common.c
[ ... ]
> @@ -797,13 +798,13 @@ int vcc_setsockopt(struct socket *sock, int level, =
int optname,
>  }
> =20
>  int vcc_getsockopt(struct socket *sock, int level, int optname,
> -		   char __user *optval, int __user *optlen)
> +		   sockopt_t *opt)
>  {
>  	struct atm_vcc *vcc;
> +	unsigned long val;
>  	int len;
> =20
> -	if (get_user(len, optlen))
> -		return -EFAULT;
> +	len =3D opt->optlen;
>  	if (__SO_LEVEL_MATCH(optname, level) && len !=3D __SO_SIZE(optname))
>  		return -EINVAL;
[ ... ]
>  	case SO_SETCLP:
> -		return put_user(vcc->atm_options & ATM_ATMOPT_CLP ? 1 : 0,
> -				(unsigned long __user *)optval) ? -EFAULT : 0;
> +		val =3D vcc->atm_options & ATM_ATMOPT_CLP ? 1 : 0;
> +		return copy_to_iter(&val, sizeof(val), &opt->iter_out) !=3D
> +		       sizeof(val) ? -EFAULT : 0;

On 64-bit systems, val is an unsigned long (8 bytes). However, __SO_SIZE
for SO_SETCLP is 4 bytes, which is enforced by the length check above.

Since the opt->iter_out iterator is restricted to 4 bytes, copy_to_iter()
will truncate the copy to 4 bytes and return 4. Does this mean the
subsequent check against sizeof(val) (8 bytes) will always fail and return
-EFAULT unconditionally?

Additionally, on 64-bit big-endian systems, does copying the first 4 bytes
of an 8-byte unsigned long always copy zeroes, ignoring the actual flag
value?

Would declaring val as an int instead of an unsigned long resolve both the
copy size mismatch and the potential endianness issue here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513-getsock_fo=
ur-v1-0-fe7f0e756fac@debian.org?part=3D1
