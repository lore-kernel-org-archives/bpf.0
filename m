Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773476;
	b=tCdYSvX5PGoaTSS7rGohOr5plxCz2mvaJrYpw/QW2ZMSl1EGKyWzOoUA5Yrp2yT5I2n8
	 P+M/DHD7TF4pvAi8lKZm3VZFMAPjKD5B9zXnVUQVJB4Mx2uePDy/iGDBJuUwkwRexrFyZ
	 WBdeLNRS8Vf9peh8AHKgfskQI3uTFOw76l+oJ1rHLpfL+0L24jxOOp24wEik/BztUnfx6
	 VUcGs2CG+NBUVorq0elY+oAPi0Mu8ZrSHDh41HlO3WBislMfumkZMXBOqWhjfIBkcYq5E
	 R/RFTJVTXBCtMUiAWPSl3Ft1KPmjjp3lb6EynstSPgphhN7A7zYrbJl5+W6bKg4U0ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=RBQvwJaEWfCXavrlm0QvxBA4XXZLz+nq7LPKIoTQg38=;
	b=AodknxsO8Pz507cN0Jegq7xrU9OWswILnWu1gTequOW6J6Kc1XKhlF14Y4fk3MkiCDZt
	 csDPSbbR3LQhKgkXeAM9upayRnUhOd/d2+v55kugTsVsKvmYEKW/JtIToO/qJfQF6Zszo
	 MMeuxv8ptnEKbJ99U6xIIHPlU2YJNO7Pp/eqirJvZQcvaw1AgfUngHGX4RckLQddfH6xz
	 M/L/8rdaG7Z9HbgPBno38vm3RoMOccep89hqOeUBdzqKqMMcxS9k+/ciLdpxUwjHKH3vR
	 Mb+ckalrHM4l2tsxZijWm12zZx4TjSzIkPotqtJ5VIehb+MZ7tJcezNveSBEuQGVY+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="rzd/1d+Z";
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC1D606A31B
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 16:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECC1D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rzd/1d+Z
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso601749a91.0
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 09:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792773475; x=1793378275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RBQvwJaEWfCXavrlm0QvxBA4XXZLz+nq7LPKIoTQg38=;
        b=rzd/1d+ZioP7HoHqRg2srtt6f7eVw1vhAtI1hlyfAO4CqpsGqrsjz5D9+nYhAoMR47
         G0fBMlw6eTqLB2EDm0kzGIHMeZliiH+72sU/9iyCt/hlhW/pHnqdpA1SLhh9Oktw/5B5
         o/Ks8HMPhN4I+fwKbHXMvieGMmWjzpqPXeDTnpalJykIbRQIJ+By1D++CFtF9BBL9VOA
         OeH5iUMoLAowr+Am9ridFc05ONQJ4bmzBJQQl+jAlb8d9MVzCJqzrVJDeJBEYrFZT7MH
         5sLBtCdIH9lnWy9S9pOTmQq21pJBrwMH/f6m6AiFjtGOK/O7tdAdF3r2U2ZGj1leLJZY
         u15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792773475; x=1793378275;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RBQvwJaEWfCXavrlm0QvxBA4XXZLz+nq7LPKIoTQg38=;
        b=auHhW0dsE0COIYeslfHz+O8bi1W/yGUZNvICxelBgHx4oLp640KlwgN/t8U1T2902V
         cdOQk0v69huf7vwCd7LCjSveCLwvHLRjD2ToDHCtJiYhUo2KhOxpWqviqGgSjmbYoVmT
         9qIDVcpFyGdJQzf4+P3fcOyYM66qXyE1FClUALFh8MyHecaqqCSI5UmszEuLgE4LNzJf
         K/mB1IMvx4NBkOBzTpVvB5REhSK7pNcDAYOsLGMzbIZGA6Ckls6kl/t7t7Oqdv2kcKt4
         AEOeRb2NAeeX8TkO/VWvfkbj235TysDP5Yowzr1IEOQnveELgPO0ghfWZLTlt6+TJmVE
         xXqA==
X-Forwarded-Encrypted: i=1; AKwUvByIWI37oXqNpgRurSm3nJaQ3JIxAexo1QZt0jHfudno+/0WD+18k9U7c8YfBlyW1YSK4Ds=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0WwSGeeWDe/bgfw2BrlS5/F6KHX6vuwacEjxijFxBfLHW35as
	1hyFHnhf4nBm1p5kXqNJ9JzwIDZZVe9ELIOt33CSqvcn7LZOG7B8s+JK
