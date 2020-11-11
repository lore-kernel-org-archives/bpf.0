Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FAEC56201
	for <bpf@archiver.kernel.org>; Wed, 11 Nov 2020 20:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6F9207F7
	for <bpf@archiver.kernel.org>; Wed, 11 Nov 2020 20:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlqWcA8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgKKUJm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 11 Nov 2020 15:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgKKUJl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 15:09:41 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A052C0613D1;
        Wed, 11 Nov 2020 12:09:41 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id s9so3457257ljo.11;
        Wed, 11 Nov 2020 12:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4O7dSv7r4Y+yU7mfsrBZpH53JVwwJEULvzPK+mdVFIE=;
        b=XlqWcA8DhRwktzmxBPb/iE3IxyUjR9AJGVlo5r0JnozVklxfEGotAJF330qlcQu+IE
         QdweCk5JWswpsruq7wzGkqdM7kjFp9bnALItr3jNfXRNdl1dcC0ypiLjtlLCVOIBr/vL
         y00xw18fWX7rkg/sskMoXq/V1cQOYR3PypAUIczJvQfFfUAAc3rr7Xn4z1kGRwBuS6Iq
         Zz0jwaMv1xn0C4Quo4cUS7hFfWjFvNgg47S30f2qS8FTmzD2ppbUMocIvIJSpOGhCqBJ
         KSwmPkRKhogH5LczgpvSMTMm3oK1WpgAtoegio5YiwK1hW12dBjnxomOoS8zKhw2pbCR
         vEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4O7dSv7r4Y+yU7mfsrBZpH53JVwwJEULvzPK+mdVFIE=;
        b=oUscersPxIvjDKrCq8FTK693TSbBnFGbpAafsv2khM3UIZztPZbuIZqsi8Nfb8t1cJ
         IPHnv0GzwfH9e4mVUnuMn5rJBo41XzmMx8NwimLCutg2y72LGxQ+EpeQ0706/MTFrDEG
         1N61pycwB7IPD5YgA9yALX9Ql8/3yrR+JUonIEQbMk7wtzGO5fGfQtnhdZ9Rwb3+/SIW
         +4NBgUBCBBHeT2usA/yRo99EjLC6WuFVzx2U6mmeE7rY9wXFF1OXvUhA3JEzSH3AJ3Cp
         0zKGAv0bgfM76I4kHLyaA/vyDj9rbM777EVm7CAyKQf1ANnopeu7boG1+gQ/sTKy1Cr7
         2bCg==
X-Gm-Message-State: AOAM530fq7yPjZtMK6ZZzYt8hhMzioRKNqldeZFIeQweUME3g2aMpnK7
        QZn1zou2JzeYl45Uz2WjxOTBdGu1s0eyuPViSo4=
X-Google-Smtp-Source: ABdhPJzYvAxIp1NAWZOJe0fM1XXjCQhyxh6CkHlH6qoTW6FAHl4lhFJ35t7CgU8UeUEmCt+M4Sf1/cloNYAyqQUfbBE=
X-Received: by 2002:a05:651c:1205:: with SMTP id i5mr11962786lja.283.1605125378319;
 Wed, 11 Nov 2020 12:09:38 -0800 (PST)
MIME-Version: 1.0
References: <20201110154017.482352-1-jolsa@kernel.org> <2a71a0b4-b5de-e9fb-bacc-3636e16245c5@iogearbox.net>
 <20201111123738.GE355344@kernel.org> <20201111123820.GF355344@kernel.org>
In-Reply-To: <20201111123820.GF355344@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 11 Nov 2020 12:09:26 -0800
Message-ID: <CAADnVQ+A-+jAbDiJV-qe53SjJ+zGeqcV5owZ3S7RNKMMYirVBw@mail.gmail.com>
Subject: Re: [PATCHv6 bpf] bpf: Move iterator functions into special init section
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 11, 2020 at 4:38 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Nov 11, 2020 at 09:37:38AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Nov 11, 2020 at 12:26:29PM +0100, Daniel Borkmann escreveu:
> > > On 11/10/20 4:40 PM, Jiri Olsa wrote:
> > > > With upcoming changes to pahole, that change the way how and
> > > > which kernel functions are stored in BTF data, we need a way
> > > > to recognize iterator functions.
> > > >
> > > > Iterator functions need to be in BTF data, but have no real
> > > > body and are currently placed in .init.text section, so they
> > > > are freed after kernel init and are filtered out of BTF data
> > > > because of that.
> > > >
> > > > The solution is to place these functions under new section:
> > > >    .init.bpf.preserve_type
> > > >
> > > > And add 2 new symbols to mark that area:
> > > >    __init_bpf_preserve_type_begin
> > > >    __init_bpf_preserve_type_end
> > > >
> > > > The code in pahole responsible for picking up the functions will
> > > > be able to recognize functions from this section and add them to
> > > > the BTF data and filter out all other .init.text functions.
> > > >
> > > > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > > > Suggested-by: Yonghong Song <yhs@fb.com>
> > > > Signed-off-by: Jiri Olsa <jolsa@redhat.com>
> > >
> > > LGTM, applied, thanks! Also added a reference to the pahole commit
> >
> > Applied to what branch? I'm trying to test it now :-)
>
> Nevermind, bpf/master, I was looking at bpf-next/master.

I've dropped this patch from bpf tree.
I think we need to agree on the whole approach first.
This filtering based on section name with special handling in pahole doesn't
feel like solid long term direction.
I think we have to brainstorm more on it.
I'm not saying we will not go back to a special section approach.
This revert is only buying us time to discuss what's the right path here.
Mainly I reverted to unbreak bpf tree CI which currently fails due to
two tests in test_progs
failing with the latest pahole and this patch.
