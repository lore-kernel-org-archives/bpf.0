Return-Path: <SRS0=qicS=WR=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 474BBC3A59E
	for <bpf@archiver.kernel.org>; Wed, 21 Aug 2019 19:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215202332A
	for <bpf@archiver.kernel.org>; Wed, 21 Aug 2019 19:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbfHUTUA (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 21 Aug 2019 15:20:00 -0400
Received: from www62.your-server.de ([213.133.104.62]:53224 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfHUTUA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 15:20:00 -0400
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i0W9G-0007BX-9r; Wed, 21 Aug 2019 21:19:58 +0200
Received: from [178.197.249.40] (helo=pc-63.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i0W9F-0003Hz-Uh; Wed, 21 Aug 2019 21:19:58 +0200
Subject: Re: [PATCH bpf-next 0/2] tools: bpftool: work with frozen maps
To:     Quentin Monnet <quentin.monnet@netronome.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
References: <20190821085219.30387-1-quentin.monnet@netronome.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <97aaccaa-51d5-ae53-6e5f-e32b1f90dc5c@iogearbox.net>
Date:   Wed, 21 Aug 2019 21:19:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190821085219.30387-1-quentin.monnet@netronome.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25548/Wed Aug 21 10:27:18 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/21/19 10:52 AM, Quentin Monnet wrote:
> Hi,
> This is a simple set to add support for BPF map freezing to bpftool. First
> patch makes bpftool indicate if a map is frozen when listing BPF maps.
> Second patch adds a command to freeze a map loaded on the system.
> 
> Quentin Monnet (2):
>    tools: bpftool: show frozen status for maps
>    tools: bpftool: add "bpftool map freeze" subcommand
> 
>   .../bpf/bpftool/Documentation/bpftool-map.rst |  9 +++
>   tools/bpf/bpftool/bash-completion/bpftool     |  4 +-
>   tools/bpf/bpftool/map.c                       | 64 +++++++++++++++++--
>   3 files changed, 71 insertions(+), 6 deletions(-)
> 

Applied, thanks!
