Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D36CC56201
	for <bpf@archiver.kernel.org>; Thu, 19 Nov 2020 19:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6D7424655
	for <bpf@archiver.kernel.org>; Thu, 19 Nov 2020 19:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PENxc16r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgKSTAG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 19 Nov 2020 14:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:60144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbgKSTAG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Nov 2020 14:00:06 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605812405;
        bh=tKZvzFocHZ94fJ2BwxLsjEsBGMpIYOwbna8PZfmUqUQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PENxc16r+LVGxf+jrgKMdCcAqqfPutW6b8wRNvqpa2cFJRcRTIByM8s2ASyJxLP1b
         pkusgxqHxGb90ZopaHrE976du1vfzPJOfh30FkWpO2W4D/oZxJFlVfEFf2con4sg0n
         OFLC/f/P456ptGnFY2M9FRZId+ANX7pehBxWvcTA=
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v7 0/2] Fix bpf_probe_read_user_str() overcopying
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <160581240571.6156.14990667088525286782.git-patchwork-notify@kernel.org>
Date:   Thu, 19 Nov 2020 19:00:05 +0000
References: <cover.1605642949.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1605642949.git.dxu@dxuuu.xyz>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, songliubraving@fb.com,
        andrii.nakryiko@gmail.com, torvalds@linux-foundation.org,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf.git (refs/heads/master):

On Tue, 17 Nov 2020 12:05:44 -0800 you wrote:
> 6ae08ae3dea2 ("bpf: Add probe_read_{user, kernel} and probe_read_{user,
> kernel}_str helpers") introduced a subtle bug where
> bpf_probe_read_user_str() would potentially copy a few extra bytes after
> the NUL terminator.
> 
> This issue is particularly nefarious when strings are used as map keys,
> as seemingly identical strings can occupy multiple entries in a map.
> 
> [...]

Here is the summary with links:
  - [bpf,v7,1/2] lib/strncpy_from_user.c: Don't overcopy bytes after NUL terminator
    https://git.kernel.org/bpf/bpf/c/33b97ea52713
  - [bpf,v7,2/2] selftest/bpf: Test bpf_probe_read_user_str() strips trailing bytes after NUL
    https://git.kernel.org/bpf/bpf/c/a8005439fc81

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


