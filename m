Return-Path: <SRS0=glaE=3A=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E7BC33C9E
	for <bpf@archiver.kernel.org>; Sat, 11 Jan 2020 07:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36262206DA
	for <bpf@archiver.kernel.org>; Sat, 11 Jan 2020 07:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgAKHLf (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 11 Jan 2020 02:11:35 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44208 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbgAKHLf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Jan 2020 02:11:35 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:1c3::f0c])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6EBBF14FA41BF;
        Fri, 10 Jan 2020 23:11:34 -0800 (PST)
Date:   Fri, 10 Jan 2020 23:11:33 -0800 (PST)
Message-Id: <20200110.231133.366069857384555250.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     ast@kernel.org, daniel@iogearbox.net, jakub.kicinski@netronome.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] sfc: remove duplicated include from ef10.c
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200110013517.37685-1-yuehaibing@huawei.com>
References: <20200110013517.37685-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 10 Jan 2020 23:11:34 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Fri, 10 Jan 2020 01:35:17 +0000

> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied, thanks.
