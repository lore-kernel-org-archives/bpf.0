Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C991CC2D0A3
	for <bpf@archiver.kernel.org>; Mon,  9 Nov 2020 16:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6210E221F1
	for <bpf@archiver.kernel.org>; Mon,  9 Nov 2020 16:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfadf+rH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729982AbgKIQaG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 9 Nov 2020 11:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729973AbgKIQaF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Nov 2020 11:30:05 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604939405;
        bh=+5kJG3NMtrcLDCLz+/f2Sl4IGMJodjcOI5wNJ3FQhKI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hfadf+rH1a8CqCFpR/rfI5a4wvjJQ8AofbOrv2qAL0LCe9kI/gwLDOQY8E9mzE+4q
         22wjIyfThT4EGWK7hm6UC+8eA3NN70tmyW5TmSLBBLLS1ymgTpJH4xkK2OOrPt5i+8
         /IPCwXmJzaG8F5ib7+S9csB9ezVUnwQbXgIEV1o0=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v4 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160493940533.2913.16972160195346742271.git-patchwork-notify@kernel.org>
Date:   Mon, 09 Nov 2020 16:30:05 +0000
References: <4ff12d0c19de63e7172d25922adfb83ae7c8691f.1604620776.git.dxu@dxuuu.xyz>
In-Reply-To: <4ff12d0c19de63e7172d25922adfb83ae7c8691f.1604620776.git.dxu@dxuuu.xyz>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        andrii.nakryiko@gmail.com, kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (refs/heads/master):

On Thu,  5 Nov 2020 16:06:34 -0800 you wrote:
> do_strncpy_from_user() may copy some extra bytes after the NUL
> terminator into the destination buffer. This usually does not matter for
> normal string operations. However, when BPF programs key BPF maps with
> strings, this matters a lot.
> 
> A BPF program may read strings from user memory by calling the
> bpf_probe_read_user_str() helper which eventually calls
> do_strncpy_from_user(). The program can then key a map with the
> resulting string. BPF map keys are fixed-width and string-agnostic,
> meaning that map keys are treated as a set of bytes.
> 
> [...]

Here is the summary with links:
  - [bpf,v4,1/2] lib/strncpy_from_user.c: Don't overcopy bytes after NUL terminator
    https://git.kernel.org/bpf/bpf/c/baca7f1c1c1e
  - [bpf,v4,2/2] selftest/bpf: Test bpf_probe_read_user_str() strips trailing bytes after NUL
    https://git.kernel.org/bpf/bpf/c/d18b184127de

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


