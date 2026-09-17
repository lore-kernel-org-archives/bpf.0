Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427BC456E0B
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789681918; cv=pass; b=SWyt79OCujU8icqB/LHT0PlY9h5wWl5qwfaxgO2dtjMrkOQkIFDwbYS8LILiEguqMk5k+bnl0mmr08diIJRRYG/EnLnQtB6Dx/R1E51NOvI1nalz6PyyQ/Kzryv8XrgGOQ07kJNnv8H/DMgmvgBBdOYNiypfTPh7Pi3FZmNYgI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789681918; c=relaxed/simple;
	bh=Bh0Za0M7eIE9l9EkUcM/rV1DFudofFcuMDh04EBYbmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BSiNLkCYM6kMMU3aLY9Cwzje8YLefCeo0MxPPfnG3mb23U8cBsOoQrP1ft9Ak7jvgaCX9WjG9rCYwfP+bIEC5qq68ASYUiL68d0s38pmHk7FyHxWWHEicrVf/0G/ZtTMYXU1NEK2dGbQ/iHN6DNQFb6FgSTXM+kihWL4vb4/L30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aqy+wEg8; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aqy+wEg8"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ee1f9bso756365ad.3
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 14:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789681916; cv=none;
        d=google.com; s=arc-20260327;
        b=a96BDhO/DcmMTJkFeYmRA7F5PZrhvMJMJJV/SaOhLtVZK/Kg0Qk7y/sDQGEhIcGlRH
         uPivUElXYJFFIkdngoHa6DGt02imcPNR40Fvz+ZjagWEZPaVaBby8TzbOzvbdJSlFBY8
         Yn5ilXzGqtgaDwsNZsn6fOmZ+ccBMSSNQbenh8uwOgC3fYV+jxuFTG141h1Ue81b83/x
         kPDMZr/JuB1f/thP1/t23Z3XzYsA/dnClNuG+bMtxCC6r4h1cWhk0B3+rd7hwN8neJvw
         ZxIiHJV1KSmo+ZHOC+CXaPy00XcSZq8z49PrCiHbnG/YtuOo8XacvIy+qOmJ/ObOTolD
         jkxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kllAQrd4mkfujcBfLx+9muZFMAG4CFkONTpnqsj5ZFU=;
        fh=Pt6sKbZv0ijAhavqZflLqF3fSjEVzNxt6H6Xlv9tcSU=;
        b=K6Lzot4y1Eottmlm3VnhdUQEd0wqdsdnMw9aZFDR13NuRAUn+In08RGNnejwSK8WBY
         TP0BYL7d2UA/i/AEfAZ2/ujkbIGqB3rVzc/TfCBpDiLsW4LtGD5jEOmgjQDaRVa9GpFB
         sB0hrAsI7XScDEFQfHruuaCITJBy9RpMgstHv2LzoG27yum7OCFGKoLTqox0caktQY9f
         Lv0ZQNvfYqnZ3b5Fpt/EZIG/a1LTAmJ83MMfL58cQTD2ddT+oFEpwdpEjSCU/L/zjHHd
         LbC+M1fsqZPPfVIu10SYAaupQQguMZXnoSJ5yBCokxDuHT3VLXh7+GjCWGGIFTyeuLm0
         E3nA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789681916; x=1790286716; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kllAQrd4mkfujcBfLx+9muZFMAG4CFkONTpnqsj5ZFU=;
        b=Aqy+wEg8risuAGpXE2ucYeuLWSY5YSYX2PySoybM6arggtZffeWO4kKcEjfvsvLo9j
         BFgzmeM+AC9wmRS3/YKXMw+Y8Kd6X5I5dYmw1dKKjVmX/kyqvtWvh5713ClNLKMGWUtX
         AHfR9gmWC/CGag+HbDkzGMXFVI8kHyYgK7hHdxEZlPQBIOaK2iyYgkbzW0Ir5TkExiIV
         wMjCfY6w/ZOpQErpZxXRaCGyyRX/sAP2sfB495ZIuwdC8xMjWFOv0fvGn7mF+FAZ5pr7
         UnU45uiOGiDSlePJJoTlLqlzsBw455os3oEKwE3cn1sjssuGrdYrq4HGOH06fexOpE0T
         XoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789681916; x=1790286716;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kllAQrd4mkfujcBfLx+9muZFMAG4CFkONTpnqsj5ZFU=;
        b=oWJ/jAFo3bQZmCGb6eLJtnHYVBz8hp/HSik4RyS2lZww3nQrJIYGBZzYMB4DhRooUM
         3dMF24aZjM89WIEr/X/6qcNpIuIVSEni7IdZY4F1kVyGs2dxxMM+4BvfkLquhy/eLs5j
         86y4G3nM5fQj2VtQTJEy4W8ZL5a/mnzAQlWU1/q3g81XJDu8+yt35yGlFwcUAOKI1SB6
         HHr0i1h8XVwXsGYZ9HtdE+ewSPASeu+RGZcPt3RBqqW86XaGDqMAHAIw9yCIXAWiEj1M
         HmVmbwsAfvdNoTLHgcs+ZSg6tCGg4IXOhLHgeFZeb/hLMLV94CkcJwqQ8Q/lz478BMDZ
         E8Fg==
X-Gm-Message-State: AFuF++mZxjVk2CJNSGwh8AfuRf2BwPi5Uin9lEg8oBBSgJ3RoKU39hkO
	aG+3t9ZxfVVp3rPFdXl3nY0fo1goXqNyh1XuXJA6uOxu0bIW1wn9BZNlPedNX5FSZUSYMh3ASdo
	oMKUBp2YANOcDQABjXCLWqV83Is/AOAMaEw==
