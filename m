Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E5FBC43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 20:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 498AF2087C
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 20:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mo0sHffx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfBYUvb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:51:31 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37203 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbfBYUva (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 15:51:30 -0500
Received: by mail-oi1-f193.google.com with SMTP id w66so8469440oia.4;
        Mon, 25 Feb 2019 12:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZZQP1sLuZQFzgrypT9KASViFxH9yS3J43oFu9SAZdlw=;
        b=Mo0sHffxPzny1aMWsYYY0dQi4CQbZSDDUHN3B13tn/Ieszoy0PuPFRd+s3eqe+pfI6
         TPDulFhObnOT+JuQ+bTiwNwZpRawNl4o8JHzvYJHNu94WliBAQXleijpKjPO4jYnaR45
         JmgK40zyXkgWpGmZu6HxvxRQb/jO+PRkCdCwsarumIFRJ00brKSJMT4aqRuL1jmogFb1
         MEc8XJl/1ky5ZzcNlwjoV/kcqTT54AGiCYmnkEy49hy2SiMSop28ONpW+OWVXQEcxV45
         zKdfMhdieM2uupIpi00UgueqGtuGcTwZrOBYrbjxoF0rHwCOZo69gAaaqMjxKucceXCp
         Ma1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZZQP1sLuZQFzgrypT9KASViFxH9yS3J43oFu9SAZdlw=;
        b=NbHxRdpXCN6Evc+LOYIm5S08xgv/BjRj3vrWYMijOKyf99fj+lx8IyFTFoQw3CED46
         1EGfqNPzNQhRTc5Qr3CWWx7VdZmL4X5G8Dmtr5TqxVI/qdAct8chfP3IeSfDHIGY4dBy
         +I662//NsP0QfyPkSyO00UgOzLiWiEcEg/uFgq3A1LSAIReL/D8nIoZHFsIDUNpZavrC
         SoMauZ5RTT2pL8nSSh1+DkUXiaq1UrqkzywloPIhXhLS6QmP3PPcWYCAgxXy9Wxdxwu9
         I2yAK+s1NIigKDoWwnCG+dFapAmIPHCDkDxcBmAxjxlOF4iOXAzw9/0YBd74ITc1ySlT
         mSUg==
X-Gm-Message-State: AHQUAuaw9je98Eqv4COSLM7Hfk+aiK+yi7sJx6FyqWeu7T1Xz+b0fqOA
        m68wsdXlx2c5xdIPIhodadgTCCd0JR4XrDl1tJU=
X-Google-Smtp-Source: AHgI3IYGGVhlbSuM32ni971s71PTAFinkJxKfM4wEX44G8mj3Jc1aQUG9+A3tXfQlx3G0XaQifP9GEj1/ERDsLn3iko=
X-Received: by 2002:aca:60c1:: with SMTP id u184mr149774oib.45.1551127889068;
 Mon, 25 Feb 2019 12:51:29 -0800 (PST)
MIME-Version: 1.0
References: <20190220205732.2514975-1-andriin@fb.com> <20190222220243.GI26132@kernel.org>
 <CAEf4BzYoJgxYWX9iS7pda62cnGr5VOC70NGgqPurMNWP_w1daA@mail.gmail.com>
 <20190225160239.GR31136@kernel.org> <20190225185949.GT31136@kernel.org>
 <CAEf4BzZjnvw9yDKst1xU4PkkcUuPh2Q2Oep=B1jhWSWoO6cgWg@mail.gmail.com> <20190225200822.GB13100@kernel.org>
In-Reply-To: <20190225200822.GB13100@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Feb 2019 12:51:17 -0800
Message-ID: <CAEf4Bzb9rT8ohHtMBNdsYrkv9BDsjN-0TU5WDQqmG0j4rz3hGw@mail.gmail.com>
Subject: Re: encoding BTF on glibc was: Re: [PATCH pahole 0/3] fix handling of
 bitfields in btf_loader
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 25, 2019 at 12:08 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Mon, Feb 25, 2019 at 11:42:29AM -0800, Andrii Nakryiko escreveu:
> > On Mon, Feb 25, 2019 at 11:00 AM Arnaldo Carvalho de Melo> <arnaldo.melo@gmail.com> wrote:
>
> > > Em Mon, Feb 25, 2019 at 01:02:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > So yeah, the BTF encoder/decoder is working just fine, the problem is in
> > > > pahole's DWARF code, lemme see...
> > >
> > > Please try the patch below, for me btfdiff continues to show no diff for
> > > all types in my vmlinux and now it also produces the same output for
> > > when the first element of a bitfield has its bit_size equal to its
> > > byte_size * 8:
> >
> > Yes, this fixes all the issues I've seen. btfdiff output is now empty
> > for my kernel image. Thanks for quick fix!
> >
> > Reviewed-by: Andrii Nakryiko <andriin@fb.com>
>
> Thanks, just for some extra testing I tried encoding BTF for glibc 2.28:
>
> [acme@quaco pahole]$ pahole -JV libc-2.28.so.debug
> <BIG snip>

<snip>

> [386075] INT long unsigned int size=8 bit_offset=0 nr_bits=64 encoding=(none)
> Cannot open libc-2.28.so.debug
> Failed to encode BTF

I've tried the same on libc-2.26.so.debug and it worked.

It failes after BTF encoding and deduping is done, exactly when it
tries to re-open libc-2.28.so.debug to write out new contents. Not
sure why it would fail, as it seems to be just plain open() call, but
the fact that we both can repro this means there is something there.

It also seems that libc-2.28.so.debug is corrupted:

$ readelf -n /home/andriin/local/btf/libc-2.26.so.debug | grep
'Unknown note type' | wc -l
0
$ readelf -n /home/andriin/local/btf/libc-2.28.so.debug | grep
'Unknown note type' | wc -l
17953

> [acme@quaco pahole]$
