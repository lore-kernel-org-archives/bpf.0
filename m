Return-Path: <SRS0=p5ic=RF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052F0C43381
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 00:00:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B7F20823
	for <bpf@archiver.kernel.org>; Sat,  2 Mar 2019 00:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbfCBAAx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 19:00:53 -0500
Received: from www62.your-server.de ([213.133.104.62]:39446 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCBAAx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 19:00:53 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzs5C-0000gv-Qg; Sat, 02 Mar 2019 01:00:50 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzs5C-00072e-J3; Sat, 02 Mar 2019 01:00:50 +0100
Subject: Re: [PATCH bpf-next v2 0/7] selftests: bpf: break up test_progs
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org
References: <20190228232440.28668-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c3b9965e-b987-a36a-e870-d8f8bb804262@iogearbox.net>
Date:   Sat, 2 Mar 2019 01:00:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190228232440.28668-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/01/2019 12:24 AM, Stanislav Fomichev wrote:
> Recently we had linux-next bpf/bpf-next conflict when we added new
> functionality to the test_progs.c at the same location. Let's split
> test_progs.c the same way we recently split test_verifier.c.
> 
> I follow the same patten we did in commit 2dfb40121ee8 ("selftests: bpf:
> prepare for break up of verifier tests") for verifier: create
> scaffolding to support dedicated files and slowly move the tests into
> separate files.
> 
> The first patch adds scaffolding, subsequent patches move progs into
> separate files.
> 
> In theory, many of the standalone tests can be migrated to this new
> framework as well. They get the benefit of common CHECK macro and
> bpf_find_map function which a lot of standalone tests need to redefine.
> 
> v2 changes:
> * added cover letter, added more description about file structure
> 
> Stanislav Fomichev (7):
>   selftests: bpf: break up test_progs - preparations
>   selftests: bpf: break up test_progs - pkt access
>   selftests: bpf: break up test_progs - xdp
>   selftests: bpf: break up test_progs - stackmap
>   selftests: bpf: break up test_progs - tracepoint
>   selftests: bpf: break up test_progs - spinlock
>   selftests: bpf: break up test_progs - misc

Looks good, thanks for bringing some structure into selftests! Series
failed to apply cleanly on the last patch though:

Switched to a new branch 'bpf-split-prog-tests'
Applying: selftests: bpf: break up test_progs - preparations
Applying: selftests: bpf: break up test_progs - pkt access
Applying: selftests: bpf: break up test_progs - xdp
Applying: selftests: bpf: break up test_progs - stackmap
Applying: selftests: bpf: break up test_progs - tracepoint
Applying: selftests: bpf: break up test_progs - spinlock
Applying: selftests: bpf: break up test_progs - misc
fatal: sha1 information is lacking or useless (tools/testing/selftests/bpf/test_progs.c).
error: could not build fake ancestor

Last commit in that file before this series is your ebace0e981b2
("selftests/bpf: use __bpf_constant_htons in test_prog.c for flow
dissector"), please respin with a fresh rebase.

Thanks,
Daniel
