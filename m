Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E239C4332B
	for <bpf@archiver.kernel.org>; Sat, 16 Jan 2021 04:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E7523A75
	for <bpf@archiver.kernel.org>; Sat, 16 Jan 2021 04:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbhAPEUt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Jan 2021 23:20:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728608AbhAPEUs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jan 2021 23:20:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 54C2E23A75;
        Sat, 16 Jan 2021 04:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610770808;
        bh=4Hjf+SYTiUwRYEi7Ch8ciAf1Kf+uxPk3UycOlwbAOP4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=T5s1fLVtK6DmptrPCct/ycA0dCoxDMBFndq3EcEhOMCrSwM907xKlMD4gG/xQqVVO
         HU3eNt1ayzLMlvWV/5dlGr3hwbwyCbe1Qhe/Cxwr/lwRlqbJncV21w5bcQGu+8lGHX
         TGMKZrEua1/eILeesm8h2Byb0ETjaBUJ0Yd5CoMD/hsw7P2CtWXKYautH1H9qZza8e
         rOO3FJ4bvbzzWUJE29zA8gzNmKaVawizGTcqYWa3uXzrMED1J+5/2LhmBE19dPxI0V
         ekCAGrTRH/JQDFdt7SSOsuRPKvYNaLIGR8RbZehJ8K+Im29LvQNUt+oALxTgvpmpnE
         grerCx3D0VCbg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: tap: check vlan with eth_type_vlan() method
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161077080829.25355.1708567039756626049.git-patchwork-notify@kernel.org>
Date:   Sat, 16 Jan 2021 04:20:08 +0000
References: <20210115023238.4681-1-dong.menglong@zte.com.cn>
In-Reply-To: <20210115023238.4681-1-dong.menglong@zte.com.cn>
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     kuba@kernel.org, davem@davemloft.net, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, dong.menglong@zte.com.cn
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Thu, 14 Jan 2021 18:32:38 -0800 you wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> Replace some checks for ETH_P_8021Q and ETH_P_8021AD in
> drivers/net/tap.c with eth_type_vlan.
> 
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: tap: check vlan with eth_type_vlan() method
    https://git.kernel.org/netdev/net-next/c/b69df2608281

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


