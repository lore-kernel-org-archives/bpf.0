Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2E0C433ED
	for <bpf@archiver.kernel.org>; Tue, 11 May 2021 21:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FE5161921
	for <bpf@archiver.kernel.org>; Tue, 11 May 2021 21:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhEKVbR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 11 May 2021 17:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhEKVbQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 17:31:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id C6B00613A9;
        Tue, 11 May 2021 21:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620768609;
        bh=CY3XSaHL566xPOOMU3oQLhWbTLCROjGsEgserggjsIU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=J9APIy0h5CrRblDCSXvLUyaFmU6W+2Expm8LilBbwGeQZTzqCJjaJlJE+Mf7ofKfR
         Sk9cRPS5zRuKcypYUksAVckPLTpb4PrXFZy8KVuKIXkvEw+xcvhGshUxJd0S7TXwt0
         uLlfEq0RRnx2OGx4C0X4znn+F9qDrukapTyF0169GGtgfjdlHQK+2nEtLJ2tr1umZX
         9/HthTHGbpbCp7PioSmt3xR2qaof/wtnCMED4IWY1tvT3g/XsygkaHAz79KM4mqPV2
         A9pXStqoZkKpNtzvOgrWq10EbfCAL+Ft3DJbDrFssVNi15Wb6JkcyCo4XsckYSpXEL
         y4/sRMzWdbJmQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v3] selftests/bpf: Rewrite test_tc_redirect.sh as
 prog_tests/tc_redirect.c
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162076860974.722.10828670605241355661.git-patchwork-notify@kernel.org>
Date:   Tue, 11 May 2021 21:30:09 +0000
References: <20210505085925.783985-1-joamaki@gmail.com>
In-Reply-To: <20210505085925.783985-1-joamaki@gmail.com>
To:     Jussi Maki <joamaki@gmail.com>
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net,
        andrii.nakryiko@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Wed,  5 May 2021 08:59:25 +0000 you wrote:
> Ports test_tc_redirect.sh to the test_progs framework and removes the
> old test. This makes it more in line with rest of the tests and makes
> it possible to run this test with vmtest.sh and under the bpf CI.
> 
> Signed-off-by: Jussi Maki <joamaki@gmail.com>
> ---
>  tools/testing/selftests/bpf/network_helpers.c |   2 +-
>  tools/testing/selftests/bpf/network_helpers.h |   1 +
>  .../selftests/bpf/prog_tests/tc_redirect.c    | 589 ++++++++++++++++++
>  .../selftests/bpf/progs/test_tc_neigh.c       |  33 +-
>  .../selftests/bpf/progs/test_tc_neigh_fib.c   |   9 +-
>  .../selftests/bpf/progs/test_tc_peer.c        |  33 +-
>  .../testing/selftests/bpf/test_tc_redirect.sh | 216 -------
>  7 files changed, 617 insertions(+), 266 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/tc_redirect.c
>  delete mode 100755 tools/testing/selftests/bpf/test_tc_redirect.sh

Here is the summary with links:
  - [bpf,v3] selftests/bpf: Rewrite test_tc_redirect.sh as prog_tests/tc_redirect.c
    https://git.kernel.org/bpf/bpf/c/096eccdef0b3

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


