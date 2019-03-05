Return-Path: <SRS0=GR7L=RI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EA2C43381
	for <bpf@archiver.kernel.org>; Tue,  5 Mar 2019 18:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC32D20652
	for <bpf@archiver.kernel.org>; Tue,  5 Mar 2019 18:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6Q4jDI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbfCES7z (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 5 Mar 2019 13:59:55 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46541 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfCES7z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Mar 2019 13:59:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id 196so6247782pgf.13;
        Tue, 05 Mar 2019 10:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mWr4VhFEBTp4XzQy2ESv3rThEg2LIyEQ6lxwa4c+3ek=;
        b=f6Q4jDI7ANlsqJ2Lulc0FmPBwXjoRbqBOCVoLNhrco/35xHbp21+c/5nFBnfHVBm/r
         uZ9SlKWv/NjqDkonk0H9uWcwGP9w6CV/faDvwQHH2qkcxW4HdegHmU8G6bEZYZWzjuTk
         bpbCNMqsCFu0IDtiFLtJVeHrs8Q8jbVsRKJDIP4KqP0wWVLmPgopZ+3ig2k6biIzLKSJ
         voE6fyii59zTes5PQIz7G6XpHDsB6+Hnzd3eJvcq4vl9+dlF/RAQuUG5Z3NtVTMFMFba
         c9jSUseKiIS4iGx5+PaUBfbzxx46I8z5Cmqz07KARDt0LHC8tsDifIrE+6+9farRFhU6
         B7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mWr4VhFEBTp4XzQy2ESv3rThEg2LIyEQ6lxwa4c+3ek=;
        b=HMhSZXqlai1Clvh+awep7pUnnpqJWSGbev9cqCJXT2d59hps9qQaD1v1jsLXLyTwIp
         Sx/OqUV+tLlvJtj+59z1GVADCkO8g6tN5qx2enptXgGkIR8eMIJwAK+Ah4iQ8hFNSS9b
         rOIGLmmdEdtV4lvL0qXFh/UpF0MMOp/ekaiXG5Me0R7X+dkROk2o65mdjcoxz+WHSJ6m
         //fwTkhj8o4Adu/WdsACE9/IecXoDGRa+2Solbc3F3ygfEDmO+DNKyZSAIJOPvUVxt1a
         zu5Uhm86JnA654LC5wpdUoXRS+DQXQpoafaUxjKlDGUeWuOsb+xg+yWtT4iGoVntK6aN
         cwFg==
X-Gm-Message-State: APjAAAWLnZkiO0olzLRYHDYHzYeDaOaSd91I41LUOXaDKmfleMp1X/Jm
        DgV5Ipy+dfRR+KZGCyIRHaY=
X-Google-Smtp-Source: APXvYqyGloEc7E6uqYBjx2GC59SC75EAmLI82zck1hhviI5PGej/BRI/G39f6rfIEeXzKIxYH52Lwg==
X-Received: by 2002:a63:2e06:: with SMTP id u6mr2686142pgu.71.1551812394196;
        Tue, 05 Mar 2019 10:59:54 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::3:8efd])
        by smtp.gmail.com with ESMTPSA id z77sm16617232pfi.155.2019.03.05.10.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 10:59:53 -0800 (PST)
Date:   Tue, 5 Mar 2019 10:59:52 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kris Van Hees <kris.van.hees@oracle.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH 0/2] bpf: context casting for tail call and gtrace prog
 type
Message-ID: <20190305185950.rpx7srzpbya5psnf@ast-mbp.dhcp.thefacebook.com>
References: <201902251554.x1PFsD3w017626@userv0121.oracle.com>
 <20190226061823.f7hfs7yojfuycqmg@ast-mbp.dhcp.thefacebook.com>
 <20190226064601.GE16689@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226064601.GE16689@oracle.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 26, 2019 at 01:46:01AM -0500, Kris Van Hees wrote:
> On Mon, Feb 25, 2019 at 10:18:25PM -0800, Alexei Starovoitov wrote:
> > On Mon, Feb 25, 2019 at 07:54:13AM -0800, Kris Van Hees wrote:
> > > 
> > > The goal is to further extend the BPF_PROG_TYPE_GTRACE implementation to
> > > support what tracers commonly need, and I am also looking at ways to further
> > > extend this model to allow more tracer-specific features as well without the
> > > need for adding a BPF program types for every tracer.
> > 
> > It seems by themselves the patches don't provide any new functionality,
> > but instead look like plumbing to call external code.
> 
> The patches are definitely not plumbing to call external code, and if I gave
> that impression I apologise.  I overlooked the information you quote below on
> allowing new functionality through modules when I wrote the comment above but
> please note that it was a forward-looking comment in terms of what could be
> done - not a reason for the patches that I submitted.
> 
> The patches accomplish something that is totally independent from that: they
> make it possible for existing events that execute BPF programs when triggered
> to transfer control to a BPF program with a more rich context.  The first
> patch makes such a transfer possible (using tail-call combined with converting
> the context to the new program type), and the second patch provides one such
> program type (generic trace).  The new functionality provided by the program
> type is direct access to task information that previously could only be
> obtained through helper calls.  E.g. the new program type allows programs to
> access the task state, prio, ppid, euid, and egid.  None of those pieces of
> information can currently be obtained unless you start poking around in
> memory using bpf_probe_read() helper calls.

I don't think I understand the problem you're trying to solve.
From kprobe/tracepoints/etc bpf prog can use bpf_probe_read() to read everything.
Are you saying direct access to state, prio, ppid, euid, and egid via context
is much superior? Why? Because it's more stable?
Why stop at these fields then? task_struct has many others.

What we observed that no matter how many fields we add to stable uapi
somebody will always request one more. For networking the total number of
such fields is contained, but for tracing we're talking about thousands
of useful fields. We cannot make them stable.
Hence we've been working on alternative approach via BTF to make all
of kernel internal fields sort-of stable via 'compile once' technique that
we described at the last LPC.

