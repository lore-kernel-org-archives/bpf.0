Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08479C433EF
	for <bpf@archiver.kernel.org>; Thu, 10 Feb 2022 14:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243300AbiBJO7s (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 10 Feb 2022 09:59:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243267AbiBJO7r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 09:59:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB4610A
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 06:59:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34F2461B30
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 14:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859F0C340E5;
        Thu, 10 Feb 2022 14:59:46 +0000 (UTC)
Date:   Thu, 10 Feb 2022 09:59:44 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: Re: [RFC PATCH 2/3] powerpc/ftrace: Override
 ftrace_location_lookup() for MPROFILE_KERNEL
Message-ID: <20220210095944.1fe98b74@gandalf.local.home>
In-Reply-To: <1644501274.apfdo9z1hy.naveen@linux.ibm.com>
References: <cover.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
        <fadc5f2a295d6cb9f590bbbdd71fc2f78bf3a085.1644216043.git.naveen.n.rao@linux.vnet.ibm.com>
        <20220207102454.41b1d6b5@gandalf.local.home>
        <1644426751.786cjrgqey.naveen@linux.ibm.com>
        <20220209161017.2bbdb01a@gandalf.local.home>
        <1644501274.apfdo9z1hy.naveen@linux.ibm.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 10 Feb 2022 13:58:29 +0000
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index f9feb197b2daaf..68f20cf34b0c47 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -1510,6 +1510,7 @@ ftrace_ops_test(struct ftrace_ops *ops, unsigned long ip, void *regs)
>  	}
>  
>  
> +#ifndef ftrace_cmp_recs
>  static int ftrace_cmp_recs(const void *a, const void *b)
>  {
>  	const struct dyn_ftrace *key = a;
> @@ -1521,6 +1522,7 @@ static int ftrace_cmp_recs(const void *a, const void *b)
>  		return 1;
>  	return 0;
>  }
> +#endif
>  

I don't really care for this part, as it seems somewhat ugly. But this
patch does appear to solve your issue, and I can't think of a prettier way
to do this.

So, I will reluctantly ack it.

If anything, please add a comment above saying that architectures may need
to override this function, and when doing so, they will define their own
ftrace_cmp_recs.

-- Steve
