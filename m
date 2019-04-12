Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C1DC10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 16:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF83520652
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 16:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfDLQOL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:14:11 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37804 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfDLQOL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 12:14:11 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hEyoZ-0007cE-2r; Fri, 12 Apr 2019 18:14:07 +0200
Date:   Fri, 12 Apr 2019 18:14:07 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Yonghong Song <yhs@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] bpf: Use spinlock_t in bpf_lru_list
Message-ID: <20190412161406.ok3b4ooyeab6i3wz@linutronix.de>
References: <20190410143025.11997-1-bigeasy@linutronix.de>
 <813645e9-6a09-4aa4-0e2e-9b68359b83db@fb.com>
 <4150a0db-18f9-aa93-cdb4-8cf047093740@iogearbox.net>
 <20190410174444.26ebmnwpsiw6eicz@linutronix.de>
 <7ce75f79-839f-1aea-8a62-c432e4dba518@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7ce75f79-839f-1aea-8a62-c432e4dba518@iogearbox.net>
User-Agent: NeoMutt/20180716
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2019-04-10 21:44:22 [+0200], Daniel Borkmann wrote:
> > Ah. I checked one or two of those and it looked like it was raw since
> > the beginning. Anyway, it would be nice to Cc: the RT developer while
> 
> The later ones like form LRU may have just been adapted to use the
> same after the conversion from ac00881f9221, but I presume there might
> unfortunately be little to no testing on RT kernels currently. Hopefully
> we'll get there such that at min bots would yell if something is off
> so it can be fixed.

Thanks. The boot part what made me look at lpm_trie.

> > fiddling with something that only concerns RT.
> 
> I think that was the case back then, see discussion / Cc list:
> 
> https://lore.kernel.org/netdev/1446243386-26582-1-git-send-email-yang.shi@linaro.org/T/

So there was a discussion and I somehow missed it. Fair enough.

This memory allocation under the lock. Is that new or was it not seen
back then?

> > That usage pattern that is mentioned in ac00881f9221, is it true for all
> > data structure algorithms? In bpf_lru_list I was concerned about the
> > list loops. However hashtab and lpm_trie may perform memory allocations
> > while holding the lock and this isn't going to work.
> 
> Do you have some document or guide for such typical patterns and how to
> make them behave better for RT?

Let me put something simple together and once I have the pieces in
lockdep I hope that there will be also a document explaining things in
more detail.
For now: try to keep you preemptible.
- spin_lock() -> raw_spin_lock() is correct but
  raw_spin_lock() -> spin_lock() is not correct.

- interrupts handlers run threaded (as with "threadirqs" command line).
  Most code therefore never really disables interrupts. This includes
  spin_lock_irq().
  Therefore local_irq_disable() + spin_lock() != spin_lock_irq()

- preempt_disable(), local_irq_disable(), raw_spin_lock() enables atomic
  context on -RT which makes scheduling impossible.

- in atomic context

  - memory allocations are not possible (including GFP_ATOMIC).

  - a spin_lock() can not be acquired nor released.

  - unbounded loops add to task's max latency which should be avoided.

- architecture's core runs with disabled interrupts and it is attempted
  to keep this part short. This includes even hrtimer callbacks which
  are not invoked with disabled interrupts.

- core code uses raw_spin_lock() if it needs to protect something. If
  you think you need such a lock try to measure the worst case with
  cyclictest and see how it behaves. If it is visible then a different
  design should probably be used by shrinking the atomic section in
  order to become more deterministic.

- debugging code often increases latency (lockdep even by few ms).
  Please document if this introduced unbounded atomic section is
  intended only for debugging.
 
> Thanks,
> Daniel

Sebastian
