Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA796C38142
	for <bpf@archiver.kernel.org>; Fri, 27 Jan 2023 23:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjA0XuU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 27 Jan 2023 18:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjA0XuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 18:50:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5221384FA5
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 15:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E368961DC8
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 23:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 436F9C4339B;
        Fri, 27 Jan 2023 23:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674863417;
        bh=XpHp0FtQcbvk2gb4SOWgyf0muQLsLRTg8j4k4a2qCuM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=L4XLbwUBKrztcT1EhNFhoYvSKnkwpVTU+1fFIbdZxdY0ucCdrO6T81Uc56PWZKWDZ
         r3+YIVsV+JA7Oo1smL2EWcb4XB85zUT8HpC0rh1bpkP4BrjLN5HX9SBGAZZYVZuyaS
         1WdG1AsCQv+FQl3InRQEJSHcjB59gRstPqErvyFduC9iWIPR3IUDKvdaOJjXH5d46N
         ikamzLb3h5JV86XKlnIlx2JIe5gZBfRfwOLJIKtQ5/4Rp6N/ZVLLGLyG9rhVtLB5lm
         uUl3XGkQsIRFKAtsP30dgPpkuqhPfqpWtcodjhkbp7vHjNUaalbfycannuK2OJ2BLR
         DUktp8SKuUyeQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B2F0E52504;
        Fri, 27 Jan 2023 23:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftest/bpf: Make crashes more debuggable in
 test_progs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167486341710.23162.13568236479995503045.git-patchwork-notify@kernel.org>
Date:   Fri, 27 Jan 2023 23:50:17 +0000
References: <20230127215705.1254316-1-sdf@google.com>
In-Reply-To: <20230127215705.1254316-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 27 Jan 2023 13:57:05 -0800 you wrote:
> Reset stdio before printing verbose log of the SIGSEGV'ed test.
> Otherwise, it's hard to understand what's going on in the cases like [0].
> 
> With the following patch applied:
> 
> 	--- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> 	+++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> 	@@ -392,6 +392,11 @@ void test_xdp_metadata(void)
> 	 		       "generate freplace packet"))
> 	 		goto out;
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftest/bpf: Make crashes more debuggable in test_progs
    https://git.kernel.org/bpf/bpf-next/c/16809afdcbad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


