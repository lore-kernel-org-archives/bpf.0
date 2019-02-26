Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A3FC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 03:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE16620842
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 03:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fomichev-me.20150623.gappssmtp.com header.i=@fomichev-me.20150623.gappssmtp.com header.b="mh76pXYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfBZDKw (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 22:10:52 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37815 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbfBZDKw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 22:10:52 -0500
Received: by mail-pf1-f194.google.com with SMTP id s22so5495567pfh.4
        for <bpf@vger.kernel.org>; Mon, 25 Feb 2019 19:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pt351PZKReNavNjhw2RTcrXUp2l6pKI0FirKR95LwEQ=;
        b=mh76pXYkURzdjZNTDG1xhyqhPTiKY6eoInIhB0DDobLNmT/jhQlgtzCRPidS+ZtIGl
         FO/d/It78XsVEASfyMtpMfOF30CzhFNvbkgCeWgjMndWzzDCGmw9IRw2IMti9JNOERcM
         BCaDotIjuEb+IfomBw+VzxLrv8zm7UebUtbxIxaBaxTnPwOYO7Caj/55XopDjYdKIbyp
         X1Qb1j+dvf8qroN/Wlcy9f4/dnAOFXcOOAmzrBob4UpRl50kEdFwLv5jw+1NlS6IpNdH
         Z7W0rKt/9ns5ZEQRABcftUnVm0Tp3hKPV3om6Q3pp3Ja12z1tuD3czBScuBn/luu7hMM
         kaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pt351PZKReNavNjhw2RTcrXUp2l6pKI0FirKR95LwEQ=;
        b=XJZvFFIMVSKFVS8+t0vjsS+7qF6TAmjMgOaR7A0N2D/eoigRkZda+rMWqx6B0Z+dzd
         cCmFJo9gwuRv/+t15g7GrI3gci7UJ9xGmhe6I+j03+lkJx2yddvdthdUJYBZvnhfQlKh
         UriA3nppWGpFHaY/r8KeVxAsPQJfo4FC0r6uULwYEu1Z5rRz4G5gfjSMOyj760MzXMqw
         FEc/ATYB4wn0cbmPNy41iI5M8nLJqK7ganFuibJCU2zRltVXa0Gw6hayjW0c32y2AN7X
         EboHAleiUqE7MHokUxGpkczSK+r7TQcByRIq4dNps5zV0ISx5jhv5ag/igFVgfGR30w2
         XJsQ==
X-Gm-Message-State: AHQUAuavTWA2eLflqSYWrUCs2nFLvJzJ7TPEKgN+DqvEIbVaGNo+c6cJ
        2gKmPh6vwXEWARqLX3ofP+4Rjg==
X-Google-Smtp-Source: AHgI3IZTuCU6tmgVtgjVo3FXMxc5wnTSHmlq+GNIwhSXHSru2pAY8NoOabULgyi0vweSAaKQCPWVbQ==
X-Received: by 2002:a62:444b:: with SMTP id r72mr23973753pfa.184.1551150651109;
        Mon, 25 Feb 2019 19:10:51 -0800 (PST)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id 15sm16731952pfr.55.2019.02.25.19.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 19:10:50 -0800 (PST)
Date:   Mon, 25 Feb 2019 19:10:49 -0800
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Alexei Starovoitov <ast@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 1/4] bpf: enable program stats
Message-ID: <20190226031049.GD32115@mini-arch>
References: <20190225222842.2031962-1-ast@kernel.org>
 <20190225222842.2031962-2-ast@kernel.org>
 <20190225230703.GB32115@mini-arch>
 <2eeb7f8d-d184-07d1-2b7b-76c93b4b1bfe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2eeb7f8d-d184-07d1-2b7b-76c93b4b1bfe@fb.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 02/25, Alexei Starovoitov wrote:
> On 2/25/19 3:07 PM, Stanislav Fomichev wrote:
> >> +#define BPF_PROG_RUN(prog, ctx)	({				\
> >> +	u32 ret;						\
> >> +	cant_sleep();						\
> >> +	if (static_branch_unlikely(&bpf_stats_enabled_key)) {	\
> >> +		struct bpf_prog_stats *stats;			\
> >> +		u64 start = sched_clock();			\
> > QQ: why sched_clock() and not, for example, ktime_get_ns() which we do
> > in the bpf_test_run()? Or even why not local_clock?
> > I'm just wondering what king of trade off we are doing here
> > regarding precision vs run time cost.
> 
> 
> I'm making this decision based on documentation:
> Documentation/timers/timekeeping.txt
> "Compared to clock sources, sched_clock() has to be very fast: it is 
> called much more often, especially by the scheduler. If you have to do 
> trade-offs between accuracy compared to the clock source, you may 
> sacrifice accuracy for speed in sched_clock()."
So sched_clock is fast, but imprecise; and ktime_get_ns (and
lock_clock?) are slow(er), but more precise?

If that's the case, would it make sense to use a more precise
measurement? I suppose the BPF program execution time is on the order of
nanoseconds and if sched_close has msec or usec resolution, all we get is
essentially noise?

I understand that you want this feature to have almost no overhead, but
since it's gated by the static key, should we aim for a higher precision?
