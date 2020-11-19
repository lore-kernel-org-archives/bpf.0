Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB3BC388F9
	for <bpf@archiver.kernel.org>; Thu, 19 Nov 2020 19:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9274422267
	for <bpf@archiver.kernel.org>; Thu, 19 Nov 2020 19:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xtXbG1Om"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgKSTKG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Nov 2020 14:10:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727414AbgKSTKG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Nov 2020 14:10:06 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605813005;
        bh=VMFZb4lVrAacMR7fWWEUSQnByu4OpqbokI7aHyckUGs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=xtXbG1OmaYJG5blm4IZUB+13bPHD7CjZOec2X5i5c01Ar/6CYcZLa/LbyNQi9pWIx
         fs7sIXSwQX+qFDqXdAWT2KQ35wwErkdESCYaVxdSW43g5/Oit3nN6lRSDWgfMQZLvI
         i0CaFiUfYuzEakaBW0pMCLpoyQWYwdmJXq70fWBY=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] fail_function: remove a redundant mutex unlock
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160581300537.10604.4454902032527726160.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Nov 2020 19:10:05 +0000
References: <160570737118.263807.8358435412898356284.stgit@devnote2>
In-Reply-To: <160570737118.263807.8358435412898356284.stgit@devnote2>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     jbacik@fb.com, ast@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, luomeng12@huawei.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Wed, 18 Nov 2020 22:49:31 +0900 you wrote:
> From: Luo Meng <luomeng12@huawei.com>
> 
> Fix a mutex_unlock() issue where before copy_from_user() is
> not called mutex_locked.
> 
> Fixes: 4b1a29a7f542 ("error-injection: Support fault injection framework")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Luo Meng <luomeng12@huawei.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> [...]

Here is the summary with links:
  - fail_function: remove a redundant mutex unlock
    https://git.kernel.org/bpf/bpf/c/891515d945a3

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


