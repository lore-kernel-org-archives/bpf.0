Return-Path: <SRS0=MJ0i=RT=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C8AC43381
	for <bpf@archiver.kernel.org>; Sat, 16 Mar 2019 00:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFEDF218AC
	for <bpf@archiver.kernel.org>; Sat, 16 Mar 2019 00:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfCPAb3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Mar 2019 20:31:29 -0400
Received: from www62.your-server.de ([213.133.104.62]:38302 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCPAb3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Mar 2019 20:31:29 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h4xEU-00079w-OS; Sat, 16 Mar 2019 01:31:26 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h4xEU-0000q4-Ib; Sat, 16 Mar 2019 01:31:26 +0100
Subject: Re: [PATCH bpf] xsk: fix umem memory leak on cleanup
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, netdev@vger.kernel.org, jslaby@suse.cz
Cc:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        magnus.karlsson@intel.com, magnus.karlsson@gmail.com,
        bpf@vger.kernel.org
References: <20190313141549.17783-1-bjorn.topel@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <5a49783b-9ddb-af6f-494b-2aa28bffe513@iogearbox.net>
Date:   Sat, 16 Mar 2019 01:31:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190313141549.17783-1-bjorn.topel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25389/Fri Mar 15 08:52:25 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/13/2019 03:15 PM, Björn Töpel wrote:
> From: Björn Töpel <bjorn.topel@intel.com>
> 
> When the umem is cleaned up, the task that created it might already be
> gone. If the task was gone, the xdp_umem_release function did not free
> the pages member of struct xdp_umem.
> 
> It turned out that the task lookup was not needed at all; The code was
> a left-over when we moved from task accounting to user accounting [1].
> 
> This patch fixes the memory leak by removing the task lookup logic
> completely.
> 
> [1] https://lore.kernel.org/netdev/20180131135356.19134-3-bjorn.topel@gmail.com/
> 
> Link: https://lore.kernel.org/netdev/c1cb2ca8-6a14-3980-8672-f3de0bb38dfd@suse.cz/
> Fixes: c0c77d8fb787 ("xsk: add user memory registration support sockopt")
> Reported-by: Jiri Slaby <jslaby@suse.cz>
> Signed-off-by: Björn Töpel <bjorn.topel@intel.com>

Applied, thanks!
