Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44C2C4338F
	for <bpf@archiver.kernel.org>; Thu, 29 Jul 2021 22:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E7C60F5E
	for <bpf@archiver.kernel.org>; Thu, 29 Jul 2021 22:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhG2WkJ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 29 Jul 2021 18:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229795AbhG2WkI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 18:40:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 277BA60F6F;
        Thu, 29 Jul 2021 22:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627598405;
        bh=cmxfOOb0z6cj7G5XZXBIee6zGWueTv1jsBY+UQ5yOcA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qkUCWE511gOufiXQPcUpsl1UteE09C384XbzclrzJr78E/QBDEA58YNstz4Ox//FZ
         U2YBuYk7lbxYyr0hTWaB+SwYyMqvcqNo65lXXgwiDLluCL1don8bDtZ+vfop69GAMA
         tq60mtA02e1zvCeZCCfPtQCa20CVdU9GL1XS6N9+J7A5LXNWA9f19FaSTWASqGpyfO
         kcgS6dJQ7S+QNuR7h4UJ06gMnaPp+I56kHYXpH9zRarpjjMmyRqftxquHKmZXEELXn
         FHnUqy89CPLTx/sAiW2VBc8BzZbaIPQPedi1OaNGD/kz9Lb5CSEyklquIUYVTP+2OY
         sOH6KaAY+VBzA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND bpf] libbpf: fix probe for BPF_PROG_TYPE_CGROUP_SOCKOPT
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162759840511.16381.1837433437038471811.git-patchwork-notify@kernel.org>
Date:   Thu, 29 Jul 2021 22:40:05 +0000
References: <20210728225825.2357586-1-r.goegge@gmail.com>
In-Reply-To: <20210728225825.2357586-1-r.goegge@gmail.com>
To:     =?utf-8?q?Robin_G=C3=B6gge_=3Cr=2Egoegge=40googlemail=2Ecom=3E?=@ci.codeaurora.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        sdf@google.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        r.goegge@gmail.com, quentin@isovalent.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Thu, 29 Jul 2021 00:58:25 +0200 you wrote:
> This patch fixes the probe for BPF_PROG_TYPE_CGROUP_SOCKOPT,
> so the probe reports accurate results when used by e.g.
> bpftool.
> 
> Fixes: 4cdbfb59c44a ("libbpf: support sockopt hooks")
> 
> Signed-off-by: Robin Gögge <r.goegge@gmail.com>
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
> 
> [...]

Here is the summary with links:
  - [RESEND,bpf] libbpf: fix probe for BPF_PROG_TYPE_CGROUP_SOCKOPT
    https://git.kernel.org/bpf/bpf/c/19f6fb5956fc

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


