Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE404C433E0
	for <bpf@archiver.kernel.org>; Thu, 18 Mar 2021 16:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DFA464E09
	for <bpf@archiver.kernel.org>; Thu, 18 Mar 2021 16:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhCRQUT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Mar 2021 12:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232073AbhCRQUI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 12:20:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 1F1C564F38;
        Thu, 18 Mar 2021 16:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616084408;
        bh=+a4nWidE1JEvouZrihIgCVTgCTzEfiAfjNNGzyfA6OY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nknRd7IwkKu6HaWiTDA3XVwIFE5SCHLJbd98fmC/6+uUCt1LTSmzrXteYwJRRhidw
         VQFF5Ji2Z9J0gUxcjvZyAh61fHMx1ZAXSVDTjQU8NHclMeQuGSHhULtLW6wFV/6Oie
         OwaC/UC+ED5fJ4BBg1DfsBUwMru1z0ZabVJ+GgHuzb7r56gwbJmAHr4LEUaNTPZ/wZ
         mx9mPpqglBkfj51TPHEwywBN7YSdwkvXpAyeyh8Qyu6WGM0kVs/3lV9UYvLZLcHBSJ
         mSifphj7AJAoBfxM3H/Dzk8ZqOeI2ahqUfOqmIKNlHgGpGqq//mBMAAXjdzCplGBag
         4kYzGzLp1+Vsg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] selftest/bpf: Add a test to check trampoline freeing
 logic.
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161608440806.14881.15483276592183806085.git-patchwork-notify@kernel.org>
Date:   Thu, 18 Mar 2021 16:20:08 +0000
References: <20210318004523.55908-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20210318004523.55908-1-alexei.starovoitov@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        paulmck@kernel.org, bpf@vger.kernel.org, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Wed, 17 Mar 2021 17:45:23 -0700 you wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Add a selfttest for commit e21aa341785c ("bpf: Fix fexit trampoline.")
> to make sure that attaching fexit prog to a sleeping kernel function
> will trigger appropriate trampoline and program destruction.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf] selftest/bpf: Add a test to check trampoline freeing logic.
    https://git.kernel.org/bpf/bpf/c/eddbe8e65214

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


