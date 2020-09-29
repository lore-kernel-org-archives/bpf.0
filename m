Return-Path: <SRS0=PNb+=DG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D22BC4727F
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 12:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECEA72076B
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601382016;
	bh=HYxGlk6NQY71ojUKwTQeds4Me6ucmHaf8NpcyRLpkN8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=Z1jNc6gEEK3iArn9GLDIvvfjR1577rmbSh02FVHA2yFbyzSyL/USRoPtAURzzOs3d
	 rMRemaw2JVOk8J4uLwq0NEZQ/OozcDaglnGtETPzVWinAbM8KXcoJldgHzLmGXfpki
	 IZLe3lAr8ikdOoGQk2fBw93FIY3hzftYYEkaLR18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgI2MUK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Sep 2020 08:20:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732467AbgI2MUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 08:20:09 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601382008;
        bh=HYxGlk6NQY71ojUKwTQeds4Me6ucmHaf8NpcyRLpkN8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZlfWno5wZeUobHPmALGG2z/GOPfdcb4BiT4th2IFIexyso+CfOWSAaCb7YDmBxr7x
         tIIgYOnILTWEhJlhtLvGrgTFoU4kb7zp9wQSa7PMXNyejnYMr31F+M5bCgpEcsApkd
         m56OXanmiqE6/aDaNGBInknMh5UcpAyWTk7Y3qPo=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [bpf-next PATCH] bpf,
 selftests: Fix cast to smaller integer type 'int' warning in raw_tp
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160138200850.26741.8249592517695495561.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 12:20:08 +0000
References: <160134424745.11199.13841922833336698133.stgit@john-Precision-5820-Tower>
In-Reply-To: <160134424745.11199.13841922833336698133.stgit@john-Precision-5820-Tower>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 28 Sep 2020 18:50:47 -0700 you wrote:
> Fix warning in bpf selftests,
> 
> progs/test_raw_tp_test_run.c:18:10: warning: cast to smaller integer type 'int' from 'struct task_struct *' [-Wpointer-to-int-cast]
> 
> Change int type cast to long to fix. Discovered with gcc-9 and llvm-11+
> where llvm was recent main branch.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf, selftests: Fix cast to smaller integer type 'int' warning in raw_tp
    https://git.kernel.org/bpf/bpf-next/c/00e8c44a147a

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


