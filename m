Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACDDC77B6E
	for <bpf@archiver.kernel.org>; Sun,  9 Apr 2023 17:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjDIRZu (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 9 Apr 2023 13:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjDIRZt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Apr 2023 13:25:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B2330CF;
        Sun,  9 Apr 2023 10:25:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1E8260C1A;
        Sun,  9 Apr 2023 17:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09226C433EF;
        Sun,  9 Apr 2023 17:25:45 +0000 (UTC)
Date:   Sun, 9 Apr 2023 13:25:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     mhiramat@kernel.org, alexei.starovoitov@gmail.com,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] tracing: Refuse fprobe if RCU is not watching
Message-ID: <20230409132544.023d9ec5@rorschach.local.home>
In-Reply-To: <CALOAHbBALsJrkO-tPKoEtrdm42fLnRoYs-46tz0J7yDwrxC0Tg@mail.gmail.com>
References: <20230321020103.13494-1-laoar.shao@gmail.com>
        <20230321101711.625d0ccb@gandalf.local.home>
        <CALOAHbAfQxAMQTwDHnMOLHDfz=Mo0gFwu9i3bS0emttUTodA4g@mail.gmail.com>
        <20230323083914.31f76c2b@gandalf.local.home>
        <CALOAHbDtM7KuiRn1n9EBYrSGqJmOYcY6voVRfF+QGN510W_OtQ@mail.gmail.com>
        <20230323230105.57c40232@rorschach.local.home>
        <CALOAHbCZSY2XJpzJ+AxSrRLbMqyoJjcaXeof-xMLN8y+uB7PJg@mail.gmail.com>
        <20230409075515.2504db78@rorschach.local.home>
        <CALOAHbBALsJrkO-tPKoEtrdm42fLnRoYs-46tz0J7yDwrxC0Tg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 9 Apr 2023 20:45:39 +0800
Yafang Shao <laoar.shao@gmail.com> wrote:
> 
> I didn't notice preempt_{disable,enable}_notrace before :(
> Seems that is a better solution. I have verified that it really works.

Great.

> 
> BTW, why can we attach fentry to preempt_count_sub(), but can't attach
> it to migrate_disable() ?
> migrate_disable() isn't hidden from ftrace either...

You can't?

 # trace-cmd -p function -l migrate_disable
 # trace-cmd show
          <idle>-0       [000] ..s2. 153664.937829: migrate_disable <-bpf_prog_run_clear_cb
          <idle>-0       [000] ..s2. 153664.937834: migrate_disable <-bpf_prog_run_clear_cb
          <idle>-0       [000] ..s2. 153664.937835: migrate_disable <-bpf_prog_run_clear_cb
          <idle>-0       [000] ..s2. 153665.769555: migrate_disable <-bpf_prog_run_clear_cb
          <idle>-0       [000] ..s2. 153665.772109: migrate_disable <-bpf_prog_run_clear_cb

I think bpf prevents it. Perhaps that's another solution:

See 35e3815fa8102 ("bpf: Add deny list of btf ids check for tracing programs")

-- Steve
