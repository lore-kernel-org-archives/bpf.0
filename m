Return-Path: <SRS0=81Vy=WU=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC9BC3A59E
	for <bpf@archiver.kernel.org>; Sat, 24 Aug 2019 21:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0606420870
	for <bpf@archiver.kernel.org>; Sat, 24 Aug 2019 21:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbfHXVXt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 24 Aug 2019 17:23:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:47756 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbfHXVXt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 24 Aug 2019 17:23:49 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 18D0115252E15;
        Sat, 24 Aug 2019 14:23:49 -0700 (PDT)
Date:   Sat, 24 Aug 2019 14:23:48 -0700 (PDT)
Message-Id: <20190824.142348.742100834261970478.davem@davemloft.net>
To:     xiaolinkui@kylinos.cn
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH] net: use unlikely for dql_avail case
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190822065816.23619-1-xiaolinkui@kylinos.cn>
References: <20190822065816.23619-1-xiaolinkui@kylinos.cn>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 24 Aug 2019 14:23:49 -0700 (PDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: xiaolinkui <xiaolinkui@kylinos.cn>
Date: Thu, 22 Aug 2019 14:58:16 +0800

> This is an unlikely case, use unlikely() on it seems logical.
> 
> Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>

Applied to net-next.
