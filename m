Return-Path: <SRS0=lSwV=ZK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38C64C432C0
	for <bpf@archiver.kernel.org>; Mon, 18 Nov 2019 20:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DFC214DE
	for <bpf@archiver.kernel.org>; Mon, 18 Nov 2019 20:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/6bQJBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfKRULo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 18 Nov 2019 15:11:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35402 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfKRULo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Nov 2019 15:11:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id n4so21763902qte.2;
        Mon, 18 Nov 2019 12:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OwNqsptRcRe3hbNv2GLcmIi41EqiqihjL4TXY6PCZs4=;
        b=H/6bQJBBWTpAdWbGf9Jl//DTijcIdU2Fq5FkizaFzWh7YtxiDbNk+uDh5fxQWR3vED
         KLZf8CFKBYJ6TZF5PPOQXATSUfaQo9FSL7+SaJ06rRBayK4keeKiEnlkc0RiUzdsC8/H
         q1o5TumQkeICa/x+k4Nje8b39+nm5eC6LRz7Igfdb3ldxEov4G1M1pxjwhVRzEDxy5YQ
         qNPYoehHFrVniBa0rditVkK90cdUMWpsh3KKOiiU4H9gKPKrVNRozThp6taXoIXoHWnA
         ABzcVJVJ33BYvWnlIXFlanFsDB594UNYjwa9Y33qd6+eFCUcdBkcTIpKEwb5Ntc8wCW9
         v2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OwNqsptRcRe3hbNv2GLcmIi41EqiqihjL4TXY6PCZs4=;
        b=Tvz8QW/Y3AE9yj9I1WXzsdyyzo24WnypxCjJAucuDC4ovzNcxW6RqL39aT9gky17V4
         xq7hYAyduHVCZFU1vye3ixW0xCNO2nXGK2fbCoqbr6/oxEdnO2bgnP09i88soyw6hgzN
         8jr7dko7qMFIVsW/6qimy1EM+kPiQJxGolm5n0xqNzSIRiJQBOANLgT4iPfR5xqvej0V
         /MkRIkp0mr4/2R+i5Mdh+Pv56e16JlnLZRfStMCIpBCZVClr4JrbPugSlZ3OAZ95Y38h
         mBSuR9ShMwjyEXnDbqufLO5HRir5o1EXDZOOVTIERK8fQh0Halvv5SEIGELper1ISc1e
         Y6RA==
X-Gm-Message-State: APjAAAV3XJuFlMYryVRhVHMuuphNhR6y4TXrvcgEGy8ZThKDmIOJqEvD
        crOVk28nSqVBDIxUusDFe70N/cQWOto5539oj/s=
X-Google-Smtp-Source: APXvYqyKHHDQ/JhbcS60pSoKKwb2H/+N25DeZ6Mo2Uu4MhfvwuFS43N3KFZSo3CjYMRaEE9AjsHNFymXKE5VMyC37tU=
X-Received: by 2002:ac8:3968:: with SMTP id t37mr28916940qtb.37.1574107903380;
 Mon, 18 Nov 2019 12:11:43 -0800 (PST)
MIME-Version: 1.0
References: <20191113204737.31623-1-bjorn.topel@gmail.com> <20191113204737.31623-3-bjorn.topel@gmail.com>
 <CAEf4BzZw+jX13JuiVueKhpufQ9qHEBc0xYtqKdhhUV00afx0Gw@mail.gmail.com>
In-Reply-To: <CAEf4BzZw+jX13JuiVueKhpufQ9qHEBc0xYtqKdhhUV00afx0Gw@mail.gmail.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Mon, 18 Nov 2019 21:11:32 +0100
Message-ID: <CAJ+HfNjQkno=iOWherDMuxAVyA=Ku925o25dAYbqQQTrJN_n5g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/4] bpf: introduce BPF dispatcher
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 18 Nov 2019 at 20:36, Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
[...]
> > +       sort(&ips[0], num_progs, sizeof(ips[i]), cmp_ips, NULL);
>
> nit: sizeof(ips[i]) looks weird...
>

Ick! Thanks for spotting.

> > +       return emit_bpf_dispatcher(&prog, 0, num_progs - 1, &ips[0], fa=
llback);
> > +}
> > +
> >  struct x64_jit_data {
> >         struct bpf_binary_header *header;
> >         int *addrs;
>
> [...]
>
> > +
> > +static int bpf_dispatcher_add_prog(struct bpf_dispatcher *d,
> > +                                  struct bpf_prog *prog)
> > +{
> > +       struct bpf_prog **entry =3D NULL;
> > +       int i, err =3D 0;
> > +
> > +       if (d->num_progs =3D=3D BPF_DISPATCHER_MAX)
> > +               return err;
>
> err =3D=3D 0, not what you want, probably
>

No, the error handling in this RFC is bad. I'll fix that in the patch prope=
r!

[...]
> > +static void bpf_dispatcher_remove_prog(struct bpf_dispatcher *d,
> > +                                      struct bpf_prog *prog)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < BPF_DISPATCHER_MAX; i++) {
> > +               if (d->progs[i] =3D=3D prog) {
> > +                       bpf_prog_put(prog);
> > +                       d->progs[i] =3D NULL;
> > +                       d->num_progs--;
>
> instead of allowing holes, why not swap removed prog with the last on
> in d->progs?
>

Yeah, holes is a no go. I'll redo that.

[...]

> > +
> > +       WARN_ON(bpf_dispatcher_update(d));
>
> shouldn't dispatcher be removed from the list before freed? It seems
> like handling dispatches freeing is better done here explicitly (and
> you won't need to leave a NB remark)
>

I agree. Let's make that explicit. I'll send out a patch proper in a day or=
 two.

Thanks for looking at the code, Andrii!


Bj=C3=B6rn
