Return-Path: <SRS0=+eov=SG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1145BC10F05
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AE320882
	for <bpf@archiver.kernel.org>; Thu,  4 Apr 2019 08:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbfDDIrZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 4 Apr 2019 04:47:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728543AbfDDIrZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Apr 2019 04:47:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C21B081E19;
        Thu,  4 Apr 2019 08:47:24 +0000 (UTC)
Received: from krava (unknown [10.40.205.150])
        by smtp.corp.redhat.com (Postfix) with SMTP id A09216C758;
        Thu,  4 Apr 2019 08:47:21 +0000 (UTC)
Date:   Thu, 4 Apr 2019 10:47:20 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, andrii.nakryiko@gmail.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH bpf-next] kbuild: add ability to generate BTF type info
 for vmlinux
Message-ID: <20190404084720.GG32001@krava>
References: <20190402164950.429597-1-andrii.nakryiko@gmail.com>
 <20190403084619.GA23855@krava>
 <611b4f67-801e-1bab-7a43-a16d341187ba@iogearbox.net>
 <20190403091258.GA24875@krava>
 <20190404004042.GA7400@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404004042.GA7400@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 04 Apr 2019 08:47:25 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 03, 2019 at 09:40:42PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 03, 2019 at 11:12:58AM +0200, Jiri Olsa escreveu:
> > On Wed, Apr 03, 2019 at 11:04:28AM +0200, Daniel Borkmann wrote:
> > > On 04/03/2019 10:46 AM, Jiri Olsa wrote:
> > > > On Tue, Apr 02, 2019 at 09:49:50AM -0700, andrii.nakryiko@gmail.com wrote:
> > > >> From: Andrii Nakryiko <andriin@fb.com>
> > > >>
> > > >> This patch adds new config option to trigger generation of BTF type
> > > >> information from DWARF debuginfo for vmlinux and kernel modules through
> > > >> pahole, which in turn relies on libbpf for btf_dedup() algorithm.
> > > > I'm using the latest pahole from git tree:
> 
> > > >   https://github.com/acmel/dwarves.git
> 
> I've updated this oen as well, but the canonical one is at:
> 
> git://git.kernel.org/pub/scm/devel/pahole/pahole.git
> 
> See the fix below.
> 
> > > > and getting pahole crash:
> 
> > > >   LD      vmlinux
> > > >   BTF     vmlinux
> > > > die__process_inline_expansion: DW_TAG_label (0xa) @ <0x3eef8> not handled!
> > > > scripts/link-vmlinux.sh: line 96: 31222 Segmentation fault      (core dumped) LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
> > > > make[1]: *** [/home/jolsa/linux/Makefile:1025: vmlinux] Error 139
> > > > make: *** [Makefile:170: sub-make] Error 2
> 
> > > > is there some other source/dependency I'm missing?
> 
> > > Yesterday night, I've tested with [0] but seems to have the same HEAD as
> > > the github repo you pointed out. Seems the above is coming from pahole's
> > > __die__process_tag() bailing out with default for DW_TAG_label?
> 
> > > On my side worked fine:
>  
> > hum, I also had to change the version of pahole in the patch to allow
> > version v1.12, because both latest pahole sources are on version 1.12,
> > did u have to do that? looks like there's v1.13 somewhere ;-)
> 
> So, I've reproduced the problem and fixed it, please pull my latest
> master branch from git://git.kernel.org/pub/scm/devel/pahole/pahole.git,
> please do the hack to make it expect v1.12, I'll try and relase v1.13
> soon, if nothing else pops up soon.

  ...
  LD      vmlinux
  BTF     vmlinux
  SORTEX  vmlinux

works nicely now, thanks ;-)

jirka
