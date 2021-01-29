Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216C7C433E6
	for <bpf@archiver.kernel.org>; Fri, 29 Jan 2021 00:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF88064DEB
	for <bpf@archiver.kernel.org>; Fri, 29 Jan 2021 00:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhA2AmB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Jan 2021 19:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231575AbhA2Akw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jan 2021 19:40:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 191CA61481;
        Fri, 29 Jan 2021 00:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611880811;
        bh=nA9naOfVkaEyFBrZRUNE7Iz+oUfnwrm//mN8FBP4glg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Mkl/WZitognKtWMksdP3rgPyuDZV/IRr1Kmw8M3tqOhpltxItNkxTqpS127ijLsYf
         U4DmSevmoMiPw5o/ubAlGyAq1RFrF9o4BfrL6NDE2idBh9RLs7Mr4YoauuSnu4Vy9f
         /oS8N4oIFf9oOrEuXboZ1wuGi9fkgLohenRhzrYv5WDWfmdgYvJyZXPVtHasTyQo/O
         lPMnuI8GV2bgtlFJD5wP4fN/Hxwh+t2tJY9acKpffR3PYv3spc6+BYaydgCEPrkjqw
         zrwsvN3hYWj67MEyY2oN5rZRpRPJ3+rPPOPScNvto16kbw/gamHxVhjz4TqxDb9cx5
         A4el5tbxMqzjA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] tools: Factor Clang, LLC and LLVM utils definitions
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <161188081098.4317.7357078159366339576.git-patchwork-notify@kernel.org>
Date:   Fri, 29 Jan 2021 00:40:10 +0000
References: <20210128015117.20515-1-sedat.dilek@gmail.com>
In-Reply-To: <20210128015117.20515-1-sedat.dilek@gmail.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, shuah@kernel.org, natechancellor@gmail.com,
        ndesaulniers@google.com, quentin@isovalent.com,
        jean-philippe@linaro.org, tklauser@distanz.ch, iii@linux.ibm.com,
        hex@fb.com, eranian@google.com, fche@redhat.com,
        tommyhebb@gmail.com, mhiramat@kernel.org, davem@davemloft.net,
        dcaratti@redhat.com, briana.oursler@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        clang-built-linux@googlegroups.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (refs/heads/master):

On Thu, 28 Jan 2021 02:50:58 +0100 you wrote:
> When dealing with BPF/BTF/pahole and DWARF v5 I wanted to build bpftool.
> 
> While looking into the source code I found duplicate assignments
> in misc tools for the LLVM eco system, e.g. clang and llvm-objcopy.
> 
> Move the Clang, LLC and/or LLVM utils definitions to
> tools/scripts/Makefile.include file and add missing
> includes where needed.
> Honestly, I was inspired by commit c8a950d0d3b9
> ("tools: Factor HOSTCC, HOSTLD, HOSTAR definitions").
> 
> [...]

Here is the summary with links:
  - [bpf-next] tools: Factor Clang, LLC and LLVM utils definitions
    https://git.kernel.org/bpf/bpf-next/c/211a741cd3e1

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


