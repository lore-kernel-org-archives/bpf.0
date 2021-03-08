Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C37C433DB
	for <bpf@archiver.kernel.org>; Mon,  8 Mar 2021 18:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DA96526C
	for <bpf@archiver.kernel.org>; Mon,  8 Mar 2021 18:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCHSuY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:50:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:58936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230512AbhCHSuX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Mar 2021 13:50:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id A49E46527A;
        Mon,  8 Mar 2021 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615229422;
        bh=jg/rSLiEH2flcGJK6Lxa/bpilW5SjxG3S+zvHbX25Z4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=c3BKwf2nPnSB0HHqz4qIHHG/Ismdex1rFfqfV/uPkWtoOsNLO1pk81vqrsziVMkA2
         u4gfJHdDU+xvJEPIpHn+MME9U2SYe/5I8cA0TeZc6gl4fhT+3VChY1yPEji/sIR5AD
         GfzYbZsnykeq5FqF9OzdpzNWOOG/chZlLXoehHhHih5i/uV8yAAbuoEZyYHwyeqxzz
         Re3SDKRbfwf3IkOK9/5SGxnMBtpEQtRDAXoAxMml0Bv/E3XLRjE9Wv/pqmWFed/Dgr
         3ssAUfIQX8t0vYAljGZY2BHDxDAkqnEbX36xPbRlurXAqAcJ02RosmVvodK+TNCPHu
         O2mj4ltnuTbtA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 bpf] libbpf: fix INSTALL flag order
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161522942265.22364.8207188698397322594.git-patchwork-notify@kernel.org>
Date:   Mon, 08 Mar 2021 18:50:22 +0000
References: <20210308183038.613432-1-andrii@kernel.org>
In-Reply-To: <20210308183038.613432-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, gvalkov@abv.bg, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Mon, 8 Mar 2021 10:30:38 -0800 you wrote:
> From: Georgi Valkov <gvalkov@abv.bg>
> 
> It was reported ([0]) that having optional -m flag between source and
> destination arguments in install command breaks bpftools cross-build on MacOS.
> Move -m to the front to fix this issue.
> 
>   [0] https://github.com/openwrt/openwrt/pull/3959
> 
> [...]

Here is the summary with links:
  - [v2,bpf] libbpf: fix INSTALL flag order
    https://git.kernel.org/bpf/bpf/c/e7fb6465d4c8

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


