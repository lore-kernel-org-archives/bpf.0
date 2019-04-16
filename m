Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0E7C10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABBF12073F
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfDPI6j (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:58:39 -0400
Received: from www62.your-server.de ([213.133.104.62]:36602 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbfDPI6j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 04:58:39 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJSn-0006Gp-6r; Tue, 16 Apr 2019 10:29:09 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJSm-000EpW-VJ; Tue, 16 Apr 2019 10:29:09 +0200
Subject: Re: [PATCH bpf-next 0/5] tools: bpftool: fix minor issues in bpftool
 and its documentation
To:     Quentin Monnet <quentin.monnet@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
References: <20190412132938.9044-1-quentin.monnet@netronome.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <b594b44a-5963-25b9-be08-c776df0ffa4b@iogearbox.net>
Date:   Tue, 16 Apr 2019 10:29:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190412132938.9044-1-quentin.monnet@netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25420/Mon Apr 15 09:57:25 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/12/2019 03:29 PM, Quentin Monnet wrote:
> Hi,
> This series brings a number of small fixes to bpftool and the related
> manual pages.
> 
> The first two patches are on bpftool itself (remove blank lines when
> dumping programs, do not set errno when showing a tree of cgroup programs).
> 
> The next two patches are fixes for the manual pages (missing keyword, wrong
> option name for showing bpftool version). The last one is not exactly a
> fix, but rather an addition to the man page, explaining how to dump program
> statistics.
> 
> Quentin Monnet (5):
>   tools: bpftool: remove blank line after btf_id when listing programs
>   tools: bpftool: reset errno for "bpftool cgroup tree"
>   tools: bpftool: fix man page documentation for "pinmaps" keyword
>   tools: bpftool: fix short option name for printing version in man
>     pages
>   tools: bpftool: add a note on program statistics in man page
> 
>  tools/bpf/bpftool/Documentation/bpftool-cgroup.rst  |  2 +-
>  tools/bpf/bpftool/Documentation/bpftool-feature.rst |  2 +-
>  tools/bpf/bpftool/Documentation/bpftool-map.rst     |  2 +-
>  tools/bpf/bpftool/Documentation/bpftool-net.rst     |  2 +-
>  tools/bpf/bpftool/Documentation/bpftool-perf.rst    |  2 +-
>  tools/bpf/bpftool/Documentation/bpftool-prog.rst    | 12 ++++++++++--
>  tools/bpf/bpftool/Documentation/bpftool.rst         |  2 +-
>  tools/bpf/bpftool/cgroup.c                          |  7 +++++++
>  tools/bpf/bpftool/prog.c                            |  2 +-
>  9 files changed, 24 insertions(+), 9 deletions(-)
> 

Applied, thanks!
