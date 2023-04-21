Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCB6C7618E
	for <bpf@archiver.kernel.org>; Fri, 21 Apr 2023 02:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjDUCAX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 20 Apr 2023 22:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDUCAW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 22:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB96E3C34
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 19:00:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6741B64CE6
        for <bpf@vger.kernel.org>; Fri, 21 Apr 2023 02:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0775C4339B;
        Fri, 21 Apr 2023 02:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682042419;
        bh=G5qdHJtG7YBVLasUz4BxoGsx7uyCSlfc6GJVjJG/xG8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YDWwWIXJcJ9zrycSj+iJ+eR8EXaSz9jPjKxNrVQDW/JROb4bp5C1nFv85OYk03HzI
         w807WP17eOOVjoUgwwoEVhlKozTW7EBUIIarfX63Altw5ngdx1eCPlXDaShj6MY0sD
         QlmA7atYeFNyx6XLgMy2JZLYnbQg4HS+TJ6SwBzBNz54SNtlfQr1C+qIff/kULNNak
         7+oJY1OxngNXmkyjwtq3tWdIHJuzDNT24tIHXkPHJkj9lPI8pjThz1OejAVJbNo2xX
         Boykk3GPhizRWAexyBUPHcgaDKyxJAhpPrTD7fR/07K8YA6/Z7OiCJJ4rhq97bIjWH
         y+vgiXyRnnYhg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A809BE501E3;
        Fri, 21 Apr 2023 02:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/4] fix __retval() being always ignored
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168204241968.27140.15302922849910536093.git-patchwork-notify@kernel.org>
Date:   Fri, 21 Apr 2023 02:00:19 +0000
References: <20230420232317.2181776-1-eddyz87@gmail.com>
In-Reply-To: <20230420232317.2181776-1-eddyz87@gmail.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
        yhs@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 21 Apr 2023 02:23:13 +0300 you wrote:
> Florian Westphal found a bug in test_loader.c processing of __retval tag.
> Because of this bug the function test_loader.c:do_prog_test_run()
> never executed and all __retval test tags were ignored. See [1].
> 
> Fix for this bug uncovers two additional bugs:
> - During test_verifier tests migration to inline assembly (see [2])
>   I missed the fact that some tests require maps to contain mock values;
> - Some issue with a new refcounted_kptr test, which causes kernel to
>   produce dead lock and refcount saturation warnings when subject to
>   libbpf's bpf_test_run_opts().
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/4] selftests/bpf: disable program test run for progs/refcounted_kptr.c
    https://git.kernel.org/bpf/bpf-next/c/7c4b96c00043
  - [bpf-next,2/4] selftests/bpf: fix __retval() being always ignored
    https://git.kernel.org/bpf/bpf-next/c/7cdddb99e4a6
  - [bpf-next,3/4] selftests/bpf: add pre bpf_prog_test_run_opts() callback for test_loader
    https://git.kernel.org/bpf/bpf-next/c/5b22f4d1436b
  - [bpf-next,4/4] selftests/bpf: populate map_array_ro map for verifier_array_access test
    https://git.kernel.org/bpf/bpf-next/c/cbb110bc6672

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


