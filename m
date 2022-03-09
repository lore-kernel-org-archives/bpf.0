Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE24DC433EF
	for <bpf@archiver.kernel.org>; Wed,  9 Mar 2022 20:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbiCIUtL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiCIUtK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 15:49:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053BD12603;
        Wed,  9 Mar 2022 12:48:11 -0800 (PST)
Date:   Wed, 9 Mar 2022 21:48:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646858889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzNRykEAI9kBHyCf1JrgJutl0+QaBQcxJyyweN9kOOY=;
        b=fiBpZbI/oUHqAdFkqxCxklEP39q+EDJ/mls+rHEQ80Zg4Kt4gNkO3Un2F9FJhJ5KKx6U0E
        O3qSGAXk/NUf1LnIaQqsXram7O5SxbzisZ1ZTl1FUG6TuWzeTclqTT+oUph2+GTKNmCGl5
        JC9nvrh0P5ZO4gMycnooCbk+t/iYU5ZYlyLMXFjLB+Y9vuSOoGKGvb44icHDoslBCsx2p/
        S+XBtOvzUnQOEzCkNkgDZJhkGP0dw+3EOrBq6TuLif2i8QY8JUHfU6RpKutoGaC2DGfW60
        C8aVASpfrnkVNk6Tiafvlt490jVksmC2eCLyFB7v2FHE/fSRS4Wi9Q6HfStbqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646858889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lzNRykEAI9kBHyCf1JrgJutl0+QaBQcxJyyweN9kOOY=;
        b=PpvGjRwv6cAQRq5ZodyenuJymYKeqOrznysoFoQz5h0UlNiSZgpoRDFTYmZX0A5Qc23aq7
        RRWDBLrh/i4HIwCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH net] xdp: xdp_mem_allocator can be NULL in
 trace_mem_connect().
Message-ID: <YikSiGjkOtM7zMkM@linutronix.de>
References: <YiC0BwndXiwxGDNz@linutronix.de>
 <875yovdtm4.fsf@toke.dk>
 <YiDM0WRlWuM2jjNJ@linutronix.de>
 <87y21l7lmr.fsf@toke.dk>
 <YiZIEVTRMQVYe8DP@linutronix.de>
 <87sfrt7i1i.fsf@toke.dk>
 <20220309091508.4e48511f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220309091508.4e48511f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2022-03-09 09:15:08 [-0800], Jakub Kicinski wrote:
> Was the patch posted? This seems to be a 5.17 thing, so it'd be really
> really good if the fix was in net by tomorrow morning! :S

Just posted v2.

Sebastian
