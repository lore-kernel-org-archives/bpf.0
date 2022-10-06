Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E386AC433F5
	for <bpf@archiver.kernel.org>; Thu,  6 Oct 2022 17:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiJFRaS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 6 Oct 2022 13:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJFRaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 13:30:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8700C82D12
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 10:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 22B7861A38
        for <bpf@vger.kernel.org>; Thu,  6 Oct 2022 17:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75CD9C433B5;
        Thu,  6 Oct 2022 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665077415;
        bh=20bL7YSAXv4HVZkZz+p54hzoXH5fGdMKkuZgpF7t6ew=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OUAOlPmm3re1IFqnnr4ZmbMrlCR9iCYIdEUPoY6W66k4PKUhzEY/SYOPnSJl7bM3k
         vtseGPVax/G6P6P60ObwaYOvZrXwsTN22G1JpJ/tMv3HCcNsk4mOSIQzKzOCXr29f/
         2MChqPx2buE8IufVSlEPealkSbQnA92+Lt8XWu6KRr7DUAHP5uvHetzzi2yEqJ2uJM
         QBHviMA4pxO5OX5yjLo/imviVAyLVkzE5YYwMBrhV3+D7QlkdLOGqaKDgLPvQsZmrC
         sgJ5bKJJdI4uQWgx+lWPmwnzow3FDzPoJJXzxriH/CmFaJ0OYNhmu7d6B+MroFkUxK
         6fYfOhGEpCsaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5E33AE2A05F;
        Thu,  6 Oct 2022 17:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 bpf-next] selftests/bpf: Add missing
 bpf_iter_vma_offset__destroy call
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166507741538.29602.15781463786556703500.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Oct 2022 17:30:15 +0000
References: <20221006083106.117987-1-jolsa@kernel.org>
In-Reply-To: <20221006083106.117987-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kuifeng@fb.com, bpf@vger.kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu,  6 Oct 2022 10:31:06 +0200 you wrote:
> Adding missing bpf_iter_vma_offset__destroy call and using in-skeletin
> link pointer so we don't need extra bpf_link__destroy call.
> 
> Fixes: b3e1331eb925 ("selftests/bpf: Test parameterized task BPF iterators.")
> Cc: Kui-Feng Lee <kuifeng@fb.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> [...]

Here is the summary with links:
  - [PATCHv2,bpf-next] selftests/bpf: Add missing bpf_iter_vma_offset__destroy call
    https://git.kernel.org/bpf/bpf-next/c/1d2d941bc140

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


