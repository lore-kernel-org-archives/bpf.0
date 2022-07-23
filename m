Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFDCC43334
	for <bpf@archiver.kernel.org>; Sat, 23 Jul 2022 03:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiGWD42 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Jul 2022 23:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGWD41 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 23:56:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208C274DDA
        for <bpf@vger.kernel.org>; Fri, 22 Jul 2022 20:56:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C91B4B82BC3
        for <bpf@vger.kernel.org>; Sat, 23 Jul 2022 03:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79574C341C0;
        Sat, 23 Jul 2022 03:56:21 +0000 (UTC)
Date:   Fri, 22 Jul 2022 23:56:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [RFC] ftrace: Add support to keep some functions out of ftrace
Message-ID: <20220722235619.4bd4a0e1@rorschach.local.home>
In-Reply-To: <20220722235358.0eaa62d0@rorschach.local.home>
References: <20220722110811.124515-1-jolsa@kernel.org>
        <20220722072608.17ef543f@rorschach.local.home>
        <CAADnVQ+hLnyztCi9aqpptjQk-P+ByAkyj2pjbdD45dsXwpZ0bw@mail.gmail.com>
        <20220722120854.3cc6ec4b@gandalf.local.home>
        <20220722122548.2db543ca@gandalf.local.home>
        <YtsRD1Po3qJy3w3t@krava>
        <20220722174120.688768a3@gandalf.local.home>
        <20220722235358.0eaa62d0@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 22 Jul 2022 23:53:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> If you are interested in more details about the birth of fentry, here's
> the email that started it all:
> 
>  https://lore.kernel.org/lkml/1258657614.22249.824.camel@gandalf.stny.rr.com/

And I was the one to suggest the "fentry" name as well.

 https://lore.kernel.org/lkml/1258720459.22249.1018.camel@gandalf.stny.rr.com/

-- Steve
