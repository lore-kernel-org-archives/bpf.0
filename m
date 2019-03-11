Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD0DC43381
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 17:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1581206DF
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 17:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhluMu/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfCKRju (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:39:50 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36181 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbfCKRju (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 13:39:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id t206so4352491oib.3;
        Mon, 11 Mar 2019 10:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TinCy7gTTtwRapjm0Slbtw08QVPPK+rWE0EvwRggH/Q=;
        b=WhluMu/t/yFmUbotu4mjgUWcVx4VcTHXzywSeEMKPg3z6yE0JZCxma+ZoKzCq4bKnt
         UrJL/P2cGja8bzwAQb198zPoSOJ1bIUbPDY/oHHIAlsBaw1WR3dlP6ekCNSrMsKuxzTj
         hjeyRh1Z3pZPfWvZX/9XhN4X+Jq2VxWlIYDSyPtqLIjAviDlmKrckvsWUuJdU3DG0cGu
         o6LfBxlNqq1xWfMLhv2AOBFQnBmxWLiKS90NzEa+IsJGKeeBiHRFbFEtRSQcD7/LXot/
         dBIh595OQnrWFLFf/3GX2S8w1lk1aqNhkDHq2/eFy4JEJyUtDL1YFpoHcQOhvFtWZC37
         rotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TinCy7gTTtwRapjm0Slbtw08QVPPK+rWE0EvwRggH/Q=;
        b=kTaN5CbJaiWrhHXwxIuy+a1xuR/p/5p52f3Wy7Hsfd4RfhIGnT5dB1qpuMoFp+gMrq
         BYn2svwujYdirm0RLdrl25XCFsOtBfauiIcQayG9V9gKpTCJCKO/FmCiXUtAZ9wjgC+I
         LXUGYoilEkv2u7JhU/nswCHJxXxu3UYNghbNn0p9kYEcklhi6myM9r6K7dQwBfdzAuXQ
         HPvfAwptwC/LhbEJaoxXDdOEhi+fZKo7w8YEVXpVt0bjeJfRS6Yzzb8b6IvzeYPBYKKl
         khvgdyTabOWsjX/AIiywJSeViaN1CB9zk3XOqhqi/ZhzITiUM8pBqjazOs+em/33KA+j
         OC7A==
X-Gm-Message-State: APjAAAW6NnHpPcuqxwwPClsdQnq2vtV9XvkJkRcSWG5Zm25MjJu883LU
        +d30mxYmkQD2fJI+UX5zxZDmwE4g5LDI/K40kVk=
X-Google-Smtp-Source: APXvYqwYnnF6Scri+HQFxhPZg7v5p1TYg2guPnClCNIh1lqXHxrGWCANmurqB4sWC7Zo1gx8ZhH4uuVt18gXCNR8djI=
X-Received: by 2002:aca:3ed4:: with SMTP id l203mr155749oia.88.1552325989005;
 Mon, 11 Mar 2019 10:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190311004410.3896503-1-andriin@fb.com> <20190311004410.3896503-2-andriin@fb.com>
 <755d4871-f8a1-ec31-02bf-87ffe82cdd56@fb.com> <CAEf4Bzbo1_mCN4wnGV+G8ombYPmSBNMQG7Qy8729Ji7HaKxV3Q@mail.gmail.com>
 <4e224736-5174-17e5-f388-6c34276c0c24@solarflare.com>
In-Reply-To: <4e224736-5174-17e5-f388-6c34276c0c24@solarflare.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 11 Mar 2019 10:39:37 -0700
Message-ID: <CAEf4BzZCotM8s+o9Aav_j2Yn3AJ2zvNcFtz=cE3GDWQUp9o9Rw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] btf: resolve enum fwds in btf_dedup
To:     Edward Cree <ecree@solarflare.com>
Cc:     Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 11, 2019 at 10:27 AM Edward Cree <ecree@solarflare.com> wrote:
>
> On 11/03/19 16:34, Andrii Nakryiko wrote:
> > The only thing we should consider is that enums can have different
> > sizes. And enum size is part of enum's forward declaration. So unlike
> > struct/union fwd, enum's fwd has extra info. I don't think it's
> > possible to specify in C (enum is always 4 bytes),
> Not always, see e.g. N1458 =C2=A76.7.2.2.4:

Yeah, you are right, sorry. I was mostly trying to point out that C
itself doesn't allow programmer to specify size, while C++ does.


> > Each enumerated type shall be compatible with char, a signed integer
> > type, or an unsigned integer type. The choice of type is implementation=
-
> > defined,=C2=B9=C2=B2=E2=81=B8=E2=81=BE but shall be capable of represen=
ting the values of all the
> > members of the enumeration. [...]
> The enumeration _constants_ have type int (=C2=A76.7.2.2.3), but the enum=
 type
> itself has implementation-defined size, per the above.
> C doesn't allow to forward-declare enumerators (=C2=A76.7.2.3.3), nor eve=
n to

There is a GCC extension that allows to forward-declare enums:
https://gcc.gnu.org/onlinedocs/gcc/Incomplete-Enums.html#Incomplete-Enums

Kernel actually has examples of using this (see patch description
regrading irqchip_irq_state).

> reference them from the enumerator-list in the declaration, since the
> enumerator type is incomplete until the closing brace (=C2=A76.7.2.2.4).
> Footnote 128 adds that "An implementation may delay the choice of which
> integer type until all enumeration constants have been seen."
> It appears, in any case, that no forward-declaration could be required in
> BTF, since an enum type's BTF record does not reference other types.  Wit=
h
> something like
>     enum foo {
>         BAR =3D sizeof(enum foo *),
>     };
> which is not valid C thanks to =C2=A76.7.2.3.3 (but many compilers will a=
ccept
> it, e.g. gcc without -pedantic), the BTF record would read
>     kind=3Denum name_off=3D&"foo" vlen=3D1
>         name_off=3D&"BAR" val=3D8
> (assuming 64-bit) which does not require any forward-declaring.
>
> I don't know about the C++ situation, though.

C++ allows to forward-declare enums only if as part of declaration you
also specify underlying integer type.

>
> -Ed
>
> PS: It's not really clear to me what the rationale for =C2=A76.7.2.3.3 is=
,
> since all the problems with incomplete enum types also arise with other
> incomplete types; why 'enum foo *' can't be treated like 'struct quux *'

Seems like GCC's extension allows exactly this.

> I don't know.  But this isn't comp.std.c...
