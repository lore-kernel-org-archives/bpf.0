Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86471C433E6
	for <bpf@archiver.kernel.org>; Thu, 11 Feb 2021 00:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C83264E2E
	for <bpf@archiver.kernel.org>; Thu, 11 Feb 2021 00:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhBKAAt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Feb 2021 19:00:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232565AbhBKAAr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 19:00:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3DFD964E16;
        Thu, 11 Feb 2021 00:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613001607;
        bh=yj20q5kPQi5rfMEAVi/VtRdZVsbRN8a/HB78My4y0nc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VPa0Fkt2KHwp3qLX6HMos41sC5cmTrFCOYmvabN5gPyLicNextgZmtJBkcMLGgeVT
         ulyMZhWmLduVvR3yfvSpEvdQKhqT8y2vFWNrMqF3aHyMiCePQGaLGWOHwltyfb5+Xx
         dgeBg81XiHSOe4mn2Y9c7RWDAJoqAQRIRHy9BwsV7Y1hAap4nrcP1Ca8Ehleb9/2xv
         QZr0JVS/tMeNsazScdxdQ3pS1SPddb+fpmwY5rkbDOgZfZheoC3LrTYcSHJ7cT1tbA
         VnSVLe4KLNwJ6hoZ7Eu1niqItAczpe9+LkI7HJaCaAGiaQCRCeHjpmhXZ4VwznaZ7C
         D9AXXBOcT9lKw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf_lru_list: Read double-checked variable once without lock
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161300160716.412.6891143842651326044.git-patchwork-notify@kernel.org>
Date:   Thu, 11 Feb 2021 00:00:07 +0000
References: <20210209112701.3341724-1-elver@google.com>
In-Reply-To: <20210209112701.3341724-1-elver@google.com>
To:     Marco Elver <elver@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        paulmck@kernel.org, dvyukov@google.com,
        syzbot+3536db46dfa58c573458@syzkaller.appspotmail.com,
        syzbot+516acdb03d3e27d91bcd@syzkaller.appspotmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue,  9 Feb 2021 12:27:01 +0100 you wrote:
> For double-checked locking in bpf_common_lru_push_free(), node->type is
> read outside the critical section and then re-checked under the lock.
> However, concurrent writes to node->type result in data races.
> 
> For example, the following concurrent access was observed by KCSAN:
> 
>   write to 0xffff88801521bc22 of 1 bytes by task 10038 on cpu 1:
>    __bpf_lru_node_move_in        kernel/bpf/bpf_lru_list.c:91
>    __local_list_flush            kernel/bpf/bpf_lru_list.c:298
>    ...
>   read to 0xffff88801521bc22 of 1 bytes by task 10043 on cpu 0:
>    bpf_common_lru_push_free      kernel/bpf/bpf_lru_list.c:507
>    bpf_lru_push_free             kernel/bpf/bpf_lru_list.c:555
>    ...
> 
> [...]

Here is the summary with links:
  - bpf_lru_list: Read double-checked variable once without lock
    https://git.kernel.org/bpf/bpf-next/c/6df8fb83301d

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


