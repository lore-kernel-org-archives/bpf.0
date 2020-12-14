Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D71C2BB9A
	for <bpf@archiver.kernel.org>; Mon, 14 Dec 2020 15:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A67622518
	for <bpf@archiver.kernel.org>; Mon, 14 Dec 2020 15:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439044AbgLNPva (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 14 Dec 2020 10:51:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:35306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439078AbgLNPur (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Dec 2020 10:50:47 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607961006;
        bh=qfSkywVxi8bHRHis4d/vB01QNrT6uvZqHOdQA352IPU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MFDQZTNU7crZbVi4/KmZ58VR849DpUZetJ3dDc+DObFgn8WE75nK6kC61OTjbAX6k
         IOELxsWPKnGfaqf3v2D1GlbjhXVX5qso73z7RtEJpqTJTf0h1FJaoFYR9SwJWg6d6d
         28YI1LlzTBMFUW/hurzhEQ/Tr3ZnZGATVBlUoL+pc9zMNk4mO2QJSqjstXqvPXHhZr
         HdJ5ZR1Op7BHad4BzW5O9gmDYDhlRO/msewgnNhsuye+jP+OnFsxuGLu2aVeP5acAs
         pQqyArDy2HOnEEuujQ4AETb0vTZstqc3SkehTdjG2EZzMz2Q3UuyLGEKBCzlsYLxZS
         h610xDFiCM5ug==
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] libbpf: support modules in set_attach_target()
 API
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160796100647.7023.1440666593259323373.git-patchwork-notify@kernel.org>
Date:   Mon, 14 Dec 2020 15:50:06 +0000
References: <20201211215825.3646154-1-andrii@kernel.org>
In-Reply-To: <20201211215825.3646154-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Fri, 11 Dec 2020 13:58:23 -0800 you wrote:
> Add support for finding BTF-based kernel attach targets (fentry/fexit
> functions, tp_btf tracepoints, etc) with programmatic
> bpf_program__set_attach_target() API. It is now as capable as libbpf's
> SEC()-based logic.
> 
> Andrii Nakryiko (2):
>   libbpf: support modules in bpf_program__set_attach_target() API
>   selftests/bpf: add set_attach_target() API selftest for module target
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] libbpf: support modules in bpf_program__set_attach_target() API
    https://git.kernel.org/bpf/bpf-next/c/fe62de310e2b
  - [bpf-next,2/2] selftests/bpf: add set_attach_target() API selftest for module target
    https://git.kernel.org/bpf/bpf-next/c/2e33f831fccd

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


