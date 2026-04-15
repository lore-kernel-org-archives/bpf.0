Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDB23CE4AF
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241420; cv=none; b=o3GNAdK0PRe7T6RcMScLfOYH/2T7w8M7KX5xA1eLVeojC7elOObKgKdvX3mv691fr/HaDUFWIxc0wCBmXejB21SiywFVcmD+ZPOrIM4iESODMshVtF6aJAQ6pv6ikzYHESY3rji6ppqYCd5yYK8Aopj7IJ7vcFDKB7xW/gagzaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241420; c=relaxed/simple;
	bh=PHbelQtjpt7RIOSYwYNo0wlI+8//Q6hsPIBWJoezvZA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3+0XzS3ljpxfc4Ad7JZjCCeKUYtq4FYfRMMSrwfRTKXY6DO5Md+6WtWn5A/vBhr7H/+YW4kzEoRQAL7ev3GepDQ89JesEWrwdAoJD/Re+KHNk/0fef4JxDEPY52voAxDaGagyWTOL/MxpyrZkx9lbtGwsTwXvu46Aqoy6qALds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MzHBmVSB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzHBmVSB"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so44946965e9.1
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 01:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776241417; x=1776846217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Jd24Fd4zRjvKri3Tyf11h9vJHAqmEDSN1hLN3ri3ss=;
        b=MzHBmVSBmluqDflomOycuN0iahpySNwv1ejBBm1JNt5x+jnl67CZBj7W1WKVF+9vQF
         P3T7d3nFog2W9Dnnzhsg5/bP+EaOvgQoY81dQI3UrD0i6uI6TyYfI580tRtbuTdAfSTM
         8VTqYEpBVVLbq2q8JWKgmCZKZ2/AD/P0DCxfDT5kj0Xrmhikuei4z86/7NJRoOR2fLpl
         dRukLqoapXH5gMWjJIeFb+iMfA5ySqQBCw3Ah4CNCZvkBJvvK5g9tt6prktb3zgrfF7e
         ep4mlmYUhGvRYlCqDtbEa9gJrnk+G/xxOf6nM/aVIo/3KEkHAMy/xFrGWBKz48WRED6D
         In9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776241417; x=1776846217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Jd24Fd4zRjvKri3Tyf11h9vJHAqmEDSN1hLN3ri3ss=;
        b=js6Av3UGf1DPVAzeEn2c8c8lmXR8oqy1rSF7J2GC3Dzq2boDSvcxZL8yd/v9kEihDe
         EtYUf4i5koZ3i8QMP6HrOwJGqzyy9nNIRtCPybwYuUMDhRzrzJwbapMetv30tXuWSV1n
         1SPx3jzPRCpy6GXhc2pwPSLHqoxRgmSVjBxcq/0exRqeb8d3yB9iusU3ZB44Z9pn2hl8
         LkDCGihxk0b9qcvPVhNXOl1fFjC7H4GMUIkkuuMUNLHH9pn8eOKbF68CeGuvEcBf6zn+
         SfkokwVhKXQYPGJkZMnaNqV4o1R+2A+clF8qUvFjPVm1asWs0U/9eQH4nmmpRIJLOwxC
         5o3g==
X-Forwarded-Encrypted: i=1; AFNElJ9KouSmh/Tl4Lo1yMTgUnc/HgFsylWdoTdw2D6yyIC0aYPl7zPEAV7LejvI8KG2XHbPREk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz03HCCCcsCCN8Kq6yUz2MhihxWNuVZLOjhjwWxwSb4DnHI9aXY
	ASnf/1SNnbcuhAhGoeVf/VG0O+3xfW5tdzvht9KE1b/gCWyqdFKQ9oLg
X-Gm-Gg: AeBDietlh0bXkn3cQKKbnVkqYLutGQfe/yuWLHF1wQJY80bFqhbzPRn5yxGVZKhi4Ab
	FmI2PfDxb9J8Vn33MIx00xH07vFBVbym4jKJg0lDaNMezSnEpakpUQ/EYhMdyEfgKAywNbTXpHv
	jrZfvFFUBNphrpVvvUGjx6pX05rVtLjZhqhzrg0FxjSk+K7SNAt2tOO5qtNrsLbpKUFkd46S93a
	CkhOQGcJ19j7k5aqVs26V6UJVkBN9UabZuMFXhKIYkxYWz+dtKnooOcH/Hs5PQMyRTirzqbGokY
	V9fzI/brZQ70eI6WZRz/rI3OXOb01n70INWuYmPOivPE25HLute1uBNai3xNR7t9mceJaINgwm/
	qL3efX0A8M4dK7fnFt+v11Gc1VV1rs8BlrttOkgnI/Blk8+WkRzkbQk5Wugh/SnFM1r14nVSJRO
	oVLPnWWPA=
X-Received: by 2002:a05:600c:45c6:b0:488:a797:f0ac with SMTP id 5b1f17b1804b1-488d6ac2226mr245021055e9.28.1776241417203;
        Wed, 15 Apr 2026 01:23:37 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f0948731sm15803755e9.5.2026.04.15.01.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 01:23:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 15 Apr 2026 10:23:34 +0200
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	bpf@vger.kernel.org, kafai@fb.com, eddyz87@gmail.com,
	songliubraving@fb.com, yhs@fb.com, martin.lau@kernel.org,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf 2/2] libbpf: Prevent double close of btf objects
Message-ID: <ad9LBouzrr8vaUJa@krava>
References: <20260414194804.1428676-2-jolsa@kernel.org>
 <3980e25bb714eb481b5c90ff23d5ce1beb39f94267394f8459dab233b668ad54@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3980e25bb714eb481b5c90ff23d5ce1beb39f94267394f8459dab233b668ad54@mail.kernel.org>

On Tue, Apr 14, 2026 at 08:29:01PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index b60ac8094a9e..33e7a09915dd 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -5825,7 +5825,7 @@ static int load_module_btfs(struct bpf_object *obj)
> >  		if (err)
> >  			goto err_out;
> >
> > -		mod_btf = &obj->btf_modules[obj->btf_module_cnt++];
> > +		mod_btf = &obj->btf_modules[obj->btf_module_cnt];
> 
> [ ... ]
> 
> > @@ -5835,6 +5835,7 @@ static int load_module_btfs(struct bpf_object *obj)
> >  			err = -ENOMEM;
> >  			goto err_out;
> >  		}
> > +		obj->btf_module_cnt++;
> >  		continue;
> 
> The fix looks correct.  Would it make sense to add a Fixes: tag?
> The double close was introduced when fd tracking and the err_out
> error path with close(fd) were added to load_module_btfs():
> 
> Fixes: 91abb4a6d79d ("libbpf: Support attachment of BPF tracing programs to kernel modules")

right, will add

jirka
