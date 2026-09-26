Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD27305665
	for <bpf@vger.kernel.org>; Sat, 26 Sep 2026 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790438192; cv=none; b=UHu/frHoJrGSBsjPh0jsezg35lBOVYc7xdUJ77OWTdFh0ATF32Ic21IUieAc7LmKd8KwNHL2DVGT9bkfVXq9qHFnVlKdl9HimVzGcxZYCX2VX3bYrccGxunjH9kgiJwwK0JeX4mgHPXdLM808Cz+h5mRBNBsKSOMdZn8BSygI24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790438192; c=relaxed/simple;
	bh=CpZ3O71iV2MJWp4DqqTAE0tLfrVg0Ql5qJOK+nO32Xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CdbshbH/F3AhNDid3MSRA79ZAAJPM9BqDb/78eKVm9MFf2KmJdPSVIHcMxwn1eyfuMsOj84TcBGHU0xMryhsZoR7tJ13IXvoKzVruMbh4ktRY120a83wctcDlTSpxrTLQ8n2izHhhGQ7fYtgWcp8yGQLRoA27/fbRTDGbqA6a2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebrEgMD8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ebrEgMD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E6F1F000FF;
	Sat, 26 Sep 2026 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790438191;
	bh=sFscBNEfEbpA9dAOHkeG7R8CL+lje2+tz9gd8z24yDw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ebrEgMD8sBFblZ8KLhKC8UtUDEQc58ObQuDsQCcb8LPLyeZb3J6ipblcQUPFDsNe2
	 NozrnP3mIj2rCNIP2dunSFrL71/9t6Qh+x3foHEGgb7uBeS/vlcUcMFGMIV9IBbaxo
	 Ivmnm+tvMmXuSGUiAU2OtuGj8qYBb/35eEO/RtAzRWXcHC54HcFY2RmyBYc1wPObqx
	 987JCwNoHl8/Qa89UkrCC/8cRF5wxCILxqQB93PAV88urYvv6hFm5cwOAykhl5FfGM
	 G05xF5OHcJJZK8KD1Y/UAUXnX1mEYemgVdpSrFVNyZcegJk+7NR9jJHMX/iNEFLrNS
	 yFrfQlpPKq1MQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 4/6] ipv4: convert do_ip_getsockopt() to
 sockopt_t
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260925-sockopt_expand_out_v2-v1-4-c3ef2e3bb5c0@debian.org>
References: <20260925-sockopt_expand_out_v2-v1-0-c3ef2e3bb5c0@debian.org>
 <20260925-sockopt_expand_out_v2-v1-4-c3ef2e3bb5c0@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 26 Sep 2026 15:56:30 +0000
Message-Id: <20260926155631.13E6F1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: MCAST_MSFILTER leaks modified optlen to userspace on copy f=
ailure
--

commit 28c83ba3c12df5eadd41490e34288c12faadfb4f
Author: Breno Leitao <leitao@debian.org>
Subject: ipv4: convert do_ip_getsockopt() to sockopt_t

This commit converts the SOL_IP switch and ip_mroute_getsockopt() to use
sockopt_t. It updates ip_getsockopt() to write optlen back unconditionally,
and modifies ip_mc_msfget() to store its length last so it doesn't report
an updated length if it fails.

> diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
> --- a/net/ipv4/ip_sockglue.c
> +++ b/net/ipv4/ip_sockglue.c
[ ... ]
> @@ -1783,19 +1759,22 @@ int do_ip_getsockopt(struct sock *sk, int level, =
int optname,
>  int ip_getsockopt(struct sock *sk, int level,
>  		  int optname, char __user *optval, int __user *optlen)
>  {
> +	sockopt_t opt;
>  	int err;
> =20
> -	err =3D do_ip_getsockopt(sk, level, optname,
> -			       USER_SOCKPTR(optval), USER_SOCKPTR(optlen));
> +	err =3D sockopt_init_user(&opt, optval, optlen);
> +	if (err)
> +		return err;
> +
> +	err =3D do_ip_getsockopt(sk, level, optname, &opt);
> +	if (put_user(opt.optlen, optlen))
> +		return -EFAULT;

[Severity: Medium]
Since put_user() now unconditionally writes opt.optlen back even if
do_ip_getsockopt() returns an error, does this leak modified lengths to
userspace on failure for MCAST_MSFILTER?

The commit message notes that ip_mc_msfget() was changed to store its length
last because of this unconditional writeback. However, the MCAST_MSFILTER
handlers (ip_get_mcast_msfilter() and compat_ip_get_mcast_msfilter()) still
set opt->optlen before their final copy_to_iter() calls.

For example, in ip_get_mcast_msfilter():

	opt->optlen =3D gsf_size;
	/* ip_mc_gsfget() consumed the whole reply; rewind to the fixed part. */
	iov_iter_revert(&opt->iter_out, gsf_size);
	if (copy_to_iter(&gsf, size0, &opt->iter_out) !=3D size0)
		return -EFAULT;

If this final copy fails, do_ip_getsockopt() will return -EFAULT, but the
updated optlen will still be written to userspace.

A similar pattern exists in compat_ip_get_mcast_msfilter():

	opt->optlen =3D len;
	/* Rewind to gf_fmode, which gf_numsrc follows. */
	iov_iter_revert(&opt->iter_out,
			len - offsetof(struct compat_group_filter, gf_fmode));
	if (copy_to_iter(&gf.gf_fmode, sizeof(gf32.gf_fmode),
			 &opt->iter_out) !=3D sizeof(gf32.gf_fmode) ||
	    copy_to_iter(&gf.gf_numsrc, sizeof(gf32.gf_numsrc),
			 &opt->iter_out) !=3D sizeof(gf32.gf_numsrc))
		return -EFAULT;

Should these handlers also be updated to set opt->optlen only after all
copies have succeeded, matching the change made to ip_mc_msfget()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-sockopt_ex=
pand_out_v2-v1-0-c3ef2e3bb5c0@debian.org?part=3D4
