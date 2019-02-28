Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875B1C43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA4C218CD
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6o4wy+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbfB1TT0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:19:26 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38406 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbfB1TTZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 14:19:25 -0500
Received: by mail-ot1-f66.google.com with SMTP id m1so18743022otf.5;
        Thu, 28 Feb 2019 11:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOduxGW1oMbubPrknhTIISLNzcddjeFP4fdBef7gCAw=;
        b=g6o4wy+X9V+dgg5tjoU0Y+LVT1DIK1cpdJPk7z7bTS7swDGMJiOiFaCllBj18xDFi1
         R9DDBb1xe1LDMCmxoY5k5Xd0BsQCw3LMl4Mz7Y9fsgIA4nLdhRMBR50rtMN507uRcXyI
         deNnDSHIsxMBEfKMf7pR+uKfsgGEJRR0U1/EwnsNzl6oUkYfrQPKuvyxPcUMKflYDM6l
         qRQtXq3G4WXYAMVW0vB2csvmC/3FerBwfmpp3szvCjfT/TdPEQFsdcZ0OnyQOSxfAIsr
         2DNAcORHG1Ub/olIGcKcn7ECBpLoKbT5lJVR9ISo6sk4ns1GNufDXVomuhYiO6nmOeeO
         DA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOduxGW1oMbubPrknhTIISLNzcddjeFP4fdBef7gCAw=;
        b=NwyiKDjExi+rVGoEnQkVwSRhdBQEHvMYZCp0Wh7d0IkBE2DXXZR0FXBVrgw02gmZie
         szwv0PU3pdqkxwFqezXeeSctM6AENuMmDdz010lrC9oWj6QEGaVln3thSeVrvhbrEEJY
         v9dr9cO4md8neO4R/SrhGsWrrVFFNyGBhGeeB9dLPTdV+aYKokiewmrkQhbE28hd6aSo
         INzhUdq2NsQJvaeTTe6vtFSJF9diu5/TJyANz2ey6bG3lODZKp1xxs7+Bttnh/fTzJaD
         k/YqMzfj3DDOCFrMEY5CjUh03nVRPg3K0Aq53kLj5TWifTR6S1fiaZqSuXwfioguhonl
         eAaw==
X-Gm-Message-State: APjAAAWcF740KUuWVE1OXPB2oWhTmwe7AHT48BMkJlgoof5WM5/+RWvs
        QM5Izbm0GCZX54Sn39Ib/w4dmIfTaqPiSkSnvRw=
X-Google-Smtp-Source: APXvYqz7GWvR/ERFzk+1GbaqOFJcCGHf9uCtZy7kSZOVvST/Iv2STAd1nVLt3UbQ6lGEwQd6f1h1RY5QmgrwilE8SeQ=
X-Received: by 2002:a9d:d88:: with SMTP id 8mr878242ots.164.1551381563992;
 Thu, 28 Feb 2019 11:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20190227224642.1069138-1-andriin@fb.com> <20190227224642.1069138-2-andriin@fb.com>
 <20190228185212.GH9508@kernel.org>
In-Reply-To: <20190228185212.GH9508@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Feb 2019 11:19:12 -0800
Message-ID: <CAEf4Bzb_Pe6bvvTi1+6toQsYZ+4u+CcBtunrYs6iDMGWznqCAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/5] selftests/bpf: fix btf_dedup testing code
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Kernel Team <kernel-team@fb.com>,
        Alexei Starovoitov <ast@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 28, 2019 at 10:52 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Feb 27, 2019 at 02:46:37PM -0800, Andrii Nakryiko escreveu:
> > btf_dedup testing code doesn't account for length of struct btf_header
> > when calculating the start of a string section. This patch fixes this
> > problem.
> >
> > Fixes: 49b57e0d01db ("tools/bpf: remove btf__get_strings() superseded by raw data API")
>
> I think this clarifies things, but a Fixes seems excessive, right? I.e.
> if you missed it in both sides of the (a != b) expression, the test will
> be just as valid.
>
> I say this because Fixes tags are now tracked and generates backporting
> efforts that sometimes end up causing unnecessary human exchanges when
> the patches don't apply because of some other patch.o

I think this is a legitimate fix. The bug wasn't exposed until I added
a new test from this patchset, but still. See below.

>
> Or is there some further use of 'test_strs' and 'expect_strs' further
> down that do_test_dedup() function?

Yes, few lines further down we use those pointers to iterate over all
strings in BTF string section and compare them:

        test_str_cur = test_strs;
        test_str_end = test_strs + test_hdr->str_len;
        expect_str_cur = expect_strs;
        expect_str_end = expect_strs + expect_hdr->str_len;
        while (test_str_cur < test_str_end && expect_str_cur < expect_str_end) {
                ... compare strings ...
        }

With this bug, what ended up happening was that we never tested last
sizeof(struct btf_header) bytes of string section. It worked fine for
existing tests by luck, but in general it would fail, because after
that loop we check that we finished iteration exactly where we should:

        if (CHECK(test_str_cur != test_str_end,
                  "test_str_cur:%p != test_str_end:%p",
                  test_str_cur, test_str_end)) {
                err = -1;
                goto done;
        }

New test I added didn't have lucky byte arrangement that made
test_str_cur == test_str_end true for previous tests.


>
> /me scratches head, probably missing something...
>
> - Arnaldo
>
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> > ---
> >  tools/testing/selftests/bpf/.gitignore | 1 +
> >  tools/testing/selftests/bpf/test_btf.c | 4 ++--
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
> > index e47168d1257d..3b74d23fffab 100644
> > --- a/tools/testing/selftests/bpf/.gitignore
> > +++ b/tools/testing/selftests/bpf/.gitignore
> > @@ -14,6 +14,7 @@ feature
> >  test_libbpf_open
> >  test_sock
> >  test_sock_addr
> > +test_sock_fields
> >  urandom_read
> >  test_btf
> >  test_sockmap
> > diff --git a/tools/testing/selftests/bpf/test_btf.c b/tools/testing/selftests/bpf/test_btf.c
> > index 02d314383a9c..1426c0a905c8 100644
> > --- a/tools/testing/selftests/bpf/test_btf.c
> > +++ b/tools/testing/selftests/bpf/test_btf.c
> > @@ -5936,9 +5936,9 @@ static int do_test_dedup(unsigned int test_num)
> >       }
> >
> >       test_hdr = test_btf_data;
> > -     test_strs = test_btf_data + test_hdr->str_off;
> > +     test_strs = test_btf_data + sizeof(*test_hdr) + test_hdr->str_off;
> >       expect_hdr = expect_btf_data;
> > -     expect_strs = expect_btf_data + expect_hdr->str_off;
> > +     expect_strs = expect_btf_data + sizeof(*test_hdr) + expect_hdr->str_off;
> >       if (CHECK(test_hdr->str_len != expect_hdr->str_len,
> >                 "test_hdr->str_len:%u != expect_hdr->str_len:%u",
> >                 test_hdr->str_len, expect_hdr->str_len)) {
> > --
> > 2.17.1
>
> --
>
> - Arnaldo
