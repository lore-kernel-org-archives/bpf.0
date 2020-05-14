Return-Path: <SRS0=rqwV=64=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1767EC433DF
	for <bpf@archiver.kernel.org>; Thu, 14 May 2020 07:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED7272065D
	for <bpf@archiver.kernel.org>; Thu, 14 May 2020 07:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgENH5L (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 14 May 2020 03:57:11 -0400
Received: from elvis.franken.de ([193.175.24.41]:53051 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgENH5L (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 May 2020 03:57:11 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jZ8js-0005U5-01; Thu, 14 May 2020 09:57:08 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 39DD7C0493; Thu, 14 May 2020 09:43:15 +0200 (CEST)
Date:   Thu, 14 May 2020 09:43:15 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] KVM: MIPS/TLB: Remove Unneeded semicolon in tlb.c
Message-ID: <20200514074315.GB5880@alpha.franken.de>
References: <20200428063245.32776-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428063245.32776-1-yanaijie@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 28, 2020 at 02:32:45PM +0800, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> arch/mips/kvm/tlb.c:472:2-3: Unneeded semicolon
> arch/mips/kvm/tlb.c:489:2-3: Unneeded semicolon
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  arch/mips/kvm/tlb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
