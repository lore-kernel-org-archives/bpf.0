Return-Path: <SRS0=bsNo=X2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99213ECE58A
	for <bpf@archiver.kernel.org>; Tue,  1 Oct 2019 19:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3104921783
	for <bpf@archiver.kernel.org>; Tue,  1 Oct 2019 19:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJY+aXpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbfJATms (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 1 Oct 2019 15:42:48 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34544 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfJATms (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Oct 2019 15:42:48 -0400
Received: by mail-qt1-f194.google.com with SMTP id 3so23223329qta.1;
        Tue, 01 Oct 2019 12:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=whqsh30XdZ9EyBnuZBXEM1EkoYG5j4Cfs1trI8cQppI=;
        b=IJY+aXpnq+8AV55vjz8eTmG1NM6pmelUL7D19BvdTpnv+uB9eWfNlwQVCmS25lGsoM
         HAYJwzIXF6I96RicvAH7QvK49y+VNH72sO0wDlnCx2TyS7mXMSYipD74B47zQEOIpv+A
         91fhM+3XMznZywnW3VD5/MEiRqqkjeupQgBI9a1vfayvrRcX173MuWZcYqvNTRsCyN7F
         T4a+W3ew3YXmNHkitFk1r3Lw0Op5E/uFumtoe0pCz8hNum6EvYyvofhfkg6L2IFW7i+O
         C5pDQ+YTGXljdy0z668eaxceknEmyAmyk6pmdQSmjVhvPcMkGNZPMWJQZmfNDtz+/Gov
         DoqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=whqsh30XdZ9EyBnuZBXEM1EkoYG5j4Cfs1trI8cQppI=;
        b=ivBuKIrOT9WpNMQkjUrxERQqBiMvV05GRuInDzbq491a/v9KEb5XoRu7zHOGTahwU6
         rQQI1UCodvXrip7/xl3yALo5+Cm2WjWcesZo+AuRvdbVXDiffyxHFL/X1sfOl+XTKoWr
         6poQGFQU2gNQ4h93ekeHWcwhqEvMp971tOFti7L0dYxONgoVnErlSx+OKXqLBbohuQq5
         22gqlIFrn5zIfUPA1y1m2zCM9owe2BMPx5lP6iL5lzACCMvqIoFCi8kET23jdIdeIc95
         6P+IQM6hhVHnFAa1AMca/PXg4kVaxcseW8gASUgBjMGXxCuRfIu0qeNVQz+b0a1mFA57
         pvvA==
X-Gm-Message-State: APjAAAVKssYsBdBTGwCGgKhHzMYJw87YHpjbVgvAlr4mOVF58iymeIpK
        1M01rzGrN2HSyHtUtWg2oHTfWqPnKS9VrKxJy5Xu02Ox
X-Google-Smtp-Source: APXvYqzb2kC1XlolvloPxSsUvFWXKatu//rY8FM4cPsQmJwkyvEKlFMyjgCQU76NcqY67/2pvntoEEEe0nPsjxyfrVE=
X-Received: by 2002:a0c:e48b:: with SMTP id n11mr27822275qvl.38.1569958966027;
 Tue, 01 Oct 2019 12:42:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190930185855.4115372-1-andriin@fb.com> <20190930185855.4115372-3-andriin@fb.com>
 <87d0fhvt4e.fsf@toke.dk>
In-Reply-To: <87d0fhvt4e.fsf@toke.dk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Oct 2019 12:42:34 -0700
Message-ID: <CAEf4Bza789NPSx0FksudY7J0D9Q-+EsTDvvAJXJyrcTNka=sag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/6] libbpf: move bpf_helpers.h, bpf_endian.h
 into libbpf
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 1, 2019 at 12:10 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
>
> > +struct bpf_map_def {
> > +     unsigned int type;
> > +     unsigned int key_size;
> > +     unsigned int value_size;
> > +     unsigned int max_entries;
> > +     unsigned int map_flags;
> > +     unsigned int inner_map_idx;
> > +     unsigned int numa_node;
> > +};
>
> Didn't we agree on no new bpf_map_def ABI in libbpf, and that all
> additions should be BTF-based?

Oh yes, we did, sorry, this is an oversight. I really appreciate you
pointing this out ;)
I'll go over bpf_helpers.h carefully and will double-check if we don't
have any other custom selftests-only stuff left there.

>
> -Toke
>
