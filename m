Return-Path: <SRS0=PNb+=DG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E54C47420
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 18:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588B321924
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 18:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601403604;
	bh=BNIcJIXedxm/RSKS1P8mm6Xt3zcebnqMKpR7viofVWU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=pXVtUeAvR/WDVn7wq+BdTy8GD/3HA/KwNe1cVXvEzbgOKV1n4uZtk1hpp+vMOe5ya
	 d76P7KjBXafkfY6vPKMBRqgFgyjk4YxSLuIl0ZFHw+jDYMcYM2a8LmN8am1EAvn2rG
	 HsP7dZhcW9O9dYEVSvadUDSoxErEbVOy68UXbW4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgI2SUD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Sep 2020 14:20:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725320AbgI2SUD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 14:20:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601403603;
        bh=BNIcJIXedxm/RSKS1P8mm6Xt3zcebnqMKpR7viofVWU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=N/r0icMTzFnY/R8fuBrKZVj6WIG8zT2DQJ9kBu0xHlP8JPGS4sDFxKuOSAKJd/eqM
         sDyI+MpprQQ1kdwwNjeOLZBTwhr55ILTSmpdBnrpx/dLsKQW0cYrdExo18jwGQq5U8
         tTWsaoEgQaw5tqTnddOE1Oq3Qt6W7cP5Ykn3+GUE=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] selftests/bpf: BTF-based kernel data display
 fixes
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160140360303.18925.12949460606105895151.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 18:20:03 +0000
References: <1601379151-21449-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1601379151-21449-1-git-send-email-alan.maguire@oracle.com>
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 29 Sep 2020 04:32:29 -0700 (PDT) you wrote:
> Resolve issues in bpf selftests introduced with BTF-based kernel data
> display selftests; these are
> 
> - a warning introduced in snprintf_btf.c; and
> - compilation failures with old kernels vmlinux.h
> 
> Alan Maguire (2):
>   selftests/bpf: fix unused-result warning in snprintf_btf.c
>   selftests/bpf: ensure snprintf_btf/bpf_iter tests compatibility with
>     old vmlinux.h
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] selftests/bpf: fix unused-result warning in snprintf_btf.c
    https://git.kernel.org/bpf/bpf-next/c/96c48058db15
  - [bpf-next,2/2] selftests/bpf: ensure snprintf_btf/bpf_iter tests compatibility with old vmlinux.h
    https://git.kernel.org/bpf/bpf-next/c/cfe77683b8d4

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


