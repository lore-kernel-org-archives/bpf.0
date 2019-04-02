Return-Path: <SRS0=V8Hm=SE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C4BC4360F
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 21:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0862075E
	for <bpf@archiver.kernel.org>; Tue,  2 Apr 2019 21:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbfDBVT0 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:19:26 -0400
Received: from www62.your-server.de ([213.133.104.62]:52690 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfDBVT0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Apr 2019 17:19:26 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBQoV-0004VH-6d; Tue, 02 Apr 2019 23:19:23 +0200
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1hBQoU-0002Cw-Ua; Tue, 02 Apr 2019 23:19:23 +0200
Subject: Re: [PATCH bpf-next 0/4] selftests: bpf: support building selftests
 with clang and fix warnings
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org
References: <20190402170835.30732-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <4f126315-d385-0a5a-fbba-440ae519b9bf@iogearbox.net>
Date:   Tue, 2 Apr 2019 23:19:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190402170835.30732-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25407/Tue Apr  2 09:54:31 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 04/02/2019 07:08 PM, Stanislav Fomichev wrote:
> This series contains small fixes to make bpf selftests compile cleanly
> with clangs. All of them are not real problems, but it's nice to have
> an option to use clang for the tests themselves.
> 
> Stanislav Fomichev (4):
>   selftests: bpf: tests.h should depend on .c files, not the output
>   selftests: bpf: fix -Wformat-security warning for
>     flow_dissector_load.c
>   selftests: bpf: fix -Wformat-invalid-specifier for bpf_obj_id.c
>   selftests: bpf: remove duplicate .flags initialization in ctx_skb.c
> 
>  tools/testing/selftests/bpf/Makefile                | 4 ++--
>  tools/testing/selftests/bpf/flow_dissector_load.c   | 2 +-
>  tools/testing/selftests/bpf/prog_tests/bpf_obj_id.c | 8 ++++----
>  tools/testing/selftests/bpf/verifier/ctx_skb.c      | 1 -
>  4 files changed, 7 insertions(+), 8 deletions(-)
> 

Applied, thanks!
