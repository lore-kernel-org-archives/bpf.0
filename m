Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C569C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 17:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D05C62075E
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 17:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbfDBRkm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 13:40:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57720 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730392AbfDBRkm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 13:40:42 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7C473133FCD40;
        Tue,  2 Apr 2019 10:40:41 -0700 (PDT)
Date:   Tue, 02 Apr 2019 10:40:30 -0700 (PDT)
Message-Id: <20190402.104030.733182526476732084.davem@davemloft.net>
To:     andrii.nakryiko@gmail.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@fb.com,
        andriin@fb.com, yamada.masahiro@socionext.com, acme@redhat.com,
        daniel@iogearbox.net, ast@fb.com, yhs@fb.com, kafai@fb.com
Subject: Re: [PATCH bpf-next] kbuild: add ability to generate BTF type info
 for vmlinux
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190402164950.429597-1-andrii.nakryiko@gmail.com>
References: <20190402164950.429597-1-andrii.nakryiko@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 02 Apr 2019 10:40:41 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: <andrii.nakryiko@gmail.com>
Date: Tue, 2 Apr 2019 09:49:50 -0700

> From: Andrii Nakryiko <andriin@fb.com>
> 
> This patch adds new config option to trigger generation of BTF type
> information from DWARF debuginfo for vmlinux and kernel modules through
> pahole, which in turn relies on libbpf for btf_dedup() algorithm.
> 
> The intent is to record compact type information of all types used
> inside kernel, including all the structs/unions/typedefs/etc. This
> enables BPF's compile-once-run-everywhere ([0]) approach, in which
> tracing programs that are inspecting kernel's internal data (e.g.,
> struct task_struct) can be compiled on a system running some kernel
> version, but would be possible to run on other kernel versions (and
> configurations) without recompilation, even if the layout of structs
> changed and/or some of the fields were added, removed, or renamed.
> 
> This is only possible if BPF loader can get kernel type info to adjust
> all the offsets correctly. This patch is a first time in this direction,
> making sure that BTF type info is part of Linux kernel image in
> non-loadable ELF section.
> 
> BTF deduplication ([1]) algorithm typically provides 100x savings
> compared to DWARF data, so resulting .BTF section is not big as is
> typically about 2MB in size.
> 
> [0] http://vger.kernel.org/lpc-bpf2018.html#session-2
> [1] https://facebookmicrosites.github.io/bpf/blog/2018/11/14/btf-enhancement.html
> 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: David S. Miller <davem@davemloft.net>
