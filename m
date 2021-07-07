Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B27C07E95
	for <bpf@archiver.kernel.org>; Wed,  7 Jul 2021 21:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DCE611C2
	for <bpf@archiver.kernel.org>; Wed,  7 Jul 2021 21:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhGGVMo (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 7 Jul 2021 17:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230185AbhGGVMo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Jul 2021 17:12:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 992E661209;
        Wed,  7 Jul 2021 21:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625692203;
        bh=vt0ESRDPTWeUGHD82MjEXKrJJ5mXfO4JyIUhjTuwNiY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oGQaLqTYLZXQrxE+7fUdcBTzd3wT5Hqjy360Tb/QBvMLHtcP+tO8K+isWFJb8EtR8
         gk/iWLPGZ6LZCqscvOM9gAZSf95SbKagoie64bnBzCk9uF5qSvi2+ZMAppDL3GvKEI
         RYfHccuhtWISmP9FfPSiTlbgztI4zU8pUhKDl2DFjZohk66Pm0NU1c/2WRIFwivm/s
         RcJJ8QLF6mcKajbxUA0JKLXYucoWvUU3W/m1tf0TVFmIXcU59IoXMBC8VZVdNMoYi7
         LIEZ2oDABqhfEQ8u6v27dLJ8RwS8FuEpZVnLDHCmz/ORDLLUPOUqIOkmMHjUtQfeeW
         MtvGZNzA8fbpg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tools: bpf: Fix error in 'make -C tools/ bpf_install'
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162569220356.14612.2663823878014678070.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Jul 2021 21:10:03 +0000
References: <20210628030409.3459095-1-liwei391@huawei.com>
In-Reply-To: <20210628030409.3459095-1-liwei391@huawei.com>
To:     Wei Li <liwei391@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Mon, 28 Jun 2021 11:04:09 +0800 you wrote:
> make[2]: *** No rule to make target 'install'.  Stop.
> make[1]: *** [Makefile:122: runqslower_install] Error 2
> make: *** [Makefile:116: bpf_install] Error 2
> 
> There is no rule for target 'install' in tools/bpf/runqslower/Makefile,
> and there is no need to install it, so just remove 'runqslower_install'.
> 
> [...]

Here is the summary with links:
  - tools: bpf: Fix error in 'make -C tools/ bpf_install'
    https://git.kernel.org/bpf/bpf/c/1d719254c139

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


