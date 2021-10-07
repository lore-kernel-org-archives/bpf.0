Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C606C433EF
	for <bpf@archiver.kernel.org>; Thu,  7 Oct 2021 19:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30C2D6112D
	for <bpf@archiver.kernel.org>; Thu,  7 Oct 2021 19:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233241AbhJGTwC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 Oct 2021 15:52:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232821AbhJGTwB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 15:52:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 5662161042;
        Thu,  7 Oct 2021 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633636207;
        bh=IO3HjGBwnP5Whawhz+w+O45bPieTkx81QIVPvWxNfSo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GVT2pYwiyhb5C1wpC+TDfZDAbTvaoYlMJeWlJswc3jVvHHo97b8Re2Z/QKOJ7cprz
         6NT3YXni9F5V7GuLCx5aG17oSaGdvOdPN/p3yURnH54hx5IcepryeixkH0/6YIYFcH
         f+5rLiEx0w56F1BCLC0zQIcfY0PMkWqm+63ccxsKjVzGrZu0JFGlAoiVYzNXFTDEpH
         bTJwCIEk//Cl8njtUiU2tOj+MB07uBqY2Q/4ohJQh5loB+kx9JaXK0v+5F057GU8cW
         97RjU4Qfna5DG1kJK0pwK2aI2piDgyXyrQ2+9QErogDzLolgSrIzCO8ZoxX0dTn59K
         F5Tq/zYYDyYLQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf,x64: Factor out emission of REX byte in more
 cases
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163363620726.31141.12675997930343202985.git-patchwork-notify@kernel.org>
Date:   Thu, 07 Oct 2021 19:50:07 +0000
References: <20211006194135.608932-1-jmeng@fb.com>
In-Reply-To: <20211006194135.608932-1-jmeng@fb.com>
To:     Jie Meng <jmeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Wed, 6 Oct 2021 12:41:35 -0700 you wrote:
> Introduce a single reg version of maybe_emit_mod() and factor out
> common code in more cases.
> 
> Signed-off-by: Jie Meng <jmeng@fb.com>
> ---
>  arch/x86/net/bpf_jit_comp.c | 67 +++++++++++++++++--------------------
>  1 file changed, 31 insertions(+), 36 deletions(-)

Here is the summary with links:
  - [bpf-next] bpf,x64: Factor out emission of REX byte in more cases
    https://git.kernel.org/bpf/bpf-next/c/6364d7d75a0e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


