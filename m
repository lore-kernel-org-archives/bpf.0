Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 826B2C433FE
	for <bpf@archiver.kernel.org>; Fri,  7 Oct 2022 19:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJGTfc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 7 Oct 2022 15:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiJGTf3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 15:35:29 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F0C6B8CF
        for <bpf@vger.kernel.org>; Fri,  7 Oct 2022 12:35:16 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ogt7q-0008Sc-Q0; Fri, 07 Oct 2022 21:35:14 +0200
Date:   Fri, 7 Oct 2022 21:35:14 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, bpf <bpf@vger.kernel.org>
Subject: Re: [RFC v2 6/9] netfilter: add bpf base hook program generator
Message-ID: <20221007193514.GA22318@breakpoint.cc>
References: <20221005141309.31758-1-fw@strlen.de>
 <20221005141309.31758-7-fw@strlen.de>
 <20221006025209.rx4xnwdduqypja4b@macbook-pro-4.dhcp.thefacebook.com>
 <20221007114543.GA4296@breakpoint.cc>
 <CAADnVQLSwX4gCK62KT_qEuPwagn4B9SMOBrLBcLh+2PFxypxqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLSwX4gCK62KT_qEuPwagn4B9SMOBrLBcLh+2PFxypxqw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > -       if (!emit(p, BPF_EMIT_CALL(nf_hook_slow)))
> > +       if (!emit(p, BPF_EMIT_CALL(nf_hook_slow_bpf)))
> >
> > ?
> >
> > If yes, I don't see how this will work for the case where I only have an
> > address, i.e.:
> >
> > if (!emit(p, BPF_EMIT_CALL(h->hook))) ....
> >
> > (Also, the address might be in a kernel module)
> >
> > > On x86-64 it will be a nop.
> > > On x86-32 it will do quite a bit of work.
> >
> > If this only a problem for 32bit arches, I could also make this
> > 'depends on CONFIG_64BIT'.
> 
> If that's acceptable, sure.

Good, thanks!

> > But perhaps I am on the wrong track, I see existing code doing:
> >         *insn++ = BPF_EMIT_CALL(__htab_map_lookup_elem);
> 
> Yes, because we do:
>                 /* BPF_EMIT_CALL() assumptions in some of the map_gen_lookup
>                  * and other inlining handlers are currently limited to 64 bit
>                  * only.
>                  */
>                 if (prog->jit_requested && BITS_PER_LONG == 64 &&

Ah, thanks, makes sense.

> I think you already gate this feature with jit_requested?
> Otherwise it's going to be slow in the interpreter.

Right, use of bpf interpreter is silly for this.

> > 39: unspec  tag 0000000000000000
> > xlated 416B  jited 221B  memlock 4096B
> 
> Probably should do bpf_prog_calc_tag() too.
> And please give it some meaningful name.

Agree, will add this.
