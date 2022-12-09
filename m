Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB95C4167B
	for <bpf@archiver.kernel.org>; Fri,  9 Dec 2022 17:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbiLIRuS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 9 Dec 2022 12:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiLIRuR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 12:50:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983747A192;
        Fri,  9 Dec 2022 09:50:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3646C622E8;
        Fri,  9 Dec 2022 17:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9009BC433F0;
        Fri,  9 Dec 2022 17:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670608215;
        bh=9qzt9BQpb73mPkbaBSKVFKBm13JD2EkP8hbzXLiTBnQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g74Ndkk9OkIuv+LVReNyJ1hp5bCJ9csAILmVly+jpeop8fB5IZmsSCR+gYDgbSIjb
         YrqE6nuoy826mCBq6spHqmLGfKj8pzc8Cmvb40bgqEnkxYEi9ew8X5awipNVRWiQ9k
         PFU0mPVHKfjpi443c6NZ8e4GSp0kde6QF6PT9nGTPypNTh5O5qt63YSTv43T7jQIxN
         1qGaXzH7Cip2JCKvWA+b/8ug525XpdsPwTt8vDvi7vnwHegdeB7JB3r+VL8xmXJtR5
         f+VpvkC6Ql5f5VmOZ+FzH/rhD7PFMMvhbIb4WBE0cg881h2xXzLU26DIlTyR8F0JVU
         iQ1kq5hQSFBqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74EE3E1B4D9;
        Fri,  9 Dec 2022 17:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v4] docs/bpf: Add documentation for
 BPF_MAP_TYPE_SK_STORAGE
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <167060821547.31126.2706063406083427383.git-patchwork-notify@kernel.org>
Date:   Fri, 09 Dec 2022 17:50:15 +0000
References: <20221209112401.69319-1-donald.hunter@gmail.com>
In-Reply-To: <20221209112401.69319-1-donald.hunter@gmail.com>
To:     Donald Hunter <donald.hunter@gmail.com>
Cc:     bpf@vger.kernel.org, linux-doc@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, corbet@lwn.net,
        yhs@meta.com, void@manifault.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  9 Dec 2022 11:24:01 +0000 you wrote:
> Add documentation for the BPF_MAP_TYPE_SK_STORAGE including
> kernel version introduced, usage and examples.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
> v3 -> v4:
> - Update intro paragraph with detail about storage locality.
> - Remove confusing text from bpf_map_update_elem()
>   as reported by David Vernet
> - Updated BPF_EXIST and BPF_NOEXIST behaviour as suggested
>   by David Vernet
> - Fixed extra space in function signature as reported by
>   David Vernet
> - Added reference to selftests for complete examples as
>   suggested by Yonghong Song
> v2 -> v3:
> - Fix void * return, reported by Yonghong Song
> - Add tracing programs to API note, reported by Yonghong Song
> v1 -> v2:
> - Fix bpf_sk_storage_* function signatures, reported by Yonghong Song
> - Fix NULL return on failure, reported by Yonghong Song
> 
> [...]

Here is the summary with links:
  - [bpf-next,v4] docs/bpf: Add documentation for BPF_MAP_TYPE_SK_STORAGE
    https://git.kernel.org/bpf/bpf-next/c/f3212ad5b7e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


