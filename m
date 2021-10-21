Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C301BC433F5
	for <bpf@archiver.kernel.org>; Thu, 21 Oct 2021 23:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B6261371
	for <bpf@archiver.kernel.org>; Thu, 21 Oct 2021 23:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbhJUXMY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Oct 2021 19:12:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230190AbhJUXMY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Oct 2021 19:12:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id F08AC61362;
        Thu, 21 Oct 2021 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634857808;
        bh=nhj4Y/jARhOyKJhK70TdhKaGx+i1n5UNmyqmMu5i4x8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fbUIpOo63dl67VoqCyJ0ttnRES+WWfVg3G1ZpVWTxt9hbEzqzfrzhb3TLA616FD0+
         8988LsAbElfons4H8lPkkKraMaNoAvUnlN3rcZG9y0Kj4EHX58xYDvKQHDnnsCQ32a
         w5ls2jr0NyCE2nJmvtTtthk+YvYngw10D/iGPVpGPAcCdED31790Ijf2OtmgFVfNkT
         VZP7uotCZ+Vn+t8IE8hFhW3JBc3Hz8bqyPsuJ0X4wVKtzqgLAfgngGhEgnrAyM1TBH
         0ejpfnJu4FJ+pELvcQvK043p4uMhRpcIEUVePoririPeeZ6Yhsk4Vqm8o/Y4VnM+kK
         W61bgVKg0TLAQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/3] selftests/bpf: Fixes for perf_buffer test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163485780787.11841.4560009352390229112.git-patchwork-notify@kernel.org>
Date:   Thu, 21 Oct 2021 23:10:07 +0000
References: <20211021114132.8196-1-jolsa@kernel.org>
In-Reply-To: <20211021114132.8196-1-jolsa@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 21 Oct 2021 13:41:29 +0200 you wrote:
> hi,
> sending fixes for perf_buffer test on systems
> with offline cpus.
> 
> v2:
>   - resend due to delivery issues, no changes
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/3] selftests/bpf: Fix perf_buffer test on system with offline cpus
    https://git.kernel.org/bpf/bpf-next/c/d4121376ac7a
  - [bpf-next,2/3] selftests/bpf: Fix possible/online index mismatch in perf_buffer test
    https://git.kernel.org/bpf/bpf-next/c/aa274f98b269
  - [bpf-next,3/3] selftests/bpf: Use nanosleep tracepoint in perf buffer test
    https://git.kernel.org/bpf/bpf-next/c/99d099757ab4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


