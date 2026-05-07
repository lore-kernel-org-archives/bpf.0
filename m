Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA8E3A9605
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156468; cv=pass; b=IQXQbkD9R9dFo2UlN1MvAGWoMTBwwW/avtwMj0Jp3C6c7DLLJl8Bt6aS8Pjcaf4cmBorvYVrqBBF14x64j9gd1GKziDyffHh7kZIY7LqNdoCb64SQM7hqbM+4uWnCw2F71LiOZ8oN4KSoF3mjqtX9o+DEfVfYV3eblwuOZO1W3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156468; c=relaxed/simple;
	bh=uLcjLVv+qWPSR5ICTOjPYBPL7zWto8pcAWObjXNGHpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kajCl39tO+8wkMybN8EA/LGNfDWenkmu8gH6tKjOa/FJc9E88E7Ff2eC9fEn1qdyiNXsHaP4wn/QqlsyEMLr/alqe428WtmTTpFlffzYtQxa50dHLNO/bg7bXtlnKClJVMxjcWxjQ3ndzHTYA29PvOMQPHxNwYO90GrW5rB60cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWZxTSN+; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWZxTSN+"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a535e7c00so8591847b3.3
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 05:21:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778156464; cv=none;
        d=google.com; s=arc-20240605;
        b=AJC5aB487QNxP6GTBvzSbzrFGDHw07SLcSikZNzTblWEzz0FmB1mPIRF6ECpIaOCE7
         incE3FYbcqQcSkdQQ2m7eYKdmxH1yKdiAkz4urHPGVxR+SghhKjc+RFB5QvR6+3us1or
         Nt72esdD91OE4MjXuPNNjGD9OpqHlPkdDrJAykILoHR0V/Nj6WA44ujjmmmk+CYDv/ZZ
         NJopnUYZpk1F17sipYuGcy/GlfiaLDuJW0jBGIED+pQDzTUwkbCxv+aSDxJZdV5yiBss
         JvYCSTxiASK00TmN4LkqRjN9mgcPFld3kQhJ+nNso7neGJHMZfqOqLDscX/3W3yj+Yrw
         RKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J8j96orVQ/ckOv/5hosOw0K8Ur7DOqe9Q4uzoByj5jw=;
        fh=SS7tT0KC3jLZdfo/Ptau2hbovOS8lxj95BG5rgPZ6kI=;
        b=Lafi26yawiNJE8MicgcHcZt774yJxvDYHi2PiSLtjDD7+7wrc2hMJmhwLHgf/u4/hg
         rZ9ja6gxXuLJLyXm30K4LXmfp9YeT5za8uxf18KcmLtCkbvD/nEY20noV8VX/dJevVxA
         PmjhFLeTqJ8Bin8WL4Xf2iYU03No9bK7MOmGVJnq2jr9ChjAcxD/BhHW4kKtMBOPwxbn
         SxWAbsZMZ/NJgkg3jT/57jr/NyoqRvg4HRcDdZlsfu0ns4HRrAFR4Po9MNZqm67lumqT
         /PxSv8cXxV4pXWHYTN5cxyw9/Fz4Y4zsn0+tNQMfbAClbn6Yelli/GYjdGnpXxId2J19
         OPvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778156464; x=1778761264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J8j96orVQ/ckOv/5hosOw0K8Ur7DOqe9Q4uzoByj5jw=;
        b=NWZxTSN+bxSyw1hGZwXru1FYRvpJVa86plY4BhMZlT7AhJmK1gzZVa9HLn5Zgw0ihE
         vqRr32MhJJKaAPiYEAYWUP84Yudpbd9EEs8UQ9Hyd1f0PWYeQOrJOIcSM3ODAS775xPm
         94d/05/jIEbGN3Ed5cxtunT/8WZfaRW8PTXhCtC+sJdo/NYhPrxCDpk+P10p9ITrEY88
         FK5rr0jJDhFNiktNiFxOyNdOwSPP5/LCCNs+2RE3F+QLLq1V71P/o9Pk+XCy9dUkCG6u
         Kx1516bElSqXL3GVbs97+RuERNYG1HvDTx31lZV5RVIlSDSP4abr9ZoBaRzVdc1dNxyN
         5bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778156464; x=1778761264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J8j96orVQ/ckOv/5hosOw0K8Ur7DOqe9Q4uzoByj5jw=;
        b=VY4adjgRF2jy5L/lwFwAVXAH1ErkKv4kyU25Oz/jSOtoelSDCm0ks+/9JY2jzQtj98
         xvwVd8TxgH/fdYUHIlwrVltwqYVNpNKH7kexi57IXuHsgmJKB4s2xNxznSx19fmYwXRU
         FJtsrLDZLCCGeqqGO6dPdgxu75ZEZv4VsPBjKKC7wBbeGSQhjCPLGR2gfEQ3k4wpKLT1
         mVPvyKff81lWe1ml5I1qwSkAOi5Algvu0roVz/8oWdx+wWAKuDblCTHsT+PDTTAA3ubO
         Lt7bWPiWXpi7YqzGkrjKtdUnmHrgmVumdFcf3yCsFFU6rnbeVDGntlFgaIcA8VBFyJtE
         /L/g==
