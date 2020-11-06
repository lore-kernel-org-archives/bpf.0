Return-Path: <SRS0=kVCt=EM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7135C388F7
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 03:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F8320885
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 03:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604631605;
	bh=zivFvH2EmKSTwjoE1L09JuEtomwd5wJlLCbNJmLzGUc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=F2HDxF8WNpajU/sYkveWzDSbsELOeisP0z0GriLZzN8B8gGMvgHGdsEdb/q6A/qPY
	 jezviO/kOCzydt4bsR85fA9pr8Qs98HsYlqpR66WM1Y9lr7tPkHWuKonDTXzoPYOu0
	 XcnGU93LDhC4dS6s8bn5laGkwbslrTav/kseakw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbgKFDAF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 5 Nov 2020 22:00:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgKFDAF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 Nov 2020 22:00:05 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604631604;
        bh=zivFvH2EmKSTwjoE1L09JuEtomwd5wJlLCbNJmLzGUc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PpZkvoilugW/rjckrNYGSt/XXmo+ynU4bqLgKfx2L5yrYEmK2OLNDY4FUfUrloC63
         ubdyYdSYak2bSj42keDWkVphV0HZjxuBUWcuRxXV8PtlRwJFBE2XRQyl5OjM9jpLDg
         TF8MOnIlo9DwD6oQnX1L6jMO+0jZbUF+P5bJkL0g=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: BPF_PRELOAD depends on BPF_SYSCALL
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160463160433.6051.614286952023434203.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Nov 2020 03:00:04 +0000
References: <20201105195109.26232-1-rdunlap@infradead.org>
In-Reply-To: <20201105195109.26232-1-rdunlap@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, lkp@intel.com, ast@kernel.org,
        daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (refs/heads/master):

On Thu,  5 Nov 2020 11:51:09 -0800 you wrote:
> Fix build error when BPF_SYSCALL is not set/enabled but BPF_PRELOAD is
> by making BPF_PRELOAD depend on BPF_SYSCALL.
> 
> ERROR: modpost: "bpf_preload_ops" [kernel/bpf/preload/bpf_preload.ko] undefined!
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: netdev@vger.kernel.org
> Cc: bpf@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - bpf: BPF_PRELOAD depends on BPF_SYSCALL
    https://git.kernel.org/bpf/bpf/c/7c0afcad7507

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


