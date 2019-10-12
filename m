Return-Path: <SRS0=4NqM=YF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35118C4360C
	for <bpf@archiver.kernel.org>; Sat, 12 Oct 2019 23:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 097702067B
	for <bpf@archiver.kernel.org>; Sat, 12 Oct 2019 23:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imy/VD+k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfJLXXD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 12 Oct 2019 19:23:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38729 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727262AbfJLXXD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Oct 2019 19:23:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id b20so13163180ljj.5;
        Sat, 12 Oct 2019 16:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gWm05V3+5OCUE1Jul6ruiUK3DxJYF/Ublixv6I9dc0w=;
        b=imy/VD+kfCiFAjojUZ9u4fs5Vz7R99RTm98cwix6r2fYCImv6f+htTTPDsjyMWLPHa
         2bjZt642F9cUBAxF0N7utgvILspyGqLgZJwQAsvcW39cIQyquaUi1uBqzRbuJ48TJHqF
         Wt2cbYH4iZJyt44S7LzCI2ZNiVQDtkz71QfMk1D7se2tKFj20zPF9KNHbrjjLoHTmnQ5
         OCPLcJlGlZTC7sb7f374HtCXghi5iHku8FWuiZ4Q41fPifNyCijN+P3LnaSekDFEpgwb
         TG+1HOm4WYmxQGR054xC+v7MxUEATx2VWoI/fvW6hj/wT3iJBwAwyWNj6NLANprqdIKD
         EQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gWm05V3+5OCUE1Jul6ruiUK3DxJYF/Ublixv6I9dc0w=;
        b=KclH9qcGWIxnfJQIChYe3K199kXNjXcBpp+l8cQj6sFL8da7jyMHHJ5i7A2V/mcpMb
         VEnLXnR+htM1ieUpNqzatWOpXMxRObf7MEyM2/oHSnUtFHSxZnFZW+KpR3nYcQzdM7VF
         LXLBY0DLkB+rWzzQVv+jURtGJ4yfuHs8G4asPYgxhGWdhNgUhXy+eV2Dg6xEJM11XGXG
         MC160cLIfJnmtRqQV6T5ND2lDqf+iiFlQn5W9q9gL+ozkJWE4YJa00nLsvzD5QpNloct
         INbv2mJU938ft9AKBBrW23SnAItxkWYkcn+34NN5mYk7+xSTRpPGUq18s4GzvvMy32x3
         cP7A==
X-Gm-Message-State: APjAAAWgI7D9WBAnK/bFa8n1c15lspMpZ4BAW9vYGrukmAzHL0zzGhKB
        Bhu/6xhQheiayvnABx4bDzmqgpX04o7bUCSOGIo=
X-Google-Smtp-Source: APXvYqzqEyzvA8foxjjpRs8hRVSVwht+Ck5ccPYv0wK4Yi5CETHwR43M8KLk0n42K/hApQe/NZurGehMlkTqLPxQlHo=
X-Received: by 2002:a2e:8197:: with SMTP id e23mr13684678ljg.228.1570922581191;
 Sat, 12 Oct 2019 16:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191011220146.3798961-1-andriin@fb.com> <20191012071526.lgrzyvyhnyvzh7ao@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20191012071526.lgrzyvyhnyvzh7ao@kafai-mbp.dhcp.thefacebook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 12 Oct 2019 16:22:49 -0700
Message-ID: <CAADnVQJ-__rn88Z1wgPsRdGdtyznG_rO3=kCx+7rSSENUE-dyw@mail.gmail.com>
Subject: Re: [Potential Spoof] [PATCH v2 bpf-next 0/2] selftests/bpf Makefile
 cleanup and fixes
To:     Martin Lau <kafai@fb.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Oct 12, 2019 at 12:25 AM Martin Lau <kafai@fb.com> wrote:
>
> On Fri, Oct 11, 2019 at 03:01:44PM -0700, Andrii Nakryiko wrote:
> > Patch #1 enforces libbpf build to have bpf_helper_defs.h ready before test BPF
> > programs are built.
> > Patch #2 drops obsolete BTF/pahole detection logic from Makefile.
> Acked-by: Martin KaFai Lau <kafai@fb.com>

Applied. Thanks
