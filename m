Return-Path: <SRS0=yg+S=4C=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9250C2BA83
	for <bpf@archiver.kernel.org>; Fri, 14 Feb 2020 18:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C34D20848
	for <bpf@archiver.kernel.org>; Fri, 14 Feb 2020 18:37:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbgBNShC (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:37:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55987 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387551AbgBNShC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 14 Feb 2020 13:37:02 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2fpO-0004c8-S7; Fri, 14 Feb 2020 19:36:39 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 57DD9101161; Fri, 14 Feb 2020 19:36:37 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        bigeasy@linutronix.de, peterz@infradead.org, williams@redhat.com,
        rostedt@goodmis.org, juri.lelli@redhat.com, mingo@kernel.org
Subject: Re: [RFC patch 00/19] bpf: Make BPF and PREEMPT_RT co-exist
In-Reply-To: <20200214.095303.341559462549043464.davem@davemloft.net>
Date:   Fri, 14 Feb 2020 19:36:37 +0100
Message-ID: <87pneht3re.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Miller <davem@davemloft.net> writes:

> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Fri, 14 Feb 2020 14:39:17 +0100
>
>> This is a follow up to the initial patch series which David posted a
>> while ago:
>> 
>>  https://lore.kernel.org/bpf/20191207.160357.828344895192682546.davem@davemloft.net/
>> 
>> which was (while non-functional on RT) a good starting point for further
>> investigations.
>
> This looks really good after a cursory review, thanks for doing this week.
>
> I was personally unaware of the pre-allocation rules for MAPs used by
> tracing et al.  And that definitely shapes how this should be handled.

Hmm. I just noticed that my analysis only holds for PERF events. But
that's broken on mainline already.

Assume the following simplified callchain:

       kmalloc() from regular non BPF context
         cache empty
           freelist empty
             lock(zone->lock);
                tracepoint or kprobe
                  BPF()
                    update_elem()
                      lock(bucket)
                        kmalloc()
                          cache empty
                            freelist empty
                              lock(zone->lock);  <- DEADLOCK

So really, preallocation _must_ be enforced for all variants of
intrusive instrumentation. There is no if and but, it's simply mandatory
as all intrusive instrumentation has to follow the only sensible
principle: KISS = Keep It Safe and Simple.

The above is a perfectly valid scenario and works with perf and tracing,
so it has to work with BPF in the same safe way.

I might be missing some magic enforcement of that, but I got lost in the
maze.

Thanks,

        tglx

