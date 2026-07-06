Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35237D11F
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305007; cv=pass; b=HBds3z3sjRafRttHt+dCqGf2kZ/LUBr8PvxxD04ONIvpa+YqfSXkIV2MKVars6m8/E79m4ZyA5/3vszVcREvcZyLdJdRtM7JsoLGGUNYEe9KdFooDkCpl7KU7tKRds+/z5YRQAw5Cu9r5jKycFsTT8uKqvpori6RxmyzAzEgBoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305007; c=relaxed/simple;
	bh=kjz/DIz50I2rslr6Su2IYgJwRnyep07PbWz5fU1LQbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDOLbpDiT+xhxl+MDErGizjOPvE7H1WFQlunF1z+UuOEo9z3a8ilMHtnPcciwQ3c7Vvlae3VFuS6URHaVARX7JoH64h2iMpUxT+gAcag2JDignRigyY58utTkV4pu8o9OfW06GXS6HS/66M6j+58/rbBwNbTVjk/tV8X0djpYUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qcx6wTqg; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qcx6wTqg"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664b05d408bso1872435d50.1
        for <bpf@vger.kernel.org>; Sun, 05 Jul 2026 19:30:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783305004; cv=none;
        d=google.com; s=arc-20260327;
        b=IvKeirBapSajVDWLmx2M7e0L6neprPI0/r7iLVjDBe3nO0JurnQaGLa0lKd/rc5r7L
         36beHBigmMPBltDlgoBFGXSuDDAq4QOzN6RYLpDBXLOGtwHjfocgC9lzt9/ucNbInZaw
         JYSVm7NrnhFt8cOFyLSX1ptSmo0G+8K4St43XXHF3j0hFxrVksE61sSeGD4iqWNtNVrN
         /HX6j4gaJyfDS3kk/SZ7caCtwF8lQojq+8NdKwDbMXD/lltBBhIZAj1TsJlwJyihAICy
         6TNbsuST23La6X9tzTDmj0o8+OJLzyzTU9c7OQ+19eu0yEnxuLrxiqFbu6ZG0v3S0egY
         64gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7E709KOZSjF31w+mjIEzSoygJsJhyB+mH78Dt0DgfUQ=;
        fh=u/IB48dHVp9NXmLLY/G0IKDXORT8bgCZnDn9lZoqyyA=;
        b=mlYO+VCbM9f/DDwiTRADC2grNzPEhJukfI7+ybePo0YsqENypOUgCk/D0jGO/Gg8mR
         +q3YOI0IEXcSFsqKp+YUxjNnJgmtTlpNjGImK7bgq3bZ+qYpDMoKD1ufCSuFnhkoTm8t
         slJaKV3WuevQvCJ6pusoxemeEgP0hc/d4Un6SpVXwh4MP8lJ2w+6xz8/dTSS/LU0/CL4
         5NSRPPcydeOMgpkqMYz5944Hd3fp2O4H08FUDLYn2NZMSi71ML/zAQG5UF0NXvFNwVlQ
         Gb/8noVWPRy2is9WU3N06OXWYFhAOnSKqD30D14+MLR3SQGFItmG4cyU73i2oT6pZqJa
         cK0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783305004; x=1783909804; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7E709KOZSjF31w+mjIEzSoygJsJhyB+mH78Dt0DgfUQ=;
        b=qcx6wTqgbf5odF1dvqwaaR57Z6iNfjAtG1QivrFcwjG7jNS/fPoJOqy2Rz5hjLAFLg
         uS3jBiEpOZSoauvu6zzLfLdHAaVz3ImiiEenufCkDNJKug7i3Q5MbB5VioEog9U9IfSc
         eVpuu16AF7nWPweI5hmKUduH4nGKgy9QsP/ZdZxBZDgKE8vWm/SBCY4lrloeywT8UEoI
         BZ8YT/2RkkKwQMgpa5ZTu48Q5r1zh2pIDmoK6MOqhjePPH8oNHpVSjYRJmaLyMdiwwNG
         t1yeRdnw1OL+jJs67a9USLsVhkEH6IhhxbkbOsPTx2Fbg8vcb2V4lEdC3opv+F5ZkA6K
         o85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783305004; x=1783909804;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7E709KOZSjF31w+mjIEzSoygJsJhyB+mH78Dt0DgfUQ=;
        b=lXuvVP14w/xdxvoRORz2REZlwu+FBK3/Q4F4PHVTtp5iGw/HLXobaz+GLBpwm1i9Q/
         KNP0h5xNpQSF/lO9suH6Hm0lOn7QKMPG9k7xZpXOM2xSQ1z32oM6yT7i1AZbf9ksBJV2
         4LUW02BeXaepq09ArT8SPbf/Gpvi3ZOxU1/3qudWTxUAa032idFrmOhGBHno2xbS/6la
         5DJmgq+GQzIqDmcjmmC/SrJ27wtiQ1/4vB34jDtVoGM6WxYTBJapEc1MnlVKMYuIQEG5
         OuC6dZrKkYI4xZrO2D8KK8OrQAdA11+4K/R4OZrFblNB0VuXRAijrLmHwpH40LHAcSO3
         X3iQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrwo2UxfwCFCVnFVWB7CTQDZYUSv4Q14127BHFOdAc5ciooQ/fKClkwL4qIa56Jz5InkBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQaeXjIPoZZE2sL20R81C9aCL7nji9Ga+pHhkFbemPgE43qmg6
	WJIVIb8bg5hfSTCy4/Kss2fxsp2twWVBpsC7k9dmL5RYZD9rdTuLhMQkRiAk4EeVfcTwCf8yW1u
	V9ZGXGFRiMKVKdzyFZoV2OSQdz1rLL08=
