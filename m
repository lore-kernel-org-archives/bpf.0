Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE897C4332F
	for <bpf@archiver.kernel.org>; Fri, 18 Nov 2022 20:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiKRUUU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 18 Nov 2022 15:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiKRUUT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 15:20:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF1045EEA
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 12:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BBB0B8251E
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 20:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0766AC433C1;
        Fri, 18 Nov 2022 20:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668802816;
        bh=EgUnKlXBwPVDLJvLUlEK+ltZoiu6H9Ez+en40fUIvvA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MAWx9VmppD4MLfYNhEeGnuW/KnHmZIEwLG49mMmQ8WujtjoHW7TlenA1Mpm8r2yn0
         cBjQ94aRSDG3UWkLFO22hlFMHWR8BsyAPWUUaACs7Y+OQtJB86hi+ssVh5UuUBUPFE
         SOSqzDH/EONcg4Wm1dU0Kv/9efxJF2tR1swrhDTsYUU7axR6qaDuxXbxgwjyVkYMia
         Kztb+Ksp27JzIfb3pJZe6/SS+oTrl5StN5Pf/QvMdLRNvIMJ2fwOoTxFboo6K9HwNg
         ngvavjCJHPHQdZyjFhsZ5Y++rqh5IR4iZD5hT4fJF7xX3ZVBm5dGen19OWnq2O11qH
         l9O2Nsv4XOXUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB735E270F6;
        Fri, 18 Nov 2022 20:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v1 0/2] Follow ups for bpf-list set
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166880281589.7537.6028248915916238724.git-patchwork-notify@kernel.org>
Date:   Fri, 18 Nov 2022 20:20:15 +0000
References: <20221118185938.2139616-1-memxor@gmail.com>
In-Reply-To: <20221118185938.2139616-1-memxor@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 19 Nov 2022 00:29:36 +0530 you wrote:
> Make a few changes
>  - Remove bpf_global_ma_set check at runtime, disallow calling bpf_obj_new during verification
>  - Disable spin lock failure test when JIT does not support kfunc (s390x)
> 
> Kumar Kartikeya Dwivedi (2):
>   bpf: Disallow calling bpf_obj_new_impl on bpf_mem_alloc_init failure
>   selftests/bpf: Skip spin lock failure test on s390x
> 
> [...]

Here is the summary with links:
  - [bpf-next,v1,1/2] bpf: Disallow calling bpf_obj_new_impl on bpf_mem_alloc_init failure
    (no matching commit)
  - [bpf-next,v1,2/2] selftests/bpf: Skip spin lock failure test on s390x
    https://git.kernel.org/bpf/bpf-next/c/97c11d6e3154

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


