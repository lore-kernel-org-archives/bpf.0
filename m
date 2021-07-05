Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F3DC07E99
	for <bpf@archiver.kernel.org>; Mon,  5 Jul 2021 11:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFD68613B7
	for <bpf@archiver.kernel.org>; Mon,  5 Jul 2021 11:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhGELkO (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 5 Jul 2021 07:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhGELkO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Jul 2021 07:40:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761D3C061574;
        Mon,  5 Jul 2021 04:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CtwriWiKNwEyPS7wLGosDrs1cNvFIMaj7va3rpRQQIg=; b=tmtzEHW3+X0tS77m9YJ9iqG4hq
        KZ6c5b4LQxTd/0FbCgReItHmXkmQXz+fVrK/XAThajPegKRWxD3+QLJE7XIuP054SYCBp5HRgsSrt
        Krevd8NbRA3zaGwAEgi82jX1FzhtGyoXk2aC1FvLF7lPN1uIiEqFdOoikHiKE3HHyX4iIdIPH48Iz
        XXOJIYcyJQIPz43O3BoIr1qmaNp6chmnlZGGCNNCSe/9vspoOMBEbME/WiysvjKHhpPhyJZIqQjKC
        I4E0mb+HraGyZUN8qj3mgIY97Q/y97pDFmYzdb5UZLgh6RnGaqzDrviBlUZrbB3dmfJ+HiuT5DfVO
        hoWLslYQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0Mtd-00ACWy-27; Mon, 05 Jul 2021 11:36:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2C3E3001DC;
        Mon,  5 Jul 2021 13:36:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5F23A200E1E64; Mon,  5 Jul 2021 13:36:14 +0200 (CEST)
Date:   Mon, 5 Jul 2021 13:36:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, X86 ML <x86@kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, kuba@kernel.org, mingo@redhat.com,
        ast@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, kernel-team@fb.com, yhs@fb.com,
        linux-ia64@vger.kernel.org,
        Abhishek Sagar <sagar.abhishek@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH -tip v8 11/13] x86/unwind: Recover kretprobe trampoline
 entry
Message-ID: <YOLurg5mGHdBc+fz@hirez.programming.kicks-ass.net>
References: <162399992186.506599.8457763707951687195.stgit@devnote2>
 <162400002631.506599.2413605639666466945.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162400002631.506599.2413605639666466945.stgit@devnote2>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 18, 2021 at 04:07:06PM +0900, Masami Hiramatsu wrote:
> @@ -549,7 +548,15 @@ bool unwind_next_frame(struct unwind_state *state)
>  					 (void *)orig_ip);
>  			goto err;
>  		}
> -
> +		/*
> +		 * There is a small chance to interrupt at the entry of
> +		 * kretprobe_trampoline where the ORC info doesn't exist.
> +		 * That point is right after the RET to kretprobe_trampoline
> +		 * which was modified return address. So the @addr_p must
> +		 * be right before the regs->sp.
> +		 */
> +		state->ip = unwind_recover_kretprobe(state, state->ip,
> +				(unsigned long *)(state->sp - sizeof(long)));
>  		state->regs = (struct pt_regs *)sp;
>  		state->prev_regs = NULL;
>  		state->full_regs = true;
> @@ -562,6 +569,9 @@ bool unwind_next_frame(struct unwind_state *state)
>  					 (void *)orig_ip);
>  			goto err;
>  		}
> +		/* See UNWIND_HINT_TYPE_REGS case comment. */
> +		state->ip = unwind_recover_kretprobe(state, state->ip,
> +				(unsigned long *)(state->sp - sizeof(long)));
>  
>  		if (state->full_regs)
>  			state->prev_regs = state->regs;

Why doesn't the ftrace case have this? That is, why aren't both return
trampolines having the same general shape?
