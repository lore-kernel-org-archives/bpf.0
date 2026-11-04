Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793828315;
	b=m8ME9RUPyQykO+ugaGjrWMdOYhfgUh+YAZW0oMd9eOIP6CeFATjhznfdgLUhPCwDDucE
	 KCCTBU8zeCgbQUF6EHELq9Xbi1gDM+m4bsACoPeCuSJeWGFvRmsQ/SYKA/AvMt/nZuHdK
	 EfXUbWezB2HqjFDVfjqaX+Cyh9zwo5edNN7hgSrGL9xPkhnEylk2LoBmu1ovQTegxJIjA
	 N+T0OvFBeMmzj2JMLKikKjTKJsqHk5ZGXuEuX/4zdkXTZE0nYJsccJ8TYC1QJfUIhnZre
	 lZ283dClmfaeQzd6+OR5/rrDjWuLW4shf1cXHxrORZk3TbO/z6NNxzHeiSmH5JCpJ3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793828315;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YHCMrhCX9qwCLtIcZFgPvqvF5+LnUpH344kbevzFH48=;
	b=qnnnbykGuAM4/Ln02f7e4x7CBRZlP8/knG77bxahxufyr+1uOYy/h+NbyKkPws/qSvLe
	 VwvMRX2FyeqtIhi4FD1q7kNDviZHWZIMafeLO+KSzGAtOJNsN9p/WkJqjGhyccpSW4AAp
	 U3ru7DB37xNDzp+61Pr9bsInkE9OKt27yA50rpcBQfFnWxH7OtP1hWb9yBVcxoiMWdhzn
	 Th+7oPyiU9erX2B6LsbWKqXqn87SPiS8cVZd4iHxrhJj8QYzhVKw8QNcrORYmdaI6qJmv
	 2g9TX9zCl9yiIK2NWRoQx96RQR+jiHsELHT2a7GjE2sRYlWG7GQdQodhOSGiR/Tpbhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G+J2+nn3;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B3B606D4F0
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 21:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51B3B606D4F0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=G+J2+nn3
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so10967065e9.2
        for <bpf@vger.kernel.org>; Wed, 04 Nov 2026 13:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793828314; x=1794433114; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YHCMrhCX9qwCLtIcZFgPvqvF5+LnUpH344kbevzFH48=;
        b=G+J2+nn3otnZjYTnQ2PhqHmn0skLRlZ9/mwLClS3eJz27Rnluif97LoQGI2ol6R7W5
         slSO3+UbAJEKwnWh8s3xdbdrvUmKxciaq9IT/4lrQjBFiNWunNT0jXaROnrRWMIAUPdw
         7RiK602LnIMtfRhaOG/rCLtybXM/FtJz33gepSSmPhYiD+uIRkgXLoG+z8yhNBEO6xGg
         K+Y0qO03UnqI+/Snm1GWHVpCfEmu4oMYdUlZNPN8OUdAHEP92t9/NIlhzuCZdr1/H/sd
         5XGhJMT/I+kfxbUQc39fh+qR7ad499J1H0lzq+quPHcHyVv+rqTqYhpfTT2d+ilR7XLs
         Gj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793828314; x=1794433114;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YHCMrhCX9qwCLtIcZFgPvqvF5+LnUpH344kbevzFH48=;
        b=BIeb3SSdXIeVlBINCzf7qPS8fgSCiOaTnFAb3Rhmal4MePHEZvdhZNy4i6qDtyFfT/
         kpp2i+t0ncJGJ4/Y2mdzmQd0OBhNYuRDz3pqtRJnQuP+2r7EixrHgM1ODMZWBXC6hOdE
         YYSDxTvsaRlHI6NJKJQybwKhDQ3Kwghzd3cJcTXJ6yDKVp1h73hyM6aL+c4j/XeiOsWz
         2sE3ULABNfUIj6CqgLYOzlBBpF5MFoSG3w2ADzLmkGikKMVJL76PDAh94cUpZzLnre5m
         30bUJ91W9AgFF4pEB2Si6VvROZZPQG6GsAJ1Li+raLWFn4QBSGB72DElTJ+ypSgJNRny
         Fi6g==
X-Forwarded-Encrypted: i=1; AKwUvBxRd+Y6oX6pIDKGUBWrK7SVjQfwvwmt6lZwsNaS4Qg1bRgJ+qm5w1WnON/9szcsF3qe9no=@vger.kernel.org
X-Gm-Message-State: APuU4Z9E+v+CWi6y6ysN+edf1hqctvAxzElmLdLjBM7IJZ2dSnotLkXo
	rYzLIAcSCsZNu6HZ7giBu7pUNyTBgTvzpccsaDSOTSAODITc1rjpxkJZ
