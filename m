Return-Path: <SRS0=8xVa=6M=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB1AC83000
	for <bpf@archiver.kernel.org>; Tue, 28 Apr 2020 19:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7509221707
	for <bpf@archiver.kernel.org>; Tue, 28 Apr 2020 19:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgD1Tt7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Apr 2020 15:49:59 -0400
Received: from www62.your-server.de ([213.133.104.62]:40180 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728559AbgD1Tt7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Apr 2020 15:49:59 -0400
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jTWEr-0003hO-Lx; Tue, 28 Apr 2020 21:49:53 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jTWEr-0006gW-90; Tue, 28 Apr 2020 21:49:53 +0200
Subject: Re: [PATCH -next] libbpf: Remove unneeded semicolon
To:     Zou Wei <zou_wei@huawei.com>, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1588064829-70613-1-git-send-email-zou_wei@huawei.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <fd053a28-8cc3-5c7a-7c23-4d9f0aec88f7@iogearbox.net>
Date:   Tue, 28 Apr 2020 21:49:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1588064829-70613-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25796/Tue Apr 28 14:00:48 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/28/20 11:07 AM, Zou Wei wrote:
> Fixes coccicheck warning:
> 
>   tools/lib/bpf/btf_dump.c:661:4-5: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Applied, thanks!
