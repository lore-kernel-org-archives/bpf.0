Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30209C48BDF
	for <bpf@archiver.kernel.org>; Fri, 18 Jun 2021 18:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 070EF613F2
	for <bpf@archiver.kernel.org>; Fri, 18 Jun 2021 18:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhFRSWN (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:22:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234175AbhFRSWN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Jun 2021 14:22:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 601BE613C2;
        Fri, 18 Jun 2021 18:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624040403;
        bh=6ywh9bHoVEBIVZNLwsBQgS4AZlK5lBo5UuyQGPd/S+s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=X5VNP4/j3k9on+MC4+VD4GXL0oQ0WLG7Acwn0Bvnk9352nIxGcbO/fv95fYxuSRaF
         2l3XrDZ4ZKXDd/KYP9jr/V6vesZBjaYD+kPVeiAVWDAfbi6lpfFl2egbu9qe08S1wi
         +Kz8WTloB680NTwb4vFg7ZBoHG1aGVcoYpbTRSwldoCDrkbQAzXBFNXYRERskDGKSU
         1W0rDk2HXy90AIWxV+s+rcwfi9a7xfuBvjmljgDjvBNQ2KXXDcaLun3Y+OQacrOq9N
         5RXps4lV+hdsSGMKWpb4mx32IR6jWkIqTHVB/Ei1g9sZSz4kWuSrGKKqygSWphJ/Un
         +aZARnmBdODKw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] samples/bpf: Fix Segmentation fault for xdp_redirect
 command
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162404040331.13927.1341543990901719711.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Jun 2021 18:20:03 +0000
References: <20210616042324.314832-1-wanghai38@huawei.com>
In-Reply-To: <20210616042324.314832-1-wanghai38@huawei.com>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        kpsingh@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 16 Jun 2021 12:23:24 +0800 you wrote:
> A Segmentation fault error is caused when the following command
> is executed.
> 
> $ sudo ./samples/bpf/xdp_redirect lo
> Segmentation fault
> 
> This command is missing a device <IFNAME|IFINDEX> as an argument, resulting
> in out-of-bounds access from argv.
> 
> [...]

Here is the summary with links:
  - [bpf] samples/bpf: Fix Segmentation fault for xdp_redirect command
    https://git.kernel.org/bpf/bpf-next/c/85102ba58b41

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


