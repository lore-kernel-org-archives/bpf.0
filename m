Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AD5C43460
	for <bpf@archiver.kernel.org>; Thu,  6 May 2021 23:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFCC0613D8
	for <bpf@archiver.kernel.org>; Thu,  6 May 2021 23:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhEFXbN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 6 May 2021 19:31:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:52030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231802AbhEFXbI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 May 2021 19:31:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D6F95613B5;
        Thu,  6 May 2021 23:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620343809;
        bh=mZ+MIQdIM3mzSl3Io6Yg/GSU0sdnx0Cwcr96d5Tp+ds=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kEI5Uhr/dk+s28rxK9rFJWwsXTtJjW84Ae5WI0udMOnnDkoyoya6FyTFM7a4dE7iW
         7ST+ZVNsoNZmx+QmXMFsNfOGwEJYtcUGoP1gwddiGcjwR2El2tgP3tIeSS3jHLZ1Iq
         8h6dgF9alOWzP2RLxc17VyK3tqfB+NYWLmo/i9pTiHksvHWgBLb+Yku/M3yyGsj18O
         SgF0yRlfbX8MkuJJgZdoNTBT3gghmXhRIKgUUUVArDrJdqYM27qpkIIDBFWM+41d7f
         kAaVWj9YusUERsTl+krHQp+ipaMg5HeKsLLlydIf1+wT+D38n8H6uXUHQYmDXQF6ua
         B7VAiG/Q4iCgA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] samples/bpf: consider frame size in tx_only of xdpsock
 sample
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162034380980.14975.13507815656502362582.git-patchwork-notify@kernel.org>
Date:   Thu, 06 May 2021 23:30:09 +0000
References: <20210506124349.6666-1-magnus.karlsson@gmail.com>
In-Reply-To: <20210506124349.6666-1-magnus.karlsson@gmail.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     magnus.karlsson@intel.com, bjorn@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com, bpf@vger.kernel.org,
        maciej.fijalkowski@intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Thu,  6 May 2021 14:43:49 +0200 you wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Fix the tx_only micro-benchmark in xdpsock to take frame size into
> consideration. It was hardcoded to the default value of frame_size
> which is 4K. Changing this on the command line to 2K made half of the
> packets illegal as they were outside the umem and were therefore
> discarded by the kernel.
> 
> [...]

Here is the summary with links:
  - [bpf] samples/bpf: consider frame size in tx_only of xdpsock sample
    https://git.kernel.org/bpf/bpf/c/3b80d106e110

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


