Return-Path: <SRS0=J20p=SM=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A5CC10F11
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 17:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7D02082E
	for <bpf@archiver.kernel.org>; Wed, 10 Apr 2019 17:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfDJRos (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 10 Apr 2019 13:44:48 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:60434 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbfDJRos (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Apr 2019 13:44:48 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hEHHA-0007jv-Dp; Wed, 10 Apr 2019 19:44:44 +0200
Date:   Wed, 10 Apr 2019 19:44:44 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Yonghong Song <yhs@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/3] bpf: Use spinlock_t in bpf_lru_list
Message-ID: <20190410174444.26ebmnwpsiw6eicz@linutronix.de>
References: <20190410143025.11997-1-bigeasy@linutronix.de>
 <813645e9-6a09-4aa4-0e2e-9b68359b83db@fb.com>
 <4150a0db-18f9-aa93-cdb4-8cf047093740@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4150a0db-18f9-aa93-cdb4-8cf047093740@iogearbox.net>
User-Agent: NeoMutt/20180716
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2019-04-10 19:19:27 [+0200], Daniel Borkmann wrote:
> On 04/10/2019 07:08 PM, Yonghong Song wrote:
> > On 4/10/19 7:30 AM, Sebastian Andrzej Siewior wrote:
> >> There is no difference between spinlock_t and raw_spinlock_t for !RT
> >> kernels. It is possible that bpf_lru_list_pop_free_to_local() invokes
> >> at least three list walks which look unbounded it probably makes sense
> >> to use spinlock_t.
> >>
> >> Make bpf_lru_list use a spinlock_t.
> > 
> > Could you add a cover letter for the patch set since you have
> > more than one patch?

yes.

> >> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >> ---
> >>   kernel/bpf/bpf_lru_list.c | 38 +++++++++++++++++++-------------------
> >>   kernel/bpf/bpf_lru_list.h |  4 ++--
> >>   2 files changed, 21 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/kernel/bpf/bpf_lru_list.c b/kernel/bpf/bpf_lru_list.c
> >> index e6ef4401a1380..40f47210c3817 100644
> >> --- a/kernel/bpf/bpf_lru_list.c
> >> +++ b/kernel/bpf/bpf_lru_list.c
> >> @@ -313,9 +313,9 @@ static void bpf_lru_list_push_free(struct bpf_lru_list *l,
> >>   	if (WARN_ON_ONCE(IS_LOCAL_LIST_TYPE(node->type)))
> >>   		return;
> >>   
> >> -	raw_spin_lock_irqsave(&l->lock, flags);
> >> +	spin_lock_irqsave(&l->lock, flags);
> >>   	__bpf_lru_node_move(l, node, BPF_LRU_LIST_T_FREE);
> >> -	raw_spin_unlock_irqrestore(&l->lock, flags);
> >> +	spin_unlock_irqrestore(&l->lock, flags);
> >>   }
> > 
> > This function (plus many others) is called by bpf program helpers which 
> > cannot sleep. Is it possible that under RT spin_lock_irqsave() could 
> > sleep and this will make bpf subsystem cannot be used under RT?
> 
> Back then in ac00881f9221 ("bpf: convert hashtab lock to raw lock")
> Yang Shi converted spinlock_t to raw_spinlock_t due to exactly the
> above mentioned issue. I presume that hasn't changed, right?

Ah. I checked one or two of those and it looked like it was raw since
the beginning. Anyway, it would be nice to Cc: the RT developer while
fiddling with something that only concerns RT.

That usage pattern that is mentioned in ac00881f9221, is it true for all
data structure algorithms? In bpf_lru_list I was concerned about the
list loops. However hashtab and lpm_trie may perform memory allocations
while holding the lock and this isn't going to work.

Sebastian
