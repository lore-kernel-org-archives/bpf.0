Return-Path: <SRS0=/x2n=CN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466A4C433E2
	for <bpf@archiver.kernel.org>; Fri,  4 Sep 2020 13:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FC222073B
	for <bpf@archiver.kernel.org>; Fri,  4 Sep 2020 13:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgIDNJS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:09:18 -0400
Received: from www62.your-server.de ([213.133.104.62]:49300 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730310AbgIDNJQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 09:09:16 -0400
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1kEBSs-0000lQ-Og; Fri, 04 Sep 2020 15:09:14 +0200
Received: from [2001:1620:665:0:5795:5b0a:e5d5:5944] (helo=linux.fritz.box)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1kEBSs-000BQq-JG; Fri, 04 Sep 2020 15:09:14 +0200
Subject: Re: [PATCH bpf-next 1/2] libbpf: fix another __u64 cast in printf
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com
References: <20200904041611.1695163-1-andriin@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <8efdf19f-9353-b38f-e5c6-c4f3074ff591@iogearbox.net>
Date:   Fri, 4 Sep 2020 15:09:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200904041611.1695163-1-andriin@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.4/25919/Thu Sep  3 15:39:22 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/4/20 6:16 AM, Andrii Nakryiko wrote:
> Another issue of __u64 needing either %lu or %llu, depending on the
> architecture. Fix with cast to `unsigned long long`.
> 
> Fixes: 7e06aad52929 ("libbpf: Add multi-prog section support for struct_ops")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied, thanks!
