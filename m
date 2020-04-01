Return-Path: <SRS0=joy4=5R=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D9BC43331
	for <bpf@archiver.kernel.org>; Wed,  1 Apr 2020 12:53:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41FA20675
	for <bpf@archiver.kernel.org>; Wed,  1 Apr 2020 12:53:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732459AbgDAMxL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:53:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46271 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732435AbgDAMxL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Apr 2020 08:53:11 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48smMS2jDxz9sT6; Wed,  1 Apr 2020 23:53:07 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a7032637b54186e5649917679727d7feaec932b1
In-Reply-To: <20190812215052.71840-10-ndesaulniers@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        akpm@linux-foundation.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Song Liu <songliubraving@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        clang-built-linux@googlegroups.com, yhs@fb.com,
        jpoimboe@redhat.com, sedat.dilek@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Geoff Levand <geoff@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH 10/16] powerpc: prefer __section and __printf from compiler_attributes.h
Message-Id: <48smMS2jDxz9sT6@ozlabs.org>
Date:   Wed,  1 Apr 2020 23:53:07 +1100 (AEDT)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2019-08-12 at 21:50:43 UTC, Nick Desaulniers wrote:
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a7032637b54186e5649917679727d7feaec932b1

cheers
