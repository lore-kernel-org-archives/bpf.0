Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71107C433EF
	for <bpf@archiver.kernel.org>; Fri,  1 Apr 2022 01:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbiDABy2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 31 Mar 2022 21:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiDABy0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 21:54:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5832571B7;
        Thu, 31 Mar 2022 18:52:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F046B82277;
        Fri,  1 Apr 2022 01:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869BDC340ED;
        Fri,  1 Apr 2022 01:52:35 +0000 (UTC)
Date:   Thu, 31 Mar 2022 21:52:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: ftrace_direct (used by bpf trampoline) conflicts with live
 patch
Message-ID: <20220331215233.496479fc@rorschach.local.home>
In-Reply-To: <20220331214836.663bc7cf@rorschach.local.home>
References: <0962AC9B-2FBD-4578-8B2F-A376A6B3B83F@fb.com>
        <20220331214836.663bc7cf@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 31 Mar 2022 21:48:36 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Does this make sense to you? Did I miss something?  
> 
> I thought the BPF trampoline does:
> 
> 	call bpf_trace_before_function
> 	call original_function + X86_PATCH_SIZE
> 	call bpf_trace_after_function
> 
> Thus, the bpf direct trampoline calls the unpatched version of the
> function call making the live patch useless. Or is this not what it
> does?

Or perhaps you are only talking about the part of bpf that does not
trace the end of a function?

-- Steve
