Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0140624DCF9
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 17:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781977698; cv=none; b=eUP2dD/hQVfjSMz8lHfwdZirjG5h75zWTQZRMowWH5Kel2obZlN2NDcl+56Pvb6k7oErMs+A+u/rdabTIKgMUSL3UCKB5LPEQzREZ5uWkutH6gWbcCDA9GG9q23b/3/K9DXEhdSE3085HxO1hu/t6WRxLmv2uFyoanedTVuLzjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781977698; c=relaxed/simple;
	bh=7/oFG6inbFJ1U+fOeljq4apG//LM5FHDCawn0uBqltw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TKJUVnbpjN3oLqDB9UgT7vha9BITJxYu7I3vfsJtWj/wYaodhbTiQbgcJFpBTY+Ba6fTsDTQ9noL7jWjIgz//Lz3+ClulJEJObC84NglbSDfe516qoM/nIBE9gCv+azuYVoiLFdt53rf5Vxsb/mVdXU8hdt90kG+nAN1RzRWE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bz9n9NJu; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bz9n9NJu"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4474073fa81so359155fac.3
        for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 10:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781977696; x=1782582496; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cLs5VtWni2+vY/ypzHPByb/qpr24QSiCWnes7mK8Z8=;
        b=Bz9n9NJuwCbyU2R6uR7LfzuMmNYsIE6V+tC/fp44FF7SOkPfy3m2P6jm5bTPDX90v5
         RK+Hig3ilxqQAjiUootHFkUa4bwEVlbddogAq2mwbCrlGnAe2flFd8VgfLOhK08akLqk
         TKteom5BpzJcpesJ/idOv3SpoG95BwyIZugimPwbw07gz/F4FWxaYdAjgcSWjXkkoGUd
         x+9bpbB2gq3d8bcmwlxDjerDMWkgkptKjYL5z6+7q0yxs2SmaEStIPjPK+X9JV6yk9hV
         riiqCk+ziLzi6/93l/E26Lr7LnB31NM//baKmJPe7ObBhLf5YMCiaZ+YPQlpMJSk2PgI
         3pYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781977696; x=1782582496;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+cLs5VtWni2+vY/ypzHPByb/qpr24QSiCWnes7mK8Z8=;
        b=BHbMKDhUpVzvjP62Dgb0AuzK5tQqfDPaHA1Eu07oT3ooai2Crp/ZG38RPpMa8LhiHw
         w29uyoqudd0ZoZRMJ5s9cB+ytNDvqljl/NDQNGnLYNwi0sjjBw4HJ8MhrVYq++invkiV
         X7SV7UkyOxrCjKoojrqYqQ4/R4wMsoeMgZfSzjhWrHi24++QHzNwIot5PmHfh3uJQr6D
         FUoBZ/oaKSJBIkJqN79l7IHSJYG/v7NZhdi9azlcRM2+F72GxMR0kAWmTwWdATu0K1Hy
         snjBFuUtviUsaQ/H8I8E1NzZxKJAlPrwYNGKmrHsaqF0hs+lwdD0jv1WGHmrahv/Dl2L
         Nu3g==
X-Forwarded-Encrypted: i=1; AFNElJ+Xh8PXSXDCowyMMAWL4SI+Dtlvlyph5/LiKm9sSLcNkeUu5qjxkQzKL9Li/iQfOfu6i3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy28kP5+V1CG6miCGaEjRJlqn36JXa2JfOdKNeTF/Pxn7t+Tw4f
	oCs8Mbi3nS0ZcsWIg4cIJEtdKOW46XylouGcaUphMoYhp9m2OHdqPQyc