X-Gm-Gg: AYBFou0+lX8jaLcfyRGYN74XtECwkXQHy7Z7rNjXds4dZ9dKBkd8eV7wOKzRwJo/0YE
	ir0kRU2N6Uwss45Bmlb3k7f8Sjo+4YDN+ooXBuwpv36PvoLZGhj6y9SwCddD8Gm2Iubxd0AlrCG
	bZSjN3PGrR7I2xYw2NZMl2TPrJOKzpENWDIoxefGnC2Eopr/Q3qwVOCQu9GOeeJMY8y5WR6+a3O
	lOoiDK8aaB4kNpldBsvcvJFBfylgYbCk6+1WUf6CIWjPfeBf3Ut2Z9duorGBigkLrqybK429xWa
	u84go0ft5P1qZC/8fTq4b9tpCYGdq3w1ZTe0kMdGZzXh6sEA0qPmoKqgjvBUz6XeQAvmVEDKNj2
	IALiJc298VDN5lr8abdysUO3xdvVO0InUODHIyX0jfuTqTujXOtyAmHRqqTdJJq0hojbrmWQeEM
	4l2s22L0wu8rbgBgualeqz4usyIlLWrSnxz0IhvxCj+TokIVGHgiljRk/IK+I1T4uERfGUqxjvN
	eHPsTMGQPxIonZWk9lIB98lQnbZZ9sUz8J+6DG3O+ZXKoun1G7zmfdwXOI6WV+9H89Hx6HS9ltD
	K+Xs8wgb3esaoZ8=
X-Received: by 2002:a05:600c:524b:b0:4b2:612d:908c with SMTP id 5b1f17b1804b1-4b2612d90d4mr159560295e9.34.1793828313453;
        Wed, 04 Nov 2026 13:38:33 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56eb4da1esm23736045e9.6.2026.11.04.13.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 13:38:32 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 4 Nov 2026 22:38:31 +0100
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
	linux-mm@kvack.org, andrii@kernel.org, eddyz87@gmail.com,
	memxor@gmail.com, ljs@kernel.org, john.fastabend@gmail.com,
	nierro92@gmail.com, martin.lau@kernel.org, yonghong.song@linux.dev,
	mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCHv2 bpf-next 8/8] selftests/bpf: Test user memory kfunc
 errors
Message-ID: <auul10Zrq0WmmU5K@krava>
References: <20261103075916.100050-9-jolsa@kernel.org>
 <28b71b95a782f28f081233a18a48ab18cfb5483df6ec6980f8168cbecfd93543@mail.kernel.org>
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
In-Reply-To: <28b71b95a782f28f081233a18a48ab18cfb5483df6ec6980f8168cbecfd93543@mail.kernel.org>

On Tue, Nov 03, 2026 at 08:39:48AM +0000, bot+bpf-ci@kernel.org wrote:
> > selftests/bpf: Test user memory kfunc errors
> 
> TL;DR: Test nit only: the user_mem_kprobe() selftest looks redundant with
> user_mem_nonsleepable(), since both have the same body and expected failure
> and load as the same program type. One may be droppable.
> 
> > diff --git a/tools/testing/selftests/bpf/progs/user_mem.c b/tools/testing/selftests/bpf/progs/user_mem.c
> > --- a/tools/testing/selftests/bpf/progs/user_mem.c
> > +++ b/tools/testing/selftests/bpf/progs/user_mem.c
> 
> [ ... ]
> 
> > @@ -80,3 +80,32 @@ int user_mem_test(struct pt_regs *ctx)
> > +SEC("?uprobe//proc/self/exe:user_mem_trigger")
> > +__failure
> > +__msg("program must be sleepable to call sleepable kfunc bpf_user_anon_mmap")
> > +__msg("cannot be used in non-sleepable program")
> > +int user_mem_nonsleepable(struct pt_regs *ctx)
> > +{
> > +	bpf_user_anon_mmap(4096, 1);
> > +	return 0;
> > +}
> > +
> > +SEC("?kprobe")
> > +__failure
> > +__msg("program must be sleepable to call sleepable kfunc bpf_user_anon_mmap")
> > +__msg("cannot be used in non-sleepable program")
> > +int user_mem_kprobe(struct pt_regs *ctx)
> > +{
> > +	bpf_user_anon_mmap(4096, 1);
> > +	return 0;
> > +}
> 
> This isn't a bug, but user_mem_kprobe() has the same body and the same
> __failure and __msg() annotations as user_mem_nonsleepable() above it.
> 
> Since SEC("kprobe") and SEC("uprobe") both load as BPF_PROG_TYPE_KPROBE
> and the attach target is not used at load time, does user_mem_kprobe()
> test anything that user_mem_nonsleepable() does not, or could one of the
> two be dropped?

yep, will drop one

jirka
