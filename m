Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BAD4C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 00:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F88E2085A
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 00:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbfCAAAq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:00:46 -0500
Received: from www62.your-server.de ([213.133.104.62]:57190 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfCAAAq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 19:00:46 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzVbY-0006oC-EE; Fri, 01 Mar 2019 01:00:44 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzVbY-000PZY-8B; Fri, 01 Mar 2019 01:00:44 +0100
Subject: Re: [PATCH bpf-next v2 0/5] samples: bpf: continue effort to get rid
 of bpf_load
To:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        alexei.starovoitov@gmail.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com
References: <20190228030414.18973-1-jakub.kicinski@netronome.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f2680751-be12-7d31-34ac-251d7d4ef617@iogearbox.net>
Date:   Fri, 1 Mar 2019 01:00:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190228030414.18973-1-jakub.kicinski@netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/28/2019 04:04 AM, Jakub Kicinski wrote:
> Hi!
> 
> This set is next part of a quest to get rid of the bpf_load
> ELF loader.  It fixes some minor issues with the samples and
> starts the conversion.
> 
> First patch fixes ping invocations, ping localhost defaults
> to IPv6 on modern setups. Next load_sock_ops sample is removed
> and users are directed towards using bpftool directly.
> 
> Patch 4 removes the use of bpf_load from samples which don't
> need the auto-attachment functionality at all.
> 
> Patch 5 improves symbol counting in libbpf, it's not currently
> an issue but it will be when anyone adds a symbol with a long
> name. Let's make sure that person doesn't have to spend time
> scratching their head and wondering why .a and .so symbol
> counts don't match.
> 
> v2: - specify prog_type where possible (Andrii).
> 
> Jakub Kicinski (5):
>   samples: bpf: force IPv4 in ping
>   samples: bpf: remove load_sock_ops in favour of bpftool
>   tools: libbpf: add a correctly named define for map iteration
>   samples: bpf: use libbpf where easy
>   tools: libbpf: make sure readelf shows full names in build checks
> 
>  samples/bpf/.gitignore                        |  1 -
>  samples/bpf/Makefile                          |  8 +-
>  samples/bpf/fds_example.c                     | 10 +-
>  samples/bpf/load_sock_ops.c                   | 97 -------------------
>  samples/bpf/sock_example.c                    |  2 +-
>  samples/bpf/sockex1_user.c                    | 25 ++---
>  samples/bpf/sockex2_user.c                    | 23 +++--
>  samples/bpf/sockex3_user.c                    |  2 +-
>  samples/bpf/tcp_basertt_kern.c                |  2 +-
>  samples/bpf/tcp_bpf.readme                    | 14 +--
>  samples/bpf/tcp_bufs_kern.c                   |  2 +-
>  samples/bpf/tcp_clamp_kern.c                  |  2 +-
>  samples/bpf/tcp_cong_kern.c                   |  2 +-
>  samples/bpf/tcp_iw_kern.c                     |  2 +-
>  samples/bpf/tcp_rwnd_kern.c                   |  2 +-
>  samples/bpf/tcp_synrto_kern.c                 |  2 +-
>  samples/bpf/tcp_tos_reflect_kern.c            |  2 +-
>  samples/bpf/tracex2_user.c                    |  2 +-
>  tools/bpf/bpftool/prog.c                      |  4 +-
>  tools/lib/bpf/Makefile                        |  4 +-
>  tools/lib/bpf/libbpf.c                        |  8 +-
>  tools/lib/bpf/libbpf.h                        |  3 +-
>  tools/perf/util/bpf-loader.c                  |  4 +-
>  .../testing/selftests/bpf/test_libbpf_open.c  |  2 +-
>  24 files changed, 69 insertions(+), 156 deletions(-)
>  delete mode 100644 samples/bpf/load_sock_ops.c
> 

Applied, thanks for cleaning this up!
