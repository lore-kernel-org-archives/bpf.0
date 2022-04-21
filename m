Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FD7C433F5
	for <bpf@archiver.kernel.org>; Thu, 21 Apr 2022 17:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390502AbiDURDI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 21 Apr 2022 13:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352029AbiDURDG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 13:03:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A315496BF;
        Thu, 21 Apr 2022 10:00:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B26DB827BD;
        Thu, 21 Apr 2022 17:00:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA557C385AB;
        Thu, 21 Apr 2022 17:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650560413;
        bh=igHBxsBDv9LXy72s2FLOu0CTl+6oOlqkWtVuEl1zjUE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=od4fuCiAnAT5fsX6cKz1wDB2lge6t9jnkKwQUffyfMs07NW0KGzg9Ao8gTqqyL6t7
         5cB1rLqdRGFgq+BCoGRDSlpygZ6EEqcx+B3UASu10Qye7opO3hvy8ud8fepdH2ycAk
         Kzkc9R5TxjVOZMCFvn0AoR0x4/81JxePXp9Qjr0xSAj1VxPN2hNqFwsqg4QJfeVdo8
         XFDCSxQdB8GwZLLk+3K1PYTaRbFKbVwp8hBq7nEhZ3DIaTUxwr9x4Xr49KSyoYNX/F
         ymQIVQOPDx8QoViifgKmFPHDKANjWll43pg/ksvsWPexERtEgfapqFojRI7Zx0rgoD
         4ZfJJHQt8OXbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 888CAF03853;
        Thu, 21 Apr 2022 17:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next] libbpf: Remove redundant non-null checks on obj_elf
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165056041355.10585.12852812889491153214.git-patchwork-notify@kernel.org>
Date:   Thu, 21 Apr 2022 17:00:13 +0000
References: <20220421031803.2283974-1-cuigaosheng1@huawei.com>
In-Reply-To: <20220421031803.2283974-1-cuigaosheng1@huawei.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, gongruiqi1@huawei.com,
        wangweiyang2@huawei.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 21 Apr 2022 11:18:03 +0800 you wrote:
> Obj_elf is already non-null checked at the function entry, so remove
> redundant non-null checks on obj_elf.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  tools/lib/bpf/libbpf.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [-next] libbpf: Remove redundant non-null checks on obj_elf
    https://git.kernel.org/bpf/bpf-next/c/b71a2ebf74ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


