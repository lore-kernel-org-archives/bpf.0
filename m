Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 303CFC6FD19
	for <bpf@archiver.kernel.org>; Mon, 13 Mar 2023 18:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjCMSvn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 13 Mar 2023 14:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCMSvm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 14:51:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACE287D90
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 11:51:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7913DB811E9
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 18:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3CE74C4339B;
        Mon, 13 Mar 2023 18:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678733417;
        bh=AzO+ysYVRIeMEIs28j2IoGDz1t0ZNmiYWWccnKLlnIs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ftyyFXXjFJdw5yPHuuYmRbmjQHm6jhk+09oyUR//ksthgLg/sF9YrhwzJHUAN3GVQ
         mlaM8C/IJHGX4GEBGEYvczWP5rAyP4ZkVDobT7V2hICPNd/NKxG9KBn4C4H1itBoTp
         5z/R3DSgLd/n+mM1gCQmPk1Q3pmzwg7jUBAy1GfhQ3zpexsyqD4rj8l35ELlf01Vn+
         Yi/s2+33Y64dJluBH3lPg5zevQW1ZReJWvPxY4Wg9UJZdcdIVAU3vcCmVSmua6tlke
         Y2j3elaoXnybe4HDIVJ653InFrsVegBh8UaBm0g8DxTJEuXdUATv2MywLVgkdW3Acx
         +WfV28f9x5+dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23A8BC43161;
        Mon, 13 Mar 2023 18:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: fix precision propagation verbose logging
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167873341714.21585.6250521476360743415.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Mar 2023 18:50:17 +0000
References: <20230313184017.4083374-1-andrii@kernel.org>
In-Reply-To: <20230313184017.4083374-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@meta.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 13 Mar 2023 11:40:17 -0700 you wrote:
> Fix wrong order of frame index vs register/slot index in precision
> propagation verbose (level 2) output. It's wrong and very confusing as is.
> 
> Fixes: 529409ea92d5 ("bpf: propagate precision across all frames, not just the last one")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/verifier.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf: fix precision propagation verbose logging
    https://git.kernel.org/bpf/bpf-next/c/34f0677e7afd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


