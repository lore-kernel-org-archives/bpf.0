Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9299FC4338F
	for <bpf@archiver.kernel.org>; Tue, 17 Aug 2021 01:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB1D60E90
	for <bpf@archiver.kernel.org>; Tue, 17 Aug 2021 01:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbhHQBkn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 16 Aug 2021 21:40:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237247AbhHQBki (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 21:40:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 00B7360EAF;
        Tue, 17 Aug 2021 01:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629164406;
        bh=Bq5DAX+WmnZEJclLVBLHelBXsBDj33/78+o64HHUWik=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZgvsveUWdZkjJoTSLicmrwl3hoWQXC6BSvb51DYSRnnhMGz1EHduHCSIvhhXrYCTA
         JIzqVkH8i2g/j+SE/AHe5norkn9vaCThrDooEsonykxyqnlly6uiWUOY6C2tEbHrVo
         7Pjrv9Ys+zvtg01lntt/i/P/3WuXTRlApWBt0uukwyq4cV0m31znECiyyv/SaKJrNL
         qG0JFIFHeDK5bdZm0W3UM7xx3cs40vmbY4tDTpuTJCTK162zCBQXgH/7FU0wvAFzAu
         ibSAty5UD437DXMD2YLrt8PxI0NqfyhebZ0aWNIQ5PdiJWzpO1y2QEQCNwBUT43bui
         OCDRWWPfMJM5g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Test
 btf__load_vmlinux_btf/btf__load_module_btf APIs
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <162916440594.16860.1942480031572783865.git-patchwork-notify@kernel.org>
Date:   Tue, 17 Aug 2021 01:40:05 +0000
References: <20210815081035.205879-1-hengqi.chen@gmail.com>
In-Reply-To: <20210815081035.205879-1-hengqi.chen@gmail.com>
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, john.fastabend@gmail.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Sun, 15 Aug 2021 16:10:35 +0800 you wrote:
> Add test for btf__load_vmlinux_btf/btf__load_module_btf APIs. The test
> loads bpf_testmod module BTF and check existence of a symbol which is
> known to exist.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/btf_module.c     | 34 +++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_module.c

Here is the summary with links:
  - [bpf-next,v3] selftests/bpf: Test btf__load_vmlinux_btf/btf__load_module_btf APIs
    https://git.kernel.org/bpf/bpf-next/c/edce1a248670

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


