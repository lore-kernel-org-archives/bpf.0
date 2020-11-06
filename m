Return-Path: <SRS0=kVCt=EM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FFCC2D0A3
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 16:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92DCE22203
	for <bpf@archiver.kernel.org>; Fri,  6 Nov 2020 16:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604680207;
	bh=7+TLDC0TsrPzHnm18zh2FFLZMNWt6KUkleHczhCixcI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=tTjPgILpHMJs+elyLUyKD3tL0MlNVRcp0OP8gX8BBWKhEn6m8O7+ro0UJlUw2G/Dp
	 6AsJ6FF5Kxk56nc0/GPkuU8+/0GfUZO7PFyuENP7KqljqWxe5RduYtleeBLT8kjrSM
	 6XPYxSniknMzW5zh1IWJnnSzDx2XwXZVX0AP2FWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgKFQaH (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 6 Nov 2020 11:30:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:39326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgKFQaG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Nov 2020 11:30:06 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604680206;
        bh=7+TLDC0TsrPzHnm18zh2FFLZMNWt6KUkleHczhCixcI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dXX4qPXCSZ2z3S19tsVQDoeV8uVoY2UQpcS9So7QF7mhy/8elRheRSPcGFIEKVT3T
         RpWnxXv1Bt4RmQ2a+MVl5NJR50eAns7QOwfFYPf79lcIaRv4JyqgkjWFxDpCMVvhW8
         pzIZvUDO1feib8ELeak3Z+8yrxAtNOMBdEp5be08=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v6 1/9] bpf: Allow LSM programs to use bpf spin locks
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160468020631.12149.17904247795919763724.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Nov 2020 16:30:06 +0000
References: <20201106103747.2780972-2-kpsingh@chromium.org>
In-Reply-To: <20201106103747.2780972-2-kpsingh@chromium.org>
To:     KP Singh <kpsingh@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        songliubraving@fb.com, kafai@fb.com, ast@kernel.org,
        daniel@iogearbox.net, pjt@google.com, jannh@google.com,
        haoluo@google.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Fri,  6 Nov 2020 10:37:39 +0000 you wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Usage of spin locks was not allowed for tracing programs due to
> insufficient preemption checks. The verifier does not currently prevent
> LSM programs from using spin locks, but the helpers are not exposed
> via bpf_lsm_func_proto.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v6,1/9] bpf: Allow LSM programs to use bpf spin locks
    https://git.kernel.org/bpf/bpf-next/c/9e7a4d9831e8
  - [bpf-next,v6,2/9] bpf: Implement task local storage
    https://git.kernel.org/bpf/bpf-next/c/4cf1bc1f1045
  - [bpf-next,v6,3/9] libbpf: Add support for task local storage
    https://git.kernel.org/bpf/bpf-next/c/8885274d2259
  - [bpf-next,v6,4/9] bpftool: Add support for task local storage
    https://git.kernel.org/bpf/bpf-next/c/864ab0616dcc
  - [bpf-next,v6,5/9] bpf: Implement get_current_task_btf and RET_PTR_TO_BTF_ID
    https://git.kernel.org/bpf/bpf-next/c/3ca1032ab7ab
  - [bpf-next,v6,6/9] bpf: Fix tests for local_storage
    https://git.kernel.org/bpf/bpf-next/c/f0e5ba0bc481
  - [bpf-next,v6,7/9] bpf: Update selftests for local_storage to use vmlinux.h
    https://git.kernel.org/bpf/bpf-next/c/a367efa71b3f
  - [bpf-next,v6,8/9] bpf: Add tests for task_local_storage
    https://git.kernel.org/bpf/bpf-next/c/9cde3beeadb3
  - [bpf-next,v6,9/9] bpf: Exercise syscall operations for inode and sk storage
    https://git.kernel.org/bpf/bpf-next/c/4170bc6baa54

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


