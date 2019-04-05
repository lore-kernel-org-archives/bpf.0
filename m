Return-Path: <SRS0=rZCH=SH=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDC1C4360F
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 10:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED31F21850
	for <bpf@archiver.kernel.org>; Fri,  5 Apr 2019 10:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730609AbfDEKJ2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 5 Apr 2019 06:09:28 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:39114 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730283AbfDEKJ2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 5 Apr 2019 06:09:28 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hCLmE-0004oo-Fn; Fri, 05 Apr 2019 12:08:50 +0200
Date:   Fri, 5 Apr 2019 12:08:50 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     alexander.h.duyck@intel.com, amritha.nambiar@intel.com,
        ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, ecree@solarflare.com, idosch@mellanox.com,
        jiri@mellanox.com, kafai@fb.com, kuznet@ms2.inr.ac.ru,
        linux-kernel@vger.kernel.org, lirongqing@baidu.com,
        netdev@vger.kernel.org, petrm@mellanox.com, sd@queasysnail.net,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com,
        yoshfuji@linux-ipv6.org
Subject: Re: BUG: using __this_cpu_read() in preemptible code in
 ip6_finish_output
Message-ID: <20190405100850.tojfhy3ob5gprwo7@breakpoint.cc>
References: <000000000000e02450058593df62@google.com>
 <000000000000db3c59058595f0ac@google.com>
 <CAJKOXPcrimyMrK7LBbZLaqHGhS5dSCcBC1X01_pRY5evCD7n5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPcrimyMrK7LBbZLaqHGhS5dSCcBC1X01_pRY5evCD7n5Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Wed, 3 Apr 2019 at 03:14, syzbot
> <syzbot+51471b4aae195285a4a3@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this bug to:
> >
> > commit 97cdcf37b57e3f204be3000b9eab9686f38b4356
> > Author: Florian Westphal <fw@strlen.de>
> > Date:   Mon Apr 1 14:42:13 2019 +0000
> >
> >      net: place xmit recursion in softnet data
> 
> I am seeing this as well on ARMv7 board booted from NFS root (exynos_defconfig):

Sorry about this, the fix is now in net-next though:
28b05b92886871bdd ("net: use correct this_cpu primitive in dev_recursion_level")
