Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BD6C4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 23:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034F220856
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 23:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfDBXAk (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 19:00:40 -0400
Received: from www62.your-server.de ([213.133.104.62]:41968 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfDBXAk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 19:00:40 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBSOS-0004Cu-IQ; Wed, 03 Apr 2019 01:00:36 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBSOS-000EXy-Bz; Wed, 03 Apr 2019 01:00:36 +0200
Subject: Re: [PATCH bpf-next] kbuild: add ability to generate BTF type info
 for vmlinux
To:     andrii.nakryiko@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org, kernel-team@fb.com
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
References: <20190402164950.429597-1-andrii.nakryiko@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f3d47b6e-13ba-0667-f631-f30326b048d3@iogearbox.net>
Date:   Wed, 3 Apr 2019 01:00:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190402164950.429597-1-andrii.nakryiko@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25407/Tue Apr  2 09:54:31 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/02/2019 06:49 PM, andrii.nakryiko@gmail.com wrote:
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
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Alexei Starovoitov <ast@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

LGTM! As subject is targetting bpf-next this time since this BPF-related patch
in this form has been sitting on the list for over 1.5months, I've taken it in
there now, thanks!
