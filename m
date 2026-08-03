Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB202E88BD
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785779141; cv=pass; b=IvgJ6hKKAYKauEJ75epKHl7Jh9kR0ERzTW4gN5tadbWsDFIh+mhpEA5NBZQno4MfA4DsifN5wG+89fqK5MmV83fiVNYvJc0InSpCUvubuh6V/QgoLl7Ub2D8fd7Czoq7hZFESmkiBBeFwURjbgA6pu+NMrXmBbcjdrK14x5FEoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785779141; c=relaxed/simple;
	bh=PoaxjX7gkLGcVWTwINsJIl8svA8kT+l+Auiz+RY9eUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIZsw7djoP80j/+cyxtrvPENuqsYmNtxo6ejzdmsurhT02o38vFh1imjU5LaULZIPSkOlF01E16aclGA8h2ycDIy6AxF8ToRZehFd2khFOV6UgkzvmSGY85XuSqxApWkf4x9mdQZcNcKJBp8RZE2yGOzSdbc3O97IdhzgcorxFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUjVz3/3; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUjVz3/3"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84864086bfeso3903999b3a.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 10:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785779139; cv=none;
        d=google.com; s=arc-20260327;
        b=BplUVF9Pz4ccTOnN3UQvE/9njzUGn3GaAF9pUyrdh6gMAuhSdY9J2sisZ4kSWtklmP
         dXRw0yhpBUJPJjAQ3XPvFCzIZ1PFAJxnjvnLPT2/bO0ecdzV9yDDKxiLmGBFl2OdPod6
         liNUddNZnA12jvk6IEtFypljQdgaqPvU0hOZoiVzUYp56OWXuC/Y1G2ibFKLE7880nTC
         oMnJfbdVan3Z8gn+RBubHBXRtn8Em130fbVtm626qEq+koLRwbAkKNyK52daQeRjCf4a
         nH6MRB5FCWfXI3X3Gtd1C6uNHmvpX939xKUaF3XYzoBrHY2v96PmFCgF5zbWCMkLm90J
         okNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JvXutYZoCN6kAezBjL3UuOZhfst8yNA/gvOtW2Q7+a0=;
        fh=nBbEpJv7qAWvTwtwtvYR8swUhgDtlGx4Io5DQ0SifZo=;
        b=BqH9eTaIl9d5qxs3TRBH6gBvAmdWwaTA3xpPTL8hREkIkF5Ee05FW78O0DvoSMpeSz
         QED7wW6tH1WX9pMp4EHLh/4HJUvvujQSWnh+h9mvTZSWTk3vVbsFeK+JeBjwc5CneiVM
         5+UunAS+scxJRzWYmyHnCQ8I96y2svwdEyeVzsoG/bszWjkOzcvF59BuNyFJ5a1MtX4Y
         Jm41COkPrrb8fGvrul928Ag2vKQ/OoAVYcPHbYag7bABgX+QYYFO04xCbuS6dfYnm8/B
         cvtXlIFafgrHSWvGxn5maHf8Ee85XoQPLHndSygy3eNzOv294yPZftm1PdvkhC2Om9+S
         XmFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785779139; x=1786383939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JvXutYZoCN6kAezBjL3UuOZhfst8yNA/gvOtW2Q7+a0=;
        b=SUjVz3/3Ok5D6b8ohcf9bVJsTlDKsOeuLGbCEvVMRajfYJAmzb/eXKqz8CIRCB71At
         ACxXHP2tt+6M1byZIY2YQtatu0Xhe5XPRcnDCwiwnNOmF4OFp/VTz4IXpgsmN4mRPbNS
         oOuePoKqPSr8bZ2xqGsUNvRIsefNuoMQXYlDHb+7PhLz1RgF4FZeajxTGlG1k0lIg11c
         ya6f0ge5/iC+YGVYF/c1YFjAf0htK5c4CfMgTNWcG5VyhDg+Cz1loL0MHdXYHTw/T7CB
         fb8uZht3DMCA5W52Ri93txRXrCGM+pxJck4gINwkp2kshqFjjvyB9ZDFT1gut+uzQOeI
         TyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785779139; x=1786383939;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JvXutYZoCN6kAezBjL3UuOZhfst8yNA/gvOtW2Q7+a0=;
        b=OlnKbBQqSlKhRggvgwY2fA6AYFxqltT0nYTjfOn3zMnM1C6ToECoEU5j7xdcV7TyCY
         K48CXFYPzNvYLrR8ZtX3EIq+iDIfaauKhBdwRq/TbEhefMsn/JxovJ+Ggmi0dFQDkduP
         sfpe0tZGUfQvj2rntj9yAyxK0I5ik7W1q8b5PA8q0Gl3sz1CU7zUjuh+a26jzs7k1fGV
         TRWPXaXcvJeZR1lqH+7r+yQbzgghwXFfFpChgc36gidM0ni2Wv9jKwgWqEIhpgWrIQPn
         db/Rq7EzH0P+Xx4xmCONQKfZ1XP4LzgSJDYxI+3fdf2v/prqO8jmDQ9VkPpgVZqhV0ut
         GSzQ==
