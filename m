Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65763CCA479
	for <bpf@archiver.kernel.org>; Thu, 21 Jul 2022 12:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232543AbiGUMaS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Jul 2022 08:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbiGUMaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jul 2022 08:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73A9E028;
        Thu, 21 Jul 2022 05:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E825B8245B;
        Thu, 21 Jul 2022 12:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01998C341CB;
        Thu, 21 Jul 2022 12:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658406614;
        bh=txJSRKRpmnX/OM6BcK0maKHWdxc+gPKeeMEv/+ncWoY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gEK4hCBrgRRkf9suhs08jS3KR8RD4vbPqoLeOGqQUsh/hFr/VAr8P/XqOV0frPKeM
         QDKBjGznza3thyLUEr4WtvOz100R2+HAC5uWmYRJxWb3XBrnXmMKETZitY7BGYvCKL
         MdsWn4AoFglbOxzlR/WJmt3mRLecBSIb4dB5GuwX9jl7kxX7aFgxD56CUNpueBRoyX
         Ftdv0HQZGR/4BnGgXwuhjj/DecyZt4pDUO4oIIdBECmtZAvMuHnah9UG63yXODhYO6
         l7rPVANbyQ2Cb4Z1p6Nfue4kVRrnoasnbWFTDSAFh9cmrlmNugZkp33v5S+c8bnmnt
         DcyvC8da0B+WA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB682E451B0;
        Thu, 21 Jul 2022 12:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] libbpf: fix sign expansion bug in btf_dump_get_enum_value()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165840661389.30255.12097142217891066504.git-patchwork-notify@kernel.org>
Date:   Thu, 21 Jul 2022 12:30:13 +0000
References: <YtZ+LpgPADm7BeEd@kili>
In-Reply-To: <YtZ+LpgPADm7BeEd@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     andrii@kernel.org, yhs@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 19 Jul 2022 12:49:34 +0300 you wrote:
> The code here is supposed to take a signed int and store it in a
> signed long long.  Unfortunately, the way that the type promotion works
> with this conditional statement is that it takes a signed int, type
> promotes it to a __u32, and then stores that as a signed long long.
> The result is never negative.
> 
> Fixes: d90ec262b35b ("libbpf: Add enum64 support for btf_dump")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> [...]

Here is the summary with links:
  - libbpf: fix sign expansion bug in btf_dump_get_enum_value()
    https://git.kernel.org/bpf/bpf-next/c/c6018fc6e7b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


