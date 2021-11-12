Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F9D1C433EF
	for <bpf@archiver.kernel.org>; Fri, 12 Nov 2021 15:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58BDC61076
	for <bpf@archiver.kernel.org>; Fri, 12 Nov 2021 15:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhKLPXB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Nov 2021 10:23:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:35228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230019AbhKLPW6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Nov 2021 10:22:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id DA8D861075;
        Fri, 12 Nov 2021 15:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636730407;
        bh=98H4O+FKpQ9XX0+bYQopI0JkrcUYcv+gZiOfk7O2tr0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=uD5i+EEr4l3cSQu9kv7Ob+9kw9cOLtYnR40bHGvfA1iWxDQwH+M78nmfiMdHmyu21
         7+OCK3xWvq3JcH11v6sHBXIn6qx8hdLJkLhbZiwJA4+uJAJ0QKr9sBsAO0baOlaQV0
         qlRPFkqehYl6lGAe99+xHwmCPdLpw4wmfmQH4zx4/o8EgRPJm8+jfLumPm20kA3xxb
         KGyiNMYifGtEtT6GFLzEM/rjfyO2kFcA6WL2AX9IG4kCGUyQz8iO2XQOw0p2rojYn3
         WJk9iR2Uuz3uKtgIJNDB4C6/7nGxkuPMsaUa0ax/hmJ0yxvgzDLDaLOZPYg5y41JJ3
         ltfpILv7AkPdg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftests: bpf: check map in map pruning
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163673040779.12963.16453161654886346779.git-patchwork-notify@kernel.org>
Date:   Fri, 12 Nov 2021 15:20:07 +0000
References: <20211111161452.86864-1-lmb@cloudflare.com>
In-Reply-To: <20211111161452.86864-1-lmb@cloudflare.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kernel-team@cloudflare.com,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Thu, 11 Nov 2021 16:14:52 +0000 you wrote:
> Ensure that two registers with a map_value loaded from a nested
> map are considered equivalent for the purpose of state pruning
> and don't cause the verifier to revisit a pruning point.
> 
> This uses a rather crude match on the number of insns visited by
> the verifier, which might change in the future. I've therefore
> tried to keep the code as "unpruneable" as possible by having
> the code paths only converge on the second to last instruction.
> 
> [...]

Here is the summary with links:
  - [bpf] selftests: bpf: check map in map pruning
    https://git.kernel.org/bpf/bpf/c/a583309d968b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


