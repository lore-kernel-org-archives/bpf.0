Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84207C2B9F4
	for <bpf@archiver.kernel.org>; Thu, 17 Jun 2021 23:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5737B613B9
	for <bpf@archiver.kernel.org>; Thu, 17 Jun 2021 23:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhFRAAY (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:00:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:56514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229848AbhFRAAY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Jun 2021 20:00:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A98C361019;
        Thu, 17 Jun 2021 23:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623974295;
        bh=M0lRaJht8iOxf3cY0Le5dA8WTI73qlYLqx7cmUga8cA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uR+jaHbIFOiP1N1bZF91AcJpKpoCLDh5MS+QwS/B6V7VL35kk1fLu0yhGmOKnsWdy
         A1RQixbBMPj2iJ4h73eZxwlBAKoD4WsU02kq8ukkU8Xm4SrCXTnoEXbiZF1j0U+jmP
         eOEvxHg6q/FC2i4rfbDFvIdvio5KoG+GmfPiW5Zlur4sPjclnPN/0enES53byckVPu
         hoshuo/aK5nClbdKYjTRISgQtPSLtGaWrKtj22p6fL0DnskhbQd2xvYQDErkLQ+1u2
         V7ztTkspcRI1irecm9DgT+IdU7NlUdAdgjfZIqQtALLm7DQuQJDjtilHTTBCcib8mS
         3WiLp4wBEWf6g==
Date:   Fri, 18 Jun 2021 08:58:11 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>,
        open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>
Subject: Re: [PATCH -tip v7 09/13] kprobes: Setup instruction pointer in
 __kretprobe_trampoline_handler
Message-Id: <20210618085811.19f0a7b8c1e91d54483ba9f8@kernel.org>
In-Reply-To: <20210617182159.ka227nkmhe4yu2de@treble>
References: <162209754288.436794.3904335049560916855.stgit@devnote2>
        <162209762943.436794.874947392889792501.stgit@devnote2>
        <20210617043909.fgu2lhnkxflmy5mk@treble>
        <20210617044032.txng4enhiduacvt6@treble>
        <20210617234001.54cd2ff60410ff82a39a2020@kernel.org>
        <20210618000239.f95de17418beae6d84ce783d@kernel.org>
        <CAEf4Bzbob_M0aS-GUY5XaqePZr_prxUag3RLHtp=HY8Uu__10g@mail.gmail.com>
        <20210617182159.ka227nkmhe4yu2de@treble>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 17 Jun 2021 13:21:59 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Thu, Jun 17, 2021 at 10:45:41AM -0700, Andrii Nakryiko wrote:
> > > > > > I know I suggested this patch, but I believe it would only be useful in
> > > > > > combination with the use of UNWIND_HINT_REGS in SAVE_REGS_STRING.  But I
> > > > > > think that would be tricky to pull off correctly.  Instead, we have
> > > > > > UNWIND_HINT_FUNC, which is working fine.
> > > > > >
> > > > > > So I'd suggest dropping this patch, as the unwinder isn't actually
> > > > > > reading regs->ip after all.
> > > > >
> > > > > ... and I guess this means patches 6-8 are no longer necessary.
> > > >
> > > > OK, I also confirmed that dropping those patche does not make any change
> > > > on the stacktrace.
> > > > Let me update the series without those.
> > >
> > > Oops, Andrii, can you also test the kernel without this patch?
> > > (you don't need to drop patch 6-8)
> > 
> > Hi Masami,
> > 
> > Dropping this patch and leaving all the other in place breaks stack
> > traces from kretprobes for BPF. I double checked with and without this
> > patch. Without this patch we are back to having broken stack traces. I
> > see either
> > 
> >   kretprobe_trampoline+0x0
> > 
> > or
> > 
> >   ftrace_trampoline+0xc8
> >   kretprobe_trampoline+0x0

Thanks for confirmation.

> > 
> > Is there any problem if you leave this patch as is?
> 
> Hm, I must be missing something then.  The patch is probably fine to
> keep, we just may need to improve the commit log so that it makes sense
> to me.

Yeah, I need to update the commit message so that this will help
the stacktrace from kretprobe's pt_regs, which will be used in bpf. 

Thank you!

> 
> Which unwinder are you using (CONFIG_UNWINDER_*)?
> 
> -- 
> Josh
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
