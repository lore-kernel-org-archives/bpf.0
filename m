Return-Path: <SRS0=PNb+=DG=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6F8C4741F
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 14:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA87207F7
	for <bpf@archiver.kernel.org>; Tue, 29 Sep 2020 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601391004;
	bh=A7OrBZ2t9dvfy9ArxkVBjQDpYTEaGRaCxWFdPFuB34g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=kK35E8ABGr+SPp30dZOZRnC5OJSaWaTbAw7JlVusQ2OhjXhbJwJEDMtFpTs5X8zPV
	 SsVJJmLdTWOZjLJsSL6KYaInxp1zXIN66+BBs4hYALUS5OOqvDFDnTA0UQcakAe9b0
	 zkc2dqfDZiWwDah08+WYWu4WMxMMPqi3/wvXW3Bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729038AbgI2OuD (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 29 Sep 2020 10:50:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbgI2OuD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Sep 2020 10:50:03 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601391002;
        bh=A7OrBZ2t9dvfy9ArxkVBjQDpYTEaGRaCxWFdPFuB34g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SuYGVnEcVLNQ/UUTlKRCDLD9oS3vkGUXNGFuHqanhp3CZ6uHYWPC+XUilL7/bgR09
         Ewvb4oFD9q0PZ0RE0BG6mfs6QX/zRhjSqCRL4dXCmRC/nbx3rVT8eEmWtxI5Fu4f6h
         UNpE9/C5HdobP/O34j8XfVjlNc9eiggJXw9HAx6M=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] powerpc: net: bpf_jit_comp: Fix misuse of fallthrough
From:   patchwork-bot+bpf@kernel.org
Message-Id: <160139100285.9570.3050757599508198365.git-patchwork-notify@kernel.org>
Date:   Tue, 29 Sep 2020 14:50:02 +0000
References: <20200928090023.38117-1-zhe.he@windriver.com>
In-Reply-To: <20200928090023.38117-1-zhe.he@windriver.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Mon, 28 Sep 2020 17:00:23 +0800 you wrote:
> From: He Zhe <zhe.he@windriver.com>
> 
> The user defined label following "fallthrough" is not considered by GCC
> and causes build failure.
> 
> kernel-source/include/linux/compiler_attributes.h:208:41: error: attribute
> 'fallthrough' not preceding a case label or default label [-Werror]
>  208   define fallthrough _attribute((fallthrough_))
>                           ^~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - powerpc: net: bpf_jit_comp: Fix misuse of fallthrough
    https://git.kernel.org/bpf/bpf/c/9cf51446e686

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