X-Gm-Gg: AfdE7cnm6/4vnSsq5s/m1jGgP2+d0lzI9TNTbkPODIZn3HwkUpWFgoD7qC//XM/Acuj
	uzl7wduEw8qk9pa7S5HopJ/SW0ivhZIecv6tJXACoM0ipj5gjeEMs2K31+cE68meJhtARgTiFXx
	1MQ/URAd2CsoNAKIrPrjWU9wL5R+gnESmBpM5yUjoEeERiLWp1bgsT7TfRKtggKvKg4W3AWIJGI
	t6toR2r9TpdmyUlBGvlCpNJ3FtzqWYOrSBT9yfyV6ujzR70n/zpBGNZABgo9kf/wprTTPfvMTqy
	mUBKdseOuzLyWgq1QswBKhR4d68QE1fL4D504Ls35x6tIcBi314aakKMhcRYWH7gZkQyBwkGRRt
	I9N3LLtrMT2MWGh2qXCkSNSBBbXpxish+B4Fkke5anjZLMOJVZGsJmnlfoZVIBzWQHdM8phQfOm
	1bxMOcniMbvxygF+QLDcEOmQv4uJ2UKU/t7zqcWfMdAU/RN9Z2itEtjzEYnaJIHrCZ9dsc1uZV3
	wBnE00=
X-Received: by 2002:a05:6870:d306:b0:43c:4fbc:d08c with SMTP id 586e51a60fabf-44707f03eebmr6820925fac.24.1781977695917;
        Sat, 20 Jun 2026 10:48:15 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:48::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472efb37fesm2451299fac.10.2026.06.20.10.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2026 10:48:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 20 Jun 2026 10:48:14 -0700
Message-Id: <DJE2DFJT0246.6W0FDJ3LH8CP@gmail.com>
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 "Viktor Malik" <vmalik@redhat.com>, "Leon Hwang" <leon.hwang@linux.dev>,
 "Dave Marchevsky" <davemarchevsky@fb.com>, <bpf@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Reject offset refcount acquire
 arguments
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc
References: <cover.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
 <cover.1781963957.git.chenyy23@mails.tsinghua.edu.cn>
 <faad6ed6ab46008e1b0ca5c490a706dbebb80ea8.1781963957.git.chenyy23@mails.tsinghua.edu.cn>
In-Reply-To: <faad6ed6ab46008e1b0ca5c490a706dbebb80ea8.1781963957.git.chenyy23@mails.tsinghua.edu.cn>

On Sat Jun 20, 2026 at 8:04 AM PDT, Yiyang Chen wrote:
> bpf_refcount_acquire() increments the refcount at the caller-supplied
> pointer plus the refcount field offset, then returns the caller-supplied
> pointer unchanged.
>
> The verifier records the return value as a base pointer to the refcounted
> object.
>
> bpf_list_pop_front() and bpf_rbtree_remove() can return embedded
> graph-node pointers as PTR_TO_BTF_ID | MEM_ALLOC with a fixed offset equa=
l
> to the node field offset. Passing such a pointer directly to
> bpf_refcount_acquire() currently passes the refcounted-kptr type check.
>
> That makes the runtime operation start from base + node_off while the
> verifier models the returned pointer as the object base.
>
> Require refcount-acquire arguments to have zero fixed offset by carrying
> the requirement through check_func_arg_reg_off() to __check_ptr_off_reg()=
.
> Programs can still acquire a refcount from a graph-node-derived pointer
> after normalizing it with container_of().
>
> Fixes: 7c50b1cb76aca ("bpf: Add bpf_refcount_acquire kfunc")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
>  include/linux/bpf.h   |  3 +++
>  kernel/bpf/verifier.c | 18 +++++++++++-------
>  2 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f6528..b9b7d19cb 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -859,6 +859,9 @@ enum bpf_type_flag {
>  	/* DYNPTR points to file */
>  	DYNPTR_TYPE_FILE	=3D BIT(20 + BPF_BASE_TYPE_BITS),
> =20
> +	/* PTR argument cannot have a fixed offset. */
> +	PTR_ZERO_OFF		=3D BIT(21 + BPF_BASE_TYPE_BITS),

No. We're not going to burn the bit.

pw-bot: cr
