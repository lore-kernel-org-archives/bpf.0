Return-Path: <SRS0=W4j7=SA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AED4C43381
	for <bpf@archiver.kernel.org>; Fri, 29 Mar 2019 19:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD24218A3
	for <bpf@archiver.kernel.org>; Fri, 29 Mar 2019 19:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCPN4gvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfC2TN7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 29 Mar 2019 15:13:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46051 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfC2TN7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Mar 2019 15:13:59 -0400
Received: by mail-lj1-f195.google.com with SMTP id y6so2892910ljd.12;
        Fri, 29 Mar 2019 12:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IjmaW/Wo53nk/RCs1iL8RSH7UACY/tTFlxbrfLdM4Wk=;
        b=GCPN4gvRHnQbcvG4HH8wXcD/WqCXlC0uWEDPgtdkGyrVIb3D6FMSZLNciBz1yl+YhE
         Z7UMHzWEPBqNSoBIRE80+59BG+Rv26dnkGYrqW1rW15Z04Lus21PFGv3MlGUh4R+jLx9
         fXWGFPI3ZseaBiK4sx+MD3aOWkee0U5ZteYex+xsRuQD8PkdHhOkNO0OPGDS2Xh9bpy+
         sKU8CXnfNVGT2Iyh2pnCwxnGkBh+eX39WFChFERsALew1I7LEcmQVj0jvdmzW8fcSvW5
         fk4t1q99G11U65A7cyRZbgLNEW69Epvl8XcGXazinUNbxPD4Qok8qAYTMac2EQdc5hq4
         a3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IjmaW/Wo53nk/RCs1iL8RSH7UACY/tTFlxbrfLdM4Wk=;
        b=WrqINB8x4BKAkXQQE/6JcVuDpXxX4ZGzlhcp+KJvg6xabaJp0ppsmAq+xIiWjWg1bJ
         eyX+jSqZLXIoC9RtkE7L69I9yd/2iDg3euFYFdtUaj9P1ra9bhUL90bR97rnVpU6wAuP
         cJKBOJ7cvU7feDp9giLNqEP0seSP8J9B7Tunfx7SXr/9HgqLYXWm8xXITjch1tDt28jr
         UvpCx+J15BQCtoLbBAsX02bEKtqg8UNrNR7T78X0RWSVb+oYhJrPLfJMxDpip5bW6LT+
         gPVvCqC9PzKv5kgCqd9HobdQL+V8GbKkpGSfz3bZEJWiO6cPl2KyVnCZ9g/p4Ju5eL4F
         t19w==
X-Gm-Message-State: APjAAAXowWzHLJ65UbuntEQYBohBXYn5gaercgb9iXvAXG8YbaTVAXlP
        2CXM3BHr4y9bRrRHNubYflGorU5LJj0n6gyg8y0=
X-Google-Smtp-Source: APXvYqwjjmHWN4ScV3zyyKnfEc94wCyvQPbwTDyf3ufY7GMVtuB//c9ramTdk4KRiVBsLqq+e6UdLEW8+8Z1uHp03ZU=
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr26459915ljk.78.1553886837185;
 Fri, 29 Mar 2019 12:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190329053053.3968514-1-yhs@fb.com>
In-Reply-To: <20190329053053.3968514-1-yhs@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 29 Mar 2019 12:13:45 -0700
Message-ID: <CAADnVQLL=enrrKixJRU=a6daGmj9TEKs-Qjx6yFRNusZPeRJHQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] [tools/bpf] add bpffs multi-dimensional array
 tests in test_btf
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 28, 2019 at 10:32 PM Yonghong Song <yhs@fb.com> wrote:
>
> For multiple dimensional arrays like below,
>   int a[2][3]
> both llvm and pahole generated one BTF_KIND_ARRAY type like
>   . element_type: int
>   . index_type: unsigned int
>   . number of elements: 6
>
> Such a collapsed BTF_KIND_ARRAY type will cause the divergence
> in BTF vs. the user code. In the compile-once-run-everywhere
> project, the header file is generated from BTF and used for bpf
> program, and the definition in the header file will be different
> from what user expects.
>
> But the kernel actually supports chained multi-dimensional array
> types properly. The above "int a[2][3]" can be represented as
>   Type #n:
>     . element_type: int
>     . index_type: unsigned int
>     . number of elements: 3
>   Type #(n+1):
>     . element_type: type #n
>     . index_type: unsigned int
>     . number of elements: 2
>
> The following llvm commit
>   https://reviews.llvm.org/rL357215
> also enables llvm to generated proper chained multi-dimensional arrays.
>
> The test_btf already has a raw test ("struct test #1") for chained
> multi-dimensional arrays. This patch added amended bpffs test for
> chained multi-dimensional arrays.
>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Applied. Thanks
