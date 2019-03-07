Return-Path: <SRS0=xp9Q=RK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2C1C43381
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 10:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E6C20675
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 10:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfCGK3q (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:29:46 -0500
Received: from www62.your-server.de ([213.133.104.62]:48230 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfCGK3q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Mar 2019 05:29:46 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h1qHY-0003M9-DB; Thu, 07 Mar 2019 11:29:44 +0100
Received: from [178.197.249.29] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h1qHX-0004pg-W2; Thu, 07 Mar 2019 11:29:44 +0100
Subject: Re: [PATCH bpf 1/2] selftests: bpf: fix compilation with out-of-tree
 $(OUTPUT)
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org
References: <20190306195927.208503-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <21fb1443-4e0a-fcdc-f649-eada06e09420@iogearbox.net>
Date:   Thu, 7 Mar 2019 11:29:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190306195927.208503-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25380/Wed Mar  6 10:23:41 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/06/2019 08:59 PM, Stanislav Fomichev wrote:
> A bunch of related changes lumped together:
> * Create prog_tests and verifier output directories; these don't exist with
>   out-of-tree $(OUTPUT)
> * Add missing -I (via separate TEST_{PROGS,VERIFIER}_CFLAGS) for the main tree
>   ($(PWD) != $(OUTPUT) for out-of-tree)
> * Add libbpf.a dependency for test_progs_32 (parallel make fails otherwise)
> * Add missing "; \" after "cd" when generating test.h headers
> 
> Tested by:
> $ alias m="make -s -j$(nproc)"
> $ m -C tools/testing/selftests/bpf/ clean
> $ m -C tools/lib/bpf/ clean
> $ rm -rf xxx; mkdir xxx; m -C tools/testing/selftests/bpf/ OUTPUT=$PWD/xxx
> $ m -C tools/testing/selftests/bpf/
> 
> Fixes: 3f30658830f3 ("selftests: bpf: break up test_progs - preparations")
> Fixes: 2dfb40121ee8 ("selftests: bpf: prepare for break up of verifier tests")
> Fixes: 3ef84346c561 ("selftests: bpf: makefile support sub-register code-gen test mode")
> 

Btw, please no newline between these tags, I've fixed it up.

> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Applied, thanks!
