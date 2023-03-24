Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E6EC74A5B
	for <bpf@archiver.kernel.org>; Fri, 24 Mar 2023 03:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCXDB1 convert rfc822-to-8bit (ORCPT
        <rfc822;bpf@archiver.kernel.org>); Thu, 23 Mar 2023 23:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjCXDB0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Mar 2023 23:01:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F721B30B;
        Thu, 23 Mar 2023 20:01:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 119F4627BC;
        Fri, 24 Mar 2023 03:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A5DC433EF;
        Fri, 24 Mar 2023 03:01:20 +0000 (UTC)
Date:   Thu, 23 Mar 2023 23:01:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
Message-ID: <20230323230105.57c40232@rorschach.local.home>
In-Reply-To: <CALOAHbDtM7KuiRn1n9EBYrSGqJmOYcY6voVRfF+QGN510W_OtQ@mail.gmail.com>
References: <20230321020103.13494-1-laoar.shao@gmail.com>
        <20230321101711.625d0ccb@gandalf.local.home>
        <CALOAHbAfQxAMQTwDHnMOLHDfz=Mo0gFwu9i3bS0emttUTodA4g@mail.gmail.com>
        <20230323083914.31f76c2b@gandalf.local.home>
        <CALOAHbDtM7KuiRn1n9EBYrSGqJmOYcY6voVRfF+QGN510W_OtQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 24 Mar 2023 10:51:49 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> On Thu, Mar 23, 2023 at 8:39 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Thu, 23 Mar 2023 13:59:34 +0800
> > Yafang Shao <laoar.shao@gmail.com> wrote:
> >  
> > > I have verified the latest linux-trace tree,
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> > > trace/core
> > >
> > > The result of "uname -r" is ''6.3.0-rc3+".
> > > This issue still exists, and after applying this patch it disappears.
> > > It can be reproduced with a simple bpf program as follows,
> > >     SEC("kprobe.multi/preempt_count_sub")
> > >     int fprobe_test()
> > >     {
> > >         return 0;
> > >     }  
> >
> > Still your patch is hiding a bug, not fixing one.
> >
> > Can you apply this patch and see if the bug goes away?
> >  
> 
> I have verified that the bug goes away after applying this patch.
> Thanks for the fix.
> 

It's in tip:

  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=x86/urgent&id=f87d28673b71b35b248231a2086f9404afbb7f28

Hopefully it will make it to mainline soon.

-- Steve
