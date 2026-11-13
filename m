Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589670;
	b=WnYEJhKR9JlFMxEtVUbSBZoyOdE3CknMS8bi55Iit+AmvncRLhpfqkFQsOCid84EmN26
	 XV0db9Bb82GapORYjFGsLTcTOBd2aqltz1SXctyaTmP+E6sGj4c8nx7cxJEiUAsU24FjT
	 rb27JpGL3YFjz7MO0fAl+gswi0dhsFGkkG32fxUYVxw4DY7bDOeO5eHOLT9kvB/WdLBmW
	 Rgb3xTmLmaMIb2DuI2IgUXaA7dYgizjoFaiGfQ8y/P7q9O+iZhUCk4Ukjj/QDWzHYTiLs
	 fuE7IxoRfqIyPvB2E57Ynh/j4EehRSbxfk/Zjc3F2AEQeFYeM1B637xVqtR64xqH8Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589670;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NQzhutDUub2+BeweYXmAJd5ZQ1j21fbFWwglmjxib/0=;
	b=g7ndsQA2286vbMdqNpbWWnckPk+8b+JodhwHe5pk9w9k0apUQENKRuN3EotQtk1rs8D1
	 7TN3DWT0quPU1BRKL9BEZYaKOeRtLiTBgDwb1iNXUszndA1F/+D3wZHD5cj+EtYwpy7UC
	 ltKYaG8efKgVpd32E1K46+IPz0BZ7Acf9a2poU2yLXlXbZ1zxD73PIPXwJ8FhqbmZTkrl
	 J5ArbrQj0FDuY6z390JUL83LGOdDULlhDoq4OcxOYiVRl/ceKAUAA1IRIiy9cmN2YHPa1
	 AQq/UjcEA+gqa/za7wlIawrtS9/5KBEurHF/GmnWzuxcbN1Pm0zRvY85yGJPM4ivV+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VC0tk+fK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909F8606A334
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 17:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VC0tk+fK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501D41F000C5;
	Fri, 13 Nov 2026 17:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794589670;
	bh=NQzhutDUub2+BeweYXmAJd5ZQ1j21fbFWwglmjxib/0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VC0tk+fKsC7+yB0P6rR9rMfnhP3X0UXwjVl3JzwQ07EpPy9kNnGYfX3KkQI1StwdZ
	 dk6e6Veb0+jzOknQ/iKftDkDyuVl9kym/VyldCLvJLW1Hwo9OxtJmDgCikPt9xZame
	 rEXZkvi8QAn6z7T7ZwIFYta58HCXjkySMKM10MTb2n1bXDlVx9nsx0EhfOH50ECCY0
	 j97uiOVeCm3DO302gNujufzxOFUXRLSFIJe+XUpEOqlaneXe20h/3GlOGf+s03G2z+
	 H/jrRjCVKbZfVb4H/4jecUuJ6DSBSyNXX7ons06Gvkzo2mYOqzBKh5S+ZSPOxySFWm
	 j8ya8jDo6EL/w==
Message-ID: <sashiko-outbox-213275@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 2/3] tcp: convert do_tcp_getsockopt() to
 sockopt_t
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261112-getsockopt_phase7-v1-2-1eb759dd0929@debian.org>
References: <20261112-getsockopt_phase7-v1-0-1eb759dd0929@debian.org>
 <20261112-getsockopt_phase7-v1-2-1eb759dd0929@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:07:49 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bpf: non-standard multi-line comment style in
  sol_tcp_getsockopt()
--

commit adc743711fff2b36324cfbce470ae256d9f2a174
Author: Breno Leitao <leitao@debian.org>

tcp: convert do_tcp_getsockopt() to sockopt_t

This commit converts do_tcp_getsockopt() to take a sockopt_t pointer and
updates tcp_getsockopt() and the bpf sol_tcp_getsockopt() helper to pass
one.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9b8d5191c4ba2..0d5afe1c5606b 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -5686,6 +5686,28 @@ static int bpf_sol_tcp_setsockopt(struct sock *sk,=
 int optname,
>  	return 0;
>  }
> =20
> +static int sol_tcp_getsockopt(struct sock *sk, int optname, char *optval,
> +			      int *optlen)
> +{
> +	struct kvec kvec;
> +	sockopt_t opt;
> +	int err;
> +
> +	err =3D sockptr_to_sockopt(&opt, KERNEL_SOCKPTR(optval),
> +				 KERNEL_SOCKPTR(optlen), &kvec);
> +	if (err)
> +		return err;
> +
> +	/* BPF may call this in softirq: with page faults disabled, the
> +	 * usercopy check skips find_vmap_area() and its lock.
> +	 */

[Severity: Low]
This isn't a bug, but bpf code uses the kernel multi-line comment style
where the opening /* goes on its own line and the comment text starts on
the next line.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-getsockopt=
_phase7-v1-0-1eb759dd0929@debian.org?part=3D2
