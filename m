Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72D62C433F5
	for <bpf@archiver.kernel.org>; Fri, 13 May 2022 20:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383834AbiEMUKR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 13 May 2022 16:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbiEMUKQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 May 2022 16:10:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC6E5BE57
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 13:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F32FCB8311C
        for <bpf@vger.kernel.org>; Fri, 13 May 2022 20:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2DDDC34113;
        Fri, 13 May 2022 20:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652472612;
        bh=1BmTEXtfFO0V5RwV2lGuu/7msKnyvr86ewwk869jZLM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bC6Bpp7vV9yYoAXr1FkxieQDfOIZeC/yStW6dl/5V5Hf4Lfp0YO12jieOCd7PV2HE
         feHi/jcOlRrW7xyzdBQgXOXmOtYTkgb4dhwJkebr6gGCOQ7XJQkymUKRM6u6phbWcw
         hdB4KK+P/QkwaVdfyfM6Oqj1hXFpJO7DBX4KwBMhcc0lF1Zf7cFi1TS9ynmtgNKATD
         gGxob0vYN+9UCflYeBs5e0Pm9iIhk3X0Tpi94IqDdJLP6pP0ueUAaHR5Tl5aRUHVTe
         rE/bejpKEuYjA2GfPaMSiK6fPHTdopjZ6Qz7hpzoSHXbqCE929rANuVHPY8dry0Q8g
         AyOKoO749HH6Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F274F03934;
        Fri, 13 May 2022 20:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix usdt_400 test case
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165247261257.30072.10511731081638155735.git-patchwork-notify@kernel.org>
Date:   Fri, 13 May 2022 20:10:12 +0000
References: <20220513173703.89271-1-andrii@kernel.org>
In-Reply-To: <20220513173703.89271-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, mykolal@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 13 May 2022 10:37:03 -0700 you wrote:
> usdt_400 test case relies on compiler using the same arg spec for
> usdt_400 USDT. This assumption breaks with Clang (Clang generates
> different arg specs with varying offsets relative to %rbp), so simplify
> this further and hard-code the constant which will guarantee that arg
> spec is the same across all 400 inlinings.
> 
> Fixes: 630301b0d59d ("selftests/bpf: Add basic USDT selftests")
> Reported-by: Mykola Lysenko <mykolal@fb.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix usdt_400 test case
    https://git.kernel.org/bpf/bpf-next/c/0d2d2648931b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


