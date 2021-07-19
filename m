Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0AFC6377A
	for <bpf@archiver.kernel.org>; Tue, 20 Jul 2021 00:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82BF61222
	for <bpf@archiver.kernel.org>; Tue, 20 Jul 2021 00:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356699AbhGSXcX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 19 Jul 2021 19:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351025AbhGSWqW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 18:46:22 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47EAC061574
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 16:27:01 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v189so30311939ybg.3
        for <bpf@vger.kernel.org>; Mon, 19 Jul 2021 16:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dTZXTpgF2i2C0t8/kbGyjVPSkn7uNri2/0/lBwkeoeQ=;
        b=qCcm3nXAjTdFQ/kLVySjYD8F9zAqh6VcxPvLtkJwOP2x7/ArVmQO5OVgLtGEghdVDt
         IeAa+LJb8sDse72p97LHgWyJYx0pL5dJnjntbVTBy77zaUhOcH9KarxgvtSrQ2CVHr0M
         PjmOLlcSJJhGgHK84gcEwSTrfWH3gCmd/5J1SesHZPX5x2Q9/uf4xWS9TTroHv9EM+dC
         3NNMZJLRvUYD5Cv9ODmX5BWLV9PHCuMYJY0N4gIMOc2f8PQ6hmOa217Ylj9D7yfLrYsG
         GXia36bd2BNjHVfk7ZnyOttWXNntwRarWSXiX2gNAALiRgU0oMlRQuQkaeLtBRlHLBY0
         OZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTZXTpgF2i2C0t8/kbGyjVPSkn7uNri2/0/lBwkeoeQ=;
        b=VrMTtg0KOxPJj7bZmB+MtIUe/Qbgs5iCZgcwwAVY/Oi9Gmqz4s5yDWRzeqQmAKnY9S
         s2rBMSKY7EFP+0y2cb8HhZT5V3OuQCVJL1HEbSSFL9O6WkRqFWc4PfWWGVlyCiVYgeB0
         niceRQu13Fir5f0JlFDf4drd6Zv9wEpONIpETGnih40vCxVyLE8s0yhFuQ54TZMIEIo6
         X355nNLPGvuRUlFHORcAxvhVjNhNtTC4qC/OLulCo+mkM/Wr1T5YTDhClI6RJNBZr3BP
         +rCf9goDNEnTJ6O5xfAqmSw4Mf3pahbZwWxHgFuwI26GcxDDStlUP/OO5ggyMBIvySId
         pJ9w==
X-Gm-Message-State: AOAM531MUFIuK8zoCLHqBqJOAsADi7BCpTEaL2/Id+XzAr60n8tiIGZN
        nYLGBmFnGbBzMQjAovrJ8S4utz8UGj/qHmJrsGQ=
X-Google-Smtp-Source: ABdhPJzmB7pTs9XRhdDFscvG8yLdDXmfEyoLuMmJEDf+zk19YC+TEAsO0Fwz+3MtUx6byph5aAli8YtklnJd3SMEQn4=
X-Received: by 2002:a25:1455:: with SMTP id 82mr34364097ybu.403.1626737220956;
 Mon, 19 Jul 2021 16:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210429153043.3145478-1-joamaki@gmail.com>
In-Reply-To: <20210429153043.3145478-1-joamaki@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 19 Jul 2021 16:26:50 -0700
Message-ID: <CAEf4BzaSN+aN5RV=anaGewGAmqOWJRZpHtSeMfYcJ2HZ98LqLQ@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Rewrite test_tc_redirect.sh as prog_tests/tc_redirect.c
To:     Jussi Maki <joamaki@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 29, 2021 at 8:32 AM Jussi Maki <joamaki@gmail.com> wrote:
>
> Ports test_tc_redirect.sh to the test_progs framework and removes the
> old test. This makes it more in line with rest of the tests and makes
> it possible to run this test with vmtest.sh and under the bpf CI.
>
> Signed-off-by: Jussi Maki <joamaki@gmail.com>
> ---

Hey Jussi,

I noticed that running these new tc_redirect tests locally in my qemu
image were failing. I narrowed it down to `ping6` vs `ping -6`
differences. My image lacks ping6. I see that there were previous
attempts to gracefully handle them both:

da85d8bfd151 ("kselftests/bpf: use ping6 as the default ipv6 ping
binary when it exists")
deee2cae27d1 ("kselftests/bpf: use ping6 as the default ipv6 ping
binary if it exists")

(those are two different commits, yeah :) )

It seems the shell script version used to handle this more gracefully.
Can you please update the test to handle the lack of ping6 binary?

>  tools/testing/selftests/bpf/network_helpers.c |   2 +-
>  tools/testing/selftests/bpf/network_helpers.h |   1 +
>  .../selftests/bpf/prog_tests/tc_redirect.c    | 481 ++++++++++++++++++
>  .../selftests/bpf/progs/test_tc_neigh.c       |  33 +-
>  .../selftests/bpf/progs/test_tc_neigh_fib.c   |   9 +-
>  .../selftests/bpf/progs/test_tc_peer.c        |  33 +-
>  .../testing/selftests/bpf/test_tc_redirect.sh | 216 --------
>  7 files changed, 509 insertions(+), 266 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_redirect.c
>  delete mode 100755 tools/testing/selftests/bpf/test_tc_redirect.sh
>

[...]
