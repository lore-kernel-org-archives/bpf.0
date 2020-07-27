Return-Path: <SRS0=Ijne=BG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E91C433E1
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 17:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEFCB20714
	for <bpf@archiver.kernel.org>; Mon, 27 Jul 2020 17:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JGlQ42aW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbgG0R27 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730663AbgG0R27 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jul 2020 13:28:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0328FC0619D2;
        Mon, 27 Jul 2020 10:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=CmygioY1skJ3ZoZf02/bumjZmxuivqPuGfV1LmHfRLM=; b=JGlQ42aWhcaZ5SsiR7SUqB/XBc
        vI7bc74sMOmlxQNI5Nqdl1L6oRbZL/IY60XxkFSpUic2M9GxcY1j5GM3KM66MhO92R6lEbrZIGsQQ
        yb7PCg4SlEGh6f0nCeB5LtY/E5mz46Na6lneiuHN3g9uXOrDtzEFj2HgdnDK/CEvkeWkbhb1xh04v
        nVaElu3hkt0eY0RUOUh7aoF2HQSjrCLT0nPpVy5iSw3roqPgazOejDotpK9p1Iu3myGQ3MrD8fpON
        Sow1035sR/3mLKSuXj0q6jMwlTGSw9EvVtHu8hy9eo7WJOW2NeeKcUjiRcxCTV3+2S+dLGywXjPPn
        gGKWctDA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k06vk-00071Y-VA; Mon, 27 Jul 2020 17:28:55 +0000
Subject: Re: linux-next: Tree for Jul 27 (kernel/bpf/syscall.o)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20200727232346.0106c375@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e342e8ce-db29-1603-3fd9-40792a783296@infradead.org>
Date:   Mon, 27 Jul 2020 10:28:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727232346.0106c375@canb.auug.org.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/27/20 6:23 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20200724:
> 

on i386:
when CONFIG_XPS is not set/enabled:

ld: kernel/bpf/syscall.o: in function `__do_sys_bpf':
syscall.c:(.text+0x4482): undefined reference to `bpf_xdp_link_attach'


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
