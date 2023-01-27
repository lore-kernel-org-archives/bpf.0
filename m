Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D542C38142
	for <bpf@archiver.kernel.org>; Fri, 27 Jan 2023 07:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232701AbjA0HkU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 27 Jan 2023 02:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjA0HkT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 02:40:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E7259E4F
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 23:40:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47C5F61A1D
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 07:40:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABB1AC4339C;
        Fri, 27 Jan 2023 07:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674805217;
        bh=FLYzVewLagWT7By/gfoK8dA0E9rsdRuFMIA7yIfbnQI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cfkY6bHGpKzASXVMNh0/Tlp2jgkhq0JHBfwX2iIp2FyE6LwvtLNuBok05a4QnkAXx
         HEOD2RHSfVRAcoEy97EmEPh7dz14c6Bs1Po1qWxpK3wu3b/K/9L2suLYJfGDBzQINw
         4zrGUgj56Vt8T6emxp3sfYNXKLzlxrnWvZCWTIbhB9RIPdl1wLrORzwdHXbV36odT9
         BP91J/J+uLnqFxehJKeQeakexPa3UA53cni2k017/HQ+Q7FRh/f0FpICRhqCguU1Pf
         RR/i/y+lDNnz0nz7hr0k19kxDRKe2QsKt9QQpENKh3xKwFZ4JJ63rDzE07RM5Bco3+
         KlZv+L5aG6kdw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 85D3EE52508;
        Fri, 27 Jan 2023 07:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: Fix the kernel crash caused by bpf_setsockopt().
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167480521754.25138.13729838846615715515.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Jan 2023 07:40:17 +0000
References: <20230127001732.4162630-1-kuifeng@meta.com>
In-Reply-To: <20230127001732.4162630-1-kuifeng@meta.com>
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Thu, 26 Jan 2023 16:17:32 -0800 you wrote:
> The kernel crash was caused by a BPF program attached to the
> "lsm_cgroup/socket_sock_rcv_skb" hook, which performed a call to
> `bpf_setsockopt()` in order to set the TCP_NODELAY flag as an
> example. Flags like TCP_NODELAY can prompt the kernel to flush a
> socket's outgoing queue, and this hook
> "lsm_cgroup/socket_sock_rcv_skb" is frequently triggered by
> softirqs. The issue was that in certain circumstances, when
> `tcp_write_xmit()` was called to flush the queue, it would also allow
> BH (bottom-half) to run. This could lead to our program attempting to
> flush the same socket recursively, which caused a `skbuf` to be
> unlinked twice.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: Fix the kernel crash caused by bpf_setsockopt().
    https://git.kernel.org/bpf/bpf/c/5416c9aea832

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


