Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED60C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 17:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889C62087C
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 17:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfCYRTG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:19:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45454 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729036AbfCYRTF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Mar 2019 13:19:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C7793086216;
        Mon, 25 Mar 2019 17:19:05 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 74B981001DD4;
        Mon, 25 Mar 2019 17:19:03 +0000 (UTC)
Date:   Mon, 25 Mar 2019 18:19:02 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrey Ignatov <rdna@fb.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>, bpf <bpf@vger.kernel.org>,
        Brenden Blanco <bblanco@gmail.com>, Yonghong Song <yhs@fb.com>
Subject: Re: libbpf packaging
Message-ID: <20190325171902.GA13250@krava>
References: <20190325122134.GA14042@krava>
 <854218ad-ce5c-cd00-7772-97bd9bc379a1@iogearbox.net>
 <CAADnVQKvRz-EMPqB5oMiG=6N1-QwAhMGnpnQsgSyQuUcrA781A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQKvRz-EMPqB5oMiG=6N1-QwAhMGnpnQsgSyQuUcrA781A@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 25 Mar 2019 17:19:05 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 25, 2019 at 09:03:11AM -0700, Alexei Starovoitov wrote:
> On Mon, Mar 25, 2019 at 5:53 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
> >
> > On 03/25/2019 01:21 PM, Jiri Olsa wrote:
> > > hi guys,
> > > we want to package libbpf and I'd like to coordinate
> > > with you on some issues I've met on this:
> > >
> > > 1) I think libbpf should be part of kernel-tools-libs and kernel-tools-libs-devel,
> > >    which would look like below (from early rpm build):
> > >
> > >    $ rpm -qpl kernel-tools-libs-5.0.0-1.fc31.x86_64.rpm
> > >    /usr/lib/.build-id
> > >    /usr/lib/.build-id/ca
> > >    /usr/lib/.build-id/ca/654da1e5ea553f985e28b8d98ad24e51f19e88
> > >    /usr/lib/.build-id/f6
> > >    /usr/lib/.build-id/f6/a788b316f26fbe70db47bfc0ef500348117023
> > >    /usr/lib64/libbpf.so.0
> > >    /usr/lib64/libbpf.so.0.0.1
> > >    /usr/lib64/libcpupower.so.0
> > >    /usr/lib64/libcpupower.so.0.0.1
> > >    /usr/share/licenses/kernel-tools-libs
> > >    /usr/share/licenses/kernel-tools-libs/COPYING
> > >
> > >    $ rpm -qpl kernel-tools-libs-devel-5.0.0-1.fc31.x86_64.rpm
> > >    /usr/include/bpf/bpf.h
> > >    /usr/include/bpf/btf.h
> > >    /usr/include/bpf/libbpf.h
> > >    /usr/include/cpufreq.h
> > >    /usr/include/cpuidle.h
> > >    /usr/lib64/libbpf.a
> > >    /usr/lib64/libbpf.so
> > >    /usr/lib64/libcpupower.so
> > >
> > >    Do you see libbpf as a standalone package or kernel-tools-libs* wuold be ok for you?
> >
> > My preference is definitely on making libbpf a stand-alone package, so
> > people can just install 'libbpf' or 'libbpf-dev{,el}' and are good to
> > go. Also given the pace it's growing these days, it absolutely qualifies
> > as a stand-alone package.
> 
> +1
> libbpf should be standalone package and not part of kernel-tools.

ok

> 
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

yea, but looks like it still exports its own libbpf.so with some helpers:

[jolsa@krava ~]$ nm -D /usr/lib64/libbpf.so.0
...
0000000000005500 T bpf_attach_kprobe
0000000000005340 T bpf_attach_perf_event
00000000000052a0 T bpf_attach_perf_event_raw
0000000000004b50 T bpf_attach_raw_tracepoint
0000000000004af0 T bpf_attach_socket
0000000000005d10 T bpf_attach_tracepoint
0000000000005810 T bpf_attach_uprobe
0000000000004ea0 T bpf_attach_xdp
0000000000005480 T bpf_close_perf_event_fd
0000000000003990 T bpf_create_map
0000000000003cb0 T bpf_delete_elem
0000000000004b20 T bpf_detach_kprobe
0000000000004b40 T bpf_detach_tracepoint
0000000000004b30 T bpf_detach_uprobe
0000000000003d30 T bpf_get_first_key
0000000000003e70 T bpf_get_next_key
0000000000003c30 T bpf_lookup_elem
0000000000005fb0 T bpf_map_get_fd_by_id
0000000000005e40 T bpf_obj_get
0000000000003ef0 T bpf_obj_get_info
0000000000005dc0 T bpf_obj_pin
0000000000004c10 T bpf_open_perf_buffer
0000000000004d80 T bpf_open_perf_event
0000000000004980 T bpf_open_raw_sock
0000000000003f70 T bpf_prog_compute_tag
0000000000005f30 T bpf_prog_get_fd_by_id
0000000000005eb0 T bpf_prog_get_next_id
00000000000042f0 T bpf_prog_get_tag
0000000000004430 T bpf_prog_load
0000000000003ba0 T bpf_update_elem
00000000000061b0 T perf_reader_event_read
0000000000006520 T perf_reader_fd
0000000000006090 T perf_reader_free
0000000000006120 T perf_reader_mmap
0000000000006030 T perf_reader_new
00000000000063f0 T perf_reader_poll
0000000000006510 T perf_reader_set_fd
...

jirka