X-Gm-Gg: AYBFou0a/97xKEVm2C4AwkZvdKeQ4V8kcQxtA4ac2q9A93J0FrO3+YOqzfIuPEa80N6
	eOPrAZeZOIanPVohEArhzTYX9/f/QKK/53m+JmIUfO6ixEqV3V+VsNNDbfIQp3S5s3mLfvhCd7e
	2UrJ3hM+p4R1JCcteetfz1Zazp9hRKKyTUmX/fsItK3e/pZR+fEfa3Hi+5kXawbVfxk2HVspKDy
	UUdMEUgY3FSzFrf9xXktgzqHMFnkZKEA0J9UtRbF6V8YuxlHl4bH+WaXJAtRbTUmL6eB0ae8+5A
	08o9WOOcttBGwbQePutEE6E3eerRNvCXrmXE6sMqRvAIyzHb9zsq9edr68+Zm2LGlKQRQQZTKsQ
	5y0y+8LmNLuw1nXC2UqxMjOnEE3BhmyqEBfma8vCmVIlyK/EJmNzeBe6/k0WOm5w65yoSC+1T/x
	Jtc086OzA3CYX71tdsTfpHusLV3c8oSciuprvKU999GLKPN6cWmSI7yy9iUpaK7Io+lsLijM7Uh
	EpcyxkasUCQagbuLYyArTtnIzaKT8Q1ZzekYLZS9pqm/nGsE/IC01KcYpjG7YjIy6gJMA0BeUfC
	6GolqjJpMUE=
X-Received: by 2002:a17:90b:3f88:b0:3a4:b3ac:904c with SMTP id 98e67ed59e1d1-3adce7ac5fbmr2221017a91.51.1792773475215;
        Fri, 23 Oct 2026 09:37:55 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adde81d746sm734700a91.7.2026.10.23.09.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 09:37:54 -0700 (PDT)
Date: Fri, 23 Oct 2026 18:37:36 +0200
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
	emil@etsalapatis.com, ihor.solodrai@linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Propagate btf_add_type() errors in
 btf_check_all_metas()
Message-ID: <atuNUC7MrIBIsN5X@gmail.com>
References: <20261022064727.747304-1-yangfeng59949@163.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261022064727.747304-1-yangfeng59949@163.com>

On Thu, Oct 22, 2026 at 02:47:27PM +0800, Feng Yang wrote:
> From: Feng Yang <yangfeng@kylinos.cn>
> 
> btf_check_all_metas() ignores the return value of btf_add_type(), so a
> type that could not be registered is silently dropped while the loop
> keeps walking over the type section.
> 
> Both failure modes are reachable:
> 
>   - -E2BIG.  Once the types array reaches its capacity (BTF_MAX_TYPE),
>     every following btf_add_type() fails the same way, so
>     btf_check_all_metas() still returns 0 and the BTF object is created
>     with btf->nr_types capped while hdr->type_len claims more records.
> 
>   - -ENOMEM.  btf->nr_types is not incremented and the array is not
>     grown, so the next type is recorded at the slot of the dropped one
>     and btf->types[] stays off by one with respect to the type ids for
>     all remaining types.  btf_type_by_id() then returns the wrong type
>     for those ids for the whole lifetime of the object, and the last
>     type is silently left unresolved.
> 
> Propagate the error so that the object is rejected instead.
> 
> Fixes: 69b693f0aefa ("bpf: btf: Introduce BPF Type Format (BTF)")
> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>

Reviewed-by: Mahe Tardy <mahe.tardy@gmail.com>

As sashiko pointed out, also makes sense in the context of this other
patch: bpf: Fix out-of-bounds btf->types write for split BTF[^1].

It seems it dates to the original introduction of this codebase with no
good reasons given the two points above listed by Feng.

[^1]: https://lore.kernel.org/bpf/20261023063133.563998-1-yangfeng59949@163.com/

> ---
>  kernel/bpf/btf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index d870bc5e50bc..80b6f96263f1 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -5459,6 +5459,7 @@ static int btf_check_all_metas(struct btf_verifier_env *env)
>  	struct btf *btf = env->btf;
>  	struct btf_header *hdr;
>  	void *cur, *end;
> +	int err;
>  
>  	hdr = &btf->hdr;
>  	cur = btf->nohdr_data + hdr->type_off;
> @@ -5473,7 +5474,10 @@ static int btf_check_all_metas(struct btf_verifier_env *env)
>  		if (meta_size < 0)
>  			return meta_size;
>  
> -		btf_add_type(env, t);
> +		err = btf_add_type(env, t);
> +		if (err)
> +			return err;
> +
>  		cur += meta_size;
>  		env->log_type_id++;
>  	}
> -- 
> 2.25.1
> 
