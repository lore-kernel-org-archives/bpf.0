Return-Path: <SRS0=N94o=5J=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FF1C10DCE
	for <bpf@archiver.kernel.org>; Tue, 24 Mar 2020 04:54:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 533C720663
	for <bpf@archiver.kernel.org>; Tue, 24 Mar 2020 04:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgCXEyY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 24 Mar 2020 00:54:24 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56398 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgCXEyX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Mar 2020 00:54:23 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 233D3157A5EBC;
        Mon, 23 Mar 2020 21:54:23 -0700 (PDT)
Date:   Mon, 23 Mar 2020 21:54:22 -0700 (PDT)
Message-Id: <20200323.215422.456286022120023020.davem@davemloft.net>
To:     zhengzengkai@huawei.com
Cc:     sgoutham@marvell.com, rrichter@marvell.com, ast@kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] net: thunderx: remove set but not used
 variable 'tail'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200323065116.45399-1-zhengzengkai@huawei.com>
References: <20200323065116.45399-1-zhengzengkai@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 23 Mar 2020 21:54:23 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Zheng Zengkai <zhengzengkai@huawei.com>
Date: Mon, 23 Mar 2020 14:51:16 +0800

> From: Zheng zengkai <zhengzengkai@huawei.com>
> 
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/ethernet/cavium/thunder/nicvf_queues.c: In function nicvf_sq_free_used_descs:
> drivers/net/ethernet/cavium/thunder/nicvf_queues.c:1182:12: warning:
>  variable tail set but not used [-Wunused-but-set-variable]
> 
> It's not used since commit 4863dea3fab01("net: Adding support for Cavium ThunderX network controller"),
> so remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng zengkai <zhengzengkai@huawei.com>

Applied, thank you.
