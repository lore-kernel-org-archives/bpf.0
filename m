Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A94C433EF
	for <bpf@archiver.kernel.org>; Thu, 23 Jun 2022 18:54:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiFWSyi (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 23 Jun 2022 14:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiFWSyU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jun 2022 14:54:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A914FF9A7
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 11:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B3F661D10
        for <bpf@vger.kernel.org>; Thu, 23 Jun 2022 18:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4A59C341C4;
        Thu, 23 Jun 2022 18:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656007213;
        bh=UkqLLlTkGkIidLBbmmt0OjWgaui4sbFVY0V5GCiNydU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RRAJS5dAPATNliYWy/XiWo/dhSxEaq3ywxkKprI0IYGvZxw9D9tEQKbZtPMU+XlIN
         mYEexg5Axxqml34qvO3d/NEs4XiJ6DVmSnBMOwqz9Cj/3WmVJU4qWsyTpOxio0pV6J
         Ceb4jxxFTga+coth4vnIIyWKRnI2lOmtrY0KQUgyQfXapWn9Ty/IZvMfWeNuuIwwoC
         mo8uRRa3scmN5Md9d6MoIvraKaDILDq8871kvF6QjtfPp+VvcTAi9yrF4U0iof/gcQ
         7y4k06k6EqK/U/nVdd4ogeReEc6gJqqJHbq+470uBIrrSdNETXevkXQ8P2GlwaUS89
         dxSlbA+X3RVmA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9BF5E737F0;
        Thu, 23 Jun 2022 18:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix rare segfault in sock_fields prog
 test
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165600721369.10885.72088434152385801.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Jun 2022 18:00:13 +0000
References: <20220621070116.307221-1-jthinz@mailbox.tu-berlin.de>
In-Reply-To: <20220621070116.307221-1-jthinz@mailbox.tu-berlin.de>
To:     =?utf-8?q?J=C3=B6rn-Thorben_Hinz_=3Cjthinz=40mailbox=2Etu-berlin=2Ede=3E?=@ci.codeaurora.org
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, jakub@cloudflare.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Tue, 21 Jun 2022 09:01:16 +0200 you wrote:
> test_sock_fields__detach() got called with a null pointer here when one
> of the CHECKs or ASSERTs up to the test_sock_fields__open_and_load()
> call resulted in a jump to the "done" label.
> 
> A skeletons *__detach() is not safe to call with a null pointer, though.
> This led to a segfault.
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: Fix rare segfault in sock_fields prog test
    https://git.kernel.org/bpf/bpf-next/c/6dc7a0baf1a7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


