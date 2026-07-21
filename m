Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6B13909A9
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658413; cv=none; b=Ri4fxdx5ENRJkI7SKJ5qkJajBWQ59qGdBkrydiXbmVucF33QoohjuzWvoGu5tPSVFuzC6OxBiyQl96UV0PgJjz+6hgTGRUmKoifInWpIUo7EvKJ5lK0fhpDnvnuKyVA4abfn/Li3aGbij29iR9+BmmFP0dME5LIYYz6Fi47KQbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658413; c=relaxed/simple;
	bh=fQHd+uEUR0EMAJfARb//8zwb3tUrURatWZYQ2ejmOhw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ilfxe1yDdCBlW9re/twDsOt3XCnfIbny/37xkRa6eQBZ9mqQceauankk/pmb16Y1ccdq4bsV1L+Fhit4sLs/HnX+PpIgrbQD5KnMj5+mvNJyfF6lUWsD1BwQLjrvsxwDqZyUOZGM5px/xfl+FKhAB/YZ7Op3VnSNIF4TPNaBJQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYSufqs7; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYSufqs7"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so31150645ad.0
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 11:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784658411; x=1785263211; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yBKLH1IS6gIWkO09u0gos9sDYoSJpRQOYrMr7XRmoGU=;
        b=AYSufqs7wVyGJtrdgYV3/eq2vtlik7mYU4eM8LIhsPwQJrAWB+Jjnr4oUwVIfgye9D
         hpEPCjh4lSWYPcFa44+pFzaZkmluB7aOjdYd+akZuBu7yCZuk+S7X1AkRnpvU/cVnX02
         AphCsU2E6Srd3c6cQIr9zvm/HPtzg52e7zaoJLxA+EzOeGUS/hE4A0GIGOwgQtZovsZK
         3d6XrjyeDZkSMuTQeKI0M7l2uM6LdqctL+xs0ilvMm5p1O7kBD64jJAPHmIhSZg21/sj
         yKuFKJrrDWGMDzR56ACN9+Kh+w6Y39zCe3aOfZacgN9SB+y7HjzQuT+C5dOW738OuA4t
         rEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784658411; x=1785263211;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yBKLH1IS6gIWkO09u0gos9sDYoSJpRQOYrMr7XRmoGU=;
        b=PSFmMzAUJHNJYLg5XXXkBSStiogryXhHujfUM8hN09HKXXr95TLCeP08OyK6xMRscp
         SmMoUDZRVEa4LbFZ32GJmZ1FDfZxHMPbpD1fCb4Mn9KlHW7YtW4XaNb2rvPCpayHtpkM
         TJFf5MMJnnu+kHUd689s1FqreU29OhMII/lk1IGSqKQ3Ws9dUSkFA66v8fcGHWgQpfX4
         jRn0b5aZAXnAl7+AP07tb4jCG6ypVxXu6DeBpy3rWYsbHsRjhZedgtRYFhjLhIGtYIwP
         nnjej+S5X0e3sTS0j/aj3yOyHx9Lix2TBlkOwUvA0zjD2cDxBgYQjKw/Scq7klHOodbM
         qU4A==
X-Forwarded-Encrypted: i=1; AHgh+RrzCqphRINRh8g4f2bCRiZVl/1kNhIq8/+uosL3rT6nghpWtFgFljscYdDIFT8QWakI99w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaAJ06rNWYAR/U7vudirOZPbLaxN1sx9eshD69xyzZvs0Sns+K
	wls5lIMF9Bo0nWkq6KdSi6zMycNUwaT9VdilFQtuRiWiRSUCCvY4Ian1
X-Gm-Gg: AR+sD11nqTDbH7E6Sn6l81P99BSweUx0NG+dzsQenI+p7+NzMvdg2A0BjgmtT/Vobew
	iYEvyEgl1uxJhU4vlUN89ugjq5SjPPvxRWmueDLrGeoh1csb7hRSFZqc4WPxtSuTIwjgJeH9NFb
	dlhxnasCZ8myAzpByGIy2WtF37nWotUFtgZs72LWV8XoBE4PgzrajHTR/4A/KLcLamYNBCJg3F1
	TH2imkvs5ftraV87yIrteVpzHREQi3iEQPScVJo5/KqnoFwnkGjsdNbBJtwu21aN/cENoJyPBJF
	EF2yS0S7kjBVP1hG3nQXnsrXiwuIXf7+k8acfLQmbqfSFizQzUjXHXQ7X/AqcruvsmNCbG9SqC2
	UFg65yFqeCzAXB9lipl5E7iNPKQPk7RtGz3DAVG0PeHLSGWSAccvLCByxK4keKJ2UidoyB5r+qW
	9OIokZcqmTnACp2yyHSGhVivd+o/e07vRuXq5BTwTcUCcWZnbMgon0vJYMlZcpNvVvgXM=
X-Received: by 2002:a05:6a20:734f:b0:3c3:9557:3b56 with SMTP id adf61e73a8af0-3c3ad9ec39bmr21830993637.72.1784658411459;
        Tue, 21 Jul 2026 11:26:51 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cda2:e912:7f2e:f787? ([2620:10d:c090:500::7827])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc1a67esm1231506eec.2.2026.07.21.11.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 11:26:50 -0700 (PDT)
Message-ID: <e7312dd40b06f19429f157aa100914c8d5536232.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] bpf: Fix is_tracing_prog_type() to
 cover fentry/fexit/fmod_ret
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Tue, 21 Jul 2026 11:26:49 -0700
In-Reply-To: <20260719113551.1294284-3-memxor@gmail.com>
References: <20260719113551.1294284-1-memxor@gmail.com>
	 <20260719113551.1294284-3-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-07-19 at 13:35 +0200, Kumar Kartikeya Dwivedi wrote:

...

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index bb6e16668d0d..3fe2410c7ce3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

...

> @@ -12317,6 +12323,10 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_call_arg_me
>  				verbose(env, "allocated object must be referenced\n");
>  				return -EINVAL;
>  			}
> +			if (is_tracing_prog_type(env->prog)) {
> +				verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n=
");
> +				return -EINVAL;
> +			}

I think this and the next checks should be moved to
__process_kf_arg_ptr_to_graph_root() or check_reg_allocation_locked().
Could you please elaborate a bit on why is it necessary at all?

>  			ret =3D process_kf_arg_ptr_to_list_head(env, reg, argno, meta);
>  			if (ret < 0)
>  				return ret;
> @@ -12333,6 +12343,10 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_call_arg_me
>  				verbose(env, "allocated object must be referenced\n");
>  				return -EINVAL;
>  			}
> +			if (is_tracing_prog_type(env->prog)) {
> +				verbose(env, "tracing progs cannot use bpf_{list_head,rb_root} yet\n=
");
> +				return -EINVAL;
> +			}
>  			ret =3D process_kf_arg_ptr_to_rbtree_root(env, reg, argno, meta);
>  			if (ret < 0)
>  				return ret;

...
