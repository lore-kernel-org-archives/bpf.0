Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130FAC77B73
	for <bpf@archiver.kernel.org>; Mon,  1 May 2023 22:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjEAWkW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 1 May 2023 18:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEAWkV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 May 2023 18:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065C910FD
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 15:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87D2D6200A
        for <bpf@vger.kernel.org>; Mon,  1 May 2023 22:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DEAFCC433D2;
        Mon,  1 May 2023 22:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682980819;
        bh=fdu/sUqEfgAXIDmJtkpV98YJm+VfjX8r7sxIDRtDWuU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Bppgi43lJJP0x5v+X6GWZkV5hS74cqJeLlsCtx8JIiCKHBCTKIH4E++JzZXkr404O
         sXfeTI2dCKuwXed90bUVA7LXbpT28Q7hKLDrRFMSGO/vO3IEp8QPB2YzdUwRGhvuoE
         ygILl3394ZfKg8hsb6abQpdP93YBwjNdKm1r9sf2iv4qj5yto7cRCkdmKzKGKStXHM
         f//dCTbjrCKYNhCoumHDFopeH9OLl9f2ZPlgbboXMsWSPgSpurCLsHIxeJ/epDjgel
         Mozo9TySJng7H8sfNAwh6l6a4jnots2YMWP1UMu2CVuqQeEhE3bHBgyjL3K5HSRF93
         hJP4gFUVnKv9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5632C43158;
        Mon,  1 May 2023 22:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] selftests/bpf: test_progs can read test lists
 from file
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168298081980.22124.4046559755108095867.git-patchwork-notify@kernel.org>
Date:   Mon, 01 May 2023 22:40:19 +0000
References: <20230427225333.3506052-1-sveiss@meta.com>
In-Reply-To: <20230427225333.3506052-1-sveiss@meta.com>
To:     Stephen Veiss <sveiss@meta.com>
Cc:     bpf@vger.kernel.org, mykolal@fb.com, andrii@kernel.org,
        yhs@meta.com, daniel@iogearbox.net, ast@kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 27 Apr 2023 15:53:31 -0700 you wrote:
> BPF selftests have ALLOWLIST and DENYLIST files, used to control which
> tests are run in CI. These files are currently parsed by a shell
> script. [1]
> 
> This patchset allows those files to be specified directly on the
> test_progs command line (eg, as -a @ALLOWLIST).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] selftests/bpf: extract insert_test from parse_test_list
    https://git.kernel.org/bpf/bpf-next/c/0a5c0de8b66f
  - [bpf-next,v2,2/2] selftests/bpf: test_progs can read test lists from file
    https://git.kernel.org/bpf/bpf-next/c/64276f01dce8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


