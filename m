Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E13C07E96
	for <bpf@archiver.kernel.org>; Tue,  6 Jul 2021 10:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 674CC619C6
	for <bpf@archiver.kernel.org>; Tue,  6 Jul 2021 10:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhGFKze (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 6 Jul 2021 06:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhGFKze (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Jul 2021 06:55:34 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAABFC06175F
        for <bpf@vger.kernel.org>; Tue,  6 Jul 2021 03:52:55 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GJzsy1QGmz9sXV; Tue,  6 Jul 2021 20:52:54 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@redhat.com>,
        Brendan Jackman <jackmanb@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/2] powerpc/bpf: Fix issue with atomic ops
Message-Id: <162556873716.460578.10069325708926626758.b4-ty@ellerman.id.au>
Date:   Tue, 06 Jul 2021 20:52:17 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 1 Jul 2021 20:38:57 +0530, Naveen N. Rao wrote:
> The first patch fixes an issue that causes a soft lockup on ppc64 with
> the BPF_ATOMIC bounds propagation verifier test. The second one updates
> ppc32 JIT to reject atomic operations properly.
> 
> - Naveen
> 
> Naveen N. Rao (2):
>   powerpc/bpf: Fix detecting BPF atomic instructions
>   powerpc/bpf: Reject atomic ops in ppc32 JIT
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/bpf: Fix detecting BPF atomic instructions
      https://git.kernel.org/powerpc/c/419ac821766cbdb9fd85872bb3f1a589df05c94c
[2/2] powerpc/bpf: Reject atomic ops in ppc32 JIT
      https://git.kernel.org/powerpc/c/307e5042c7bdae15308ef2e9b848833b84122eb0

cheers
