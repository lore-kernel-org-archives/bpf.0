Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8A416F84A
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712330393; cv=none; b=tBBak3B8r29rNYy19SzoJ6lL/24OLd6jITMurlyIYtWi68Y6KqJEGTMjz2hMoCw5NAYKV3zQt28jFfYRiumr0Ax4xvD+z8J08tsaLNVGHkD6+olPBecbeHKRFB0PgEbCAcxfzRWn/A/VM8UbQMml7R07K2scJYGOsXlSx8sUQ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712330393; c=relaxed/simple;
	bh=7ExM+nOWjFjEqWU/LaZ3c7XsijGS2VP3Sh7LUGhYVeI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sQgQazIsbF2EfAqu+uM7x6eBrPQh2QDFK7qx2lQHaNlohAS3suAKGL+bO1OpEor6sYJA897V0WzdrmqgzKCX6EORjk32VvcGi4GxpruBkz3ykZthGB2hxtOQw2/OcBOALocmZ+I/aWadM7pJGcxXLeiLNDmjN+urKbnFAZuaKww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqAtr19a; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqAtr19a"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso1349808b3a.2
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 08:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712330392; x=1712935192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWDqqBcEDXK40Q4FcvTHHo9rfB4ZEMKtPpPeEV33bcM=;
        b=nqAtr19aOIWu/RB5VyIMs+pnP/A3vJFr6LGLDtjN7tb4iK48gPmcL8B8zERoP/uq/6
         XmMwnUxyDl6EhxsveIyN2kfmncOYZKU3F1dglI5JJdhZ+MQyuSyf5IhimuDELlRxK9rL
         dSUo5JCi+7I2g24SVFRKW5Kh2A2fm+2d5zRpr21koE1aIk9Q2OTRiWBZuBY6QO1SdHN/
         kmtv04c7r4ZwKt1CRSHKLB6GV+s5Lm3C+M3mjEXoAmrwx0M76J4yM3TkORwFAZrAIVJ+
         cbVBokqzxspMJQVsf0/QVnUIOAOmAUs/8AduhxqCCN7A3Fao8a5mtUADklQPr0yOdtET
         edzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712330392; x=1712935192;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lWDqqBcEDXK40Q4FcvTHHo9rfB4ZEMKtPpPeEV33bcM=;
        b=Law9johFhtAjzdPg5oy8NdKvvBGcTHmJF1eXeZAFERIJwb8oiQ/61EQ07nyIBg9dlN
         Fs5M3SW0K1Ox5ajTz4XndJ8qSb6PKwX6FEXOxbH+dX1hg3ON1P6z8XDYNiqUU21bSJch
         X9yTHogH8pCaU5yeG7v3gv2ENgglcXq6K+f/Pl1T2HZrNgXAKwMLEZ0wDKL9x5ta7nEz
         4/4ExotkTIVHndi4O722NshGVIV6mOyQD4mkl8qr6ZZiSm2o6LEJs6B10Vkg+DyCLOFT
         f7qCUHHIO4at3XX0KqLy6G9uYmmMEXgMsdLLLKfCyupoD4AI3z7Uq2y7mPRId3hN5x1t
         8FUg==
X-Forwarded-Encrypted: i=1; AJvYcCUqg9qeL5RZgbz2EWuCzZkjKpb2QhKrC3jZ3g4Sy3ltz3BxEKEBWl5RNp8IewSNiRBimGEoYr2M6veFkkjOGaGbAkAL
X-Gm-Message-State: AOJu0Ywo3GBWqPk9dwaI3dAFXtNAktD3qgeocQKjogBWdUl8LD3ANeHQ
	HvYyV4wF6APSLwsAF9OxyNU4eTB8Kp+ICAIlCaX8VNtw4nZELMbbsqAM+9Pj
X-Google-Smtp-Source: AGHT+IGsU1lroEUkLVNKTRj4kGu4PWws1HBvfMILqfs82V2AECqq5m+wUbyrbNw8fcKTTQWx+PoFxg==
X-Received: by 2002:a05:6a00:cc8:b0:6ec:ec8f:d588 with SMTP id b8-20020a056a000cc800b006ecec8fd588mr2054683pfv.16.1712330390867;
        Fri, 05 Apr 2024 08:19:50 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id i26-20020aa787da000000b006ecbcbd2293sm1679827pfo.173.2024.04.05.08.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 08:19:50 -0700 (PDT)
Date: Fri, 05 Apr 2024 08:19:49 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, 
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 kernel-team@fb.com, 
 Martin KaFai Lau <martin.lau@kernel.org>
Message-ID: <66101695d69a7_5803020833@john.notmuch>
In-Reply-To: <20240404025310.2211688-1-yonghong.song@linux.dev>
References: <20240404025305.2210999-1-yonghong.song@linux.dev>
 <20240404025310.2211688-1-yonghong.song@linux.dev>
Subject: RE: [PATCH bpf-next v4 1/5] bpf: Add bpf_link support for sk_msg and
 sk_skb progs
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yonghong Song wrote:
> Add bpf_link support for sk_msg and sk_skb programs. We have an
> internal request to support bpf_link for sk_msg programs so user
> space can have a uniform handling with bpf_link based libbpf
> APIs. Using bpf_link based libbpf API also has a benefit which
> makes system robust by decoupling prog life cycle and
> attachment life cycle.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  include/linux/bpf.h            |   6 +
>  include/linux/skmsg.h          |   4 +
>  include/uapi/linux/bpf.h       |   5 +
>  kernel/bpf/syscall.c           |   4 +
>  net/core/sock_map.c            | 268 ++++++++++++++++++++++++++++++++-
>  tools/include/uapi/linux/bpf.h |   5 +
>  6 files changed, 284 insertions(+), 8 deletions(-)
> 

LGTM one question below.

> +/* Handle the following two cases:
> + * case 1: link != NULL, prog != NULL, old != NULL
> + * case 2: link != NULL, prog != NULL, old == NULL
> + */
> +static int sock_map_link_update_prog(struct bpf_link *link,
> +				     struct bpf_prog *prog,
> +				     struct bpf_prog *old)
> +{
> +	const struct sockmap_link *sockmap_link = container_of(link, struct sockmap_link, link);
> +	struct bpf_prog **pprog;
> +	struct bpf_link **plink;
> +	int ret = 0;
> +
> +	mutex_lock(&sockmap_mutex);
> +
> +	/* If old prog is not NULL, ensure old prog is the same as link->prog. */
> +	if (old && link->prog != old) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	/* Ensure link->prog has the same type/attach_type as the new prog. */
> +	if (link->prog->type != prog->type ||
> +	    link->prog->expected_attach_type != prog->expected_attach_type) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = sock_map_prog_lookup(sockmap_link->map, &pprog,
> +				   sockmap_link->attach_type);
> +	if (ret)
> +		goto out;
> +
> +	/* Ensure the same link between the one in map and the passed-in. */
> +	ret = sock_map_link_lookup(sockmap_link->map, &plink, link, false,
> +				   sockmap_link->attach_type);
> +	if (ret)
> +		goto out;
> +
> +	if (old) {
> +		ret = psock_replace_prog(pprog, prog, old);
> +		goto out;
> +	}
> +
> +	psock_set_prog(pprog, prog);
> +
> +out:
> +	if (!ret) {
> +		bpf_prog_inc(prog);
> +		old = xchg(&link->prog, prog);
> +		bpf_prog_put(old);

Need to check old? I don't think we can clal bpf_prog_put on null?

  if (old)
     bpf_prog_put(old)

> +	}
> +	mutex_unlock(&sockmap_mutex);
> +	return ret;
> +}
> +
