Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D6CC4332F
	for <bpf@archiver.kernel.org>; Tue, 29 Mar 2022 02:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiC2CWB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 28 Mar 2022 22:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiC2CV5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 22:21:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3432C2C657
        for <bpf@vger.kernel.org>; Mon, 28 Mar 2022 19:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA3EFB815A9
        for <bpf@vger.kernel.org>; Tue, 29 Mar 2022 02:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7FA4AC340ED;
        Tue, 29 Mar 2022 02:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648520412;
        bh=VlAxQjwS7KNel+oY1yAJyq3grrGC78xa8PCRLqMfaR4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PYbqvq3UQR5XkqKEyzhXul96nVSoWa3AyofmH0u6VtAb3U8a8wZDLRAUZaa+JU31l
         0Q5Lras/+2A+pirWCffKW4lpQRkQ26MammeyyhlRNL68tPJReRnW/QTKoBRNL1mKi5
         hW/SbMsCptlmX0xUt7LtfII+f0vUyJEURTjF253QgiI6XAu2Cfwwr0ph3sFj0nHmmr
         S+e+gmnCUdiFxvXQX6s7mTvSdJmS+bu6HSwFWKvqk9RyMzcG/0F5VJEwwWBqZ1buat
         WQrkDQL19J2inR9vHtuSesPIdImupD+5ul//yK6c8bDKZ6PMY1fQZ2posM2H6WKoL8
         oLOXijUPY9SxA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 603DCEAC081;
        Tue, 29 Mar 2022 02:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: fix selftest after
 random:urandom_read tracepoint removal
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164852041238.3757.14229678984564482915.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Mar 2022 02:20:12 +0000
References: <20220325225643.2606-1-andrii@kernel.org>
In-Reply-To: <20220325225643.2606-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, yhs@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 25 Mar 2022 15:56:43 -0700 you wrote:
> 14c174633f34 ("random: remove unused tracepoints") removed all the
> tracepoints from drivers/char/random.c, one of which,
> random:urandom_read, was used by stacktrace_build_id selftest to trigger
> stack trace capture.
> 
> Fix breakage by switching to kprobing urandom_read() function.
> 
> [...]

Here is the summary with links:
  - [v2,bpf-next] selftests/bpf: fix selftest after random:urandom_read tracepoint removal
    https://git.kernel.org/bpf/bpf/c/99dea2c664d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


