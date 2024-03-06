Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCD86FAD
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 02:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709690680; cv=none; b=UiCQeIMmb++yqTlSKq+ARqh+qdoNMLRxgT1gbaVJQZ/Sll4cenNjOh2jWL716I3JaXW6+IOxqFFeWvT7weHRRmSbyT8+T0WuqKn6A9RWe2+uX2xotfiMdNPIcmB3S21a5gg550DyNT8p5OSKmU684+mCOVjOqMINvik1AMmbcWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709690680; c=relaxed/simple;
	bh=hnVn9ahkZgQh2ioVwfEOa76YoUot3D2b1k5mU3nNxl8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pQ+7YT846QwDYTpLNBYySf2WD7IrDjqH0PBYcXSJ8rvhTk+pBFlPqXZq5XR7QoSiE5gmn4HV0a/rAzEKGDY3L6BT6Y9lpCfEaoaubHyvBu4/zt85HdCx7j2oykVbiejtNgdRtOPJxN5XfmHwJaF7Ehvuy26lCzrGoQFXs6h47hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqkNQ8jw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqkNQ8jw"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-567eb0396e7so88554a12.2
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 18:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709690676; x=1710295476; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xLkJY27g6BUUvnEjEDXsrG4cxTQCBXtYrAp2JUXrpUc=;
        b=kqkNQ8jwGc12+1fj2fDXxx62jeETKkA0ma8A8FVXFXdlad1S9x+rkI85JWcByHg8L+
         x9L32GhmV1YiaE7MkCRq0KForOvLlxBqZVXeynyA3lrn8sxdMdCgNMM+98GgId+/+cXv
         AY5aLqPUVN9npAf0O5J2UyyUkaec/EBjj0KEEgEnb2HYvnluWAb0Znalx1zb0OwcbBdW
         QgrC+SavEnQNzY6BP/41hkdtncVax7mwJOJZnQdZFS/jhj0THLj3EYVKoXhYG+OB2S2O
         II0TMMtcTXmG1BLCzGSaT2Bh4vGnOtz/0qfxErEY27yXxtXNcWbMvPYCdKw9d3Wz1FBg
         I1bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709690676; x=1710295476;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLkJY27g6BUUvnEjEDXsrG4cxTQCBXtYrAp2JUXrpUc=;
        b=Alhzdcfps6YanhCzk9oUukRnZD204+20rXCa3rwpabvXlwagkrDmu8WZFo9favlOhX
         8vQVxhUB2xFv5Uq2HFbAWNOUCjmtQ0+Nlkbclglj6q79mZkam+MfzIea84IRkNpudkdb
         JppQDdec3iBSFNmbCUy+cqxy61vo2X7Pg4tDAL0xNf4mMZrQWB9rbZtiVLRLyqXDQWSd
         j+igMTUtJ/etVn0uKu2XSXi3DDFeSc04xkZP1KiDqyDOol/yjDxDpb5EC8gDUPSbm11y
         fkvqrEi6hlaMCgBEmbb6Ad41dBLGH7ERF0Lz5/iQMnAa+XbiDWpD3ArIQbcuV3rXd9Az
         UUBw==
X-Gm-Message-State: AOJu0Yyw9/ip9wE++Va3l1NJZ218elCahrxchkkIrSV3SLyE9s1TEwRm
	8GcIl+ISdBzbfZEVCiTNmHWUj8Mjl7WuGmzsblm0Dq6tMwxjA2QA
X-Google-Smtp-Source: AGHT+IGWNEKCUYJpyz+zwhJUqSOI92DaJXm2BFwXSushdaOvSdP2Z4Dk7x/Uel1KJk9LXYhNXnBXMQ==
X-Received: by 2002:a05:6402:948:b0:565:4ac9:d69c with SMTP id h8-20020a056402094800b005654ac9d69cmr8870370edz.11.1709690676625;
        Tue, 05 Mar 2024 18:04:36 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id e20-20020a056402105400b0056518035195sm6381519edu.69.2024.03.05.18.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 18:04:36 -0800 (PST)
Message-ID: <40a86c034c9b536c2bd0850e9590be2b7a2c28b9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 14/15] bpf: allow '?' at the beginning of
 DATASEC names
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  void@manifault.com, sinquersw@gmail.com
Date: Wed, 06 Mar 2024 04:04:34 +0200
In-Reply-To: <CAEf4BzZ0tkh5T4EjwHGH4v8LxzG7y_WMfbefjaU1==Kf_adgtw@mail.gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
	 <20240304225156.24765-15-eddyz87@gmail.com>
	 <CAEf4BzZ0tkh5T4EjwHGH4v8LxzG7y_WMfbefjaU1==Kf_adgtw@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-05 at 13:43 -0800, Andrii Nakryiko wrote:
[...]

> > @@ -761,12 +761,13 @@ static bool btf_name_offset_valid(const struct bt=
f *btf, u32 offset)
> >         return offset < btf->hdr.str_len;
> >  }
> >=20
> > -static bool __btf_name_char_ok(char c, bool first)
> > +static bool __btf_name_char_ok(char c, bool first, bool allow_qmark)
> >  {
> >         if ((first ? !isalpha(c) :
> >                      !isalnum(c)) &&
> >             c !=3D '_' &&
> > -           c !=3D '.')
> > +           c !=3D '.' &&
> > +           (allow_qmark && first ? c !=3D '?' : true))
>=20
> ELF data section can have pretty much arbitrary characters in the
> name. I don't think we should allow question mark only at the
> beginning. Let's just allow any printable character, anywhere (for
> DATASEC only, of course)? There is no danger in doing this, data
> section name is not a variable name or some C identifier, and so won't
> be used like that.

Makes sense to me.

Thank you for reviewing this patch-set, I've applied the changes,
will share v4 tomorrow.
