Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A54C4167E
	for <bpf@archiver.kernel.org>; Thu,  3 Feb 2022 20:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354761AbiBCUmQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 3 Feb 2022 15:42:16 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40966 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242937AbiBCUkM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Feb 2022 15:40:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27D4EB835A9
        for <bpf@vger.kernel.org>; Thu,  3 Feb 2022 20:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CE1B7C36AE2;
        Thu,  3 Feb 2022 20:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643920809;
        bh=QzjFKEu3QyELqRdimAQ2VppRpyoMLVuZq6DPpqd4QOs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CK1/2ew4WJXzaLFG9OIswdMlp7KhNUQ/Q81aCFEB9BrsZxMWvPYxrVo8QrefE3AES
         lBST1jzgj19y+faNhFex+AQcjs8JDSHLZ4V4BAJOnQJMyiaQJHkLcDdYIVEVy2xAn+
         E2eA2v2duH7/WxBxbwFWxgbceA9qnrwrrDopSfDl/3inaHjK9HbSJudjLuxVlX+MGi
         DcZPed1MbUy5O6FsnZ/V6yimCUu/R3AZX6EyloF2dJ/ThIl6M6jJ0vd8E/Yjhcixfm
         uXZKeJJ3UO8wjYTS5UAqC8KOR+QOZFqqK2VYS7JLvclTceG+HY88PvrmCR3Wxz9TU9
         1H1N0QSUG1gaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AFFFAE6BAC6;
        Thu,  3 Feb 2022 20:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: deprecate priv/set_priv storage
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164392080971.19679.12302322534218675117.git-patchwork-notify@kernel.org>
Date:   Thu, 03 Feb 2022 20:40:09 +0000
References: <20220203180032.1921580-1-delyank@fb.com>
In-Reply-To: <20220203180032.1921580-1-delyank@fb.com>
To:     Delyan Kratunov <delyank@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 3 Feb 2022 10:00:32 -0800 you wrote:
> Arbitrary storage via bpf_*__set_priv/__priv is being deprecated
> without a replacement ([1]). perf uses this capability, but most of
> that is going away with the removal of prologue generation ([2]).
> perf is already suppressing deprecation warnings, so the remaining
> cleanup will happen separately.
> 
>   [1]: Closes: https://github.com/libbpf/libbpf/issues/294
>   [2]: https://lore.kernel.org/bpf/20220123221932.537060-1-jolsa@kernel.org/
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: deprecate priv/set_priv storage
    https://git.kernel.org/bpf/bpf-next/c/ca33aa4ec5cb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


