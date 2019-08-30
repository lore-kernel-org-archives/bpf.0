Return-Path: <SRS0=XeSK=W2=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF86C3A59B
	for <bpf@archiver.kernel.org>; Fri, 30 Aug 2019 23:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DF423429
	for <bpf@archiver.kernel.org>; Fri, 30 Aug 2019 23:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfH3XXw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 30 Aug 2019 19:23:52 -0400
Received: from www62.your-server.de ([213.133.104.62]:58908 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727304AbfH3XXw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Aug 2019 19:23:52 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i3qFB-0004Ip-DM; Sat, 31 Aug 2019 01:23:49 +0200
Received: from [178.197.249.19] (helo=pc-63.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i3qFB-000N8a-7e; Sat, 31 Aug 2019 01:23:49 +0200
Subject: Re: [bpf-next] bpf: fix error check in bpf_tcp_gen_syncookie
To:     Petar Penkov <ppenkov.kernel@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org,
        Petar Penkov <ppenkov@google.com>,
        Stanislav Fomichev <sdf@google.com>
References: <20190827234622.76209-1-ppenkov.kernel@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <74217193-2568-0fbf-ea2c-2737bdd9184d@iogearbox.net>
Date:   Sat, 31 Aug 2019 01:23:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190827234622.76209-1-ppenkov.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25557/Fri Aug 30 10:30:29 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/28/19 1:46 AM, Petar Penkov wrote:
> From: Petar Penkov <ppenkov@google.com>
> 
> If a SYN cookie is not issued by tcp_v#_gen_syncookie, then the return
> value will be exactly 0, rather than <= 0. Let's change the check to
> reflect that, especially since mss is an unsigned value and cannot be
> negative.
> 
> Fixes: 70d66244317e ("bpf: add bpf_tcp_gen_syncookie helper")
> Reported-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Petar Penkov <ppenkov@google.com>

Applied, thanks!
