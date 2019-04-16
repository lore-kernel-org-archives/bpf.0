Return-Path: <SRS0=hZ0g=SS=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBC8C10F13
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50B0A2086A
	for <bpf@archiver.kernel.org>; Tue, 16 Apr 2019 08:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfDPI1K (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:27:10 -0400
Received: from www62.your-server.de ([213.133.104.62]:59128 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfDPI1J (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Apr 2019 04:27:09 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJQq-00067q-2U; Tue, 16 Apr 2019 10:27:08 +0200
Received: from [178.197.249.32] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hGJQp-000TTe-Pi; Tue, 16 Apr 2019 10:27:07 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: bring back (void *) cast to
 set_ipv4_csum in test_tc_tunnel
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org,
        Alan Maguire <alan.maguire@oracle.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>
References: <20190411225316.125106-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f796bf2e-162f-4a9a-f540-c90f31ee06a9@iogearbox.net>
Date:   Tue, 16 Apr 2019 10:27:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190411225316.125106-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25420/Mon Apr 15 09:57:25 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/12/2019 12:53 AM, Stanislav Fomichev wrote:
> It was removed in commit 166b5a7f2ca3 ("selftests_bpf: extend
> test_tc_tunnel for UDP encap") without any explanation.
> 
> Otherwise I see:
> progs/test_tc_tunnel.c:160:17: warning: taking address of packed member 'ip' of class or structure
>       'v4hdr' may result in an unaligned pointer value [-Waddress-of-packed-member]
>         set_ipv4_csum(&h_outer.ip);
>                        ^~~~~~~~~~
> 1 warning generated.
> 
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Fixes: 166b5a7f2ca3 ("selftests_bpf: extend test_tc_tunnel for UDP encap")
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Applied, thanks!
