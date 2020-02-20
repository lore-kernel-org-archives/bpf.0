Return-Path: <SRS0=tRXP=4I=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A425C5ACC4
	for <bpf@archiver.kernel.org>; Thu, 20 Feb 2020 00:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2429207FD
	for <bpf@archiver.kernel.org>; Thu, 20 Feb 2020 00:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgBTATb convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Wed, 19 Feb 2020 19:19:31 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49372 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbgBTATb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Feb 2020 19:19:31 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 1897915BCF42D;
        Wed, 19 Feb 2020 16:19:30 -0800 (PST)
Date:   Wed, 19 Feb 2020 16:19:29 -0800 (PST)
Message-Id: <20200219.161929.816816918618854813.davem@davemloft.net>
To:     ilias.apalodimas@linaro.org
Cc:     netdev@vger.kernel.org, jonathan.lemon@gmail.com,
        lorenzo@kernel.org, toke@redhat.com, thomas.petazzoni@bootlin.com,
        jaswinder.singh@linaro.org, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, joabreu@synopsys.com,
        mcoquelin.stm32@gmail.com, hawk@kernel.org, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: page_pool: API cleanup and comments
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200218141031.377860-1-ilias.apalodimas@linaro.org>
References: <20200218141031.377860-1-ilias.apalodimas@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 19 Feb 2020 16:19:30 -0800 (PST)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 18 Feb 2020 16:10:31 +0200

> Functions starting with __ usually indicate those which are exported,
> but should not be called directly. Update some of those declared in the
> API and make it more readable.
> 
> page_pool_unmap_page() and page_pool_release_page() were doing
> exactly the same thing calling __page_pool_clean_page().  Let's
> rename __page_pool_clean_page() to page_pool_release_page() and
> export it in order to show up on perf logs and get rid of
> page_pool_unmap_page().
> 
> Finally rename __page_pool_put_page() to page_pool_put_page() since we
> can now directly call it from drivers and rename the existing
> page_pool_put_page() to page_pool_put_full_page() since they do the same
> thing but the latter is trying to sync the full DMA area.
> 
> This patch also updates netsec, mvneta and stmmac drivers which use
> those functions.
> 
> Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

This doesn't apply cleanly, please respin.

Thank you.
