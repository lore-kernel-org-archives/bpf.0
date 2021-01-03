Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC75C433E0
	for <bpf@archiver.kernel.org>; Sun,  3 Jan 2021 00:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2130206F9
	for <bpf@archiver.kernel.org>; Sun,  3 Jan 2021 00:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbhACAuq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 2 Jan 2021 19:50:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbhACAuq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Jan 2021 19:50:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3CDDC2078E;
        Sun,  3 Jan 2021 00:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609635006;
        bh=EAHXiHS4OzA1WBssLvIUl2ldX+LzhXKQiiNZqbc+ZHc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iyp7CioVLpSmPCqkMEabDm6t1TwrRZKrc9rruASL3AnMBTQNyteNF+40EEwADllTg
         7pgE9RSIf2YV8pLNXErfYdZTsWyvsdxvp95ng8C04URT+7yB6EgIozMym81v4WwvNe
         ufFrWca2C/1Neda1eDOs9TfGpdamZe1MlDZOYMXBFX3jXNdyCHY5RKugOgAW10DICN
         tUfQo+d9tR7fkUUA3FdG7G5v7fJwp7jFePG9oSnEieVwzG3Mkqdaib6TWC5Sn1i6PU
         zxLlEOAd1Qov0wl1r/lOIQ1LdxVxg6JJvgrODXJiYGuBjlGc5JaO2wJmfs7UVQLUhn
         TC91iDuqvsyZg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] bpf: fix a task_iter bug caused by a merge conflict
 resolution
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160963500619.25136.4438244384142452463.git-patchwork-notify@kernel.org>
Date:   Sun, 03 Jan 2021 00:50:06 +0000
References: <20201231052418.577024-1-yhs@fb.com>
In-Reply-To: <20201231052418.577024-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Wed, 30 Dec 2020 21:24:18 -0800 you wrote:
> Latest bpf tree has a bug for bpf_iter selftest.
>   $ ./test_progs -n 4/25
>   test_bpf_sk_storage_get:PASS:bpf_iter_bpf_sk_storage_helpers__open_and_load 0 nsec
>   test_bpf_sk_storage_get:PASS:socket 0 nsec
>   ...
>   do_dummy_read:PASS:read 0 nsec
>   test_bpf_sk_storage_get:FAIL:bpf_map_lookup_elem map value wasn't set correctly
>                           (expected 1792, got -1, err=0)
>   #4/25 bpf_sk_storage_get:FAIL
>   #4 bpf_iter:FAIL
>   Summary: 0/0 PASSED, 0 SKIPPED, 2 FAILED
> 
> [...]

Here is the summary with links:
  - [bpf] bpf: fix a task_iter bug caused by a merge conflict resolution
    https://git.kernel.org/bpf/bpf/c/04901aab40ea

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


