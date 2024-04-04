Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F63F6F510
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 22:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270965; cv=none; b=h5VrXmy8ZVfxfzi0teO+nlnu2NptnODEfHm4hCm0BqZYu9Gr7ZByQzL7qPuOVZOw//trZNRATk04zTyGsYUDprqr3LPsH4tFpeSNvtsIbrXUuiKvQIZ4nmKjyaSoB+twfgHVYzct6gSRafPLwZ0xK5DtuSvqLtfTYMyFyjrF+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270965; c=relaxed/simple;
	bh=k/5HHUGgQ8yYKuU4D7QaBYbSmrfpTqlrd4Pr8wlSGM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKt0aOx1JgHHW2uI4NsP9ViGUVvbmSF3XAqJqdOiwfCy61jKSnXrXroFY6/5uq++awOuG9bvWft/PePZ59IaVLGmos8oFBMw2Qkf2aG6zQuH+Tuuk41XTsmSqBQ1H3IRJ56kZS+i3G6f3ayFuoiAU0lFc8ZXk7ZiGZY9xIrbmrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXpqvQzp; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXpqvQzp"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29b7164eef6so1197343a91.2
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 15:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712270963; x=1712875763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hD+GAZ+ugayG7k4pqOPLbebEyyTUbtXzN+nt+0dJRc=;
        b=hXpqvQzpL47z3ClnLlV4qZfBYp9r345MQPiIKgLo/eq4VmWFo1AhxGQPZVWVw1tNpl
         /RtRr3sLlRoZhCFTmOwtt2YEhsbk/COm1VbnjsZwWkGZuAIcYQXhKVARF1IFnDJVdUTa
         HE/NVNSOZ4SWztmukm7u0SWTeGXxOo3SzjWtEPep6mDnqgOmRLHw8p1vpRjkXOwRfLhh
         pxNabt05yqMCAy4YLNzy58KSPK8c0FiujIocuiZKr9Sps9ZTsxOKT2fwOo4r9IJS0gVX
         IeycSCtvZjykMwoCsIB38SQPro+tzjebeXhGtm8m0SUEGX/fwoKNvmbWxeOT7RQcbi7l
         /Lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712270963; x=1712875763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hD+GAZ+ugayG7k4pqOPLbebEyyTUbtXzN+nt+0dJRc=;
        b=WkMjSqto0xQl6eqi4xs/nIjHyYQCfEQ51Nj8LrxTXcOjf5nhLw0YCOwsEgfpEcalKj
         Xf9Ba13SCgbzuB9YutSFh1Z6HpKDH3RiLlqwQWZqzS1c4qiOaKVOYd5rD6x567bDUeFG
         Mlr/oRYTcYVR+jpIg0s+qAn+jXdXjpKfNcK6tl++35dxyE6HcJEbpozQ4f6csj4jond6
         mpYYobrzPNHAR7Kw22woxxBZ1/Cu5VzrEcawH4pf/7HEuk4rjeXuqC49Sl6ODnVBZKyH
         x/tOT8JlNzROdJLkctR46Me/s78E6WjIP2HZt5EHm6FLrWdjH59kwzJuFhkJJePySAuC
         Jg5A==
X-Forwarded-Encrypted: i=1; AJvYcCVXMKrPo2dtZksdHWiwlyn6ItZVfQH5CLmJ5LZHL6etqNNkQiVdtyCfmLImlyaV2WkWjO2C64nUb07yGaNGfe4qZyU/
X-Gm-Message-State: AOJu0YwGjzW5LBYlCXJywX1MpYa6JQCSd8bCFlYKGqTqDu7/Shl33RrP
	/K08DwXhMEworc9/JIbzHY05WGfhUqkxoLShUuKifYnlE1Dpr7GxMUSLn3y3i5ciFtETnGpNXaU
	7gYG0L+dBv/0+Ncw/x8yOvz0A9fo=
X-Google-Smtp-Source: AGHT+IEXy9WgJkgHX67N3NPJ8F4s7V/OuaWQScLv9FESM24T1ueDWlkAgYlOXcOD8iDZvIBf6glWx9qD+dA70QdCXtU=
X-Received: by 2002:a17:90a:d917:b0:2a0:9b18:daf with SMTP id
 c23-20020a17090ad91700b002a09b180dafmr3876680pjv.42.1712270963323; Thu, 04
 Apr 2024 15:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322102455.98558-1-alan.maguire@oracle.com>
 <20240322102455.98558-4-alan.maguire@oracle.com> <CAEf4BzZ-rezyjmsR2CJdZMbY0LUzp0KBOV1oVfXVDpXgyWMAYg@mail.gmail.com>
 <fc2a18b6-ea8c-4672-b5c2-05224a9a8adc@oracle.com>
In-Reply-To: <fc2a18b6-ea8c-4672-b5c2-05224a9a8adc@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 4 Apr 2024 15:49:10 -0700
Message-ID: <CAEf4BzYE2QQ9cJwr45RSYTH2CEKrCMUWBg7m+ZsKDafPW5whUQ@mail.gmail.com>
Subject: Re: [RFC bpf-next 02/13] libbpf: add btf__new_split_base_ref()
 creating split BTF with reference base BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 8:22=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> On 29/03/2024 22:00, Andrii Nakryiko wrote:
