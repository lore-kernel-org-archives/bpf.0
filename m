Return-Path: <SRS0=sqwL=R4=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E533C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 12:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458A320854
	for <bpf@archiver.kernel.org>; Mon, 25 Mar 2019 12:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbfCYMVi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:21:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45990 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729831AbfCYMVi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Mar 2019 08:21:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B4EF3004E77;
        Mon, 25 Mar 2019 12:21:38 +0000 (UTC)
Received: from krava (unknown [10.43.17.124])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3FCC17891C;
        Mon, 25 Mar 2019 12:21:35 +0000 (UTC)
Date:   Mon, 25 Mar 2019 13:21:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrey Ignatov <rdna@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>, bpf@vger.kernel.org
Subject: libbpf packaging
Message-ID: <20190325122134.GA14042@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Mon, 25 Mar 2019 12:21:38 +0000 (UTC)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi guys,
we want to package libbpf and I'd like to coordinate
with you on some issues I've met on this:

1) I think libbpf should be part of kernel-tools-libs and kernel-tools-libs-devel,
   which would look like below (from early rpm build):

   $ rpm -qpl kernel-tools-libs-5.0.0-1.fc31.x86_64.rpm
   /usr/lib/.build-id
   /usr/lib/.build-id/ca
   /usr/lib/.build-id/ca/654da1e5ea553f985e28b8d98ad24e51f19e88
   /usr/lib/.build-id/f6
   /usr/lib/.build-id/f6/a788b316f26fbe70db47bfc0ef500348117023
   /usr/lib64/libbpf.so.0
   /usr/lib64/libbpf.so.0.0.1
   /usr/lib64/libcpupower.so.0
   /usr/lib64/libcpupower.so.0.0.1
   /usr/share/licenses/kernel-tools-libs
   /usr/share/licenses/kernel-tools-libs/COPYING

   $ rpm -qpl kernel-tools-libs-devel-5.0.0-1.fc31.x86_64.rpm
   /usr/include/bpf/bpf.h
   /usr/include/bpf/btf.h
   /usr/include/bpf/libbpf.h
   /usr/include/cpufreq.h
   /usr/include/cpuidle.h
   /usr/lib64/libbpf.a
   /usr/lib64/libbpf.so
   /usr/lib64/libcpupower.so

   Do you see libbpf as a standalone package or kernel-tools-libs* wuold be ok for you?

2) There's already bcc-devel's libbpf library packaged:

   $ rpm -qf /usr/lib64/libbpf.so
   bcc-devel-0.8.0-1.fc28.x86_64

   so there's a conflict.. any chance we could rename libbpf to
   something else like:

   libbpf2.so
   libbpfobject.so
   libbpfbest.so
   ...?

   I checked and I think those 2 conflicting libraries don't make
   a valid case for using 'alternatives'.
  
   Also the libbpf.so from bcc-devel has been there for some time
   so we can't just remove/rename it.. ;-)

thoughts?


thanks,
jirka
