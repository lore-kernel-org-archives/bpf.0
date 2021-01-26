Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424B5C433E6
	for <bpf@archiver.kernel.org>; Tue, 26 Jan 2021 16:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F62821E92
	for <bpf@archiver.kernel.org>; Tue, 26 Jan 2021 16:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404355AbhAZQK5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Jan 2021 11:10:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404480AbhAZQKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Jan 2021 11:10:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 8825021E92;
        Tue, 26 Jan 2021 16:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611677410;
        bh=3iSSaXDYEP4kn4RdZmyK9hoYwtGVODXjkRw+i+Zs/Ck=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iq+w4TMlaCU6kNmODDVA4/k1cLPDsnmjIQ4p4PVq+c1tZwccwscBV6F9r4XDXf2TK
         Jx6payQM5FLRzmPK8XgV1FpNjHKSmmq5B0SH++m36XwDJmJV7P1EX2Zup3/DstXR1l
         XVBjto2m3SAYa3VlL50K43F/RcbH4GvcHkS/zNBaXsiF2W3iuSJeFpGFscSIUdL3t+
         rkudW1KlZLBdBP5qVeBkEpCRGXu3QGGiCimMiCrgQseLvd92nswBBdWF0VsFPQcvJw
         vezMgPUCqK3klWfSZPV4AXgRz9VDggDY0GBqG0uzT/5UNwTwCHjcZ8Yznys818K2O9
         WWMHpsr1ZnTYQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] selftests/bpf: don't exit on failed bpf_testmod
 unload
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161167741047.22282.14409289492552812997.git-patchwork-notify@kernel.org>
Date:   Tue, 26 Jan 2021 16:10:10 +0000
References: <20210126065019.1268027-1-andrii@kernel.org>
In-Reply-To: <20210126065019.1268027-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 25 Jan 2021 22:50:18 -0800 you wrote:
> Fix bug in handling bpf_testmod unloading that will cause test_progs exiting
> prematurely if bpf_testmod unloading failed. This is especially problematic
> when running a subset of test_progs that doesn't require root permissions and
> doesn't rely on bpf_testmod, yet will fail immediately due to exit(1) in
> unload_bpf_testmod().
> 
> Fixes: 9f7fa225894c ("selftests/bpf: Add bpf_testmod kernel module for testing")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> 
> [...]

Here is the summary with links:
  - [bpf-next] selftests/bpf: don't exit on failed bpf_testmod unload
    https://git.kernel.org/bpf/bpf-next/c/86ce322d21eb

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


