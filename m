Return-Path: <SRS0=d9P3=VC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F10CC5B57D
	for <bpf@archiver.kernel.org>; Fri,  5 Jul 2019 22:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC3F21738
	for <bpf@archiver.kernel.org>; Fri,  5 Jul 2019 22:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725764AbfGEWVy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 5 Jul 2019 18:21:54 -0400
Received: from www62.your-server.de ([213.133.104.62]:60502 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfGEWVx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Jul 2019 18:21:53 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hjWaV-0006Mg-OU; Sat, 06 Jul 2019 00:21:51 +0200
Received: from [178.193.45.231] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hjWaV-0007QK-Io; Sat, 06 Jul 2019 00:21:51 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: add test_tcp_rtt to .gitignore
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org,
        Andrii Nakryiko <andriin@fb.com>
References: <20190703200952.159728-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d9e078d0-b1bd-1d6b-bfb3-19bca72976ea@iogearbox.net>
Date:   Sat, 6 Jul 2019 00:21:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190703200952.159728-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25501/Fri Jul  5 10:01:52 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/03/2019 10:09 PM, Stanislav Fomichev wrote:
> Forgot to add it in the original patch.
> 
> Fixes: b55873984dab ("selftests/bpf: test BPF_SOCK_OPS_RTT_CB")
> Reported-by: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Applied, thanks!
