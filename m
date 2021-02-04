Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00EAC433DB
	for <bpf@archiver.kernel.org>; Thu,  4 Feb 2021 00:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E8164F4A
	for <bpf@archiver.kernel.org>; Thu,  4 Feb 2021 00:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232867AbhBDAKs (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Feb 2021 19:10:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:33224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232762AbhBDAKr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 19:10:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 1374664F4A;
        Thu,  4 Feb 2021 00:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612397407;
        bh=L3ZfOc3RTF7zQ3JKDq2xAvPeuR5KXD5wzrVNNCSak5E=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MpvnAeUAiVyjQ1eSUJCLYxfh3m1k40JIDYm50Mhw1bz/ZmaJQ8hdCkh0P8pF54Kq4
         1IGTiY4SbhFe5CTAjSJEvU7uk9jy/kg3f7FEeXz8cSd7qILaHxK8IOmjb7BNe0l/8U
         OhoAJxgKI0VytVJ6umJdh6ZlgzjTgZGMEJCZV9R/+X4kpfROURZKviCypek9Qa0PKf
         igBMUPpHudG6RUZcPdVqCD+rE16i1N6rBn/WG4lPPHB3+YkQI47emJET4PUGkrCrWI
         8oNGQv3MCY3Afm35brDNHamLFd+RJQnikmjVWHSVU5HCUFunouKB5qhxtu0sPZqaon
         /01oMxGIxpsoA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] net: veth: alloc skb in bulk for ndo_xdp_xmit
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161239740702.9417.6621670773510084819.git-patchwork-notify@kernel.org>
Date:   Thu, 04 Feb 2021 00:10:07 +0000
References: <a14a30d3c06fff24e13f836c733d80efc0bd6eb5.1611957532.git.lorenzo@kernel.org>
In-Reply-To: <a14a30d3c06fff24e13f836c733d80efc0bd6eb5.1611957532.git.lorenzo@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
        kuba@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        toshiaki.makita1@gmail.com, lorenzo.bianconi@redhat.com,
        brouer@redhat.com, toke@redhat.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Fri, 29 Jan 2021 23:04:08 +0100 you wrote:
> Split ndo_xdp_xmit and ndo_start_xmit use cases in veth_xdp_rcv routine
> in order to alloc skbs in bulk for XDP_PASS verdict.
> Introduce xdp_alloc_skb_bulk utility routine to alloc skb bulk list.
> The proposed approach has been tested in the following scenario:
> 
> eth (ixgbe) --> XDP_REDIRECT --> veth0 --> (remote-ns) veth1 --> XDP_PASS
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] net: veth: alloc skb in bulk for ndo_xdp_xmit
    https://git.kernel.org/bpf/bpf-next/c/65e6dcf73398

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


