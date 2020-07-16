Return-Path: <SRS0=dSfD=A3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228FFC433E1
	for <bpf@archiver.kernel.org>; Thu, 16 Jul 2020 19:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04E332083B
	for <bpf@archiver.kernel.org>; Thu, 16 Jul 2020 19:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgGPTDO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 16 Jul 2020 15:03:14 -0400
Received: from www62.your-server.de ([213.133.104.62]:36614 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729496AbgGPTDN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jul 2020 15:03:13 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jw99q-0007tR-2w; Thu, 16 Jul 2020 21:03:02 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jw99p-000PJA-TM; Thu, 16 Jul 2020 21:03:01 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: fix possible hang in
 sockopt_inherit
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org,
        Andrii Nakryiko <andriin@fb.com>
References: <20200715224107.3591967-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c63f1825-bea8-b59c-20fe-e5717aae15c7@iogearbox.net>
Date:   Thu, 16 Jul 2020 21:02:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200715224107.3591967-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25875/Thu Jul 16 16:46:30 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/16/20 12:41 AM, Stanislav Fomichev wrote:
> Andrii reported that sockopt_inherit occasionally hangs up on 5.5 kernel [0].
> This can happen if server_thread runs faster than the main thread.
> In that case, pthread_cond_wait will wait forever because
> pthread_cond_signal was executed before the main thread was blocking.
> Let's move pthread_mutex_lock up a bit to make sure server_thread
> runs strictly after the main thread goes to sleep.
> 
> (Not sure why this is 5.5 specific, maybe scheduling is less
> deterministic? But I was able to confirm that it does indeed
> happen in a VM.)
> 
> [0] https://lore.kernel.org/bpf/CAEf4BzY0-bVNHmCkMFPgObs=isUAyg-dFzGDY7QWYkmm7rmTSg@mail.gmail.com/
> 
> Reported-by: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Applied, thanks!
