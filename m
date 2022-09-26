Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EE5C32771
	for <bpf@archiver.kernel.org>; Mon, 26 Sep 2022 18:28:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiIZS2s (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 26 Sep 2022 14:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiIZS2a (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 14:28:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446ACD41
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4ILHim2Y7dvs3bjhrdzIIjeoCWpEtTqH2OroRAw/UkQ=; b=J1rt2UFS/wt8vBa7/8GodB65HO
        4NZs7cUTXLYhi1JUZv+H9WmnW5sd7+J69l4uZqu2O+8LS7CNaorFKTNTv3hJaIz9aJdyvpPBcl4NT
        rh6wDH9Uf2mwLXeDpjkTj3vdn4UVzpq7fRYjuZu3lP9qJyripQe7WEL4SJRbSi1Mmc6T8NgkYUsLa
        cpa6CI0K2Rj46oIz1KTDqrEEiLXLqm6lAqPQqC8DcYvTlyStT8sjzO4ypn7KH/2BXz118auiGCxPW
        JeIsSLue3E5109hc3b1LtKj8ZiT7jMTW4PkwARzGIJDfHyYHXvmGgLE0oQx3zXAGYs+BsUk50UvOZ
        cnfL+tXQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ocsq4-00AjW0-Ad; Mon, 26 Sep 2022 18:28:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC0623002F1;
        Mon, 26 Sep 2022 20:28:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8C08F2B6C1E54; Mon, 26 Sep 2022 20:28:16 +0200 (CEST)
Date:   Mon, 26 Sep 2022 20:28:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Martynas Pumputis <m@lambda.lt>
Subject: Re: [PATCHv5 bpf-next 0/6] bpf: Fixes for CONFIG_X86_KERNEL_IBT
Message-ID: <YzHvQCIaJa3K/b3D@hirez.programming.kicks-ass.net>
References: <20220926153340.1621984-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926153340.1621984-1-jolsa@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 26, 2022 at 05:33:34PM +0200, Jiri Olsa wrote:
> Jiri Olsa (6):
>       kprobes: Add new KPROBE_FLAG_ON_FUNC_ENTRY kprobe flag
>       ftrace: Keep the resolved addr in kallsyms_callback
>       bpf: Use given function address for trampoline ip arg
>       bpf: Adjust kprobe_multi entry_ip for CONFIG_X86_KERNEL_IBT
>       bpf: Return value in kprobe get_func_ip only for entry address

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
