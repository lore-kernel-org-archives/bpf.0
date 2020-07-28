Return-Path: <SRS0=s4C/=BH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E2CC433E1
	for <bpf@archiver.kernel.org>; Tue, 28 Jul 2020 22:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB10D2074F
	for <bpf@archiver.kernel.org>; Tue, 28 Jul 2020 22:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgG1Wcb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:32:31 -0400
Received: from www62.your-server.de ([213.133.104.62]:45420 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgG1Wcb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 18:32:31 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1k0Y96-0003Fa-2e; Wed, 29 Jul 2020 00:32:28 +0200
Received: from [178.196.57.75] (helo=pc-9.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1k0Y95-000OIG-SE; Wed, 29 Jul 2020 00:32:27 +0200
Subject: Re: [PATCH bpf-next] bpf: fix build without CONFIG_NET when using BPF
 XDP link
To:     Andrii Nakryiko <andriin@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, rdunlap@infradead.org
Cc:     andrii.nakryiko@gmail.com, kernel-team@fb.com
References: <20200728190527.110830-1-andriin@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <7a5abe48-4ede-ed75-7ec1-bf3175411e01@iogearbox.net>
Date:   Wed, 29 Jul 2020 00:32:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200728190527.110830-1-andriin@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.102.3/25887/Tue Jul 28 17:44:20 2020)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/28/20 9:05 PM, Andrii Nakryiko wrote:
> Entire net/core subsystem is not built without CONFIG_NET. linux/netdevice.h
> just assumes that it's always there, so the easiest way to fix this is to
> conditionally compile out bpf_xdp_link_attach() use in bpf/syscall.c.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: aa8d3a716b59 ("bpf, xdp: Add bpf_link-based XDP attachment API")
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>

Applied, thanks!
