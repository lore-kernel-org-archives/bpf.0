Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C74C6369E
	for <bpf@archiver.kernel.org>; Thu, 12 Nov 2020 05:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 227562076E
	for <bpf@archiver.kernel.org>; Thu, 12 Nov 2020 05:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF+6BuUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbgKLFim (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 12 Nov 2020 00:38:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727790AbgKLCaG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Nov 2020 21:30:06 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605148205;
        bh=m6rUkqJKq9F3iC5CPTIt//ZsZFBtNJ/6kyXuw7EeVxU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gF+6BuUiT2OLrhLMs8oxgd/dXncy4gSsGBZwiVVjqYyhAomzFR3r6clRq3LvrYVld
         T19N3C1wiDvzIDBZKHnTkoBE16mkHhLpmSrKLjeKZfOtN7CDmGzoxzjXpeJna5OYtj
         t1Z+wUlSopwQ3bn0gppND643TUMELr83F7yhiUn0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Fix NULL dereference in bpf_task_storage
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160514820562.32619.7344516183978068506.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Nov 2020 02:30:05 +0000
References: <20201112001919.2028357-1-kafai@fb.com>
In-Reply-To: <20201112001919.2028357-1-kafai@fb.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, guro@fb.com, kpsingh@chromium.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 11 Nov 2020 16:19:19 -0800 you wrote:
> In bpf_pid_task_storage_update_elem(), it missed to
> test the !task_storage_ptr(task) which then could trigger a NULL
> pointer exception in bpf_local_storage_update().
> 
> Fixes: 4cf1bc1f1045 ("bpf: Implement task local storage")
> Tested-by: Roman Gushchin <guro@fb.com>
> Cc: KP Singh <kpsingh@chromium.org>
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Fix NULL dereference in bpf_task_storage
    https://git.kernel.org/bpf/bpf-next/c/09a3dac7b579

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


