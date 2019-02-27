Return-Path: <SRS0=P9GS=RC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA23C43381
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 16:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA172184A
	for <bpf@archiver.kernel.org>; Wed, 27 Feb 2019 16:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfB0QdA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:33:00 -0500
Received: from www62.your-server.de ([213.133.104.62]:39590 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfB0QdA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 27 Feb 2019 11:33:00 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gz28a-0002b0-6g; Wed, 27 Feb 2019 17:32:52 +0100
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gz28Z-00018p-V6; Wed, 27 Feb 2019 17:32:52 +0100
Subject: Re: [PATCH v3 bpf-next 0/4] bpf: per program stats
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     edumazet@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
References: <20190225222842.2031962-1-ast@kernel.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7a15f237-68b2-e998-69c5-2394bccf3749@iogearbox.net>
Date:   Wed, 27 Feb 2019 17:32:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190225222842.2031962-1-ast@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25373/Wed Feb 27 11:36:59 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/25/2019 11:28 PM, Alexei Starovoitov wrote:
> Introduce per program stats to monitor the usage BPF
> 
> v2->v3:
> - rename to run_time_ns/run_cnt everywhere
> 
> v1->v2:
> - fixed u64 stats on 32-bit archs. Thanks Eric
> - use more verbose run_time_ns in json output as suggested by Andrii
> - refactored prog_alloc and clarified behavior of stats in subprogs
> 
> Alexei Starovoitov (4):
>   bpf: enable program stats
>   bpf: expose program stats via bpf_prog_info
>   tools/bpf: sync bpf.h into tools
>   tools/bpftool: recognize bpf_prog_info run_time_ns and run_cnt
> 
>  include/linux/bpf.h                           |  9 +++++
>  include/linux/filter.h                        | 20 +++++++++-
>  include/uapi/linux/bpf.h                      |  2 +
>  kernel/bpf/core.c                             | 31 ++++++++++++++-
>  kernel/bpf/syscall.c                          | 39 ++++++++++++++++++-
>  kernel/bpf/verifier.c                         |  7 +++-
>  kernel/sysctl.c                               | 34 ++++++++++++++++
>  .../bpftool/Documentation/bpftool-prog.rst    |  4 +-
>  tools/bpf/bpftool/prog.c                      |  7 ++++
>  tools/include/uapi/linux/bpf.h                |  2 +
>  10 files changed, 148 insertions(+), 7 deletions(-)
> 

Applied, thanks!
