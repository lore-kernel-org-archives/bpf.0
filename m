Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07F8C433F5
	for <bpf@archiver.kernel.org>; Mon,  3 Oct 2022 23:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJCXuW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 3 Oct 2022 19:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiJCXuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Oct 2022 19:50:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4461CFD5;
        Mon,  3 Oct 2022 16:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1ED0FB81686;
        Mon,  3 Oct 2022 23:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDEC9C433D7;
        Mon,  3 Oct 2022 23:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664841016;
        bh=fjWoGVlpF+2/4trOPoHtstU5D0NvCQteA6D4jbCehMI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Q03k84JSzmPMYP0zgnfdlqr/sTZkTiHc/rnEdPN3CKR00b+ER7EIeNU2WzgXPW9nJ
         3qXN5Ju5ryhehlCptPozszOec8T6YfI+IGhdz3ZxhAO5WCYRnCC/vhZiCIlH+i7bLS
         e5S0HuZuukSVLu7HlVOjhOzTko4OE+cBxNohgm/0lIMDu98MU+9jTUeZVF+fMMJYOl
         vxZ6abeOWtYbFzlY6ixe4kRAtIzsoTua1SGVgfBVZUBAIKSGjZ9+XmZV9Xo4QbLIZC
         MzqV/XXI706JUCJrTbN+fCDxeCL/rIXF0MavIEOnIZZWIqcAxF9NECgjz/cOibTzxT
         MlpZV3c4rWUGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9FB97E49FA3;
        Mon,  3 Oct 2022 23:50:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf 2022-10-03
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166484101664.29578.14594582447594809345.git-patchwork-notify@kernel.org>
Date:   Mon, 03 Oct 2022 23:50:16 +0000
References: <20221003201957.13149-1-daniel@iogearbox.net>
In-Reply-To: <20221003201957.13149-1-daniel@iogearbox.net>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        edumazet@google.com, ast@kernel.org, andrii@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Oct 2022 22:19:57 +0200 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net* tree.
> 
> Note that into net tree this pulls cleanly, but for later merge of net into
> net-next there will be a small merge conflict in kernel/bpf/helpers.c
> between commit 8addbfc7b308 ("bpf: Gate dynptr API behind CAP_BPF") from
> bpf and commit 5679ff2f138f ("bpf: Move bpf_loop and bpf_for_each_map_elem
> under CAP_BPF") as well as 8a67f2de9b1d ("bpf: expose bpf_strtol and
> bpf_strtoul to all program types") from bpf-next.
> 
> [...]

Here is the summary with links:
  - pull-request: bpf 2022-10-03
    https://git.kernel.org/netdev/net/c/ad061cf4222f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


