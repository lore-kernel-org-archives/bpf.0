Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13EFAC43334
	for <bpf@archiver.kernel.org>; Wed, 13 Jul 2022 19:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiGMTKQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 Jul 2022 15:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbiGMTKP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 15:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB111EEEA
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 12:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2B4F061DC6
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 19:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 809FEC341C0;
        Wed, 13 Jul 2022 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657739413;
        bh=9yW1AZXL0CmMFTTuSbhdXNdzL+aF4eAEt3iNx5ma2to=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jKAvjhyWPdnHLkdUen56TsrUKn9z1QuC0pTAIY7fbMMqHcpGDL3S0Ugfy6Oo4b6GI
         R++Ye2+Cvv/kc7x5eCch92KYbIpZl/fz0cOH9U5skh9kl6UEiceNqVAqiLps2cojYP
         yovsixz/G3H/J/OIzURNzZfDYdmLiCEL3fgZiQXw4UD7tqnaXxXiWnsYolCmL2u8/S
         SSqrPWE9yadPFTD1dYX+arJLRvjxkrCmSDsrpnuZUHFqbgD7pCN+wEdQzkmg55mjgd
         c7czHSxppyIvtjNPYUE/0nhjkgTdBE702bMfyEs96nSzDNUxRTQs0JBP6wPSWjNk5C
         bfrMdBT5yq26A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6458AE4522E;
        Wed, 13 Jul 2022 19:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: Error out when binary_path is NULL for
 uprobe and USDT
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165773941340.10137.12598431657420079595.git-patchwork-notify@kernel.org>
Date:   Wed, 13 Jul 2022 19:10:13 +0000
References: <20220712025745.2703995-1-hengqi.chen@gmail.com>
In-Reply-To: <20220712025745.2703995-1-hengqi.chen@gmail.com>
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 12 Jul 2022 10:57:45 +0800 you wrote:
> binary_path is a required non-null parameter for bpf_program__attach_usdt
> and bpf_program__attach_uprobe_opts. Check it against NULL to prevent
> coredump on strchr.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: Error out when binary_path is NULL for uprobe and USDT
    https://git.kernel.org/bpf/bpf-next/c/8ed2f5a6f385

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


