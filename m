Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C3CC433EF
	for <bpf@archiver.kernel.org>; Mon, 30 May 2022 19:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235283AbiE3Tdn (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 30 May 2022 15:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbiE3Tdn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 May 2022 15:33:43 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698FF3CFFA;
        Mon, 30 May 2022 12:33:41 -0700 (PDT)
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <daniel@iogearbox.net>)
        id 1nvl8r-0001V6-CF; Mon, 30 May 2022 21:33:29 +0200
Received: from [85.1.206.226] (helo=linux-2.home)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1nvl8q-000VcP-QA; Mon, 30 May 2022 21:33:29 +0200
Subject: Re: [PATCH] tracing/kprobes: Check whether get_kretprobe() returns
 NULL in kretprobe_dispatcher()
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <165366693881.797669.16926184644089588731.stgit@devnote2>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <0204f480-cdb0-e49f-9034-602eced02966@iogearbox.net>
Date:   Mon, 30 May 2022 21:33:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <165366693881.797669.16926184644089588731.stgit@devnote2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.6/26557/Mon May 30 10:05:44 2022)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 5/27/22 5:55 PM, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> There is a small chance that get_kretprobe(ri) returns NULL in
> kretprobe_dispatcher() when another CPU unregisters the kretprobe
> right after __kretprobe_trampoline_handler().
> 
> To avoid this issue, kretprobe_dispatcher() checks the get_kretprobe()
> return value again. And if it is NULL, it returns soon because that
> kretprobe is under unregistering process.
> 
> This issue has been introduced when the kretprobe is decoupled
> from the struct kretprobe_instance by commit d741bf41d7c7
> ("kprobes: Remove kretprobe hash"). Before that commit, the
> struct kretprob_instance::rp directly points the kretprobe
> and it is never be NULL.
> 
> Reported-by: Yonghong Song <yhs@fb.com>
> Fixes: d741bf41d7c7 ("kprobes: Remove kretprobe hash")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Steven, I presume you'll pick this fix up?

Thanks,
Daniel
