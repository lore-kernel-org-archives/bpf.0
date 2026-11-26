Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689477;
	b=Sh2Pdhyv2a3ZZVF5NyMzERjzIPbImAE4rq0LDYJy3MRCsN2tOZseSVUJnoeTIyzCu6WT
	 umkxn5tcX9GjN9cVJ53tFzNwDGv5BUqWgAELT/47BrU9hYZQisLM0CFlhHHMBSG3r1VmX
	 j9gyAitOlXHIYJP5k0Nz0fiOYYClvDjcgH59wE7SbWzBT9EC96m4Xy3DBaJqAPeOE772b
	 z0eysRcJBIeVk9uo9KeqWVGAYzyVTSl2azAZRWhpHKfnCUkw6BhboRbh5xCvzCeZnNwlW
	 DEo24L9UWETxKasW/0K3LOIPB0ggfxi0Q2vgKDNZFF4rkmclYlfiO21DN9T055hIjzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689477;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=cLFVvY7PLckhGVm4llGNVecGMr3w0jQfG50iM05w1fY=;
	b=E4lNAUS7Ct4jzBjRIHbtsmvADz0YsjgAzq3WwwPVOAysw8BgJOOn9hSXlwDd9k7kgi1Y
	 jSwt7P64/fmil7SsN1cMMelhfIEfyQrLvftQY6hSfkunrAcGARsv1Z/5uCIqlV3A7fH6f
	 sdZfkZUxKtJuE2PFzOCfbQYMjIWDKjsGXWTNoYRr/cZZRYZ/hXZ8dSMEG7Pl3Rl3aMopX
	 HiF/FE8w28imZamK7PF+TW/IgMzyvZUgs2qY28oc7pKltD2i9nXfHXkqupb1eI+xlTWSq
	 swnK1SosVjorGeUqdyJbcmOSCHr5a5fQEiQrVjsUgC83wE7TjB86Qp25zDhkXvffMFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k6ChLeOP;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D6606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 10:37:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 084D6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k6ChLeOP
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso3114306f8f.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 02:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795689475; x=1796294275; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cLFVvY7PLckhGVm4llGNVecGMr3w0jQfG50iM05w1fY=;
        b=k6ChLeOPK3wuvpaED8jG1megy+Ih4B9oiY9K6u/pQlM851D3ML2TVCzXf+rzpTstT3
         HKvDpCP0S9lctJd8iKoz1nwWwsOduWNVqcRuhGh6CQ2kVJiC09f1SFsbLUin7hGdAFbe
         h5sfWXZbuOy+nzRA2RJ6sMhuNbm0OZOy3ZMLDKNe9e+az8xd6WPqU814Di1Y2XZRSanE
         zLHiBQi/sEY5BrN9Nr5quS3jCVyYRQrQaDzmWBbn13Xq+lLE5deM2UPzCADLUnbQ5xsZ
         J4iRdUMhYcnspekNL74fia+jhP/P9siUXgRdy4Rd7zO5SGrfCcBI77JZYxTRkxX9vIJx
         +OXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795689475; x=1796294275;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cLFVvY7PLckhGVm4llGNVecGMr3w0jQfG50iM05w1fY=;
        b=o+scfVd2wiLIs9gypVYnJXVGd6uargIK9pHqYjs54780y/WQGrjBAQFJ+01PDqf+uu
         K0t4/H3Lf9I0HBBrkPcOUdxJCrPgjcTp4gqFr61sBQi6ersB+chbNFv3MyCIoseiOjbG
         Df7I8ae8lWovw6WGhHyc7YEw1WQAxF1PiJ8pTT0gCCBREXYTstRZi7yNCVzR/yatYIA6
         tAmbHSzWD25irGxOUCmP9lVe97EWG0Y/Q9REN0JvVdQeaffEdd6GB1SdU99jo3uwvxvK
         MF01qcymDFuvsRO2amfU7kpgCDnb0jGAIR5IXensk5ENeWchy8aZ5czY+Gmtje5UHGJq
         4FIg==
X-Forwarded-Encrypted: i=1; AL+hErHJvR7kQfDhxj+vrFjTZDUAxMhZU62VFpFy9vj7dfSQ6kf4uHyGfB0Ylo+7RJT1knWFT8M=@vger.kernel.org
X-Gm-Message-State: APuU4Z9WL79Jzx850/jimn01jFgAQyEphAXi5TP0qJNkbCcp03EvEqti
	obVO6y459dpQkZ+S/ZHjwLI1XSfn79ddK0GnFcHyc++wjqKhADwSlL9w
