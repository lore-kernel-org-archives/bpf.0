Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10AFC77B76
	for <bpf@archiver.kernel.org>; Tue, 18 Apr 2023 11:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjDRL5w (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 18 Apr 2023 07:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjDRLzv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 07:55:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23729742;
        Tue, 18 Apr 2023 04:54:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AFDA625F0;
        Tue, 18 Apr 2023 11:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21D8C433A1;
        Tue, 18 Apr 2023 11:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681818846;
        bh=AXG/C2BTZBum1dQyk9xGMcX+JvRAly8xQcU58qub2TY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=YWm19zFa301nIsz39oDFn59dpZkUCH2MAVqlW5HDdaX1rAdGSRB1o1hw8xpyfUcxk
         X9anxNHN9gXA711KO6QVbkC9vMQMmrEWLPfg0SpYzrhLQpuxuk8Bg+/XgY+V8O/PDX
         3PAGR0NoOWjjFH4zYUdlavCcVT0IVvyXbuj4WOZMM4X7384z7GeQjLXcfkDp5IVA0v
         cL5b7JyDHDBPPv7XW4tJDJsijvZAtKItqU2bI2OzA69vUdtHjcmS/I5PoG/PEXLzgf
         lwtKNF5/+RRFRs4mUP+TEyi5xupeCBi1Zz4Y9Z65SKbw4disf506aJnBYryW1r3JVR
         YgXncspNH3AwA==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Aleksandr Nogikh <nogikh@google.com>, pulehui@huawei.com,
        bpf@vger.kernel.org
Cc:     linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: arch/riscv/net/bpf_jit_comp64.c build error
In-Reply-To: <CANp29Y6YqPbE9Y3iQEaTwD_YAQBvsxxRE=0COVYy=gBP-USvkg@mail.gmail.com>
References: <CANp29Y6YqPbE9Y3iQEaTwD_YAQBvsxxRE=0COVYy=gBP-USvkg@mail.gmail.com>
Date:   Tue, 18 Apr 2023 13:54:03 +0200
Message-ID: <871qkh9zj8.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Aleksandr Nogikh <nogikh@google.com> writes:

> Hi Pu Lehui,
>
> I'm writing to you regarding your following patch.
>
> Author: Pu Lehui <pulehui@huawei.com>
> Date:   Wed Feb 15 21:52:04 2023 +0800
>
>     riscv, bpf: Add bpf_arch_text_poke support for RV64
>
> When trying to compile the "fixes" branch of the
> "git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git" tree,
> syzbot gets the following error:
>
> arch/riscv/net/bpf_jit_comp64.c: In function 'bpf_arch_text_poke':
> arch/riscv/net/bpf_jit_comp64.c:691:9: error: implicit declaration of
> function 'patch_text'; did you mean 'path_get'?
> [-Werror=3Dimplicit-function-declaration]
>   691 |   ret =3D patch_text(ip, new_insns, ninsns);
>       |         ^~~~~~~~~~
>       |         path_get
>
> FWIW the compiler is riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1
> 20210110, GNU ld (GNU Binutils for Debian) 2.35.2.
>
> Could you please take a look?

Randy sent a fix for this [1], which went in via the BPF tree. Pull in
commit 2d311f480b52 ("riscv, bpf: Fix patch_text implicit declaration").


Bj=C3=B6rn

[1] https://lore.kernel.org/linux-riscv/20230227072016.14618-1-rdunlap@infr=
adead.org/
