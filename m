Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D7EC433EF
	for <bpf@archiver.kernel.org>; Wed, 23 Mar 2022 12:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242437AbiCWMhK (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 23 Mar 2022 08:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCWMhI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Mar 2022 08:37:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13E97B54C;
        Wed, 23 Mar 2022 05:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CrfM5P6uQxUgoVxVGucVUuZlS+SIBC3DY3b2Hzvq/N8=; b=eHGDgEWUrAEh/h/uGdBgZzUPRH
        E2Kp9T0tjRBRrthBXloHB4LoTJ4Hhrn5vH0yzofryiU8eKW/Dm6KuR27nZzFwDZKj4dig/51VpznY
        vO8RV9JJcYNqHT1LVNH5nyQGRsDwISqbumMrmVyGDaw0zM4fON//yeo64Bn36bDZpaz4jOGAFRDxQ
        IPA6fSwHrRBKvynnM61kDPAA8m8ILcHFB7CAHPEEfIIIYWkED/Q5rlWyJ7lcib78lECZ/K968pJj2
        UPbW4wRS/uIvAYCbMJOmkXvpxTiwfE9EuCWneWbA4gmIowWqU39R7N9nyqNNOJov1rAhK+ocIUKt3
        9pfaUkgA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nX0CW-003lG5-Dy; Wed, 23 Mar 2022 12:34:56 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 318A99861FD; Wed, 23 Mar 2022 13:34:54 +0100 (CET)
Date:   Wed, 23 Mar 2022 13:34:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH v13 bpf-next 1/1] rethook: x86: Add rethook x86
 implementation
Message-ID: <20220323123454.GW8939@worktop.programming.kicks-ass.net>
References: <164800288611.1716332.7053663723617614668.stgit@devnote2>
 <164800289923.1716332.9772144337267953560.stgit@devnote2>
 <YjrUxmABaohh1I8W@hirez.programming.kicks-ass.net>
 <20220323204119.1feac1af0a1d58b8e63acd5d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323204119.1feac1af0a1d58b8e63acd5d@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 23, 2022 at 08:41:19PM +0900, Masami Hiramatsu wrote:

> > Also, what's rethook for anyway?
> 
> Rethook is a feature which hooks the function return. Most of the
> logic came from the kretprobe. Simply to say, 'kretprobe - kprobe' is 
> the rethook :)

I got that far, but why did you take the bother to do these patches? Why
wasn't 'use kretprobe' a good enough option?