X-Gm-Message-State: AOJu0Yzf7t0l9pm6rEm92P7oqCmj8w2yxvbsLOnprhP5yUzaotJ1wdq2
	KAvhF5P/AW0mT2MMHMhvaMrB3XKFhpEtg1FltrrqT7YlTwh120uu9w9I55UuLMWyCqzmkZ1qQay
	HCfCUtmYA0kxj7SnyHjdqN7jSY/6GD78=
X-Gm-Gg: Acq92OHzHeTb3xtggs1ygYLhWQlL+vC8v0vcH7DyAaMM8dv8F1abXUo0ttZ9FOplENJ
	nHS6TiknEbzCmsfXzrFtbdYnkkZ+BOL55iUpw8d1Y3vD7/X4Rr2qLmlQhSngSouGI5jjA3yK6tg
	bEYf6czkQZ1N/H3I/yQR1AEKu1ZP8yZ2y6663SfJaNMJKe+nueYNEANRUiqBeuev/HUv1HmmVm0
	yd+i2Jqe/cao0rc8bwnepAvCkWpxqRLvG2C90eW3oqMl91UJhIa/9BtBfIKFptYoiipM4o6WnYf
	c2o8cyPFVdh/jIS7VDEZ7GO7IOGr3A==
X-Received: by 2002:a05:690c:c511:b0:7ba:f784:57a2 with SMTP id
 00721157ae682-7bdf5e91f70mr83830267b3.33.1778156464224; Thu, 07 May 2026
 05:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506142709.2298255-6-ameryhung@gmail.com> <755de35ed30756cc0f8c3f1dae3cf6d6b82be6f066353b8421d38f9605f64ff1@mail.kernel.org>
In-Reply-To: <755de35ed30756cc0f8c3f1dae3cf6d6b82be6f066353b8421d38f9605f64ff1@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 7 May 2026 14:20:52 +0200
X-Gm-Features: AVHnY4Kh8Z5M2NprGbWaJKaOziopAMmlDagS0Mw0TVgN2MNVvJLW50ZAkE6GRm0
Message-ID: <CAMB2axOoARisR8EuFng_XSE5Nx74ZagFuQU71PdF-66rMtUwuQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 05/12] bpf: Refactor object relationship
 tracking and fix dynptr UAF bug
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, kernel-team@meta.com, 
	ast@kernel.org, yonghong.song@linux.dev, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 4:27=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.=
h
> > index f330e9cf297e..51d5f5dd6e5b 100644
> > --- a/include/linux/bpf_verifier.h
> > +++ b/include/linux/bpf_verifier.h
>
> [ ... ]
>
> > @@ -1381,6 +1394,7 @@ struct bpf_dynptr_desc {
> >       enum bpf_dynptr_type type;
> >       u32 id;
> >       u32 ref_obj_id;
> > +     u32 parent_id;
> >  };
>
> Eduard Zingerman raised a suggestion in v3 about adding documentation
> comments to struct bpf_dynptr_desc. The structure still lacks comments
> explaining when the id, ref_obj_id, and parent_id fields are populated.
> Would it help readers to document when these fields are set?
>
> >
> >  struct bpf_kfunc_call_arg_meta {
> > @@ -1392,6 +1406,7 @@ struct bpf_kfunc_call_arg_meta {
> >       const char *func_name;
> >       /* Out parameters */
> >       u32 ref_obj_id;
> > +     u32 id;
> >       u8 release_regno;
> >       bool r0_rdonly;
> >       u32 ret_btf_id;
>
> Eduard Zingerman suggested in v3 adding a comment for the new id field
> in struct bpf_kfunc_call_arg_meta. The field remains undocumented. Would
> a comment clarifying its purpose improve code readability?

The readability should be improved in patch 7 where ref_obj_id and id
are moved into ref_obj_desc.

For the meaning of id and ref_obj_id, we should keep it in where they
are defined: bpf_verifier.h

>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/254424=
56702
