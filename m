Return-Path: <SRS0=svjS=DJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA72C4363D
	for <bpf@archiver.kernel.org>; Fri,  2 Oct 2020 14:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4C720719
	for <bpf@archiver.kernel.org>; Fri,  2 Oct 2020 14:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601650217;
	bh=/oi4t6O4+8UbXf5rf8wLnbq+N0Rp5nNDrAwKT7wdmPI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=nuPkJrGHK6Y/5SB4LBo850RM313VVkXFsNt7hbT1NkydCNL3w6w4MDmncIlylXuTq
	 z3mbjSTQ0Mt8fu+4Q6m06cTgMQjB7MkTKttbAKQHGR+aUHIQViP3IT+hz7bpDqn+aq
	 C+2xK1toUOJomjnGxgUYbW47YmaNUb17iT7hIB5g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388153AbgJBOuR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 2 Oct 2020 10:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388002AbgJBOuD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 10:50:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601650202;
        bh=/oi4t6O4+8UbXf5rf8wLnbq+N0Rp5nNDrAwKT7wdmPI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=M18on/MAK7m+a6Tk68VEKmahJCdKY4bWb36YZ8NPOj8gPVNQtWZQPRHw/+/CgPR00
         JjGWC3AJzitpNLP8gZBCgmBHOmS1lFVuGQgEgUsoQ8vZ+sXtmDxK7x77Jl4pmnNumN
         Fm7cbSSMvyHYUO5b7MNiKisUm8/3ABc41c74N92E=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: initialize duration in xdp_noinline.c
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160165020271.24758.13755402807472066757.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Oct 2020 14:50:02 +0000
References: <20201001225440.1373233-1-sdf@google.com>
In-Reply-To: <20201001225440.1373233-1-sdf@google.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu,  1 Oct 2020 15:54:40 -0700 you wrote:
> Fixes clang error:
> tools/testing/selftests/bpf/prog_tests/xdp_noinline.c:35:6: error: variable 'duration' is uninitialized when used here [-Werror,-Wuninitialized]
>         if (CHECK(!skel, "skel_open_and_load", "failed\n"))
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: initialize duration in xdp_noinline.c
    https://git.kernel.org/bpf/bpf-next/c/cffcdbff70a3

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


