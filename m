Return-Path: <SRS0=hCIb=TV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53ABBC04AAF
	for <bpf@archiver.kernel.org>; Tue, 21 May 2019 17:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3445921019
	for <bpf@archiver.kernel.org>; Tue, 21 May 2019 17:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbfEURnb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 21 May 2019 13:43:31 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:42858 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbfEURnb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 May 2019 13:43:31 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::3d8])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B16AF146BB096;
        Tue, 21 May 2019 10:43:30 -0700 (PDT)
Date:   Tue, 21 May 2019 10:43:30 -0700 (PDT)
Message-Id: <20190521.104330.1268444854419644640.davem@davemloft.net>
To:     jiong.wang@netronome.com
Cc:     jose.marchesi@oracle.com, binutils@sourceware.org,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org
Subject: Re: [PATCH 0/9] eBPF support for GNU binutils
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1B2BE52B-527E-436E-AE49-29FA9E044FD3@netronome.com>
References: <20190520164526.13491-1-jose.marchesi_()_oracle_!_com>
        <1B2BE52B-527E-436E-AE49-29FA9E044FD3@netronome.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 May 2019 10:43:30 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Jiong Wang <jiong.wang@netronome.com>
Date: Tue, 21 May 2019 16:41:56 +0100

> CCing BPF kernel community who is defining the ISA and various runtime stuff.
> 
> Also two inline comments below about the assembler

Also, I already wrote such a binutils patch a year or two ago:

https://lwn.net/Articles/721473/
