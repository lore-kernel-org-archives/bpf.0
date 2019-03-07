Return-Path: <SRS0=xp9Q=RK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC2BC4360F
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 10:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F278320675
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 10:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfCGKXB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:23:01 -0500
Received: from www62.your-server.de ([213.133.104.62]:47048 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfCGKW7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Mar 2019 05:22:59 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h1qAy-0002sn-NR; Thu, 07 Mar 2019 11:22:56 +0100
Received: from [178.197.249.29] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h1qAy-000ML3-Eq; Thu, 07 Mar 2019 11:22:56 +0100
Subject: Re: [PATCH net] xsk: fix potential crash in xsk_diag_put_umem()
To:     Eric Dumazet <edumazet@google.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     netdev <netdev@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        bpf <bpf@vger.kernel.org>, syzbot <syzkaller@googlegroups.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        Magnus Karlsson <magnus.karlsson@intel.com>
References: <20190305173126.167142-1-edumazet@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2411b303-0ef5-ec67-cab9-e43e543d6b10@iogearbox.net>
Date:   Thu, 7 Mar 2019 11:22:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190305173126.167142-1-edumazet@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25380/Wed Mar  6 10:23:41 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/05/2019 06:31 PM, Eric Dumazet wrote:
> Fixes two typos in xsk_diag_put_umem()
> 
> syzbot reported the following crash :
> 
> kasan: CONFIG_KASAN_INLINE enabled
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 7641 Comm: syz-executor946 Not tainted 5.0.0-rc7+ #95
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:xsk_diag_put_umem net/xdp/xsk_diag.c:71 [inline]
> RIP: 0010:xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
> RIP: 0010:xsk_diag_dump+0xdcb/0x13a0 net/xdp/xsk_diag.c:143
[...]
> 
> Fixes: a36b38aa2af6 ("xsk: add sock_diag interface for AF_XDP")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Cc: Björn Töpel <bjorn.topel@intel.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Magnus Karlsson <magnus.karlsson@intel.com>

Applied, thanks!
