Return-Path: <SRS0=saG7=5Y=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7EDC2BA2B
	for <bpf@archiver.kernel.org>; Wed,  8 Apr 2020 23:14:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1AA32082F
	for <bpf@archiver.kernel.org>; Wed,  8 Apr 2020 23:14:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDHXOH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 8 Apr 2020 19:14:07 -0400
Received: from www62.your-server.de ([213.133.104.62]:52748 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgDHXOH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Apr 2020 19:14:07 -0400
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1jMJtV-0006A0-3b; Thu, 09 Apr 2020 01:14:05 +0200
Received: from [178.195.186.98] (helo=pc-9.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1jMJtU-000DNi-Sz; Thu, 09 Apr 2020 01:14:04 +0200
Subject: Re: [PATCH bpf] bpf: Fix use of sk->sk_reuseport from sk_assign
To:     Joe Stringer <joe@wand.net.nz>, bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org
References: <20200408033540.10339-1-joe@wand.net.nz>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7be18104-f499-19af-a513-cfc39d2c491b@iogearbox.net>
Date:   Thu, 9 Apr 2020 01:14:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200408033540.10339-1-joe@wand.net.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.2/25776/Wed Apr  8 14:56:40 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/8/20 5:35 AM, Joe Stringer wrote:
> In testing, we found that for request sockets the sk->sk_reuseport field
> may yet be uninitialized, which caused bpf_sk_assign() to randomly
> succeed or return -ESOCKTNOSUPPORT when handling the forward ACK in a
> three-way handshake.
> 
> Fix it by only applying the reuseport check for full sockets.
> 
> Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
> Signed-off-by: Joe Stringer <joe@wand.net.nz>

Applied, thanks!
