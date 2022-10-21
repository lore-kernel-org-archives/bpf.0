Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7BFC433FE
	for <bpf@archiver.kernel.org>; Fri, 21 Oct 2022 21:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiJUVKe (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 21 Oct 2022 17:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJUVKd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 17:10:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F31A11DA8C
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:10:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F93461F87
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 21:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BFDEC433D7;
        Fri, 21 Oct 2022 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666386616;
        bh=/upXijRVagdbAhL94bvWnx9s1RPyDOUPLC4ZxkAAqU4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dBtLbY5SgD37qdRjk7VuWehFLVHyQOfsTZzYIWmjl9pc81Y0zbCLU1BrBgPsirgG6
         5C0VJX1Xd+twGfugkZPGD28X0OpJlIlNGTIaJDmsZXlbPivbCkkO07eWaX2BoXoW4B
         4aP6CuUiP4QAK1gklnnRwWcZUllZEBIR3uUquwTPH36I12b8/7FTfLwvsYIoDzILDG
         1DLrkWT5JBXZw+jS9DLDQO28aiSoBgijiqLi/J5NUf941JmsGaTHuxjf9PkHrLKboi
         t1m/vwq+ZlGG8jbpufZAi79+jHUjWherh7VuqGo6sGgyq3iVU5jzqKSp01YXdhO6b8
         d79usZmWCIFJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C624E270E1;
        Fri, 21 Oct 2022 21:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: fix task_local_storage/exit_creds
 rcu usage
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166638661643.2639.16814405561858562162.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Oct 2022 21:10:16 +0000
References: <156d4ef82275a074e8da8f4cffbd01b0c1466493.camel@meta.com>
In-Reply-To: <156d4ef82275a074e8da8f4cffbd01b0c1466493.camel@meta.com>
To:     Delyan Kratunov <delyank@meta.com>
Cc:     daniel@iogearbox.net, songliubraving@meta.com, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 21 Oct 2022 19:36:38 +0000 you wrote:
> BPF CI has revealed flakiness in the task_local_storage/exit_creds test.
> The failure point in CI [1] is that null_ptr_count is equal to 0,
> which indicates that the program hasn't run yet. This points to the
> kern_sync_rcu (sys_membarrier -> synchronize_rcu underneath) not
> waiting sufficiently.
> 
> Indeed, synchronize_rcu only waits for read-side sections that started
> before the call. If the program execution starts *during* the
> synchronize_rcu invocation (due to, say, preemption), the test won't
> wait long enough.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: fix task_local_storage/exit_creds rcu usage
    https://git.kernel.org/bpf/bpf-next/c/eb814cf1adea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