X-Forwarded-Encrypted: i=1; AHgh+RqS4Fv7QmaYHox+rgrWNnZGnCm5HOV1bYJqJOspM/jJb65xhXl+LodDmfCDUb4LPkPLaCY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIcGI83lz7GfaLne7IudLeC13ZgzyF0PpLSEJ4ND1PZlQSkIyg
	sjo3iffUe4xpsW71A02jMu/OQj822jKOKjVCNvRXMXj35S2texXIddfxsD7JCwTQ+gTFqOcrgYL
	c/exmPBfhl/gVc+2+IxvzoEY9eQKbtYA=
X-Gm-Gg: AR+sD11QQNYJqXZRKFeUUsc48gjLwX0hspm9Jtt//4Z0La4XArgdUTCssrN2PKt94d6
	cyeAyEp0eV4WyquQ1f8eYdENf9CJd7ewCZhtqFUujKrmwo+kkDqwRvSHTuguZQ9JtU60rJcg5OL
	wBnK/0qDOyahwR2j08L6h/EsFTDeeliioW7PXRUYH9KUgmHtEvrYP9FC0ncl58IUPratRiCPi1P
	15UFGwbtP20gj8g/RInLwYNM34J8fviJU3Mv1U2Ft4C6vrJuFWt0yF1SrpoZFJFZqSdBXBRHjJe
	jiOQvBQjYu61XMF9n9H0MD297pKQ1nI8sbBuELHLgq7OBvox73Ha4eZ5FaJcA9idejlBfKp9AmX
	nSa+noZZ9xgOI/N3MI8asc+9BJkKOOdM4SyQ4pnKi2g==
X-Received: by 2002:a05:6a00:4285:b0:848:64fc:510d with SMTP id
 d2e1a72fcca58-84ee48d5b62mr9781919b3a.45.1785779138765; Mon, 03 Aug 2026
 10:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260729083807.1588544-1-jolsa@kernel.org> <20260729083807.1588544-10-jolsa@kernel.org>
 <CAEf4BzYRzFH+n7Cj2jKpcG6LOZJMh7O38=R7MnoH2jFKxSG1Tg@mail.gmail.com>
 <amykPmjhfVJlAevL@krava> <CAEf4BzaWoB-RnBqa62X4pzM0PBvn21ZA_Fh3P9pWZ6s5_Hjoeg@mail.gmail.com>
 <anBFHILS3Ac-RmtT@krava>
In-Reply-To: <anBFHILS3Ac-RmtT@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 3 Aug 2026 10:45:22 -0700
X-Gm-Features: AUfX_mw0tO41utRll9kn6jAt1YTp7wCDrzYHzCES-z1uw3pAp5Xxzu6ELfpCEUo
Message-ID: <CAEf4BzapkhvCiAhPC-A7yYfYKn0cwcv3RTmJ8SCgn1+_WmNOMQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 09/11] bpf: Remove trace_in argument from __bpf_get_stack
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Quentin Monnet <qmo@kernel.org>, 
	Tao Chen <chen.dylane@linux.dev>, STAR Labs SG <info@starlabs.sg>, 
	Arnaud Lecomte <contact@arnaud-lcm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 12:37=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Jul 31, 2026 at 08:14:03AM -0700, Andrii Nakryiko wrote:
