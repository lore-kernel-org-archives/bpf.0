Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC15C43334
	for <bpf@archiver.kernel.org>; Fri, 17 Jun 2022 17:48:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383371AbiFQRsj (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 17 Jun 2022 13:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383268AbiFQRsW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jun 2022 13:48:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D2F37BDD;
        Fri, 17 Jun 2022 10:48:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6B6FB82B54;
        Fri, 17 Jun 2022 17:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 685F9C3411B;
        Fri, 17 Jun 2022 17:48:17 +0000 (UTC)
Date:   Fri, 17 Jun 2022 13:48:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tracing/kprobes: Check whether get_kretprobe() returns
 NULL in kretprobe_dispatcher()
Message-ID: <20220617134815.5e1a97de@gandalf.local.home>
In-Reply-To: <26a91f26-8d9c-e5e4-0a2f-4f17746c28b8@iogearbox.net>
References: <165366693881.797669.16926184644089588731.stgit@devnote2>
        <0204f480-cdb0-e49f-9034-602eced02966@iogearbox.net>
        <7619DB57-C39B-4A49-808C-7ACF12D58592@goodmis.org>
        <d28e1548-98fb-a533-4fdc-ae4f4568fb75@iogearbox.net>
        <20220608091017.0596dade@gandalf.local.home>
        <3d535ae1-69cd-dbae-32f6-7d571a88c2d8@iogearbox.net>
        <20220617120254.30bb0f15@gandalf.local.home>
        <26a91f26-8d9c-e5e4-0a2f-4f17746c28b8@iogearbox.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 17 Jun 2022 18:09:44 +0200
Daniel Borkmann <daniel@iogearbox.net> wrote:

> > Sorry, between traveling for conferences and PTO I fell behind. I'll pull
> > this into my urgent queue and start running my tests on it.  
> 
> Okay, if you pick these fixes up today then I'll toss them from our bpf patchwork.

This patch I'll take, but please keep the fprobe/rethook one, as that's
specific to your tree.

-- Steve
