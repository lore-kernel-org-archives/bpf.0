Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AB0C77B7E
	for <bpf@archiver.kernel.org>; Thu, 27 Apr 2023 15:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243484AbjD0Pqt (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 27 Apr 2023 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjD0Pqs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 11:46:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B312A2D72;
        Thu, 27 Apr 2023 08:46:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 510CF63E0B;
        Thu, 27 Apr 2023 15:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0265C433EF;
        Thu, 27 Apr 2023 15:46:44 +0000 (UTC)
Date:   Thu, 27 Apr 2023 11:46:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        bpf <bpf@vger.kernel.org>, linux-trace-kernel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 5/6] bpf: Improve tracing recursion prevention
 mechanism
Message-ID: <20230427114643.1e3e52aa@gandalf.local.home>
In-Reply-To: <CALOAHbCvZP1-x7Uc39zUFgLdxxvZUVPY9Eh6bL2vjDx_BZSyug@mail.gmail.com>
References: <20230417154737.12740-1-laoar.shao@gmail.com>
        <20230417154737.12740-6-laoar.shao@gmail.com>
        <20230427092628.21fd23e4@gandalf.local.home>
        <CALOAHbBX1C-eg93Hf3xPLsdsaBzoGn1pHh9jb3Z_-T-7HD60wA@mail.gmail.com>
        <20230427111842.2e40fe3c@gandalf.local.home>
        <CALOAHbDRSNvihv5n0jJpAsK3onezRRipO78RG3rAf3LGgkzYHg@mail.gmail.com>
        <20230427113602.0e49c0d1@gandalf.local.home>
        <CAADnVQLaBMtBoSY4ZMgeTU1T-rrU6vPSU+xg1HmQpWnnE84sNw@mail.gmail.com>
        <CALOAHbCvZP1-x7Uc39zUFgLdxxvZUVPY9Eh6bL2vjDx_BZSyug@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 27 Apr 2023 23:43:35 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:

> > > I thought that the whole point of this exercise was because the
> > > migrate_disable() itself could be traced (or call something that can), and
> > > that's outside of prog->active protection. Which the test_recursion_*()
> > > code was created for.  
> >
> > Not sure where did this come from.
> > migrate_enable/disable were added to deny list back in 2021.  
> 
> Hi Alexei,
> 
> Don't be uneasy.  It is not good to play word games.
> What Steven really meant is the preempt_count_{sub, add}.
> Anyway thanks Steven for the help with this exercise.

Right, it was the "(or call something that can)" part that this came from.
As Yafang said, migrate_disable() calls preempt_count_add() (on some
configs) which is traced by ftrace, and thus traced by bpf. Or was that
added to the deny list? I think that was one of the solutions as well.

-- Steve
