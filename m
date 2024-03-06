Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F8139D
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 01:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709688861; cv=none; b=BTzUbO4Bs1uzb1gsYim/qHaz4sGKWHMq+Wfcxl9aAdmPS11wxwYYNwhOWyk3HCyrq1ozsbbuBpUPUbjBDR6KrCu7Oikare44yxPh1Ve1jRI/WKb8jUumwl0BRy+/cYNn+X0SgHH91NG6Hz9IZf3xxlz914vypUGaZQHMA5uxJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709688861; c=relaxed/simple;
	bh=k3O4eDhAids2RihuPY0FrfeH1MgThXR1VCHVdgYAPAk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHX1Lw8ySt7Qloeb7M76ZIy3ErldkBZiPb7Ppr5+k0yJhOvbCzFKFYvMkJOv4Gas+NRBehuaUb4JIT+GmI4MoZilU07fH/vyakLXPdZrWw/yJ8NfaJI3KjH4J1SiRYq2QCwSi5vP0BYhfEeRNxiCstgZbwoWa8rUb64p7eV7RM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtUERGSC; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtUERGSC"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so1721939a12.1
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 17:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709688858; x=1710293658; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4HRLRSN7Ae3ePolJUCPt0KiyAkPEn0WcS00Xu/igH/M=;
        b=jtUERGSCayaI8l8lvS8uwh6P9YlMkb9vtTd6Ud39Lt/EtcJXUpVYRyTN6oFHDQu6a5
         yTxWjt99p9kcnBIm7UHWtpWOFgHbKY4ai9FP5pmFw9iPBbTQ7GXsArg7QKbaEnxjok+b
         lg3YthAFGAwbKY8i/TLzGgugIStulEjAKqBa3r/SSFvBZVAG8V8XHv41Qo982x+hSUGB
         fbiXirHZi2San/Erlx+2llr3SeX6W2X06+w5Xjj86wnYW8t/5xK7VLtQnPIHcaTVuP87
         ay895g1OspSjlZxZTN/iaEhl/9MMxMUezX5vkxSL2I4a+fjwvTRDnc9WmjZ+lE+qo/Ts
         z2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709688858; x=1710293658;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4HRLRSN7Ae3ePolJUCPt0KiyAkPEn0WcS00Xu/igH/M=;
        b=IFpoAPAVA3KGnAUGEJkbsKQlWi4SWnuHTnzlDfvzTr48s7biRwXKNDpWz7pZCDMKkm
         7toCu40sB6SrQ/b4GncBze0YMsT6awtalhLDkAPaLokAdR3bhALnZ7GejpmYqARJW2GD
         wmRgaMBp1oOd1atk6Sm6C/Jbm5U+Ts8sl62Lm++1b9y/3rC7i4Q9JAARN8catGh30XIE
         mMp6Kl2oA30VkIxpTX/F3FLuOFpXZYBVrzErTa2UW3c1vZIfEsMaAIw7Sdsd/exKGvRT
         PDAp354lXsvrYD0bJs3tc5jEO1bXUNhbyIqIOTqv8G5EvZJTCY2yjSfmPRQfjCr2JV1a
         jAwg==
X-Gm-Message-State: AOJu0YxkinYzmgNJp57pS496C9kqIucPGIRgVoFSvSO8czh1Iac9ZnG/
	T9YXVtGiKgb9fXNsuquv1nnFJHITiMQEo8wXh0+IYcRaE6ItYTrT
X-Google-Smtp-Source: AGHT+IEZ1TilC9Qc50aKB5tpz44sAdpKfD+Wsm8OR/EcdDF6iw9AeqNTy9QIwTeXOjR5YStmUQVfbw==
X-Received: by 2002:a05:6402:1516:b0:567:dea:613a with SMTP id f22-20020a056402151600b005670dea613amr7437885edw.37.1709688857518;
        Tue, 05 Mar 2024 17:34:17 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i17-20020aa7c9d1000000b00567566227a5sm2704078edt.18.2024.03.05.17.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 17:34:17 -0800 (PST)
Message-ID: <e335d19e48f3dc389bf75eff3fb4086409fad72f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 12/15] libbpf: rewrite btf datasec names
 starting from '?'
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  void@manifault.com, sinquersw@gmail.com
Date: Wed, 06 Mar 2024 03:34:16 +0200
In-Reply-To: <CAEf4Bzaso6bnWfks2sTxyK+BTid+Aj+vq64PCMAZW6=kQT+D-A@mail.gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
	 <20240304225156.24765-13-eddyz87@gmail.com>
	 <CAEf4Bzaso6bnWfks2sTxyK+BTid+Aj+vq64PCMAZW6=kQT+D-A@mail.gmail.com>
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

On Tue, 2024-03-05 at 12:03 -0800, Andrii Nakryiko wrote:
[...]

> > @@ -2922,6 +2929,8 @@ static int bpf_object__sanitize_btf(struct bpf_ob=
ject *obj, struct btf *btf)
> >                         char *name;
> >=20
> >                         name =3D (char *)btf__name_by_offset(btf, t->na=
me_off);
> > +                       if (*name =3D=3D '?')
> > +                               *name++ =3D '_';
> >                         while (*name) {
> >                                 if (*name =3D=3D '.')
>=20
> let's just extend this to `if (*name =3D=3D '.' || *name =3D=3D '?')` ?

Ok.

> > @@ -2938,6 +2947,25 @@ static int bpf_object__sanitize_btf(struct bpf_o=
bject *obj, struct btf *btf)
> >                                 vt =3D (void *)btf__type_by_id(btf, v->=
type);
> >                                 m->name_off =3D vt->name_off;
> >                         }
> > +               } else if (!has_qmark_datasec && btf_is_datasec(t) &&
> > +                          starts_with_qmark(btf__name_by_offset(btf, t=
->name_off))) {
> > +                       /* remove '?' prefix and add '.optional' suffix=
 for
> > +                        * DATASEC names staring from '?':
> > +                        *
> > +                        *   DATASEC ?.foo -> DATASEC .foo.optional
> > +                        */
> > +                       const char *name;
> > +                       char buf[256];
> > +                       int str;
> > +
> > +                       name =3D btf__name_by_offset(btf, t->name_off);
> > +                       snprintf(buf, sizeof(buf), "%s.optional", &name=
[1] /* skip '?' */);
> > +                       str =3D btf__add_str(btf, buf);
> > +                       if (str < 0)
> > +                               return str;
> > +
> > +                       t =3D (struct btf_type *)btf__type_by_id(btf, i=
);
> > +                       t->name_off =3D str;
>=20
> let's keep it simpler, just do in-place name sanitization like we did
> for !has_datasec case? It's fine if "?.struct_ops" becomes
> "_.struct_ops", kernel doesn't care and doesn't assign any special
> meaning to DATASEC names

Well, in theory this string is shared between several locations,
though this is probably highly unlikely.
Anyways, I made requested change.

[...]
