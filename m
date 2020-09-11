Return-Path: <SRS0=Rse5=CU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3900FC43461
	for <bpf@archiver.kernel.org>; Fri, 11 Sep 2020 03:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA65A221E5
	for <bpf@archiver.kernel.org>; Fri, 11 Sep 2020 03:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HidU9/lI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgIKDTf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 10 Sep 2020 23:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIKDTe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Sep 2020 23:19:34 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB03C061573;
        Thu, 10 Sep 2020 20:19:33 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id w11so4734095lfn.2;
        Thu, 10 Sep 2020 20:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xrby8o/rJkPFJ4psrGcsvhqqPeSWcm4VzU7eRxl8TmI=;
        b=HidU9/lIKb9Lkv3gOgwuQN5e1O3UbcY7999Yk4lwC1yU4W49W+S22ZL2fp5SIsbdoG
         jlvhjYWY2g9ON3aZ+X8AR/5wednGzUqUBbcpuLIc7LgET7hkcTtI0OfhfEtp5GxA0x8H
         cw5OzWesaUMtbZYnLh7uLPwFyajICy9Xwimsz8bmm0mED2A98Bx/PZKj1KkdqlxxIu7n
         /iLjbgtH0idBRHi1dtb2CMJ0lpURIWwczUdx/4Zk+ishn0K4EbGzInvTms/mURwZ5v9h
         I7K1x5qkBTWc4NDCkeUdkFDvAycHSm4H9+JO6APAQIw3Qaz+ebQ8ZtoQaDlY5H6+g9kH
         7qOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Xrby8o/rJkPFJ4psrGcsvhqqPeSWcm4VzU7eRxl8TmI=;
        b=g9Vqf+WP0/36+cNjTSxn7gQ7o4ALET7MRBig4CJQnwd7ZeqbPE1wn/fVA0GevIacka
         SLs8/YnJ/UJe8gJna47xIaOAH8rUPXTqQVFfK9cc6yjXty7p0h37MpaGpn3Ea5Jrwt3V
         ikiEfCYwcvSBWn6g4dpZ3fLYqZ1kyn6GlSk4M/FUlWoo3cy6H4KA3XNXd6gJy6eFiWz8
         7EeDvQkRBEa9MNdAOmEYmdx5sYkMaq+QNDjci6pU00VSuJh5csil9z2tiU8OMYnaCuJZ
         AjEF9k2GNuzmEEUfJ/DTy3UqgzrXt6j+Uhsqw202WDVo/5W3yptUBnUUaoMbrQr5rKYs
         EQGQ==
X-Gm-Message-State: AOAM532udtwSW9F0kallMzYWBG2wp17CbqA/vlcvFWSjfeyqggXSLuKS
        QuBgzw/1z2cdY/+Eljt++u99mBTtJjiu/dAK5xI=
X-Google-Smtp-Source: ABdhPJwdBJAE7c7ldgxwlVglDiBo/5sHzNnX1ug+z/9QzVPLj+poSxYAxtdSipVGfd7RLt+OwDjZPlvjV4i3Bx3VVwk=
X-Received: by 2002:a19:df53:: with SMTP id q19mr5505910lfj.119.1599794372179;
 Thu, 10 Sep 2020 20:19:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200910225245.2896991-1-andriin@fb.com>
In-Reply-To: <20200910225245.2896991-1-andriin@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 10 Sep 2020 20:19:20 -0700
Message-ID: <CAADnVQ+vqiuFO_v60Xy+wDRM3Wu2R7226kfJZAdoN3jmR7gpQg@mail.gmail.com>
Subject: Re: [PATCH bpf] docs/bpf: fix ringbuf documentation
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Kernel Team <kernel-team@fb.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 3:53 PM Andrii Nakryiko <andriin@fb.com> wrote:
>
> Remove link to litmus tests that didn't make it to upstream. Fix ringbuf
> benchmark link.
>
> I wasn't able to test this with `make htmldocs`, unfortunately, because of
> Sphinx dependencies. But bench_ringbufs.c path is certainly correct now.
>
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Fixes: 97abb2b39682 ("docs/bpf: Add BPF ring buffer design notes")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied to bpf tree. Thanks
