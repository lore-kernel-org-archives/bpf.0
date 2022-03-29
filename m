Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C081DC433EF
	for <bpf@archiver.kernel.org>; Tue, 29 Mar 2022 02:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiC2CWB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 28 Mar 2022 22:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiC2CV5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Mar 2022 22:21:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3258E26AE5;
        Mon, 28 Mar 2022 19:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB0F8B8162F;
        Tue, 29 Mar 2022 02:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B621C34113;
        Tue, 29 Mar 2022 02:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648520412;
        bh=8fxg5u3kbhVueeYO/75ErWyDpQVNBnBleAF1IIgrgzw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ELDFwev/Q8s6EDp+eQMyRennek1eJAcHptKSMuWlyWFTx5KNHKZWp6+LR3Z9RD1RZ
         TDk2ECEOFnHf9JCnMiBN98dYBqvuYmzC2o9r43Ac7iPXAU/SK7r+MjPjblaXhOR6Pn
         5zCWHw4/DTcgPL36Y73uFmUhX6DWrCbP0L4/Vg2bTFjxus7bh8lwHP9MqnWcKKb2y3
         N9kE2ldrnN8XvVBHP8Yo9zQGunwr5obdDzKIyJvsawqgWCamRPOyGsBZWc5GpzPA2X
         BTHZbaw7lddK81BsTzGu6wVsJK8IF9mZLhgGZdtq73He+qzyCOqGq2ohyFLoBPfRSR
         3qEBEd11Q6ceA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73A6EF03849;
        Tue, 29 Mar 2022 02:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpftool: Fix generated code in codegen_asserts
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164852041246.3757.13606158297445686435.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Mar 2022 02:20:12 +0000
References: <20220328083703.2880079-1-jolsa@kernel.org>
In-Reply-To: <20220328083703.2880079-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        delyank@fb.com, acme@redhat.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@chromium.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 28 Mar 2022 10:37:03 +0200 you wrote:
> Arnaldo reported perf compilation fail with:
> 
>   $ make -k BUILD_BPF_SKEL=1 CORESIGHT=1 PYTHON=python3
>   ...
>   In file included from util/bpf_counter.c:28:
>   /tmp/build/perf//util/bpf_skel/bperf_leader.skel.h: In function ‘bperf_leader_bpf__assert’:
>   /tmp/build/perf//util/bpf_skel/bperf_leader.skel.h:351:51: error: unused parameter ‘s’ [-Werror=unused-parameter]
>     351 | bperf_leader_bpf__assert(struct bperf_leader_bpf *s)
>         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~^
>   cc1: all warnings being treated as errors
> 
> [...]

Here is the summary with links:
  - bpftool: Fix generated code in codegen_asserts
    https://git.kernel.org/bpf/bpf/c/ef8a257b4e49

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


