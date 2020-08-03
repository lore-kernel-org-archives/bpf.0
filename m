Return-Path: <SRS0=579k=BN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F022C433E0
	for <bpf@archiver.kernel.org>; Mon,  3 Aug 2020 19:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DDD322CA1
	for <bpf@archiver.kernel.org>; Mon,  3 Aug 2020 19:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgHCT67 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728296AbgHCT67 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Aug 2020 15:58:59 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70633207DF;
        Mon,  3 Aug 2020 19:58:55 +0000 (UTC)
Date:   Mon, 3 Aug 2020 15:58:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Muchun Song <songmuchun@bytedance.com>, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] kprobes: fix NULL pointer dereference at
 kprobe_ftrace_handler
Message-ID: <20200803155852.022ef199@oasis.local.home>
In-Reply-To: <20200803235042.6bacaf3eb53b7ab831f4edd3@kernel.org>
References: <20200728064536.24405-1-songmuchun@bytedance.com>
        <CAMZfGtUDmQgDySu7OSBNYv5y2_QJfzDcVeYG2eY6-1xYq+t1Uw@mail.gmail.com>
        <20200803235042.6bacaf3eb53b7ab831f4edd3@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 3 Aug 2020 23:50:42 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Nice catch!
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Fixes: ae6aa16fdc16 ("kprobes: introduce ftrace based optimization")
> Cc: stable@vger.kernel.org

Thanks Masami,

I'll add this to my queue for the merge window.

-- Steve
