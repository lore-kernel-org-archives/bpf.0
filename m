Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C00FC433F5
	for <bpf@archiver.kernel.org>; Tue, 26 Apr 2022 22:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348728AbiDZWx2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Apr 2022 18:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245546AbiDZWx1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Apr 2022 18:53:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6E12127F
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 15:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DAA7BB823EC
        for <bpf@vger.kernel.org>; Tue, 26 Apr 2022 22:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83271C385AC;
        Tue, 26 Apr 2022 22:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651013415;
        bh=IFtjDcTQKjYkVeNbx63PnW2/AR1udB9XyGsNCidFIHQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Hw1LqrUEBXtNQ1bqt7SvvMvGVJwh84b5Ote3hCBH6gvv2gTt9z6vseNH5yDTsnSll
         UBP7G54Tpfez1+lNLofN17PdEdyYuW48GYYICVmuKODkEsxSonTHb2BXwluO+7Z6/c
         osbwmCLNrFWLOsu8963ShW92+xqcqp+P0reSROqMsoBZnxY8rV2k51Ttz21ehawPAU
         IptyO3NKryNRhiaW1joGBVGr7YVbn2GSnqUii5AIOtWlhqRfUgc+rTteJzGFpUpDIR
         p7Wz6m6sAIQGB+YgrPtNvIMNaw9uTJOCilFTbc0/8p62KWAxGc6Wrmg5goc05XSMng
         fhQTAZniDYzPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 68963EAC09C;
        Tue, 26 Apr 2022 22:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 00/10] Teach libbpf to "fix up" BPF verifier log
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <165101341542.30553.18010940413969630125.git-patchwork-notify@kernel.org>
Date:   Tue, 26 Apr 2022 22:50:15 +0000
References: <20220426004511.2691730-1-andrii@kernel.org>
In-Reply-To: <20220426004511.2691730-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This series was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 25 Apr 2022 17:45:01 -0700 you wrote:
> This patch set teaches libbpf to enhance BPF verifier log with human-readable
> and relevant information about failed CO-RE relocation. Patch #9 is the main
> one with the new logic. See relevant commit messages for some more details.
> 
> All the other patches are either fixing various bugs detected
> while working on this feature, most prominently a bug with libbpf not handling
> CO-RE relocations for SEC("?...") programs, or are refactoring libbpf
> internals to allow for easier reuse of CO-RE relo lookup and formatting logic.
> 
> [...]

Here is the summary with links:
  - [bpf-next,01/10] libbpf: fix anonymous type check in CO-RE logic
    https://git.kernel.org/bpf/bpf-next/c/afe98d46ba22
  - [bpf-next,02/10] libbpf: drop unhelpful "program too large" guess
    https://git.kernel.org/bpf/bpf-next/c/0994a54c5202
  - [bpf-next,03/10] libbpf: fix logic for finding matching program for CO-RE relocation
    https://git.kernel.org/bpf/bpf-next/c/966a75093253
  - [bpf-next,04/10] libbpf: avoid joining .BTF.ext data with BPF programs by section name
    https://git.kernel.org/bpf/bpf-next/c/11d5daa89254
  - [bpf-next,05/10] selftests/bpf: add CO-RE relos and SEC("?...") to linked_funcs selftests
    https://git.kernel.org/bpf/bpf-next/c/b82bb1ffbb9a
  - [bpf-next,06/10] libbpf: record subprog-resolved CO-RE relocations unconditionally
    https://git.kernel.org/bpf/bpf-next/c/185cfe837fdb
  - [bpf-next,07/10] libbpf: refactor CO-RE relo human description formatting routine
    https://git.kernel.org/bpf/bpf-next/c/b58af63aab11
  - [bpf-next,08/10] libbpf: simplify bpf_core_parse_spec() signature
    https://git.kernel.org/bpf/bpf-next/c/14032f264453
  - [bpf-next,09/10] libbpf: fix up verifier log for unguarded failed CO-RE relos
    https://git.kernel.org/bpf/bpf-next/c/9fdc4273b8da
  - [bpf-next,10/10] selftests/bpf: add libbpf's log fixup logic selftests
    https://git.kernel.org/bpf/bpf-next/c/ea4128eb43eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


