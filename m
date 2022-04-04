Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3564C433FE
	for <bpf@archiver.kernel.org>; Mon,  4 Apr 2022 00:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbiDDAMI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 3 Apr 2022 20:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbiDDAMI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 3 Apr 2022 20:12:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E9D13F6B;
        Sun,  3 Apr 2022 17:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2B8460FF5;
        Mon,  4 Apr 2022 00:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1260C340F2;
        Mon,  4 Apr 2022 00:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649031012;
        bh=MpObaTh3p43VrwtDFP8tfQ8niteSKrlB7UujmJqAZ10=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IwJ731gWL1I6R8EngP+PapPvbKBNs1HV/KESeWUVU3WxIJZKE5oNHJHDLFKJ9NrRE
         At2Cju6EYqye+t2OwTiKiIq6Z634Qc6HomoJO8gxYi9jJ3MM1mcCbWhHI8srHBiiiN
         Jg7rgAZmCFVGnmYB+aMv4BFmQMNQAqfOOtY3KFqA/oK57r2nqsDSfYA0YCR5Sq023r
         5daYGLGhtPa5FI2ReVEAFcgxRevXW8yvWtSZMbCseE+rbB+qXI3ObGm7bpHOu85baz
         QjB4muSBCQWovmZd0CfeywgfYQ3gaaWgMA9QtOTBDf1Xd59I60Wi/eC5Iak1ayhHKS
         iWnBagclqrgMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAEE3E85AE7;
        Mon,  4 Apr 2022 00:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix cd_flavor_subdir() of test_progs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <164903101181.15203.10673780637284892563.git-patchwork-notify@kernel.org>
Date:   Mon, 04 Apr 2022 00:10:11 +0000
References: <20220403135245.1713283-1-ytcoode@gmail.com>
In-Reply-To: <20220403135245.1713283-1-ytcoode@gmail.com>
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, shuah@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Sun,  3 Apr 2022 21:52:45 +0800 you wrote:
> Currently, when we run test_progs with just executable file name, for
> example 'PATH=. test_progs-no_alu32', cd_flavor_subdir() will not check
> if test_progs is running as a flavored test runner and switch into
> corresponding sub-directory.
> 
> This will cause test_progs-no_alu32 executed by the
> 'PATH=. test_progs-no_alu32' command to run in the wrong directory and
> load the wrong BPF objects.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix cd_flavor_subdir() of test_progs
    https://git.kernel.org/bpf/bpf-next/c/9bbad6dab827

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


