Return-Path: <SRS0=eV/F=6V=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A524C38A2A
	for <bpf@archiver.kernel.org>; Thu,  7 May 2020 15:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3555520857
	for <bpf@archiver.kernel.org>; Thu,  7 May 2020 15:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588866365;
	bh=MtT1K1QhdR93RnKXEINbJSy9JalbcJDWOmF/snclf4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UMJy+7PtJyOevu7ePSHdbhourGEpVTCFxorpS6LjyS7QN2xtxD1LmOD4dREEJ9NVt
	 1DluQv5RKORiE/BY0w1X6OaKZweBB1iS42V3Aq9qi9S0vBOUQHdFVTDmy/6dCzAFdv
	 3VPDcNztfmSzHgYxGqscNNKWiExXM+2vV1YQOWio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgEGPqE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 May 2020 11:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbgEGPqE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 11:46:04 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A94A0207DD;
        Thu,  7 May 2020 15:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588866364;
        bh=MtT1K1QhdR93RnKXEINbJSy9JalbcJDWOmF/snclf4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ImqSVH0/sYKWxb69Pox8SY+3RRS3M0o9prJxmrXYt8yg5zRTmmeBZywK3+SkqtrL6
         E/vnxRTB860fUDJ2IjcmXxXHAZtW7XsQ6S5pE/G3KhhSWAPa9YAoxBy66VhyVAX51N
         bX1AZ3994AOUMkgIZt+6mf9rmrCoRDcawwBU0ZGQ=
Date:   Fri, 8 May 2020 00:45:56 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Eelco Chaudron <echaudro@redhat.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Wang Nan <wangnan0@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 1/3] x86/kprobes: Support nested kprobes
Message-Id: <20200508004556.d968ee87b91dc7940ac161f2@kernel.org>
In-Reply-To: <158884559505.12656.1357851132314046716.stgit@devnote2>
References: <158884558272.12656.7654266361809594662.stgit@devnote2>
        <158884559505.12656.1357851132314046716.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu,  7 May 2020 18:59:55 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Make kprobes to accept 1-level nesting instead of
> diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
> index 681a4b36e9bb..b695c2e118f8 100644
> --- a/arch/x86/kernel/kprobes/ftrace.c
> +++ b/arch/x86/kernel/kprobes/ftrace.c
> @@ -25,13 +25,15 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
>  		return;
>  
>  	kcb = get_kprobe_ctlblk();
> -	if (kprobe_running()) {
> +	if (!kprobe_can_nest()) {

Oops, something wrong. this kprobe_can_nest() requires kcb for
the parameter. I'll fix this.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
