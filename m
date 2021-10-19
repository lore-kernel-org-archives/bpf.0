Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74876C433EF
	for <bpf@archiver.kernel.org>; Tue, 19 Oct 2021 14:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A9061212
	for <bpf@archiver.kernel.org>; Tue, 19 Oct 2021 14:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhJSOq3 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Tue, 19 Oct 2021 10:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231441AbhJSOq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Oct 2021 10:46:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E226115A;
        Tue, 19 Oct 2021 14:44:15 +0000 (UTC)
Date:   Tue, 19 Oct 2021 10:44:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH 7/8] ftrace: Add multi direct modify interface
Message-ID: <20211019104411.18322063@gandalf.local.home>
In-Reply-To: <YW7QFzXrJwoFHkct@krava>
References: <20211008091336.33616-1-jolsa@kernel.org>
        <20211008091336.33616-8-jolsa@kernel.org>
        <20211014162819.5c85618b@gandalf.local.home>
        <YWluhdDMfkNGwlhz@krava>
        <20211015100509.78d4fb01@gandalf.local.home>
        <YWq6C69rQhUcAGe+@krava>
        <20211018221015.3f145843@gandalf.local.home>
        <YW7F8kTc3Bl8AkVx@krava>
        <YW7HfV9+UiuYxt7N@krava>
        <20211019093216.058ec98b@gandalf.local.home>
        <YW7QFzXrJwoFHkct@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 19 Oct 2021 16:03:03 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> > You can make sure the patches in there have your latest version, as you can
> > review my patch. I'll update the tags if you give me one.  
> 
> I'm getting error when compiling:
> 
>   CC      kernel/trace/ftrace.o
> kernel/trace/ftrace.c: In function ‘modify_ftrace_direct_multi’:
> kernel/trace/ftrace.c:5608:2: error: label ‘out_unlock’ defined but not used [-Werror=unused-label]

Ah, I don't think I've been hit by the "-Werror" yet ;-)


>  5608 |  out_unlock:
>       |  ^~~~~~~~~~
> 
> looks like out_unlock is nolonger needed, I removed it

My tests would have found this, as it has a check for "new warnings".

Anyway, was this in your latest patch, or did I pull in and older one?

That is, should I expect a v2 from you?

-- Steve
