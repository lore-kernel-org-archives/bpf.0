Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0003742A15F
	for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360997; cv=none; b=NUd09bzLFVKE14LTpJHxu9RxoEcutI9iCf16Z7LlJz9E/e+ZJyEOc0VNM3P5J7EzH4/XSuKXai2CLEK7peyjD82pnivE2vmLrfuXWIlxQd6+iGAWPj/8Gr/tcc3uDONZykujrMHh1c7O8rNeDLOiDQkfzpm+Nks6/7tTMeZ2BoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360997; c=relaxed/simple;
	bh=yR5fKIYVJcWc/ZaDA+dXlb0F+aNrx3vc41X3bspmR9U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=hrt4mTD0YWfoco+xSaOzzE44cpyDPG9UwI3TfRks1XDFvbGyThTzAPcN0uQ4a/umFwOWwCjvNDpl870qwRI9arSAw1JyiCPFr0AE2ZF168unZmoaZBFBS6GMeeG/lOyMdgyWkHcBVI6tTMJPK1O4gKofxGNRfAx88poIUESusyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=bGt/iEjc; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="bGt/iEjc"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cace91f112so17549605ad.0
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2026 14:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1785360991; x=1785965791; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eZQ8VR07pXx0Bw0kE02/jttQnE1Ukn2+Gh6NYsBKzlI=;
        b=bGt/iEjczv8UstgvnwKYm+qjRwidQ4ojoCXXt2X9+G2W8W31JplSMyMR+TLM/KmRjJ
         Z7CBoDen2B3CaMCa1IHusGns0SZpeSXXluocFwvHCNKRL6A8akxPudwzcvZR+DIYAUU9
         1lG4P5YebaXISi5m/j6jxK2MaBG2mY0lrnSFY6fybil3PxNYv9tCgQK2uykudgEk1b30
         p74u31S0H96Ry+VC4A+CEkDPN5RLDefDfsO7oGVSn1J34jrsXbsXCuseEvw4LaXKsbFS
         seJgdO3usKU/i0TTQSADESZSo6Q2RVP2hhP4la1zODvYZ2h2sYAB2IyOy7fClGxkizMK
         Mihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785360991; x=1785965791;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eZQ8VR07pXx0Bw0kE02/jttQnE1Ukn2+Gh6NYsBKzlI=;
        b=IOe8yr38/0zl8//NqtgT9xi9Xjdk7NA6vKzqsRkn31hJrS7TqL4ywNOgmd8IDFqgZ2
         HGJLiCnH2bdtu6fCrDpw1/xIVAbrdNwhD9FyIzgoXNWFKK9VwLRoEAG3u/yb8hZ1rIqX
         lx0JXUBXo6nFX9ZPnrpyyhwbjFqdeC/rb/EmGxsAuk2ZIkIJHUDDRnq3dXmXNcT+nfvy
         kUDUdU6Me5Is95Rx33oLz31V9NeLE45l5iS8e5COvkA3J5GH8AC49uqBa2CAGPoTuWCy
         CDyS8gJUe5DzJtLdWfHpvu3pd4Jo3slr36X9B6K7TXyc5Kbt/Qt4gSWQKY4k2W/O012Q
         vpaA==
X-Forwarded-Encrypted: i=1; AHgh+Rrl56KMAE86HhtOhArf0C2AjRy/ci2d/N570yV8iWogBKHbW9k2Ft2Mx7ddla/+AMb7WoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkMRGQjrV2r75m/JSgpO8g/5HPEPPvh3+3BpEdH/5rBpsX5sJ4
	/nyLiZGG2HfMhACX+xWLQtKvcIhqa3WhTKd1nb2XOkaQWdfpVpLpMTgz+vxW+kXMItc=
X-Gm-Gg: AR+sD13dWN3yKNWZVlraFWjzHnboIOyGz1+64PdW2UknovsEb8ePcC9GqeNKONcCe0j
	izFRamJRmQUee2N5EnKC/GctODIatkKOAwToy2XfJHmqPvmqHJRNlfuZyxxBB0f2ppZMnfsraqY
	/LMes5v29JgULuzF03qvY1JrMQvEBZgn+MogvnqXri70e13nzgqwZ3Hf5OrwjrpJpHG+Rh0cFAt
	0TATEQk+2wiE/id3WppU850Vg6xbAthn986t+GVIVbvmXjuEj0gqt5zLEwrVvgcgb5Csj3tGMUK
	v106zLyK2bSjgSPaaJAD91zGLNziDiBHH8TiGdwMkZED1UfSrhK0yJ+DIKaLJ6SxicglIqARiDd
	KWSDELx8jcOc9aH+h8IL9yOcg7c/DddG6+seDOLsrEgrflbmT9MVlQACQSZlU+lAnGtrITWDx7a
	N1EbBH4UYe1y8t58gJTxmROyl1DIVDf0gh1NJmDuVYCSwj
X-Received: by 2002:a17:902:e5c3:b0:2c9:b8b7:5d27 with SMTP id d9443c01a7336-2d035c1c5f7mr398675ad.1.1785360991192;
        Wed, 29 Jul 2026 14:36:31 -0700 (PDT)
Received: from localhost ([2620:10d:c090:600::1:d447])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504dab154sm14771138eec.26.2026.07.29.14.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 14:36:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jul 2026 17:36:28 -0400
Message-Id: <DKBDNFB3WGPZ.GS7M7MY2HNAB@etsalapatis.com>
Cc: "Stanislav Fomichev" <sdf@fomichev.me>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Sechang Lim" <rhkrqnwk98@gmail.com>
Subject: Re: [PATCH bpf] bpf: Reject negative optlen in cgroup getsockopt
 hook
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: "Junseo Lim" <zirajs7@gmail.com>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260726070122.2407344-1-zirajs7@gmail.com>
In-Reply-To: <20260726070122.2407344-1-zirajs7@gmail.com>

On Sun Jul 26, 2026 at 3:01 AM EDT, Junseo Lim wrote:
> A cgroup getsockopt BPF program can shrink ctx->optlen after the
> kernel getsockopt handler has run. The kernel-buffer variant, used by
> TCP_ZEROCOPY_RECEIVE, only rejects values larger than the original
> length.
>
> If BPF writes a negative optlen, that value is accepted and propagated
> back to the TCP getsockopt code. It can then be passed to
> copy_to_sockptr() as a size_t and trigger the hardened usercopy
> bytes > INT_MAX warning.
>
> Reject negative ctx.optlen in __cgroup_bpf_run_filter_getsockopt_kern(),
> matching the lower-bound validation already present in the sockptr-based
> getsockopt hook.
>
> Fixes: 9cacf81f8161 ("bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECEIV=
E")
> Signed-off-by: Junseo Lim <zirajs7@gmail.com>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

It'd be worth resending with a reproducer setting optlen to negative.

> ---
> Reproducer and warning:=20
> https://gist.github.com/ZirAjs/a177ec6d8f2c8ed7d93edca6313a9255
>
> Tested by building and booting the patched kernel. The reproducer=20
> returns -EFAULT and no longer triggers the hardened usercopy warning.
>
>  kernel/bpf/cgroup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 4355ccb78a9c..c04a244fe2e6 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -2235,7 +2235,7 @@ int __cgroup_bpf_run_filter_getsockopt_kern(struct =
sock *sk, int level,
>  	if (ret < 0)
>  		return ret;
> =20
> -	if (ctx.optlen > *optlen)
> +	if (ctx.optlen > *optlen || ctx.optlen < 0)
>  		return -EFAULT;
> =20
>  	/* BPF programs can shrink the buffer, export the modifications.

