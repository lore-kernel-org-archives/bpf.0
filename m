Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C26C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFFD120854
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 20:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbfCYUUN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:20:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728912AbfCYUUN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Mar 2019 16:20:13 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2DA737E7B;
        Mon, 25 Mar 2019 20:20:12 +0000 (UTC)
Received: from krava (ovpn-204-80.brq.redhat.com [10.40.204.80])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4B05B5DAAE;
        Mon, 25 Mar 2019 20:20:10 +0000 (UTC)
Date:   Mon, 25 Mar 2019 21:20:09 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Michal Rostecki <mrostecki@opensuse.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrey Ignatov <rdna@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        Brenden Blanco <bblanco@gmail.com>
Subject: Re: libbpf packaging
Message-ID: <20190325202009.GA14511@krava>
References: <20190325122134.GA14042@krava>
 <854218ad-ce5c-cd00-7772-97bd9bc379a1@iogearbox.net>
 <CAADnVQKvRz-EMPqB5oMiG=6N1-QwAhMGnpnQsgSyQuUcrA781A@mail.gmail.com>
 <20190325172115.i35nfrelzkwqgyoy@workstation>
 <e13f6295-e7ae-80c4-67af-6e8551a375a1@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e13f6295-e7ae-80c4-67af-6e8551a375a1@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 25 Mar 2019 20:20:13 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 25, 2019 at 07:34:42PM +0000, Yonghong Song wrote:
> 
> 
> On 3/25/19 10:21 AM, Michal Rostecki wrote:
> > On Mon, Mar 25, 2019 at 09:03:11AM -0700, Alexei Starovoitov wrote:
> >>>> 2) There's already bcc-devel's libbpf library packaged:
> >>>>
> >>>>     $ rpm -qf /usr/lib64/libbpf.so
> >>>>     bcc-devel-0.8.0-1.fc28.x86_64
> >>>>
> >>>>     so there's a conflict.. any chance we could rename libbpf to
> >>>>     something else like:
> >>>>
> >>>>     libbpf2.so
> >>>>     libbpfobject.so
> >>>>     libbpfbest.so
> >>>>     ...?
> >>>
> >>> I don't think we should rename the official libbpf package, this will
> >>> just create plain confusion and will make it much harder for potential
> >>> users to adapt in the long-term since we aim for /everyone/ to consume
> >>> official libbpf library instead of hacking their own.
> >>>
> >>> I think bcc folks are migrating to official libbpf as well, at least
> >>> that was my impression. Imho, this would need fixing on bcc side then.
> >>
> >> bcc migrated to libbpf some time ago.
> > 
> > And the libbpf.so file which is installed with bcc is "our" libbpf. bcc
> > simply uses libbpf (from the auto-synced standalone repo[0]) as a
> > submodule[1]. To package libbpf and bcc properly in Linux distros we
> > need a possibility to use bcc with shared libbpf library - which
> > probably can be achiveved by small change in bcc's CMakeLists.txt.
> 
> I think we should rename bcc libbpf.so to a different name (maybe 
> libbcc_bpf.so) to avoid confusions between bcc libbpf and libbpf repo.
> The bcc libbpf.so is different from libbpf repo it contains some wrappers...

that'd be great first step.. then we could add libbpf
package and make bcc depend on it as suggested by Michal

> 
> I will propose to iovisor/bcc mailing list.

please keep me in cc for that

thanks,
jirka

> 
> > 
> > The standalone repo[0] might be a better base for creating a package
> > than full kernel sources. And using %soversion%+git%sha% (i.e.
> > 0.0.2+git33b017) might be a better version pattern of that package.
> > 
> > Cheers,
> > Michal
> > 
> > [0] https://github.com/libbpf/libbpf
> > [1] https://github.com/iovisor/bcc/blob/master/CMakeLists.txt#L12-L16
> > 
