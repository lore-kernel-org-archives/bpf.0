Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11D3C433F5
	for <bpf@archiver.kernel.org>; Thu, 26 May 2022 19:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiEZT6o (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 26 May 2022 15:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbiEZT6o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 May 2022 15:58:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD8746667
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 12:58:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD05EB8219C
        for <bpf@vger.kernel.org>; Thu, 26 May 2022 19:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9157C385A9;
        Thu, 26 May 2022 19:58:39 +0000 (UTC)
Date:   Thu, 26 May 2022 15:58:38 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     masami Hiramatsu <mhiramat@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: help to debug a kretprobe_dispatcher issue with 5.12
Message-ID: <20220526155838.2cdef490@gandalf.local.home>
In-Reply-To: <a5e75f2e-37ad-10e5-ff32-86e5fb7d3f5d@fb.com>
References: <a5e75f2e-37ad-10e5-ff32-86e5fb7d3f5d@fb.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 26 May 2022 12:48:41 -0700
Yonghong Song <yhs@fb.com> wrote:

> So I suspect there is a race condition between kretprobe_dispatcher()
> (or higher level kretprobe_trampoline_handler()) and 
> unregister_kretprobes(). I looked at kernel/trace code and had not
> found an obvious race yet. I will continue to check.
> But at the same time, I would like to seek some expert advice to see
> whether you are aware of any potential issues in 5.12 or not and where
> are possible places I should focus on to add debug codes for experiments.

First thing I'll ask is if you can reproduce this on a vanilla 5.12 kernel.

If not, then we can't help you.

If you can, I would ask if it is reproducible on the latest mainline kernel.
If it is, then we'll help you look into it. If not, we'll ask if you can
try to bisect it to at least find what version it was fixed in.

-- Steve
