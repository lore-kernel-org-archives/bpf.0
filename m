Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A43C47082
	for <bpf@archiver.kernel.org>; Tue,  8 Jun 2021 19:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9494A6108E
	for <bpf@archiver.kernel.org>; Tue,  8 Jun 2021 19:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbhFHTWc (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 8 Jun 2021 15:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238818AbhFHTUJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Jun 2021 15:20:09 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A97906100A;
        Tue,  8 Jun 2021 19:11:46 +0000 (UTC)
Date:   Tue, 8 Jun 2021 15:11:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH 03/19] x86/ftrace: Make function graph use ftrace
 directly
Message-ID: <20210608151144.6f4531c1@oasis.local.home>
In-Reply-To: <YL+8LRsVndGdgOMF@krava>
References: <20210605111034.1810858-1-jolsa@kernel.org>
        <20210605111034.1810858-4-jolsa@kernel.org>
        <CAEf4BzY5ngJz_=e2wnqG7yB996xdQAPCBfz3_4mB9P2N-1RoCw@mail.gmail.com>
        <YL+8LRsVndGdgOMF@krava>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 8 Jun 2021 20:51:25 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> > > +                                  FTRACE_OPS_FL_PID
> > > +                                  FTRACE_OPS_GRAPH_STUB,  
> > 
> > nit: this looks so weird... Why not define FTRACE_OPS_GRAPH_STUB as
> > zero in case of #ifdef ftrace_graph_func? Then it will be natural and
> > correctly looking | FTRACE_OPS_GRAPH_STUB?  

I have no idea why I did that :-/  But it was a while ago when I wrote
this code. I think there was a reason for it, but with various updates,
that reason disappeared.


> 
> ok, I can change that

Yes, please do.

Thanks,

-- Steve
