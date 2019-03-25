Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D39C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 17:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D376D2087C
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 17:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfCYRVW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:21:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:53634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726217AbfCYRVV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Mar 2019 13:21:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 518CCAF86;
        Mon, 25 Mar 2019 17:21:20 +0000 (UTC)
Date:   Mon, 25 Mar 2019 18:21:15 +0100
From:   Michal Rostecki <mrostecki@opensuse.org>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>, Andrey Ignatov <rdna@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        Brenden Blanco <bblanco@gmail.com>, Yonghong Song <yhs@fb.com>
Subject: Re: libbpf packaging
Message-ID: <20190325172115.i35nfrelzkwqgyoy@workstation>
References: <20190325122134.GA14042@krava>
 <854218ad-ce5c-cd00-7772-97bd9bc379a1@iogearbox.net>
 <CAADnVQKvRz-EMPqB5oMiG=6N1-QwAhMGnpnQsgSyQuUcrA781A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKvRz-EMPqB5oMiG=6N1-QwAhMGnpnQsgSyQuUcrA781A@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 25, 2019 at 09:03:11AM -0700, Alexei Starovoitov wrote:
> > > 2) There's already bcc-devel's libbpf library packaged:
> > >
> > >    $ rpm -qf /usr/lib64/libbpf.so
> > >    bcc-devel-0.8.0-1.fc28.x86_64
> > >
> > >    so there's a conflict.. any chance we could rename libbpf to
> > >    something else like:
> > >
> > >    libbpf2.so
> > >    libbpfobject.so
> > >    libbpfbest.so
> > >    ...?
> >
> > I don't think we should rename the official libbpf package, this will
> > just create plain confusion and will make it much harder for potential
> > users to adapt in the long-term since we aim for /everyone/ to consume
> > official libbpf library instead of hacking their own.
> >
> > I think bcc folks are migrating to official libbpf as well, at least
> > that was my impression. Imho, this would need fixing on bcc side then.
> 
> bcc migrated to libbpf some time ago.

And the libbpf.so file which is installed with bcc is "our" libbpf. bcc
simply uses libbpf (from the auto-synced standalone repo[0]) as a
submodule[1]. To package libbpf and bcc properly in Linux distros we
need a possibility to use bcc with shared libbpf library - which
probably can be achiveved by small change in bcc's CMakeLists.txt.

The standalone repo[0] might be a better base for creating a package
than full kernel sources. And using %soversion%+git%sha% (i.e.
0.0.2+git33b017) might be a better version pattern of that package.

Cheers,
Michal

[0] https://github.com/libbpf/libbpf
[1] https://github.com/iovisor/bcc/blob/master/CMakeLists.txt#L12-L16
