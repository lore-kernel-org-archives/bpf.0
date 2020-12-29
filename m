Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6CBC433E0
	for <bpf@archiver.kernel.org>; Tue, 29 Dec 2020 14:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4C3207C9
	for <bpf@archiver.kernel.org>; Tue, 29 Dec 2020 14:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgL2OUr (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Dec 2020 09:20:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:54904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgL2OUq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Dec 2020 09:20:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3EC8C207D1;
        Tue, 29 Dec 2020 14:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609251606;
        bh=ppFpc8YpWiFuiGCE+BmBJKur35Hz2jpCudL4Gvg0byc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CrcjYf6oT5DIZi4+xkKsUv61G3D4kNJStq58ZZm9Tck3Q0EQGMOd+2W6R2I+5dnmP
         gRc8A0wQk8JiRMdVeWCtX2o7UIaUoy/yteDVIhPQ64aO2M/zn4iIaFwXoZdSJq1FR0
         QWvQWeqNxTaVp5pDXytyu6U1Dq7rel7x8n2SAXHVd6W2jNd0u9TQTRQXoS7nAS2jQ+
         tg31hSubY7xrlrjVqQzOLRxhKql5QVeYFlZUaVQGUN5u6DdUrravG+bmZ82KflFuLq
         7huJ+uwJM1MyVV3YPernjh7G49CWJEZH7Ez8Ikp9oFbDPtJgrbuQP2Vodd29wTLvgF
         PcKvhxoaZSAKg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: Remove unnecessary <argp.h> include from
 preload/iterators
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160925160620.2585.17801325123968170711.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Dec 2020 14:20:06 +0000
References: <20201216100306.30942-1-leah@vuxu.org>
In-Reply-To: <20201216100306.30942-1-leah@vuxu.org>
To:     Leah Neukirchen <leah@vuxu.org>
Cc:     bpf@vger.kernel.org, hayashi.kunihiko@socionext.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 16 Dec 2020 11:03:06 +0100 you wrote:
> This program does not use argp (which is a glibcism).
> Instead include <errno.h> directly, which was pulled in by <argp.h>.
> 
> Signed-off-by: Leah Neukirchen <leah@vuxu.org>
> ---
>  kernel/bpf/preload/iterators/iterators.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - bpf: Remove unnecessary <argp.h> include from preload/iterators
    https://git.kernel.org/bpf/bpf-next/c/1bcf3a740aa5

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


