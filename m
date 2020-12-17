Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6AAC4361B
	for <bpf@archiver.kernel.org>; Thu, 17 Dec 2020 21:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F136223A54
	for <bpf@archiver.kernel.org>; Thu, 17 Dec 2020 21:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbgLQVwV (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 17 Dec 2020 16:52:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:34934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731896AbgLQVwV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Dec 2020 16:52:21 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608241900;
        bh=EFmsj5MotFmgfBv5iky15f0a26zMN/tUOZ39knmVtxg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IrZxBpssw8KnTn1E8777xfJf/tTb+BE9msq/lC2EAsVEkTIpuWghdE6KhPs93V4t4
         avMLbb1QO+YrIw1yD2xvwwW5UOMDck5PT2zzoYvjCFct/40Tdv/RYmPoYcZLH08wZ7
         NcEWR1dXrzUNOXqMzEcD/iq7sfYuhAj70kbgt3xcAOUz2i5SkkIhE52z8U3NnG/m7U
         MA0S16+39P7bnSAVl8r8azzPIgC3ivmvXR4MtMA6TXtpOV1lueIRs9ZaJbedVhEmtX
         SU8bn4+ksP9VarcZrpICKlsDrrqJb5vBYA6XqvYHBhFR7X24B4HLoFYdkoOt+JGB1h
         RN1f8a2T+sbFQ==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] xsk: fix memory leak for failed bind
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160824190054.27821.1116135617027194862.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Dec 2020 21:51:40 +0000
References: <20201214085127.3960-1-magnus.karlsson@gmail.com>
In-Reply-To: <20201214085127.3960-1-magnus.karlsson@gmail.com>
To:     Magnus Karlsson <magnus.karlsson@gmail.com>
Cc:     magnus.karlsson@intel.com, bjorn.topel@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org,
        jonathan.lemon@gmail.com, bpf@vger.kernel.org,
        syzbot+cfa88ddd0655afa88763@syzkaller.appspotmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Mon, 14 Dec 2020 09:51:27 +0100 you wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Fix a possible memory leak when a bind of an AF_XDP socket fails. When
> the fill and completion rings are created, they are tied to the
> socket. But when the buffer pool is later created at bind time, the
> ownership of these two rings are transferred to the buffer pool as
> they might be shared between sockets (and the buffer pool cannot be
> created until we know what we are binding to). So, before the buffer
> pool is created, these two rings are cleaned up with the socket, and
> after they have been transferred they are cleaned up together with
> the buffer pool.
> 
> [...]

Here is the summary with links:
  - [bpf] xsk: fix memory leak for failed bind
    https://git.kernel.org/bpf/bpf/c/8bee68338408

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


