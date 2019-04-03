Return-Path: <SRS0=5VBK=SF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AEEC10F0B
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 09:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B7020830
	for <bpf@archiver.kernel.org>; Wed,  3 Apr 2019 09:13:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfDCJND (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Apr 2019 05:13:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725990AbfDCJNC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Apr 2019 05:13:02 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 26C6588AA2;
        Wed,  3 Apr 2019 09:13:02 +0000 (UTC)
Received: from krava (ovpn-204-108.brq.redhat.com [10.40.204.108])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4FF2C62A14;
        Wed,  3 Apr 2019 09:12:59 +0000 (UTC)
Date:   Wed, 3 Apr 2019 11:12:58 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     andrii.nakryiko@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next] kbuild: add ability to generate BTF type info
 for vmlinux
Message-ID: <20190403091258.GA24875@krava>
References: <20190402164950.429597-1-andrii.nakryiko@gmail.com>
 <20190403084619.GA23855@krava>
 <611b4f67-801e-1bab-7a43-a16d341187ba@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <611b4f67-801e-1bab-7a43-a16d341187ba@iogearbox.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 03 Apr 2019 09:13:02 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 03, 2019 at 11:04:28AM +0200, Daniel Borkmann wrote:
> On 04/03/2019 10:46 AM, Jiri Olsa wrote:
> > On Tue, Apr 02, 2019 at 09:49:50AM -0700, andrii.nakryiko@gmail.com wrote:
> >> From: Andrii Nakryiko <andriin@fb.com>
> >>
> >> This patch adds new config option to trigger generation of BTF type
> >> information from DWARF debuginfo for vmlinux and kernel modules through
> >> pahole, which in turn relies on libbpf for btf_dedup() algorithm.
> >>
> >> The intent is to record compact type information of all types used
> >> inside kernel, including all the structs/unions/typedefs/etc. This
> >> enables BPF's compile-once-run-everywhere ([0]) approach, in which
> >> tracing programs that are inspecting kernel's internal data (e.g.,
> >> struct task_struct) can be compiled on a system running some kernel
> >> version, but would be possible to run on other kernel versions (and
> >> configurations) without recompilation, even if the layout of structs
> >> changed and/or some of the fields were added, removed, or renamed.
> >>
> >> This is only possible if BPF loader can get kernel type info to adjust
> >> all the offsets correctly. This patch is a first time in this direction,
> >> making sure that BTF type info is part of Linux kernel image in
> >> non-loadable ELF section.
> >>
> >> BTF deduplication ([1]) algorithm typically provides 100x savings
> >> compared to DWARF data, so resulting .BTF section is not big as is
> >> typically about 2MB in size.
> > 
> > hi,
> > I'm using the latest pahole from git tree:
> >   https://github.com/acmel/dwarves.git
> > 
> > and getting pahole crash:
> > 
> >   LD      vmlinux
> >   BTF     vmlinux
> > die__process_inline_expansion: DW_TAG_label (0xa) @ <0x3eef8> not handled!
> > scripts/link-vmlinux.sh: line 96: 31222 Segmentation fault      (core dumped) LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
> > make[1]: *** [/home/jolsa/linux/Makefile:1025: vmlinux] Error 139
> > make: *** [Makefile:170: sub-make] Error 2
> > 
> > is there some other source/dependency I'm missing?
> 
> Yesterday night, I've tested with [0] but seems to have the same HEAD as
> the github repo you pointed out. Seems the above is coming from pahole's
> __die__process_tag() bailing out with default for DW_TAG_label?
> 
> On my side worked fine:

hum, I also had to change the version of pahole in the patch to allow
version v1.12, because both latest pahole sources are on version 1.12,
did u have to do that? looks like there's v1.13 somewhere ;-)

jirka

SNIP

> 
>   [0] https://git.kernel.org/pub/scm/devel/pahole/pahole.git/
