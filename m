Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5984C433FE
	for <bpf@archiver.kernel.org>; Thu, 28 Apr 2022 14:02:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347932AbiD1OFj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Apr 2022 10:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348198AbiD1ODx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 10:03:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A463EB82CB;
        Thu, 28 Apr 2022 06:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B0A5B82D76;
        Thu, 28 Apr 2022 13:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63345C385A0;
        Thu, 28 Apr 2022 13:59:52 +0000 (UTC)
Date:   Thu, 28 Apr 2022 09:59:51 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: Re: [RFC bpf-next 4/4] selftests/bpf: Add attach bench test
Message-ID: <20220428095951.46eea612@gandalf.local.home>
In-Reply-To: <20220428095803.66c17c32@gandalf.local.home>
References: <20220407125224.310255-1-jolsa@kernel.org>
        <20220407125224.310255-5-jolsa@kernel.org>
        <CAEf4BzbE1n3Lie+tWTzN69RQUWgjxePorxRr9J8CuiQVUfy-kA@mail.gmail.com>
        <20220412094923.0abe90955e5db486b7bca279@kernel.org>
        <CAEf4BzaQRcZGMqq5wqHo3wSHZAAVvY6AhizDk_dV_GtnwHuxLQ@mail.gmail.com>
        <20220416232103.c0b241c2ec7f2b3b985a2f99@kernel.org>
        <20220428095803.66c17c32@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 28 Apr 2022 09:58:03 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I added the addresses it was mapping and found this:
> 
> ffffffffa828f680 T __bpf_tramp_exit

cut and pasted the kallsyms not the avaliable filter functions, which had
this:

  __bpf_tramp_exit (ffffffffa828f780)

-- Steve