> > On Fri, Jul 31, 2026 at 6:33=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > >
> > > On Thu, Jul 30, 2026 at 04:06:14PM -0700, Andrii Nakryiko wrote:
> > >
> > > SNIP
> > >
> > > > >  BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_event_data_kern *, =
ctx,
> > > > >            void *, buf, u32, size, u64, flags)
> > > > >  {
> > > > > @@ -947,7 +970,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_=
event_data_kern *, ctx,
> > > > >         int err =3D -EINVAL;
> > > > >
> > > > >         if (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN))
> > > > > -               return __bpf_get_stack(regs, NULL, NULL, buf, siz=
e, flags, false /* !may_fault */);
> > > > > +               return __bpf_get_stack(regs, NULL, buf, size, fla=
gs, false /* !may_fault */);
> > > > >
> > > > >         if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER=
_STACK |
> > > > >                                BPF_F_USER_BUILD_ID)))
> > > > > @@ -966,7 +989,7 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_=
event_data_kern *, ctx,
> > > > >
> > > > >         if (kernel) {
> > > > >                 trace->nr =3D nr_kernel;
> > > >
> > > > this whole count_kernel_ip() logic above, why do we have it? I don'=
t
> > > > think we can have combined user and kernel stack trace, so how can =
we
> > > > end up with PERF_CONTEXT_USER "ip" at all? I might be missing
> > >
> > > the callchain comes from perf event's callchain and that can
> > > have both kernel and user part
> >
> > in general, but bpf_get_stack and bpf_get_stackid never request both
> > kernel and user stack trace in one go and we set add_mark to false, so
> > we can't have PERF_CONTEXT_USER, which is why I am asking what's the
> > deal with this nr_kernel calculation.
>
> it's the bpf_get_stack_pe helper for perf event and we store the
> callchain before we run bpf program in bpf_overflow_handler:
>
>   perf_prepare_sample(data, event, regs);
>    -> perf_sample_save_callchain
>       -> perf_callchain
>          -> get_perf_callchain(... add_mark=3Dtrue ..)
>
>   ret =3D bpf_prog_run(prog, &ctx);
>    -> bpf_get_stack_pe
>       -> trace =3D ctx->data->callchain
>
> the perf event setup is independent of bpf_get_stack execution,
> so you can have PERF_CONTEXT_USER in the callchain
>

oh, I didn't realize that's what happens, thanks, never mind then!

> jirka
>
>
> >
> > If it's unnecessary, we should just drop that part and not have that
> > extra unnecessary complication
> >
> > >
> > > > something subtle here, but can you please check again if this whole
> > > > trace->nr calculation/override is even necessary.
> > >
> > > as I wrote in the other reply I don't think we need to change
> > > trace->nr directly, just pass the needed nr/count as argument
> > >
> > > jirka
> > >
> > > >
> > > > > -               err =3D __bpf_get_stack(regs, NULL, trace, buf, s=
ize, flags, false /* !may_fault */);
> > > > > +               err =3D __bpf_get_stack_pe(trace, buf, size, flag=
s);
> > > > >
> > > > >         } else { /* user */
> > > > >                 u64 skip =3D flags & BPF_F_SKIP_FIELD_MASK;
> > > > > @@ -974,9 +997,8 @@ BPF_CALL_4(bpf_get_stack_pe, struct bpf_perf_=
event_data_kern *, ctx,
> > > > >                 skip +=3D nr_kernel;
> > > > >                 if (skip > BPF_F_SKIP_FIELD_MASK)
> > > > >                         goto clear;
> > > > > -
> > > > >                 flags =3D (flags & ~BPF_F_SKIP_FIELD_MASK) | skip=
;
> > > > > -               err =3D __bpf_get_stack(regs, NULL, trace, buf, s=
ize, flags, false /* !may_fault */);
> > > > > +               err =3D __bpf_get_stack_pe(trace, buf, size, flag=
s);
> > > > >         }
> > > > >
> > > > >         /* restore nr */
> > > > > --
> > > > > 2.54.0
> > > > >
