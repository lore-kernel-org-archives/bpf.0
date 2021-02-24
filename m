Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19BEDC433E0
	for <bpf@archiver.kernel.org>; Wed, 24 Feb 2021 16:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C464C64EF5
	for <bpf@archiver.kernel.org>; Wed, 24 Feb 2021 16:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhBXQJJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Feb 2021 11:09:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:57408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232642AbhBXQAu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 11:00:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id B20B564E6C;
        Wed, 24 Feb 2021 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614182407;
        bh=emDGXIic8RWbYZf4WnX4ELjoCudvaFSZSMtPkEKjYuU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t4k+s/SilnbVbGIAjeLAadaldsfvlbJbHFAuJj4i7FdzJ7B1oD2b54sKBcZOjXxSF
         7HPgZOBkGdLDB0NvPrmCvDCnwftzME6/j2/iYsG4gfrZ71QOpbX+RsqThLdHtuCCJE
         vINVoDrvChZN0FWtI1JZkRaJRz6HW7xJUiWGVZhKTid3jKKSSzk3zngO94gCYdFzFi
         h4WOYGqc5wwuTJCTBTdMUNr6mIfP+ROIeEPfR2w7bWexhhXeChCisnznmxC33U6lBY
         9OjImiLtHjDWUdmy2ZaawpILYIb9EJT8Ip15PZdKAEKRgIvhzAgcKh3BO6st7oAOCH
         TrMHMOD5xTveQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: fix missing * in bpf.h
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161418240765.6043.8589277769549164032.git-patchwork-notify@kernel.org>
Date:   Wed, 24 Feb 2021 16:00:07 +0000
References: <20210223124554.1375051-1-liuhangbin@gmail.com>
In-Reply-To: <20210223124554.1375051-1-liuhangbin@gmail.com>
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, daniel@iogearbox.net,
        brouer@redhat.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Tue, 23 Feb 2021 20:45:54 +0800 you wrote:
> Commit 34b2021cc616 ("bpf: Add BPF-helper for MTU checking") lost a *
> in bpf.h. This will make bpf_helpers_doc.py stop building
> bpf_helper_defs.h immediately after bpf_check_mtu, which will affect
> future add functions.
> 
> Fixes: 34b2021cc616 ("bpf: Add BPF-helper for MTU checking")
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: fix missing * in bpf.h
    https://git.kernel.org/bpf/bpf/c/f566aac4e053

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


