Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B396B246768;
	Wed, 12 Aug 2026 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493450; cv=none; b=MOWCiQayTiodeX+9hrYOUDhXzgoQI8F7xLDlPTerVs0ku7EoYofcG8zHjpfysQcUge0thnvCqox3T9g2PDZZTHktxd/eFWLj9sgu/9/TjeKVLytfj74bs6upbTHmK7PtR2KmnjsIWNEZdP5RHOaz5dD2PxeXoGPDzFDO3earPwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493450; c=relaxed/simple;
	bh=6+Rvy+q5ni6toJ10ZjKsY/p3TsIFcJy3cyoJ8NjC6vU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OZ/jGfIwxMwB9MSWnZyc7ME+p43SgbTF3og9lDjM4EvJLayQQgx6A9aD9EFA7piqXnDYy4YIBGTI7R5fvio/nIyFzKARb4QOWOkfLWr25mkbpGw5WNJUfDxm0IA5AQSacoXfPlk2pSlbGACFoNAo/BhUgTzeAVo1CKkMkpf188w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5vTaPOz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5vTaPOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4EF81F000E9;
	Wed, 12 Aug 2026 00:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493449;
	bh=6DysOza7wvf5cqsIf14GiOVeOVqvMPonzUY+hG6xibI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y5vTaPOzPqRPSrFEV4X+VOZjhulTnkZHiHT9+N8TXRjLvasvr4PKjI0J6jA6DSjjP
	 3N3FDHbRIMQ4fvzof+d2yMrBMr1MVAey2e0vJ51veffII+A6hb42QkbxeyhgysSBlX
	 KLZQHet6rbZaf7BsMo43vs6Qsn6R3al8JnnREMSsvBCqnXUv/JiQA1G7GJVzVHKGsz
	 2SBLcdYDZhvJP1ilrLYR75Vqw4XyFE9dmK999SzKx/MQFIuiwMBRy3apHV/GRiFA3A
	 WIhjmn+KG+++Yp4uqlIwT5rkk9Z/RqTL++ipB0o3V7n15otpJf/S4iNo6DD94y34o2
	 /GdA44YfBqqDQ==
Date: Tue, 11 Aug 2026 17:10:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan
 <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Hangbin Liu
 <liuhangbin@gmail.com>, Krishna Kumar <krikku@gmail.com>, Samiullah Khawaja
 <skhawaja@google.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/3] bpf, xdp: move offload check into
 dev_xdp_install()
Message-ID: <20260811171047.4e6a409c@kernel.org>
In-Reply-To: <cf8655ff-4e45-40ab-898e-aff2aa7145c5@linux.dev>
References: <20260810050621.82035-1-jiayuan.chen@linux.dev>
	<20260810050621.82035-3-jiayuan.chen@linux.dev>
	<20260810114958.64e6a83d@kernel.org>
	<cf8655ff-4e45-40ab-898e-aff2aa7145c5@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Aug 2026 11:06:34 +0800 Jiayuan Chen wrote:
> > It may be better to split the series and send this patch to net,
> > the netdev CI has a netdevsim test for the prog offload, would be
> > good to run that. =20
>=20
> Though for now bpf_xdp_link_update() already does:
>=20
>  =C2=A0 =C2=A0 if (old_prog->type !=3D new_prog->type ||
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 old_prog->expected_attach_type !=3D new_prog=
->expected_attach_type) {
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EINVAL;
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_unlock;
>  =C2=A0 =C2=A0 }
>=20
> so the other checks can't be triggered on the update path even without=20
> them in dev_xdp_install().
>=20
> So I'm thinking this patch works as a standalone fix (good for=20
> backport), and the cleanup goes as a followup (if necessary)?

Just do it right please. Feels like we are promised a follow up to
every single patch these days :/
