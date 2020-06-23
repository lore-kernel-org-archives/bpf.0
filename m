Return-Path: <SRS0=QOwA=AE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A725C433E0
	for <bpf@archiver.kernel.org>; Tue, 23 Jun 2020 19:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852EF20C09
	for <bpf@archiver.kernel.org>; Tue, 23 Jun 2020 19:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733258AbgFWTjK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:39:10 -0400
Received: from mail.qboosh.pl ([217.73.31.61]:54671 "EHLO mail.qboosh.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733248AbgFWTjJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 15:39:09 -0400
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jun 2020 15:39:09 EDT
Received: by mail.qboosh.pl (Postfix, from userid 1000)
        id 45B4B1A26DAA; Tue, 23 Jun 2020 21:29:17 +0200 (CEST)
Date:   Tue, 23 Jun 2020 21:29:17 +0200
From:   Jakub Bogusz <qboosh@pld-linux.org>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH] fix libbpf hashmap with size_t shorter than long long
Message-ID: <20200623192917.GA6342@mail>
References: <20200621142559.GA25517@stranger.qboosh.pl> <CAEf4BzafxBFCa=sm-MoG71iwMA77Rj4OS-6w4U1OahP3+cH_wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzafxBFCa=sm-MoG71iwMA77Rj4OS-6w4U1OahP3+cH_wQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 22, 2020 at 10:44:56PM -0700, Andrii Nakryiko wrote:
> On Sun, Jun 21, 2020 at 7:34 AM Jakub Bogusz <qboosh@pld-linux.org> wrote:
> >
> > Hello,
> >
> > I noticed that _bpftool crashes when building kernel tools (5.7.x) for
> > 32-bit targets because in libbpf hashmap implementation hash_bits()
> > function returning numbers exceeding hashmap buckets capacity.
> >
> > Attached patch fixes this problem.
> >
> 
> Thanks! But this was already fixed by Arnaldo Carvalho de Melo <acme@kernel.org>
> in 8ca8d4a84173 ("libbpf: Define __WORDSIZE if not available").

No, it's not:
This change worked around __WORDSIZE not always being available.

But the issue on (I)LP32 platforms is that 64-bit value is shifted by
(32-bits) instead of (64-bits).

(__SIZEOF_LONG__ * 8) is 32 on such architectures (i686, arm).
I used __SIZEOF_LONG_LONG__ to get proper bit shift both on (I)LP32 and
LP64 architectures.

Should I provide an updated patch to apply on top of acme change?


Regards,

-- 
Jakub Bogusz    http://qboosh.pl/
