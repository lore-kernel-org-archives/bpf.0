Return-Path: <SRS0=AFkz=DO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40CDC4727F
	for <bpf@archiver.kernel.org>; Wed,  7 Oct 2020 18:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 811B821789
	for <bpf@archiver.kernel.org>; Wed,  7 Oct 2020 18:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1602093610;
	bh=RxghwV+bm56ZKYUOT0hYvsRwDmfaKzzU0Z/8ZNEvssA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=A9wSNxmlklD1r5+DmQq3WadOO3Ah9iZCY20+TFP31cVlJ4UgpaETz0EZdi5poAxKC
	 qfVgtM+WFFABQjbwnkv7YPsWEw/QKR9e2uz/lULWqYW2JKRFk/Ggr5JpjFRsWNPV7V
	 XZLpLUgIBh4GYoJ7Iz1AWxC2Ts2gGQsocvGEIFDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgJGSAF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 7 Oct 2020 14:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbgJGSAE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Oct 2020 14:00:04 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602093603;
        bh=RxghwV+bm56ZKYUOT0hYvsRwDmfaKzzU0Z/8ZNEvssA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=n3kqUtn+nuEIXkhsVRRcdEETzPCzfKTnI+lg1cFsGMdkYP3rwfGo793w1oPrb4MzZ
         TpiDvSYkrAiTzrCMLSRxxXqRKsm5rOpq3xgk5TXJLeX8i147xqpFWBPxYZAKZ6sDY9
         a0PKSM6W1WgOlIqPTe/9YCK5OECrE+tsKAB6Vxww=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: fix build failure for kernel/trace/bpf_trace.c
 with CONFIG_NET=n
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160209360336.7046.15696471491976584744.git-patchwork-notify@kernel.org>
Date:   Wed, 07 Oct 2020 18:00:03 +0000
References: <20201007062933.3425899-1-yhs@fb.com>
In-Reply-To: <20201007062933.3425899-1-yhs@fb.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, songliubraving@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Tue, 6 Oct 2020 23:29:33 -0700 you wrote:
> When CONFIG_NET is not defined, I hit the following build error:
>     kernel/trace/bpf_trace.o:(.rodata+0x110): undefined reference to `bpf_prog_test_run_raw_tp'
> 
> Commit 1b4d60ec162f ("bpf: Enable BPF_PROG_TEST_RUN for raw_tracepoint")
> added test_run support for raw_tracepoint in /kernel/trace/bpf_trace.c.
> But the test_run function bpf_prog_test_run_raw_tp is defined in
> net/bpf/test_run.c, only available with CONFIG_NET=y.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: fix build failure for kernel/trace/bpf_trace.c with CONFIG_NET=n
    https://git.kernel.org/bpf/bpf-next/c/ebfb4d40ed9d

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


