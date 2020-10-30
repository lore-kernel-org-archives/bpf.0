Return-Path: <SRS0=hyEm=EF=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F06C00A89
	for <bpf@archiver.kernel.org>; Fri, 30 Oct 2020 20:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53BCA20731
	for <bpf@archiver.kernel.org>; Fri, 30 Oct 2020 20:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604089206;
	bh=XWSheRzi9X/Gj8xeayBbtccyeSrp0vNSYoCISUnlEik=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:List-ID:From;
	b=PFrNmCb4AZMq8/BsJCzwQ6oQw5c3XXQMjswsw6mMCbIZlKXoIpJ/dvGOCnpuPFNg+
	 bom2wFKz/IRLMo7vLLyudwUZnkR4YWaY+z80JCmIIjW5ZLdHpyCRhBf2/y+4Soo3cD
	 Lh110z18ZDEo49wDnQG3DEFI+Xy9u2NOtlo3PYGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgJ3UUF (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 30 Oct 2020 16:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgJ3UUF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Oct 2020 16:20:05 -0400
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604089205;
        bh=XWSheRzi9X/Gj8xeayBbtccyeSrp0vNSYoCISUnlEik=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=T0oMAFrmN+rACiaYB+VR2FrDqmjBJfUdls9GeaItetax3j4oU8HKjAReAvmpsF7kl
         67ASDhqVkpntYoNTeL3FVeJqSjpLz2MTTavwOLWAf+lra0jjCevUjUNzJOXKYYUhNt
         9ODinKB+mRzxALI18hHB4w1I7Ne0c2fa3wQf5Vf8=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/2] bpf: safeguard hashtab locking in NMI context
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160408920507.23182.15914549359111070599.git-patchwork-notify@kernel.org>
Date:   Fri, 30 Oct 2020 20:20:05 +0000
References: <20201029071925.3103400-1-songliubraving@fb.com>
In-Reply-To: <20201029071925.3103400-1-songliubraving@fb.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        kpsingh@chromium.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 29 Oct 2020 00:19:23 -0700 you wrote:
> LOCKDEP NMI warning highlighted potential deadlock of hashtab in NMI
> context:
> 
> [   74.828971] ================================
> [   74.828972] WARNING: inconsistent lock state
> [   74.828973] 5.9.0-rc8+ #275 Not tainted
> [   74.828974] --------------------------------
> [   74.828975] inconsistent {INITIAL USE} -> {IN-NMI} usage.
> [   74.828976] taskset/1174 [HC2[2]:SC0[0]:HE0:SE1] takes:
> [...]
> [   74.828999]  Possible unsafe locking scenario:
> [   74.828999]
> [   74.829000]        CPU0
> [   74.829001]        ----
> [   74.829001]   lock(&htab->buckets[i].raw_lock);
> [   74.829003]   <Interrupt>
> [   74.829004]     lock(&htab->buckets[i].raw_lock);
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/2] bpf: use separate lockdep class for each hashtab
    https://git.kernel.org/bpf/bpf-next/c/c50eb518e262
  - [bpf-next,2/2] bpf: Avoid hashtab deadlock with map_locked
    https://git.kernel.org/bpf/bpf-next/c/20b6cc34ea74

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


