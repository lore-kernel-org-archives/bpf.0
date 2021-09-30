Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E5FC433F5
	for <bpf@archiver.kernel.org>; Thu, 30 Sep 2021 16:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6038761350
	for <bpf@archiver.kernel.org>; Thu, 30 Sep 2021 16:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349758AbhI3QVw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 30 Sep 2021 12:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349802AbhI3QVu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Sep 2021 12:21:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 88F8C613D1;
        Thu, 30 Sep 2021 16:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633018807;
        bh=Y642sI6KysBX5Rz4PcKYJERDb51nS+v8kKGKLm0a4GM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cVtbYR946cwDdXD6dytAA6jfiHLOQwCQ6DmWklqybgskstU6u1dJy0hH6k0hiIl3Z
         Li90YwEZD5VjITzeKYrUWXOhAy+iPyPQB2s03e8WhhiHPF+AmwBSIHied6EL1tWy6o
         M/Dxb76X9tiZCXuoytXesBeruSbZPwyyd/jKXsORz6MzJy9Oj0fW3/tqnM7NYYaP7F
         CmY2+rl8gp8HkDCA2JXqCyA8HAewy2+gbLGW/mJMu1UXhyMeBFDuK2hqPRP4M4cI9g
         mBiQcdwOMil+tKEsFS7K0xj4djO8eGZZNpFNPd0KjUh064Sj4igrvO6s9sQ2rGhDzq
         xX74E1x9x3pDw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bpf: Fix integer overflow in prealloc_elems_and_freelist()
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <163301880750.556.15888903601273023133.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Sep 2021 16:20:07 +0000
References: <20210930135545.173698-1-th.yasumatsu@gmail.com>
In-Reply-To: <20210930135545.173698-1-th.yasumatsu@gmail.com>
To:     Tatsuhiko Yasumatsu <th.yasumatsu@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Thu, 30 Sep 2021 22:55:45 +0900 you wrote:
> In prealloc_elems_and_freelist(), the multiplication to calculate the
> size passed to bpf_map_area_alloc() could lead to an integer overflow.
> As a result, out-of-bounds write could occur in pcpu_freelist_populate()
> as reported by KASAN:
> 
> [...]
> [   16.968613] BUG: KASAN: slab-out-of-bounds in pcpu_freelist_populate+0xd9/0x100
> [   16.969408] Write of size 8 at addr ffff888104fc6ea0 by task crash/78
> [   16.970038]
> [   16.970195] CPU: 0 PID: 78 Comm: crash Not tainted 5.15.0-rc2+ #1
> [   16.970878] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> [   16.972026] Call Trace:
> [   16.972306]  dump_stack_lvl+0x34/0x44
> [   16.972687]  print_address_description.constprop.0+0x21/0x140
> [   16.973297]  ? pcpu_freelist_populate+0xd9/0x100
> [   16.973777]  ? pcpu_freelist_populate+0xd9/0x100
> [   16.974257]  kasan_report.cold+0x7f/0x11b
> [   16.974681]  ? pcpu_freelist_populate+0xd9/0x100
> [   16.975190]  pcpu_freelist_populate+0xd9/0x100
> [   16.975669]  stack_map_alloc+0x209/0x2a0
> [   16.976106]  __sys_bpf+0xd83/0x2ce0
> [...]
> 
> [...]

Here is the summary with links:
  - [v2] bpf: Fix integer overflow in prealloc_elems_and_freelist()
    https://git.kernel.org/bpf/bpf/c/30e29a9a2bc6

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


