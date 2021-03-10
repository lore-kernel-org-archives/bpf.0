Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1084EC43381
	for <bpf@archiver.kernel.org>; Wed, 10 Mar 2021 22:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9F564FB1
	for <bpf@archiver.kernel.org>; Wed, 10 Mar 2021 22:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhCJWAd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Mar 2021 17:00:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:46202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232845AbhCJWAI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 17:00:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 880AE64E27;
        Wed, 10 Mar 2021 22:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615413608;
        bh=N9nIpb+7khXuC8q/4agRC1J0DvRtQshCBUqPToq27v0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WGru9/D22ou9yzpolPUZJLgHlTM2VfqoKSvlW6lHmnUViKdv6TfBh6ED9U5+Igv1t
         cYcVKox2UKg0e6PZz23WKuyDVURhlJ4szfBM18oCox/JqGAyAz878j5k4SrVzFlLSY
         DnpCydAH3KY6ku/q2kjJPxJEaIiO31b9PT1aiOCCIrqx19tKPJ4JovBjFavh3KYJo6
         rM1eIzT4+hwLtbtU+4yTacckO1FRBgMKyUP+vZKpJvD5Ws8BA5UT138sABLyJmI23Q
         mLQbg5b8BHBH6wZeN73Et0LraUg2SeaRL0u0NB1zUJ2wXbcp7JV8H0zKKO5jXu+4yv
         SAfukmk7iqkgg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] selftests/bpf: fix warning comparing pointer to 0
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161541360851.31690.1803072687405130309.git-patchwork-notify@kernel.org>
Date:   Wed, 10 Mar 2021 22:00:08 +0000
References: <1615357366-97612-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1615357366-97612-1-git-send-email-jiapeng.chong@linux.alibaba.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 10 Mar 2021 14:22:46 +0800 you wrote:
> Fix the following coccicheck warning:
> 
> ./tools/testing/selftests/bpf/progs/test_global_func10.c:17:12-13:
> WARNING comparing pointer to 0.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> 
> [...]

Here is the summary with links:
  - selftests/bpf: fix warning comparing pointer to 0
    https://git.kernel.org/bpf/bpf-next/c/04ea63e34a2e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


