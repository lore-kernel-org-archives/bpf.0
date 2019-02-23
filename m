Return-Path: <SRS0=Kw1S=Q6=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69431C43381
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 20:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3130420651
	for <bpf@archiver.kernel.org>; Sat, 23 Feb 2019 20:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JgD9KEa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfBWUe4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 23 Feb 2019 15:34:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38022 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726125AbfBWUez (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Feb 2019 15:34:55 -0500
Received: by mail-pg1-f196.google.com with SMTP id m2so2679240pgl.5;
        Sat, 23 Feb 2019 12:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vJi0VrMogIf8V+3Baw+AP77hv0ZRGn66DFv31HzkicE=;
        b=JgD9KEa/a2WuggzrGcHSWFH1ld8vLBW0npVmfxrCjIigvwwDGyYpl2QhSaMV0KB+4k
         wFI/Ya3YJdpBk0qxVu94PCbkj7ia40FtLQ9MVWO8N4S1HHoLySsRgVEJubQcXOCoK47i
         HpaBvAg2ZC7fxvvWn3isdokmwsMHYLErIphN2Nj1IiTpprgfoSNC5DExN/wP0QogV9lx
         UcfD61BI4wH2pwaUxGy6wXt8eAOsHSzQ5Sl2hbXhJ0iYQnZ+1lVDItnUD8xTvYauyb0H
         oUW4bHXOXquZ1cviRd1lZwMAVt4QICt9W0i/DI07rz/wcdCDwum1Zo+ZwzAuOiEviyzg
         4JpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vJi0VrMogIf8V+3Baw+AP77hv0ZRGn66DFv31HzkicE=;
        b=CR8gHn5mcwbL9fozl8EM+D8MRdC7NAr6cm1l2h/GTV8aAQ+SroAV6mFEVNpjhGMvp2
         aVRuU8uQJBSosRzQRvCURAQu+5dqX2HaOOni+qUXYQAYjB1/uuhJJwZE4OI255hNMEvy
         LXLe0u+G7ONUM4jW1taIyCOCWkNJMP4ivdMPm3f7uMI3k5y7gfU2X/IPtOHw/4ZQHmSq
         kNiJ+jtAX3nWBLZPErQAqdtEMiywGrpN7Ke/ffJoFjrjuKpx98z+jtm1mUh7gzUJOFAh
         577YCeNnqAd6t2CPt8hs8AoBzwryEf7oC3cIRP9hxUVT0VQUwAeQEBaj/WmN3bMi9Lwn
         /Ykw==
X-Gm-Message-State: AHQUAuYUhzuG7YXUii22elRIk8da/DKLvZOLhLG54vqt+19DMj+6oE/X
        g4uyfH4XL61GY4HKcyQSsoQ=
X-Google-Smtp-Source: AHgI3IY/2DKMs3MKBVs/l0wplkK4uAsHbozWc63WutZkUAa5nDtAW8e1KgERTRaxqhVhu6kt9E8K4A==
X-Received: by 2002:aa7:8205:: with SMTP id k5mr2434247pfi.86.1550954094740;
        Sat, 23 Feb 2019 12:34:54 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:79ba])
        by smtp.gmail.com with ESMTPSA id z6sm7105735pgo.31.2019.02.23.12.34.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 12:34:53 -0800 (PST)
Date:   Sat, 23 Feb 2019 12:34:50 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net,
        daniel@iogearbox.net, edumazet@google.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 1/4] bpf: enable program stats
Message-ID: <20190223203449.pwyijxfpwewdrg6k@ast-mbp.dhcp.thefacebook.com>
References: <20190223174422.663270-1-ast@kernel.org>
 <20190223174422.663270-2-ast@kernel.org>
 <218b9aab-5e78-46b1-1f65-dd0a305548c7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218b9aab-5e78-46b1-1f65-dd0a305548c7@gmail.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 23, 2019 at 10:36:48AM -0800, Eric Dumazet wrote:
> 
> 
> On 02/23/2019 09:44 AM, Alexei Starovoitov wrote:
> 
> ...
> 
> >  
> > -#define BPF_PROG_RUN(filter, ctx)  ({ cant_sleep(); (*(filter)->bpf_func)(ctx, (filter)->insnsi); })
> > +DECLARE_STATIC_KEY_FALSE(bpf_stats_enabled_key);
> > +
> > +#define BPF_PROG_RUN(prog, ctx)	({				\
> > +	u32 ret;						\
> > +	cant_sleep();						\
> > +	if (static_branch_unlikely(&bpf_stats_enabled_key)) {	\
> > +		struct bpf_prog_stats *stats;			\
> > +		u64 start = sched_clock();			\
> > +		ret = (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
> > +		stats = this_cpu_ptr(prog->aux->stats);		\
> > +		u64_stats_update_begin(&stats->syncp);		\
> > +		stats->cnt++;					\
> > +		stats->nsecs += sched_clock() - start;		\
> > +		u64_stats_update_end(&stats->syncp);		\
> > +	} else {						\
> > +		ret = (*(prog)->bpf_func)(ctx, (prog)->insnsi);	\
> > +	}							\
> > +	ret; })
> > 
> 
> It seems a cpu running there could still be interrupted (by an interrupt)
> and re-enter this section ?
> 
> If yes, u64_stats_update_begin() and u64_stats_update_end() are unsafe (on 32bit arches)
> 
> u64_stats_update_{begin|end}() assume proper locking, since they use a simple increment.
> 
> But then, even on 64bit arches, the stats->{cnt|nsecs} updates are unsafe ?

No. It cannot reenter for the same program.
socket filter prog can be interrupted by kprobe prog, but they are different
progs and different stats.

