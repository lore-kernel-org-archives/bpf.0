Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 505CAC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25F7B2085A
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 23:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfB1X6v (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:58:51 -0500
Received: from www62.your-server.de ([213.133.104.62]:56992 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfB1X6v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 18:58:51 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzVZg-0006Zf-D2; Fri, 01 Mar 2019 00:58:48 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzVZg-000D85-40; Fri, 01 Mar 2019 00:58:48 +0100
Subject: Re: [PATCH bpf-next] selftests/bpf: use __bpf_constant_htons in
 test_prog.c for flow dissector
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org
References: <20190227191511.80859-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <75f1fa50-fc62-7a9a-0493-29a08c771efe@iogearbox.net>
Date:   Fri, 1 Mar 2019 00:58:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190227191511.80859-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/27/2019 08:15 PM, Stanislav Fomichev wrote:
> Older GCC (<4.8) isn't smart enough to optimize !__builtin_constant_p()
> branch in bpf_htons.
> 
> I recently fixed it for pkt_v4 and pkt_v6 in commit a0517a0f7ef23
> ("selftests/bpf: use __bpf_constant_htons in test_prog.c"), but later
> added another bunch of bpf_htons in commit bf0f0fd939451 ("selftests/bpf:
> add simple BPF_PROG_TEST_RUN examples for flow dissector").
> 
> Fixes: bf0f0fd939451 ("selftests/bpf: add simple BPF_PROG_TEST_RUN examples for flow dissector")
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Applied, thanks!
