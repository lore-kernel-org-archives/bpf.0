Return-Path: <SRS0=Tx/Z=BP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A89EC433DF
	for <bpf@archiver.kernel.org>; Wed,  5 Aug 2020 06:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 027BE2076E
	for <bpf@archiver.kernel.org>; Wed,  5 Aug 2020 06:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ueJgf8jT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgHEGlu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEGlt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Aug 2020 02:41:49 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226B2C06174A;
        Tue,  4 Aug 2020 23:41:49 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id e187so10927680ybc.5;
        Tue, 04 Aug 2020 23:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RtKPIiS9RX/dfQ6JfvIaT/cXwdf0t1TspuGBAChmu4Y=;
        b=ueJgf8jTvzHKRkHTmo49u9pGuqIsru2vNCD8mForNML5XDwpXLE4voJ/dJ0Y5wpc/e
         nYT5xQONPM8lsQc+BGtCW4yfY7AaatgId1f+z9mOPwc+utmrCu3iQqsImTtRodzVTonr
         ZqUWzmIccu3H0+hyhO9MYq1Yv3JR2hyL66t0hQIVnU8ODus91EotiGSHmjR1FRz3CDmM
         xAq1h3EiXKiIColD9jgkP2UBj7ZWGnshfjFmlE7dWKZ7Y9Z/LVKknVqKEjuMkzo91BYq
         JcOuwgFKSm/sMDn/KZEPxYH7Phk10wa8ytZMbK1szi1bpCp2k9IFLxqFFyjwnceYrVrD
         hZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RtKPIiS9RX/dfQ6JfvIaT/cXwdf0t1TspuGBAChmu4Y=;
        b=raG50Gm4Aek1eFjo3ZmbKwJkYUMyMwBWGRmB9MKsynOPxP5M6/G8iBPpkpnN4ZG3Da
         jg4/a32whEWpTk8XKUjBcEWlWw9XEiTL3dVZZCg2eHyIsSFFidkSNB9TTA/XIUqf0HNf
         zjzTXj9W6DjpfFXJorbpFUfuV6NZqW+sSmLlPoG0lMGgot6czzcSAvapIuKI7XK2G7N+
         pxcXsoIkNZlpxMGYUES2Ci+i58EbQUgj2acMBjtzGH38s77ssz9dpMNsNPzXcW3PauQp
         YU6u12R/HQH1GD5y/0Fo+Bj7kjMdOXmALgCFaZeTG3Q8UjpgUtyjWgi7wfkBZP5P2yaj
         lR0w==
X-Gm-Message-State: AOAM531UnTOD8iq6xRk4h2jV2PFvycle8J737sag2kkGtUTJK/L0oSfv
        4Xjxp56VWZOSBrB/Eun1rIzbpoBEyTUcN6L6XZg=
X-Google-Smtp-Source: ABdhPJyittiuW3C/XlmJudOdG2ktxPXFQAlBs4qv86Cg3BtF6jeXdHv+Ig0hRw4HDeugHSaCBOkGLbQTM2DD7FAVMpM=
X-Received: by 2002:a25:ba0f:: with SMTP id t15mr2597442ybg.459.1596609707041;
 Tue, 04 Aug 2020 23:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200801170322.75218-1-jolsa@kernel.org> <20200801170322.75218-15-jolsa@kernel.org>
In-Reply-To: <20200801170322.75218-15-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 4 Aug 2020 23:41:35 -0700
Message-ID: <CAEf4BzbLn018RR_OPZmXQxJ0bJyfxA=xGxGEeMa=QGtqYZ0KJQ@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 14/14] selftests/bpf: Add set test to resolve_btfids
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 1, 2020 at 10:04 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding test to for sets resolve_btfids. We're checking that
> testing set gets properly resolved and sorted.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  .../selftests/bpf/prog_tests/resolve_btfids.c | 39 ++++++++++++++++++-
>  1 file changed, 38 insertions(+), 1 deletion(-)
>

[...]
