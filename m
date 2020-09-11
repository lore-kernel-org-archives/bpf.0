Return-Path: <SRS0=Rse5=CU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5CCC43461
	for <bpf@archiver.kernel.org>; Fri, 11 Sep 2020 03:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B1B21941
	for <bpf@archiver.kernel.org>; Fri, 11 Sep 2020 03:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDLQ4IKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgIKDME (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKDMC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 23:12:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218E7C061573;
        Thu, 10 Sep 2020 20:12:02 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b19so10815049lji.11;
        Thu, 10 Sep 2020 20:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dK3VvtLyZK/3g6T+rsAYFG7yO1QdtGQ4d3qbfBl3VxE=;
        b=ZDLQ4IKA3k9Y0UAB8GkfGaXHEfXwIQApIu2p7HH8JMrQuAmiYYviegXd1Ky7ejhpBa
         X8W2asOrWY0tPHutt18v6NEQZ351uEOISwNkLDJ7sCSMnOU8j58Is+Rsqj8NCwrCHk0a
         OsdIN+kKaMEyOQ2LRle3cbeOWxhcnJt5Sdqb/gGtrVZeZQm7Vg1eqJUSFECM2A9kb/tA
         eH1qZwef7R09p6ScZuCyR9OJy5unPUQuVzPA4I/qLgBRND4lxEIwwwDQ1nv5rmwNa1tn
         5LAmv3l4PXXuHkSoKc3MJJ3/SHOJamYQZpK+LaKgTQYXSW/9PiymPbA3EDaDzBnff10x
         F47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dK3VvtLyZK/3g6T+rsAYFG7yO1QdtGQ4d3qbfBl3VxE=;
        b=UktVP38IFyoCmAwjFBxXHod+cbf/TbNyJ7+xZXCNaJb5NN3mP4VPnh+6c3Tl2jEvO6
         IRa/vj21myajTEyP9FrIUeTp/dk11L0xFJasDW7IqIFZJzd64tfLYVhhC6J4g07/DRBg
         b6kfEToBiJ6d7l3ae6BH7MUzQLzNAE3eSqGH9/cVQZb6tuwIwlET+NaPi541OeLV+9Ye
         IRKXF95qRuX67cx7HfU7iQUkhx/Cwt6bDK5uuv1jDuNfaOJ+cdJcXU0iB+klVvbifkMu
         Zq2zxSm1S3XvY27rfhyxiwv5y0IjxMT4BK7f6nEWC8JczCKJOrMiqRYDV/yH1zqj/2Cj
         Gg0A==
X-Gm-Message-State: AOAM530d5I++l56WexPed3jilMNAJ1k8dt7fO5n9GBNHe28HXa3VbQSF
        cti4owvBzpqsSJDPBnLo/OntT+Ifva+JMMsaCSG30idd
X-Google-Smtp-Source: ABdhPJzjOQfXydHSjAl2+uItwgpNdnzjusSTFhFtdGcqTS2L76OtHGiOKu6tlu4n+No0W353npcpfGS/O8nScWtYRbM=
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr6357308ljb.283.1599793920574;
 Thu, 10 Sep 2020 20:12:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200910203935.25304-1-quentin@isovalent.com>
In-Reply-To: <20200910203935.25304-1-quentin@isovalent.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 10 Sep 2020 20:11:49 -0700
Message-ID: <CAADnVQKV+RspEc25o2Up6CKA=tPD4TbzyR3GVOXnrsYsa5OPrA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] tools: bpftool: automate generation for "SEE
 ALSO" sections in man pages
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 1:39 PM Quentin Monnet <quentin@isovalent.com> wrote:
>
> The "SEE ALSO" sections of bpftool's manual pages refer to bpf(2),
> bpf-helpers(7), then all existing bpftool man pages (save the current
> one).
>
> This leads to nearly-identical lists being duplicated in all manual
> pages. Ideally, when a new page is created, all lists should be updated
> accordingly, but this has led to omissions and inconsistencies multiple
> times in the past.
>
> Let's take it out of the RST files and generate the "SEE ALSO" sections
> automatically in the Makefile when generating the man pages. The lists
> are not really useful in the RST anyway because all other pages are
> available in the same directory.
>
> v3:
> - Fix conflict with a previous patchset that introduced RST2MAN_OPTS
>   variable passed to rst2man.

Applied. Thanks
