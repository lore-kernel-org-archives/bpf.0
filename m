Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B93C433E6
	for <bpf@archiver.kernel.org>; Fri, 22 Jan 2021 00:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B61322511
	for <bpf@archiver.kernel.org>; Fri, 22 Jan 2021 00:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbhAVAA7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Jan 2021 19:00:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbhAVAAt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 19:00:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id CA5D022B2D;
        Fri, 22 Jan 2021 00:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611273608;
        bh=DlTiF4+U8ho6NGepEG/zQrQrbzN7AAyBkynydQayxaY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=inYupdIvBtnSa7HYkyKT4j3P5FYIl1iwEBYji6sMT23l2PGbK0hhJlltiPO0XMT/O
         7jDOGfAZwgP1Z8zf+o3JpCDLclgL/zMsEpU0JZkZkdYzV4XM1xv21Njuv24qBbWnte
         E3Pzh2FU5q6LyjjLlWtNcvccshW6JRe92ZWgbraOGhg0KqbNUBCgzTY3Z/4cCxHWHz
         XXYGGtR0UFt682yTDpPj9uMcfllC2YwzttNGGp2rJil7XGWLNht/5+4aQ6iFsAskBG
         ZKt4fHBNFyuXzmvFnTj1YsRZnIFoDoJyHVydI05SSb40O1YbVQgGa+jxkM66D1R/Nj
         qZj+4a9D0y20Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftest/bpf: fix typo
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161127360878.9535.4569848080836230272.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Jan 2021 00:00:08 +0000
References: <20210121122309.1501-1-angkery@163.com>
In-Reply-To: <20210121122309.1501-1-angkery@163.com>
To:     angkery <angkery@163.com>
Cc:     shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, bpf@vger.kernel.org, yangjunlin@yulong.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 21 Jan 2021 20:23:09 +0800 you wrote:
> From: Junlin Yang <yangjunlin@yulong.com>
> 
> Change 'exeeds' to 'exceeds'.
> 
> Signed-off-by: Junlin Yang <yangjunlin@yulong.com>
> ---
> v1: resend this patch with Cc
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftest/bpf: fix typo
    https://git.kernel.org/bpf/bpf-next/c/443edcefb821

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


