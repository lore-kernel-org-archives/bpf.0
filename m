Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B305DC433F5
	for <bpf@archiver.kernel.org>; Wed, 11 May 2022 20:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235290AbiEKUAR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 11 May 2022 16:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbiEKUAQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 May 2022 16:00:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613AD231090
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 13:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89C7B619D9
        for <bpf@vger.kernel.org>; Wed, 11 May 2022 20:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE110C34115;
        Wed, 11 May 2022 20:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652299213;
        bh=WlBbhex+7AXOzZm5T+Pz5oT+Fv31kvKBwCQT70/ShiI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nPHSOaETf+113Ths+H+CXQNAO08XhpwW8/SGcBkUHR7RhkJt8273O76PgeLXjXWsC
         fFaArNYHq9sBMvsJXXDYoIswj8MLKEXVlDPnE3FaeHow3hLn2TRdhakLRn7vqL775g
         Sz2l5LPwkFpl5OFiAM1/v+4uQuizGSuga291BnkCCtOu8vSjyW4y5nocLjd/nCXkTm
         I0giqhybIgLehrx8m/4c8O/g+1Re3w6x25FpHR1BcZFDdZPsMh+LPZvJChwBcYCgTa
         slD0D6wJONcAQwak5fe5xwvXtkJuYpluy7GHhjodWW5bpOENPY7ObjdHItEPEaEIAJ
         hX8RpjB7KyF7Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BB4DAF03931;
        Wed, 11 May 2022 20:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: fix a few clang compilation errors
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165229921376.1053.858684231749172500.git-patchwork-notify@kernel.org>
Date:   Wed, 11 May 2022 20:00:13 +0000
References: <20220511184735.3670214-1-yhs@fb.com>
In-Reply-To: <20220511184735.3670214-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Wed, 11 May 2022 11:47:35 -0700 you wrote:
> With latest clang, I got the following compilation errors:
>   .../prog_tests/test_tunnel.c:291:6: error: variable 'local_ip_map_fd' is used uninitialized
>      whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>        if (attach_tc_prog(&tc_hook, -1, set_dst_prog_fd))
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   .../bpf/prog_tests/test_tunnel.c:312:6: note: uninitialized use occurs here
>         if (local_ip_map_fd >= 0)
>             ^~~~~~~~~~~~~~~
>   ...
>   .../prog_tests/kprobe_multi_test.c:346:6: error: variable 'err' is used uninitialized
>       whenever 'if' condition is true [-Werror,-Wsometimes-uninitialized]
>         if (IS_ERR(map))
>             ^~~~~~~~~~~
>   .../prog_tests/kprobe_multi_test.c:388:6: note: uninitialized use occurs here
>         if (err) {
>             ^~~
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: fix a few clang compilation errors
    https://git.kernel.org/bpf/bpf-next/c/fd0ad6f1d10c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


