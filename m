Return-Path: <SRS0=/UrC=ZD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCE6C43331
	for <bpf@archiver.kernel.org>; Mon, 11 Nov 2019 16:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205D0222C2
	for <bpf@archiver.kernel.org>; Mon, 11 Nov 2019 16:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfKKQKx (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Nov 2019 11:10:53 -0500
Received: from ms.lwn.net ([45.79.88.28]:34572 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbfKKQKx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Nov 2019 11:10:53 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 710522C0;
        Mon, 11 Nov 2019 16:10:52 +0000 (UTC)
Date:   Mon, 11 Nov 2019 09:10:50 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     David Miller <davem@davemloft.net>, alexei.starovoitov@gmail.com,
        ast@kernel.org, daniel@iogearbox.net, x86@kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org, Kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 02/18] bpf: Add bpf_arch_text_poke() helper
Message-ID: <20191111091050.3ece5112@lwn.net>
In-Reply-To: <20191111081403.GM4131@hirez.programming.kicks-ass.net>
References: <59d3af80-a781-9765-4d01-4c8006cd574f@fb.com>
        <CAADnVQKmrVGVHM70OT0jc7reRp1LdWTM8dhE1Gde21oxw++jwg@mail.gmail.com>
        <20191108213624.GM3079@worktop.programming.kicks-ass.net>
        <20191108.133924.1397692397131607421.davem@davemloft.net>
        <20191111081403.GM4131@hirez.programming.kicks-ass.net>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 11 Nov 2019 09:14:03 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Nov 08, 2019 at 01:39:24PM -0800, David Miller wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Fri, 8 Nov 2019 22:36:24 +0100
> >   
> > > The cover leter is not preserved and should therefore  
> >  ...
> > 
> > The cover letter is +ALWAYS+ preserved, we put them in the merge
> > commit.  
> 
> Good to know; is this a netdev special? I've not seen this before.

I read a *lot* of merge commit changelogs; it's not just netdev that does
this.  I try to do it with significant documentation sets as well.  I
agree that changelogs should contain all relevant information, but there
is value in an overview as well.  But then, I make my living in the
overview business...:)

jon
