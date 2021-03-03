Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2B3C433E0
	for <bpf@archiver.kernel.org>; Wed,  3 Mar 2021 22:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1686464F0B
	for <bpf@archiver.kernel.org>; Wed,  3 Mar 2021 22:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhCCW3e (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 3 Mar 2021 17:29:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352805AbhCCEUw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Mar 2021 23:20:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B124A64E87;
        Wed,  3 Mar 2021 04:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614745206;
        bh=90ddkU2nE+lTNfzsbBUJ6Xv95pzUpvN1bO6XO94LI2k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=joTkRD79wMum6J8LkWPOoDHdHm3vpYL1l81gIFV3wkLWv55M15BcQqAeJNKFpDCqJ
         eCGQSew2unV91hFB6lpbN0bE5QIEkWgWWcPHMGd8kI/3R+KBUUDETphoBYpKaM78da
         IkN/jLx91qOnrNEdXPrLRm7YyZqJ8GSzBS3J4P0U+xgbJrlmJPYSHMlWSmP1x9jBli
         M4ktXU9ZyMgBY8VF75fLr34mkaPD/C/a1ZlfLotbPzVeqRSN/6qtKZwSxhB7YtyEtp
         bx16EpFsjjPf2nAJLgdhBg71JoPgKfXL7r2lekJTc2awoQGkpy6wiibiTYsgjA/w+y
         JUv0Dvapi1Ptg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] tools/runqslower: allow substituting custom
 vmlinux.h for the build
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161474520665.24993.1081140250035171172.git-patchwork-notify@kernel.org>
Date:   Wed, 03 Mar 2021 04:20:06 +0000
References: <20210303004010.653954-1-andrii@kernel.org>
In-Reply-To: <20210303004010.653954-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, kernel-team@fb.com, kafai@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 2 Mar 2021 16:40:10 -0800 you wrote:
> Just like was done for bpftool and selftests in ec23eb705620 ("tools/bpftool:
> Allow substituting custom vmlinux.h for the build") and ca4db6389d61
> ("selftests/bpf: Allow substituting custom vmlinux.h for selftests build"),
> allow to provide pre-generated vmlinux.h for runqslower build.
> 
> Cc: Martin Lau <kafai@fb.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] tools/runqslower: allow substituting custom vmlinux.h for the build
    https://git.kernel.org/bpf/bpf-next/c/303dcc25b5c7

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


