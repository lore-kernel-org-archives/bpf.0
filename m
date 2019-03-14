Return-Path: <SRS0=VVzb=RR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B67C43381
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 19:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA148217F5
	for <bpf@archiver.kernel.org>; Thu, 14 Mar 2019 19:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPyrYgC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfCNT2J (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 Mar 2019 15:28:09 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45539 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbfCNT2J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Mar 2019 15:28:09 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12so6185910otp.12;
        Thu, 14 Mar 2019 12:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ykekUB1l4ADChF+vKj9P8TR3yji7u6AAy+zFP4F3rtY=;
        b=KPyrYgC7tBeesC0k2Igtt8A0sjoTFqGkpi8M86SrXUA6N3Lp+Rc7bcBFMbJieof7nI
         VOzE5G9xZA/i5RpsficG5Fh02jsf1aL/bMsNenEpqXWnsN/FhRaJ7JHwXELq5mPBsTTK
         gr2eca6kZiNnUOiRG1mjs7laTCPXYUanNQ5O11+UPkeQYm4nkRPOq01W7LBA9JO8ch8B
         Wd12v/0nEA6XbSm+IhioWNRbm17/wqpOS4vVY5D06poL7v6qncAJBT0HvI1UqNkqha7W
         vlmVUpyK20RmnrHriK48DMmdjQivyP4oEi1YSTDv27CUK5sZ+wFeRXL+MvsLQaCFvitY
         sOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ykekUB1l4ADChF+vKj9P8TR3yji7u6AAy+zFP4F3rtY=;
        b=ql1J/vjzNuHxVM3m8dkQFzK2jtnPUZSJR6cuNSlQL7P8BmtOzHTKAtBOOnskF2vrsu
         N/CHp9Eu3b9NlIL9otB0q1UHvwby8eqMavk1gHXy9sc9lOl6xg+/r9MEpPVQELAYJQEV
         +5dE692CqASZwwN/UI5sJsrTANyW4UtOQQmYdfaGFOKC/8rAy/GT0qMm7aaWvjGbuZ2c
         RJORKePDz1hj6hUDF426qdDBE1BVPS6TLBVyuh3kjRKXxv2CPNeR+rw/BFqKMTfV+b0x
         IIO8r0J3uMO+qt5W2UEh7poM8qhpATvHKWc4vDguvcwqMejmUaoZpqTHWfgqHcaAI9rM
         OeQw==
X-Gm-Message-State: APjAAAUG/Q2IZnLX+kQhCRq1CPsgdFS9Xa+Cn6/JiD1qEbkleUPH0ufU
        R4j+zDtVS6JUrYdBMQyH20GZF73qg+Q514Dd9mc=
X-Google-Smtp-Source: APXvYqyt/3egGKnKdTfOSTWjRZeLYV+NZ5CXJw4SpPKrld7ApXXZ0xvdH7h7yTsV3OC+UE46yKyqMnNCQosQSxuAfrQ=
X-Received: by 2002:a9d:6649:: with SMTP id q9mr1640901otm.221.1552591687925;
 Thu, 14 Mar 2019 12:28:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190311215125.17793-1-daniel@iogearbox.net> <20190311215125.17793-3-daniel@iogearbox.net>
 <20190311230643.hpbcxczrq46hnn7r@ast-mbp>
In-Reply-To: <20190311230643.hpbcxczrq46hnn7r@ast-mbp>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Mar 2019 12:27:56 -0700
Message-ID: <CAEf4Bzb1yxgGYjLXnsUBgrAhi0+0GvHgPk4sgi6xEai9JbXMUw@mail.gmail.com>
Subject: Re: [PATCH rfc v3 bpf-next 2/9] bpf: add program side {rd,wr}only
 support for maps
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>,
        Joe Stringer <joe@wand.net.nz>,
        john fastabend <john.fastabend@gmail.com>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>, tgraf@suug.ch,
        lmb@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 11, 2019 at 4:06 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Mar 11, 2019 at 10:51:18PM +0100, Daniel Borkmann wrote:
> > This work adds two new map creation flags BPF_F_RDONLY_PROG
> > and BPF_F_WRONLY_PROG in order to allow for read-only or
> > write-only BPF maps from a BPF program side.
> >
> > Today we have BPF_F_RDONLY and BPF_F_WRONLY, but this only
> > applies to system call side, meaning the BPF program has full
> > read/write access to the map as usual while bpf(2) calls with
> > map fd can either only read or write into the map depending
> > on the flags. BPF_F_RDONLY_PROG and BPF_F_WRONLY_PROG allows
> > for the exact opposite such that verifier is going to reject
> > program loads if write into a read-only map or a read into a
> > write-only map is detected. For read-only map case also some
> > helpers are forbidden for programs that would alter the map
> > state such as map deletion, update, etc.
> >
> > We've enabled this generic map extension to various non-special
> > maps holding normal user data: array, hash, lru, lpm, local
> > storage, queue and stack. Further map types could be followed
> > up in future depending on use-case. Main use case here is to
> > forbid writes into .rodata map values from verifier side.
>
> I think WRONLY | WRONLY_PROG should be invalid combination?

Just curious, what about the cases of special arrays (e.g., at least
PROG_ARRAY). Is doing tail call a read from that map?

> Since these attributes are set at creation time and cannot be changed,
> nothing can ever read from it, so why write into it?
> Similarly RDONLY | RDONLY_PROG is invalid too?
>
> Also looking at the next patch and 'lock' command...
> May be it would be cleaner to do add WRONCE (from syscall) flag?
> Then for .rodata the attrs will be RDONLY_PROG | WRONCE
> and no 'lock' necessary.
> WRONCE_PROG probably doesn't make sense.
> Storing dangling task_struct pointer in the next patch doesn't look great.
> The whole 'lock' concept feels useful, but in the context of implementing
> .rodata it feels that WRONCE would be a better fit,
> since libbpf won't be able to make a mistake and forget to 'lock'.
> 'lock' syscall cmd can be confused with BPF_F_LOCK too.
>
