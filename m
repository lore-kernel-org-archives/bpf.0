Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17250C433EF
	for <bpf@archiver.kernel.org>; Fri, 15 Jul 2022 05:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiGOFkR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 15 Jul 2022 01:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiGOFkQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 01:40:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4D971BC5
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 22:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 929D2B82AB6
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 05:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 03BC5C3411E;
        Fri, 15 Jul 2022 05:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657863613;
        bh=aULYVttVcSeb3kEa4TpYDvdJNJUnCrnkOrA9lSxRnWs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OzX1L+kmZn0hjUH4nXVrygMWaW99PmKCKQE39j839muBsUusGM9cXgxx/tKgX92yM
         Vn1vReZkC37r52bIOgbKDdprY4+Ekq1gFF+F7n2IYwojiWKwZFboA6Scsi/I9RhYaW
         kU+Ahm3V3OtmW2RGdOmRyX/82/42HFT2vyaPj1gznzOqyTxbn8Lz8yT5eJbnC9VMNt
         8LROxTxynVZfB8Bn6UhYAaEsUVtkZUw+RfWZ0vS2Lkm4qnxzim2v7zp3ba1Ok6gkC9
         LFxSIVQHbxXjZnaHpMOAaDgpL2NBOVOaiJ+hmW6urUlL1kvva+cvS2FJ1u53lFpfQN
         APR7hLAi9n4Mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D0944E45223;
        Fri, 15 Jul 2022 05:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests/bpf: Do not attach kprobe_multi bench to
 bpf_dispatcher_xdp_func
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165786361283.30975.6207182240758306523.git-patchwork-notify@kernel.org>
Date:   Fri, 15 Jul 2022 05:40:12 +0000
References: <20220714082316.479181-1-jolsa@kernel.org>
In-Reply-To: <20220714082316.479181-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org,
        sdf@google.com, haoluo@google.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 14 Jul 2022 10:23:16 +0200 you wrote:
> Alexei reported crash by running test_progs -j on system
> with 32 cpus.
> 
> It turned out the kprobe_multi bench test that attaches all
> ftrace-able functions will race with bpf_dispatcher_update,
> that calls bpf_arch_text_poke on bpf_dispatcher_xdp_func,
> which is ftrace-able function.
> 
> [...]

Here is the summary with links:
  - [bpf] selftests/bpf: Do not attach kprobe_multi bench to bpf_dispatcher_xdp_func
    https://git.kernel.org/bpf/bpf-next/c/7fb27a56b9eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


