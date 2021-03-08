Return-Path: <SRS0=tzzN=IG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D924DC433E0
	for <bpf@archiver.kernel.org>; Mon,  8 Mar 2021 13:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8519B6513A
	for <bpf@archiver.kernel.org>; Mon,  8 Mar 2021 13:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhCHNiT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Mar 2021 08:38:19 -0500
Received: from www62.your-server.de ([213.133.104.62]:41230 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhCHNh5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Mar 2021 08:37:57 -0500
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1lJG4j-000AJy-RM; Mon, 08 Mar 2021 14:37:33 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1lJG4j-0008T9-F6; Mon, 08 Mar 2021 14:37:33 +0100
Subject: Re: [PATCH] tools include: Add __sum16 and __wsum definitions.
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
References: <20210307223024.4081067-1-irogers@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4aa2a66d-b8e4-adfe-8b61-615d98012a65@iogearbox.net>
Date:   Mon, 8 Mar 2021 14:37:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20210307223024.4081067-1-irogers@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/26102/Mon Mar  8 13:03:13 2021)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/7/21 11:30 PM, Ian Rogers wrote:
> This adds definitions available in the uapi version.
> 
> Explanation:
> In the kernel include of types.h the uapi version is included.
> In tools the uapi/linux/types.h and linux/types.h are distinct.
> For BPF programs a definition of __wsum is needed by the generated
> bpf_helpers.h. The definition comes either from a generated vmlinux.h or
> from <linux/types.h> that may be transitively included from bpf.h. The
> perf build prefers linux/types.h over uapi/linux/types.h for
> <linux/types.h>*. To allow tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c
> to compile with the same include path used for perf then these
> definitions are necessary.
> 
> There is likely a wider conversation about exactly how types.h should be
> specified and the include order used by the perf build - it is somewhat
> confusing that tools/include/uapi/linux/bpf.h is using the non-uapi
> types.h.
> 
> *see tools/perf/Makefile.config:
> ...
> INC_FLAGS += -I$(srctree)/tools/include/
> INC_FLAGS += -I$(srctree)/tools/arch/$(SRCARCH)/include/uapi
> INC_FLAGS += -I$(srctree)/tools/include/uapi
> ...
> The include directories are scanned from left-to-right:
> https://gcc.gnu.org/onlinedocs/gcc/Directory-Options.html
> As tools/include/linux/types.h appears before
> tools/include/uapi/linux/types.h then I say it is preferred.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Given more related to perf build infra, I presume Arnaldo would pick
this one up?

Thanks,
Daniel
