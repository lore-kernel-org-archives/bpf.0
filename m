Return-Path: <SRS0=xp9Q=RK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97388C43381
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 10:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D4D420675
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 10:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfCGKa3 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 Mar 2019 05:30:29 -0500
Received: from www62.your-server.de ([213.133.104.62]:48320 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfCGKa0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Mar 2019 05:30:26 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h1qIC-0003Pf-7v; Thu, 07 Mar 2019 11:30:24 +0100
Received: from [178.197.249.29] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h1qIB-0008Er-UM; Thu, 07 Mar 2019 11:30:24 +0100
Subject: Re: [PATCH bpf] selftests: bpf: test_progs: initialize duration in
 singal_pending test
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org
References: <20190306232526.219483-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <184cf035-fcbe-478a-f017-e65b89a2e4d3@iogearbox.net>
Date:   Thu, 7 Mar 2019 11:30:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190306232526.219483-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25380/Wed Mar  6 10:23:41 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/07/2019 12:25 AM, Stanislav Fomichev wrote:
> CHECK macro implicitly uses duration. We call CHECK() a couple of times
> before duration is initialized from bpf_prog_test_run().
> Explicitly set duration to 0 to avoid compiler warnings.
> 
> Fixes: 740f8a657221 ("selftests/bpf: make sure signal interrupts BPF_PROG_TEST_RUN")
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Applied, thanks!
