Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0339CC61DD8
	for <bpf@archiver.kernel.org>; Sat, 14 Nov 2020 19:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9380223B0
	for <bpf@archiver.kernel.org>; Sat, 14 Nov 2020 19:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5QUK3Hn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgKNTkL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 14 Nov 2020 14:40:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgKNTkL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 14 Nov 2020 14:40:11 -0500
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (c-67-180-217-166.hsd1.ca.comcast.net [67.180.217.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1FAB2227F;
        Sat, 14 Nov 2020 19:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605382811;
        bh=ZxkmxCx0SVsZgVAhUbboaa+H7Wcy87kxAeGppg51J1U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L5QUK3HnMWWfCppQVDJUwkIjqaj+fcIuhcAj/lNj1Rz143yigyJN/N5xEk1AF9Tkh
         ruK96lFnHLjN8zBu4Ax2SFYqJJZQ8F1+QSyU7Ki7Frt3iW+mTEqxWx0oKAg/Ozi1aZ
         BUeJvlOG04ZtzgWr7jKb/hcI5830j3jj9UOb3ZLU=
Date:   Sat, 14 Nov 2020 11:40:10 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     davem@davemloft.net, ast@kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: pull-request: bpf-next 2020-11-14
Message-ID: <20201114114010.1b37c427@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201114020819.29584-1-daniel@iogearbox.net>
References: <20201114020819.29584-1-daniel@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, 14 Nov 2020 03:08:19 +0100 Daniel Borkmann wrote:
> 1) Add BTF generation for kernel modules and extend BTF infra in kernel
>    e.g. support for split BTF loading and validation, from Andrii Nakryiko.
> 
> 2) Support for pointers beyond pkt_end to recognize LLVM generated patterns
>    on inlined branch conditions, from Alexei Starovoitov.
> 
> 3) Implements bpf_local_storage for task_struct for BPF LSM, from KP Singh.
> 
> 4) Enable FENTRY/FEXIT/RAW_TP tracing program to use the bpf_sk_storage
>    infra, from Martin KaFai Lau.
> 
> 5) Add XDP bulk APIs that introduce a defer/flush mechanism to optimize the
>    XDP_REDIRECT path, from Lorenzo Bianconi.
> 
> 6) Fix a potential (although rather theoretical) deadlock of hashtab in NMI
>    context, from Song Liu.
> 
> 7) Fixes for cross and out-of-tree build of bpftool and runqslower allowing build
>    for different target archs on same source tree, from Jean-Philippe Brucker.
> 
> 8) Fix error path in htab_map_alloc() triggered from syzbot, from Eric Dumazet.
> 
> 9) Move functionality from test_tcpbpf_user into the test_progs framework so it
>    can run in BPF CI, from Alexander Duyck.
> 
> 10) Lift hashtab key_size limit to be larger than MAX_BPF_STACK, from Florian Lehner.

Pulled, thank you!
