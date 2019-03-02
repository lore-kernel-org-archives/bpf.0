Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7A81C43381
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 00:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 999702083E
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 00:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knZhuhkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfCBA6U (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:58:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39089 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfCBA6U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 19:58:20 -0500
Received: by mail-lj1-f196.google.com with SMTP id g80so22010786ljg.6
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2019 16:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+oJBNelppwDgiInPbYRalXc8TY386WVpaYbvB9ckULY=;
        b=knZhuhkCv/mr9bzKxZKeD0hS6aG36Bwz3KYqukVbQiTIifqyC01dxu039B4xrZGhrU
         7lwNAHf6XXFZz3O27pCjrmz9jEFn22FsNVNrNfwffHaeLRgxyuvhgFSUKa/oSheWQeN8
         rltnYx95383xDY4jdLrLojvGs7f/lUrFz6kfToajQCnhsvUxMkIBdTOM3/6hAWiY0uUi
         DNSYKdFFtF0nXq/EiyeCXTVYX0e3DtcqMi/yhOgWT7xhOOeuY00itxHbzfI+0MRcVrVP
         31fVxj9AgNJJ7Stg3NQL6XD/8el2yTf6t6VWBq7+xPij6QigEVpPZSw+oV7MQ7IOryId
         7AXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+oJBNelppwDgiInPbYRalXc8TY386WVpaYbvB9ckULY=;
        b=pr2QNjpsvXKhIUMGL/KVfTHzmkr40w7Db7NLY+W3ojvoxC5ynxlK6nutOntNECB2FC
         y3PZYhE8hwzdPS/OgIoipCDFh7J4ZVZmSoerS5msOhaT2vF0jJPBa/+8XMVFSPtNT/ow
         hjeyDXrs2OUL4oPShsB/QqVRimoPW5fLzPWh59RETa0UFDc83FGbJwkG/RVRHF0BH5Hl
         rjYu9UZOhVnyTkl8WrnsKAt3xIDKV/5hNyb9qLdbuuRdUy/apiRDFwLjreIsluzNpZKr
         azL+pwFJlMErTkyH5W+Z16os262/kSYGswHxS7dK3L23NzmS3kUqWzBjGCC8Cm/Gya/N
         GmEQ==
X-Gm-Message-State: APjAAAVngHZs0YjaWQd/yYtO1t2LsFku95rI+GMTI+VHkoWksrvHGiyP
        ouex3j6lmgxk7IlomSQOZTe8LA2bTJkPELNJa4SKag==
X-Google-Smtp-Source: APXvYqz0BAS8AXAumb+NgDCEdJAcwYa0f/l1S+jfd6/R1yPF7Zi8Z+6j5ycrtBLk+xOZmMr0Asu7W2BOTEXY84YjnB8=
X-Received: by 2002:a2e:2285:: with SMTP id i127mr4351033lji.40.1551488298305;
 Fri, 01 Mar 2019 16:58:18 -0800 (PST)
MIME-Version: 1.0
References: <20190228232440.28668-1-sdf@google.com> <c3b9965e-b987-a36a-e870-d8f8bb804262@iogearbox.net>
In-Reply-To: <c3b9965e-b987-a36a-e870-d8f8bb804262@iogearbox.net>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 1 Mar 2019 16:58:06 -0800
Message-ID: <CAKH8qBufoc1rjiGN6-TDhuUZqd+ccUo98amLEOyHXhCMNEdovA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/7] selftests: bpf: break up test_progs
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Netdev <netdev@vger.kernel.org>, bpf@vger.kernel.org,
        David Miller <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 1, 2019 at 4:00 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 03/01/2019 12:24 AM, Stanislav Fomichev wrote:
> > Recently we had linux-next bpf/bpf-next conflict when we added new
> > functionality to the test_progs.c at the same location. Let's split
> > test_progs.c the same way we recently split test_verifier.c.
> >
> > I follow the same patten we did in commit 2dfb40121ee8 ("selftests: bpf:
> > prepare for break up of verifier tests") for verifier: create
> > scaffolding to support dedicated files and slowly move the tests into
> > separate files.
> >
> > The first patch adds scaffolding, subsequent patches move progs into
> > separate files.
> >
> > In theory, many of the standalone tests can be migrated to this new
> > framework as well. They get the benefit of common CHECK macro and
> > bpf_find_map function which a lot of standalone tests need to redefine.
> >
> > v2 changes:
> > * added cover letter, added more description about file structure
> >
> > Stanislav Fomichev (7):
> >   selftests: bpf: break up test_progs - preparations
> >   selftests: bpf: break up test_progs - pkt access
> >   selftests: bpf: break up test_progs - xdp
> >   selftests: bpf: break up test_progs - stackmap
> >   selftests: bpf: break up test_progs - tracepoint
> >   selftests: bpf: break up test_progs - spinlock
> >   selftests: bpf: break up test_progs - misc
>
> Looks good, thanks for bringing some structure into selftests! Series
> failed to apply cleanly on the last patch though:
>
> Switched to a new branch 'bpf-split-prog-tests'
> Applying: selftests: bpf: break up test_progs - preparations
> Applying: selftests: bpf: break up test_progs - pkt access
> Applying: selftests: bpf: break up test_progs - xdp
> Applying: selftests: bpf: break up test_progs - stackmap
> Applying: selftests: bpf: break up test_progs - tracepoint
> Applying: selftests: bpf: break up test_progs - spinlock
> Applying: selftests: bpf: break up test_progs - misc
> fatal: sha1 information is lacking or useless (tools/testing/selftests/bpf/test_progs.c).
> error: could not build fake ancestor
>
> Last commit in that file before this series is your ebace0e981b2
> ("selftests/bpf: use __bpf_constant_htons in test_prog.c for flow
> dissector"), please respin with a fresh rebase.
Ah, sorry about that, will respin later today.

> Thanks,
> Daniel
