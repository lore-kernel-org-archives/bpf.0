Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13FFC04A95
	for <bpf@archiver.kernel.org>; Fri, 23 Sep 2022 23:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiIWXaZ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 23 Sep 2022 19:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbiIWXaS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Sep 2022 19:30:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17DA99D1
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 16:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8240461631
        for <bpf@vger.kernel.org>; Fri, 23 Sep 2022 23:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CDB4DC433D7;
        Fri, 23 Sep 2022 23:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663975814;
        bh=f2X645xXjwR9hjN/HCMvmwFWVwrddclwmDjvhKWpDgE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ddC2rOfhYuOooIwxFneWEMziufdivUxduS56j8E+ECHCFWWMbnO02+HKPlKFExS+X
         2UQySWoWGBpo/tmWKA1kDPkRwfEuJY29u5ZUOZ2Or7iN38WZr8QX1T2iNz4vLfN3PJ
         HMccw4K2Jxoy5IZSt3GMBU2E2H5i6AkzOFcUnURnrNHjK66Wi4s6bqlbLRwQZepxB+
         ejEibB/2TxHPQsgqcQwuRFUq9GggvDMk2J/mn3Fs7E7imo3oxJbJb+DTjgd9CgEXDz
         ahm7pJZS0mtWhiC6XMZY1M22hbnNvcW3a0r0nD0JICnozB8BlNdqAR39KabGIwTLCw
         5mw26ePYOXRaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5CCAC070C8;
        Fri, 23 Sep 2022 23:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: restore memory layout of
 bpf_object_open_opts
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <166397581474.8857.10749529299879806327.git-patchwork-notify@kernel.org>
Date:   Fri, 23 Sep 2022 23:30:14 +0000
References: <20220923230559.666608-1-andrii@kernel.org>
In-Reply-To: <20220923230559.666608-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, grantseltzer@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Martin KaFai Lau <martin.lau@kernel.org>:

On Fri, 23 Sep 2022 16:05:59 -0700 you wrote:
> When attach_prog_fd field was removed in libbpf 1.0 and replaced with
> `long: 0` placeholder, it actually shifted all the subsequent fields by
> 8 byte. This is due to `long: 0` promising to adjust next field's offset
> to long-aligned offset. But in this case we were already long-aligned
> as pin_root_path is a pointer. So `long: 0` had no effect, and thus
> didn't feel the gap created by removed attach_prog_fd.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: restore memory layout of bpf_object_open_opts
    https://git.kernel.org/bpf/bpf-next/c/dbdea9b36fb6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


