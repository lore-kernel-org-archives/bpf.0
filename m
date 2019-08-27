Return-Path: <SRS0=gAxt=WX=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02401C3A5A3
	for <bpf@archiver.kernel.org>; Tue, 27 Aug 2019 22:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D46DF2186A
	for <bpf@archiver.kernel.org>; Tue, 27 Aug 2019 22:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbfH0Wov (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 27 Aug 2019 18:44:51 -0400
Received: from www62.your-server.de ([213.133.104.62]:34282 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfH0Wov (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Aug 2019 18:44:51 -0400
Received: from sslproxy01.your-server.de ([88.198.220.130])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i2kCk-0004SF-0M; Wed, 28 Aug 2019 00:44:46 +0200
Received: from [178.197.249.36] (helo=pc-63.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i2kCj-0004Gc-NF; Wed, 28 Aug 2019 00:44:45 +0200
Subject: Re: [PATCH bpf-next] selftests/bpf: remove wrong nhoff in flow
 dissector test
To:     Stanislav Fomichev <sdf@google.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org
References: <20190826222712.171177-1-sdf@google.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6fc02228-a752-7111-997c-ae807b6201e3@iogearbox.net>
Date:   Wed, 28 Aug 2019 00:44:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190826222712.171177-1-sdf@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25554/Tue Aug 27 10:24:33 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/27/19 12:27 AM, Stanislav Fomichev wrote:
> .nhoff = 0 is (correctly) reset to ETH_HLEN on the next line so let's
> drop it.
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Applied, thanks!
