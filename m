Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05F346EF68
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784659096; cv=none; b=bbQVRaKT5oOl38nRTlHxYFWPJnzheVnPm4RNz9ycdtOd/GrIQgN2duvJaf6844Pa1pguH5xgFg0iy1oplmojNZJqNX4N8G10265sxARckjFFWXokAC3SCJf+asl89YkOl1rQSD9HJUrpanr0cqCumP836tZr0i3wMiZHfHb71qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784659096; c=relaxed/simple;
	bh=hOWkCrmj7KmsaFrXPpokkwozEwB2+hiuCtUceLtNcTM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=FgJeevc5FVQtx9KbjRyS6vUJLbio7YeMKqeHssQWHAHNYfIw6FY7G4exrE0Up+OIwghKS/qK8c6HzotBy70GA05P94yEeV56w21LkFFU1dvU3x+v5N5XySOo5u5jYoknsoI8Aqdnl6T351jYedvLppiyHFe5cZ1RTy2b/ofooaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=b04m9TaN; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="b04m9TaN"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8486672f03cso11665848b3a.0
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 11:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1784659087; x=1785263887; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KmrfLRCH7CRu8zb9ZdbWVFH1aGIDgJHl2tYk/WpW5mY=;
        b=b04m9TaNSv79tnRznVLDnRxoc0zrqyyv7C8bP1PUE+fEUZ4L2N1P9/+NblkjwiLOBX
         m1jsLaj91YDnmXrsHahcBDAPN3z/2HT0mx8fqJBflHAcsM7MMjMcrVgFhsHeyUDmIAZc
         RYmmivO5uObadKXFYozRaF/PqRh5e2wcqUg/lK2Mos9rYBypZmcrj/1gh08F5tOcWblJ
         U3qQs/VxJnIi72i2FWCKmsOejps35sDcV8BCuQZWlZ2vbxqtdwQUS4Lpyy62vKVT0pGP
         45KFtOA44EC8097rPp4QDMup+MV/Fnhp58Dz9wXKF78xhrzlb/5X5vKyhoCclJa94vxr
         jcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784659087; x=1785263887;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmrfLRCH7CRu8zb9ZdbWVFH1aGIDgJHl2tYk/WpW5mY=;
        b=lKnwmP+C3WypzzOFORNtNRSGXuR84NkHhIJP7P9U78FCRIVByJrBP940gvBUD5yV54
         vEXR4EhXg2h9noThCkFY3s0IZPBLIAzIObJ90GQwS8oB+fHM40GTy6g5dlKgQ4bKkfkP
         Q1dLKVcrMMcVw2soSAwxvkPFhuXtz0rLKhyTZF1JcuRL4kLX47XRnVjh+e0gYIMw0jVJ
         GOTytnaqqPSFqTIsZflHvCEFsPQH38FUxVKTOliRSMIY/4Sg06C70wKuxU/hwixWBenZ
         oQFA4o7q7Iqn0vQodPIBdg+25VGhgYjlvmglig6G/I/gheOfIHBzK5xp9m0WEeXXf3pk
         xBfA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2fApOo7r/8ywdmdWWsPtZOU03/cpFU3/wRFSm38dSFlGX3WI1t4yycKblcINFVlnRhnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwMUP+ERNaHMdkC74Y9RGyNcZTihYdxMJs+9fImAopgkZ5UNoW
	iJjH4UCKK1nneR+zGU5R7Zfuo/u5wokMKPyWiDtTU6G6tgPnOtU5VTSbpi5SOOWkYk0=
