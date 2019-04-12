Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A8AC10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 15:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D70E2171F
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 15:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfDLPiX (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:38:23 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37676 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfDLPiX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 11:38:23 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hEyFv-0006qt-Dn; Fri, 12 Apr 2019 17:38:19 +0200
Date:   Fri, 12 Apr 2019 17:38:19 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yonghong Song <yhs@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] bpf: Use spinlock_t in bpf_lru_list
Message-ID: <20190412153819.6sh2b2cwddpgnepq@linutronix.de>
References: <20190410143025.11997-1-bigeasy@linutronix.de>
 <813645e9-6a09-4aa4-0e2e-9b68359b83db@fb.com>
 <4150a0db-18f9-aa93-cdb4-8cf047093740@iogearbox.net>
 <20190410174444.26ebmnwpsiw6eicz@linutronix.de>
 <a3777ba4-467d-b24e-ec7c-91da09c10f10@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3777ba4-467d-b24e-ec7c-91da09c10f10@fb.com>
User-Agent: NeoMutt/20180716
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2019-04-10 18:35:21 [+0000], Yonghong Song wrote:
> > Ah. I checked one or two of those and it looked like it was raw since
> > the beginning. Anyway, it would be nice to Cc: the RT developer while
> > fiddling with something that only concerns RT.
> > 
> > That usage pattern that is mentioned in ac00881f9221, is it true for all
> > data structure algorithms? In bpf_lru_list I was concerned about the
> > list loops. 
> For some skewed hash tables with a lot of elements, yes, it is possible
> time to traverse the loop could be a little bit longer...

okay. So all that adds to your max latency which we try to keep low. If
this is debugging only one could argue that it is okay. However if it is
intended to be used in production then we usually try to keep as low as
possible (i.e. have an upper limit).

> > However hashtab and lpm_trie may perform memory allocations
> > while holding the lock and this isn't going to work.
> 
> The memory allocation in these two places uses GFP_ATOMIC which should 
> not sleep/block.

That is not true for -RT usage. GFP_ATOMIC enables the usage of
emergency memory pools (which are in general precious) and won't
schedule() in order to free memory. This doesn't change on -RT.
However, SLUB may call into the page allocator in order to get a fresh
page and this is not working on -RT. This means you can't allocate
memory from a preempt_disable() / local_irq_disable() section which
includes your raw_spin_lock(). It works from spin_lock_irq() because
that one is a sleeping lock on -RT.

Sebastian