X-Gm-Gg: AYBFou1BaLtGsTrwfCcVVSXLOmlrt0a2u7fBNM3HTM1h2n6eqG+2OJ9i8C6jnIKykNU
	OlSj1VA/jnMfXv2+nm+8zTqDxMQ73edpG4rgBGn9/UKGcvApnPO0mOk2U9m7nZPmDVnXOQILlwG
	+vwkbEmFDBPf1CqzOQ7XM3X8PtPWFsQz+y1zjLNyzqs97fz08eLLCEAtTZV17f5ljHX40/WVILu
	FpUcZuOiJGYlVp0PGl44VAzDJx2SWLEbGclIWyEagDJ44FPgopflg7MO/M6r/+EkAqYJU9q4B14
	ch9Nyo/vVU4KJV8OhnHAz9Teed7qewpjst9flovlOM2hGzGqiIn9+N/SAkxq+9Qd5BL4RonOdno
	qHQG9x7hKW1dgHsP/Wv4FkKK6RNnbfqELn6mlXQsXinFEX5LdgADTdw==
X-Received: by 2002:a17:902:d48e:b0:2dd:6665:9ff7 with SMTP id
 d9443c01a7336-2ddb1c17043mr7838595ad.22.1789681916353; Thu, 17 Sep 2026
 14:51:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826181825.1826541-1-andrey.grodzovsky@crowdstrike.com>
 <20260826181825.1826541-3-andrey.grodzovsky@crowdstrike.com>
 <CAEf4BzY8LLT6_=sOyof7mE+GenAwtVNhzEP_Emy_U07WFjU+Eg@mail.gmail.com> <CAOu3gNgoopD0=8_0_OmVrt1bWdffRy3GmbBBC2Qe_9MaYjvEdg@mail.gmail.com>
In-Reply-To: <CAOu3gNgoopD0=8_0_OmVrt1bWdffRy3GmbBBC2Qe_9MaYjvEdg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 17 Sep 2026 14:51:40 -0700
X-Gm-Features: AcwNN1W0trE6eF2lH82ygfeDWT122TiXdKODnVbI18W9MUMdmg1fL4Sy3-TJ62w
Message-ID: <CAEf4Bza-2N4JnnhCyFgCEHJqhFgiAsBECXpF0mrzfWZHwPysNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] libbpf: BPF programs dynamic loading and attaching
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, martin.kelly@crowdstrike.com, 
	slava.imameev@crowdstrike.com, linux-open-source@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 5:39=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Fri, Sep 11, 2026 at 7:44=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Aug 26, 2026 at 11:18=E2=80=AFAM Andrey Grodzovsky
> > <andrey.grodzovsky@crowdstrike.com> wrote:
> > >
> > > From: Slava Imameev <slava.imameev@crowdstrike.com>
> > >
> > > BPF programs designated as dynamically loaded can be loaded and
> > > attached independently after the initial bpf_object loading and
> > > attaching.
> > >
> > > These programs can also be reloaded and reattached multiple times,
> > > enabling more flexible management of a resident BPF program set.
> > >
> > > A key motivation for this feature is to reduce load times for
> > > utilities that include hundreds of BPF programs. When the selection
> > > of a resident BPF program set cannot be determined at the time of
> > > bpf_object loading and attaching, all BPF programs would otherwise
> > > need to be marked as autoload, leading to unnecessary overhead.
> > > This patch addresses that inefficiency.
> > >
> > > Signed-off-by: Slava Imameev <slava.imameev@crowdstrike.com>
> > > Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> > > ---
> > >  tools/lib/bpf/libbpf.c   | 144 ++++++++++++++++++++++++++++++++++++-=
--
> > >  tools/lib/bpf/libbpf.h   |   4 ++
> > >  tools/lib/bpf/libbpf.map |   2 +
> > >  3 files changed, 141 insertions(+), 9 deletions(-)
> > >

[...]

> > >  static void bpf_object_post_load_cleanup(struct bpf_object *obj)
> > >  {
> > > -       /* clean up fd_array */
> > > -       zfree(&obj->fd_array);
> > > +       /* The fd array is needed for dynamically loaded programs,
> > > +        * so defer freeing it in that case to the end of the object =
lifetime.
> > > +        */
> > > +       if (!obj->has_dynload_progs || !obj->fd_array_cnt)
> >
> > why the added fd_array_cnt condition?
> >
>
> To avoid keeping the array  in case no program ever referenced module kfu=
ncs
>

my confusion stems from the fact that we unconditionally zfree'd it
before. sure, you now added has_dynload_progs to postpone this, but
fd_array_cnt is new and seemingly unrelated, so I'm still a bit
confused...

> > > +               zfree(&obj->fd_array);
> > >
> > >         /* clean up BTF */
> > >         bpf_object_cleanup_btf(obj);

[...]

> > > + * Dynamically-loaded program data is initialized on object load.
> > > + * Post-load initialization is not supported.
> > > + */
> > > +int
> > > +bpf_program__load_dynamically(struct bpf_program *prog, int extra_lo=
g_level)
> >
> > just call it bpf_program__load()
>
> Problem with this is we already the legacy bpf_program__unload (full
> unload, irrevarsable) and we have our lightweighet
> bpf_program__unload_manually which just closes the prog FD but retains
> the data so it's reversible. So this renaming creates the wrong
> conceptual pairing. I am open to other ideas on how to proceed.

just make bpf_program__unload() not free anything for programs that
opted into MANUAL mode? I don't think anyone really is using
bpf_program__unload(), I actually don't know why we left this API in
libbpf v1.0+ at all, tbh...

>
> >
> > > +{
> > > +       int err;
> > > +       struct bpf_object *obj;
> > > +
> > > +       obj =3D prog->obj;
> > > +       if (!obj || obj->state < OBJ_LOADED)
> >

[...]