X-Gm-Gg: AZFdTZeYRwIlB8HEV7YtEplRrmvfo85KnIf1Hgt63TtACprtvA/Hq3o3V5ujSbwUJaI
	X/pKZUvqyGs31qc3K3BoYDG0wuV072b7tSx2wk4fZKZqJYgSom+sLPn6riwh53oVn43aG/09k4H
	s5EHaeDKPAvxiJnsFUg2yrpJeTmexzAoR4M7rNj6xJn7tLofjZA9PGFPD6eCukW3fgpR58FLdrE
	A6bR4bGA/Y5CYsDLA1wPfIrj0NCgaMZUWGRyG3vwp21bwfU/NJHE6x+As1YIf7ZWSyh/Yln/1gy
	4JsqKZTvfzeoI7Hn6rB6QSvYd30+22ikN7yWF+FmpyJ3jmHAcERqjOrmFM9nXUYDVhK+B0kwf18
	5c9FNSV+QrUY0x2/hxDXevGvTCs5cw+HKc1zlaVa7rQHovrx2jCN5fd2Vq9/O1bXpzQsh76sn5Z
	7Rh+jr0IJhUlwDYKvs9JpesNRU3JWGbQbwnAnIwrVfFFi06lEVsJE+VhxVk1ciAapDWFdfpcKsj
	AjigiedhTWKwprrkGQsIy3X5mbmTjfIISVP7cjc8dWUt0vksYAYN9vTNI+E8DO76u/nuOEnX55q
	tHIHkPngpPN0nNPIpdQn0WHUDWUKFPbnW7EBd0KhmT8FoanLRex6ynhx1rs=
X-Received: by 2002:a05:6000:4a0e:b0:48b:db7:86a7 with SMTP id ffacd0b85a97d-4abb7787c05mr38520650f8f.50.1795689475240;
        Thu, 26 Nov 2026 02:37:55 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dd55sm38548389f8f.30.2026.11.26.02.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 02:37:54 -0800 (PST)
Date: Thu, 26 Nov 2026 10:49:31 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, jolsa@kernel.org,
	almagui@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org,
	martin.lau@kernel.org, yonghong.song@linux.dev, mason@kernel.org,
	ihor.solodrai@linux.dev
Subject: Re: [PATCH v1 bpf-next 1/5] resolve_btfids: Do not tag functions
 which work on BPF objects
Message-ID: <awgOu2UooYkkRoUN@mail.gmail.com>
References: <20261125212849.868523-2-a.s.protopopov@gmail.com>
 <60e66815fcf2117a391927fc894fca80573a652ac302d35b2d680ee6f401dfae@mail.kernel.org>
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
In-Reply-To: <60e66815fcf2117a391927fc894fca80573a652ac302d35b2d680ee6f401dfae@mail.kernel.org>

On 26/11/25 10:14PM, bot+bpf-ci@kernel.org wrote:
> > resolve_btfids: Do not tag functions which work on BPF objects
> 
> TL;DR: Test issue: skipping bpf_* parameter types likely leaves vmlinux
> bpf_dummy_reg() untagged, so the tag_of_vmlinux selftest may no longer test
> anything and its comment is stale.
> 
> > diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
> > --- a/tools/bpf/resolve_btfids/fmodret.c
> > +++ b/tools/bpf/resolve_btfids/fmodret.c
> 
> [ ... ]
> 
> > @@ -220,6 +251,9 @@ int fmodret_tag(Elf *elf, struct btf *btf, int verbose)
> >  		size = int_return_size(btf, t);
> >  		if ((size != 4 && size != 8) || !fits_trampoline(btf, t))
> >  			continue;
> > +		/* Skip functions which take or return BPF objects */
> > +		if (has_bpf_types(btf, t))
> > +			continue;
> >  		/* Init code is gone before a program can attach */
> >  		name = btf__name_by_offset(btf, t->name_off);
> >  		func = image_func(&img, name);
> 
> This isn't a bug, but does this change leave the tag_of_vmlinux subtest
> without anything to test?
> 
> In tools/testing/selftests/bpf/progs/fmodret_retval.c:
> 
>     /*
>      * vmlinux has a bpf_dummy_reg() of the same type, so the two share the
>      * FUNC of vmlinux. That one returns an error and has a tag. This one
>      * returns only 0.
>      */
>     SEC("fmod_ret/bpf_testmod:bpf_dummy_reg")
>     __failure __msg("bpf_dummy_reg() is not modifiable")
>     int BPF_PROG(tag_of_vmlinux, void *kdata, struct bpf_link *link, int ret)
> 
> The vmlinux function is:
> 
>     static int bpf_dummy_reg(void *kdata, struct bpf_link *link)
>     {
>             return -EOPNOTSUPP;
>     }
> 
> Its second parameter is a pointer to struct bpf_link, so is_bpf_type()
> follows the pointer, matches the "bpf_" prefix, and has_bpf_types() returns
> true.  fmodret_tag() then no longer emits "bpf_fmodret_retval:-95" for the
> vmlinux bpf_dummy_reg().
> 
> The subtest exists to show that the verifier does not use the vmlinux tag
> for the module function.  With no vmlinux tag left, the program is rejected
> with "bpf_dummy_reg() is not modifiable" regardless of which BTF the lookup
> searches, so a later change that made btf_find_func_tag_value() also search
> base BTF would leave this test passing.  The comment "That one returns an
> error and has a tag" is also no longer true.
> 
> None of the later patches in the series touch progs/fmodret_retval.c, and
> prog_tests/fmodret_untagged.c does not cover this case.
> 
> Would a pair of same-named vmlinux and module functions with the same
> prototype, where the vmlinux one is still tagged, restore the coverage?
> Otherwise should the subtest and its comment be updated or removed?

Thanks robot. I will change the selftest to use another function.

> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45706808075

