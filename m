Return-Path: <SRS0=DkpX=4P=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FFF4C4BA3B
	for <bpf@archiver.kernel.org>; Thu, 27 Feb 2020 12:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA9E24692
	for <bpf@archiver.kernel.org>; Thu, 27 Feb 2020 12:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="R7ucxzv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728986AbgB0MCk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:02:40 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40487 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728882AbgB0MCk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Feb 2020 07:02:40 -0500
Received: by mail-oi1-f195.google.com with SMTP id a142so3014475oii.7
        for <bpf@vger.kernel.org>; Thu, 27 Feb 2020 04:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrW5LZwrgusNW5R7fWdBcyZoH5Id25Lj621CnfewVCc=;
        b=R7ucxzv9WX65DnqA/knWAtXzG4aPD3M+Asthh3S1KCrJkFmamDtuptP8MO97MSHPba
         e34rpQIqPzJrIS5t+m2Tbc5VplqIasAxwwwWAF/g02+wjLvXAycRrcQgceZ/5e3sPx6V
         FEQqshY/WSxH/1/V4meq2t1Hh1fEGRnWWai7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrW5LZwrgusNW5R7fWdBcyZoH5Id25Lj621CnfewVCc=;
        b=F8b58pfoAvYjJnSrPEGIXdv6Ja0GzWFnbcCMaICCLB4uBtwazMj8B/Oc5oNVS/ShG3
         k92WV2Vtw6r23AF6Wq6pXjIvH8SbqIqvcDwLjflxlHgG7wVFW6qtGXNZ+2WFd0hvpohJ
         dQ+hewaKflN2fGb6SeJUh+jfTYSuZ4L6BiW4NdbZJIZeqZ3nBnImhK/8DyhxT/z7iqhp
         55xBVI8f5cMwCVrMvrD3f8M2EnD0O3msNYsVxIyQsc9LC3RGrS+8uZZseA2eqD9ZWOKg
         QPGlMQlIJTU/5AeQhE6L5UzB2Id/Z1f5Cak55kI/FvBQMU2rIhKDCyOVNZqNjdKvPHOU
         eO4w==
X-Gm-Message-State: APjAAAWJD2dhfSxb8bmMHbS2o4XFot5KxS856mPsyP/JuuS4wdm3yJw6
        2PhtU+ox/HzfspIbycWd/+99ndYe9bz+sDiZeDGkBg==
X-Google-Smtp-Source: APXvYqxGGnZ2YlIzPYcumkmeZ2az1g8ikQk+YksINp58lf1d1j35iK2m2bjoEozqq7jJAU097AlwLPvODXTA3KcrXgY=
X-Received: by 2002:aca:d4c1:: with SMTP id l184mr3007527oig.172.1582804959343;
 Thu, 27 Feb 2020 04:02:39 -0800 (PST)
MIME-Version: 1.0
References: <20200225135636.5768-1-lmb@cloudflare.com> <20200225135636.5768-7-lmb@cloudflare.com>
 <877e08cksq.fsf@cloudflare.com>
In-Reply-To: <877e08cksq.fsf@cloudflare.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 27 Feb 2020 12:02:28 +0000
Message-ID: <CACAyw9832Q+uLfYgzs5oAmYZDF+3U5pPGYKViMKovqb_hKY0gw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 6/7] selftests: bpf: add tests for UDP sockets in sockmap
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 27 Feb 2020 at 11:49, Jakub Sitnicki <jakub@cloudflare.com> wrote:
> > +#define TEST(fn) TEST_SOTYPE(fn, 0)
> > +#define TEST_STREAM(fn) TEST_SOTYPE(fn, SOCK_STREAM)
> > +#define TEST_DGRAM(fn) TEST_SOTYPE(fn, SOCK_DGRAM)
> > +
>
> An alternative would be to use __VA_ARGS__ and designated intializers,
> as I did recently in e0360423d020 ("selftests/bpf: Run SYN cookies with
> reuseport BPF test only for TCP"). TEST_DGRAM is unused at the moment,
> so that's something to consider.

Good idea, I'll pick it up!

> test_redir() doesn't get called with SOCK_DGRAM, because redirection
> with sockmap and UDP is not supported yet, so perhaps no need to touch
> this function.

I did this to avoid needing another macro, it should be possible to skip this
with your VA_ARGS idea.

> Looks like we can enable reuseport tests with not too much effort.
> I managed to get them working with the changes below.

Thanks, I'll add this to the next revision!

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
