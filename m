Return-Path: <SRS0=9Oao=SO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB44C10F0E
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 16:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D815B20850
	for <bpf@archiver.kernel.org>; Fri, 12 Apr 2019 16:23:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfDLQXb (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:23:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37861 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfDLQXb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 12 Apr 2019 12:23:31 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hEyxb-0007ok-Sm; Fri, 12 Apr 2019 18:23:28 +0200
Date:   Fri, 12 Apr 2019 18:23:27 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/3] bpf: Use spinlock_t in lpm_trie
Message-ID: <20190412162327.k37f3vura272yggr@linutronix.de>
References: <20190410143025.11997-1-bigeasy@linutronix.de>
 <20190410143025.11997-3-bigeasy@linutronix.de>
 <CAPhsuW6qUk1LX5OjFXE-U2gVJnbhnrxik=1p0kYAqyD1xkXHow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPhsuW6qUk1LX5OjFXE-U2gVJnbhnrxik=1p0kYAqyD1xkXHow@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2019-04-11 13:36:38 [-0700], Song Liu wrote:
> Hi,
Hi,

> On Wed, Apr 10, 2019 at 7:31 AM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > There is no difference between spinlock_t and raw_spinlock_t for !RT
> > kernels. trie_update_elem() will allocate memory while holding ->lock
> > which is not possible on RT kernels.
> 
> I am new to RT kernel. For !RT kernel, it is OK to hold a lock and call
> malloc with GFP_ATOMIC. Is this different for RT kernel?

Yes, please see
	https://lore.kernel.org/bpf/20190412153819.6sh2b2cwddpgnepq@linutronix.de/

> Thanks,
> Song

Sebastian
