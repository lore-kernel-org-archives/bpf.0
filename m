Return-Path: <SRS0=IWuG=RQ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 039D0C4360F
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 22:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01D121019
	for <bpf@archiver.kernel.org>; Wed, 13 Mar 2019 22:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfCMWPj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 13 Mar 2019 18:15:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:41464 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfCMWPi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Mar 2019 18:15:38 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x2DMEghi031276;
        Wed, 13 Mar 2019 17:14:42 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id x2DMEcO4031272;
        Wed, 13 Mar 2019 17:14:38 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 13 Mar 2019 17:14:37 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Sandipan Das <sandipan@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michael Ellerman <mpe@ellerman.id.au>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: bpf jit PPC64 (BE) test_verifier PTR_TO_STACK store/load failure
Message-ID: <20190313221436.GO3969@gate.crashing.org>
References: <xuny4l87qc2v.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xuny4l87qc2v.fsf@redhat.com>
User-Agent: Mutt/1.4.2.3i
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

On Wed, Mar 13, 2019 at 12:54:16PM +0200, Yauheni Kaliuta wrote:
> This is because of the handling of the +2 offset.

The low two bits of instructions with primary opcodes 58 and 62 are part
of the opcode, not the offset.  These instructions can not have offsets
with the low two bits non-zero.

> For stores it is:
> #define PPC_STD(r, base, i)	EMIT(PPC_INST_STD | ___PPC_RS(r) |	      \
> 				     ___PPC_RA(base) | ((i) & 0xfffc))
> 
> and for loads
> #define PPC_LD(r, base, i)	EMIT(PPC_INST_LD | ___PPC_RT(r) |	      \
> 				     ___PPC_RA(base) | IMM_L(i))
> #define IMM_L(i)		((uintptr_t)(i) & 0xffff)
> 
> So, in the load case the offset +2 (immediate value) is not
> masked and turns the instruction to lwa instead of ld.
> 
> Would it be correct to & 0xfffc the immediate value as well?

That is only part of it.  The other thing is you have to make sure those
low bits are zero *already* (and then you do not need the mask anymore).
For example, if the low two bits are not zero load the offset into a
register instead (and then do ldx or lwax).


Segher
