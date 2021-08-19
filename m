Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C1CC432BE
	for <bpf@archiver.kernel.org>; Thu, 19 Aug 2021 19:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E115610A0
	for <bpf@archiver.kernel.org>; Thu, 19 Aug 2021 19:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbhHSTan (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Aug 2021 15:30:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230058AbhHSTam (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Aug 2021 15:30:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 408F86108D;
        Thu, 19 Aug 2021 19:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629401406;
        bh=83iVwOFKXQZOQq3fVtS2mjfDg1ZlxmT/Y4HejEK2W+k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mFRh0VxxlrcQ2ceFTRpotpHZT7+PMvf9rk+k7WDj0+UeQ33OuSea16yZ8JibmE23C
         tWYxmjiV3IBxqruec7yCktLZvqlL/FXMlWuz9X9oNGRPJVIz2spQksOy+xPrWCmiN6
         Z5ZxUi3S5eYKCwPs/unGvM0eSYFq20J7WNd62o4Pz2cy0EJO402EsBSZ35bGUuCiRD
         YabiAJEm6+ir8znfz5KSPwNHMX6GFVNWreYjQvFsZC/LIsFRqL0j/Tx+zJMQ95f39D
         z1ZbCkGc/ZPATt/a/4hZYMPTKGV60T0bbDDUnzZn0DiHXQF+3LXDBFUpi02obYyQGJ
         wod4ht4hbTbHQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: adding delay in socketmap_listen to
 reduce flakyness
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162940140620.416.23598127393855156.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Aug 2021 19:30:06 +0000
References: <20210819163609.2583758-1-fallentree@fb.com>
In-Reply-To: <20210819163609.2583758-1-fallentree@fb.com>
To:     Yucong Sun <fallentree@fb.com>
Cc:     andrii@kernel.org, sunyucong@gmail.com, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 19 Aug 2021 09:36:09 -0700 you wrote:
> This patch adds a 1ms delay to reduce flakyness of the test.
> 
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>  .../selftests/bpf/prog_tests/sockmap_listen.c        | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [bpf-next] selftests/bpf: adding delay in socketmap_listen to reduce flakyness
    https://git.kernel.org/bpf/bpf-next/c/3666b167ea68

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


