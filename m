Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C43C43600
	for <bpf@archiver.kernel.org>; Wed, 21 Apr 2021 13:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E47A961457
	for <bpf@archiver.kernel.org>; Wed, 21 Apr 2021 13:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbhDUNK5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 21 Apr 2021 09:10:57 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241993AbhDUNJn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:43 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FQLV93XvFz9vDk; Wed, 21 Apr 2021 23:09:04 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     naveen.n.rao@linux.ibm.com, sandipan@linux.ibm.com, yhs@fb.com,
        Paul Mackerras <paulus@samba.org>, john.fastabend@gmail.com,
        andrii@kernel.org, daniel@iogearbox.net,
        Christophe Leroy <christophe.leroy@csgroup.eu>, kafai@fb.com,
        songliubraving@fb.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        kpsingh@chromium.org, Michael Ellerman <mpe@ellerman.id.au>,
        ast@kernel.org
Cc:     netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <34d12a4f75cb8b53a925fada5e7ddddd3b145203.1618227846.git.christophe.leroy@csgroup.eu>
References: <34d12a4f75cb8b53a925fada5e7ddddd3b145203.1618227846.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] powerpc/ebpf32: Fix comment on BPF_ALU{64} | BPF_LSH | BPF_K
Message-Id: <161901050428.1961279.6678434799432870652.b4-ty@ellerman.id.au>
Date:   Wed, 21 Apr 2021 23:08:24 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 12 Apr 2021 11:44:16 +0000 (UTC), Christophe Leroy wrote:
> Replace <<== by <<=

Applied to powerpc/next.

[1/3] powerpc/ebpf32: Fix comment on BPF_ALU{64} | BPF_LSH | BPF_K
      https://git.kernel.org/powerpc/c/d228cc4969663623e6b5a749b02e4619352a0a8d
[2/3] powerpc/ebpf32: Rework 64 bits shifts to avoid tests and branches
      https://git.kernel.org/powerpc/c/e7de0023e1232f42a10ef6af03352538cc27eaf6
[3/3] powerpc/ebpf32: Use standard function call for functions within 32M distance
      https://git.kernel.org/powerpc/c/ee7c3ec3b4b1222b30272624897826bc40d79bc5

cheers