> > On Fri, Mar 22, 2024 at 3:25=E2=80=AFAM Alan Maguire <alan.maguire@orac=
le.com> wrote:
> >>
> >> To support more robust split BTF, adding supplemental context for the
> >> base BTF type ids that split BTF refers to is required.  Without such
> >> references, a simple shuffling of base BTF type ids (without any other
> >> significant change) invalidates the split BTF.  Here the attempt is ma=
de
> >> to store additional context to make split BTF more robust.
> >>
> >> This context comes in the form of "reference" base BTF - this base BTF
> >> constitutes the minimal BTF representation needed to disambiguate spli=
t BTF
> >> references to base BTF.  So for example if a struct is referred to fro=
m
> >> split -> base BTF, a forward representation of that struct is retained
> >
> > so you decided to not bother with recording expected size? Remember we
> > were talking about situations where vmlinux struct can be embedded
> > inside the kernel module's struct. In this case *exact* struct size is
> > very important and can't be changed without breaking compatibility.
> > Shouldn't we keep track of this?
> >
>
> There are two cases here I think. The embedded case - which is rare, but
> needs size tracking - and the non-embedded case, where a struct/union
> can potentially change size without invalidating the module's
> assumptions. In the former, your suggestion about having an empty
> (sized) struct instead of a forward would work well I think. The only
> question is around the non-embedded case. We could either use the same
> approach (but then ignore the size constraints during reconciliation) or
> continue to use FWDs. The advantage of continuing to use FWDs is we
> wouldn't have to compute struct embeddedness during reconciliation, and
> the BTF itself would be a bit more informative about the constraints
> (FWD means no constraints, empty sized struct means we care about size
> due to embeddedness). What do you think?

Sure. I was going to propose using size zero, but FWD works just as
fine and avoids the ambiguity of embedding zero-sized structs. The
important part is to check and enforce size where it's important.

>
> >> in reference base BTF, and split BTF refers to it.  Base types are kep=
t
> >> intact in reference base BTF, and reference types like pointers are st=
ored
> >> as-is.  Avoiding struct/union/enum/enum64 expansion is important to ke=
ep
> >> reference base BTF representation to a minimum size; however anonymous
> >> struct, union and enum[64] types are represented in full since type de=
tails
> >> are needed to disambiguate the reference - the name is not enough in t=
hose
> >> cases since there is no name.  In practice these are rare; in sample
> >> cases where reference base BTF was generated for in-tree kernel module=
s,
> >> only a few were needed in base reference BTF.  These represent the
> >> anonymous struct/unions that are used by the module but were de-duplic=
ated
> >> to use base vmlinux BTF ids instead.
> >>

[...]

> >> +/* Create updated split BTF with "reference" base BTF; reference base=
 BTF
> >> + * consists of BTF information required to clarify the types that spl=
it
> >> + * BTF refers to, omitting unneeded details.  Specifically it will co=
ntain
> >> + * base types and forward declarations of structs, unions and enumera=
ted
> >> + * types, along with associated reference types like pointers, arrays=
 etc.
> >> + *
> >> + * The only case where structs, unions or enumerated types are fully =
represented
> >> + * is when they are anonymous; in such cases, info about type content=
 is needed
> >> + * to clarify type references.
> >> + *
> >> + * We return newly-created split BTF where the split BTf refers to a =
newly-created
> >> + * base reference BTF. Both must be freed separately by the caller.
> >> + *
> >> + * When creating the BTF representation for a module and provided wit=
h the
> >> + * base_ref option, pahole will create split BTF using this API, and =
store
> >> + * the base reference BTF in the .BTF.base.reference section.
> >> + */
> >> +struct btf *btf__new_split_base_ref(struct btf *src_btf)
> >
> > I find this name very confusing, for some reason. btf__new*/btf__parse
> > is generally used to either create a new empty instance, or just
> > parse/index pre-existing BTF information. In this case I feel like
> > it's actually a different operation, where we create a derived BTF, so
> > I'd name it distinctively. How do you feel about something with
> > "distill" terminology as an action performed here. E.g.,
> > btf__distill_base() or something like that?
> >
> > The API contract is also suboptimal, given back split BTF where base
> > BTF is owned (and has to be freed). Let's keep it a bit more explicit,
> > something like:
> >
> > int btf__distill_base(struct btf *new_base_btf, struct btf *new_split_b=
tf);
> >
> > WDYT?
> >
>
> Yeah, any suggestions around naming are very welcome! My first choice
> was "minimal base" but that seems to prioritize the minimization, which
> is really just a side-effect of the desire to add context to the
> references in the split BTF. "base reference" feels clumsy to me too.
> Ideally we want to find a name that signals that the base BTF is a
> companion to the associated split BTF, adding context for it. Describing
> the operation as distilling certainly connotes that we're removing
> non-essential info; so we'd end up with
>
> int btf__distill_base(const struct btf *src_btf, struct btf
> **new_base_btf, struct btf **new_split_btf);
>
> ...and we could call the section .BTF.distilled.base perhaps.
>

We can get cute with analogies, but I'm sure people will hate it. :)

What do you get after you remove all the non-essential cruft
(distilling the essence)? A "nugget" of goodness... ;)

I'd keep it short as .BTF.base (and know that it's this "distilled"
base BTF, not a real one), but I don't feel very strongly about this.

>
>
> >> +{
> >> +       unsigned int n =3D btf__type_cnt(src_btf);
> >> +       const struct btf_type *t;
> >> +       struct btf_ref ref =3D {};
> >> +       struct btf *base_btf =3D NULL, *split_btf =3D NULL;
> >> +       __u32 i, id =3D 0;
> >> +       int ret =3D 0;
> >> +
> >> +       /* src BTF must be split BTF. */
> >> +       if (!btf__base_btf(src_btf)) {
> >> +               errno =3D -EINVAL;
> >> +               return NULL;
> >> +       }
> >> +       base_btf =3D btf__new_empty();
> >

[...]
