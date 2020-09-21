Return-Path: <SRS0=4c4M=C6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8711C4727D
	for <bpf@archiver.kernel.org>; Mon, 21 Sep 2020 23:08:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22A32388B
	for <bpf@archiver.kernel.org>; Mon, 21 Sep 2020 23:08:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r5sE+p/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgIUXIM (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 21 Sep 2020 19:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIUXIM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Sep 2020 19:08:12 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC26FC061755;
        Mon, 21 Sep 2020 16:08:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so10318231pgm.11;
        Mon, 21 Sep 2020 16:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBfBHyTFdB0GrrgRVq0oHDvf2JAuR+4dHuUo0HlID4Y=;
        b=r5sE+p/X8SNAElkJRkDSnQzx0S4DN0CDeKyfqmDxEhZlwvq/R+7k9LVFWChxQ9/Hga
         ryFDidiT4m48YQgSv9p5hPAY5WUyK0H4Jht8r+Q3cO7M2jQjVIfPEhnC71loez6a2ipq
         dMrBgyUI+nW3kxCM9zHIor/Xs9tIECIXv/a8JZ5gyMxb36AWnjPChH2H4S4IzCHmeIp3
         l5XL4wmCg4NI91dhdx/ZR4y/2cpik2xT17+wTpZwnU9x1kVRkPwFJoQtgY4xswu0Zbm/
         cm/r1o+7/VvvbTq3+smZGlsE5EQSp1p2Ec+rWQn0Y8KDSY709ebTYxieGwqfr17B1NaT
         EVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBfBHyTFdB0GrrgRVq0oHDvf2JAuR+4dHuUo0HlID4Y=;
        b=Vajx3+gjINcYQFKaqqnNL/WzKnAc2G0Ow39l9H8okTRf4YaJEmDcf9beU9+h9GejZb
         FuH4pgVFBiwz4PGyOd5CC8pLEWKdzqC+BSSGEXqsOzmpA2Bdmi4p+YGkS0eexUO4C2q1
         lf1RzLpWT1AP/isM7H9LTzJZxpb0JWQb3p4lOiSiRaJpdYjc+hjss/jVgKgENeUxOC6Y
         3Wi5BSz1ylnrftrqCFVTILNzcpFIrB711sYQv15/VPBrzUO7dxyEcMxYktqNsWzSEAWm
         AXQseDmUorQnGx70bM9ovWji0ZZL5HEaHsEsPGraJW6uPv2uI+tFAg3ZJv82qsT5RAyo
         Mv7A==
X-Gm-Message-State: AOAM5302LImbaqCDmpel4BKJ2Ve6eqsY3LSQTUd9v1UfYvlu4F05sGRB
        xaYawQotmMuqJ8PqgrPxgpHUOqvm2hqDV3E/rfw=
X-Google-Smtp-Source: ABdhPJwy4fPLgzwON5U2AO0MT+kd18TdzvBlPldd1/YW/sgykFmO9ubSe4y6iUOpS3BqvX1ZvjhjxEcbVPrH0iq/ghM=
X-Received: by 2002:a17:902:ed4b:b029:d1:cbfc:6382 with SMTP id
 y11-20020a170902ed4bb02900d1cbfc6382mr1911724plb.24.1600729691515; Mon, 21
 Sep 2020 16:08:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1600661418.git.yifeifz2@illinois.edu> <b792335294ee5598d0fb42702a49becbce2f925f.1600661419.git.yifeifz2@illinois.edu>
 <CAG48ez3k0_7Vev_O=uV_WVuUGK6BPA0RyrYXMYSDV4DTMMe26g@mail.gmail.com>
 <CABqSeAROcwq0ZGzWaxyPm+LDHu6T_8CD7_1c-hdhaMikr_ECCA@mail.gmail.com> <CAG48ez2HytqFaJ6V9iA6YZrbZU3kG4bB7nETMfHPt0-wd5D1jg@mail.gmail.com>
In-Reply-To: <CAG48ez2HytqFaJ6V9iA6YZrbZU3kG4bB7nETMfHPt0-wd5D1jg@mail.gmail.com>
From:   YiFei Zhu <zhuyifei1999@gmail.com>
Date:   Mon, 21 Sep 2020 18:08:00 -0500
Message-ID: <CABqSeAQDpJZdAD42myca=3BAGAJ9VyDjvEiXfcH+p3m4eo_vBw@mail.gmail.com>
Subject: Re: [RFC PATCH seccomp 2/2] seccomp/cache: Cache filter results that
 allow syscalls
To:     Jann Horn <jannh@google.com>
Cc:     Linux Containers <containers@lists.linux-foundation.org>,
        YiFei Zhu <yifeifz2@illinois.edu>, bpf <bpf@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Valentin Rothberg <vrothber@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 21, 2020 at 5:58 PM Jann Horn <jannh@google.com> wrote:
> > I do agree that an immutable bitmask is faster and easier to reason
> > about its correctness. However, I did not find the "code to statically
> > evaluate the filter for all syscall numbers" while reading seccomp.c.
> > Would you give me a pointer to that and I will see how to best make
> > use of it?
>
> I'm talking about the code you're adding in the other patch ("[RFC
> PATCH seccomp 1/2] seccomp/cache: Add "emulator" to check if filter is
> arg-dependent"). Sorry, that was a bit unclear.

I see, building an immutable accept bitmask when preparing and then
just use that when running it. I guess if the arch number issue is
resolved this should be more doable. Will do.

YiFei Zhu
