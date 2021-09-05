Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE70C433F5
	for <bpf@archiver.kernel.org>; Sun,  5 Sep 2021 12:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F022B61039
	for <bpf@archiver.kernel.org>; Sun,  5 Sep 2021 12:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237917AbhIEMLI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 5 Sep 2021 08:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234382AbhIEMLI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Sep 2021 08:11:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 12B1E61027;
        Sun,  5 Sep 2021 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630843805;
        bh=eCRJ5yerTqnwpninFmP8ox7avYfWeyLMV+GF7C/+Qeo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=r/2NdhEgwfZyWmgwck6pDPlE3YfRHGouCoinG/kXJiNkVA2/8QsW4TOtWUgmb0W0P
         2NHojWpuV9UmIm7b3fiVhGqhLgnAekojXaXjqNDEhzIH6/62qx2/37ymITpc4VMXQ8
         pTXCtdbQ4DTkv9bg/rOkyh193O4/puCb7XtresP6VVfsTLeh9hnRQFHKXyMvddbObW
         sxztyekScWwws0qwYD0zuhhoEzn6oG0MujXw+f3XpIMNeeLPgVMGLexr5D52cwNRwr
         IFJhsfahVCBrYC2G3yl8bVZkdJydM5f6o8du6ul2o979SYvCtCEYD2K+ShVa59wVip
         3zrm4p2WDmB6Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: stmmac: Fix overall budget calculation for
 rxtx_napi
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163084380500.2594.10060610886272582296.git-patchwork-notify@kernel.org>
Date:   Sun, 05 Sep 2021 12:10:05 +0000
References: <20210903020026.1381962-1-yoong.siang.song@intel.com>
In-Reply-To: <20210903020026.1381962-1-yoong.siang.song@intel.com>
To:     Song Yoong Siang <yoong.siang.song@intel.com>
Cc:     peppe.cavallaro@st.com, alexandre.torgue@st.com,
        joabreu@synopsys.com, davem@davemloft.net, kuba@kernel.org,
        mcoquelin.stm32@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com,
        boon.leong.ong@intel.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Fri,  3 Sep 2021 10:00:26 +0800 you wrote:
> tx_done is not used for napi_complete_done(). Thus, NAPI busy polling
> mechanism by gro_flush_timeout and napi_defer_hard_irqs will not able
> be triggered after a packet is transmitted when there is no receive
> packet.
> 
> Fix this by taking the maximum value between tx_done and rx_done as
> overall budget completed by the rxtx NAPI poll to ensure XDP Tx ZC
> operation is continuously polling for next Tx frame. This gives
> benefit of lower packet submission processing latency and jitter
> under XDP Tx ZC mode.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: stmmac: Fix overall budget calculation for rxtx_napi
    https://git.kernel.org/netdev/net/c/81d0885d68ec

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


