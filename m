Return-Path: <SRS0=xp9Q=RK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6718DC43381
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 21:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCF020684
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 21:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPCr8JpD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbfCGVal (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 Mar 2019 16:30:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36546 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfCGVal (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Mar 2019 16:30:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id r124so12290257pgr.3;
        Thu, 07 Mar 2019 13:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K9IjzSKu+G9SDroW6rfnS+bl125mM2MXlkgG6cbvbqc=;
        b=dPCr8JpDSIt8eOB3X0TlLKLQrYcgKvNECCzltSoX0OTXruNgAWhCenBbqNLWnTWzSK
         W2467MigNvf7sNE7YVMUp1cx4wd9693rIhxfuP4hh1MS7Q10QMImY/Hg4/W0moL/4KF1
         7XRjykthG7E2yQ78NeEUM2gBc8R9BUlBeFPsBhd9woilKw0jFKj4StnCw6ehnoaqaDlc
         SxBsvINxo0hltjYO+BBUklKMI3psXOWCof2C3nQCcjv8zc9xCicmw6pRDt1lm18D5tYF
         jTY3nzUaai1ZzqrrctGWp6VS2j/g4wI/PnIJuI7Npzs5XOMgf8yOMwtbmub8n2sk45kP
         yoVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K9IjzSKu+G9SDroW6rfnS+bl125mM2MXlkgG6cbvbqc=;
        b=BAhx/Ay8v5EQ6D4tkTEYJ0GttG+6GowNdhaYHaG63ohTce9AnRkJlzKZUK6M/DjKVa
         txNTXWjmcI1Ja/0f3FjCXXgIYzTNV3H5gX+E384wnejFKxlsyONFwGpCTNiknJbfhNBx
         ZuIFkdJgacLR0lKR/5vIBzbVdNKHyH186LB7efLIp8gXiZHH7Daj57wy6K7/Ipy6RiO2
         olBCB9iaZTxSP/1NHUksqDmDm8Mz5wS8HrQ3E3xCQrwywJLlMWtucEYzp47JTNoTq7UM
         fqNuwxKMOdi4ag0t/utVmSc26jF17N20bEaHHOkZUaMA+xZL/MZkHOqhIzE2BDLTcjrK
         DBDA==
X-Gm-Message-State: APjAAAU77OwtbW+ulCPVQcNy52oqZ6MI8D1szzioU8hsiz6baMpY1dKc
        u287k7GoiXLH/UM/eF7fmq8=
X-Google-Smtp-Source: APXvYqw0zIaOvD1SlZOTnTzLoK3jAwbIlA+yWAmeAPkXQImQIcaKhrfomz4l/E4lAaVZeDmysyuKnQ==
X-Received: by 2002:a62:6046:: with SMTP id u67mr14967464pfb.46.1551994240573;
        Thu, 07 Mar 2019 13:30:40 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::e398])
        by smtp.gmail.com with ESMTPSA id x1sm7807247pge.73.2019.03.07.13.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 13:30:39 -0800 (PST)
Date:   Thu, 7 Mar 2019 13:30:37 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kris Van Hees <kris.van.hees@oracle.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net
Subject: Re: [PATCH 0/2] bpf: context casting for tail call and gtrace prog
 type
Message-ID: <20190307213035.5eagphx6vswxalai@ast-mbp.dhcp.thefacebook.com>
References: <201902251554.x1PFsD3w017626@userv0121.oracle.com>
 <20190226061823.f7hfs7yojfuycqmg@ast-mbp.dhcp.thefacebook.com>
 <20190226064601.GE16689@oracle.com>
 <20190305185950.rpx7srzpbya5psnf@ast-mbp.dhcp.thefacebook.com>
 <20190306020357.GG32758@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190306020357.GG32758@oracle.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 05, 2019 at 09:03:57PM -0500, Kris Van Hees wrote:
> 
> So in summary, I am trying to solve two (related) problems:
> 
> - Ensure that unprivileged tracing can obtain information about the task that
>   triggered a probe or event.  There will always be limitations but we can do
>   better than is available now.

I think unprivileged tracing is a huge topic on its own.
It's too easy to create security holes with such mechanism.
kprobe/tracepoints/etc have been historically root only and I don't see a way
for them to become unpriv.
imo the existing /proc/pid/status is already more powerful than
what you're proposing with gtrace context.

> - Allow tracing tools ab ability to provide actions to be performed when a
>   probe or event fires, beyond what the individual BPF program types allow
>   for the specific probe/event types (and do it in a generic manner, in a
>   sense encapsulating multiple probe/event types in a more generic tracing
>   context).

I think existing bpf tracing is generic whereas proposed gtrace is not generic at all.
'generic' is a loaded word. we can throw it back and forth and won't make
any forward progress. Let's focus on technical bits, ok?

> A patch I am currently working on ties into this (and I hope to get it ready
> sometime next week).  It builds on the support you already have for accessing
> packet data from the __sk_buff context.  If we can make this same functionality
> available to other contexts as well, my goal would be to make it possible for
> the generic tracing context to have a buffer (data and data_end members) that
> the BPF program can issue direct stores to as a means to allow a tracing
> program to control how data is written into the buffer. 

sounds like you're trying to reinvent bpf_perf_event_output() mechanism.

> But being able to do things like this without
> needing to touch the context of any other BPF program type is a great benefit
> to offer tracing tools, as far as I see it.

I still don't understand what you're referring to by 'things like this'
that somehow will be possible in the future, but not possible today.
Could you please give concrete example?

