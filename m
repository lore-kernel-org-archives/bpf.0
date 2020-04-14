Return-Path: <SRS0=O1Al=56=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCD3C2BA19
	for <bpf@archiver.kernel.org>; Tue, 14 Apr 2020 18:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8581220575
	for <bpf@archiver.kernel.org>; Tue, 14 Apr 2020 18:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3c97Wg4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgDNS2g (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729648AbgDNS2c (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Apr 2020 14:28:32 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674CDC061A0C;
        Tue, 14 Apr 2020 11:28:32 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id 71so11022908qtc.12;
        Tue, 14 Apr 2020 11:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I6epiwiegMLOAMYG+VfYySaUuQBS1VUBIoTA9VYCi1c=;
        b=J3c97Wg41KdjaJIlmZCYdV9PYiBGibKDf9a7kgvbvO96W/kxKWAERZ1LKtYTuovT+M
         rtJL08PGYNXQIavtSPYcV0jOE4Mnl73x2gLpHS6Hr1BitBbA5mBRJZ5LkY2wW8p3A5b9
         E6rsYFgef5hydvpMpCw5MEtiPai1wyboofj01xgbG/Wy+Key710cmrTTZ5jS8ENqTzoy
         R4phvxg9HxyP/DP6FvEeMjuXjDU5C9VPS0X18H33VJmMXkOzLemJFFP+GGPhFwBXDZ+s
         EIqGtRM5F09JgS9UpeJPGgUmJVbR9O4ruIjBJYDjqhXjLAzpu1dT7oAhDtu36vVxT5Qr
         Dw+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I6epiwiegMLOAMYG+VfYySaUuQBS1VUBIoTA9VYCi1c=;
        b=GGRlPPjxtpa0VP6+p2f9M7be90Caw/NSTFbSqDsgWCan+bFFOtdUiKXFjJcgI29jWI
         zqb405qjd3obCKnzYtX+hKsxrfDqW1Yh/d+7N4yxLbc4Q24wvm/nzPpCB2BJR3ZJ7w0v
         sWXGHGnhMUEOt89OzAgcAyrcHSLkclQpU4+QqBaKBHVplOLFTAxuOQmBQdECXPfrj23C
         OkK1BafWyrBg0k9RCwArZBIKX4WQc6jeM+WRcFITw5XvF/scV8nrlMei9l9EBuDpIJnv
         Hkt+tb3QNskjLKMBh7iM4nm0XXoGo2hgYDCCfxuTjsokWwI4EcgGmDSlVzbr4q9YiHQO
         Yf5w==
X-Gm-Message-State: AGi0Pua+6nul/ePLy9ZW8fRcB5Lt5pXvpfRqyPdkxC8XRbZsu5+htwU1
        OikltIvCvtaFPuErhS7ScjQJCBkbgBTLvzdSIfk=
X-Google-Smtp-Source: APiQypJwQP/X4t6ldH3QVWxxIV1H3ZR8v5KMjkEncIGiBuxPfmuvrFLgZckennu6yH1gSK51uObngG8qVp0+xaNM0X4=
X-Received: by 2002:ac8:193d:: with SMTP id t58mr16378895qtj.93.1586888911629;
 Tue, 14 Apr 2020 11:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200410202613.3679837-1-andriin@fb.com> <CAG48ez1xuZyOLVkxsjburqjf3Tm4TR8X6pnavUf=pm_woAxLkw@mail.gmail.com>
In-Reply-To: <CAG48ez1xuZyOLVkxsjburqjf3Tm4TR8X6pnavUf=pm_woAxLkw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 14 Apr 2020 11:28:20 -0700
Message-ID: <CAEf4Bza2=_OM_yxu3FAyf=mRoDmQC6KmFQ-5qKu0bxxX0PkzgQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf 1/2] bpf: prevent re-mmap()'ing BPF map as writable
 for initially r/o mapping
To:     Jann Horn <jannh@google.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 14, 2020 at 9:58 AM Jann Horn <jannh@google.com> wrote:
>
> On Fri, Apr 10, 2020 at 10:26 PM Andrii Nakryiko <andriin@fb.com> wrote:
> > VM_MAYWRITE flag during initial memory mapping determines if already mmap()'ed
> > pages can be later remapped as writable ones through mprotect() call. To
> > prevent user application to rewrite contents of memory-mapped as read-only and
> > subsequently frozen BPF map, remove VM_MAYWRITE flag completely on initially
> > read-only mapping.
> >
> > Alternatively, we could treat any memory-mapping on unfrozen map as writable
> > and bump writecnt instead. But there is little legitimate reason to map
> > BPF map as read-only and then re-mmap() it as writable through mprotect(),
> > instead of just mmap()'ing it as read/write from the very beginning.
> >
> > Also, at the suggestion of Jann Horn, drop unnecessary refcounting in mmap
> > operations. We can just rely on VMA holding reference to BPF map's file
> > properly.
> >
> > Fixes: fc9702273e2e ("bpf: Add mmap() support for BPF_MAP_TYPE_ARRAY")
> > Reported-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>
> Reviewed-by: Jann Horn <jannh@google.com>
>
> (in the sense that I think this patch is good and correct, but does
> not fix the entire problem in the bigger picture)

I agree, we'll continue discussion on the other thread, but this
should be applied as a bug fix anyways.
