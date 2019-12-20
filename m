Return-Path: <SRS0=eFnQ=2K=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED65C43603
	for <bpf@archiver.kernel.org>; Fri, 20 Dec 2019 08:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A212467F
	for <bpf@archiver.kernel.org>; Fri, 20 Dec 2019 08:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acp1z6EW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLTIZz (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:25:55 -0500
Received: from mail-qt1-f172.google.com ([209.85.160.172]:45778 "EHLO
        mail-qt1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLTIZz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 03:25:55 -0500
Received: by mail-qt1-f172.google.com with SMTP id l12so7503506qtq.12
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 00:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=1T8HA2aq9BJi1iiA/HgNEuqQ8HFk4ZzhQUPeK2hPtG0=;
        b=acp1z6EWcwuaewW0yD2922JYyBl8caBQllPlsMHurn21l6w2YGwo8AX4CggYuVfyxI
         zmDanH9qSnWe4DXzJ56hdLW17sCinureRcZ8bl8ePfKT5tp/fUE8dVxoMoO90eptOdr+
         p51f96V8ml1dFXNewldjxIPDeL7NM94Y19vf1OH3WEDEmGPQsY+ssKMe9eEUW/3DTXVl
         mxYLbKGtbYeG0mzUYjvmoW9Ad3VK3Hwd1y/PTGPDKGZKd3/hIziiKTQHO/+auL5RRkA4
         L26jcJCp542afRsYS9r2KktdyFmuZ6xLj3rC/rF2OyMWFzWGXz2nKWg6BOW9H2V1O/NP
         cW7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=1T8HA2aq9BJi1iiA/HgNEuqQ8HFk4ZzhQUPeK2hPtG0=;
        b=MlMaNQ2kfNavNDQ3ZhnC2K589nbvDf7cKr+PG7Z77mWMpuwfZXVJeEF/oehyR1xzof
         u64x/J1wyslhjcnyYmKQvFvpaC8hMkgCvf5hcnRK1oQQksA6aeCfNQxYhEJg/gSr9bBY
         JesQP8zBXvK1wBnRvJeezwyVs73S/3SmS0tdpMN6gGKu0++U8vhMMAH6CGH31gHMIUiS
         8OvJsCJAQbY2EtqqLyz8UOIcbH4Xyp5y/pFSZb2R8pglwMq1gJDlCA1/b5mP9PqiA9nP
         sOlmY+5sjyeTOKWONOaPRE/w9/9oQvbwnMk+swmx8Toeirw/DdvCyLPsfAqAqzakg+QN
         vefQ==
X-Gm-Message-State: APjAAAWUUokNlrZ5F/kBsO8oHXiC6LH/CmYwesPXL444+lx5dq4A6vwt
        E68HX3pB9Y0c5OhL88u1tcgmEwF9ajJzCIlaodRbQUEbimU=
X-Google-Smtp-Source: APXvYqxY0Y+o9NH0cqA4V8svWqg9DRsQkD11wMc2NqjZp+rJ//7InfyDxdudr2fers21C6z23ity5zUYmv0EbbOnrU4=
X-Received: by 2002:ac8:33a5:: with SMTP id c34mr10913547qtb.359.1576830354038;
 Fri, 20 Dec 2019 00:25:54 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Fri, 20 Dec 2019 09:25:43 +0100
Message-ID: <CAJ+HfNgNAzvdBw7gBJTCDQsne-HnWm90H50zNvXBSp4izbwFTA@mail.gmail.com>
Subject: Percpu variables, benchmarking, and performance weirdness
To:     bpf <bpf@vger.kernel.org>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I've been doing some benchmarking with AF_XDP, and more specific the
bpf_xdp_redirect_map() helper and xdp_do_redirect(). One thing that
puzzles me is that the percpu-variable accesses stands out.

I did a horrible hack that just accesses a regular global variable,
instead of the percpu struct bpf_redirect_info, and got a performance
boost from 22.7 Mpps to 23.8 Mpps with the rxdrop scenario from
xdpsock.

Have anyone else seen this? So, my question to the uarch/percpu folks
out there: Why are percpu accesses (%gs segment register) more
expensive than regular global variables in this scenario.

One way around that is changing BPF_PROG_RUN, and BPF_CALL_x to pass a
context (struct bpf_redirect_info) explicitly, and access that instead
of doing percpu access. That would be a pretty churny patch, and
before doing that it would be nice to understand why percpu stands out
performance-wise.


Cheers,
Bj=C3=B6rn
