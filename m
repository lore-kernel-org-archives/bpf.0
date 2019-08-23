Return-Path: <SRS0=I0lg=WT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDDDC3A5A2
	for <bpf@archiver.kernel.org>; Fri, 23 Aug 2019 23:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EDF20850
	for <bpf@archiver.kernel.org>; Fri, 23 Aug 2019 23:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbfHWXep (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 23 Aug 2019 19:34:45 -0400
Received: from www62.your-server.de ([213.133.104.62]:52488 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfHWXep (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Aug 2019 19:34:45 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i1J4t-0001mP-Ej; Sat, 24 Aug 2019 01:34:43 +0200
Received: from [178.197.249.40] (helo=pc-63.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i1J4t-000L5g-2s; Sat, 24 Aug 2019 01:34:43 +0200
Subject: Re: [PATCH bpf] flow_dissector: Fix potential use-after-free on
 BPF_PROG_DETACH
To:     Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Lorenz Bauer <lmb@cloudflare.com>
References: <20190821121720.22009-1-jakub@cloudflare.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <9d161f2c-5cf3-9400-f6fd-f121e352246d@iogearbox.net>
Date:   Sat, 24 Aug 2019 01:34:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190821121720.22009-1-jakub@cloudflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25550/Fri Aug 23 10:25:33 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/21/19 2:17 PM, Jakub Sitnicki wrote:
> Call to bpf_prog_put(), with help of call_rcu(), queues an RCU-callback to
> free the program once a grace period has elapsed. The callback can run
> together with new RCU readers that started after the last grace period.
> New RCU readers can potentially see the "old" to-be-freed or already-freed
> pointer to the program object before the RCU update-side NULLs it.
> 
> Reorder the operations so that the RCU update-side resets the protected
> pointer before the end of the grace period after which the program will be
> freed.
> 
> Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
> Reported-by: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>

Applied, thanks!
