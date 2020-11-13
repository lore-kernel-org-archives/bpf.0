Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ADCAC388F7
	for <bpf@archiver.kernel.org>; Fri, 13 Nov 2020 15:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10206208D5
	for <bpf@archiver.kernel.org>; Fri, 13 Nov 2020 15:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgKMPcP (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 13 Nov 2020 10:32:15 -0500
Received: from www62.your-server.de ([213.133.104.62]:55972 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgKMPcP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Nov 2020 10:32:15 -0500
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1kdb3a-0000SZ-Oi; Fri, 13 Nov 2020 16:32:10 +0100
Received: from [85.7.101.30] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kdb3a-000NMT-Iv; Fri, 13 Nov 2020 16:32:10 +0100
Subject: Re: [PATCH v4 bpf] tools: bpftool: Add missing close before bpftool
 net attach exit
To:     Wang Hai <wanghai38@huawei.com>, andrii.nakryiko@gmail.com,
        mrostecki@opensuse.org, john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201113115152.53178-1-wanghai38@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c5831dbd-04be-cd4d-e18f-2c2388c69aa7@iogearbox.net>
Date:   Fri, 13 Nov 2020 16:32:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20201113115152.53178-1-wanghai38@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25987/Fri Nov 13 14:19:33 2020)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/13/20 12:51 PM, Wang Hai wrote:
> progfd is created by prog_parse_fd(), before 'bpftool net attach' exit,
> it should be closed.
> 
> Fixes: 04949ccc273e ("tools: bpftool: add net attach command to attach XDP on interface")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>

Applied & improved commit msg a bit, thanks!
