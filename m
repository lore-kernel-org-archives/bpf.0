Return-Path: <SRS0=a4pm=AO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD38C433DF
	for <bpf@archiver.kernel.org>; Fri,  3 Jul 2020 21:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7E920884
	for <bpf@archiver.kernel.org>; Fri,  3 Jul 2020 21:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgGCVqm (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGCVqm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jul 2020 17:46:42 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5EBC061794;
        Fri,  3 Jul 2020 14:46:42 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CEDB1155DE0A3;
        Fri,  3 Jul 2020 14:46:40 -0700 (PDT)
Date:   Fri, 03 Jul 2020 14:46:39 -0700 (PDT)
Message-Id: <20200703.144639.1141703316199653510.davem@davemloft.net>
To:     mcroce@linux.microsoft.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, sven.auhagen@voleatech.de, lorenzo@kernel.org,
        brouer@redhat.com, stefanc@marvell.com, mw@semihalf.com,
        maxime.chevallier@bootlin.com, antoine.tenart@bootlin.com,
        thomas.petazzoni@bootlin.com, maciej.fijalkowski@intel.com,
        rmk+kernel@armlinux.org.uk
Subject: Re: [PATCH net-next v2 0/5] mvpp2: XDP support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200702141244.51295-1-mcroce@linux.microsoft.com>
References: <20200702141244.51295-1-mcroce@linux.microsoft.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 03 Jul 2020 14:46:41 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@linux.microsoft.com>
Date: Thu,  2 Jul 2020 16:12:39 +0200

> From: Matteo Croce <mcroce@microsoft.com>
> 
> From: Matteo Croce <mcroce@microsoft.com>
> 
> Add XDP support to mvpp2. This series converts the driver to the
> page_pool API for RX buffer management, and adds native XDP support.
> 
> XDP support comes with extack error reporting and statistics as well.
> 
> These are the performance numbers, as measured by Sven:
> 
> SKB fwd page pool:
> Rx bps     390.38 Mbps
> Rx pps     762.46 Kpps
> 
> XDP fwd:
> Rx bps     1.39 Gbps
> Rx pps     2.72 Mpps
> 
> XDP Drop:
> eth0: 12.9 Mpps
> eth1: 4.1 Mpps

Series applied, thank you.