X-Gm-Gg: AR+sD13WRGn2qEjljTVCbWvLNMWsTp/y8agjTOc+tg2PfpkBA/TOrmop/UgYQlNlk0y
	iv3gb+Rsm2tPqVSwQ6pQlpjNJb89UayHHYdpuC0pyIDRUjRtVc91KVppla2ASiJ7uXcLaVI5+Ft
	cojwpnpkEhWrNYBy6Cj2gkEzhAupJONCvM8KObauz4xIdqIS1fDgXjYlFPlqIfcXTvW+rkCr3aN
	cNcfZtoRNRohGM6Wl7TMiaCtb3dMbsUzSQWrFYAlPs9RHdEm4Fb6oc9C6bcB6/Kll+L2vlbQnDN
	J1Bbz2bZ0d+xPhVTeORN12wGSlnIPkA3aDaxorvhbgNntPaHpTJjg0dMYOwR3yFTdrvBWQQdo71
	3lP66HVLvHNFUjJKXIb1Jwrbua70Ib8LJJGsdkHOSxTrCRQVO8Xm+iZ4tRJU=
X-Received: by 2002:a05:6a20:d529:b0:3b4:731e:6f95 with SMTP id adf61e73a8af0-3c3ad947d7fmr19682878637.39.1784659086752;
        Tue, 21 Jul 2026 11:38:06 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::4a7b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147e1bc886sm1042855eec.26.2026.07.21.11.38.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2026 11:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 14:38:04 -0400
Message-Id: <DK4GUGY3M3F4.3NZYQ6NZXNBYG@etsalapatis.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Song Liu" <song@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Pu Lehui"
 <pulehui@huawei.com>
Subject: Re: [PATCH bpf v5 1/4] bpf: Fix potential UAF in
 bpf_netns_link_update_prog
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Pu Lehui" <pulehui@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Mykyta Yatsenko"
 <mykyta.yatsenko5@gmail.com>, "Amery Hung" <ameryhung@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260721041048.1394085-1-pulehui@huaweicloud.com>
 <20260721041048.1394085-2-pulehui@huaweicloud.com>
In-Reply-To: <20260721041048.1394085-2-pulehui@huaweicloud.com>

On Tue Jul 21, 2026 at 12:10 AM EDT, Pu Lehui wrote:
> From: Pu Lehui <pulehui@huawei.com>
>
> In bpf_netns_link_update_prog, the checks for old_prog and prog type
> are currently performed locklessly before acquiring netns_bpf_mutex.
> This creates a race condition that can lead to a UAF issue.
>
> If two threads concurrently execute BPF_LINK_UPDATE on the same netns
> link, the following execution path can trigger a UAF:
>
> CPU0                                          CPU1
> bpf_netns_link_update_prog
>   if (old_prog && old_prog !=3D link->prog)
>     return -EPERM;
>                                               bpf_netns_link_update_prog
>                                                 if (old_prog && old_prog =
!=3D link->prog)
>                                                 ...
>                                                 old_prog =3D xchg(&link->=
prog, new_prog);
>                                                 bpf_prog_put(old_prog);
>   if (new_prog->type !=3D link->prog->type) <-- trigger UAF
>
> Fix this by moving the old_prog and prog->type checks inside the
> netns_bpf_mutex critical section.
>
> Fixes: 7f045a49fee0 ("bpf: Add link-based BPF program attachment to netwo=
rk namespace")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Reviewed-by: Amery Hung <ameryhung@gmail.com>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> ---
>  kernel/bpf/net_namespace.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
> index 25f30f9edaef..9fc62db1441c 100644
> --- a/kernel/bpf/net_namespace.c
> +++ b/kernel/bpf/net_namespace.c
> @@ -171,13 +171,17 @@ static int bpf_netns_link_update_prog(struct bpf_li=
nk *link,
>  	struct net *net;
>  	int idx, ret;
> =20
> -	if (old_prog && old_prog !=3D link->prog)
> -		return -EPERM;
> -	if (new_prog->type !=3D link->prog->type)
> -		return -EINVAL;
> -
>  	mutex_lock(&netns_bpf_mutex);
> =20
> +	if (old_prog && old_prog !=3D link->prog) {
> +		ret =3D -EPERM;
> +		goto out_unlock;
> +	}
> +	if (new_prog->type !=3D link->prog->type) {
> +		ret =3D -EINVAL;
> +		goto out_unlock;
> +	}
> +
>  	net =3D net_link->net;
>  	if (!net || !check_net(net)) {
>  		/* Link auto-detached or netns dying */

