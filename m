Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53613C6379F
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 15:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07882245B
	for <bpf@archiver.kernel.org>; Fri, 20 Nov 2020 15:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z29qCP65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgKTPAH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 20 Nov 2020 10:00:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:45356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727872AbgKTPAG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 10:00:06 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605884405;
        bh=JtOBq9k5Q7gxm5FYBu4N1VZSOARirpJvz4gTERAL3Pk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Z29qCP65QBLi6ywgoo6qVQINqsqolPX3Ouc+/8N/g/AJaSGyH4Ow1LNjdH90vNVwf
         GgOUtJiTiHrtJxOx89HwhCompIgfbdvVmm/3fvlOD4s1TxxmrQFVFzWU4jczTIfSZN
         YB0SaaeJFoauaIXUqUsocuKL34nJFgELswxeLCkk=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpftool: add {i,d}tlb_misses support for bpftool
 profile
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160588440572.22328.16982569855942163.git-patchwork-notify@kernel.org>
Date:   Fri, 20 Nov 2020 15:00:05 +0000
References: <20201119073039.4060095-1-yhs@fb.com>
In-Reply-To: <20201119073039.4060095-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, songliubraving@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Wed, 18 Nov 2020 23:30:39 -0800 you wrote:
> Commit 47c09d6a9f67("bpftool: Introduce "prog profile" command")
> introduced "bpftool prog profile" command which can be used
> to profile bpf program with metrics like # of instructions,
> 
> This patch added support for itlb_misses and dtlb_misses.
> During an internal bpf program performance evaluation,
> I found these two metrics are also very useful. The following
> is an example output:
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpftool: add {i,d}tlb_misses support for bpftool profile
    https://git.kernel.org/bpf/bpf-next/c/450d060e8f75

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


