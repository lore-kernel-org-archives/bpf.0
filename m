Return-Path: <SRS0=QOwA=AE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189EEC433E0
	for <bpf@archiver.kernel.org>; Tue, 23 Jun 2020 07:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E60752072E
	for <bpf@archiver.kernel.org>; Tue, 23 Jun 2020 07:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIQMGLF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgFWH1S (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731145AbgFWH1R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 03:27:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9BBC061573;
        Tue, 23 Jun 2020 00:27:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id y20so2070304wmi.2;
        Tue, 23 Jun 2020 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YSf1VMixS4/MhdwnpIJAY01v6Njpn3cj81WloMPQ2nM=;
        b=tIQMGLF0oaj7fV5xjzTUfIHHdYV6QIpPUavaOYOyVNiRBoOzMv4tysRDd42CcCuSqq
         XS6beEy7yYXCi1tQcr8Vl2BwsNnS6vRUImfkGGUIeiWLKLGh6KqBuwLqMbcCSVJpI99z
         zndVY+xaIwAcsbRJf3SpcgbESTSGyBWoSH0b4vxhHNB+VIbrHVcfp4fBc4UbQvqzkzIq
         FDdKMjfDCJAv05ZgctMec9UTivJeiFMJZylbpeZBleo2DdFO/QFHrgGMwnuhPa/Fu8eq
         4wVIsepnnfGEYY2pCaLwbq/DeIapMMCsOpwh3O+iTK3JeYJOKANB6gxmjtZszYGefQ/u
         9gXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YSf1VMixS4/MhdwnpIJAY01v6Njpn3cj81WloMPQ2nM=;
        b=WFGjxjCxPSbFUlywz6ID5/4rpjtg9tSxSbEt+sYTp1A2O9DGj1GrChrfHhi6zv8MPN
         9o8jn7nNVX3qDicLlF3f9aMDL/MLyy5G2u2lbRyXIzG6Kq/q7U8ohCNzcbULjGWqjTGR
         YOEqdL/vKJZ5eVm6SKMvJ1yCl70Y28Q3i2BKjnk7TKWKVF3abl7J9ZuHtFRMlTwyOAaT
         7m4ObuqPBoRi5sdao+w09nbFbaPCqnlOWjxwl4PAx7vc3LDhi8QV8w8wMPmOAD4b9qLZ
         BhlLPRsei7Ucwx4aCGvs7vg5CEqDGZKAkqQcfAFDlDIsOOXhUdC4qeIA0wPCMgmHEuVj
         LNXQ==
X-Gm-Message-State: AOAM531CtNfDICywPUhxHZFFLCQ5frSOGovak7itpBUV2Gv8eQXKLn3s
        JCiWPbTlQ3UyGH/SgM2+QFtn6WpXa8hSwUcHlfs=
X-Google-Smtp-Source: ABdhPJyKnBFpSUFzuIaP7YB37PaQJr7RqTCo17MtjKztZM2lUnj2peTtX/LbtbzjwHjE+2tcMR4pKRUtsEyP90JNcI0=
X-Received: by 2002:a7b:c041:: with SMTP id u1mr23622951wmc.56.1592897234836;
 Tue, 23 Jun 2020 00:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAPydje97m+hG3_Cqg560uHoq8aKG9eDpTHA1eJC=hLuKtMf_vw@mail.gmail.com>
In-Reply-To: <CAPydje97m+hG3_Cqg560uHoq8aKG9eDpTHA1eJC=hLuKtMf_vw@mail.gmail.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Tue, 23 Jun 2020 09:27:03 +0200
Message-ID: <CAJ+HfNgi5wEwmFTgKpR1KemVm3p0FCPTd8V+BBWC6C59OO9O8Q@mail.gmail.com>
Subject: Re: Talk about AF_XDP support multithread concurrently receive packet
To:     Yahui Chen <goodluckwillcomesoon@gmail.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Xdp <xdp-newbies@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 23 Jun 2020 at 08:21, Yahui Chen <goodluckwillcomesoon@gmail.com> w=
rote:
>
> I have make an issue for the libbpf in github, issue number 163.
>
> Andrii suggest me sending a mail here. So ,I paste out the content of the=
 issue:
>

Yes, and the xdp-newsbies is an even better list for these kinds of
discussions (added).

> Currently, libbpf do not support concurrently receive pkts using AF_XDP.
>
> For example: I create 4 af_xdp sockets on nic's ring 0. Four sockets
> receiving packets concurrently can't work correctly because the API of
> cq `xsk_ring_prod__reserve` and `xsk_ring_prod__submit` don't support
> concurrence.
>

In other words, you are using shared umem sockets. The 4 sockets can
potentially receive packets from queue 0, depending on how the XDP
program is done.

> So, my question is why libbpf was designed non-concurrent mode, is the
> limit of kernel or other reason? I want to change the code to support
> concurrent receive pkts, therefore I want to find out whether this is
> theoretically supported.
>

You are right that the AF_XDP functionality in libbpf is *not* by
itself multi-process/thread safe, and this is deliberate. From the
libbpf perspective we cannot know how a user will construct the
application, and we don't want to penalize the single-thread/process
case.

It's entirely up to you to add explicit locking, if the
single-producer/single-consumer queues are shared between
threads/processes. Explicit synchronization is required using, say,
POSIX mutexes.

Does that clear things up?


Cheers,
Bj=C3=B6rn

> Thx.