X-Gm-Gg: AfdE7cljDFr3MeOVzJE/3s7mJWZ+QZ1Y1ozUkoViIrlr8/mOnTNTjncqsKzJvpOTpxt
	6EVkzeVpxu+TKO8BhkVI7rDgingrT7tOjQpFMRvS31ftYSG/EUFcfc0kQDf1L1nNxcnRhh70ywg
	SUXJJ9WWuwErTk3DpQYAvZICHOUCM5rzZFJse0Jygu4rZBeNO//P+hVC4wQQ6GVSYMApMSK2V6Z
	9/pmX7cc2X0AZ+zCMjufxmO4p6OyXvhU42rzR7W7aE+KKzE0jR5FJBbnNVTjeuZMZLIUIQGIWQ=
X-Received: by 2002:a05:690e:dcb:b0:667:6db1:8219 with SMTP id
 956f58d0204a3-6676db1840cmr2339061d50.34.1783305004353; Sun, 05 Jul 2026
 19:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705032603.275766-1-lgs201920130244@gmail.com> <akrdNginNVZPd9if@computer>
In-Reply-To: <akrdNginNVZPd9if@computer>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 6 Jul 2026 10:29:49 +0800
X-Gm-Features: AVVi8CfvmZw2Xu2VLNXKg73r5pLLfUsBev42bTXyXrfEr24mJC-SU3Jzx77Kao0
Message-ID: <CANUHTR_zU8o+B+LCwxN59W9fPnd1uGm8wKX+=3ZfO3X-0-_FUg@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Check full backing type size for bitfield dump
To: Varun R Mallya <varunrmallya@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Varun,

Thanks for the review.

On Mon, 6 Jul 2026 at 06:39, Varun R Mallya <varunrmallya@gmail.com> wrote:
>
> On Sun, Jul 05, 2026 at 11:26:03AM +0800, Guangshuo Li wrote:
> > btf_dump_get_bitfield_value() builds a bitfield value by reading bytes
> > from the backing integer type. The bounds check added for short data
> > buffers uses the number of bytes covered by the bitfield itself, but the
> > read loop consumes the full backing type width.
> >
> > For narrow bitfields this can leave part of the backing type unchecked.
> > For example, a one-bit field backed by a four-byte integer only requires
> > one byte according to the bitfield span calculation, while the value
> > construction still reads four bytes.
> >
> > Check the backing type size instead, so the bounds check matches the
> > actual read range.
> >
> > Fixes: 5714ca8cba5e ("libbpf: Fix OOB read in btf_dump_get_bitfield_value")
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  tools/lib/bpf/btf_dump.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> > index cc1ba65bb6c5..a49790e356a8 100644
> > --- a/tools/lib/bpf/btf_dump.c
> > +++ b/tools/lib/bpf/btf_dump.c
> > @@ -1771,7 +1771,7 @@ static int btf_dump_get_bitfield_value(struct btf_dump *d,
> >       nr_bytes = (start_bit + bit_sz + 7) / 8;
>
> nr_bytes and the line before it are made obsolete due to your change and
> become an unused variable, so that would need cleanup, as sashiko
> correctly pointed out.
>
> >       /* Bound check */
> > -     if (data + nr_bytes > d->typed_dump->data_end)
> > +     if (data + t->size > d->typed_dump->data_end)
>
> The fix does not seem right to me. This will reject
> something like:
>
>   struct packed_int8 {
>         int a:8;
>   } __attribute__((packed));
>
> with BTF output like:
>
>   STRUCT 'packed_int8' size=1
>     'a' type_id=2 bits_offset=0 bitfield_size=8
>   INT 'int' size=4
>
> As you can see, this valid object has a size of 1 but BTF type has size
> 4.
> nr_bytes (the old one), would get calculated as 1, and t->size would
> show up as 4. This will unncessarily reject valid data.
>
> I do understand the concern with the loops below using t->size but the
> check happening on a value calculated separately, and this can actually
> trigger an OOB. You could maybe try fixing the loops instead by handling
> packed bitfields (like the case I gave) specially, but making the check
> more strict is something I don't think is helpful.
>
> >               return -E2BIG;
> >
> >       /* Maximum supported bitfield size is 64 bits */
> > --
> > 2.43.0
> >

You are right, checking t->size is too strict for
packed bitfields where the backing integer type can be larger than the
actual object bytes covering the field.

I'll send a v2 that keeps the nr_bytes bounds check and instead changes
the value-building loops to consume only the checked byte range.

Thanks,
Guangshuo
